import speech_recognition as sr
import keyboard  # Pour détecter l'appui sur une touche
from ivy.std_api import *

def init():
    # Initialiser l'agent Ivy
    agent_name = "vocal"
    IvyInit(agent_name,  # Nom de l'agent
            f"{agent_name} prêt !",  # Message d'annonce à la connexion
            0,  # Callback à la connexion (None si aucun)
             ) 

    # Connecter l'agent au bus Ivy (par défaut, sur localhost)
    IvyStart("127.255.255.255:2010")  # Remplacez par l'adresse et le port du bus si différent

def send_message(forme, couleur=""):
    message = "vocal Template="+forme+" couleur="+couleur
    IvySendMsg(message)
    print(f"Message envoyé : {message}")


def record_and_transcribe():
    recognizer = sr.Recognizer()
    microphone = sr.Microphone()
    
    print("Appuyez sur 'Espace' pour commencer l'enregistrement...")
    keyboard.wait('space')  # Attendre que l'utilisateur appuie sur "espace"
    print("Enregistrement en cours pendant 3 secondes...")
    
    with microphone as source:
        recognizer.adjust_for_ambient_noise(source, duration=0.5)  # Ajuster au bruit ambiant
        audio_data = recognizer.record(source, duration=3)  # Enregistrer 3 secondes
        
    print("Enregistrement terminé. Transcription en cours...")
    
    try:
        # Utiliser Google Web Speech API pour la transcription
        transcription = recognizer.recognize_google(audio_data, language="fr-FR")  # Pour le français
        trouver_forme(transcription)
        print("Transcription : ", transcription)
    except sr.UnknownValueError:
        print("Impossible de comprendre l'audio.")
    except sr.RequestError as e:
        print(f"Erreur lors de la demande à l'API Google Speech Recognition : {e}")

def trouver_forme(chaine):
    formes = ["cercle", "triangle", "losange", "rectangle", "supprime"]
    couleurs = ["rouge", "jaune", "vert", "bleu", "gris", "orange"]
    for forme in formes:
        if forme in chaine.lower():  # Comparaison insensible à la casse
            for couleur in couleurs:
                if couleur in chaine.lower():
                    send_message(forme, couleur)
                    return None
            send_message(forme)
            return None
    
if __name__ == "__main__":
    init()
    try:
        while True:
            record_and_transcribe()
            print("Ctrl+C pour arrêter le programme")    
    except KeyboardInterrupt:
        print("\nInterruption par Ctrl+C. Fin du programme.")
        IvyStop()
