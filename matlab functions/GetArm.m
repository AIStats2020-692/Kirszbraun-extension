function X = GetArm(theta,l)

N = length(l);

[Tcom,Tjoints] = GetFrames(theta,l);


% read out joint locations
  for i=1:N+1
      
      X(i,:) = Tjoints(1:3,4,i)';
      
  end
    
    