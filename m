Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A322747D9
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 09:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfGYHJr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 03:09:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729448AbfGYHJI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 03:09:08 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6P76WYJ115216
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 03:09:08 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ty66bbwj1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 03:09:07 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 25 Jul 2019 08:09:05 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Jul 2019 08:09:02 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6P791Eu42926314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 07:09:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D09FF4C04E;
        Thu, 25 Jul 2019 07:09:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64D804C046;
        Thu, 25 Jul 2019 07:09:00 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.169])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jul 2019 07:09:00 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com,
        daniel.lezcano@linaro.org, subhra.mazumdar@oracle.com
Subject: [RFC v4 1/8] sched/core: Add manual jitter classification using sched_setattr syscall
Date:   Thu, 25 Jul 2019 12:38:50 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725070857.6639-1-parth@linux.ibm.com>
References: <20190725070857.6639-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19072507-0028-0000-0000-000003879ECE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072507-0029-0000-0000-00002447DD29
Message-Id: <20190725070857.6639-2-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250085
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Jitter tasks are short/bursty tasks, typically performing some housekeeping
work and are less important in the overall scheme of things.

So provide a way to mark the task as jitter with the use of additional flag
to the existing task attribute. Also provide an interface from the
userspace which uses sched_setattr syscall to mark tasks as jitter.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 include/linux/sched.h      | 1 +
 include/uapi/linux/sched.h | 4 +++-
 kernel/sched/core.c        | 9 +++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1113dd4706ae..e03b85166e34 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1463,6 +1463,7 @@ extern struct pid *cad_pid;
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
+#define PF_CAN_BE_PACKED	0x20000000	/* Provide hints to the scheduler to pack such tasks */
 #define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as freezable */
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
 
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 617bb59aa8ba..fccb1c57d037 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -55,6 +55,7 @@
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_TASK_PACKING		0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
@@ -66,6 +67,7 @@
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN		| \
 			 SCHED_FLAG_KEEP_ALL		| \
-			 SCHED_FLAG_UTIL_CLAMP)
+			 SCHED_FLAG_UTIL_CLAMP		| \
+			 SCHED_FLAG_TASK_PACKING)
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fa43ce3962e7..e7cda4aa8696 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4498,6 +4498,8 @@ static void __setscheduler_params(struct task_struct *p,
 	p->rt_priority = attr->sched_priority;
 	p->normal_prio = normal_prio(p);
 	set_load_weight(p, true);
+	if (attr->sched_flags & SCHED_FLAG_TASK_PACKING)
+		p->flags |= PF_CAN_BE_PACKED;
 }
 
 /* Actually do priority change: must hold pi & rq lock. */
@@ -4557,6 +4559,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	struct rq_flags rf;
 	int reset_on_fork;
 	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+	unsigned long long task_packing_flag =
+				attr->sched_flags & SCHED_FLAG_TASK_PACKING;
 	struct rq *rq;
 
 	/* The pi code expects interrupts enabled */
@@ -4686,6 +4690,8 @@ static int __sched_setscheduler(struct task_struct *p,
 			goto change;
 		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
 			goto change;
+		if (task_packing_flag)
+			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
 		task_rq_unlock(rq, p, &rf);
@@ -5181,6 +5187,9 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	attr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
 #endif
 
+	if (p->flags & PF_CAN_BE_PACKED)
+		attr.sched_flags |= SCHED_FLAG_TASK_PACKING;
+
 	rcu_read_unlock();
 
 	retval = sched_read_attr(uattr, &attr, size);
-- 
2.17.1

