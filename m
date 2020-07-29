Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C07232148
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 17:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2PMY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 11:12:24 -0400
Received: from foss.arm.com ([217.140.110.172]:53390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2PMX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 11:12:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D067D6E;
        Wed, 29 Jul 2020 08:12:23 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0CA0D3F66E;
        Wed, 29 Jul 2020 08:12:20 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        viresh.kumar@linaro.org, lukasz.luba@arm.com, rjw@rjwysocki.net
Subject: [PATCH 1/4] cpufreq: Add support for statistics read from drivers
Date:   Wed, 29 Jul 2020 16:12:05 +0100
Message-Id: <20200729151208.27737-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729151208.27737-1-lukasz.luba@arm.com>
References: <20200729151208.27737-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpufreq statistics are not collected when the 'fast switch' is in use.
The information can be retrieved from firmware by the cpufreq driver, but
the cpufreq interfaces must be extended in order to support it.

Introduce callback in cpufreq driver structure and additional flag in
cpufreq policy to provide support for statistics maintained in firmware.

Since the cpufreq driver structure can be shared by many policy objects,
the flag 'has_driver_stats' in policy makes sure that the framework will
only use the statistics from cpufreq driver for actually supported CPUs.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpufreq/cpufreq.c       | 22 +++++++++++++++++++
 drivers/cpufreq/cpufreq_stats.c | 38 +++++++++++++++++++++------------
 include/linux/cpufreq.h         | 32 +++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 17c1c3becd92..83098205e739 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2543,6 +2543,28 @@ void cpufreq_update_limits(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(cpufreq_update_limits);
 
+#ifdef CONFIG_CPU_FREQ_STAT
+/**
+ * cpufreq_update_statistics - Update statistics for a given policy.
+ * @policy: struct cpufreq_policy into which the current cpufreq_policy
+ *	is written
+ *
+ * Invoke the driver's ->get_statistics callback if present to fetch
+ * newest statistics from the driver.
+ */
+int cpufreq_update_statistics(struct cpufreq_policy *policy)
+{
+	if (!cpufreq_driver || !policy)
+		return -EINVAL;
+
+	if (cpufreq_driver->get_statistics)
+		return cpufreq_driver->get_statistics(policy);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(cpufreq_update_statistics);
+#endif
+
 /*********************************************************************
  *               BOOST						     *
  *********************************************************************/
diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 94d959a8e954..d2d975b3cc6d 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -11,19 +11,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
-
-struct cpufreq_stats {
-	unsigned int total_trans;
-	unsigned long long last_time;
-	unsigned int max_state;
-	unsigned int state_num;
-	unsigned int last_index;
-	u64 *time_in_state;
-	spinlock_t lock;
-	unsigned int *freq_table;
-	unsigned int *trans_table;
-};
-
 static void cpufreq_stats_update(struct cpufreq_stats *stats)
 {
 	unsigned long long cur_time = get_jiffies_64();
@@ -50,13 +37,36 @@ static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
 }
 cpufreq_freq_attr_ro(total_trans);
 
+static ssize_t cpufreq_stats_present_driver_data(struct cpufreq_policy *policy, char *buf)
+{
+	struct cpufreq_stats *stats = policy->stats;
+	ssize_t len = 0;
+	int i, ret;
+
+	spin_lock(&stats->lock);
+	ret = cpufreq_update_statistics(policy);
+	spin_unlock(&stats->lock);
+
+	if (ret)
+		return 0;
+
+	for (i = 0; i < stats->state_num; i++) {
+		len += sprintf(buf + len, "%u %llu\n",
+				stats->freq_table[i],
+				stats->time_in_state[i]);
+	}
+	return len;
+}
+
 static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 {
 	struct cpufreq_stats *stats = policy->stats;
 	ssize_t len = 0;
 	int i;
 
-	if (policy->fast_switch_enabled)
+	if (policy->has_driver_stats)
+		return cpufreq_stats_present_driver_data(policy, buf);
+	else if (policy->fast_switch_enabled)
 		return 0;
 
 	spin_lock(&stats->lock);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index e62b022cb07e..21074703e08c 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -138,6 +138,14 @@ struct cpufreq_policy {
 	/* cpufreq-stats */
 	struct cpufreq_stats	*stats;
 
+	/*
+	 * Flag indicating that cpufreq statistics can be taken from device driver.
+	 * The statistics are collected by firmware and the driver is able to retrieve
+	 * them. It is useful when the 'fast switch' is used or the firmware changes
+	 * frequency independently due to e.g. thermal issues.
+	 */
+	bool			has_driver_stats;
+
 	/* For cpufreq driver's internal use */
 	void			*driver_data;
 
@@ -169,6 +177,18 @@ struct cpufreq_freqs {
 	u8 flags;		/* flags of cpufreq_driver, see below. */
 };
 
+struct cpufreq_stats {
+	unsigned int total_trans;
+	unsigned long long last_time;
+	unsigned int max_state;
+	unsigned int state_num;
+	unsigned int last_index;
+	u64 *time_in_state;
+	spinlock_t lock;
+	unsigned int *freq_table;
+	unsigned int *trans_table;
+};
+
 /* Only for ACPI */
 #define CPUFREQ_SHARED_TYPE_NONE (0) /* None */
 #define CPUFREQ_SHARED_TYPE_HW	 (1) /* HW does needed coordination */
@@ -245,11 +265,17 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy);
 void cpufreq_stats_free_table(struct cpufreq_policy *policy);
 void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
 				     unsigned int new_freq);
+int cpufreq_update_statistics(struct cpufreq_policy *policy);
 #else
 static inline void cpufreq_stats_create_table(struct cpufreq_policy *policy) { }
 static inline void cpufreq_stats_free_table(struct cpufreq_policy *policy) { }
 static inline void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
 						   unsigned int new_freq) { }
+static int __maybe_unused
+cpufreq_update_statistics(struct cpufreq_policy *policy)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_CPU_FREQ_STAT */
 
 /*********************************************************************
@@ -350,6 +376,12 @@ struct cpufreq_driver {
 	/* Called to update policy limits on firmware notifications. */
 	void		(*update_limits)(unsigned int cpu);
 
+	/*
+	 * Optional, used when driver can fetch statistics from firmware.
+	 * This callback function cannot sleep.
+	 */
+	int		(*get_statistics)(struct cpufreq_policy *policy);
+
 	/* optional */
 	int		(*bios_limit)(int cpu, unsigned int *limit);
 
-- 
2.17.1

