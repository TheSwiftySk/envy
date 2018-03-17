PImage stela,school,logo,room,rooms;
int stage = 0,i = 0,last;
char gender;
boolean send = false;
String msg = "";
TEXTBOX[] textbox= new TEXTBOX[12];
String[] messages = new String[12];
Table table;
Table userTable;
TableRow row;
TableRow userRow;
int ans= 0, points = 0, rowInt= 0;

void setup(){
  size(1400,800);
  stela = loadImage("Stela.jpg");
  school = loadImage("school.jpg");
  logo = loadImage("logo.png");
  room = loadImage("room.png");
  rooms = loadImage("rooms.png");
  userTable = loadTable("Users.csv", "header");
  userRow = userTable.getRow(0);
  InitLayout();
}

void draw(){
   if(stage==0){ 
    background(school);
    fill(200);
    textSize(50);
    text("Добре дошли!", 550, 200);
    fill(140,220);
    rect(350,400,200,50);
    rect(750,400,200,50);
    textSize(30);
    fill(200);
    text("Log in",380,430);
    text("Sign up",780,430);
  }
  else if(stage==1){ // REGISTER SCREEN
    background(school);
    textInfo();
    for(i=0;i<textbox.length;i++){
      textbox[i].DRAW();
      image(logo,950,675,400,150);
    }
   if(send){
     if(last==0) text(messages[last], (width - 100) / 2, 250);
     if(last==1) text(messages[last], (width - 100) / 2, 350);
    }
  }
  else if(stage==2){
    background(school);
    textbox[9].DRAW();
    textbox[10].DRAW();
    textbox[11].DRAW();
    fill(200);
    textSize(24);
    text("Потребителско име", 50, 80);
    text("Парола", 50, 180);
    text("Напред", 80, 745);
 }
  else if(stage==3){ // STELA
    background(stela);
    stage=4;
  }
  else if(stage==4){ // NZ ZA SA
    background(51);
  }
  else if(stage==5){ // KORIDOR
    background(rooms);
    fill(0,200);
    textSize(36);
    rect(550,220,80,110);
  }
  else if(stage==6){ // QUIZ
      background(room);
//      fill(0,200);
//      rect(50,570,320,130);
//      rect(550,570,320,130);
//      rect(1050,570,320,130);
        textSize(26);
        fill(0);
        text(row.getString("question"), 450, 300);
        text(row.getString("ans1"), 50, 625);
        text(row.getString("ans2"), 550, 625);
        text(row.getString("ans3"), 1050, 625);
     if(ans!=0){
        if(ans==row.getInt("ansRight")) points++;
        else points--;
        rowInt++;
        row = table.getRow(rowInt);
        ans=0;
     }       
   }
}


void mousePressed(){
    if(mouseX>350 && mouseX<550 && mouseY > 400 && mouseY < 450 && stage==0) stage=2;
    else if(mouseX>750 && mouseX<950 && mouseY > 400 && mouseY < 450) stage=1;
    else if(mouseX > 160 && mouseX < 240 && mouseY > 220 && mouseY < 330 && stage==5){
      table = loadTable("questions.csv", "header");
      row = table.getRow(rowInt);
      stage=6;
    }
    else if(mouseX > 355 && mouseX < 435 && mouseY > 220 && mouseY < 330 && stage==5){
      table = loadTable("questions2.csv", "header");
      row = table.getRow(rowInt);
      stage=6;
    }
    if(mouseX > 50 && mouseX < 380 && mouseY > 570 && mouseY < 700 && stage==6) ans=1;
    else if(mouseX > 550 && mouseX < 880 && mouseY > 570 && mouseY < 700 && stage==6) ans=2;
    else if(mouseX > 1050 && mouseX < 1380 && mouseY > 570 && mouseY < 700 && stage==6) ans=3;
    else ans = 0;
    print(ans);
    for(i=0;i<textbox.length;i++){
      textbox[i].PRESSED(mouseX,mouseY);
      if(textbox[i].selected==true){
         if(i==2) gender = 'm';
         else if(i==3) gender = 'f';
         else if(i==9) stage=5;
      }
   }
   
}

void InitLayout(){
  textbox[0] = new TEXTBOX(50,300,300,40);
  textbox[1] = new TEXTBOX(50,400,300,40);
  textbox[2] = new TEXTBOX(50,500,100,40);
  textbox[3] = new TEXTBOX(180,500,100,40);
  textbox[4] = new TEXTBOX(50,600,200,40);
  textbox[5] = new TEXTBOX(280,600,200,40);
  textbox[6] = new TEXTBOX(50,720,150,40);
  textbox[7] = new TEXTBOX(50,100,300,40);
  textbox[8] = new TEXTBOX(50,200,300,40);
  textbox[9] = new TEXTBOX(50,720,150,40);
  textbox[10] = new TEXTBOX(50,100,300,40);
  textbox[11] = new TEXTBOX(50,200,300,40);
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
  fill(200);
  text("Потребителско име", 50, 80);
  text("Парола", 50, 180);
  text("Име", 50, 280);
  text("Фамилия", 50, 380);
  text("Пол", 50, 480);
  text("Мъж", 65, 530);
  text("Жена", 190, 530);
  text("Паралелка", 55, 580);
  textSize(20);
  fill(255);
  text("Програмиране", 65, 625);
  text("Компютърни мрежи", 280, 625);
  textSize(24);
  text("Напред", 80, 745);
}