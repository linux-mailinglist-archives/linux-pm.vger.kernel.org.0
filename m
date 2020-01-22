Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2CF145871
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 16:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgAVPKf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 10:10:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:39492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgAVPKd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Jan 2020 10:10:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D8F5EACD7;
        Wed, 22 Jan 2020 15:10:30 +0000 (UTC)
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
Subject: [PATCH v5 3/6] x86,sched: Add support for frequency invariance on XEON_PHI_KNL/KNM
Date:   Wed, 22 Jan 2020 16:16:14 +0100
Message-Id: <20200122151617.531-4-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200122151617.531-1-ggherdovich@suse.cz>
References: <20200122151617.531-1-ggherdovich@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The scheduler needs the ratio freq_curr/freq_max for frequency-invariant
accounting. On Xeon Phi CPUs set freq_max to the second-highest frequency
reported by the CPU.

Xeon Phi CPUs such as Knights Landing and Knights Mill typically have either
one or two turbo frequencies; in the former case that's 100 MHz above the base
frequency, in the latter case the two levels are 100 MHz and 200 MHz above
base frequency.

We set freq_max to the second-highest frequency reported by the CPU. This
could be the base frequency (if only one turbo level is available) or the first
turbo level (if two levels are available). The rationale is to compromise
between power efficiency or performance -- going straight to max turbo would
favor efficiency and blindly using base freq would favor performance.

For reference, this is how MSR_TURBO_RATIO_LIMIT must be parsed on a Xeon Phi
to get the available frequencies (taken from a comment in turbostat's sources):

    [0] -- Reserved
    [7:1] -- Base value of number of active cores of bucket 1.
    [15:8] -- Base value of freq ratio of bucket 1.
    [20:16] -- +ve delta of number of active cores of bucket 2.
    i.e. active cores of bucket 2 =
    active cores of bucket 1 + delta
    [23:21] -- Negative delta of freq ratio of bucket 2.
    i.e. freq ratio of bucket 2 =
    freq ratio of bucket 1 - delta
    [28:24]-- +ve delta of number of active cores of bucket 3.
    [31:29]-- -ve delta of freq ratio of bucket 3.
    [36:32]-- +ve delta of number of active cores of bucket 4.
    [39:37]-- -ve delta of freq ratio of bucket 4.
    [44:40]-- +ve delta of number of active cores of bucket 5.
    [47:45]-- -ve delta of freq ratio of bucket 5.
    [52:48]-- +ve delta of number of active cores of bucket 6.
    [55:53]-- -ve delta of freq ratio of bucket 6.
    [60:56]-- +ve delta of number of active cores of bucket 7.
    [63:61]-- -ve delta of freq ratio of bucket 7.

1. PERFORMANCE EVALUATION: TBENCH +5%
2. NEUTRAL BENCHMARKS (ALL OTHERS)
3. TEST SETUP

1. PERFORMANCE EVALUATION: TBENCH +5%
-------------------------------------

A performance evaluation was conducted on a Knights Mill machine (see "Test
Setup" below), were the frequency-invariance patch (on schedutil) is compared
to both non-invariant schedutil and active intel_pstate with powersave: all
three tested kernels behave the same performance-wise and with regard to power
consumption (performance per watt). The only notable difference is tbench:

comparison ratio of performance with baseline; 1.00 means neutral,
higher is better:

                      I_PSTATE      FREQ-INV
    ----------------------------------------
    tbench                1.04          1.05

performance-per-watt ratios with baseline; 1.00 means neutral, higher is better:

                      I_PSTATE      FREQ-INV
    ----------------------------------------
    tbench                1.03          1.04

which essentially means that frequency-invariant schedutil is 5% better than
baseline, the same as intel_pstate+powersave.

As the results above are averaged over the varying parameter, here the detailed
table.

Varying parameter  : number of clients
Unit               : MB/sec (higher is better)

                    5.2.0 vanilla (BASELINE)                 5.2.0 intel_pstate                     5.2.0 freq-inv
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Hmean   1         49.06  +- 2.12% (        )         51.66  +- 1.52% (   5.30%)         52.87  +- 0.88% (   7.76%)
Hmean   2         93.82  +- 0.45% (        )        103.24  +- 0.70% (  10.05%)        105.90  +- 0.70% (  12.88%)
Hmean   4        192.46  +- 1.15% (        )        215.95  +- 0.60% (  12.21%)        215.78  +- 1.43% (  12.12%)
Hmean   8        406.74  +- 2.58% (        )        438.58  +- 0.36% (   7.83%)        437.61  +- 0.97% (   7.59%)
Hmean   16       857.70  +- 1.22% (        )        890.26  +- 0.72% (   3.80%)        889.11  +- 0.73% (   3.66%)
Hmean   32      1760.10  +- 0.92% (        )       1791.70  +- 0.44% (   1.79%)       1787.95  +- 0.44% (   1.58%)
Hmean   64      3183.50  +- 0.34% (        )       3183.19  +- 0.36% (  -0.01%)       3187.53  +- 0.36% (   0.13%)
Hmean   128     4830.96  +- 0.31% (        )       4846.53  +- 0.30% (   0.32%)       4855.86  +- 0.30% (   0.52%)
Hmean   256     5467.98  +- 0.38% (        )       5793.80  +- 0.28% (   5.96%)       5821.94  +- 0.17% (   6.47%)
Hmean   512     5398.10  +- 0.06% (        )       5745.56  +- 0.08% (   6.44%)       5503.68  +- 0.07% (   1.96%)
Hmean   1024    5290.43  +- 0.63% (        )       5221.07  +- 0.47% (  -1.31%)       5277.22  +- 0.80% (  -0.25%)
Hmean   1088    5139.71  +- 0.57% (        )       5236.02  +- 0.71% (   1.87%)       5190.57  +- 0.41% (   0.99%)

2. NEUTRAL BENCHMARKS (ALL OTHERS)
----------------------------------

* pgbench (both read/write and read-only)
* NASA Parallel Benchmarks (NPB), MPI or OpenMP for message-passing
* hackbench
* netperf
* dbench
* kernbench
* gitsource (git unit test suite)

3. TEST SETUP
-------------

Test machine:

CPU Model   : Intel Xeon Phi CPU 7255 @ 1.10GHz (a.k.a. Knights Mill)
Fam/Mod/Ste : 6:133:0
Topology    : 1 socket, 68 cores / 272 threads
Memory      : 96G
Storage     : rotary, XFS filesystem

Max EFFICiency, BASE frequency and available turbo levels (MHz):

    EFFIC   1000 |**********
    BASE    1100 |***********
    68C     1100 |***********
    30C     1200 |************

Tested kernels:

Baseline      : v5.2,              intel_pstate passive,  schedutil
Comparison #1 : v5.2,              intel_pstate active ,  powersave
Comparison #2 : v5.2, this patch,  intel_pstate passive,  schedutil

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 arch/x86/kernel/smpboot.c | 49 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ba9d3bdc191c..8cb3113377a9 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1841,6 +1841,48 @@ static const struct x86_cpu_id has_glm_turbo_ratio_limits[] = {
 	{}
 };
 
+static bool knl_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq,
+				int num_delta_fratio)
+{
+	int fratio, delta_fratio, found;
+	int err, i;
+	u64 msr;
+
+	if (!x86_match_cpu(has_knl_turbo_ratio_limits))
+		return false;
+
+	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
+	if (err)
+		return false;
+
+	*base_freq = (*base_freq >> 8) & 0xFF;	    /* max P state */
+
+	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
+	if (err)
+		return false;
+
+	fratio = (msr >> 8) & 0xFF;
+	i = 16;
+	found = 0;
+	do {
+		if (found >= num_delta_fratio) {
+			*turbo_freq = fratio;
+			return true;
+		}
+
+		delta_fratio = (msr >> (i + 5)) & 0x7;
+
+		if (delta_fratio) {
+			found += 1;
+			fratio -= delta_fratio;
+		}
+
+		i += 8;
+	} while (i < 64);
+
+	return true;
+}
+
 static bool skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
 {
 	u64 ratios, counts;
@@ -1895,20 +1937,21 @@ static bool intel_set_max_freq_ratio(void)
 	/*
 	 * TODO: add support for:
 	 *
-	 * - Xeon Phi (KNM, KNL)
 	 * - Atom Goldmont
 	 * - Atom Silvermont
 	 */
 
 	u64 base_freq = 1, turbo_freq = 1;
 
-	if (x86_match_cpu(has_knl_turbo_ratio_limits) ||
-		x86_match_cpu(has_glm_turbo_ratio_limits))
+	if (x86_match_cpu(has_glm_turbo_ratio_limits))
 		return false;
 
 	if (turbo_disabled())
 		goto out;
 
+	if (knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
+		goto out;
+
 	if (x86_match_cpu(has_skx_turbo_ratio_limits) &&
 	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 4))
 		goto out;
-- 
2.16.4

