# BE IHM MULTIMODALE

## Description

Le projet "BE IHM MULTIMODALE" utilise une application **Processing** pour afficher des formes sur un tableau blanc interactif. Cette application permet d'ajouter des formes en utilisant soit des commandes clavier, soit de la reconnaissance vocale via un programme Python. Les formes peuvent être affichées, déplacées, ou supprimées en fonction des interactions.

## Prérequis

- **Processing** : pour exécuter l'application de dessin sur le tableau blanc.
- **Python** : pour exécuter le programme vocal avec l'agent Ivy qui gère la reconnaissance vocale.
- **Ivy** : utilisé pour la communication entre le programme Python et l'application Processing.
- **Visionneur Ivy** : pour visualiser les messages échangés sur le bus Ivy.

## Installation

1. Clonez ou téléchargez ce projet sur votre machine.
2. Installez les dépendances nécessaires pour **Processing** et **Python**.
3. Exécutez le fichier **palette** dans **Processing** pour démarrer l'application.

## Utilisation

### 1. **Ajout de formes via le clavier :**

Vous pouvez ajouter les formes suivantes en appuyant sur les touches correspondantes :

- **C** pour un cercle
- **R** pour un rectangle
- **T** pour un triangle
- **L** pour un losange

Chaque forme apparaîtra à l'emplacement actuel du curseur de la souris sur le tableau blanc.

### 2. **Ajout de formes via la reconnaissance vocale :**

Le programme Python `vocal.py` utilise un agent Ivy pour la reconnaissance vocale et l'envoi des messages sur le bus Ivy. Suivez ces étapes pour utiliser la reconnaissance vocale :

- Exécutez le fichier Python `vocal.py` pour démarrer l'enregistrement vocal.
- Appuyez sur la touche **"espace"** pour commencer un enregistrement de 3 secondes.
- Prononcez une phrase pour ajouter une forme, avec ou sans couleur (par exemple, "dessine un rectangle rouge", "affiche un triangle vert", "affiche un losange").
  - Si aucune couleur n'est précisée, la forme sera affichée en **gris** par défaut.

### Liste des formes et couleurs disponibles

- **Formes** : rectangle, cercle, triangle, losange
- **Couleurs** : rouge, jaune, vert, bleu, gris, orange

### 3. **Suppression de formes :**

Vous pouvez supprimer une forme en disant une phrase contenant le mot **"supprime"**. Ensuite, cliquez sur la forme que vous souhaitez supprimer pour la sélectionner. Exemple de phrase :

- "Supprime cette forme"

### 4. **Autres interactions :**

- **Déplacer une forme** : appuyez sur la touche **"M"** puis cliquez sur une forme pour la sélectionner. Ensuite, cliquez à un autre endroit pour déplacer la forme.
- **Changer la couleur d'une forme** : cliquez sur une forme pour en changer la couleur de manière aléatoire.

### 5. **Visualisation des messages Ivy :**

Les messages échangés entre le programme Python et l'application Processing sont envoyés via le bus Ivy. Pour visualiser ces messages, exécutez **"visionneur.bat"**.

### 6. **Reconnaissance vocale (grammaire) :**

Le dossier **sra5** contient une tentative de reconnaissance vocale par grammaire. Cette version fonctionne de manière moins fiable, mais elle peut être utilisée comme base pour des améliorations.

---

## Notes

- Si vous rencontrez des problèmes lors de l'exécution de l'application, assurez-vous que les dépendances nécessaires pour **Ivy** et **Processing** sont bien installées.
- La reconnaissance vocale peut nécessiter des ajustements supplémentaires en fonction de votre environnement et des configurations de votre microphone.

### Membre de l'équipe

- **Axel NIATO**
- **Nahaclan COULIBALY**
- **Rahim SAIDI**

---
