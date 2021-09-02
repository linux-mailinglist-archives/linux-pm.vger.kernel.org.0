Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0853FEEF9
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 15:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345358AbhIBNui (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Sep 2021 09:50:38 -0400
Received: from foss.arm.com ([217.140.110.172]:50052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345342AbhIBNuf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Sep 2021 09:50:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B02041FB;
        Thu,  2 Sep 2021 06:49:36 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 440523F5A1;
        Thu,  2 Sep 2021 06:49:35 -0700 (PDT)
Date:   Thu, 2 Sep 2021 14:49:27 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v6 6/7] cpufreq: Skip inefficient frequencies
Message-ID: <20210902134927.GA147718@e120877-lin.cambridge.arm.com>
References: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
 <1630405453-275784-7-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0i5KRkUKvqGbqoxhaNh626bmg3C2F-rZmcqaaqReQF7SQ@mail.gmail.com>
 <20210902105037.GA136543@e120877-lin.cambridge.arm.com>
 <CAJZ5v0iRJuyup2M16snP+BdJSKToSQ4QiFnrCoZn1j2KYhLEGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iRJuyup2M16snP+BdJSKToSQ4QiFnrCoZn1j2KYhLEGA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[...]

> > > >
> > > > +static inline unsigned int
> > > > +cpufreq_frequency_find_efficient(struct cpufreq_policy *policy,
> > > > +                                unsigned int idx)
> > > > +{
> > > > +       struct cpufreq_frequency_table *table = policy->freq_table;
> > > > +       unsigned int efficient_idx = table[idx].efficient;
> > > > +
> > > > +       return table[efficient_idx].frequency <= policy->max ? efficient_idx :
> > > > +               idx;
> > >
> > > I'm not sure about this.
> > >
> > > In the _RELATION_L case table[idx].frequency can be above the policy
> > > max, so you may end up running at an inefficient frequency above the
> > > policy max, but you won't use an efficient one above it.  Isn't this
> > > slightly confusing?
> >
> > This can indeed happen when policy->max isn't equal to an available frequency.
> > But nontheless, we can't let the efficient resolution violate the policy->max,
> > which is used for thermal capping. The fact that we can overshoot a max
> > limit is confusing as well.
> >
> > So I could add a policy->max sanity, to make sure this value is an actual
> > frequency and that RELATION_L will never overshoot that value. Or we can have a
> > flag somewhere to indicate thermal capping is happening and we shouldn't skip
> > inefficient frequencies.
> 
> I would prefer the first option, because user space may be applying
> the limit for power capping or thermal reasons too and the kernel
> can't really tell why it is doing that.
> 
> This needs to be added to cpufreq_set_policy(), I think after calling
> the driver's ->verify().
> 
> And if this is done to the policy max, IMO it needs to be done to the
> policy min too, for consistency.  So if a frequency table is used, the
> policy max and the policy min could be only the frequencies present in
> the table.

Ack. I'll consolidate policy->max and ->min set behavior in v7 so we won't have
any problem having to know who set policy->max and if yes or no we can break it.

What relation do we want for min/max setting? I guess RELATION_H for policy->max
and RELATION_L for policy->min (i.e. The highest frequency existing right below
the maximum and the lowest frequency existing just above the minimum)

> 
> Moreover, if only efficient frequencies are to be used, RELATION_L
> needs to return min(policy->max, the closest efficient frequency equal
> to or above the target).

You mean, never returning an inefficient frequency, unless there are no
efficient ones in the range policy->min policy->max ? 

The problem is a frequency is inefficient compared to a higher one. If we have
F, inefficient, while F+1 and F-1 are efficient and policy->max restricting to F.
If we return F-1, because it is the highest _efficient_ frequency allowed, we'll
give a frequency that can do less than originally requested. It would downgrade
the performance, compared to what the platform is really allowed to.

> 
> > >
> > > > +}
> > > > +
> > > >  static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
> > > >                                                  unsigned int target_freq,
> > > >                                                  unsigned int relation)
> > > >  {
> > > > +       int idx;
> > > > +
> > > >         if (unlikely(policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED))
> > > >                 return cpufreq_table_index_unsorted(policy, target_freq,
> > > >                                                     relation);
> > >
> > > Don't you want to take this case into account?
> >
> > As the inefficient frequencies are only configured by the EM so far, and this
> > latter needs sorted frequencies to work, I didn't add support for unsorted
> > table.
> 
> So the assumption is that if inefficient OPPs are present in the
> frequency table, it must be sorted.
> 
> It would be prudent to add a comment documenting this assumption, then.

Ack. I'll add that to the documentation.

> 
> > >
> > > >
> > > >         switch (relation) {
> > > >         case CPUFREQ_RELATION_L:
> > > > -               return cpufreq_table_find_index_l(policy, target_freq);
> > > > +               idx = cpufreq_table_find_index_l(policy, target_freq);
> > > > +               break;
> > > >         case CPUFREQ_RELATION_H:
> > > > -               return cpufreq_table_find_index_h(policy, target_freq);
> > > > +               idx = cpufreq_table_find_index_h(policy, target_freq);
> > > > +               break;
> > > >         case CPUFREQ_RELATION_C:
> > > > -               return cpufreq_table_find_index_c(policy, target_freq);
> > > > +               idx = cpufreq_table_find_index_c(policy, target_freq);
> > > > +               break;
> > > >         default:
> > > >                 WARN_ON_ONCE(1);
> > > >                 return 0;
> > > >         }
> > > > +
> > > > +       if (policy->skip_inefficiencies)
> > > > +               idx = cpufreq_frequency_find_efficient(policy, idx);
> > >
> > > Here, it matters which _RELATION_ is used.  For instance, in the
> > > RELATION_H case, the frequency used cannot be above the target, which
> > > is not guaranteed now AFAICS.
> >
> > RELATION_H is used in ondemand, when powersave_bias_target is set. In that
> > case, it doesn't seem to be an issue to overshoot the target freq in that case.
> 
> It actually is used in multiple places, including the performance
> governor, so changing the behavior of it is generally risky.
> 
> > >
> > > I would just really skip the inefficient frequencies as though they
> > > were not there in the table, and then refine the search to take the
> > > inefficient ones into account when the policy max limit is in effect
> > > (which also depends on the relation type AFAICS).
> > >
> > > In addition to the above, please note that __cpufreq_driver_target()
> > > is not only called by governors and at least in the suspend frequency
> > > case I don't see why it should be an efficient one even if
> > > skip_inefficiencies is set.
> >
> > Then we need to separate the __cpufreq_driver_target() issued from DVFS
> > governors and the others.
> 
> I think so.
> 
> > I can bring back the previous RELATION_E
> > and even have RELATION_LE and RELATION_HE to not leave behind
> > ondemands's powerbias?
> 
> Or a flag to be ORed with the relation to indicate that the request
> doesn't come from a DVFS governor (which basically boils down to the
> same thing).

Ok. A flag is probably better, so we don't need to redefine each relation with
an "efficient" version.

