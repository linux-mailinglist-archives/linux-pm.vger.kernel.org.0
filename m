Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08B8D14586E
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 16:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgAVPKf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 10:10:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:39552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgAVPKf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Jan 2020 10:10:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8C130AD03;
        Wed, 22 Jan 2020 15:10:32 +0000 (UTC)
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
Subject: [PATCH v5 5/6] x86,sched: Add support for frequency invariance on ATOM
Date:   Wed, 22 Jan 2020 16:16:16 +0100
Message-Id: <20200122151617.531-6-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200122151617.531-1-ggherdovich@suse.cz>
References: <20200122151617.531-1-ggherdovich@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The scheduler needs the ratio freq_curr/freq_max for frequency-invariant
accounting. On all ATOM CPUs prior to Goldmont, set freq_max to the 1-core
turbo ratio.

We intended to perform tests validating that this patch doesn't regress in
terms of energy efficiency, given that this is the primary concern on Atom
processors. Alas, we found out that turbostat doesn't support reading RAPL
interfaces on our test machine (Airmont), and we don't have external equipment
to measure power consumption; all we have is the performance results of the
benchmarks we ran.

Test machine:

Platform    : Dell Wyse 3040 Thin Client[1]
CPU Model   : Intel Atom x5-Z8350 (aka Cherry Trail, aka Airmont)
Fam/Mod/Ste : 6:76:4
Topology    : 1 socket, 4 cores / 4 threads
Memory      : 2G
Storage     : onboard flash, XFS filesystem

[1] https://www.dell.com/en-us/work/shop/wyse-endpoints-and-software/wyse-3040-thin-client/spd/wyse-3040-thin-client

Base frequency and available turbo levels (MHz):

    Min Operating Freq   266 |***
    Low Freq Mode        800 |********
    Base Freq           2400 |************************
    4 Cores             2800 |****************************
    3 Cores             2800 |****************************
    2 Cores             3200 |********************************
    1 Core              3200 |********************************

Tested kernels:

Baseline      : v5.4-rc1,              intel_pstate passive,  schedutil
Comparison #1 : v5.4-rc1,              intel_pstate active ,  powersave
Comparison #2 : v5.4-rc1, this patch,  intel_pstate passive,  schedutil

tbench, hackbench and kernbench performed the same under all three kernels;
dbench ran faster with intel_pstate/powersave and the git unit tests were a
lot faster with intel_pstate/powersave and invariant schedutil wrt the
baseline. Not that any of this is terrbily interesting anyway, one doesn't buy
an Atom system to go fast. Power consumption regressions aren't expected but
we lack the equipment to make that measurement. Turbostat seems to think that
reading RAPL on this machine isn't a good idea and we're trusting that
decision.

comparison ratio of performance with baseline; 1.00 means neutral,
lower is better:

                      I_PSTATE      FREQ-INV
    ----------------------------------------
    dbench                0.90             ~
    kernbench             0.98          0.97
    gitsource             0.63          0.43

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 arch/x86/kernel/smpboot.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3e32d620f1fb..5f04bf8419f9 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1821,6 +1821,24 @@ static bool turbo_disabled(void)
 	return (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
 }
 
+static bool slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
+{
+	int err;
+
+	err = rdmsrl_safe(MSR_ATOM_CORE_RATIOS, base_freq);
+	if (err)
+		return false;
+
+	err = rdmsrl_safe(MSR_ATOM_CORE_TURBO_RATIOS, turbo_freq);
+	if (err)
+		return false;
+
+	*base_freq = (*base_freq >> 16) & 0x3F;     /* max P state */
+	*turbo_freq = *turbo_freq & 0x3F;           /* 1C turbo    */
+
+	return true;
+}
+
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
@@ -1938,17 +1956,14 @@ static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 
 static bool intel_set_max_freq_ratio(void)
 {
-	/*
-	 * TODO: add support for:
-	 *
-	 * - Atom Silvermont
-	 */
-
 	u64 base_freq = 1, turbo_freq = 1;
 
 	if (turbo_disabled())
 		goto out;
 
+	if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
+		goto out;
+
 	if (x86_match_cpu(has_glm_turbo_ratio_limits) &&
 	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
 		goto out;
-- 
2.16.4

