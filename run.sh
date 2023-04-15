clear
echo "   1. Install XrayR"
echo "   2. Config XrayR"
read -p "  Vui Lòng Nhập : " num

    case "${num}" in
        1) bash <(curl -Ls https://raw.githubusercontent.com/XrayR-project/XrayR-release/master/install.sh)
        ;;
        2) bash <(curl -Ls https://raw.githubusercontent.com/khiembui123Khiem/script/main/config.sh)
        ;;
        *) bash <(curl -Ls https://raw.githubusercontent.com/khiembui123Khiem/script/main/run.sh)
        ;;
    esac
