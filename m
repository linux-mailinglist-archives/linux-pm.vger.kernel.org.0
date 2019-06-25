Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC25D5222B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 06:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfFYEhn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 00:37:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726941AbfFYEhm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 00:37:42 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P4Xkad107194
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 00:37:42 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tbafbc0f3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 00:37:41 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Tue, 25 Jun 2019 05:37:39 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Jun 2019 05:37:37 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5P4baEe54329510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 04:37:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CEA611C052;
        Tue, 25 Jun 2019 04:37:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C47E11C050;
        Tue, 25 Jun 2019 04:37:35 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.87])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 04:37:34 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com
Subject: [RFCv3 5/8] powerpc: Define Core Capacity for POWER systems
Date:   Tue, 25 Jun 2019 10:07:23 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625043726.21490-1-parth@linux.ibm.com>
References: <20190625043726.21490-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19062504-0020-0000-0000-0000034D1730
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062504-0021-0000-0000-000021A0843D
Message-Id: <20190625043726.21490-6-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250036
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch tunes arch_scale_core_capacity for powerpc arch by scaling
capacity w.r.t to the number of online SMT in the core such that for SMT-4,
core capacity is 1.5x the capacity of sibling thread.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 arch/powerpc/include/asm/topology.h |  4 ++++
 arch/powerpc/kernel/smp.c           | 33 +++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index f85e2b01c3df..1c777ee67180 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -132,6 +132,10 @@ static inline void shared_proc_topology_init(void) {}
 #define topology_sibling_cpumask(cpu)	(per_cpu(cpu_sibling_map, cpu))
 #define topology_core_cpumask(cpu)	(per_cpu(cpu_core_map, cpu))
 #define topology_core_id(cpu)		(cpu_to_core_id(cpu))
+#define arch_scale_core_capacity	powerpc_scale_core_capacity
+
+unsigned long powerpc_scale_core_capacity(int first_smt,
+					  unsigned long smt_cap);
 
 int dlpar_cpu_readd(int cpu);
 #endif
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index ea6adbf6a221..149a3fbf8ed3 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1169,6 +1169,39 @@ static void remove_cpu_from_masks(int cpu)
 }
 #endif
 
+#ifdef CONFIG_SCHED_SMT
+/*
+ * Calculate capacity of a core based on the active threads in the core
+ * Scale the capacity of first SM-thread based on total number of
+ * active threads in the respective smt_mask.
+ *
+ * The scaling is done such that for
+ * SMT-4, core_capacity = 1.5x first_cpu_capacity
+ * and for SMT-8, core_capacity multiplication factor is 2x
+ *
+ * So, core_capacity multiplication factor = (1 + smt_mode*0.125)
+ *
+ * @first_cpu: First/any CPU id in the core
+ * @cap: Capacity of the first_cpu
+ */
+unsigned long powerpc_scale_core_capacity(int first_cpu,
+					  unsigned long cap)
+{
+	struct cpumask select_idles;
+	struct cpumask *cpus = &select_idles;
+	int cpu, smt_mode = 0;
+
+	cpumask_and(cpus, cpu_smt_mask(first_cpu), cpu_online_mask);
+
+	/* Find SMT mode from active SM-threads */
+	for_each_cpu(cpu, cpus)
+		smt_mode++;
+
+	/* Scale core capacity based on smt mode */
+	return smt_mode == 1 ? cap : ((cap * smt_mode) >> 3) + cap;
+}
+#endif
+
 static inline void add_cpu_to_smallcore_masks(int cpu)
 {
 	struct cpumask *this_l1_cache_map = per_cpu(cpu_l1_cache_map, cpu);
-- 
2.17.1

