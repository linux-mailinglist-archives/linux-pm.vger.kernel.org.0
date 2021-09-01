Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDA93FE11A
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 19:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbhIAR0i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 13:26:38 -0400
Received: from mail-oo1-f48.google.com ([209.85.161.48]:42801 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhIAR0i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 13:26:38 -0400
Received: by mail-oo1-f48.google.com with SMTP id e206-20020a4a55d7000000b00291379cb2baso90591oob.9
        for <linux-pm@vger.kernel.org>; Wed, 01 Sep 2021 10:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MD/gO/FcenaMvGS16vg/72/LUgbBcxbMvILblP/AY0Q=;
        b=mdDXnSra2BTj+3VR+Rkevd5KPKui+3zbVH+sLtAR4DBS31MrEAInCObDHpTRxgrq+y
         EYFtTc6Y3wLoIlmckUGlxGr4vI1OXl1fRJkx9Uzt4+sIfe6ZURW8LyyESoI0JpYs8oTa
         PbSQeHtDS6ZhEWHMsockUHy4GtqSh1I9KeAQ2wKslPRSX9dnA3FojsETJEv3uD+iB05a
         QaOSn4V4zxZacD8kvrHM61I+UCx8HL+dCZZccb57x5bkzwra4+5dHOUHmDAKnxXTlzz2
         63TSOCczokOxplNgxFaD52XRXrk+sEO23NmxOeGCUsVC/IdMwhpmYpeezpbhDctjzeMg
         oXqw==
X-Gm-Message-State: AOAM531HRWrhgGzDbOJhdTe5/756nvr2JN24LzKM+Mcx97MPSLdIj3s9
        JFIQKO3D7DC6Ce5PAIlv+LTW/gGbyxht5mC1WwjE3tHg
X-Google-Smtp-Source: ABdhPJwxnOx7kqWtD5ciNV6gxIE+bBZ+gc+Kads8cLNdYIYG/ZC08IsRqUmyc+m46Zt54yV6DWsVfLsFeTGHsccumak=
X-Received: by 2002:a4a:ca83:: with SMTP id x3mr398597ooq.2.1630517140819;
 Wed, 01 Sep 2021 10:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com> <1630405453-275784-6-git-send-email-vincent.donnefort@arm.com>
In-Reply-To: <1630405453-275784-6-git-send-email-vincent.donnefort@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Sep 2021 19:25:30 +0200
Message-ID: <CAJZ5v0inVPxV8FXJznEzqvbf5hLihzmB4cMTNX+iQxEEJfyYNQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] cpufreq: Add an interface to mark inefficient frequencies
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
> Some SoCs such as the sd855 have OPPs within the same policy whose cost is
> higher than others with a higher frequency. Those OPPs are inefficients
> and it might be interesting for a governor to not use them.
>
> The inefficient interface is composed of two calls:
>
>  1. cpufreq_table_set_inefficient() marks a frequency as inefficient.
>
>  2. cpufreq_table_update_efficiencies() use the inefficiences marked by the
>     previous function to generate a mapping inefficient->efficient.
>
> Resolving an inefficient frequency to an efficient on can then be done
> by accessing the cpufreq_frequency_table member "efficient". The
> resolution doesn't guarantee the policy maximum.
>
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 67e56cf638ef..d3fa38af2aa6 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -365,6 +365,59 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
>         return set_freq_table_sorted(policy);
>  }
>
> +/**
> + * cpufreq_table_update_efficiencies() - Update efficiency resolution
> + *

I'm not sure what the extra empty line here is for.

> + * @policy:    the &struct cpufreq_policy to update
> + *
> + * Allow quick resolution from inefficient frequencies to efficient ones.
> + * Inefficient frequencies must have been previously marked with
> + * cpufreq_table_set_inefficient().
> + *
> + * Return: %0 on success or a negative errno code
> + */
> +int cpufreq_table_update_efficiencies(struct cpufreq_policy *policy)
> +{
> +       struct cpufreq_frequency_table *pos, *table = policy->freq_table;
> +       enum cpufreq_table_sorting sort = policy->freq_table_sorted;
> +       int efficient, idx;
> +
> +       /* Not supported */
> +       if (sort == CPUFREQ_TABLE_UNSORTED)
> +               return -EINVAL;
> +
> +       /* The highest frequency is always efficient */
> +       cpufreq_for_each_valid_entry_idx(pos, table, idx) {
> +               efficient = idx;
> +               if (sort == CPUFREQ_TABLE_SORTED_DESCENDING)
> +                       break;
> +       }
> +
> +       for (;;) {
> +               pos = &table[idx];
> +
> +               if (pos->frequency != CPUFREQ_ENTRY_INVALID) {
> +                       if (pos->flags & CPUFREQ_INEFFICIENT_FREQ) {
> +                               pos->efficient = efficient;
> +                       } else {
> +                               pos->efficient = idx;
> +                               efficient = idx;
> +                       }
> +               }
> +
> +               if (sort == CPUFREQ_TABLE_SORTED_ASCENDING) {
> +                       if (--idx < 0)
> +                               break;
> +               } else {
> +                       if (table[++idx].frequency == CPUFREQ_TABLE_END)
> +                               break;
> +               }
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_table_update_efficiencies);
> +
>  MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
>  MODULE_DESCRIPTION("CPUfreq frequency table helpers");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index c65a1d7385f8..4e901ebd104d 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -664,13 +664,15 @@ struct governor_attr {
>  #define CPUFREQ_ENTRY_INVALID  ~0u
>  #define CPUFREQ_TABLE_END      ~1u
>  /* Special Values of .flags field */
> -#define CPUFREQ_BOOST_FREQ     (1 << 0)
> +#define CPUFREQ_BOOST_FREQ      (1 << 0)
> +#define CPUFREQ_INEFFICIENT_FREQ (1 << 1)
>
>  struct cpufreq_frequency_table {
>         unsigned int    flags;
>         unsigned int    driver_data; /* driver specific data, not used by core */
>         unsigned int    frequency; /* kHz - doesn't need to be in ascending
>                                     * order */
> +       unsigned int    efficient; /* idx of an efficient frequency */

It looks to me like having just one efficient frequency index here may
not work in general (I'll explain this in a reply to the next patch).

Also, it's a bit weird to kind of point it to self for the efficient ones.

>  };
>
>  #if defined(CONFIG_CPU_FREQ) && defined(CONFIG_PM_OPP)
> @@ -762,6 +764,7 @@ int cpufreq_boost_trigger_state(int state);
>  int cpufreq_boost_enabled(void);
>  int cpufreq_enable_boost_support(void);
>  bool policy_has_boost_freq(struct cpufreq_policy *policy);
> +int cpufreq_table_update_efficiencies(struct cpufreq_policy *policy);
>
>  /* Find lowest freq at or above target in a table in ascending order */
>  static inline int cpufreq_table_find_index_al(struct cpufreq_policy *policy,
> @@ -1003,6 +1006,29 @@ static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy
>
>         return count;
>  }
> +
> +/**
> + * cpufreq_table_set_inefficient() - Mark a frequency as inefficient
> + *
> + * @policy:    the &struct cpufreq_policy containing the inefficient frequency
> + * @frequency: the inefficient frequency
> + *
> + * Once inefficiencies marked, the efficient resolution must be updated with the
> + * function cpufreq_table_update_efficiencies().
> + */
> +static inline void
> +cpufreq_table_set_inefficient(const struct cpufreq_policy *policy,
> +                             unsigned int frequency)
> +{
> +       struct cpufreq_frequency_table *pos;
> +
> +       cpufreq_for_each_valid_entry(pos, policy->freq_table) {
> +               if (pos->frequency == frequency) {
> +                       pos->flags |= CPUFREQ_INEFFICIENT_FREQ;
> +                       break;
> +               }
> +       }
> +}
>  #else
>  static inline int cpufreq_boost_trigger_state(int state)
>  {
> @@ -1022,6 +1048,16 @@ static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
>  {
>         return false;
>  }
> +
> +static inline void
> +cpufreq_table_set_inefficient(const struct cpufreq_policy *policy,
> +                             unsigned int frequency) {}
> +
> +static inline int
> +cpufreq_table_update_efficiencies(struct cpufreq_policy *policy)
> +{
> +       return -EINVAL;
> +}
>  #endif
>
>  #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> --
> 2.7.4
>
