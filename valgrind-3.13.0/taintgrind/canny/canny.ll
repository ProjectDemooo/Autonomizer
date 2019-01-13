; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@stderr = external global %struct._IO_FILE*, align 8
@.str = private unnamed_addr constant [49 x i8] c"\0A<USAGE> %s image sigma tlow thigh [writedirim]\0A\00", align 1
@.str.1 = private unnamed_addr constant [52 x i8] c"\0A      image:      An image to process. Must be in \00", align 1
@.str.2 = private unnamed_addr constant [13 x i8] c"PGM format.\0A\00", align 1
@.str.3 = private unnamed_addr constant [53 x i8] c"      sigma:      Standard deviation of the gaussian\00", align 1
@.str.4 = private unnamed_addr constant [15 x i8] c" blur kernel.\0A\00", align 1
@.str.5 = private unnamed_addr constant [50 x i8] c"      tlow:       Fraction (0.0-1.0) of the high \00", align 1
@.str.6 = private unnamed_addr constant [26 x i8] c"edge strength threshold.\0A\00", align 1
@.str.7 = private unnamed_addr constant [57 x i8] c"      thigh:      Fraction (0.0-1.0) of the distribution\00", align 1
@.str.8 = private unnamed_addr constant [51 x i8] c" of non-zero edge\0A                  strengths for \00", align 1
@.str.9 = private unnamed_addr constant [45 x i8] c"hysteresis. The fraction is used to compute\0A\00", align 1
@.str.10 = private unnamed_addr constant [53 x i8] c"                  the high edge strength threshold.\0A\00", align 1
@.str.11 = private unnamed_addr constant [47 x i8] c"      writedirim: Optional argument to output \00", align 1
@.str.12 = private unnamed_addr constant [17 x i8] c"a floating point\00", align 1
@.str.13 = private unnamed_addr constant [20 x i8] c" direction image.\0A\0A\00", align 1
@.str.14 = private unnamed_addr constant [36 x i8] c"Error reading the input image, %s.\0A\00", align 1
@.str.15 = private unnamed_addr constant [31 x i8] c"%s_s_%3.2f_l_%3.2f_h_%3.2f.fim\00", align 1
@.str.16 = private unnamed_addr constant [31 x i8] c"%s_s_%3.2f_l_%3.2f_h_%3.2f.pgm\00", align 1
@.str.17 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str.18 = private unnamed_addr constant [35 x i8] c"Error writing the edge image, %s.\0A\00", align 1
@.str.19 = private unnamed_addr constant [3 x i8] c"wb\00", align 1
@.str.20 = private unnamed_addr constant [40 x i8] c"Error opening the file %s for writing.\0A\00", align 1
@.str.21 = private unnamed_addr constant [33 x i8] c"Error allocating the nms image.\0A\00", align 1
@.str.22 = private unnamed_addr constant [34 x i8] c"Error allocating the edge image.\0A\00", align 1
@.str.24 = private unnamed_addr constant [39 x i8] c"Error allocating the magnitude image.\0A\00", align 1
@.str.23 = private unnamed_addr constant [48 x i8] c"Error allocating the gradient direction image.\0A\00", align 1
@.str.25 = private unnamed_addr constant [37 x i8] c"Error allocating the delta_x image.\0A\00", align 1
@.str.26 = private unnamed_addr constant [36 x i8] c"Error allocating the buffer image.\0A\00", align 1
@.str.27 = private unnamed_addr constant [38 x i8] c"Error allocating the smoothed image.\0A\00", align 1
@.str.28 = private unnamed_addr constant [44 x i8] c"Error callocing the gaussian kernel array.\0A\00", align 1
@follow_edges.x = private unnamed_addr constant [8 x i32] [i32 1, i32 1, i32 0, i32 -1, i32 -1, i32 -1, i32 0, i32 1], align 16
@follow_edges.y = private unnamed_addr constant [8 x i32] [i32 0, i32 1, i32 1, i32 1, i32 0, i32 -1, i32 -1, i32 -1], align 16
@stdin = external global %struct._IO_FILE*, align 8
@.str.29 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str.1.30 = private unnamed_addr constant [48 x i8] c"Error reading the file %s in read_pgm_image().\0A\00", align 1
@.str.2.31 = private unnamed_addr constant [3 x i8] c"P5\00", align 1
@.str.3.32 = private unnamed_addr constant [37 x i8] c"The file %s is not in PGM format in \00", align 1
@.str.4.33 = private unnamed_addr constant [19 x i8] c"read_pgm_image().\0A\00", align 1
@.str.5.34 = private unnamed_addr constant [6 x i8] c"%d %d\00", align 1
@.str.6.35 = private unnamed_addr constant [48 x i8] c"Memory allocation failure in read_pgm_image().\0A\00", align 1
@.str.7.36 = private unnamed_addr constant [51 x i8] c"Error reading the image data in read_pgm_image().\0A\00", align 1
@stdout = external global %struct._IO_FILE*, align 8
@.str.8.39 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str.9.40 = private unnamed_addr constant [49 x i8] c"Error writing the file %s in write_pgm_image().\0A\00", align 1
@.str.10.41 = private unnamed_addr constant [10 x i8] c"P5\0A%d %d\0A\00", align 1
@.str.11.42 = private unnamed_addr constant [6 x i8] c"# %s\0A\00", align 1
@.str.12.43 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str.13.44 = private unnamed_addr constant [52 x i8] c"Error writing the image data in write_pgm_image().\0A\00", align 1
@.str.14.45 = private unnamed_addr constant [48 x i8] c"Error reading the file %s in read_ppm_image().\0A\00", align 1
@.str.15.46 = private unnamed_addr constant [3 x i8] c"P6\00", align 1
@.str.16.47 = private unnamed_addr constant [37 x i8] c"The file %s is not in PPM format in \00", align 1
@.str.17.48 = private unnamed_addr constant [19 x i8] c"read_ppm_image().\0A\00", align 1
@.str.18.49 = private unnamed_addr constant [48 x i8] c"Memory allocation failure in read_ppm_image().\0A\00", align 1
@.str.19.50 = private unnamed_addr constant [10 x i8] c"P6\0A%d %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %infilename = alloca i8*, align 8
  %dirfilename = alloca i8*, align 8
  %outfilename = alloca [128 x i8], align 16
  %composedfname = alloca [128 x i8], align 16
  %image = alloca i8*, align 8
  %edge = alloca i8*, align 8
  %rows = alloca i32, align 4
  %cols = alloca i32, align 4
  %sigma = alloca float, align 4
  %tlow = alloca float, align 4
  %thigh = alloca float, align 4
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 8
  store i8* null, i8** %infilename, align 8
  store i8* null, i8** %dirfilename, align 8
  %0 = load i32, i32* %argc.addr, align 4
  %cmp = icmp slt i32 %0, 5
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %2 = load i8**, i8*** %argv.addr, align 8
  %arrayidx = getelementptr inbounds i8*, i8** %2, i64 0
  %3 = load i8*, i8** %arrayidx, align 8
  %llvm-call = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %1, i8* getelementptr inbounds ([49 x i8], [49 x i8]* @.str, i32 0, i32 0), i8* %3)
  %4 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call1 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %4, i8* getelementptr inbounds ([52 x i8], [52 x i8]* @.str.1, i32 0, i32 0))
  %5 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call2 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %5, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.2, i32 0, i32 0))
  %6 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call3 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %6, i8* getelementptr inbounds ([53 x i8], [53 x i8]* @.str.3, i32 0, i32 0))
  %7 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call4 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %7, i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.4, i32 0, i32 0))
  %8 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call5 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %8, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.5, i32 0, i32 0))
  %9 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call6 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %9, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.6, i32 0, i32 0))
  %10 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call7 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %10, i8* getelementptr inbounds ([57 x i8], [57 x i8]* @.str.7, i32 0, i32 0))
  %11 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call8 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %11, i8* getelementptr inbounds ([51 x i8], [51 x i8]* @.str.8, i32 0, i32 0))
  %12 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call9 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %12, i8* getelementptr inbounds ([45 x i8], [45 x i8]* @.str.9, i32 0, i32 0))
  %13 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call10 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %13, i8* getelementptr inbounds ([53 x i8], [53 x i8]* @.str.10, i32 0, i32 0))
  %14 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call11 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %14, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @.str.11, i32 0, i32 0))
  %15 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call12 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %15, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.12, i32 0, i32 0))
  %16 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call13 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %16, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.13, i32 0, i32 0))
  call void @exit(i32 1) #7
  unreachable

if.end:                                           ; preds = %entry
  %17 = load i8**, i8*** %argv.addr, align 8
  %arrayidx14 = getelementptr inbounds i8*, i8** %17, i64 1
  %18 = load i8*, i8** %arrayidx14, align 8
  store i8* %18, i8** %infilename, align 8
  %19 = load i8**, i8*** %argv.addr, align 8
  %arrayidx15 = getelementptr inbounds i8*, i8** %19, i64 2
  %20 = load i8*, i8** %arrayidx15, align 8
  %llvm-call16 = call double @atof(i8* %20) #8
  %conv = fptrunc double %llvm-call16 to float
  store float %conv, float* %sigma, align 4
  %21 = load i8**, i8*** %argv.addr, align 8
  %arrayidx17 = getelementptr inbounds i8*, i8** %21, i64 3
  %22 = load i8*, i8** %arrayidx17, align 8
  %llvm-call18 = call double @atof(i8* %22) #8
  %conv19 = fptrunc double %llvm-call18 to float
  store float %conv19, float* %tlow, align 4
  %23 = load i8**, i8*** %argv.addr, align 8
  %arrayidx20 = getelementptr inbounds i8*, i8** %23, i64 4
  %24 = load i8*, i8** %arrayidx20, align 8
  %llvm-call21 = call double @atof(i8* %24) #8
  %conv22 = fptrunc double %llvm-call21 to float
  store float %conv22, float* %thigh, align 4
  %25 = load i32, i32* %argc.addr, align 4
  %cmp23 = icmp eq i32 %25, 6
  br i1 %cmp23, label %if.then25, label %if.else

if.then25:                                        ; preds = %if.end
  %26 = load i8*, i8** %infilename, align 8
  store i8* %26, i8** %dirfilename, align 8
  br label %if.end26

if.else:                                          ; preds = %if.end
  store i8* null, i8** %dirfilename, align 8
  br label %if.end26

if.end26:                                         ; preds = %if.else, %if.then25
  %27 = load i8*, i8** %infilename, align 8
  %llvm-call27 = call i32 @read_pgm_image(i8* %27, i8** %image, i32* %rows, i32* %cols)
  %cmp28 = icmp eq i32 %llvm-call27, 0
  br i1 %cmp28, label %if.then30, label %if.end32

if.then30:                                        ; preds = %if.end26
  %28 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %29 = load i8*, i8** %infilename, align 8
  %llvm-call31 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %28, i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.14, i32 0, i32 0), i8* %29)
  call void @exit(i32 1) #7
  unreachable

if.end32:                                         ; preds = %if.end26
  %30 = load i8*, i8** %dirfilename, align 8
  %cmp33 = icmp ne i8* %30, null
  br i1 %cmp33, label %if.then35, label %if.end41

if.then35:                                        ; preds = %if.end32
  %arraydecay = getelementptr inbounds [128 x i8], [128 x i8]* %composedfname, i32 0, i32 0
  %31 = load i8*, i8** %infilename, align 8
  %32 = load float, float* %sigma, align 4
  %conv36 = fpext float %32 to double
  %33 = load float, float* %tlow, align 4
  %conv37 = fpext float %33 to double
  %34 = load float, float* %thigh, align 4
  %conv38 = fpext float %34 to double
  %llvm-call39 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.15, i32 0, i32 0), i8* %31, double %conv36, double %conv37, double %conv38) #9
  %arraydecay40 = getelementptr inbounds [128 x i8], [128 x i8]* %composedfname, i32 0, i32 0
  store i8* %arraydecay40, i8** %dirfilename, align 8
  br label %if.end41

if.end41:                                         ; preds = %if.then35, %if.end32
  %35 = load i8*, i8** %image, align 8
  %36 = load i32, i32* %rows, align 4
  %37 = load i32, i32* %cols, align 4
  %38 = load float, float* %sigma, align 4
  %39 = load float, float* %tlow, align 4
  %40 = load float, float* %thigh, align 4
  %41 = load i8*, i8** %dirfilename, align 8
  call void @canny(i8* %35, i32 %36, i32 %37, float %38, float %39, float %40, i8** %edge, i8* %41)
  %arraydecay42 = getelementptr inbounds [128 x i8], [128 x i8]* %outfilename, i32 0, i32 0
  %42 = load i8*, i8** %infilename, align 8
  %43 = load float, float* %sigma, align 4
  %conv43 = fpext float %43 to double
  %44 = load float, float* %tlow, align 4
  %conv44 = fpext float %44 to double
  %45 = load float, float* %thigh, align 4
  %conv45 = fpext float %45 to double
  %llvm-call46 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay42, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.16, i32 0, i32 0), i8* %42, double %conv43, double %conv44, double %conv45) #9
  %arraydecay47 = getelementptr inbounds [128 x i8], [128 x i8]* %outfilename, i32 0, i32 0
  %46 = load i8*, i8** %edge, align 8
  %47 = load i32, i32* %rows, align 4
  %48 = load i32, i32* %cols, align 4
  %llvm-call48 = call i32 @write_pgm_image(i8* %arraydecay47, i8* %46, i32 %47, i32 %48, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.17, i32 0, i32 0), i32 255)
  %cmp49 = icmp eq i32 %llvm-call48, 0
  br i1 %cmp49, label %if.then51, label %if.end54

if.then51:                                        ; preds = %if.end41
  %49 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %arraydecay52 = getelementptr inbounds [128 x i8], [128 x i8]* %outfilename, i32 0, i32 0
  %llvm-call53 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %49, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.18, i32 0, i32 0), i8* %arraydecay52)
  call void @exit(i32 1) #7
  unreachable

if.end54:                                         ; preds = %if.end41
  %50 = load i32, i32* %retval, align 4
  ret i32 %50
}

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...) #1

; Function Attrs: noreturn nounwind
declare void @exit(i32) #2

; Function Attrs: nounwind readonly
declare double @atof(i8*) #3

; Function Attrs: nounwind
declare i32 @sprintf(i8*, i8*, ...) #4

; Function Attrs: noinline nounwind optnone uwtable
define void @canny(i8* %image, i32 %rows, i32 %cols, float %sigma, float %tlow, float %thigh, i8** %edge, i8* %fname) #0 {
entry:
  %image.addr = alloca i8*, align 8
  %rows.addr = alloca i32, align 4
  %cols.addr = alloca i32, align 4
  %sigma.addr = alloca float, align 4
  %tlow.addr = alloca float, align 4
  %thigh.addr = alloca float, align 4
  %edge.addr = alloca i8**, align 8
  %fname.addr = alloca i8*, align 8
  %fpdir = alloca %struct._IO_FILE*, align 8
  %nms = alloca i8*, align 8
  %smoothedim = alloca i16*, align 8
  %delta_x = alloca i16*, align 8
  %delta_y = alloca i16*, align 8
  %magnitude = alloca i16*, align 8
  %r = alloca i32, align 4
  %c = alloca i32, align 4
  %pos = alloca i32, align 4
  %dir_radians = alloca float*, align 8
  store i8* %image, i8** %image.addr, align 8
  store i32 %rows, i32* %rows.addr, align 4
  store i32 %cols, i32* %cols.addr, align 4
  store float %sigma, float* %sigma.addr, align 4
  store float %tlow, float* %tlow.addr, align 4
  store float %thigh, float* %thigh.addr, align 4
  store i8** %edge, i8*** %edge.addr, align 8
  store i8* %fname, i8** %fname.addr, align 8
  store %struct._IO_FILE* null, %struct._IO_FILE** %fpdir, align 8
  store float* null, float** %dir_radians, align 8
  %0 = load i8*, i8** %image.addr, align 8
  %1 = load i32, i32* %rows.addr, align 4
  %2 = load i32, i32* %cols.addr, align 4
  %3 = load float, float* %sigma.addr, align 4
  call void @gaussian_smooth(i8* %0, i32 %1, i32 %2, float %3, i16** %smoothedim)
  %4 = load i16*, i16** %smoothedim, align 8
  %5 = load i32, i32* %rows.addr, align 4
  %6 = load i32, i32* %cols.addr, align 4
  call void @derrivative_x_y(i16* %4, i32 %5, i32 %6, i16** %delta_x, i16** %delta_y)
  %7 = load i8*, i8** %fname.addr, align 8
  %cmp = icmp ne i8* %7, null
  br i1 %cmp, label %if.then, label %if.end6

if.then:                                          ; preds = %entry
  %8 = load i16*, i16** %delta_x, align 8
  %9 = load i16*, i16** %delta_y, align 8
  %10 = load i32, i32* %rows.addr, align 4
  %11 = load i32, i32* %cols.addr, align 4
  call void @radian_direction(i16* %8, i16* %9, i32 %10, i32 %11, float** %dir_radians, i32 -1, i32 -1)
  %12 = load i8*, i8** %fname.addr, align 8
  %llvm-call = call %struct._IO_FILE* @fopen(i8* %12, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.19, i32 0, i32 0))
  store %struct._IO_FILE* %llvm-call, %struct._IO_FILE** %fpdir, align 8
  %cmp1 = icmp eq %struct._IO_FILE* %llvm-call, null
  br i1 %cmp1, label %if.then2, label %if.end

if.then2:                                         ; preds = %if.then
  %13 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %14 = load i8*, i8** %fname.addr, align 8
  %llvm-call3 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %13, i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.20, i32 0, i32 0), i8* %14)
  call void @exit(i32 1) #7
  unreachable

if.end:                                           ; preds = %if.then
  %15 = load float*, float** %dir_radians, align 8
  %16 = bitcast float* %15 to i8*
  %17 = load i32, i32* %rows.addr, align 4
  %18 = load i32, i32* %cols.addr, align 4
  %mul = mul nsw i32 %17, %18
  %conv = sext i32 %mul to i64
  %19 = load %struct._IO_FILE*, %struct._IO_FILE** %fpdir, align 8
  %llvm-call4 = call i64 @fwrite(i8* %16, i64 4, i64 %conv, %struct._IO_FILE* %19)
  %20 = load %struct._IO_FILE*, %struct._IO_FILE** %fpdir, align 8
  %llvm-call5 = call i32 @fclose(%struct._IO_FILE* %20)
  %21 = load float*, float** %dir_radians, align 8
  %22 = bitcast float* %21 to i8*
  call void @free(i8* %22) #9
  br label %if.end6

if.end6:                                          ; preds = %if.end, %entry
  %23 = load i16*, i16** %delta_x, align 8
  %24 = load i16*, i16** %delta_y, align 8
  %25 = load i32, i32* %rows.addr, align 4
  %26 = load i32, i32* %cols.addr, align 4
  call void @magnitude_x_y(i16* %23, i16* %24, i32 %25, i32 %26, i16** %magnitude)
  %27 = load i32, i32* %rows.addr, align 4
  %28 = load i32, i32* %cols.addr, align 4
  %mul7 = mul nsw i32 %27, %28
  %conv8 = sext i32 %mul7 to i64
  %llvm-call9 = call noalias i8* @calloc(i64 %conv8, i64 1) #9
  store i8* %llvm-call9, i8** %nms, align 8
  %cmp10 = icmp eq i8* %llvm-call9, null
  br i1 %cmp10, label %if.then12, label %if.end14

if.then12:                                        ; preds = %if.end6
  %29 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call13 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %29, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.21, i32 0, i32 0))
  call void @exit(i32 1) #7
  unreachable

if.end14:                                         ; preds = %if.end6
  %30 = load i16*, i16** %magnitude, align 8
  %31 = load i16*, i16** %delta_x, align 8
  %32 = load i16*, i16** %delta_y, align 8
  %33 = load i32, i32* %rows.addr, align 4
  %34 = load i32, i32* %cols.addr, align 4
  %35 = load i8*, i8** %nms, align 8
  %llvm-call15 = call i32 (i16*, i16*, i16*, i32, i32, i8*, ...) bitcast (i32 (i16*, i16*, i16*, i32, i32, i8*)* @non_max_supp to i32 (i16*, i16*, i16*, i32, i32, i8*, ...)*)(i16* %30, i16* %31, i16* %32, i32 %33, i32 %34, i8* %35)
  %36 = load i32, i32* %rows.addr, align 4
  %37 = load i32, i32* %cols.addr, align 4
  %mul16 = mul nsw i32 %36, %37
  %conv17 = sext i32 %mul16 to i64
  %llvm-call18 = call noalias i8* @calloc(i64 %conv17, i64 1) #9
  %38 = load i8**, i8*** %edge.addr, align 8
  store i8* %llvm-call18, i8** %38, align 8
  %cmp19 = icmp eq i8* %llvm-call18, null
  br i1 %cmp19, label %if.then21, label %if.end23

if.then21:                                        ; preds = %if.end14
  %39 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call22 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %39, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.22, i32 0, i32 0))
  call void @exit(i32 1) #7
  unreachable

if.end23:                                         ; preds = %if.end14
  %40 = load i16*, i16** %magnitude, align 8
  %41 = load i8*, i8** %nms, align 8
  %42 = load i32, i32* %rows.addr, align 4
  %43 = load i32, i32* %cols.addr, align 4
  %44 = load float, float* %tlow.addr, align 4
  %45 = load float, float* %thigh.addr, align 4
  %46 = load i8**, i8*** %edge.addr, align 8
  %47 = load i8*, i8** %46, align 8
  call void @apply_hysteresis(i16* %40, i8* %41, i32 %42, i32 %43, float %44, float %45, i8* %47)
  %48 = load i16*, i16** %smoothedim, align 8
  %49 = bitcast i16* %48 to i8*
  call void @free(i8* %49) #9
  %50 = load i16*, i16** %delta_x, align 8
  %51 = bitcast i16* %50 to i8*
  call void @free(i8* %51) #9
  %52 = load i16*, i16** %delta_y, align 8
  %53 = bitcast i16* %52 to i8*
  call void @free(i8* %53) #9
  %54 = load i16*, i16** %magnitude, align 8
  %55 = bitcast i16* %54 to i8*
  call void @free(i8* %55) #9
  %56 = load i8*, i8** %nms, align 8
  call void @free(i8* %56) #9
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @gaussian_smooth(i8* %image, i32 %rows, i32 %cols, float %sigma, i16** %smoothedim) #0 {
entry:
  %image.addr = alloca i8*, align 8
  %rows.addr = alloca i32, align 4
  %cols.addr = alloca i32, align 4
  %sigma.addr = alloca float, align 4
  %smoothedim.addr = alloca i16**, align 8
  %r = alloca i32, align 4
  %c = alloca i32, align 4
  %rr = alloca i32, align 4
  %cc = alloca i32, align 4
  %windowsize = alloca i32, align 4
  %center = alloca i32, align 4
  %tempim = alloca float*, align 8
  %kernel = alloca float*, align 8
  %dot = alloca float, align 4
  %sum = alloca float, align 4
  store i8* %image, i8** %image.addr, align 8
  store i32 %rows, i32* %rows.addr, align 4
  store i32 %cols, i32* %cols.addr, align 4
  store float %sigma, float* %sigma.addr, align 4
  store i16** %smoothedim, i16*** %smoothedim.addr, align 8
  %0 = load float, float* %sigma.addr, align 4
  call void @make_gaussian_kernel(float %0, float** %kernel, i32* %windowsize)
  %1 = load i32, i32* %windowsize, align 4
  %div = sdiv i32 %1, 2
  store i32 %div, i32* %center, align 4
  %2 = load i32, i32* %rows.addr, align 4
  %3 = load i32, i32* %cols.addr, align 4
  %mul = mul nsw i32 %2, %3
  %conv = sext i32 %mul to i64
  %llvm-call = call noalias i8* @calloc(i64 %conv, i64 4) #9
  %4 = bitcast i8* %llvm-call to float*
  store float* %4, float** %tempim, align 8
  %cmp = icmp eq float* %4, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %5 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call2 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %5, i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.26, i32 0, i32 0))
  call void @exit(i32 1) #7
  unreachable

if.end:                                           ; preds = %entry
  %6 = load i32, i32* %rows.addr, align 4
  %7 = load i32, i32* %cols.addr, align 4
  %mul3 = mul nsw i32 %6, %7
  %conv4 = sext i32 %mul3 to i64
  %llvm-call5 = call noalias i8* @calloc(i64 %conv4, i64 2) #9
  %8 = bitcast i8* %llvm-call5 to i16*
  %9 = load i16**, i16*** %smoothedim.addr, align 8
  store i16* %8, i16** %9, align 8
  %cmp6 = icmp eq i16* %8, null
  br i1 %cmp6, label %if.then8, label %if.end10

if.then8:                                         ; preds = %if.end
  %10 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call9 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %10, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.27, i32 0, i32 0))
  call void @exit(i32 1) #7
  unreachable

if.end10:                                         ; preds = %if.end
  store i32 0, i32* %r, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc49, %if.end10
  %11 = load i32, i32* %r, align 4
  %12 = load i32, i32* %rows.addr, align 4
  %cmp11 = icmp slt i32 %11, %12
  br i1 %cmp11, label %for.body, label %for.end51

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %c, align 4
  br label %for.cond13

for.cond13:                                       ; preds = %for.inc46, %for.body
  %13 = load i32, i32* %c, align 4
  %14 = load i32, i32* %cols.addr, align 4
  %cmp14 = icmp slt i32 %13, %14
  br i1 %cmp14, label %for.body16, label %for.end48

for.body16:                                       ; preds = %for.cond13
  store float 0.000000e+00, float* %dot, align 4
  store float 0.000000e+00, float* %sum, align 4
  %15 = load i32, i32* %center, align 4
  %sub = sub nsw i32 0, %15
  store i32 %sub, i32* %cc, align 4
  br label %for.cond17

for.cond17:                                       ; preds = %for.inc, %for.body16
  %16 = load i32, i32* %cc, align 4
  %17 = load i32, i32* %center, align 4
  %cmp18 = icmp sle i32 %16, %17
  br i1 %cmp18, label %for.body20, label %for.end

for.body20:                                       ; preds = %for.cond17
  %18 = load i32, i32* %c, align 4
  %19 = load i32, i32* %cc, align 4
  %add = add nsw i32 %18, %19
  %cmp21 = icmp sge i32 %add, 0
  br i1 %cmp21, label %land.lhs.true, label %if.end40

land.lhs.true:                                    ; preds = %for.body20
  %20 = load i32, i32* %c, align 4
  %21 = load i32, i32* %cc, align 4
  %add23 = add nsw i32 %20, %21
  %22 = load i32, i32* %cols.addr, align 4
  %cmp24 = icmp slt i32 %add23, %22
  br i1 %cmp24, label %if.then26, label %if.end40

if.then26:                                        ; preds = %land.lhs.true
  %23 = load i8*, i8** %image.addr, align 8
  %24 = load i32, i32* %r, align 4
  %25 = load i32, i32* %cols.addr, align 4
  %mul27 = mul nsw i32 %24, %25
  %26 = load i32, i32* %c, align 4
  %27 = load i32, i32* %cc, align 4
  %add28 = add nsw i32 %26, %27
  %add29 = add nsw i32 %mul27, %add28
  %idxprom = sext i32 %add29 to i64
  %arrayidx = getelementptr inbounds i8, i8* %23, i64 %idxprom
  %28 = load i8, i8* %arrayidx, align 1
  %conv30 = uitofp i8 %28 to float
  %29 = load float*, float** %kernel, align 8
  %30 = load i32, i32* %center, align 4
  %31 = load i32, i32* %cc, align 4
  %add31 = add nsw i32 %30, %31
  %idxprom32 = sext i32 %add31 to i64
  %arrayidx33 = getelementptr inbounds float, float* %29, i64 %idxprom32
  %32 = load float, float* %arrayidx33, align 4
  %mul34 = fmul float %conv30, %32
  %33 = load float, float* %dot, align 4
  %add35 = fadd float %33, %mul34
  store float %add35, float* %dot, align 4
  %34 = load float*, float** %kernel, align 8
  %35 = load i32, i32* %center, align 4
  %36 = load i32, i32* %cc, align 4
  %add36 = add nsw i32 %35, %36
  %idxprom37 = sext i32 %add36 to i64
  %arrayidx38 = getelementptr inbounds float, float* %34, i64 %idxprom37
  %37 = load float, float* %arrayidx38, align 4
  %38 = load float, float* %sum, align 4
  %add39 = fadd float %38, %37
  store float %add39, float* %sum, align 4
  br label %if.end40

if.end40:                                         ; preds = %if.then26, %land.lhs.true, %for.body20
  br label %for.inc

for.inc:                                          ; preds = %if.end40
  %39 = load i32, i32* %cc, align 4
  %inc = add nsw i32 %39, 1
  store i32 %inc, i32* %cc, align 4
  br label %for.cond17

for.end:                                          ; preds = %for.cond17
  %40 = load float, float* %dot, align 4
  %41 = load float, float* %sum, align 4
  %div41 = fdiv float %40, %41
  %42 = load float*, float** %tempim, align 8
  %43 = load i32, i32* %r, align 4
  %44 = load i32, i32* %cols.addr, align 4
  %mul42 = mul nsw i32 %43, %44
  %45 = load i32, i32* %c, align 4
  %add43 = add nsw i32 %mul42, %45
  %idxprom44 = sext i32 %add43 to i64
  %arrayidx45 = getelementptr inbounds float, float* %42, i64 %idxprom44
  store float %div41, float* %arrayidx45, align 4
  br label %for.inc46

for.inc46:                                        ; preds = %for.end
  %46 = load i32, i32* %c, align 4
  %inc47 = add nsw i32 %46, 1
  store i32 %inc47, i32* %c, align 4
  br label %for.cond13

for.end48:                                        ; preds = %for.cond13
  br label %for.inc49

for.inc49:                                        ; preds = %for.end48
  %47 = load i32, i32* %r, align 4
  %inc50 = add nsw i32 %47, 1
  store i32 %inc50, i32* %r, align 4
  br label %for.cond

for.end51:                                        ; preds = %for.cond
  store i32 0, i32* %c, align 4
  br label %for.cond52

for.cond52:                                       ; preds = %for.inc104, %for.end51
  %48 = load i32, i32* %c, align 4
  %49 = load i32, i32* %cols.addr, align 4
  %cmp53 = icmp slt i32 %48, %49
  br i1 %cmp53, label %for.body55, label %for.end106

for.body55:                                       ; preds = %for.cond52
  store i32 0, i32* %r, align 4
  br label %for.cond56

for.cond56:                                       ; preds = %for.inc101, %for.body55
  %50 = load i32, i32* %r, align 4
  %51 = load i32, i32* %rows.addr, align 4
  %cmp57 = icmp slt i32 %50, %51
  br i1 %cmp57, label %for.body59, label %for.end103

for.body59:                                       ; preds = %for.cond56
  store float 0.000000e+00, float* %sum, align 4
  store float 0.000000e+00, float* %dot, align 4
  %52 = load i32, i32* %center, align 4
  %sub60 = sub nsw i32 0, %52
  store i32 %sub60, i32* %rr, align 4
  br label %for.cond61

for.cond61:                                       ; preds = %for.inc88, %for.body59
  %53 = load i32, i32* %rr, align 4
  %54 = load i32, i32* %center, align 4
  %cmp62 = icmp sle i32 %53, %54
  br i1 %cmp62, label %for.body64, label %for.end90

for.body64:                                       ; preds = %for.cond61
  %55 = load i32, i32* %r, align 4
  %56 = load i32, i32* %rr, align 4
  %add65 = add nsw i32 %55, %56
  %cmp66 = icmp sge i32 %add65, 0
  br i1 %cmp66, label %land.lhs.true68, label %if.end87

land.lhs.true68:                                  ; preds = %for.body64
  %57 = load i32, i32* %r, align 4
  %58 = load i32, i32* %rr, align 4
  %add69 = add nsw i32 %57, %58
  %59 = load i32, i32* %rows.addr, align 4
  %cmp70 = icmp slt i32 %add69, %59
  br i1 %cmp70, label %if.then72, label %if.end87

if.then72:                                        ; preds = %land.lhs.true68
  %60 = load float*, float** %tempim, align 8
  %61 = load i32, i32* %r, align 4
  %62 = load i32, i32* %rr, align 4
  %add73 = add nsw i32 %61, %62
  %63 = load i32, i32* %cols.addr, align 4
  %mul74 = mul nsw i32 %add73, %63
  %64 = load i32, i32* %c, align 4
  %add75 = add nsw i32 %mul74, %64
  %idxprom76 = sext i32 %add75 to i64
  %arrayidx77 = getelementptr inbounds float, float* %60, i64 %idxprom76
  %65 = load float, float* %arrayidx77, align 4
  %66 = load float*, float** %kernel, align 8
  %67 = load i32, i32* %center, align 4
  %68 = load i32, i32* %rr, align 4
  %add78 = add nsw i32 %67, %68
  %idxprom79 = sext i32 %add78 to i64
  %arrayidx80 = getelementptr inbounds float, float* %66, i64 %idxprom79
  %69 = load float, float* %arrayidx80, align 4
  %mul81 = fmul float %65, %69
  %70 = load float, float* %dot, align 4
  %add82 = fadd float %70, %mul81
  store float %add82, float* %dot, align 4
  %71 = load float*, float** %kernel, align 8
  %72 = load i32, i32* %center, align 4
  %73 = load i32, i32* %rr, align 4
  %add83 = add nsw i32 %72, %73
  %idxprom84 = sext i32 %add83 to i64
  %arrayidx85 = getelementptr inbounds float, float* %71, i64 %idxprom84
  %74 = load float, float* %arrayidx85, align 4
  %75 = load float, float* %sum, align 4
  %add86 = fadd float %75, %74
  store float %add86, float* %sum, align 4
  br label %if.end87

if.end87:                                         ; preds = %if.then72, %land.lhs.true68, %for.body64
  br label %for.inc88

for.inc88:                                        ; preds = %if.end87
  %76 = load i32, i32* %rr, align 4
  %inc89 = add nsw i32 %76, 1
  store i32 %inc89, i32* %rr, align 4
  br label %for.cond61

for.end90:                                        ; preds = %for.cond61
  %77 = load float, float* %dot, align 4
  %conv91 = fpext float %77 to double
  %mul92 = fmul double %conv91, 9.000000e+01
  %78 = load float, float* %sum, align 4
  %conv93 = fpext float %78 to double
  %div94 = fdiv double %mul92, %conv93
  %add95 = fadd double %div94, 5.000000e-01
  %conv96 = fptosi double %add95 to i16
  %79 = load i16**, i16*** %smoothedim.addr, align 8
  %80 = load i16*, i16** %79, align 8
  %81 = load i32, i32* %r, align 4
  %82 = load i32, i32* %cols.addr, align 4
  %mul97 = mul nsw i32 %81, %82
  %83 = load i32, i32* %c, align 4
  %add98 = add nsw i32 %mul97, %83
  %idxprom99 = sext i32 %add98 to i64
  %arrayidx100 = getelementptr inbounds i16, i16* %80, i64 %idxprom99
  store i16 %conv96, i16* %arrayidx100, align 2
  br label %for.inc101

for.inc101:                                       ; preds = %for.end90
  %84 = load i32, i32* %r, align 4
  %inc102 = add nsw i32 %84, 1
  store i32 %inc102, i32* %r, align 4
  br label %for.cond56

for.end103:                                       ; preds = %for.cond56
  br label %for.inc104

for.inc104:                                       ; preds = %for.end103
  %85 = load i32, i32* %c, align 4
  %inc105 = add nsw i32 %85, 1
  store i32 %inc105, i32* %c, align 4
  br label %for.cond52

for.end106:                                       ; preds = %for.cond52
  %86 = load float*, float** %tempim, align 8
  %87 = bitcast float* %86 to i8*
  call void @free(i8* %87) #9
  %88 = load float*, float** %kernel, align 8
  %89 = bitcast float* %88 to i8*
  call void @free(i8* %89) #9
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @derrivative_x_y(i16* %smoothedim, i32 %rows, i32 %cols, i16** %delta_x, i16** %delta_y) #0 {
entry:
  %smoothedim.addr = alloca i16*, align 8
  %rows.addr = alloca i32, align 4
  %cols.addr = alloca i32, align 4
  %delta_x.addr = alloca i16**, align 8
  %delta_y.addr = alloca i16**, align 8
  %r = alloca i32, align 4
  %c = alloca i32, align 4
  %pos = alloca i32, align 4
  store i16* %smoothedim, i16** %smoothedim.addr, align 8
  store i32 %rows, i32* %rows.addr, align 4
  store i32 %cols, i32* %cols.addr, align 4
  store i16** %delta_x, i16*** %delta_x.addr, align 8
  store i16** %delta_y, i16*** %delta_y.addr, align 8
  %0 = load i32, i32* %rows.addr, align 4
  %1 = load i32, i32* %cols.addr, align 4
  %mul = mul nsw i32 %0, %1
  %conv = sext i32 %mul to i64
  %llvm-call = call noalias i8* @calloc(i64 %conv, i64 2) #9
  %2 = bitcast i8* %llvm-call to i16*
  %3 = load i16**, i16*** %delta_x.addr, align 8
  store i16* %2, i16** %3, align 8
  %cmp = icmp eq i16* %2, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %4 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call2 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %4, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.25, i32 0, i32 0))
  call void @exit(i32 1) #7
  unreachable

if.end:                                           ; preds = %entry
  %5 = load i32, i32* %rows.addr, align 4
  %6 = load i32, i32* %cols.addr, align 4
  %mul3 = mul nsw i32 %5, %6
  %conv4 = sext i32 %mul3 to i64
  %llvm-call5 = call noalias i8* @calloc(i64 %conv4, i64 2) #9
  %7 = bitcast i8* %llvm-call5 to i16*
  %8 = load i16**, i16*** %delta_y.addr, align 8
  store i16* %7, i16** %8, align 8
  %cmp6 = icmp eq i16* %7, null
  br i1 %cmp6, label %if.then8, label %if.end10

if.then8:                                         ; preds = %if.end
  %9 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call9 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %9, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.25, i32 0, i32 0))
  call void @exit(i32 1) #7
  unreachable

if.end10:                                         ; preds = %if.end
  store i32 0, i32* %r, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc51, %if.end10
  %10 = load i32, i32* %r, align 4
  %11 = load i32, i32* %rows.addr, align 4
  %cmp11 = icmp slt i32 %10, %11
  br i1 %cmp11, label %for.body, label %for.end53

for.body:                                         ; preds = %for.cond
  %12 = load i32, i32* %r, align 4
  %13 = load i32, i32* %cols.addr, align 4
  %mul13 = mul nsw i32 %12, %13
  store i32 %mul13, i32* %pos, align 4
  %14 = load i16*, i16** %smoothedim.addr, align 8
  %15 = load i32, i32* %pos, align 4
  %add = add nsw i32 %15, 1
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds i16, i16* %14, i64 %idxprom
  %16 = load i16, i16* %arrayidx, align 2
  %conv14 = sext i16 %16 to i32
  %17 = load i16*, i16** %smoothedim.addr, align 8
  %18 = load i32, i32* %pos, align 4
  %idxprom15 = sext i32 %18 to i64
  %arrayidx16 = getelementptr inbounds i16, i16* %17, i64 %idxprom15
  %19 = load i16, i16* %arrayidx16, align 2
  %conv17 = sext i16 %19 to i32
  %sub = sub nsw i32 %conv14, %conv17
  %conv18 = trunc i32 %sub to i16
  %20 = load i16**, i16*** %delta_x.addr, align 8
  %21 = load i16*, i16** %20, align 8
  %22 = load i32, i32* %pos, align 4
  %idxprom19 = sext i32 %22 to i64
  %arrayidx20 = getelementptr inbounds i16, i16* %21, i64 %idxprom19
  store i16 %conv18, i16* %arrayidx20, align 2
  %23 = load i32, i32* %pos, align 4
  %inc = add nsw i32 %23, 1
  store i32 %inc, i32* %pos, align 4
  store i32 1, i32* %c, align 4
  br label %for.cond21

for.cond21:                                       ; preds = %for.inc, %for.body
  %24 = load i32, i32* %c, align 4
  %25 = load i32, i32* %cols.addr, align 4
  %sub22 = sub nsw i32 %25, 1
  %cmp23 = icmp slt i32 %24, %sub22
  br i1 %cmp23, label %for.body25, label %for.end

for.body25:                                       ; preds = %for.cond21
  %26 = load i16*, i16** %smoothedim.addr, align 8
  %27 = load i32, i32* %pos, align 4
  %add26 = add nsw i32 %27, 1
  %idxprom27 = sext i32 %add26 to i64
  %arrayidx28 = getelementptr inbounds i16, i16* %26, i64 %idxprom27
  %28 = load i16, i16* %arrayidx28, align 2
  %conv29 = sext i16 %28 to i32
  %29 = load i16*, i16** %smoothedim.addr, align 8
  %30 = load i32, i32* %pos, align 4
  %sub30 = sub nsw i32 %30, 1
  %idxprom31 = sext i32 %sub30 to i64
  %arrayidx32 = getelementptr inbounds i16, i16* %29, i64 %idxprom31
  %31 = load i16, i16* %arrayidx32, align 2
  %conv33 = sext i16 %31 to i32
  %sub34 = sub nsw i32 %conv29, %conv33
  %conv35 = trunc i32 %sub34 to i16
  %32 = load i16**, i16*** %delta_x.addr, align 8
  %33 = load i16*, i16** %32, align 8
  %34 = load i32, i32* %pos, align 4
  %idxprom36 = sext i32 %34 to i64
  %arrayidx37 = getelementptr inbounds i16, i16* %33, i64 %idxprom36
  store i16 %conv35, i16* %arrayidx37, align 2
  br label %for.inc

for.inc:                                          ; preds = %for.body25
  %35 = load i32, i32* %c, align 4
  %inc38 = add nsw i32 %35, 1
  store i32 %inc38, i32* %c, align 4
  %36 = load i32, i32* %pos, align 4
  %inc39 = add nsw i32 %36, 1
  store i32 %inc39, i32* %pos, align 4
  br label %for.cond21

for.end:                                          ; preds = %for.cond21
  %37 = load i16*, i16** %smoothedim.addr, align 8
  %38 = load i32, i32* %pos, align 4
  %idxprom40 = sext i32 %38 to i64
  %arrayidx41 = getelementptr inbounds i16, i16* %37, i64 %idxprom40
  %39 = load i16, i16* %arrayidx41, align 2
  %conv42 = sext i16 %39 to i32
  %40 = load i16*, i16** %smoothedim.addr, align 8
  %41 = load i32, i32* %pos, align 4
  %sub43 = sub nsw i32 %41, 1
  %idxprom44 = sext i32 %sub43 to i64
  %arrayidx45 = getelementptr inbounds i16, i16* %40, i64 %idxprom44
  %42 = load i16, i16* %arrayidx45, align 2
  %conv46 = sext i16 %42 to i32
  %sub47 = sub nsw i32 %conv42, %conv46
  %conv48 = trunc i32 %sub47 to i16
  %43 = load i16**, i16*** %delta_x.addr, align 8
  %44 = load i16*, i16** %43, align 8
  %45 = load i32, i32* %pos, align 4
  %idxprom49 = sext i32 %45 to i64
  %arrayidx50 = getelementptr inbounds i16, i16* %44, i64 %idxprom49
  store i16 %conv48, i16* %arrayidx50, align 2
  br label %for.inc51

for.inc51:                                        ; preds = %for.end
  %46 = load i32, i32* %r, align 4
  %inc52 = add nsw i32 %46, 1
  store i32 %inc52, i32* %r, align 4
  br label %for.cond

for.end53:                                        ; preds = %for.cond
  store i32 0, i32* %c, align 4
  br label %for.cond54

for.cond54:                                       ; preds = %for.inc102, %for.end53
  %47 = load i32, i32* %c, align 4
  %48 = load i32, i32* %cols.addr, align 4
  %cmp55 = icmp slt i32 %47, %48
  br i1 %cmp55, label %for.body57, label %for.end104

for.body57:                                       ; preds = %for.cond54
  %49 = load i32, i32* %c, align 4
  store i32 %49, i32* %pos, align 4
  %50 = load i16*, i16** %smoothedim.addr, align 8
  %51 = load i32, i32* %pos, align 4
  %52 = load i32, i32* %cols.addr, align 4
  %add58 = add nsw i32 %51, %52
  %idxprom59 = sext i32 %add58 to i64
  %arrayidx60 = getelementptr inbounds i16, i16* %50, i64 %idxprom59
  %53 = load i16, i16* %arrayidx60, align 2
  %conv61 = sext i16 %53 to i32
  %54 = load i16*, i16** %smoothedim.addr, align 8
  %55 = load i32, i32* %pos, align 4
  %idxprom62 = sext i32 %55 to i64
  %arrayidx63 = getelementptr inbounds i16, i16* %54, i64 %idxprom62
  %56 = load i16, i16* %arrayidx63, align 2
  %conv64 = sext i16 %56 to i32
  %sub65 = sub nsw i32 %conv61, %conv64
  %conv66 = trunc i32 %sub65 to i16
  %57 = load i16**, i16*** %delta_y.addr, align 8
  %58 = load i16*, i16** %57, align 8
  %59 = load i32, i32* %pos, align 4
  %idxprom67 = sext i32 %59 to i64
  %arrayidx68 = getelementptr inbounds i16, i16* %58, i64 %idxprom67
  store i16 %conv66, i16* %arrayidx68, align 2
  %60 = load i32, i32* %cols.addr, align 4
  %61 = load i32, i32* %pos, align 4
  %add69 = add nsw i32 %61, %60
  store i32 %add69, i32* %pos, align 4
  store i32 1, i32* %r, align 4
  br label %for.cond70

for.cond70:                                       ; preds = %for.inc87, %for.body57
  %62 = load i32, i32* %r, align 4
  %63 = load i32, i32* %rows.addr, align 4
  %sub71 = sub nsw i32 %63, 1
  %cmp72 = icmp slt i32 %62, %sub71
  br i1 %cmp72, label %for.body74, label %for.end90

for.body74:                                       ; preds = %for.cond70
  %64 = load i16*, i16** %smoothedim.addr, align 8
  %65 = load i32, i32* %pos, align 4
  %66 = load i32, i32* %cols.addr, align 4
  %add75 = add nsw i32 %65, %66
  %idxprom76 = sext i32 %add75 to i64
  %arrayidx77 = getelementptr inbounds i16, i16* %64, i64 %idxprom76
  %67 = load i16, i16* %arrayidx77, align 2
  %conv78 = sext i16 %67 to i32
  %68 = load i16*, i16** %smoothedim.addr, align 8
  %69 = load i32, i32* %pos, align 4
  %70 = load i32, i32* %cols.addr, align 4
  %sub79 = sub nsw i32 %69, %70
  %idxprom80 = sext i32 %sub79 to i64
  %arrayidx81 = getelementptr inbounds i16, i16* %68, i64 %idxprom80
  %71 = load i16, i16* %arrayidx81, align 2
  %conv82 = sext i16 %71 to i32
  %sub83 = sub nsw i32 %conv78, %conv82
  %conv84 = trunc i32 %sub83 to i16
  %72 = load i16**, i16*** %delta_y.addr, align 8
  %73 = load i16*, i16** %72, align 8
  %74 = load i32, i32* %pos, align 4
  %idxprom85 = sext i32 %74 to i64
  %arrayidx86 = getelementptr inbounds i16, i16* %73, i64 %idxprom85
  store i16 %conv84, i16* %arrayidx86, align 2
  br label %for.inc87

for.inc87:                                        ; preds = %for.body74
  %75 = load i32, i32* %r, align 4
  %inc88 = add nsw i32 %75, 1
  store i32 %inc88, i32* %r, align 4
  %76 = load i32, i32* %cols.addr, align 4
  %77 = load i32, i32* %pos, align 4
  %add89 = add nsw i32 %77, %76
  store i32 %add89, i32* %pos, align 4
  br label %for.cond70

for.end90:                                        ; preds = %for.cond70
  %78 = load i16*, i16** %smoothedim.addr, align 8
  %79 = load i32, i32* %pos, align 4
  %idxprom91 = sext i32 %79 to i64
  %arrayidx92 = getelementptr inbounds i16, i16* %78, i64 %idxprom91
  %80 = load i16, i16* %arrayidx92, align 2
  %conv93 = sext i16 %80 to i32
  %81 = load i16*, i16** %smoothedim.addr, align 8
  %82 = load i32, i32* %pos, align 4
  %83 = load i32, i32* %cols.addr, align 4
  %sub94 = sub nsw i32 %82, %83
  %idxprom95 = sext i32 %sub94 to i64
  %arrayidx96 = getelementptr inbounds i16, i16* %81, i64 %idxprom95
  %84 = load i16, i16* %arrayidx96, align 2
  %conv97 = sext i16 %84 to i32
  %sub98 = sub nsw i32 %conv93, %conv97
  %conv99 = trunc i32 %sub98 to i16
  %85 = load i16**, i16*** %delta_y.addr, align 8
  %86 = load i16*, i16** %85, align 8
  %87 = load i32, i32* %pos, align 4
  %idxprom100 = sext i32 %87 to i64
  %arrayidx101 = getelementptr inbounds i16, i16* %86, i64 %idxprom100
  store i16 %conv99, i16* %arrayidx101, align 2
  br label %for.inc102

for.inc102:                                       ; preds = %for.end90
  %88 = load i32, i32* %c, align 4
  %inc103 = add nsw i32 %88, 1
  store i32 %inc103, i32* %c, align 4
  br label %for.cond54

for.end104:                                       ; preds = %for.cond54
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @radian_direction(i16* %delta_x, i16* %delta_y, i32 %rows, i32 %cols, float** %dir_radians, i32 %xdirtag, i32 %ydirtag) #0 {
entry:
  %delta_x.addr = alloca i16*, align 8
  %delta_y.addr = alloca i16*, align 8
  %rows.addr = alloca i32, align 4
  %cols.addr = alloca i32, align 4
  %dir_radians.addr = alloca float**, align 8
  %xdirtag.addr = alloca i32, align 4
  %ydirtag.addr = alloca i32, align 4
  %r = alloca i32, align 4
  %c = alloca i32, align 4
  %pos = alloca i32, align 4
  %dirim = alloca float*, align 8
  %dx = alloca double, align 8
  %dy = alloca double, align 8
  store i16* %delta_x, i16** %delta_x.addr, align 8
  store i16* %delta_y, i16** %delta_y.addr, align 8
  store i32 %rows, i32* %rows.addr, align 4
  store i32 %cols, i32* %cols.addr, align 4
  store float** %dir_radians, float*** %dir_radians.addr, align 8
  store i32 %xdirtag, i32* %xdirtag.addr, align 4
  store i32 %ydirtag, i32* %ydirtag.addr, align 4
  store float* null, float** %dirim, align 8
  %0 = load i32, i32* %rows.addr, align 4
  %1 = load i32, i32* %cols.addr, align 4
  %mul = mul nsw i32 %0, %1
  %conv = sext i32 %mul to i64
  %llvm-call = call noalias i8* @calloc(i64 %conv, i64 4) #9
  %2 = bitcast i8* %llvm-call to float*
  store float* %2, float** %dirim, align 8
  %cmp = icmp eq float* %2, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %3 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call2 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %3, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.23, i32 0, i32 0))
  call void @exit(i32 1) #7
  unreachable

if.end:                                           ; preds = %entry
  %4 = load float*, float** %dirim, align 8
  %5 = load float**, float*** %dir_radians.addr, align 8
  store float* %4, float** %5, align 8
  store i32 0, i32* %r, align 4
  store i32 0, i32* %pos, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc27, %if.end
  %6 = load i32, i32* %r, align 4
  %7 = load i32, i32* %rows.addr, align 4
  %cmp3 = icmp slt i32 %6, %7
  br i1 %cmp3, label %for.body, label %for.end29

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %c, align 4
  br label %for.cond5

for.cond5:                                        ; preds = %for.inc, %for.body
  %8 = load i32, i32* %c, align 4
  %9 = load i32, i32* %cols.addr, align 4
  %cmp6 = icmp slt i32 %8, %9
  br i1 %cmp6, label %for.body8, label %for.end

for.body8:                                        ; preds = %for.cond5
  %10 = load i16*, i16** %delta_x.addr, align 8
  %11 = load i32, i32* %pos, align 4
  %idxprom = sext i32 %11 to i64
  %arrayidx = getelementptr inbounds i16, i16* %10, i64 %idxprom
  %12 = load i16, i16* %arrayidx, align 2
  %conv9 = sitofp i16 %12 to double
  store double %conv9, double* %dx, align 8
  %13 = load i16*, i16** %delta_y.addr, align 8
  %14 = load i32, i32* %pos, align 4
  %idxprom10 = sext i32 %14 to i64
  %arrayidx11 = getelementptr inbounds i16, i16* %13, i64 %idxprom10
  %15 = load i16, i16* %arrayidx11, align 2
  %conv12 = sitofp i16 %15 to double
  store double %conv12, double* %dy, align 8
  %16 = load i32, i32* %xdirtag.addr, align 4
  %cmp13 = icmp eq i32 %16, 1
  br i1 %cmp13, label %if.then15, label %if.end16

if.then15:                                        ; preds = %for.body8
  %17 = load double, double* %dx, align 8
  %sub = fsub double -0.000000e+00, %17
  store double %sub, double* %dx, align 8
  br label %if.end16

if.end16:                                         ; preds = %if.then15, %for.body8
  %18 = load i32, i32* %ydirtag.addr, align 4
  %cmp17 = icmp eq i32 %18, -1
  br i1 %cmp17, label %if.then19, label %if.end21

if.then19:                                        ; preds = %if.end16
  %19 = load double, double* %dy, align 8
  %sub20 = fsub double -0.000000e+00, %19
  store double %sub20, double* %dy, align 8
  br label %if.end21

if.end21:                                         ; preds = %if.then19, %if.end16
  %20 = load double, double* %dx, align 8
  %21 = load double, double* %dy, align 8
  %llvm-call22 = call double @angle_radians(double %20, double %21)
  %conv23 = fptrunc double %llvm-call22 to float
  %22 = load float*, float** %dirim, align 8
  %23 = load i32, i32* %pos, align 4
  %idxprom24 = sext i32 %23 to i64
  %arrayidx25 = getelementptr inbounds float, float* %22, i64 %idxprom24
  store float %conv23, float* %arrayidx25, align 4
  br label %for.inc

for.inc:                                          ; preds = %if.end21
  %24 = load i32, i32* %c, align 4
  %inc = add nsw i32 %24, 1
  store i32 %inc, i32* %c, align 4
  %25 = load i32, i32* %pos, align 4
  %inc26 = add nsw i32 %25, 1
  store i32 %inc26, i32* %pos, align 4
  br label %for.cond5

for.end:                                          ; preds = %for.cond5
  br label %for.inc27

for.inc27:                                        ; preds = %for.end
  %26 = load i32, i32* %r, align 4
  %inc28 = add nsw i32 %26, 1
  store i32 %inc28, i32* %r, align 4
  br label %for.cond

for.end29:                                        ; preds = %for.cond
  ret void
}

declare %struct._IO_FILE* @fopen(i8*, i8*) #1

declare i64 @fwrite(i8*, i64, i64, %struct._IO_FILE*) #1

declare i32 @fclose(%struct._IO_FILE*) #1

; Function Attrs: nounwind
declare void @free(i8*) #4

; Function Attrs: noinline nounwind optnone uwtable
define void @magnitude_x_y(i16* %delta_x, i16* %delta_y, i32 %rows, i32 %cols, i16** %magnitude) #0 {
entry:
  %delta_x.addr = alloca i16*, align 8
  %delta_y.addr = alloca i16*, align 8
  %rows.addr = alloca i32, align 4
  %cols.addr = alloca i32, align 4
  %magnitude.addr = alloca i16**, align 8
  %r = alloca i32, align 4
  %c = alloca i32, align 4
  %pos = alloca i32, align 4
  %sq1 = alloca i32, align 4
  %sq2 = alloca i32, align 4
  store i16* %delta_x, i16** %delta_x.addr, align 8
  store i16* %delta_y, i16** %delta_y.addr, align 8
  store i32 %rows, i32* %rows.addr, align 4
  store i32 %cols, i32* %cols.addr, align 4
  store i16** %magnitude, i16*** %magnitude.addr, align 8
  %0 = load i32, i32* %rows.addr, align 4
  %1 = load i32, i32* %cols.addr, align 4
  %mul = mul nsw i32 %0, %1
  %conv = sext i32 %mul to i64
  %llvm-call = call noalias i8* @calloc(i64 %conv, i64 2) #9
  %2 = bitcast i8* %llvm-call to i16*
  %3 = load i16**, i16*** %magnitude.addr, align 8
  store i16* %2, i16** %3, align 8
  %cmp = icmp eq i16* %2, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %4 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call2 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %4, i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.24, i32 0, i32 0))
  call void @exit(i32 1) #7
  unreachable

if.end:                                           ; preds = %entry
  store i32 0, i32* %r, align 4
  store i32 0, i32* %pos, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc30, %if.end
  %5 = load i32, i32* %r, align 4
  %6 = load i32, i32* %rows.addr, align 4
  %cmp3 = icmp slt i32 %5, %6
  br i1 %cmp3, label %for.body, label %for.end32

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %c, align 4
  br label %for.cond5

for.cond5:                                        ; preds = %for.inc, %for.body
  %7 = load i32, i32* %c, align 4
  %8 = load i32, i32* %cols.addr, align 4
  %cmp6 = icmp slt i32 %7, %8
  br i1 %cmp6, label %for.body8, label %for.end

for.body8:                                        ; preds = %for.cond5
  %9 = load i16*, i16** %delta_x.addr, align 8
  %10 = load i32, i32* %pos, align 4
  %idxprom = sext i32 %10 to i64
  %arrayidx = getelementptr inbounds i16, i16* %9, i64 %idxprom
  %11 = load i16, i16* %arrayidx, align 2
  %conv9 = sext i16 %11 to i32
  %12 = load i16*, i16** %delta_x.addr, align 8
  %13 = load i32, i32* %pos, align 4
  %idxprom10 = sext i32 %13 to i64
  %arrayidx11 = getelementptr inbounds i16, i16* %12, i64 %idxprom10
  %14 = load i16, i16* %arrayidx11, align 2
  %conv12 = sext i16 %14 to i32
  %mul13 = mul nsw i32 %conv9, %conv12
  store i32 %mul13, i32* %sq1, align 4
  %15 = load i16*, i16** %delta_y.addr, align 8
  %16 = load i32, i32* %pos, align 4
  %idxprom14 = sext i32 %16 to i64
  %arrayidx15 = getelementptr inbounds i16, i16* %15, i64 %idxprom14
  %17 = load i16, i16* %arrayidx15, align 2
  %conv16 = sext i16 %17 to i32
  %18 = load i16*, i16** %delta_y.addr, align 8
  %19 = load i32, i32* %pos, align 4
  %idxprom17 = sext i32 %19 to i64
  %arrayidx18 = getelementptr inbounds i16, i16* %18, i64 %idxprom17
  %20 = load i16, i16* %arrayidx18, align 2
  %conv19 = sext i16 %20 to i32
  %mul20 = mul nsw i32 %conv16, %conv19
  store i32 %mul20, i32* %sq2, align 4
  %21 = load i32, i32* %sq1, align 4
  %conv21 = sitofp i32 %21 to float
  %22 = load i32, i32* %sq2, align 4
  %conv22 = sitofp i32 %22 to float
  %add = fadd float %conv21, %conv22
  %conv23 = fpext float %add to double
  %llvm-call24 = call double @sqrt(double %conv23) #9
  %add25 = fadd double 5.000000e-01, %llvm-call24
  %conv26 = fptosi double %add25 to i16
  %23 = load i16**, i16*** %magnitude.addr, align 8
  %24 = load i16*, i16** %23, align 8
  %25 = load i32, i32* %pos, align 4
  %idxprom27 = sext i32 %25 to i64
  %arrayidx28 = getelementptr inbounds i16, i16* %24, i64 %idxprom27
  store i16 %conv26, i16* %arrayidx28, align 2
  br label %for.inc

for.inc:                                          ; preds = %for.body8
  %26 = load i32, i32* %c, align 4
  %inc = add nsw i32 %26, 1
  store i32 %inc, i32* %c, align 4
  %27 = load i32, i32* %pos, align 4
  %inc29 = add nsw i32 %27, 1
  store i32 %inc29, i32* %pos, align 4
  br label %for.cond5

for.end:                                          ; preds = %for.cond5
  br label %for.inc30

for.inc30:                                        ; preds = %for.end
  %28 = load i32, i32* %r, align 4
  %inc31 = add nsw i32 %28, 1
  store i32 %inc31, i32* %r, align 4
  br label %for.cond

for.end32:                                        ; preds = %for.cond
  ret void
}

; Function Attrs: nounwind
declare noalias i8* @calloc(i64, i64) #4

; Function Attrs: nounwind
declare double @sqrt(double) #4

; Function Attrs: noinline nounwind optnone uwtable
define double @angle_radians(double %x, double %y) #0 {
entry:
  %retval = alloca double, align 8
  %x.addr = alloca double, align 8
  %y.addr = alloca double, align 8
  %xu = alloca double, align 8
  %yu = alloca double, align 8
  %ang = alloca double, align 8
  store double %x, double* %x.addr, align 8
  store double %y, double* %y.addr, align 8
  %0 = load double, double* %x.addr, align 8
  %1 = call double @llvm.fabs.f64(double %0)
  store double %1, double* %xu, align 8
  %2 = load double, double* %y.addr, align 8
  %3 = call double @llvm.fabs.f64(double %2)
  store double %3, double* %yu, align 8
  %4 = load double, double* %xu, align 8
  %cmp = fcmp oeq double %4, 0.000000e+00
  br i1 %cmp, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %entry
  %5 = load double, double* %yu, align 8
  %cmp1 = fcmp oeq double %5, 0.000000e+00
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  store double 0.000000e+00, double* %retval, align 8
  br label %return

if.end:                                           ; preds = %land.lhs.true, %entry
  %6 = load double, double* %yu, align 8
  %7 = load double, double* %xu, align 8
  %div = fdiv double %6, %7
  %llvm-call = call double @atan(double %div) #9
  store double %llvm-call, double* %ang, align 8
  %8 = load double, double* %x.addr, align 8
  %cmp2 = fcmp oge double %8, 0.000000e+00
  br i1 %cmp2, label %if.then3, label %if.else6

if.then3:                                         ; preds = %if.end
  %9 = load double, double* %y.addr, align 8
  %cmp4 = fcmp oge double %9, 0.000000e+00
  br i1 %cmp4, label %if.then5, label %if.else

if.then5:                                         ; preds = %if.then3
  %10 = load double, double* %ang, align 8
  store double %10, double* %retval, align 8
  br label %return

if.else:                                          ; preds = %if.then3
  %11 = load double, double* %ang, align 8
  %sub = fsub double 0x401921FB54442D18, %11
  store double %sub, double* %retval, align 8
  br label %return

if.else6:                                         ; preds = %if.end
  %12 = load double, double* %y.addr, align 8
  %cmp7 = fcmp oge double %12, 0.000000e+00
  br i1 %cmp7, label %if.then8, label %if.else10

if.then8:                                         ; preds = %if.else6
  %13 = load double, double* %ang, align 8
  %sub9 = fsub double 0x400921FB54442D18, %13
  store double %sub9, double* %retval, align 8
  br label %return

if.else10:                                        ; preds = %if.else6
  %14 = load double, double* %ang, align 8
  %add = fadd double 0x400921FB54442D18, %14
  store double %add, double* %retval, align 8
  br label %return

return:                                           ; preds = %if.else10, %if.then8, %if.else, %if.then5, %if.then
  %15 = load double, double* %retval, align 8
  ret double %15
}

; Function Attrs: nounwind readnone speculatable
declare double @llvm.fabs.f64(double) #5

; Function Attrs: nounwind
declare double @atan(double) #4

; Function Attrs: noinline nounwind optnone uwtable
define void @make_gaussian_kernel(float %sigma, float** %kernel, i32* %windowsize) #0 {
entry:
  %sigma.addr = alloca float, align 4
  %kernel.addr = alloca float**, align 8
  %windowsize.addr = alloca i32*, align 8
  %i = alloca i32, align 4
  %center = alloca i32, align 4
  %x = alloca float, align 4
  %fx = alloca float, align 4
  %sum = alloca float, align 4
  store float %sigma, float* %sigma.addr, align 4
  store float** %kernel, float*** %kernel.addr, align 8
  store i32* %windowsize, i32** %windowsize.addr, align 8
  store float 0.000000e+00, float* %sum, align 4
  %0 = load float, float* %sigma.addr, align 4
  %conv = fpext float %0 to double
  %mul = fmul double 2.500000e+00, %conv
  %1 = call double @llvm.ceil.f64(double %mul)
  %mul1 = fmul double 2.000000e+00, %1
  %add = fadd double 1.000000e+00, %mul1
  %conv2 = fptosi double %add to i32
  %2 = load i32*, i32** %windowsize.addr, align 8
  store i32 %conv2, i32* %2, align 4
  %3 = load i32*, i32** %windowsize.addr, align 8
  %4 = load i32, i32* %3, align 4
  %div = sdiv i32 %4, 2
  store i32 %div, i32* %center, align 4
  %5 = load i32*, i32** %windowsize.addr, align 8
  %6 = load i32, i32* %5, align 4
  %conv3 = sext i32 %6 to i64
  %llvm-call = call noalias i8* @calloc(i64 %conv3, i64 4) #9
  %7 = bitcast i8* %llvm-call to float*
  %8 = load float**, float*** %kernel.addr, align 8
  store float* %7, float** %8, align 8
  %cmp = icmp eq float* %7, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %9 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call5 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %9, i8* getelementptr inbounds ([44 x i8], [44 x i8]* @.str.28, i32 0, i32 0))
  call void @exit(i32 1) #7
  unreachable

if.end:                                           ; preds = %entry
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end
  %10 = load i32, i32* %i, align 4
  %11 = load i32*, i32** %windowsize.addr, align 8
  %12 = load i32, i32* %11, align 4
  %cmp6 = icmp slt i32 %10, %12
  br i1 %cmp6, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %13 = load i32, i32* %i, align 4
  %14 = load i32, i32* %center, align 4
  %sub = sub nsw i32 %13, %14
  %conv8 = sitofp i32 %sub to float
  store float %conv8, float* %x, align 4
  %15 = load float, float* %x, align 4
  %conv9 = fpext float %15 to double
  %mul10 = fmul double -5.000000e-01, %conv9
  %16 = load float, float* %x, align 4
  %conv11 = fpext float %16 to double
  %mul12 = fmul double %mul10, %conv11
  %17 = load float, float* %sigma.addr, align 4
  %18 = load float, float* %sigma.addr, align 4
  %mul13 = fmul float %17, %18
  %conv14 = fpext float %mul13 to double
  %div15 = fdiv double %mul12, %conv14
  %llvm-call16 = call double @pow(double 2.718280e+00, double %div15) #9
  %19 = load float, float* %sigma.addr, align 4
  %conv17 = fpext float %19 to double
  %llvm-call18 = call double @sqrt(double 0x401921FB53C8D4F1) #9
  %mul19 = fmul double %conv17, %llvm-call18
  %div20 = fdiv double %llvm-call16, %mul19
  %conv21 = fptrunc double %div20 to float
  store float %conv21, float* %fx, align 4
  %20 = load float, float* %fx, align 4
  %21 = load float**, float*** %kernel.addr, align 8
  %22 = load float*, float** %21, align 8
  %23 = load i32, i32* %i, align 4
  %idxprom = sext i32 %23 to i64
  %arrayidx = getelementptr inbounds float, float* %22, i64 %idxprom
  store float %20, float* %arrayidx, align 4
  %24 = load float, float* %fx, align 4
  %25 = load float, float* %sum, align 4
  %add22 = fadd float %25, %24
  store float %add22, float* %sum, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %26 = load i32, i32* %i, align 4
  %inc = add nsw i32 %26, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  store i32 0, i32* %i, align 4
  br label %for.cond23

for.cond23:                                       ; preds = %for.inc30, %for.end
  %27 = load i32, i32* %i, align 4
  %28 = load i32*, i32** %windowsize.addr, align 8
  %29 = load i32, i32* %28, align 4
  %cmp24 = icmp slt i32 %27, %29
  br i1 %cmp24, label %for.body26, label %for.end32

for.body26:                                       ; preds = %for.cond23
  %30 = load float, float* %sum, align 4
  %31 = load float**, float*** %kernel.addr, align 8
  %32 = load float*, float** %31, align 8
  %33 = load i32, i32* %i, align 4
  %idxprom27 = sext i32 %33 to i64
  %arrayidx28 = getelementptr inbounds float, float* %32, i64 %idxprom27
  %34 = load float, float* %arrayidx28, align 4
  %div29 = fdiv float %34, %30
  store float %div29, float* %arrayidx28, align 4
  br label %for.inc30

for.inc30:                                        ; preds = %for.body26
  %35 = load i32, i32* %i, align 4
  %inc31 = add nsw i32 %35, 1
  store i32 %inc31, i32* %i, align 4
  br label %for.cond23

for.end32:                                        ; preds = %for.cond23
  ret void
}

; Function Attrs: nounwind readnone speculatable
declare double @llvm.ceil.f64(double) #5

; Function Attrs: nounwind
declare double @pow(double, double) #4

; Function Attrs: noinline nounwind optnone uwtable
define i32 @follow_edges(i8* %edgemapptr, i16* %edgemagptr, i16 signext %lowval, i32 %cols) #0 {
entry:
  %retval = alloca i32, align 4
  %edgemapptr.addr = alloca i8*, align 8
  %edgemagptr.addr = alloca i16*, align 8
  %lowval.addr = alloca i16, align 2
  %cols.addr = alloca i32, align 4
  %tempmagptr = alloca i16*, align 8
  %tempmapptr = alloca i8*, align 8
  %i = alloca i32, align 4
  %thethresh = alloca float, align 4
  %x = alloca [8 x i32], align 16
  %y = alloca [8 x i32], align 16
  store i8* %edgemapptr, i8** %edgemapptr.addr, align 8
  store i16* %edgemagptr, i16** %edgemagptr.addr, align 8
  store i16 %lowval, i16* %lowval.addr, align 2
  store i32 %cols, i32* %cols.addr, align 4
  %0 = bitcast [8 x i32]* %x to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* bitcast ([8 x i32]* @follow_edges.x to i8*), i64 32, i32 16, i1 false)
  %1 = bitcast [8 x i32]* %y to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* bitcast ([8 x i32]* @follow_edges.y to i8*), i64 32, i32 16, i1 false)
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %2, 8
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %3 = load i8*, i8** %edgemapptr.addr, align 8
  %4 = load i32, i32* %i, align 4
  %idxprom = sext i32 %4 to i64
  %arrayidx = getelementptr inbounds [8 x i32], [8 x i32]* %y, i64 0, i64 %idxprom
  %5 = load i32, i32* %arrayidx, align 4
  %6 = load i32, i32* %cols.addr, align 4
  %mul = mul nsw i32 %5, %6
  %idx.ext = sext i32 %mul to i64
  %idx.neg = sub i64 0, %idx.ext
  %add.ptr = getelementptr inbounds i8, i8* %3, i64 %idx.neg
  %7 = load i32, i32* %i, align 4
  %idxprom1 = sext i32 %7 to i64
  %arrayidx2 = getelementptr inbounds [8 x i32], [8 x i32]* %x, i64 0, i64 %idxprom1
  %8 = load i32, i32* %arrayidx2, align 4
  %idx.ext3 = sext i32 %8 to i64
  %add.ptr4 = getelementptr inbounds i8, i8* %add.ptr, i64 %idx.ext3
  store i8* %add.ptr4, i8** %tempmapptr, align 8
  %9 = load i16*, i16** %edgemagptr.addr, align 8
  %10 = load i32, i32* %i, align 4
  %idxprom5 = sext i32 %10 to i64
  %arrayidx6 = getelementptr inbounds [8 x i32], [8 x i32]* %y, i64 0, i64 %idxprom5
  %11 = load i32, i32* %arrayidx6, align 4
  %12 = load i32, i32* %cols.addr, align 4
  %mul7 = mul nsw i32 %11, %12
  %idx.ext8 = sext i32 %mul7 to i64
  %idx.neg9 = sub i64 0, %idx.ext8
  %add.ptr10 = getelementptr inbounds i16, i16* %9, i64 %idx.neg9
  %13 = load i32, i32* %i, align 4
  %idxprom11 = sext i32 %13 to i64
  %arrayidx12 = getelementptr inbounds [8 x i32], [8 x i32]* %x, i64 0, i64 %idxprom11
  %14 = load i32, i32* %arrayidx12, align 4
  %idx.ext13 = sext i32 %14 to i64
  %add.ptr14 = getelementptr inbounds i16, i16* %add.ptr10, i64 %idx.ext13
  store i16* %add.ptr14, i16** %tempmagptr, align 8
  %15 = load i8*, i8** %tempmapptr, align 8
  %16 = load i8, i8* %15, align 1
  %conv = zext i8 %16 to i32
  %cmp15 = icmp eq i32 %conv, 128
  br i1 %cmp15, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %for.body
  %17 = load i16*, i16** %tempmagptr, align 8
  %18 = load i16, i16* %17, align 2
  %conv17 = sext i16 %18 to i32
  %19 = load i16, i16* %lowval.addr, align 2
  %conv18 = sext i16 %19 to i32
  %cmp19 = icmp sgt i32 %conv17, %conv18
  br i1 %cmp19, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  %20 = load i8*, i8** %tempmapptr, align 8
  store i8 0, i8* %20, align 1
  %21 = load i8*, i8** %tempmapptr, align 8
  %22 = load i16*, i16** %tempmagptr, align 8
  %23 = load i16, i16* %lowval.addr, align 2
  %24 = load i32, i32* %cols.addr, align 4
  %llvm-call = call i32 @follow_edges(i8* %21, i16* %22, i16 signext %23, i32 %24)
  br label %if.end

if.end:                                           ; preds = %if.then, %land.lhs.true, %for.body
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %25 = load i32, i32* %i, align 4
  %inc = add nsw i32 %25, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %26 = load i32, i32* %retval, align 4
  ret i32 %26
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #6

; Function Attrs: noinline nounwind optnone uwtable
define void @apply_hysteresis(i16* %mag, i8* %nms, i32 %rows, i32 %cols, float %tlow, float %thigh, i8* %edge) #0 {
entry:
  %mag.addr = alloca i16*, align 8
  %nms.addr = alloca i8*, align 8
  %rows.addr = alloca i32, align 4
  %cols.addr = alloca i32, align 4
  %tlow.addr = alloca float, align 4
  %thigh.addr = alloca float, align 4
  %edge.addr = alloca i8*, align 8
  %r = alloca i32, align 4
  %c = alloca i32, align 4
  %pos = alloca i32, align 4
  %numedges = alloca i32, align 4
  %lowcount = alloca i32, align 4
  %highcount = alloca i32, align 4
  %lowthreshold = alloca i32, align 4
  %highthreshold = alloca i32, align 4
  %i = alloca i32, align 4
  %hist = alloca [32768 x i32], align 16
  %rr = alloca i32, align 4
  %cc = alloca i32, align 4
  %maximum_mag = alloca i16, align 2
  %sumpix = alloca i16, align 2
  store i16* %mag, i16** %mag.addr, align 8
  store i8* %nms, i8** %nms.addr, align 8
  store i32 %rows, i32* %rows.addr, align 4
  store i32 %cols, i32* %cols.addr, align 4
  store float %tlow, float* %tlow.addr, align 4
  store float %thigh, float* %thigh.addr, align 4
  store i8* %edge, i8** %edge.addr, align 8
  store i32 0, i32* %r, align 4
  store i32 0, i32* %pos, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc11, %entry
  %0 = load i32, i32* %r, align 4
  %1 = load i32, i32* %rows.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end13

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %c, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %2 = load i32, i32* %c, align 4
  %3 = load i32, i32* %cols.addr, align 4
  %cmp2 = icmp slt i32 %2, %3
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %4 = load i8*, i8** %nms.addr, align 8
  %5 = load i32, i32* %pos, align 4
  %idxprom = sext i32 %5 to i64
  %arrayidx = getelementptr inbounds i8, i8* %4, i64 %idxprom
  %6 = load i8, i8* %arrayidx, align 1
  %conv = zext i8 %6 to i32
  %cmp4 = icmp eq i32 %conv, 128
  br i1 %cmp4, label %if.then, label %if.else

if.then:                                          ; preds = %for.body3
  %7 = load i8*, i8** %edge.addr, align 8
  %8 = load i32, i32* %pos, align 4
  %idxprom6 = sext i32 %8 to i64
  %arrayidx7 = getelementptr inbounds i8, i8* %7, i64 %idxprom6
  store i8 -128, i8* %arrayidx7, align 1
  br label %if.end

if.else:                                          ; preds = %for.body3
  %9 = load i8*, i8** %edge.addr, align 8
  %10 = load i32, i32* %pos, align 4
  %idxprom8 = sext i32 %10 to i64
  %arrayidx9 = getelementptr inbounds i8, i8* %9, i64 %idxprom8
  store i8 -1, i8* %arrayidx9, align 1
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %11 = load i32, i32* %c, align 4
  %inc = add nsw i32 %11, 1
  store i32 %inc, i32* %c, align 4
  %12 = load i32, i32* %pos, align 4
  %inc10 = add nsw i32 %12, 1
  store i32 %inc10, i32* %pos, align 4
  br label %for.cond1

for.end:                                          ; preds = %for.cond1
  br label %for.inc11

for.inc11:                                        ; preds = %for.end
  %13 = load i32, i32* %r, align 4
  %inc12 = add nsw i32 %13, 1
  store i32 %inc12, i32* %r, align 4
  br label %for.cond

for.end13:                                        ; preds = %for.cond
  store i32 0, i32* %r, align 4
  store i32 0, i32* %pos, align 4
  br label %for.cond14

for.cond14:                                       ; preds = %for.inc22, %for.end13
  %14 = load i32, i32* %r, align 4
  %15 = load i32, i32* %rows.addr, align 4
  %cmp15 = icmp slt i32 %14, %15
  br i1 %cmp15, label %for.body17, label %for.end25

for.body17:                                       ; preds = %for.cond14
  %16 = load i8*, i8** %edge.addr, align 8
  %17 = load i32, i32* %pos, align 4
  %idxprom18 = sext i32 %17 to i64
  %arrayidx19 = getelementptr inbounds i8, i8* %16, i64 %idxprom18
  store i8 -1, i8* %arrayidx19, align 1
  %18 = load i8*, i8** %edge.addr, align 8
  %19 = load i32, i32* %pos, align 4
  %20 = load i32, i32* %cols.addr, align 4
  %add = add nsw i32 %19, %20
  %sub = sub nsw i32 %add, 1
  %idxprom20 = sext i32 %sub to i64
  %arrayidx21 = getelementptr inbounds i8, i8* %18, i64 %idxprom20
  store i8 -1, i8* %arrayidx21, align 1
  br label %for.inc22

for.inc22:                                        ; preds = %for.body17
  %21 = load i32, i32* %r, align 4
  %inc23 = add nsw i32 %21, 1
  store i32 %inc23, i32* %r, align 4
  %22 = load i32, i32* %cols.addr, align 4
  %23 = load i32, i32* %pos, align 4
  %add24 = add nsw i32 %23, %22
  store i32 %add24, i32* %pos, align 4
  br label %for.cond14

for.end25:                                        ; preds = %for.cond14
  %24 = load i32, i32* %rows.addr, align 4
  %sub26 = sub nsw i32 %24, 1
  %25 = load i32, i32* %cols.addr, align 4
  %mul = mul nsw i32 %sub26, %25
  store i32 %mul, i32* %pos, align 4
  store i32 0, i32* %c, align 4
  br label %for.cond27

for.cond27:                                       ; preds = %for.inc35, %for.end25
  %26 = load i32, i32* %c, align 4
  %27 = load i32, i32* %cols.addr, align 4
  %cmp28 = icmp slt i32 %26, %27
  br i1 %cmp28, label %for.body30, label %for.end38

for.body30:                                       ; preds = %for.cond27
  %28 = load i8*, i8** %edge.addr, align 8
  %29 = load i32, i32* %c, align 4
  %idxprom31 = sext i32 %29 to i64
  %arrayidx32 = getelementptr inbounds i8, i8* %28, i64 %idxprom31
  store i8 -1, i8* %arrayidx32, align 1
  %30 = load i8*, i8** %edge.addr, align 8
  %31 = load i32, i32* %pos, align 4
  %idxprom33 = sext i32 %31 to i64
  %arrayidx34 = getelementptr inbounds i8, i8* %30, i64 %idxprom33
  store i8 -1, i8* %arrayidx34, align 1
  br label %for.inc35

for.inc35:                                        ; preds = %for.body30
  %32 = load i32, i32* %c, align 4
  %inc36 = add nsw i32 %32, 1
  store i32 %inc36, i32* %c, align 4
  %33 = load i32, i32* %pos, align 4
  %inc37 = add nsw i32 %33, 1
  store i32 %inc37, i32* %pos, align 4
  br label %for.cond27

for.end38:                                        ; preds = %for.cond27
  store i32 0, i32* %r, align 4
  br label %for.cond39

for.cond39:                                       ; preds = %for.inc45, %for.end38
  %34 = load i32, i32* %r, align 4
  %cmp40 = icmp slt i32 %34, 32768
  br i1 %cmp40, label %for.body42, label %for.end47

for.body42:                                       ; preds = %for.cond39
  %35 = load i32, i32* %r, align 4
  %idxprom43 = sext i32 %35 to i64
  %arrayidx44 = getelementptr inbounds [32768 x i32], [32768 x i32]* %hist, i64 0, i64 %idxprom43
  store i32 0, i32* %arrayidx44, align 4
  br label %for.inc45

for.inc45:                                        ; preds = %for.body42
  %36 = load i32, i32* %r, align 4
  %inc46 = add nsw i32 %36, 1
  store i32 %inc46, i32* %r, align 4
  br label %for.cond39

for.end47:                                        ; preds = %for.cond39
  store i32 0, i32* %r, align 4
  store i32 0, i32* %pos, align 4
  br label %for.cond48

for.cond48:                                       ; preds = %for.inc72, %for.end47
  %37 = load i32, i32* %r, align 4
  %38 = load i32, i32* %rows.addr, align 4
  %cmp49 = icmp slt i32 %37, %38
  br i1 %cmp49, label %for.body51, label %for.end74

for.body51:                                       ; preds = %for.cond48
  store i32 0, i32* %c, align 4
  br label %for.cond52

for.cond52:                                       ; preds = %for.inc68, %for.body51
  %39 = load i32, i32* %c, align 4
  %40 = load i32, i32* %cols.addr, align 4
  %cmp53 = icmp slt i32 %39, %40
  br i1 %cmp53, label %for.body55, label %for.end71

for.body55:                                       ; preds = %for.cond52
  %41 = load i8*, i8** %edge.addr, align 8
  %42 = load i32, i32* %pos, align 4
  %idxprom56 = sext i32 %42 to i64
  %arrayidx57 = getelementptr inbounds i8, i8* %41, i64 %idxprom56
  %43 = load i8, i8* %arrayidx57, align 1
  %conv58 = zext i8 %43 to i32
  %cmp59 = icmp eq i32 %conv58, 128
  br i1 %cmp59, label %if.then61, label %if.end67

if.then61:                                        ; preds = %for.body55
  %44 = load i16*, i16** %mag.addr, align 8
  %45 = load i32, i32* %pos, align 4
  %idxprom62 = sext i32 %45 to i64
  %arrayidx63 = getelementptr inbounds i16, i16* %44, i64 %idxprom62
  %46 = load i16, i16* %arrayidx63, align 2
  %idxprom64 = sext i16 %46 to i64
  %arrayidx65 = getelementptr inbounds [32768 x i32], [32768 x i32]* %hist, i64 0, i64 %idxprom64
  %47 = load i32, i32* %arrayidx65, align 4
  %inc66 = add nsw i32 %47, 1
  store i32 %inc66, i32* %arrayidx65, align 4
  br label %if.end67

if.end67:                                         ; preds = %if.then61, %for.body55
  br label %for.inc68

for.inc68:                                        ; preds = %if.end67
  %48 = load i32, i32* %c, align 4
  %inc69 = add nsw i32 %48, 1
  store i32 %inc69, i32* %c, align 4
  %49 = load i32, i32* %pos, align 4
  %inc70 = add nsw i32 %49, 1
  store i32 %inc70, i32* %pos, align 4
  br label %for.cond52

for.end71:                                        ; preds = %for.cond52
  br label %for.inc72

for.inc72:                                        ; preds = %for.end71
  %50 = load i32, i32* %r, align 4
  %inc73 = add nsw i32 %50, 1
  store i32 %inc73, i32* %r, align 4
  br label %for.cond48

for.end74:                                        ; preds = %for.cond48
  store i32 1, i32* %r, align 4
  store i32 0, i32* %numedges, align 4
  br label %for.cond75

for.cond75:                                       ; preds = %for.inc89, %for.end74
  %51 = load i32, i32* %r, align 4
  %cmp76 = icmp slt i32 %51, 32768
  br i1 %cmp76, label %for.body78, label %for.end91

for.body78:                                       ; preds = %for.cond75
  %52 = load i32, i32* %r, align 4
  %idxprom79 = sext i32 %52 to i64
  %arrayidx80 = getelementptr inbounds [32768 x i32], [32768 x i32]* %hist, i64 0, i64 %idxprom79
  %53 = load i32, i32* %arrayidx80, align 4
  %cmp81 = icmp ne i32 %53, 0
  br i1 %cmp81, label %if.then83, label %if.end85

if.then83:                                        ; preds = %for.body78
  %54 = load i32, i32* %r, align 4
  %conv84 = trunc i32 %54 to i16
  store i16 %conv84, i16* %maximum_mag, align 2
  br label %if.end85

if.end85:                                         ; preds = %if.then83, %for.body78
  %55 = load i32, i32* %r, align 4
  %idxprom86 = sext i32 %55 to i64
  %arrayidx87 = getelementptr inbounds [32768 x i32], [32768 x i32]* %hist, i64 0, i64 %idxprom86
  %56 = load i32, i32* %arrayidx87, align 4
  %57 = load i32, i32* %numedges, align 4
  %add88 = add nsw i32 %57, %56
  store i32 %add88, i32* %numedges, align 4
  br label %for.inc89

for.inc89:                                        ; preds = %if.end85
  %58 = load i32, i32* %r, align 4
  %inc90 = add nsw i32 %58, 1
  store i32 %inc90, i32* %r, align 4
  br label %for.cond75

for.end91:                                        ; preds = %for.cond75
  %59 = load i32, i32* %numedges, align 4
  %conv92 = sitofp i32 %59 to float
  %60 = load float, float* %thigh.addr, align 4
  %mul93 = fmul float %conv92, %60
  %conv94 = fpext float %mul93 to double
  %add95 = fadd double %conv94, 5.000000e-01
  %conv96 = fptosi double %add95 to i32
  store i32 %conv96, i32* %highcount, align 4
  store i32 1, i32* %r, align 4
  %arrayidx97 = getelementptr inbounds [32768 x i32], [32768 x i32]* %hist, i64 0, i64 1
  %61 = load i32, i32* %arrayidx97, align 4
  store i32 %61, i32* %numedges, align 4
  br label %while.cond

while.cond:                                       ; preds = %while.body, %for.end91
  %62 = load i32, i32* %r, align 4
  %63 = load i16, i16* %maximum_mag, align 2
  %conv98 = sext i16 %63 to i32
  %sub99 = sub nsw i32 %conv98, 1
  %cmp100 = icmp slt i32 %62, %sub99
  br i1 %cmp100, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %while.cond
  %64 = load i32, i32* %numedges, align 4
  %65 = load i32, i32* %highcount, align 4
  %cmp102 = icmp slt i32 %64, %65
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.cond
  %66 = phi i1 [ false, %while.cond ], [ %cmp102, %land.rhs ]
  br i1 %66, label %while.body, label %while.end

while.body:                                       ; preds = %land.end
  %67 = load i32, i32* %r, align 4
  %inc104 = add nsw i32 %67, 1
  store i32 %inc104, i32* %r, align 4
  %68 = load i32, i32* %r, align 4
  %idxprom105 = sext i32 %68 to i64
  %arrayidx106 = getelementptr inbounds [32768 x i32], [32768 x i32]* %hist, i64 0, i64 %idxprom105
  %69 = load i32, i32* %arrayidx106, align 4
  %70 = load i32, i32* %numedges, align 4
  %add107 = add nsw i32 %70, %69
  store i32 %add107, i32* %numedges, align 4
  br label %while.cond

while.end:                                        ; preds = %land.end
  %71 = load i32, i32* %r, align 4
  store i32 %71, i32* %highthreshold, align 4
  %72 = load i32, i32* %highthreshold, align 4
  %conv108 = sitofp i32 %72 to float
  %73 = load float, float* %tlow.addr, align 4
  %mul109 = fmul float %conv108, %73
  %conv110 = fpext float %mul109 to double
  %add111 = fadd double %conv110, 5.000000e-01
  %conv112 = fptosi double %add111 to i32
  store i32 %conv112, i32* %lowthreshold, align 4
  store i32 0, i32* %r, align 4
  store i32 0, i32* %pos, align 4
  br label %for.cond113

for.cond113:                                      ; preds = %for.inc142, %while.end
  %74 = load i32, i32* %r, align 4
  %75 = load i32, i32* %rows.addr, align 4
  %cmp114 = icmp slt i32 %74, %75
  br i1 %cmp114, label %for.body116, label %for.end144

for.body116:                                      ; preds = %for.cond113
  store i32 0, i32* %c, align 4
  br label %for.cond117

for.cond117:                                      ; preds = %for.inc138, %for.body116
  %76 = load i32, i32* %c, align 4
  %77 = load i32, i32* %cols.addr, align 4
  %cmp118 = icmp slt i32 %76, %77
  br i1 %cmp118, label %for.body120, label %for.end141

for.body120:                                      ; preds = %for.cond117
  %78 = load i8*, i8** %edge.addr, align 8
  %79 = load i32, i32* %pos, align 4
  %idxprom121 = sext i32 %79 to i64
  %arrayidx122 = getelementptr inbounds i8, i8* %78, i64 %idxprom121
  %80 = load i8, i8* %arrayidx122, align 1
  %conv123 = zext i8 %80 to i32
  %cmp124 = icmp eq i32 %conv123, 128
  br i1 %cmp124, label %land.lhs.true, label %if.end137

land.lhs.true:                                    ; preds = %for.body120
  %81 = load i16*, i16** %mag.addr, align 8
  %82 = load i32, i32* %pos, align 4
  %idxprom126 = sext i32 %82 to i64
  %arrayidx127 = getelementptr inbounds i16, i16* %81, i64 %idxprom126
  %83 = load i16, i16* %arrayidx127, align 2
  %conv128 = sext i16 %83 to i32
  %84 = load i32, i32* %highthreshold, align 4
  %cmp129 = icmp sge i32 %conv128, %84
  br i1 %cmp129, label %if.then131, label %if.end137

if.then131:                                       ; preds = %land.lhs.true
  %85 = load i8*, i8** %edge.addr, align 8
  %86 = load i32, i32* %pos, align 4
  %idxprom132 = sext i32 %86 to i64
  %arrayidx133 = getelementptr inbounds i8, i8* %85, i64 %idxprom132
  store i8 0, i8* %arrayidx133, align 1
  %87 = load i8*, i8** %edge.addr, align 8
  %88 = load i32, i32* %pos, align 4
  %idx.ext = sext i32 %88 to i64
  %add.ptr = getelementptr inbounds i8, i8* %87, i64 %idx.ext
  %89 = load i16*, i16** %mag.addr, align 8
  %90 = load i32, i32* %pos, align 4
  %idx.ext134 = sext i32 %90 to i64
  %add.ptr135 = getelementptr inbounds i16, i16* %89, i64 %idx.ext134
  %91 = load i32, i32* %lowthreshold, align 4
  %conv136 = trunc i32 %91 to i16
  %92 = load i32, i32* %cols.addr, align 4
  %llvm-call = call i32 @follow_edges(i8* %add.ptr, i16* %add.ptr135, i16 signext %conv136, i32 %92)
  br label %if.end137

if.end137:                                        ; preds = %if.then131, %land.lhs.true, %for.body120
  br label %for.inc138

for.inc138:                                       ; preds = %if.end137
  %93 = load i32, i32* %c, align 4
  %inc139 = add nsw i32 %93, 1
  store i32 %inc139, i32* %c, align 4
  %94 = load i32, i32* %pos, align 4
  %inc140 = add nsw i32 %94, 1
  store i32 %inc140, i32* %pos, align 4
  br label %for.cond117

for.end141:                                       ; preds = %for.cond117
  br label %for.inc142

for.inc142:                                       ; preds = %for.end141
  %95 = load i32, i32* %r, align 4
  %inc143 = add nsw i32 %95, 1
  store i32 %inc143, i32* %r, align 4
  br label %for.cond113

for.end144:                                       ; preds = %for.cond113
  store i32 0, i32* %r, align 4
  store i32 0, i32* %pos, align 4
  br label %for.cond145

for.cond145:                                      ; preds = %for.inc166, %for.end144
  %96 = load i32, i32* %r, align 4
  %97 = load i32, i32* %rows.addr, align 4
  %cmp146 = icmp slt i32 %96, %97
  br i1 %cmp146, label %for.body148, label %for.end168

for.body148:                                      ; preds = %for.cond145
  store i32 0, i32* %c, align 4
  br label %for.cond149

for.cond149:                                      ; preds = %for.inc162, %for.body148
  %98 = load i32, i32* %c, align 4
  %99 = load i32, i32* %cols.addr, align 4
  %cmp150 = icmp slt i32 %98, %99
  br i1 %cmp150, label %for.body152, label %for.end165

for.body152:                                      ; preds = %for.cond149
  %100 = load i8*, i8** %edge.addr, align 8
  %101 = load i32, i32* %pos, align 4
  %idxprom153 = sext i32 %101 to i64
  %arrayidx154 = getelementptr inbounds i8, i8* %100, i64 %idxprom153
  %102 = load i8, i8* %arrayidx154, align 1
  %conv155 = zext i8 %102 to i32
  %cmp156 = icmp ne i32 %conv155, 0
  br i1 %cmp156, label %if.then158, label %if.end161

if.then158:                                       ; preds = %for.body152
  %103 = load i8*, i8** %edge.addr, align 8
  %104 = load i32, i32* %pos, align 4
  %idxprom159 = sext i32 %104 to i64
  %arrayidx160 = getelementptr inbounds i8, i8* %103, i64 %idxprom159
  store i8 -1, i8* %arrayidx160, align 1
  br label %if.end161

if.end161:                                        ; preds = %if.then158, %for.body152
  br label %for.inc162

for.inc162:                                       ; preds = %if.end161
  %105 = load i32, i32* %c, align 4
  %inc163 = add nsw i32 %105, 1
  store i32 %inc163, i32* %c, align 4
  %106 = load i32, i32* %pos, align 4
  %inc164 = add nsw i32 %106, 1
  store i32 %inc164, i32* %pos, align 4
  br label %for.cond149

for.end165:                                       ; preds = %for.cond149
  br label %for.inc166

for.inc166:                                       ; preds = %for.end165
  %107 = load i32, i32* %r, align 4
  %inc167 = add nsw i32 %107, 1
  store i32 %inc167, i32* %r, align 4
  br label %for.cond145

for.end168:                                       ; preds = %for.cond145
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @non_max_supp(i16* %mag, i16* %gradx, i16* %grady, i32 %nrows, i32 %ncols, i8* %result) #0 {
entry:
  %retval = alloca i32, align 4
  %mag.addr = alloca i16*, align 8
  %gradx.addr = alloca i16*, align 8
  %grady.addr = alloca i16*, align 8
  %nrows.addr = alloca i32, align 4
  %ncols.addr = alloca i32, align 4
  %result.addr = alloca i8*, align 8
  %rowcount = alloca i32, align 4
  %colcount = alloca i32, align 4
  %count = alloca i32, align 4
  %magrowptr = alloca i16*, align 8
  %magptr = alloca i16*, align 8
  %gxrowptr = alloca i16*, align 8
  %gxptr = alloca i16*, align 8
  %gyrowptr = alloca i16*, align 8
  %gyptr = alloca i16*, align 8
  %z1 = alloca i16, align 2
  %z2 = alloca i16, align 2
  %m00 = alloca i16, align 2
  %gx = alloca i16, align 2
  %gy = alloca i16, align 2
  %mag1 = alloca float, align 4
  %mag2 = alloca float, align 4
  %xperp = alloca float, align 4
  %yperp = alloca float, align 4
  %resultrowptr = alloca i8*, align 8
  %resultptr = alloca i8*, align 8
  store i16* %mag, i16** %mag.addr, align 8
  store i16* %gradx, i16** %gradx.addr, align 8
  store i16* %grady, i16** %grady.addr, align 8
  store i32 %nrows, i32* %nrows.addr, align 4
  store i32 %ncols, i32* %ncols.addr, align 4
  store i8* %result, i8** %result.addr, align 8
  store i32 0, i32* %count, align 4
  %0 = load i8*, i8** %result.addr, align 8
  store i8* %0, i8** %resultrowptr, align 8
  %1 = load i8*, i8** %result.addr, align 8
  %2 = load i32, i32* %ncols.addr, align 4
  %3 = load i32, i32* %nrows.addr, align 4
  %sub = sub nsw i32 %3, 1
  %mul = mul nsw i32 %2, %sub
  %idx.ext = sext i32 %mul to i64
  %add.ptr = getelementptr inbounds i8, i8* %1, i64 %idx.ext
  store i8* %add.ptr, i8** %resultptr, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %4 = load i32, i32* %count, align 4
  %5 = load i32, i32* %ncols.addr, align 4
  %cmp = icmp slt i32 %4, %5
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %6 = load i8*, i8** %resultptr, align 8
  store i8 0, i8* %6, align 1
  %7 = load i8*, i8** %resultrowptr, align 8
  store i8 0, i8* %7, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %8 = load i8*, i8** %resultptr, align 8
  %incdec.ptr = getelementptr inbounds i8, i8* %8, i32 1
  store i8* %incdec.ptr, i8** %resultptr, align 8
  %9 = load i8*, i8** %resultrowptr, align 8
  %incdec.ptr1 = getelementptr inbounds i8, i8* %9, i32 1
  store i8* %incdec.ptr1, i8** %resultrowptr, align 8
  %10 = load i32, i32* %count, align 4
  %inc = add nsw i32 %10, 1
  store i32 %inc, i32* %count, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  store i32 0, i32* %count, align 4
  %11 = load i8*, i8** %result.addr, align 8
  store i8* %11, i8** %resultptr, align 8
  %12 = load i8*, i8** %result.addr, align 8
  %13 = load i32, i32* %ncols.addr, align 4
  %idx.ext2 = sext i32 %13 to i64
  %add.ptr3 = getelementptr inbounds i8, i8* %12, i64 %idx.ext2
  %add.ptr4 = getelementptr inbounds i8, i8* %add.ptr3, i64 -1
  store i8* %add.ptr4, i8** %resultrowptr, align 8
  br label %for.cond5

for.cond5:                                        ; preds = %for.inc8, %for.end
  %14 = load i32, i32* %count, align 4
  %15 = load i32, i32* %nrows.addr, align 4
  %cmp6 = icmp slt i32 %14, %15
  br i1 %cmp6, label %for.body7, label %for.end14

for.body7:                                        ; preds = %for.cond5
  %16 = load i8*, i8** %resultrowptr, align 8
  store i8 0, i8* %16, align 1
  %17 = load i8*, i8** %resultptr, align 8
  store i8 0, i8* %17, align 1
  br label %for.inc8

for.inc8:                                         ; preds = %for.body7
  %18 = load i32, i32* %count, align 4
  %inc9 = add nsw i32 %18, 1
  store i32 %inc9, i32* %count, align 4
  %19 = load i32, i32* %ncols.addr, align 4
  %20 = load i8*, i8** %resultptr, align 8
  %idx.ext10 = sext i32 %19 to i64
  %add.ptr11 = getelementptr inbounds i8, i8* %20, i64 %idx.ext10
  store i8* %add.ptr11, i8** %resultptr, align 8
  %21 = load i32, i32* %ncols.addr, align 4
  %22 = load i8*, i8** %resultrowptr, align 8
  %idx.ext12 = sext i32 %21 to i64
  %add.ptr13 = getelementptr inbounds i8, i8* %22, i64 %idx.ext12
  store i8* %add.ptr13, i8** %resultrowptr, align 8
  br label %for.cond5

for.end14:                                        ; preds = %for.cond5
  store i32 1, i32* %rowcount, align 4
  %23 = load i16*, i16** %mag.addr, align 8
  %24 = load i32, i32* %ncols.addr, align 4
  %idx.ext15 = sext i32 %24 to i64
  %add.ptr16 = getelementptr inbounds i16, i16* %23, i64 %idx.ext15
  %add.ptr17 = getelementptr inbounds i16, i16* %add.ptr16, i64 1
  store i16* %add.ptr17, i16** %magrowptr, align 8
  %25 = load i16*, i16** %gradx.addr, align 8
  %26 = load i32, i32* %ncols.addr, align 4
  %idx.ext18 = sext i32 %26 to i64
  %add.ptr19 = getelementptr inbounds i16, i16* %25, i64 %idx.ext18
  %add.ptr20 = getelementptr inbounds i16, i16* %add.ptr19, i64 1
  store i16* %add.ptr20, i16** %gxrowptr, align 8
  %27 = load i16*, i16** %grady.addr, align 8
  %28 = load i32, i32* %ncols.addr, align 4
  %idx.ext21 = sext i32 %28 to i64
  %add.ptr22 = getelementptr inbounds i16, i16* %27, i64 %idx.ext21
  %add.ptr23 = getelementptr inbounds i16, i16* %add.ptr22, i64 1
  store i16* %add.ptr23, i16** %gyrowptr, align 8
  %29 = load i8*, i8** %result.addr, align 8
  %30 = load i32, i32* %ncols.addr, align 4
  %idx.ext24 = sext i32 %30 to i64
  %add.ptr25 = getelementptr inbounds i8, i8* %29, i64 %idx.ext24
  %add.ptr26 = getelementptr inbounds i8, i8* %add.ptr25, i64 1
  store i8* %add.ptr26, i8** %resultrowptr, align 8
  br label %for.cond27

for.cond27:                                       ; preds = %for.inc375, %for.end14
  %31 = load i32, i32* %rowcount, align 4
  %32 = load i32, i32* %nrows.addr, align 4
  %sub28 = sub nsw i32 %32, 2
  %cmp29 = icmp slt i32 %31, %sub28
  br i1 %cmp29, label %for.body30, label %for.end385

for.body30:                                       ; preds = %for.cond27
  store i32 1, i32* %colcount, align 4
  %33 = load i16*, i16** %magrowptr, align 8
  store i16* %33, i16** %magptr, align 8
  %34 = load i16*, i16** %gxrowptr, align 8
  store i16* %34, i16** %gxptr, align 8
  %35 = load i16*, i16** %gyrowptr, align 8
  store i16* %35, i16** %gyptr, align 8
  %36 = load i8*, i8** %resultrowptr, align 8
  store i8* %36, i8** %resultptr, align 8
  br label %for.cond31

for.cond31:                                       ; preds = %for.inc368, %for.body30
  %37 = load i32, i32* %colcount, align 4
  %38 = load i32, i32* %ncols.addr, align 4
  %sub32 = sub nsw i32 %38, 2
  %cmp33 = icmp slt i32 %37, %sub32
  br i1 %cmp33, label %for.body34, label %for.end374

for.body34:                                       ; preds = %for.cond31
  %39 = load i16*, i16** %magptr, align 8
  %40 = load i16, i16* %39, align 2
  store i16 %40, i16* %m00, align 2
  %41 = load i16, i16* %m00, align 2
  %conv = sext i16 %41 to i32
  %cmp35 = icmp eq i32 %conv, 0
  br i1 %cmp35, label %if.then, label %if.else

if.then:                                          ; preds = %for.body34
  %42 = load i8*, i8** %resultptr, align 8
  store i8 -1, i8* %42, align 1
  br label %if.end

if.else:                                          ; preds = %for.body34
  %43 = load i16*, i16** %gxptr, align 8
  %44 = load i16, i16* %43, align 2
  store i16 %44, i16* %gx, align 2
  %conv37 = sext i16 %44 to i32
  %sub38 = sub nsw i32 0, %conv37
  %conv39 = sitofp i32 %sub38 to float
  %45 = load i16, i16* %m00, align 2
  %conv40 = sitofp i16 %45 to float
  %div = fdiv float %conv39, %conv40
  store float %div, float* %xperp, align 4
  %46 = load i16*, i16** %gyptr, align 8
  %47 = load i16, i16* %46, align 2
  store i16 %47, i16* %gy, align 2
  %conv41 = sext i16 %47 to i32
  %conv42 = sitofp i32 %conv41 to float
  %48 = load i16, i16* %m00, align 2
  %conv43 = sitofp i16 %48 to float
  %div44 = fdiv float %conv42, %conv43
  store float %div44, float* %yperp, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %49 = load i16, i16* %gx, align 2
  %conv45 = sext i16 %49 to i32
  %cmp46 = icmp sge i32 %conv45, 0
  br i1 %cmp46, label %if.then48, label %if.else198

if.then48:                                        ; preds = %if.end
  %50 = load i16, i16* %gy, align 2
  %conv49 = sext i16 %50 to i32
  %cmp50 = icmp sge i32 %conv49, 0
  br i1 %cmp50, label %if.then52, label %if.else123

if.then52:                                        ; preds = %if.then48
  %51 = load i16, i16* %gx, align 2
  %conv53 = sext i16 %51 to i32
  %52 = load i16, i16* %gy, align 2
  %conv54 = sext i16 %52 to i32
  %cmp55 = icmp sge i32 %conv53, %conv54
  br i1 %cmp55, label %if.then57, label %if.else87

if.then57:                                        ; preds = %if.then52
  %53 = load i16*, i16** %magptr, align 8
  %add.ptr58 = getelementptr inbounds i16, i16* %53, i64 -1
  %54 = load i16, i16* %add.ptr58, align 2
  store i16 %54, i16* %z1, align 2
  %55 = load i16*, i16** %magptr, align 8
  %56 = load i32, i32* %ncols.addr, align 4
  %idx.ext59 = sext i32 %56 to i64
  %idx.neg = sub i64 0, %idx.ext59
  %add.ptr60 = getelementptr inbounds i16, i16* %55, i64 %idx.neg
  %add.ptr61 = getelementptr inbounds i16, i16* %add.ptr60, i64 -1
  %57 = load i16, i16* %add.ptr61, align 2
  store i16 %57, i16* %z2, align 2
  %58 = load i16, i16* %m00, align 2
  %conv62 = sext i16 %58 to i32
  %59 = load i16, i16* %z1, align 2
  %conv63 = sext i16 %59 to i32
  %sub64 = sub nsw i32 %conv62, %conv63
  %conv65 = sitofp i32 %sub64 to float
  %60 = load float, float* %xperp, align 4
  %mul66 = fmul float %conv65, %60
  %61 = load i16, i16* %z2, align 2
  %conv67 = sext i16 %61 to i32
  %62 = load i16, i16* %z1, align 2
  %conv68 = sext i16 %62 to i32
  %sub69 = sub nsw i32 %conv67, %conv68
  %conv70 = sitofp i32 %sub69 to float
  %63 = load float, float* %yperp, align 4
  %mul71 = fmul float %conv70, %63
  %add = fadd float %mul66, %mul71
  store float %add, float* %mag1, align 4
  %64 = load i16*, i16** %magptr, align 8
  %add.ptr72 = getelementptr inbounds i16, i16* %64, i64 1
  %65 = load i16, i16* %add.ptr72, align 2
  store i16 %65, i16* %z1, align 2
  %66 = load i16*, i16** %magptr, align 8
  %67 = load i32, i32* %ncols.addr, align 4
  %idx.ext73 = sext i32 %67 to i64
  %add.ptr74 = getelementptr inbounds i16, i16* %66, i64 %idx.ext73
  %add.ptr75 = getelementptr inbounds i16, i16* %add.ptr74, i64 1
  %68 = load i16, i16* %add.ptr75, align 2
  store i16 %68, i16* %z2, align 2
  %69 = load i16, i16* %m00, align 2
  %conv76 = sext i16 %69 to i32
  %70 = load i16, i16* %z1, align 2
  %conv77 = sext i16 %70 to i32
  %sub78 = sub nsw i32 %conv76, %conv77
  %conv79 = sitofp i32 %sub78 to float
  %71 = load float, float* %xperp, align 4
  %mul80 = fmul float %conv79, %71
  %72 = load i16, i16* %z2, align 2
  %conv81 = sext i16 %72 to i32
  %73 = load i16, i16* %z1, align 2
  %conv82 = sext i16 %73 to i32
  %sub83 = sub nsw i32 %conv81, %conv82
  %conv84 = sitofp i32 %sub83 to float
  %74 = load float, float* %yperp, align 4
  %mul85 = fmul float %conv84, %74
  %add86 = fadd float %mul80, %mul85
  store float %add86, float* %mag2, align 4
  br label %if.end122

if.else87:                                        ; preds = %if.then52
  %75 = load i16*, i16** %magptr, align 8
  %76 = load i32, i32* %ncols.addr, align 4
  %idx.ext88 = sext i32 %76 to i64
  %idx.neg89 = sub i64 0, %idx.ext88
  %add.ptr90 = getelementptr inbounds i16, i16* %75, i64 %idx.neg89
  %77 = load i16, i16* %add.ptr90, align 2
  store i16 %77, i16* %z1, align 2
  %78 = load i16*, i16** %magptr, align 8
  %79 = load i32, i32* %ncols.addr, align 4
  %idx.ext91 = sext i32 %79 to i64
  %idx.neg92 = sub i64 0, %idx.ext91
  %add.ptr93 = getelementptr inbounds i16, i16* %78, i64 %idx.neg92
  %add.ptr94 = getelementptr inbounds i16, i16* %add.ptr93, i64 -1
  %80 = load i16, i16* %add.ptr94, align 2
  store i16 %80, i16* %z2, align 2
  %81 = load i16, i16* %z1, align 2
  %conv95 = sext i16 %81 to i32
  %82 = load i16, i16* %z2, align 2
  %conv96 = sext i16 %82 to i32
  %sub97 = sub nsw i32 %conv95, %conv96
  %conv98 = sitofp i32 %sub97 to float
  %83 = load float, float* %xperp, align 4
  %mul99 = fmul float %conv98, %83
  %84 = load i16, i16* %z1, align 2
  %conv100 = sext i16 %84 to i32
  %85 = load i16, i16* %m00, align 2
  %conv101 = sext i16 %85 to i32
  %sub102 = sub nsw i32 %conv100, %conv101
  %conv103 = sitofp i32 %sub102 to float
  %86 = load float, float* %yperp, align 4
  %mul104 = fmul float %conv103, %86
  %add105 = fadd float %mul99, %mul104
  store float %add105, float* %mag1, align 4
  %87 = load i16*, i16** %magptr, align 8
  %88 = load i32, i32* %ncols.addr, align 4
  %idx.ext106 = sext i32 %88 to i64
  %add.ptr107 = getelementptr inbounds i16, i16* %87, i64 %idx.ext106
  %89 = load i16, i16* %add.ptr107, align 2
  store i16 %89, i16* %z1, align 2
  %90 = load i16*, i16** %magptr, align 8
  %91 = load i32, i32* %ncols.addr, align 4
  %idx.ext108 = sext i32 %91 to i64
  %add.ptr109 = getelementptr inbounds i16, i16* %90, i64 %idx.ext108
  %add.ptr110 = getelementptr inbounds i16, i16* %add.ptr109, i64 1
  %92 = load i16, i16* %add.ptr110, align 2
  store i16 %92, i16* %z2, align 2
  %93 = load i16, i16* %z1, align 2
  %conv111 = sext i16 %93 to i32
  %94 = load i16, i16* %z2, align 2
  %conv112 = sext i16 %94 to i32
  %sub113 = sub nsw i32 %conv111, %conv112
  %conv114 = sitofp i32 %sub113 to float
  %95 = load float, float* %xperp, align 4
  %mul115 = fmul float %conv114, %95
  %96 = load i16, i16* %z1, align 2
  %conv116 = sext i16 %96 to i32
  %97 = load i16, i16* %m00, align 2
  %conv117 = sext i16 %97 to i32
  %sub118 = sub nsw i32 %conv116, %conv117
  %conv119 = sitofp i32 %sub118 to float
  %98 = load float, float* %yperp, align 4
  %mul120 = fmul float %conv119, %98
  %add121 = fadd float %mul115, %mul120
  store float %add121, float* %mag2, align 4
  br label %if.end122

if.end122:                                        ; preds = %if.else87, %if.then57
  br label %if.end197

if.else123:                                       ; preds = %if.then48
  %99 = load i16, i16* %gx, align 2
  %conv124 = sext i16 %99 to i32
  %100 = load i16, i16* %gy, align 2
  %conv125 = sext i16 %100 to i32
  %sub126 = sub nsw i32 0, %conv125
  %cmp127 = icmp sge i32 %conv124, %sub126
  br i1 %cmp127, label %if.then129, label %if.else161

if.then129:                                       ; preds = %if.else123
  %101 = load i16*, i16** %magptr, align 8
  %add.ptr130 = getelementptr inbounds i16, i16* %101, i64 -1
  %102 = load i16, i16* %add.ptr130, align 2
  store i16 %102, i16* %z1, align 2
  %103 = load i16*, i16** %magptr, align 8
  %104 = load i32, i32* %ncols.addr, align 4
  %idx.ext131 = sext i32 %104 to i64
  %add.ptr132 = getelementptr inbounds i16, i16* %103, i64 %idx.ext131
  %add.ptr133 = getelementptr inbounds i16, i16* %add.ptr132, i64 -1
  %105 = load i16, i16* %add.ptr133, align 2
  store i16 %105, i16* %z2, align 2
  %106 = load i16, i16* %m00, align 2
  %conv134 = sext i16 %106 to i32
  %107 = load i16, i16* %z1, align 2
  %conv135 = sext i16 %107 to i32
  %sub136 = sub nsw i32 %conv134, %conv135
  %conv137 = sitofp i32 %sub136 to float
  %108 = load float, float* %xperp, align 4
  %mul138 = fmul float %conv137, %108
  %109 = load i16, i16* %z1, align 2
  %conv139 = sext i16 %109 to i32
  %110 = load i16, i16* %z2, align 2
  %conv140 = sext i16 %110 to i32
  %sub141 = sub nsw i32 %conv139, %conv140
  %conv142 = sitofp i32 %sub141 to float
  %111 = load float, float* %yperp, align 4
  %mul143 = fmul float %conv142, %111
  %add144 = fadd float %mul138, %mul143
  store float %add144, float* %mag1, align 4
  %112 = load i16*, i16** %magptr, align 8
  %add.ptr145 = getelementptr inbounds i16, i16* %112, i64 1
  %113 = load i16, i16* %add.ptr145, align 2
  store i16 %113, i16* %z1, align 2
  %114 = load i16*, i16** %magptr, align 8
  %115 = load i32, i32* %ncols.addr, align 4
  %idx.ext146 = sext i32 %115 to i64
  %idx.neg147 = sub i64 0, %idx.ext146
  %add.ptr148 = getelementptr inbounds i16, i16* %114, i64 %idx.neg147
  %add.ptr149 = getelementptr inbounds i16, i16* %add.ptr148, i64 1
  %116 = load i16, i16* %add.ptr149, align 2
  store i16 %116, i16* %z2, align 2
  %117 = load i16, i16* %m00, align 2
  %conv150 = sext i16 %117 to i32
  %118 = load i16, i16* %z1, align 2
  %conv151 = sext i16 %118 to i32
  %sub152 = sub nsw i32 %conv150, %conv151
  %conv153 = sitofp i32 %sub152 to float
  %119 = load float, float* %xperp, align 4
  %mul154 = fmul float %conv153, %119
  %120 = load i16, i16* %z1, align 2
  %conv155 = sext i16 %120 to i32
  %121 = load i16, i16* %z2, align 2
  %conv156 = sext i16 %121 to i32
  %sub157 = sub nsw i32 %conv155, %conv156
  %conv158 = sitofp i32 %sub157 to float
  %122 = load float, float* %yperp, align 4
  %mul159 = fmul float %conv158, %122
  %add160 = fadd float %mul154, %mul159
  store float %add160, float* %mag2, align 4
  br label %if.end196

if.else161:                                       ; preds = %if.else123
  %123 = load i16*, i16** %magptr, align 8
  %124 = load i32, i32* %ncols.addr, align 4
  %idx.ext162 = sext i32 %124 to i64
  %add.ptr163 = getelementptr inbounds i16, i16* %123, i64 %idx.ext162
  %125 = load i16, i16* %add.ptr163, align 2
  store i16 %125, i16* %z1, align 2
  %126 = load i16*, i16** %magptr, align 8
  %127 = load i32, i32* %ncols.addr, align 4
  %idx.ext164 = sext i32 %127 to i64
  %add.ptr165 = getelementptr inbounds i16, i16* %126, i64 %idx.ext164
  %add.ptr166 = getelementptr inbounds i16, i16* %add.ptr165, i64 -1
  %128 = load i16, i16* %add.ptr166, align 2
  store i16 %128, i16* %z2, align 2
  %129 = load i16, i16* %z1, align 2
  %conv167 = sext i16 %129 to i32
  %130 = load i16, i16* %z2, align 2
  %conv168 = sext i16 %130 to i32
  %sub169 = sub nsw i32 %conv167, %conv168
  %conv170 = sitofp i32 %sub169 to float
  %131 = load float, float* %xperp, align 4
  %mul171 = fmul float %conv170, %131
  %132 = load i16, i16* %m00, align 2
  %conv172 = sext i16 %132 to i32
  %133 = load i16, i16* %z1, align 2
  %conv173 = sext i16 %133 to i32
  %sub174 = sub nsw i32 %conv172, %conv173
  %conv175 = sitofp i32 %sub174 to float
  %134 = load float, float* %yperp, align 4
  %mul176 = fmul float %conv175, %134
  %add177 = fadd float %mul171, %mul176
  store float %add177, float* %mag1, align 4
  %135 = load i16*, i16** %magptr, align 8
  %136 = load i32, i32* %ncols.addr, align 4
  %idx.ext178 = sext i32 %136 to i64
  %idx.neg179 = sub i64 0, %idx.ext178
  %add.ptr180 = getelementptr inbounds i16, i16* %135, i64 %idx.neg179
  %137 = load i16, i16* %add.ptr180, align 2
  store i16 %137, i16* %z1, align 2
  %138 = load i16*, i16** %magptr, align 8
  %139 = load i32, i32* %ncols.addr, align 4
  %idx.ext181 = sext i32 %139 to i64
  %idx.neg182 = sub i64 0, %idx.ext181
  %add.ptr183 = getelementptr inbounds i16, i16* %138, i64 %idx.neg182
  %add.ptr184 = getelementptr inbounds i16, i16* %add.ptr183, i64 1
  %140 = load i16, i16* %add.ptr184, align 2
  store i16 %140, i16* %z2, align 2
  %141 = load i16, i16* %z1, align 2
  %conv185 = sext i16 %141 to i32
  %142 = load i16, i16* %z2, align 2
  %conv186 = sext i16 %142 to i32
  %sub187 = sub nsw i32 %conv185, %conv186
  %conv188 = sitofp i32 %sub187 to float
  %143 = load float, float* %xperp, align 4
  %mul189 = fmul float %conv188, %143
  %144 = load i16, i16* %m00, align 2
  %conv190 = sext i16 %144 to i32
  %145 = load i16, i16* %z1, align 2
  %conv191 = sext i16 %145 to i32
  %sub192 = sub nsw i32 %conv190, %conv191
  %conv193 = sitofp i32 %sub192 to float
  %146 = load float, float* %yperp, align 4
  %mul194 = fmul float %conv193, %146
  %add195 = fadd float %mul189, %mul194
  store float %add195, float* %mag2, align 4
  br label %if.end196

if.end196:                                        ; preds = %if.else161, %if.then129
  br label %if.end197

if.end197:                                        ; preds = %if.end196, %if.end122
  br label %if.end352

if.else198:                                       ; preds = %if.end
  %147 = load i16*, i16** %gyptr, align 8
  %148 = load i16, i16* %147, align 2
  store i16 %148, i16* %gy, align 2
  %conv199 = sext i16 %148 to i32
  %cmp200 = icmp sge i32 %conv199, 0
  br i1 %cmp200, label %if.then202, label %if.else276

if.then202:                                       ; preds = %if.else198
  %149 = load i16, i16* %gx, align 2
  %conv203 = sext i16 %149 to i32
  %sub204 = sub nsw i32 0, %conv203
  %150 = load i16, i16* %gy, align 2
  %conv205 = sext i16 %150 to i32
  %cmp206 = icmp sge i32 %sub204, %conv205
  br i1 %cmp206, label %if.then208, label %if.else240

if.then208:                                       ; preds = %if.then202
  %151 = load i16*, i16** %magptr, align 8
  %add.ptr209 = getelementptr inbounds i16, i16* %151, i64 1
  %152 = load i16, i16* %add.ptr209, align 2
  store i16 %152, i16* %z1, align 2
  %153 = load i16*, i16** %magptr, align 8
  %154 = load i32, i32* %ncols.addr, align 4
  %idx.ext210 = sext i32 %154 to i64
  %idx.neg211 = sub i64 0, %idx.ext210
  %add.ptr212 = getelementptr inbounds i16, i16* %153, i64 %idx.neg211
  %add.ptr213 = getelementptr inbounds i16, i16* %add.ptr212, i64 1
  %155 = load i16, i16* %add.ptr213, align 2
  store i16 %155, i16* %z2, align 2
  %156 = load i16, i16* %z1, align 2
  %conv214 = sext i16 %156 to i32
  %157 = load i16, i16* %m00, align 2
  %conv215 = sext i16 %157 to i32
  %sub216 = sub nsw i32 %conv214, %conv215
  %conv217 = sitofp i32 %sub216 to float
  %158 = load float, float* %xperp, align 4
  %mul218 = fmul float %conv217, %158
  %159 = load i16, i16* %z2, align 2
  %conv219 = sext i16 %159 to i32
  %160 = load i16, i16* %z1, align 2
  %conv220 = sext i16 %160 to i32
  %sub221 = sub nsw i32 %conv219, %conv220
  %conv222 = sitofp i32 %sub221 to float
  %161 = load float, float* %yperp, align 4
  %mul223 = fmul float %conv222, %161
  %add224 = fadd float %mul218, %mul223
  store float %add224, float* %mag1, align 4
  %162 = load i16*, i16** %magptr, align 8
  %add.ptr225 = getelementptr inbounds i16, i16* %162, i64 -1
  %163 = load i16, i16* %add.ptr225, align 2
  store i16 %163, i16* %z1, align 2
  %164 = load i16*, i16** %magptr, align 8
  %165 = load i32, i32* %ncols.addr, align 4
  %idx.ext226 = sext i32 %165 to i64
  %add.ptr227 = getelementptr inbounds i16, i16* %164, i64 %idx.ext226
  %add.ptr228 = getelementptr inbounds i16, i16* %add.ptr227, i64 -1
  %166 = load i16, i16* %add.ptr228, align 2
  store i16 %166, i16* %z2, align 2
  %167 = load i16, i16* %z1, align 2
  %conv229 = sext i16 %167 to i32
  %168 = load i16, i16* %m00, align 2
  %conv230 = sext i16 %168 to i32
  %sub231 = sub nsw i32 %conv229, %conv230
  %conv232 = sitofp i32 %sub231 to float
  %169 = load float, float* %xperp, align 4
  %mul233 = fmul float %conv232, %169
  %170 = load i16, i16* %z2, align 2
  %conv234 = sext i16 %170 to i32
  %171 = load i16, i16* %z1, align 2
  %conv235 = sext i16 %171 to i32
  %sub236 = sub nsw i32 %conv234, %conv235
  %conv237 = sitofp i32 %sub236 to float
  %172 = load float, float* %yperp, align 4
  %mul238 = fmul float %conv237, %172
  %add239 = fadd float %mul233, %mul238
  store float %add239, float* %mag2, align 4
  br label %if.end275

if.else240:                                       ; preds = %if.then202
  %173 = load i16*, i16** %magptr, align 8
  %174 = load i32, i32* %ncols.addr, align 4
  %idx.ext241 = sext i32 %174 to i64
  %idx.neg242 = sub i64 0, %idx.ext241
  %add.ptr243 = getelementptr inbounds i16, i16* %173, i64 %idx.neg242
  %175 = load i16, i16* %add.ptr243, align 2
  store i16 %175, i16* %z1, align 2
  %176 = load i16*, i16** %magptr, align 8
  %177 = load i32, i32* %ncols.addr, align 4
  %idx.ext244 = sext i32 %177 to i64
  %idx.neg245 = sub i64 0, %idx.ext244
  %add.ptr246 = getelementptr inbounds i16, i16* %176, i64 %idx.neg245
  %add.ptr247 = getelementptr inbounds i16, i16* %add.ptr246, i64 1
  %178 = load i16, i16* %add.ptr247, align 2
  store i16 %178, i16* %z2, align 2
  %179 = load i16, i16* %z2, align 2
  %conv248 = sext i16 %179 to i32
  %180 = load i16, i16* %z1, align 2
  %conv249 = sext i16 %180 to i32
  %sub250 = sub nsw i32 %conv248, %conv249
  %conv251 = sitofp i32 %sub250 to float
  %181 = load float, float* %xperp, align 4
  %mul252 = fmul float %conv251, %181
  %182 = load i16, i16* %z1, align 2
  %conv253 = sext i16 %182 to i32
  %183 = load i16, i16* %m00, align 2
  %conv254 = sext i16 %183 to i32
  %sub255 = sub nsw i32 %conv253, %conv254
  %conv256 = sitofp i32 %sub255 to float
  %184 = load float, float* %yperp, align 4
  %mul257 = fmul float %conv256, %184
  %add258 = fadd float %mul252, %mul257
  store float %add258, float* %mag1, align 4
  %185 = load i16*, i16** %magptr, align 8
  %186 = load i32, i32* %ncols.addr, align 4
  %idx.ext259 = sext i32 %186 to i64
  %add.ptr260 = getelementptr inbounds i16, i16* %185, i64 %idx.ext259
  %187 = load i16, i16* %add.ptr260, align 2
  store i16 %187, i16* %z1, align 2
  %188 = load i16*, i16** %magptr, align 8
  %189 = load i32, i32* %ncols.addr, align 4
  %idx.ext261 = sext i32 %189 to i64
  %add.ptr262 = getelementptr inbounds i16, i16* %188, i64 %idx.ext261
  %add.ptr263 = getelementptr inbounds i16, i16* %add.ptr262, i64 -1
  %190 = load i16, i16* %add.ptr263, align 2
  store i16 %190, i16* %z2, align 2
  %191 = load i16, i16* %z2, align 2
  %conv264 = sext i16 %191 to i32
  %192 = load i16, i16* %z1, align 2
  %conv265 = sext i16 %192 to i32
  %sub266 = sub nsw i32 %conv264, %conv265
  %conv267 = sitofp i32 %sub266 to float
  %193 = load float, float* %xperp, align 4
  %mul268 = fmul float %conv267, %193
  %194 = load i16, i16* %z1, align 2
  %conv269 = sext i16 %194 to i32
  %195 = load i16, i16* %m00, align 2
  %conv270 = sext i16 %195 to i32
  %sub271 = sub nsw i32 %conv269, %conv270
  %conv272 = sitofp i32 %sub271 to float
  %196 = load float, float* %yperp, align 4
  %mul273 = fmul float %conv272, %196
  %add274 = fadd float %mul268, %mul273
  store float %add274, float* %mag2, align 4
  br label %if.end275

if.end275:                                        ; preds = %if.else240, %if.then208
  br label %if.end351

if.else276:                                       ; preds = %if.else198
  %197 = load i16, i16* %gx, align 2
  %conv277 = sext i16 %197 to i32
  %sub278 = sub nsw i32 0, %conv277
  %198 = load i16, i16* %gy, align 2
  %conv279 = sext i16 %198 to i32
  %sub280 = sub nsw i32 0, %conv279
  %cmp281 = icmp sgt i32 %sub278, %sub280
  br i1 %cmp281, label %if.then283, label %if.else315

if.then283:                                       ; preds = %if.else276
  %199 = load i16*, i16** %magptr, align 8
  %add.ptr284 = getelementptr inbounds i16, i16* %199, i64 1
  %200 = load i16, i16* %add.ptr284, align 2
  store i16 %200, i16* %z1, align 2
  %201 = load i16*, i16** %magptr, align 8
  %202 = load i32, i32* %ncols.addr, align 4
  %idx.ext285 = sext i32 %202 to i64
  %add.ptr286 = getelementptr inbounds i16, i16* %201, i64 %idx.ext285
  %add.ptr287 = getelementptr inbounds i16, i16* %add.ptr286, i64 1
  %203 = load i16, i16* %add.ptr287, align 2
  store i16 %203, i16* %z2, align 2
  %204 = load i16, i16* %z1, align 2
  %conv288 = sext i16 %204 to i32
  %205 = load i16, i16* %m00, align 2
  %conv289 = sext i16 %205 to i32
  %sub290 = sub nsw i32 %conv288, %conv289
  %conv291 = sitofp i32 %sub290 to float
  %206 = load float, float* %xperp, align 4
  %mul292 = fmul float %conv291, %206
  %207 = load i16, i16* %z1, align 2
  %conv293 = sext i16 %207 to i32
  %208 = load i16, i16* %z2, align 2
  %conv294 = sext i16 %208 to i32
  %sub295 = sub nsw i32 %conv293, %conv294
  %conv296 = sitofp i32 %sub295 to float
  %209 = load float, float* %yperp, align 4
  %mul297 = fmul float %conv296, %209
  %add298 = fadd float %mul292, %mul297
  store float %add298, float* %mag1, align 4
  %210 = load i16*, i16** %magptr, align 8
  %add.ptr299 = getelementptr inbounds i16, i16* %210, i64 -1
  %211 = load i16, i16* %add.ptr299, align 2
  store i16 %211, i16* %z1, align 2
  %212 = load i16*, i16** %magptr, align 8
  %213 = load i32, i32* %ncols.addr, align 4
  %idx.ext300 = sext i32 %213 to i64
  %idx.neg301 = sub i64 0, %idx.ext300
  %add.ptr302 = getelementptr inbounds i16, i16* %212, i64 %idx.neg301
  %add.ptr303 = getelementptr inbounds i16, i16* %add.ptr302, i64 -1
  %214 = load i16, i16* %add.ptr303, align 2
  store i16 %214, i16* %z2, align 2
  %215 = load i16, i16* %z1, align 2
  %conv304 = sext i16 %215 to i32
  %216 = load i16, i16* %m00, align 2
  %conv305 = sext i16 %216 to i32
  %sub306 = sub nsw i32 %conv304, %conv305
  %conv307 = sitofp i32 %sub306 to float
  %217 = load float, float* %xperp, align 4
  %mul308 = fmul float %conv307, %217
  %218 = load i16, i16* %z1, align 2
  %conv309 = sext i16 %218 to i32
  %219 = load i16, i16* %z2, align 2
  %conv310 = sext i16 %219 to i32
  %sub311 = sub nsw i32 %conv309, %conv310
  %conv312 = sitofp i32 %sub311 to float
  %220 = load float, float* %yperp, align 4
  %mul313 = fmul float %conv312, %220
  %add314 = fadd float %mul308, %mul313
  store float %add314, float* %mag2, align 4
  br label %if.end350

if.else315:                                       ; preds = %if.else276
  %221 = load i16*, i16** %magptr, align 8
  %222 = load i32, i32* %ncols.addr, align 4
  %idx.ext316 = sext i32 %222 to i64
  %add.ptr317 = getelementptr inbounds i16, i16* %221, i64 %idx.ext316
  %223 = load i16, i16* %add.ptr317, align 2
  store i16 %223, i16* %z1, align 2
  %224 = load i16*, i16** %magptr, align 8
  %225 = load i32, i32* %ncols.addr, align 4
  %idx.ext318 = sext i32 %225 to i64
  %add.ptr319 = getelementptr inbounds i16, i16* %224, i64 %idx.ext318
  %add.ptr320 = getelementptr inbounds i16, i16* %add.ptr319, i64 1
  %226 = load i16, i16* %add.ptr320, align 2
  store i16 %226, i16* %z2, align 2
  %227 = load i16, i16* %z2, align 2
  %conv321 = sext i16 %227 to i32
  %228 = load i16, i16* %z1, align 2
  %conv322 = sext i16 %228 to i32
  %sub323 = sub nsw i32 %conv321, %conv322
  %conv324 = sitofp i32 %sub323 to float
  %229 = load float, float* %xperp, align 4
  %mul325 = fmul float %conv324, %229
  %230 = load i16, i16* %m00, align 2
  %conv326 = sext i16 %230 to i32
  %231 = load i16, i16* %z1, align 2
  %conv327 = sext i16 %231 to i32
  %sub328 = sub nsw i32 %conv326, %conv327
  %conv329 = sitofp i32 %sub328 to float
  %232 = load float, float* %yperp, align 4
  %mul330 = fmul float %conv329, %232
  %add331 = fadd float %mul325, %mul330
  store float %add331, float* %mag1, align 4
  %233 = load i16*, i16** %magptr, align 8
  %234 = load i32, i32* %ncols.addr, align 4
  %idx.ext332 = sext i32 %234 to i64
  %idx.neg333 = sub i64 0, %idx.ext332
  %add.ptr334 = getelementptr inbounds i16, i16* %233, i64 %idx.neg333
  %235 = load i16, i16* %add.ptr334, align 2
  store i16 %235, i16* %z1, align 2
  %236 = load i16*, i16** %magptr, align 8
  %237 = load i32, i32* %ncols.addr, align 4
  %idx.ext335 = sext i32 %237 to i64
  %idx.neg336 = sub i64 0, %idx.ext335
  %add.ptr337 = getelementptr inbounds i16, i16* %236, i64 %idx.neg336
  %add.ptr338 = getelementptr inbounds i16, i16* %add.ptr337, i64 -1
  %238 = load i16, i16* %add.ptr338, align 2
  store i16 %238, i16* %z2, align 2
  %239 = load i16, i16* %z2, align 2
  %conv339 = sext i16 %239 to i32
  %240 = load i16, i16* %z1, align 2
  %conv340 = sext i16 %240 to i32
  %sub341 = sub nsw i32 %conv339, %conv340
  %conv342 = sitofp i32 %sub341 to float
  %241 = load float, float* %xperp, align 4
  %mul343 = fmul float %conv342, %241
  %242 = load i16, i16* %m00, align 2
  %conv344 = sext i16 %242 to i32
  %243 = load i16, i16* %z1, align 2
  %conv345 = sext i16 %243 to i32
  %sub346 = sub nsw i32 %conv344, %conv345
  %conv347 = sitofp i32 %sub346 to float
  %244 = load float, float* %yperp, align 4
  %mul348 = fmul float %conv347, %244
  %add349 = fadd float %mul343, %mul348
  store float %add349, float* %mag2, align 4
  br label %if.end350

if.end350:                                        ; preds = %if.else315, %if.then283
  br label %if.end351

if.end351:                                        ; preds = %if.end350, %if.end275
  br label %if.end352

if.end352:                                        ; preds = %if.end351, %if.end197
  %245 = load float, float* %mag1, align 4
  %conv353 = fpext float %245 to double
  %cmp354 = fcmp ogt double %conv353, 0.000000e+00
  br i1 %cmp354, label %if.then359, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.end352
  %246 = load float, float* %mag2, align 4
  %conv356 = fpext float %246 to double
  %cmp357 = fcmp ogt double %conv356, 0.000000e+00
  br i1 %cmp357, label %if.then359, label %if.else360

if.then359:                                       ; preds = %lor.lhs.false, %if.end352
  %247 = load i8*, i8** %resultptr, align 8
  store i8 -1, i8* %247, align 1
  br label %if.end367

if.else360:                                       ; preds = %lor.lhs.false
  %248 = load float, float* %mag2, align 4
  %conv361 = fpext float %248 to double
  %cmp362 = fcmp oeq double %conv361, 0.000000e+00
  br i1 %cmp362, label %if.then364, label %if.else365

if.then364:                                       ; preds = %if.else360
  %249 = load i8*, i8** %resultptr, align 8
  store i8 -1, i8* %249, align 1
  br label %if.end366

if.else365:                                       ; preds = %if.else360
  %250 = load i8*, i8** %resultptr, align 8
  store i8 -128, i8* %250, align 1
  br label %if.end366

if.end366:                                        ; preds = %if.else365, %if.then364
  br label %if.end367

if.end367:                                        ; preds = %if.end366, %if.then359
  br label %for.inc368

for.inc368:                                       ; preds = %if.end367
  %251 = load i32, i32* %colcount, align 4
  %inc369 = add nsw i32 %251, 1
  store i32 %inc369, i32* %colcount, align 4
  %252 = load i16*, i16** %magptr, align 8
  %incdec.ptr370 = getelementptr inbounds i16, i16* %252, i32 1
  store i16* %incdec.ptr370, i16** %magptr, align 8
  %253 = load i16*, i16** %gxptr, align 8
  %incdec.ptr371 = getelementptr inbounds i16, i16* %253, i32 1
  store i16* %incdec.ptr371, i16** %gxptr, align 8
  %254 = load i16*, i16** %gyptr, align 8
  %incdec.ptr372 = getelementptr inbounds i16, i16* %254, i32 1
  store i16* %incdec.ptr372, i16** %gyptr, align 8
  %255 = load i8*, i8** %resultptr, align 8
  %incdec.ptr373 = getelementptr inbounds i8, i8* %255, i32 1
  store i8* %incdec.ptr373, i8** %resultptr, align 8
  br label %for.cond31

for.end374:                                       ; preds = %for.cond31
  br label %for.inc375

for.inc375:                                       ; preds = %for.end374
  %256 = load i32, i32* %rowcount, align 4
  %inc376 = add nsw i32 %256, 1
  store i32 %inc376, i32* %rowcount, align 4
  %257 = load i32, i32* %ncols.addr, align 4
  %258 = load i16*, i16** %magrowptr, align 8
  %idx.ext377 = sext i32 %257 to i64
  %add.ptr378 = getelementptr inbounds i16, i16* %258, i64 %idx.ext377
  store i16* %add.ptr378, i16** %magrowptr, align 8
  %259 = load i32, i32* %ncols.addr, align 4
  %260 = load i16*, i16** %gyrowptr, align 8
  %idx.ext379 = sext i32 %259 to i64
  %add.ptr380 = getelementptr inbounds i16, i16* %260, i64 %idx.ext379
  store i16* %add.ptr380, i16** %gyrowptr, align 8
  %261 = load i32, i32* %ncols.addr, align 4
  %262 = load i16*, i16** %gxrowptr, align 8
  %idx.ext381 = sext i32 %261 to i64
  %add.ptr382 = getelementptr inbounds i16, i16* %262, i64 %idx.ext381
  store i16* %add.ptr382, i16** %gxrowptr, align 8
  %263 = load i32, i32* %ncols.addr, align 4
  %264 = load i8*, i8** %resultrowptr, align 8
  %idx.ext383 = sext i32 %263 to i64
  %add.ptr384 = getelementptr inbounds i8, i8* %264, i64 %idx.ext383
  store i8* %add.ptr384, i8** %resultrowptr, align 8
  br label %for.cond27

for.end385:                                       ; preds = %for.cond27
  %265 = load i32, i32* %retval, align 4
  ret i32 %265
}

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
  %llvm-call = call %struct._IO_FILE* @fopen(i8* %2, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.29, i32 0, i32 0))
  store %struct._IO_FILE* %llvm-call, %struct._IO_FILE** %fp, align 8
  %cmp1 = icmp eq %struct._IO_FILE* %llvm-call, null
  br i1 %cmp1, label %if.then2, label %if.end

if.then2:                                         ; preds = %if.else
  %3 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %4 = load i8*, i8** %infilename.addr, align 8
  %llvm-call3 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %3, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.1.30, i32 0, i32 0), i8* %4)
  store i32 0, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %if.else
  br label %if.end4

if.end4:                                          ; preds = %if.end, %if.then
  %arraydecay = getelementptr inbounds [71 x i8], [71 x i8]* %buf, i32 0, i32 0
  %5 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call5 = call i8* @fgets(i8* %arraydecay, i32 70, %struct._IO_FILE* %5)
  %arraydecay6 = getelementptr inbounds [71 x i8], [71 x i8]* %buf, i32 0, i32 0
  %llvm-call7 = call i32 @strncmp(i8* %arraydecay6, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.2.31, i32 0, i32 0), i64 2) #8
  %cmp8 = icmp ne i32 %llvm-call7, 0
  br i1 %cmp8, label %if.then9, label %if.end16

if.then9:                                         ; preds = %if.end4
  %6 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %7 = load i8*, i8** %infilename.addr, align 8
  %llvm-call10 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %6, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.3.32, i32 0, i32 0), i8* %7)
  %8 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call11 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %8, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.4.33, i32 0, i32 0))
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
  %llvm-call22 = call i32 (i8*, i8*, ...) @__isoc99_sscanf(i8* %arraydecay21, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5.34, i32 0, i32 0), i32* %14, i32* %15) #9
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
  %llvm-call33 = call noalias i8* @malloc(i64 %conv32) #9
  %22 = load i8**, i8*** %image.addr, align 8
  store i8* %llvm-call33, i8** %22, align 8
  %cmp34 = icmp eq i8* %llvm-call33, null
  br i1 %cmp34, label %if.then36, label %if.end43

if.then36:                                        ; preds = %do.end31
  %23 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call37 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %23, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.6.35, i32 0, i32 0))
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
  %llvm-call51 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %36, i8* getelementptr inbounds ([51 x i8], [51 x i8]* @.str.7.36, i32 0, i32 0))
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
  call void @free(i8* %41) #9
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

declare i8* @fgets(i8*, i32, %struct._IO_FILE*) #1

; Function Attrs: nounwind readonly
declare i32 @strncmp(i8*, i8*, i64) #3

; Function Attrs: nounwind
declare i32 @__isoc99_sscanf(i8*, i8*, ...) #4

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #4

declare i64 @fread(i8*, i64, i64, %struct._IO_FILE*) #1

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
  %llvm-call = call %struct._IO_FILE* @fopen(i8* %2, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.8.39, i32 0, i32 0))
  store %struct._IO_FILE* %llvm-call, %struct._IO_FILE** %fp, align 8
  %cmp1 = icmp eq %struct._IO_FILE* %llvm-call, null
  br i1 %cmp1, label %if.then2, label %if.end

if.then2:                                         ; preds = %if.else
  %3 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %4 = load i8*, i8** %outfilename.addr, align 8
  %llvm-call3 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %3, i8* getelementptr inbounds ([49 x i8], [49 x i8]* @.str.9.40, i32 0, i32 0), i8* %4)
  store i32 0, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %if.else
  br label %if.end4

if.end4:                                          ; preds = %if.end, %if.then
  %5 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %6 = load i32, i32* %cols.addr, align 4
  %7 = load i32, i32* %rows.addr, align 4
  %llvm-call5 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %5, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.10.41, i32 0, i32 0), i32 %6, i32 %7)
  %8 = load i8*, i8** %comment.addr, align 8
  %cmp6 = icmp ne i8* %8, null
  br i1 %cmp6, label %if.then7, label %if.end13

if.then7:                                         ; preds = %if.end4
  %9 = load i8*, i8** %comment.addr, align 8
  %llvm-call8 = call i64 @strlen(i8* %9) #8
  %cmp9 = icmp ule i64 %llvm-call8, 70
  br i1 %cmp9, label %if.then10, label %if.end12

if.then10:                                        ; preds = %if.then7
  %10 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %11 = load i8*, i8** %comment.addr, align 8
  %llvm-call11 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %10, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.11.42, i32 0, i32 0), i8* %11)
  br label %if.end12

if.end12:                                         ; preds = %if.then10, %if.then7
  br label %if.end13

if.end13:                                         ; preds = %if.end12, %if.end4
  %12 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %13 = load i32, i32* %maxval.addr, align 4
  %llvm-call14 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %12, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.12.43, i32 0, i32 0), i32 %13)
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
  %llvm-call21 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %19, i8* getelementptr inbounds ([52 x i8], [52 x i8]* @.str.13.44, i32 0, i32 0))
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
declare i64 @strlen(i8*) #3

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
  %llvm-call = call %struct._IO_FILE* @fopen(i8* %2, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.29, i32 0, i32 0))
  store %struct._IO_FILE* %llvm-call, %struct._IO_FILE** %fp, align 8
  %cmp1 = icmp eq %struct._IO_FILE* %llvm-call, null
  br i1 %cmp1, label %if.then2, label %if.end

if.then2:                                         ; preds = %if.else
  %3 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %4 = load i8*, i8** %infilename.addr, align 8
  %llvm-call3 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %3, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.14.45, i32 0, i32 0), i8* %4)
  store i32 0, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %if.else
  br label %if.end4

if.end4:                                          ; preds = %if.end, %if.then
  %arraydecay = getelementptr inbounds [71 x i8], [71 x i8]* %buf, i32 0, i32 0
  %5 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %llvm-call5 = call i8* @fgets(i8* %arraydecay, i32 70, %struct._IO_FILE* %5)
  %arraydecay6 = getelementptr inbounds [71 x i8], [71 x i8]* %buf, i32 0, i32 0
  %llvm-call7 = call i32 @strncmp(i8* %arraydecay6, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.15.46, i32 0, i32 0), i64 2) #8
  %cmp8 = icmp ne i32 %llvm-call7, 0
  br i1 %cmp8, label %if.then9, label %if.end16

if.then9:                                         ; preds = %if.end4
  %6 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %7 = load i8*, i8** %infilename.addr, align 8
  %llvm-call10 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %6, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.16.47, i32 0, i32 0), i8* %7)
  %8 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call11 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %8, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.17.48, i32 0, i32 0))
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
  %llvm-call22 = call i32 (i8*, i8*, ...) @__isoc99_sscanf(i8* %arraydecay21, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5.34, i32 0, i32 0), i32* %14, i32* %15) #9
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
  %llvm-call33 = call noalias i8* @malloc(i64 %conv32) #9
  %22 = load i8**, i8*** %image_red.addr, align 8
  store i8* %llvm-call33, i8** %22, align 8
  %cmp34 = icmp eq i8* %llvm-call33, null
  br i1 %cmp34, label %if.then36, label %if.end43

if.then36:                                        ; preds = %do.end31
  %23 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call37 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %23, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.18.49, i32 0, i32 0))
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
  %llvm-call46 = call noalias i8* @malloc(i64 %conv45) #9
  %31 = load i8**, i8*** %image_grn.addr, align 8
  store i8* %llvm-call46, i8** %31, align 8
  %cmp47 = icmp eq i8* %llvm-call46, null
  br i1 %cmp47, label %if.then49, label %if.end56

if.then49:                                        ; preds = %if.end43
  %32 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call50 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %32, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.18.49, i32 0, i32 0))
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
  %llvm-call59 = call noalias i8* @malloc(i64 %conv58) #9
  %40 = load i8**, i8*** %image_blu.addr, align 8
  store i8* %llvm-call59, i8** %40, align 8
  %cmp60 = icmp eq i8* %llvm-call59, null
  br i1 %cmp60, label %if.then62, label %if.end69

if.then62:                                        ; preds = %if.end56
  %41 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call63 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %41, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.18.49, i32 0, i32 0))
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
  %llvm-call = call %struct._IO_FILE* @fopen(i8* %2, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.8.39, i32 0, i32 0))
  store %struct._IO_FILE* %llvm-call, %struct._IO_FILE** %fp, align 8
  %cmp1 = icmp eq %struct._IO_FILE* %llvm-call, null
  br i1 %cmp1, label %if.then2, label %if.end

if.then2:                                         ; preds = %if.else
  %3 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %4 = load i8*, i8** %outfilename.addr, align 8
  %llvm-call3 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %3, i8* getelementptr inbounds ([49 x i8], [49 x i8]* @.str.9.40, i32 0, i32 0), i8* %4)
  store i32 0, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %if.else
  br label %if.end4

if.end4:                                          ; preds = %if.end, %if.then
  %5 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %6 = load i32, i32* %cols.addr, align 4
  %7 = load i32, i32* %rows.addr, align 4
  %llvm-call5 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %5, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.19.50, i32 0, i32 0), i32 %6, i32 %7)
  %8 = load i8*, i8** %comment.addr, align 8
  %cmp6 = icmp ne i8* %8, null
  br i1 %cmp6, label %if.then7, label %if.end13

if.then7:                                         ; preds = %if.end4
  %9 = load i8*, i8** %comment.addr, align 8
  %llvm-call8 = call i64 @strlen(i8* %9) #8
  %cmp9 = icmp ule i64 %llvm-call8, 70
  br i1 %cmp9, label %if.then10, label %if.end12

if.then10:                                        ; preds = %if.then7
  %10 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %11 = load i8*, i8** %comment.addr, align 8
  %llvm-call11 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %10, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.11.42, i32 0, i32 0), i8* %11)
  br label %if.end12

if.end12:                                         ; preds = %if.then10, %if.then7
  br label %if.end13

if.end13:                                         ; preds = %if.end12, %if.end4
  %12 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %13 = load i32, i32* %maxval.addr, align 4
  %llvm-call14 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %12, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.12.43, i32 0, i32 0), i32 %13)
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
attributes #2 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readnone speculatable }
attributes #6 = { argmemonly nounwind }
attributes #7 = { noreturn nounwind }
attributes #8 = { nounwind readonly }
attributes #9 = { nounwind }

!llvm.ident = !{!0, !0, !0}
!llvm.module.flags = !{!1}

!0 = !{!"clang version 6.0.1 (tags/RELEASE_601/final)"}
!1 = !{i32 1, !"wchar_size", i32 4}
