%% This will resize the spectrogram data to be compatible

function usableImages = formatFile(rawData, numRows, numCols)

numData = length(rawData);

usableImages = cell(numData,1);

for i =1:numData
    
usableImages{i} = spectrogram(rawData{i});
usableImages{i} = imresize(usableImages{i},[numRows, numCols]);
usableImages{i} = repmat(usableImages{i}, [1 1 3]);
end

usableImages = cat(4,usableImages{:});

end
