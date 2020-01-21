Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C722B143727
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 07:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAUGdX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 01:33:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728456AbgAUGdX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 01:33:23 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00L6X6YY133274
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2020 01:33:21 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xmg3amjjf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2020 01:33:21 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Tue, 21 Jan 2020 06:33:19 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Jan 2020 06:33:15 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00L6XE0J57933886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 06:33:15 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFC64A405D;
        Tue, 21 Jan 2020 06:33:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E03AFA405B;
        Tue, 21 Jan 2020 06:33:12 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.158])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jan 2020 06:33:12 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, pavel@ucw.cz, dsmythies@telus.net,
        qperret@google.com, tim.c.chen@linux.intel.com
Subject: [RFC v6 2/5] sched/core: Update turbo_sched count only when required
Date:   Tue, 21 Jan 2020 12:03:04 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200121063307.17221-1-parth@linux.ibm.com>
References: <20200121063307.17221-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20012106-0012-0000-0000-0000037F40E3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012106-0013-0000-0000-000021BB7FBE
Message-Id: <20200121063307.17221-3-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_01:2020-01-20,2020-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001210056
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the get/put methods to add/remove the use of TurboSched support, such
that the feature is turned on only in the presence of atleast one
classified small bckground task.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/core.c  | 9 +++++++++
 kernel/sched/sched.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dfbb52d66b29..629c2589d727 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3272,6 +3272,9 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		mmdrop(mm);
 	}
 	if (unlikely(prev_state == TASK_DEAD)) {
+		if (unlikely(is_bg_task(prev)))
+			turbo_sched_put();
+
 		if (prev->sched_class->task_dead)
 			prev->sched_class->task_dead(prev);
 
@@ -4800,6 +4803,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	int reset_on_fork;
 	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	struct rq *rq;
+	bool attr_leniency = bgtask_latency(attr->sched_latency_nice);
+
 
 	/* The pi code expects interrupts enabled */
 	BUG_ON(pi && in_interrupt());
@@ -5024,6 +5029,10 @@ static int __sched_setscheduler(struct task_struct *p,
 
 	prev_class = p->sched_class;
 
+	/* Refcount tasks classified as a small background task */
+	if (is_bg_task(p) != attr_leniency)
+		attr_leniency ? turbo_sched_get() : turbo_sched_put();
+
 	__setscheduler(rq, p, attr, pi);
 	__setscheduler_uclamp(p, attr);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f841297b7d56..0a00e16e033a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2498,6 +2498,9 @@ static inline void membarrier_switch_mm(struct rq *rq,
 }
 #endif
 
+#define bgtask_latency(lat)	((lat) == MAX_LATENCY_NICE)
+#define is_bg_task(p)		(bgtask_latency((p)->latency_nice))
+
 void turbo_sched_get(void);
 void turbo_sched_put(void);
 
-- 
2.17.2

