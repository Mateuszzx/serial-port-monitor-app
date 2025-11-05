function readData(src, ~)
% Read the ASCII data from the serialport object.

data = readline(src);
disp(data);
% Convert the string data to numeric type and save it in the UserData
% property of the serialport object.
src.UserData.Data(end+1) = data;

% If data is equal to END switch off the
% callbacks and plot the data.
if data == "END"
    configureCallback(src, "off");
end
end