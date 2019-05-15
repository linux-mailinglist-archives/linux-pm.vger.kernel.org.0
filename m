Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0D21F605
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 15:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfEONyA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 09:54:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728030AbfEONx7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 09:53:59 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4FDqusH123679
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 09:53:58 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sgjv0csjd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 09:53:57 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Wed, 15 May 2019 14:53:55 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 May 2019 14:53:51 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4FDroQ025100530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 13:53:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C32252050;
        Wed, 15 May 2019 13:53:50 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.102.18.182])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 79C345204F;
        Wed, 15 May 2019 13:53:48 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        dsmythies@telus.net
Subject: [RFCv2 6/6] sched/fair: Bound non idle core search by DIE domain
Date:   Wed, 15 May 2019 19:23:22 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190515135322.19393-1-parth@linux.ibm.com>
References: <20190515135322.19393-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19051513-0020-0000-0000-0000033CFCA2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051513-0021-0000-0000-0000218FBF30
Message-Id: <20190515135322.19393-7-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905150087
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch specifies the sched domain to search for a non idle core.

The select_non_idle_core searches for the non idle cores across whole
system. But in the systems with multiple NUMA domains, the Turbo frequency
can be sustained within the NUMA domain without being affected from other
NUMA.

This patch provides an architecture specific implementation for defining
the turbo domain to make searching of the core to be bound within the NUMA.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 arch/powerpc/include/asm/topology.h |  3 +++
 arch/powerpc/kernel/smp.c           |  5 +++++
 kernel/sched/fair.c                 | 10 +++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 1c777ee67180..410b94c9e1a2 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -133,10 +133,13 @@ static inline void shared_proc_topology_init(void) {}
 #define topology_core_cpumask(cpu)	(per_cpu(cpu_core_map, cpu))
 #define topology_core_id(cpu)		(cpu_to_core_id(cpu))
 #define arch_scale_core_capacity	powerpc_scale_core_capacity
+#define arch_turbo_domain		powerpc_turbo_domain
 
 unsigned long powerpc_scale_core_capacity(int first_smt,
 					  unsigned long smt_cap);
 
+struct cpumask *powerpc_turbo_domain(int cpu);
+
 int dlpar_cpu_readd(int cpu);
 #endif
 #endif
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 256ab2a50f6e..e13ba3981891 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1203,6 +1203,11 @@ inline unsigned long powerpc_scale_core_capacity(int first_cpu,
 	/* Scale core capacity based on smt mode */
 	return smt_mode == 1 ? cap : ((cap * smt_mode) >> 3) + cap;
 }
+
+inline struct cpumask *powerpc_turbo_domain(int cpu)
+{
+	return cpumask_of_node(cpu_to_node(cpu));
+}
 #endif
 
 static inline void add_cpu_to_smallcore_masks(int cpu)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d2d556eb6d0f..bd9985775db4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6260,6 +6260,13 @@ static inline bool core_underutilized(unsigned long core_util,
 	return core_util < (core_capacity >> 3);
 }
 
+#ifndef arch_turbo_domain
+static __always_inline struct cpumask *arch_turbo_domain(int cpu)
+{
+	return sched_domain_span(rcu_dereference(per_cpu(sd_llc, cpu)));
+}
+#endif
+
 /*
  * Try to find a non idle core in the system  with spare capacity
  * available for task packing, thereby keeping minimal cores active.
@@ -6270,7 +6277,8 @@ static int select_non_idle_core(struct task_struct *p, int prev_cpu)
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(turbo_sched_mask);
 	int iter_cpu, sibling;
 
-	cpumask_and(cpus, cpu_online_mask, &p->cpus_allowed);
+	cpumask_and(cpus, cpu_online_mask, arch_turbo_domain(prev_cpu));
+	cpumask_and(cpus, cpus, &p->cpus_allowed);
 
 	for_each_cpu_wrap(iter_cpu, cpus, prev_cpu) {
 		unsigned long core_util = 0;
-- 
2.17.1

