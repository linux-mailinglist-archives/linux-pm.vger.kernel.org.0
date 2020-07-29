Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE2E23214D
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 17:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgG2PMc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 11:12:32 -0400
Received: from foss.arm.com ([217.140.110.172]:53422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgG2PMb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 11:12:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7E931063;
        Wed, 29 Jul 2020 08:12:30 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F1BD3F66E;
        Wed, 29 Jul 2020 08:12:28 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        viresh.kumar@linaro.org, lukasz.luba@arm.com, rjw@rjwysocki.net
Subject: [PATCH 4/4] cpufreq: scmi: Read statistics from FW shared memory
Date:   Wed, 29 Jul 2020 16:12:08 +0100
Message-Id: <20200729151208.27737-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729151208.27737-1-lukasz.luba@arm.com>
References: <20200729151208.27737-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for reading CPUFreq statistics from the firmware. The setup
code initializes needed structures per domain basis. The driver callback
scmi_cpufreq_stats_get is called by the CPUFreq framework and invokes
SCMI performance protocol in order to retrieve latest statistics.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 80 ++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index fe95350eb844..67ae63171dd0 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -22,6 +22,7 @@
 struct scmi_data {
 	int domain_id;
 	struct device *cpu_dev;
+	struct scmi_perf_domain_stats *stats;
 };
 
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu);
@@ -48,6 +49,34 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 
 static const struct scmi_handle *handle;
 
+static int scmi_cpufreq_stats_get(struct cpufreq_policy *policy)
+{
+	struct scmi_data *priv = policy->driver_data;
+	struct cpufreq_stats *stats = policy->stats;
+	int i, ret;
+
+	/*
+	 * Since the driver callback is global and can be set for all
+	 * policy objects, there is a need to check if that policy has
+	 * statistics in the shared memory.
+	 */
+	if (!policy->has_driver_stats)
+		return -EINVAL;
+
+	ret = handle->perf_ops->statistics_get(handle, priv->domain_id, priv->stats);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < priv->stats->state_num; i++)
+		stats->time_in_state[i] = priv->stats->time_in_state[i];
+
+	stats->total_trans = priv->stats->total_trans;
+	stats->last_index = priv->stats->last_index;
+	stats->last_time = priv->stats->last_time;
+
+	return ret;
+}
+
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
@@ -147,6 +176,45 @@ scmi_get_cpu_power(unsigned long *power, unsigned long *KHz,
 	return 0;
 }
 
+static int scmi_cpufreq_stats_init(struct cpufreq_policy *policy,
+				   struct scmi_data *priv, int nr_opp)
+{
+	struct scmi_perf_domain_stats *stats;
+	int ret;
+
+	stats = kzalloc(sizeof(struct scmi_perf_domain_stats), GFP_KERNEL);
+	if (!stats)
+		return -ENOMEM;
+
+	stats->time_in_state = kcalloc(nr_opp, sizeof(u64), GFP_KERNEL);
+	if (!stats->time_in_state) {
+		kfree(stats);
+		return -ENOMEM;
+	}
+
+	stats->freq_table = kcalloc(nr_opp, sizeof(unsigned int), GFP_KERNEL);
+	if (!stats->freq_table) {
+		kfree(stats->time_in_state);
+		kfree(stats);
+		return -ENOMEM;
+	}
+
+	priv->stats = stats;
+	priv->stats->state_num = nr_opp;
+	policy->has_driver_stats = true;
+	scmi_cpufreq_driver.get_statistics = scmi_cpufreq_stats_get;
+
+	ret = handle->perf_ops->statistics_get(handle, priv->domain_id, stats);
+	if (ret) {
+		kfree(stats->freq_table);
+		kfree(stats->time_in_state);
+		kfree(stats);
+		policy->has_driver_stats = false;
+	}
+
+	return ret;
+}
+
 static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret, nr_opp;
@@ -209,6 +277,10 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	/* SCMI allows DVFS request for any domain from any CPU */
 	policy->dvfs_possible_from_any_cpu = true;
 
+	ret = scmi_cpufreq_stats_init(policy, priv, nr_opp);
+	if (ret)
+		dev_warn(cpu_dev, "failed to init statistics: %d\n", ret);
+
 	latency = handle->perf_ops->transition_latency_get(handle, cpu_dev);
 	if (!latency)
 		latency = CPUFREQ_ETERNAL;
@@ -236,6 +308,14 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
 
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
+
+	if (priv->stats) {
+		policy->has_driver_stats = false;
+		kfree(priv->stats->time_in_state);
+		kfree(priv->stats->freq_table);
+		kfree(priv->stats);
+	}
+
 	kfree(priv);
 
 	return 0;
-- 
2.17.1

