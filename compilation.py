#!/usr/bin/env python3
import argparse
import subprocess
from concurrent.futures import ThreadPoolExecutor, as_completed
import re
from pathlib import Path

CHAPTERS_LOCATION = "./"

BUILD_DIR = CHAPTERS_LOCATION + "build/"
C_CHAPITRES_DIR = BUILD_DIR + "chapitres/"
C_COURS_DIR = BUILD_DIR + "cours/"
C_TD_DIR = BUILD_DIR + "TDs/"
C_INTEGRALE_DIR = BUILD_DIR + "integrale/"
LATEX_COMPILER = "lualatex"

GARBAGE_EXTENSIONS = {
    ".aux", ".log", ".toc", ".out", ".synctex.gz", 
    ".fls", ".fdb_latexmk", ".lof", ".lot", ".bcf", ".run.xml"
}

parser = argparse.ArgumentParser(description="Compilation script for MPI math course.")

parser.add_argument("-ch", "--chapitres", default="all", help="Chapters to compile, default : all.")
parser.add_argument("-m", "--mode", default="chapitre", help="What to compile, default : chapitre, options : chapitre, cours, TD." )
parser.add_argument("-he", "--halt_on_error", action='store_true', help="Wether the compilation stops or not when a file gets an error while compiling.")
parser.add_argument("-a", "--all", action='store_true', help='Whether to compile all files or not.')
parser.add_argument("-v", "--vstyle", action='store_true', help='Compiles with V Style then restores the default style.')

args = parser.parse_args()



def SetVStyle():
        #Fixing the colors on TDs

    with open("commun/prepacours_TD.cls","r") as TD:
        data = TD.read()
        data = data.replace(r"\definecolor{sectionblue}{RGB}{13,114,202}", r"\definecolor{sectionblue}{RGB}{255,145,10}")
    
    with open("commun/prepacours_TD.cls","w") as TD:
        TD.write(data)

    with open("commun/prepacours.cls","r") as file:
        data = file.read()
    data = data.replace(r"\setboolean{vstyle}{false}", r"\setboolean{vstyle}{true}")
    
        #Fixing the chapter/section colors
    data = data.replace(r"\color{sectionblue}", r"\color{sectionorange}")
    data = data.replace("=sectionblue", "=sectionorange")
    data = data.replace(r"\textcolor{sectionblue}", r"\textcolor{sectionorange}")
    data = data.replace(r"\definecolor{bluebox}{RGB}{36,113,200}%Actual bluebox", r"\definecolor{bluebox}{RGB}{255, 145, 10}%Fake bluebox, actually orange :D")

    # Write changes
    with open("commun/prepacours.cls","w") as file:
        file.write(data)

def SetDefault():
        #Fixing the colors on TDs

    with open("commun/prepacours_TD.cls","r") as TD:
        data = TD.read()
        data = data.replace(r"\definecolor{sectionblue}{RGB}{255,145,10}", r"\definecolor{sectionblue}{RGB}{13,114,202}")
    
    with open("commun/prepacours_TD.cls","w") as TD:
        TD.write(data)


        #Fixing the main file
    with open("commun/prepacours.cls","r") as file:
        data = file.read()


    # (Re)Add the Default style
    data = data.replace(r"\setboolean{vstyle}{true}", r"\setboolean{vstyle}{false}")

    # Fix the chapter/section colors
    data = data.replace(r"\color{sectionorange}", r"\color{sectionblue}")
    data = data.replace("=sectionorange", "=sectionblue")
    data = data.replace(r"\textcolor{sectionorange}", r"\textcolor{sectionblue}")
    data = data.replace(r"\definecolor{bluebox}{RGB}{255, 145, 10}%Fake bluebox, actually orange :D", r"\definecolor{bluebox}{RGB}{36,113,200}%Actual bluebox")

    #Write
    with open("commun/prepacours.cls","w") as file:
        file.write(data)


def clean_dir (dir) :
    for file in dir.iterdir():
        if file.is_file() and file.suffix in GARBAGE_EXTENSIONS :
            file.unlink()
    return

def compile_file (file, output_dir, cwd_path) :
    cwd_dir = Path(cwd_path).resolve()
    
    result = subprocess.run(
                            [
                                LATEX_COMPILER,
                                f"-output-directory={output_dir}",
                                "-interaction=nonstopmode",
                                "-halt-on-error",
                                file
                            ],
                            capture_output=True,
                            cwd=cwd_dir
                        )

    if(result.returncode != 0) :
        print("ERROR : Compilation failed for ", file)
        if args.halt_on_error:
            exit(1)
    return

if args.vstyle:
    SetVStyle()

print("vstyle =", args.vstyle)

chapters_path = Path(CHAPTERS_LOCATION).resolve()

target_dirs = [
    d for d in chapters_path.iterdir() 
    if d.is_dir() and d.name.startswith("chapitre") and d.name != "chapitre0"
]

build_dir = Path(BUILD_DIR).resolve()
build_dir.mkdir(exist_ok=True)

if args.all :
    target_files = []
    target_out_dirs = []
    target_cwds = []

    c_integrale_dir = Path(C_INTEGRALE_DIR).resolve()
    c_integrale_dir.mkdir(exist_ok=True)
    
    c_chapters_dir = Path(C_CHAPITRES_DIR).resolve()
    c_chapters_dir.mkdir(exist_ok=True)
    
    c_cours_dir = Path(C_COURS_DIR).resolve()
    c_cours_dir.mkdir(exist_ok=True)
    
    c_TDs_dir = Path(C_TD_DIR).resolve()
    c_TDs_dir.mkdir(exist_ok=True)
    
    target_files.append(str(chapters_path) + "/integrale/integrale_mpi.tex")
    target_files.append(str(chapters_path) + "/integrale/integrale_cours.tex")
    target_files.append(str(chapters_path) + "/integrale/integrale_TD.tex")

    target_out_dirs.extend(str(c_integrale_dir) for _ in range(3))
    target_cwds.extend(str(chapters_path) + "/integrale/" for _ in range(3))

    for chap in target_dirs :
        chap_int = str(int(chap.name.replace("chapitre", "")))

        target_files.append(str(chap) + "/chapitre" + chap_int + ".tex")
        target_out_dirs.append(str(c_chapters_dir))
        target_cwds.append(str(chap))
        
        target_files.append(str(chap) + "/cours/cours" + chap_int + ".tex")
        target_out_dirs.append(str(c_cours_dir))
        target_cwds.append(str(chap) + "/cours/")
        
        target_files.append(str(chap) + "/TD/TD" + chap_int + ".tex")
        target_out_dirs.append(str(c_TDs_dir))
        target_cwds.append(str(chap) + "/TD/")
        
    with ThreadPoolExecutor() as executor:
        futures = [
            executor.submit(compile_file, file, dir_out, cw) 
            for file, dir_out, cw in zip(target_files, target_out_dirs, target_cwds)
        ]
    
        results = [fut.result() for fut in as_completed(futures)]
        
    with ThreadPoolExecutor() as executor:
        futures = [
            executor.submit(compile_file, file, out, c) 
            for file, out, c in zip(target_files, target_out_dirs, target_cwds)
         ]
    
        results = [fut.result() for fut in as_completed(futures)]
        
    clean_dir(c_integrale_dir)
    clean_dir(c_chapters_dir)
    clean_dir(c_cours_dir)
    clean_dir(c_TDs_dir)
    if args.vstyle:
        SetDefault()
        print("V Style used for compilation. It will not work for chapter 0 because it uses its own prepacours.cls\n Some rare boxes may also have the default style because of how they were written, and I don't want to spend time fixing them when I could be playing MORROWIND instead\n")

    print("Compilation finished, pdf are in the build subdir.")
    exit(0)

if args.chapitres.lower() != "all" and args.chapitres.lower() != "integrale" :
    target_numbers = {num.strip() for num in args.chapitres.split(",")}
    target_dirs = [d for d in target_dirs if (m := re.search(r"(\d+)$", d.name)) and m.group(1) in target_numbers]

def compile_chapters (targets, dir) :
    with ThreadPoolExecutor() as executor:
        futures = [
        executor.submit(compile_file, str(chap) + "/chapitre" + str(int(chap.name.replace("chapitre", ""))) + ".tex", str(dir), str(chap)) 
        for chap in targets
    ]

    results = [fut.result() for fut in as_completed(futures)]
    return

def compile_cours (targets, dir) :
    with ThreadPoolExecutor() as executor:
        futures = [
        executor.submit(compile_file, str(chap) + "/cours/cours" + str(int(chap.name.replace("chapitre", ""))) + ".tex", str(dir), str(chap) + "/cours/") 
        for chap in targets
    ]

    results = [fut.result() for fut in as_completed(futures)]
    return  

def compile_TDs (targets, dir) :
    with ThreadPoolExecutor() as executor:
        futures = [
        executor.submit(compile_file, str(chap) + "/TD/TD" + str(int(chap.name.replace("chapitre", ""))) + ".tex", str(dir), str(chap) + "/TD/") 
        for chap in targets
    ]

    results = [fut.result() for fut in as_completed(futures)]
    return

if args.chapitres == "integrale" :
    c_integrale_dir = Path(C_INTEGRALE_DIR).resolve()
    c_integrale_dir.mkdir(exist_ok=True)

    match args.mode :
        case "chapitre" :
            compile_file(str(chapters_path) + "/integrale/integrale_mpi.tex", str(c_integrale_dir), str(chapters_path) + "/integrale/")
            compile_file(str(chapters_path) + "/integrale/integrale_mpi.tex", str(c_integrale_dir), str(chapters_path) + "/integrale/")
        case "cours" :
            compile_file(str(chapters_path) + "/integrale/integrale_cours.tex", str(c_integrale_dir), str(chapters_path) + "/integrale/")
            compile_file(str(chapters_path) + "/integrale/integrale_cours.tex", str(c_integrale_dir), str(chapters_path) + "/integrale/")
        case "TD" :
            compile_file(str(chapters_path) + "/integrale/integrale_TD.tex", str(c_integrale_dir), str(chapters_path) + "/integrale/")
            compile_file(str(chapters_path) + "/integrale/integrale_TD.tex", str(c_integrale_dir), str(chapters_path) + "/integrale/")
        case _ :
            print("ERROR: invalid input for mode field.")
            exit(1)

    clean_dir(c_integrale_dir)
else :
    match args.mode :
        case "chapitre" :
            c_chapters_dir = Path(C_CHAPITRES_DIR).resolve()
            c_chapters_dir.mkdir(exist_ok=True)
        
            compile_chapters(target_dirs, c_chapters_dir)
            compile_chapters(target_dirs, c_chapters_dir)
        
            clean_dir(c_chapters_dir)
        case "cours" :
            c_cours_dir = Path(C_COURS_DIR).resolve()
            c_cours_dir.mkdir(exist_ok=True)
        
            compile_cours(target_dirs, c_cours_dir)
            compile_cours(target_dirs, c_cours_dir)

            clean_dir(c_cours_dir)
        case "TD" :
            c_TDs_dir = Path(C_TD_DIR).resolve()
            c_TDs_dir.mkdir(exist_ok=True)
        
            compile_TDs(target_dirs, c_TDs_dir)
            compile_TDs(target_dirs, c_TDs_dir)

            clean_dir(c_TDs_dir)
        case _ :
            print("ERROR: invalid input for mode field.")
            exit(1)
        
if args.vstyle:
    SetDefault()
    print("V Style used for compilation. It will not work for chapter 0 because it uses its own prepacours.cls\n")



print("Compilation finished, pdf are in the build subdir.")
