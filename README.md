# Insect-Development-Model
Code by Jordan Hoffmann
Work by Seth Donoughe and Jordan Hoffmann
Done in the lab of Cassandra Extavour

_All code will be uploaded with the manuscript preprint. Feel fee to contact me if you have any questions._

Based on experimental data from a light-sheet microscope, I developed a model that recapitulates the observed motion of nuclei.

Below, we show a schematic representation of a computational method for simulating syncytial development. Nucleus movements are simulated in a 3D egg, but it is schematized here in 2D. 

![Setup](./ims/model_cartoon.png)

The model is implemented in `Python.` By solving the Eikonal equation, <a href="https://www.codecogs.com/eqnedit.php?latex=F(\vec{x})&space;|&space;\nabla&space;T(\vec{x})&space;|&space;=&space;1" target="_blank"><img src="https://latex.codecogs.com/gif.latex?F(\vec{x})&space;|&space;\nabla&space;T(\vec{x})&space;|&space;=&space;1" title="F(\vec{x}) | \nabla T(\vec{x}) | = 1" /></a>. I do this using the `scikit-fmm` library. This approach naturally captures many aspects of development and results in a minimal number of free parameters, almost all of which can be directly extracted from the data. 

# Geometry
We are able to deploy our model over a wide range of different geometries. Below, we show an example in a slightly bent embryo shape as well as an ellipsoidal shape.
![concave](./ims/shape_1.png)
Below, I show an ellipsoidal geometry. 
![convex](./ims/shape_2.png)
In the above two plots, the colors are random for the different nuclei.

Insect eggs adopt a very large space of shapes and sizes. Many eggs are curved into U shapes, have large asymmetries, and eggs range in volume by more than 8 orders of magnitude. An advantage of having an _in silico_ model is that by altering the geometry, we are able to ask what would happen if a model, tuned on one organism, where to operate in the egg of another. This allows us to make potential hypothesis and targeted experimental predictions.
![diversity](./ims/diversity.png)
In the above plot, the color represents the instantaneous speed of motion at the snapshot that is shown.

# Comparison to Experimental Data
By extract parameters from the data, we are able to match every quantifiable aspect of embryonic development that we are able to measure. s
 
# Fate
In the development of _Gryllus bimaculatus_, only a small fraction of the entire egg volume comprises the region where the embryo will coalesce. By using our developmental model, we are able to perfectly track nuclei through time. This allows us to hypothesis answers related to fate determination of nuclei (whether they will become embryonic or extra embryonic). A rough example of the capabilities are shown below. 
![fate](./ims/fate.png)
For each nuclei, we compute which fraction of the nuclei end up in a preselected embryonic region, versus what fraction of nuclei end up in the extra-embryonic region.

# Rendering Code	
A few people have asked me for the code I used to render the images. I used `povray` which can be installed easily on Ubuntu. On Mac, it is easily installed with either MacPorts or Brew. At the moment, I added a random file I had. It is a bit messy, but feel free to modify it to suit your needs or contact me. 