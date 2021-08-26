Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FCC3F83CA
	for <lists+linux-pm@lfdr.de>; Thu, 26 Aug 2021 10:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbhHZIhQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 04:37:16 -0400
Received: from foss.arm.com ([217.140.110.172]:41596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240327AbhHZIhQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Aug 2021 04:37:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AA33D6E;
        Thu, 26 Aug 2021 01:36:29 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6BDCE3F5A1;
        Thu, 26 Aug 2021 01:36:27 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v5 6/8] cpufreq: Skip inefficient frequencies
Date:   Thu, 26 Aug 2021 09:35:42 +0100
Message-Id: <1629966944-439570-7-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629966944-439570-1-git-send-email-vincent.donnefort@arm.com>
References: <1629966944-439570-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CPUFreq governors that do DVFS (i.e. CPUFREQ_GOV_DYNAMIC_SWITCHING flag)
can skip frequencies marked as inefficient, as long as the efficient
frequency found meet the policy maximum requirement.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 64ff3836955d..936b92a09785 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2299,6 +2299,7 @@ __weak struct cpufreq_governor *cpufreq_fallback_governor(void)
 
 static int cpufreq_init_governor(struct cpufreq_policy *policy)
 {
+	struct cpufreq_frequency_table *pos;
 	int ret;
 
 	/* Don't start any governor operations if we are entering suspend */
@@ -2340,6 +2341,16 @@ static int cpufreq_init_governor(struct cpufreq_policy *policy)
 
 	policy->strict_target = !!(policy->governor->flags & CPUFREQ_GOV_STRICT_TARGET);
 
+	policy->skip_inefficiencies = false;
+	if (policy->governor->flags & CPUFREQ_GOV_DYNAMIC_SWITCHING) {
+		cpufreq_for_each_valid_entry(pos, policy->freq_table) {
+			if (pos->flags & CPUFREQ_INEFFICIENT_FREQ) {
+				policy->skip_inefficiencies = true;
+				break;
+			}
+		}
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 4659921173f7..2554dd1ec09d 100644
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
@@ -971,25 +978,46 @@ static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
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

