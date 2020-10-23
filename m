Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE048297231
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 17:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465720AbgJWPZt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 11:25:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13202 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S462034AbgJWPZt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 11:25:49 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09NF80Up173997;
        Fri, 23 Oct 2020 11:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=4Oa+MQeYoCD5dtHPc4P27y5/l9DQ48/TR9kQHv0a+I0=;
 b=CaAVifl9EWUfFA4Pj8R7NdQa7fuXgRoZmUut6qsvO81ugnq9kXxb2hgudoJDtaDhukjV
 3mhRspxql6gmVDHM1lH4w/gFAjiwHWADQuBtD4Wa12ifv3+7QclmsFVlglQCay02bo8t
 ZN2nDDn7kHXNht5ZrMhSr0VaYhl8NQ8qctLRpw4xqKg0wB6QUBCs/cF60JgSYSqOmufZ
 ITlgs5LrldkAQiKrGiqcAPOTAaMV9zU2RmOUTEjXsY0n6u2Q0xXubxSbCg56k46eF+w7
 /9MLXSdZn9+izzae51ZO/gGcVGIwXvPHAoiFkBQDHp9ewnv8/4+9u+FAU5k0PcIGDO0m Yw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34byj04ret-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Oct 2020 11:25:42 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09NF6u3E022838;
        Fri, 23 Oct 2020 15:25:40 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 347r883gct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Oct 2020 15:25:40 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09NFPcks33030600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Oct 2020 15:25:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AE744C05A;
        Fri, 23 Oct 2020 15:25:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEDD54C050;
        Fri, 23 Oct 2020 15:25:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.244.89])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 23 Oct 2020 15:25:36 +0000 (GMT)
From:   Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
To:     shuah@kernel.org, trenn@suse.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        latha@linux.vnet.ibm.com,
        "Pavithra R . Prakash" <pavrampu@in.ibm.com>
Subject: [PATCH v4] cpupower: Provide online and offline CPU information
Date:   Fri, 23 Oct 2020 20:55:27 +0530
Message-Id: <20201023152527.15884-1-latha@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-23_07:2020-10-23,2020-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=2
 mlxlogscore=999 adultscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010230103
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

v1-->v2: Added helper functions to find online and offline CPUs and print them.
v2-->v3: Fixed some build issues
v3-->v4: Fixed the commit log and moved the version summary to the correct place. 

diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index 7b2164e07057..c5e60a39cfa6 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -315,6 +315,7 @@ int cmd_freq_set(int argc, char **argv)
 		}
 	}
 
+	get_cpustate();
 
 	/* loop over CPUs */
 	for (cpu = bitmask_first(cpus_chosen);
@@ -332,5 +333,7 @@ int cmd_freq_set(int argc, char **argv)
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
index c258eeccd05f..d5799aa71e1f 100644
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
+void print_online_cpus(void);
+void print_offline_cpus(void);
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

