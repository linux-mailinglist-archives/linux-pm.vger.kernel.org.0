Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5978CDD58
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2019 10:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfJGIbJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Oct 2019 04:31:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727452AbfJGIbI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Oct 2019 04:31:08 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x978SeXk093643
        for <linux-pm@vger.kernel.org>; Mon, 7 Oct 2019 04:31:07 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vg14nhjwj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 07 Oct 2019 04:31:07 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 7 Oct 2019 09:31:05 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 7 Oct 2019 09:31:00 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x978Uxdt48234526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Oct 2019 08:30:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE1CB11C058;
        Mon,  7 Oct 2019 08:30:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D78F11C054;
        Mon,  7 Oct 2019 08:30:57 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.220])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Oct 2019 08:30:57 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, pavel@ucw.cz, dsmythies@telus.net,
        quentin.perret@arm.com, rafael.j.wysocki@intel.com,
        tim.c.chen@linux.intel.com, daniel.lezcano@linaro.org
Subject: [RFC v5 2/6] sched: Introduce switch to enable TurboSched for task packing
Date:   Mon,  7 Oct 2019 14:00:47 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007083051.4820-1-parth@linux.ibm.com>
References: <20191007083051.4820-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19100708-0016-0000-0000-000002B4C032
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100708-0017-0000-0000-00003315D5ED
Message-Id: <20191007083051.4820-3-parth@linux.ibm.com>
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
 kernel/sched/core.c  | 20 ++++++++++++++++++++
 kernel/sched/sched.h |  9 +++++++++
 2 files changed, 29 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e7cda4aa8696..ee5980b4e150 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -72,6 +72,26 @@ __read_mostly int scheduler_running;
  */
 int sysctl_sched_rt_runtime = 950000;
 
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
+
 /*
  * __task_rq_lock - lock the rq @p resides on.
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 802b1f3405f2..4a0b90ea8652 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2423,3 +2423,12 @@ static inline bool sched_energy_enabled(void)
 static inline bool sched_energy_enabled(void) { return false; }
 
 #endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
+
+void turbo_sched_get(void);
+void turbo_sched_put(void);
+DECLARE_STATIC_KEY_FALSE(__turbo_sched_enabled);
+
+static inline bool is_turbosched_enabled(void)
+{
+	return static_branch_unlikely(&__turbo_sched_enabled);
+}
-- 
2.17.1

