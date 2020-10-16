Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE8A290A71
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbgJPRSI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 13:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732485AbgJPRSI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 13:18:08 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A85C061755
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 10:18:08 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h24so4255393ejg.9
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n94Aye7p3JfVB9OWEVZfTsET/k6kwBnbW1NyhTebgm0=;
        b=MXe/RlNtDcm7WmVWFKDrU32h37x7JqsxCQ0bYdYnCA8PwEMLhCFZDac8it5CjMwsj0
         YRwzHriIDngcRdS6/ZMdt+d2U/KNGvr4TWgPvzTEWqLCeo1tQUGkKWGwkcINPz6JqX6n
         elXBSN0v7qKAvTya4tu7H1T3//dv1GZFkj395XpcREj7uOSgac/8PWLmfm7qKEx1ZZhU
         5Oxr52FoRFm0XrZcjXCqFh4vRriDbE18XLwtVXMAFMLXAPxW0O8GxZKpd/zozWK16nZ1
         G3eBKVQ9uYhacdk23r4cxLPqrTN2iAqOm+zXa053vR2pxTe1jBi34ejoXIKpqTVH7kh/
         cqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n94Aye7p3JfVB9OWEVZfTsET/k6kwBnbW1NyhTebgm0=;
        b=VR3GA+Nq/TpOlHT0NYCDVs1tTDO/ZnVuEfQccTf3gh4ntIg1DLxu9h47ivA2DwJ4q0
         Qt8ZhiB8ZaEUKrKHKBeQwSIVKofXvfOkDpEODfcvHDX0uJJQ4PXrMK/G0f/ljGMD6Pl2
         0ER/X27XRY4mJMQDd7zgnNJiOoFGNEJigvbxSM3/VBPg76kWhgWHlsJwbe3oH52yGm3l
         RMn6MqqgLnYHfzq3qpNW03rXC57X+txVlmGByFoHmpuTy6AwhuAKX6g5IrFKtT7M7yL/
         iPSAnpVFABM7jXdv1/njixDvtn9HahIOXNFxKG6ZaO01WZf+8w2tVXcGF+DKTp08Y9Y0
         MIGQ==
X-Gm-Message-State: AOAM530oOiYbTBrXUUt2Z2ab+GRF+jOZL+9Ea7aCtCrmRaDsOZp9jvVk
        RaW1Dody4f2EcrP31IIoy+lBxCVu+2CevxsfOySDww==
X-Google-Smtp-Source: ABdhPJyAzoyZlICBGj2MSFdlQ9NJbplP3tVCmOehRIBBsOBQBoOrZKgI5izJT0qAZTRS49+rvSI2+7/HVuRagRUNjQM=
X-Received: by 2002:a17:906:364f:: with SMTP id r15mr4775896ejb.388.1602868685981;
 Fri, 16 Oct 2020 10:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201016163634.857573-1-wvw@google.com> <CAJZ5v0in0N6USFqvuLcccpirahj=oOki67+Lq9_5i_q7Ep7T6g@mail.gmail.com>
In-Reply-To: <CAJZ5v0in0N6USFqvuLcccpirahj=oOki67+Lq9_5i_q7Ep7T6g@mail.gmail.com>
From:   Wei Wang <wvw@google.com>
Date:   Fri, 16 Oct 2020 10:17:54 -0700
Message-ID: <CAGXk5yq_xcHYizG_z+FV14ieWya-4qeyVFz1gQZ9_gbJxUcQqg@mail.gmail.com>
Subject: Re: [PATCH] sched: cpufreq_schedutil: maintain raw cache when next_f
 is not changed
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 16, 2020 at 10:01 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Oct 16, 2020 at 6:36 PM Wei Wang <wvw@google.com> wrote:
> >
> > Currently, raw cache will be reset when next_f is changed after
> > get_next_freq for correctness. However, it may introduce more
> > cycles. This patch changes it to maintain the cached value instead of
> > dropping it.
>
> IMV you need to be more specific about why this helps.
>

I think the idea of cached_raw_freq is to reduce the chance of calling
cpufreq drivers (in some arch those may be costly) but sometimes the
cache will be wiped for correctness. The purpose of this patch is to
still keep the cached value instead of wiping them.

thx
wvw


>
> > This is adapted from https://android-review.googlesource.com/1352810/
> >
> > Signed-off-by: Wei Wang <wvw@google.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 5ae7b4e6e8d6..ae3ae7fcd027 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -31,6 +31,7 @@ struct sugov_policy {
> >         s64                     freq_update_delay_ns;
> >         unsigned int            next_freq;
> >         unsigned int            cached_raw_freq;
> > +       unsigned int            prev_cached_raw_freq;
> >
> >         /* The next fields are only needed if fast switch cannot be used: */
> >         struct                  irq_work irq_work;
> > @@ -165,6 +166,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >                 return sg_policy->next_freq;
> >
> >         sg_policy->need_freq_update = false;
> > +       sg_policy->prev_cached_raw_freq = sg_policy->cached_raw_freq;
> >         sg_policy->cached_raw_freq = freq;
> >         return cpufreq_driver_resolve_freq(policy, freq);
> >  }
> > @@ -464,8 +466,8 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
> >         if (busy && next_f < sg_policy->next_freq) {
> >                 next_f = sg_policy->next_freq;
> >
> > -               /* Reset cached freq as next_freq has changed */
> > -               sg_policy->cached_raw_freq = 0;
> > +               /* Restore cached freq as next_freq has changed */
> > +               sg_policy->cached_raw_freq = sg_policy->prev_cached_raw_freq;
> >         }
> >
> >         /*
> > @@ -828,6 +830,7 @@ static int sugov_start(struct cpufreq_policy *policy)
> >         sg_policy->limits_changed               = false;
> >         sg_policy->need_freq_update             = false;
> >         sg_policy->cached_raw_freq              = 0;
> > +       sg_policy->prev_cached_raw_freq         = 0;
> >
> >         for_each_cpu(cpu, policy->cpus) {
> >                 struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
> > --
> > 2.29.0.rc1.297.gfa9743e501-goog
> >
