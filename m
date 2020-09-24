Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1F7276EA7
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 12:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgIXKZJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 06:25:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32799 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgIXKZJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 06:25:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id m12so2699012otr.0;
        Thu, 24 Sep 2020 03:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rd+YTDrEimq1BimK47ljL9rpY0VeXSNxYm1iPNxV2KY=;
        b=onqfFF4Hi+v0sz7LZgxihkKEyAMLW5FQSjmgVd0zagnXkojRj0/uFDKeS822BNdv/L
         DBJTxZxzU3KR4CZ7R2tuaXB66PFIVlJxpfFFD+sJy7HTPa6g2ogz69tz3NyCYhjJr0Qt
         58BTIh0LekBgG+DQw6YNqCqTCp/MoEipHZoGGxDUEcasMoF/wvI2vFKpnZmhQT9lZfHP
         zcHQnA9CxW+zeoshmgnu67eZpzEplGHO/XIASbz6U/rvmdf58SBmJistBGzX1kypP4gA
         g1XwUgDGGZf133FpWhRNOw9LZuFTIq4UrifMh24e1qfgI1fIlIEf88EanZUiY7cgn/Iq
         vufA==
X-Gm-Message-State: AOAM5304wSN7zXiO85SEauG7X8LXdV3cWZBUgcVZij8pZWD5bIdLTqdi
        6O5jvVKS+1AMsgsuqnufstL75QprjXrrv9hH24mi0MOq
X-Google-Smtp-Source: ABdhPJw1CfCA7p6EBrHphIJKpbQBbhT9YWNTuOFSFjaDf5tPlRCrPnEgbkB4PdsWPbV6N2IxacIzTGh5tru/lkxdhIw=
X-Received: by 2002:a05:6830:1f16:: with SMTP id u22mr2490195otg.118.1600943108102;
 Thu, 24 Sep 2020 03:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600238586.git.viresh.kumar@linaro.org> <31999d801bfb4d8063dc1ceec1234b6b80b4ae68.1600238586.git.viresh.kumar@linaro.org>
 <CAJZ5v0i0aW6jT=DD6ogyfr+bs5LZu7Gn+5A9O_bZxNsnHPojOQ@mail.gmail.com> <a4c5a6b9-10f8-34f8-f01d-8b373214d173@arm.com>
In-Reply-To: <a4c5a6b9-10f8-34f8-f01d-8b373214d173@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 24 Sep 2020 12:24:56 +0200
Message-ID: <CAJZ5v0iFjzqTKTPFF5hB5C0TYSQn2rxL_6099gqUwoTARKRnZA@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        cristian.marussi@arm.com, Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 24, 2020 at 11:25 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Rafael,
>
> On 9/23/20 2:48 PM, Rafael J. Wysocki wrote:
> > On Wed, Sep 16, 2020 at 8:45 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >>
> >> In order to prepare for lock-less stats update, add support to defer any
> >> updates to it until cpufreq_stats_record_transition() is called.
> >
> > This is a bit devoid of details.
> >
> > I guess you mean reset in particular, but that's not clear from the above.
> >
> > Also, it would be useful to describe the design somewhat.
> >
> >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> ---
> >>   drivers/cpufreq/cpufreq_stats.c | 75 ++++++++++++++++++++++++---------
> >>   1 file changed, 56 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> >> index 94d959a8e954..3e7eee29ee86 100644
> >> --- a/drivers/cpufreq/cpufreq_stats.c
> >> +++ b/drivers/cpufreq/cpufreq_stats.c
> >> @@ -22,17 +22,22 @@ struct cpufreq_stats {
> >>          spinlock_t lock;
> >>          unsigned int *freq_table;
> >>          unsigned int *trans_table;
> >> +
> >> +       /* Deferred reset */
> >> +       unsigned int reset_pending;
> >> +       unsigned long long reset_time;
> >>   };
> >>
> >> -static void cpufreq_stats_update(struct cpufreq_stats *stats)
> >> +static void cpufreq_stats_update(struct cpufreq_stats *stats,
> >> +                                unsigned long long time)
> >>   {
> >>          unsigned long long cur_time = get_jiffies_64();
> >>
> >> -       stats->time_in_state[stats->last_index] += cur_time - stats->last_time;
> >> +       stats->time_in_state[stats->last_index] += cur_time - time;
> >>          stats->last_time = cur_time;
> >>   }
> >>
> >> -static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
> >> +static void cpufreq_stats_reset_table(struct cpufreq_stats *stats)
> >>   {
> >>          unsigned int count = stats->max_state;
> >>
> >> @@ -41,42 +46,67 @@ static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
> >>          memset(stats->trans_table, 0, count * count * sizeof(int));
> >>          stats->last_time = get_jiffies_64();
> >>          stats->total_trans = 0;
> >> +
> >> +       /* Adjust for the time elapsed since reset was requested */
> >> +       WRITE_ONCE(stats->reset_pending, 0);
> >
> > What if this runs in parallel with store_reset()?
> >
> > The latter may update reset_pending to 1 before the below runs.
> > Conversely, this may clear reset_pending right after store_reset() has
> > set it to 1, but before it manages to set reset_time.  Is that not a
> > problem?
>
> I wonder if we could just drop the reset feature. Is there a tool
> which uses this file? The 'reset' sysfs would probably have to stay
> forever, but an empty implementation is not an option?

Well, having an empty sysfs attr would be a bit ugly, but the
implementation of it could be simplified.

> The documentation states:
> 'This can be useful for evaluating system behaviour under different
> governors without the need for a reboot.'
> With the scenario of fast-switch this resetting complicates the
> implementation and the justification of having it just for experiments
> avoiding reboot is IMO weak. The real production code would have to pay
> extra cycles every time. Also, we would probably not experiment with
> cpufreq different governors, since the SchedUtil is considered the best
> option.

It would still be good to have a way to test it against the other
available options, though.
