Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654ED2784AC
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 12:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgIYKFC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 06:05:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36460 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbgIYKFC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 06:05:02 -0400
Received: by mail-ot1-f68.google.com with SMTP id 60so1781088otw.3;
        Fri, 25 Sep 2020 03:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sUdX5BJCnjUHbakBtLYxfuIBOC4QZh0maFRiwBw5/jg=;
        b=fDCP0LHtfGZKQhRErie2kC+4ZP30EUUO7xVuoo0pX0yVwUJOQFrTj2aBwR+q8oC0v3
         6ieGG/+Qf5mPD9CCGOCA1c7rrD6z89HeKM7idCDkkOTe/ZNA+AFvXVhMsxdgHu+1Y+j+
         8sfC0LUtdYcV6YT/d6d1wb4dZmAbUOnVIZZ6/k1IL1+K0qtRosJSYEAcssG4LIu+D7aU
         gUC64PlK4H1nprwvvlcg2CAb43Wy2w0iHmb7Hfq2/4l21dlkxiv6G1RbAulJnVQUKsF8
         hC6MXLKo/9nwIAkIouWa66OL/hp9veINtPA24OkKEZk/buxoIP6O57Uoq/hkP5OKJJG6
         bKrg==
X-Gm-Message-State: AOAM532n76Xs/VO691JHU4ixW5abG7N4MTvBjyfkgSK4npAo0AgqWm4J
        z6WJy+BRjICXDA0td0B8b0EibkVleLlogBCZB7M=
X-Google-Smtp-Source: ABdhPJwsV0Z4bzdx1s40BeqfLs4+dYxHWlWBVydSNbF4OvgqCLP83oMZqUy6wyEIRHII+bB/Gsct/uKHdN0OTnt73fA=
X-Received: by 2002:a9d:718a:: with SMTP id o10mr2323645otj.262.1601028300591;
 Fri, 25 Sep 2020 03:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600238586.git.viresh.kumar@linaro.org> <31999d801bfb4d8063dc1ceec1234b6b80b4ae68.1600238586.git.viresh.kumar@linaro.org>
 <CAJZ5v0i0aW6jT=DD6ogyfr+bs5LZu7Gn+5A9O_bZxNsnHPojOQ@mail.gmail.com> <20200924131543.eury5vhqy3xt35v6@vireshk-i7>
In-Reply-To: <20200924131543.eury5vhqy3xt35v6@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 12:04:49 +0200
Message-ID: <CAJZ5v0g8Bmxt=GEKcNrKjY1cHnsURV5oe3+n1R2+U_2VJnwfRQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 24, 2020 at 3:15 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 23-09-20, 15:48, Rafael J. Wysocki wrote:
> > On Wed, Sep 16, 2020 at 8:45 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > In order to prepare for lock-less stats update, add support to defer any
> > > updates to it until cpufreq_stats_record_transition() is called.
> >
> > This is a bit devoid of details.
> >
> > I guess you mean reset in particular, but that's not clear from the above.
>
> We used to update the stats from two places earlier, reset and
> show_time_in_state, the later got removed with this patch.
>
> > Also, it would be useful to describe the design somewhat.
>
> Okay. I will work on it.
>
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/cpufreq/cpufreq_stats.c | 75 ++++++++++++++++++++++++---------
> > >  1 file changed, 56 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> > > index 94d959a8e954..3e7eee29ee86 100644
> > > --- a/drivers/cpufreq/cpufreq_stats.c
> > > +++ b/drivers/cpufreq/cpufreq_stats.c
> > > @@ -22,17 +22,22 @@ struct cpufreq_stats {
> > >         spinlock_t lock;
> > >         unsigned int *freq_table;
> > >         unsigned int *trans_table;
> > > +
> > > +       /* Deferred reset */
> > > +       unsigned int reset_pending;
> > > +       unsigned long long reset_time;
> > >  };
> > >
> > > -static void cpufreq_stats_update(struct cpufreq_stats *stats)
> > > +static void cpufreq_stats_update(struct cpufreq_stats *stats,
> > > +                                unsigned long long time)
> > >  {
> > >         unsigned long long cur_time = get_jiffies_64();
> > >
> > > -       stats->time_in_state[stats->last_index] += cur_time - stats->last_time;
> > > +       stats->time_in_state[stats->last_index] += cur_time - time;
> > >         stats->last_time = cur_time;
> > >  }
> > >
> > > -static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
> > > +static void cpufreq_stats_reset_table(struct cpufreq_stats *stats)
> > >  {
> > >         unsigned int count = stats->max_state;
> > >
> > > @@ -41,42 +46,67 @@ static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
> > >         memset(stats->trans_table, 0, count * count * sizeof(int));
> > >         stats->last_time = get_jiffies_64();
> > >         stats->total_trans = 0;
> > > +
> > > +       /* Adjust for the time elapsed since reset was requested */
> > > +       WRITE_ONCE(stats->reset_pending, 0);
> >
> > What if this runs in parallel with store_reset()?
> >
> > The latter may update reset_pending to 1 before the below runs.
> > Conversely, this may clear reset_pending right after store_reset() has
> > set it to 1, but before it manages to set reset_time.  Is that not a
> > problem?
>
> What I tried to do here with reset_time is to capture the delta time-in-state
> that has elapsed since the last time reset was called and reset was actually
> performed, so we keep showing it in stats.
>
> In the first race you mentioned, whatever update we make here won't matter much
> as reset-pending will be 1 and so below stats will not be used anywhere.
>
> In the second race, we may get the delta time-in-state wrong, since this is just
> stats it shouldn't matter much. But still I think we need to fix the way we do
> reset as you pointed out. More later.
>
> > > +       cpufreq_stats_update(stats, stats->reset_time);
> > >
> > >         spin_unlock(&stats->lock);
> > >  }
> > >
> > >  static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
> > >  {
> > > -       return sprintf(buf, "%d\n", policy->stats->total_trans);
> > > +       struct cpufreq_stats *stats = policy->stats;
> > > +
> > > +       if (READ_ONCE(stats->reset_pending))
> > > +               return sprintf(buf, "%d\n", 0);
> > > +       else
> > > +               return sprintf(buf, "%d\n", stats->total_trans);
> > >  }
> > >  cpufreq_freq_attr_ro(total_trans);
> > >
> > >  static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
> > >  {
> > >         struct cpufreq_stats *stats = policy->stats;
> > > +       bool pending = READ_ONCE(stats->reset_pending);
> > > +       unsigned long long time;
> > >         ssize_t len = 0;
> > >         int i;
> > >
> > >         if (policy->fast_switch_enabled)
> > >                 return 0;
> > >
> > > -       spin_lock(&stats->lock);
> > > -       cpufreq_stats_update(stats);
> > > -       spin_unlock(&stats->lock);
> > > -
> > >         for (i = 0; i < stats->state_num; i++) {
> > > +               if (pending) {
> > > +                       if (i == stats->last_index)
> > > +                               time = get_jiffies_64() - stats->reset_time;
> >
> > What if this runs in parallel with store_reset() and reads reset_time
> > before the latter manages to update it?
>
> We should update reset-time first I think. More later.
>
> > > +                       else
> > > +                               time = 0;
> > > +               } else {
> > > +                       time = stats->time_in_state[i];
> > > +                       if (i == stats->last_index)
> > > +                               time += get_jiffies_64() - stats->last_time;
> > > +               }
> > > +
> > >                 len += sprintf(buf + len, "%u %llu\n", stats->freq_table[i],
> > > -                       (unsigned long long)
> > > -                       jiffies_64_to_clock_t(stats->time_in_state[i]));
> > > +                              jiffies_64_to_clock_t(time));
> > >         }
> > >         return len;
> > >  }
> > >  cpufreq_freq_attr_ro(time_in_state);
> > >
> > > +/* We don't care what is written to the attribute */
> > >  static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
> > >                            size_t count)
> > >  {
> > > -       /* We don't care what is written to the attribute. */
> > > -       cpufreq_stats_clear_table(policy->stats);
> > > +       struct cpufreq_stats *stats = policy->stats;
> > > +
> > > +       /*
> > > +        * Defer resetting of stats to cpufreq_stats_record_transition() to
> > > +        * avoid races.
> > > +        */
> > > +       WRITE_ONCE(stats->reset_pending, 1);
> > > +       stats->reset_time = get_jiffies_64();
> >
> > AFAICS, there is nothing to ensure that reset_time will be updated in
> > one go and even to ensure that it won't be partially updated before
> > setting reset_pending.
> >
> > This should at least be addressed in a comment to explain why it is
> > not a problem.
>
> I propose something like this for it:
>
>        WRITE_ONCE(stats->reset_time, get_jiffies_64());
>        WRITE_ONCE(stats->reset_pending, 1);
>
> Whatever race happens here, the worst would be like getting time-in-state for
> one of the frequencies wrong only once and I don't think that should be a
> real problem as this is just stats and won't make the kernel behave badly.

I'm actually wondering if reset_time is necessary at all.

If cpufreq_stats_record_transition() is the only updater of the stats,
which will be the case after applying this series IIUC, it may as well
simply set the new starting point and discard all of the data
collected so far if reset_pending is set.

IOW, the time when the reset has been requested isn't particularly
relevant IMV (and it is not exact anyway), because the user is
basically asking for discarding "history" and that may very well be
interpreted to include the current sample.

> > > +
> > >         return count;
> > >  }
> > >  cpufreq_freq_attr_wo(reset);
> > > @@ -84,8 +114,9 @@ cpufreq_freq_attr_wo(reset);
> > >  static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
> > >  {
> > >         struct cpufreq_stats *stats = policy->stats;
> > > +       bool pending = READ_ONCE(stats->reset_pending);
> > >         ssize_t len = 0;
> > > -       int i, j;
> > > +       int i, j, count;
> > >
> > >         if (policy->fast_switch_enabled)
> > >                 return 0;
> > > @@ -113,8 +144,13 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
> > >                 for (j = 0; j < stats->state_num; j++) {
> > >                         if (len >= PAGE_SIZE)
> > >                                 break;
> > > -                       len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ",
> > > -                                       stats->trans_table[i*stats->max_state+j]);
> > > +
> > > +                       if (pending)
> > > +                               count = 0;
> > > +                       else
> > > +                               count = stats->trans_table[i * stats->max_state + j];
> > > +
> > > +                       len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ", count);
> > >                 }
> > >                 if (len >= PAGE_SIZE)
> > >                         break;
> > > @@ -228,10 +264,11 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
> > >         struct cpufreq_stats *stats = policy->stats;
> > >         int old_index, new_index;
> > >
> > > -       if (!stats) {
> > > -               pr_debug("%s: No stats found\n", __func__);
> > > +       if (!stats)
> > >                 return;
> > > -       }
> > > +
> > > +       if (READ_ONCE(stats->reset_pending))
> > > +               cpufreq_stats_reset_table(stats);
> >
> > This is a bit confusing, because cpufreq_stats_reset_table() calls
> > cpufreq_stats_update() and passes reset_time to it, but it is called
> > again below with last_time as the second arg.
> >
> > It is not particularly clear to me why this needs to be done this way.
>
> Because we need to account for the elapsed time-in-state, for the currently
> running frequency.
>
> When reset-stats is called, we note down the reset-time, then if reset was
> pending then we call reset-table which calls cpufreq_stats_update(reset_time),
> and so we account for the elapsed time in current state, where we also update
> last-time.
>
> The second call here won't update much in case reset was pending, but will
> update normally otherwise.
>
> --
> viresh
