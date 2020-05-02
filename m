Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DD21C260F
	for <lists+linux-pm@lfdr.de>; Sat,  2 May 2020 16:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgEBO02 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 May 2020 10:26:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:34224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgEBO02 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 2 May 2020 10:26:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D010BB019;
        Sat,  2 May 2020 14:26:26 +0000 (UTC)
Message-ID: <1588429584.8505.31.camel@suse.cz>
Subject: Re: [PATCH 2/2] x86, sched: Bail out of frequency invariance if
 turbo frequency is unknown
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
Date:   Sat, 02 May 2020 16:26:24 +0200
In-Reply-To: <20200501130427.GD3762@hirez.programming.kicks-ass.net>
References: <20200428132450.24901-1-ggherdovich@suse.cz>
         <20200428132450.24901-3-ggherdovich@suse.cz>
         <20200501130427.GD3762@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2020-05-01 at 15:04 +0200, Peter Zijlstra wrote:
> On Tue, Apr 28, 2020 at 03:24:50PM +0200, Giovanni Gherdovich wrote:
> > There may be CPUs that support turbo boost but don't declare any turbo
> > ratio, i.e. their MSR_TURBO_RATIO_LIMIT is all zeroes. In that condition
> > scale-invariant calculations can't be performed.
> > 
> > Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> > Suggested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
> > ---
> >  arch/x86/kernel/smpboot.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > index 4718f29a3065..ab2a0df7d1fb 100644
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> > @@ -1991,9 +1991,11 @@ static bool intel_set_max_freq_ratio(void)
> >  	/*
> >  	 * Some hypervisors advertise X86_FEATURE_APERFMPERF
> >  	 * but then fill all MSR's with zeroes.
> > +	 * Some CPUs have turbo boost but don't declare any turbo ratio
> > +	 * in MSR_TURBO_RATIO_LIMIT.
> >  	 */
> > -	if (!base_freq) {
> > -		pr_debug("Couldn't determine cpu base frequency, necessary for scale-invariant accounting.\n");
> > +	if (!base_freq || !turbo_freq) {
> > +		pr_debug("Couldn't determine cpu base or turbo frequency, necessary for scale-invariant accounting.\n");
> >  		return false;
> >  	}
> 
> I've added the below, imagine base_freq > turbo_freq *
> SCHED_CAPACITY_SCALE.

Right, I didn't consider that case. It doesn't hurt to be defensive.

I understand you've already edited the patches in your tree, so I am not
resending, just confirming my

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>

> 
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1975,6 +1975,7 @@ static bool core_set_max_freq_ratio(u64
>  static bool intel_set_max_freq_ratio(void)
>  {
>  	u64 base_freq, turbo_freq;
> +	u64 turbo_ratio;
>  
>  	if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
>  		goto out;
> @@ -2008,9 +2009,15 @@ static bool intel_set_max_freq_ratio(voi
>  		return false;
>  	}
>  
> -	arch_turbo_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
> -					base_freq);
> +	turbo_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE, base_freq);
> +	if (!turbo_ratio) {
> +		pr_debug("Non-zero turbo and base frequencies led to a 0 ratio.\n");
> +		return false;
> +	}
> +
> +	arch_turbo_freq_ratio = turbo_ratio;
>  	arch_set_max_freq_ratio(turbo_disabled());
> +
>  	return true;
>  }
>  
