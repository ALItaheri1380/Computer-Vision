classdef WeakClassifier < handle
    properties
        dimension
        threshold
        compare
    end
    methods
        function err = train(obj, samples, labels, weights)
            
            [threshRow, errRow] = obj.findThreshold(samples(:, 1), labels, weights);
            [threshCol, errCol] = obj.findThreshold(samples(:, 2), labels, weights);
            
            if errRow < errCol
                err = errRow;
                obj.dimension = 1;
                obj.threshold = threshRow;
            else
                err = errCol;
                obj.dimension = 2;
                obj.threshold = threshCol;
            end
            
            preds = obj.test(samples);
            err = sum(weights(preds ~= labels));
        end
        function [thresh, err] = findThreshold(obj, vals, labels, weights)
            
            negSum = sum(weights(labels < 0));
            posSum = sum(weights) - negSum;
            
            data = [vals labels weights];
            data = sortrows(data, 1);
            
            posCum = cumsum(data(:, 3) .* (data(:, 2) == 1));
            negCum = cumsum(data(:, 3) .* (data(:, 2) == -1));
            
            err1 = posCum + (negSum - negCum);
            err2 = negCum + (posSum - posCum);
            errs = min(err1, err2);
            minIdx = find(errs == min(errs));
            obj.compare = err1(minIdx) < err2(minIdx);
            
            thresh = data(minIdx, 1);
            err = errs(minIdx);
        end
        function preds = test(obj, samples)
            if obj.compare
                preds = samples(:, obj.dimension) > obj.threshold;
            else
                preds = samples(:, obj.dimension) < obj.threshold;
            end
            preds = -1 + 2 * preds;
        end
    end
end
