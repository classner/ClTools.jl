using OpenCV
using ClTools
using Base.Test
using ImageCore
using MicroLogging


limit_logging(MicroLogging.Info);

# Visualization.
img = ones(UInt8, 100, 100);
ClTools.visualization.apply_colormap(img; vmin=0, vmax=18, cmap=22);
ClTools.visualization.apply_colormap(img; vmin=0, vmax=18, cmap=:viridis);
img = ones(Float32, 100, 100);
ClTools.visualization.apply_colormap(img; vmin=0, vmax=18, cmap=22);
ClTools.visualization.apply_colormap(img; vmin=0, vmax=18, cmap=:viridis);
duration = @elapsed ClTools.visualization.apply_colormap(img;
                                                         vmin=0, vmax=18,
                                                         cmap=22);
@info "Visualizing a 100x100 image took $(duration)s."

# Configuration.
ncpus = ClTools.config.available_cpu_count()
@info "This machine has $(ncpus) CPUs."
npus = ClTools.config.available_pu_count()
@info "This machine has $(npus) PUs."
