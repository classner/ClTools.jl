module visualization

importall MicroLogging
import ImageCore: colorview, normedview
import Colors: RGB, distinguishable_colors
import PlotUtils: cgrad


"""
Apply a colormap to an image.

If vmin or vmax is provided, normalize the values in the given range. `cmap` can
either be a matplotlib colormap name or a number. In the latter case, a colormap
is generated with `cmap` discrete, as well as possible distinguishable colors.
`cmap_seed` can be used to set a different seed color for creating these values.
"""
function apply_colormap{T<:Real}(image::Array{T, 2};
                                 vmin=nothing, vmax=nothing, cmap=:viridis,
                                 cmap_seed=nothing)
    @debug "Input image shape: $(size(image))." *
        "Applying colormap with vmin: $(vmin), vmax: $(vmax) and " *
        "cmap $(cmap)."
    # Prepare for normalization.
    vis_image = convert(Array{Float32, 2}, image);
    @debug "Current min: $(minimum(vis_image)), " *
        "current max: $(maximum(vis_image))."
    # Normalization.
    if vmin != nothing
        imin = Float32(vmin);
        clamp!(vis_image, vmin, typemax(Float32));
    else
        imin = minimum(vis_image);
    end
    if vmax != nothing
        imax = Float32(vmax);
        clamp!(vis_image, typemin(Float32), vmax);
    else
        imax = maximum(vis_image);
    end
    @debug "After normalization: min: $(minimum(vis_image)), " *
           "max: $(maximum(vis_image))."
    vis_image -= imin;
    vis_image /= (imax - imin);
    # Visualization.
    result = colorview(RGB, normedview(zeros(UInt8,
                                             3,
                                             size(vis_image)[1],
                                             size(vis_image)[2])));
    @debug "Result size: $(size(result))."
    if isa(cmap, Integer)
        vis_image = round.(Int32, vis_image .* Float32(cmap - 1));
        if cmap_seed == nothing
            map = distinguishable_colors(cmap);
        else
            map = distinguishable_colors(cmap, cmap_seed);
        end
        for row_idx = 1:size(vis_image)[2]
            for col_idx = 1:size(vis_image)[1]
                @inbounds result[col_idx, row_idx] = map[vis_image[col_idx,
                                                                   row_idx] + 1];
            end
        end
    else
        gradient = cgrad(cmap);
        for row_idx = 1:size(vis_image)[2]
            for col_idx = 1:size(vis_image)[1]
                @inbounds result[col_idx, row_idx] = gradient[
                    vis_image[col_idx, row_idx]];
            end
        end
    end
    return result;
end
end  # module
