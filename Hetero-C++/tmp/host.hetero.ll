; ModuleID = 'streaming-src/host.cpp'
source_filename = "streaming-src/host.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"class.std::__cxx11::basic_string" = type { %"struct.std::__cxx11::basic_string<char>::_Alloc_hider", i64, %union.anon }
%"struct.std::__cxx11::basic_string<char>::_Alloc_hider" = type { i8* }
%union.anon = type { i64, [8 x i8] }
%"class.std::basic_ostream" = type { i32 (...)**, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", %"class.std::basic_ostream"*, i8, i8, %"class.std::basic_streambuf"*, %"class.std::ctype"*, %"class.std::num_put"*, %"class.std::num_get"* }
%"class.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"class.std::locale" }
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"class.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"class.std::locale" = type { %"class.std::locale::_Impl"* }
%"class.std::locale::_Impl" = type { i32, %"class.std::locale::facet"**, i64, %"class.std::locale::facet"**, i8** }
%"class.std::locale::facet" = type <{ i32 (...)**, i32, [4 x i8] }>
%"class.std::basic_streambuf" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"class.std::locale" }
%"class.std::ctype" = type <{ %"class.std::locale::facet.base", [4 x i8], %struct.__locale_struct*, i8, [7 x i8], i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8, [6 x i8] }>
%"class.std::locale::facet.base" = type <{ i32 (...)**, i32 }>
%struct.__locale_struct = type { [13 x %struct.__locale_data*], i16*, i32*, i32*, [13 x i8*] }
%struct.__locale_data = type opaque
%"class.std::num_put" = type { %"class.std::locale::facet.base", [4 x i8] }
%"class.std::num_get" = type { %"class.std::locale::facet.base", [4 x i8] }
%"class.std::vector" = type { %"struct.std::_Vector_base" }
%"struct.std::_Vector_base" = type { %"struct.std::_Vector_base<int, std::allocator<int>>::_Vector_impl" }
%"struct.std::_Vector_base<int, std::allocator<int>>::_Vector_impl" = type { i32*, i32*, i32* }
%"class.std::basic_ifstream" = type { %"class.std::basic_istream.base", %"class.std::basic_filebuf", %"class.std::basic_ios" }
%"class.std::basic_istream.base" = type { i32 (...)**, i64 }
%"class.std::basic_filebuf" = type { %"class.std::basic_streambuf", %union.pthread_mutex_t, %"class.std::__basic_file", i32, %struct.__mbstate_t, %struct.__mbstate_t, %struct.__mbstate_t, i8*, i64, i8, i8, i8, i8, i8*, i8*, i8, %"class.std::codecvt"*, i8*, i64, i8*, i8* }
%union.pthread_mutex_t = type { %struct.__pthread_mutex_s }
%struct.__pthread_mutex_s = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%struct.__pthread_internal_list = type { %struct.__pthread_internal_list*, %struct.__pthread_internal_list* }
%"class.std::__basic_file" = type <{ %struct._IO_FILE*, i8, [7 x i8] }>
%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.__mbstate_t = type { i32, %union.anon.3 }
%union.anon.3 = type { i32 }
%"class.std::codecvt" = type { %"class.std::__codecvt_abstract_base.base", %struct.__locale_struct* }
%"class.std::__codecvt_abstract_base.base" = type { %"class.std::locale::facet.base" }
%"class.std::basic_istream" = type { i32 (...)**, i64, %"class.std::basic_ios" }
%"class.std::basic_ofstream" = type { %"class.std::basic_ostream.base", %"class.std::basic_filebuf", %"class.std::basic_ios" }
%"class.std::basic_ostream.base" = type { i32 (...)** }

$_ZNSt6vectorIiSaIiEEaSERKS1_ = comdat any

$_Z16rp_encoding_nodeILi32ELi617EEvPimS0_mS0_m = comdat any

$_Z9root_nodeILi32ELi1ELi6238ELi617EEvPimS0_mS0_mS0_mS0_miiS0_m = comdat any

$_ZNSt6vectorIiSaIiEE17_M_realloc_insertIJRKiEEEvN9__gnu_cxx17__normal_iteratorIPiS1_EEDpOT_ = comdat any

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external hidden global i8
@EPOCH = dso_local local_unnamed_addr global i32 1, align 4
@shuffled = dso_local local_unnamed_addr global i8 0, align 1
@_Z11X_data_pathB5cxx11 = dso_local global %"class.std::__cxx11::basic_string" zeroinitializer, align 8
@.str = private unnamed_addr constant [35 x i8] c"../dataset/isolet_train_trainX.bin\00", align 1
@_Z11y_data_pathB5cxx11 = dso_local global %"class.std::__cxx11::basic_string" zeroinitializer, align 8
@.str.3 = private unnamed_addr constant [35 x i8] c"../dataset/isolet_train_trainY.bin\00", align 1
@.str.5 = private unnamed_addr constant [41 x i8] c"file_.is_open() && \22Couldn't open file!\22\00", align 1
@.str.6 = private unnamed_addr constant [23 x i8] c"streaming-src/host.cpp\00", align 1
@__PRETTY_FUNCTION__._Z17datasetBinaryReadRSt6vectorIiSaIiEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE = private unnamed_addr constant [56 x i8] c"void datasetBinaryRead(std::vector<int> &, std::string)\00", align 1
@_ZSt4cout = external dso_local global %"class.std::basic_ostream", align 8
@.str.7 = private unnamed_addr constant [14 x i8] c"Main Starting\00", align 1
@.str.8 = private unnamed_addr constant [19 x i8] c"Read Data Starting\00", align 1
@.str.9 = private unnamed_addr constant [26 x i8] c"N_SAMPLE == y_data.size()\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [23 x i8] c"int main(int, char **)\00", align 1
@.str.10 = private unnamed_addr constant [19 x i8] c"Reading data took \00", align 1
@.str.11 = private unnamed_addr constant [6 x i8] c" mSec\00", align 1
@.str.12 = private unnamed_addr constant [18 x i8] c"Dimension over 32\00", align 1
@.str.13 = private unnamed_addr constant [23 x i8] c"After seed generation\0A\00", align 1
@.str.14 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.15 = private unnamed_addr constant [20 x i8] c"\0AReading data took \00", align 1
@.str.16 = private unnamed_addr constant [12 x i8] c"Execution (\00", align 1
@.str.17 = private unnamed_addr constant [16 x i8] c" epochs)  took \00", align 1
@.str.18 = private unnamed_addr constant [8 x i8] c"out.txt\00", align 1
@_ZTTSt14basic_ifstreamIcSt11char_traitsIcEE = external unnamed_addr constant [4 x i8*], align 8
@.str.21 = private unnamed_addr constant [2 x i8] c"[\00", align 1
@.str.22 = private unnamed_addr constant [3 x i8] c", \00", align 1
@.str.23 = private unnamed_addr constant [3 x i8] c"]\0A\00", align 1
@.str.24 = private unnamed_addr constant [10 x i8] c"Root_Task\00", align 1
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_host.cpp, i8* null }]

declare dso_local void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1)) unnamed_addr #0

; Function Attrs: nounwind
declare dso_local void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1)) unnamed_addr #1

; Function Attrs: nofree nounwind
declare dso_local i32 @__cxa_atexit(void (i8*)*, i8*, i8*) local_unnamed_addr #2

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #3

declare dso_local i32 @__gxx_personality_v0(...)

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #3

; Function Attrs: nounwind uwtable
declare dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32)) unnamed_addr #4 align 2

; Function Attrs: uwtable
define dso_local void @_Z17datasetBinaryReadRSt6vectorIiSaIiEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(%"class.std::vector"* nonnull align 8 dereferenceable(24) %data, %"class.std::__cxx11::basic_string"* nonnull %path) local_unnamed_addr #5 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %file_ = alloca %"class.std::basic_ifstream", align 8
  %size = alloca i32, align 4
  %temp = alloca i32, align 4
  %0 = bitcast %"class.std::basic_ifstream"* %file_ to i8*
  call void @llvm.lifetime.start.p0i8(i64 520, i8* nonnull %0) #18
  call void @_ZNSt14basic_ifstreamIcSt11char_traitsIcEEC1ERKNSt7__cxx1112basic_stringIcS1_SaIcEEESt13_Ios_Openmode(%"class.std::basic_ifstream"* nonnull align 8 dereferenceable(256) %file_, %"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %path, i32 12)
  %_M_file.i.i = getelementptr inbounds %"class.std::basic_ifstream", %"class.std::basic_ifstream"* %file_, i64 0, i32 1, i32 2
  %call.i.i = call zeroext i1 @_ZNKSt12__basic_fileIcE7is_openEv(%"class.std::__basic_file"* nonnull align 8 dereferenceable(9) %_M_file.i.i) #19
  br i1 %call.i.i, label %cond.end, label %cond.false

cond.false:                                       ; preds = %entry
  call void @__assert_fail(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.6, i64 0, i64 0), i32 30, i8* getelementptr inbounds ([56 x i8], [56 x i8]* @__PRETTY_FUNCTION__._Z17datasetBinaryReadRSt6vectorIiSaIiEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE, i64 0, i64 0)) #20
  unreachable

cond.end:                                         ; preds = %entry
  %1 = bitcast i32* %size to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %1) #18
  %2 = bitcast %"class.std::basic_ifstream"* %file_ to %"class.std::basic_istream"*
  %call4 = invoke nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSi4readEPcl(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) %2, i8* nonnull %1, i64 4)
          to label %invoke.cont3 unwind label %lpad2

invoke.cont3:                                     ; preds = %cond.end
  %3 = bitcast i32* %temp to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3) #18
  %_M_finish.i = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %data, i64 0, i32 0, i32 0, i32 1
  %_M_end_of_storage.i = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %data, i64 0, i32 0, i32 0, i32 2
  %4 = load i32, i32* %size, align 4, !tbaa !3
  %cmp23 = icmp sgt i32 %4, 0
  br i1 %cmp23, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.inc, %invoke.cont3
  %_M_filebuf.i = getelementptr inbounds %"class.std::basic_ifstream", %"class.std::basic_ifstream"* %file_, i64 0, i32 1
  %call.i20 = invoke %"class.std::basic_filebuf"* @_ZNSt13basic_filebufIcSt11char_traitsIcEE5closeEv(%"class.std::basic_filebuf"* nonnull align 8 dereferenceable(240) %_M_filebuf.i)
          to label %call.i.noexc unwind label %lpad9

call.i.noexc:                                     ; preds = %for.cond.cleanup
  %tobool.not.i = icmp eq %"class.std::basic_filebuf"* %call.i20, null
  br i1 %tobool.not.i, label %if.then.i, label %invoke.cont10

if.then.i:                                        ; preds = %call.i.noexc
  %5 = bitcast %"class.std::basic_ifstream"* %file_ to i8**
  %vtable.i = load i8*, i8** %5, align 8, !tbaa !7
  %vbase.offset.ptr.i = getelementptr i8, i8* %vtable.i, i64 -24
  %6 = bitcast i8* %vbase.offset.ptr.i to i64*
  %vbase.offset.i = load i64, i64* %6, align 8
  %add.ptr.i = getelementptr inbounds i8, i8* %0, i64 %vbase.offset.i
  %7 = bitcast i8* %add.ptr.i to %"class.std::basic_ios"*
  %_M_streambuf_state.i.i.i = getelementptr inbounds i8, i8* %add.ptr.i, i64 32
  %8 = bitcast i8* %_M_streambuf_state.i.i.i to i32*
  %9 = load i32, i32* %8, align 8, !tbaa !9
  %or.i.i.i = or i32 %9, 4
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* nonnull align 8 dereferenceable(264) %7, i32 %or.i.i.i)
          to label %invoke.cont10 unwind label %lpad9

lpad2:                                            ; preds = %cond.end
  %10 = landingpad { i8*, i32 }
          cleanup
  br label %ehcleanup11

for.body:                                         ; preds = %invoke.cont3, %for.inc
  %i.024 = phi i32 [ %inc, %for.inc ], [ 0, %invoke.cont3 ]
  %call7 = invoke nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSi4readEPcl(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) %2, i8* nonnull %3, i64 4)
          to label %invoke.cont6 unwind label %lpad5

invoke.cont6:                                     ; preds = %for.body
  %11 = load i32*, i32** %_M_finish.i, align 8, !tbaa !17
  %12 = load i32*, i32** %_M_end_of_storage.i, align 8, !tbaa !20
  %cmp.not.i = icmp eq i32* %11, %12
  br i1 %cmp.not.i, label %if.else.i, label %if.then.i21

if.then.i21:                                      ; preds = %invoke.cont6
  %13 = load i32, i32* %temp, align 4, !tbaa !3
  store i32 %13, i32* %11, align 4, !tbaa !3
  %incdec.ptr.i = getelementptr inbounds i32, i32* %11, i64 1
  store i32* %incdec.ptr.i, i32** %_M_finish.i, align 8, !tbaa !17
  br label %for.inc

if.else.i:                                        ; preds = %invoke.cont6
  invoke void @_ZNSt6vectorIiSaIiEE17_M_realloc_insertIJRKiEEEvN9__gnu_cxx17__normal_iteratorIPiS1_EEDpOT_(%"class.std::vector"* nonnull align 8 dereferenceable(24) %data, i32* %11, i32* nonnull align 4 dereferenceable(4) %temp)
          to label %for.inc unwind label %lpad5

for.inc:                                          ; preds = %if.then.i21, %if.else.i
  %inc = add nuw nsw i32 %i.024, 1
  %14 = load i32, i32* %size, align 4, !tbaa !3
  %cmp = icmp slt i32 %inc, %14
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !21

lpad5:                                            ; preds = %if.else.i, %for.body
  %15 = landingpad { i8*, i32 }
          cleanup
  br label %ehcleanup

invoke.cont10:                                    ; preds = %call.i.noexc, %if.then.i
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3) #18
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %1) #18
  call void @_ZNSt14basic_ifstreamIcSt11char_traitsIcEED2Ev(%"class.std::basic_ifstream"* nonnull align 8 dereferenceable(256) %file_, i8** getelementptr inbounds ([4 x i8*], [4 x i8*]* @_ZTTSt14basic_ifstreamIcSt11char_traitsIcEE, i64 0, i64 0)) #18
  %16 = getelementptr inbounds %"class.std::basic_ifstream", %"class.std::basic_ifstream"* %file_, i64 0, i32 2, i32 0
  call void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* nonnull align 8 dereferenceable(216) %16) #18
  call void @llvm.lifetime.end.p0i8(i64 520, i8* nonnull %0) #18
  ret void

lpad9:                                            ; preds = %if.then.i, %for.cond.cleanup
  %17 = landingpad { i8*, i32 }
          cleanup
  br label %ehcleanup

ehcleanup:                                        ; preds = %lpad9, %lpad5
  %.pn = phi { i8*, i32 } [ %15, %lpad5 ], [ %17, %lpad9 ]
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3) #18
  br label %ehcleanup11

ehcleanup11:                                      ; preds = %ehcleanup, %lpad2
  %.pn.pn = phi { i8*, i32 } [ %.pn, %ehcleanup ], [ %10, %lpad2 ]
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %1) #18
  call void @_ZNSt14basic_ifstreamIcSt11char_traitsIcEED2Ev(%"class.std::basic_ifstream"* nonnull align 8 dereferenceable(256) %file_, i8** getelementptr inbounds ([4 x i8*], [4 x i8*]* @_ZTTSt14basic_ifstreamIcSt11char_traitsIcEE, i64 0, i64 0)) #18
  %18 = getelementptr inbounds %"class.std::basic_ifstream", %"class.std::basic_ifstream"* %file_, i64 0, i32 2, i32 0
  call void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* nonnull align 8 dereferenceable(216) %18) #18
  call void @llvm.lifetime.end.p0i8(i64 520, i8* nonnull %0) #18
  resume { i8*, i32 } %.pn.pn
}

; Function Attrs: uwtable
declare dso_local void @_ZNSt14basic_ifstreamIcSt11char_traitsIcEEC1ERKNSt7__cxx1112basic_stringIcS1_SaIcEEESt13_Ios_Openmode(%"class.std::basic_ifstream"* nonnull align 8 dereferenceable(256), %"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32), i32) unnamed_addr #5 align 2

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) local_unnamed_addr #6

declare dso_local nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSi4readEPcl(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16), i8*, i64) local_unnamed_addr #0

; Function Attrs: norecurse uwtable
define dso_local i32 @main(i32 %argc, i8** nocapture readnone %argv) local_unnamed_addr #7 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %__dnew.i.i.i.i467 = alloca i64, align 8
  %__dnew.i.i.i.i = alloca i64, align 8
  %X_data = alloca %"class.std::vector", align 8
  %y_data = alloca %"class.std::vector", align 8
  %agg.tmp = alloca %"class.std::__cxx11::basic_string", align 8
  %agg.tmp7 = alloca %"class.std::__cxx11::basic_string", align 8
  %X_data_shuffled = alloca %"class.std::vector", align 8
  %y_data_shuffled = alloca %"class.std::vector", align 8
  %labels = alloca [6238 x i32], align 16
  %encoded_hv = alloca <32 x i32>, align 4
  %clusters = alloca <32 x i32>, align 4
  %clusters_temp = alloca <32 x i32>, align 4
  %rp_matrix = alloca [19744 x i32], align 4
  %myfile = alloca %"class.std::basic_ofstream", align 8
  %call = call i64 @_ZNSt6chrono3_V212system_clock3nowEv() #18
  %call1.i = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i8* nonnull getelementptr inbounds ([14 x i8], [14 x i8]* @.str.7, i64 0, i64 0), i64 13)
  %vtable.i = load i8*, i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !7
  %vbase.offset.ptr.i = getelementptr i8, i8* %vtable.i, i64 -24
  %0 = bitcast i8* %vbase.offset.ptr.i to i64*
  %vbase.offset.i = load i64, i64* %0, align 8
  %_M_ctype.i.idx.i = add nsw i64 %vbase.offset.i, 240
  %_M_ctype.i.i = getelementptr inbounds i8, i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %_M_ctype.i.idx.i
  %1 = bitcast i8* %_M_ctype.i.i to %"class.std::ctype"**
  %2 = load %"class.std::ctype"*, %"class.std::ctype"** %1, align 8, !tbaa !24
  %tobool.not.i.i.i723 = icmp eq %"class.std::ctype"* %2, null
  br i1 %tobool.not.i.i.i723, label %if.then.i.i.i724, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i

if.then.i.i.i724:                                 ; preds = %entry
  call void @_ZSt16__throw_bad_castv() #21
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i: ; preds = %entry
  %_M_widen_ok.i.i.i = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %2, i64 0, i32 8
  %3 = load i8, i8* %_M_widen_ok.i.i.i, align 8, !tbaa !27
  %tobool.not.i3.i.i = icmp eq i8 %3, 0
  br i1 %tobool.not.i3.i.i, label %if.end.i.i.i, label %if.then.i4.i.i

if.then.i4.i.i:                                   ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i
  %arrayidx.i.i.i = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %2, i64 0, i32 9, i64 10
  %4 = load i8, i8* %arrayidx.i.i.i, align 1, !tbaa !29
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit

if.end.i.i.i:                                     ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %2)
  %5 = bitcast %"class.std::ctype"* %2 to i8 (%"class.std::ctype"*, i8)***
  %vtable.i.i.i = load i8 (%"class.std::ctype"*, i8)**, i8 (%"class.std::ctype"*, i8)*** %5, align 8, !tbaa !7
  %vfn.i.i.i = getelementptr inbounds i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vtable.i.i.i, i64 6
  %6 = load i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vfn.i.i.i, align 8
  %call.i.i.i = call signext i8 %6(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %2, i8 signext 10)
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit

_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit: ; preds = %if.then.i4.i.i, %if.end.i.i.i
  %retval.0.i.i.i = phi i8 [ %4, %if.then.i4.i.i ], [ %call.i.i.i, %if.end.i.i.i ]
  %call1.i725 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i8 signext %retval.0.i.i.i)
  %call.i.i726 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call1.i725)
  %call4 = call i64 @time(i64* null) #18
  %conv = trunc i64 %call4 to i32
  call void @srand(i32 %conv) #18
  %7 = bitcast %"class.std::vector"* %X_data to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %7) #18
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(24) %7, i8 0, i64 24, i1 false) #18
  %8 = bitcast %"class.std::vector"* %y_data to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %8) #18
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(24) %8, i8 0, i64 24, i1 false) #18
  %9 = getelementptr inbounds %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* %agg.tmp, i64 0, i32 2
  %10 = bitcast %"class.std::__cxx11::basic_string"* %agg.tmp to %union.anon**
  store %union.anon* %9, %union.anon** %10, align 8, !tbaa !30
  %11 = load i8*, i8** getelementptr inbounds (%"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* @_Z11X_data_pathB5cxx11, i64 0, i32 0, i32 0), align 8, !tbaa !32
  %12 = load i64, i64* getelementptr inbounds (%"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* @_Z11X_data_pathB5cxx11, i64 0, i32 1), align 8, !tbaa !34
  %13 = bitcast i64* %__dnew.i.i.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %13) #18
  store i64 %12, i64* %__dnew.i.i.i.i, align 8, !tbaa !35
  %cmp3.i.i.i.i = icmp ugt i64 %12, 15
  br i1 %cmp3.i.i.i.i, label %if.then4.i.i.i.i, label %if.end6.i.i.i.i

if.then4.i.i.i.i:                                 ; preds = %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit
  %call5.i.i.i14.i466 = invoke i8* @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_createERmm(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %agg.tmp, i64* nonnull align 8 dereferenceable(8) %__dnew.i.i.i.i, i64 0)
          to label %call5.i.i.i14.i.noexc unwind label %lpad

call5.i.i.i14.i.noexc:                            ; preds = %if.then4.i.i.i.i
  %_M_p.i.i.i.i.i = getelementptr inbounds %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* %agg.tmp, i64 0, i32 0, i32 0
  store i8* %call5.i.i.i14.i466, i8** %_M_p.i.i.i.i.i, align 8, !tbaa !32
  %14 = load i64, i64* %__dnew.i.i.i.i, align 8, !tbaa !35
  %_M_allocated_capacity.i.i.i.i.i = getelementptr inbounds %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* %agg.tmp, i64 0, i32 2, i32 0
  store i64 %14, i64* %_M_allocated_capacity.i.i.i.i.i, align 8, !tbaa !29
  br label %if.end6.i.i.i.i

if.end6.i.i.i.i:                                  ; preds = %call5.i.i.i14.i.noexc, %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit
  %_M_p.i13.i.i.i.i = getelementptr inbounds %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* %agg.tmp, i64 0, i32 0, i32 0
  %15 = load i8*, i8** %_M_p.i13.i.i.i.i, align 8, !tbaa !32
  switch i64 %12, label %if.end.i.i.i.i.i.i.i [
    i64 1, label %if.then.i.i.i.i.i.i
    i64 0, label %_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2ERKS4_.exit
  ]

if.then.i.i.i.i.i.i:                              ; preds = %if.end6.i.i.i.i
  %16 = load i8, i8* %11, align 1, !tbaa !29
  store i8 %16, i8* %15, align 1, !tbaa !29
  br label %_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2ERKS4_.exit

if.end.i.i.i.i.i.i.i:                             ; preds = %if.end6.i.i.i.i
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %15, i8* align 1 %11, i64 %12, i1 false) #18
  br label %_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2ERKS4_.exit

_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2ERKS4_.exit: ; preds = %if.end6.i.i.i.i, %if.then.i.i.i.i.i.i, %if.end.i.i.i.i.i.i.i
  %17 = load i64, i64* %__dnew.i.i.i.i, align 8, !tbaa !35
  %_M_string_length.i.i.i.i.i.i = getelementptr inbounds %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* %agg.tmp, i64 0, i32 1
  store i64 %17, i64* %_M_string_length.i.i.i.i.i.i, align 8, !tbaa !34
  %18 = load i8*, i8** %_M_p.i13.i.i.i.i, align 8, !tbaa !32
  %arrayidx.i.i.i.i.i = getelementptr inbounds i8, i8* %18, i64 %17
  store i8 0, i8* %arrayidx.i.i.i.i.i, align 1, !tbaa !29
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %13) #18
  invoke void @_Z17datasetBinaryReadRSt6vectorIiSaIiEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(%"class.std::vector"* nonnull align 8 dereferenceable(24) %X_data, %"class.std::__cxx11::basic_string"* nonnull %agg.tmp)
          to label %invoke.cont6 unwind label %lpad5

invoke.cont6:                                     ; preds = %_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2ERKS4_.exit
  %19 = load i8*, i8** %_M_p.i13.i.i.i.i, align 8, !tbaa !32
  %arraydecay.i.i.i.i = bitcast %union.anon* %9 to i8*
  %cmp.i.i.i = icmp eq i8* %19, %arraydecay.i.i.i.i
  br i1 %cmp.i.i.i, label %_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev.exit, label %if.then.i.i

if.then.i.i:                                      ; preds = %invoke.cont6
  call void @_ZdlPv(i8* %19) #18
  br label %_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev.exit

_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev.exit: ; preds = %invoke.cont6, %if.then.i.i
  %20 = getelementptr inbounds %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* %agg.tmp7, i64 0, i32 2
  %21 = bitcast %"class.std::__cxx11::basic_string"* %agg.tmp7 to %union.anon**
  store %union.anon* %20, %union.anon** %21, align 8, !tbaa !30
  %22 = load i8*, i8** getelementptr inbounds (%"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* @_Z11y_data_pathB5cxx11, i64 0, i32 0, i32 0), align 8, !tbaa !32
  %23 = load i64, i64* getelementptr inbounds (%"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* @_Z11y_data_pathB5cxx11, i64 0, i32 1), align 8, !tbaa !34
  %24 = bitcast i64* %__dnew.i.i.i.i467 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %24) #18
  store i64 %23, i64* %__dnew.i.i.i.i467, align 8, !tbaa !35
  %cmp3.i.i.i.i468 = icmp ugt i64 %23, 15
  br i1 %cmp3.i.i.i.i468, label %if.then4.i.i.i.i471, label %if.end6.i.i.i.i473

if.then4.i.i.i.i471:                              ; preds = %_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev.exit
  %call5.i.i.i14.i479 = invoke i8* @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_createERmm(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %agg.tmp7, i64* nonnull align 8 dereferenceable(8) %__dnew.i.i.i.i467, i64 0)
          to label %call5.i.i.i14.i.noexc478 unwind label %lpad

call5.i.i.i14.i.noexc478:                         ; preds = %if.then4.i.i.i.i471
  %_M_p.i.i.i.i.i469 = getelementptr inbounds %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* %agg.tmp7, i64 0, i32 0, i32 0
  store i8* %call5.i.i.i14.i479, i8** %_M_p.i.i.i.i.i469, align 8, !tbaa !32
  %25 = load i64, i64* %__dnew.i.i.i.i467, align 8, !tbaa !35
  %_M_allocated_capacity.i.i.i.i.i470 = getelementptr inbounds %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* %agg.tmp7, i64 0, i32 2, i32 0
  store i64 %25, i64* %_M_allocated_capacity.i.i.i.i.i470, align 8, !tbaa !29
  br label %if.end6.i.i.i.i473

if.end6.i.i.i.i473:                               ; preds = %call5.i.i.i14.i.noexc478, %_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev.exit
  %_M_p.i13.i.i.i.i472 = getelementptr inbounds %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* %agg.tmp7, i64 0, i32 0, i32 0
  %26 = load i8*, i8** %_M_p.i13.i.i.i.i472, align 8, !tbaa !32
  switch i64 %23, label %if.end.i.i.i.i.i.i.i475 [
    i64 1, label %if.then.i.i.i.i.i.i474
    i64 0, label %_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2ERKS4_.exit480
  ]

if.then.i.i.i.i.i.i474:                           ; preds = %if.end6.i.i.i.i473
  %27 = load i8, i8* %22, align 1, !tbaa !29
  store i8 %27, i8* %26, align 1, !tbaa !29
  br label %_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2ERKS4_.exit480

if.end.i.i.i.i.i.i.i475:                          ; preds = %if.end6.i.i.i.i473
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %26, i8* align 1 %22, i64 %23, i1 false) #18
  br label %_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2ERKS4_.exit480

_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2ERKS4_.exit480: ; preds = %if.end6.i.i.i.i473, %if.then.i.i.i.i.i.i474, %if.end.i.i.i.i.i.i.i475
  %28 = load i64, i64* %__dnew.i.i.i.i467, align 8, !tbaa !35
  %_M_string_length.i.i.i.i.i.i476 = getelementptr inbounds %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* %agg.tmp7, i64 0, i32 1
  store i64 %28, i64* %_M_string_length.i.i.i.i.i.i476, align 8, !tbaa !34
  %29 = load i8*, i8** %_M_p.i13.i.i.i.i472, align 8, !tbaa !32
  %arrayidx.i.i.i.i.i477 = getelementptr inbounds i8, i8* %29, i64 %28
  store i8 0, i8* %arrayidx.i.i.i.i.i477, align 1, !tbaa !29
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %24) #18
  invoke void @_Z17datasetBinaryReadRSt6vectorIiSaIiEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(%"class.std::vector"* nonnull align 8 dereferenceable(24) %y_data, %"class.std::__cxx11::basic_string"* nonnull %agg.tmp7)
          to label %invoke.cont10 unwind label %lpad9

invoke.cont10:                                    ; preds = %_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2ERKS4_.exit480
  %30 = load i8*, i8** %_M_p.i13.i.i.i.i472, align 8, !tbaa !32
  %arraydecay.i.i.i.i482 = bitcast %union.anon* %20 to i8*
  %cmp.i.i.i483 = icmp eq i8* %30, %arraydecay.i.i.i.i482
  br i1 %cmp.i.i.i483, label %_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev.exit485, label %if.then.i.i484

if.then.i.i484:                                   ; preds = %invoke.cont10
  call void @_ZdlPv(i8* %30) #18
  br label %_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev.exit485

_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev.exit485: ; preds = %invoke.cont10, %if.then.i.i484
  %call1.i487488 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i8* nonnull getelementptr inbounds ([19 x i8], [19 x i8]* @.str.8, i64 0, i64 0), i64 18)
          to label %invoke.cont11 unwind label %lpad

invoke.cont11:                                    ; preds = %_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev.exit485
  %vtable.i727 = load i8*, i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !7
  %vbase.offset.ptr.i728 = getelementptr i8, i8* %vtable.i727, i64 -24
  %31 = bitcast i8* %vbase.offset.ptr.i728 to i64*
  %vbase.offset.i729 = load i64, i64* %31, align 8
  %_M_ctype.i.idx.i730 = add nsw i64 %vbase.offset.i729, 240
  %_M_ctype.i.i731 = getelementptr inbounds i8, i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %_M_ctype.i.idx.i730
  %32 = bitcast i8* %_M_ctype.i.i731 to %"class.std::ctype"**
  %33 = load %"class.std::ctype"*, %"class.std::ctype"** %32, align 8, !tbaa !24
  %tobool.not.i.i.i732 = icmp eq %"class.std::ctype"* %33, null
  br i1 %tobool.not.i.i.i732, label %if.then.i.i.i733, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i736

if.then.i.i.i733:                                 ; preds = %invoke.cont11
  invoke void @_ZSt16__throw_bad_castv() #21
          to label %.noexc746 unwind label %lpad

.noexc746:                                        ; preds = %if.then.i.i.i733
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i736: ; preds = %invoke.cont11
  %_M_widen_ok.i.i.i734 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %33, i64 0, i32 8
  %34 = load i8, i8* %_M_widen_ok.i.i.i734, align 8, !tbaa !27
  %tobool.not.i3.i.i735 = icmp eq i8 %34, 0
  br i1 %tobool.not.i3.i.i735, label %if.end.i.i.i742, label %if.then.i4.i.i738

if.then.i4.i.i738:                                ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i736
  %arrayidx.i.i.i737 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %33, i64 0, i32 9, i64 10
  %35 = load i8, i8* %arrayidx.i.i.i737, align 1, !tbaa !29
  br label %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i

if.end.i.i.i742:                                  ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i736
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %33)
          to label %.noexc747 unwind label %lpad

.noexc747:                                        ; preds = %if.end.i.i.i742
  %36 = bitcast %"class.std::ctype"* %33 to i8 (%"class.std::ctype"*, i8)***
  %vtable.i.i.i739 = load i8 (%"class.std::ctype"*, i8)**, i8 (%"class.std::ctype"*, i8)*** %36, align 8, !tbaa !7
  %vfn.i.i.i740 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vtable.i.i.i739, i64 6
  %37 = load i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vfn.i.i.i740, align 8
  %call.i.i.i741748 = invoke signext i8 %37(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %33, i8 signext 10)
          to label %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i unwind label %lpad

_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i: ; preds = %.noexc747, %if.then.i4.i.i738
  %retval.0.i.i.i743 = phi i8 [ %35, %if.then.i4.i.i738 ], [ %call.i.i.i741748, %.noexc747 ]
  %call1.i744749 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i8 signext %retval.0.i.i.i743)
          to label %call1.i744.noexc unwind label %lpad

call1.i744.noexc:                                 ; preds = %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i
  %call.i.i745750 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call1.i744749)
          to label %invoke.cont13 unwind label %lpad

invoke.cont13:                                    ; preds = %call1.i744.noexc
  %_M_finish.i = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %y_data, i64 0, i32 0, i32 0, i32 1
  %38 = load i32*, i32** %_M_finish.i, align 8, !tbaa !17
  %_M_start.i = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %y_data, i64 0, i32 0, i32 0, i32 0
  %39 = load i32*, i32** %_M_start.i, align 8, !tbaa !36
  %sub.ptr.lhs.cast.i = ptrtoint i32* %38 to i64
  %sub.ptr.rhs.cast.i = ptrtoint i32* %39 to i64
  %sub.ptr.sub.i = sub i64 %sub.ptr.lhs.cast.i, %sub.ptr.rhs.cast.i
  %sub.ptr.div.i = ashr exact i64 %sub.ptr.sub.i, 2
  %40 = call i8* @llvm.stacksave()
  %vla = alloca i32, i64 %sub.ptr.div.i, align 16
  call void @srand(i32 0) #18
  %41 = load i8, i8* @shuffled, align 1, !tbaa !37, !range !38
  %tobool.not = icmp eq i8 %41, 0
  br i1 %tobool.not, label %if.end, label %if.then

if.then:                                          ; preds = %invoke.cont13
  %42 = bitcast %"class.std::vector"* %X_data_shuffled to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %42) #18
  %_M_finish.i491 = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %X_data, i64 0, i32 0, i32 0, i32 1
  %43 = load i32*, i32** %_M_finish.i491, align 8, !tbaa !17
  %_M_start.i492 = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %X_data, i64 0, i32 0, i32 0, i32 0
  %44 = load i32*, i32** %_M_start.i492, align 8, !tbaa !36
  %sub.ptr.lhs.cast.i493 = ptrtoint i32* %43 to i64
  %sub.ptr.rhs.cast.i494 = ptrtoint i32* %44 to i64
  %sub.ptr.sub.i495 = sub i64 %sub.ptr.lhs.cast.i493, %sub.ptr.rhs.cast.i494
  %sub.ptr.div.i496 = ashr exact i64 %sub.ptr.sub.i495, 2
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(24) %42, i8 0, i64 24, i1 false) #18
  %cmp.not.i.i.i.i = icmp eq i64 %sub.ptr.sub.i495, 0
  br i1 %cmp.not.i.i.i.i, label %_ZNSt12_Vector_baseIiSaIiEEC2EmRKS0_.exit.i, label %cond.true.i.i.i.i

cond.true.i.i.i.i:                                ; preds = %if.then
  %cmp.i.i.i.i.i.i = icmp slt i64 %sub.ptr.sub.i495, 0
  br i1 %cmp.i.i.i.i.i.i, label %if.then.i.i.i.i.i.i497, label %_ZNSt16allocator_traitsISaIiEE8allocateERS0_m.exit.i.i.i.i

if.then.i.i.i.i.i.i497:                           ; preds = %cond.true.i.i.i.i
  invoke void @_ZSt17__throw_bad_allocv() #21
          to label %.noexc unwind label %lpad17

.noexc:                                           ; preds = %if.then.i.i.i.i.i.i497
  unreachable

_ZNSt16allocator_traitsISaIiEE8allocateERS0_m.exit.i.i.i.i: ; preds = %cond.true.i.i.i.i
  %call2.i.i.i.i3.i.i498 = invoke noalias nonnull i8* @_Znwm(i64 %sub.ptr.sub.i495) #22
          to label %call2.i.i.i.i3.i.i.noexc unwind label %lpad17

call2.i.i.i.i3.i.i.noexc:                         ; preds = %_ZNSt16allocator_traitsISaIiEE8allocateERS0_m.exit.i.i.i.i
  %45 = bitcast i8* %call2.i.i.i.i3.i.i498 to i32*
  br label %_ZNSt12_Vector_baseIiSaIiEEC2EmRKS0_.exit.i

_ZNSt12_Vector_baseIiSaIiEEC2EmRKS0_.exit.i:      ; preds = %call2.i.i.i.i3.i.i.noexc, %if.then
  %cond.i.i.i.i = phi i32* [ %45, %call2.i.i.i.i3.i.i.noexc ], [ null, %if.then ]
  %_M_start.i.i.i = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %X_data_shuffled, i64 0, i32 0, i32 0, i32 0
  store i32* %cond.i.i.i.i, i32** %_M_start.i.i.i, align 8, !tbaa !36
  %_M_finish.i.i.i = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %X_data_shuffled, i64 0, i32 0, i32 0, i32 1
  store i32* %cond.i.i.i.i, i32** %_M_finish.i.i.i, align 8, !tbaa !17
  %add.ptr.i.i.i = getelementptr i32, i32* %cond.i.i.i.i, i64 %sub.ptr.div.i496
  %_M_end_of_storage.i.i.i = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %X_data_shuffled, i64 0, i32 0, i32 0, i32 2
  store i32* %add.ptr.i.i.i, i32** %_M_end_of_storage.i.i.i, align 8, !tbaa !20
  br i1 %cmp.not.i.i.i.i, label %_ZNSt6vectorIiSaIiEEC2EmRKS0_.exit, label %for.body.i.i.preheader.i.i.i.i.i

for.body.i.i.preheader.i.i.i.i.i:                 ; preds = %_ZNSt12_Vector_baseIiSaIiEEC2EmRKS0_.exit.i
  %__first2.i.i.i.i.i = bitcast i32* %cond.i.i.i.i to i8*
  call void @llvm.memset.p0i8.i64(i8* align 4 %__first2.i.i.i.i.i, i8 0, i64 %sub.ptr.sub.i495, i1 false)
  br label %_ZNSt6vectorIiSaIiEEC2EmRKS0_.exit

_ZNSt6vectorIiSaIiEEC2EmRKS0_.exit:               ; preds = %_ZNSt12_Vector_baseIiSaIiEEC2EmRKS0_.exit.i, %for.body.i.i.preheader.i.i.i.i.i
  %__first.addr.0.lcssa.i.i.i.i.i.i.i = phi i32* [ %cond.i.i.i.i, %_ZNSt12_Vector_baseIiSaIiEEC2EmRKS0_.exit.i ], [ %add.ptr.i.i.i, %for.body.i.i.preheader.i.i.i.i.i ]
  store i32* %__first.addr.0.lcssa.i.i.i.i.i.i.i, i32** %_M_finish.i.i.i, align 8, !tbaa !17
  %46 = bitcast %"class.std::vector"* %y_data_shuffled to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %46) #18
  %47 = load i32*, i32** %_M_finish.i, align 8, !tbaa !17
  %48 = load i32*, i32** %_M_start.i, align 8, !tbaa !36
  %sub.ptr.lhs.cast.i501 = ptrtoint i32* %47 to i64
  %sub.ptr.rhs.cast.i502 = ptrtoint i32* %48 to i64
  %sub.ptr.sub.i503 = sub i64 %sub.ptr.lhs.cast.i501, %sub.ptr.rhs.cast.i502
  %sub.ptr.div.i504 = ashr exact i64 %sub.ptr.sub.i503, 2
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(24) %46, i8 0, i64 24, i1 false) #18
  %cmp.not.i.i.i.i505 = icmp eq i64 %sub.ptr.sub.i503, 0
  br i1 %cmp.not.i.i.i.i505, label %_ZNSt12_Vector_baseIiSaIiEEC2EmRKS0_.exit.i516, label %cond.true.i.i.i.i507

cond.true.i.i.i.i507:                             ; preds = %_ZNSt6vectorIiSaIiEEC2EmRKS0_.exit
  %cmp.i.i.i.i.i.i506 = icmp slt i64 %sub.ptr.sub.i503, 0
  br i1 %cmp.i.i.i.i.i.i506, label %if.then.i.i.i.i.i.i508, label %_ZNSt16allocator_traitsISaIiEE8allocateERS0_m.exit.i.i.i.i509

if.then.i.i.i.i.i.i508:                           ; preds = %cond.true.i.i.i.i507
  invoke void @_ZSt17__throw_bad_allocv() #21
          to label %.noexc522 unwind label %lpad21

.noexc522:                                        ; preds = %if.then.i.i.i.i.i.i508
  unreachable

_ZNSt16allocator_traitsISaIiEE8allocateERS0_m.exit.i.i.i.i509: ; preds = %cond.true.i.i.i.i507
  %call2.i.i.i.i3.i.i524 = invoke noalias nonnull i8* @_Znwm(i64 %sub.ptr.sub.i503) #22
          to label %call2.i.i.i.i3.i.i.noexc523 unwind label %lpad21

call2.i.i.i.i3.i.i.noexc523:                      ; preds = %_ZNSt16allocator_traitsISaIiEE8allocateERS0_m.exit.i.i.i.i509
  %49 = bitcast i8* %call2.i.i.i.i3.i.i524 to i32*
  br label %_ZNSt12_Vector_baseIiSaIiEEC2EmRKS0_.exit.i516

_ZNSt12_Vector_baseIiSaIiEEC2EmRKS0_.exit.i516:   ; preds = %call2.i.i.i.i3.i.i.noexc523, %_ZNSt6vectorIiSaIiEEC2EmRKS0_.exit
  %cond.i.i.i.i510 = phi i32* [ %49, %call2.i.i.i.i3.i.i.noexc523 ], [ null, %_ZNSt6vectorIiSaIiEEC2EmRKS0_.exit ]
  %_M_start.i.i.i511 = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %y_data_shuffled, i64 0, i32 0, i32 0, i32 0
  store i32* %cond.i.i.i.i510, i32** %_M_start.i.i.i511, align 8, !tbaa !36
  %_M_finish.i.i.i512 = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %y_data_shuffled, i64 0, i32 0, i32 0, i32 1
  store i32* %cond.i.i.i.i510, i32** %_M_finish.i.i.i512, align 8, !tbaa !17
  %add.ptr.i.i.i513 = getelementptr i32, i32* %cond.i.i.i.i510, i64 %sub.ptr.div.i504
  %_M_end_of_storage.i.i.i514 = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %y_data_shuffled, i64 0, i32 0, i32 0, i32 2
  store i32* %add.ptr.i.i.i513, i32** %_M_end_of_storage.i.i.i514, align 8, !tbaa !20
  br i1 %cmp.not.i.i.i.i505, label %_ZNSt6vectorIiSaIiEEC2EmRKS0_.exit525, label %for.body.i.i.preheader.i.i.i.i.i519

for.body.i.i.preheader.i.i.i.i.i519:              ; preds = %_ZNSt12_Vector_baseIiSaIiEEC2EmRKS0_.exit.i516
  %__first2.i.i.i.i.i517 = bitcast i32* %cond.i.i.i.i510 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 4 %__first2.i.i.i.i.i517, i8 0, i64 %sub.ptr.sub.i503, i1 false)
  br label %_ZNSt6vectorIiSaIiEEC2EmRKS0_.exit525

_ZNSt6vectorIiSaIiEEC2EmRKS0_.exit525:            ; preds = %_ZNSt12_Vector_baseIiSaIiEEC2EmRKS0_.exit.i516, %for.body.i.i.preheader.i.i.i.i.i519
  %__first.addr.0.lcssa.i.i.i.i.i.i.i520 = phi i32* [ %cond.i.i.i.i510, %_ZNSt12_Vector_baseIiSaIiEEC2EmRKS0_.exit.i516 ], [ %add.ptr.i.i.i513, %for.body.i.i.preheader.i.i.i.i.i519 ]
  store i32* %__first.addr.0.lcssa.i.i.i.i.i.i.i520, i32** %_M_finish.i.i.i512, align 8, !tbaa !17
  %50 = load i32*, i32** %_M_finish.i, align 8, !tbaa !17
  %51 = load i32*, i32** %_M_start.i, align 8, !tbaa !36
  %sub.ptr.lhs.cast.i528 = ptrtoint i32* %50 to i64
  %sub.ptr.rhs.cast.i529 = ptrtoint i32* %51 to i64
  %sub.ptr.sub.i530 = sub i64 %sub.ptr.lhs.cast.i528, %sub.ptr.rhs.cast.i529
  %sub.ptr.div.i531 = ashr exact i64 %sub.ptr.sub.i530, 2
  %cmp942.not = icmp eq i64 %sub.ptr.sub.i530, 0
  br i1 %cmp942.not, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %_ZNSt6vectorIiSaIiEEC2EmRKS0_.exit525
  %umax = call i64 @llvm.umax.i64(i64 %sub.ptr.div.i531, i64 1)
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %_ZNSt6vectorIiSaIiEEC2EmRKS0_.exit525
  %52 = trunc i64 %sub.ptr.div.i531 to i32
  %i25.0945 = add i32 %52, -1
  %cmp29.not946 = icmp eq i32 %i25.0945, 0
  br i1 %cmp29.not946, label %for.cond44.preheader, label %for.body31

lpad:                                             ; preds = %call1.i744.noexc, %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i, %.noexc747, %if.end.i.i.i742, %if.then.i.i.i733, %_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev.exit485, %if.then4.i.i.i.i471, %if.then4.i.i.i.i
  %53 = landingpad { i8*, i32 }
          cleanup
  br label %ehcleanup329

lpad5:                                            ; preds = %_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2ERKS4_.exit
  %54 = landingpad { i8*, i32 }
          cleanup
  %55 = load i8*, i8** %_M_p.i13.i.i.i.i, align 8, !tbaa !32
  %arraydecay.i.i.i.i539 = bitcast %union.anon* %9 to i8*
  %cmp.i.i.i540 = icmp eq i8* %55, %arraydecay.i.i.i.i539
  br i1 %cmp.i.i.i540, label %ehcleanup329, label %if.then.i.i541

if.then.i.i541:                                   ; preds = %lpad5
  call void @_ZdlPv(i8* %55) #18
  br label %ehcleanup329

lpad9:                                            ; preds = %_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2ERKS4_.exit480
  %56 = landingpad { i8*, i32 }
          cleanup
  %57 = load i8*, i8** %_M_p.i13.i.i.i.i472, align 8, !tbaa !32
  %arraydecay.i.i.i.i544 = bitcast %union.anon* %20 to i8*
  %cmp.i.i.i545 = icmp eq i8* %57, %arraydecay.i.i.i.i544
  br i1 %cmp.i.i.i545, label %ehcleanup329, label %if.then.i.i546

if.then.i.i546:                                   ; preds = %lpad9
  call void @_ZdlPv(i8* %57) #18
  br label %ehcleanup329

lpad17:                                           ; preds = %_ZNSt16allocator_traitsISaIiEE8allocateERS0_m.exit.i.i.i.i, %if.then.i.i.i.i.i.i497
  %58 = landingpad { i8*, i32 }
          cleanup
  br label %ehcleanup81

lpad21:                                           ; preds = %_ZNSt16allocator_traitsISaIiEE8allocateERS0_m.exit.i.i.i.i509, %if.then.i.i.i.i.i.i508
  %59 = landingpad { i8*, i32 }
          cleanup
  br label %ehcleanup

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i32, i32* %vla, i64 %indvars.iv
  %60 = trunc i64 %indvars.iv to i32
  store i32 %60, i32* %arrayidx, align 4, !tbaa !3
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %umax
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !39

for.cond44.preheader:                             ; preds = %for.body31, %for.cond.cleanup
  %61 = load i32*, i32** %_M_finish.i, align 8, !tbaa !17
  %62 = load i32*, i32** %_M_start.i, align 8, !tbaa !36
  %sub.ptr.lhs.cast.i550 = ptrtoint i32* %61 to i64
  %sub.ptr.rhs.cast.i551 = ptrtoint i32* %62 to i64
  %sub.ptr.sub.i552 = sub i64 %sub.ptr.lhs.cast.i550, %sub.ptr.rhs.cast.i551
  %63 = load i32*, i32** %_M_start.i.i.i511, align 8
  %64 = load i32*, i32** %_M_start.i492, align 8
  %65 = load i32*, i32** %_M_start.i.i.i, align 8
  %cmp47949.not = icmp eq i64 %sub.ptr.sub.i552, 0
  br i1 %cmp47949.not, label %for.cond.cleanup48, label %for.body49.preheader

for.body49.preheader:                             ; preds = %for.cond44.preheader
  %sub.ptr.div.i553 = ashr exact i64 %sub.ptr.sub.i552, 2
  %umax972 = call i64 @llvm.umax.i64(i64 %sub.ptr.div.i553, i64 1)
  br label %for.body49

for.body31:                                       ; preds = %for.cond.cleanup, %for.body31
  %i25.0947 = phi i32 [ %i25.0, %for.body31 ], [ %i25.0945, %for.cond.cleanup ]
  %call32 = call i32 @rand() #18
  %rem = srem i32 %call32, %i25.0947
  %idxprom33 = sext i32 %i25.0947 to i64
  %arrayidx34 = getelementptr inbounds i32, i32* %vla, i64 %idxprom33
  %66 = load i32, i32* %arrayidx34, align 4, !tbaa !3
  %idxprom35 = sext i32 %rem to i64
  %arrayidx36 = getelementptr inbounds i32, i32* %vla, i64 %idxprom35
  %67 = load i32, i32* %arrayidx36, align 4, !tbaa !3
  store i32 %67, i32* %arrayidx34, align 4, !tbaa !3
  store i32 %66, i32* %arrayidx36, align 4, !tbaa !3
  %i25.0 = add i32 %i25.0947, -1
  %cmp29.not = icmp eq i32 %i25.0, 0
  br i1 %cmp29.not, label %for.cond44.preheader, label %for.body31, !llvm.loop !40

for.cond.cleanup48:                               ; preds = %for.cond.cleanup59, %for.cond44.preheader
  %call77 = invoke nonnull align 8 dereferenceable(24) %"class.std::vector"* @_ZNSt6vectorIiSaIiEEaSERKS1_(%"class.std::vector"* nonnull align 8 dereferenceable(24) %X_data, %"class.std::vector"* nonnull align 8 dereferenceable(24) %X_data_shuffled)
          to label %invoke.cont76 unwind label %lpad75

for.body49:                                       ; preds = %for.body49.preheader, %for.cond.cleanup59
  %indvars.iv969 = phi i64 [ 0, %for.body49.preheader ], [ %indvars.iv.next970, %for.cond.cleanup59 ]
  %arrayidx51 = getelementptr inbounds i32, i32* %vla, i64 %indvars.iv969
  %68 = load i32, i32* %arrayidx51, align 4, !tbaa !3
  %conv52 = sext i32 %68 to i64
  %add.ptr.i = getelementptr inbounds i32, i32* %62, i64 %conv52
  %69 = load i32, i32* %add.ptr.i, align 4, !tbaa !3
  %add.ptr.i556 = getelementptr inbounds i32, i32* %63, i64 %indvars.iv969
  store i32 %69, i32* %add.ptr.i556, align 4, !tbaa !3
  %mul = mul nsw i32 %68, 617
  %70 = mul nuw nsw i64 %indvars.iv969, 617
  %71 = sext i32 %mul to i64
  br label %for.body60

for.cond.cleanup59:                               ; preds = %for.body60
  %indvars.iv.next970 = add nuw nsw i64 %indvars.iv969, 1
  %exitcond973.not = icmp eq i64 %indvars.iv.next970, %umax972
  br i1 %exitcond973.not, label %for.cond.cleanup48, label %for.body49, !llvm.loop !41

for.body60:                                       ; preds = %for.body49, %for.body60
  %indvars.iv964 = phi i64 [ 0, %for.body49 ], [ %indvars.iv.next965, %for.body60 ]
  %72 = add nsw i64 %indvars.iv964, %71
  %add.ptr.i558 = getelementptr inbounds i32, i32* %64, i64 %72
  %73 = load i32, i32* %add.ptr.i558, align 4, !tbaa !3
  %74 = add nuw nsw i64 %indvars.iv964, %70
  %add.ptr.i560 = getelementptr inbounds i32, i32* %65, i64 %74
  store i32 %73, i32* %add.ptr.i560, align 4, !tbaa !3
  %indvars.iv.next965 = add nuw nsw i64 %indvars.iv964, 1
  %exitcond968.not = icmp eq i64 %indvars.iv.next965, 617
  br i1 %exitcond968.not, label %for.cond.cleanup59, label %for.body60, !llvm.loop !42

invoke.cont76:                                    ; preds = %for.cond.cleanup48
  %call79 = invoke nonnull align 8 dereferenceable(24) %"class.std::vector"* @_ZNSt6vectorIiSaIiEEaSERKS1_(%"class.std::vector"* nonnull align 8 dereferenceable(24) %y_data, %"class.std::vector"* nonnull align 8 dereferenceable(24) %y_data_shuffled)
          to label %invoke.cont78 unwind label %lpad75

invoke.cont78:                                    ; preds = %invoke.cont76
  %75 = load i32*, i32** %_M_start.i.i.i511, align 8, !tbaa !36
  %tobool.not.i.i.i = icmp eq i32* %75, null
  br i1 %tobool.not.i.i.i, label %_ZNSt6vectorIiSaIiEED2Ev.exit, label %if.then.i.i.i

if.then.i.i.i:                                    ; preds = %invoke.cont78
  %76 = bitcast i32* %75 to i8*
  call void @_ZdlPv(i8* nonnull %76) #18
  br label %_ZNSt6vectorIiSaIiEED2Ev.exit

_ZNSt6vectorIiSaIiEED2Ev.exit:                    ; preds = %invoke.cont78, %if.then.i.i.i
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %46) #18
  %77 = load i32*, i32** %_M_start.i.i.i, align 8, !tbaa !36
  %tobool.not.i.i.i563 = icmp eq i32* %77, null
  br i1 %tobool.not.i.i.i563, label %_ZNSt6vectorIiSaIiEED2Ev.exit565, label %if.then.i.i.i564

if.then.i.i.i564:                                 ; preds = %_ZNSt6vectorIiSaIiEED2Ev.exit
  %78 = bitcast i32* %77 to i8*
  call void @_ZdlPv(i8* nonnull %78) #18
  br label %_ZNSt6vectorIiSaIiEED2Ev.exit565

_ZNSt6vectorIiSaIiEED2Ev.exit565:                 ; preds = %_ZNSt6vectorIiSaIiEED2Ev.exit, %if.then.i.i.i564
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %42) #18
  br label %if.end

lpad75:                                           ; preds = %invoke.cont76, %for.cond.cleanup48
  %79 = landingpad { i8*, i32 }
          cleanup
  %80 = load i32*, i32** %_M_start.i.i.i511, align 8, !tbaa !36
  %tobool.not.i.i.i567 = icmp eq i32* %80, null
  br i1 %tobool.not.i.i.i567, label %ehcleanup, label %if.then.i.i.i568

if.then.i.i.i568:                                 ; preds = %lpad75
  %81 = bitcast i32* %80 to i8*
  call void @_ZdlPv(i8* nonnull %81) #18
  br label %ehcleanup

ehcleanup:                                        ; preds = %if.then.i.i.i568, %lpad75, %lpad21
  %.pn462 = phi { i8*, i32 } [ %59, %lpad21 ], [ %79, %lpad75 ], [ %79, %if.then.i.i.i568 ]
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %46) #18
  %82 = load i32*, i32** %_M_start.i.i.i, align 8, !tbaa !36
  %tobool.not.i.i.i571 = icmp eq i32* %82, null
  br i1 %tobool.not.i.i.i571, label %ehcleanup81, label %if.then.i.i.i572

if.then.i.i.i572:                                 ; preds = %ehcleanup
  %83 = bitcast i32* %82 to i8*
  call void @_ZdlPv(i8* nonnull %83) #18
  br label %ehcleanup81

ehcleanup81:                                      ; preds = %if.then.i.i.i572, %ehcleanup, %lpad17
  %.pn462.pn = phi { i8*, i32 } [ %58, %lpad17 ], [ %.pn462, %ehcleanup ], [ %.pn462, %if.then.i.i.i572 ]
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %42) #18
  br label %ehcleanup329

if.end:                                           ; preds = %_ZNSt6vectorIiSaIiEED2Ev.exit565, %invoke.cont13
  %84 = load i32*, i32** %_M_finish.i, align 8, !tbaa !17
  %85 = load i32*, i32** %_M_start.i, align 8, !tbaa !36
  %sub.ptr.lhs.cast.i576 = ptrtoint i32* %84 to i64
  %sub.ptr.rhs.cast.i577 = ptrtoint i32* %85 to i64
  %sub.ptr.sub.i578 = sub i64 %sub.ptr.lhs.cast.i576, %sub.ptr.rhs.cast.i577
  %cmp83 = icmp eq i64 %sub.ptr.sub.i578, 24952
  br i1 %cmp83, label %cond.end, label %cond.false

cond.false:                                       ; preds = %if.end
  call void @__assert_fail(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.6, i64 0, i64 0), i32 82, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #20
  unreachable

cond.end:                                         ; preds = %if.end
  %_M_start.i580 = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %X_data, i64 0, i32 0, i32 0, i32 0
  %86 = load i32*, i32** %_M_start.i580, align 8, !tbaa !36
  %87 = bitcast [6238 x i32]* %labels to i8*
  call void @llvm.lifetime.start.p0i8(i64 24952, i8* nonnull %87) #18
  %call86 = call i64 @_ZNSt6chrono3_V212system_clock3nowEv() #18
  %sub.i.i = sub nsw i64 %call86, %call
  %div.i.i = sdiv i64 %sub.i.i, 1000000
  %call1.i582583 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i8* nonnull getelementptr inbounds ([19 x i8], [19 x i8]* @.str.10, i64 0, i64 0), i64 18)
          to label %invoke.cont103 unwind label %lpad102

invoke.cont103:                                   ; preds = %cond.end
  %call.i585586 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo9_M_insertIlEERSoT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i64 %div.i.i)
          to label %invoke.cont105 unwind label %lpad102

invoke.cont105:                                   ; preds = %invoke.cont103
  %call1.i588589 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call.i585586, i8* nonnull getelementptr inbounds ([6 x i8], [6 x i8]* @.str.11, i64 0, i64 0), i64 5)
          to label %invoke.cont107 unwind label %lpad102

invoke.cont107:                                   ; preds = %invoke.cont105
  %88 = bitcast %"class.std::basic_ostream"* %call.i585586 to i8**
  %vtable.i752 = load i8*, i8** %88, align 8, !tbaa !7
  %vbase.offset.ptr.i753 = getelementptr i8, i8* %vtable.i752, i64 -24
  %89 = bitcast i8* %vbase.offset.ptr.i753 to i64*
  %vbase.offset.i754 = load i64, i64* %89, align 8
  %90 = bitcast %"class.std::basic_ostream"* %call.i585586 to i8*
  %_M_ctype.i.idx.i755 = add nsw i64 %vbase.offset.i754, 240
  %_M_ctype.i.i756 = getelementptr inbounds i8, i8* %90, i64 %_M_ctype.i.idx.i755
  %91 = bitcast i8* %_M_ctype.i.i756 to %"class.std::ctype"**
  %92 = load %"class.std::ctype"*, %"class.std::ctype"** %91, align 8, !tbaa !24
  %tobool.not.i.i.i757 = icmp eq %"class.std::ctype"* %92, null
  br i1 %tobool.not.i.i.i757, label %if.then.i.i.i758, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i761

if.then.i.i.i758:                                 ; preds = %invoke.cont107
  invoke void @_ZSt16__throw_bad_castv() #21
          to label %.noexc772 unwind label %lpad102

.noexc772:                                        ; preds = %if.then.i.i.i758
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i761: ; preds = %invoke.cont107
  %_M_widen_ok.i.i.i759 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %92, i64 0, i32 8
  %93 = load i8, i8* %_M_widen_ok.i.i.i759, align 8, !tbaa !27
  %tobool.not.i3.i.i760 = icmp eq i8 %93, 0
  br i1 %tobool.not.i3.i.i760, label %if.end.i.i.i767, label %if.then.i4.i.i763

if.then.i4.i.i763:                                ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i761
  %arrayidx.i.i.i762 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %92, i64 0, i32 9, i64 10
  %94 = load i8, i8* %arrayidx.i.i.i762, align 1, !tbaa !29
  br label %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i771

if.end.i.i.i767:                                  ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i761
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %92)
          to label %.noexc773 unwind label %lpad102

.noexc773:                                        ; preds = %if.end.i.i.i767
  %95 = bitcast %"class.std::ctype"* %92 to i8 (%"class.std::ctype"*, i8)***
  %vtable.i.i.i764 = load i8 (%"class.std::ctype"*, i8)**, i8 (%"class.std::ctype"*, i8)*** %95, align 8, !tbaa !7
  %vfn.i.i.i765 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vtable.i.i.i764, i64 6
  %96 = load i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vfn.i.i.i765, align 8
  %call.i.i.i766774 = invoke signext i8 %96(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %92, i8 signext 10)
          to label %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i771 unwind label %lpad102

_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i771: ; preds = %.noexc773, %if.then.i4.i.i763
  %retval.0.i.i.i768 = phi i8 [ %94, %if.then.i4.i.i763 ], [ %call.i.i.i766774, %.noexc773 ]
  %call1.i769775 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call.i585586, i8 signext %retval.0.i.i.i768)
          to label %call1.i769.noexc unwind label %lpad102

call1.i769.noexc:                                 ; preds = %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i771
  %call.i.i770776 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call1.i769775)
          to label %invoke.cont109 unwind label %lpad102

invoke.cont109:                                   ; preds = %call1.i769.noexc
  %call112 = call i64 @_ZNSt6chrono3_V212system_clock3nowEv() #18
  %97 = bitcast <32 x i32>* %encoded_hv to i8*
  call void @llvm.lifetime.start.p0i8(i64 128, i8* nonnull %97) #18
  %98 = getelementptr inbounds <32 x i32>, <32 x i32>* %encoded_hv, i64 0, i64 0
  %99 = bitcast <32 x i32>* %clusters to i8*
  call void @llvm.lifetime.start.p0i8(i64 128, i8* nonnull %99) #18
  %100 = getelementptr inbounds <32 x i32>, <32 x i32>* %clusters, i64 0, i64 0
  %101 = bitcast <32 x i32>* %clusters_temp to i8*
  call void @llvm.lifetime.start.p0i8(i64 128, i8* nonnull %101) #18
  %102 = getelementptr inbounds <32 x i32>, <32 x i32>* %clusters_temp, i64 0, i64 0
  %103 = bitcast [19744 x i32]* %rp_matrix to i8*
  call void @llvm.lifetime.start.p0i8(i64 78976, i8* nonnull %103) #18
  %104 = getelementptr inbounds [19744 x i32], [19744 x i32]* %rp_matrix, i64 0, i64 0
  %call1.i595596 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @.str.12, i64 0, i64 0), i64 17)
          to label %invoke.cont116 unwind label %lpad115.loopexit.split-lp

invoke.cont116:                                   ; preds = %invoke.cont109
  %call119 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 1)
          to label %invoke.cont118 unwind label %lpad115.loopexit.split-lp

invoke.cont118:                                   ; preds = %invoke.cont116
  %105 = bitcast %"class.std::basic_ostream"* %call119 to i8**
  %vtable.i778 = load i8*, i8** %105, align 8, !tbaa !7
  %vbase.offset.ptr.i779 = getelementptr i8, i8* %vtable.i778, i64 -24
  %106 = bitcast i8* %vbase.offset.ptr.i779 to i64*
  %vbase.offset.i780 = load i64, i64* %106, align 8
  %107 = bitcast %"class.std::basic_ostream"* %call119 to i8*
  %_M_ctype.i.idx.i781 = add nsw i64 %vbase.offset.i780, 240
  %_M_ctype.i.i782 = getelementptr inbounds i8, i8* %107, i64 %_M_ctype.i.idx.i781
  %108 = bitcast i8* %_M_ctype.i.i782 to %"class.std::ctype"**
  %109 = load %"class.std::ctype"*, %"class.std::ctype"** %108, align 8, !tbaa !24
  %tobool.not.i.i.i783 = icmp eq %"class.std::ctype"* %109, null
  br i1 %tobool.not.i.i.i783, label %if.then.i.i.i784, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i787

if.then.i.i.i784:                                 ; preds = %invoke.cont118
  invoke void @_ZSt16__throw_bad_castv() #21
          to label %.noexc798 unwind label %lpad115.loopexit.split-lp

.noexc798:                                        ; preds = %if.then.i.i.i784
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i787: ; preds = %invoke.cont118
  %_M_widen_ok.i.i.i785 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %109, i64 0, i32 8
  %110 = load i8, i8* %_M_widen_ok.i.i.i785, align 8, !tbaa !27
  %tobool.not.i3.i.i786 = icmp eq i8 %110, 0
  br i1 %tobool.not.i3.i.i786, label %if.end.i.i.i793, label %if.then.i4.i.i789

if.then.i4.i.i789:                                ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i787
  %arrayidx.i.i.i788 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %109, i64 0, i32 9, i64 10
  %111 = load i8, i8* %arrayidx.i.i.i788, align 1, !tbaa !29
  br label %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i797

if.end.i.i.i793:                                  ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i787
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %109)
          to label %.noexc799 unwind label %lpad115.loopexit.split-lp

.noexc799:                                        ; preds = %if.end.i.i.i793
  %112 = bitcast %"class.std::ctype"* %109 to i8 (%"class.std::ctype"*, i8)***
  %vtable.i.i.i790 = load i8 (%"class.std::ctype"*, i8)**, i8 (%"class.std::ctype"*, i8)*** %112, align 8, !tbaa !7
  %vfn.i.i.i791 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vtable.i.i.i790, i64 6
  %113 = load i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vfn.i.i.i791, align 8
  %call.i.i.i792800 = invoke signext i8 %113(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %109, i8 signext 10)
          to label %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i797 unwind label %lpad115.loopexit.split-lp

_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i797: ; preds = %.noexc799, %if.then.i4.i.i789
  %retval.0.i.i.i794 = phi i8 [ %111, %if.then.i4.i.i789 ], [ %call.i.i.i792800, %.noexc799 ]
  %call1.i795801 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call119, i8 signext %retval.0.i.i.i794)
          to label %call1.i795.noexc unwind label %lpad115.loopexit.split-lp

call1.i795.noexc:                                 ; preds = %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i797
  %call.i.i796802 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call1.i795801)
          to label %for.body126 unwind label %lpad115.loopexit.split-lp

for.cond.cleanup125:                              ; preds = %invoke.cont137
  %call1.i.i603 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.21, i64 0, i64 0), i64 1)
          to label %for.body.i unwind label %lpad115.loopexit.split-lp

for.cond.cleanup.i:                               ; preds = %call1.i13.i.noexc
  %vecext3.i = extractelement <32 x i32> %vecins147, i32 31
  %call4.i604 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 %vecext3.i)
          to label %call4.i.noexc unwind label %lpad115.loopexit.split-lp

call4.i.noexc:                                    ; preds = %for.cond.cleanup.i
  %call1.i11.i605 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call4.i604, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.23, i64 0, i64 0), i64 2)
          to label %invoke.cont159 unwind label %lpad115.loopexit.split-lp

for.body.i:                                       ; preds = %for.cond.cleanup125, %call1.i13.i.noexc
  %i.014.i = phi i32 [ %inc.i, %call1.i13.i.noexc ], [ 0, %for.cond.cleanup125 ]
  %vecext.i = extractelement <32 x i32> %vecins147, i32 %i.014.i
  %call1.i602606 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 %vecext.i)
          to label %call1.i602.noexc unwind label %lpad115.loopexit

call1.i602.noexc:                                 ; preds = %for.body.i
  %call1.i13.i607 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call1.i602606, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.22, i64 0, i64 0), i64 2)
          to label %call1.i13.i.noexc unwind label %lpad115.loopexit

call1.i13.i.noexc:                                ; preds = %call1.i602.noexc
  %inc.i = add nuw nsw i32 %i.014.i, 1
  %exitcond.not.i = icmp eq i32 %inc.i, 31
  br i1 %exitcond.not.i, label %for.cond.cleanup.i, label %for.body.i, !llvm.loop !43

lpad102:                                          ; preds = %call1.i769.noexc, %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i771, %.noexc773, %if.end.i.i.i767, %if.then.i.i.i758, %invoke.cont105, %invoke.cont103, %cond.end
  %114 = landingpad { i8*, i32 }
          cleanup
  br label %ehcleanup324

lpad115.loopexit:                                 ; preds = %for.body.i, %call1.i602.noexc
  %lpad.loopexit932 = landingpad { i8*, i32 }
          cleanup
  br label %ehcleanup310

lpad115.loopexit.split-lp:                        ; preds = %invoke.cont116, %invoke.cont270, %invoke.cont109, %for.cond.cleanup125, %for.cond.cleanup.i, %call4.i.noexc, %invoke.cont159, %for.cond.cleanup210, %invoke.cont262, %invoke.cont264, %invoke.cont268, %invoke.cont272, %invoke.cont274, %invoke.cont276, %if.then.i.i.i784, %if.end.i.i.i793, %.noexc799, %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i797, %call1.i795.noexc, %if.then.i.i.i836, %if.end.i.i.i845, %.noexc851, %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i849, %call1.i847.noexc, %if.then.i.i.i862, %if.end.i.i.i871, %.noexc877, %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i875, %call1.i873.noexc
  %lpad.loopexit.split-lp933 = landingpad { i8*, i32 }
          cleanup
  br label %ehcleanup310

for.body126:                                      ; preds = %call1.i795.noexc
  %call128 = call i32 @rand() #18
  br label %for.body133

for.body133:                                      ; preds = %for.body126, %invoke.cont137
  %j129.0953 = phi i32 [ 0, %for.body126 ], [ %inc151, %invoke.cont137 ]
  %rp_seed.1952 = phi <32 x i32> [ undef, %for.body126 ], [ %vecins147, %invoke.cont137 ]
  %shl = shl i32 1, %j129.0953
  %and = and i32 %shl, %call128
  %call136 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 %and)
          to label %invoke.cont135 unwind label %lpad134.loopexit

invoke.cont135:                                   ; preds = %for.body133
  %115 = bitcast %"class.std::basic_ostream"* %call136 to i8**
  %vtable.i804 = load i8*, i8** %115, align 8, !tbaa !7
  %vbase.offset.ptr.i805 = getelementptr i8, i8* %vtable.i804, i64 -24
  %116 = bitcast i8* %vbase.offset.ptr.i805 to i64*
  %vbase.offset.i806 = load i64, i64* %116, align 8
  %117 = bitcast %"class.std::basic_ostream"* %call136 to i8*
  %_M_ctype.i.idx.i807 = add nsw i64 %vbase.offset.i806, 240
  %_M_ctype.i.i808 = getelementptr inbounds i8, i8* %117, i64 %_M_ctype.i.idx.i807
  %118 = bitcast i8* %_M_ctype.i.i808 to %"class.std::ctype"**
  %119 = load %"class.std::ctype"*, %"class.std::ctype"** %118, align 8, !tbaa !24
  %tobool.not.i.i.i809 = icmp eq %"class.std::ctype"* %119, null
  br i1 %tobool.not.i.i.i809, label %if.then.i.i.i810, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i813

if.then.i.i.i810:                                 ; preds = %invoke.cont135
  invoke void @_ZSt16__throw_bad_castv() #21
          to label %.noexc824 unwind label %lpad134.loopexit.split-lp

.noexc824:                                        ; preds = %if.then.i.i.i810
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i813: ; preds = %invoke.cont135
  %_M_widen_ok.i.i.i811 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %119, i64 0, i32 8
  %120 = load i8, i8* %_M_widen_ok.i.i.i811, align 8, !tbaa !27
  %tobool.not.i3.i.i812 = icmp eq i8 %120, 0
  br i1 %tobool.not.i3.i.i812, label %if.end.i.i.i819, label %if.then.i4.i.i815

if.then.i4.i.i815:                                ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i813
  %arrayidx.i.i.i814 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %119, i64 0, i32 9, i64 10
  %121 = load i8, i8* %arrayidx.i.i.i814, align 1, !tbaa !29
  br label %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i823

if.end.i.i.i819:                                  ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i813
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %119)
          to label %.noexc825 unwind label %lpad134.loopexit

.noexc825:                                        ; preds = %if.end.i.i.i819
  %122 = bitcast %"class.std::ctype"* %119 to i8 (%"class.std::ctype"*, i8)***
  %vtable.i.i.i816 = load i8 (%"class.std::ctype"*, i8)**, i8 (%"class.std::ctype"*, i8)*** %122, align 8, !tbaa !7
  %vfn.i.i.i817 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vtable.i.i.i816, i64 6
  %123 = load i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vfn.i.i.i817, align 8
  %call.i.i.i818826 = invoke signext i8 %123(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %119, i8 signext 10)
          to label %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i823 unwind label %lpad134.loopexit

_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i823: ; preds = %.noexc825, %if.then.i4.i.i815
  %retval.0.i.i.i820 = phi i8 [ %121, %if.then.i4.i.i815 ], [ %call.i.i.i818826, %.noexc825 ]
  %call1.i821827 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call136, i8 signext %retval.0.i.i.i820)
          to label %call1.i821.noexc unwind label %lpad134.loopexit

call1.i821.noexc:                                 ; preds = %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i823
  %call.i.i822828 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call1.i821827)
          to label %invoke.cont137 unwind label %lpad134.loopexit

invoke.cont137:                                   ; preds = %call1.i821.noexc
  %tobool141.not = icmp eq i32 %and, 0
  %. = select i1 %tobool141.not, i32 -1, i32 1
  %vecins147 = insertelement <32 x i32> %rp_seed.1952, i32 %., i32 %j129.0953
  %inc151 = add nuw nsw i32 %j129.0953, 1
  %exitcond974.not = icmp eq i32 %inc151, 32
  br i1 %exitcond974.not, label %for.cond.cleanup125, label %for.body133, !llvm.loop !44

lpad134.loopexit:                                 ; preds = %for.body133, %if.end.i.i.i819, %.noexc825, %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i823, %call1.i821.noexc
  %lpad.loopexit935 = landingpad { i8*, i32 }
          cleanup
  br label %ehcleanup310

lpad134.loopexit.split-lp:                        ; preds = %if.then.i.i.i810
  %lpad.loopexit.split-lp936 = landingpad { i8*, i32 }
          cleanup
  br label %ehcleanup310

invoke.cont159:                                   ; preds = %call4.i.noexc
  %call1.i612613 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i8* nonnull getelementptr inbounds ([23 x i8], [23 x i8]* @.str.13, i64 0, i64 0), i64 22)
          to label %for.body.i620.preheader unwind label %lpad115.loopexit.split-lp

for.body.i620.preheader:                          ; preds = %invoke.cont159, %invoke.cont173
  %indvars.iv975 = phi i64 [ %indvars.iv.next976, %invoke.cont173 ], [ 0, %invoke.cont159 ]
  %124 = trunc i64 %indvars.iv975 to i32
  br label %for.body.i620

for.body.i620:                                    ; preds = %for.body.i620.preheader, %for.body.i620
  %i.012.i = phi i32 [ %inc.i618, %for.body.i620 ], [ 0, %for.body.i620.preheader ]
  %output.011.i = phi <32 x i32> [ %vecins.i, %for.body.i620 ], [ undef, %for.body.i620.preheader ]
  %add2.i = add nuw nsw i32 %i.012.i, %124
  %rem.i = and i32 %add2.i, 31
  %vecext.i617 = extractelement <32 x i32> %vecins147, i32 %rem.i
  %vecins.i = insertelement <32 x i32> %output.011.i, i32 %vecext.i617, i32 %i.012.i
  %inc.i618 = add nuw nsw i32 %i.012.i, 1
  %exitcond.not.i619 = icmp eq i32 %inc.i618, 32
  br i1 %exitcond.not.i619, label %_Z23__hetero_hdc_wrap_shiftILi32EiEN15__hypervector__IXT_ET0_E1vES3_i.exit, label %for.body.i620, !llvm.loop !45

_Z23__hetero_hdc_wrap_shiftILi32EiEN15__hypervector__IXT_ET0_E1vES3_i.exit: ; preds = %for.body.i620
  %125 = shl nsw i64 %indvars.iv975, 5
  %add.ptr.i623 = getelementptr inbounds [19744 x i32], [19744 x i32]* %rp_matrix, i64 0, i64 %125
  %126 = bitcast i32* %add.ptr.i623 to <32 x i32>*
  store <32 x i32> %vecins.i, <32 x i32>* %126, align 4, !tbaa !29
  %call1.i.i635 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.21, i64 0, i64 0), i64 1)
          to label %for.body.i633 unwind label %lpad172.loopexit.split-lp

for.cond.cleanup.i627:                            ; preds = %call1.i13.i.noexc640
  %vecext3.i626 = extractelement <32 x i32> %vecins.i, i32 31
  %call4.i637 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 %vecext3.i626)
          to label %call4.i.noexc636 unwind label %lpad172.loopexit.split-lp

call4.i.noexc636:                                 ; preds = %for.cond.cleanup.i627
  %call1.i11.i638 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call4.i637, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.23, i64 0, i64 0), i64 2)
          to label %invoke.cont173 unwind label %lpad172.loopexit.split-lp

for.body.i633:                                    ; preds = %_Z23__hetero_hdc_wrap_shiftILi32EiEN15__hypervector__IXT_ET0_E1vES3_i.exit, %call1.i13.i.noexc640
  %i.014.i628 = phi i32 [ %inc.i631, %call1.i13.i.noexc640 ], [ 0, %_Z23__hetero_hdc_wrap_shiftILi32EiEN15__hypervector__IXT_ET0_E1vES3_i.exit ]
  %vecext.i629 = extractelement <32 x i32> %vecins.i, i32 %i.014.i628
  %call1.i630639 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 %vecext.i629)
          to label %call1.i630.noexc unwind label %lpad172.loopexit

call1.i630.noexc:                                 ; preds = %for.body.i633
  %call1.i13.i641 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call1.i630639, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.22, i64 0, i64 0), i64 2)
          to label %call1.i13.i.noexc640 unwind label %lpad172.loopexit

call1.i13.i.noexc640:                             ; preds = %call1.i630.noexc
  %inc.i631 = add nuw nsw i32 %i.014.i628, 1
  %exitcond.not.i632 = icmp eq i32 %inc.i631, 31
  br i1 %exitcond.not.i632, label %for.cond.cleanup.i627, label %for.body.i633, !llvm.loop !43

invoke.cont173:                                   ; preds = %call4.i.noexc636
  %indvars.iv.next976 = add nuw nsw i64 %indvars.iv975, 1
  %exitcond978.not = icmp eq i64 %indvars.iv.next976, 617
  br i1 %exitcond978.not, label %for.body182, label %for.body.i620.preheader, !llvm.loop !46

lpad172.loopexit:                                 ; preds = %for.body.i633, %call1.i630.noexc
  %lpad.loopexit929 = landingpad { i8*, i32 }
          cleanup
  br label %ehcleanup310

lpad172.loopexit.split-lp:                        ; preds = %_Z23__hetero_hdc_wrap_shiftILi32EiEN15__hypervector__IXT_ET0_E1vES3_i.exit, %for.cond.cleanup.i627, %call4.i.noexc636
  %lpad.loopexit.split-lp930 = landingpad { i8*, i32 }
          cleanup
  br label %ehcleanup310

for.body182:                                      ; preds = %invoke.cont173
  %call192 = call i8* (i8*, ...) @__hetero_launch(i8* bitcast (void (i32*, i64, i32*, i64, i32*, i64)* @_Z16rp_encoding_nodeILi32ELi617EEvPimS0_mS0_m to i8*), i32 3, i32* nonnull %104, i64 78976, i32* %86, i64 2468, i32* nonnull %100, i64 128, i32 1, i32* nonnull %100, i64 128) #18
  call void @__hetero_wait(i8* %call192) #18
  %call198 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 0)
          to label %invoke.cont197 unwind label %lpad196

invoke.cont197:                                   ; preds = %for.body182
  %call1.i644645 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call198, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.14, i64 0, i64 0), i64 1)
          to label %for.cond208.preheader unwind label %lpad196

for.cond208.preheader:                            ; preds = %invoke.cont197
  %arraydecay = getelementptr inbounds [6238 x i32], [6238 x i32]* %labels, i64 0, i64 0
  %127 = load i32, i32* @EPOCH, align 4, !tbaa !3
  %cmp209958 = icmp sgt i32 %127, 0
  br i1 %cmp209958, label %for.cond213.preheader, label %for.cond.cleanup210

lpad196:                                          ; preds = %invoke.cont197, %for.body182
  %128 = landingpad { i8*, i32 }
          cleanup
  br label %ehcleanup310

for.cond213.preheader:                            ; preds = %for.cond208.preheader, %_Z17__hetero_hdc_signILi32EiEN15__hypervector__IXT_ET0_E1vES3_.exit
  %i207.0959 = phi i32 [ %inc241, %_Z17__hetero_hdc_signILi32EiEN15__hypervector__IXT_ET0_E1vES3_.exit ], [ 0, %for.cond208.preheader ]
  br label %for.body216

for.cond.cleanup210:                              ; preds = %_Z17__hetero_hdc_signILi32EiEN15__hypervector__IXT_ET0_E1vES3_.exit, %for.cond208.preheader
  %call245 = call i64 @_ZNSt6chrono3_V212system_clock3nowEv() #18
  %sub.i.i651 = sub nsw i64 %call245, %call112
  %div.i.i664 = sdiv i64 %sub.i.i651, 1000000
  %call1.i667668 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i8* nonnull getelementptr inbounds ([20 x i8], [20 x i8]* @.str.15, i64 0, i64 0), i64 19)
          to label %invoke.cont262 unwind label %lpad115.loopexit.split-lp

for.body216:                                      ; preds = %for.cond213.preheader, %for.body216
  %indvars.iv979 = phi i64 [ 0, %for.cond213.preheader ], [ %indvars.iv.next980, %for.body216 ]
  %129 = mul nuw nsw i64 %indvars.iv979, 617
  %arrayidx219 = getelementptr inbounds i32, i32* %86, i64 %129
  %call223 = call i8* (i8*, ...) @__hetero_launch(i8* bitcast (void (i32*, i64, i32*, i64, i32*, i64, i32*, i64, i32*, i64, i32, i32, i32*, i64)* @_Z9root_nodeILi32ELi1ELi6238ELi617EEvPimS0_mS0_mS0_mS0_miiS0_m to i8*), i32 6, i32* nonnull %104, i64 78976, i32* %arrayidx219, i64 2468, i32* nonnull %98, i64 128, i32* nonnull %100, i64 128, i32* nonnull %102, i64 128, i32* nonnull %arraydecay, i64 24952, i32 1, i32* nonnull %arraydecay, i64 24952) #18
  call void @__hetero_wait(i8* %call223) #18
  %indvars.iv.next980 = add nuw nsw i64 %indvars.iv979, 1
  %exitcond982.not = icmp eq i64 %indvars.iv.next980, 6238
  br i1 %exitcond982.not, label %for.body231, label %for.body216, !llvm.loop !47

for.body231:                                      ; preds = %for.body216
  %130 = load <32 x i32>, <32 x i32>* %clusters_temp, align 4, !tbaa !29
  br label %for.body.i659

for.body.i659:                                    ; preds = %for.body.i659, %for.body231
  %i.09.i = phi i32 [ 0, %for.body231 ], [ %inc.i657, %for.body.i659 ]
  %output.08.i = phi <32 x i32> [ undef, %for.body231 ], [ %vecins.i656, %for.body.i659 ]
  %vecext.i655 = extractelement <32 x i32> %130, i32 %i.09.i
  %cmp1.inv.i = icmp slt i32 %vecext.i655, 1
  %conv.i = select i1 %cmp1.inv.i, i32 -1, i32 1
  %vecins.i656 = insertelement <32 x i32> %output.08.i, i32 %conv.i, i32 %i.09.i
  %inc.i657 = add nuw nsw i32 %i.09.i, 1
  %exitcond.not.i658 = icmp eq i32 %inc.i657, 32
  br i1 %exitcond.not.i658, label %_Z17__hetero_hdc_signILi32EiEN15__hypervector__IXT_ET0_E1vES3_.exit, label %for.body.i659, !llvm.loop !48

_Z17__hetero_hdc_signILi32EiEN15__hypervector__IXT_ET0_E1vES3_.exit: ; preds = %for.body.i659
  store <32 x i32> %vecins.i656, <32 x i32>* %clusters, align 4, !tbaa !29
  %inc241 = add nuw nsw i32 %i207.0959, 1
  %131 = load i32, i32* @EPOCH, align 4, !tbaa !3
  %cmp209 = icmp slt i32 %inc241, %131
  br i1 %cmp209, label %for.cond213.preheader, label %for.cond.cleanup210, !llvm.loop !49

invoke.cont262:                                   ; preds = %for.cond.cleanup210
  %call.i670671 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo9_M_insertIlEERSoT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i64 %div.i.i)
          to label %invoke.cont264 unwind label %lpad115.loopexit.split-lp

invoke.cont264:                                   ; preds = %invoke.cont262
  %call1.i674675 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call.i670671, i8* nonnull getelementptr inbounds ([6 x i8], [6 x i8]* @.str.11, i64 0, i64 0), i64 5)
          to label %invoke.cont266 unwind label %lpad115.loopexit.split-lp

invoke.cont266:                                   ; preds = %invoke.cont264
  %132 = bitcast %"class.std::basic_ostream"* %call.i670671 to i8**
  %vtable.i830 = load i8*, i8** %132, align 8, !tbaa !7
  %vbase.offset.ptr.i831 = getelementptr i8, i8* %vtable.i830, i64 -24
  %133 = bitcast i8* %vbase.offset.ptr.i831 to i64*
  %vbase.offset.i832 = load i64, i64* %133, align 8
  %134 = bitcast %"class.std::basic_ostream"* %call.i670671 to i8*
  %_M_ctype.i.idx.i833 = add nsw i64 %vbase.offset.i832, 240
  %_M_ctype.i.i834 = getelementptr inbounds i8, i8* %134, i64 %_M_ctype.i.idx.i833
  %135 = bitcast i8* %_M_ctype.i.i834 to %"class.std::ctype"**
  %136 = load %"class.std::ctype"*, %"class.std::ctype"** %135, align 8, !tbaa !24
  %tobool.not.i.i.i835 = icmp eq %"class.std::ctype"* %136, null
  br i1 %tobool.not.i.i.i835, label %if.then.i.i.i836, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i839

if.then.i.i.i836:                                 ; preds = %invoke.cont266
  invoke void @_ZSt16__throw_bad_castv() #21
          to label %.noexc850 unwind label %lpad115.loopexit.split-lp

.noexc850:                                        ; preds = %if.then.i.i.i836
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i839: ; preds = %invoke.cont266
  %_M_widen_ok.i.i.i837 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %136, i64 0, i32 8
  %137 = load i8, i8* %_M_widen_ok.i.i.i837, align 8, !tbaa !27
  %tobool.not.i3.i.i838 = icmp eq i8 %137, 0
  br i1 %tobool.not.i3.i.i838, label %if.end.i.i.i845, label %if.then.i4.i.i841

if.then.i4.i.i841:                                ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i839
  %arrayidx.i.i.i840 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %136, i64 0, i32 9, i64 10
  %138 = load i8, i8* %arrayidx.i.i.i840, align 1, !tbaa !29
  br label %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i849

if.end.i.i.i845:                                  ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i839
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %136)
          to label %.noexc851 unwind label %lpad115.loopexit.split-lp

.noexc851:                                        ; preds = %if.end.i.i.i845
  %139 = bitcast %"class.std::ctype"* %136 to i8 (%"class.std::ctype"*, i8)***
  %vtable.i.i.i842 = load i8 (%"class.std::ctype"*, i8)**, i8 (%"class.std::ctype"*, i8)*** %139, align 8, !tbaa !7
  %vfn.i.i.i843 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vtable.i.i.i842, i64 6
  %140 = load i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vfn.i.i.i843, align 8
  %call.i.i.i844852 = invoke signext i8 %140(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %136, i8 signext 10)
          to label %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i849 unwind label %lpad115.loopexit.split-lp

_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i849: ; preds = %.noexc851, %if.then.i4.i.i841
  %retval.0.i.i.i846 = phi i8 [ %138, %if.then.i4.i.i841 ], [ %call.i.i.i844852, %.noexc851 ]
  %call1.i847853 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call.i670671, i8 signext %retval.0.i.i.i846)
          to label %call1.i847.noexc unwind label %lpad115.loopexit.split-lp

call1.i847.noexc:                                 ; preds = %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i849
  %call.i.i848854 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call1.i847853)
          to label %invoke.cont268 unwind label %lpad115.loopexit.split-lp

invoke.cont268:                                   ; preds = %call1.i847.noexc
  %call1.i681682 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.16, i64 0, i64 0), i64 11)
          to label %invoke.cont270 unwind label %lpad115.loopexit.split-lp

invoke.cont270:                                   ; preds = %invoke.cont268
  %141 = load i32, i32* @EPOCH, align 4, !tbaa !3
  %call273 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 %141)
          to label %invoke.cont272 unwind label %lpad115.loopexit.split-lp

invoke.cont272:                                   ; preds = %invoke.cont270
  %call1.i685686 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call273, i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @.str.17, i64 0, i64 0), i64 15)
          to label %invoke.cont274 unwind label %lpad115.loopexit.split-lp

invoke.cont274:                                   ; preds = %invoke.cont272
  %call.i688689 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo9_M_insertIlEERSoT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call273, i64 %div.i.i664)
          to label %invoke.cont276 unwind label %lpad115.loopexit.split-lp

invoke.cont276:                                   ; preds = %invoke.cont274
  %call1.i692693 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call.i688689, i8* nonnull getelementptr inbounds ([6 x i8], [6 x i8]* @.str.11, i64 0, i64 0), i64 5)
          to label %invoke.cont278 unwind label %lpad115.loopexit.split-lp

invoke.cont278:                                   ; preds = %invoke.cont276
  %142 = bitcast %"class.std::basic_ostream"* %call.i688689 to i8**
  %vtable.i856 = load i8*, i8** %142, align 8, !tbaa !7
  %vbase.offset.ptr.i857 = getelementptr i8, i8* %vtable.i856, i64 -24
  %143 = bitcast i8* %vbase.offset.ptr.i857 to i64*
  %vbase.offset.i858 = load i64, i64* %143, align 8
  %144 = bitcast %"class.std::basic_ostream"* %call.i688689 to i8*
  %_M_ctype.i.idx.i859 = add nsw i64 %vbase.offset.i858, 240
  %_M_ctype.i.i860 = getelementptr inbounds i8, i8* %144, i64 %_M_ctype.i.idx.i859
  %145 = bitcast i8* %_M_ctype.i.i860 to %"class.std::ctype"**
  %146 = load %"class.std::ctype"*, %"class.std::ctype"** %145, align 8, !tbaa !24
  %tobool.not.i.i.i861 = icmp eq %"class.std::ctype"* %146, null
  br i1 %tobool.not.i.i.i861, label %if.then.i.i.i862, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i865

if.then.i.i.i862:                                 ; preds = %invoke.cont278
  invoke void @_ZSt16__throw_bad_castv() #21
          to label %.noexc876 unwind label %lpad115.loopexit.split-lp

.noexc876:                                        ; preds = %if.then.i.i.i862
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i865: ; preds = %invoke.cont278
  %_M_widen_ok.i.i.i863 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %146, i64 0, i32 8
  %147 = load i8, i8* %_M_widen_ok.i.i.i863, align 8, !tbaa !27
  %tobool.not.i3.i.i864 = icmp eq i8 %147, 0
  br i1 %tobool.not.i3.i.i864, label %if.end.i.i.i871, label %if.then.i4.i.i867

if.then.i4.i.i867:                                ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i865
  %arrayidx.i.i.i866 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %146, i64 0, i32 9, i64 10
  %148 = load i8, i8* %arrayidx.i.i.i866, align 1, !tbaa !29
  br label %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i875

if.end.i.i.i871:                                  ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i865
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %146)
          to label %.noexc877 unwind label %lpad115.loopexit.split-lp

.noexc877:                                        ; preds = %if.end.i.i.i871
  %149 = bitcast %"class.std::ctype"* %146 to i8 (%"class.std::ctype"*, i8)***
  %vtable.i.i.i868 = load i8 (%"class.std::ctype"*, i8)**, i8 (%"class.std::ctype"*, i8)*** %149, align 8, !tbaa !7
  %vfn.i.i.i869 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vtable.i.i.i868, i64 6
  %150 = load i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vfn.i.i.i869, align 8
  %call.i.i.i870878 = invoke signext i8 %150(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %146, i8 signext 10)
          to label %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i875 unwind label %lpad115.loopexit.split-lp

_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i875: ; preds = %.noexc877, %if.then.i4.i.i867
  %retval.0.i.i.i872 = phi i8 [ %148, %if.then.i4.i.i867 ], [ %call.i.i.i870878, %.noexc877 ]
  %call1.i873879 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call.i688689, i8 signext %retval.0.i.i.i872)
          to label %call1.i873.noexc unwind label %lpad115.loopexit.split-lp

call1.i873.noexc:                                 ; preds = %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i875
  %call.i.i874880 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call1.i873879)
          to label %invoke.cont280 unwind label %lpad115.loopexit.split-lp

invoke.cont280:                                   ; preds = %call1.i873.noexc
  %151 = bitcast %"class.std::basic_ofstream"* %myfile to i8*
  call void @llvm.lifetime.start.p0i8(i64 512, i8* nonnull %151) #18
  invoke void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEEC1EPKcSt13_Ios_Openmode(%"class.std::basic_ofstream"* nonnull align 8 dereferenceable(248) %myfile, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.18, i64 0, i64 0), i32 48)
          to label %for.cond287.preheader unwind label %lpad282

for.cond287.preheader:                            ; preds = %invoke.cont280
  %152 = bitcast %"class.std::basic_ofstream"* %myfile to %"class.std::basic_ostream"*
  br label %for.body290

for.cond.cleanup289:                              ; preds = %for.inc304
  call void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev(%"class.std::basic_ofstream"* nonnull align 8 dereferenceable(248) %myfile) #18
  call void @llvm.lifetime.end.p0i8(i64 512, i8* nonnull %151) #18
  call void @llvm.lifetime.end.p0i8(i64 78976, i8* nonnull %103) #18
  call void @llvm.lifetime.end.p0i8(i64 128, i8* nonnull %101) #18
  call void @llvm.lifetime.end.p0i8(i64 128, i8* nonnull %99) #18
  call void @llvm.lifetime.end.p0i8(i64 128, i8* nonnull %97) #18
  call void @llvm.lifetime.end.p0i8(i64 24952, i8* nonnull %87) #18
  call void @llvm.stackrestore(i8* %40)
  %153 = load i32*, i32** %_M_start.i, align 8, !tbaa !36
  %tobool.not.i.i.i699 = icmp eq i32* %153, null
  br i1 %tobool.not.i.i.i699, label %_ZNSt6vectorIiSaIiEED2Ev.exit701, label %if.then.i.i.i700

if.then.i.i.i700:                                 ; preds = %for.cond.cleanup289
  %154 = bitcast i32* %153 to i8*
  call void @_ZdlPv(i8* nonnull %154) #18
  br label %_ZNSt6vectorIiSaIiEED2Ev.exit701

_ZNSt6vectorIiSaIiEED2Ev.exit701:                 ; preds = %for.cond.cleanup289, %if.then.i.i.i700
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %8) #18
  %155 = load i32*, i32** %_M_start.i580, align 8, !tbaa !36
  %tobool.not.i.i.i703 = icmp eq i32* %155, null
  br i1 %tobool.not.i.i.i703, label %_ZNSt6vectorIiSaIiEED2Ev.exit705, label %if.then.i.i.i704

if.then.i.i.i704:                                 ; preds = %_ZNSt6vectorIiSaIiEED2Ev.exit701
  %156 = bitcast i32* %155 to i8*
  call void @_ZdlPv(i8* nonnull %156) #18
  br label %_ZNSt6vectorIiSaIiEED2Ev.exit705

_ZNSt6vectorIiSaIiEED2Ev.exit705:                 ; preds = %_ZNSt6vectorIiSaIiEED2Ev.exit701, %if.then.i.i.i704
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %7) #18
  ret i32 0

lpad282:                                          ; preds = %invoke.cont280
  %157 = landingpad { i8*, i32 }
          cleanup
  br label %ehcleanup309

for.body290:                                      ; preds = %for.cond287.preheader, %for.inc304
  %indvars.iv983 = phi i64 [ 0, %for.cond287.preheader ], [ %indvars.iv.next984, %for.inc304 ]
  %158 = load i32*, i32** %_M_start.i, align 8, !tbaa !36
  %add.ptr.i707 = getelementptr inbounds i32, i32* %158, i64 %indvars.iv983
  %159 = load i32, i32* %add.ptr.i707, align 4, !tbaa !3
  %call295 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %152, i32 %159)
          to label %invoke.cont294 unwind label %lpad293.loopexit

invoke.cont294:                                   ; preds = %for.body290
  %call1.i709710 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call295, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.14, i64 0, i64 0), i64 1)
          to label %invoke.cont296 unwind label %lpad293.loopexit

invoke.cont296:                                   ; preds = %invoke.cont294
  %arrayidx299 = getelementptr inbounds [6238 x i32], [6238 x i32]* %labels, i64 0, i64 %indvars.iv983
  %160 = load i32, i32* %arrayidx299, align 4, !tbaa !3
  %call301 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call295, i32 %160)
          to label %invoke.cont300 unwind label %lpad293.loopexit

invoke.cont300:                                   ; preds = %invoke.cont296
  %161 = bitcast %"class.std::basic_ostream"* %call301 to i8**
  %vtable.i882 = load i8*, i8** %161, align 8, !tbaa !7
  %vbase.offset.ptr.i883 = getelementptr i8, i8* %vtable.i882, i64 -24
  %162 = bitcast i8* %vbase.offset.ptr.i883 to i64*
  %vbase.offset.i884 = load i64, i64* %162, align 8
  %163 = bitcast %"class.std::basic_ostream"* %call301 to i8*
  %_M_ctype.i.idx.i885 = add nsw i64 %vbase.offset.i884, 240
  %_M_ctype.i.i886 = getelementptr inbounds i8, i8* %163, i64 %_M_ctype.i.idx.i885
  %164 = bitcast i8* %_M_ctype.i.i886 to %"class.std::ctype"**
  %165 = load %"class.std::ctype"*, %"class.std::ctype"** %164, align 8, !tbaa !24
  %tobool.not.i.i.i887 = icmp eq %"class.std::ctype"* %165, null
  br i1 %tobool.not.i.i.i887, label %if.then.i.i.i888, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i891

if.then.i.i.i888:                                 ; preds = %invoke.cont300
  invoke void @_ZSt16__throw_bad_castv() #21
          to label %.noexc902 unwind label %lpad293.loopexit.split-lp

.noexc902:                                        ; preds = %if.then.i.i.i888
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i891: ; preds = %invoke.cont300
  %_M_widen_ok.i.i.i889 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %165, i64 0, i32 8
  %166 = load i8, i8* %_M_widen_ok.i.i.i889, align 8, !tbaa !27
  %tobool.not.i3.i.i890 = icmp eq i8 %166, 0
  br i1 %tobool.not.i3.i.i890, label %if.end.i.i.i897, label %if.then.i4.i.i893

if.then.i4.i.i893:                                ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i891
  %arrayidx.i.i.i892 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %165, i64 0, i32 9, i64 10
  %167 = load i8, i8* %arrayidx.i.i.i892, align 1, !tbaa !29
  br label %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i901

if.end.i.i.i897:                                  ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i891
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %165)
          to label %.noexc903 unwind label %lpad293.loopexit

.noexc903:                                        ; preds = %if.end.i.i.i897
  %168 = bitcast %"class.std::ctype"* %165 to i8 (%"class.std::ctype"*, i8)***
  %vtable.i.i.i894 = load i8 (%"class.std::ctype"*, i8)**, i8 (%"class.std::ctype"*, i8)*** %168, align 8, !tbaa !7
  %vfn.i.i.i895 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vtable.i.i.i894, i64 6
  %169 = load i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vfn.i.i.i895, align 8
  %call.i.i.i896904 = invoke signext i8 %169(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %165, i8 signext 10)
          to label %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i901 unwind label %lpad293.loopexit

_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i901: ; preds = %.noexc903, %if.then.i4.i.i893
  %retval.0.i.i.i898 = phi i8 [ %167, %if.then.i4.i.i893 ], [ %call.i.i.i896904, %.noexc903 ]
  %call1.i899905 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call301, i8 signext %retval.0.i.i.i898)
          to label %call1.i899.noexc unwind label %lpad293.loopexit

call1.i899.noexc:                                 ; preds = %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i901
  %call.i.i900906 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call1.i899905)
          to label %for.inc304 unwind label %lpad293.loopexit

for.inc304:                                       ; preds = %call1.i899.noexc
  %indvars.iv.next984 = add nuw nsw i64 %indvars.iv983, 1
  %exitcond985.not = icmp eq i64 %indvars.iv.next984, 6238
  br i1 %exitcond985.not, label %for.cond.cleanup289, label %for.body290, !llvm.loop !50

lpad293.loopexit:                                 ; preds = %for.body290, %invoke.cont296, %invoke.cont294, %if.end.i.i.i897, %.noexc903, %_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc.exit.i901, %call1.i899.noexc
  %lpad.loopexit = landingpad { i8*, i32 }
          cleanup
  br label %lpad293

lpad293.loopexit.split-lp:                        ; preds = %if.then.i.i.i888
  %lpad.loopexit.split-lp = landingpad { i8*, i32 }
          cleanup
  br label %lpad293

lpad293:                                          ; preds = %lpad293.loopexit.split-lp, %lpad293.loopexit
  %lpad.phi = phi { i8*, i32 } [ %lpad.loopexit, %lpad293.loopexit ], [ %lpad.loopexit.split-lp, %lpad293.loopexit.split-lp ]
  call void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev(%"class.std::basic_ofstream"* nonnull align 8 dereferenceable(248) %myfile) #18
  br label %ehcleanup309

ehcleanup309:                                     ; preds = %lpad293, %lpad282
  %.pn = phi { i8*, i32 } [ %lpad.phi, %lpad293 ], [ %157, %lpad282 ]
  call void @llvm.lifetime.end.p0i8(i64 512, i8* nonnull %151) #18
  br label %ehcleanup310

ehcleanup310:                                     ; preds = %lpad172.loopexit, %lpad172.loopexit.split-lp, %lpad134.loopexit, %lpad134.loopexit.split-lp, %lpad115.loopexit, %lpad115.loopexit.split-lp, %ehcleanup309, %lpad196
  %.pn456 = phi { i8*, i32 } [ %128, %lpad196 ], [ %.pn, %ehcleanup309 ], [ %lpad.loopexit932, %lpad115.loopexit ], [ %lpad.loopexit.split-lp933, %lpad115.loopexit.split-lp ], [ %lpad.loopexit935, %lpad134.loopexit ], [ %lpad.loopexit.split-lp936, %lpad134.loopexit.split-lp ], [ %lpad.loopexit929, %lpad172.loopexit ], [ %lpad.loopexit.split-lp930, %lpad172.loopexit.split-lp ]
  call void @llvm.lifetime.end.p0i8(i64 78976, i8* nonnull %103) #18
  call void @llvm.lifetime.end.p0i8(i64 128, i8* nonnull %101) #18
  call void @llvm.lifetime.end.p0i8(i64 128, i8* nonnull %99) #18
  call void @llvm.lifetime.end.p0i8(i64 128, i8* nonnull %97) #18
  br label %ehcleanup324

ehcleanup324:                                     ; preds = %ehcleanup310, %lpad102
  %.pn456.pn.pn.pn = phi { i8*, i32 } [ %.pn456, %ehcleanup310 ], [ %114, %lpad102 ]
  call void @llvm.lifetime.end.p0i8(i64 24952, i8* nonnull %87) #18
  br label %ehcleanup329

ehcleanup329:                                     ; preds = %if.then.i.i546, %lpad9, %if.then.i.i541, %lpad5, %ehcleanup324, %ehcleanup81, %lpad
  %.pn456.pn.pn.pn.pn = phi { i8*, i32 } [ %.pn456.pn.pn.pn, %ehcleanup324 ], [ %.pn462.pn, %ehcleanup81 ], [ %53, %lpad ], [ %54, %lpad5 ], [ %54, %if.then.i.i541 ], [ %56, %lpad9 ], [ %56, %if.then.i.i546 ]
  %_M_start.i.i715 = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %y_data, i64 0, i32 0, i32 0, i32 0
  %170 = load i32*, i32** %_M_start.i.i715, align 8, !tbaa !36
  %tobool.not.i.i.i716 = icmp eq i32* %170, null
  br i1 %tobool.not.i.i.i716, label %_ZNSt6vectorIiSaIiEED2Ev.exit718, label %if.then.i.i.i717

if.then.i.i.i717:                                 ; preds = %ehcleanup329
  %171 = bitcast i32* %170 to i8*
  call void @_ZdlPv(i8* nonnull %171) #18
  br label %_ZNSt6vectorIiSaIiEED2Ev.exit718

_ZNSt6vectorIiSaIiEED2Ev.exit718:                 ; preds = %ehcleanup329, %if.then.i.i.i717
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %8) #18
  %_M_start.i.i719 = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %X_data, i64 0, i32 0, i32 0, i32 0
  %172 = load i32*, i32** %_M_start.i.i719, align 8, !tbaa !36
  %tobool.not.i.i.i720 = icmp eq i32* %172, null
  br i1 %tobool.not.i.i.i720, label %_ZNSt6vectorIiSaIiEED2Ev.exit722, label %if.then.i.i.i721

if.then.i.i.i721:                                 ; preds = %_ZNSt6vectorIiSaIiEED2Ev.exit718
  %173 = bitcast i32* %172 to i8*
  call void @_ZdlPv(i8* nonnull %173) #18
  br label %_ZNSt6vectorIiSaIiEED2Ev.exit722

_ZNSt6vectorIiSaIiEED2Ev.exit722:                 ; preds = %_ZNSt6vectorIiSaIiEED2Ev.exit718, %if.then.i.i.i721
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %7) #18
  resume { i8*, i32 } %.pn456.pn.pn.pn.pn
}

; Function Attrs: nounwind
declare dso_local i64 @_ZNSt6chrono3_V212system_clock3nowEv() local_unnamed_addr #1

; Function Attrs: nounwind
declare dso_local void @srand(i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare dso_local i64 @time(i64*) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nosync nounwind willreturn
declare i8* @llvm.stacksave() #8

; Function Attrs: nounwind
declare dso_local i32 @rand() local_unnamed_addr #1

; Function Attrs: uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(24) %"class.std::vector"* @_ZNSt6vectorIiSaIiEEaSERKS1_(%"class.std::vector"* nonnull align 8 dereferenceable(24) %this, %"class.std::vector"* nonnull align 8 dereferenceable(24) %__x) local_unnamed_addr #5 comdat align 2 personality i32 (...)* @__gxx_personality_v0 {
entry:
  %cmp.not = icmp eq %"class.std::vector"* %__x, %this
  br i1 %cmp.not, label %if.end75, label %if.then

if.then:                                          ; preds = %entry
  %_M_finish.i = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %__x, i64 0, i32 0, i32 0, i32 1
  %0 = load i32*, i32** %_M_finish.i, align 8, !tbaa !17
  %_M_start.i = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %__x, i64 0, i32 0, i32 0, i32 0
  %1 = load i32*, i32** %_M_start.i, align 8, !tbaa !36
  %sub.ptr.lhs.cast.i = ptrtoint i32* %0 to i64
  %sub.ptr.rhs.cast.i = ptrtoint i32* %1 to i64
  %sub.ptr.sub.i = sub i64 %sub.ptr.lhs.cast.i, %sub.ptr.rhs.cast.i
  %sub.ptr.div.i = ashr exact i64 %sub.ptr.sub.i, 2
  %_M_end_of_storage.i = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %this, i64 0, i32 0, i32 0, i32 2
  %2 = load i32*, i32** %_M_end_of_storage.i, align 8, !tbaa !20
  %_M_start.i91 = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %this, i64 0, i32 0, i32 0, i32 0
  %3 = load i32*, i32** %_M_start.i91, align 8, !tbaa !36
  %sub.ptr.lhs.cast.i92 = ptrtoint i32* %2 to i64
  %sub.ptr.rhs.cast.i93 = ptrtoint i32* %3 to i64
  %sub.ptr.sub.i94 = sub i64 %sub.ptr.lhs.cast.i92, %sub.ptr.rhs.cast.i93
  %sub.ptr.div.i95 = ashr exact i64 %sub.ptr.sub.i94, 2
  %cmp3 = icmp ugt i64 %sub.ptr.div.i, %sub.ptr.div.i95
  br i1 %cmp3, label %cond.true.i.i, label %if.else

cond.true.i.i:                                    ; preds = %if.then
  %cmp.i.i.i.i = icmp slt i64 %sub.ptr.sub.i, 0
  br i1 %cmp.i.i.i.i, label %if.then.i.i.i.i, label %_ZNSt16allocator_traitsISaIiEE8allocateERS0_m.exit.i.i

if.then.i.i.i.i:                                  ; preds = %cond.true.i.i
  call void @_ZSt17__throw_bad_allocv() #21
  unreachable

_ZNSt16allocator_traitsISaIiEE8allocateERS0_m.exit.i.i: ; preds = %cond.true.i.i
  %call2.i.i.i.i = call noalias nonnull i8* @_Znwm(i64 %sub.ptr.sub.i) #22
  %4 = bitcast i8* %call2.i.i.i.i to i32*
  %tobool.not.i.i.i.i.i.i.i.i = icmp eq i64 %sub.ptr.sub.i, 0
  br i1 %tobool.not.i.i.i.i.i.i.i.i, label %_ZNSt6vectorIiSaIiEE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPKiS1_EEEEPimT_S9_.exit, label %if.then.i.i.i.i.i.i.i.i

if.then.i.i.i.i.i.i.i.i:                          ; preds = %_ZNSt16allocator_traitsISaIiEE8allocateERS0_m.exit.i.i
  %5 = bitcast i32* %1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 %call2.i.i.i.i, i8* align 4 %5, i64 %sub.ptr.sub.i, i1 false) #18
  br label %_ZNSt6vectorIiSaIiEE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPKiS1_EEEEPimT_S9_.exit

_ZNSt6vectorIiSaIiEE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPKiS1_EEEEPimT_S9_.exit: ; preds = %_ZNSt16allocator_traitsISaIiEE8allocateERS0_m.exit.i.i, %if.then.i.i.i.i.i.i.i.i
  %6 = load i32*, i32** %_M_start.i91, align 8, !tbaa !36
  %tobool.not.i = icmp eq i32* %6, null
  br i1 %tobool.not.i, label %_ZNSt12_Vector_baseIiSaIiEE13_M_deallocateEPim.exit, label %if.then.i

if.then.i:                                        ; preds = %_ZNSt6vectorIiSaIiEE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPKiS1_EEEEPimT_S9_.exit
  %7 = bitcast i32* %6 to i8*
  call void @_ZdlPv(i8* nonnull %7) #18
  br label %_ZNSt12_Vector_baseIiSaIiEE13_M_deallocateEPim.exit

_ZNSt12_Vector_baseIiSaIiEE13_M_deallocateEPim.exit: ; preds = %_ZNSt6vectorIiSaIiEE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPKiS1_EEEEPimT_S9_.exit, %if.then.i
  %8 = bitcast %"class.std::vector"* %this to i8**
  store i8* %call2.i.i.i.i, i8** %8, align 8, !tbaa !36
  %add.ptr = getelementptr inbounds i32, i32* %4, i64 %sub.ptr.div.i
  store i32* %add.ptr, i32** %_M_end_of_storage.i, align 8, !tbaa !20
  br label %if.end69

if.else:                                          ; preds = %if.then
  %_M_finish.i98 = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %this, i64 0, i32 0, i32 0, i32 1
  %9 = load i32*, i32** %_M_finish.i98, align 8, !tbaa !17
  %sub.ptr.lhs.cast.i100 = ptrtoint i32* %9 to i64
  %sub.ptr.sub.i102 = sub i64 %sub.ptr.lhs.cast.i100, %sub.ptr.rhs.cast.i93
  %sub.ptr.div.i103 = ashr exact i64 %sub.ptr.sub.i102, 2
  %cmp26.not = icmp ult i64 %sub.ptr.div.i103, %sub.ptr.div.i
  br i1 %cmp26.not, label %if.else49, label %if.then27

if.then27:                                        ; preds = %if.else
  %tobool.not.i.i.i.i = icmp eq i64 %sub.ptr.sub.i, 0
  br i1 %tobool.not.i.i.i.i, label %if.end69, label %if.then.i.i.i.i107

if.then.i.i.i.i107:                               ; preds = %if.then27
  %10 = bitcast i32* %3 to i8*
  %11 = bitcast i32* %1 to i8*
  call void @llvm.memmove.p0i8.p0i8.i64(i8* align 4 %10, i8* align 4 %11, i64 %sub.ptr.sub.i, i1 false) #18
  br label %if.end69

if.else49:                                        ; preds = %if.else
  %tobool.not.i.i.i.i118 = icmp eq i64 %sub.ptr.sub.i102, 0
  br i1 %tobool.not.i.i.i.i118, label %_ZSt4copyIPiS0_ET0_T_S2_S1_.exit, label %if.then.i.i.i.i119

if.then.i.i.i.i119:                               ; preds = %if.else49
  %12 = bitcast i32* %3 to i8*
  %13 = bitcast i32* %1 to i8*
  call void @llvm.memmove.p0i8.p0i8.i64(i8* align 4 %12, i8* align 4 %13, i64 %sub.ptr.sub.i102, i1 false) #18
  br label %_ZSt4copyIPiS0_ET0_T_S2_S1_.exit

_ZSt4copyIPiS0_ET0_T_S2_S1_.exit:                 ; preds = %if.else49, %if.then.i.i.i.i119
  %14 = load i32*, i32** %_M_start.i, align 8, !tbaa !36
  %15 = load i32*, i32** %_M_finish.i98, align 8, !tbaa !17
  %16 = load i32*, i32** %_M_start.i91, align 8, !tbaa !36
  %sub.ptr.lhs.cast.i124 = ptrtoint i32* %15 to i64
  %sub.ptr.rhs.cast.i125 = ptrtoint i32* %16 to i64
  %sub.ptr.sub.i126 = sub i64 %sub.ptr.lhs.cast.i124, %sub.ptr.rhs.cast.i125
  %sub.ptr.div.i127 = ashr exact i64 %sub.ptr.sub.i126, 2
  %add.ptr62 = getelementptr inbounds i32, i32* %14, i64 %sub.ptr.div.i127
  %17 = load i32*, i32** %_M_finish.i, align 8, !tbaa !17
  %sub.ptr.lhs.cast.i.i.i.i.i.i.i = ptrtoint i32* %17 to i64
  %sub.ptr.rhs.cast.i.i.i.i.i.i.i = ptrtoint i32* %add.ptr62 to i64
  %sub.ptr.sub.i.i.i.i.i.i.i = sub i64 %sub.ptr.lhs.cast.i.i.i.i.i.i.i, %sub.ptr.rhs.cast.i.i.i.i.i.i.i
  %tobool.not.i.i.i.i.i.i.i = icmp eq i64 %sub.ptr.sub.i.i.i.i.i.i.i, 0
  br i1 %tobool.not.i.i.i.i.i.i.i, label %if.end69, label %if.then.i.i.i.i.i.i.i

if.then.i.i.i.i.i.i.i:                            ; preds = %_ZSt4copyIPiS0_ET0_T_S2_S1_.exit
  %18 = bitcast i32* %15 to i8*
  %19 = bitcast i32* %add.ptr62 to i8*
  call void @llvm.memmove.p0i8.p0i8.i64(i8* align 4 %18, i8* align 4 %19, i64 %sub.ptr.sub.i.i.i.i.i.i.i, i1 false) #18
  br label %if.end69

if.end69:                                         ; preds = %if.then.i.i.i.i.i.i.i, %_ZSt4copyIPiS0_ET0_T_S2_S1_.exit, %if.then.i.i.i.i107, %if.then27, %_ZNSt12_Vector_baseIiSaIiEE13_M_deallocateEPim.exit
  %20 = load i32*, i32** %_M_start.i91, align 8, !tbaa !36
  %add.ptr72 = getelementptr inbounds i32, i32* %20, i64 %sub.ptr.div.i
  %_M_finish74 = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %this, i64 0, i32 0, i32 0, i32 1
  store i32* %add.ptr72, i32** %_M_finish74, align 8, !tbaa !17
  br label %if.end75

if.end75:                                         ; preds = %if.end69, %entry
  ret %"class.std::vector"* %this
}

; Function Attrs: argmemonly mustprogress nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #9

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i32) local_unnamed_addr #0

; Function Attrs: nounwind
declare dso_local i8* @__hetero_launch(i8*, ...) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind uwtable
define linkonce_odr dso_local void @_Z16rp_encoding_nodeILi32ELi617EEvPimS0_mS0_m(i32* %rp_matrix_ptr, i64 %rp_matrix_size, i32* %input_datapoint_ptr, i64 %input_datapoint_size, i32* %output_hv_ptr, i64 %output_hv_size) #10 comdat {
entry:
  %matrix.addr.i.i = alloca [19744 x i32], align 4
  %call = call i8* @__hetero_section_begin() #18
  %call1 = call i8* (i32, ...) @__hetero_task_begin(i32 3, i32* %rp_matrix_ptr, i64 %rp_matrix_size, i32* %input_datapoint_ptr, i64 %input_datapoint_size, i32* %output_hv_ptr, i64 %output_hv_size, i32 1, i32* %output_hv_ptr, i64 %output_hv_size) #18
  %0 = bitcast i32* %input_datapoint_ptr to <617 x i32>*
  %1 = load <617 x i32>, <617 x i32>* %0, align 4, !tbaa !29
  %2 = bitcast i32* %rp_matrix_ptr to <19744 x i32>*
  %3 = load <19744 x i32>, <19744 x i32>* %2, align 4, !tbaa !29
  %4 = bitcast [19744 x i32]* %matrix.addr.i.i to i8*
  %5 = bitcast [19744 x i32]* %matrix.addr.i.i to <19744 x i32>*
  br label %for.body.i

for.body.i:                                       ; preds = %_Z21__hetero_hdc_dot_prodILi617EiET0_N15__hypervector__IXT_ES0_E1vES3_.exit.i, %entry
  %indvars.iv.i = phi i64 [ 0, %entry ], [ %indvars.iv.next.i, %_Z21__hetero_hdc_dot_prodILi617EiET0_N15__hypervector__IXT_ES0_E1vES3_.exit.i ]
  %output.019.i = phi <32 x i32> [ undef, %entry ], [ %vecins.i, %_Z21__hetero_hdc_dot_prodILi617EiET0_N15__hypervector__IXT_ES0_E1vES3_.exit.i ]
  call void @llvm.lifetime.start.p0i8(i64 78976, i8* nonnull %4) #18
  store <19744 x i32> %3, <19744 x i32>* %5, align 4, !tbaa !29
  %6 = mul nuw nsw i64 %indvars.iv.i, 617
  %add.ptr.i.i = getelementptr inbounds [19744 x i32], [19744 x i32]* %matrix.addr.i.i, i64 0, i64 %6
  %7 = bitcast i32* %add.ptr.i.i to <617 x i32>*
  %8 = load <617 x i32>, <617 x i32>* %7, align 4, !tbaa !29
  call void @llvm.lifetime.end.p0i8(i64 78976, i8* nonnull %4) #18
  br label %for.body.i.i

for.body.i.i:                                     ; preds = %for.body.i.i, %for.body.i
  %i.09.i.i = phi i32 [ 0, %for.body.i ], [ %inc.i.i, %for.body.i.i ]
  %dot_prod.08.i.i = phi i32 [ 0, %for.body.i ], [ %add.i.i, %for.body.i.i ]
  %vecext.i.i = extractelement <617 x i32> %1, i32 %i.09.i.i
  %vecext1.i.i = extractelement <617 x i32> %8, i32 %i.09.i.i
  %mul.i13.i = mul nsw i32 %vecext.i.i, %vecext1.i.i
  %add.i.i = add nsw i32 %mul.i13.i, %dot_prod.08.i.i
  %inc.i.i = add nuw nsw i32 %i.09.i.i, 1
  %exitcond.not.i.i = icmp eq i32 %inc.i.i, 617
  br i1 %exitcond.not.i.i, label %_Z21__hetero_hdc_dot_prodILi617EiET0_N15__hypervector__IXT_ES0_E1vES3_.exit.i, label %for.body.i.i, !llvm.loop !51

_Z21__hetero_hdc_dot_prodILi617EiET0_N15__hypervector__IXT_ES0_E1vES3_.exit.i: ; preds = %for.body.i.i
  %9 = trunc i64 %indvars.iv.i to i32
  %vecins.i = insertelement <32 x i32> %output.019.i, i32 %add.i.i, i32 %9
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 32
  br i1 %exitcond.not.i, label %for.body.i18, label %for.body.i, !llvm.loop !52

for.body.i18:                                     ; preds = %_Z21__hetero_hdc_dot_prodILi617EiET0_N15__hypervector__IXT_ES0_E1vES3_.exit.i, %for.body.i18
  %i.09.i = phi i32 [ %inc.i, %for.body.i18 ], [ 0, %_Z21__hetero_hdc_dot_prodILi617EiET0_N15__hypervector__IXT_ES0_E1vES3_.exit.i ]
  %output.08.i = phi <32 x i32> [ %vecins.i16, %for.body.i18 ], [ undef, %_Z21__hetero_hdc_dot_prodILi617EiET0_N15__hypervector__IXT_ES0_E1vES3_.exit.i ]
  %vecext.i = extractelement <32 x i32> %vecins.i, i32 %i.09.i
  %cmp1.inv.i = icmp slt i32 %vecext.i, 1
  %conv.i = select i1 %cmp1.inv.i, i32 -1, i32 1
  %vecins.i16 = insertelement <32 x i32> %output.08.i, i32 %conv.i, i32 %i.09.i
  %inc.i = add nuw nsw i32 %i.09.i, 1
  %exitcond.not.i17 = icmp eq i32 %inc.i, 32
  br i1 %exitcond.not.i17, label %_Z17__hetero_hdc_signILi32EiEN15__hypervector__IXT_ET0_E1vES3_.exit, label %for.body.i18, !llvm.loop !48

_Z17__hetero_hdc_signILi32EiEN15__hypervector__IXT_ET0_E1vES3_.exit: ; preds = %for.body.i18
  %10 = bitcast i32* %output_hv_ptr to <32 x i32>*
  store <32 x i32> %vecins.i16, <32 x i32>* %10, align 4, !tbaa !29
  call void @__hetero_task_end(i8* %call1) #18
  call void @__hetero_section_end(i8* %call) #18
  ret void
}

; Function Attrs: nounwind
declare dso_local void @__hetero_wait(i8*) local_unnamed_addr #1

; Function Attrs: mustprogress uwtable
define linkonce_odr dso_local void @_Z9root_nodeILi32ELi1ELi6238ELi617EEvPimS0_mS0_mS0_mS0_miiS0_m(i32* %rp_matrix_ptr, i64 %rp_matrix_size, i32* %datapoint_vec_ptr, i64 %datapoint_vec_size, i32* %encoded_hv_ptr, i64 %encoded_hv_size, i32* %clusters_ptr, i64 %clusters_size, i32* %temp_clusters_ptr, i64 %temp_clusters_size, i32 %num_iterations, i32 %convergence_threshold, i32* %labels, i64 %labels_size) #11 comdat {
entry:
  %matrix.addr.i.i.i = alloca [19744 x i32], align 4
  %call = call i8* @__hetero_section_begin() #18
  %call1 = call i8* (i32, ...) @__hetero_task_begin(i32 6, i32* %rp_matrix_ptr, i64 %rp_matrix_size, i32* %datapoint_vec_ptr, i64 %datapoint_vec_size, i32* %encoded_hv_ptr, i64 %encoded_hv_size, i32* %clusters_ptr, i64 %clusters_size, i32* %temp_clusters_ptr, i64 %temp_clusters_size, i32* %labels, i64 %labels_size, i32 1, i32* %labels, i64 %labels_size, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.24, i64 0, i64 0)) #18
  %call.i = call i8* @__hetero_section_begin() #18
  %call1.i = call i8* (i32, ...) @__hetero_task_begin(i32 3, i32* %rp_matrix_ptr, i64 %rp_matrix_size, i32* %datapoint_vec_ptr, i64 %datapoint_vec_size, i32* %encoded_hv_ptr, i64 %encoded_hv_size, i32 1, i32* %encoded_hv_ptr, i64 %encoded_hv_size) #18
  %0 = bitcast i32* %datapoint_vec_ptr to <617 x i32>*
  %1 = load <617 x i32>, <617 x i32>* %0, align 4, !tbaa !29
  %2 = bitcast i32* %rp_matrix_ptr to <19744 x i32>*
  %3 = load <19744 x i32>, <19744 x i32>* %2, align 4, !tbaa !29
  %4 = bitcast [19744 x i32]* %matrix.addr.i.i.i to i8*
  %5 = bitcast [19744 x i32]* %matrix.addr.i.i.i to <19744 x i32>*
  br label %for.body.i.i

for.body.i.i:                                     ; preds = %_Z21__hetero_hdc_dot_prodILi617EiET0_N15__hypervector__IXT_ES0_E1vES3_.exit.i.i, %entry
  %indvars.iv.i.i = phi i64 [ 0, %entry ], [ %indvars.iv.next.i.i, %_Z21__hetero_hdc_dot_prodILi617EiET0_N15__hypervector__IXT_ES0_E1vES3_.exit.i.i ]
  %output.019.i.i = phi <32 x i32> [ undef, %entry ], [ %vecins.i.i, %_Z21__hetero_hdc_dot_prodILi617EiET0_N15__hypervector__IXT_ES0_E1vES3_.exit.i.i ]
  call void @llvm.lifetime.start.p0i8(i64 78976, i8* nonnull %4) #18
  store <19744 x i32> %3, <19744 x i32>* %5, align 4, !tbaa !29
  %6 = mul nuw nsw i64 %indvars.iv.i.i, 617
  %add.ptr.i.i.i = getelementptr inbounds [19744 x i32], [19744 x i32]* %matrix.addr.i.i.i, i64 0, i64 %6
  %7 = bitcast i32* %add.ptr.i.i.i to <617 x i32>*
  %8 = load <617 x i32>, <617 x i32>* %7, align 4, !tbaa !29
  call void @llvm.lifetime.end.p0i8(i64 78976, i8* nonnull %4) #18
  br label %for.body.i.i.i

for.body.i.i.i:                                   ; preds = %for.body.i.i.i, %for.body.i.i
  %i.09.i.i.i = phi i32 [ 0, %for.body.i.i ], [ %inc.i.i.i, %for.body.i.i.i ]
  %dot_prod.08.i.i.i = phi i32 [ 0, %for.body.i.i ], [ %add.i.i.i, %for.body.i.i.i ]
  %vecext.i.i.i = extractelement <617 x i32> %1, i32 %i.09.i.i.i
  %vecext1.i.i.i = extractelement <617 x i32> %8, i32 %i.09.i.i.i
  %mul.i13.i.i = mul nsw i32 %vecext.i.i.i, %vecext1.i.i.i
  %add.i.i.i = add nsw i32 %mul.i13.i.i, %dot_prod.08.i.i.i
  %inc.i.i.i = add nuw nsw i32 %i.09.i.i.i, 1
  %exitcond.not.i.i.i = icmp eq i32 %inc.i.i.i, 617
  br i1 %exitcond.not.i.i.i, label %_Z21__hetero_hdc_dot_prodILi617EiET0_N15__hypervector__IXT_ES0_E1vES3_.exit.i.i, label %for.body.i.i.i, !llvm.loop !51

_Z21__hetero_hdc_dot_prodILi617EiET0_N15__hypervector__IXT_ES0_E1vES3_.exit.i.i: ; preds = %for.body.i.i.i
  %9 = trunc i64 %indvars.iv.i.i to i32
  %vecins.i.i = insertelement <32 x i32> %output.019.i.i, i32 %add.i.i.i, i32 %9
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.i.i, 1
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, 32
  br i1 %exitcond.not.i.i, label %for.body.i18.i, label %for.body.i.i, !llvm.loop !52

for.body.i18.i:                                   ; preds = %_Z21__hetero_hdc_dot_prodILi617EiET0_N15__hypervector__IXT_ES0_E1vES3_.exit.i.i, %for.body.i18.i
  %i.09.i.i = phi i32 [ %inc.i.i, %for.body.i18.i ], [ 0, %_Z21__hetero_hdc_dot_prodILi617EiET0_N15__hypervector__IXT_ES0_E1vES3_.exit.i.i ]
  %output.08.i.i = phi <32 x i32> [ %vecins.i16.i, %for.body.i18.i ], [ undef, %_Z21__hetero_hdc_dot_prodILi617EiET0_N15__hypervector__IXT_ES0_E1vES3_.exit.i.i ]
  %vecext.i.i = extractelement <32 x i32> %vecins.i.i, i32 %i.09.i.i
  %cmp1.inv.i.i = icmp slt i32 %vecext.i.i, 1
  %conv.i.i = select i1 %cmp1.inv.i.i, i32 -1, i32 1
  %vecins.i16.i = insertelement <32 x i32> %output.08.i.i, i32 %conv.i.i, i32 %i.09.i.i
  %inc.i.i = add nuw nsw i32 %i.09.i.i, 1
  %exitcond.not.i17.i = icmp eq i32 %inc.i.i, 32
  br i1 %exitcond.not.i17.i, label %_Z16rp_encoding_nodeILi32ELi617EEvPimS0_mS0_m.exit, label %for.body.i18.i, !llvm.loop !48

_Z16rp_encoding_nodeILi32ELi617EEvPimS0_mS0_m.exit: ; preds = %for.body.i18.i
  %10 = bitcast i32* %encoded_hv_ptr to <32 x i32>*
  store <32 x i32> %vecins.i16.i, <32 x i32>* %10, align 4, !tbaa !29
  call void @__hetero_task_end(i8* %call1.i) #18
  call void @__hetero_section_end(i8* %call.i) #18
  %call.i20 = call i8* @__hetero_section_begin() #18
  %call1.i21 = call i8* (i32, ...) @__hetero_task_begin(i32 4, i32* %encoded_hv_ptr, i64 %encoded_hv_size, i32* %clusters_ptr, i64 %clusters_size, i32* %temp_clusters_ptr, i64 %temp_clusters_size, i32* %labels, i64 %labels_size, i32 1, i32* %labels, i64 %labels_size) #18
  %11 = load <32 x i32>, <32 x i32>* %10, align 4, !tbaa !29
  %12 = bitcast i32* %temp_clusters_ptr to <32 x i32>*
  %13 = load <32 x i32>, <32 x i32>* %12, align 4, !tbaa !29
  %add.i = add <32 x i32> %13, %11
  store <32 x i32> %add.i, <32 x i32>* %12, align 4, !tbaa !29
  call void @__hetero_task_end(i8* %call1.i21) #18
  call void @__hetero_section_end(i8* %call.i20) #18
  call void @__hetero_task_end(i8* %call1) #18
  call void @__hetero_section_end(i8* %call) #18
  ret void
}

; Function Attrs: uwtable
declare dso_local void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEEC1EPKcSt13_Ios_Openmode(%"class.std::basic_ofstream"* nonnull align 8 dereferenceable(248), i8*, i32) unnamed_addr #5 align 2

; Function Attrs: nounwind uwtable
declare dso_local void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev(%"class.std::basic_ofstream"* nonnull align 8 dereferenceable(248)) unnamed_addr #4 align 2

; Function Attrs: mustprogress nofree nosync nounwind willreturn
declare void @llvm.stackrestore(i8*) #8

; Function Attrs: nobuiltin nounwind
declare dso_local void @_ZdlPv(i8*) local_unnamed_addr #12

declare dso_local i8* @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_createERmm(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32), i64* nonnull align 8 dereferenceable(8), i64) local_unnamed_addr #0

declare dso_local void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* nonnull align 8 dereferenceable(264), i32) local_unnamed_addr #0

declare dso_local %"class.std::basic_filebuf"* @_ZNSt13basic_filebufIcSt11char_traitsIcEE5closeEv(%"class.std::basic_filebuf"* nonnull align 8 dereferenceable(240)) local_unnamed_addr #0

; Function Attrs: nounwind
declare dso_local void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* nonnull align 8 dereferenceable(216)) unnamed_addr #1

; Function Attrs: nounwind uwtable
declare dso_local void @_ZNSt14basic_ifstreamIcSt11char_traitsIcEED2Ev(%"class.std::basic_ifstream"* nonnull align 8 dereferenceable(256), i8**) unnamed_addr #4 align 2

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare dso_local zeroext i1 @_ZNKSt12__basic_fileIcE7is_openEv(%"class.std::__basic_file"* nonnull align 8 dereferenceable(9)) local_unnamed_addr #13

; Function Attrs: uwtable
define linkonce_odr dso_local void @_ZNSt6vectorIiSaIiEE17_M_realloc_insertIJRKiEEEvN9__gnu_cxx17__normal_iteratorIPiS1_EEDpOT_(%"class.std::vector"* nonnull align 8 dereferenceable(24) %this, i32* %__position.coerce, i32* nonnull align 4 dereferenceable(4) %__args) local_unnamed_addr #5 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %_M_finish.i.i = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %this, i64 0, i32 0, i32 0, i32 1
  %0 = load i32*, i32** %_M_finish.i.i, align 8, !tbaa !17
  %_M_start.i.i = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %this, i64 0, i32 0, i32 0, i32 0
  %1 = load i32*, i32** %_M_start.i.i, align 8, !tbaa !36
  %sub.ptr.lhs.cast.i.i = ptrtoint i32* %0 to i64
  %sub.ptr.rhs.cast.i.i = ptrtoint i32* %1 to i64
  %sub.ptr.sub.i.i = sub i64 %sub.ptr.lhs.cast.i.i, %sub.ptr.rhs.cast.i.i
  %sub.ptr.div.i.i = ashr exact i64 %sub.ptr.sub.i.i, 2
  %cmp.i.i = icmp eq i64 %sub.ptr.sub.i.i, 0
  %.sroa.speculated.i = select i1 %cmp.i.i, i64 1, i64 %sub.ptr.div.i.i
  %add.i = add nsw i64 %.sroa.speculated.i, %sub.ptr.div.i.i
  %cmp7.i = icmp ult i64 %add.i, %sub.ptr.div.i.i
  %cmp9.i = icmp ugt i64 %add.i, 4611686018427387903
  %or.cond.i = or i1 %cmp7.i, %cmp9.i
  %cond.i = select i1 %or.cond.i, i64 4611686018427387903, i64 %add.i
  %sub.ptr.lhs.cast.i = ptrtoint i32* %__position.coerce to i64
  %sub.ptr.sub.i = sub i64 %sub.ptr.lhs.cast.i, %sub.ptr.rhs.cast.i.i
  %sub.ptr.div.i = ashr exact i64 %sub.ptr.sub.i, 2
  %cmp.not.i = icmp eq i64 %cond.i, 0
  br i1 %cmp.not.i, label %_ZNSt12_Vector_baseIiSaIiEE11_M_allocateEm.exit, label %cond.true.i

cond.true.i:                                      ; preds = %entry
  %cmp.i.i.i = icmp ugt i64 %cond.i, 4611686018427387903
  br i1 %cmp.i.i.i, label %if.then.i.i.i, label %_ZNSt16allocator_traitsISaIiEE8allocateERS0_m.exit.i

if.then.i.i.i:                                    ; preds = %cond.true.i
  call void @_ZSt17__throw_bad_allocv() #21
  unreachable

_ZNSt16allocator_traitsISaIiEE8allocateERS0_m.exit.i: ; preds = %cond.true.i
  %mul.i.i.i = shl i64 %cond.i, 2
  %call2.i.i.i = call noalias nonnull i8* @_Znwm(i64 %mul.i.i.i) #22
  %2 = bitcast i8* %call2.i.i.i to i32*
  br label %_ZNSt12_Vector_baseIiSaIiEE11_M_allocateEm.exit

_ZNSt12_Vector_baseIiSaIiEE11_M_allocateEm.exit:  ; preds = %entry, %_ZNSt16allocator_traitsISaIiEE8allocateERS0_m.exit.i
  %cond.i66 = phi i32* [ %2, %_ZNSt16allocator_traitsISaIiEE8allocateERS0_m.exit.i ], [ null, %entry ]
  %add.ptr = getelementptr inbounds i32, i32* %cond.i66, i64 %sub.ptr.div.i
  %3 = load i32, i32* %__args, align 4, !tbaa !3
  store i32 %3, i32* %add.ptr, align 4, !tbaa !3
  %4 = load i32*, i32** %_M_start.i.i, align 8, !tbaa !36
  %sub.ptr.rhs.cast.i.i.i.i.i.i.i.i = ptrtoint i32* %4 to i64
  %sub.ptr.sub.i.i.i.i.i.i.i.i = sub i64 %sub.ptr.lhs.cast.i, %sub.ptr.rhs.cast.i.i.i.i.i.i.i.i
  %tobool.not.i.i.i.i.i.i.i.i = icmp eq i64 %sub.ptr.sub.i.i.i.i.i.i.i.i, 0
  br i1 %tobool.not.i.i.i.i.i.i.i.i, label %_ZSt34__uninitialized_move_if_noexcept_aIPiS0_SaIiEET0_T_S3_S2_RT1_.exit, label %if.then.i.i.i.i.i.i.i.i

if.then.i.i.i.i.i.i.i.i:                          ; preds = %_ZNSt12_Vector_baseIiSaIiEE11_M_allocateEm.exit
  %5 = bitcast i32* %cond.i66 to i8*
  %6 = bitcast i32* %4 to i8*
  call void @llvm.memmove.p0i8.p0i8.i64(i8* align 4 %5, i8* align 4 %6, i64 %sub.ptr.sub.i.i.i.i.i.i.i.i, i1 false) #18
  br label %_ZSt34__uninitialized_move_if_noexcept_aIPiS0_SaIiEET0_T_S3_S2_RT1_.exit

_ZSt34__uninitialized_move_if_noexcept_aIPiS0_SaIiEET0_T_S3_S2_RT1_.exit: ; preds = %_ZNSt12_Vector_baseIiSaIiEE11_M_allocateEm.exit, %if.then.i.i.i.i.i.i.i.i
  %sub.ptr.div.i.i.i.i.i.i.i.i = ashr exact i64 %sub.ptr.sub.i.i.i.i.i.i.i.i, 2
  %incdec.ptr.idx = add nsw i64 %sub.ptr.div.i.i.i.i.i.i.i.i, 1
  %incdec.ptr = getelementptr inbounds i32, i32* %cond.i66, i64 %incdec.ptr.idx
  %7 = load i32*, i32** %_M_finish.i.i, align 8, !tbaa !17
  %sub.ptr.lhs.cast.i.i.i.i.i.i.i.i68 = ptrtoint i32* %7 to i64
  %sub.ptr.sub.i.i.i.i.i.i.i.i70 = sub i64 %sub.ptr.lhs.cast.i.i.i.i.i.i.i.i68, %sub.ptr.lhs.cast.i
  %tobool.not.i.i.i.i.i.i.i.i71 = icmp eq i64 %sub.ptr.sub.i.i.i.i.i.i.i.i70, 0
  br i1 %tobool.not.i.i.i.i.i.i.i.i71, label %_ZSt34__uninitialized_move_if_noexcept_aIPiS0_SaIiEET0_T_S3_S2_RT1_.exit75, label %if.then.i.i.i.i.i.i.i.i72

if.then.i.i.i.i.i.i.i.i72:                        ; preds = %_ZSt34__uninitialized_move_if_noexcept_aIPiS0_SaIiEET0_T_S3_S2_RT1_.exit
  %8 = bitcast i32* %incdec.ptr to i8*
  %9 = bitcast i32* %__position.coerce to i8*
  call void @llvm.memmove.p0i8.p0i8.i64(i8* align 4 %8, i8* align 4 %9, i64 %sub.ptr.sub.i.i.i.i.i.i.i.i70, i1 false) #18
  br label %_ZSt34__uninitialized_move_if_noexcept_aIPiS0_SaIiEET0_T_S3_S2_RT1_.exit75

_ZSt34__uninitialized_move_if_noexcept_aIPiS0_SaIiEET0_T_S3_S2_RT1_.exit75: ; preds = %_ZSt34__uninitialized_move_if_noexcept_aIPiS0_SaIiEET0_T_S3_S2_RT1_.exit, %if.then.i.i.i.i.i.i.i.i72
  %tobool.not.i = icmp eq i32* %4, null
  br i1 %tobool.not.i, label %_ZNSt12_Vector_baseIiSaIiEE13_M_deallocateEPim.exit, label %if.then.i76

if.then.i76:                                      ; preds = %_ZSt34__uninitialized_move_if_noexcept_aIPiS0_SaIiEET0_T_S3_S2_RT1_.exit75
  %10 = bitcast i32* %4 to i8*
  call void @_ZdlPv(i8* nonnull %10) #18
  br label %_ZNSt12_Vector_baseIiSaIiEE13_M_deallocateEPim.exit

_ZNSt12_Vector_baseIiSaIiEE13_M_deallocateEPim.exit: ; preds = %_ZSt34__uninitialized_move_if_noexcept_aIPiS0_SaIiEET0_T_S3_S2_RT1_.exit75, %if.then.i76
  %_M_end_of_storage = getelementptr inbounds %"class.std::vector", %"class.std::vector"* %this, i64 0, i32 0, i32 0, i32 2
  %sub.ptr.div.i.i.i.i.i.i.i.i73 = ashr exact i64 %sub.ptr.sub.i.i.i.i.i.i.i.i70, 2
  %add.ptr.i.i.i.i.i.i.i.i74 = getelementptr inbounds i32, i32* %incdec.ptr, i64 %sub.ptr.div.i.i.i.i.i.i.i.i73
  store i32* %cond.i66, i32** %_M_start.i.i, align 8, !tbaa !36
  store i32* %add.ptr.i.i.i.i.i.i.i.i74, i32** %_M_finish.i.i, align 8, !tbaa !17
  %add.ptr39 = getelementptr inbounds i32, i32* %cond.i66, i64 %cond.i
  store i32* %add.ptr39, i32** %_M_end_of_storage, align 8, !tbaa !20
  ret void
}

; Function Attrs: noreturn
declare dso_local void @_ZSt17__throw_bad_allocv() local_unnamed_addr #14

; Function Attrs: nobuiltin allocsize(0)
declare dso_local nonnull i8* @_Znwm(i64) local_unnamed_addr #15

; Function Attrs: argmemonly mustprogress nofree nounwind willreturn
declare void @llvm.memmove.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #9

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i8*, i64) local_unnamed_addr #0

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i8 signext) local_unnamed_addr #0

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8)) local_unnamed_addr #0

; Function Attrs: noreturn
declare dso_local void @_ZSt16__throw_bad_castv() local_unnamed_addr #14

declare dso_local void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* nonnull align 8 dereferenceable(570)) local_unnamed_addr #0

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo9_M_insertIlEERSoT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i64) local_unnamed_addr #0

; Function Attrs: nounwind
declare dso_local i8* @__hetero_section_begin() local_unnamed_addr #1

; Function Attrs: nounwind
declare dso_local i8* @__hetero_task_begin(i32, ...) local_unnamed_addr #1

; Function Attrs: nounwind
declare dso_local void @__hetero_task_end(i8*) local_unnamed_addr #1

; Function Attrs: nounwind
declare dso_local void @__hetero_section_end(i8*) local_unnamed_addr #1

; Function Attrs: uwtable
define internal void @_GLOBAL__sub_I_host.cpp() #5 section ".text.startup" personality i32 (...)* @__gxx_personality_v0 {
entry:
  %__dnew.i.i.i.i.i1 = alloca i64, align 8
  %__dnew.i.i.i.i.i = alloca i64, align 8
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) @_ZStL8__ioinit)
  %0 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* nonnull @__dso_handle) #18
  store %union.anon* getelementptr inbounds (%"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* @_Z11X_data_pathB5cxx11, i64 0, i32 2), %union.anon** bitcast (%"class.std::__cxx11::basic_string"* @_Z11X_data_pathB5cxx11 to %union.anon**), align 8, !tbaa !30
  %1 = bitcast i64* %__dnew.i.i.i.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %1) #18
  store i64 34, i64* %__dnew.i.i.i.i.i, align 8, !tbaa !35
  %call5.i.i.i10.i2.i = call i8* @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_createERmm(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) @_Z11X_data_pathB5cxx11, i64* nonnull align 8 dereferenceable(8) %__dnew.i.i.i.i.i, i64 0)
  store i8* %call5.i.i.i10.i2.i, i8** getelementptr inbounds (%"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* @_Z11X_data_pathB5cxx11, i64 0, i32 0, i32 0), align 8, !tbaa !32
  %2 = load i64, i64* %__dnew.i.i.i.i.i, align 8, !tbaa !35
  store i64 %2, i64* getelementptr inbounds (%"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* @_Z11X_data_pathB5cxx11, i64 0, i32 2, i32 0), align 8, !tbaa !29
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(34) %call5.i.i.i10.i2.i, i8* noundef nonnull align 1 dereferenceable(34) getelementptr inbounds ([35 x i8], [35 x i8]* @.str, i64 0, i64 0), i64 34, i1 false) #18
  store i64 %2, i64* getelementptr inbounds (%"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* @_Z11X_data_pathB5cxx11, i64 0, i32 1), align 8, !tbaa !34
  %arrayidx.i.i.i.i.i.i = getelementptr inbounds i8, i8* %call5.i.i.i10.i2.i, i64 %2
  store i8 0, i8* %arrayidx.i.i.i.i.i.i, align 1, !tbaa !29
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %1) #18
  %3 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::__cxx11::basic_string"*)* @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev to void (i8*)*), i8* bitcast (%"class.std::__cxx11::basic_string"* @_Z11X_data_pathB5cxx11 to i8*), i8* nonnull @__dso_handle) #18
  store %union.anon* getelementptr inbounds (%"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* @_Z11y_data_pathB5cxx11, i64 0, i32 2), %union.anon** bitcast (%"class.std::__cxx11::basic_string"* @_Z11y_data_pathB5cxx11 to %union.anon**), align 8, !tbaa !30
  %4 = bitcast i64* %__dnew.i.i.i.i.i1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %4) #18
  store i64 34, i64* %__dnew.i.i.i.i.i1, align 8, !tbaa !35
  %call5.i.i.i10.i2.i2 = call i8* @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_createERmm(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) @_Z11y_data_pathB5cxx11, i64* nonnull align 8 dereferenceable(8) %__dnew.i.i.i.i.i1, i64 0)
  store i8* %call5.i.i.i10.i2.i2, i8** getelementptr inbounds (%"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* @_Z11y_data_pathB5cxx11, i64 0, i32 0, i32 0), align 8, !tbaa !32
  %5 = load i64, i64* %__dnew.i.i.i.i.i1, align 8, !tbaa !35
  store i64 %5, i64* getelementptr inbounds (%"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* @_Z11y_data_pathB5cxx11, i64 0, i32 2, i32 0), align 8, !tbaa !29
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(34) %call5.i.i.i10.i2.i2, i8* noundef nonnull align 1 dereferenceable(34) getelementptr inbounds ([35 x i8], [35 x i8]* @.str.3, i64 0, i64 0), i64 34, i1 false) #18
  store i64 %5, i64* getelementptr inbounds (%"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* @_Z11y_data_pathB5cxx11, i64 0, i32 1), align 8, !tbaa !34
  %arrayidx.i.i.i.i.i.i3 = getelementptr inbounds i8, i8* %call5.i.i.i10.i2.i2, i64 %5
  store i8 0, i8* %arrayidx.i.i.i.i.i.i3, align 1, !tbaa !29
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %4) #18
  %6 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::__cxx11::basic_string"*)* @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev to void (i8*)*), i8* bitcast (%"class.std::__cxx11::basic_string"* @_Z11y_data_pathB5cxx11 to i8*), i8* nonnull @__dso_handle) #18
  ret void
}

; Function Attrs: argmemonly nofree nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #16

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.umax.i64(i64, i64) #17

attributes #0 = { "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind }
attributes #3 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #4 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { noreturn nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { norecurse uwtable "frame-pointer"="none" "min-legal-vector-width"="1024" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { mustprogress nofree nosync nounwind willreturn }
attributes #9 = { argmemonly mustprogress nofree nounwind willreturn }
attributes #10 = { mustprogress nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="631808" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #11 = { mustprogress uwtable "frame-pointer"="none" "min-legal-vector-width"="631808" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #12 = { nobuiltin nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #13 = { mustprogress nofree nounwind readonly willreturn "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #14 = { noreturn "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #15 = { nobuiltin allocsize(0) "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #16 = { argmemonly nofree nounwind willreturn writeonly }
attributes #17 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #18 = { nounwind }
attributes #19 = { nounwind readonly willreturn }
attributes #20 = { noreturn nounwind }
attributes #21 = { noreturn }
attributes #22 = { allocsize(0) }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{!"clang version 13.0.0 (https://gitlab.engr.illinois.edu/llvm/hpvm.git 2602b1ef68733874f30035a9eea4f9588ff91f01)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{!8, !8, i64 0}
!8 = !{!"vtable pointer", !6, i64 0}
!9 = !{!10, !13, i64 32}
!10 = !{!"_ZTSSt8ios_base", !11, i64 8, !11, i64 16, !12, i64 24, !13, i64 28, !13, i64 32, !14, i64 40, !15, i64 48, !5, i64 64, !4, i64 192, !14, i64 200, !16, i64 208}
!11 = !{!"long", !5, i64 0}
!12 = !{!"_ZTSSt13_Ios_Fmtflags", !5, i64 0}
!13 = !{!"_ZTSSt12_Ios_Iostate", !5, i64 0}
!14 = !{!"any pointer", !5, i64 0}
!15 = !{!"_ZTSNSt8ios_base6_WordsE", !14, i64 0, !11, i64 8}
!16 = !{!"_ZTSSt6locale", !14, i64 0}
!17 = !{!18, !14, i64 8}
!18 = !{!"_ZTSSt12_Vector_baseIiSaIiEE", !19, i64 0}
!19 = !{!"_ZTSNSt12_Vector_baseIiSaIiEE12_Vector_implE", !14, i64 0, !14, i64 8, !14, i64 16}
!20 = !{!18, !14, i64 16}
!21 = distinct !{!21, !22, !23}
!22 = !{!"llvm.loop.mustprogress"}
!23 = !{!"llvm.loop.unroll.disable"}
!24 = !{!25, !14, i64 240}
!25 = !{!"_ZTSSt9basic_iosIcSt11char_traitsIcEE", !14, i64 216, !5, i64 224, !26, i64 225, !14, i64 232, !14, i64 240, !14, i64 248, !14, i64 256}
!26 = !{!"bool", !5, i64 0}
!27 = !{!28, !5, i64 56}
!28 = !{!"_ZTSSt5ctypeIcE", !14, i64 16, !26, i64 24, !14, i64 32, !14, i64 40, !14, i64 48, !5, i64 56, !5, i64 57, !5, i64 313, !5, i64 569}
!29 = !{!5, !5, i64 0}
!30 = !{!31, !14, i64 0}
!31 = !{!"_ZTSNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderE", !14, i64 0}
!32 = !{!33, !14, i64 0}
!33 = !{!"_ZTSNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE", !31, i64 0, !11, i64 8, !5, i64 16}
!34 = !{!33, !11, i64 8}
!35 = !{!11, !11, i64 0}
!36 = !{!18, !14, i64 0}
!37 = !{!26, !26, i64 0}
!38 = !{i8 0, i8 2}
!39 = distinct !{!39, !22, !23}
!40 = distinct !{!40, !22, !23}
!41 = distinct !{!41, !22, !23}
!42 = distinct !{!42, !22, !23}
!43 = distinct !{!43, !22, !23}
!44 = distinct !{!44, !22, !23}
!45 = distinct !{!45, !22, !23}
!46 = distinct !{!46, !22, !23}
!47 = distinct !{!47, !22, !23}
!48 = distinct !{!48, !22, !23}
!49 = distinct !{!49, !22, !23}
!50 = distinct !{!50, !22, !23}
!51 = distinct !{!51, !22, !23}
!52 = distinct !{!52, !22, !23}
