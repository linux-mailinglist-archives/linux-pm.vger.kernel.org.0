Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08F6961BE0
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 10:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfGHIoT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 04:44:19 -0400
Received: from foss.arm.com ([217.140.110.172]:41980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729602AbfGHIoT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 04:44:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A06D01516;
        Mon,  8 Jul 2019 01:44:18 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CD6D3F246;
        Mon,  8 Jul 2019 01:44:16 -0700 (PDT)
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
Subject: [PATCH v11 3/5] sched/core: uclamp: Propagate system defaults to root group
Date:   Mon,  8 Jul 2019 09:43:55 +0100
Message-Id: <20190708084357.12944-4-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190708084357.12944-1-patrick.bellasi@arm.com>
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The clamp values are not tunable at the level of the root task group.
That's for two main reasons:

 - the root group represents "system resources" which are always
   entirely available from the cgroup standpoint.

 - when tuning/restricting "system resources" makes sense, tuning must
   be done using a system wide API which should also be available when
   control groups are not.

When a system wide restriction is available, cgroups should be aware of
its value in order to know exactly how much "system resources" are
available for the subgroups.

Utilization clamping supports already the concepts of:

 - system defaults: which define the maximum possible clamp values
   usable by tasks.

 - effective clamps: which allows a parent cgroup to constraint (maybe
   temporarily) its descendants without losing the information related
   to the values "requested" from them.

Exploit these two concepts and bind them together in such a way that,
whenever system default are tuned, the new values are propagated to
(possibly) restrict or relax the "effective" value of nested cgroups.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ec91f4518752..276f9c2f6103 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1017,12 +1017,30 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 		uclamp_rq_dec_id(rq, p, clamp_id);
 }
 
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+static void cpu_util_update_eff(struct cgroup_subsys_state *css);
+static void uclamp_update_root_tg(void)
+{
+	struct task_group *tg = &root_task_group;
+
+	uclamp_se_set(&tg->uclamp_req[UCLAMP_MIN],
+		      sysctl_sched_uclamp_util_min, false);
+	uclamp_se_set(&tg->uclamp_req[UCLAMP_MAX],
+		      sysctl_sched_uclamp_util_max, false);
+
+	cpu_util_update_eff(&root_task_group.css);
+}
+#else
+static void uclamp_update_root_tg(void) { }
+#endif
+
 int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 				void __user *buffer, size_t *lenp,
 				loff_t *ppos)
 {
-	int old_min, old_max;
+	bool update_root_tg = false;
 	static DEFINE_MUTEX(mutex);
+	int old_min, old_max;
 	int result;
 
 	mutex_lock(&mutex);
@@ -1044,12 +1062,17 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 	if (old_min != sysctl_sched_uclamp_util_min) {
 		uclamp_se_set(&uclamp_default[UCLAMP_MIN],
 			      sysctl_sched_uclamp_util_min, false);
+		update_root_tg = true;
 	}
 	if (old_max != sysctl_sched_uclamp_util_max) {
 		uclamp_se_set(&uclamp_default[UCLAMP_MAX],
 			      sysctl_sched_uclamp_util_max, false);
+		update_root_tg = true;
 	}
 
+	if (update_root_tg)
+		uclamp_update_root_tg();
+
 	/*
 	 * Updating all the RUNNABLE task is expensive, keep it simple and do
 	 * just a lazy update at each next enqueue time.
-- 
2.21.0

