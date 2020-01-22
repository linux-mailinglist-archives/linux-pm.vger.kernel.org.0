Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 874D6145873
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 16:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgAVPKf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 10:10:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:39460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgAVPKd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Jan 2020 10:10:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F289BACD6;
        Wed, 22 Jan 2020 15:10:29 +0000 (UTC)
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
Subject: [PATCH v5 2/6] x86,sched: Add support for frequency invariance on SKYLAKE_X
Date:   Wed, 22 Jan 2020 16:16:13 +0100
Message-Id: <20200122151617.531-3-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200122151617.531-1-ggherdovich@suse.cz>
References: <20200122151617.531-1-ggherdovich@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The scheduler needs the ratio freq_curr/freq_max for frequency-invariant
accounting. On SKYLAKE_X CPUs set freq_max to the highest frequency that can
be sustained by a group of at least 4 cores.

From the changelog of commit 31e07522be56 ("tools/power turbostat: fix
decoding for GLM, DNV, SKX turbo-ratio limits"):

>   Newer processors do not hard-code the the number of cpus in each bin
>   to {1, 2, 3, 4, 5, 6, 7, 8}  Rather, they can specify any number
>   of CPUS in each of the 8 bins:
>
>   eg.
>
>   ...
>   37 * 100.0 = 3600.0 MHz max turbo 4 active cores
>   38 * 100.0 = 3700.0 MHz max turbo 3 active cores
>   39 * 100.0 = 3800.0 MHz max turbo 2 active cores
>   39 * 100.0 = 3900.0 MHz max turbo 1 active cores
>
>   could now look something like this:
>
>   ...
>   37 * 100.0 = 3600.0 MHz max turbo 16 active cores
>   38 * 100.0 = 3700.0 MHz max turbo 8 active cores
>   39 * 100.0 = 3800.0 MHz max turbo 4 active cores
>   39 * 100.0 = 3900.0 MHz max turbo 2 active cores

This encoding of turbo levels applies to both SKYLAKE_X and GOLDMONT/GOLDMONT_D,
but we treat these two classes in separate commits because their freq_max
values need to be different. For SKX we prefer a lower freq_max in the ratio
freq_curr/freq_max, allowing load and utilization to overshoot and the
schedutil governor to be more performance-oriented. Models from the Atom
series (such as GOLDMONT*) are handled in a forthcoming commit as they have to
favor power-efficiency over performance.

Results from a performance evaluation follow.

1. TEST SETUP
2. NEUTRAL BENCHMARKS
3. NON-NEUTRAL BENCHMARKS
4. DETAILED TABLES

1. TEST SETUP
-------------

Test machine:

CPU Model   : Intel Xeon Platinum 8260L CPU @ 2.40GHz (a.k.a. Cascade Lake)
Fam/Mod/Ste : 6:85:6
Topology    : 2 sockets, 24 cores / 48 threads each socket
Memory      : 192G
Storage     : SSD, XFS filesystem

Max EFFICiency, BASE frequency and available turbo levels (MHz):

    EFFIC   1000 |**********
    BASE    2400 |************************
    24C     3100 |*******************************
    20C     3300 |*********************************
    16C     3600 |************************************
    12C     3600 |************************************
    8C      3600 |************************************
    4C      3700 |*************************************
    2C      3900 |***************************************

Tested kernels:

Baseline      : v5.2,              intel_pstate passive,  schedutil
Comparison #1 : v5.2,              intel_pstate active ,  powersave+HWP
Comparison #2 : v5.2, this patch,  intel_pstate passive,  schedutil

2. NEUTRAL BENCHMARKS
---------------------

* pgbench read/write
* NASA Parallel Benchmarks (NPB), MPI or OpenMP for message-passing
* hackbench
* netperf

3. NON-NEUTRAL BENCHMARKS
-------------------------

comparison ratio with baseline; 1.00 means neutral, higher is better:

                      I_PSTATE      FREQ-INV
    ----------------------------------------
    pgbench read-only     1.10             ~
    tbench                1.82          1.14

comparison ratio with baseline; 1.00 means neutral, lower is better:

                      I_PSTATE      FREQ-INV
    ----------------------------------------
    dbench                   ~          0.97
    kernbench             0.88          0.78
    gitsource[*]             ~          0.46

[*] "gitsource" consists in running git's unit tests
tilde (~) means 1.00, ie result identical to baseline

Performance per watt:

performance-per-watt ratios with baseline; 1.00 means neutral, higher is better:

		      I_PSTATE      FREQ-INV
    ----------------------------------------
    dbench                0.92          0.91
    tbench                1.26          1.04
    kernbench             0.95          0.96
    gitsource             1.03          1.30

Similarly to earlier Xeons, measurable performance gains over non-invariant
schedutil are observed on dbench, tbench, kernel compilation and running the
git unit tests suite. Looking at the detailed tables show that the patch
scores the largest difference when the machine is lightly loaded. Power
efficiency suffers lightly on kernbench and a bit more on dbench, but largely
improves on gitsource (which also runs considerably faster). For reference, we
also report results using active intel_pstate with powersave and HWP; the
largest gap between non-invariant schedutil and intel_pstate+powersave is
still tbench, which runs 82% better and with 26% improved efficiency on the
latter configuration -- this divide isn't closed yet by frequency-invariant
schedutil.

4. DETAILED TABLES
------------------

Benchmark          : tbench4 (i.e. dbench4 over the network, actually loopback)
Varying parameter  : number of clients
Unit               : MB/sec (higher is better)

                     5.2.0 vanilla (BASELINE)            5.2.0 intel_pstate/HWP                    5.2.0 freq-inv
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Hmean   1         183.56  +- 0.21% (        )       516.12  +- 0.57% ( 181.18%)       185.59  +- 0.59% (   1.11%)
Hmean   2         365.75  +- 0.25% (        )      1015.14  +- 0.33% ( 177.55%)       402.59  +- 4.48% (  10.07%)
Hmean   4         720.99  +- 0.44% (        )      1951.75  +- 0.28% ( 170.70%)       738.39  +- 1.72% (   2.41%)
Hmean   8        1449.93  +- 0.34% (        )      3830.56  +- 0.24% ( 164.19%)      1750.36  +- 4.65% (  20.72%)
Hmean   16       2874.26  +- 0.57% (        )      7381.62  +- 0.53% ( 156.82%)      4348.35  +- 2.22% (  51.29%)
Hmean   32       6116.17  +- 5.10% (        )     13013.05  +- 0.08% ( 112.76%)      8980.35  +- 0.66% (  46.83%)
Hmean   64      14485.04  +- 3.46% (        )     17835.12  +- 0.35% (  23.13%)     16540.73  +- 0.51% (  14.19%)
Hmean   128     30779.16  +- 3.20% (        )     32796.94  +- 2.13% (   6.56%)     31512.58  +- 0.20% (   2.38%)
Hmean   256     34664.66  +- 0.81% (        )     34604.67  +- 0.46% (  -0.17%)     34943.70  +- 0.25% (   0.80%)
Hmean   384     33957.51  +- 0.11% (        )     34091.50  +- 0.14% (   0.39%)     33921.41  +- 0.09% (  -0.11%)

Benchmark          : kernbench (kernel compilation)
Varying parameter  : number of jobs
Unit               : seconds (lower is better)

                    5.2.0 vanilla (BASELINE)             5.2.0 intel_pstate/HWP                     5.2.0 freq-inv
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Amean   2        332.94  +- 0.40% (        )        260.16  +- 0.45% (  21.86%)        233.56  +- 0.21% (  29.85%)
Amean   4        173.04  +- 0.43% (        )        138.76  +- 0.03% (  19.81%)        123.59  +- 0.11% (  28.58%)
Amean   8         89.65  +- 0.20% (        )         73.54  +- 0.09% (  17.97%)         65.69  +- 0.10% (  26.72%)
Amean   16        48.08  +- 1.41% (        )         41.64  +- 1.61% (  13.40%)         36.00  +- 1.80% (  25.11%)
Amean   32        28.78  +- 0.72% (        )         26.61  +- 1.99% (   7.55%)         23.19  +- 1.68% (  19.43%)
Amean   64        20.46  +- 1.85% (        )         19.76  +- 0.35% (   3.42%)         17.38  +- 0.92% (  15.06%)
Amean   128       18.69  +- 1.70% (        )         17.59  +- 1.04% (   5.90%)         15.73  +- 1.40% (  15.85%)
Amean   192       18.82  +- 1.01% (        )         17.76  +- 0.77% (   5.67%)         15.57  +- 1.80% (  17.28%)

Benchmark          : gitsource (time to run the git unit test suite)
Varying parameter  : none
Unit               : seconds (lower is better)

                 5.2.0 vanilla (BASELINE)           5.2.0 intel_pstate/HWP                    5.2.0 freq-inv
- - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Amean         792.49  +- 0.20% (        )      779.35  +- 0.24% (   1.66%)      427.14  +- 0.16% (   46.10%)

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 arch/x86/kernel/smpboot.c | 66 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 28696bccf912..ba9d3bdc191c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1841,24 +1841,52 @@ static const struct x86_cpu_id has_glm_turbo_ratio_limits[] = {
 	{}
 };
 
-static bool core_set_max_freq_ratio(void)
+static bool skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
+{
+	u64 ratios, counts;
+	u32 group_size;
+	int err, i;
+
+	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
+	if (err)
+		return false;
+
+	*base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
+
+	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &ratios);
+	if (err)
+		return false;
+
+	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT1, &counts);
+	if (err)
+		return false;
+
+	for (i = 0; i < 64; i += 8) {
+		group_size = (counts >> i) & 0xFF;
+		if (group_size >= size) {
+			*turbo_freq = (ratios >> i) & 0xFF;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 {
-	u64 base_freq, turbo_freq;
 	int err;
 
-	err = rdmsrl_safe(MSR_PLATFORM_INFO, &base_freq);
+	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
 	if (err)
 		return false;
 
-	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &turbo_freq);
+	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, turbo_freq);
 	if (err)
 		return false;
 
-	base_freq = (base_freq >> 8) & 0xFF;      /* max P state */
-	turbo_freq = (turbo_freq >> 24) & 0xFF;   /* 4C turbo    */
+	*base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
+	*turbo_freq = (*turbo_freq >> 24) & 0xFF;   /* 4C turbo    */
 
-	arch_max_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
-					base_freq);
 	return true;
 }
 
@@ -1867,21 +1895,33 @@ static bool intel_set_max_freq_ratio(void)
 	/*
 	 * TODO: add support for:
 	 *
-	 * - Xeon Gold/Platinum
 	 * - Xeon Phi (KNM, KNL)
 	 * - Atom Goldmont
 	 * - Atom Silvermont
 	 */
 
-	if (x86_match_cpu(has_skx_turbo_ratio_limits) ||
-		x86_match_cpu(has_knl_turbo_ratio_limits) ||
+	u64 base_freq = 1, turbo_freq = 1;
+
+	if (x86_match_cpu(has_knl_turbo_ratio_limits) ||
 		x86_match_cpu(has_glm_turbo_ratio_limits))
 		return false;
 
-	if (turbo_disabled() || core_set_max_freq_ratio())
-		return true;
+	if (turbo_disabled())
+		goto out;
+
+	if (x86_match_cpu(has_skx_turbo_ratio_limits) &&
+	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 4))
+		goto out;
+
+	if (core_set_max_freq_ratio(&base_freq, &turbo_freq))
+		goto out;
 
 	return false;
+
+out:
+	arch_max_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
+					base_freq);
+	return true;
 }
 
 static void init_counter_refs(void *arg)
-- 
2.16.4

