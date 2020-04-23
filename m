Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F2E1B56E7
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 10:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgDWIGI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 04:06:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:48388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgDWIGI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Apr 2020 04:06:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 56E0FAA4F;
        Thu, 23 Apr 2020 08:06:05 +0000 (UTC)
Message-ID: <1587629164.28094.11.camel@suse.cz>
Subject: Re: [PATCH 1/4] x86, sched: Bail out of frequency invariance if
 base frequency is unknown
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Doug Smythies <dsmythies@telus.net>,
        Like Xu <like.xu@linux.intel.com>,
        Neil Rickert <nwr10cst-oslnx@yahoo.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Date:   Thu, 23 Apr 2020 10:06:04 +0200
In-Reply-To: <20200422171547.GA11942@ranerica-svr.sc.intel.com>
References: <20200416054745.740-1-ggherdovich@suse.cz>
         <20200416054745.740-2-ggherdovich@suse.cz>
         <20200422171547.GA11942@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-04-22 at 10:15 -0700, Ricardo Neri wrote:
> On Thu, Apr 16, 2020 at 07:47:42AM +0200, Giovanni Gherdovich wrote:
> > Some hypervisors such as VMWare ESXi 5.5 advertise support for
> > X86_FEATURE_APERFMPERF but then fill all MSR's with zeroes. In particular,
> > MSR_PLATFORM_INFO set to zero tricks the code that wants to know the base
> > clock frequency of the CPU (highest non-turbo frequency), producing a
> > division by zero when computing the ratio turbo_freq/base_freq necessary
> > for frequency invariant accounting.
> > 
> > It is to be noted that even if MSR_PLATFORM_INFO contained the appropriate
> > data, APERF and MPERF are constantly zero on ESXi 5.5, thus freq-invariance
> > couldn't be done in principle (not that it would make a lot of sense in a
> > VM anyway). The real problem is advertising X86_FEATURE_APERFMPERF. This
> > appears to be fixed in more recent versions: ESXi 6.7 doesn't advertise
> > that feature.
> > 
> > Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> > Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
> > ---
> >  arch/x86/kernel/smpboot.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > index fe3ab9632f3b..3a318ec9bc17 100644
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> > @@ -1985,6 +1985,15 @@ static bool intel_set_max_freq_ratio(void)
> >  	return false;
> >  
> >  out:
> > +	/*
> > +	 * Some hypervisors advertise X86_FEATURE_APERFMPERF
> > +	 * but then fill all MSR's with zeroes.
> > +	 */
> > +	if (!base_freq) {
> > +		pr_debug("Couldn't determine cpu base frequency, necessary for scale-invariant accounting.\n");
> > +		return false;
> > +	}
> 
> It may be possible that MSR_TURBO_RATIO_LIMIT is also all-zeros. In
> such case, turbo_freq will be also zero. If that is the case,
> arch_max_freq_ratio will be zero and we will see a division by zero
> exception in arch_scale_freq_tick() because mcnt is multiplied by
> arch_max_freq_ratio().

Thanks Ricardo for clarifying this.

Follow-up question: when I see an all-zeros MSR_TURBO_RATIO_LIMIT, can I
assume the CPU doesn't support turbo boost? Or is it possible that such a CPU
has turbo boost, just the turbo ratios aren't declared in the MSR?

Some context: this feature (called "frequency invariance") wants to know
what's the max clock freq a CPU can have at any time (it needs it for some
scheduler calculations). This is hard to know precisely, because turbo can
kick in at any time and depends on many factors.  So it settles for an
"average maximum frequency", which I decided the 4 cores turbo is a good
estimate for. Now, if an all-zeros MSR_TURBO_RATIO_LIMIT means "turbo boost
unsupported", this is actually the easy case because then I know exactly what
the max freq is (base frequency). If, on the other hand, an all-zeros MSR
means "there may or may not be turbo, and you don't know how much" then I must
disable frequency invariance.


Thanks,
Giovanni
