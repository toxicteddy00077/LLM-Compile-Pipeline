# LLM-Compile-Pipeline
Hosting : https://huggingface.co/spaces/4skin/MLIR-Test

Model(Huggingface): https://huggingface.co/4skin/test1

A small compilation pipeline made for LLVM infrastructure family of languages. It is primarily for performing high level passes on Multi-Level IR representation by utilising a finetuned Llama-3B model to predicting the passes for dialect lowering. The perfocmance gains currently have not been, massive as the model is currently only able to predict passes for code following standard programming models for the respective language.

![screenshot](https://github.com/toxicteddy00077/LLM-Compile-Pipeline/blob/main/assets/Screenshot%20from%202025-06-20%2022-43-04.png)

*left : standard exectution   |     right : LLM optmized execution*

## Execution:
![screenshot]() 

## Pipeline:

