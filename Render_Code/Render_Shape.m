(* ::Package:: *)

(* ::Input::Initialization:: *)
ClearAll[MPLColorMap]
<<"http://pastebin.com/raw/pFsb4ZBS";


(* ::Input::Initialization:: *)
SetDirectory["/Users/jordan/Desktop/Bent_4/"];


(* ::Input::Initialization:: *)
files=FileNames[];


(* ::Input::Initialization:: *)
printvertex[vec_]:=Return["      <"<>ToString[vec[[1]][[1]]]<>","<>ToString[vec[[1]][[2]]]<>","<>ToString[vec[[1]][[3]]]<>">, "<>"<"<>ToString[vec[[2]][[1]]]<>","<>ToString[vec[[2]][[2]]]<>","<>ToString[vec[[2]][[3]]]<>">, "<>"<"<>ToString[vec[[3]][[1]]]<>","<>ToString[vec[[3]][[2]]]<>","<>ToString[vec[[3]][[3]]]<>">,\n"]
printvertex2[vec_]:=Return["      <"<>ToString[vec[[1]][[1]]]<>","<>ToString[vec[[1]][[2]]]<>","<>ToString[vec[[1]][[3]]]<>">, "<>"<"<>ToString[vec[[2]][[1]]]<>","<>ToString[vec[[2]][[2]]]<>","<>ToString[vec[[2]][[3]]]<>">, "<>"<"<>ToString[vec[[3]][[1]]]<>","<>ToString[vec[[3]][[2]]]<>","<>ToString[vec[[3]][[3]]]<>">\n"]
print2[vec_]:=Return["      <"<>ToString[vec[[1]]]<>","<>ToString[vec[[2]]]<>","<>ToString[vec[[3]]]<>">,\n"]
print22[vec_]:=Return["      <"<>ToString[vec[[1]]]<>","<>ToString[vec[[2]]]<>","<>ToString[vec[[3]]]<>">\n"]
unitnormal[verts_]:=Round[Normalize[Cross[verts[[2]]-verts[[1]],verts[[3]]-verts[[1]]]],10^-5];
includer[TIME_,NUC_]:=Return["#include \"Nucleus_"<>ToString[NUC]<>"_Time_"<>ToString[TIME]<>".txt\"\n"]
makecol[vec_]:=Return["   pigment{rgbt <"<>ToString[vec[[1]]]<>","<>ToString[vec[[2]]]<>","<>ToString[vec[[3]]]<>",0.5>} finish{specular 0.5 ambient 0.42}"]


(* ::Input::Initialization:: *)
includer2[TIME_,NUC_]:=Return["#include \"Nucleus2_"<>ToString[NUC]<>"_Time_"<>ToString[TIME]<>".txt\"\n"]


(* ::Input:: *)
(*colorss=Table[RandomColor[],{10000}];*)


(* ::Input:: *)
(*colorss=Table[RGBColor[0.92,RandomReal[{0,0.5}],RandomReal[{0,0.5}]],{10000}];*)


(* ::Input:: *)
(*colorss[[1;;2]]*)


(* ::Input:: *)
(*Table[*)
(*colorss[[j]]=RandomChoice[{RGBColor[{0.6509803921568628, 0.807843137254902, 0.8901960784313725}],RGBColor[{0.12156862745098039`, 0.47058823529411764`, 0.7058823529411764}],RGBColor[{0.6980392156862745, 0.8745098039215686, 0.5411764705882353}],RGBColor[{0.2, 0.6274509803921569, 0.17254901960784313`}],RGBColor[{0.984313725490196, 0.6039215686274509, 0.6}],RGBColor[{0.8901960784313725, 0.10196078431372549`, 0.10980392156862745`}],RGBColor[{0.9921568627450981, 0.7490196078431373, 0.43529411764705883`}],RGBColor[{1., 0.4980392156862745, 0.}],RGBColor[{0.792156862745098, 0.6980392156862745, 0.8392156862745098}],RGBColor[{0.4156862745098039, 0.2392156862745098, 0.6039215686274509}],RGBColor[{1., 1., 0.6}]}](*Hue[RandomReal[],1,1]*);*)
(*,{j,1,10000}];*)


(* ::Input:: *)
(*colorss[[1;;64]]*)


(* ::Input:: *)
(*colorss=Table[*)
(*ColorConvert[colorss[[i]],"RGB"]*)
(*,{i,1,Length[colorss]}];*)


(* ::Input:: *)
(*TIME2=400;*)
(*TIME=TIME2;*)


(* ::Input::Initialization:: *)
(*For[TIME=TIME2,TIME\[LessEqual]TIME2,TIME++,*)
Print[TIME];
data=Import["/Users/jordan/Desktop/Bent_4/locations_0_"<>ToString[TIME]<>".csv","Data"];
points=Import["/Users/jordan/Desktop/Bent_4/locations_0_"<>ToString[TIME]<>".csv","Data"];
NEXT=Import["/Users/jordan/Desktop/Bent_4/locations_0_"<>ToString[TIME+2]<>".csv","Data"];
Print["Length of data"];
Print[Length[data]];
SPEEDS=ParallelTable[
speed=1100/400Min[Table[
Norm[data[[nn]]-NEXT[[j]]]
,{j,1,Length[NEXT]}]];
speed/4
,{nn,1,Length[data]}];
Print["Spped ok"];
cols=Table[
MPLColorMap["Magma"][SPEEDS[[n]]]
,{n,1,Length[SPEEDS]}];
Print["Length of cols "<>ToString[Length[cols]]];
ds=ParallelTable[
1(*1+SignedRegionDistance[el,data[[m]]]/20*)
,{m,1,Length[data]}];
Print["Distance ok"];
cols2=Table[
colorss[[m]]
,{m,1,Length[ds]}];
Print["Length of cols2 "<>ToString[Length[cols2]]];
SetDirectory["/Users/jordan/Desktop/render_2d"];


(* ::Input::Initialization:: *)
orbs=Table[
{cols[[i]],Specularity[White,100],Sphere[data[[i]],1]}
,{i,1,Length[data]}];
Export["spheres_"<>ToString[TIME]<>".pov",
Graphics3D[Table[
{cols[[i]],Specularity[White,50],Sphere[data[[i]]]}
,{i,1,Length[data]}]]
,"POV"];
Export["spheres2_"<>ToString[TIME]<>".pov",
Graphics3D[Table[
{cols2[[i]],Specularity[White,50],Sphere[data[[i]]]}
,{i,1,Length[data]}]]
,"POV"];
Print["Did export"];
SetDirectory["/Users/jordan/Desktop/render_2d"];


(* ::Input::Initialization:: *)
shells=Table[
"shell_0_"<>ToString[TIME]<>"_"<>ToString[ooo-1]<>".csv"
,{ooo,1,Length[data]}];
convexhulls=ParallelTable[
SetDirectory["/Users/jordan/Desktop/Bent_4/"];
tmp=Import[shells[[nn]],"Data"][[1;;-1]];
If[Length[tmp]>1000,
tmp=tmp[[1;;-1;;2]];
];
tmp=Table[tmp[[nnn]]+0.001{RandomReal[{-1,1}],RandomReal[{-1,1}],RandomReal[{-1,1}]},{nnn,1,Length[tmp]}];
ConvexHullMesh[tmp]
,{nn,1,Length[shells]}];
Print["Time is: "<>ToString[TIME]<>" Length is: "<>ToString[Length[convexhulls]]];


(* ::Input:: *)
(*cols2*)


(* ::Input:: *)
(*ColorConvert[cols2[[1]],"RGB"]*)


(* ::Input:: *)
(*makecol[ColorConvert[cols2[[1]],"RGB"]]*)


(* ::Input::Initialization:: *)
For[NUC=1,NUC<=Length[convexhulls],NUC++,
convexhull=convexhulls[[NUC]];
triangles=MeshPrimitives[convexhull,2];
triangles=Table[
triangles[[j]][[1]]
,{j,1,Length[triangles]}];
Len=Length[triangles];
getnormals=Table[
Table[
{triangles[[k]][[j]],unitnormal[triangles[[k]]]//N}
,{j,1,3}]
,{k,1,Length[triangles]}];
getnormals=Partition[Flatten[getnormals],6];
getnormals=Table[
Partition[getnormals[[j]],3]
,{j,1,Length[getnormals]}];
corrds=getnormals[[All,1]];
normals=getnormals[[All,2]];
NORMALS=Table[
Table[Mean[Extract[normals,Position[corrds,triangles[[j]][[i]]]]]+0.0001{RandomReal[{-1,1}],RandomReal[{-1,1}],RandomReal[{-1,1}]},{i,1,3}]
,{j,1,Length[triangles]}];
sets=Partition[Range[3*Len]-1,3];
ps=Position[Abs[NORMALS],_?(#<0.0001&)];
Table[
NORMALS[[ps[[j]][[1]],ps[[j]][[2]],ps[[j]][[3]]]]=0;
,{j,1,Length[ps]}];
ps=Position[Abs[triangles],_?(#<0.0001&)];
Table[
triangles[[ps[[j]][[1]],ps[[j]][[2]],ps[[j]][[3]]]]=0;
,{j,1,Length[ps]}];

forPOV=StringJoin[{
"mesh2 {
   vertex_vectors {\n"
,
"      "<>ToString[3*Len]<>",\n"
,
Table[
printvertex[triangles[[j]]]
,{j,1,Length[triangles]-1}]
,
printvertex2[triangles[[-1]]]
,
"   }\n"
,
"   normal_vectors {\n"
,
"      "<>ToString[3*Len]<>",\n"
,
Table[
printvertex[NORMALS[[j]]]
,{j,1,Length[NORMALS]-1}]
,
printvertex2[NORMALS[[-1]]]
,
"   }\n"
,
"   face_indices {\n"
,
"      "<>ToString[Len]<>",\n"
,
Table[
print2[sets[[j]]]
,{j,1,Length[sets]-1}]
,
print22[sets[[-1]]]

,
"   }\n"
,
makecol[cols[[NUC]]]
,
"\n}"
}];
SetDirectory["//Users/jordan/Desktop/render_2d"];
Export["Nucleus_"<>ToString[NUC]<>"_Time_"<>ToString[TIME]<>".txt",forPOV];
];
For[NUC=1,NUC<=Length[convexhulls],NUC++,
convexhull=convexhulls[[NUC]];
triangles=MeshPrimitives[convexhull,2];
triangles=Table[
triangles[[j]][[1]]
,{j,1,Length[triangles]}];
Len=Length[triangles];
getnormals=Table[
Table[
{triangles[[k]][[j]],unitnormal[triangles[[k]]]//N}
,{j,1,3}]
,{k,1,Length[triangles]}];
getnormals=Partition[Flatten[getnormals],6];
getnormals=Table[
Partition[getnormals[[j]],3]
,{j,1,Length[getnormals]}];
corrds=getnormals[[All,1]];
normals=getnormals[[All,2]];
NORMALS=Table[
Table[Mean[Extract[normals,Position[corrds,triangles[[j]][[i]]]]]+0.0001{RandomReal[{-1,1}],RandomReal[{-1,1}],RandomReal[{-1,1}]},{i,1,3}]
,{j,1,Length[triangles]}];
sets=Partition[Range[3*Len]-1,3];
ps=Position[Abs[NORMALS],_?(#<0.0001&)];
Table[
NORMALS[[ps[[j]][[1]],ps[[j]][[2]],ps[[j]][[3]]]]=0;
,{j,1,Length[ps]}];
ps=Position[Abs[triangles],_?(#<0.0001&)];
Table[
triangles[[ps[[j]][[1]],ps[[j]][[2]],ps[[j]][[3]]]]=0;
,{j,1,Length[ps]}];

forPOV=StringJoin[{
"mesh2 {
   vertex_vectors {\n"
,
"      "<>ToString[3*Len]<>",\n"
,
Table[
printvertex[triangles[[j]]]
,{j,1,Length[triangles]-1}]
,
printvertex2[triangles[[-1]]]
,
"   }\n"
,
"   normal_vectors {\n"
,
"      "<>ToString[3*Len]<>",\n"
,
Table[
printvertex[NORMALS[[j]]]
,{j,1,Length[NORMALS]-1}]
,
printvertex2[NORMALS[[-1]]]
,
"   }\n"
,
"   face_indices {\n"
,
"      "<>ToString[Len]<>",\n"
,
Table[
print2[sets[[j]]]
,{j,1,Length[sets]-1}]
,
print22[sets[[-1]]]

,
"   }\n"
,
makecol[cols2[[NUC]]]
,
"\n}"
}];
SetDirectory["/Users/jordan/Desktop/render_2d"];
Export["Nucleus2_"<>ToString[NUC]<>"_Time_"<>ToString[TIME]<>".txt",forPOV];
];
string1="#version 3.6;

// Right-handed coordinate system in which the z-axis points upwards
camera {
\tlocation <950,900,900>
\tsky z
\tright -0.24*x*image_width/image_height
\tup 0.24*z
\tlook_at <200,50,50>
}

// White background
background{rgb 1.0}

// Two lights with slightly different colors
light_source{<280,250,175> color rgb <0.77,0.75,0.75>}
light_source{<280,50,275> color rgb <0.38,0.40,0.40>}

#include \"spheres_"<>ToString[TIME]<>".pov\"
#include \"SHELL.txt\"
";
MAINFILE=StringJoin[
string1,
Table[
includer[TIME,k]
,{k,1,Length[convexhulls]}]
];
Export["Render_"<>ToString[TIME]<>".txt",MAINFILE];
string1="#version 3.6;

// Right-handed coordinate system in which the z-axis points upwards
camera {
\tlocation <950,900,900>
\tsky z
\tright -0.24*x*image_width/image_height
\tup 0.24*z
\tlook_at <200,50,50>
}

// White background
background{rgb 1.0}

// Two lights with slightly different colors
light_source{<280,250,175> color rgb <0.77,0.75,0.75>}
light_source{<280,50,275> color rgb <0.38,0.40,0.40>}

#include \"spheres2_"<>ToString[TIME]<>".pov\"
#include \"SHELL.txt\"
";
MAINFILE=StringJoin[
string1,
Table[
includer2[TIME,k]
,{k,1,Length[convexhulls]}]
];
Export["Render2_"<>ToString[TIME]<>".txt",MAINFILE];



(* ::Input:: *)
(*data[[1]]*)


(* ::Input:: *)
(*SetDirectory["/Users/jordan/Desktop/render_2d"];*)


(* ::Input:: *)
(*Export["Rods.pov",*)
(*Graphics3D[*)
(*(*SetDirectory["/Users/jordan/Desktop/Bent_4/"];*)*)
(*Table[*)
(*rods=1.Import["/Users/jordan/Desktop/Bent_4/"<>shells[[hh]],"CSV"];*)
(*Table[*)
(*{cols2[[hh]],Opacity[0.2],Cylinder[{data[[hh]],rods[[h]]},0.1]}*)
(*,{h,1,Length[rods]}]*)
(*,{hh,1,Length[data]}]*)
(*]*)
(*,"POV"]*)
