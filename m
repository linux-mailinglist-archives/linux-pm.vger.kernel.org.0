Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AA92107A0
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 11:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgGAJJc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 05:09:32 -0400
Received: from foss.arm.com ([217.140.110.172]:47772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgGAJJb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Jul 2020 05:09:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDD0B106F;
        Wed,  1 Jul 2020 02:09:30 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3489D3F68F;
        Wed,  1 Jul 2020 02:09:29 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, valentin.schneider@arm.com
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] cpufreq: move invariance setter calls in cpufreq core
Date:   Wed,  1 Jul 2020 10:07:45 +0100
Message-Id: <20200701090751.7543-3-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701090751.7543-1-ionela.voinescu@arm.com>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

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
implementation.

Thefore, the hook works on the asusmption the core can use
freq_table[index].frequency.

target()
=======
This has been flagged as deprecated since:

  commit 9c0ebcf78fde ("cpufreq: Implement light weight ->target_index() routine")

It also doesn't have that many users:

  cpufreq-nforce2.c:371:2:	.target = nforce2_target,
  cppc_cpufreq.c:416:2:		.target = cppc_cpufreq_set_target,
  pcc-cpufreq.c:573:2:		.target = pcc_cpufreq_target,

Should we care about drivers using this hook, we may be able to exploit
cpufreq_freq_transition_{being, end}(). Otherwise, if FIE support is
desired in their current state, arch_set_freq_scale() could still be
called directly by the driver, while CPUFREQ_CUSTOM_SET_FREQ_SCALE
could be used to mark support for it.

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

If FIE support is desired in their current state, arch_set_freq_scale()
could still be called directly by the driver, while
CPUFREQ_CUSTOM_SET_FREQ_SCALE could be used to mark support for it.

Conclusion
==========

Given that the significant majority of current FIE enabled drivers use
callbacks that lend themselves to triggering the setting of the FIE scale
factor in a generic way, move the invariance setter calls to cpufreq core,
while filtering drivers that flag custom support using
CPUFREQ_CUSTOM_SET_FREQ_SCALE.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0128de3603df..83b58483a39b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2046,9 +2046,16 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
 unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq)
 {
+	unsigned int freq;
+
 	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	freq = cpufreq_driver->fast_switch(policy, target_freq);
+
+	if (freq && !(cpufreq_driver->flags & CPUFREQ_CUSTOM_SET_FREQ_SCALE))
+		arch_set_freq_scale(policy->related_cpus, freq,
+				    policy->cpuinfo.max_freq);
 
-	return cpufreq_driver->fast_switch(policy, target_freq);
+	return freq;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
 
@@ -2140,7 +2147,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			    unsigned int relation)
 {
 	unsigned int old_target_freq = target_freq;
-	int index;
+	int index, retval;
 
 	if (cpufreq_disabled())
 		return -ENODEV;
@@ -2171,7 +2178,14 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 
 	index = cpufreq_frequency_table_target(policy, target_freq, relation);
 
-	return __target_index(policy, index);
+	retval = __target_index(policy, index);
+
+	if (!retval && !(cpufreq_driver->flags & CPUFREQ_CUSTOM_SET_FREQ_SCALE))
+		arch_set_freq_scale(policy->related_cpus,
+				    policy->freq_table[index].frequency,
+				    policy->cpuinfo.max_freq);
+
+	return retval;
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 
-- 
2.17.1

