Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B981DC2E9
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 12:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439167AbfJRKiq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 06:38:46 -0400
Received: from [217.140.110.172] ([217.140.110.172]:34262 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2439166AbfJRKiq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Oct 2019 06:38:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 755D3C8F;
        Fri, 18 Oct 2019 03:38:05 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8CA923F6C4;
        Fri, 18 Oct 2019 03:38:04 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: [PATCH v3 5/5] cpufreq: vexpress-spc: fix some coding style issues
Date:   Fri, 18 Oct 2019 11:37:49 +0100
Message-Id: <20191018103749.11226-6-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018103749.11226-1-sudeep.holla@arm.com>
References: <20191018103749.11226-1-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following checkpatch checks/warnings:

CHECK: Unnecessary parentheses around the code
CHECK: Alignment should match open parenthesis
CHECK: Prefer kernel type 'u32' over 'uint32_t'
WARNING: Missing a blank line after declarations

Acked-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/vexpress-spc-cpufreq.c | 36 +++++++++++++-------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 132610424747..3259498d7eaa 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -79,8 +79,8 @@ static unsigned int find_cluster_maxfreq(int cluster)
 	for_each_online_cpu(j) {
 		cpu_freq = per_cpu(cpu_last_req_freq, j);
 
-		if ((cluster == per_cpu(physical_cluster, j)) &&
-				(max_freq < cpu_freq))
+		if (cluster == per_cpu(physical_cluster, j) &&
+		    max_freq < cpu_freq)
 			max_freq = cpu_freq;
 	}
 
@@ -190,13 +190,11 @@ static int ve_spc_cpufreq_set_target(struct cpufreq_policy *policy,
 	freqs_new = freq_table[cur_cluster][index].frequency;
 
 	if (is_bL_switching_enabled()) {
-		if ((actual_cluster == A15_CLUSTER) &&
-				(freqs_new < clk_big_min)) {
+		if (actual_cluster == A15_CLUSTER && freqs_new < clk_big_min)
 			new_cluster = A7_CLUSTER;
-		} else if ((actual_cluster == A7_CLUSTER) &&
-				(freqs_new > clk_little_max)) {
+		else if (actual_cluster == A7_CLUSTER &&
+			 freqs_new > clk_little_max)
 			new_cluster = A15_CLUSTER;
-		}
 	}
 
 	ret = ve_spc_cpufreq_set_rate(cpu, actual_cluster, new_cluster,
@@ -224,7 +222,8 @@ static inline u32 get_table_count(struct cpufreq_frequency_table *table)
 static inline u32 get_table_min(struct cpufreq_frequency_table *table)
 {
 	struct cpufreq_frequency_table *pos;
-	uint32_t min_freq = ~0;
+	u32 min_freq = ~0;
+
 	cpufreq_for_each_entry(pos, table)
 		if (pos->frequency < min_freq)
 			min_freq = pos->frequency;
@@ -235,7 +234,8 @@ static inline u32 get_table_min(struct cpufreq_frequency_table *table)
 static inline u32 get_table_max(struct cpufreq_frequency_table *table)
 {
 	struct cpufreq_frequency_table *pos;
-	uint32_t max_freq = 0;
+	u32 max_freq = 0;
+
 	cpufreq_for_each_entry(pos, table)
 		if (pos->frequency > max_freq)
 			max_freq = pos->frequency;
@@ -259,10 +259,9 @@ static int merge_cluster_tables(void)
 	/* Add in reverse order to get freqs in increasing order */
 	for (i = MAX_CLUSTERS - 1; i >= 0; i--) {
 		for (j = 0; freq_table[i][j].frequency != CPUFREQ_TABLE_END;
-				j++) {
-			table[k].frequency = VIRT_FREQ(i,
-					freq_table[i][j].frequency);
-			k++;
+		     j++, k++) {
+			table[k].frequency =
+				VIRT_FREQ(i, freq_table[i][j].frequency);
 		}
 	}
 
@@ -335,13 +334,13 @@ static int _get_cluster_clk_and_freq_table(struct device *cpu_dev,
 		return 0;
 
 	dev_err(cpu_dev, "%s: Failed to get clk for cpu: %d, cluster: %d\n",
-			__func__, cpu_dev->id, cluster);
+		__func__, cpu_dev->id, cluster);
 	ret = PTR_ERR(clk[cluster]);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
 
 out:
 	dev_err(cpu_dev, "%s: Failed to get data for cluster: %d\n", __func__,
-			cluster);
+		cluster);
 	return ret;
 }
 
@@ -411,7 +410,7 @@ static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
 		pr_err("%s: failed to get cpu%d device\n", __func__,
-				policy->cpu);
+		       policy->cpu);
 		return -ENODEV;
 	}
 
@@ -437,7 +436,8 @@ static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
 	dev_pm_opp_of_register_em(policy->cpus);
 
 	if (is_bL_switching_enabled())
-		per_cpu(cpu_last_req_freq, policy->cpu) = clk_get_cpu_rate(policy->cpu);
+		per_cpu(cpu_last_req_freq, policy->cpu) =
+						clk_get_cpu_rate(policy->cpu);
 
 	dev_info(cpu_dev, "%s: CPU %d initialized\n", __func__, policy->cpu);
 	return 0;
@@ -456,7 +456,7 @@ static int ve_spc_cpufreq_exit(struct cpufreq_policy *policy)
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
 		pr_err("%s: failed to get cpu%d device\n", __func__,
-				policy->cpu);
+		       policy->cpu);
 		return -ENODEV;
 	}
 
-- 
2.17.1

