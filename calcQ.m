function Q = calcQ(volume, time)
% Calculate a flow rate given a volume and time string, for instance, for
% when measuring flow rates with glassware and chronometer.
% volume in ml
% time as 'minutes:seconds' e.g., '3:15'
% Outouted flow rate in ml/min

arguments
    volume double
    time string 
end

min_secs = strsplit(time,':');
minutes = str2double( min_secs{1} );
seconds = str2double( min_secs{2} );

Q = volume / (minutes + seconds/60);
