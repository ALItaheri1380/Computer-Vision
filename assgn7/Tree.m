classdef Tree < handle
   properties
       nodes
       leafs
   end
   methods
       function obj = Tree(varargin)
           if nargin > 0
               obj.read(varargin{1});
           end
       end
       function read(obj, filename)
           [obj.nodes, obj.leafs] = Load_tree(filename);
       end
       function [outX, outY] = pred(obj, img, posX, posY)
           currIdx = 1;
           isLeaf = false;
           while ~isLeaf
               
               if obj.choose(currIdx, img, posX, posY)
                   currIdx = obj.nodes(currIdx, 2);
               else
                   currIdx = obj.nodes(currIdx, 3);
               end
               
               if currIdx < 1
                   isLeaf = true;
                   currIdx = abs(currIdx);
               end
               
               currIdx = currIdx + 1;
           end
           outX = obj.leafs(currIdx, 2);
           outY = obj.leafs(currIdx, 3);
       end
       function val = feature(~, img, posX, posY, ch, sizeVal)
           offset = floor(sizeVal / 2);
          
           imgH = size(img, 1);
           imgW = size(img, 2);
           
           xMin = min(max(posX - offset, 1), imgW);
           yMin = min(max(posY - offset, 1), imgH);
           xMax = min(max(posX + offset, 1), imgW);
           yMax = min(max(posY + offset, 1), imgH);

           val = img(yMax, xMax, ch) + img(yMin, xMin, ch);
           val = val - img(yMax, xMin, ch) - img(yMin, xMax, ch);
       end
       function decision = choose(obj, idx, img, posX, posY)
           params = obj.nodes(idx, 4:11);
           threshold = params(1);

           xA = posX + params(2);
           yA = posY + params(3);

           chA = params(4);

           xB = posX + params(5);
           yB = posY + params(6);

           chB = params(7);
           sizeVal = params(8);

           featA = obj.feature(img, xA, yA, chA, sizeVal);
           featB = obj.feature(img, xB, yB, chB, sizeVal);   
           
           decision = (featA - featB) < threshold;
       end
   end 
end
