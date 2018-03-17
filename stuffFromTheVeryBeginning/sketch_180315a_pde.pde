PImage stela,school,logo,room;
int stage = 1,i = 0,last;
char gender;
boolean send = false;
String msg = "";
TEXTBOX[] textbox= new TEXTBOX[7];
String[] messages = new String[7];

void setup(){
  size(1400,800);
  stela = loadImage("Stela.jpg");
  school = loadImage("school.jpg");
  logo = loadImage("logo.png");
  room = loadImage("room.png");
  InitLayout();
}

void draw(){
  if(stage==1){ // REGISTER SCREEN
    background(school);
    for(i=0;i<textbox.length;i++){
      textbox[i].DRAW();
      textInfo();
      image(logo,950,675,400,150);
    }
   if(send){
     if(last==0) text(messages[last], (width - 100) / 2, 250);
     if(last==1) text(messages[last], (width - 100) / 2, 350);
    }
  }
  else if(stage==2){ // STELA
    background(stela);
    stage++;
  }
  else if(stage==3){ // NZ ZA SA
    delay(4000);
    background(room);
  }
  else if(stage==4){ // KORIDOR
      
  }
  else if(stage==5){ // QUIZ
      
  }
}


void mousePressed(){
    for(i=0;i<textbox.length;i++){
      textbox[i].PRESSED(mouseX,mouseY);
      if(textbox[i].selected==true){
         if(i==2) gender = 'm';
         else if(i==3) gender = 'f';
         else if(i==6) stage = 2; 
      }
   }
}

void InitLayout(){
  textbox[0] = new TEXTBOX(50,200,300,40);
  textbox[1] = new TEXTBOX(50,300,300,40);
  textbox[2] = new TEXTBOX(50,400,100,40);
  textbox[3] = new TEXTBOX(180,400,100,40);
  textbox[4] = new TEXTBOX(50,500,200,40);
  textbox[5] = new TEXTBOX(280,500,200,40);
  textbox[6] = new TEXTBOX(50,680,150,40);
}

void keyPressed(){
    for(i=0;i<textbox.length;i++){
      if (textbox[i].KEYPRESSED(key,keyCode)){
        send = true;
        last = i;
        messages[i] = textbox[i].Text;
    }
  } 
}

void textInfo(){
  textSize(24);
  text("Име", 50, 180);
  text("Фамилия", 50, 280);
  text("Пол", 50, 380);
  text("Мъж", 65, 430);
  text("Жена", 190, 430);
  text("Паралелка", 55, 480);
  textSize(20);
  text("Програмиране", 65, 525);
  text("Компютърни мрежи", 280, 525);
  textSize(24);
  text("Напред", 80, 708);
}