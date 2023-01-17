function [min,A] = improve(A,linematrix)
  [n,l]=size(A);
  
  min=Inf;
  
  %finding the uncovered mnimum value in the reduced matrix
  for i=1:n
      for j=1:n
          if linematrix(i,j)==0
             if A(i,j)<min
                 min=A(i,j);
             end
          end
      end
  end
  
  % improvemet operation
  for i=1:n
      for j=1:n
          if linematrix(i,j)==0
              A(i,j)=A(i,j)-min;   % if the value is uncovered with line then subtract the min from the value
          end
          if linematrix(i,j)==-2
              A(i,j)=A(i,j)+min;   % if the value is in the intersection of 2 lines then add the min with the value
          end 
      end
  end

end

