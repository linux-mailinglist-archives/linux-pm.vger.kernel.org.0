Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6297B275918
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 15:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIWNsi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Sep 2020 09:48:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42157 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgIWNsi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2020 09:48:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id m13so14503249otl.9;
        Wed, 23 Sep 2020 06:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJSihRXz/gvuMsPkQyFBnZN2lc53j8bv4MakGdcfst4=;
        b=kjHj9O1XKNlv8TcC0ej6ZzJ6v4fOVvFMyE+C+J8Gn7gLoPIgJJ6J5leuwhg+JYO/9n
         lXsbEsJpyq2pPToqAjGca18kmB7pdMutlL61VU5mzuR81hRX02/T+Z3C6j9WBCkLEsCY
         u0cBRN+uJPLfvJ8yPjFIOMZxf3fhJvLC0QUZ3tluTGJ8AB9QqPB35FcogazUmUsMbwX7
         E+FKjnvRov0CE85/xQ/plEo0rtJaO2gego0WvPR2mnEwripvz32o4apFF7thc5H2laq3
         0Ehma9pbA0Q7G5H7oUTuh9RoxDjmtEr/yFw1xlt3Tck7sozVpNX6ia3sgPi8doSgmHWp
         RDcA==
X-Gm-Message-State: AOAM530BAKc/bIJW0oH8bGTuuYpUJ3y/voTcS/dJb/fQFeVwJE74c5fq
        nVKImLzZn4NbNauRvjgZzEmd57o8rV3/zpW2Nqk=
X-Google-Smtp-Source: ABdhPJxqnJ6rTAsG4LPmdV/0Tzgrr9KmZtVMh6uIxv4EEJmW66ziwr76KlgavrDQoaSEuksMvlkfk69zy8bKLRrgHdk=
X-Received: by 2002:a05:6830:1f16:: with SMTP id u22mr5927129otg.118.1600868915730;
 Wed, 23 Sep 2020 06:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600238586.git.viresh.kumar@linaro.org> <31999d801bfb4d8063dc1ceec1234b6b80b4ae68.1600238586.git.viresh.kumar@linaro.org>
In-Reply-To: <31999d801bfb4d8063dc1ceec1234b6b80b4ae68.1600238586.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Sep 2020 15:48:24 +0200
Message-ID: <CAJZ5v0i0aW6jT=DD6ogyfr+bs5LZu7Gn+5A9O_bZxNsnHPojOQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 16, 2020 at 8:45 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> In order to prepare for lock-less stats update, add support to defer any
> updates to it until cpufreq_stats_record_transition() is called.

This is a bit devoid of details.

I guess you mean reset in particular, but that's not clear from the above.

Also, it would be useful to describe the design somewhat.

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 75 ++++++++++++++++++++++++---------
>  1 file changed, 56 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 94d959a8e954..3e7eee29ee86 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -22,17 +22,22 @@ struct cpufreq_stats {
>         spinlock_t lock;
>         unsigned int *freq_table;
>         unsigned int *trans_table;
> +
> +       /* Deferred reset */
> +       unsigned int reset_pending;
> +       unsigned long long reset_time;
>  };
>
> -static void cpufreq_stats_update(struct cpufreq_stats *stats)
> +static void cpufreq_stats_update(struct cpufreq_stats *stats,
> +                                unsigned long long time)
>  {
>         unsigned long long cur_time = get_jiffies_64();
>
> -       stats->time_in_state[stats->last_index] += cur_time - stats->last_time;
> +       stats->time_in_state[stats->last_index] += cur_time - time;
>         stats->last_time = cur_time;
>  }
>
> -static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
> +static void cpufreq_stats_reset_table(struct cpufreq_stats *stats)
>  {
>         unsigned int count = stats->max_state;
>
> @@ -41,42 +46,67 @@ static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
>         memset(stats->trans_table, 0, count * count * sizeof(int));
>         stats->last_time = get_jiffies_64();
>         stats->total_trans = 0;
> +
> +       /* Adjust for the time elapsed since reset was requested */
> +       WRITE_ONCE(stats->reset_pending, 0);

What if this runs in parallel with store_reset()?

The latter may update reset_pending to 1 before the below runs.
Conversely, this may clear reset_pending right after store_reset() has
set it to 1, but before it manages to set reset_time.  Is that not a
problem?

> +       cpufreq_stats_update(stats, stats->reset_time);
>
>         spin_unlock(&stats->lock);
>  }
>
>  static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
>  {
> -       return sprintf(buf, "%d\n", policy->stats->total_trans);
> +       struct cpufreq_stats *stats = policy->stats;
> +
> +       if (READ_ONCE(stats->reset_pending))
> +               return sprintf(buf, "%d\n", 0);
> +       else
> +               return sprintf(buf, "%d\n", stats->total_trans);
>  }
>  cpufreq_freq_attr_ro(total_trans);
>
>  static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>  {
>         struct cpufreq_stats *stats = policy->stats;
> +       bool pending = READ_ONCE(stats->reset_pending);
> +       unsigned long long time;
>         ssize_t len = 0;
>         int i;
>
>         if (policy->fast_switch_enabled)
>                 return 0;
>
> -       spin_lock(&stats->lock);
> -       cpufreq_stats_update(stats);
> -       spin_unlock(&stats->lock);
> -
>         for (i = 0; i < stats->state_num; i++) {
> +               if (pending) {
> +                       if (i == stats->last_index)
> +                               time = get_jiffies_64() - stats->reset_time;

What if this runs in parallel with store_reset() and reads reset_time
before the latter manages to update it?

> +                       else
> +                               time = 0;
> +               } else {
> +                       time = stats->time_in_state[i];
> +                       if (i == stats->last_index)
> +                               time += get_jiffies_64() - stats->last_time;
> +               }
> +
>                 len += sprintf(buf + len, "%u %llu\n", stats->freq_table[i],
> -                       (unsigned long long)
> -                       jiffies_64_to_clock_t(stats->time_in_state[i]));
> +                              jiffies_64_to_clock_t(time));
>         }
>         return len;
>  }
>  cpufreq_freq_attr_ro(time_in_state);
>
> +/* We don't care what is written to the attribute */
>  static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
>                            size_t count)
>  {
> -       /* We don't care what is written to the attribute. */
> -       cpufreq_stats_clear_table(policy->stats);
> +       struct cpufreq_stats *stats = policy->stats;
> +
> +       /*
> +        * Defer resetting of stats to cpufreq_stats_record_transition() to
> +        * avoid races.
> +        */
> +       WRITE_ONCE(stats->reset_pending, 1);
> +       stats->reset_time = get_jiffies_64();

AFAICS, there is nothing to ensure that reset_time will be updated in
one go and even to ensure that it won't be partially updated before
setting reset_pending.

This should at least be addressed in a comment to explain why it is
not a problem.

> +
>         return count;
>  }
>  cpufreq_freq_attr_wo(reset);
> @@ -84,8 +114,9 @@ cpufreq_freq_attr_wo(reset);
>  static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>  {
>         struct cpufreq_stats *stats = policy->stats;
> +       bool pending = READ_ONCE(stats->reset_pending);
>         ssize_t len = 0;
> -       int i, j;
> +       int i, j, count;
>
>         if (policy->fast_switch_enabled)
>                 return 0;
> @@ -113,8 +144,13 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>                 for (j = 0; j < stats->state_num; j++) {
>                         if (len >= PAGE_SIZE)
>                                 break;
> -                       len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ",
> -                                       stats->trans_table[i*stats->max_state+j]);
> +
> +                       if (pending)
> +                               count = 0;
> +                       else
> +                               count = stats->trans_table[i * stats->max_state + j];
> +
> +                       len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ", count);
>                 }
>                 if (len >= PAGE_SIZE)
>                         break;
> @@ -228,10 +264,11 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
>         struct cpufreq_stats *stats = policy->stats;
>         int old_index, new_index;
>
> -       if (!stats) {
> -               pr_debug("%s: No stats found\n", __func__);
> +       if (!stats)
>                 return;
> -       }
> +
> +       if (READ_ONCE(stats->reset_pending))
> +               cpufreq_stats_reset_table(stats);

This is a bit confusing, because cpufreq_stats_reset_table() calls
cpufreq_stats_update() and passes reset_time to it, but it is called
again below with last_time as the second arg.

It is not particularly clear to me why this needs to be done this way.

>
>         old_index = stats->last_index;
>         new_index = freq_table_get_index(stats, new_freq);
> @@ -241,7 +278,7 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
>                 return;
>
>         spin_lock(&stats->lock);
> -       cpufreq_stats_update(stats);
> +       cpufreq_stats_update(stats, stats->last_time);
>
>         stats->last_index = new_index;
>         stats->trans_table[old_index * stats->max_state + new_index]++;
> --
> 2.25.0.rc1.19.g042ed3e048af
>
