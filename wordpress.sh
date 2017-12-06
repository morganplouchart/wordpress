#!/bin/sh
show_menu(){

    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${MENU}**${NUMBER} 0)${MENU} Restart Apache2 ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 1)${MENU} Installation de la configuration minimum ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} Création Base De Données${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3)${MENU} Installation de Wordpress étape 1 (Cli)${NORMAL}"
    echo -e "${MENU}**${NUMBER} 4)${MENU} Installation de Wordpress étape 2 (Droit fichier)${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5)${MENU} Installation de Wordpress étape 3 (Téléchargement du core)${NORMAL}"
    echo -e "${MENU}**${NUMBER} 6)${MENU} Installation de Wordpress étape 4 (Création de la base de données de Wordpress)${NORMAL}"
    echo -e "${MENU}**${NUMBER} 7)${MENU} Installation de Wordpress étape 5 (Vous êtes arrivée a la fin !)${NORMAL}"
    echo -e "${MENU}**${NUMBER} 8)${MENU} Search un plugin ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 9)${MENU} Installer un plugin ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 10)${MENU} Activer un plugin ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 11)${MENU} Désactiver un plugin ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 12)${MENU} Supprimer un plugin ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter a menu option and enter or ${RED_TEXT}enter to exit. ${NORMAL}"
    read opt
}
function option_picked() {
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE=${@:-"${RESET}Error: No message passed"}
    echo -e "${COLOR}${MESSAGE}${RESET}"
}

clear;
show_menu;
while [ opt != '' ]
  do
        case $opt in

        0) clear;
        option_picked "Redemarer apache2";
        sudo service apache2 restart;  option_picked "Apache2 a redemarer"; show_menu;
        menu;
            ;;
        1) clear;
        option_picked "Installer la configuration minimum.";
        sudo apt-get install php7.0;
        sudo apt-get install apache2;
        sudo apt-get install php7.0-mysql;
        sudo apt-get install libapache2-mod-php7.0;
        option_picked "PHP 7 est installer"; show_menu;
        menu;

        ;;

        2) clear;
            option_picked "La base de données est en cours de création ...";
        sudo mysql -uroot -p; option_picked "L'user est root et le mot de passe est celui que vous avez choisi"; show_menu;
        menu;
            ;;

        3) clear;
            option_picked "Prémiere étape de l'installation de Wordpress";
        sudo curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; option_picked "La prémiere étape est terminé"; show_menu;
        menu;
            ;;


        4) clear;
            option_picked "Seconde étape de l'installation de Wordpress";
        sudo chmod 777 wp-cli.phar; sudo mv wp-cli.phar /usr/local/bin/wp; option_picked "La Seconde étape est terminé"; show_menu;
        menu;
            ;;

        5) clear;
            option_picked "troisième étape de l'installation de Wordpress";
        sudo wp core download --allow-root; option_picked "La troisième étape est terminé, l'installation de WordPress est terminé"; show_menu;
        menu;
            ;;

        6) clear;
            option_picked "Quatriéme étape de l'installation de Wordpress";
            echo "entrée le nom de votre base de donnée"
            read -e dbname break;
            echo "entrée le nom de l'utilisateur"
            read -e user break;
            echo "entrée le mot de passe"
            read -e password break;
        sudo wp config create --dbname=$dbname --dbuser=$user --dbpass=$password --allow-root; option_picked "La quatrième étape est terminé, l'installation de WordPress est terminé"; show_menu;
        menu;
            ;;
            7) clear;
                option_picked "derniere étape de l'installation de Wordpress";
                echo "entrée votre URL"
                read -e urlname break;
                echo "entrée le titre de votre site"
                read -e Titre break;
                echo "entrer votre pseudo"
                read -e admin break;
                echo "entrer votre mot de passe"
                read -e password break;
                echo "entrer votre email"
                read -e email break;
            sudo wp core install --url=$urlname --title=$titre --admin_user=$admin --admin_password=$password --admin_email=$email --allow-root; option_picked "La derniere étape est terminé, l'installation de WordPress est terminé"; show_menu;
            menu;
                ;;

           8) clear;
            option_picked "Search un plugin";
            echo "entrée le nom d'un plugin à rechercher"
            read -e cherche break;
            sudo wp plugin search $cherche --allow-root; option_picked "Recherche terminer"; show_menu;
            menu;
            ;;

           9) option_picked "Installer un plugin";
              echo "entrée le nom d'un plugin à installer"
              read -e install break;
              sudo wp plugin install $install --allow-root; option_picked "Recherche terminer"; show_menu;
              menu;
              ;;
            
           10) 
              option_picked "activer un plugin";
              echo "entrée le nom d'un plugin à activer"
              read -e active break;
              sudo wp plugin activate $active --allow-root; option_picked "Recherche terminer"; show_menu;
              menu;
              ;;

            11)
              option_picked "désactiver un plugin";
              echo "entrée le nom d'un plugin à désactiver"
              read -e desactive break;
              sudo wp plugin deactivate $desactive --allow-root; option_picked "Recherche terminer"; show_menu;
              menu;
              ;;

             12)
              option_picked "désactiver un plugin";
              echo "entrée le nom d'un plugin à supprimer"
              read -e uninstall break;
              sudo wp plugin uninstall $uninstall --allow-root; option_picked "Recherche terminer"; show_menu;
              menu;
              ;;
        
        x)exit;
        ;;

        \n)exit;
        ;;

        *)clear;
        option_picked "Pick an option from the menu";
        show_menu;
        ;;
    esac
done
