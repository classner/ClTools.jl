module config

import Hwloc


"Get the number of available CPUs."
function available_cpu_count()
    topology = Hwloc.topology_load();
    counts = Hwloc.histmap(topology);
    return counts[:Core];
end


"Get the number of available PUs."
function available_pu_count()
    topology = Hwloc.topology_load();
    counts = Hwloc.histmap(topology);    
    return counts[:PU];
end

end  # module
