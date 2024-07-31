function r = getPlotRange(m_range)
% Estimate an appropiate axis range for a given triangular plot.

arguments
    m_range (1,2) double
end

difference = abs(m_range(1) - m_range(2));

order_of_magnitude = 10^floor(log10(abs(difference)));

lower_limit = floor((min(m_range) - difference/2) / order_of_magnitude) * order_of_magnitude;
upper_limit = ceil((max(m_range) + difference/2) / order_of_magnitude) * order_of_magnitude;

r = [lower_limit upper_limit];