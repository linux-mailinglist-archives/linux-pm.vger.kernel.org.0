Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630E53BA452
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 21:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhGBTTk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Jul 2021 15:19:40 -0400
Received: from foss.arm.com ([217.140.110.172]:53196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhGBTTi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Jul 2021 15:19:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40E561FB;
        Fri,  2 Jul 2021 12:17:06 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1EF33F718;
        Fri,  2 Jul 2021 12:17:04 -0700 (PDT)
Date:   Fri, 2 Jul 2021 20:17:00 +0100
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
Message-ID: <20210702191658.GA30379@e120877-lin.cambridge.arm.com>
References: <a4971ab0-87d7-4457-49ec-ce20106be358@arm.com>
 <20210616093127.lfpi4rje56b3dhwx@vireshk-i7>
 <ff9a9daa-7d25-ea08-2cd9-fc56f778acde@arm.com>
 <20210616105327.wnppsau4gg5ihrlv@vireshk-i7>
 <4d975236-943c-ea82-547b-04f2bead9f48@arm.com>
 <0a930559-a648-c20d-f3f6-09e4974a031d@arm.com>
 <CAJZ5v0iMHeAOpDStN_qZLbM7-My4rQuAC9nEcT3sHCC33bH3NA@mail.gmail.com>
 <CAJZ5v0hOXHtoN3Z+Mw9Ym_HaY0OxessNAKTEpp6GM5_pnLJauw@mail.gmail.com>
 <a660b9ec-3ee7-28b2-569c-5a8d1510d927@arm.com>
 <CAJZ5v0iQve59SxD0TJ19wonj=WO7qVSApM-xPf_FYUf42Z3d5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iQve59SxD0TJ19wonj=WO7qVSApM-xPf_FYUf42Z3d5Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[...]

> > >
> > > I'm guessing that the problem is that cpufreq_cooling works by using
> > > freq_qos_update_request() to update the max frequency limit and if
> > > that is in effect you'd rather use the inefficient frequencies,
> > > whereas when the governor selects an inefficient frequency  below the
> > > policy limit, you'd rather use a higher-but-efficient frequency
> > > instead (within the policy limit).
> > >
> > > Am I guessing correctly?
> > >
> >
> > Yes, correct. Thermal would use all (efficient + inefficient), but
> > we in cpufreq governor would like to pick if possible the efficient
> > one (below the thermal limit).
> 
> To address that, you need to pass more information from schedutil to
> __cpufreq_driver_target() that down the road can be used by
> cpufreq_frequency_table_target() to decide whether or not to skip the
> inefficient frequencies.
> 
> For example, you can define CPUFREQ_RELATION_EFFICIENT and pass it
> from schedutil to __cpufreq_driver_target() in the "relation"
> argument, and clear it if the target frequency is above the max policy
> limit, or if ->target() is to be called.

What about a cpufreq_policy option that if sets would make
cpufreq_frequency_table_target() skip inefficient OPPs while staying within
the limit of max policy? Each governor could decide to set it or not, but
it would hide the efficiency resolution to the governor and allow drivers
that implements ->target() to also implements support for inefficient OPPs.

That flag could be set according to a new cpufreq_governor flag
CPUFREQ_GOV_SKIP_INEFFICIENCIES?

That could though modify behaviors like powersave_bias from ondemand. But if
a frequency is inefficient, there's probably no power saving anyway.

-- 
Vincent
