Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A02754E22F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 10:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfFUIm4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 04:42:56 -0400
Received: from foss.arm.com ([217.140.110.172]:50986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfFUIm4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Jun 2019 04:42:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92C171516;
        Fri, 21 Jun 2019 01:42:55 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3FEFB3F246;
        Fri, 21 Jun 2019 01:42:53 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: [PATCH v10 08/16] sched/core: uclamp: Set default clamps for RT tasks
Date:   Fri, 21 Jun 2019 09:42:09 +0100
Message-Id: <20190621084217.8167-9-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190621084217.8167-1-patrick.bellasi@arm.com>
References: <20190621084217.8167-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

By default FAIR tasks start without clamps, i.e. neither boosted nor
capped, and they run at the best frequency matching their utilization
demand.  This default behavior does not fit RT tasks which instead are
expected to run at the maximum available frequency, if not otherwise
required by explicitly capping them.

Enforce the correct behavior for RT tasks by setting util_min to max
whenever:

 1. the task is switched to the RT class and it does not already have a
    user-defined clamp value assigned.

 2. an RT task is forked from a parent with RESET_ON_FORK set.

NOTE: utilization clamp values are cross scheduling class attributes and
thus they are never changed/reset once a value has been explicitly
defined from user-space.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2c49b23efc87..ab75e874fdcc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1051,6 +1051,27 @@ static int uclamp_validate(struct task_struct *p,
 static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr)
 {
+	unsigned int clamp_id;
+
+	/*
+	 * On scheduling class change, reset to default clamps for tasks
+	 * without a task-specific value.
+	 */
+	for_each_clamp_id(clamp_id) {
+		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
+		unsigned int clamp_value = uclamp_none(clamp_id);
+
+		/* Keep using defined clamps across class changes */
+		if (uc_se->user_defined)
+			continue;
+
+		/* By default, RT tasks always get 100% boost */
+		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
+			clamp_value = uclamp_none(UCLAMP_MAX);
+
+		uclamp_se_set(uc_se, clamp_value, false);
+	}
+
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
 		return;
 
@@ -1076,8 +1097,13 @@ static void uclamp_fork(struct task_struct *p)
 		return;
 
 	for_each_clamp_id(clamp_id) {
-		uclamp_se_set(&p->uclamp_req[clamp_id],
-			      uclamp_none(clamp_id), false);
+		unsigned int clamp_value = uclamp_none(clamp_id);
+
+		/* By default, RT tasks always get 100% boost */
+		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
+			clamp_value = uclamp_none(UCLAMP_MAX);
+
+		uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
 	}
 }
 
-- 
2.21.0

