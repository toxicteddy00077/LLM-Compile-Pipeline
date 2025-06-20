#!/usr/bin/env bash
set -euo pipefail

# Config
C_FILE="${1:-example.c}"
SPACE_URL="https://4skin-mlir-test.hf.space/generate"

# Compile C -> LLVM IR
echo "Generating LLVM IR "
clang -S -emit-llvm "${C_FILE}" -o input.ll

# LLVM IR -> MLIR
echo "Translating to MLIR"
mlir-translate --import-llvm input.ll -o input.mlir

echo "[3/8] Extracting function definitions..."
sed -n '/func.func/,/^}$/p' input.mlir > func_only.mlir

# basic optmization passes
echo "Applying MLIR canonical and CSE"
mlir-opt func_only.mlir \
  --canonicalize \
  --cse \
  --loop-invariant-code-motion \
  --mem2reg \
  --remove-dead-values \
  --simplify-mir \
  -o optimized_initial.mlir

# Send request to LLM for further passes
MLIR_SNIPPET=$(awk 'NR<=2000' optimized_initial.mlir)
JSON=$( jq -n --arg p "Given this MLIR:\n${MLIR_SNIPPET}\nOnly return valid MLIR optimization passes without explanation." '{prompt:$p}' )
PASS_LIST=$(curl -s -X POST "${SPACE_URL}" \
  -H "Content-Type: application/json" \
  -d "${JSON}" | jq -r '.response')

echo "[+] Received passes: ${PASS_LIST}"

# apply passes
echo "Applying LLM-suggested optimization passes"
mlir-opt optimized_initial.mlir ${PASS_LIST} -o optimized_llm.mlir

# dialect lowering
echo "Converting to LLVM dialect"
mlir-opt optimized_llm.mlir \
  --canonicalize --cse \
  --convert-to-llvm \
  -o lowered.mlir

# back to LLVM IR
mlir-translate --mlir-to-llvmir lowered.mlir -o output.ll

# compile and test runtime
clang output.ll -O3 -o final_exec

echo "performance test"
/usr/bin/time -v ./final_exec


