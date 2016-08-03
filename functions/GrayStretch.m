function GS = GrayStretch(I,Per)
%   The code was written by Jicai Teng, Jinhui Shi, Kun Zhan
%   $Revision: 1.0.0.0 $  $Date: 2014/12/06 $ 17:58:47 $

%   Reference:
%   [1] K Zhan, J Shi, Q Li, J Teng, M Wang, 
%   "Image segmentation using fast linking SCM," 
%   in Proc. of IJCNN, IEEE, vol. 25, pp. 2093-2100, 2015.
%   [2] K Zhan, J Teng, J Shi, Q Li, M Wang, 
%   "Feature-linking model for image enhancement," 
%   Neural Computation, 28(5), 1072-1100, 2016.

    [m,M] = FindingMm(I,Per);
    GS = uint8((double(I)-m)./(M-m)*255);
end
function [minI,MaxI] = FindingMm(I,Per)
    h = imhist(I);
    All = sum(h);
    ph = h ./ All;
    mth_ceiling = BoundFinding(ph,Per);
    Mph=fliplr(ph')';
    Mth_floor = BoundFinding(Mph,Per);
    Mth_floor = 256 - Mth_floor + 1;
    ConstraintJudge = @(x,y) sum(h(x:y))/All >= Per;
    Difference = zeros(256,256) + inf;
    for m = mth_ceiling:-1:1
        for M = Mth_floor:256
            if (h(m) > 0 )&&(h(M) > 0)
                if ConstraintJudge(m,M)
                    Difference(m,M) = M - m;
                end
            end
        end
    end
    minD = min(Difference(:));
    [m, M] = find(Difference==minD);
    minI = m(1) - 1;
    MaxI = M(1) - 1;
end
function m_ceiling = BoundFinding(ph,Per)
    cumP = cumsum(ph);
    n = 1;
    residualP = 1-Per;
    while cumP(n) < residualP
        n = n + 1;
    end
    m_ceiling = n;
end