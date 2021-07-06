Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CAE3BC7AC
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhGFIPm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 04:15:42 -0400
Received: from foss.arm.com ([217.140.110.172]:34358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230257AbhGFIPl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Jul 2021 04:15:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3217E31B;
        Tue,  6 Jul 2021 01:13:03 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D05DC3F5A1;
        Tue,  6 Jul 2021 01:13:01 -0700 (PDT)
Date:   Tue, 6 Jul 2021 09:12:56 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <20210706081256.GA216826@e120877-lin.cambridge.arm.com>
References: <ff9a9daa-7d25-ea08-2cd9-fc56f778acde@arm.com>
 <20210616105327.wnppsau4gg5ihrlv@vireshk-i7>
 <4d975236-943c-ea82-547b-04f2bead9f48@arm.com>
 <0a930559-a648-c20d-f3f6-09e4974a031d@arm.com>
 <CAJZ5v0iMHeAOpDStN_qZLbM7-My4rQuAC9nEcT3sHCC33bH3NA@mail.gmail.com>
 <CAJZ5v0hOXHtoN3Z+Mw9Ym_HaY0OxessNAKTEpp6GM5_pnLJauw@mail.gmail.com>
 <a660b9ec-3ee7-28b2-569c-5a8d1510d927@arm.com>
 <CAJZ5v0iQve59SxD0TJ19wonj=WO7qVSApM-xPf_FYUf42Z3d5Q@mail.gmail.com>
 <20210702191658.GA30379@e120877-lin.cambridge.arm.com>
 <CAJZ5v0ijLepOyGX0Et1h3j6AbtFxV_-mq+2uNrv8syG0RPiJbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ijLepOyGX0Et1h3j6AbtFxV_-mq+2uNrv8syG0RPiJbg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[...]

> >
> > What about a cpufreq_policy option that if sets would make
> > cpufreq_frequency_table_target() skip inefficient OPPs while staying within
> > the limit of max policy?
> 
> That would work too, ->
> 
> > Each governor could decide to set it or not, but
> > it would hide the efficiency resolution to the governor and allow drivers
> > that implements ->target() to also implements support for inefficient OPPs.
> 
> -> but alternatively there could be an additional cpufreq driver flag
> to be set by the drivers implementing ->target() and wanting to deal
> with CPUFREQ_RELATION_EFFICIENT themselves (an opt-in of sorts).
> 
> So the governors that want it may pass CPUFREQ_RELATION_EFFICIENT to
> __cpufreq_driver_target() and then it will be passed to ->target()
> depending on whether or not the new driver flag is set.

Of course, I can implement this instead of a cpufreq_policy flag in v4.
I suppose then right fallback for CPUFREQ_RELATION_EFFICIENT in case the
driver doesn't opt-in is CPUFREQ_RELATION_L.

> 
> > That flag could be set according to a new cpufreq_governor flag
> > CPUFREQ_GOV_SKIP_INEFFICIENCIES?
> >
> > That could though modify behaviors like powersave_bias from ondemand. But if
> > a frequency is inefficient, there's probably no power saving anyway.
> 
> AFAICS, the userspace governor aside, using inefficient frequencies
> only works with the powersave governor.  In the other cases,
> RELATION_L (say) can be interpreted as "the closest efficient
> frequency equal to or above the target" with the max policy limit
> possibly causing inefficient frequencies to be used if they are closer
> to the limit than the next efficient one.
> 
> As a rule, the governors don't assume that there are any inefficient
> frequencies in the table.  In fact, they don't make any assumptions
> regarding the contents of the frequency table at all.  They don't even
> assume that the driver uses a frequency table in the first place.

So all the governors, beside powersave and userspace would replace their
RELATION_L with RELATION_EFFICIENT. I'll add the changes in v4.

So if I sum-up: new RELATION_EFFICIENT that resolves RELATION_L to an higher
efficient frequency (if necessary) within the limits of policy->max.
CPUfreq drivers can opt-in by setting an appropriate flag. If they do not,
RELATION_EFFICIENT will be rewritten in RELATION_L. All governors but userspace
and powersave would use RELATION_EFFICIENT instead of RELATION_L.

If that works for you, I'll implement this in a v4, as well as some
improvements for the CPUfreq/EM registration following the discussion with
Viresh.

-- 
Vincent
