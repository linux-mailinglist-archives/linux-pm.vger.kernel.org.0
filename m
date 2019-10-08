Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A0DCF41D
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2019 09:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfJHHnI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Oct 2019 03:43:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:39514 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730218AbfJHHnI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Oct 2019 03:43:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3AC18AEF1;
        Tue,  8 Oct 2019 07:43:06 +0000 (UTC)
Message-ID: <1570520919.25071.2.camel@suse.cz>
Subject: Re: [PATCH v2 1/2] x86,sched: Add support for frequency invariance
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Len Brown <lenb@kernel.org>, x86@kernel.org,
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
Date:   Tue, 08 Oct 2019 09:48:39 +0200
In-Reply-To: <1990043.dY4KdrEkPr@kreacher>
References: <20191002122926.385-1-ggherdovich@suse.cz>
         <1906426.HDqaVa71mF@kreacher>
         <20191003121537.GR4536@hirez.programming.kicks-ass.net>
         <1990043.dY4KdrEkPr@kreacher>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2019-10-03 at 19:53 +0200, Rafael J. Wysocki wrote:
> On Thursday, October 3, 2019 2:15:37 PM CEST Peter Zijlstra wrote:
> > On Thu, Oct 03, 2019 at 12:27:52PM +0200, Rafael J. Wysocki wrote:
> > > On Wednesday, October 2, 2019 2:29:25 PM CEST Giovanni Gherdovich wrote:
> > > > +static bool turbo_disabled(void)
> > > > +{
> > > > +	u64 misc_en;
> > > > +	int err;
> > > > +
> > > > +	err = rdmsrl_safe(MSR_IA32_MISC_ENABLE, &misc_en);
> > > > +	if (err)
> > > > +		return false;
> > > > +
> > > > +	return (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
> > > > +}
> > > 
> > > This setting may be updated by the platform firmware (BIOS) in some cases
> > > (see kernel.org BZ 200759, for example), so in general checking it once
> > > at the init time is not enough.
> > 
> > Is there anything sane we can do if the BIOS frobs stuff like that under
> > our feet? Other than yell bloody murder, that is?
> 
> Sane?  No, I don't think so.
> 
> Now, in principle *something* could be done to fix things up in the _PPC
> notify handler, but I guess we would just end up disabling the scale
> invariance code altogether in those cases.

I'm looking at how to react to turbo being disabled at run time, assuming a
_PPC notification is triggered in that case.

I don't think the correct action would be to disable scale invariance: if the
turbo range is not available, then max frequency is max_P, and scale
invariance can go on using that. The case max_freq=max_P is represented by
arch_max_freq=1024 in this patch (because arch_max_freq=max_freq*1024/max_P).

Since the variable arch_max_freq is global to all CPUs, the fact that the _PPC
notification is sent to just one CPU is not a concern: the CPU receiving the
notif will set arch_max_freq=1024 (Srinivas was worried about this in another
message).

This looks like a job for the ->update_limits callback you added to "struct
cpufreq_driver" in response to the mentioned kernel.org BZ 200759.
I see that only intel_pstate implements it, it's not clear to me yet if I'll
have to give an ->update_limits to acpi_cpufreq as well to treat this case.


Giovanni
