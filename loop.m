p = input("Enter crop ratio:");
  i=0;k=0;
  while (i!=11)
    getpicture
    t = imageTo20x20Gray('e.jpg',p,0,Theta1,Theta2);
    %i = predict(Theta1,Theta2,t)
    pause(0.5);
    %close;
    t = reshape(t,1,400);
    %k = input("Press 1 to add to the dataset");
    i=11;
    
    subplot(12,10,[26:30 36:40 46:50 56:60 66:70 76:80 86:90 96:100]);
    h = displayData(Theta1(:, 2:end));
    %imshow(h);
    if(k==1)
      X = [X;t];
      y = [y;label];
      save("new.mat",'X','y');
    end
    % title(gca,num2str (i));
  endwhile
