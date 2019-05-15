Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 980841F5FE
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 15:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfEONxs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 09:53:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbfEONxr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 09:53:47 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4FDqgWZ118681
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 09:53:47 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sgj7mptuh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 09:53:46 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Wed, 15 May 2019 14:53:43 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 May 2019 14:53:40 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4FDrdda49479760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 13:53:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DAF852051;
        Wed, 15 May 2019 13:53:39 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.102.18.182])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 50DC65204E;
        Wed, 15 May 2019 13:53:37 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        dsmythies@telus.net
Subject: [RFCv2 2/6] sched: Introduce switch to enable TurboSched mode
Date:   Wed, 15 May 2019 19:23:18 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190515135322.19393-1-parth@linux.ibm.com>
References: <20190515135322.19393-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19051513-0020-0000-0000-0000033CFC9B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051513-0021-0000-0000-0000218FBF2A
Message-Id: <20190515135322.19393-3-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905150087
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch creates a static key which allows to enable or disable
TurboSched feature at runtime.

This key is added in order to enable the TurboSched feature. The static key
helps in optimizing the scheduler fast-path when the TurboSched feature is
disabled.

The patch also provides get/put methods to keep track of the cgroups using
the TurboSched feature. This allows to enable the feature on adding first
cgroup classified as jitter, similarly disable the feature on removal of
such last cgroup.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/core.c  | 20 ++++++++++++++++++++
 kernel/sched/sched.h |  7 +++++++
 2 files changed, 27 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 77aa4aee4478..facbedd2554e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -60,6 +60,26 @@ __read_mostly int scheduler_running;
  */
 int sysctl_sched_rt_runtime = 950000;
 
+DEFINE_STATIC_KEY_FALSE(__turbo_sched_enabled);
+static DEFINE_SPINLOCK(turbo_sched_lock);
+static int turbo_sched_count;
+
+void turbo_sched_get(void)
+{
+	spin_lock(&turbo_sched_lock);
+	if (!turbo_sched_count++)
+		static_branch_enable(&__turbo_sched_enabled);
+	spin_unlock(&turbo_sched_lock);
+}
+
+void turbo_sched_put(void)
+{
+	spin_lock(&turbo_sched_lock);
+	if (!--turbo_sched_count)
+		static_branch_disable(&__turbo_sched_enabled);
+	spin_unlock(&turbo_sched_lock);
+}
+
 /*
  * __task_rq_lock - lock the rq @p resides on.
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e75ffaf3ff34..0339964cdf43 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2437,3 +2437,10 @@ static inline bool sched_energy_enabled(void)
 static inline bool sched_energy_enabled(void) { return false; }
 
 #endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
+
+DECLARE_STATIC_KEY_FALSE(__turbo_sched_enabled);
+
+static inline bool is_turbosched_enabled(void)
+{
+	return static_branch_unlikely(&__turbo_sched_enabled);
+}
-- 
2.17.1

