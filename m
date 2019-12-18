Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 859A31252AB
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 21:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfLRUGi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 15:06:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbfLRUGg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 15:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9rC2lluhWmst6sPoNa1SifEs6p/w43BDs1gIkal0A94=; b=uP96Nmt2mIS6jVz44ULow1++Z
        uMaPwxNRhr16G++pXzw634K3bHHTzhlB5V81DznjL6xTzstcJNHAV4S+jFru2GNSoyxI+NVf/rBsQ
        SeBCyyp2aROSulVjYk2pxG37fDzCaGE2/ZDH5bz1vR7j9Y133q1xGDqbXmuXzGlg3lZHMwDqC6iOs
        x3x8BcPQ3Uad9jgOXJ627YSnbjoRAVYmrZ7punGyQil000cQonTNvU262y5OghDYu0CGU+iZ4445R
        HZgsxQr7i6AyNobzJCWk2zObwcTQRhERypEE8iK1FLX4Z6gK0kefIJzfbDhjj7SUirz5F0T4S8I9N
        O47ytvwZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihfaU-0006rf-MK; Wed, 18 Dec 2019 20:06:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54C49980E35; Wed, 18 Dec 2019 21:06:24 +0100 (CET)
Date:   Wed, 18 Dec 2019 21:06:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH v4 2/6] x86,sched: Add support for frequency invariance
 on SKYLAKE_X
Message-ID: <20191218200624.GI11457@worktop.programming.kicks-ass.net>
References: <20191113124654.18122-1-ggherdovich@suse.cz>
 <20191113124654.18122-3-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113124654.18122-3-ggherdovich@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 13, 2019 at 01:46:50PM +0100, Giovanni Gherdovich wrote:
> The scheduler needs the ratio freq_curr/freq_max for frequency-invariant
> accounting. On SKYLAKE_X CPUs set freq_max to the highest frequency that can
> be sustained by a group of at least 4 cores.
> 
> From the changelog of commit 31e07522be56 ("tools/power turbostat: fix
> decoding for GLM, DNV, SKX turbo-ratio limits"):
> 
> >   Newer processors do not hard-code the the number of cpus in each bin
> >   to {1, 2, 3, 4, 5, 6, 7, 8}  Rather, they can specify any number
> >   of CPUS in each of the 8 bins:
> >
> >   eg.
> >
> >   ...
> >   37 * 100.0 = 3600.0 MHz max turbo 4 active cores
> >   38 * 100.0 = 3700.0 MHz max turbo 3 active cores
> >   39 * 100.0 = 3800.0 MHz max turbo 2 active cores
> >   39 * 100.0 = 3900.0 MHz max turbo 1 active cores
> >
> >   could now look something like this:
> >
> >   ...
> >   37 * 100.0 = 3600.0 MHz max turbo 16 active cores
> >   38 * 100.0 = 3700.0 MHz max turbo 8 active cores
> >   39 * 100.0 = 3800.0 MHz max turbo 4 active cores
> >   39 * 100.0 = 3900.0 MHz max turbo 2 active cores
> 
> This encoding of turbo levels applies to both SKYLAKE_X and GOLDMONT/GOLDMONT_D,
> but we treat these two classes in separate commits because their freq_max
> values need to be different. For SKX we prefer a lower freq_max in the ratio
> freq_curr/freq_max, allowing load and utilization to overshoot and the
> schedutil governor to be more performance-oriented. Models from the Atom
> series (such as GOLDMONT*) are handled in a forthcoming commit as they have to
> favor power-efficiency over performance.

Can we at least use a single function to decode both? A little like the
below. I'm not married to the naming, but I think it is a little silly
to have 2 different functions to decode the exact same MSRs.

(one could even go as far as to make a boot param to override the {1,4}
default core count for these things)

---

Index: linux-2.6/arch/x86/kernel/smpboot.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/smpboot.c
+++ linux-2.6/arch/x86/kernel/smpboot.c
@@ -1863,27 +1863,6 @@ static const struct x86_cpu_id has_glm_t
 	{}
 };

-static bool glm_set_cpu_max_freq(u64 *ratio, u64 *turbo_ratio)
-{
-	int err;
-
-	if (!x86_match_cpu(has_glm_turbo_ratio_limits))
-		return false;
-
-	err = rdmsrl_safe(MSR_PLATFORM_INFO, ratio);
-	if (err)
-		return false;
-
-	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, turbo_ratio);
-	if (err)
-		return false;
-
-	*ratio = (*ratio >> 8) & 0xFF;        /* max P state ratio */
-	*turbo_ratio = *turbo_ratio & 0xFF;   /* highest turbo ratio */
-
-	return true;
-}
-
 static int get_knl_turbo_ratio(u64 *turbo_ratio)
 {
 	u64 msr;
@@ -1933,53 +1912,35 @@ static bool knl_set_cpu_max_freq(u64 *ra
 	return true;
 }

-static int get_turbo_ratio_group(u64 *turbo_ratio)
+static bool skx_set_cpu_max_freq(u64 *ratio, u64 *turbo_ratio, int size)
 {
-	u64 ratio, core_counts;
-	u32 group_size = 0;
-	int err, i, found = 0;
+	u64 ratios, counts;
+	u32 group_size;
+	int err, i;

-	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &ratio);
-	if (err)
-		return err;
-
-	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT1, &core_counts);
+	err = rdmsrl_safe(MSR_PLATFORM_INFO, ratio);
 	if (err)
-		return err;
-
-	for (i = 0; i < 64; i += 8) {
-		group_size = (core_counts >> i) & 0xFF;
-		if (group_size >= 4) {
-			*turbo_ratio = (ratio >> i) & 0xFF;
-			found = 1;
-			break;
-		}
-	}
-
-	if (!found)
-		return 1;
-
-	return 0;
-}
-
-static bool skx_set_cpu_max_freq(u64 *ratio, u64 *turbo_ratio)
-{
-	int err;
-
-	if (!x86_match_cpu(has_skx_turbo_ratio_limits))
 		return false;

-	err = rdmsrl_safe(MSR_PLATFORM_INFO, ratio);
+	*ratio = (*ratio >> 8) & 0xFF;                /* max P state ratio */
+
+	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &ratios);
 	if (err)
 		return false;

-	err = get_turbo_ratio_group(turbo_ratio);  /* 4C (circa) turbo ratio */
+	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT1, &counts);
 	if (err)
 		return false;

-	*ratio = (*ratio >> 8) & 0xFF;                /* max P state ratio */
+	for (i = 0; i < 64; i += 8) {
+		group_size = (counts >> i) & 0xFF;
+		if (group_size >= size) {
+			*turbo_ratio = (ratios >> i) & 0xFF;
+			return true;
+		}
+	}

-	return true;
+	return false;
 }

 static bool core_set_cpu_max_freq(u64 *ratio, u64 *turbo_ratio)
@@ -2010,13 +1971,15 @@ static void intel_set_cpu_max_freq(void)
 	if (slv_set_cpu_max_freq(&ratio, &turbo_ratio))
 		goto set_value;

-	if (glm_set_cpu_max_freq(&ratio, &turbo_ratio))
+	if (x86_match_cpu(has_glm_turbo_ratio_limits) &&
+	    skx_set_cpu_max_freq(&ratio, &turbo_ratio, 1))
 		goto set_value;

 	if (knl_set_cpu_max_freq(&ratio, &turbo_ratio))
 		goto set_value;

-	if (skx_set_cpu_max_freq(&ratio, &turbo_ratio))
+	if (x86_match_cpu(has_skx_turbo_ratio_limits) &&
+	    skx_set_cpu_max_freq(&ratio, &turbo_ratio, 4))
 		goto set_value;

 	core_set_cpu_max_freq(&ratio, &turbo_ratio);

