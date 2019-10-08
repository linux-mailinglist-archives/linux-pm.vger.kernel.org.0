Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B70CCF611
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2019 11:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfJHJcw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Oct 2019 05:32:52 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32837 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbfJHJcw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Oct 2019 05:32:52 -0400
Received: by mail-oi1-f195.google.com with SMTP id a15so8191511oic.0;
        Tue, 08 Oct 2019 02:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpyIfFhb6u0PVbeugJF5vjG519P0Ebf37EyYspX74y0=;
        b=nsv+qxZWPdOU8zrn4NM2Dhvo5vv2AhyLv9lJf7SJ1EXhR/+1w9B8qq2ZbvpxUgFxZV
         0T9t4Nx0NlBXgTTDB3JLEf+K1wNfwa93LMns0Wf2yHE5oEO8/jxFljv9Ug/e+6y0cZSN
         M+HC4VWz++60RaHiQLhg9CqzLuTeZGTn0/Kncj1gkcgayNW43AUxOYvz8kl/vlWfqx9w
         RRvdWirGK8mrzKv5CM6Bf2BqFLV948SNpcDwgXJLlq6R/8NqH9A3dr0VZEiavz67WMLE
         gj7FqhWh5ao0FJ3Qj4w7KrK1EgKCtdSFhdBHjoP/7Vg+Oizd4h4XEf5rZC8rZGI20VCA
         N7mg==
X-Gm-Message-State: APjAAAUmsIN/zMhozYAwYCFAMROjAbdSfzaULlIZEd28DSB7IZ7Vk1bJ
        WWnJOF5HJs18a7PRG6mD0T7wS4KHwNL+NpnInww=
X-Google-Smtp-Source: APXvYqzj3VKcMMb/wWxnx/nhRa/HPA2yYO1wwxiMKhHhurdmx5hX69hbO2rtgrkjdViD+rzIh1OQwgRHC3guGHA3VCs=
X-Received: by 2002:aca:484:: with SMTP id 126mr3035077oie.68.1570527169759;
 Tue, 08 Oct 2019 02:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191002122926.385-1-ggherdovich@suse.cz> <1906426.HDqaVa71mF@kreacher>
 <20191003121537.GR4536@hirez.programming.kicks-ass.net> <1990043.dY4KdrEkPr@kreacher>
 <1570520919.25071.2.camel@suse.cz>
In-Reply-To: <1570520919.25071.2.camel@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Oct 2019 11:32:38 +0200
Message-ID: <CAJZ5v0ivtBCPCUj-bQvhyuda=dh71P+YeXVeM=FffATnAU_bLw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] x86,sched: Add support for frequency invariance
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Len Brown <lenb@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 8, 2019 at 9:43 AM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> On Thu, 2019-10-03 at 19:53 +0200, Rafael J. Wysocki wrote:
> > On Thursday, October 3, 2019 2:15:37 PM CEST Peter Zijlstra wrote:
> > > On Thu, Oct 03, 2019 at 12:27:52PM +0200, Rafael J. Wysocki wrote:
> > > > On Wednesday, October 2, 2019 2:29:25 PM CEST Giovanni Gherdovich wrote:
> > > > > +static bool turbo_disabled(void)
> > > > > +{
> > > > > +       u64 misc_en;
> > > > > +       int err;
> > > > > +
> > > > > +       err = rdmsrl_safe(MSR_IA32_MISC_ENABLE, &misc_en);
> > > > > +       if (err)
> > > > > +               return false;
> > > > > +
> > > > > +       return (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
> > > > > +}
> > > >
> > > > This setting may be updated by the platform firmware (BIOS) in some cases
> > > > (see kernel.org BZ 200759, for example), so in general checking it once
> > > > at the init time is not enough.
> > >
> > > Is there anything sane we can do if the BIOS frobs stuff like that under
> > > our feet? Other than yell bloody murder, that is?
> >
> > Sane?  No, I don't think so.
> >
> > Now, in principle *something* could be done to fix things up in the _PPC
> > notify handler, but I guess we would just end up disabling the scale
> > invariance code altogether in those cases.
>
> I'm looking at how to react to turbo being disabled at run time, assuming a
> _PPC notification is triggered in that case.
>
> I don't think the correct action would be to disable scale invariance: if the
> turbo range is not available, then max frequency is max_P, and scale
> invariance can go on using that. The case max_freq=max_P is represented by
> arch_max_freq=1024 in this patch (because arch_max_freq=max_freq*1024/max_P).

OK, so now you have the case when the BIOS enables turbo on the fly,
but then the scale invariance is not going to be enabled AFAICS.

> Since the variable arch_max_freq is global to all CPUs, the fact that the _PPC
> notification is sent to just one CPU is not a concern: the CPU receiving the
> notif will set arch_max_freq=1024 (Srinivas was worried about this in another
> message).
>
> This looks like a job for the ->update_limits callback you added to "struct
> cpufreq_driver" in response to the mentioned kernel.org BZ 200759.
> I see that only intel_pstate implements it, it's not clear to me yet if I'll
> have to give an ->update_limits to acpi_cpufreq as well to treat this case.

If you want acpi_cpufreq and intel_pstate to be consistent with each
other in that repsect, then yes.
