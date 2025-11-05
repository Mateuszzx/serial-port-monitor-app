function readData(src, ~)
% Read the ASCII data from the serialport object.
data =readline(src);

% If data is equal to END switch off the callbacks
    
if data == "END"
        configureCallback(src, "off");
end
if src.UserData.Count == 1
    splitdata = split(data,",");
    src.UserData.Title = splitdata;
    src.UserData.Count = src.UserData.Count + 1;
else
    splitdata = split(data,",");
    
    if src.UserData.Count >3
        src.UserData.Data(end+1) = data;
    end
    if src.UserData.Count == 3
        src.UserData.Headers = splitdata;
        src.UserData.Count = src.UserData.Count + 1;
    end
    if src.UserData.Count == 2
        src.UserData.Ylabels = splitdata;
        src.UserData.Count = src.UserData.Count + 1;
    
    end
end
end