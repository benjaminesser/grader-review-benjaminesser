CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

if [[ -f 'student-submission/ListExamples.java' ]]
then
    echo 'ListExamples.java submitted'
else
    echo 'ListExamples.java not submitted'
    exit 1
fi

cp student-submission/ListExamples.java ListExamples.java

javac -cp $CPATH ListExamples.java TestListExamples.java
if [[ $? > 0 ]]
then
    echo "Compile error"
    exit 1
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > test-output.txt
if grep -q "failure" test-output.txt
then
    echo "Fail!"
else
    echo "Pass!"
fi

