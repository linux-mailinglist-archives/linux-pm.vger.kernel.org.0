Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCBC143728
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 07:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgAUGd1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 01:33:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728982AbgAUGd0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 01:33:26 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00L6Wj6H023028
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2020 01:33:26 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgdknvf6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2020 01:33:25 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Tue, 21 Jan 2020 06:33:23 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Jan 2020 06:33:20 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00L6XJRL41746700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 06:33:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7096AA4055;
        Tue, 21 Jan 2020 06:33:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73AC6A405D;
        Tue, 21 Jan 2020 06:33:17 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.158])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jan 2020 06:33:17 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, pavel@ucw.cz, dsmythies@telus.net,
        qperret@google.com, tim.c.chen@linux.intel.com
Subject: [RFC v6 4/5] sched/fair: Provide arch hook to find domain for non idle core search scan
Date:   Tue, 21 Jan 2020 12:03:06 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200121063307.17221-1-parth@linux.ibm.com>
References: <20200121063307.17221-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20012106-4275-0000-0000-000003997BF4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012106-4276-0000-0000-000038AD834C
Message-Id: <20200121063307.17221-5-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_01:2020-01-20,2020-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001210056
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
 kernel/sched/fair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8643e6309451..af19e1f9d56d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5890,6 +5890,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 /* Define non-idle CPU as the one with the utilization >= 12.5% */
 #define merely_used_cpu(util) ((cpu_util(util)) > (100 >> 3))
 
+#ifndef arch_turbo_domain
+static __always_inline struct cpumask *arch_turbo_domain(int cpu)
+{
+	return sched_domain_span(rcu_dereference(per_cpu(sd_llc, cpu)));
+}
+#endif
+
 /*
  * Classify small background tasks with higher latency_nice value for task
  * packing.
@@ -5916,6 +5923,7 @@ static int select_non_idle_core(struct task_struct *p, int prev_cpu)
 	int iter_cpu, sibling;
 
 	cpumask_and(cpus, cpu_online_mask, p->cpus_ptr);
+	cpumask_and(cpus, cpus, arch_turbo_domain(prev_cpu));
 
 	for_each_cpu_wrap(iter_cpu, cpus, prev_cpu) {
 		int idle_cpu_count = 0, non_idle_cpu_count = 0;
-- 
2.17.2

