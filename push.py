#!/usr/bin/env python3
"""
Script Python pour déployer le portfolio sur GitHub
Auteur: SANKARA Saïdou
Date: Septembre 2025
"""

import subprocess
import sys
import os

def run_command(command, description):
    """Exécute une commande et affiche le résultat"""
    print(f"\n🔄 {description}...")
    print(f"Commande: {command}")
    print("-" * 50)
    
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True, encoding='utf-8')
        
        if result.stdout:
            print(result.stdout)
        
        if result.stderr:
            print(f"⚠️  Avertissements/Erreurs:")
            print(result.stderr)
        
        if result.returncode == 0:
            print(f"✅ {description} - Succès!")
            return True
        else:
            print(f"❌ {description} - Échec (code: {result.returncode})")
            return False
            
    except Exception as e:
        print(f"❌ Erreur lors de l'exécution: {e}")
        return False

def main():
    """Fonction principale du script"""
    print("🚀 Script de Déploiement GitHub - Portfolio Académique")
    print("=" * 60)
    
    # Vérifier si nous sommes dans un repository Git
    if not os.path.exists('.git'):
        print("❌ Erreur: Ce dossier n'est pas un repository Git!")
        print("💡 Initialisez d'abord Git avec: git init")
        sys.exit(1)
    
    # 1. Git add .
    if not run_command("git add .", "Ajout de tous les fichiers"):
        print("❌ Échec lors de l'ajout des fichiers. Arrêt du script.")
        sys.exit(1)
    
    # 2. Demander le message de commit
    print("\n" + "=" * 60)
    print("📝 Message de commit")
    print("=" * 60)
    
    while True:
        commit_message = input("Entrez votre message de commit: ").strip()
        
        if commit_message:
            break
        else:
            print("⚠️  Le message ne peut pas être vide. Veuillez réessayer.")
    
    # 3. Git commit
    commit_cmd = f'git commit -m "{commit_message}"'
    if not run_command(commit_cmd, "Création du commit"):
        print("❌ Échec lors de la création du commit. Arrêt du script.")
        sys.exit(1)
    
    # 4. Git status
    run_command("git status", "Vérification du statut")
    
    # 5. Git push
    if not run_command("git push", "Poussée vers GitHub"):
        print("❌ Échec lors de la poussée vers GitHub.")
        print("💡 Vérifiez:")
        print("   - Votre connexion internet")
        print("   - Vos identifiants GitHub")
        print("   - L'URL du repository distant")
        sys.exit(1)
    
    # 6. Message de confirmation
    print("\n" + "=" * 60)
    print("🎉 DÉPLOIEMENT TERMINÉ AVEC SUCCÈS!")
    print("=" * 60)
    print("✅ Tous les fichiers ont été ajoutés")
    print("✅ Le commit a été créé avec le message:")
    print(f'   "{commit_message}"')
    print("✅ Le statut a été vérifié")
    print("✅ Le code a été poussé vers GitHub")
    print("\n🌐 Votre portfolio est maintenant en ligne!")
    print("🔗 Vérifiez votre repository sur GitHub pour confirmer")
    print("\n💡 Prochaines étapes:")
    print("   - Partagez le lien de votre portfolio")
    print("   - Activez GitHub Pages si souhaité")
    print("   - Continuez à développer vos projets!")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\n⚠️  Script interrompu par l'utilisateur.")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ Erreur inattendue: {e}")
        sys.exit(1)
