#!/usr/bin/env sh
#MIMA=<pfad zur mima.jar>

trap "exit" SIGINT

doTest() {
  let "inputA = $1"
  let "inputB = $2"
  let "result = ( inputA < inputB ) "
  echo "test ${inputA} < ${inputB}? => ${result}"
  
  if java -jar "${MIMA}" -run -set a=${inputA} -set b=${inputB} -test x=${result} ../aufgabe71b.mima >/dev/null; then
     echo "...Pass"
  else
    echo "Failed: ${input}"
  fi
}

# 0 < MAX_POSITIVE?
doTest 0 0x7fffff
# MAX_POSTIVE < MAX_POSITIVE?
doTest 0x7fffff 0x7fffff
# MAX_POSITIVE-1 < MAX_POSITIVE?
doTest 0x7ffffe 0x7fffff

# MAX_POSITIVE < 0?
doTest 0x7fffff 0
# MAX_POSITIVE < MAX_POSITIVE-1?
doTest 0x7fffff 0x7ffffe

doTest -1 -1
doTest -1 0
doTest -1 1
doTest 0 -1
doTest 0 0
doTest 0 1
doTest 1 -1
doTest 1 0
doTest 1 1

doTest 0x800000 0

echo "now loop"

let "max = 0x7fffff"
i=0
while [ $i -lt ${max} ]; do
  doTest 0 $i
  let "i = i + 1000"
done

#for (( i = 0; i < 5; i++ )); do
#  for (( j = 0; j < 15; j++ )); do
#    doTest $i $j
#  done
#done
