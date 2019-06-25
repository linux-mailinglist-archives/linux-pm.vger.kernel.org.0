Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73AEE5222E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 06:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfFYEhj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 00:37:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726845AbfFYEhi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 00:37:38 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P4ZwYc073995
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 00:37:37 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tbbjda3r8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 00:37:37 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Tue, 25 Jun 2019 05:37:34 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Jun 2019 05:37:31 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5P4bUiB38666438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 04:37:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C79911C050;
        Tue, 25 Jun 2019 04:37:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AE2B11C04A;
        Tue, 25 Jun 2019 04:37:29 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.87])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 04:37:28 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com
Subject: [RFCv3 1/8] sched/core: Add manual jitter classification using sched_setattr syscall
Date:   Tue, 25 Jun 2019 10:07:19 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625043726.21490-1-parth@linux.ibm.com>
References: <20190625043726.21490-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19062504-0016-0000-0000-0000028C117F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062504-0017-0000-0000-000032E98140
Message-Id: <20190625043726.21490-2-parth@linux.ibm.com>
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

Jitter tasks are short/bursty tasks,typically performing some housekeeping
and are less important in the overall scheme of things. In this patch we
provide a mechanism based on Patrick Bellasi's UCLAMP framework to classify
jitter tasks"

We define jitter tasks as those whose util.max in the UCLAMP framework is
the least (=0). This also provides benefit of giving the least frequency to
those jitter tasks, which is useful if all jitters are packed onto a
separate core."

UCLAMP already provides a way to set util.max for a task by using a syscall
interface. This patch uses the `sched_setattr` syscall to set
sched_util_max attribute of the task which is used to classify the task as
jitter.

Use Case with turbo_bench.c
===================
```
i=8;
./turbo_bench -t 30 -h $i -n $((2*i)) -j
```
This spawns 2*i total threads: of which i-CPU bound and i-jitter threads.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 include/linux/sched.h | 6 ++++++
 kernel/sched/core.c   | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e2d80e6a187d..2bd9f75a3abb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -696,6 +696,12 @@ struct task_struct {
 	struct uclamp_se		uclamp_req[UCLAMP_CNT];
 	/* Effective clamp values used for a scheduling entity */
 	struct uclamp_se		uclamp[UCLAMP_CNT];
+	/*
+	 * Tag the task as jitter.
+	 * 0 = regular. Follows regular CFS policy for task placement.
+	 * 1 = Jitter tasks. Should be packed to reduce active core count.
+	 */
+	unsigned int			is_jitter;
 #endif
 
 #ifdef CONFIG_PREEMPT_NOTIFIERS
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ab0aa319fe60..19c7204d6351 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1189,6 +1189,15 @@ static void __setscheduler_uclamp(struct task_struct *p,
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
 			      attr->sched_util_max, true);
+
+		/*
+		 * Set task to jitter class if Max util is clamped to the least
+		 * possible value
+		 */
+		if (p->uclamp_req[UCLAMP_MAX].bucket_id == 0 && !p->is_jitter)
+			p->is_jitter = 1;
+		else if (p->is_jitter)
+			p->is_jitter = 0;
 	}
 }
 
-- 
2.17.1

