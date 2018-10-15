use ${dbName};

set hive.execution.engine=tez;
set hive.vectorized.execution.enabled = true;
set hive.vectorized.execution.reduce.enabled = true;
set hive.vectorized.execution.reduce.groupby.enabled = true;
set hive.optimize.index.filter=true;
set hive.fetch.task.conversion=more;
set hive.exec.parallel=true;
set hive.cbo.enable=true;
set hive.compute.query.using.stats=true;
set hive.stats.fetch.column.stats=true;
set hive.stats.fetch.partition.stats=true;
set hive.tez.container.size=2048;
set hive.auto.convert.join.noconditionaltask.size=3000;



INSERT OVERWRITE DIRECTORY "${outputDir}" ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' select Applicable_Manufacturer_or_Applicable_GPO_Making_Payment_Name,Physician_Specialty,sum(Total_Amount_of_Payment_USDollars) as total_investment from gnrl_pay_orc_test group by Applicable_Manufacturer_or_Applicable_GPO_Making_Payment_Name,Physician_Specialty;

dfs -mv hdfs://jana-hadoop-mgr-1.node.dc1.pnda.local:8020/user/pnda/sujoy_hive_oozie_app/output_data/000000_0 hdfs://jana-hadoop-mgr-1.node.dc1.pnda.local:8020/user/pnda/sujoy_hive_oozie_app/result_data/q1.csv

