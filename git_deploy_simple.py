#!/usr/bin/env python3
"""
Script Python simple pour déployer sur GitHub
Version simplifiée - SANKARA Saïdou
"""

import subprocess
import sys

def main():
    print("🚀 Déploiement GitHub - Portfolio")
    print("=" * 40)
    
    # 1. Git add .
    print("\n📦 Ajout des fichiers...")
    result = subprocess.run("git add .", shell=True)
    if result.returncode != 0:
        print("❌ Erreur lors de l'ajout des fichiers")
        sys.exit(1)
    print("✅ Fichiers ajoutés")
    
    # 2. Message de commit
    print("\n📝 Message de commit:")
    message = input("Entrez votre message: ")
    
    # 3. Git commit
    print("\n💾 Création du commit...")
    result = subprocess.run(f'git commit -m "{message}"', shell=True)
    if result.returncode != 0:
        print("❌ Erreur lors du commit")
        sys.exit(1)
    print("✅ Commit créé")
    
    # 4. Git status
    print("\n📊 Statut du repository:")
    subprocess.run("git status", shell=True)
    
    # 5. Git push
    print("\n🚀 Poussée vers GitHub...")
    result = subprocess.run("git push", shell=True)
    if result.returncode != 0:
        print("❌ Erreur lors de la poussée")
        sys.exit(1)
    
    # 6. Confirmation
    print("\n🎉 SUCCÈS!")
    print("✅ Portfolio déployé sur GitHub")
    print("🌐 Vérifiez votre repository en ligne")

if __name__ == "__main__":
    main()
