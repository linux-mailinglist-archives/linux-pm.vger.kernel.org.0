Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5CED747D4
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 09:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfGYHJP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 03:09:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729580AbfGYHJO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 03:09:14 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6P76X8s089225
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 03:09:13 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ty520ep36-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 03:09:13 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 25 Jul 2019 08:09:10 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Jul 2019 08:09:06 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6P78otG38273304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 07:08:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72DC94C040;
        Thu, 25 Jul 2019 07:09:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7F9B4C04A;
        Thu, 25 Jul 2019 07:09:03 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.169])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jul 2019 07:09:03 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com,
        daniel.lezcano@linaro.org, subhra.mazumdar@oracle.com
Subject: [RFC v4 3/8] sched/core: Update turbo_sched count only when required
Date:   Thu, 25 Jul 2019 12:38:52 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725070857.6639-1-parth@linux.ibm.com>
References: <20190725070857.6639-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19072507-0028-0000-0000-000003879ECF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072507-0029-0000-0000-00002447DD2B
Message-Id: <20190725070857.6639-4-parth@linux.ibm.com>
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

Use the get/put methods to add/remove the use of TurboSched support, such
that the feature is turned on only if there is atleast one jitter task.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee5980b4e150..60340fa18abb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3141,6 +3141,9 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		mmdrop(mm);
 	}
 	if (unlikely(prev_state == TASK_DEAD)) {
+		if (unlikely(prev->flags & PF_CAN_BE_PACKED))
+			turbo_sched_put();
+
 		if (prev->sched_class->task_dead)
 			prev->sched_class->task_dead(prev);
 
@@ -4793,6 +4796,10 @@ static int __sched_setscheduler(struct task_struct *p,
 
 	prev_class = p->sched_class;
 
+	/* Refcount tasks classified as jitter task */
+	if (task_packing_flag != (p->flags & PF_CAN_BE_PACKED))
+		(task_packing_flag) ? turbo_sched_get() : turbo_sched_put();
+
 	__setscheduler(rq, p, attr, pi);
 	__setscheduler_uclamp(p, attr);
 
-- 
2.17.1

