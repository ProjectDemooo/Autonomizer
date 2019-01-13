; ModuleID = 'hysteresis.c'
source_filename = "hysteresis.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@follow_edges.x = private unnamed_addr constant [8 x i32] [i32 1, i32 1, i32 0, i32 -1, i32 -1, i32 -1, i32 0, i32 1], align 16
@follow_edges.y = private unnamed_addr constant [8 x i32] [i32 0, i32 1, i32 1, i32 1, i32 0, i32 -1, i32 -1, i32 -1], align 16

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
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #1

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

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.1 (tags/RELEASE_601/final)"}
