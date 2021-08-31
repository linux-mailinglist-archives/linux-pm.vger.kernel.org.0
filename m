Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934483FC59B
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 12:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbhHaKZj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 06:25:39 -0400
Received: from foss.arm.com ([217.140.110.172]:52930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240962AbhHaKZi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Aug 2021 06:25:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D61F139F;
        Tue, 31 Aug 2021 03:24:43 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 22A5B3F5A1;
        Tue, 31 Aug 2021 03:24:42 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v6 6/7] cpufreq: Skip inefficient frequencies
Date:   Tue, 31 Aug 2021 11:24:12 +0100
Message-Id: <1630405453-275784-7-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
References: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CPUFreq governors that do DVFS (i.e. CPUFREQ_GOV_DYNAMIC_SWITCHING flag)
can skip frequencies marked as inefficient, as long as the efficient
frequency found meet the policy maximum requirement.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7d5f170ecad1..b46fe2d7baf1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2295,6 +2295,44 @@ __weak struct cpufreq_governor *cpufreq_fallback_governor(void)
 	return NULL;
 }
 
+static inline bool
+cpufreq_can_skip_inefficiencies(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *pos;
+	bool valid = false;
+	int idx;
+
+	if (!(policy->governor->flags & CPUFREQ_GOV_DYNAMIC_SWITCHING))
+		return false;
+
+	if (policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED)
+		return false;
+
+	/* Is there at least one inefficiency ? */
+	cpufreq_for_each_valid_entry(pos, policy->freq_table) {
+		if (pos->flags & CPUFREQ_INEFFICIENT_FREQ) {
+			valid = true;
+			break;
+		}
+	}
+
+	if (!valid)
+		return false;
+
+	/*
+	 * Has cpufreq_table_update_efficiencies been called? i.e. is the
+	 * highest frequency efficient.
+	 */
+	cpufreq_for_each_valid_entry_idx(pos, policy->freq_table, idx) {
+		valid = !!(idx == pos->efficient);
+		if (policy->freq_table_sorted ==
+					CPUFREQ_TABLE_SORTED_DESCENDING)
+			break;
+	}
+
+	return valid;
+}
+
 static int cpufreq_init_governor(struct cpufreq_policy *policy)
 {
 	int ret;
@@ -2337,6 +2375,7 @@ static int cpufreq_init_governor(struct cpufreq_policy *policy)
 	}
 
 	policy->strict_target = !!(policy->governor->flags & CPUFREQ_GOV_STRICT_TARGET);
+	policy->skip_inefficiencies = cpufreq_can_skip_inefficiencies(policy);
 
 	return 0;
 }
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 4e901ebd104d..cb09afbf01e2 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -117,6 +117,13 @@ struct cpufreq_policy {
 	bool			strict_target;
 
 	/*
+	 * Set if the CPUFREQ_GOV_DYNAMIC_SWITCHING flag is set for the current
+	 * governor and if inefficient frequencies were found in the frequency
+	 * table.
+	 */
+	bool			skip_inefficiencies;
+
+	/*
 	 * Preferred average time interval between consecutive invocations of
 	 * the driver to set the frequency for this policy.  To be set by the
 	 * scaling driver (0, which is the default, means no preference).
@@ -972,25 +979,46 @@ static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
 		return cpufreq_table_find_index_dc(policy, target_freq);
 }
 
+static inline unsigned int
+cpufreq_frequency_find_efficient(struct cpufreq_policy *policy,
+				 unsigned int idx)
+{
+	struct cpufreq_frequency_table *table = policy->freq_table;
+	unsigned int efficient_idx = table[idx].efficient;
+
+	return table[efficient_idx].frequency <= policy->max ? efficient_idx :
+		idx;
+}
+
 static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 						 unsigned int target_freq,
 						 unsigned int relation)
 {
+	int idx;
+
 	if (unlikely(policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED))
 		return cpufreq_table_index_unsorted(policy, target_freq,
 						    relation);
 
 	switch (relation) {
 	case CPUFREQ_RELATION_L:
-		return cpufreq_table_find_index_l(policy, target_freq);
+		idx = cpufreq_table_find_index_l(policy, target_freq);
+		break;
 	case CPUFREQ_RELATION_H:
-		return cpufreq_table_find_index_h(policy, target_freq);
+		idx = cpufreq_table_find_index_h(policy, target_freq);
+		break;
 	case CPUFREQ_RELATION_C:
-		return cpufreq_table_find_index_c(policy, target_freq);
+		idx = cpufreq_table_find_index_c(policy, target_freq);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
 	}
+
+	if (policy->skip_inefficiencies)
+		idx = cpufreq_frequency_find_efficient(policy, idx);
+
+	return idx;
 }
 
 static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy *policy)
-- 
2.7.4

