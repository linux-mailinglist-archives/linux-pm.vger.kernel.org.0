Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0C928BCFE
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 17:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgJLPy5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 11:54:57 -0400
Received: from foss.arm.com ([217.140.110.172]:54716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729816AbgJLPy5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Oct 2020 11:54:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75C0031B;
        Mon, 12 Oct 2020 08:54:55 -0700 (PDT)
Received: from bogus (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A35BC3F719;
        Mon, 12 Oct 2020 08:54:53 -0700 (PDT)
Date:   Mon, 12 Oct 2020 16:54:43 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, chris.redpath@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>, morten.rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201012155443.GE16519@bogus>
References: <20200924095347.32148-1-nicola.mazzucato@arm.com>
 <20200924095347.32148-3-nicola.mazzucato@arm.com>
 <20201006071909.3cgz7i5v35dgnuzn@vireshk-i7>
 <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
 <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7>
 <20201008150317.GB20268@arm.com>
 <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
 <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7>
 <42e3c8e9-cadc-d013-1e1f-fa06af4a45ff@arm.com>
 <20201009140141.GA4048593@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009140141.GA4048593@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 09, 2020 at 09:01:41AM -0500, Rob Herring wrote:
> On Fri, Oct 09, 2020 at 12:10:03PM +0100, Nicola Mazzucato wrote:
> > Hi Viresh, I'm glad it helped.
> >
> > Please find below my reply.
> >
> > On 10/9/20 6:39 AM, Viresh Kumar wrote:
> > > On 08-10-20, 17:00, Nicola Mazzucato wrote:
> > >> On 10/8/20 4:03 PM, Ionela Voinescu wrote:
> > >>> Hi Viresh,
> > >>>
> > >>> On Thursday 08 Oct 2020 at 16:32:41 (+0530), Viresh Kumar wrote:
> > >>>> On 07-10-20, 13:58, Nicola Mazzucato wrote:
> > >>>>> Hi Viresh,
> > >>>>>
> > >>>>> performance controls is what is exposed by the firmware through a protocol that
> > >>>>> is not capable of describing hardware (say SCMI). For example, the firmware can
> > >>>>> tell that the platform has N controls, but it can't say to which hardware they
> > >>>>> are "wired" to. This is done in dt, where, for example, we map these controls
> > >>>>> to cpus, gpus, etc.
> > >>>>>
> > >>>>> Let's focus on cpus.
> > >>>>>
> > >>>>> Normally we would have N of performance controls (what comes from f/w)
> > >>>>> that that correspond to hardware clock/dvfs domains.
> > >>>>>
> > >>>>> However, some firmware implementations might benefit from having finer
> > >>>>> grained information about the performance requirements (e.g.
> > >>>>> per-CPU) and therefore choose to present M performance controls to the
> > >>>>> OS. DT would be adjusted accordingly to "wire" these controls to cpus
> > >>>>> or set of cpus.
> > >>>>> In this scenario, the f/w will make aggregation decisions based on the
> > >>>>> requests it receives on these M controls.
> > >>>>>
> > >>>>> Here we would have M cpufreq policies which do not necessarily reflect the
> > >>>>> underlying clock domains, thus some s/w components will underperform
> > >>>>> (EAS and thermal, for example).
> > >>>>>
> > >>>>> A real example would be a platform in which the firmware describes the system
> > >>>>> having M per-cpu control, and the cpufreq subsystem will have M policies while
> > >>>>> in fact these cpus are "performance-dependent" each other (e.g. are in the same
> > >>>>> clock domain).
> > >>>>
> > >>>> If the CPUs are in the same clock domain, they must be part of the
> > >>>> same cpufreq policy.
> > >>>
> > >>> But cpufreq does not currently support HW_ALL (I'm using the ACPI
> > >>> coordination type to describe the generic scenario of using hardware
> > >>> aggregation and coordination when establishing the clock rate of CPUs).
> > >>>
> > >>> Adding support for HW_ALL* will involve either bypassing some
> > >>> assumptions around cpufreq policies or making core cpufreq changes.
> > >>>
> > >>> In the way I see it, support for HW_ALL involves either:
> > >>>
> > >>>  - (a) Creating per-cpu policies in order to allow each of the CPUs to
> > >>>    send their own frequency request to the hardware which will do
> > >>>    aggregation and clock rate decision at the level of the clock
> > >>>    domain. The PSD domains (ACPI) and the new DT binding will tell
> > >>>    which CPUs are actually in the same clock domain for whomever is
> > >>>    interested, despite those CPUs not being in the same policy.
> > >>>    This requires the extra mask that Nicola introduced.
> > >>>
> > >>>  - (b) Making deep changes to cpufreq (core/governors/drivers) to allow:
> > >>>    - Governors to stop aggregating (usually max) the information
> > >>>      for each of the CPUs in the policy and convey to the core
> > >>>      information for each CPU.
> > >>>    - Cpufreq core to be able to receive and pass this information
> > >>>      down to the drivers.
> > >>>    - Drivers to be able to have some per cpu structures to hold
> > >>>      frequency control (let's say SCP fast channel addresses) for
> > >>>      each of the CPUs in the policy. Or have these structures in the
> > >>>      cpufreq core/policy, to avoid code duplication in drivers.
> > >>>
> > >>> Therefore (a) is the least invasive but we'll be bypassing the rule
> > >>> above. But to make that rule stick we'll have to make invasive cpufreq
> > >>> changes (b).
> > >>
> > >> Regarding the 'rule' above of one cpufreq policy per clock domain, I would like
> > >> to share my understanding on it. Perhaps it's a good opportunity to shed some light.
> > >>
> > >> Looking back in the history of CPUFreq, related_cpus was originally designed
> > >> to hold the map of cpus within the same clock. Later on, the meaning of this
> > >> cpumask changed [1].
> > >> This led to the introduction of a new cpumask 'freqdomain_cpus'
> > >> within acpi-cpufreq to keep the knowledge of hardware clock domains for
> > >> sysfs consumers since related_cpus was not suitable anymore for this.
> > >> Further on, this cpumask was assigned to online+offline cpus within the same clk
> > >> domain when sw coordination is in use [2].
> > >>
> > >> My interpretation is that there is no guarantee that related_cpus holds the
> > >> 'real' hardware clock implementation. As a consequence, it is not true anymore
> > >> that cpus that are in the same clock domain will be part of the same
> > >> policy.
> > >>
> > >> This guided me to think it would be better to have a cpumask which always holds
> > >> the real hw clock domains in the policy.
> > >>
> > >>>
> > >>> This is my current understanding and I'm leaning towards (a). What do
> > >>> you think?
> > >>>
> > >>> *in not so many words, this is what these patches are trying to propose,
> > >>> while also making sure it's supported for both ACPI and DT.
> > >>>
> > >>> BTW, thank you for your effort in making sense of this!
> > >>>
> > >>> Regards,
> > >>> Ionela.
> > >>>
> > >>
> > >> This could be a platform where per-cpu and perf-dependencies will be used:
> > >>
> > >> CPU:              0    1    2    3    4    5    6    7
> > >> Type:             A    A    A    A    B    B    B    B
> > >> Cluster:         [                                    ]
> > >> perf-controls:   [  ] [  ] [  ] [ ]  [ ]  [ ]  [ ]  [ ]
> > >> perf-dependency: [                ]  [                ]
> > >> HW clock:        [                ]  [                ]
> > >>
> > >> The firmware will present 8 controls to the OS and each control is mapped to a
> > >> cpu device via the standard dt. This is done so we can achieve hw coordination.
> > >> What is required in these systems is to present to OS the information of which
> > >> cpus belong to which clock domain. In other words, when hw coordinates we don't
> > >> have any way at present in dt to understand how these cpus are dependent
> > >> each other, from performance perspective (as opposed to ACPI where we have
> > >> _PSD). Hence my proposal for the new cpu-perf-dependencies.
> > >> This is regardless whether we decide to go for either a policy per-cpu or a
> > >> policy per-domain.
> > >>
> > >> Hope it helps.
> > >
> > > Oh yes, I get it now. Finally. Thanks for helping me out :)
> > >
> > > So if I can say all this stuff in simple terms, this is what it will
> > > be like:
> > >
> > > - We don't want software aggregation of frequencies and so we need to
> > >   have per-cpu policies even when they share their clock lines.
> > >
> > > - But we still need a way for other frameworks to know which CPUs
> > >   share the clock lines (that's what the perf-dependency is all about,
> > >   right ?).
> > >
> > > - We can't get it from SCMI, but need a DT based solution.
> > >
> > > - Currently for the cpufreq-case we relied for this on the way OPP
> > >   tables for the CPUs were described. i.e. the opp-table is marked as
> > >   "shared" and multiple CPUs point to it.
> > >
> > > - I wonder if we can keep using that instead of creating new bindings
> > >   for exact same stuff ? Though the difference here would be that the
> > >   OPP may not have any other entries.
> >
> > I thought about it and looked for other platforms' DT to see if can reuse
> > existing opp information. Unfortunately I don't think it is optimal. The reason
> > being that, because cpus have the same opp table it does not necessarily mean
> > that they share a clock wire. It just tells us that they have the same
> > capabilities (literally just tells us they have the same V/f op points).
> > Unless I am missing something?
> >
> > When comparing with ACPI/_PSD it becomes more intuitive that there is no
> > equivalent way to reveal "perf-dependencies" in DT.
>
> You should be able to by examining the clock tree. But perhaps SCMI
> abstracts all that and just presents virtual clocks without parent
> clocks available to determine what clocks are shared? Fix SCMI if that's
> the case.

We tried, but it goes against the abstraction according to SCMI spec authors
which is hard to argue against. The authors think the whole EAS thing is
OSPM specific and since ACPI has a way to express this even when CPPC
entries are per CPU and _PSD provides the shared clock domain info, they
prefer this to be outside the scope of SCMI and use DT for this. I don't
totally agree with that but I don't have strong case to argue here.

--
Regards,
Sudeep
