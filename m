Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676EC27CEA9
	for <lists+linux-pm@lfdr.de>; Tue, 29 Sep 2020 15:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgI2NLv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 09:11:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728566AbgI2NLu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2020 09:11:50 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TD3bDL095852;
        Tue, 29 Sep 2020 09:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=RG1Uv5STyr5XZTpnTxIdCgVPhqYsGIeVg/+pw1rRP0s=;
 b=Y8W7mO/P8lIb+sNsuBba+46UEz5kK9LSYw50K/SJJnQw7pm7I1Nqieqgk+zjDuJT/4Nd
 KMIn7HZPY7P5uUB9hlqGoXIEGtql4P8fVDgQmAnKDqzihh0+XwErVsmQwt3aIKhJwc94
 lfHPmDEJWcMxGUibPSjPgA+zTVG3FkSoUNcw1wq1ohAKHx20F+UcNrQgFU+Uz61IYruU
 s8ubLEQ98rOxx/hB7X0Z6u2GCSjNMyxMih5/oc6isniUootLB+GxdYAqiP2sPCcrxORc
 hYaWUjTUc4GyBzJbUQhClopT1FyHtE5zkeyfSI/ztWHsK60zgCe6SxK+3MJn1a3rdbhK qQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33v4w02095-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 09:11:43 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08TD7cZk014352;
        Tue, 29 Sep 2020 13:11:41 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 33sw983b1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 13:11:41 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08TDBdMk36110786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 13:11:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1B384C050;
        Tue, 29 Sep 2020 13:11:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2235E4C052;
        Tue, 29 Sep 2020 13:11:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.233.44])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Sep 2020 13:11:36 +0000 (GMT)
From:   Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
To:     shuah@kernel.org, trenn@suse.com
Cc:     latha@linux.vnet.ibm.com, Janakarajan.Natarajan@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Pavithra R . Prakash" <pavrampu@in.ibm.com>
Subject: [PATCH v2] cpupower: Provide online and offline CPU information
Date:   Tue, 29 Sep 2020 18:41:08 +0530
Message-Id: <20200929131108.19435-1-latha@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_04:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 suspectscore=2 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290114
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When a user tries to modify cpuidle or cpufreq properties on offline
CPUs, the tool returns success (exit status 0) but also does not provide
any warning message regarding offline cpus that may have been specified
but left unchanged. In case of all or a few CPUs being offline, it can be
difficult to keep track of which CPUs didn't get the new frequency or idle
state set. Silent failures are difficult to keep track of when there are a
huge number of CPUs on which the action is performed.

This patch adds helper functions to find both online and offline CPUs and
print them out accordingly.

We use these helper functions in cpuidle-set and cpufreq-set to print an
additional message if the user attempts to modify offline cpus.

Reported-by: Pavithra R. Prakash <pavrampu@in.ibm.com>
Signed-off-by: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
---
 tools/power/cpupower/utils/cpufreq-set.c     |  3 +
 tools/power/cpupower/utils/cpuidle-set.c     |  4 ++
 tools/power/cpupower/utils/cpupower.c        |  8 +++
 tools/power/cpupower/utils/helpers/helpers.h | 12 ++++
 tools/power/cpupower/utils/helpers/misc.c    | 66 +++++++++++++++++++-
 5 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index 6ed82fba5aaa..f25cdfa05c5f 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -311,6 +311,7 @@ int cmd_freq_set(int argc, char **argv)
 		}
 	}
 
+	get_cpustate();
 
 	/* loop over CPUs */
 	for (cpu = bitmask_first(cpus_chosen);
@@ -328,5 +329,7 @@ int cmd_freq_set(int argc, char **argv)
 		}
 	}
 
+	print_offline_cpus();
+
 	return 0;
 }
diff --git a/tools/power/cpupower/utils/cpuidle-set.c b/tools/power/cpupower/utils/cpuidle-set.c
index 569f268f4c7f..46158928f9ad 100644
--- a/tools/power/cpupower/utils/cpuidle-set.c
+++ b/tools/power/cpupower/utils/cpuidle-set.c
@@ -95,6 +95,8 @@ int cmd_idle_set(int argc, char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	get_cpustate();
+
 	/* Default is: set all CPUs */
 	if (bitmask_isallclear(cpus_chosen))
 		bitmask_setall(cpus_chosen);
@@ -181,5 +183,7 @@ int cmd_idle_set(int argc, char **argv)
 			break;
 		}
 	}
+
+	print_offline_cpus();
 	return EXIT_SUCCESS;
 }
diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
index 8e3d08042825..8ac3304a9957 100644
--- a/tools/power/cpupower/utils/cpupower.c
+++ b/tools/power/cpupower/utils/cpupower.c
@@ -34,6 +34,8 @@ int run_as_root;
 int base_cpu;
 /* Affected cpus chosen by -c/--cpu param */
 struct bitmask *cpus_chosen;
+struct bitmask *online_cpus;
+struct bitmask *offline_cpus;
 
 #ifdef DEBUG
 int be_verbose;
@@ -178,6 +180,8 @@ int main(int argc, const char *argv[])
 	char pathname[32];
 
 	cpus_chosen = bitmask_alloc(sysconf(_SC_NPROCESSORS_CONF));
+	online_cpus = bitmask_alloc(sysconf(_SC_NPROCESSORS_CONF));
+	offline_cpus = bitmask_alloc(sysconf(_SC_NPROCESSORS_CONF));
 
 	argc--;
 	argv += 1;
@@ -230,6 +234,10 @@ int main(int argc, const char *argv[])
 		ret = p->main(argc, argv);
 		if (cpus_chosen)
 			bitmask_free(cpus_chosen);
+		if (online_cpus)
+			bitmask_free(online_cpus);
+		if (offline_cpus)
+			bitmask_free(offline_cpus);
 		return ret;
 	}
 	print_help();
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index c258eeccd05f..88ab1bda7ba4 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -94,6 +94,8 @@ struct cpupower_cpu_info {
  */
 extern int get_cpu_info(struct cpupower_cpu_info *cpu_info);
 extern struct cpupower_cpu_info cpupower_cpu_info;
+
+
 /* cpuid and cpuinfo helpers  **************************/
 
 /* X86 ONLY ****************************************/
@@ -171,4 +173,14 @@ static inline unsigned int cpuid_ecx(unsigned int op) { return 0; };
 static inline unsigned int cpuid_edx(unsigned int op) { return 0; };
 #endif /* defined(__i386__) || defined(__x86_64__) */
 
+/*
+ * CPU State related functions
+ */
+extern struct bitmask *online_cpus;
+extern struct bitmask *offline_cpus;
+
+void get_cpustate(void);
+void get_cpustate(void);
+void get_cpustate(void);
+
 #endif /* __CPUPOWERUTILS_HELPERS__ */
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index f406adc40bad..2ead98169cf5 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -1,8 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#if defined(__i386__) || defined(__x86_64__)
+
+#include <stdio.h>
+#include <stdlib.h>
 
 #include "helpers/helpers.h"
 
+#if defined(__i386__) || defined(__x86_64__)
+
 #define MSR_AMD_HWCR	0xc0010015
 
 int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
@@ -41,3 +45,63 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 	return 0;
 }
 #endif /* #if defined(__i386__) || defined(__x86_64__) */
+
+/* get_cpustate
+ *
+ * Gather the information of all online CPUs into bitmask struct
+ */
+void get_cpustate(void)
+{
+	unsigned int cpu = 0;
+
+	bitmask_clearall(online_cpus);
+	bitmask_clearall(offline_cpus);
+
+	for (cpu = bitmask_first(cpus_chosen);
+		cpu <= bitmask_last(cpus_chosen); cpu++) {
+
+		if (cpupower_is_cpu_online(cpu) == 1)
+			bitmask_setbit(online_cpus, cpu);
+		else
+			bitmask_setbit(offline_cpus, cpu);
+
+		continue;
+	}
+}
+
+/* print_online_cpus
+ *
+ * Print the CPU numbers of all CPUs that are online currently
+ */
+void print_online_cpus(void)
+{
+	int str_len = 0;
+	char *online_cpus_str = NULL;
+
+	str_len = online_cpus->size * 5;
+	online_cpus_str = (void *)malloc(sizeof(char) * str_len);
+
+	if (!bitmask_isallclear(online_cpus)) {
+		bitmask_displaylist(online_cpus_str, str_len, online_cpus);
+		printf(_("Following CPUs are online:\n%s\n"), online_cpus_str);
+	}
+}
+
+/* print_offline_cpus
+ *
+ * Print the CPU numbers of all CPUs that are offline currently
+ */
+void print_offline_cpus(void)
+{
+	int str_len = 0;
+	char *offline_cpus_str = NULL;
+
+	str_len = offline_cpus->size * 5;
+	offline_cpus_str = (void *)malloc(sizeof(char) * str_len);
+
+	if (!bitmask_isallclear(offline_cpus)) {
+		bitmask_displaylist(offline_cpus_str, str_len, offline_cpus);
+		printf(_("Following CPUs are offline:\n%s\n"), offline_cpus_str);
+		printf(_("cpupower set operation was not performed on them\n"));
+	}
+}
-- 
2.24.3 (Apple Git-128)

