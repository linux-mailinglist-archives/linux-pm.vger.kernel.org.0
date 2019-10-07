Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAC8CDD5E
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2019 10:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfJGIbT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Oct 2019 04:31:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727587AbfJGIbT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Oct 2019 04:31:19 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x978SM35100554
        for <linux-pm@vger.kernel.org>; Mon, 7 Oct 2019 04:31:18 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vg097tx49-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 07 Oct 2019 04:31:17 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 7 Oct 2019 09:31:15 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 7 Oct 2019 09:31:11 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x978VAbY40239290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Oct 2019 08:31:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E54A211C050;
        Mon,  7 Oct 2019 08:31:09 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2C6111C054;
        Mon,  7 Oct 2019 08:31:07 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.220])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Oct 2019 08:31:07 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, pavel@ucw.cz, dsmythies@telus.net,
        quentin.perret@arm.com, rafael.j.wysocki@intel.com,
        tim.c.chen@linux.intel.com, daniel.lezcano@linaro.org
Subject: [RFC v5 6/6] powerpc: Set turbo domain to NUMA node for task packing
Date:   Mon,  7 Oct 2019 14:00:51 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007083051.4820-1-parth@linux.ibm.com>
References: <20191007083051.4820-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19100708-0028-0000-0000-000003A6BE4F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100708-0029-0000-0000-00002468CDD2
Message-Id: <20191007083051.4820-7-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910070088
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Provide an powerpc architecture specific implementation for defining the
turbo domain to make searching of the core to be bound within the NUMA.

The POWER9 systems have a pair of cores in the LLC domain. Hence to make
TurboSched more effective, increase the domain space for task packing
to search within NUMA domain.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 arch/powerpc/include/asm/topology.h | 3 +++
 arch/powerpc/kernel/smp.c           | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index f85e2b01c3df..b2493bb11653 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -132,6 +132,9 @@ static inline void shared_proc_topology_init(void) {}
 #define topology_sibling_cpumask(cpu)	(per_cpu(cpu_sibling_map, cpu))
 #define topology_core_cpumask(cpu)	(per_cpu(cpu_core_map, cpu))
 #define topology_core_id(cpu)		(cpu_to_core_id(cpu))
+#define arch_turbo_domain		powerpc_turbo_domain
+
+struct cpumask *powerpc_turbo_domain(int cpu);
 
 int dlpar_cpu_readd(int cpu);
 #endif
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index ea6adbf6a221..0fc4443a3f27 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1169,6 +1169,13 @@ static void remove_cpu_from_masks(int cpu)
 }
 #endif
 
+#ifdef CONFIG_SCHED_SMT
+inline struct cpumask *powerpc_turbo_domain(int cpu)
+{
+	return cpumask_of_node(cpu_to_node(cpu));
+}
+#endif
+
 static inline void add_cpu_to_smallcore_masks(int cpu)
 {
 	struct cpumask *this_l1_cache_map = per_cpu(cpu_l1_cache_map, cpu);
-- 
2.17.1

