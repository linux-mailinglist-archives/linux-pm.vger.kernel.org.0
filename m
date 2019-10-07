Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75317CDD61
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2019 10:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfJGIb2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Oct 2019 04:31:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727514AbfJGIbO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Oct 2019 04:31:14 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x978SL7F014030
        for <linux-pm@vger.kernel.org>; Mon, 7 Oct 2019 04:31:10 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vg1qd0d4r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 07 Oct 2019 04:31:10 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 7 Oct 2019 09:31:08 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 7 Oct 2019 09:31:03 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x978V2QX54067400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Oct 2019 08:31:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47AD611C04C;
        Mon,  7 Oct 2019 08:31:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F224E11C069;
        Mon,  7 Oct 2019 08:30:59 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.220])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Oct 2019 08:30:59 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, pavel@ucw.cz, dsmythies@telus.net,
        quentin.perret@arm.com, rafael.j.wysocki@intel.com,
        tim.c.chen@linux.intel.com, daniel.lezcano@linaro.org
Subject: [RFC v5 3/6] sched/core: Update turbo_sched count only when required
Date:   Mon,  7 Oct 2019 14:00:48 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007083051.4820-1-parth@linux.ibm.com>
References: <20191007083051.4820-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19100708-0012-0000-0000-00000354C1D2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100708-0013-0000-0000-0000218FD1A0
Message-Id: <20191007083051.4820-4-parth@linux.ibm.com>
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

Use the get/put methods to add/remove the use of TurboSched support, such
that the feature is turned on only in the presence of atleast one
classified small bckground task.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee5980b4e150..6e1ae8046fe0 100644
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
 
+	/* Refcount tasks classified as a small background task */
+	if (task_packing_flag != (p->flags & PF_CAN_BE_PACKED))
+		(task_packing_flag) ? turbo_sched_get() : turbo_sched_put();
+
 	__setscheduler(rq, p, attr, pi);
 	__setscheduler_uclamp(p, attr);
 
-- 
2.17.1

