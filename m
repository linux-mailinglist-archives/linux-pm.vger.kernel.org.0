Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816DB44000A
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 18:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhJ2QKA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 12:10:00 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:41758 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2QJ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Oct 2021 12:09:59 -0400
Received: by mail-oi1-f172.google.com with SMTP id y128so13997363oie.8;
        Fri, 29 Oct 2021 09:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lu7KlDiDD4b+IN0GOyZKFEqg42aag7ye4ODeWU/vdAQ=;
        b=PrXYCtu+BFF+QJN+asWOiR2YFHkZIsbcMUyKLpUL+QC7zzclyzL5dzw+z8O85DbI+X
         F3k2O/Z/h6c1UWz/tojbkbsd8W3iyShUJ3Q5pIb/kDBqLhE6FWmHhQdLiKsFlc1D4u8o
         NVyH+qD3Jl3tztpsHodFIMoTaCxiuIKElff6A+Qen9uedgYcupEd/Lfubfvig+GOKlSd
         thMtx6cG4RKe/JSgS1DlCTLRm3Wro/xC6hpIoqNBy/zwCNTX9AxeStR3L1bMN/vgohjd
         oKhJvgany22eMbH6n/vTlfr751bxSqP4O3rL92U7J5xqgY9b43JaRgB6gJpxVJs3olrV
         RqwQ==
X-Gm-Message-State: AOAM531MyMxyBz0o1j50OblMgSa3GKQ/xSOT4yKW2htUXfN0snziHLXB
        FGWA/LHFMatTeqIgrTH/IwP0TUeTiVBd0FzCRHI=
X-Google-Smtp-Source: ABdhPJwtnN5N6Ip5bwANimooyjfDhNJ07hr/7h7HbCuFbTx7dntx+hag2+5dWh6IP0CHbPF3De7DcywkGiS4YigdzUU=
X-Received: by 2002:a05:6808:e90:: with SMTP id k16mr8536510oil.166.1635523649047;
 Fri, 29 Oct 2021 09:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <1635478517-3071352-1-git-send-email-jiasheng@iscas.ac.cn>
In-Reply-To: <1635478517-3071352-1-git-send-email-jiasheng@iscas.ac.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Oct 2021 18:07:18 +0200
Message-ID: <CAJZ5v0iRD0pLkVfDE7KgmTfZJJZ2BFquV8owiPoQgFMmC2ZrGA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Fix implicit type conversion
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 29, 2021 at 5:51 AM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> The variable 'cpu' and 'j' are defined as unsigned int.
> However in the for_each_cpu, their values are assigned to -1.
> That doesn't make sense

Yes, it does.

The binary representation of -1 is an all-ones value of the size of
int.  It is perfectly valid to store that value in an unsigned int
variable.

> and in the cpumask_next() they are implicitly type conversed to int.

However, the return type of cpumask_next() is unsigned int.

> It is universally accepted that the implicit type conversion is terrible.

I wouldn't say "terrible", but yes, it is risky when dealing with
variables of different sizes and possible sign-extensions.

In this particular case, I don't see a problem.

> Also, having the good programming custom will set an example for
> others.
> Thus, it might be better to change the definition of 'cpu' and 'j'
> from unsigned int to int.
>
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  kernel/sched/cpufreq_schedutil.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 4f09afd..4aff4b6 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -409,7 +409,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>         struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>         struct cpufreq_policy *policy = sg_policy->policy;
>         unsigned long util = 0, max = 1;
> -       unsigned int j;
> +       int j;
>
>         for_each_cpu(j, policy->cpus) {
>                 struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
> @@ -746,7 +746,7 @@ static int sugov_start(struct cpufreq_policy *policy)
>  {
>         struct sugov_policy *sg_policy = policy->governor_data;
>         void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
> -       unsigned int cpu;
> +       int cpu;
>
>         sg_policy->freq_update_delay_ns = sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
>         sg_policy->last_freq_update_time        = 0;
> @@ -783,7 +783,7 @@ static int sugov_start(struct cpufreq_policy *policy)
>  static void sugov_stop(struct cpufreq_policy *policy)
>  {
>         struct sugov_policy *sg_policy = policy->governor_data;
> -       unsigned int cpu;
> +       int cpu;
>
>         for_each_cpu(cpu, policy->cpus)
>                 cpufreq_remove_update_util_hook(cpu);
> --
> 2.7.4
>
