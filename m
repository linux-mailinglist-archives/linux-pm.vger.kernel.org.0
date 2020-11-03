Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF8F2A3FA6
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 10:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgKCJGX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 04:06:23 -0500
Received: from foss.arm.com ([217.140.110.172]:44710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgKCJGV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 04:06:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D83911424;
        Tue,  3 Nov 2020 01:06:20 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.19.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F5603F719;
        Tue,  3 Nov 2020 01:06:16 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, amitk@kernel.org, corbet@lwn.net,
        daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, dianders@chromium.org, mka@chromium.org,
        rnayak@codeaurora.org, rafael@kernel.org, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, sboyd@kernel.org, nm@ti.com
Subject: [PATCH v4 1/4] PM / EM: Add a flag indicating units of power values in Energy Model
Date:   Tue,  3 Nov 2020 09:05:57 +0000
Message-Id: <20201103090600.29053-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103090600.29053-1-lukasz.luba@arm.com>
References: <20201103090600.29053-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are different platforms and devices which might use different scale
for the power values. Kernel sub-systems might need to check if all
Energy Model (EM) devices are using the same scale. Address that issue and
store the information inside EM for each device. Thanks to that they can
be easily compared and proper action triggered.

Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Quentin Perret <qperret@google.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c |  3 ++-
 drivers/opp/of.c               |  2 +-
 include/linux/energy_model.h   |  9 +++++++--
 kernel/power/energy_model.c    | 24 +++++++++++++++++++++++-
 4 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index e855e8612a67..3714a4cd07fa 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -188,7 +188,8 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->fast_switch_possible =
 		handle->perf_ops->fast_switch_possible(handle, cpu_dev);
 
-	em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus);
+	em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus,
+				    false);
 
 	return 0;
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 9faeb83e4b32..16f39e2127a5 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1335,7 +1335,7 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
 		goto failed;
 	}
 
-	ret = em_dev_register_perf_domain(dev, nr_opp, &em_cb, cpus);
+	ret = em_dev_register_perf_domain(dev, nr_opp, &em_cb, cpus, true);
 	if (ret)
 		goto failed;
 
diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index b67a51c574b9..685d9e919137 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -29,6 +29,8 @@ struct em_perf_state {
  * em_perf_domain - Performance domain
  * @table:		List of performance states, in ascending order
  * @nr_perf_states:	Number of performance states
+ * @milliwatts:		Flag indicating the power values are in milli-Watts
+ *			or some other scale.
  * @cpus:		Cpumask covering the CPUs of the domain. It's here
  *			for performance reasons to avoid potential cache
  *			misses during energy calculations in the scheduler
@@ -43,6 +45,7 @@ struct em_perf_state {
 struct em_perf_domain {
 	struct em_perf_state *table;
 	int nr_perf_states;
+	int milliwatts;
 	unsigned long cpus[];
 };
 
@@ -79,7 +82,8 @@ struct em_data_callback {
 struct em_perf_domain *em_cpu_get(int cpu);
 struct em_perf_domain *em_pd_get(struct device *dev);
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
-				struct em_data_callback *cb, cpumask_t *span);
+				struct em_data_callback *cb, cpumask_t *spani,
+				bool milliwatts);
 void em_dev_unregister_perf_domain(struct device *dev);
 
 /**
@@ -186,7 +190,8 @@ struct em_data_callback {};
 
 static inline
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
-				struct em_data_callback *cb, cpumask_t *span)
+				struct em_data_callback *cb, cpumask_t *span,
+				bool milliwatts)
 {
 	return -EINVAL;
 }
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index c1ff7fa030ab..efe2a595988e 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -52,6 +52,17 @@ static int em_debug_cpus_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(em_debug_cpus);
 
+static int em_debug_units_show(struct seq_file *s, void *unused)
+{
+	struct em_perf_domain *pd = s->private;
+	char *units = pd->milliwatts ? "milliWatts" : "bogoWatts";
+
+	seq_printf(s, "%s\n", units);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(em_debug_units);
+
 static void em_debug_create_pd(struct device *dev)
 {
 	struct dentry *d;
@@ -64,6 +75,8 @@ static void em_debug_create_pd(struct device *dev)
 		debugfs_create_file("cpus", 0444, d, dev->em_pd->cpus,
 				    &em_debug_cpus_fops);
 
+	debugfs_create_file("units", 0444, d, dev->em_pd, &em_debug_units_fops);
+
 	/* Create a sub-directory for each performance state */
 	for (i = 0; i < dev->em_pd->nr_perf_states; i++)
 		em_debug_create_ps(&dev->em_pd->table[i], d);
@@ -250,17 +263,24 @@ EXPORT_SYMBOL_GPL(em_cpu_get);
  * @cpus	: Pointer to cpumask_t, which in case of a CPU device is
  *		obligatory. It can be taken from i.e. 'policy->cpus'. For other
  *		type of devices this should be set to NULL.
+ * @milliwatts	: Flag indicating that the power values are in milliWatts or
+ *		in some other scale. It must be set properly.
  *
  * Create Energy Model tables for a performance domain using the callbacks
  * defined in cb.
  *
+ * The @milliwatts is important to set with correct value. Some kernel
+ * sub-systems might rely on this flag and check if all devices in the EM are
+ * using the same scale.
+ *
  * If multiple clients register the same performance domain, all but the first
  * registration will be ignored.
  *
  * Return 0 on success
  */
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
-				struct em_data_callback *cb, cpumask_t *cpus)
+				struct em_data_callback *cb, cpumask_t *cpus,
+				bool milliwatts)
 {
 	unsigned long cap, prev_cap = 0;
 	int cpu, ret;
@@ -313,6 +333,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 	if (ret)
 		goto unlock;
 
+	dev->em_pd->milliwatts = milliwatts;
+
 	em_debug_create_pd(dev);
 	dev_info(dev, "EM: created perf domain\n");
 
-- 
2.17.1

