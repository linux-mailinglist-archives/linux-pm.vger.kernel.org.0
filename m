Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CC5290A29
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 19:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409104AbgJPRBy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 13:01:54 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35440 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408925AbgJPRBy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 13:01:54 -0400
Received: by mail-ot1-f68.google.com with SMTP id f22so439146ots.2;
        Fri, 16 Oct 2020 10:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Himune9w6PJjlJKnqlQ8/CdxmtO3vE0wktnjw8cHEI=;
        b=DwF0RNFFQBbt+KIaH8w/5Z0LWk3GG/c/JcCtX/+bTDgWI0v1Cy4s9aC0AdstydWMZS
         fK9ngfOxcswwQpNw84qVaTdyDIGuRYF4X34LSiUj3uAIyi4hTjBUM+XCsrbX6lWGggFi
         sUEeqwbdoFtAhFXnFjwda9kaH5xTD48vlKVdHtXcHC3+JAE0Dh7LWjrYmAxzpzEzBntR
         EbUO1H1TXwmZ+9rNdUafa5WR+l+wh4JgMEQIJNsNhndsKbeQU+RSrGJHevXjFHCQnfvh
         8iU4MjsyVzxrIIaiLRybmGWLtJRbxOsjpmkaaD5X5lqqpMKTXoiScYPViAQivlg1YiNw
         tayw==
X-Gm-Message-State: AOAM533Qwd6KRxB/ghgOYtRa3oAaYC1G+D3QeJPxab/Sw8qY2VKFyXyr
        KFZLSJ4rNrrz30ysajsYBygtPYs9YuTCIwSUxMI=
X-Google-Smtp-Source: ABdhPJy1ZMEwozD7IMMR6Ns8d6xHA4hhNtBNd+yL9N+dy7uYrX2vdVdTA6czST7D+uoJm7fzTmjKGorqD62EXhlRx94=
X-Received: by 2002:a05:6830:30ae:: with SMTP id g14mr3471060ots.206.1602867713251;
 Fri, 16 Oct 2020 10:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201016163634.857573-1-wvw@google.com>
In-Reply-To: <20201016163634.857573-1-wvw@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 19:01:42 +0200
Message-ID: <CAJZ5v0in0N6USFqvuLcccpirahj=oOki67+Lq9_5i_q7Ep7T6g@mail.gmail.com>
Subject: Re: [PATCH] sched: cpufreq_schedutil: maintain raw cache when next_f
 is not changed
To:     Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>,
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

On Fri, Oct 16, 2020 at 6:36 PM Wei Wang <wvw@google.com> wrote:
>
> Currently, raw cache will be reset when next_f is changed after
> get_next_freq for correctness. However, it may introduce more
> cycles. This patch changes it to maintain the cached value instead of
> dropping it.

IMV you need to be more specific about why this helps.

> This is adapted from https://android-review.googlesource.com/1352810/
>
> Signed-off-by: Wei Wang <wvw@google.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 5ae7b4e6e8d6..ae3ae7fcd027 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -31,6 +31,7 @@ struct sugov_policy {
>         s64                     freq_update_delay_ns;
>         unsigned int            next_freq;
>         unsigned int            cached_raw_freq;
> +       unsigned int            prev_cached_raw_freq;
>
>         /* The next fields are only needed if fast switch cannot be used: */
>         struct                  irq_work irq_work;
> @@ -165,6 +166,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>                 return sg_policy->next_freq;
>
>         sg_policy->need_freq_update = false;
> +       sg_policy->prev_cached_raw_freq = sg_policy->cached_raw_freq;
>         sg_policy->cached_raw_freq = freq;
>         return cpufreq_driver_resolve_freq(policy, freq);
>  }
> @@ -464,8 +466,8 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>         if (busy && next_f < sg_policy->next_freq) {
>                 next_f = sg_policy->next_freq;
>
> -               /* Reset cached freq as next_freq has changed */
> -               sg_policy->cached_raw_freq = 0;
> +               /* Restore cached freq as next_freq has changed */
> +               sg_policy->cached_raw_freq = sg_policy->prev_cached_raw_freq;
>         }
>
>         /*
> @@ -828,6 +830,7 @@ static int sugov_start(struct cpufreq_policy *policy)
>         sg_policy->limits_changed               = false;
>         sg_policy->need_freq_update             = false;
>         sg_policy->cached_raw_freq              = 0;
> +       sg_policy->prev_cached_raw_freq         = 0;
>
>         for_each_cpu(cpu, policy->cpus) {
>                 struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
