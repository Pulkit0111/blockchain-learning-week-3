const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("AdvancedToken Contract", function () {
  let owner;
  let user1;
  let user2;
  let advancedToken;

  before(async function () {
    [owner, user1, user2] = await ethers.getSigners();

    const AdvancedToken = await ethers.getContractFactory("AdvancedToken");
    advancedToken = await AdvancedToken.deploy("TestToken", "TT", 18, 1000, 2000);
    await advancedToken.deployed();
  });

  it("Should mint tokens and update balance", async function () {
    await advancedToken.connect(owner).mintTokens(user1.address, 500);
    const balance = await advancedToken.balanceOf(user1.address);
    expect(balance).to.equal(500);
  });

  it("Should not mint tokens beyond max supply", async function () {
    await expect(advancedToken.connect(owner).mintTokens(user2.address, 1500)).to.be.revertedWith("Max supply exceeded");
  });

  it("Should allow users to burn tokens", async function () {
    await advancedToken.connect(user1).burnTokens(200);
    const balance = await advancedToken.balanceOf(user1.address);
    expect(balance).to.equal(300);
  });

  it("Should lock and unlock tokens", async function () {
    await advancedToken.connect(owner).lockTokens(user1.address, 7);
    let lockedUntil = await advancedToken._lockedUntil(user1.address);
    expect(lockedUntil.toNumber()).to.be.gt(0);

    await advancedToken.connect(owner).unlockTokens(user1.address);
    lockedUntil = await advancedToken._lockedUntil(user1.address);
    expect(lockedUntil.toNumber()).to.equal(0);
  });

  it("Should prevent the transfer of locked tokens", async function () {
    await advancedToken.connect(owner).lockTokens(user1.address, 7);

    await expect(advancedToken.connect(user1).transfer(user2.address, 100)).to.be.revertedWith("Your tokens are locked");
  });
});
