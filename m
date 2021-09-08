Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED1C403B32
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 16:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351761AbhIHOHB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 10:07:01 -0400
Received: from foss.arm.com ([217.140.110.172]:47166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351804AbhIHOHA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 10:07:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB3A11042;
        Wed,  8 Sep 2021 07:05:52 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8BC053F766;
        Wed,  8 Sep 2021 07:05:51 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v7 7/9] cpufreq: Introducing CPUFREQ_RELATION_E
Date:   Wed,  8 Sep 2021 15:05:28 +0100
Message-Id: <1631109930-290049-8-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631109930-290049-1-git-send-email-vincent.donnefort@arm.com>
References: <1631109930-290049-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This newly introduced flag can be applied by a governor to a CPUFreq
relation, when looking for a frequency within the policy table. The
resolution would then only walk through efficient frequencies.

Even with the flag set, the policy max limit will still be honoured. If no
efficient frequencies can be found within the limits of the policy, an
inefficient one would be returned.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index b49612895c78..e88b6b5dd913 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -470,7 +470,8 @@ static unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	if (policy->cached_target_freq == target_freq)
 		index = policy->cached_resolved_idx;
 	else
-		index = cpufreq_table_find_index_dl(policy, target_freq);
+		index = cpufreq_table_find_index_dl(policy, target_freq,
+						    false);
 
 	entry = &policy->freq_table[index];
 	next_freq = entry->frequency;
diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
index d0b10baf039a..6448e03bcf48 100644
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -91,7 +91,8 @@ static unsigned int amd_powersave_bias_target(struct cpufreq_policy *policy,
 			unsigned int index;
 
 			index = cpufreq_table_find_index_h(policy,
-							   policy->cur - 1);
+							   policy->cur - 1,
+							   relation & CPUFREQ_RELATION_E);
 			freq_next = policy->freq_table[index].frequency;
 		}
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 95b0464249d6..9edf4abc9fa0 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2264,8 +2264,16 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	    !(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS))
 		return 0;
 
-	if (cpufreq_driver->target)
+	if (cpufreq_driver->target) {
+		/*
+		 * If the driver hasn't setup a single inefficient frequency,
+		 * it's unlikely it knows how to decode CPUFREQ_RELATION_E.
+		 */
+		if (!policy->efficiencies_available)
+			relation &= ~CPUFREQ_RELATION_E;
+
 		return cpufreq_driver->target(policy, target_freq, relation);
+	}
 
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index eb4320b619c9..f68cad9abd11 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -83,9 +83,11 @@ static unsigned int generic_powersave_bias_target(struct cpufreq_policy *policy,
 	freq_avg = freq_req - freq_reduc;
 
 	/* Find freq bounds for freq_avg in freq_table */
-	index = cpufreq_table_find_index_h(policy, freq_avg);
+	index = cpufreq_table_find_index_h(policy, freq_avg,
+					   relation & CPUFREQ_RELATION_E);
 	freq_lo = freq_table[index].frequency;
-	index = cpufreq_table_find_index_l(policy, freq_avg);
+	index = cpufreq_table_find_index_l(policy, freq_avg,
+					   relation & CPUFREQ_RELATION_E);
 	freq_hi = freq_table[index].frequency;
 
 	/* Find out how long we have to be in hi and lo freqs */
diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 23a06cba392c..ed5b317574ec 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -933,7 +933,7 @@ static void powernv_cpufreq_work_fn(struct work_struct *work)
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy)
 			continue;
-		index = cpufreq_table_find_index_c(policy, policy->cur);
+		index = cpufreq_table_find_index_c(policy, policy->cur, false);
 		powernv_cpufreq_target_index(policy, index);
 		cpumask_andnot(&mask, &mask, policy->cpus);
 		cpufreq_cpu_put(policy);
@@ -1021,7 +1021,7 @@ static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
 	int index;
 	struct powernv_smp_call_data freq_data;
 
-	index = cpufreq_table_find_index_dl(policy, target_freq);
+	index = cpufreq_table_find_index_dl(policy, target_freq, false);
 	freq_data.pstate_id = powernv_freqs[index].driver_data;
 	freq_data.gpstate_id = powernv_freqs[index].driver_data;
 	set_pstate(&freq_data);
diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index ad7d4f272ddc..76c888ed8d16 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -243,7 +243,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 	new_freq = s5pv210_freq_table[index].frequency;
 
 	/* Finding current running level index */
-	priv_index = cpufreq_table_find_index_h(policy, old_freq);
+	priv_index = cpufreq_table_find_index_h(policy, old_freq, false);
 
 	arm_volt = dvs_conf[index].arm_volt;
 	int_volt = dvs_conf[index].int_volt;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 18b486a1c816..045565fe5b29 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -117,6 +117,13 @@ struct cpufreq_policy {
 	bool			strict_target;
 
 	/*
+	 * Set if inefficient frequencies were found in the frequency table.
+	 * This indicates if the relation flag CPUFREQ_RELATION_E can be
+	 * honored.
+	 */
+	bool			efficiencies_available;
+
+	/*
 	 * Preferred average time interval between consecutive invocations of
 	 * the driver to set the frequency for this policy.  To be set by the
 	 * scaling driver (0, which is the default, means no preference).
@@ -271,6 +278,8 @@ static inline void cpufreq_stats_record_transition(struct cpufreq_policy *policy
 #define CPUFREQ_RELATION_L 0  /* lowest frequency at or above target */
 #define CPUFREQ_RELATION_H 1  /* highest frequency below or at target */
 #define CPUFREQ_RELATION_C 2  /* closest frequency to target */
+/* relation flags */
+#define CPUFREQ_RELATION_E BIT(2) /* Get if possible an efficient frequency */
 
 struct freq_attr {
 	struct attribute attr;
@@ -742,6 +751,22 @@ static inline void dev_pm_opp_free_cpufreq_table(struct device *dev,
 			continue;					\
 		else
 
+/**
+ * cpufreq_for_each_efficient_entry_idx - iterate with index over a cpufreq
+ *	frequency_table excluding CPUFREQ_ENTRY_INVALID and
+ *	CPUFREQ_INEFFICIENT_FREQ frequencies.
+ * @pos: the &struct cpufreq_frequency_table to use as a loop cursor.
+ * @table: the &struct cpufreq_frequency_table to iterate over.
+ * @idx: the table entry currently being processed.
+ * @efficiencies: set to true to only iterate over efficient frequencies.
+ */
+
+#define cpufreq_for_each_efficient_entry_idx(pos, table, idx, efficiencies)	\
+	cpufreq_for_each_valid_entry_idx(pos, table, idx)			\
+		if (efficiencies && (pos->flags & CPUFREQ_INEFFICIENT_FREQ))	\
+			continue;						\
+		else
+
 
 int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
 				    struct cpufreq_frequency_table *table);
@@ -766,14 +791,15 @@ bool policy_has_boost_freq(struct cpufreq_policy *policy);
 
 /* Find lowest freq at or above target in a table in ascending order */
 static inline int cpufreq_table_find_index_al(struct cpufreq_policy *policy,
-					      unsigned int target_freq)
+					      unsigned int target_freq,
+					      bool efficiencies)
 {
 	struct cpufreq_frequency_table *table = policy->freq_table;
 	struct cpufreq_frequency_table *pos;
 	unsigned int freq;
 	int idx, best = -1;
 
-	cpufreq_for_each_valid_entry_idx(pos, table, idx) {
+	cpufreq_for_each_efficient_entry_idx(pos, table, idx, efficiencies) {
 		freq = pos->frequency;
 
 		if (freq >= target_freq)
@@ -787,14 +813,15 @@ static inline int cpufreq_table_find_index_al(struct cpufreq_policy *policy,
 
 /* Find lowest freq at or above target in a table in descending order */
 static inline int cpufreq_table_find_index_dl(struct cpufreq_policy *policy,
-					      unsigned int target_freq)
+					      unsigned int target_freq,
+					      bool efficiencies)
 {
 	struct cpufreq_frequency_table *table = policy->freq_table;
 	struct cpufreq_frequency_table *pos;
 	unsigned int freq;
 	int idx, best = -1;
 
-	cpufreq_for_each_valid_entry_idx(pos, table, idx) {
+	cpufreq_for_each_efficient_entry_idx(pos, table, idx, efficiencies) {
 		freq = pos->frequency;
 
 		if (freq == target_freq)
@@ -817,26 +844,30 @@ static inline int cpufreq_table_find_index_dl(struct cpufreq_policy *policy,
 
 /* Works only on sorted freq-tables */
 static inline int cpufreq_table_find_index_l(struct cpufreq_policy *policy,
-					     unsigned int target_freq)
+					     unsigned int target_freq,
+					     bool efficiencies)
 {
 	target_freq = clamp_val(target_freq, policy->min, policy->max);
 
 	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
-		return cpufreq_table_find_index_al(policy, target_freq);
+		return cpufreq_table_find_index_al(policy, target_freq,
+						   efficiencies);
 	else
-		return cpufreq_table_find_index_dl(policy, target_freq);
+		return cpufreq_table_find_index_dl(policy, target_freq,
+						   efficiencies);
 }
 
 /* Find highest freq at or below target in a table in ascending order */
 static inline int cpufreq_table_find_index_ah(struct cpufreq_policy *policy,
-					      unsigned int target_freq)
+					      unsigned int target_freq,
+					      bool efficiencies)
 {
 	struct cpufreq_frequency_table *table = policy->freq_table;
 	struct cpufreq_frequency_table *pos;
 	unsigned int freq;
 	int idx, best = -1;
 
-	cpufreq_for_each_valid_entry_idx(pos, table, idx) {
+	cpufreq_for_each_efficient_entry_idx(pos, table, idx, efficiencies) {
 		freq = pos->frequency;
 
 		if (freq == target_freq)
@@ -859,14 +890,15 @@ static inline int cpufreq_table_find_index_ah(struct cpufreq_policy *policy,
 
 /* Find highest freq at or below target in a table in descending order */
 static inline int cpufreq_table_find_index_dh(struct cpufreq_policy *policy,
-					      unsigned int target_freq)
+					      unsigned int target_freq,
+					      bool efficiencies)
 {
 	struct cpufreq_frequency_table *table = policy->freq_table;
 	struct cpufreq_frequency_table *pos;
 	unsigned int freq;
 	int idx, best = -1;
 
-	cpufreq_for_each_valid_entry_idx(pos, table, idx) {
+	cpufreq_for_each_efficient_entry_idx(pos, table, idx, efficiencies) {
 		freq = pos->frequency;
 
 		if (freq <= target_freq)
@@ -880,26 +912,30 @@ static inline int cpufreq_table_find_index_dh(struct cpufreq_policy *policy,
 
 /* Works only on sorted freq-tables */
 static inline int cpufreq_table_find_index_h(struct cpufreq_policy *policy,
-					     unsigned int target_freq)
+					     unsigned int target_freq,
+					     bool efficiencies)
 {
 	target_freq = clamp_val(target_freq, policy->min, policy->max);
 
 	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
-		return cpufreq_table_find_index_ah(policy, target_freq);
+		return cpufreq_table_find_index_ah(policy, target_freq,
+						   efficiencies);
 	else
-		return cpufreq_table_find_index_dh(policy, target_freq);
+		return cpufreq_table_find_index_dh(policy, target_freq,
+						   efficiencies);
 }
 
 /* Find closest freq to target in a table in ascending order */
 static inline int cpufreq_table_find_index_ac(struct cpufreq_policy *policy,
-					      unsigned int target_freq)
+					      unsigned int target_freq,
+					      bool efficiencies)
 {
 	struct cpufreq_frequency_table *table = policy->freq_table;
 	struct cpufreq_frequency_table *pos;
 	unsigned int freq;
 	int idx, best = -1;
 
-	cpufreq_for_each_valid_entry_idx(pos, table, idx) {
+	cpufreq_for_each_efficient_entry_idx(pos, table, idx, efficiencies) {
 		freq = pos->frequency;
 
 		if (freq == target_freq)
@@ -926,14 +962,15 @@ static inline int cpufreq_table_find_index_ac(struct cpufreq_policy *policy,
 
 /* Find closest freq to target in a table in descending order */
 static inline int cpufreq_table_find_index_dc(struct cpufreq_policy *policy,
-					      unsigned int target_freq)
+					      unsigned int target_freq,
+					      bool efficiencies)
 {
 	struct cpufreq_frequency_table *table = policy->freq_table;
 	struct cpufreq_frequency_table *pos;
 	unsigned int freq;
 	int idx, best = -1;
 
-	cpufreq_for_each_valid_entry_idx(pos, table, idx) {
+	cpufreq_for_each_efficient_entry_idx(pos, table, idx, efficiencies) {
 		freq = pos->frequency;
 
 		if (freq == target_freq)
@@ -960,35 +997,58 @@ static inline int cpufreq_table_find_index_dc(struct cpufreq_policy *policy,
 
 /* Works only on sorted freq-tables */
 static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
-					     unsigned int target_freq)
+					     unsigned int target_freq,
+					     bool efficiencies)
 {
 	target_freq = clamp_val(target_freq, policy->min, policy->max);
 
 	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
-		return cpufreq_table_find_index_ac(policy, target_freq);
+		return cpufreq_table_find_index_ac(policy, target_freq,
+						   efficiencies);
 	else
-		return cpufreq_table_find_index_dc(policy, target_freq);
+		return cpufreq_table_find_index_dc(policy, target_freq,
+						   efficiencies);
 }
 
 static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 						 unsigned int target_freq,
 						 unsigned int relation)
 {
+	bool efficiencies = policy->efficiencies_available &&
+			    (relation & CPUFREQ_RELATION_E);
+	int idx;
+
+	/* cpufreq_table_index_unsorted() has no use for this flag anyway */
+	relation &= ~CPUFREQ_RELATION_E;
+
 	if (unlikely(policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED))
 		return cpufreq_table_index_unsorted(policy, target_freq,
 						    relation);
-
+retry:
 	switch (relation) {
 	case CPUFREQ_RELATION_L:
-		return cpufreq_table_find_index_l(policy, target_freq);
+		idx = cpufreq_table_find_index_l(policy, target_freq,
+						 efficiencies);
+		break;
 	case CPUFREQ_RELATION_H:
-		return cpufreq_table_find_index_h(policy, target_freq);
+		idx = cpufreq_table_find_index_h(policy, target_freq,
+						 efficiencies);
+		break;
 	case CPUFREQ_RELATION_C:
-		return cpufreq_table_find_index_c(policy, target_freq);
+		idx = cpufreq_table_find_index_c(policy, target_freq,
+						 efficiencies);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
 	}
+
+	if (idx < 0 && efficiencies) {
+		efficiencies = false;
+		goto retry;
+	}
+
+	return idx;
 }
 
 static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy *policy)
@@ -1028,6 +1088,7 @@ cpufreq_table_set_inefficient(struct cpufreq_policy *policy,
 	cpufreq_for_each_valid_entry(pos, policy->freq_table) {
 		if (pos->frequency == frequency) {
 			pos->flags |= CPUFREQ_INEFFICIENT_FREQ;
+			policy->efficiencies_available = true;
 			return 0;
 		}
 	}
-- 
2.7.4

