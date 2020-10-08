Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764392876A6
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 17:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbgJHPDW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 11:03:22 -0400
Received: from foss.arm.com ([217.140.110.172]:33758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730697AbgJHPDU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 11:03:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9483E1063;
        Thu,  8 Oct 2020 08:03:19 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35BAC3F70D;
        Thu,  8 Oct 2020 08:03:19 -0700 (PDT)
Date:   Thu, 8 Oct 2020 16:03:17 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        sudeep.holla@arm.com, chris.redpath@arm.com,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201008150317.GB20268@arm.com>
References: <20200924095347.32148-1-nicola.mazzucato@arm.com>
 <20200924095347.32148-3-nicola.mazzucato@arm.com>
 <20201006071909.3cgz7i5v35dgnuzn@vireshk-i7>
 <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
 <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Thursday 08 Oct 2020 at 16:32:41 (+0530), Viresh Kumar wrote:
> On 07-10-20, 13:58, Nicola Mazzucato wrote:
> > Hi Viresh,
> > 
> > performance controls is what is exposed by the firmware through a protocol that
> > is not capable of describing hardware (say SCMI). For example, the firmware can
> > tell that the platform has N controls, but it can't say to which hardware they
> > are "wired" to. This is done in dt, where, for example, we map these controls
> > to cpus, gpus, etc.
> > 
> > Let's focus on cpus.
> > 
> > Normally we would have N of performance controls (what comes from f/w)
> > that that correspond to hardware clock/dvfs domains.
> > 
> > However, some firmware implementations might benefit from having finer
> > grained information about the performance requirements (e.g.
> > per-CPU) and therefore choose to present M performance controls to the
> > OS. DT would be adjusted accordingly to "wire" these controls to cpus
> > or set of cpus.
> > In this scenario, the f/w will make aggregation decisions based on the
> > requests it receives on these M controls.
> > 
> > Here we would have M cpufreq policies which do not necessarily reflect the
> > underlying clock domains, thus some s/w components will underperform
> > (EAS and thermal, for example).
> > 
> > A real example would be a platform in which the firmware describes the system
> > having M per-cpu control, and the cpufreq subsystem will have M policies while
> > in fact these cpus are "performance-dependent" each other (e.g. are in the same
> > clock domain).
> 
> If the CPUs are in the same clock domain, they must be part of the
> same cpufreq policy.

But cpufreq does not currently support HW_ALL (I'm using the ACPI
coordination type to describe the generic scenario of using hardware
aggregation and coordination when establishing the clock rate of CPUs).

Adding support for HW_ALL* will involve either bypassing some
assumptions around cpufreq policies or making core cpufreq changes.

In the way I see it, support for HW_ALL involves either:

 - (a) Creating per-cpu policies in order to allow each of the CPUs to
   send their own frequency request to the hardware which will do
   aggregation and clock rate decision at the level of the clock
   domain. The PSD domains (ACPI) and the new DT binding will tell
   which CPUs are actually in the same clock domain for whomever is
   interested, despite those CPUs not being in the same policy.
   This requires the extra mask that Nicola introduced.

 - (b) Making deep changes to cpufreq (core/governors/drivers) to allow:
   - Governors to stop aggregating (usually max) the information
     for each of the CPUs in the policy and convey to the core
     information for each CPU.
   - Cpufreq core to be able to receive and pass this information
     down to the drivers.
   - Drivers to be able to have some per cpu structures to hold
     frequency control (let's say SCP fast channel addresses) for
     each of the CPUs in the policy. Or have these structures in the
     cpufreq core/policy, to avoid code duplication in drivers.

Therefore (a) is the least invasive but we'll be bypassing the rule
above. But to make that rule stick we'll have to make invasive cpufreq
changes (b).

This is my current understanding and I'm leaning towards (a). What do
you think?

*in not so many words, this is what these patches are trying to propose,
while also making sure it's supported for both ACPI and DT.

BTW, thank you for your effort in making sense of this!

Regards,
Ionela.
