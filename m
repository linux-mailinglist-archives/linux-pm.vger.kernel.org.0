Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5160145AE6
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 18:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgAVRgO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 12:36:14 -0500
Received: from foss.arm.com ([217.140.110.172]:59002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVRgO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Jan 2020 12:36:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE8B8106F;
        Wed, 22 Jan 2020 09:36:13 -0800 (PST)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8FAE43F6C4;
        Wed, 22 Jan 2020 09:36:12 -0800 (PST)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc:     douglas.raillard@arm.com, dietmar.eggemann@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org
Subject: [RFC PATCH v4 2/6] sched/cpufreq: Attach perf domain to sugov policy
Date:   Wed, 22 Jan 2020 17:35:34 +0000
Message-Id: <20200122173538.1142069-3-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122173538.1142069-1-douglas.raillard@arm.com>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Attach an Energy Model perf_domain to each sugov_policy to prepare the
ground for energy-aware schedutil.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 41 ++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 9b8916fd00a2..09e284dc918a 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -42,6 +42,10 @@ struct sugov_policy {
 
 	bool			limits_changed;
 	bool			need_freq_update;
+
+#ifdef CONFIG_ENERGY_MODEL
+	struct em_perf_domain *pd;
+#endif
 };
 
 struct sugov_cpu {
@@ -66,6 +70,40 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
 
 /************************ Governor internals ***********************/
 
+#ifdef CONFIG_ENERGY_MODEL
+static void sugov_policy_attach_pd(struct sugov_policy *sg_policy)
+{
+	struct cpufreq_policy *policy = sg_policy->policy;
+	struct em_perf_domain *pd;
+
+	sg_policy->pd = NULL;
+	pd = em_cpu_get(policy->cpu);
+	if (!pd)
+		return;
+
+	if (cpumask_equal(policy->related_cpus, to_cpumask(pd->cpus))) {
+		sg_policy->pd = pd;
+	} else {
+		pr_warn("%s: Not all CPUs in schedutil policy %u share the same perf domain, no perf domain for that policy will be registered\n",
+			__func__, policy->cpu);
+	}
+}
+
+static struct em_perf_domain *
+sugov_policy_get_pd(struct sugov_policy *sg_policy)
+{
+	return sg_policy->pd;
+}
+#else /* CONFIG_ENERGY_MODEL */
+static void sugov_policy_attach_pd(struct sugov_policy *sg_policy) {}
+
+static struct em_perf_domain *
+sugov_policy_get_pd(struct sugov_policy *sg_policy)
+{
+	return NULL;
+}
+#endif /* CONFIG_ENERGY_MODEL */
+
 static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 {
 	s64 delta_ns;
@@ -859,6 +897,9 @@ static int sugov_start(struct cpufreq_policy *policy)
 							sugov_update_shared :
 							sugov_update_single);
 	}
+
+	sugov_policy_attach_pd(sg_policy);
+
 	return 0;
 }
 
-- 
2.24.1

