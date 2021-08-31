Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B00E3FC59A
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 12:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbhHaKZh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 06:25:37 -0400
Received: from foss.arm.com ([217.140.110.172]:52918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240908AbhHaKZh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Aug 2021 06:25:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3C7212FC;
        Tue, 31 Aug 2021 03:24:41 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 799843F5A1;
        Tue, 31 Aug 2021 03:24:40 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v6 5/7] cpufreq: Add an interface to mark inefficient frequencies
Date:   Tue, 31 Aug 2021 11:24:11 +0100
Message-Id: <1630405453-275784-6-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
References: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some SoCs such as the sd855 have OPPs within the same policy whose cost is
higher than others with a higher frequency. Those OPPs are inefficients
and it might be interesting for a governor to not use them.

The inefficient interface is composed of two calls:

 1. cpufreq_table_set_inefficient() marks a frequency as inefficient.

 2. cpufreq_table_update_efficiencies() use the inefficiences marked by the
    previous function to generate a mapping inefficient->efficient.

Resolving an inefficient frequency to an efficient on can then be done
by accessing the cpufreq_frequency_table member "efficient". The
resolution doesn't guarantee the policy maximum.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 67e56cf638ef..d3fa38af2aa6 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -365,6 +365,59 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
 	return set_freq_table_sorted(policy);
 }
 
+/**
+ * cpufreq_table_update_efficiencies() - Update efficiency resolution
+ *
+ * @policy:	the &struct cpufreq_policy to update
+ *
+ * Allow quick resolution from inefficient frequencies to efficient ones.
+ * Inefficient frequencies must have been previously marked with
+ * cpufreq_table_set_inefficient().
+ *
+ * Return: %0 on success or a negative errno code
+ */
+int cpufreq_table_update_efficiencies(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
+	enum cpufreq_table_sorting sort = policy->freq_table_sorted;
+	int efficient, idx;
+
+	/* Not supported */
+	if (sort == CPUFREQ_TABLE_UNSORTED)
+		return -EINVAL;
+
+	/* The highest frequency is always efficient */
+	cpufreq_for_each_valid_entry_idx(pos, table, idx) {
+		efficient = idx;
+		if (sort == CPUFREQ_TABLE_SORTED_DESCENDING)
+			break;
+	}
+
+	for (;;) {
+		pos = &table[idx];
+
+		if (pos->frequency != CPUFREQ_ENTRY_INVALID) {
+			if (pos->flags & CPUFREQ_INEFFICIENT_FREQ) {
+				pos->efficient = efficient;
+			} else {
+				pos->efficient = idx;
+				efficient = idx;
+			}
+		}
+
+		if (sort == CPUFREQ_TABLE_SORTED_ASCENDING) {
+			if (--idx < 0)
+				break;
+		} else {
+			if (table[++idx].frequency == CPUFREQ_TABLE_END)
+				break;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_table_update_efficiencies);
+
 MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION("CPUfreq frequency table helpers");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c65a1d7385f8..4e901ebd104d 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -664,13 +664,15 @@ struct governor_attr {
 #define CPUFREQ_ENTRY_INVALID	~0u
 #define CPUFREQ_TABLE_END	~1u
 /* Special Values of .flags field */
-#define CPUFREQ_BOOST_FREQ	(1 << 0)
+#define CPUFREQ_BOOST_FREQ	 (1 << 0)
+#define CPUFREQ_INEFFICIENT_FREQ (1 << 1)
 
 struct cpufreq_frequency_table {
 	unsigned int	flags;
 	unsigned int	driver_data; /* driver specific data, not used by core */
 	unsigned int	frequency; /* kHz - doesn't need to be in ascending
 				    * order */
+	unsigned int	efficient; /* idx of an efficient frequency */
 };
 
 #if defined(CONFIG_CPU_FREQ) && defined(CONFIG_PM_OPP)
@@ -762,6 +764,7 @@ int cpufreq_boost_trigger_state(int state);
 int cpufreq_boost_enabled(void);
 int cpufreq_enable_boost_support(void);
 bool policy_has_boost_freq(struct cpufreq_policy *policy);
+int cpufreq_table_update_efficiencies(struct cpufreq_policy *policy);
 
 /* Find lowest freq at or above target in a table in ascending order */
 static inline int cpufreq_table_find_index_al(struct cpufreq_policy *policy,
@@ -1003,6 +1006,29 @@ static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy
 
 	return count;
 }
+
+/**
+ * cpufreq_table_set_inefficient() - Mark a frequency as inefficient
+ *
+ * @policy:	the &struct cpufreq_policy containing the inefficient frequency
+ * @frequency:	the inefficient frequency
+ *
+ * Once inefficiencies marked, the efficient resolution must be updated with the
+ * function cpufreq_table_update_efficiencies().
+ */
+static inline void
+cpufreq_table_set_inefficient(const struct cpufreq_policy *policy,
+			      unsigned int frequency)
+{
+	struct cpufreq_frequency_table *pos;
+
+	cpufreq_for_each_valid_entry(pos, policy->freq_table) {
+		if (pos->frequency == frequency) {
+			pos->flags |= CPUFREQ_INEFFICIENT_FREQ;
+			break;
+		}
+	}
+}
 #else
 static inline int cpufreq_boost_trigger_state(int state)
 {
@@ -1022,6 +1048,16 @@ static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
 {
 	return false;
 }
+
+static inline void
+cpufreq_table_set_inefficient(const struct cpufreq_policy *policy,
+			      unsigned int frequency) {}
+
+static inline int
+cpufreq_table_update_efficiencies(struct cpufreq_policy *policy)
+{
+	return -EINVAL;
+}
 #endif
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
-- 
2.7.4

