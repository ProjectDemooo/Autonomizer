; ModuleID = 'pgm_io.c'
source_filename = "pgm_io.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@stdin = external global %struct._IO_FILE*, align 8
@.str = private unnamed_addr constant [2 x i8] c"r\00", align 1
@stderr = external global %struct._IO_FILE*, align 8
@.str.1 = private unnamed_addr constant [48 x i8] c"Error reading the file %s in read_pgm_image().\0A\00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c"P5\00", align 1
@.str.3 = private unnamed_addr constant [37 x i8] c"The file %s is not in PGM format in \00", align 1
@.str.4 = private unnamed_addr constant [19 x i8] c"read_pgm_image().\0A\00", align 1
@.str.5 = private unnamed_addr constant [6 x i8] c"%d %d\00", align 1
@.str.6 = private unnamed_addr constant [48 x i8] c"Memory allocation failure in read_pgm_image().\0A\00", align 1
@.str.7 = private unnamed_addr constant [51 x i8] c"Error reading the image data in read_pgm_image().\0A\00", align 1
@stdout = external global %struct._IO_FILE*, align 8
@.str.8 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str.9 = private unnamed_addr constant [49 x i8] c"Error writing the file %s in write_pgm_image().\0A\00", align 1
@.str.10 = private unnamed_addr constant [10 x i8] c"P5\0A%d %d\0A\00", align 1
@.str.11 = private unnamed_addr constant [6 x i8] c"# %s\0A\00", align 1
@.str.12 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str.13 = private unnamed_addr constant [52 x i8] c"Error writing the image data in write_pgm_image().\0A\00", align 1
@.str.14 = private unnamed_addr constant [48 x i8] c"Error reading the file %s in read_ppm_image().\0A\00", align 1
@.str.15 = private unnamed_addr constant [3 x i8] c"P6\00", align 1
@.str.16 = private unnamed_addr constant [37 x i8] c"The file %s is not in PPM format in \00", align 1
@.str.17 = private unnamed_addr constant [19 x i8] c"read_ppm_image().\0A\00", align 1
@.str.18 = private unnamed_addr constant [48 x i8] c"Memory allocation failure in read_ppm_image().\0A\00", align 1
@.str.19 = private unnamed_addr constant [10 x i8] c"P6\0A%d %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @read_pgm_image(i8* %infilename, i8** %image, i32* %rows, i32* %cols) #0 {
entry:
  %retval = alloca i32, align 4
  %infilename.addr = alloca i8*, align 8
  %image.addr = alloca i8**, align 8
  %rows.addr = alloca i32*, align 8
  %cols.addr = alloca i32*, align 8
  %fp = alloca %struct._IO_FILE*, align 8
  %buf = alloca [71 x i8], align 16
  store i8* %infilename, i8** %infilename.addr, align 8
  store i8** %image, i8*** %image.addr, align 8
  store i32* %rows, i32** %rows.addr, align 8
  store i32* %cols, i32** %cols.addr, align 8
  %0 = load i8*, i8** %infilename.addr, align 8
  %cmp = icmp eq i8* %0, null
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load %struct._IO_FILE*, %struct._IO_FILE** @stdin, align 8
  store %struct._IO_FILE* %1, %struct._IO_FILE** %fp, align 8
  br label %if.end4

if.else:                                          ; preds = %entry
  %2 = load i8*, i8** %infilename.addr, align 8
  %llvm-call = call %struct._IO_FILE* @fopen(i8* %2, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i32 0, i32 0))
  store %struct._IO_FILE* %llvm-call, %struct._IO_FILE** %fp, align 8
  %cmp1 = icmp eq %struct._IO_FILE* %llvm-call, null
  br i1 %cmp1, label %if.then2, label %if.end

if.then2:                                         ; preds = %if.else
  %3 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %4 = load i8*, i8** %infilename.addr, align 8
  %llvm-call3 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %3, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.1, i32 0, i32 0), i8* %4)
  store i32 0, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %if.else
  br label %if.end4

if.end4:                                          ; preds = %if.end, %if.then
  %arraydecay = getelementptr inbounds [71 x i8], [71 x i8]* %buf, i32 0, i32 0
  %5 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call5 = call i8* @fgets(i8* %arraydecay, i32 70, %struct._IO_FILE* %5)
  %arraydecay6 = getelementptr inbounds [71 x i8], [71 x i8]* %buf, i32 0, i32 0
  %llvm-call7 = call i32 @strncmp(i8* %arraydecay6, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.2, i32 0, i32 0), i64 2) #4
  %cmp8 = icmp ne i32 %llvm-call7, 0
  br i1 %cmp8, label %if.then9, label %if.end16

if.then9:                                         ; preds = %if.end4
  %6 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %7 = load i8*, i8** %infilename.addr, align 8
  %llvm-call10 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %6, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.3, i32 0, i32 0), i8* %7)
  %8 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call11 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %8, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.4, i32 0, i32 0))
  %9 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %10 = load %struct._IO_FILE*, %struct._IO_FILE** @stdin, align 8
  %cmp12 = icmp ne %struct._IO_FILE* %9, %10
  br i1 %cmp12, label %if.then13, label %if.end15

if.then13:                                        ; preds = %if.then9
  %11 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call14 = call i32 @fclose(%struct._IO_FILE* %11)
  br label %if.end15

if.end15:                                         ; preds = %if.then13, %if.then9
  store i32 0, i32* %retval, align 4
  br label %return

if.end16:                                         ; preds = %if.end4
  br label %do.body

do.body:                                          ; preds = %do.cond, %if.end16
  %arraydecay17 = getelementptr inbounds [71 x i8], [71 x i8]* %buf, i32 0, i32 0
  %12 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call18 = call i8* @fgets(i8* %arraydecay17, i32 70, %struct._IO_FILE* %12)
  br label %do.cond

do.cond:                                          ; preds = %do.body
  %arrayidx = getelementptr inbounds [71 x i8], [71 x i8]* %buf, i64 0, i64 0
  %13 = load i8, i8* %arrayidx, align 16
  %conv = sext i8 %13 to i32
  %cmp19 = icmp eq i32 %conv, 35
  br i1 %cmp19, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond
  %arraydecay21 = getelementptr inbounds [71 x i8], [71 x i8]* %buf, i32 0, i32 0
  %14 = load i32*, i32** %cols.addr, align 8
  %15 = load i32*, i32** %rows.addr, align 8
  %llvm-call22 = call i32 (i8*, i8*, ...) @__isoc99_sscanf(i8* %arraydecay21, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i32 0, i32 0), i32* %14, i32* %15) #5
  br label %do.body23

do.body23:                                        ; preds = %do.cond26, %do.end
  %arraydecay24 = getelementptr inbounds [71 x i8], [71 x i8]* %buf, i32 0, i32 0
  %16 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call25 = call i8* @fgets(i8* %arraydecay24, i32 70, %struct._IO_FILE* %16)
  br label %do.cond26

do.cond26:                                        ; preds = %do.body23
  %arrayidx27 = getelementptr inbounds [71 x i8], [71 x i8]* %buf, i64 0, i64 0
  %17 = load i8, i8* %arrayidx27, align 16
  %conv28 = sext i8 %17 to i32
  %cmp29 = icmp eq i32 %conv28, 35
  br i1 %cmp29, label %do.body23, label %do.end31

do.end31:                                         ; preds = %do.cond26
  %18 = load i32*, i32** %rows.addr, align 8
  %19 = load i32, i32* %18, align 4
  %20 = load i32*, i32** %cols.addr, align 8
  %21 = load i32, i32* %20, align 4
  %mul = mul nsw i32 %19, %21
  %conv32 = sext i32 %mul to i64
  %llvm-call33 = call noalias i8* @malloc(i64 %conv32) #5
  %22 = load i8**, i8*** %image.addr, align 8
  store i8* %llvm-call33, i8** %22, align 8
  %cmp34 = icmp eq i8* %llvm-call33, null
  br i1 %cmp34, label %if.then36, label %if.end43

if.then36:                                        ; preds = %do.end31
  %23 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call37 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %23, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.6, i32 0, i32 0))
  %24 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %25 = load %struct._IO_FILE*, %struct._IO_FILE** @stdin, align 8
  %cmp38 = icmp ne %struct._IO_FILE* %24, %25
  br i1 %cmp38, label %if.then40, label %if.end42

if.then40:                                        ; preds = %if.then36
  %26 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call41 = call i32 @fclose(%struct._IO_FILE* %26)
  br label %if.end42

if.end42:                                         ; preds = %if.then40, %if.then36
  store i32 0, i32* %retval, align 4
  br label %return

if.end43:                                         ; preds = %do.end31
  %27 = load i32*, i32** %rows.addr, align 8
  %28 = load i32, i32* %27, align 4
  %conv44 = sext i32 %28 to i64
  %29 = load i8**, i8*** %image.addr, align 8
  %30 = load i8*, i8** %29, align 8
  %31 = load i32*, i32** %cols.addr, align 8
  %32 = load i32, i32* %31, align 4
  %conv45 = sext i32 %32 to i64
  %33 = load i32*, i32** %rows.addr, align 8
  %34 = load i32, i32* %33, align 4
  %conv46 = sext i32 %34 to i64
  %35 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call47 = call i64 @fread(i8* %30, i64 %conv45, i64 %conv46, %struct._IO_FILE* %35)
  %cmp48 = icmp ne i64 %conv44, %llvm-call47
  br i1 %cmp48, label %if.then50, label %if.end57

if.then50:                                        ; preds = %if.end43
  %36 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call51 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %36, i8* getelementptr inbounds ([51 x i8], [51 x i8]* @.str.7, i32 0, i32 0))
  %37 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %38 = load %struct._IO_FILE*, %struct._IO_FILE** @stdin, align 8
  %cmp52 = icmp ne %struct._IO_FILE* %37, %38
  br i1 %cmp52, label %if.then54, label %if.end56

if.then54:                                        ; preds = %if.then50
  %39 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call55 = call i32 @fclose(%struct._IO_FILE* %39)
  br label %if.end56

if.end56:                                         ; preds = %if.then54, %if.then50
  %40 = load i8**, i8*** %image.addr, align 8
  %41 = load i8*, i8** %40, align 8
  call void @free(i8* %41) #5
  store i32 0, i32* %retval, align 4
  br label %return

if.end57:                                         ; preds = %if.end43
  %42 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %43 = load %struct._IO_FILE*, %struct._IO_FILE** @stdin, align 8
  %cmp58 = icmp ne %struct._IO_FILE* %42, %43
  br i1 %cmp58, label %if.then60, label %if.end62

if.then60:                                        ; preds = %if.end57
  %44 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call61 = call i32 @fclose(%struct._IO_FILE* %44)
  br label %if.end62

if.end62:                                         ; preds = %if.then60, %if.end57
  store i32 1, i32* %retval, align 4
  br label %return

return:                                           ; preds = %if.end62, %if.end56, %if.end42, %if.end15, %if.then2
  %45 = load i32, i32* %retval, align 4
  ret i32 %45
}

declare %struct._IO_FILE* @fopen(i8*, i8*) #1

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...) #1

declare i8* @fgets(i8*, i32, %struct._IO_FILE*) #1

; Function Attrs: nounwind readonly
declare i32 @strncmp(i8*, i8*, i64) #2

declare i32 @fclose(%struct._IO_FILE*) #1

; Function Attrs: nounwind
declare i32 @__isoc99_sscanf(i8*, i8*, ...) #3

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

declare i64 @fread(i8*, i64, i64, %struct._IO_FILE*) #1

; Function Attrs: nounwind
declare void @free(i8*) #3

; Function Attrs: noinline nounwind optnone uwtable
define i32 @write_pgm_image(i8* %outfilename, i8* %image, i32 %rows, i32 %cols, i8* %comment, i32 %maxval) #0 {
entry:
  %retval = alloca i32, align 4
  %outfilename.addr = alloca i8*, align 8
  %image.addr = alloca i8*, align 8
  %rows.addr = alloca i32, align 4
  %cols.addr = alloca i32, align 4
  %comment.addr = alloca i8*, align 8
  %maxval.addr = alloca i32, align 4
  %fp = alloca %struct._IO_FILE*, align 8
  store i8* %outfilename, i8** %outfilename.addr, align 8
  store i8* %image, i8** %image.addr, align 8
  store i32 %rows, i32* %rows.addr, align 4
  store i32 %cols, i32* %cols.addr, align 4
  store i8* %comment, i8** %comment.addr, align 8
  store i32 %maxval, i32* %maxval.addr, align 4
  %0 = load i8*, i8** %outfilename.addr, align 8
  %cmp = icmp eq i8* %0, null
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  store %struct._IO_FILE* %1, %struct._IO_FILE** %fp, align 8
  br label %if.end4

if.else:                                          ; preds = %entry
  %2 = load i8*, i8** %outfilename.addr, align 8
  %llvm-call = call %struct._IO_FILE* @fopen(i8* %2, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.8, i32 0, i32 0))
  store %struct._IO_FILE* %llvm-call, %struct._IO_FILE** %fp, align 8
  %cmp1 = icmp eq %struct._IO_FILE* %llvm-call, null
  br i1 %cmp1, label %if.then2, label %if.end

if.then2:                                         ; preds = %if.else
  %3 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %4 = load i8*, i8** %outfilename.addr, align 8
  %llvm-call3 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %3, i8* getelementptr inbounds ([49 x i8], [49 x i8]* @.str.9, i32 0, i32 0), i8* %4)
  store i32 0, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %if.else
  br label %if.end4

if.end4:                                          ; preds = %if.end, %if.then
  %5 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %6 = load i32, i32* %cols.addr, align 4
  %7 = load i32, i32* %rows.addr, align 4
  %llvm-call5 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %5, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.10, i32 0, i32 0), i32 %6, i32 %7)
  %8 = load i8*, i8** %comment.addr, align 8
  %cmp6 = icmp ne i8* %8, null
  br i1 %cmp6, label %if.then7, label %if.end13

if.then7:                                         ; preds = %if.end4
  %9 = load i8*, i8** %comment.addr, align 8
  %llvm-call8 = call i64 @strlen(i8* %9) #4
  %cmp9 = icmp ule i64 %llvm-call8, 70
  br i1 %cmp9, label %if.then10, label %if.end12

if.then10:                                        ; preds = %if.then7
  %10 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %11 = load i8*, i8** %comment.addr, align 8
  %llvm-call11 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %10, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.11, i32 0, i32 0), i8* %11)
  br label %if.end12

if.end12:                                         ; preds = %if.then10, %if.then7
  br label %if.end13

if.end13:                                         ; preds = %if.end12, %if.end4
  %12 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %13 = load i32, i32* %maxval.addr, align 4
  %llvm-call14 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %12, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.12, i32 0, i32 0), i32 %13)
  %14 = load i32, i32* %rows.addr, align 4
  %conv = sext i32 %14 to i64
  %15 = load i8*, i8** %image.addr, align 8
  %16 = load i32, i32* %cols.addr, align 4
  %conv15 = sext i32 %16 to i64
  %17 = load i32, i32* %rows.addr, align 4
  %conv16 = sext i32 %17 to i64
  %18 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call17 = call i64 @fwrite(i8* %15, i64 %conv15, i64 %conv16, %struct._IO_FILE* %18)
  %cmp18 = icmp ne i64 %conv, %llvm-call17
  br i1 %cmp18, label %if.then20, label %if.end27

if.then20:                                        ; preds = %if.end13
  %19 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call21 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %19, i8* getelementptr inbounds ([52 x i8], [52 x i8]* @.str.13, i32 0, i32 0))
  %20 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %21 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %cmp22 = icmp ne %struct._IO_FILE* %20, %21
  br i1 %cmp22, label %if.then24, label %if.end26

if.then24:                                        ; preds = %if.then20
  %22 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call25 = call i32 @fclose(%struct._IO_FILE* %22)
  br label %if.end26

if.end26:                                         ; preds = %if.then24, %if.then20
  store i32 0, i32* %retval, align 4
  br label %return

if.end27:                                         ; preds = %if.end13
  %23 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %24 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %cmp28 = icmp ne %struct._IO_FILE* %23, %24
  br i1 %cmp28, label %if.then30, label %if.end32

if.then30:                                        ; preds = %if.end27
  %25 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call31 = call i32 @fclose(%struct._IO_FILE* %25)
  br label %if.end32

if.end32:                                         ; preds = %if.then30, %if.end27
  store i32 1, i32* %retval, align 4
  br label %return

return:                                           ; preds = %if.end32, %if.end26, %if.then2
  %26 = load i32, i32* %retval, align 4
  ret i32 %26
}

; Function Attrs: nounwind readonly
declare i64 @strlen(i8*) #2

declare i64 @fwrite(i8*, i64, i64, %struct._IO_FILE*) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @read_ppm_image(i8* %infilename, i8** %image_red, i8** %image_grn, i8** %image_blu, i32* %rows, i32* %cols) #0 {
entry:
  %retval = alloca i32, align 4
  %infilename.addr = alloca i8*, align 8
  %image_red.addr = alloca i8**, align 8
  %image_grn.addr = alloca i8**, align 8
  %image_blu.addr = alloca i8**, align 8
  %rows.addr = alloca i32*, align 8
  %cols.addr = alloca i32*, align 8
  %fp = alloca %struct._IO_FILE*, align 8
  %buf = alloca [71 x i8], align 16
  %p = alloca i32, align 4
  %size = alloca i32, align 4
  store i8* %infilename, i8** %infilename.addr, align 8
  store i8** %image_red, i8*** %image_red.addr, align 8
  store i8** %image_grn, i8*** %image_grn.addr, align 8
  store i8** %image_blu, i8*** %image_blu.addr, align 8
  store i32* %rows, i32** %rows.addr, align 8
  store i32* %cols, i32** %cols.addr, align 8
  %0 = load i8*, i8** %infilename.addr, align 8
  %cmp = icmp eq i8* %0, null
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load %struct._IO_FILE*, %struct._IO_FILE** @stdin, align 8
  store %struct._IO_FILE* %1, %struct._IO_FILE** %fp, align 8
  br label %if.end4

if.else:                                          ; preds = %entry
  %2 = load i8*, i8** %infilename.addr, align 8
  %llvm-call = call %struct._IO_FILE* @fopen(i8* %2, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i32 0, i32 0))
  store %struct._IO_FILE* %llvm-call, %struct._IO_FILE** %fp, align 8
  %cmp1 = icmp eq %struct._IO_FILE* %llvm-call, null
  br i1 %cmp1, label %if.then2, label %if.end

if.then2:                                         ; preds = %if.else
  %3 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %4 = load i8*, i8** %infilename.addr, align 8
  %llvm-call3 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %3, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.14, i32 0, i32 0), i8* %4)
  store i32 0, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %if.else
  br label %if.end4

if.end4:                                          ; preds = %if.end, %if.then
  %arraydecay = getelementptr inbounds [71 x i8], [71 x i8]* %buf, i32 0, i32 0
  %5 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call5 = call i8* @fgets(i8* %arraydecay, i32 70, %struct._IO_FILE* %5)
  %arraydecay6 = getelementptr inbounds [71 x i8], [71 x i8]* %buf, i32 0, i32 0
  %llvm-call7 = call i32 @strncmp(i8* %arraydecay6, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.15, i32 0, i32 0), i64 2) #4
  %cmp8 = icmp ne i32 %llvm-call7, 0
  br i1 %cmp8, label %if.then9, label %if.end16

if.then9:                                         ; preds = %if.end4
  %6 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %7 = load i8*, i8** %infilename.addr, align 8
  %llvm-call10 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %6, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.16, i32 0, i32 0), i8* %7)
  %8 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call11 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %8, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.17, i32 0, i32 0))
  %9 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %10 = load %struct._IO_FILE*, %struct._IO_FILE** @stdin, align 8
  %cmp12 = icmp ne %struct._IO_FILE* %9, %10
  br i1 %cmp12, label %if.then13, label %if.end15

if.then13:                                        ; preds = %if.then9
  %11 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call14 = call i32 @fclose(%struct._IO_FILE* %11)
  br label %if.end15

if.end15:                                         ; preds = %if.then13, %if.then9
  store i32 0, i32* %retval, align 4
  br label %return

if.end16:                                         ; preds = %if.end4
  br label %do.body

do.body:                                          ; preds = %do.cond, %if.end16
  %arraydecay17 = getelementptr inbounds [71 x i8], [71 x i8]* %buf, i32 0, i32 0
  %12 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call18 = call i8* @fgets(i8* %arraydecay17, i32 70, %struct._IO_FILE* %12)
  br label %do.cond

do.cond:                                          ; preds = %do.body
  %arrayidx = getelementptr inbounds [71 x i8], [71 x i8]* %buf, i64 0, i64 0
  %13 = load i8, i8* %arrayidx, align 16
  %conv = sext i8 %13 to i32
  %cmp19 = icmp eq i32 %conv, 35
  br i1 %cmp19, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond
  %arraydecay21 = getelementptr inbounds [71 x i8], [71 x i8]* %buf, i32 0, i32 0
  %14 = load i32*, i32** %cols.addr, align 8
  %15 = load i32*, i32** %rows.addr, align 8
  %llvm-call22 = call i32 (i8*, i8*, ...) @__isoc99_sscanf(i8* %arraydecay21, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i32 0, i32 0), i32* %14, i32* %15) #5
  br label %do.body23

do.body23:                                        ; preds = %do.cond26, %do.end
  %arraydecay24 = getelementptr inbounds [71 x i8], [71 x i8]* %buf, i32 0, i32 0
  %16 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call25 = call i8* @fgets(i8* %arraydecay24, i32 70, %struct._IO_FILE* %16)
  br label %do.cond26

do.cond26:                                        ; preds = %do.body23
  %arrayidx27 = getelementptr inbounds [71 x i8], [71 x i8]* %buf, i64 0, i64 0
  %17 = load i8, i8* %arrayidx27, align 16
  %conv28 = sext i8 %17 to i32
  %cmp29 = icmp eq i32 %conv28, 35
  br i1 %cmp29, label %do.body23, label %do.end31

do.end31:                                         ; preds = %do.cond26
  %18 = load i32*, i32** %rows.addr, align 8
  %19 = load i32, i32* %18, align 4
  %20 = load i32*, i32** %cols.addr, align 8
  %21 = load i32, i32* %20, align 4
  %mul = mul nsw i32 %19, %21
  %conv32 = sext i32 %mul to i64
  %llvm-call33 = call noalias i8* @malloc(i64 %conv32) #5
  %22 = load i8**, i8*** %image_red.addr, align 8
  store i8* %llvm-call33, i8** %22, align 8
  %cmp34 = icmp eq i8* %llvm-call33, null
  br i1 %cmp34, label %if.then36, label %if.end43

if.then36:                                        ; preds = %do.end31
  %23 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call37 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %23, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.18, i32 0, i32 0))
  %24 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %25 = load %struct._IO_FILE*, %struct._IO_FILE** @stdin, align 8
  %cmp38 = icmp ne %struct._IO_FILE* %24, %25
  br i1 %cmp38, label %if.then40, label %if.end42

if.then40:                                        ; preds = %if.then36
  %26 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call41 = call i32 @fclose(%struct._IO_FILE* %26)
  br label %if.end42

if.end42:                                         ; preds = %if.then40, %if.then36
  store i32 0, i32* %retval, align 4
  br label %return

if.end43:                                         ; preds = %do.end31
  %27 = load i32*, i32** %rows.addr, align 8
  %28 = load i32, i32* %27, align 4
  %29 = load i32*, i32** %cols.addr, align 8
  %30 = load i32, i32* %29, align 4
  %mul44 = mul nsw i32 %28, %30
  %conv45 = sext i32 %mul44 to i64
  %llvm-call46 = call noalias i8* @malloc(i64 %conv45) #5
  %31 = load i8**, i8*** %image_grn.addr, align 8
  store i8* %llvm-call46, i8** %31, align 8
  %cmp47 = icmp eq i8* %llvm-call46, null
  br i1 %cmp47, label %if.then49, label %if.end56

if.then49:                                        ; preds = %if.end43
  %32 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call50 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %32, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.18, i32 0, i32 0))
  %33 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %34 = load %struct._IO_FILE*, %struct._IO_FILE** @stdin, align 8
  %cmp51 = icmp ne %struct._IO_FILE* %33, %34
  br i1 %cmp51, label %if.then53, label %if.end55

if.then53:                                        ; preds = %if.then49
  %35 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call54 = call i32 @fclose(%struct._IO_FILE* %35)
  br label %if.end55

if.end55:                                         ; preds = %if.then53, %if.then49
  store i32 0, i32* %retval, align 4
  br label %return

if.end56:                                         ; preds = %if.end43
  %36 = load i32*, i32** %rows.addr, align 8
  %37 = load i32, i32* %36, align 4
  %38 = load i32*, i32** %cols.addr, align 8
  %39 = load i32, i32* %38, align 4
  %mul57 = mul nsw i32 %37, %39
  %conv58 = sext i32 %mul57 to i64
  %llvm-call59 = call noalias i8* @malloc(i64 %conv58) #5
  %40 = load i8**, i8*** %image_blu.addr, align 8
  store i8* %llvm-call59, i8** %40, align 8
  %cmp60 = icmp eq i8* %llvm-call59, null
  br i1 %cmp60, label %if.then62, label %if.end69

if.then62:                                        ; preds = %if.end56
  %41 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call63 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %41, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.18, i32 0, i32 0))
  %42 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %43 = load %struct._IO_FILE*, %struct._IO_FILE** @stdin, align 8
  %cmp64 = icmp ne %struct._IO_FILE* %42, %43
  br i1 %cmp64, label %if.then66, label %if.end68

if.then66:                                        ; preds = %if.then62
  %44 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call67 = call i32 @fclose(%struct._IO_FILE* %44)
  br label %if.end68

if.end68:                                         ; preds = %if.then66, %if.then62
  store i32 0, i32* %retval, align 4
  br label %return

if.end69:                                         ; preds = %if.end56
  %45 = load i32*, i32** %rows.addr, align 8
  %46 = load i32, i32* %45, align 4
  %47 = load i32*, i32** %cols.addr, align 8
  %48 = load i32, i32* %47, align 4
  %mul70 = mul nsw i32 %46, %48
  store i32 %mul70, i32* %size, align 4
  store i32 0, i32* %p, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end69
  %49 = load i32, i32* %p, align 4
  %50 = load i32, i32* %size, align 4
  %cmp71 = icmp slt i32 %49, %50
  br i1 %cmp71, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %51 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call73 = call i32 @fgetc(%struct._IO_FILE* %51)
  %conv74 = trunc i32 %llvm-call73 to i8
  %52 = load i8**, i8*** %image_red.addr, align 8
  %53 = load i8*, i8** %52, align 8
  %54 = load i32, i32* %p, align 4
  %idxprom = sext i32 %54 to i64
  %arrayidx75 = getelementptr inbounds i8, i8* %53, i64 %idxprom
  store i8 %conv74, i8* %arrayidx75, align 1
  %55 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call76 = call i32 @fgetc(%struct._IO_FILE* %55)
  %conv77 = trunc i32 %llvm-call76 to i8
  %56 = load i8**, i8*** %image_grn.addr, align 8
  %57 = load i8*, i8** %56, align 8
  %58 = load i32, i32* %p, align 4
  %idxprom78 = sext i32 %58 to i64
  %arrayidx79 = getelementptr inbounds i8, i8* %57, i64 %idxprom78
  store i8 %conv77, i8* %arrayidx79, align 1
  %59 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call80 = call i32 @fgetc(%struct._IO_FILE* %59)
  %conv81 = trunc i32 %llvm-call80 to i8
  %60 = load i8**, i8*** %image_blu.addr, align 8
  %61 = load i8*, i8** %60, align 8
  %62 = load i32, i32* %p, align 4
  %idxprom82 = sext i32 %62 to i64
  %arrayidx83 = getelementptr inbounds i8, i8* %61, i64 %idxprom82
  store i8 %conv81, i8* %arrayidx83, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %63 = load i32, i32* %p, align 4
  %inc = add nsw i32 %63, 1
  store i32 %inc, i32* %p, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %64 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %65 = load %struct._IO_FILE*, %struct._IO_FILE** @stdin, align 8
  %cmp84 = icmp ne %struct._IO_FILE* %64, %65
  br i1 %cmp84, label %if.then86, label %if.end88

if.then86:                                        ; preds = %for.end
  %66 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call87 = call i32 @fclose(%struct._IO_FILE* %66)
  br label %if.end88

if.end88:                                         ; preds = %if.then86, %for.end
  store i32 1, i32* %retval, align 4
  br label %return

return:                                           ; preds = %if.end88, %if.end68, %if.end55, %if.end42, %if.end15, %if.then2
  %67 = load i32, i32* %retval, align 4
  ret i32 %67
}

declare i32 @fgetc(%struct._IO_FILE*) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @write_ppm_image(i8* %outfilename, i8* %image_red, i8* %image_grn, i8* %image_blu, i32 %rows, i32 %cols, i8* %comment, i32 %maxval) #0 {
entry:
  %retval = alloca i32, align 4
  %outfilename.addr = alloca i8*, align 8
  %image_red.addr = alloca i8*, align 8
  %image_grn.addr = alloca i8*, align 8
  %image_blu.addr = alloca i8*, align 8
  %rows.addr = alloca i32, align 4
  %cols.addr = alloca i32, align 4
  %comment.addr = alloca i8*, align 8
  %maxval.addr = alloca i32, align 4
  %fp = alloca %struct._IO_FILE*, align 8
  %size = alloca i64, align 8
  %p = alloca i64, align 8
  store i8* %outfilename, i8** %outfilename.addr, align 8
  store i8* %image_red, i8** %image_red.addr, align 8
  store i8* %image_grn, i8** %image_grn.addr, align 8
  store i8* %image_blu, i8** %image_blu.addr, align 8
  store i32 %rows, i32* %rows.addr, align 4
  store i32 %cols, i32* %cols.addr, align 4
  store i8* %comment, i8** %comment.addr, align 8
  store i32 %maxval, i32* %maxval.addr, align 4
  %0 = load i8*, i8** %outfilename.addr, align 8
  %cmp = icmp eq i8* %0, null
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  store %struct._IO_FILE* %1, %struct._IO_FILE** %fp, align 8
  br label %if.end4

if.else:                                          ; preds = %entry
  %2 = load i8*, i8** %outfilename.addr, align 8
  %llvm-call = call %struct._IO_FILE* @fopen(i8* %2, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.8, i32 0, i32 0))
  store %struct._IO_FILE* %llvm-call, %struct._IO_FILE** %fp, align 8
  %cmp1 = icmp eq %struct._IO_FILE* %llvm-call, null
  br i1 %cmp1, label %if.then2, label %if.end

if.then2:                                         ; preds = %if.else
  %3 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %4 = load i8*, i8** %outfilename.addr, align 8
  %llvm-call3 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %3, i8* getelementptr inbounds ([49 x i8], [49 x i8]* @.str.9, i32 0, i32 0), i8* %4)
  store i32 0, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %if.else
  br label %if.end4

if.end4:                                          ; preds = %if.end, %if.then
  %5 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %6 = load i32, i32* %cols.addr, align 4
  %7 = load i32, i32* %rows.addr, align 4
  %llvm-call5 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %5, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.19, i32 0, i32 0), i32 %6, i32 %7)
  %8 = load i8*, i8** %comment.addr, align 8
  %cmp6 = icmp ne i8* %8, null
  br i1 %cmp6, label %if.then7, label %if.end13

if.then7:                                         ; preds = %if.end4
  %9 = load i8*, i8** %comment.addr, align 8
  %llvm-call8 = call i64 @strlen(i8* %9) #4
  %cmp9 = icmp ule i64 %llvm-call8, 70
  br i1 %cmp9, label %if.then10, label %if.end12

if.then10:                                        ; preds = %if.then7
  %10 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %11 = load i8*, i8** %comment.addr, align 8
  %llvm-call11 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %10, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.11, i32 0, i32 0), i8* %11)
  br label %if.end12

if.end12:                                         ; preds = %if.then10, %if.then7
  br label %if.end13

if.end13:                                         ; preds = %if.end12, %if.end4
  %12 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %13 = load i32, i32* %maxval.addr, align 4
  %llvm-call14 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %12, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.12, i32 0, i32 0), i32 %13)
  %14 = load i32, i32* %rows.addr, align 4
  %conv = sext i32 %14 to i64
  %15 = load i32, i32* %cols.addr, align 4
  %conv15 = sext i32 %15 to i64
  %mul = mul nsw i64 %conv, %conv15
  store i64 %mul, i64* %size, align 8
  store i64 0, i64* %p, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end13
  %16 = load i64, i64* %p, align 8
  %17 = load i64, i64* %size, align 8
  %cmp16 = icmp slt i64 %16, %17
  br i1 %cmp16, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %18 = load i8*, i8** %image_red.addr, align 8
  %19 = load i64, i64* %p, align 8
  %arrayidx = getelementptr inbounds i8, i8* %18, i64 %19
  %20 = load i8, i8* %arrayidx, align 1
  %conv18 = zext i8 %20 to i32
  %21 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call19 = call i32 @fputc(i32 %conv18, %struct._IO_FILE* %21)
  %22 = load i8*, i8** %image_grn.addr, align 8
  %23 = load i64, i64* %p, align 8
  %arrayidx20 = getelementptr inbounds i8, i8* %22, i64 %23
  %24 = load i8, i8* %arrayidx20, align 1
  %conv21 = zext i8 %24 to i32
  %25 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call22 = call i32 @fputc(i32 %conv21, %struct._IO_FILE* %25)
  %26 = load i8*, i8** %image_blu.addr, align 8
  %27 = load i64, i64* %p, align 8
  %arrayidx23 = getelementptr inbounds i8, i8* %26, i64 %27
  %28 = load i8, i8* %arrayidx23, align 1
  %conv24 = zext i8 %28 to i32
  %29 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call25 = call i32 @fputc(i32 %conv24, %struct._IO_FILE* %29)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %30 = load i64, i64* %p, align 8
  %inc = add nsw i64 %30, 1
  store i64 %inc, i64* %p, align 8
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %31 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %32 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %cmp26 = icmp ne %struct._IO_FILE* %31, %32
  br i1 %cmp26, label %if.then28, label %if.end30

if.then28:                                        ; preds = %for.end
  %33 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call29 = call i32 @fclose(%struct._IO_FILE* %33)
  br label %if.end30

if.end30:                                         ; preds = %if.then28, %for.end
  store i32 1, i32* %retval, align 4
  br label %return

return:                                           ; preds = %if.end30, %if.then2
  %34 = load i32, i32* %retval, align 4
  ret i32 %34
}

declare i32 @fputc(i32, %struct._IO_FILE*) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.1 (tags/RELEASE_601/final)"}
