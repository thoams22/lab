#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#set text(lang :"fr")
#show: codly-init.with()
#codly(number-format: none)

#outline()

= Verification

Verifier que virtualbox est installé.

Sur linux :
```bash
virtualbox --version
```
Si ce n'est pas le cas, l'installer
```bash
sudo apt install virtualbox
```

Sur windows:

Vous pouvez télécharger le programme d'installation depuis le site officiel de VirtualBox : https://www.virtualbox.org/

= Setup

== Créer une machine virtuelle linux

Lancer le programme virtual box.

Dans la barre de menu de VirtualBox, cliquer sur "Machine" puis "Nouvelle" pour créer une nouvelle machine virtuelle.

Dans la fenêtre qui s'ouvre, choisir un nom pour la machine virtuelle, sélectionner le type de système d'exploitation (Linux) et la version (Ubuntu 64-bit par exemple). 
Cliquer sur "Suivant".

Laisser les paramètres par défaut pour le materiel et cliquer sur "Suivant".

Laisser les paramètres par défaut pour le disque dur et cliquer sur "Suivant".

Verifier les paramètres de la machine virtuelle et cliquer sur "Créer".

== Créer un réseau virtuel

Dans la barre de menu de VirtualBox, cliquer sur "Fichier" puis "Préférences".

Dans la fenêtre qui s'ouvre, sélectionner "Réseau" dans le menu de gauche, puis aller dans l'onglet "Réseaux NAT".

Cliquer sur l'icône avec un "+" pour ajouter un nouveau réseau. Un réseau par défaut sera créé (par exemple, ReseauNat).

Cliquer sur "Propriétés" pour configurer le réseau.

Verifier qu'il y a un prefix IPv4 et que DHCP est activé. Ensuite aller dans "transfert de port" et ajouter une nouvelle règle de transfert de port. 

Ajouter une règle de transfert de port avec les paramètres suivants :
- Protocole : TCP
- IP hote : Votre adresse IP
- Port hote : 8080
- IP invité: 10.0.2.15
- Port invité : 5000

Pour récupérer votre adresse IP, vous pouvez utiliser la commande suivante dans le terminal :

Sur linux : 
```bash
hostname -I
```

Sur windows :
```bash
ipconfig
```

== Ajouter la machine virtuelle au réseau virtuel

Selectionner la machine virtuelle dans la liste de gauche, puis cliquer sur "Paramètres" dans la barre de menu.

Dans la fenêtre qui s'ouvre, sélectionner "Réseau" dans le menu de gauche.

Dans l'onglet "Adaptateur 1", cocher la case "Activer l'adaptateur réseau".

Dans le menu déroulant "Attachement", sélectionner "Réseau NAT" et choisir le réseau que vous venez de créer (par exemple, ReseauNat).

Cliquer sur "OK" pour enregistrer les modifications.

== Lancer la machine virtuelle

Dans la barre de menu de VirtualBox, cliquer sur "Machine" puis "Démarrer" pour lancer la machine virtuelle ou double cliquer sur la machine virtuelle dans la liste de gauche.

Suiver les instructions à l'écran pour installer le système d'exploitation sur la machine virtuelle.

== Installer les dependances du laboratoire

Dans la machine virtuelle, ouvrir un terminal et exécuter les commandes suivantes pour installer les dépendances nécessaires :

```bash
sudo apt update
```

Verifier que git est installé
```bash
git --version
```
Si ce n'est pas le cas, l'installer
```bash
sudo apt install git
```

Cloner le projet depuis le repository git
```bash
git clone https://github.com/thoams22/lab.git
```

Verifier que python est installé
```bash
python3 --version
```
Si ce n'est pas le cas, l'installer
```bash
sudo apt install python3
```

Verifier que pip est installé
```bash
pip3 --version
```

Si ce n'est pas le cas, l'installer
```bash
sudo apt install python3-pip
```

Verifier que flask est installé
```bash
pip3 show flask
```
Si ce n'est pas le cas, l'installer
```bash
pip3 install flask
```
ou 
```bash
python3-flask
```


Au besoin, installer via un environnement virtuel
```bash
python3 -m venv env
source env/bin/activate
pip3 install flask
```
Il est peut être nécessaire d'être en super utilisateur
```bash
sudo python3 -m venv env
source env/bin/activate
pip3 install flask
```
ou 
```bash
su 
python3 -m venv env
source env/bin/activate
pip3 install flask
```


== Lancer le serveur

Dans le terminal de la machine virtuelle, naviguer vers le dossier du projet cloné :
```bash
cd lab
```
Puis, lancer le serveur Flask avec la commande suivante :
```bash
python3 SQLinjection.py
```

Au besoin lancer depuis un environnement virtuel (Peut être nécessaire d'être en super utilisateur)
```bash
source env/bin/activate
python3 SQLinjection.py
```

Un message du type Running on 10.0.2:5000 (Press CTRL+C to quit) devrait s'afficher, indiquant que le serveur est en cours d'exécution.

== Tester le serveur

Dans le navigateur de la machine virtuelle, entrer l'URL suivante du message de lancement du serveur.

== Verifier la regle de transfert de port

Dans le navigateur de la machine hote, entrer l'URL suivante :

\<Adresse IP de la machine hote>:8080

Si tout est bien configuré, vous devriez voir la page d'accueil de l'application.

Verifier maintenant que la page est accessible depuis une autre machine sur le même réseau local. Pour cela, vous pouvez utiliser un autre ordinateur ou un smartphone connecté au même réseau.

Si vous avez des difficultés à accéder à la page, vérifiez que le pare-feu de votre machine hôte ne bloque pas le port 8080. Vous pouvez temporairement désactiver le pare-feu pour tester si c'est la cause du problème.

Ou verifer les addresses IP de la machine hote et de la machine virtuelle. Pour cela, vous pouvez utiliser la commande suivante dans le terminal de la machine hote et verifier que dans la regle de transfert de port, les adresses IP sont bien configurées.

