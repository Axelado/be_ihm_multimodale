/*
 * Palette Graphique - prélude au projet multimodal 3A SRI
 * 4 objets gérés : cercle, rectangle(carré), losange et triangle
 * (c) 05/11/2019
 * Dernière révision : 28/04/2020
 */
 
import java.awt.Point;

import fr.dgac.ivy.*;
import javax.swing.JOptionPane;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;



ArrayList<Forme> formes; // liste de formes stockées
FSM mae; // Finite Sate Machine
int indice_forme;
PImage sketch_icon;
String message = "";
String msg_couleur = "";

// Attributes
Ivy bus;
Point notre_point = new Point(0,0);

HashMap<String, ArrayList<Integer>> couleurs_map = new HashMap<>();

void setup() {
  size(800,600);
  surface.setResizable(true);
  surface.setTitle("Palette multimodale");
  surface.setLocation(20,20);
  sketch_icon = loadImage("Palette.jpg");
  surface.setIcon(sketch_icon);
  
  formes= new ArrayList(); // nous créons une liste vide
  noStroke();
  mae = FSM.INITIAL;
  indice_forme = -1;
  initColor();
  initIvy();
}

void initIvy() {
   try {
    bus = new Ivy("demo", " demo_processing is ready", null);
    bus.start("127.255.255.255:2010");
    
    bus.bindMsg("^vocal Template=(.*) couleur=(.*)", new IvyMessageListener() {
      public void receive(IvyClient client, String[] args) {
        println("ok");
        message = args[0];
        msg_couleur = args[1];

        //displayShape(message);
        println(message);
        println(msg_couleur);
      }        
    });
  } catch (IvyException ie) {
    println("Erreur Ivy : " + ie.getMessage());
  }
}

void initColor() {
   // Définition des couleurs et de leurs valeurs RGB
  couleurs_map.put("rouge", new ArrayList<Integer>(List.of(255, 0, 0)));  // Rouge
  couleurs_map.put("jaune", new ArrayList<Integer>(List.of(255, 255, 0)));  // Jaune
  couleurs_map.put("vert", new ArrayList<Integer>(List.of(0, 255, 0)));  // Vert
  couleurs_map.put("bleu", new ArrayList<Integer>(List.of(0, 0, 255)));  // Bleu
  couleurs_map.put("gris", new ArrayList<Integer>(List.of(169, 169, 169)));  // Gris
  couleurs_map.put("orange", new ArrayList<Integer>(List.of(255, 165, 0)));  // Orange
}


void draw() {
  background(0);
  //println("MAE : " + mae + " indice forme active ; " + indice_forme);
  switch (mae) {
    case INITIAL:  // Etat INITIAL
      background(255);
      fill(0);
      text("Etat initial (c(ercle)/l(osange)/r(ectangle)/t(riangle) pour créer la forme à la position courante)", 50,50);
      text("m(ove)+ click pour sélectionner un objet et click pour sa nouvelle position", 50,80);
      text("click sur un objet pour changer sa couleur de manière aléatoire", 50,110);
      break;
    case AFFICHER_FORMES:  // 
    case DEPLACER_FORMES_SELECTION: 
    case DEPLACER_FORMES_DESTINATION: 
      affiche();
      break;   
      
    default:
      break;
  }  
}

// fonction d'affichage des formes m
void affiche() {
  background(255);
  /* afficher tous les objets */
  for (int i=0;i<formes.size();i++) // on affiche les objets de la liste
    (formes.get(i)).update();
}


void mousePressed() { // sur l'événement clic

  notre_point = new Point(mouseX,mouseY);
  
  Point p = new Point(mouseX,mouseY);
    switch (mae) {
      case AFFICHER_FORMES:
        for (int i=0;i<formes.size();i++) { // we're trying every object in the list
          // println((formes.get(i)).isClicked(p));
          if ((formes.get(i)).isClicked(p)) {
            (formes.get(i)).setColor(color(random(0,255),random(0,255),random(0,255)));
          }
        }
        break;
        
     case DEPLACER_FORMES_SELECTION:
       for (int i=0;i<formes.size();i++) { // we're trying every object in the list        
          if ((formes.get(i)).isClicked(p)) {
            indice_forme = i;
            mae = FSM.DEPLACER_FORMES_DESTINATION;
          }         
       }
       if (indice_forme == -1)
         mae= FSM.AFFICHER_FORMES;
       break;
       
     case DEPLACER_FORMES_DESTINATION:
       if (indice_forme !=-1)
         (formes.get(indice_forme)).setLocation(new Point(mouseX,mouseY));
       indice_forme=-1;
       mae=FSM.AFFICHER_FORMES;
       break;
       
      default:
        break;
    }
  
  
   switch (message) {
      case "rectangle":
        Forme f= new Rectangle(notre_point);
        if(couleurs_map.containsKey(msg_couleur)) {
          println(msg_couleur);
          ArrayList<Integer> couleur_rgb = couleurs_map.get(msg_couleur);
          println(couleur_rgb);
          f.setColor(color(couleur_rgb.get(0), couleur_rgb.get(1), couleur_rgb.get(2)));
        }
        formes.add(f);
        mae=FSM.AFFICHER_FORMES;
        break;
      
    case "cercle":
      Forme f2=new Cercle(notre_point);
      
      if(couleurs_map.containsKey(msg_couleur)) {
        println(msg_couleur);
        ArrayList<Integer> couleur_rgb = couleurs_map.get(msg_couleur);
        println(couleur_rgb);
        f2.setColor(color(couleur_rgb.get(0), couleur_rgb.get(1), couleur_rgb.get(2)));
      }
      
      formes.add(f2);
      mae=FSM.AFFICHER_FORMES;
      break;
    
    case "triangle":
      Forme f3=new Triangle(notre_point);
      
      if(couleurs_map.containsKey(msg_couleur)) {
        println(msg_couleur);
        ArrayList<Integer> couleur_rgb = couleurs_map.get(msg_couleur);
        println(couleur_rgb);
        f3.setColor(color(couleur_rgb.get(0), couleur_rgb.get(1), couleur_rgb.get(2)));
      }
      
      formes.add(f3);
      mae=FSM.AFFICHER_FORMES;
      break;  
      
    case "losange":
      Forme f4=new Losange(notre_point);
      if(couleurs_map.containsKey(msg_couleur)) {
        println(msg_couleur);
        ArrayList<Integer> couleur_rgb = couleurs_map.get(msg_couleur);
        println(couleur_rgb);
        f4.setColor(color(couleur_rgb.get(0), couleur_rgb.get(1), couleur_rgb.get(2)));
      }
      formes.add(f4);
      mae=FSM.AFFICHER_FORMES;
      break; 
    case "supprime":
      for (int i=0;i<formes.size();i++) { // we're trying every object in the list
        // println((formes.get(i)).isClicked(p));
        if ((formes.get(i)).isClicked(notre_point)) {
          formes.remove(i);
        }
      } 
     
      mae=FSM.AFFICHER_FORMES;
      break; 
    }
    

    
  msg_couleur = "";
  message = "";
    
}

void keyPressed() {
  Point p = new Point(mouseX,mouseY);
  switch(key) {
    case 'r':
      Forme f= new Rectangle(p);
      formes.add(f);
      mae=FSM.AFFICHER_FORMES;
      break;
      
    case 'c':
      Forme f2=new Cercle(p);
      formes.add(f2);
      mae=FSM.AFFICHER_FORMES;
      break;
    
    case 't':
      Forme f3=new Triangle(p);
      formes.add(f3);
       mae=FSM.AFFICHER_FORMES;
      break;  
      
    case 'l':
      Forme f4=new Losange(p);
      formes.add(f4);
      mae=FSM.AFFICHER_FORMES;
      break;    
      
    case 'm' : // move
      mae=FSM.DEPLACER_FORMES_SELECTION;
      break;
  }
}
