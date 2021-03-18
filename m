Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93B8340D8A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 19:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCRSvT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 14:51:19 -0400
Received: from mail-oo1-f45.google.com ([209.85.161.45]:36783 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhCRSuq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 14:50:46 -0400
Received: by mail-oo1-f45.google.com with SMTP id w1-20020a4adec10000b02901bc77feac3eso1686758oou.3;
        Thu, 18 Mar 2021 11:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xE/+zwrG8Sz1bNHFmDwKKVFIzwhY9mhnwyiscge5jEE=;
        b=Nr54tlfnRT2ceElKMccWjwzzh6bSpVCA0UZu34HV3DKG9KSKlZ7pAfhW0JDcLctgZE
         v62hQ8OlSnGHqrD4JoCc6vZ7cNgVQYBHAT1Fd2FhKn+7zgNaBYpsw0ZujaQV3I6FJeYj
         3LQKP4c1US+MGmhi8Z/X8jb+hGMwwtOcqSwBNdLpisnEKs7GiX5iWE11i4R8kaTnjM3t
         rYgRz4VRSQSVCUZ0EH67cR30Lii6ltT7DzQnYeRMf6MIvdEQr3uL4AdTkGJB9j8/Hc0j
         4HOZ/YBjlcAZqDBXN+IqLKpc+s245hkLJ53YdYT1mAjiOzg/XwN5OV398htezhYmYbqK
         2Eqg==
X-Gm-Message-State: AOAM531lutk3b7fwyGD6CTeHdrL8V21Om9Dgfcl8JoXByFIWofZSnQBX
        ozj2LJS96NKtCdz8afjrx/wUcGs6SJLOIqD80Ek=
X-Google-Smtp-Source: ABdhPJxD3ownm0QRPUTIdzTbdbXOwpMfBeLMBr6KR50rbU6Na1GBkHNrcPJdP8qfFu7ITjLBgminJZ9mgxeSBM0f3uI=
X-Received: by 2002:a4a:bb14:: with SMTP id f20mr8743168oop.1.1616093445406;
 Thu, 18 Mar 2021 11:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210224054232.1222-1-zbestahu@gmail.com>
In-Reply-To: <20210224054232.1222-1-zbestahu@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Mar 2021 19:50:34 +0100
Message-ID: <CAJZ5v0jtjrBuJNMVpZDABaEWeBzJ7sWW7Gb=RggDFm1SF7wUHA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Call sugov_update_next_freq() before
 check to fast_switch_enabled
To:     Yue Hu <zbestahu@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, Yue Hu <zbestahu@163.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 24, 2021 at 6:44 AM Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> Note that sugov_update_next_freq() may return false, that means the
> caller sugov_fast_switch() will do nothing except fast switch check.
>
> Similarly, sugov_deferred_update() also has unnecessary operations
> of raw_spin_{lock,unlock} in sugov_update_single_freq() for that case.
>
> So, let's call sugov_update_next_freq() before the fast switch check
> to avoid unnecessary behaviors above. Update the related interface
> definitions accordingly.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 41e498b..d23e5be 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -114,19 +114,13 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>         return true;
>  }
>
> -static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
> -                             unsigned int next_freq)
> +static void sugov_fast_switch(struct sugov_policy *sg_policy, unsigned int next_freq)
>  {
> -       if (sugov_update_next_freq(sg_policy, time, next_freq))
> -               cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
> +       cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
>  }
>
> -static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
> -                                 unsigned int next_freq)
> +static void sugov_deferred_update(struct sugov_policy *sg_policy)
>  {
> -       if (!sugov_update_next_freq(sg_policy, time, next_freq))
> -               return;
> -
>         if (!sg_policy->work_in_progress) {
>                 sg_policy->work_in_progress = true;
>                 irq_work_queue(&sg_policy->irq_work);
> @@ -368,16 +362,19 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
>                 sg_policy->cached_raw_freq = cached_freq;
>         }
>
> +       if (!sugov_update_next_freq(sg_policy, time, next_f))
> +               return;
> +
>         /*
>          * This code runs under rq->lock for the target CPU, so it won't run
>          * concurrently on two different CPUs for the same target and it is not
>          * necessary to acquire the lock in the fast switch case.
>          */
>         if (sg_policy->policy->fast_switch_enabled) {
> -               sugov_fast_switch(sg_policy, time, next_f);
> +               sugov_fast_switch(sg_policy, next_f);
>         } else {
>                 raw_spin_lock(&sg_policy->update_lock);
> -               sugov_deferred_update(sg_policy, time, next_f);
> +               sugov_deferred_update(sg_policy);
>                 raw_spin_unlock(&sg_policy->update_lock);
>         }
>  }
> @@ -456,12 +453,15 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>         if (sugov_should_update_freq(sg_policy, time)) {
>                 next_f = sugov_next_freq_shared(sg_cpu, time);
>
> +               if (!sugov_update_next_freq(sg_policy, time, next_f))
> +                       goto unlock;
> +
>                 if (sg_policy->policy->fast_switch_enabled)
> -                       sugov_fast_switch(sg_policy, time, next_f);
> +                       sugov_fast_switch(sg_policy, next_f);
>                 else
> -                       sugov_deferred_update(sg_policy, time, next_f);
> +                       sugov_deferred_update(sg_policy);
>         }
> -
> +unlock:
>         raw_spin_unlock(&sg_policy->update_lock);
>  }
>
> --

Applied as 5.13 material, thanks!
