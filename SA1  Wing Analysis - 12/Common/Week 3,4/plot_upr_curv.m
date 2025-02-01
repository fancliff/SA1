function plot_upr_curv(xs,ys,curv_tog,curv_scale,curv_reduce)
    %plots upper surface curvature vectors for use in conjunction with
    %wasg_curvature_refined
    [~,LEpos] = mink(xs,1);
    xs_top = xs(:,1:curv_reduce:LEpos-1);
    ys_top = ys(:,1:curv_reduce:LEpos-1);
    curvature_vectors_top = spline_curvature(xs_top,ys_top,curv_tog);
    curvature_vectors_top = curvature_vectors_top/curv_scale;
    quiver(xs_top,ys_top, curvature_vectors_top(1,:), curvature_vectors_top(2,:), 0,'- . r');
end