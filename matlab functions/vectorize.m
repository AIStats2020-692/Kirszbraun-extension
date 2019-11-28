function Pos = vectorize(angles,l)
%VECTORIZE gets the data as angles and return as 2d positions
%   Detailed explanation goes here
    N = size(angles,1);
    d = size(angles,2);
    Pos = zeros(N,2*d+2);
    for i = 1:N 
        tmp = GetArm(angles(i,:),l);
        Pos(i,:) = reshape(tmp(:,1:2)',[],1)';
    end
    
    
end

