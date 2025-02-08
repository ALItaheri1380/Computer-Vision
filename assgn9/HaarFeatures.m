classdef HaarFeatures < handle
    properties
        r
        c
        winWidth
        winHeight
        featureType
        features
        minT
        maxT
        alpha
        windowSize
        scale
    end
    methods
        function obj = HaarFeatures(attrs, varargin)
            
            obj.r = attrs(1, :);
            obj.c = attrs(2, :);
            obj.winWidth = attrs(3, :);
            obj.winHeight = attrs(4, :);
            obj.featureType = attrs(5, :);
            obj.alpha = attrs(11, :);
            
            meanVal = attrs(6, :);
            maxVal = attrs(8, :);
            minVal = attrs(9, :);            
            range = attrs(10, :);
            
            obj.minT = (meanVal - abs(meanVal - minVal)) .* (range - 5) / 50;
            obj.maxT = (meanVal + abs(maxVal - meanVal)) .* (range - 5) / 50;
            
            obj.features = {@feature1, @feature2, @feature3, @feature4, @feature5};
            obj.windowSize = 19;
            
            if nargin == 2
                scaleFactor = varargin{1};
                obj.r = round(obj.r * scaleFactor);
                obj.c = round(obj.c * scaleFactor);
                obj.winWidth = round(obj.winWidth * scaleFactor);
                obj.winHeight = round(obj.winHeight * scaleFactor);
                obj.windowSize = round(obj.windowSize * scaleFactor);
                obj.scale = scaleFactor;
            end
            
        end
        function response = classify(obj, img)
            imgInt = Cl_Intgrl_img(img);
            response = zeros(size(imgInt) - obj.windowSize);
            for y = 1:size(imgInt, 1) - obj.windowSize
                for x = 1:size(imgInt, 2) - obj.windowSize
                    patch = imgInt(y:y+obj.windowSize-1, x:x+obj.windowSize-1);
                    response(y, x) = obj.classifyPatch(patch);
                end
            end
        end
        function f = classifyPatch(obj, patch)
            
            featureVals = zeros(size(obj.r));
            for i = 2:numel(obj.r)
                featureVals(i) = obj.extractFeature(patch, i);
            end
            validRange = (obj.minT <= featureVals) & (featureVals <= obj.maxT);
            f = obj.alpha * validRange';
        end
        function f = extractFeature(obj, img, idx)
            featureFunc = obj.features{obj.featureType(idx)};
            f = featureFunc(img, obj.r(idx), obj.c(idx), obj.winWidth(idx), obj.winHeight(idx));
        end
    end
end
