Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14DE1AB77D
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 07:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406990AbgDPFsO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 01:48:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:38452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406805AbgDPFsM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Apr 2020 01:48:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8B068AD7C;
        Thu, 16 Apr 2020 05:48:09 +0000 (UTC)
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
        Doug Smythies <dsmythies@telus.net>,
        Like Xu <like.xu@linux.intel.com>,
        Neil Rickert <nwr10cst-oslnx@yahoo.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 3/4] x86, sched: Don't enable static key when starting secondary CPUs
Date:   Thu, 16 Apr 2020 07:47:44 +0200
Message-Id: <20200416054745.740-4-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200416054745.740-1-ggherdovich@suse.cz>
References: <20200416054745.740-1-ggherdovich@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

The static key arch_scale_freq_key only needs to be enabled once (at
boot). This change fixes a bug by which the key was enabled every time cpu0
is started, even as a secondary CPU during cpu hotplug. Secondary CPUs are
started from the idle thread: setting a static key from there means
acquiring a lock and may result in sleeping in the idle task, causing CPU
lockup.

Another consequence of this change is that init_counter_refs() is now
called on each CPU correctly; previously the function on_each_cpu() was
used, but it was called at boot when the only online cpu is cpu0.

[ggherdovich@suse.cz: Tested and wrote changelog]
Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
---
 arch/x86/kernel/smpboot.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 5d346b70844b..dd8e15f648bc 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -147,7 +147,7 @@ static inline void smpboot_restore_warm_reset_vector(void)
 	*((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
 }
 
-static void init_freq_invariance(void);
+static void init_freq_invariance(bool secondary);
 
 /*
  * Report back to the Boot Processor during boot time or to the caller processor
@@ -185,7 +185,7 @@ static void smp_callin(void)
 	 */
 	set_cpu_sibling_map(raw_smp_processor_id());
 
-	init_freq_invariance();
+	init_freq_invariance(true);
 
 	/*
 	 * Get our bogomips.
@@ -1341,7 +1341,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	set_sched_topology(x86_topology);
 
 	set_cpu_sibling_map(0);
-	init_freq_invariance();
+	init_freq_invariance(false);
 	smp_sanity_check();
 
 	switch (apic_intr_mode) {
@@ -2005,7 +2005,7 @@ static bool intel_set_max_freq_ratio(void)
 	return true;
 }
 
-static void init_counter_refs(void *arg)
+static void init_counter_refs(void)
 {
 	u64 aperf, mperf;
 
@@ -2016,18 +2016,25 @@ static void init_counter_refs(void *arg)
 	this_cpu_write(arch_prev_mperf, mperf);
 }
 
-static void init_freq_invariance(void)
+static void init_freq_invariance(bool secondary)
 {
 	bool ret = false;
 
-	if (smp_processor_id() != 0 || !boot_cpu_has(X86_FEATURE_APERFMPERF))
+	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return;
 
+	if (secondary) {
+		if (static_branch_likely(&arch_scale_freq_key)) {
+			init_counter_refs();
+		}
+		return;
+	}
+
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		ret = intel_set_max_freq_ratio();
 
 	if (ret) {
-		on_each_cpu(init_counter_refs, NULL, 1);
+		init_counter_refs();
 		static_branch_enable(&arch_scale_freq_key);
 	} else {
 		pr_debug("Couldn't determine max cpu frequency, necessary for scale-invariant accounting.\n");
-- 
2.16.4

