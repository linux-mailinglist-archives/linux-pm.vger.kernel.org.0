Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE08CB72F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 11:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfJDJRw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 05:17:52 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41583 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbfJDJRw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2019 05:17:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id g13so4728573otp.8;
        Fri, 04 Oct 2019 02:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4sHQIu94xzWF2HMMw8MZrhePhhdBNh3YDiLHJCJfguY=;
        b=KSeTqCuXbqeSLk1s8GJTWYTZ70G+jwb+TMUoJJxTB58fITgs7/nRJEmd88UIWA7Swl
         DNeGi7xpYaNKVYvunvzFitbxtYY/VQ/JHam7Pw247nJ22y0TU90WQAeve1KbmoekP7ML
         f69Nm9M90NBnhJb0w997h2m2olmGLAi/DegQpPiIJYYKlkd69/dKtbEDsadi9brk7FC6
         qP8N6kFNIKbky9X28huHy5LdRoRKoaj8G3nZH5+kamAcMyOw3TOMxpq3YUQbiTuoZV/b
         0eCKo8yENBKQjA+PLWCDQ5ometnPqoNSJZvvBISNLOzAzBQ+379ZzL0z6B3L84TSKf3x
         Q5GQ==
X-Gm-Message-State: APjAAAVTVXz9TpkdSNmrbQ/w/n2mGsw5iRfmiSuhPVy16c80vmYs54nX
        DQqkNdGD6E7hbukZqF0NqUxusT0mZO7okXierO8=
X-Google-Smtp-Source: APXvYqzsjdaEQCbotxJo3CPT06zTKV3UI+cRyYBGDFf8EipAF4/3oIPKNRxNbLhtw1cNOSiaD+IM5tbuM1m2GyyIKMY=
X-Received: by 2002:a9d:6301:: with SMTP id q1mr9881718otk.262.1570180668950;
 Fri, 04 Oct 2019 02:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191002122926.385-1-ggherdovich@suse.cz> <20191002122926.385-3-ggherdovich@suse.cz>
 <13106850.QMtCbivBLn@kreacher> <5d6d601d2647644238fc51621407061e1c29320d.camel@linux.intel.com>
 <1570177786.30086.1.camel@suse.cz> <CAJZ5v0jK1kMjQ3gu8KhQmp2Paq9Rb74NPjMQ1HsVRCD3Fct5TQ@mail.gmail.com>
 <1570179472.30086.4.camel@suse.cz>
In-Reply-To: <1570179472.30086.4.camel@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Oct 2019 11:17:37 +0200
Message-ID: <CAJZ5v0gAsd4=LOd0BBJGZgwg2TYUuQP_-FzYXS4k+XK1vfM_3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: intel_pstate: Conditional frequency
 invariant accounting
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
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

On Fri, Oct 4, 2019 at 10:52 AM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> On Fri, 2019-10-04 at 10:29 +0200, Rafael J. Wysocki wrote:
> > On Fri, Oct 4, 2019 at 10:24 AM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
> > >
> > > On Thu, 2019-10-03 at 20:31 -0700, Srinivas Pandruvada wrote:
> > > > On Thu, 2019-10-03 at 20:05 +0200, Rafael J. Wysocki wrote:
> > > > > On Wednesday, October 2, 2019 2:29:26 PM CEST Giovanni Gherdovich
> > > > > wrote:
> > > > > > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > > >
> > > > > > intel_pstate has two operating modes: active and passive. In "active"
> > > > > > mode, the in-built scaling governor is used and in "passive" mode, the
> > > > > > driver can be used with any governor like "schedutil". In "active" mode
> > > > > > the utilization values from schedutil is not used and there is a
> > > > > > requirement from high performance computing use cases, not to readas
> > > > > > well any APERF/MPERF MSRs.
> > > > >
> > > > > Well, this isn't quite convincing.
> > > > >
> > > > > In particular, I don't see why the "don't read APERF/MPERF MSRs" argument
> > > > > applies *only* to intel_pstate in the "active" mode.  What about
> > > > > intel_pstate in the "passive" mode combined with the "performance"
> > > > > governor?  Or any other governor different from "schedutil" for that
> > > > > matter?
> > > > >
> > > > > And what about acpi_cpufreq combined with any governor different from
> > > > > "schedutil"?
> > > > >
> > > > > Scale invariance is not really needed in all of those cases right now
> > > > > AFAICS, or is it?
> > > >
> > > > Correct. This is just part of the patch to disable in active mode
> > > > (particularly in HWP and performance mode).
> > > >
> > > > But this patch is 2 years old. The folks who wanted this, disable
> > > > intel-pstate and use userspace governor with acpi-cpufreq. So may be
> > > > better to address those cases too.
> > >
> > > I disagree with "scale invariance is needed only by the schedutil governor";
> > > the two other users are the CPU's estimated utilization in the wakeup path,
> > > via cpu_util_without(), as well as the load-balance path, via cpu_util() which
> > > is used by update_sg_lb_stats().
> >
> > OK, so there are reasons to run the scale invariance code which are
> > not related to the cpufreq governor in use.
> >
> > I wonder then why those reasons are not relevant for intel_pstate in
> > the "active" mode.
> >
> > > Also remember that scale invariance is applied to both PELT signals util_avg
> > > and load_avg; schedutil uses the former but not the latter.
> > >
> > > I understand Srinivas patch to disable MSR accesses during the tick as a
> > > band-aid solution to address a specific use case he cares about, but I don't
> > > think that extending this approach to any non-schedutil governor is a good
> > > idea -- you'd be killing load balancing in the process.
> >
> > But that is also the case for intel_pstate in the "active" mode, isn't it?
>
> Sure it is.
>
> Now, what's the performance impact of loosing scale-invariance in PELT signals?

That needs to be measured.

> And what's the performance impact of accessing two MSRs at the scheduler tick
> on each CPU?

That would be the MSR access latency times two and I don't remember
the exact numbers from the top of my head.  It would also depend on
how much time it takes to run the tick without those two MSR accesses,
on average.

The question I have, however, is whether or not it really is necessary
to update arch_cpu_freq on every tick.  Maybe it would be sufficient
to do that every 10 ms, say (in case the tick is more frequent than
that), or similar?

> I am sporting Srinivas' patch because he expressed the concern that the losses
> don't justify the gains for a specific class of users (supercomputing),
> although I don't fully like the idea (and arguably that should be measured).

My point is that this patch doesn't even cover the entire case in
question, because the HPC people may very well be using cpufreq
driver/governor configurations different from intel_pstate in the
"active" mode.  Moreover, given the lack of data, it is even hard to
say what the potential impact is, if any.

I guess it should be a fairly straightforward exercise to compare the
results of the various benchmarks using intel_pstate in the "passive"
mode and the "performance" governor with and without patch [1/2] from
this series. If you see any perf regressions after applying the patch,
that's what the others will probably see as well.
