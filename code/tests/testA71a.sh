#!/usr/bin/env sh
#MIMA=<pfad zur mima.jar>

doTest() {
  let "input = $1"
  let "result = ( ( input << 1 ) & 0xffffff ) + ( ( input >> 23 ) & 0x1 ) "
  echo "test ${input} => ${result} ?"
  
  if java -jar "${MIMA}" -run -set x=${input} -test x=${result} ../aufgabe71a.mima >/dev/null; then
     echo "...Pass"
  else
    echo "Failed: ${input}"
  fi
}

for (( i = 0; i < 0xffffff; i++ )); do
  doTest $i
done

