Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEDF752225
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 06:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfFYEhs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 00:37:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726697AbfFYEhs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 00:37:48 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P4X9AU108709
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 00:37:46 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tb9pye3ds-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 00:37:46 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Tue, 25 Jun 2019 05:37:44 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Jun 2019 05:37:41 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5P4beIQ42205414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 04:37:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C203C11C058;
        Tue, 25 Jun 2019 04:37:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90A8711C04C;
        Tue, 25 Jun 2019 04:37:39 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.87])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 04:37:39 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com
Subject: [RFCv3 8/8] powerpc: Set turbo domain to NUMA node for task packing
Date:   Tue, 25 Jun 2019 10:07:26 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625043726.21490-1-parth@linux.ibm.com>
References: <20190625043726.21490-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19062504-0016-0000-0000-0000028C1181
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062504-0017-0000-0000-000032E98142
Message-Id: <20190625043726.21490-9-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=919 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250036
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch provides an powerpc architecture specific implementation for
defining the turbo domain to make searching of the core to be bound within
the NUMA.  This provides a way to decrease the searching time for specific
architectures.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 arch/powerpc/include/asm/topology.h | 3 +++
 arch/powerpc/kernel/smp.c           | 5 +++++
 2 files changed, 8 insertions(+)

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
index 149a3fbf8ed3..856f7233190e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1200,6 +1200,11 @@ unsigned long powerpc_scale_core_capacity(int first_cpu,
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
-- 
2.17.1

