function [] = faceRecog1(path)

    num_people = 32;
    num_train_img = 6;
    num_test_img = 4;
    
    train_data = cell(num_people, num_train_img);
    test_data = cell(num_people , num_test_img);
%     data = cell(1, numfolders);
    
    cd(path);
    for k = 1:num_people
        fname = sprintf('s%d', k);
%         folder = dir(fname);
        
        cd(fname);
        
        for i = 1:num_train_img-1
            img_name = sprintf('%d.pgm',i);
            train_data{k,i} = importdata(img_name);
        end
        
        img_name = sprintf('%d.pgm',10);
        train_data{k,6} = importdata(img_name);
        
        for i = 1:num_test_img
            img_name = sprintf('%d.pgm', i+num_train_img-1);
            test_data{k,i} = importdata(img_name);
        end
        
        cd ..;
    end
    
    cd ..;
    cd ../code;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [l,m] = size(train_data{1,1});
    train_images = zeros(num_people*num_train_img, l*m);
    test_images = zeros(num_people*num_test_img, l*m);
    
    for k = 1:num_people
        for i = 1:num_train_img
            train_images((k-1)*num_train_img + i,:) = reshape(train_data{k,i}, [1,l*m]);
        end
        
        for i = 1:num_test_img
            test_images((k-1)*num_test_img + i,:) = reshape(test_data{k,i}, [1,l*m]);
        end
    end
    
    clearvars test_data train_data;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     k = 170;
    x_mean = mean(train_images);
    
    train_images_norm = (train_images - x_mean)';
    test_images_norm = (test_images - x_mean)';
    
%     C = (1 / (num_people*num_train_img - 1)) * (train_images_norm * train_images_norm');
%     clearvars train_images test_images;

    L = train_images_norm' * train_images_norm;
    
    [U,D] = eig(L);
    [~,ind] = sort(diag(D), 'descend');
%     Ds = D(ind,ind);
    U = U(:,ind);
    V = train_images_norm * U;
    Vs = V ./ (sum(V.^2,1).^0.5);
    
%     V_k = U(:, 1:k);
%     alpha_k = V_k' * train_images_norm;
%     
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     
%     alpha_test = V_k' * test_images_norm;
    
    correct_ans = zeros(1,13);
    accuracy = zeros(1,13);
    k_values = [1,2,3,5,10,15,20,30,50,75,100,150,170];
    
    for k = 1:13
        correct = 0;
        total = 0;
        
        V_k = Vs(:, 1:k_values(k));
        alpha_k = V_k' * train_images_norm;
        alpha_test = V_k' * test_images_norm;
        
        for i = 1: num_people* num_test_img

            total = total+1;

            true_label = ceil(i/4);

            [~, min_index] = min(vecnorm(alpha_k - alpha_test(:,i)));
            pred_label = ceil(min_index/6);

            if(true_label == pred_label)
                correct = correct+1;
            end
        end
        
        correct_ans(k) = correct;
        accuracy(k) = (correct/total);
    end
    
    
    plot(k_values, accuracy);
    
%     correct
%     total
%     correct / total

    
        
end

