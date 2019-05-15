Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9735D1F600
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 15:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfEONxv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 09:53:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727890AbfEONxu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 09:53:50 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4FDrRtS140463
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 09:53:50 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sgkpdsg3n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 09:53:47 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Wed, 15 May 2019 14:53:40 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 May 2019 14:53:38 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4FDrb6851642486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 13:53:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF54252050;
        Wed, 15 May 2019 13:53:36 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.102.18.182])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 18FF85204E;
        Wed, 15 May 2019 13:53:33 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        dsmythies@telus.net
Subject: [RFCv2 1/6] sched/core: Add manual jitter classification from cgroup interface
Date:   Wed, 15 May 2019 19:23:17 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190515135322.19393-1-parth@linux.ibm.com>
References: <20190515135322.19393-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19051513-4275-0000-0000-000003351565
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051513-4276-0000-0000-0000384499A3
Message-Id: <20190515135322.19393-2-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905150087
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Jitter tasks are usually of less important in terms of performance
and are short/bursty in characteristics. TurboSched uses this jitter
classification to pack jitters into the already running busy cores to
keep the total idle core count high.

The patch describes the use of UCLAMP mechanism to classify tasks. Patrick
Bellasi came up with a mechanism to classify tasks from the userspace
https://lore.kernel.org/lkml/20190402104153.25404-1-patrick.bellasi@arm.com/

This UCLAMP mechanism can be useful in classifying tasks as jitter. Jitters
can be classified for the cgroup by keeping util.max of the tasks as the
least(=0). This also provides benefit of giving the least frequency to
those jitter tasks, which is useful if all jitters are packed onto a
separate core.

Use Case with UCLAMP
===================
To create a cgroup with all the tasks classified as jitters;

```
mkdir -p /sys/fs/cgroup/cpu/jitter
echo 0 > /proc/sys/kernel/sched_uclamp_util_min;
echo 0 > /sys/fs/cgroup/cpu/jitter/cpu.util.min;
echo 0 > /sys/fs/cgroup/cpu/jitter/cpu.util.max;
i=8;
./turbo_bench -t 30 -h $i -n $i &
./turbo_bench -t 30 -h 0 -n $i &
echo $! > /sys/fs/cgroup/cpu/jitter/cgroup.procs;
```

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/core.c  | 9 +++++++++
 kernel/sched/sched.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d42c0f5eefa9..77aa4aee4478 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7192,6 +7192,15 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 	tg->uclamp_req[UCLAMP_MAX].value = max_value;
 	tg->uclamp_req[UCLAMP_MAX].bucket_id = uclamp_bucket_id(max_value);
 
+	/*
+	 * Classify the tasks belonging to the last bucket of MAX UCLAMP as
+	 * jitters
+	 */
+	if (uclamp_bucket_id(max_value) == 0)
+		tg->turbo_sched_enabled = 1;
+	else if (tg->turbo_sched_enabled)
+		tg->turbo_sched_enabled = 0;
+
 	/* Update effective clamps to track the most restrictive value */
 	cpu_util_update_eff(css, UCLAMP_MAX);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b4019012d84b..e75ffaf3ff34 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -407,6 +407,7 @@ struct task_group {
 	struct uclamp_se	uclamp[UCLAMP_CNT];
 #endif
 
+	bool			turbo_sched_enabled;
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.17.1

