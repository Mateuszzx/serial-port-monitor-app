function readData(src, ~)
%READDATA Store one completed serial line in the monitor protocol.
%   READDATA(SRC, ~) is the serialport terminator callback used by Main.
%   SRC.UserData.Count selects where the line is written:
%
%       1    Graph titles, split on commas, then Count becomes 2.
%       2    Y-axis labels, split on commas, then Count becomes 3.
%       3    Column headers, split on commas, then Count becomes 4.
%       4+   Measurement text, appended to Data. Count stays at 4.
%
%   UserData is created by Main as
%   struct("Title","","Headers","","Ylabels","","Data","START","Count",1).
%   A line equal to "END" disables this callback. The line is still stored
%   by the rules above, so an END after the header block is the last Data
%   entry. Plotting ignores the leading "START" sentinel and that last line.
%
%   Expected stream:
%       title_1,title_2,...
%       ylabel_1,ylabel_2,...
%       X,Y_1_1,...,Y_n_l
%       <numeric rows in the same column order>
%       END
%
%   See also serialport, configureCallback, readline, MonitorGraph.

    line = readline(src);

    if line == "END"
        configureCallback(src, "off");
    end

    switch src.UserData.Count
        case 1
            src.UserData.Title = split(line, ",");
            src.UserData.Count = 2;
        case 2
            src.UserData.Ylabels = split(line, ",");
            src.UserData.Count = 3;
        case 3
            src.UserData.Headers = split(line, ",");
            src.UserData.Count = 4;
        otherwise
            src.UserData.Data(end+1) = line;
    end
end
