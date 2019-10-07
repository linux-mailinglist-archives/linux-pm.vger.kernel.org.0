Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB00CDD5B
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2019 10:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfJGIbR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Oct 2019 04:31:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727563AbfJGIbQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Oct 2019 04:31:16 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x978SNUT100705
        for <linux-pm@vger.kernel.org>; Mon, 7 Oct 2019 04:31:16 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vg097tx3a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 07 Oct 2019 04:31:15 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 7 Oct 2019 09:31:13 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 7 Oct 2019 09:31:08 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x978V7MS37224706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Oct 2019 08:31:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54BBC11C054;
        Mon,  7 Oct 2019 08:31:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E8B511C04C;
        Mon,  7 Oct 2019 08:31:05 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.220])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Oct 2019 08:31:04 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, pavel@ucw.cz, dsmythies@telus.net,
        quentin.perret@arm.com, rafael.j.wysocki@intel.com,
        tim.c.chen@linux.intel.com, daniel.lezcano@linaro.org
Subject: [RFC v5 5/6] sched/fair: Provide arch hook to find domain for non idle core search scan
Date:   Mon,  7 Oct 2019 14:00:50 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007083051.4820-1-parth@linux.ibm.com>
References: <20191007083051.4820-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19100708-0028-0000-0000-000003A6BE4A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100708-0029-0000-0000-00002468CDD0
Message-Id: <20191007083051.4820-6-parth@linux.ibm.com>
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

Specify the method which returns cpumask within which to limit the
search for a non idle core. By default, limit the search in LLC domain
which usually includes few/all the cores in the processor chip.

The select_non_idle_core searches for the non idle cores in the LLC domain.
But in the systems with multiple NUMA domains, the Turbo frequency can be
sustained within the NUMA domain without being affected from other
NUMA. For such case, arch_turbo_domain can be tuned to change domain for
non idle core search.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/fair.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4a1b6474338..731d1aaa6bc0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5967,6 +5967,14 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 }
 
 #ifdef CONFIG_SCHED_SMT
+
+#ifndef arch_turbo_domain
+static __always_inline struct cpumask *arch_turbo_domain(int cpu)
+{
+	return sched_domain_span(rcu_dereference(per_cpu(sd_llc, cpu)));
+}
+#endif
+
 static inline bool is_background_task(struct task_struct *p)
 {
 	if (p->flags & PF_CAN_BE_PACKED)
@@ -5991,7 +5999,8 @@ static int select_non_idle_core(struct task_struct *p, int prev_cpu, int target)
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(turbo_sched_mask);
 	int iter_cpu, sibling;
 
-	cpumask_and(cpus, cpu_online_mask, p->cpus_ptr);
+	cpumask_and(cpus, cpu_online_mask, arch_turbo_domain(prev_cpu));
+	cpumask_and(cpus, cpus, p->cpus_ptr);
 
 	for_each_cpu_wrap(iter_cpu, cpus, prev_cpu) {
 		int idle_cpu_count = 0, non_idle_cpu_count = 0;
-- 
2.17.1

