; ModuleID = 'canny_edge.c'
source_filename = "canny_edge.c"
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
@.str.23 = private unnamed_addr constant [48 x i8] c"Error allocating the gradient direction image.\0A\00", align 1
@.str.24 = private unnamed_addr constant [39 x i8] c"Error allocating the magnitude image.\0A\00", align 1
@.str.25 = private unnamed_addr constant [37 x i8] c"Error allocating the delta_x image.\0A\00", align 1
@.str.26 = private unnamed_addr constant [36 x i8] c"Error allocating the buffer image.\0A\00", align 1
@.str.27 = private unnamed_addr constant [38 x i8] c"Error allocating the smoothed image.\0A\00", align 1
@.str.28 = private unnamed_addr constant [44 x i8] c"Error callocing the gaussian kernel array.\0A\00", align 1

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
  call void @exit(i32 1) #6
  unreachable

if.end:                                           ; preds = %entry
  %17 = load i8**, i8*** %argv.addr, align 8
  %arrayidx14 = getelementptr inbounds i8*, i8** %17, i64 1
  %18 = load i8*, i8** %arrayidx14, align 8
  store i8* %18, i8** %infilename, align 8
  %19 = load i8**, i8*** %argv.addr, align 8
  %arrayidx15 = getelementptr inbounds i8*, i8** %19, i64 2
  %20 = load i8*, i8** %arrayidx15, align 8
  %llvm-call16 = call double @atof(i8* %20) #7
  %conv = fptrunc double %llvm-call16 to float
  store float %conv, float* %sigma, align 4
  %21 = load i8**, i8*** %argv.addr, align 8
  %arrayidx17 = getelementptr inbounds i8*, i8** %21, i64 3
  %22 = load i8*, i8** %arrayidx17, align 8
  %llvm-call18 = call double @atof(i8* %22) #7
  %conv19 = fptrunc double %llvm-call18 to float
  store float %conv19, float* %tlow, align 4
  %23 = load i8**, i8*** %argv.addr, align 8
  %arrayidx20 = getelementptr inbounds i8*, i8** %23, i64 4
  %24 = load i8*, i8** %arrayidx20, align 8
  %llvm-call21 = call double @atof(i8* %24) #7
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
  call void @exit(i32 1) #6
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
  %llvm-call39 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.15, i32 0, i32 0), i8* %31, double %conv36, double %conv37, double %conv38) #8
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
  %llvm-call46 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay42, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.16, i32 0, i32 0), i8* %42, double %conv43, double %conv44, double %conv45) #8
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
  call void @exit(i32 1) #6
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

declare i32 @read_pgm_image(i8*, i8**, i32*, i32*) #1

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
  call void @exit(i32 1) #6
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
  call void @free(i8* %22) #8
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
  %llvm-call9 = call noalias i8* @calloc(i64 %conv8, i64 1) #8
  store i8* %llvm-call9, i8** %nms, align 8
  %cmp10 = icmp eq i8* %llvm-call9, null
  br i1 %cmp10, label %if.then12, label %if.end14

if.then12:                                        ; preds = %if.end6
  %29 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call13 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %29, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.21, i32 0, i32 0))
  call void @exit(i32 1) #6
  unreachable

if.end14:                                         ; preds = %if.end6
  %30 = load i16*, i16** %magnitude, align 8
  %31 = load i16*, i16** %delta_x, align 8
  %32 = load i16*, i16** %delta_y, align 8
  %33 = load i32, i32* %rows.addr, align 4
  %34 = load i32, i32* %cols.addr, align 4
  %35 = load i8*, i8** %nms, align 8
  %llvm-call15 = call i32 (i16*, i16*, i16*, i32, i32, i8*, ...) bitcast (i32 (...)* @non_max_supp to i32 (i16*, i16*, i16*, i32, i32, i8*, ...)*)(i16* %30, i16* %31, i16* %32, i32 %33, i32 %34, i8* %35)
  %36 = load i32, i32* %rows.addr, align 4
  %37 = load i32, i32* %cols.addr, align 4
  %mul16 = mul nsw i32 %36, %37
  %conv17 = sext i32 %mul16 to i64
  %llvm-call18 = call noalias i8* @calloc(i64 %conv17, i64 1) #8
  %38 = load i8**, i8*** %edge.addr, align 8
  store i8* %llvm-call18, i8** %38, align 8
  %cmp19 = icmp eq i8* %llvm-call18, null
  br i1 %cmp19, label %if.then21, label %if.end23

if.then21:                                        ; preds = %if.end14
  %39 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call22 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %39, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.22, i32 0, i32 0))
  call void @exit(i32 1) #6
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
  call void @free(i8* %49) #8
  %50 = load i16*, i16** %delta_x, align 8
  %51 = bitcast i16* %50 to i8*
  call void @free(i8* %51) #8
  %52 = load i16*, i16** %delta_y, align 8
  %53 = bitcast i16* %52 to i8*
  call void @free(i8* %53) #8
  %54 = load i16*, i16** %magnitude, align 8
  %55 = bitcast i16* %54 to i8*
  call void @free(i8* %55) #8
  %56 = load i8*, i8** %nms, align 8
  call void @free(i8* %56) #8
  ret void
}

declare i32 @write_pgm_image(i8*, i8*, i32, i32, i8*, i32) #1

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
  %llvm-call = call noalias i8* @calloc(i64 %conv, i64 4) #8
  %4 = bitcast i8* %llvm-call to float*
  store float* %4, float** %tempim, align 8
  %cmp = icmp eq float* %4, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %5 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call2 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %5, i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.26, i32 0, i32 0))
  call void @exit(i32 1) #6
  unreachable

if.end:                                           ; preds = %entry
  %6 = load i32, i32* %rows.addr, align 4
  %7 = load i32, i32* %cols.addr, align 4
  %mul3 = mul nsw i32 %6, %7
  %conv4 = sext i32 %mul3 to i64
  %llvm-call5 = call noalias i8* @calloc(i64 %conv4, i64 2) #8
  %8 = bitcast i8* %llvm-call5 to i16*
  %9 = load i16**, i16*** %smoothedim.addr, align 8
  store i16* %8, i16** %9, align 8
  %cmp6 = icmp eq i16* %8, null
  br i1 %cmp6, label %if.then8, label %if.end10

if.then8:                                         ; preds = %if.end
  %10 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call9 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %10, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.27, i32 0, i32 0))
  call void @exit(i32 1) #6
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
  call void @free(i8* %87) #8
  %88 = load float*, float** %kernel, align 8
  %89 = bitcast float* %88 to i8*
  call void @free(i8* %89) #8
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
  %llvm-call = call noalias i8* @calloc(i64 %conv, i64 2) #8
  %2 = bitcast i8* %llvm-call to i16*
  %3 = load i16**, i16*** %delta_x.addr, align 8
  store i16* %2, i16** %3, align 8
  %cmp = icmp eq i16* %2, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %4 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call2 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %4, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.25, i32 0, i32 0))
  call void @exit(i32 1) #6
  unreachable

if.end:                                           ; preds = %entry
  %5 = load i32, i32* %rows.addr, align 4
  %6 = load i32, i32* %cols.addr, align 4
  %mul3 = mul nsw i32 %5, %6
  %conv4 = sext i32 %mul3 to i64
  %llvm-call5 = call noalias i8* @calloc(i64 %conv4, i64 2) #8
  %7 = bitcast i8* %llvm-call5 to i16*
  %8 = load i16**, i16*** %delta_y.addr, align 8
  store i16* %7, i16** %8, align 8
  %cmp6 = icmp eq i16* %7, null
  br i1 %cmp6, label %if.then8, label %if.end10

if.then8:                                         ; preds = %if.end
  %9 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call9 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %9, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.25, i32 0, i32 0))
  call void @exit(i32 1) #6
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
  %llvm-call = call noalias i8* @calloc(i64 %conv, i64 4) #8
  %2 = bitcast i8* %llvm-call to float*
  store float* %2, float** %dirim, align 8
  %cmp = icmp eq float* %2, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %3 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call2 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %3, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.23, i32 0, i32 0))
  call void @exit(i32 1) #6
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
  %llvm-call = call noalias i8* @calloc(i64 %conv, i64 2) #8
  %2 = bitcast i8* %llvm-call to i16*
  %3 = load i16**, i16*** %magnitude.addr, align 8
  store i16* %2, i16** %3, align 8
  %cmp = icmp eq i16* %2, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %4 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call2 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %4, i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.24, i32 0, i32 0))
  call void @exit(i32 1) #6
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
  %llvm-call24 = call double @sqrt(double %conv23) #8
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

declare i32 @non_max_supp(...) #1

declare void @apply_hysteresis(i16*, i8*, i32, i32, float, float, i8*) #1

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
  %llvm-call = call double @atan(double %div) #8
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

; Function Attrs: nounwind
declare double @sqrt(double) #4

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
  %llvm-call = call noalias i8* @calloc(i64 %conv3, i64 4) #8
  %7 = bitcast i8* %llvm-call to float*
  %8 = load float**, float*** %kernel.addr, align 8
  store float* %7, float** %8, align 8
  %cmp = icmp eq float* %7, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %9 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %llvm-call5 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %9, i8* getelementptr inbounds ([44 x i8], [44 x i8]* @.str.28, i32 0, i32 0))
  call void @exit(i32 1) #6
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
  %llvm-call16 = call double @pow(double 2.718280e+00, double %div15) #8
  %19 = load float, float* %sigma.addr, align 4
  %conv17 = fpext float %19 to double
  %llvm-call18 = call double @sqrt(double 0x401921FB53C8D4F1) #8
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

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readnone speculatable }
attributes #6 = { noreturn nounwind }
attributes #7 = { nounwind readonly }
attributes #8 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.1 (tags/RELEASE_601/final)"}
