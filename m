Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8621A23A833
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 16:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgHCOQh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 10:16:37 -0400
Received: from foss.arm.com ([217.140.110.172]:58208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgHCOQh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Aug 2020 10:16:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 621C130E;
        Mon,  3 Aug 2020 07:16:36 -0700 (PDT)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5F933F718;
        Mon,  3 Aug 2020 07:16:35 -0700 (PDT)
Date:   Mon, 3 Aug 2020 15:16:34 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v2 1/7] cpufreq: move invariance setter calls in cpufreq
 core
Message-ID: <20200803141634.GA30107@arm.com>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-2-ionela.voinescu@arm.com>
 <CAJZ5v0i5Xrk6oTt81aeXDi1F8gnEspJo9e6nGf10nSvBz-Dbkw@mail.gmail.com>
 <20200730034128.k4fmblfuwjcmqdze@vireshk-mac-ubuntu>
 <20200803132617.GA9512@arm.com>
 <CAJZ5v0gOJXtpF4iy2v+Jbv9y9QZsAtEREMQwWv0u7Zks0Fvp1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gOJXtpF4iy2v+Jbv9y9QZsAtEREMQwWv0u7Zks0Fvp1A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Monday 03 Aug 2020 at 15:46:59 (+0200), Rafael J. Wysocki wrote:
> On Mon, Aug 3, 2020 at 3:26 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> >
> > Hi guys,
> >
> > On Thursday 30 Jul 2020 at 09:11:28 (+0530), Viresh Kumar wrote:
> > > On 27-07-20, 15:48, Rafael J. Wysocki wrote:
> > > > On Wed, Jul 22, 2020 at 11:38 AM Ionela Voinescu
> > > > <ionela.voinescu@arm.com> wrote:
> > > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > > index 036f4cc42ede..bac4101546db 100644
> > > > > --- a/drivers/cpufreq/cpufreq.c
> > > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > > @@ -2058,9 +2058,16 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
> > > > >  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> > > > >                                         unsigned int target_freq)
> > > > >  {
> > > > > +       unsigned int freq;
> > > > > +
> > > > >         target_freq = clamp_val(target_freq, policy->min, policy->max);
> > > > > +       freq = cpufreq_driver->fast_switch(policy, target_freq);
> > > > > +
> > > > > +       if (freq)
> > > > > +               arch_set_freq_scale(policy->related_cpus, freq,
> > > > > +                                   policy->cpuinfo.max_freq);
> > > >
> > > > Why can't arch_set_freq_scale() handle freq == 0?
> > >
> >
> > Sorry, I seem to have missed this question the first time around.
> >
> > arch_set_freq_scale() could handle freq == 0, but given that freq == 0
> > is signaling an error here, I do believe this check is well placed, to
> > prevent a useless call to arch_set_freq_scale(). Also [1]:
> 
> So let me rephrase:
> 
> Doesn't this check add overhead in the empty arch_set_freq_scale() case?

Yes, you are right, I did not consider that. I can add a patch for the
arch_topology driver's arch_set_freq_scale() to handle this and we can
remove it from here.

Thank you for pointing this out,
Ionela.
