function[y] = linear_mapping(x)
	% Rescale image with arbitrary range to [0,255].
	xMin = min(x(:));
	xMax = max(x(:));

	if (xMin == xMax)
	    % Avoid dividing by zero.
	    if (xMin == 0)
	        y = x;
	    else
	        y = x ./ xMin;
	    end
	    
	else
	    % Linearly scale the values to [0,255].
	    y = ((x - xMin) ./ (xMax - xMin))*255;
	end
end