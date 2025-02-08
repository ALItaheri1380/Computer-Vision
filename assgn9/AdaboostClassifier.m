classdef AdaboostClassifier < handle
    properties
        weakClassifier
        alpha
        numTries
    end
    methods
        function obj = AdaboostClassifier(numWeakClassifiers)
            obj.weakClassifier = cell(numWeakClassifiers, 1);
            obj.alpha = zeros(numWeakClassifiers, 1);
            obj.numTries = 1;
        end
        function train(obj, samples, labels)
            weights = ones(size(samples, 1), 1);
            for t = 1:numel(obj.weakClassifier)
                weights = weights / sum(weights);
               
                weakClf = WeakClassifier();
                obj.weakClassifier{t} = weakClf;
                error = weakClf.train(samples, labels, weights);
         
                classification = weakClf.test(samples);
                obj.alpha(t) = 0.5 * log((1-error)/error);
                weights = weights .* exp(-obj.alpha(t) * labels .* classification); 
                
            end 
            
            obj.alpha = obj.alpha / sum(obj.alpha);
        end
        function labels = test(obj, samples)
            
            labels = zeros(size(samples, 1), 1);
            for n = 1:numel(obj.weakClassifier)
                labels = labels + obj.alpha(n) * obj.weakClassifier{n}.test(samples);
            end
            labels = -1 + 2 * (labels > 0);
        end
    end
end