function plot_lwr_curv(xs,ys,curv_tog,curv_scale,curv_reduce)
    %plots lower surface curvature vectors for use in conjunction with
    %wasg_curvature_refined
    [~,LEpos] = mink(xs,1);
    xs_bot = xs(:,LEpos+1:curv_reduce:end);
    ys_bot = ys(:,LEpos+1:curv_reduce:end);
    curvature_vectors_bot = spline_curvature(xs_bot,ys_bot,curv_tog);
    curvature_vectors_bot = curv_tog*curvature_vectors_bot/curv_scale;
    quiver(xs_bot,ys_bot, curvature_vectors_bot(1,:), curvature_vectors_bot(2,:), 0,'- . r');
end
