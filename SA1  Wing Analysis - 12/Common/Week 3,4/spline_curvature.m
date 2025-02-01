function curvature_vectors = spline_curvature(xs, ys, toggle)
    %returns curvature vectors of cubic polynomial fit spline to the aerofoil surface spline
    %can then be plotted using matlab quiver function

    %Find piecewise polynomial spline curve
    splineCurve = spline(xs, ys);
    %evaluate first and second derivatives
    pp_der1 = fnder(splineCurve, 1);
    pp_der2 = fnder(splineCurve, 2);
    % Evaluate the first and second derivatives at the points given
    dy = ppval(pp_der1, xs);
    d2y = ppval(pp_der2, xs);

    % Compute the curvature
    if toggle == -1
        curvature = abs(d2y) ./ (1 + dy.^2).^(3/2);
    end
    if toggle == 1
        curvature = -d2y ./ (1 + dy.^2).^(3/2);
    end
    %by changing abs(d2y) to -d2y and removing the minus multiplication to all curvature_vectors_bot 
    %the program can be modified to show reflexes in curvature either side of the surface
    %current setting is all on the outside of the surface

    % Compute the tangent vector to the aerofoil surface
    dx = ones(size(dy));
    tangent = [dx; dy];
    % Normalize the tangent vector
    tangent_norm = sqrt(tangent(1,:).^2 + tangent(2,:).^2);
    tangent_unit = tangent ./ tangent_norm;
    % Compute the normal vector by rotating the tangent vector by 90 degrees
    normal = [-tangent_unit(2,:); tangent_unit(1,:)];
    % Compute the curvature vectors
    curvature_vectors = curvature .* normal;
end