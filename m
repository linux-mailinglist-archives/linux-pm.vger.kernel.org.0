Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67253FE22E
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 20:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhIASOd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 14:14:33 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:38760 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344153AbhIASOd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 14:14:33 -0400
Received: by mail-oo1-f54.google.com with SMTP id m11-20020a056820034b00b0028bb60b551fso140750ooe.5
        for <linux-pm@vger.kernel.org>; Wed, 01 Sep 2021 11:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1v3MC9qGxjZStPclsDY7cKvcpEX2tItfXGLnlwdNQM=;
        b=TuVDEl/aWmPjqiQMUddEyFmisYA/nJiVpyIEyOP77xmTApM3uiSeZRBjEMyHtX7e13
         kpIorK8rWif4DTfN30MoxeQbcH2X87IM6ztjGY7frLpexyAq+YZ/+GHhb+5jQm1qXzf/
         rhQ8wmHYLC16SrVYY4Nb7QGKz4o/mXpkatVrCNpTTwUtLKKHPdecMVM7JIWhlzG8zdFY
         vacSvKtubY4QM0TnZNFHa3J4LSIcRLPmIExwtd4CIuwKafdHhvk0l447yzYrDUVUwIEf
         5pusXx7AlN74eV3HA7OJ9Pr/QR3MALduW+Fwz9UHv0NcruvPueY1PJ0PZirqIMUscdd9
         dPbQ==
X-Gm-Message-State: AOAM5336+ZIfClCCQmKVBGdWHjnjHfhW4ihc+37bUoyLIfh7bcDLHdKr
        bMxc64CIf8drmcsDDtQq6qcuk+/qTJMRJ5mmpPc=
X-Google-Smtp-Source: ABdhPJwbaO2ciRnl4knu0zR2EYvmZZ/aQOCQhepETb5e+nsvxTUT2Zg3GhL1n4aElUfMLTLceLeSxXUq5axaEtgxHR4=
X-Received: by 2002:a4a:dcd0:: with SMTP id h16mr560804oou.44.1630520015633;
 Wed, 01 Sep 2021 11:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com> <1630405453-275784-7-git-send-email-vincent.donnefort@arm.com>
In-Reply-To: <1630405453-275784-7-git-send-email-vincent.donnefort@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Sep 2021 20:13:24 +0200
Message-ID: <CAJZ5v0i5KRkUKvqGbqoxhaNh626bmg3C2F-rZmcqaaqReQF7SQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] cpufreq: Skip inefficient frequencies
To:     Vincent Donnefort <vincent.donnefort@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 31, 2021 at 12:24 PM Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> CPUFreq governors that do DVFS (i.e. CPUFREQ_GOV_DYNAMIC_SWITCHING flag)
> can skip frequencies marked as inefficient, as long as the efficient
> frequency found meet the policy maximum requirement.
>
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7d5f170ecad1..b46fe2d7baf1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2295,6 +2295,44 @@ __weak struct cpufreq_governor *cpufreq_fallback_governor(void)
>         return NULL;
>  }
>
> +static inline bool
> +cpufreq_can_skip_inefficiencies(struct cpufreq_policy *policy)

This is not just about the ability to skp the inefficient frequencies,
but about whether or not they should be skipped.  Moreover, the
inefficient frequencies are not really skipped, but mapped to specific
efficient ones.

I would call this function cpufreq_use_efficient_frequencies() or similar.

> +{
> +       struct cpufreq_frequency_table *pos;
> +       bool valid = false;
> +       int idx;
> +
> +       if (!(policy->governor->flags & CPUFREQ_GOV_DYNAMIC_SWITCHING))
> +               return false;
> +
> +       if (policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED)
> +               return false;
> +
> +       /* Is there at least one inefficiency ? */
> +       cpufreq_for_each_valid_entry(pos, policy->freq_table) {
> +               if (pos->flags & CPUFREQ_INEFFICIENT_FREQ) {
> +                       valid = true;
> +                       break;
> +               }
> +       }
> +
> +       if (!valid)
> +               return false;
> +
> +       /*
> +        * Has cpufreq_table_update_efficiencies been called? i.e. is the
> +        * highest frequency efficient.
> +        */
> +       cpufreq_for_each_valid_entry_idx(pos, policy->freq_table, idx) {
> +               valid = !!(idx == pos->efficient);
> +               if (policy->freq_table_sorted ==
> +                                       CPUFREQ_TABLE_SORTED_DESCENDING)
> +                       break;
> +       }
> +
> +       return valid;
> +}
> +
>  static int cpufreq_init_governor(struct cpufreq_policy *policy)
>  {
>         int ret;
> @@ -2337,6 +2375,7 @@ static int cpufreq_init_governor(struct cpufreq_policy *policy)
>         }
>
>         policy->strict_target = !!(policy->governor->flags & CPUFREQ_GOV_STRICT_TARGET);
> +       policy->skip_inefficiencies = cpufreq_can_skip_inefficiencies(policy);
>
>         return 0;
>  }
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 4e901ebd104d..cb09afbf01e2 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -117,6 +117,13 @@ struct cpufreq_policy {
>         bool                    strict_target;
>
>         /*
> +        * Set if the CPUFREQ_GOV_DYNAMIC_SWITCHING flag is set for the current
> +        * governor and if inefficient frequencies were found in the frequency
> +        * table.
> +        */
> +       bool                    skip_inefficiencies;
> +
> +       /*
>          * Preferred average time interval between consecutive invocations of
>          * the driver to set the frequency for this policy.  To be set by the
>          * scaling driver (0, which is the default, means no preference).
> @@ -972,25 +979,46 @@ static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
>                 return cpufreq_table_find_index_dc(policy, target_freq);
>  }
>
> +static inline unsigned int
> +cpufreq_frequency_find_efficient(struct cpufreq_policy *policy,
> +                                unsigned int idx)
> +{
> +       struct cpufreq_frequency_table *table = policy->freq_table;
> +       unsigned int efficient_idx = table[idx].efficient;
> +
> +       return table[efficient_idx].frequency <= policy->max ? efficient_idx :
> +               idx;

I'm not sure about this.

In the _RELATION_L case table[idx].frequency can be above the policy
max, so you may end up running at an inefficient frequency above the
policy max, but you won't use an efficient one above it.  Isn't this
slightly confusing?

> +}
> +
>  static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
>                                                  unsigned int target_freq,
>                                                  unsigned int relation)
>  {
> +       int idx;
> +
>         if (unlikely(policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED))
>                 return cpufreq_table_index_unsorted(policy, target_freq,
>                                                     relation);

Don't you want to take this case into account?

>
>         switch (relation) {
>         case CPUFREQ_RELATION_L:
> -               return cpufreq_table_find_index_l(policy, target_freq);
> +               idx = cpufreq_table_find_index_l(policy, target_freq);
> +               break;
>         case CPUFREQ_RELATION_H:
> -               return cpufreq_table_find_index_h(policy, target_freq);
> +               idx = cpufreq_table_find_index_h(policy, target_freq);
> +               break;
>         case CPUFREQ_RELATION_C:
> -               return cpufreq_table_find_index_c(policy, target_freq);
> +               idx = cpufreq_table_find_index_c(policy, target_freq);
> +               break;
>         default:
>                 WARN_ON_ONCE(1);
>                 return 0;
>         }
> +
> +       if (policy->skip_inefficiencies)
> +               idx = cpufreq_frequency_find_efficient(policy, idx);

Here, it matters which _RELATION_ is used.  For instance, in the
RELATION_H case, the frequency used cannot be above the target, which
is not guaranteed now AFAICS.

I would just really skip the inefficient frequencies as though they
were not there in the table, and then refine the search to take the
inefficient ones into account when the policy max limit is in effect
(which also depends on the relation type AFAICS).

In addition to the above, please note that __cpufreq_driver_target()
is not only called by governors and at least in the suspend frequency
case I don't see why it should be an efficient one even if
skip_inefficiencies is set.

> +
> +       return idx;
>  }
>
>  static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy *policy)
> --
> 2.7.4
>
