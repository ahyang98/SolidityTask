
import { ethers } from "hardhat";
import hre from "hardhat";

async function main(contractName: string) {
    // 验证参数是否提供
    if (!contractName) {
        console.error("请指定要部署的合约名称！");
        console.error("使用方式: npx hardhat run scripts/deploy-dynamic.ts --network <网络名称> <合约名称>");
        process.exit(1);
    }

    console.log(`开始部署合约: ${contractName}`);

    // 获取合约工厂
    const ContractFactory = await ethers.getContractFactory(contractName);

    // 部署合约
    const contract = await ContractFactory.deploy();
    if (!contract) {
        console.error(`合约 ${contractName} 部署失败，请检查错误信息。`);
        process.exit(1);
    }
    await contract.waitForDeployment();

    console.log(`${contractName} 合约已部署到地址: ${contract.target}`);

    // 验证合约（如果是支持的网络）
    if (process.env.HARDHAT_NETWORK === "hardhat"
        || process.env.HARDHAT_NETWORK === "localhost") {
        console.log("在本地网络上部署，跳过合约验证。请在测试网络或主网部署后再进行验证。");
        return;
    }
    console.log("等待区块确认后验证合约...");
    // 等待几个区块确认，确保合约已上链
    const deploymentTx = contract.deploymentTransaction();
    if (deploymentTx) {
        await deploymentTx.wait(5);
    } else {
        console.error("Deployment transaction is null. Cannot wait for confirmation.");
        process.exit(1);
    }

    try {
        await hre.run("verify:verify", {
            address: contract.target,
        });
        console.log("合约验证成功");
    } catch (error) {
        console.log("合约验证失败:", error);
    }
}


main("RomaConvert")
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })