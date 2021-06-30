Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E863B8751
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 19:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhF3RDp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 13:03:45 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:40802 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhF3RDo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 13:03:44 -0400
Received: by mail-oi1-f175.google.com with SMTP id l26so1200363oic.7;
        Wed, 30 Jun 2021 10:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTjSyaFQS7XnJNczYIzf9hXNc2aJUcdGoOWTLAlowDc=;
        b=DCjT515hgYCEH4yCNadp2NCKBjDa9BXrqS6o6Inaad31yaZmrs7vjQsuo7R8cWie4e
         qVJQpOmE7gUebTB/BVoSgAqm8/qXjL/z59TR7tIifhpTeKCuamyVCAOUEdIs3OIxOD//
         TicSBmruAunBRY5fzTBe+oaMoogrUYWM0jyUtxPE1CHHKi2XNf9ABUPvgsQd+pPXmNMP
         NQqgcIq/DncmyeBfYxuMrmGZQ4/+F3ys8dNUsZkNIrNJ3rervl4iVltMhBghmXbjCsu0
         55DumJh44RqR1AuP7yalzpNPTC1I6EBx5Epm07PgHapmpnLIlgCIk0Q8apoXCxHP6SYV
         VuLg==
X-Gm-Message-State: AOAM532MtNHC/jO0GReS/Ob0KjYCAtYtSZa5rcj52Bi2qUS0RztpiVVA
        b8HKNnrw4rsi23t5TO567AJiJF32mQWpPYLFNbg=
X-Google-Smtp-Source: ABdhPJxW87779//+LyPvUb00M0A5ZCmL8LjAd5vaItb5M9OLoWKDmHUM9UY5gn0xqTUscZ1GHKYLRFStBEG792r5OQc=
X-Received: by 2002:aca:417:: with SMTP id 23mr11474706oie.71.1625072474548;
 Wed, 30 Jun 2021 10:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210625152603.25960-1-lukasz.luba@arm.com> <20210625152603.25960-2-lukasz.luba@arm.com>
In-Reply-To: <20210625152603.25960-2-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Jun 2021 19:01:03 +0200
Message-ID: <CAJZ5v0iOzp5FKo4NsNE-m+sEXZUvv1TbkAO_9+jSidx9c0iq8A@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Prepare variables for increased precision
 of EAS estimated energy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        CCj.Yeh@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 25, 2021 at 5:26 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> The Energy Aware Scheduler (EAS) tries to find best CPU for a waking up
> task. It probes many possibilities and compares the estimated energy values
> for different scenarios. For calculating those energy values it relies on
> Energy Model (EM) data and em_cpu_energy(). The precision which is used in
> EM data is in milli-Watts (or abstract scale), which sometimes is not
> sufficient. In some cases it might happen that two CPUs from different
> Performance Domains (PDs) get the same calculated value for a given task
> placement, but in more precised scale, they might differ. This rounding
> error has to be addressed. This patch prepares EAS code for better
> precision in the coming EM improvements.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

If you want me to pick up this series, this patch requires an ACK from
the scheduler maintainers.

> ---
>  kernel/sched/fair.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7b8990fd4896..b517c9e79768 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6582,7 +6582,7 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
>   * to compute what would be the energy if we decided to actually migrate that
>   * task.
>   */
> -static long
> +static u64
>  compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>  {
>         struct cpumask *pd_mask = perf_domain_span(pd);
> @@ -6689,12 +6689,13 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>   */
>  static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  {
> -       unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
>         struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
> +       u64 prev_delta = ULLONG_MAX, best_delta = ULLONG_MAX;
>         int cpu, best_energy_cpu = prev_cpu, target = -1;
> -       unsigned long cpu_cap, util, base_energy = 0;
> +       unsigned long cpu_cap, util;
>         struct sched_domain *sd;
>         struct perf_domain *pd;
> +       u64 base_energy = 0;
>
>         rcu_read_lock();
>         pd = rcu_dereference(rd->pd);
> @@ -6718,9 +6719,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                 goto unlock;
>
>         for (; pd; pd = pd->next) {
> -               unsigned long cur_delta, spare_cap, max_spare_cap = 0;
> +               unsigned long spare_cap, max_spare_cap = 0;
>                 bool compute_prev_delta = false;
> -               unsigned long base_energy_pd;
> +               u64 base_energy_pd, cur_delta;
>                 int max_spare_cap_cpu = -1;
>
>                 for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
> @@ -6790,7 +6791,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>          * Pick the best CPU if prev_cpu cannot be used, or if it saves at
>          * least 6% of the energy used by prev_cpu.
>          */
> -       if ((prev_delta == ULONG_MAX) ||
> +       if ((prev_delta == ULLONG_MAX) ||
>             (prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
>                 target = best_energy_cpu;
>
> --
> 2.17.1
>
