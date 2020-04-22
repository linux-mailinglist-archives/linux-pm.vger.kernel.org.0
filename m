Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3766C1B4B71
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 19:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDVRRh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 13:17:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:33930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDVRRg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 13:17:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A6D83AC19;
        Wed, 22 Apr 2020 17:17:33 +0000 (UTC)
Message-ID: <1587575853.9537.117.camel@suse.cz>
Subject: Re: [PATCH] x86, sched: Prevent divisions by zero in frequency
 invariant accounting
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>
Date:   Wed, 22 Apr 2020 19:17:33 +0200
In-Reply-To: <20200422145334.GM20730@hirez.programming.kicks-ass.net>
References: <20200422144055.18171-1-ggherdovich@suse.cz>
         <20200422145334.GM20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-04-22 at 16:53 +0200, Peter Zijlstra wrote:
> On Wed, Apr 22, 2020 at 04:40:55PM +0200, Giovanni Gherdovich wrote:
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
> > Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> > Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
> > ---
> >  arch/x86/kernel/smpboot.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > index 8c89e4d9ad28..fb71395cbcad 100644
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> > @@ -2055,14 +2055,14 @@ void arch_scale_freq_tick(void)
> >  
> >  	acnt = aperf - this_cpu_read(arch_prev_aperf);
> >  	mcnt = mperf - this_cpu_read(arch_prev_mperf);
> > -	if (!mcnt)
> > -		return;
> >  
> >  	this_cpu_write(arch_prev_aperf, aperf);
> >  	this_cpu_write(arch_prev_mperf, mperf);
> >  
> >  	acnt <<= 2*SCHED_CAPACITY_SHIFT;
> >  	mcnt *= arch_max_freq_ratio;
> > +	if (!mcnt)
> > +		return;
> 
> Should we not pr_warn() and disable the whole thing when this happens?

Ok, I will resend this patch disabling freq invariant accounting when this
overflow happens.

To elaborate further, your comment touches on an area where x86 freq
invariance is very weak at the moment: what happens if the tick doesn't run on
a cpu for a long time (answer: the estimation of freq_scale is garbage).
And by "a long time" I mean a few seconds; the patch I'm about to resend only
covers a minuscule fraction of those cases. That is, not only the tick has
been missing for days (?!), but we only noticed because the product
mcnt * arch_max_freq_ratio gave exactly 2^64 (aka 0). It could have been
waiting for 1 more millis and we wouldn't have seen the issue.

Anyways I agree on the principle: even if we can't address all problems now,
let's at least cover those where the solution is easy.


Giovanni
