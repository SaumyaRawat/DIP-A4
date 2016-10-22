% Local Dodge and Burn Tone Mapping Operator, by Reinhard 02 paper. %
function output = dodge_and_burn(img, a)
    output = zeros(size(img));
    [rows,cols] = size(img(:,:,1));
    if( ~exist('a') )
        a = 0.18;
    end

    delta = 1e-6;
    phi = 100;
    alpha_1 = 0.35;
    alpha_2 = 1.6 * alpha_1;
    epsilon = 1e-4;
    threshold = 0.05;

    Lw = 0.27*img(:,:,1)+0.67*img(:,:,2)+0.06*img(:,:,3);
    LwMean = exp(mean(mean(log(delta + Lw))));
    Lm = (a / LwMean) * Lw;
    Ld = zeros(rows,cols);

    for x=1:rows
    	for y=1:cols
    		%%%%%%%%%%%%%%%
    		s = 1;
    		V1 = conv(Lm(x,y),(1/pi*(alpha_1*s).^2)*exp(-((x.^2+y.^2)/(alpha_1*s).^2)));
    		V2 = conv(Lm(x,y),(1/pi*(alpha_2*s).^2)*exp(-((x.^2+y.^2)/(alpha_2*s).^2)));
            V = (V1-V2)/( (((2.^phi)*a)/(s.^2)) + V1 );
    		%% Find the scale sm %%
    		while V >= threshold
    			s = 1.6*s;
	    		V1 = conv(Lm(x,y),(1/pi*(alpha_1*s).^2)*exp(-((x.^2+y.^2)/(alpha_1*s).^2)));
	    		V2 = conv(Lm(x,y),(1/pi*(alpha_2*s).^2)*exp(-((x.^2+y.^2)/(alpha_2*s).^2)));
	    		%% Find the scale sm %%
	    		V = (V1-V2)/( (((2.^phi)*a)/(s.^2)) + V1 );
			end
			sm = s;    			
		    V1 = conv(Lm(x,y),(1/pi*(alpha_1*sm).^2)*exp(-((x.^2+y.^2)/(alpha_1*sm).^2)));
		    % For Ld, we will define local regions as those where the contrast doesnt change much. Given a decent scale for a pixel, V1 serves as its avg
		    Ld(x,y) = (Lm(x,y) .* (1 + V1));
		end
	end
    for channel = 1:3
    	Cw = img(:,:,channel) ./ Lw;
        output(:,:,channel) = Cw .* Ld;
    end
end
