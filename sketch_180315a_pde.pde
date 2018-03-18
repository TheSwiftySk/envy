PImage stela,school,logo,room,rooms,balloons,elsysLife;
int stage = 0,i = 0,last;
String gender;
boolean send = false;
String msg = "";
TEXTBOX[] textbox= new TEXTBOX[12];
String[] messages = new String[12];
Table table, userTable, dataTable;
TableRow row, userRow, dataRow;
int ans = 0, points = 0, rowInt = 0;
int currentPoints;

void setup(){
  size(1400,800);
  stela = loadImage("Stela.jpg");
  school = loadImage("school.jpg");
  logo = loadImage("logo.png");
  room = loadImage("room.png");
  rooms = loadImage("rooms.png");
  balloons = loadImage("balloons.png");
  elsysLife = loadImage("elsysLife.png");
  userTable = loadTable("Users.csv", "header");
  userRow = userTable.getRow(0);
  dataTable = loadTable("data.csv", "header");
  dataRow = dataTable.getRow(0);
  messages[10] = "nishto";
  messages[11] = "nshto";
  InitLayout();
}

void draw(){
   if(stage==0){                                 // WELLCOME SCREEN
    background(school);
    fill(200);
    textSize(50);
    text("Добре дошли!", 500, 200);
    fill(140,220);
    rect(350,400,200,50);
    rect(750,400,200,50);
    textSize(30);
    fill(255);
    text("Log in",380,430);
    text("Sign up",780,430);
  }
  else if(stage==1){                              // REGISTER SCREEN
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
  else if(stage==2){                               // LOG IN SCREEN
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
  else if(stage==3){                                 // STELA
    background(stela);
    textbox[9].DRAW();
    fill(200);
    textSize(24);    
    text("Напред", 80, 745);
  }
  else if(stage==4){                                 // PURVI TEST
    background(balloons);
    fill(0);
    textSize(50);
    text("Втеме е за входен тест!", 600, height/2-200);
    textbox[9].DRAW();
    fill(0);
    textSize(24);    
    text("Напред", 80, 745);
  }
  else if(stage==5){     // KORIDOR
    rowInt=0;
    background(rooms);
    fill(150,100);
    rect(1200,5,150,40);
    fill(0);
    textAlign(LEFT);
    textSize(22);
    text("Статистика", 1210, 30);
    textSize(26);
    fill(0);
    text("Потребител: ",10,30);
    text(userRow.getString("username"),180,30);
    text("Точки: ",300,30);
    text(userRow.getString("points"),390,30);
  }
  else if(stage==6){                                 // QUIZ
      background(room);
        textSize(20);
        fill(0);
        textAlign(CENTER);
        text(row.getString("question"), width/2, 300);
        textSize(22);
        text(row.getString("ans1"), 200, 625);
        text(row.getString("ans2"), 700, 625);
        text(row.getString("ans3"), 1200, 625);
     if(ans!=0){                                        // PROVERKA DALI OTGOVORA E VEREN
        currentPoints=userRow.getInt("points")+1;
        if(ans==row.getInt("ansRight")){
          userRow.setInt("points", currentPoints);
          saveTable(userTable, "Users.csv");
        }
        rowInt++;
        row = table.getRow(rowInt);
        ans=0;
     if(rowInt>3) stage=5;
     }       
   }
   else if(stage==7){
     background(255);
     fill(150,100);
     rect(1200,5,150,40);
     fill(0);
     textSize(24);
     text("Назад", 1230, 30);
     
     for(int i = 0;i<dataRow.getInt("counter");i++){
         userRow = userTable.getRow(i);
         text("Потребител: ",10,30+(50*i));
         text(userRow.getString("username"),180,30+(50*i));
         text("Точки: ",300,30+(50*i));
         text(userRow.getString("points"),390,30+(50*i));
               }     
       } 
}

// rect(1200,5,150,40);

void mousePressed(){
    if(mouseX>350 && mouseX<550 && mouseY > 400 && mouseY < 450 && stage==0) stage=2; // PROVERKA DALI SI SE REGISTRILAL ILI NE
    else if(mouseX>750 && mouseX<950 && mouseY > 400 && mouseY < 450 && stage==0) stage=1;
    if(mouseX > 160 && mouseX < 240 && mouseY > 220 && mouseY < 330 && stage==5){  // PROVERKA V KOQ STAQ VLIZASH
      table = loadTable("ae8.csv", "header");
      row = table.getRow(rowInt);
      stage=6;
    }
    else if(mouseX > 355 && mouseX < 435 && mouseY > 220 && mouseY < 330 && stage==5){
      table = loadTable("elth.csv", "header");
      row = table.getRow(rowInt);
      stage=6;
    }
    if(mouseX > 50 && mouseX < 380 && mouseY > 570 && mouseY < 700 && stage==6) ans=1;        // PROVERKA KOI OTGOVOR E NATISKAT
    else if(mouseX > 550 && mouseX < 880 && mouseY > 570 && mouseY < 700 && stage==6) ans=2;
    else if(mouseX > 1050 && mouseX < 1380 && mouseY > 570 && mouseY < 700 && stage==6) ans=3;
    else ans = 0;
    
    if(stage==5 && mouseX > 1200 && mouseX < 1350 && mouseY > 5 && mouseY < 45) stage = 7;
    else if(stage==7 && mouseX > 1200 && mouseX < 1350 && mouseY > 5 && mouseY < 45) stage = 5;
    for(i=0;i<textbox.length;i++){
      textbox[i].PRESSED(mouseX,mouseY);
      if(textbox[i].selected==true){
         if(i==2) gender = "m";
         else if(i==3) gender = "f";
         else if(i==9 && stage==2){  // PROVERKA ZA USER-A
           for(int i = 0;i<dataRow.getInt("counter");i++){
             userRow = userTable.getRow(i);
             if(messages[10].equals(userRow.getString("username")) && messages[11].equals(userRow.getString("password"))){
               stage=5;
               break;
               }
              }
            }
         else if(i==9 && stage==3) stage++; 
         else if(i==9 && stage==4){
           table = loadTable("vhodenTest.csv", "header");
           row = table.getRow(rowInt);
           stage=6;
         }
         else if(i==9 && stage==1){                          // DOBAVQNE NA USER
            userTable = loadTable("Users.csv", "header");
            userRow = userTable.addRow();
            userRow.setString("username", messages[7]);
            userRow.setString("password", messages[8]);
            userRow.setString("firstName", messages[0]);
            userRow.setString("secondName", messages[1]);
            userRow.setString("gender", gender);
            userRow.setInt("points", 0);
            saveTable(userTable, "Users.csv");
            dataRow.setInt("counter", dataRow.getInt("counter")+1);
            saveTable(dataTable, "data.csv");
            stage=3;
      }
    }
  }
}

void InitLayout(){                                    // VSICHKI BUTONI I TEXTBOX-OVE
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

void keyPressed(){                                      // PROVERKA KAKVO PISHESH
    for(i=0;i<textbox.length;i++){
      textbox[i].KEYPRESSED(key,keyCode);
        send = true;
        last = i;
        messages[i] = textbox[i].Text;
    
  } 
}

void textInfo(){                                        // POVECHETO TEKST  
  textSize(24);
  fill(255);
  text("Потребителско име", 50, 80);
  text("Парола", 50, 180);
  text("Име", 50, 280);
  text("Фамилия", 50, 380);
  text("Пол", 50, 480);
  text("Паралелка", 55, 580);
  textSize(20);
  fill(255);
  text("Мъж", 65, 530);
  text("Жена", 190, 530);
  text("Програмиране", 65, 625);
  text("Компютърни мрежи", 280, 625);
  textSize(24);
  text("Напред", 80, 745);
}