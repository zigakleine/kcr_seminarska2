function outsig = artifact_removal_filtering(insig, f_s)

    %odstrani baseline drift in visoke frekv. z butterworth filtrom:
    % filter signal -—> flip signal --> filter signal --> flip signal

    f_from = 0.1;
    f_to = 30;

    [b, a] = butter(4, [f_from/(f_s/2), f_to/(f_s/2)], "bandpass");

    fsig = filter(b, a, insig);

    fsig_flip = flip(fsig);

    ffsig_flip = filter(b, a, fsig_flip);

    ffsig = flip(ffsig_flip);
    
    outsig = ffsig;
            
end
    
    