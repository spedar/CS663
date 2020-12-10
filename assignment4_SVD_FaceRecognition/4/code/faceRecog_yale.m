function [] = faceRecog_yale(path, p)

    tic;
    num_people = 38;
    num_train_img = 40;
    fnames = string(zeros(1, num_people));
%     num_test_img = 4;
    
    train_data = cell(num_people, num_train_img);
%     test_data = cell(num_people , num_test_img);
    
    cd(path);
    disp("Preparing input");
    for k = 1:39
        
        k;
        if(k==14)
            continue;
            
        elseif(k<=9)
            fname = sprintf('yaleB0%d', k);
        else
            fname = sprintf('yaleB%d', k);
        end
        
        cd(fname);
        
%         for i = 1:num_train_img
%             img_name = sprintf('%d.pgm',i);
%             train_data{k,i} = importdata(img_name);
%         end
%         
%         for i = 1:num_test_img
%             img_name = sprintf('%d.pgm', i+num_train_img);
%             test_data{k,i} = importdata(img_name);
%         end

        files = dir(['*.pgm']);
        for i = 1:num_train_img
            img_name = files(i).name;
            
            if(k<=13)
                train_data{k,i} = importdata(img_name);
                fnames(k) = fname;
            else
                train_data{k-1,i} = importdata(img_name);
                fnames(k-1) = fname;
            end
        end
        
%         for i = num_train_img+1: length(files)
%             img_name = files(i).name;
%             test_data{k,i} = importdata(img_name);
%         end
        
        cd ..;
    end
    
    cd ..;
    cd ../code;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [l,m] = size(train_data{1,1});
    train_images = zeros(num_people*num_train_img, l*m);
%     test_images = zeros(num_people*num_test_img, l*m);
    
    for k = 1:num_people
        for i = 1:num_train_img
            train_images((k-1)*num_train_img + i,:) = reshape(train_data{k,i}, [1,l*m]);
        end
        
%         for i = 1:num_test_img
%             test_images((k-1)*num_test_img + i,:) = reshape(test_data{k,i}, [1,l*m]);
%         end
    end
    
    clearvars train_data;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    x_mean = mean(train_images);
    
    train_images_norm = (train_images - x_mean)';
%     test_images_norm = (test_images - x_mean)';
    [U,~,~] = svd(train_images_norm, 'econ');
   
    k_values = [1,2,3,5,10,15,20,30,50,60,65,75,100,200,300,500,1000];
    correct_ans = zeros(1,length(k_values));
    accuracy = zeros(1,length(k_values));
    
    for k = 1:length(k_values)
        correct = 0;
        total = 0;
        
        if p=='a'
            V_k = U(:, 1: k_values(k)); 
        else
            V_k = U(:, 4: 3+k_values(k));
        end
        
%         V_k = U(:, 4: 3+k_values(k));
        alpha_k = V_k' * train_images_norm;
%         alpha_test = V_k' * test_images_norm;
        
%         for i = 1: num_people* num_test_img
% 
%             total = total+1;
% 
%             true_label = ceil(i/4);
% 
%             [~, min_index] = min(vecnorm(alpha_k - alpha_test(:,i)));
%             pred_label = ceil(min_index/6);
% 
%             if(true_label == pred_label)
%                 correct = correct+1;
%             end
%         end
        
        cd(path);
        for i = 1:num_people
            
            cd(fnames(i));
            files = dir(['*.pgm']);
            
            for j = num_train_img+1 : length(files)
                total = total + 1;
                true_label = i;
                
                img_name = files(j).name;
                img = importdata(img_name);
                img = reshape(img, [1,l*m]);
                img_norm = (double(img) - x_mean)';
                
                alpha_test = V_k' * img_norm;
                alpha_k;
                alpha_test;
%                 [~, min_index] = min(vecnorm(alpha_k(4:k_values(k)+3, :) - alpha_test(4:k_values(k)+3, :)));
                [~, min_index] = min(vecnorm(alpha_k - alpha_test));
                pred_label = ceil(min_index/40);
                
                if(true_label == pred_label)
                    correct = correct + 1;
                end
            end
            
            cd ..;
        end
        
        correct_ans(k) = correct;
        accuracy(k) = (correct/total);
        cd ..;
        cd ../code;
        fprintf('k = %d\n', k_values(k));
    end
    
    plot(k_values, accuracy)  
    toc;
end

