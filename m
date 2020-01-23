Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9878146D69
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 16:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgAWPzX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 10:55:23 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39413 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgAWPzW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2020 10:55:22 -0500
Received: by mail-oi1-f193.google.com with SMTP id z2so3331949oih.6;
        Thu, 23 Jan 2020 07:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBQh/ztAv8A8s1fZeCX1HGHosYEq7sMvmqcArko66RE=;
        b=V2b3+WDqvyWMl6ciDwCGVqJVMdb3Fyv1n/+DMMPtyf2szpBoaWAvry9QGnHJvg4XHY
         kzGIxZLikUkdtKVzms0yJLKZNhivgu1qYqbG6BwtZjHcypxVUzIv7hEBIdXZU4IekQEz
         yS5q7MnNx6AWPgnwjknajsCRKIpWd/lbFqSkmVuF/ViJNEIcb3X1k+Ic130gG4aqMnNH
         ZHqfxGfXjrTpHH6AdvAJhwIseC+A6tAr+gQPa9sHviMDhTZ1a0i6PYtHWELDkH31MhrU
         LgX6Zoo1Rz9yNUDlmDQBx9L3ZMYNE5bgsKQzQ4i58vlblFhnXBv8XJNKRUfMmUHYN4PT
         b06A==
X-Gm-Message-State: APjAAAXD8qZmESSs6+9h6O7id7uk5vUPFS9e2sJRAPA51Z9+8e6iWFdw
        v0Pr+NR/7prTJinrB7LbEbRc7HXXlSsFnlM35zs=
X-Google-Smtp-Source: APXvYqxFzmeZQd1iIhJ8L8/r1AhyVuRog/jVaX7vKW9ZL59lDPcDcN8MK+SwDQj95pAxeyXA1cwnL107XIqt4JgBCzo=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr11441686oig.103.1579794921907;
 Thu, 23 Jan 2020 07:55:21 -0800 (PST)
MIME-Version: 1.0
References: <20200122173538.1142069-1-douglas.raillard@arm.com> <20200122173538.1142069-5-douglas.raillard@arm.com>
In-Reply-To: <20200122173538.1142069-5-douglas.raillard@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Jan 2020 16:55:11 +0100
Message-ID: <CAJZ5v0gP5v3LzU-uGyHpoJV8z+E2heR1PEQp+c=L7RZS3FzCWg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/6] sched/cpufreq: Introduce sugov_cpu_ramp_boost
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        qperret@google.com, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 22, 2020 at 6:36 PM Douglas RAILLARD
<douglas.raillard@arm.com> wrote:
>
> Use the utilization signals dynamic to detect when the utilization of a
> set of tasks starts increasing because of a change in tasks' behavior.
> This allows detecting when spending extra power for faster frequency
> ramp up response would be beneficial to the reactivity of the system.
>
> This ramp boost is computed as the difference between util_avg and
> util_est_enqueued. This number somehow represents a lower bound of how
> much extra utilization this tasks is actually using, compared to our
> best current stable knowledge of it (which is util_est_enqueued).
>
> When the set of runnable tasks changes, the boost is disabled as the
> impact of blocked utilization on util_avg will make the delta with
> util_est_enqueued not very informative.
>
> Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 43 ++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 608963da4916..25a410a1ff6a 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -61,6 +61,10 @@ struct sugov_cpu {
>         unsigned long           bw_dl;
>         unsigned long           max;
>
> +       unsigned long           ramp_boost;
> +       unsigned long           util_est_enqueued;
> +       unsigned long           util_avg;
> +
>         /* The field below is for single-CPU policies only: */
>  #ifdef CONFIG_NO_HZ_COMMON
>         unsigned long           saved_idle_calls;
> @@ -183,6 +187,42 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
>         }
>  }
>
> +static unsigned long sugov_cpu_ramp_boost(struct sugov_cpu *sg_cpu)
> +{
> +       return READ_ONCE(sg_cpu->ramp_boost);
> +}

Where exactly is this function used?

> +
> +static unsigned long sugov_cpu_ramp_boost_update(struct sugov_cpu *sg_cpu)
> +{
> +       struct rq *rq = cpu_rq(sg_cpu->cpu);
> +       unsigned long util_est_enqueued;
> +       unsigned long util_avg;
> +       unsigned long boost = 0;
> +
> +       util_est_enqueued = READ_ONCE(rq->cfs.avg.util_est.enqueued);
> +       util_avg = READ_ONCE(rq->cfs.avg.util_avg);
> +
> +       /*
> +        * Boost when util_avg becomes higher than the previous stable
> +        * knowledge of the enqueued tasks' set util, which is CPU's
> +        * util_est_enqueued.
> +        *
> +        * We try to spot changes in the workload itself, so we want to
> +        * avoid the noise of tasks being enqueued/dequeued. To do that,
> +        * we only trigger boosting when the "amount of work" enqueued
> +        * is stable.
> +        */
> +       if (util_est_enqueued == sg_cpu->util_est_enqueued &&
> +           util_avg >= sg_cpu->util_avg &&
> +           util_avg > util_est_enqueued)
> +               boost = util_avg - util_est_enqueued;
> +
> +       sg_cpu->util_est_enqueued = util_est_enqueued;
> +       sg_cpu->util_avg = util_avg;
> +       WRITE_ONCE(sg_cpu->ramp_boost, boost);
> +       return boost;
> +}
> +
>  /**
>   * get_next_freq - Compute a new frequency for a given cpufreq policy.
>   * @sg_policy: schedutil policy object to compute the new frequency for.
> @@ -514,6 +554,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>         busy = !sg_policy->need_freq_update && sugov_cpu_is_busy(sg_cpu);
>
>         util = sugov_get_util(sg_cpu);
> +       sugov_cpu_ramp_boost_update(sg_cpu);
>         max = sg_cpu->max;
>         util = sugov_iowait_apply(sg_cpu, time, util, max);
>         next_f = get_next_freq(sg_policy, util, max);
> @@ -554,6 +595,8 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>                 unsigned long j_util, j_max;
>
>                 j_util = sugov_get_util(j_sg_cpu);
> +               if (j_sg_cpu == sg_cpu)
> +                       sugov_cpu_ramp_boost_update(sg_cpu);
>                 j_max = j_sg_cpu->max;
>                 j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);
>
> --
