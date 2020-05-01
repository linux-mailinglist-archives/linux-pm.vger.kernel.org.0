Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34761C1598
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgEANaz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 09:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730043AbgEANay (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 09:30:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D8AC061A0C;
        Fri,  1 May 2020 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g1HJbRTAH6u4WBCmhMZ9LnGwhoaAiquAYI+U4ca89TU=; b=oyDdMDAg89BCnftkud0KnfX+Z9
        9Ai6tavDSvb42MbYg/Sk7oB9XLAxIU3UNFnxjSFjM+nsOAtqCaBYFZad5DmH9pIqED0r/tyEkxZTZ
        pHJ01TYue0gOaNpQtZ1WJ8veKIu3sRO8L+tQ7ga+YVIhJ5OJi7QVSxEbkhPZURdlwe623hdUIszkm
        iCVIlbZI+HC/FoiqQbMPnp1dt/cE4fPPdC42kSGUSQnKJLRwxCemoXV0OsCDxRxT3SHbiTCkrMDHb
        TOgf7cyxpAb1YVWkjHqoQqOKIHmJNluaoMl3tUeN472F67EGVE7FVU+caPQ661NhpIS0/+v8pAr5S
        5yvBLsvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUVkc-0007vG-5C; Fri, 01 May 2020 13:30:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EDCEE3075F9;
        Fri,  1 May 2020 15:30:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB3F32391C520; Fri,  1 May 2020 15:30:42 +0200 (CEST)
Date:   Fri, 1 May 2020 15:30:42 +0200
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
Subject: Re: [PATCH 1/2] x86, sched: Prevent divisions by zero in frequency
 invariant accounting
Message-ID: <20200501133042.GE3762@hirez.programming.kicks-ass.net>
References: <20200428132450.24901-1-ggherdovich@suse.cz>
 <20200428132450.24901-2-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428132450.24901-2-ggherdovich@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 28, 2020 at 03:24:49PM +0200, Giovanni Gherdovich wrote:
> The product mcnt * arch_max_freq_ratio could be zero if it overflows u64.
> 
> For context, a large value for arch_max_freq_ratio would be 5000,
> corresponding to a turbo_freq/base_freq ratio of 5 (normally it's more like
> 1500-2000). A large increment frequency for the MPERF counter would be 5GHz
> (the base clock of all CPUs on the market today is less than that). With
> these figures, a CPU would need to go without a scheduler tick for around 8
> days for the u64 overflow to happen. It is unlikely, but the check is
> warranted.
> 
> In that case it's also appropriate to disable frequency invariant
> accounting: the feature relies on measures of the clock frequency done at
> every scheduler tick, which need to be "fresh" to be at all meaningful.
> 
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")

>  	acnt <<= 2*SCHED_CAPACITY_SHIFT;
>  	mcnt *= arch_max_freq_ratio;
> +	if (!mcnt) {

The problem is; this doesn't do what you claim it does.

> +		pr_warn("Scheduler tick missing for long time, disabling scale-invariant accounting.\n");
> +		/* static_branch_disable() acquires a lock and may sleep */
> +		schedule_work(&disable_freq_invariance_work);
> +		return;
> +	}
>  
>  	freq_scale = div64_u64(acnt, mcnt);

I've changed the patch like so.. OK?

(ok, perhaps I went a little overboard with the paranoia ;-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -55,6 +55,7 @@
 #include <linux/gfp.h>
 #include <linux/cpuidle.h>
 #include <linux/numa.h>
+#include <linux/overflow.h>
 
 #include <asm/acpi.h>
 #include <asm/desc.h>
@@ -2057,11 +2058,19 @@ static void init_freq_invariance(bool se
 	}
 }
 
+static void disable_freq_invariance_workfn(struct work_struct *work)
+{
+	static_branch_disable(&arch_scale_freq_key);
+}
+
+static DECLARE_WORK(disable_freq_invariance_work,
+		    disable_freq_invariance_workfn);
+
 DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
 
 void arch_scale_freq_tick(void)
 {
-	u64 freq_scale;
+	u64 freq_scale = SCHED_CAPACITY_SCALE;
 	u64 aperf, mperf;
 	u64 acnt, mcnt;
 
@@ -2073,19 +2082,27 @@ void arch_scale_freq_tick(void)
 
 	acnt = aperf - this_cpu_read(arch_prev_aperf);
 	mcnt = mperf - this_cpu_read(arch_prev_mperf);
-	if (!mcnt)
-		return;
 
 	this_cpu_write(arch_prev_aperf, aperf);
 	this_cpu_write(arch_prev_mperf, mperf);
 
-	acnt <<= 2*SCHED_CAPACITY_SHIFT;
-	mcnt *= arch_max_freq_ratio;
+	if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
+		goto error;
+
+	if (check_mul_overflow(mcnt, arch_max_freq_ratio, &mcnt) || !mcnt)
+		goto error;
 
 	freq_scale = div64_u64(acnt, mcnt);
+	if (!freq_scale)
+		goto error;
 
 	if (freq_scale > SCHED_CAPACITY_SCALE)
 		freq_scale = SCHED_CAPACITY_SCALE;
 
 	this_cpu_write(arch_freq_scale, freq_scale);
+	return;
+
+error:
+	pr_warn("Scheduler frequency invariance went wobbly, disabling!\n");
+	schedule_work(&disable_freq_invariance_work);
 }
