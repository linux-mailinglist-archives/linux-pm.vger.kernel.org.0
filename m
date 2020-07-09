Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34CB219B83
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 10:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgGIIx5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 04:53:57 -0400
Received: from foss.arm.com ([217.140.110.172]:44016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgGIIx5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Jul 2020 04:53:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D48331B;
        Thu,  9 Jul 2020 01:53:56 -0700 (PDT)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 397383F887;
        Thu,  9 Jul 2020 01:53:56 -0700 (PDT)
Date:   Thu, 9 Jul 2020 09:53:54 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] cpufreq: allow drivers to flag custom support for
 freq invariance
Message-ID: <20200709085354.GA5623@arm.com>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-2-ionela.voinescu@arm.com>
 <20200701094417.ffuvduz6pqknjcks@vireshk-i7>
 <20200701133330.GA32736@arm.com>
 <CAJZ5v0gT+xWwxcx3OZjXBnDLr9i4VOt2Vp3ScWBxbu+NiopkbA@mail.gmail.com>
 <20200702025818.s4oh7rzz3tr6zwqr@vireshk-i7>
 <20200702114425.GB28120@arm.com>
 <389dd87f-fed0-e4ea-81f3-5491fd2a54d1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <389dd87f-fed0-e4ea-81f3-5491fd2a54d1@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi guys,

On Monday 06 Jul 2020 at 14:14:47 (+0200), Dietmar Eggemann wrote:
> On 02/07/2020 13:44, Ionela Voinescu wrote:
> > Hi,
> > 
> > On Thursday 02 Jul 2020 at 08:28:18 (+0530), Viresh Kumar wrote:
> >> On 01-07-20, 18:05, Rafael J. Wysocki wrote:
> >>> On Wed, Jul 1, 2020 at 3:33 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> >>>> On Wednesday 01 Jul 2020 at 16:16:17 (+0530), Viresh Kumar wrote:
> 
> [...]
> 
> >> There can be other reasons which we aren't able to imagine at this
> >> point of time.
> >>
> > 
> > But I understand both the points you and Rafael raised so it's obvious
> > that a 'opt in' flag would be the better option.
> 
> Why can't we just move the arch_set_freq_scale() call from cpufreq
> driver to cpufreq core w/o introducing a FIE related driver flag?
> 
> Current scenario for Frequency Invariance Engine (FIE) on arm/arm64.
> 
> +------------------------------+       +------------------------------+
> |                              |       |                              |
> | cpufreq core:                |       | arch: (arm, arm64)           |
> 
> |                              |       |                              |
> | weak arch_set_freq_scale() {}|       |                              |
> |                              |       |                              |
> +------------------------------+       |                              |
>                                        |                              |
> +------------------------------+       |                              |
> |                              |       |                              |
> | cpufreq driver:              |       |                              |
> |                            +-----------> arch_set_freq_scale()      |
> |                              |       |   {                          |
> +------------------------------+       |      if (use counters)       |
>                                        |        return;               |
> +------------------------------+       |      ...                     |
> |                              |       |   }                          |
> | task scheduler:              |       |                              |
> |                            +-----------> arch_scale_freq_tick()*    |
> |                              |       |   {                          |
> 
> |                              |       |      if (!use counters)      |
> |                              |       |        return;               |
> |                              |       |      ...                     |
> |                              |       |   }                          |
> +------------------------------+       +------------------------------+
> 
> * defined as topology_scale_freq_tick() in arm64
> 
> Only Arm/Arm64 defines arch_set_freq_scale() to get the 'legacy' CPUfreq
> based FIE. This would still be the case when we move
> arch_set_freq_scale() from individual cpufreq drivers to cpufreq core.
> 
> Arm64 is the only arch which has to runtime-choose between two different
> FIEs. This is currently done by bailing out early in one of the FIE
> functions based on 'use counters'.
> 
> X86 (and others) will continue to not define arch_set_freq_scale().
> 
> The issue with CONFIG_BL_SWITCHER (vexpress-spc-cpufreq.c) could be
> solved arm/arm64 internally (arch_topology.c) by putting
> arch_set_freq_scale() under a !CONFIG_BL_SWITCHER guard.
> I doubt that there are any arm bL systems out there running it. At least
> I'm not aware of any complaints due to missing FIE support in bl
> switcher setups so far.

Thank you Dietmar, for your review.

I was trying to suggest the same in my other replies. Given that BL_SWITCHER
can be removed as an argument for introducing a flag, I would also find it
cleaner to just skip on introducing a flag altogether, at least until we
have a driver/scenario in the kernel that will functionally benefit from it.
This would also give us the chance to reconsider the best meaning of the
flag we later introduce.

The introduction of the 'opt in' flag would be the next best thing as
suggested in the other replies, but currently it would not result in
anything functionally different.


Rafael, Viresh, would you mind confirming whether you still consider
having an 'opt in' flag is preferable here?

Many thanks,
Ionela.
