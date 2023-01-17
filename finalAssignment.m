function [finalsolList] = finalAssignment(A)
[n,~]=size(A);
row=zeros(1,n);
col=zeros(1,n);
persol=zeros(n);
finalsolList=zeros(n);
x=0;
for i=1:n
    if sum(A(i,:)==0)==1
        for j=1:n           %row scanning where in a row if only 1 zero exists then mark the whole column in which that zero lies. 
            if A(i,j)==0
                persol(i,j)=1;
                col(j)=1;
                A(:,j)=-1;
            end
        end
    end
end

    for i=1:n
        if (col(i)==0 && sum(A(:,i)==0)==1)
            for j=1:n % col scanning where in a col if only 1 uncovered zero exists then mark the whole column where that zero lies.Not done for coumuns that are already marked 
                if A(j,i)==0
                    persol(j,i)=1;
                    row(j)=1;
                    A(j,:)=-1;                    
                end
            end
        end
    end
    
   
D=A;
finalsol=persol;
tempcol=col;
temprow=row;
mark=zeros(n);
flag=0;
for i=1:n
    if row(i)==0
        for j=1:n
            if (A(i,j)==0 & mark(i,j)==0)
                flag=1;
                mark(i,j)=1;
                persol(i,j)=1;
                col(j)=1;
                row(i)=1;
                A(:,j)=-1;
                A(i,:)=-1;
              while(sum(A(:)==0)~=0)
                for k=1:n-1
                    L=mod((i+k),n);                    
                    if(L==0)
                        L=n;
                    end
                    if (sum(A(L,:)==0)==1 & row(L)==0)
                            for m=1:n           
                                if A(L,m)==0
                                    persol(L,m)=1;
                                    row(L)=1;
                                    col(m)=1;
                                    A(:,m)=-1;
                                    A(L,:)=-1;
                                end
                            end
                    end
                    
                    
                end
                for ix=1:n
                    if (col(ix)==0 && sum(A(:,ix)==0)==1)
                        for jx=1:n 
                            if A(jx,ix)==0
                                 persol(jx,ix)=1;
                                   row(jx)=1;
                                   col(ix)=1;
                                   A(jx,:)=-1;
                                   A(:,ix)=-1;
                                 
                            end
                        end
                    end
                end
              end
            x=x+1;    
            finalsolList(:,:,x)=persol;
            
            A=D;
            persol=finalsol;
            col=tempcol;
            row=temprow;
            end            
        end
    end
end
   
if(flag==0)
    finalsolList(:,:,1)=persol;
end



end


