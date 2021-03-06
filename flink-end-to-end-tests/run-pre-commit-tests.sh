#!/usr/bin/env bash
################################################################################
#  Licensed to the Apache Software Foundation (ASF) under one
#  or more contributor license agreements.  See the NOTICE file
#  distributed with this work for additional information
#  regarding copyright ownership.  The ASF licenses this file
#  to you under the Apache License, Version 2.0 (the
#  "License"); you may not use this file except in compliance
#  with the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

END_TO_END_DIR="`dirname \"$0\"`" # relative
END_TO_END_DIR="`( cd \"$END_TO_END_DIR\" && pwd )`" # absolutized and normalized
if [ -z "$END_TO_END_DIR" ] ; then
    # error; for some reason, the path is not accessible
    # to the script (e.g. permissions re-evaled after suid)
    exit 1  # fail
fi

export END_TO_END_DIR

if [ -z "$FLINK_DIR" ] ; then
    echo "You have to export the Flink distribution directory as FLINK_DIR"
    exit 1
fi

source ${END_TO_END_DIR}/test-scripts/test-runner-common.sh

FLINK_DIR="`( cd \"$FLINK_DIR\" && pwd )`" # absolutized and normalized

echo "flink-end-to-end-test directory: $END_TO_END_DIR"
echo "Flink distribution directory: $FLINK_DIR"

# Template for adding a test:
# run_test "<description>" "$END_TO_END_DIR/test-scripts/<script_name>"

run_test "Batch Python Wordcount end-to-end test" "$END_TO_END_DIR/test-scripts/test_batch_python_wordcount.sh"
run_test "Streaming Python Wordcount end-to-end test" "$END_TO_END_DIR/test-scripts/test_streaming_python_wordcount.sh"
run_test "Wordcount end-to-end test" "$END_TO_END_DIR/test-scripts/test_batch_wordcount.sh"
run_test "Kafka end-to-end test" "$END_TO_END_DIR/test-scripts/test_streaming_kafka010.sh"
run_test "class loading end-to-end test" "$END_TO_END_DIR/test-scripts/test_streaming_classloader.sh"
run_test "Shaded Hadoop S3A end-to-end test" "$END_TO_END_DIR/test-scripts/test_shaded_hadoop_s3a.sh"
run_test "Shaded Presto S3 end-to-end test" "$END_TO_END_DIR/test-scripts/test_shaded_presto_s3.sh"
run_test "Hadoop-free Wordcount end-to-end test" "$END_TO_END_DIR/test-scripts/test_hadoop_free.sh"
run_test "Distributed cache end-to-end test" "$END_TO_END_DIR/test-scripts/test_streaming_distributed_cache_via_blob.sh"

printf "\n[PASS] All tests passed\n"
exit 0
