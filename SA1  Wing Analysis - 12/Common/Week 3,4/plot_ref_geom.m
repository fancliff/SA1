function plot_ref_geom()
    %plots reference profile geometries for use in conjunction with
    %wasg_curvature_refined
    refs = {'thick1','thick2'}; %references to plot
    %refs = {'naca8406', 'naca8208', 'naca8412'}; %references to plot
    len_refs = length(refs);
    colours = {[0 0.5 0],"b","m","#4DBEEE","#77AC30","#7E2F8E","#EDB120","#0072BD","#D95319","#A2142F"};
    len_colours = length(colours);
    for i = 1:len_refs
        file = load(strcat('Geometry/', refs{i}, '.surf'));
        x=file(2:end-1,1);
        y=file(2:end-1,2);
        [xs, ys] = splinefit([1;x;1],[0;y;0],0);
        plot(xs,ys,"-", "Color", colours{mod(i,len_colours)}, "linewidth", 0.75)
    end
end
