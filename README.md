# Smart contract for fractionalization of NFTs

This smart contract converts NFT(ERC 721) into fractional NFT(ERC20 Tokens). Parameters like token name, token symbol, supply, curator fee should be passed into the contract.

## Description

There are 2 solidity scripts in this project which are NFT.sol and FNFT.sol. NFT.sol is responsible for deploying smart contact to mint NFT's. FNFT.sol will take care of fractionalizing NFT's. Both the scripts will be running in Remix IDE with "Injected Provider(Metamask)" as environment.

## Steps

<img alt="12_Token_In_Metamask" src="https://github.com/keerthanchand/fractional-NFTs-smart-contract/blob/main/images/1_NFT_Deployment.png"  height="450">

* Smart contract for minting NFTs is deployed 

<img alt="12_Token_In_Metamask" src="https://github.com/keerthanchand/fractional-NFTs-smart-contract/blob/main/images/2_Minting_NFT.png"  height="450">

* Under "safeMint" function wallet address of the owner and id for the NFT is provided.

<div style="display:"flex">
<img alt="12_Token_In_Metamask" src="https://github.com/keerthanchand/fractional-NFTs-smart-contract/blob/main/images/3_FNFT_Deployment.png"  height="450">
<img alt="12_Token_In_Metamask" src="https://github.com/keerthanchand/fractional-NFTs-smart-contract/blob/main/images/4_FNFT_Deployment_Payment.png"  height="450">
</div>

* In FNFT.sol the new token name and token symbol is provided and deployed. Here The token name is given as "lilketoToken" and symbol as "LILKE".

<img alt="12_Token_In_Metamask" src="https://github.com/keerthanchand/fractional-NFTs-smart-contract/blob/main/images/5_Deployed_contracts.png"  height="120">

* Smart contract for fractionalizing NFT is deployed 

<img alt="12_Token_In_Metamask" src="https://github.com/keerthanchand/fractional-NFTs-smart-contract/blob/main/images/6_Initial_NFT_Owner.png"  height="120">

* Currently the owner of NFT with id 1 is wallet's owner. This can be verified under OwnerOf function in deployed NFT smart contract.



<div style="display:"flex">
<img alt="12_Token_In_Metamask" src="https://github.com/keerthanchand/fractional-NFTs-smart-contract/blob/main/images/7_Approve_all.png"  height="120">
<img alt="12_Token_In_Metamask" src="https://github.com/keerthanchand/fractional-NFTs-smart-contract/blob/main/images/8_Grant_Permission_Payment.png"  height="450">
</div>

* Address of FNFT smart contract is passed into "setApprovalForAll" function under NFT smart contract to set FNFT smart contract as operator of NFT. 

<img alt="12_Token_In_Metamask" src="https://github.com/keerthanchand/fractional-NFTs-smart-contract/blob/main/images/9_FNFT_Init.png"  height="350">

* Under the "Initialize" function of FNFT, address of collection which is NFT's smart contract address, token id which we are going to fractionalize, total supply which is 18 decimal number and curator fee is provided. 

<img alt="12_Token_In_Metamask" src="https://github.com/keerthanchand/fractional-NFTs-smart-contract/blob/main/images/10_New_NFT_Owner.png"  height="120">

* After successful transaction, if we check owner of NFT using OwnerOf function we can see that the FNFT smart contract is the new owner.


<div style="display:"flex">
<img alt="12_Token_In_Metamask" src="https://github.com/keerthanchand/fractional-NFTs-smart-contract/blob/main/images/11_Token_Transafer_Etherscan.png"  height="350">
<img alt="12_Token_In_Metamask" src="https://github.com/keerthanchand/fractional-NFTs-smart-contract/blob/main/images/12_Token_In_Metamask.png"  height="350">
</div>

* 12 LilKeto Tokens are minted from FNFT smart contract and transfered into owners account.

<img alt="12_Token_In_Metamask" src="https://github.com/keerthanchand/fractional-NFTs-smart-contract/blob/main/images/curator_function.png"  height="120">

* This block explains how curator fee claim function works. As soon as the FNFT smart contract initializes lastClamed time is set to block's timestamp. when curator claims curator fee the function figures out the anual curator fee by multiplying number of tokens with given curator fee during initialization, then the claimable curator fee per second is calcuated by dividing anual curator fee with number of seconds in a year. As our smart contract knows the timestamp of last curator fee claim, it subtracts previous timestamp from current timestamp which leaves us with seconds between last curator fee claim and current curator claim. The difference is multiplied with curator fee per second and the result is minted and transfered to the curator. Finally last claim timestamp is set to block's timestamp.
