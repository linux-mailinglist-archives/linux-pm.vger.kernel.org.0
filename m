Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413132B6AF2
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 18:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgKQQ7z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 11:59:55 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38043 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgKQQ7y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2020 11:59:54 -0500
Received: by mail-oi1-f194.google.com with SMTP id o25so23329137oie.5;
        Tue, 17 Nov 2020 08:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sb3ebKnvqbWb9P6RANvx9VkhKnNgpXL+s67E5/WsuIo=;
        b=uHJJ4bxqOtT4l0mKq3hG5iTWHEaAp0CPj36O8fiqImTwzVqXlsrI/CZjc5UdTqplcV
         PvFxeGUQu4zuIvtlb6ImsUGVWOca1kZIKl7rePmz4b2nxzmB/Rj00PISE0af9S/lPOh0
         2qxdKb00ax33YIvZjDJhsfc6fhMG4ByHWRBH9cJYShA4rJMQ1vyFbMsxizfhGW6F3Ts0
         sWwJveZ+s3oo5pym3gEajvGcjUOEoCz9dF1Kvn8wx4qq6yhUTkhNhe8o/QdYAhTk7R/y
         Suc+utX7ZnNU8r4usIGBP58027Dcyx/2bXtmtKy3s/+Ln2HoDno51/hHhDMdP+Y+0MEc
         DFyQ==
X-Gm-Message-State: AOAM533S5dUpnaSu0iGx0iXapXJsDsiU7bCklKiI0/F6nhQfEPR4tuxZ
        0KBw7LWqscn1JApFfcPb2BuUFPIAjHzq+zfDWbw=
X-Google-Smtp-Source: ABdhPJyiDy++olmem/k2N3oiypZ96XNV13PBBOT4OACdtIjSyHsu7cPwAmAkYb4wQk9VILXWTkXA70QqCr1Vo4GgudY=
X-Received: by 2002:aca:cf4b:: with SMTP id f72mr3037726oig.157.1605632393546;
 Tue, 17 Nov 2020 08:59:53 -0800 (PST)
MIME-Version: 1.0
References: <d6d9193249832c54fdd29656558f48914a4015dd.1605612661.git.viresh.kumar@linaro.org>
In-Reply-To: <d6d9193249832c54fdd29656558f48914a4015dd.1605612661.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Nov 2020 17:59:42 +0100
Message-ID: <CAJZ5v0hBdsEW6bnCP1kH+8F_st98bN=8y7+Zp166DEqdUJG8eg@mail.gmail.com>
Subject: Re: [PATCH V2] cpufreq: stats: Use local_clock() instead of jiffies
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 17, 2020 at 12:32 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> local_clock() has better precision and accuracy as compared to jiffies,
> lets use it for time management in cpufreq stats.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2:
> - Doesn't change the units to msec and use local_clock() instead of
>   ktime.
>
>  drivers/cpufreq/cpufreq_stats.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 6cd5c8ab5d49..da717f7cd9a9 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -9,9 +9,9 @@
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/module.h>
> +#include <linux/sched/clock.h>
>  #include <linux/slab.h>
>
> -
>  struct cpufreq_stats {
>         unsigned int total_trans;
>         unsigned long long last_time;
> @@ -30,7 +30,7 @@ struct cpufreq_stats {
>  static void cpufreq_stats_update(struct cpufreq_stats *stats,
>                                  unsigned long long time)
>  {
> -       unsigned long long cur_time = get_jiffies_64();
> +       unsigned long long cur_time = local_clock();
>
>         stats->time_in_state[stats->last_index] += cur_time - time;
>         stats->last_time = cur_time;
> @@ -42,7 +42,7 @@ static void cpufreq_stats_reset_table(struct cpufreq_stats *stats)
>
>         memset(stats->time_in_state, 0, count * sizeof(u64));
>         memset(stats->trans_table, 0, count * count * sizeof(int));
> -       stats->last_time = get_jiffies_64();
> +       stats->last_time = local_clock();
>         stats->total_trans = 0;
>
>         /* Adjust for the time elapsed since reset was requested */
> @@ -82,18 +82,18 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>                                  * before the reset_pending read above.
>                                  */
>                                 smp_rmb();
> -                               time = get_jiffies_64() - READ_ONCE(stats->reset_time);
> +                               time = local_clock() - READ_ONCE(stats->reset_time);
>                         } else {
>                                 time = 0;
>                         }
>                 } else {
>                         time = stats->time_in_state[i];
>                         if (i == stats->last_index)
> -                               time += get_jiffies_64() - stats->last_time;
> +                               time += local_clock() - stats->last_time;
>                 }
>
>                 len += sprintf(buf + len, "%u %llu\n", stats->freq_table[i],
> -                              jiffies_64_to_clock_t(time));
> +                              nsec_to_clock_t(time));
>         }
>         return len;
>  }
> @@ -109,7 +109,7 @@ static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
>          * Defer resetting of stats to cpufreq_stats_record_transition() to
>          * avoid races.
>          */
> -       WRITE_ONCE(stats->reset_time, get_jiffies_64());
> +       WRITE_ONCE(stats->reset_time, local_clock());
>         /*
>          * The memory barrier below is to prevent the readers of reset_time from
>          * seeing a stale or partially updated value.
> @@ -249,7 +249,7 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
>                         stats->freq_table[i++] = pos->frequency;
>
>         stats->state_num = i;
> -       stats->last_time = get_jiffies_64();
> +       stats->last_time = local_clock();
>         stats->last_index = freq_table_get_index(stats, policy->cur);
>
>         policy->stats = stats;
> --

Applied as 5.11 material, thanks!
