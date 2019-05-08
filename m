Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAF517F47
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 19:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfEHRnl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 13:43:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41800 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729059AbfEHRnM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 May 2019 13:43:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE56415AB;
        Wed,  8 May 2019 10:43:11 -0700 (PDT)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 536C23F575;
        Wed,  8 May 2019 10:43:10 -0700 (PDT)
From:   douglas.raillard@arm.com
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        quentin.perret@arm.com, douglas.raillard@arm.com,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com
Subject: [RFC PATCH 2/7] sched/cpufreq: Attach perf domain to sugov policy
Date:   Wed,  8 May 2019 18:42:56 +0100
Message-Id: <20190508174301.4828-3-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190508174301.4828-1-douglas.raillard@arm.com>
References: <20190508174301.4828-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Douglas RAILLARD <douglas.raillard@arm.com>

Attach an Energy Model perf_domain to each sugov_policy to prepare the
ground for energy-aware schedutil.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index d0f4d2111bfe..82dbacf83649 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -39,6 +39,10 @@ struct sugov_policy {
 	bool			work_in_progress;
 
 	bool			need_freq_update;
+
+#ifdef CONFIG_ENERGY_MODEL
+	struct em_perf_domain *pd;
+#endif
 };
 
 struct sugov_cpu {
@@ -64,6 +68,38 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
 
 /************************ Governor internals ***********************/
 
+#ifdef CONFIG_ENERGY_MODEL
+static void sugov_policy_attach_pd(struct sugov_policy *sg_policy)
+{
+	struct em_perf_domain *pd;
+	struct cpufreq_policy *policy = sg_policy->policy;
+
+	sg_policy->pd = NULL;
+	pd = em_cpu_get(policy->cpu);
+	if (!pd)
+		return;
+
+	if (cpumask_equal(policy->related_cpus, to_cpumask(pd->cpus)))
+		sg_policy->pd = pd;
+	else
+		pr_warn("%s: Not all CPUs in schedutil policy %u share the same perf domain, no perf domain for that policy will be registered\n",
+			__func__, policy->cpu);
+}
+
+static struct em_perf_domain *sugov_policy_get_pd(
+						struct sugov_policy *sg_policy)
+{
+	return sg_policy->pd;
+}
+#else /* CONFIG_ENERGY_MODEL */
+static void sugov_policy_attach_pd(struct sugov_policy *sg_policy) {}
+static struct em_perf_domain *sugov_policy_get_pd(
+						struct sugov_policy *sg_policy)
+{
+	return NULL;
+}
+#endif /* CONFIG_ENERGY_MODEL */
+
 static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 {
 	s64 delta_ns;
@@ -849,6 +885,9 @@ static int sugov_start(struct cpufreq_policy *policy)
 							sugov_update_shared :
 							sugov_update_single);
 	}
+
+	sugov_policy_attach_pd(sg_policy);
+
 	return 0;
 }
 
-- 
2.21.0

