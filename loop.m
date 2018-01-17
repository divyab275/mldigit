p = input("Enter crop ratio:");
  i=0;k=0;
  while (i!=11)
    getpicture
    t = imageTo20x20Gray('e.jpg',p,0,Theta1,Theta2);
    i = predict(Theta1,Theta2,t)
    pause(0.25);
    t = reshape(t,1,400);
    %k = input("Press 1 to add to the dataset");
    
    if(k==1)
      X = [X;t];
      y = [y;label];
      save("new.mat",'X','y');
    end
    % title(gca,num2str (i));
  endwhile
