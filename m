Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2EC145878
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 16:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgAVPKt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 10:10:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:39578 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgAVPKg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Jan 2020 10:10:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7EB35AD11;
        Wed, 22 Jan 2020 15:10:33 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH v5 6/6] x86: intel_pstate: handle runtime turbo disablement/enablement in freq. invariance
Date:   Wed, 22 Jan 2020 16:16:17 +0100
Message-Id: <20200122151617.531-7-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200122151617.531-1-ggherdovich@suse.cz>
References: <20200122151617.531-1-ggherdovich@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On some platforms such as the Dell XPS 13 laptop the firmware disables turbo
when the machine is disconnected from AC, and viceversa it enables it again
when it's reconnected. In these cases a _PPC ACPI notification is issued.

The scheduler needs to know freq_max for frequency-invariant calculations.
To account for turbo availability to come and go, record freq_max at boot as
if turbo was available and store it in a helper variable. Use a setter
function to swap between freq_base and freq_max every time turbo goes off or on.

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 arch/x86/include/asm/topology.h |  5 +++++
 arch/x86/kernel/smpboot.c       | 15 ++++++++++-----
 drivers/cpufreq/intel_pstate.c  |  1 +
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 2ebf7b7b2126..79d8d5496330 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -211,6 +211,11 @@ static inline long arch_scale_freq_capacity(int cpu)
 extern void arch_scale_freq_tick(void);
 #define arch_scale_freq_tick arch_scale_freq_tick
 
+extern void arch_set_max_freq_ratio(bool turbo_disabled);
+#else
+static inline void arch_set_max_freq_ratio(bool turbo_disabled)
+{
+}
 #endif
 
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 5f04bf8419f9..467191e51196 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1807,8 +1807,15 @@ DEFINE_STATIC_KEY_FALSE(arch_scale_freq_key);
 
 static DEFINE_PER_CPU(u64, arch_prev_aperf);
 static DEFINE_PER_CPU(u64, arch_prev_mperf);
+static u64 arch_turbo_freq_ratio = SCHED_CAPACITY_SCALE;
 static u64 arch_max_freq_ratio = SCHED_CAPACITY_SCALE;
 
+void arch_set_max_freq_ratio(bool turbo_disabled)
+{
+	arch_max_freq_ratio = turbo_disabled ? SCHED_CAPACITY_SCALE :
+					arch_turbo_freq_ratio;
+}
+
 static bool turbo_disabled(void)
 {
 	u64 misc_en;
@@ -1956,10 +1963,7 @@ static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 
 static bool intel_set_max_freq_ratio(void)
 {
-	u64 base_freq = 1, turbo_freq = 1;
-
-	if (turbo_disabled())
-		goto out;
+	u64 base_freq, turbo_freq;
 
 	if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
 		goto out;
@@ -1981,8 +1985,9 @@ static bool intel_set_max_freq_ratio(void)
 	return false;
 
 out:
-	arch_max_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
+	arch_turbo_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
 					base_freq);
+	arch_set_max_freq_ratio(turbo_disabled());
 	return true;
 }
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index d2fa3e9ccd97..abbeeca8bb3b 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -922,6 +922,7 @@ static void intel_pstate_update_limits(unsigned int cpu)
 	 */
 	if (global.turbo_disabled_mf != global.turbo_disabled) {
 		global.turbo_disabled_mf = global.turbo_disabled;
+		arch_set_max_freq_ratio(global.turbo_disabled);
 		for_each_possible_cpu(cpu)
 			intel_pstate_update_max_freq(cpu);
 	} else {
-- 
2.16.4

