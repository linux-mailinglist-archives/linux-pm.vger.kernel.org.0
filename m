Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 715C0F7A62
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 19:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKKSA2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 13:00:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:33910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726924AbfKKSA2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Nov 2019 13:00:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F090B24D;
        Mon, 11 Nov 2019 18:00:26 +0000 (UTC)
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
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 6/6] x86: intel_pstate: handle runtime turbo disablement/enablement in freq. invariance
Date:   Mon, 11 Nov 2019 19:05:49 +0100
Message-Id: <20191111180549.12166-7-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191111180549.12166-1-ggherdovich@suse.cz>
References: <20191111180549.12166-1-ggherdovich@suse.cz>
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
function to swap between 1024 and freq_max every time turbo goes off or on.

Reminder: "freq_max" isn't really the maximum frequency but the ratio
turbo_freq*1024/base_freq, which becomes 1024 when turbo is disabled. The name
could be misleading but makes explainations a lot simpler and is really
convenient in calculations.

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 arch/x86/include/asm/topology.h |  2 ++
 arch/x86/kernel/smpboot.c       | 14 ++++++++++----
 drivers/cpufreq/intel_pstate.c  |  1 +
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 9b3aca463c8f..5c36fa1a6f3e 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -214,6 +214,8 @@ static inline long arch_scale_freq_capacity(int cpu)
 extern void arch_scale_freq_tick(void);
 #define arch_scale_freq_tick arch_scale_freq_tick
 
+extern void set_arch_max_freq(bool turbo_disabled);
+
 #endif
 
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8988177064be..f94aa1dfc778 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1807,8 +1807,15 @@ DEFINE_STATIC_KEY_FALSE(arch_scale_freq_key);
 
 static DEFINE_PER_CPU(u64, arch_prev_aperf);
 static DEFINE_PER_CPU(u64, arch_prev_mperf);
+static u64 arch_max_turbo_freq = SCHED_CAPACITY_SCALE;
 static u64 arch_max_freq = SCHED_CAPACITY_SCALE;
 
+void set_arch_max_freq(bool turbo_disabled)
+{
+	arch_max_freq = turbo_disabled ? SCHED_CAPACITY_SCALE :
+					arch_max_turbo_freq;
+}
+
 static bool turbo_disabled(void)
 {
 	u64 misc_en;
@@ -2004,9 +2011,6 @@ static void intel_set_cpu_max_freq(void)
 {
 	u64 ratio = 1, turbo_ratio = 1;
 
-	if (turbo_disabled())
-		return;
-
 	if (slv_set_cpu_max_freq(&ratio, &turbo_ratio))
 		goto set_value;
 
@@ -2022,7 +2026,9 @@ static void intel_set_cpu_max_freq(void)
 	core_set_cpu_max_freq(&ratio, &turbo_ratio);
 
 set_value:
-	arch_max_freq = div_u64(turbo_ratio * SCHED_CAPACITY_SCALE, ratio);
+	arch_max_turbo_freq = div_u64(turbo_ratio * SCHED_CAPACITY_SCALE,
+					ratio);
+	set_arch_max_freq(turbo_disabled());
 	static_branch_enable(&arch_scale_freq_key);
 }
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8ab31702cf6a..6bf50783bc24 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -922,6 +922,7 @@ static void intel_pstate_update_limits(unsigned int cpu)
 	 */
 	if (global.turbo_disabled_mf != global.turbo_disabled) {
 		global.turbo_disabled_mf = global.turbo_disabled;
+		set_arch_max_freq(global.turbo_disabled);
 		for_each_possible_cpu(cpu)
 			intel_pstate_update_max_freq(cpu);
 	} else {
-- 
2.16.4

