Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832163F83CB
	for <lists+linux-pm@lfdr.de>; Thu, 26 Aug 2021 10:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbhHZIhV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 04:37:21 -0400
Received: from foss.arm.com ([217.140.110.172]:41608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240512AbhHZIhR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Aug 2021 04:37:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5D39101E;
        Thu, 26 Aug 2021 01:36:30 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 43E483F5A1;
        Thu, 26 Aug 2021 01:36:29 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v5 7/8] cpufreq: Read inefficiencies from EM
Date:   Thu, 26 Aug 2021 09:35:43 +0100
Message-Id: <1629966944-439570-8-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629966944-439570-1-git-send-email-vincent.donnefort@arm.com>
References: <1629966944-439570-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Energy Model has a 1:1 mapping between OPPs and performance states
(em_perf_state). If a CPUFreq driver registers an Energy Model,
inefficiencies found by the latter can be applied to CPUFreq.

This applies to all drivers using the generic callback
cpufreq_register_em_with_opp() for .register_em.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 2554dd1ec09d..50bf38ea2539 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1104,9 +1104,38 @@ void cpufreq_generic_init(struct cpufreq_policy *policy,
 		struct cpufreq_frequency_table *table,
 		unsigned int transition_latency);
 
+static inline void
+cpufreq_read_inefficiencies_from_em(struct cpufreq_policy *policy,
+				    struct em_perf_domain *em_pd)
+{
+	struct em_perf_state *em_table;
+	int i;
+
+	if (!em_pd)
+		return;
+
+	/* Inefficiencies support needs a sorted table */
+	if (!policy->freq_table ||
+	    policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED)
+		return;
+
+	em_table = em_pd->table;
+
+	for (i = 0; i < em_pd->nr_perf_states; i++) {
+		if (!(em_table[i].flags & EM_PERF_STATE_INEFFICIENT))
+			continue;
+
+		cpufreq_table_set_inefficient(policy,
+					      em_table[i].frequency);
+		em_pd->flags |= EM_PERF_DOMAIN_SKIP_INEFFICIENCIES;
+	}
+}
+
 static inline void cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
 {
-	dev_pm_opp_of_register_em(get_cpu_device(policy->cpu),
-				  policy->related_cpus);
+	struct device *cpu_dev = get_cpu_device(policy->cpu);
+
+	dev_pm_opp_of_register_em(cpu_dev, policy->related_cpus);
+	cpufreq_read_inefficiencies_from_em(policy, em_pd_get(cpu_dev));
 }
 #endif /* _LINUX_CPUFREQ_H */
-- 
2.7.4

