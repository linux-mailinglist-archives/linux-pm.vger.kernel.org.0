Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 907B7FB0A9
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 13:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfKMMlc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 07:41:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:39312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726548AbfKMMlV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Nov 2019 07:41:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EDF00B558;
        Wed, 13 Nov 2019 12:41:19 +0000 (UTC)
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
Subject: [PATCH v4 5/6] x86,sched: Add support for frequency invariance on ATOM
Date:   Wed, 13 Nov 2019 13:46:53 +0100
Message-Id: <20191113124654.18122-6-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191113124654.18122-1-ggherdovich@suse.cz>
References: <20191113124654.18122-1-ggherdovich@suse.cz>
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
 arch/x86/kernel/smpboot.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 4d192abf337d..8988177064be 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1821,6 +1821,24 @@ static bool turbo_disabled(void)
 	return (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
 }
 
+static bool slv_set_cpu_max_freq(u64 *ratio, u64 *turbo_ratio)
+{
+	int err;
+
+	err = rdmsrl_safe(MSR_ATOM_CORE_RATIOS, ratio);
+	if (err)
+		return false;
+
+	err = rdmsrl_safe(MSR_ATOM_CORE_TURBO_RATIOS, turbo_ratio);
+	if (err)
+		return false;
+
+	*ratio = (*ratio >> 16) & 0x3F;      /* max P state ratio */
+	*turbo_ratio = *turbo_ratio & 0x3F;  /* 1C turbo ratio */
+
+	return true;
+}
+
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
@@ -1984,19 +2002,14 @@ static bool core_set_cpu_max_freq(u64 *ratio, u64 *turbo_ratio)
 
 static void intel_set_cpu_max_freq(void)
 {
-	/*
-	 * TODO: add support for:
-	 *
-	 * - Atom Silvermont
-	 *
-	 * which all now get by default arch_max_freq = SCHED_CAPACITY_SCALE
-	 */
-
 	u64 ratio = 1, turbo_ratio = 1;
 
 	if (turbo_disabled())
 		return;
 
+	if (slv_set_cpu_max_freq(&ratio, &turbo_ratio))
+		goto set_value;
+
 	if (glm_set_cpu_max_freq(&ratio, &turbo_ratio))
 		goto set_value;
 
-- 
2.16.4

