Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529A712535C
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 21:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfLRUWu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 15:22:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbfLRUWt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 15:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SHZ8xl3re+bA4KEYO+3sCnxXO5OgGt4zMOPrCsEWg84=; b=OWNiKcm1uOH+8Mm4swI4mH+wo
        eUo0fFFAASYMuISJBVydVTd2GRZyZ1Tg+FVkvW2A5sgQL0XchfurINfwPCBxk8GDc17tb6h3cpkXr
        zdT+eEWqCzSRXcJRnC6n0e7aTyRcFQNF0pXi7ngMe7WSxOpNstIcPU3z/2EHyVMNFVnS7t7iaJVr3
        Ir1moIZGuALSMEihwiVPfj7Pc/oHexs4KDSGxuWg9i0otHyXVt2Fa3YbLotn7mjXrEWbNQzFShKIx
        u3i4ed63vYOBt5/ZVVjFdiAkbpIjOBdtQ0Q4W7XC0KptfHLHmrDPBi9hnDbn8c5/54SCN8WEEsS9U
        SQ1ESJUDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihfqB-0005Ar-9M; Wed, 18 Dec 2019 20:22:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60DD0980E35; Wed, 18 Dec 2019 21:22:36 +0100 (CET)
Date:   Wed, 18 Dec 2019 21:22:36 +0100
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
Subject: Re: [PATCH v4 3/6] x86,sched: Add support for frequency invariance
 on XEON_PHI_KNL/KNM
Message-ID: <20191218202236.GJ11457@worktop.programming.kicks-ass.net>
References: <20191113124654.18122-1-ggherdovich@suse.cz>
 <20191113124654.18122-4-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113124654.18122-4-ggherdovich@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 13, 2019 at 01:46:51PM +0100, Giovanni Gherdovich wrote:
> The scheduler needs the ratio freq_curr/freq_max for frequency-invariant
> accounting. On Xeon Phi CPUs set freq_max to the second-highest frequency
> reported by the CPU.
> 
> Xeon Phi CPUs such as Knights Landing and Knights Mill typically have either
> one or two turbo frequencies; in the former case that's 100 MHz above the base
> frequency, in the latter case the two levels are 100 MHz and 200 MHz above
> base frequency.
> 
> We set freq_max to the second-highest frequency reported by the CPU. This
> could be the base frequency (if only one turbo level is available) or the first
> turbo level (if two levels are available). The rationale is to compromise
> between power efficiency or performance -- going straight to max turbo would
> favor efficiency and blindly using base freq would favor performance.
> 
> For reference, this is how MSR_TURBO_RATIO_LIMIT must be parsed on a Xeon Phi
> to get the available frequencies (taken from a comment in turbostat's sources):
> 
>     [0] -- Reserved
>     [7:1] -- Base value of number of active cores of bucket 1.
>     [15:8] -- Base value of freq ratio of bucket 1.
>     [20:16] -- +ve delta of number of active cores of bucket 2.
>     i.e. active cores of bucket 2 =
>     active cores of bucket 1 + delta
>     [23:21] -- Negative delta of freq ratio of bucket 2.
>     i.e. freq ratio of bucket 2 =
>     freq ratio of bucket 1 - delta
>     [28:24]-- +ve delta of number of active cores of bucket 3.
>     [31:29]-- -ve delta of freq ratio of bucket 3.
>     [36:32]-- +ve delta of number of active cores of bucket 4.
>     [39:37]-- -ve delta of freq ratio of bucket 4.
>     [44:40]-- +ve delta of number of active cores of bucket 5.
>     [47:45]-- -ve delta of freq ratio of bucket 5.
>     [52:48]-- +ve delta of number of active cores of bucket 6.
>     [55:53]-- -ve delta of freq ratio of bucket 6.
>     [60:56]-- +ve delta of number of active cores of bucket 7.
>     [63:61]-- -ve delta of freq ratio of bucket 7.

Does it make sense to write a complete decoder and pass a @size
parameter just like the skx/glm case?

(I've no idea on the 4 I passed in, probably wants to be something else)

---
Index: linux-2.6/arch/x86/kernel/smpboot.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/smpboot.c
+++ linux-2.6/arch/x86/kernel/smpboot.c
@@ -1863,36 +1863,12 @@ static const struct x86_cpu_id has_glm_t
 	{}
 };

-static int get_knl_turbo_ratio(u64 *turbo_ratio)
+static bool knl_set_cpu_max_freq(u64 *ratio, u64 *turbo_ratio, int size)
 {
+	int delta_cores, delta_fratio;
+	int cores, fratio;
+	int err, i;
 	u64 msr;
-	u32 ratio, delta_ratio;
-	int err, i, found = 0;
-
-	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
-	if (err)
-		return err;
-
-	ratio = (msr >> 8) & 0xFF;
-
-	for (i = 16; i < 64; i += 8) {
-		delta_ratio = (msr >> (i + 5)) & 0x7;
-		if (delta_ratio) {
-			*turbo_ratio = ratio - delta_ratio;
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
-static bool knl_set_cpu_max_freq(u64 *ratio, u64 *turbo_ratio)
-{
-	int err;

 	if (!x86_match_cpu(has_knl_turbo_ratio_limits))
 		return false;
@@ -1901,15 +1877,32 @@ static bool knl_set_cpu_max_freq(u64 *ra
 	if (err)
 		return false;

-	/* second highest turbo ratio */
-	err = get_knl_turbo_ratio(turbo_ratio);
+	*ratio = (*ratio >> 8) & 0xFF; /* max P state ratio */
+
+	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
 	if (err)
 		return false;

-	/* max P state ratio */
-	*ratio = (*ratio >> 8) & 0xFF;
+	cores = (msr >> 1) & 0x7F;
+	fratio = (msr >> 8) & 0xFF;

-	return true;
+	i = 16;
+	do {
+		if (cores >= size) {
+			*turbo_ratio = fratio;
+			return true;
+		}
+
+		delta_cores = (msr >> i) & 0x1F;
+		delta_fratio = (msr >> (i + 5)) & 0x07;
+
+		cores += delta_cores;
+		fratio -= delta_fratio;
+
+		i += 8;
+	} while (i < 64);
+
+	return false;
 }

 static bool skx_set_cpu_max_freq(u64 *ratio, u64 *turbo_ratio, int size)
@@ -1975,7 +1968,7 @@ static void intel_set_cpu_max_freq(void)
 	    skx_set_cpu_max_freq(&ratio, &turbo_ratio, 1))
 		goto set_value;

-	if (knl_set_cpu_max_freq(&ratio, &turbo_ratio))
+	if (knl_set_cpu_max_freq(&ratio, &turbo_ratio, 4))
 		goto set_value;

 	if (x86_match_cpu(has_skx_turbo_ratio_limits) &&

