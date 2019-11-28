function [Tcom,Tjoints] = GetFrames(theta,l)


% theta(1) = pi/3;
% theta(2) = pi/12;
% theta(3) = pi/4;
% theta(4) = pi/5;
% 
% l(1) = 0.3;
% l(2) = 0.4;
% l(3) = 0.7;
% l(4) = 0.6;

N = length(theta); %Number of links

phi = [];
  c = [];
  
 


for i=1:N
      
   
    phi = [phi,theta(i)];
    c   = [c,l(i)];
    
    
    if i == 1 
        
    
        t0 = zeros(3,1);
        
       Mcom(:,:,i)    = [1 0 0 l(1)/2; 0 1 0 0; 0 0 1 0; 0 0 0 1];
       Mjoints(:,:,i) = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
               
    else
        
       Mcom(:,:,i)    = [1 0 0 sum(c(1:i-1)) + l(i)/2; 0 1 0 0; 0 0 1 0; 0 0 0 1];
       Mjoints(:,:,i) = [1 0 0 sum(c(1:i-1)); 0 1 0 0; 0 0 1 0; 0 0 0 1];
        
       t0 = zeros(3,1);
       
       for j=2:i
           
          % i
      
         R0  = [cos(sum(phi(1:j-1)))   -sin(sum(phi(1:j-1))) 0; sin(sum(phi(1:j-1))) cos(sum(phi(1:j-1))) 0; 0 0 1];
         p0  = [sum(c(1:j-1))*(1-cos(theta(j))), -sum(c(1:j-1))*sin(theta(j)),0];
         
         t0 = t0 + R0*p0';
    
       end
      
    end
    %pause

    % rotation
    R(:,:,i) =  [cos(sum(phi)) -sin(sum(phi)) 0; sin(sum(phi)) cos(sum(phi)) 0; 0 0 1];
    % translation
    p(1,i) =  t0(1);
    p(2,i) =  t0(2);
    p(3,i) =  t0(3);
    % configuration
    Tcom(:,:,i)    = [[R(:,:,i), p(:,i)]; 0 0 0 1]*Mcom(:,:,i);
    Tjoints(:,:,i) = [[R(:,:,i), p(:,i)]; 0 0 0 1]*Mjoints(:,:,i);
    
   
    
end
 
% add end-effector frame

Mcom(:,:,N+1) = [1 0 0 sum(c(1:N)); 0 1 0 0; 0 0 1 0; 0 0 0 1];
Tcom(:,:,N+1) = [[R(:,:,i), p(:,i)]; 0 0 0 1]*Mcom(:,:,N+1);
Tjoints(:,:,N+1) = Tcom(:,:,N+1);
