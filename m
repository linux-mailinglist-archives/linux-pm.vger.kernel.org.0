Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCD7231BDE
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 11:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgG2JOS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 05:14:18 -0400
Received: from foss.arm.com ([217.140.110.172]:48378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2JOS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 05:14:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98600101E;
        Wed, 29 Jul 2020 02:14:17 -0700 (PDT)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A2E43F718;
        Wed, 29 Jul 2020 02:14:17 -0700 (PDT)
Date:   Wed, 29 Jul 2020 10:14:15 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] cpufreq: set invariance scale factor on
 transition end
Message-ID: <20200729091405.GB12941@arm.com>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-3-ionela.voinescu@arm.com>
 <CAJZ5v0iiF75+POMF5oX8_NOBiLLqMQSYTTf-X0QoLAPV7fF0-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iiF75+POMF5oX8_NOBiLLqMQSYTTf-X0QoLAPV7fF0-g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday 27 Jul 2020 at 15:52:41 (+0200), Rafael J. Wysocki wrote:
> On Wed, Jul 22, 2020 at 11:38 AM Ionela Voinescu
> <ionela.voinescu@arm.com> wrote:
> >
> > While the move of the invariance setter calls (arch_set_freq_scale())
> > from cpufreq drivers to cpufreq core maintained the previous
> > functionality for existing drivers that use target_index() and
> > fast_switch() for frequency switching, it also gives the possibility
> > of adding support for users of the target() callback, which is exploited
> > here.
> >
> > To be noted that the target() callback has been flagged as deprecated
> > since:
> >
> > commit 9c0ebcf78fde ("cpufreq: Implement light weight ->target_index() routine")
> >
> > It also doesn't have that many users:
> >
> >   cpufreq-nforce2.c:371:2:      .target = nforce2_target,
> >   cppc_cpufreq.c:416:2:         .target = cppc_cpufreq_set_target,
> >   gx-suspmod.c:439:2:           .target = cpufreq_gx_target,
> >   pcc-cpufreq.c:573:2:          .target = pcc_cpufreq_target,
> >
> > Similarly to the path taken for target_index() calls in the cpufreq core
> > during a frequency change, all of the drivers above will mark the end of a
> > frequency change by a call to cpufreq_freq_transition_end().
> >
> > Therefore, cpufreq_freq_transition_end() can be used as the location for
> > the arch_set_freq_scale() call to potentially inform the scheduler of the
> > frequency change.
> >
> > This change maintains the previous functionality for the drivers that
> > implement the target_index() callback, while also adding support for the
> > few drivers that implement the deprecated target() callback.
> >
> > Two notes are worthwhile here:
> >  - In __target_index(), cpufreq_freq_transition_end() is called only for
> >    drivers that have synchronous notifications enabled. There is only one
> >    driver that disables them,
> >
> >    drivers/cpufreq/powernow-k8.c:1142: .flags = CPUFREQ_ASYNC_NOTIFICATION,
> >
> >    which is deprecated.
> >
> >  - Despite marking a successful frequency change, many cpufreq drivers
> >    will populate the new policy->cur with the new requested frequency,
> >    although this might not be the one granted by the hardware.
> >
> >    Therefore, the call to arch_set_freq_scale() is a "best effort" one,
> >    and it is up to the architecture if the new frequency is used in the
> >    new frequency scale factor setting or eventually used by the scheduler.
> >    The architecture is in a better position to decide if it has better
> >    methods to obtain more accurate information regarding the current
> >    frequency (for example the use of counters).
> >
[..]

> I would fold this patch into the previous one.
> 
> I don't see much reason for it to be separate and it looks like
> folding it in would cause the previous patch to be simpler.

I kept it separate in this version as a proposal to move the call to
cpufreq_freq_transition_end() and properly justify it in the commit
message.

I'll squash it into the previous one, as recommended.

Thanks,
Ionela.
