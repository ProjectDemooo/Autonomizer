rm *.ll

clang-6.0 *.c -emit-llvm -S
llvm-link *.ll -S -o canny.ll

#opt -load ../build/lib/libAndersen.so -instnamer -basicaa -cfl-anders-aa -cfl-steens-aa -globals-aa -external-aa -scev-aa -anders-aa < canny.ll -disable-output
opt -load ../build/lib/LLVMAuto.so -instnamer -basicaa -cfl-anders-aa -cfl-steens-aa -globals-aa -external-aa -scev-aa -anders-aa -auto < canny.ll -disable-output
