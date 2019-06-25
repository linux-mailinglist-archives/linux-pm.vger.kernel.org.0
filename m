Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9466852226
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 06:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfFYEh4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 00:37:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41380 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727060AbfFYEhr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 00:37:47 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P4X87k108583
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 00:37:46 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tb9pye3dm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 00:37:46 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Tue, 25 Jun 2019 05:37:44 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Jun 2019 05:37:40 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5P4bdxY49676486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 04:37:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49A0C11C050;
        Tue, 25 Jun 2019 04:37:39 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1826C11C04C;
        Tue, 25 Jun 2019 04:37:38 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.87])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 04:37:37 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com
Subject: [RFCv3 7/8] sched/fair: Bound non idle core search within LLC domain
Date:   Tue, 25 Jun 2019 10:07:25 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625043726.21490-1-parth@linux.ibm.com>
References: <20190625043726.21490-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19062504-0016-0000-0000-0000028C1180
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062504-0017-0000-0000-000032E98141
Message-Id: <20190625043726.21490-8-parth@linux.ibm.com>
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

This patch specifies the method which returns sched domain to limit the
search for a non idle core. By default, limit the search in LLC domain
which usually includes all the cores across the system.

The select_non_idle_core searches for the non idle cores across whole
system. But in the systems with multiple NUMA domains, the Turbo frequency
can be sustained within the NUMA domain without being affected from other
NUMA. For such case, arch_turbo_domain can be tuned to change domain for
non idle core search.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/fair.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9d11631ce18c..b049c9d73f1d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5973,6 +5973,13 @@ static inline bool core_underutilized(unsigned long core_util,
 	return core_util < (core_capacity >> UNDERUTILIZED_THRESHOLD);
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
@@ -5983,7 +5990,8 @@ static int select_non_idle_core(struct task_struct *p, int prev_cpu, int target)
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(turbo_sched_mask);
 	int iter_cpu, sibling;
 
-	cpumask_and(cpus, cpu_online_mask, p->cpus_ptr);
+	cpumask_and(cpus, cpu_online_mask, arch_turbo_domain(prev_cpu));
+	cpumask_and(cpus, cpus, p->cpus_ptr);
 
 	for_each_cpu_wrap(iter_cpu, cpus, prev_cpu) {
 		unsigned long core_util = 0;
-- 
2.17.1

