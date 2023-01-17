function [D,row,col,totalLines,linematrix] = findminlines2coverall0(A)
D=A; %saving and returning the actual form of the reduced matrix in case of future improvement operation
[n,l]=size(A);
nzeros=sum(A(:)==0);
col=zeros(1,n);
row=zeros(1,n);

for i=1:n
    if sum(A(i,:)==0)==1
        for j=1:n           %row scanning where in a row if only 1 zero exists then mark the whole column in which that zero lies. 
            if A(i,j)==0
                col(j)=1;
                for k=1:n
                    if A(k,j)==0
                       A(k,j)=-1;
                    end
                end
            end
        end
    end
end


presentlycovered0=sum(A(:)==-1);

%second time row scanning if not all zeros already covered
if(presentlycovered0<nzeros)
    for i=1:n
        if (col(i)==0 && sum(A(:,i)==0)==1)
            for j=1:n           % col scanning where in a col if only 1 uncovered zero exists then mark the whole column where that zero lies.Not done for coumuns that are already marked 
                if A(j,i)==0
                    row(j)=1;
                    for k=1:n
                        if A(j,k)==0
                           A(j,k)=-1;
                        end
                    end
                end
            end
        end
    end

    while (sum(A(:)==-1)~=nzeros)  %start of diagonal rule 
        flag=0;
        for i=1:n
            if ((row(i)==0 && sum(A(i,:)==0)==1) | (flag==0 && row(i)==0 && sum(A(i,:)==0)>1))
                for j=1:n           % row scanning(for more than one zero is also applicable where in a row if only 1 zero exists then mark the whole column where that zero lies. 
                    if A(i,j)==0
                        col(j)=1;
                        for k=1:n
                            if A(k,j)==0
                                A(k,j)=-1;
                            end
                        end
                        if(flag==0)
                            flag=1;  %if there is more than 1 zeros int the first row of consideration then choose the first one, mark the col, and brek from the loop to go back to normal row scanning
                            break;
                        end
                    end
                end
            end
        end
        
        for i=1:n
            if (col(i)==0 && sum(A(:,i)==0)==1)
             for j=1:n         %col scanning where in a col if only 1 uncovered zero exists then mark the whole column where that zero lies.Not done for coumuns that are already marked 
                   if A(j,i)==0
                       row(j)=1;
                        for k=1:n
                            if A(j,k)==0
                                A(j,k)=-1;
                            end
                        end
                    end
              end
            end
        end
           
    end


    
end
linematrix=zeros(n);
for i=1:n
    if(row(i)==1)
       linematrix(i,:)= linematrix(i,:)-1;
    end
    if(col(i)==1)
       linematrix(:,i)= linematrix(:,i)-1;
    end
end

totalLines=(sum(row==1))+(sum(col==1));
end

