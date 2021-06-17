Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80D53AAB69
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 07:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhFQFyR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 01:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhFQFyQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 01:54:16 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7950C06175F
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 22:52:08 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id s26so1806111ioe.9
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 22:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y9YmWN3ejD6pzrKoHrGIGgPWXjNjdQmoDeyA5xdpeqg=;
        b=VYYZNfUAEN4up+T8rpc1B8UTWV40no6kfeKPYa+91bCqaV5AUFvU9flGhqB1k6fH8X
         ZIdyD7A1mkLusc9Pg7+8g+5nWwUo4wmJNCEnz45bXnhadNdKWLOTUb2Wond6MTfihYxL
         B94NqB2ncpYHeNeC3UMsQA3tBFVvq4ujLHbnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9YmWN3ejD6pzrKoHrGIGgPWXjNjdQmoDeyA5xdpeqg=;
        b=nh/tOS54A1dqzD7nozr4clN7GBqhU9EuOPKNZ5ngGSOulH3glvOe7g62ThkKnNreVX
         sd4Ab9pZWu2DD0cWP0mKhtbTMq9zzFJfdvgBsKFkYJxmPBtty9zycXNUJMy8LI3yhq0P
         69IpJQoubnne9fIqi8Q4vScmc1huCFNk+IUPpmTel8QYuXtDwEf2idZsZ83bCuGziXVd
         SEXKmKiU4BqX0jsUiKBVfvIZkPSpO1WPxQ7EkPBYcX7cMyjy50ZLuK9rXlAiAlvA8S/M
         8QGdZNXq6JXzwJfdcBTGrBXPn2RI7rSfCttB25L0OrV/k3eVqWXpYVZzEqDoeJy1QiR9
         fnWw==
X-Gm-Message-State: AOAM530hnxBCLNo6LzlG0W015izaXKTezkcEQLOeZj8bw2zAY+i4CJF7
        9GmQPAg8f4MAZqdPOnzjilZ0lSyg+CcYz/V0F787Sw==
X-Google-Smtp-Source: ABdhPJyKdwJp1iKRU0kd1q/h5cD5jJ+B+Cs2ATYKqCYu6eaoiXdDwlEt05pQeDH6nP71lPpzwUXdApEd091giIm5SDw=
X-Received: by 2002:a02:9f97:: with SMTP id a23mr2968525jam.114.1623909128110;
 Wed, 16 Jun 2021 22:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210617054647epcas1p431edaffea5bf7f3792b55dc3d91289ae@epcas1p4.samsung.com>
 <20210617060546.26933-1-cw00.choi@samsung.com> <20210617060546.26933-4-cw00.choi@samsung.com>
In-Reply-To: <20210617060546.26933-4-cw00.choi@samsung.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 17 Jun 2021 13:51:42 +0800
Message-ID: <CAJMQK-i+VnmNybe+0fKJJkEb5gmKyo59pvAoKvH5det1fJ0UBQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] PM / devfreq: Add cpu based scaling support to
 passive governor
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>, chanwoo@kernel.org,
        cwchoi00@gmail.com, Linux PM <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Saravana Kannan <skannan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 17, 2021 at 1:46 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> From: Saravana Kannan <skannan@codeaurora.org>
>
> Many CPU architectures have caches that can scale independent of the
> CPUs. Frequency scaling of the caches is necessary to make sure that the
> cache is not a performance bottleneck that leads to poor performance and
> power. The same idea applies for RAM/DDR.
>
> To achieve this, this patch adds support for cpu based scaling to the
> passive governor. This is accomplished by taking the current frequency
> of each CPU frequency domain and then adjust the frequency of the cache
> (or any devfreq device) based on the frequency of the CPUs. It listens
> to CPU frequency transition notifiers to keep itself up to date on the
> current CPU frequency.
>
> To decide the frequency of the device, the governor does one of the
> following:
> * Derives the optimal devfreq device opp from required-opps property of
>   the parent cpu opp_table.
>
> * Scales the device frequency in proportion to the CPU frequency. So, if
>   the CPUs are running at their max frequency, the device runs at its
>   max frequency. If the CPUs are running at their min frequency, the
>   device runs at its min frequency. It is interpolated for frequencies
>   in between.
>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> [Sibi: Integrated cpu-freqmap governor into passive_governor]
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> [Chanwoo: Fix conflict with latest code and clean code up]
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/governor.h         |  22 +++
>  drivers/devfreq/governor_passive.c | 264 ++++++++++++++++++++++++++++-
>  include/linux/devfreq.h            |  16 +-
>  3 files changed, 293 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index 9a9495f94ac6..3c36c92c89a9 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -47,6 +47,28 @@
>  #define DEVFREQ_GOV_ATTR_POLLING_INTERVAL              BIT(0)
>  #define DEVFREQ_GOV_ATTR_TIMER                         BIT(1)
>
> +/**
> + * struct devfreq_cpu_data - Hold the per-cpu data
> + * @dev:       reference to cpu device.
> + * @first_cpu: the cpumask of the first cpu of a policy.
> + * @opp_table: reference to cpu opp table.
> + * @cur_freq:  the current frequency of the cpu.
> + * @min_freq:  the min frequency of the cpu.
> + * @max_freq:  the max frequency of the cpu.
> + *
> + * This structure stores the required cpu_data of a cpu.
> + * This is auto-populated by the governor.
> + */
> +struct devfreq_cpu_data {
> +       struct device *dev;
> +       unsigned int first_cpu;
> +
> +       struct opp_table *opp_table;
> +       unsigned int cur_freq;
> +       unsigned int min_freq;
> +       unsigned int max_freq;
> +};
> +
>  /**
>   * struct devfreq_governor - Devfreq policy governor
>   * @node:              list node - contains registered devfreq governors
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index fc09324a03e0..07e864509b7e 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -8,11 +8,84 @@
>   */
>
>  #include <linux/module.h>
> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/cpumask.h>
> +#include <linux/slab.h>
>  #include <linux/device.h>
>  #include <linux/devfreq.h>
>  #include "governor.h"
>
> -static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
> +#define HZ_PER_KHZ     1000
> +
> +static unsigned long get_taget_freq_by_required_opp(struct device *p_dev,
> +                                               struct opp_table *p_opp_table,
> +                                               struct opp_table *opp_table,
> +                                               unsigned long freq)
> +{
> +       struct dev_pm_opp *opp = NULL, *p_opp = NULL;
> +
> +       if (!p_dev || !p_opp_table || !opp_table || !freq)
> +               return 0;
> +
> +       p_opp = devfreq_recommended_opp(p_dev, &freq, 0);
> +       if (IS_ERR(p_opp))
> +               return 0;
> +
> +       opp = dev_pm_opp_xlate_required_opp(p_opp_table, opp_table, p_opp);
> +       dev_pm_opp_put(p_opp);
> +
> +       if (IS_ERR(opp))
> +               return 0;
> +
> +       freq = dev_pm_opp_get_freq(opp);
> +       dev_pm_opp_put(opp);
> +
> +       return freq;
> +}
> +
> +static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
> +                                       unsigned long *target_freq)
> +{
> +       struct devfreq_passive_data *p_data =
> +                               (struct devfreq_passive_data *)devfreq->data;
> +       struct devfreq_cpu_data *cpu_data;
We might have to rename the cpu_data variable.

For some architectures, cpu_data is defined as macro. This results in
errors such as

include/linux/devfreq.h:331:27: note: in expansion of macro 'cpu_data'
     331 |  struct devfreq_cpu_data *cpu_data[NR_CPUS];
         |                           ^~~~~~~~
   In file included from include/linux/devfreq_cooling.h:13,
                    from drivers/devfreq/devfreq.c:14:
   include/linux/devfreq.h:332:1: warning: no semicolon at end of
struct or union

> +       unsigned long cpu, cpu_cur, cpu_min, cpu_max, cpu_percent;
> +       unsigned long dev_min, dev_max;
> +       unsigned long freq = 0;
> +
> +       for_each_online_cpu(cpu) {
> +               cpu_data = p_data->cpu_data[cpu];
> +               if (!cpu_data || cpu_data->first_cpu != cpu)
> +                       continue;
> +
> +               /* Get target freq via required opps */
> +               cpu_cur = cpu_data->cur_freq * HZ_PER_KHZ;
> +               freq = get_taget_freq_by_required_opp(cpu_data->dev,
> +                                       cpu_data->opp_table,
> +                                       devfreq->opp_table, cpu_cur);
> +               if (freq) {
> +                       *target_freq = max(freq, *target_freq);
> +                       continue;
> +               }
> +
> +               /* Use Interpolation if required opps is not available */
> +               devfreq_get_freq_range(devfreq, &dev_min, &dev_max);
> +
> +               cpu_min = cpu_data->min_freq;
> +               cpu_max = cpu_data->max_freq;
> +               cpu_cur = cpu_data->cur_freq;
> +
> +               cpu_percent = ((cpu_cur - cpu_min) * 100) / (cpu_max - cpu_min);
> +               freq = dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
> +
> +               *target_freq = max(freq, *target_freq);
> +       }
> +
> +       return 0;
> +}
> +
> +static int get_target_freq_with_devfreq(struct devfreq *devfreq,
>                                         unsigned long *freq)
>  {
>         struct devfreq_passive_data *p_data
> @@ -99,6 +172,172 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>         return 0;
>  }
>
> +static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
> +                                          unsigned long *freq)
> +{
> +       struct devfreq_passive_data *p_data =
> +                               (struct devfreq_passive_data *)devfreq->data;
> +       int ret;
> +
> +       if (!p_data)
> +               return -EINVAL;
> +
> +       /*
> +        * If the devfreq device with passive governor has the specific method
> +        * to determine the next frequency, should use the get_target_freq()
> +        * of struct devfreq_passive_data.
> +        */
> +       if (p_data->get_target_freq)
> +               return p_data->get_target_freq(devfreq, freq);
> +
> +       switch (p_data->parent_type) {
> +       case DEVFREQ_PARENT_DEV:
> +               ret = get_target_freq_with_devfreq(devfreq, freq);
> +               break;
> +       case CPUFREQ_PARENT_DEV:
> +               ret = get_target_freq_with_cpufreq(devfreq, freq);
> +               break;
> +       default:
> +               ret = -EINVAL;
> +               dev_err(&devfreq->dev, "Invalid parent type\n");
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int cpufreq_passive_notifier_call(struct notifier_block *nb,
> +                                        unsigned long event, void *ptr)
> +{
> +       struct devfreq_passive_data *data =
> +                       container_of(nb, struct devfreq_passive_data, nb);
> +       struct devfreq *devfreq = (struct devfreq *)data->this;
> +       struct devfreq_cpu_data *cpu_data;
> +       struct cpufreq_freqs *freqs = ptr;
> +       unsigned int cur_freq;
> +       int ret;
> +
> +       if (event != CPUFREQ_POSTCHANGE || !freqs ||
> +               !data->cpu_data[freqs->policy->cpu])
> +               return 0;
> +
> +       cpu_data = data->cpu_data[freqs->policy->cpu];
> +       if (cpu_data->cur_freq == freqs->new)
> +               return 0;
> +
> +       cur_freq = cpu_data->cur_freq;
> +       cpu_data->cur_freq = freqs->new;
> +
> +       mutex_lock(&devfreq->lock);
> +       ret = devfreq_update_target(devfreq, freqs->new);
> +       mutex_unlock(&devfreq->lock);
> +       if (ret) {
> +               cpu_data->cur_freq = cur_freq;
> +               dev_err(&devfreq->dev, "failed to update the frequency.\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
> +{
> +       struct devfreq_passive_data *p_data
> +                       = (struct devfreq_passive_data *)devfreq->data;
> +       struct device *dev = devfreq->dev.parent;
> +       struct opp_table *opp_table = NULL;
> +       struct devfreq_cpu_data *cpu_data;
> +       struct cpufreq_policy *policy;
> +       struct device *cpu_dev;
> +       unsigned int cpu;
> +       int ret;
> +
> +       get_online_cpus();
> +
> +       p_data->nb.notifier_call = cpufreq_passive_notifier_call;
> +       ret = cpufreq_register_notifier(&p_data->nb, CPUFREQ_TRANSITION_NOTIFIER);
> +       if (ret) {
> +               dev_err(dev, "failed to register cpufreq notifier\n");
> +               p_data->nb.notifier_call = NULL;
> +               goto out;
> +       }
> +
> +       for_each_online_cpu(cpu) {
> +               if (p_data->cpu_data[cpu])
> +                       continue;
> +
> +               policy = cpufreq_cpu_get(cpu);
> +               if (policy) {
> +                       cpu_data = kzalloc(sizeof(*cpu_data), GFP_KERNEL);
> +                       if (!cpu_data) {
> +                               ret = -ENOMEM;
> +                               goto out;
> +                       }
> +
> +                       cpu_dev = get_cpu_device(cpu);
> +                       if (!cpu_dev) {
> +                               dev_err(dev, "failed to get cpu device\n");
> +                               ret = -ENODEV;
> +                               goto out;
> +                       }
> +
> +                       opp_table = dev_pm_opp_get_opp_table(cpu_dev);
> +                       if (IS_ERR(opp_table)) {
> +                               ret = PTR_ERR(opp_table);
> +                               goto out;
> +                       }
> +
> +                       cpu_data->dev = cpu_dev;
> +                       cpu_data->opp_table = opp_table;
> +                       cpu_data->first_cpu = cpumask_first(policy->related_cpus);
> +                       cpu_data->cur_freq = policy->cur;
> +                       cpu_data->min_freq = policy->cpuinfo.min_freq;
> +                       cpu_data->max_freq = policy->cpuinfo.max_freq;
> +
> +                       p_data->cpu_data[cpu] = cpu_data;
> +                       cpufreq_cpu_put(policy);
> +               } else {
> +                       ret = -EPROBE_DEFER;
> +                       goto out;
> +               }
> +       }
> +out:
> +       put_online_cpus();
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&devfreq->lock);
> +       ret = devfreq_update_target(devfreq, 0L);
> +       mutex_unlock(&devfreq->lock);
> +       if (ret)
> +               dev_err(dev, "failed to update the frequency\n");
> +
> +       return ret;
> +}
> +
> +static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
> +{
> +       struct devfreq_passive_data *p_data
> +                       = (struct devfreq_passive_data *)devfreq->data;
> +       struct devfreq_cpu_data *cpu_data;
> +       int cpu;
> +
> +       if (p_data->nb.notifier_call)
> +               cpufreq_unregister_notifier(&p_data->nb, CPUFREQ_TRANSITION_NOTIFIER);
> +
> +       for_each_possible_cpu(cpu) {
> +               cpu_data = p_data->cpu_data[cpu];
> +               if (cpu_data) {
> +                       if (cpu_data->opp_table)
> +                               dev_pm_opp_put_opp_table(cpu_data->opp_table);
> +                       kfree(cpu_data);
> +                       cpu_data = NULL;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int devfreq_passive_notifier_call(struct notifier_block *nb,
>                                 unsigned long event, void *ptr)
>  {
> @@ -140,7 +379,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>         struct notifier_block *nb = &p_data->nb;
>         int ret = 0;
>
> -       if (!parent)
> +       if (p_data->parent_type == DEVFREQ_PARENT_DEV && !parent)
>                 return -EPROBE_DEFER;
>
>         switch (event) {
> @@ -148,13 +387,24 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>                 if (!p_data->this)
>                         p_data->this = devfreq;
>
> -               nb->notifier_call = devfreq_passive_notifier_call;
> -               ret = devfreq_register_notifier(parent, nb,
> -                                       DEVFREQ_TRANSITION_NOTIFIER);
> +               if (p_data->parent_type == DEVFREQ_PARENT_DEV) {
> +                       nb->notifier_call = devfreq_passive_notifier_call;
> +                       ret = devfreq_register_notifier(parent, nb,
> +                                               DEVFREQ_TRANSITION_NOTIFIER);
> +               } else if (p_data->parent_type == CPUFREQ_PARENT_DEV) {
> +                       ret = cpufreq_passive_register_notifier(devfreq);
> +               } else {
> +                       ret = -EINVAL;
> +               }
>                 break;
>         case DEVFREQ_GOV_STOP:
> -               WARN_ON(devfreq_unregister_notifier(parent, nb,
> -                                       DEVFREQ_TRANSITION_NOTIFIER));
> +               if (p_data->parent_type == DEVFREQ_PARENT_DEV)
> +                       WARN_ON(devfreq_unregister_notifier(parent, nb,
> +                                               DEVFREQ_TRANSITION_NOTIFIER));
> +               else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
> +                       WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
> +               else
> +                       ret = -EINVAL;
>                 break;
>         default:
>                 break;
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 142474b4af96..cfa0ef54841e 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -38,6 +38,7 @@ enum devfreq_timer {
>
>  struct devfreq;
>  struct devfreq_governor;
> +struct devfreq_cpu_data;
>  struct thermal_cooling_device;
>
>  /**
> @@ -288,6 +289,11 @@ struct devfreq_simple_ondemand_data {
>  #endif
>
>  #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
> +enum devfreq_parent_dev_type {
> +       DEVFREQ_PARENT_DEV,
> +       CPUFREQ_PARENT_DEV,
> +};
> +
>  /**
>   * struct devfreq_passive_data - ``void *data`` fed to struct devfreq
>   *     and devfreq_add_device
> @@ -299,8 +305,10 @@ struct devfreq_simple_ondemand_data {
>   *                     using governors except for passive governor.
>   *                     If the devfreq device has the specific method to decide
>   *                     the next frequency, should use this callback.
> - * @this:      the devfreq instance of own device.
> - * @nb:                the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
> + + * @parent_type      parent type of the device
> + + * @this:            the devfreq instance of own device.
> + + * @nb:              the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
> + + * @cpu_data:                the state min/max/current frequency of all online cpu's
>   *
>   * The devfreq_passive_data have to set the devfreq instance of parent
>   * device with governors except for the passive governor. But, don't need to
> @@ -314,9 +322,13 @@ struct devfreq_passive_data {
>         /* Optional callback to decide the next frequency of passvice device */
>         int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
>
> +       /* Should set the type of parent device */
> +       enum devfreq_parent_dev_type parent_type;
> +
>         /* For passive governor's internal use. Don't need to set them */
>         struct devfreq *this;
>         struct notifier_block nb;
> +       struct devfreq_cpu_data *cpu_data[NR_CPUS];
>  };
>  #endif
>
> --
> 2.17.1
>
