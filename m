Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EFB22951E
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jul 2020 11:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbgGVJik (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jul 2020 05:38:40 -0400
Received: from foss.arm.com ([217.140.110.172]:53016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGVJij (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Jul 2020 05:38:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48B021045;
        Wed, 22 Jul 2020 02:38:39 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D0C23F66F;
        Wed, 22 Jul 2020 02:38:37 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, catalin.marinas@arm.com,
        sudeep.holla@arm.com, will@kernel.org, linux@armlinux.org.uk
Cc:     mingo@redhat.com, peterz@infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH v2 2/7] cpufreq: set invariance scale factor on transition end
Date:   Wed, 22 Jul 2020 10:37:27 +0100
Message-Id: <20200722093732.14297-3-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722093732.14297-1-ionela.voinescu@arm.com>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While the move of the invariance setter calls (arch_set_freq_scale())
from cpufreq drivers to cpufreq core maintained the previous
functionality for existing drivers that use target_index() and
fast_switch() for frequency switching, it also gives the possibility
of adding support for users of the target() callback, which is exploited
here.

To be noted that the target() callback has been flagged as deprecated
since:

commit 9c0ebcf78fde ("cpufreq: Implement light weight ->target_index() routine")

It also doesn't have that many users:

  cpufreq-nforce2.c:371:2:      .target = nforce2_target,
  cppc_cpufreq.c:416:2:         .target = cppc_cpufreq_set_target,
  gx-suspmod.c:439:2:           .target = cpufreq_gx_target,
  pcc-cpufreq.c:573:2:          .target = pcc_cpufreq_target,

Similarly to the path taken for target_index() calls in the cpufreq core
during a frequency change, all of the drivers above will mark the end of a
frequency change by a call to cpufreq_freq_transition_end().

Therefore, cpufreq_freq_transition_end() can be used as the location for
the arch_set_freq_scale() call to potentially inform the scheduler of the
frequency change.

This change maintains the previous functionality for the drivers that
implement the target_index() callback, while also adding support for the
few drivers that implement the deprecated target() callback.

Two notes are worthwhile here:
 - In __target_index(), cpufreq_freq_transition_end() is called only for
   drivers that have synchronous notifications enabled. There is only one
   driver that disables them,

   drivers/cpufreq/powernow-k8.c:1142: .flags = CPUFREQ_ASYNC_NOTIFICATION,

   which is deprecated.

 - Despite marking a successful frequency change, many cpufreq drivers
   will populate the new policy->cur with the new requested frequency,
   although this might not be the one granted by the hardware.

   Therefore, the call to arch_set_freq_scale() is a "best effort" one,
   and it is up to the architecture if the new frequency is used in the
   new frequency scale factor setting or eventually used by the scheduler.
   The architecture is in a better position to decide if it has better
   methods to obtain more accurate information regarding the current
   frequency (for example the use of counters).

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index bac4101546db..3497c1cd6818 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -448,6 +448,10 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
 
 	cpufreq_notify_post_transition(policy, freqs, transition_failed);
 
+	arch_set_freq_scale(policy->related_cpus,
+			    policy->cur,
+			    policy->cpuinfo.max_freq);
+
 	policy->transition_ongoing = false;
 	policy->transition_task = NULL;
 
@@ -2159,7 +2163,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			    unsigned int relation)
 {
 	unsigned int old_target_freq = target_freq;
-	int index, retval;
+	int index;
 
 	if (cpufreq_disabled())
 		return -ENODEV;
@@ -2190,14 +2194,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 
 	index = cpufreq_frequency_table_target(policy, target_freq, relation);
 
-	retval = __target_index(policy, index);
-
-	if (!retval)
-		arch_set_freq_scale(policy->related_cpus,
-				    policy->freq_table[index].frequency,
-				    policy->cpuinfo.max_freq);
-
-	return retval;
+	return __target_index(policy, index);
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 
-- 
2.17.1

