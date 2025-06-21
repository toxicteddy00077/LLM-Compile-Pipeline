# LLM-Compile-Pipeline
Hosting : https://huggingface.co/spaces/4skin/MLIR-Test

Model(Huggingface): https://huggingface.co/4skin/test1

A small compilation pipeline made for LLVM infrastructure family of languages. It is primarily for performing high level passes on Multi-Level IR representation by utilising a finetuned Llama-3B model to predicting the passes for dialect lowering. The perfocmance gains currently have not been, massive as the model is currently only able to predict passes for code following standard programming models for the respective language.

![screenshot](https://github.com/toxicteddy00077/LLM-Compile-Pipeline/blob/main/assets/Screenshot%20from%202025-06-20%2022-43-04.png)

*left : standard exectution   |     right : LLM optmized execution*

## Execution:
![screenshot](https://github.com/toxicteddy00077/LLM-Compile-Pipeline/blob/main/assets/flowchart.png) 

## Background:
Currently there havent been many improvments in compiler insfrastructure for code optmization. LLVM based compiler still rely heavily on heurisitcs and langauegs like C, C++ whihc are directly are converted to IR, are unable to be optmized at a higher logical level. This is where MLIR and LLMs come into play. Multi-Level intermediate representation allows capturing high level code logic in dialects, which may be lost when code is lowered direclty to IR. During this lowering a finetuned LLM can deteermine the most optimal pass based on the MLIR code, and thus lower it with Loop, Memory or domain specific optimization. This is then convert back to IR and fianlly a binary executbale. 

By doing this we no longer need to rely on heuristics or guessing for optmization, and in the near future, a lightweingt LLM may replace these heuristics.  
