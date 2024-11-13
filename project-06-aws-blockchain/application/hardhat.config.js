require("@nomiclabs/hardhat-waffle");


module.exports = {
  networks: {
    gethNetwork: {
      //url: "http://<IP_DE_VOTRE_NOEUD>:8545", //l'adresse IP publique de votre nœud sur AWS (ou localhost si vous vous connectez à un nœud local).
      url: "http://localhost:8501",
    }

  },
  solidity: "0.8.0"
};