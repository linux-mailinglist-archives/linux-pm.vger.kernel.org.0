Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538EF28B346
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 12:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387908AbgJLK7u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 06:59:50 -0400
Received: from foss.arm.com ([217.140.110.172]:37640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387594AbgJLK7s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Oct 2020 06:59:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F09F330E;
        Mon, 12 Oct 2020 03:59:46 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 924113F719;
        Mon, 12 Oct 2020 03:59:46 -0700 (PDT)
Date:   Mon, 12 Oct 2020 11:59:45 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Nicola Mazzucato <nicola.mazzucato@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        chris.redpath@arm.com, morten.rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201012105945.GA9219@arm.com>
References: <20200924095347.32148-3-nicola.mazzucato@arm.com>
 <20201006071909.3cgz7i5v35dgnuzn@vireshk-i7>
 <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
 <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7>
 <20201008150317.GB20268@arm.com>
 <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
 <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7>
 <42e3c8e9-cadc-d013-1e1f-fa06af4a45ff@arm.com>
 <20201009140141.GA4048593@bogus>
 <2b7b6486-2898-1279-ce9f-9e7bd3512152@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b7b6486-2898-1279-ce9f-9e7bd3512152@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday 12 Oct 2020 at 11:22:57 (+0100), Lukasz Luba wrote:
[..]
> > > I thought about it and looked for other platforms' DT to see if can reuse
> > > existing opp information. Unfortunately I don't think it is optimal. The reason
> > > being that, because cpus have the same opp table it does not necessarily mean
> > > that they share a clock wire. It just tells us that they have the same
> > > capabilities (literally just tells us they have the same V/f op points).
> > > Unless I am missing something?
> > > 
> > > When comparing with ACPI/_PSD it becomes more intuitive that there is no
> > > equivalent way to reveal "perf-dependencies" in DT.
> > 
> > You should be able to by examining the clock tree. But perhaps SCMI
> > abstracts all that and just presents virtual clocks without parent
> > clocks available to determine what clocks are shared? Fix SCMI if that's
> > the case.
> 
> True, the SCMI clock does not support discovery of clock tree:
> (from 4.6.1 Clock management protocol background)
> 'The protocol does not cover discovery of the clock tree, which must be
> described through firmware tables instead.' [1]
> 
> In this situation, would it make sense, instead of this binding from
> patch 1/2, create a binding for internal firmware/scmi node?
> 
> Something like:
> 
> firmware {
> 	scmi {
> 	...		
> 		scmi-perf-dep {
> 			compatible = "arm,scmi-perf-dependencies";
> 			cpu-perf-dep0 {
> 				cpu-perf-affinity = <&CPU0>, <&CPU1>;
> 			};
> 			cpu-perf-dep1 {
> 				cpu-perf-affinity = <&CPU3>, <&CPU4>;
> 			};
> 			cpu-perf-dep2 {
> 				cpu-perf-affinity = <&CPU7>;
> 			};
> 		};
> 	};
> };
> 
> The code which is going to parse the binding would be inside the
> scmi perf protocol code and used via API by scmi-cpufreq.c.
> 

While SCMI cpufreq would be able to benefit from the functionality that
Nicola is trying to introduce, it's not the only driver, and more
importantly, it's not *going* to be the only driver benefiting from
this.

Currently there is also qcom-cpufreq-hw.c and the future
mediatek-cpufreq-hw.c that is currently under review [1]. They both do
their frequency setting by interacting with HW/FW, and could either take
or update their OPP tables from there. Therefore, if the platform would
require it, they could also expose different controls for frequency
setting and could benefit from additional information about clock
domains (either through opp-shared or the new entries in Nicola's patch),
without driver changes.

Another point to be made is that I strongly believe this is going to be
the norm in the future. Directly setting PLLs and regulator voltages
has been proven unsafe and unsecure.

Therefore, I see this as support for a generic cpufreq feature (a
hardware coordination type), rather than support for a specific driver.

[1] https://lkml.org/lkml/2020/9/10/11

> 
> Now regarding the 'dependent_cpus' mask.
> 
> We could avoid adding a new field 'dependent_cpus' in policy
> struct, but I am not sure of one bit - Frequency Invariant Engine,
> (which is also not fixed by just adding a new cpumask).
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Let's take it step by step..
> 
> We have 3 subsystems to fix:
> 1. EAS - EM has API function which takes custom cpumask, so no issue,
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	   keep in mind that EAS it's using the max aggregation method
	   that schedutil is using. So if we are to describe the
	   functionality correctly, it needs both a cpumask describing
	   the frequency domains and an aggregation method.

>   fix would be to use it via the scmi-cpufreq.c

> 2. IPA (for calculating the power of a cluster, not whole thermal needs
>   this knowledge about 'dependent cpus') - this can be fixed internally

> 3. Frequency Invariant Engine (FIE) - currently it relies on schedutil
>   filtering and providing max freq of all cpus in the cluster into the
>   FIE; this info is then populated to all 'related_cpus' which will
>   have this freq (we know, because there is no other freq requests);
>   Issues:
> 3.1. Schedutil is not going to check all cpus in the cluster to take
>   max freq, which is then passed into the cpufreq driver and FIE
> 3.2. FIE would have to (or maybe we would drop it) have a logic similar
>   to what schedutil does (max freq search and set, then filter next
>   freq requests from other cpus in the next period e.g. 10ms)
> 3.3. Schedutil is going to invoke freq change for each cpu independently
>   and the current code just calls arch_set_freq_scale() - adding just
>   'dependent_cpus' won't help

I don't believe these are issues. As we need changes for EAS and IPA, we'd
need changes for FIE. We don't need more than the cpumask that shows
frequency domains as we already already have the aggregation method that
schedutil uses to propagate the max frequency in a domain across CPUs.

This would be the default method if cycle counters are not present. It
might not reflect the frequency the cores actually get from HW, but for
that cycle counters should be used.

> 3.4 What would be the real frequency of these cpus and what would be
>   set to FIE
> 3.5 FIE is going to filter to soon requests from other dependent cpus?
> 
> IMHO the FIE needs more bits than just a new cpumask.
> Maybe we should consider to move FIE arch_set_freq_scale() call into the
> cpufreq driver, which will know better how to aggregate/filter requests
> and then call FIE update?

I'm quite strongly against this :). As described before, this is not a
feature that a single driver needs, and even if it was, the aggregation
method for FIE is not a driver policy.

Thanks,
Ionela.

> 
> Regards,
> Lukasz
> 
> [1] https://developer.arm.com/documentation/den0056/b/
> > 
> > Rob
> > 
