Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA1D3F83C9
	for <lists+linux-pm@lfdr.de>; Thu, 26 Aug 2021 10:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbhHZIhO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 04:37:14 -0400
Received: from foss.arm.com ([217.140.110.172]:41580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240327AbhHZIhO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Aug 2021 04:37:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3280513A1;
        Thu, 26 Aug 2021 01:36:27 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9341A3F5A1;
        Thu, 26 Aug 2021 01:36:25 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v5 5/8] cpufreq: Add an interface to mark inefficient frequencies
Date:   Thu, 26 Aug 2021 09:35:41 +0100
Message-Id: <1629966944-439570-6-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629966944-439570-1-git-send-email-vincent.donnefort@arm.com>
References: <1629966944-439570-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some SoCs such as the sd855 have OPPs within the same policy whose cost is
higher than others with a higher frequency. Those OPPs are inefficients
and it might be interesting for a governor to not use them.

Adding a flag, CPUFREQ_INEFFICIENT_FREQ, to mark such OPPs into the
frequency table, as well as a new cpufreq_frequency_table member
"efficient". This new member allows CPUFreq to resolve an inefficient
frequency to an efficient one.

Efficient frequencies point to themselves. The efficiency resolution must
check it doesn't break the policy maximum.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7d5f170ecad1..64ff3836955d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1504,6 +1504,8 @@ static int cpufreq_online(unsigned int cpu)
 		 */
 		if (cpufreq_driver->register_em)
 			cpufreq_driver->register_em(policy);
+
+		cpufreq_table_update_efficiencies(policy);
 	}
 
 	ret = cpufreq_init_policy(policy);
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 67e56cf638ef..c43320c57067 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -365,6 +365,52 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
 	return set_freq_table_sorted(policy);
 }
 
+void cpufreq_table_update_efficiencies(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
+	enum cpufreq_table_sorting sort = policy->freq_table_sorted;
+	int efficient, idx;
+
+	/* Not supported */
+	if (sort == CPUFREQ_TABLE_UNSORTED) {
+		cpufreq_for_each_entry_idx(pos, table, idx)
+			pos->efficient = idx;
+		return;
+	}
+
+	/* The highest frequency is always efficient */
+	cpufreq_for_each_entry_idx(pos, table, idx) {
+		if (pos->frequency == CPUFREQ_ENTRY_INVALID)
+			continue;
+
+		efficient = idx;
+
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
+}
+
 MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION("CPUfreq frequency table helpers");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c65a1d7385f8..4659921173f7 100644
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
@@ -1003,6 +1005,20 @@ static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy
 
 	return count;
 }
+
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
@@ -1022,6 +1038,10 @@ static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
 {
 	return false;
 }
+
+static inline int
+cpufreq_table_set_inefficient(const struct cpufreq_policy *policy,
+			      unsigned int frequency) {}
 #endif
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
@@ -1049,6 +1069,7 @@ extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
 extern struct freq_attr *cpufreq_generic_attr[];
 int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy);
+void cpufreq_table_update_efficiencies(struct cpufreq_policy *policy);
 
 unsigned int cpufreq_generic_get(unsigned int cpu);
 void cpufreq_generic_init(struct cpufreq_policy *policy,
-- 
2.7.4

