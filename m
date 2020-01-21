Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08EF6143722
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 07:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgAUGdU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 01:33:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727817AbgAUGdU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 01:33:20 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00L6Wh1b138657
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2020 01:33:19 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xkyeaubcj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2020 01:33:19 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Tue, 21 Jan 2020 06:33:17 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Jan 2020 06:33:13 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00L6XCuW26411448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 06:33:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C417A4051;
        Tue, 21 Jan 2020 06:33:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B915A404D;
        Tue, 21 Jan 2020 06:33:10 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.158])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jan 2020 06:33:10 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, pavel@ucw.cz, dsmythies@telus.net,
        qperret@google.com, tim.c.chen@linux.intel.com
Subject: [RFC v6 1/5] sched: Introduce switch to enable TurboSched for task packing
Date:   Tue, 21 Jan 2020 12:03:03 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200121063307.17221-1-parth@linux.ibm.com>
References: <20200121063307.17221-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20012106-0008-0000-0000-0000034B47C1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012106-0009-0000-0000-00004A6BAC62
Message-Id: <20200121063307.17221-2-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_01:2020-01-20,2020-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001210056
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Create a static key which allows to enable or disable TurboSched feature at
runtime.

This key is added in order to enable the TurboSched feature only when
required. This helps in optimizing the scheduler fast-path when the
TurboSched feature is disabled.

Also provide get/put methods to keep track of the tasks using the
TurboSched feature and also refcount classified background tasks. This
allows to enable the feature on setting first task classified as background
noise, similarly disable the feature on unsetting of such last task.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/core.c  | 25 +++++++++++++++++++++++++
 kernel/sched/sched.h | 12 ++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a9e5d157b1a5..dfbb52d66b29 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -73,6 +73,31 @@ __read_mostly int scheduler_running;
  */
 int sysctl_sched_rt_runtime = 950000;
 
+#ifdef CONFIG_SCHED_SMT
+DEFINE_STATIC_KEY_FALSE(__turbo_sched_enabled);
+static DEFINE_MUTEX(turbo_sched_lock);
+static int turbo_sched_count;
+
+void turbo_sched_get(void)
+{
+	mutex_lock(&turbo_sched_lock);
+	if (!turbo_sched_count++)
+		static_branch_enable(&__turbo_sched_enabled);
+	mutex_unlock(&turbo_sched_lock);
+}
+
+void turbo_sched_put(void)
+{
+	mutex_lock(&turbo_sched_lock);
+	if (!--turbo_sched_count)
+		static_branch_disable(&__turbo_sched_enabled);
+	mutex_unlock(&turbo_sched_lock);
+}
+#else
+void turbo_sched_get(void) { return ; }
+void turbo_sched_get(void) { return ; }
+#endif
+
 /*
  * __task_rq_lock - lock the rq @p resides on.
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index edae9277e48d..f841297b7d56 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2497,3 +2497,15 @@ static inline void membarrier_switch_mm(struct rq *rq,
 {
 }
 #endif
+
+void turbo_sched_get(void);
+void turbo_sched_put(void);
+
+#ifdef CONFIG_SCHED_SMT
+DECLARE_STATIC_KEY_FALSE(__turbo_sched_enabled);
+
+static inline bool is_turbosched_enabled(void)
+{
+	return static_branch_unlikely(&__turbo_sched_enabled);
+}
+#endif
-- 
2.17.2

