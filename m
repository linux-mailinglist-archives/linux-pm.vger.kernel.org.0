Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4A1287A97
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbgJHRIS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 13:08:18 -0400
Received: from foss.arm.com ([217.140.110.172]:39744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730545AbgJHRIR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 13:08:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26CD2D6E;
        Thu,  8 Oct 2020 10:08:17 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBC693F802;
        Thu,  8 Oct 2020 10:08:16 -0700 (PDT)
Date:   Thu, 8 Oct 2020 18:08:15 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Nicola Mazzucato <nicola.mazzucato@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201008170815.GB29728@arm.com>
References: <20200924095347.32148-1-nicola.mazzucato@arm.com>
 <20200924095347.32148-3-nicola.mazzucato@arm.com>
 <20201006071909.3cgz7i5v35dgnuzn@vireshk-i7>
 <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
 <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7>
 <20201008150317.GB20268@arm.com>
 <CAJZ5v0j=g6y53yk_+cPNnUYb6usrQmghCNuiHYc1vbpsypFtCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j=g6y53yk_+cPNnUYb6usrQmghCNuiHYc1vbpsypFtCQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Thursday 08 Oct 2020 at 17:57:23 (+0200), Rafael J. Wysocki wrote:
> On Thu, Oct 8, 2020 at 5:03 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> >
> > Hi Viresh,
> >
> > On Thursday 08 Oct 2020 at 16:32:41 (+0530), Viresh Kumar wrote:
> > > On 07-10-20, 13:58, Nicola Mazzucato wrote:
> > > > Hi Viresh,
> > > >
> > > > performance controls is what is exposed by the firmware through a protocol that
> > > > is not capable of describing hardware (say SCMI). For example, the firmware can
> > > > tell that the platform has N controls, but it can't say to which hardware they
> > > > are "wired" to. This is done in dt, where, for example, we map these controls
> > > > to cpus, gpus, etc.
> > > >
> > > > Let's focus on cpus.
> > > >
> > > > Normally we would have N of performance controls (what comes from f/w)
> > > > that that correspond to hardware clock/dvfs domains.
> > > >
> > > > However, some firmware implementations might benefit from having finer
> > > > grained information about the performance requirements (e.g.
> > > > per-CPU) and therefore choose to present M performance controls to the
> > > > OS. DT would be adjusted accordingly to "wire" these controls to cpus
> > > > or set of cpus.
> > > > In this scenario, the f/w will make aggregation decisions based on the
> > > > requests it receives on these M controls.
> > > >
> > > > Here we would have M cpufreq policies which do not necessarily reflect the
> > > > underlying clock domains, thus some s/w components will underperform
> > > > (EAS and thermal, for example).
> > > >
> > > > A real example would be a platform in which the firmware describes the system
> > > > having M per-cpu control, and the cpufreq subsystem will have M policies while
> > > > in fact these cpus are "performance-dependent" each other (e.g. are in the same
> > > > clock domain).
> > >
> > > If the CPUs are in the same clock domain, they must be part of the
> > > same cpufreq policy.
> >
> > But cpufreq does not currently support HW_ALL (I'm using the ACPI
> > coordination type to describe the generic scenario of using hardware
> > aggregation and coordination when establishing the clock rate of CPUs).
> >
> > Adding support for HW_ALL* will involve either bypassing some
> > assumptions around cpufreq policies or making core cpufreq changes.
> >
> > In the way I see it, support for HW_ALL involves either:
> >
> >  - (a) Creating per-cpu policies in order to allow each of the CPUs to
> >    send their own frequency request to the hardware which will do
> >    aggregation and clock rate decision at the level of the clock
> >    domain.
> 
> This has been done for years on many platforms.

Exactly!

> 
> >    The PSD domains (ACPI) and the new DT binding will tell
> >    which CPUs are actually in the same clock domain for whomever is
> >    interested, despite those CPUs not being in the same policy.
> 
> And this information hasn't been used so far in those cases.
> 
> >    This requires the extra mask that Nicola introduced.
> 
> What would you use it for, specifically?

This would be useful for:

 - Energy Aware Scheduling: for this you need to know how other CPUs in
   a clock domain would be impacted by a task placement. For example,
   if the utilization of a CPU would increase as a result of a certain
   task placement choice and as a result (for schedutil) its clock rate
   need would increase as well, this increase in the clock rate, and
   therefore energy, of the entire domain is considered before making
   that task placement choice.

 - Thermal: the usefulness is dependent on the distribution of thermal
   zones and their attached cooling devices. But with knowledge about
   what CPUs use the same clock, the thermal governors could cap all
   dependent CPUs in one go, while for some governor (IPA) knowing about
   dependent CPUs help with more accurate power allocation, similar to
   EAS.

 - Frequency invariance: ideally one would have counters for this,
   but when lacking counters, even knowing that some CPUs have the same
   frequency and after using some software aggregation (likely maximum)
   to establish what that frequency might be, I believe it would still
   be more useful than no frequency invariance at all.

Even if in these cases you don't have accurate information about the
frequency that hardware will grant, knowing that some CPUs will change
frequency together is useful. Given that some of the above users (EAS,
IPA) are proactive and are trying to predict the future state of a
system, they did not have completely accurate information to begin with.
But not taking into account CPUs sharing a clock will result in too
much inaccuracy (that even control loops and can't compensate for).
This together with the assumption* that predicted frequencies won't be
very far off from granted frequencies will result in maintaining these
features in a more useful state.

*my assumption, until proven otherwise :)

> 
> >  - (b) Making deep changes to cpufreq (core/governors/drivers) to allow:
> 
> Not an option really.

Agreed!

Thanks,
Ionela.
