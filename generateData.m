function data = generateData(pathName,numSamples,first,last)
%% Takes the path to a function and the number of samples to read
%  returns a cell 
%  array of all the audio files as matrices

listing = dir(pathName);
numMusic = length(listing);
data = cell(numMusic,1);

for i = first:last
    if i ==42 || i ==1 || i==2 || i == 125 || i == 705
        continue
    end
    filename = listing(i).name;
    filename = strcat(pathName, '\',filename);
    
    try
    data{i} = audioread(filename,[1 numSamples]);
    catch
        continue;
    end
    % only need "one ear" so to speak
    data{i} = data{i}(:,1);
    i
end

%Eliminate the placeholders in data that are still zeroes
nonFiles = find(~cellfun(@isempty,data));
data = data(nonFiles);

end
