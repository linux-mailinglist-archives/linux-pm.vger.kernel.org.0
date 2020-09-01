Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE2E25A041
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 22:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgIAU4z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 16:56:55 -0400
Received: from foss.arm.com ([217.140.110.172]:50374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbgIAU4w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Sep 2020 16:56:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF31511D4;
        Tue,  1 Sep 2020 13:56:51 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 55CD53F66F;
        Tue,  1 Sep 2020 13:56:50 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, catalin.marinas@arm.com,
        sudeep.holla@arm.com, will@kernel.org, valentin.schneider@arm.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com
Subject: [PATCH v5 2/5] cpufreq: move invariance setter calls in cpufreq core
Date:   Tue,  1 Sep 2020 21:55:46 +0100
Message-Id: <20200901205549.30096-3-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901205549.30096-1-ionela.voinescu@arm.com>
References: <20200901205549.30096-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To properly scale its per-entity load-tracking signals, the task scheduler
needs to be given a frequency scale factor, i.e. some image of the current
frequency the CPU is running at. Currently, this scale can be computed
either by using counters (APERF/MPERF on x86, AMU on arm64), or by
piggy-backing on the frequency selection done by cpufreq.

For the latter, drivers have to explicitly set the scale factor
themselves, despite it being purely boiler-plate code: the required
information depends entirely on the kind of frequency switch callback
implemented by the driver, i.e. either of: target_index(), target(),
fast_switch() and setpolicy().

The fitness of those callbacks with regard to driving the Frequency
Invariance Engine (FIE) is studied below:

target_index()
==============
Documentation states that the chosen frequency "must be determined by
freq_table[index].frequency". It isn't clear if it *has* to be that
frequency, or if it can use that frequency value to do some computation
that ultimately leads to a different frequency selection. All drivers
go for the former, while the vexpress-spc-cpufreq has an atypical
implementation which is handled separately.

Therefore, the hook works on the assumption the core can use
freq_table[index].frequency.

target()
=======
This has been flagged as deprecated since:

  commit 9c0ebcf78fde ("cpufreq: Implement light weight ->target_index() routine")

It also doesn't have that many users:

  gx-suspmod.c:439:       .target = cpufreq_gx_target,
  s3c24xx-cpufreq.c:428:  .target = s3c_cpufreq_target,
  intel_pstate.c:2528:    .target = intel_cpufreq_target,
  cppc_cpufreq.c:401:     .target = cppc_cpufreq_set_target,
  cpufreq-nforce2.c:371:  .target = nforce2_target,
  sh-cpufreq.c:163:       .target = sh_cpufreq_target,
  pcc-cpufreq.c:573:      .target = pcc_cpufreq_target,

Similarly to the path taken for target_index() calls in the cpufreq core
during a frequency change, all of the drivers above will mark the end of a
frequency change by a call to cpufreq_freq_transition_end().

Therefore, cpufreq_freq_transition_end() can be used as the location for
the arch_set_freq_scale() call to potentially inform the scheduler of the
frequency change.

This change maintains the previous functionality for the drivers that
implement the target_index() callback, while also adding support for the
few drivers that implement the deprecated target() callback.

fast_switch()
=============
This callback *has* to return the frequency that was selected.

setpolicy()
===========
This callback does not have any designated way of informing what was the
end choice. But there are only two drivers using setpolicy(), and none
of them have current FIE support:

  drivers/cpufreq/longrun.c:281:	.setpolicy	= longrun_set_policy,
  drivers/cpufreq/intel_pstate.c:2215:	.setpolicy	= intel_pstate_set_policy,

The intel_pstate is known to use counter-driven frequency invariance.

Conclusion
==========

Given that the significant majority of current FIE enabled drivers use
callbacks that lend themselves to triggering the setting of the FIE scale
factor in a generic way, move the invariance setter calls to cpufreq core.

As a result of setting the frequency scale factor in cpufreq core, after
callbacks that lend themselves to trigger it, remove this functionality
from the driver side.

To be noted that despite marking a successful frequency change, many
cpufreq drivers will consider the new frequency as the requested
frequency, although this is might not be the one granted by the hardware.

Therefore, the call to arch_set_freq_scale() is a "best effort" one, and
it is up to the architecture if the new frequency is used in the new
frequency scale factor setting (determined by the implementation of
arch_set_freq_scale()) or eventually used by the scheduler (determined
by the implementation of arch_scale_freq_capacity()). The architecture
is in a better position to decide if it has better methods to obtain
more accurate information regarding the current frequency and use that
information instead (for example, the use of counters).

Also, the implementation to arch_set_freq_scale() will now have to handle
error conditions (current frequency == 0) in order to prevent the
overhead in cpufreq core when the default arch_set_freq_scale()
implementation is used.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Suggested-by: Valentin Schneider <valentin.schneider@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c           | 10 +---------
 drivers/cpufreq/cpufreq.c              | 12 +++++++++++-
 drivers/cpufreq/qcom-cpufreq-hw.c      |  9 +--------
 drivers/cpufreq/scmi-cpufreq.c         | 12 ++----------
 drivers/cpufreq/scpi-cpufreq.c         |  6 +-----
 drivers/cpufreq/vexpress-spc-cpufreq.c | 12 ++----------
 6 files changed, 18 insertions(+), 43 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index f0c2d3876dec..e363ae04aac6 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -58,16 +58,8 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
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
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 47aa90f9a7c2..4d5fe777184a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -446,6 +446,10 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
 
 	cpufreq_notify_post_transition(policy, freqs, transition_failed);
 
+	arch_set_freq_scale(policy->related_cpus,
+			    policy->cur,
+			    policy->cpuinfo.max_freq);
+
 	policy->transition_ongoing = false;
 	policy->transition_task = NULL;
 
@@ -2056,9 +2060,15 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
 unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq)
 {
+	unsigned int freq;
+
 	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	freq = cpufreq_driver->fast_switch(policy, target_freq);
+
+	arch_set_freq_scale(policy->related_cpus, freq,
+			    policy->cpuinfo.max_freq);
 
-	return cpufreq_driver->fast_switch(policy, target_freq);
+	return freq;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
 
diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 3fb044b907a8..aabe4306d92f 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -85,8 +85,6 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 	if (icc_scaling_enabled)
 		qcom_cpufreq_set_bw(policy, freq);
 
-	arch_set_freq_scale(policy->related_cpus, freq,
-			    policy->cpuinfo.max_freq);
 	return 0;
 }
 
@@ -113,16 +111,11 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 {
 	void __iomem *perf_state_reg = policy->driver_data;
 	unsigned int index;
-	unsigned long freq;
 
 	index = policy->cached_resolved_idx;
 	writel_relaxed(index, perf_state_reg);
 
-	freq = policy->freq_table[index].frequency;
-	arch_set_freq_scale(policy->related_cpus, freq,
-			    policy->cpuinfo.max_freq);
-
-	return freq;
+	return policy->freq_table[index].frequency;
 }
 
 static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index fb42e3390377..6dd1311660b5 100644
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
@@ -67,11 +62,8 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	struct scmi_perf_ops *perf_ops = handle->perf_ops;
 
 	if (!perf_ops->freq_set(handle, priv->domain_id,
-				target_freq * 1000, true)) {
-		arch_set_freq_scale(policy->related_cpus, target_freq,
-				    policy->cpuinfo.max_freq);
+				target_freq * 1000, true))
 		return target_freq;
-	}
 
 	return 0;
 }
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index b0f5388b8854..43db05b949d9 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -47,9 +47,8 @@ static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
 static int
 scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	unsigned long freq = policy->freq_table[index].frequency;
+	u64 rate = policy->freq_table[index].frequency * 1000;
 	struct scpi_data *priv = policy->driver_data;
-	u64 rate = freq * 1000;
 	int ret;
 
 	ret = clk_set_rate(priv->clk, rate);
@@ -60,9 +59,6 @@ scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 	if (clk_get_rate(priv->clk) != rate)
 		return -EIO;
 
-	arch_set_freq_scale(policy->related_cpus, freq,
-			    policy->cpuinfo.max_freq);
-
 	return 0;
 }
 
diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 4e8b1dee7c9a..e89b905754d2 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -182,7 +182,6 @@ static int ve_spc_cpufreq_set_target(struct cpufreq_policy *policy,
 {
 	u32 cpu = policy->cpu, cur_cluster, new_cluster, actual_cluster;
 	unsigned int freqs_new;
-	int ret;
 
 	cur_cluster = cpu_to_cluster(cpu);
 	new_cluster = actual_cluster = per_cpu(physical_cluster, cpu);
@@ -197,15 +196,8 @@ static int ve_spc_cpufreq_set_target(struct cpufreq_policy *policy,
 			new_cluster = A15_CLUSTER;
 	}
 
-	ret = ve_spc_cpufreq_set_rate(cpu, actual_cluster, new_cluster,
-				      freqs_new);
-
-	if (!ret) {
-		arch_set_freq_scale(policy->related_cpus, freqs_new,
-				    policy->cpuinfo.max_freq);
-	}
-
-	return ret;
+	return ve_spc_cpufreq_set_rate(cpu, actual_cluster, new_cluster,
+				       freqs_new);
 }
 
 static inline u32 get_table_count(struct cpufreq_frequency_table *table)
-- 
2.17.1

