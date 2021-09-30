function [ out1,out2 ] = flowViewer(im,steps)
      
    [m,n,~] = size(im) ;
    out1 = im;
    out2 = im;
    N = steps;

    
    flow1 = zeros([m,n,2]) ; 
    T1 = zeros([m,n,4]) ;
    T2 = T1;
    flow2 = flow1;

    for i=1:m     
        for j=1:n
            %initialising the vector fields, same dimensions as the image
            if(j < n/2)
                flow1(i,j,:) = [3;0];
                if(i < m/2)
                    flow2(i,j,:) = [0;3];
                else
                    flow2(i,j,:) = [3;0];
                end
            end
            if(j >= n/2)
                flow1(i,j,:) = [0;3];
                if(i > m/2)
                    flow2(i,j,:) = [0;3];
                else
                    flow2(i,j,:) = [3;0];
                end
            end
            %calculating the tensor field T = FF'/norm(F)
            temp1 = reshape(flow1(i,j,:),2,1) ; 
            T1(i,j,:) = reshape((temp1*temp1')/norm(temp1),4,1) ;
            temp2 = reshape(flow2(i,j,:),2,1);
            T2(i,j,:) = reshape((temp2*temp2')/norm(temp2),4,1);
        end
    end
    %Flow Visualisation #1
    out1 = im2double(out1) ; 
    for i = 1:N
          for j=1:3
              H = getHessianVector(out1(:,:,j));
              out1(:,:,j) = updateImage(out1(:,:,j),T1,H);
          end
    end
    %Flow Visualisation #2
    out2 = im2double(out2) ; 
    for i = 1:N
          for j=1:3
              H = getHessianVector(out2(:,:,j));
              out2(:,:,j) = updateImage(out2(:,:,j),T2,H);
          end
    end
end