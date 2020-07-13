Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9762521D0FC
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 09:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgGMH5D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 03:57:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9092 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725818AbgGMH5C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 03:57:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06D757K7081399;
        Mon, 13 Jul 2020 03:56:57 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3279a9u8e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 03:56:56 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06D7tM6T005302;
        Mon, 13 Jul 2020 07:56:55 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 327527syan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 07:56:55 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06D7uqqp59244560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jul 2020 07:56:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2B2952057;
        Mon, 13 Jul 2020 07:56:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.53.244])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 935C25204F;
        Mon, 13 Jul 2020 07:56:51 +0000 (GMT)
From:   latha@linux.vnet.ibm.com
To:     trenn@suse.com, shuah@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
Subject: [PATCH] cpupower: Provide offline CPU information for cpuidle-set and cpufreq-set options
Date:   Mon, 13 Jul 2020 13:26:47 +0530
Message-Id: <20200713075647.70036-1-latha@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_04:2020-07-10,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=2
 clxscore=1011 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130053
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>

When a user tries to modify cpuidle or cpufreq properties on offline
CPUs, the tool returns success (exit status 0) but also does not provide
any warning message regarding offline cpus that may have been specified
but left unchanged. In case of all or a few CPUs being offline, it can be
difficult to keep track of which CPUs didn't get the new frequency or idle
state set. Silent failures are difficult to keep track of when there are a
huge number of CPUs on which the action is performed.

This patch adds an additional message if the user attempts to modify
offline cpus.

Reported-by: Pavithra R. Prakash <pavrampu@in.ibm.com>
Signed-off-by: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
---
 tools/power/cpupower/utils/cpufreq-set.c | 24 ++++++++++++++++++++++--
 tools/power/cpupower/utils/cpuidle-set.c | 21 ++++++++++++++++++++-
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index 6ed82fba5aaa..87031120582a 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -195,10 +195,14 @@ int cmd_freq_set(int argc, char **argv)
 	extern int optind, opterr, optopt;
 	int ret = 0, cont = 1;
 	int double_parm = 0, related = 0, policychange = 0;
+	int str_len = 0;
 	unsigned long freq = 0;
 	char gov[20];
+	char *offline_cpus_str = NULL;
 	unsigned int cpu;
 
+	struct bitmask *offline_cpus = NULL;
+
 	struct cpufreq_policy new_pol = {
 		.min = 0,
 		.max = 0,
@@ -311,14 +315,21 @@ int cmd_freq_set(int argc, char **argv)
 		}
 	}
 
+	offline_cpus = bitmask_alloc(sysconf(_SC_NPROCESSORS_CONF));
+	str_len = sysconf(_SC_NPROCESSORS_CONF) * 5;
+	offline_cpus_str = malloc(sizeof(char) * str_len);
 
 	/* loop over CPUs */
 	for (cpu = bitmask_first(cpus_chosen);
 	     cpu <= bitmask_last(cpus_chosen); cpu++) {
 
-		if (!bitmask_isbitset(cpus_chosen, cpu) ||
-		    cpupower_is_cpu_online(cpu) != 1)
+		if (!bitmask_isbitset(cpus_chosen, cpu))
+			continue;
+
+		if (cpupower_is_cpu_online(cpu) != 1) {
+			bitmask_setbit(offline_cpus, cpu);
 			continue;
+		}
 
 		printf(_("Setting cpu: %d\n"), cpu);
 		ret = do_one_cpu(cpu, &new_pol, freq, policychange);
@@ -328,5 +339,14 @@ int cmd_freq_set(int argc, char **argv)
 		}
 	}
 
+	if (!bitmask_isallclear(offline_cpus)) {
+		bitmask_displaylist(offline_cpus_str, str_len, offline_cpus);
+		printf(_("Following CPUs are offline:\n%s\n"),
+			 offline_cpus_str);
+		printf(_("cpupower set operation was not performed on them\n"));
+	}
+	free(offline_cpus_str);
+	bitmask_free(offline_cpus);
+
 	return 0;
 }
diff --git a/tools/power/cpupower/utils/cpuidle-set.c b/tools/power/cpupower/utils/cpuidle-set.c
index 569f268f4c7f..adf6543fd3d6 100644
--- a/tools/power/cpupower/utils/cpuidle-set.c
+++ b/tools/power/cpupower/utils/cpuidle-set.c
@@ -27,9 +27,12 @@ int cmd_idle_set(int argc, char **argv)
 	extern char *optarg;
 	extern int optind, opterr, optopt;
 	int ret = 0, cont = 1, param = 0, disabled;
+	int str_len = 0;
 	unsigned long long latency = 0, state_latency;
 	unsigned int cpu = 0, idlestate = 0, idlestates = 0;
 	char *endptr;
+	char *offline_cpus_str = NULL;
+	struct bitmask *offline_cpus = NULL;
 
 	do {
 		ret = getopt_long(argc, argv, "d:e:ED:", info_opts, NULL);
@@ -99,14 +102,20 @@ int cmd_idle_set(int argc, char **argv)
 	if (bitmask_isallclear(cpus_chosen))
 		bitmask_setall(cpus_chosen);
 
+	offline_cpus = bitmask_alloc(sysconf(_SC_NPROCESSORS_CONF));
+	str_len = sysconf(_SC_NPROCESSORS_CONF) * 5;
+	offline_cpus_str = (void *)malloc(sizeof(char) * str_len);
+
 	for (cpu = bitmask_first(cpus_chosen);
 	     cpu <= bitmask_last(cpus_chosen); cpu++) {
 
 		if (!bitmask_isbitset(cpus_chosen, cpu))
 			continue;
 
-		if (cpupower_is_cpu_online(cpu) != 1)
+		if (cpupower_is_cpu_online(cpu) != 1) {
+			bitmask_setbit(offline_cpus, cpu);
 			continue;
+		}
 
 		idlestates = cpuidle_state_count(cpu);
 		if (idlestates <= 0)
@@ -181,5 +190,15 @@ int cmd_idle_set(int argc, char **argv)
 			break;
 		}
 	}
+
+	if (!bitmask_isallclear(offline_cpus)) {
+		bitmask_displaylist(offline_cpus_str, str_len, offline_cpus);
+		printf(_("Following CPUs are offline:\n%s\n"),
+			 offline_cpus_str);
+		printf(_("CPU idle operation was not performed on them\n"));
+	}
+	free(offline_cpus_str);
+	bitmask_free(offline_cpus);
+
 	return EXIT_SUCCESS;
 }
-- 
2.19.1

