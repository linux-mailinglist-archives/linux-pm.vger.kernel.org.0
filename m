Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AC63F83C7
	for <lists+linux-pm@lfdr.de>; Thu, 26 Aug 2021 10:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbhHZIhN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 04:37:13 -0400
Received: from foss.arm.com ([217.140.110.172]:41564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240327AbhHZIhM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Aug 2021 04:37:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58350113E;
        Thu, 26 Aug 2021 01:36:25 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B9A223F5A1;
        Thu, 26 Aug 2021 01:36:23 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v5 4/8] PM / EM: Allow skipping inefficient states
Date:   Thu, 26 Aug 2021 09:35:40 +0100
Message-Id: <1629966944-439570-5-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629966944-439570-1-git-send-email-vincent.donnefort@arm.com>
References: <1629966944-439570-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new performance domain flag EM_PERF_DOMAIN_SKIP_INEFFICIENCIES allows
to not take into account inefficient states when estimating energy
consumption. This intends to let the Energy Model know that CPUFreq itself
will skip inefficiencies and such states don't need to be part of the
estimation anymore.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index ac2f7d0ab946..15d41f09f009 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -64,8 +64,12 @@ struct em_perf_domain {
  *
  *  EM_PERF_DOMAIN_MILLIWATTS: The power values are in milli-Watts or some
  *  other scale.
+ *
+ *  EM_PERF_DOMAIN_SKIP_INEFFICIENCIES: Skip inefficient states when estimating
+ *  energy consumption.
  */
 #define EM_PERF_DOMAIN_MILLIWATTS BIT(0)
+#define EM_PERF_DOMAIN_SKIP_INEFFICIENCIES BIT(1)
 
 #define em_span_cpus(em) (to_cpumask((em)->cpus))
 
@@ -121,6 +125,37 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 void em_dev_unregister_perf_domain(struct device *dev);
 
 /**
+ * em_pd_get_efficient_state() - Get an efficient performance state from the EM
+ * @pd   : Performance domain for which we want an efficient frequency
+ * @freq : Frequency to map with the EM
+ *
+ * It is called from the scheduler code quite frequently and as a consequence
+ * doesn't implement any check.
+ *
+ * Return: An efficient performance state, high enough to meet @freq
+ * requirement.
+ */
+static inline
+struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
+						unsigned long freq)
+{
+	struct em_perf_state *ps;
+	int i;
+
+	for (i = 0; i < pd->nr_perf_states; i++) {
+		ps = &pd->table[i];
+		if (ps->frequency >= freq) {
+			if (pd->flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
+			    ps->flags & EM_PERF_STATE_INEFFICIENT)
+				continue;
+			break;
+		}
+	}
+
+	return ps;
+}
+
+/**
  * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
 		performance domain
  * @pd		: performance domain for which energy has to be estimated
@@ -142,7 +177,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 {
 	unsigned long freq, scale_cpu;
 	struct em_perf_state *ps;
-	int i, cpu;
+	int cpu;
 
 	if (!sum_util)
 		return 0;
@@ -167,11 +202,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 * Find the lowest performance state of the Energy Model above the
 	 * requested frequency.
 	 */
-	for (i = 0; i < pd->nr_perf_states; i++) {
-		ps = &pd->table[i];
-		if (ps->frequency >= freq)
-			break;
-	}
+	ps = em_pd_get_efficient_state(pd, freq);
 
 	/*
 	 * The capacity of a CPU in the domain at the performance state (ps)
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 3a7d1573b214..d353ef29e37f 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -65,6 +65,17 @@ static int em_debug_units_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(em_debug_units);
 
+static int em_debug_skip_inefficiencies_show(struct seq_file *s, void *unused)
+{
+	struct em_perf_domain *pd = s->private;
+	int enabled = (pd->flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES) ? 1 : 0;
+
+	seq_printf(s, "%d\n", enabled);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(em_debug_skip_inefficiencies);
+
 static void em_debug_create_pd(struct device *dev)
 {
 	struct dentry *d;
@@ -78,6 +89,8 @@ static void em_debug_create_pd(struct device *dev)
 				    &em_debug_cpus_fops);
 
 	debugfs_create_file("units", 0444, d, dev->em_pd, &em_debug_units_fops);
+	debugfs_create_file("skip-inefficiencies", 0444, d, dev->em_pd,
+			    &em_debug_skip_inefficiencies_fops);
 
 	/* Create a sub-directory for each performance state */
 	for (i = 0; i < dev->em_pd->nr_perf_states; i++)
-- 
2.7.4

