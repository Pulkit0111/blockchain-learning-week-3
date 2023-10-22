// scripts/deploy.js
async function main() {
  const AdvancedToken = await ethers.getContractFactory("AdvancedToken");
  const advancedToken = await AdvancedToken.deploy(
    "YourTokenName",
    "YourTokenSymbol",
    18, // Decimals
    initialSupply, // Initial supply
    maxSupply // Max supply
  );

  await advancedToken.deployed();

  console.log("AdvancedToken deployed to:", advancedToken.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
