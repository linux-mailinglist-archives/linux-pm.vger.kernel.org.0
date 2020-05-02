Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22A21C21C8
	for <lists+linux-pm@lfdr.de>; Sat,  2 May 2020 02:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgEBAFg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 20:05:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:12649 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgEBAFg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 20:05:36 -0400
IronPort-SDR: UlZM9BZb7ufLCJ2yP+ZdMUS2Pg+X0+ozunH0TcMI93fX/ffZaGSWr+jeblRMwSqspZXedR8uuM
 HUGaPFEODgIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 17:05:35 -0700
IronPort-SDR: K70DggpAD+F/gP8NeaI9Jpjm81GiddEY1n6voc9WdkDg3aVj8yuITrRC7nex6gYQ9DvqWY54vT
 l0nMAg/l+vEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,342,1583222400"; 
   d="scan'208";a="433466848"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 01 May 2020 17:05:35 -0700
Date:   Fri, 1 May 2020 17:06:07 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] x86, sched: Bail out of frequency invariance if
 turbo frequency is unknown
Message-ID: <20200502000607.GB3118@ranerica-svr.sc.intel.com>
References: <20200428132450.24901-1-ggherdovich@suse.cz>
 <20200428132450.24901-3-ggherdovich@suse.cz>
 <20200501130427.GD3762@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501130427.GD3762@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 01, 2020 at 03:04:27PM +0200, Peter Zijlstra wrote:
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

I guess this covers more cases in which turbo_ratio can be zero.

Also, FWIW

Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Thanks and BR,
Ricardo
