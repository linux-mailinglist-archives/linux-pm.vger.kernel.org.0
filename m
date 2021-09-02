Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D613FEE6B
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 15:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbhIBNKM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Sep 2021 09:10:12 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:37526 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344895AbhIBNKM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 09:10:12 -0400
Received: by mail-ot1-f44.google.com with SMTP id i3-20020a056830210300b0051af5666070so2399145otc.4
        for <linux-pm@vger.kernel.org>; Thu, 02 Sep 2021 06:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCmjp9j+At+nDMLsJJz3dHztYr++RH2IVVIXX01S0Ck=;
        b=p8+6Pi+kvGCVsANy+HA+qaJh9BRNVecah3KmEacg8OKKk8VHEpPuq+usCaCBsF3kRq
         ySmdkHljLSzG4UuKnRU+hgtjWi8sb88qFjwRnqxX8BfcszMSX7JZtbMu8CtqNGhDR+0x
         BlYCTo78Gb71sVm+o1BXwyNdIvwcOCIXr3Frq0/VWQi8D8r2OCu+/YJ9k4ss9YJ8kHfu
         QHE8dRDDjs0m7lOfTb7a2kGMBELrktrO1MOB66lzVQvCaVepSoAUH/4kHWnHJannoBbd
         20PusGRmdWKfZxc9WgGPB/U9d5dHnI/zDmLJOj7xEeO8Z/IUS7PzntIasm9IfxrK99y8
         BrRQ==
X-Gm-Message-State: AOAM531mHvLJ0A8se7SOq8SSJmWlfSyqWk57fQ7bKwT1RNq4KD/IKqz+
        23BC6X4kG4O99QmOcGIZK8cMg88BFkb39NYRU7s=
X-Google-Smtp-Source: ABdhPJzf5c2Joj0OBt6EiqAZ+tu4U7gLrJTK2JnfAHx1ttM2UHud1kCxOCp1V6iMXCC/QivWQQm1V+AlxbqByfS9vDU=
X-Received: by 2002:a9d:7396:: with SMTP id j22mr2638473otk.206.1630588153549;
 Thu, 02 Sep 2021 06:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
 <1630405453-275784-7-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0i5KRkUKvqGbqoxhaNh626bmg3C2F-rZmcqaaqReQF7SQ@mail.gmail.com> <20210902105037.GA136543@e120877-lin.cambridge.arm.com>
In-Reply-To: <20210902105037.GA136543@e120877-lin.cambridge.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Sep 2021 15:09:02 +0200
Message-ID: <CAJZ5v0iRJuyup2M16snP+BdJSKToSQ4QiFnrCoZn1j2KYhLEGA@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] cpufreq: Skip inefficient frequencies
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 2, 2021 at 12:50 PM Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> On Wed, Sep 01, 2021 at 08:13:24PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Aug 31, 2021 at 12:24 PM Vincent Donnefort
> > <vincent.donnefort@arm.com> wrote:
> > >
> > > CPUFreq governors that do DVFS (i.e. CPUFREQ_GOV_DYNAMIC_SWITCHING flag)
> > > can skip frequencies marked as inefficient, as long as the efficient
> > > frequency found meet the policy maximum requirement.
> > >
> > > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 7d5f170ecad1..b46fe2d7baf1 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -2295,6 +2295,44 @@ __weak struct cpufreq_governor *cpufreq_fallback_governor(void)
> > >         return NULL;
> > >  }
> > >
> > > +static inline bool
> > > +cpufreq_can_skip_inefficiencies(struct cpufreq_policy *policy)
> >
> > This is not just about the ability to skp the inefficient frequencies,
> > but about whether or not they should be skipped.  Moreover, the
> > inefficient frequencies are not really skipped, but mapped to specific
> > efficient ones.
> >
> > I would call this function cpufreq_use_efficient_frequencies() or similar.
>
> Ack.
>
> >
> > > +{
> > > +       struct cpufreq_frequency_table *pos;
> > > +       bool valid = false;
> > > +       int idx;
> > > +
> > > +       if (!(policy->governor->flags & CPUFREQ_GOV_DYNAMIC_SWITCHING))
> > > +               return false;
> > > +
> > > +       if (policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED)
> > > +               return false;
> > > +
> > > +       /* Is there at least one inefficiency ? */
> > > +       cpufreq_for_each_valid_entry(pos, policy->freq_table) {
> > > +               if (pos->flags & CPUFREQ_INEFFICIENT_FREQ) {
> > > +                       valid = true;
> > > +                       break;
> > > +               }
> > > +       }
> > > +
> > > +       if (!valid)
> > > +               return false;
> > > +
> > > +       /*
> > > +        * Has cpufreq_table_update_efficiencies been called? i.e. is the
> > > +        * highest frequency efficient.
> > > +        */
> > > +       cpufreq_for_each_valid_entry_idx(pos, policy->freq_table, idx) {
> > > +               valid = !!(idx == pos->efficient);
> > > +               if (policy->freq_table_sorted ==
> > > +                                       CPUFREQ_TABLE_SORTED_DESCENDING)
> > > +                       break;
> > > +       }
> > > +
> > > +       return valid;
> > > +}
> > > +
> > >  static int cpufreq_init_governor(struct cpufreq_policy *policy)
> > >  {
> > >         int ret;
> > > @@ -2337,6 +2375,7 @@ static int cpufreq_init_governor(struct cpufreq_policy *policy)
> > >         }
> > >
> > >         policy->strict_target = !!(policy->governor->flags & CPUFREQ_GOV_STRICT_TARGET);
> > > +       policy->skip_inefficiencies = cpufreq_can_skip_inefficiencies(policy);
> > >
> > >         return 0;
> > >  }
> > > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > > index 4e901ebd104d..cb09afbf01e2 100644
> > > --- a/include/linux/cpufreq.h
> > > +++ b/include/linux/cpufreq.h
> > > @@ -117,6 +117,13 @@ struct cpufreq_policy {
> > >         bool                    strict_target;
> > >
> > >         /*
> > > +        * Set if the CPUFREQ_GOV_DYNAMIC_SWITCHING flag is set for the current
> > > +        * governor and if inefficient frequencies were found in the frequency
> > > +        * table.
> > > +        */
> > > +       bool                    skip_inefficiencies;
> > > +
> > > +       /*
> > >          * Preferred average time interval between consecutive invocations of
> > >          * the driver to set the frequency for this policy.  To be set by the
> > >          * scaling driver (0, which is the default, means no preference).
> > > @@ -972,25 +979,46 @@ static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
> > >                 return cpufreq_table_find_index_dc(policy, target_freq);
> > >  }
> > >
> > > +static inline unsigned int
> > > +cpufreq_frequency_find_efficient(struct cpufreq_policy *policy,
> > > +                                unsigned int idx)
> > > +{
> > > +       struct cpufreq_frequency_table *table = policy->freq_table;
> > > +       unsigned int efficient_idx = table[idx].efficient;
> > > +
> > > +       return table[efficient_idx].frequency <= policy->max ? efficient_idx :
> > > +               idx;
> >
> > I'm not sure about this.
> >
> > In the _RELATION_L case table[idx].frequency can be above the policy
> > max, so you may end up running at an inefficient frequency above the
> > policy max, but you won't use an efficient one above it.  Isn't this
> > slightly confusing?
>
> This can indeed happen when policy->max isn't equal to an available frequency.
> But nontheless, we can't let the efficient resolution violate the policy->max,
> which is used for thermal capping. The fact that we can overshoot a max
> limit is confusing as well.
>
> So I could add a policy->max sanity, to make sure this value is an actual
> frequency and that RELATION_L will never overshoot that value. Or we can have a
> flag somewhere to indicate thermal capping is happening and we shouldn't skip
> inefficient frequencies.

I would prefer the first option, because user space may be applying
the limit for power capping or thermal reasons too and the kernel
can't really tell why it is doing that.

This needs to be added to cpufreq_set_policy(), I think after calling
the driver's ->verify().

And if this is done to the policy max, IMO it needs to be done to the
policy min too, for consistency.  So if a frequency table is used, the
policy max and the policy min could be only the frequencies present in
the table.

Moreover, if only efficient frequencies are to be used, RELATION_L
needs to return min(policy->max, the closest efficient frequency equal
to or above the target).

> >
> > > +}
> > > +
> > >  static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
> > >                                                  unsigned int target_freq,
> > >                                                  unsigned int relation)
> > >  {
> > > +       int idx;
> > > +
> > >         if (unlikely(policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED))
> > >                 return cpufreq_table_index_unsorted(policy, target_freq,
> > >                                                     relation);
> >
> > Don't you want to take this case into account?
>
> As the inefficient frequencies are only configured by the EM so far, and this
> latter needs sorted frequencies to work, I didn't add support for unsorted
> table.

So the assumption is that if inefficient OPPs are present in the
frequency table, it must be sorted.

It would be prudent to add a comment documenting this assumption, then.

> >
> > >
> > >         switch (relation) {
> > >         case CPUFREQ_RELATION_L:
> > > -               return cpufreq_table_find_index_l(policy, target_freq);
> > > +               idx = cpufreq_table_find_index_l(policy, target_freq);
> > > +               break;
> > >         case CPUFREQ_RELATION_H:
> > > -               return cpufreq_table_find_index_h(policy, target_freq);
> > > +               idx = cpufreq_table_find_index_h(policy, target_freq);
> > > +               break;
> > >         case CPUFREQ_RELATION_C:
> > > -               return cpufreq_table_find_index_c(policy, target_freq);
> > > +               idx = cpufreq_table_find_index_c(policy, target_freq);
> > > +               break;
> > >         default:
> > >                 WARN_ON_ONCE(1);
> > >                 return 0;
> > >         }
> > > +
> > > +       if (policy->skip_inefficiencies)
> > > +               idx = cpufreq_frequency_find_efficient(policy, idx);
> >
> > Here, it matters which _RELATION_ is used.  For instance, in the
> > RELATION_H case, the frequency used cannot be above the target, which
> > is not guaranteed now AFAICS.
>
> RELATION_H is used in ondemand, when powersave_bias_target is set. In that
> case, it doesn't seem to be an issue to overshoot the target freq in that case.

It actually is used in multiple places, including the performance
governor, so changing the behavior of it is generally risky.

> >
> > I would just really skip the inefficient frequencies as though they
> > were not there in the table, and then refine the search to take the
> > inefficient ones into account when the policy max limit is in effect
> > (which also depends on the relation type AFAICS).
> >
> > In addition to the above, please note that __cpufreq_driver_target()
> > is not only called by governors and at least in the suspend frequency
> > case I don't see why it should be an efficient one even if
> > skip_inefficiencies is set.
>
> Then we need to separate the __cpufreq_driver_target() issued from DVFS
> governors and the others.

I think so.

> I can bring back the previous RELATION_E
> and even have RELATION_LE and RELATION_HE to not leave behind
> ondemands's powerbias?

Or a flag to be ORed with the relation to indicate that the request
doesn't come from a DVFS governor (which basically boils down to the
same thing).

> >
> > > +
> > > +       return idx;
> > >  }
> > >
> > >  static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy *policy)
> > > --
> > > 2.7.4
> > >
