Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68ECF2107A5
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 11:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgGAJJn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 05:09:43 -0400
Received: from foss.arm.com ([217.140.110.172]:47798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbgGAJJf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Jul 2020 05:09:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63272113E;
        Wed,  1 Jul 2020 02:09:34 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B2323F68F;
        Wed,  1 Jul 2020 02:09:32 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, valentin.schneider@arm.com
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] cpufreq,drivers: remove setting of frequency scale factor
Date:   Wed,  1 Jul 2020 10:07:46 +0100
Message-Id: <20200701090751.7543-4-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701090751.7543-1-ionela.voinescu@arm.com>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As a result of setting the frequency scale factor in cpufreq core, after
callbacks that lend themselves to trigger it, remove this functionality
from the driver side.

For these drivers, the CPUFREQ_CUSTOM_SET_FREQ_SCALE flag is also removed,
to enable the use of the generic code on the cpufreq core side.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c      | 13 ++-----------
 drivers/cpufreq/qcom-cpufreq-hw.c | 12 ++----------
 drivers/cpufreq/scmi-cpufreq.c    | 21 ++++++---------------
 drivers/cpufreq/scpi-cpufreq.c    |  6 +-----
 4 files changed, 11 insertions(+), 41 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 8e0571a49d1e..9fd4ce774f12 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -40,16 +40,8 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct private_data *priv = policy->driver_data;
 	unsigned long freq = policy->freq_table[index].frequency;
-	int ret;
-
-	ret = dev_pm_opp_set_rate(priv->cpu_dev, freq * 1000);
 
-	if (!ret) {
-		arch_set_freq_scale(policy->related_cpus, freq,
-				    policy->cpuinfo.max_freq);
-	}
-
-	return ret;
+	return dev_pm_opp_set_rate(priv->cpu_dev, freq * 1000);
 }
 
 /*
@@ -331,8 +323,7 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver dt_cpufreq_driver = {
 	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-		 CPUFREQ_IS_COOLING_DEV |
-		 CPUFREQ_CUSTOM_SET_FREQ_SCALE,
+		 CPUFREQ_IS_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = set_target,
 	.get = cpufreq_generic_get,
diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index e13780beb373..e5d1ee7746a4 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -85,8 +85,6 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 	if (icc_scaling_enabled)
 		qcom_cpufreq_set_bw(policy, freq);
 
-	arch_set_freq_scale(policy->related_cpus, freq,
-			    policy->cpuinfo.max_freq);
 	return 0;
 }
 
@@ -113,7 +111,6 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 {
 	void __iomem *perf_state_reg = policy->driver_data;
 	int index;
-	unsigned long freq;
 
 	index = policy->cached_resolved_idx;
 	if (index < 0)
@@ -121,11 +118,7 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 
 	writel_relaxed(index, perf_state_reg);
 
-	freq = policy->freq_table[index].frequency;
-	arch_set_freq_scale(policy->related_cpus, freq,
-			    policy->cpuinfo.max_freq);
-
-	return freq;
+	return policy->freq_table[index].frequency;
 }
 
 static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
@@ -337,8 +330,7 @@ static struct freq_attr *qcom_cpufreq_hw_attr[] = {
 static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
-			  CPUFREQ_IS_COOLING_DEV |
-			  CPUFREQ_CUSTOM_SET_FREQ_SCALE,
+			  CPUFREQ_IS_COOLING_DEV,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= qcom_cpufreq_hw_target_index,
 	.get		= qcom_cpufreq_hw_get,
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 16ab4ecc75e4..a91a45c90274 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -48,16 +48,11 @@ static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
 static int
 scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	int ret;
 	struct scmi_data *priv = policy->driver_data;
 	struct scmi_perf_ops *perf_ops = handle->perf_ops;
 	u64 freq = policy->freq_table[index].frequency;
 
-	ret = perf_ops->freq_set(handle, priv->domain_id, freq * 1000, false);
-	if (!ret)
-		arch_set_freq_scale(policy->related_cpus, freq,
-				    policy->cpuinfo.max_freq);
-	return ret;
+	return perf_ops->freq_set(handle, priv->domain_id, freq * 1000, false);
 }
 
 static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
@@ -66,14 +61,11 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	struct scmi_data *priv = policy->driver_data;
 	struct scmi_perf_ops *perf_ops = handle->perf_ops;
 
-	if (!perf_ops->freq_set(handle, priv->domain_id,
-				target_freq * 1000, true)) {
-		arch_set_freq_scale(policy->related_cpus, target_freq,
-				    policy->cpuinfo.max_freq);
-		return target_freq;
-	}
+	if (perf_ops->freq_set(handle, priv->domain_id,
+				target_freq * 1000, true))
+		return 0;
 
-	return 0;
+	return target_freq;
 }
 
 static int
@@ -223,8 +215,7 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 	.name	= "scmi",
 	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
 		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-		  CPUFREQ_IS_COOLING_DEV |
-		  CPUFREQ_CUSTOM_SET_FREQ_SCALE,
+		  CPUFREQ_IS_COOLING_DEV,
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.attr	= cpufreq_generic_attr,
 	.target_index	= scmi_cpufreq_set_target,
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 6b5f56dc3ca3..5a399fb847b9 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -60,9 +60,6 @@ scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 	if (clk_get_rate(priv->clk) != rate)
 		return -EIO;
 
-	arch_set_freq_scale(policy->related_cpus, freq,
-			    policy->cpuinfo.max_freq);
-
 	return 0;
 }
 
@@ -197,8 +194,7 @@ static struct cpufreq_driver scpi_cpufreq_driver = {
 	.name	= "scpi-cpufreq",
 	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
 		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-		  CPUFREQ_IS_COOLING_DEV |
-		  CPUFREQ_CUSTOM_SET_FREQ_SCALE,
+		  CPUFREQ_IS_COOLING_DEV,
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.attr	= cpufreq_generic_attr,
 	.get	= scpi_cpufreq_get_rate,
-- 
2.17.1

