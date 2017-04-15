using OpenCV
using ClTools
using Base.Test
using ImageCore
using MicroLogging


limit_logging(MicroLogging.Info);

img = ones(UInt8, 100, 100);
ClTools.visualization.apply_colormap(img; vmin=0, vmax=18, cmap=22);
ClTools.visualization.apply_colormap(img; vmin=0, vmax=18, cmap=:viridis);
img = ones(Float32, 100, 100);
ClTools.visualization.apply_colormap(img; vmin=0, vmax=18, cmap=22);
ClTools.visualization.apply_colormap(img; vmin=0, vmax=18, cmap=:viridis);
duration = @elapsed ClTools.visualization.apply_colormap(img;
                                                         vmin=0, vmax=18,
                                                         cmap=22);
println("Visualizing a 100x100 image took $(duration)s.");
