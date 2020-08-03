Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F9F23A7F8
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 15:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHCN6l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 09:58:41 -0400
Received: from foss.arm.com ([217.140.110.172]:57992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgHCN6l (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Aug 2020 09:58:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42E3230E;
        Mon,  3 Aug 2020 06:58:40 -0700 (PDT)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9FDC3F718;
        Mon,  3 Aug 2020 06:58:39 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:58:38 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] cpufreq: set invariance scale factor on
 transition end
Message-ID: <20200803135838.GB9512@arm.com>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-3-ionela.voinescu@arm.com>
 <20200730041334.cjg5mc5xpopd2lst@vireshk-mac-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730041334.cjg5mc5xpopd2lst@vireshk-mac-ubuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Thursday 30 Jul 2020 at 09:43:34 (+0530), Viresh Kumar wrote:
> On 22-07-20, 10:37, Ionela Voinescu wrote:
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
> 
> I don't think this is deprecated.

Sorry, possibly 'deprecated' is a strong word.

As far as I knew acpi_cpufreq was recommended more recently for K8/K10
CPUs so that's why I decided not to create a special case for it, also
considering that it was not supporting cpufreq-based frequency
invariance to begin with.

We could support this as well by having a call to arch_set_freq_scale()
on the else path in __target_index(). But given that there was only this
one user of CPUFREQ_ASYNC_NOTIFICATION, I thought I'd propose this simpler
version first.

Let me know if my reasoning is wrong.

Thank you,
Ionela.

> 
> -- 
> viresh
