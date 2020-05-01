Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8121C128D
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 15:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgEANE7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 09:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728586AbgEANE7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 09:04:59 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E548C061A0C;
        Fri,  1 May 2020 06:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xMXWVTc7R+JhjJn+KS3GnD4/0ygZbQWbKw26aELhegA=; b=mwwUk7GEE0TAQBUF24oh02jytD
        A/0jaT8TH802Az+IjxVBaIJACdmBGYq1cpDWwDS/KIUn74i+TSzJQAulkfC53sOKU39ZUqByGQnLM
        vZOQXNgzoFaWGWAHIcCrPvXVYx1zxk4l9QEKY4sYcbv9xRtkF7RgKIzB9GdzWCmj3lNp25btDyYiC
        JdkcxKHIA5PSHfJT9o/Cqt7YXx3axn/K5QG+MsNoSNAs7CacKtP2cVXMGyrIfg1YThAglejnc+STn
        iUZPuR6yxkuXNlQnECo5YCKYSF/1+6pf0vzNvJJLImpNHoyyjYawgb8jkN5ZageFpIx2cj4pWcdxH
        4V+yWoTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUVLB-000510-PD; Fri, 01 May 2020 13:04:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E35BE300F28;
        Fri,  1 May 2020 15:04:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA54529A7943E; Fri,  1 May 2020 15:04:27 +0200 (CEST)
Date:   Fri, 1 May 2020 15:04:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] x86, sched: Bail out of frequency invariance if
 turbo frequency is unknown
Message-ID: <20200501130427.GD3762@hirez.programming.kicks-ass.net>
References: <20200428132450.24901-1-ggherdovich@suse.cz>
 <20200428132450.24901-3-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428132450.24901-3-ggherdovich@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 28, 2020 at 03:24:50PM +0200, Giovanni Gherdovich wrote:
> There may be CPUs that support turbo boost but don't declare any turbo
> ratio, i.e. their MSR_TURBO_RATIO_LIMIT is all zeroes. In that condition
> scale-invariant calculations can't be performed.
> 
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> Suggested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
> ---
>  arch/x86/kernel/smpboot.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 4718f29a3065..ab2a0df7d1fb 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1991,9 +1991,11 @@ static bool intel_set_max_freq_ratio(void)
>  	/*
>  	 * Some hypervisors advertise X86_FEATURE_APERFMPERF
>  	 * but then fill all MSR's with zeroes.
> +	 * Some CPUs have turbo boost but don't declare any turbo ratio
> +	 * in MSR_TURBO_RATIO_LIMIT.
>  	 */
> -	if (!base_freq) {
> -		pr_debug("Couldn't determine cpu base frequency, necessary for scale-invariant accounting.\n");
> +	if (!base_freq || !turbo_freq) {
> +		pr_debug("Couldn't determine cpu base or turbo frequency, necessary for scale-invariant accounting.\n");
>  		return false;
>  	}

I've added the below, imagine base_freq > turbo_freq *
SCHED_CAPACITY_SCALE.

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1975,6 +1975,7 @@ static bool core_set_max_freq_ratio(u64
 static bool intel_set_max_freq_ratio(void)
 {
 	u64 base_freq, turbo_freq;
+	u64 turbo_ratio;
 
 	if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
 		goto out;
@@ -2008,9 +2009,15 @@ static bool intel_set_max_freq_ratio(voi
 		return false;
 	}
 
-	arch_turbo_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
-					base_freq);
+	turbo_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE, base_freq);
+	if (!turbo_ratio) {
+		pr_debug("Non-zero turbo and base frequencies led to a 0 ratio.\n");
+		return false;
+	}
+
+	arch_turbo_freq_ratio = turbo_ratio;
 	arch_set_max_freq_ratio(turbo_disabled());
+
 	return true;
 }
 
