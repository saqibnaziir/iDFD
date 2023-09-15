%  Author: Saqib, nazir, Bucharest Polytechnic University
%  E-mail: saqib.nazir@upb.ro
function [MOVINGREG] = registerImages(MOVING,FIXED,DEPTH)
%  The values for all registration parameters were set interactively in the
%  app and result in the registered image stored in the structure array MOVINGREG.
%-----------------------------------------------------------


% Feature-based techniques require license to Computer Vision Toolbox
checkLicense()

% Convert RGB images to grayscale
FIXED = im2gray(FIXED);
%MOVINGRGB = MOVING;
MOVING = im2gray(MOVING);

% Default spatial referencing objects
fixedRefObj = imref2d(size(FIXED));
movingRefObj = imref2d(size(MOVING));

% Detect corners using ORB algorithm
fixedPoints = detectORBFeatures(FIXED,'ScaleFactor',1.200000,'NumLevels',4);
movingPoints = detectORBFeatures(MOVING,'ScaleFactor',1.200000,'NumLevels',4);

% Detect SURF features
% fixedPoints = detectSURFFeatures(FIXED,'MetricThreshold',750.000000,'NumOctaves',3,'NumScaleLevels',5);
% movingPoints = detectSURFFeatures(MOVING,'MetricThreshold',750.000000,'NumOctaves',3,'NumScaleLevels',5);

% Extract features
[fixedFeatures,fixedValidPoints] = extractFeatures(FIXED,fixedPoints);
[movingFeatures,movingValidPoints] = extractFeatures(MOVING,movingPoints);

% Match features
indexPairs = matchFeatures(fixedFeatures,movingFeatures,'MatchThreshold',50.000000,'MaxRatio',0.500000);
fixedMatchedPoints = fixedValidPoints(indexPairs(:,1));
movingMatchedPoints = movingValidPoints(indexPairs(:,2));
MOVINGREG.FixedMatchedFeatures = fixedMatchedPoints;
MOVINGREG.MovingMatchedFeatures = movingMatchedPoints;

% Apply transformation - Results may not be identical between runs because of the randomized nature of the algorithm
tform = estimateGeometricTransform2D(movingMatchedPoints,fixedMatchedPoints,'projective');
MOVINGREG.Transformation = tform;
%MOVINGREG.RegisteredImage = imwarp(MOVINGRGB, movingRefObj, tform, 'OutputView', fixedRefObj, 'SmoothEdges', true);
MOVINGREG.RegisteredImage = imwarp(DEPTH, movingRefObj, tform, 'OutputView', fixedRefObj, 'SmoothEdges', true);

% Store spatial referencing object
MOVINGREG.SpatialRefObj = fixedRefObj;

end

function checkLicense()

% Check for license to Computer Vision Toolbox
CVTStatus = license('test','Video_and_Image_Blockset');
if ~CVTStatus
    error(message('images:imageRegistration:CVTRequired'));
end

end

