Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD46D1C260D
	for <lists+linux-pm@lfdr.de>; Sat,  2 May 2020 16:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgEBOZF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 May 2020 10:25:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:34120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgEBOZF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 2 May 2020 10:25:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 35938B019;
        Sat,  2 May 2020 14:25:03 +0000 (UTC)
Message-ID: <1588429500.8505.29.camel@suse.cz>
Subject: Re: [PATCH 1/2] x86, sched: Prevent divisions by zero in frequency
 invariant accounting
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 02 May 2020 16:25:00 +0200
In-Reply-To: <20200501133042.GE3762@hirez.programming.kicks-ass.net>
References: <20200428132450.24901-1-ggherdovich@suse.cz>
         <20200428132450.24901-2-ggherdovich@suse.cz>
         <20200501133042.GE3762@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2020-05-01 at 15:30 +0200, Peter Zijlstra wrote:
> On Tue, Apr 28, 2020 at 03:24:49PM +0200, Giovanni Gherdovich wrote:
> > The product mcnt * arch_max_freq_ratio could be zero if it overflows u64.
> > 
> > For context, a large value for arch_max_freq_ratio would be 5000,
> > corresponding to a turbo_freq/base_freq ratio of 5 (normally it's more like
> > 1500-2000). A large increment frequency for the MPERF counter would be 5GHz
> > (the base clock of all CPUs on the market today is less than that). With
> > these figures, a CPU would need to go without a scheduler tick for around 8
> > days for the u64 overflow to happen. It is unlikely, but the check is
> > warranted.
> > 
> > In that case it's also appropriate to disable frequency invariant
> > accounting: the feature relies on measures of the clock frequency done at
> > every scheduler tick, which need to be "fresh" to be at all meaningful.
> > 
> > Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> > Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
> >  	acnt <<= 2*SCHED_CAPACITY_SHIFT;
> >  	mcnt *= arch_max_freq_ratio;
> > +	if (!mcnt) {
> 
> The problem is; this doesn't do what you claim it does.
> 
> > +		pr_warn("Scheduler tick missing for long time, disabling scale-invariant accounting.\n");
> > +		/* static_branch_disable() acquires a lock and may sleep */
> > +		schedule_work(&disable_freq_invariance_work);
> > +		return;
> > +	}
> >  
> >  	freq_scale = div64_u64(acnt, mcnt);
> 
> I've changed the patch like so.. OK?
> 
> (ok, perhaps I went a little overboard with the paranoia ;-)

Right, I wasn't really checking for overflow, only for when the product
"mcnt * arch_max_freq_ratio" becomes zero.

Thanks for your edit (I took note of the macros check_*_overflow, didn't know
them). I fully subscribe to the paranoid approach.

I understand you've already edited the patches in your tree, so I am not
resending, just confirming my

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>

> 
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -55,6 +55,7 @@
>  #include <linux/gfp.h>
>  #include <linux/cpuidle.h>
>  #include <linux/numa.h>
> +#include <linux/overflow.h>
>  
>  #include <asm/acpi.h>
>  #include <asm/desc.h>
> @@ -2057,11 +2058,19 @@ static void init_freq_invariance(bool se
>  	}
>  }
>  
> +static void disable_freq_invariance_workfn(struct work_struct *work)
> +{
> +	static_branch_disable(&arch_scale_freq_key);
> +}
> +
> +static DECLARE_WORK(disable_freq_invariance_work,
> +		    disable_freq_invariance_workfn);
> +
>  DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
>  
>  void arch_scale_freq_tick(void)
>  {
> -	u64 freq_scale;
> +	u64 freq_scale = SCHED_CAPACITY_SCALE;
>  	u64 aperf, mperf;
>  	u64 acnt, mcnt;
>  
> @@ -2073,19 +2082,27 @@ void arch_scale_freq_tick(void)
>  
>  	acnt = aperf - this_cpu_read(arch_prev_aperf);
>  	mcnt = mperf - this_cpu_read(arch_prev_mperf);
> -	if (!mcnt)
> -		return;
>  
>  	this_cpu_write(arch_prev_aperf, aperf);
>  	this_cpu_write(arch_prev_mperf, mperf);
>  
> -	acnt <<= 2*SCHED_CAPACITY_SHIFT;
> -	mcnt *= arch_max_freq_ratio;
> +	if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
> +		goto error;
> +
> +	if (check_mul_overflow(mcnt, arch_max_freq_ratio, &mcnt) || !mcnt)
> +		goto error;
>  
>  	freq_scale = div64_u64(acnt, mcnt);
> +	if (!freq_scale)
> +		goto error;
>  
>  	if (freq_scale > SCHED_CAPACITY_SCALE)
>  		freq_scale = SCHED_CAPACITY_SCALE;
>  
>  	this_cpu_write(arch_freq_scale, freq_scale);
> +	return;
> +
> +error:
> +	pr_warn("Scheduler frequency invariance went wobbly, disabling!\n");
> +	schedule_work(&disable_freq_invariance_work);
>  }
