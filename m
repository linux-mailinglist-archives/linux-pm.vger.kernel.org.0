Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69B5947E44
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 11:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfFQJYR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 05:24:17 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35667 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbfFQJYQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 05:24:16 -0400
Received: by mail-ua1-f67.google.com with SMTP id r7so3238365ual.2
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2019 02:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PRt2ai/Er3hzcX9UtTXNSan44NF3l9STORNotelgDcA=;
        b=ELFaR6VFUuKRYF35FZKZeQ34VdhzRo/bilEbTsRafKA3FYI6xk4YKo4WZIeQKGTgPu
         aiUKa4cYRMYJVhOWFXWKausxylRLWnoy0gSl+RPyAJyJXHdb2t4/hBS/euVc5AqZ80XU
         x1q7/3ljinMis6g1AMzbk4nj26VKkdyVMASCD3QKYbXjuqkSkwe8w2wIYbeZ59Wa+8D4
         IKAJeEfBKMvBqiJrqynl909zoJBNHjxuyOCg6Q5oiSVwL2QmODD/UycczJkZ/IJhlog6
         jwnZrXl2PK+d1s2d4SkxYLkcHtyzD/+9+scmBTc9271eq/AUtu4UNmqTKBTsmCwaFKM2
         J/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PRt2ai/Er3hzcX9UtTXNSan44NF3l9STORNotelgDcA=;
        b=RMpPCtWe9rQUnh/DZjHLVRZEBoVabnVP83YHRgLSCzly5CBJ8heKN296pqSZ3da+zL
         gshfcneO55LzTm/W4ePciNdwZyV9IpN+VzPIxQw7E8D+ueu9LwK5WzKoJwvT2TPzqwxK
         whM2lW/CkKs7rv/vCqAaqdYJf2JZCP3mix0GdTFs2pSQPgN61OKHfQBP6cBwfiMGVArm
         1GueQPpsXf4duJecltZNHDhb8NxjNhHYKn+3okmYDKIb8Egh26f6V+p7fECMxDIQMD3u
         AHB/33PN0GQTFV2vs0N/IkwcorC58b9+FtXP7PumNyP5EiC/IGcjitfEXEqeC2cZr03B
         29OA==
X-Gm-Message-State: APjAAAWTxoopzMQb3ZUusijgCbv42d8Q7H0lA5qTpebHSwgZcYPC2PSE
        zffhNUfFKarNSkwWUAmo7xZOAP6DyIDivQZPnQ+X2w==
X-Google-Smtp-Source: APXvYqyUC6IFvM+3X1n6Rnzikth4YkSC4rV+YZpwk2BI9ElKwttYKxk+Cc0bkn+D6AkxemJzbZCSUVM4JtM6bJoJ1+Q=
X-Received: by 2002:ab0:4108:: with SMTP id j8mr1410903uad.104.1560763455124;
 Mon, 17 Jun 2019 02:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560163748.git.viresh.kumar@linaro.org> <a275fdd9325f1b2cba046c79930ad59653674455.1560163748.git.viresh.kumar@linaro.org>
In-Reply-To: <a275fdd9325f1b2cba046c79930ad59653674455.1560163748.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Jun 2019 11:23:38 +0200
Message-ID: <CAPDyKFra=9y58dzicL0PkwwMNWZDXaJB1+YX_ujOBeP6hrBLcA@mail.gmail.com>
Subject: Re: [PATCH V3 4/5] cpufreq: Register notifiers with the PM QoS framework
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, Matthias Kaehlcke <mka@chromium.org>,
        juri.lelli@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 10 Jun 2019 at 12:52, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This registers the notifiers for min/max frequency constraints with the
> PM QoS framework. The constraints are also taken into consideration in
> cpufreq_set_policy().
>
> This also relocates cpufreq_policy_put_kobj() as it is required to be
> called from cpufreq_policy_alloc() now.
>
> No constraints are added until now though.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/cpufreq/cpufreq.c | 139 +++++++++++++++++++++++++++++++-------
>  include/linux/cpufreq.h   |   4 ++
>  2 files changed, 120 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 85ff958e01f1..547d221b2ff2 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -26,6 +26,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/pm_qos.h>
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
>  #include <linux/syscore_ops.h>
> @@ -1126,11 +1127,77 @@ static void handle_update(struct work_struct *work)
>         cpufreq_update_policy(cpu);
>  }
>
> +static void cpufreq_update_freq_work(struct work_struct *work)
> +{
> +       struct cpufreq_policy *policy =
> +               container_of(work, struct cpufreq_policy, req_work);
> +       struct cpufreq_policy new_policy = *policy;
> +
> +       /* We should read constraint values from QoS layer */
> +       new_policy.min = 0;
> +       new_policy.max = UINT_MAX;
> +
> +       down_write(&policy->rwsem);
> +
> +       if (!policy_is_inactive(policy))
> +               cpufreq_set_policy(policy, &new_policy);
> +
> +       up_write(&policy->rwsem);
> +}
> +
> +static int cpufreq_update_freq(struct cpufreq_policy *policy)
> +{
> +       schedule_work(&policy->req_work);
> +       return 0;
> +}
> +
> +static int cpufreq_notifier_min(struct notifier_block *nb, unsigned long freq,
> +                               void *data)
> +{
> +       struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_min);
> +
> +       return cpufreq_update_freq(policy);
> +}
> +
> +static int cpufreq_notifier_max(struct notifier_block *nb, unsigned long freq,
> +                               void *data)
> +{
> +       struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_max);
> +
> +       return cpufreq_update_freq(policy);
> +}
> +
> +static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
> +{
> +       struct kobject *kobj;
> +       struct completion *cmp;
> +
> +       down_write(&policy->rwsem);
> +       cpufreq_stats_free_table(policy);
> +       kobj = &policy->kobj;
> +       cmp = &policy->kobj_unregister;
> +       up_write(&policy->rwsem);
> +       kobject_put(kobj);
> +
> +       /*
> +        * We need to make sure that the underlying kobj is
> +        * actually not referenced anymore by anybody before we
> +        * proceed with unloading.
> +        */
> +       pr_debug("waiting for dropping of refcount\n");
> +       wait_for_completion(cmp);
> +       pr_debug("wait complete\n");
> +}
> +
>  static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>  {
>         struct cpufreq_policy *policy;
> +       struct device *dev = get_cpu_device(cpu);
>         int ret;
>
> +       if (!dev)
> +               return NULL;
> +
>         policy = kzalloc(sizeof(*policy), GFP_KERNEL);
>         if (!policy)
>                 return NULL;
> @@ -1147,7 +1214,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>         ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
>                                    cpufreq_global_kobject, "policy%u", cpu);
>         if (ret) {
> -               pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
> +               dev_err(dev, "%s: failed to init policy->kobj: %d\n", __func__, ret);
>                 /*
>                  * The entire policy object will be freed below, but the extra
>                  * memory allocated for the kobject name needs to be freed by
> @@ -1157,16 +1224,41 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>                 goto err_free_real_cpus;
>         }
>
> +       policy->nb_min.notifier_call = cpufreq_notifier_min;
> +       policy->nb_max.notifier_call = cpufreq_notifier_max;
> +
> +       ret = dev_pm_qos_add_notifier(dev, &policy->nb_min,
> +                                     DEV_PM_QOS_MIN_FREQUENCY);
> +       if (ret) {
> +               dev_err(dev, "Failed to register MIN QoS notifier: %d (%*pbl)\n",
> +                       ret, cpumask_pr_args(policy->cpus));
> +               goto err_kobj_remove;
> +       }
> +
> +       ret = dev_pm_qos_add_notifier(dev, &policy->nb_max,
> +                                     DEV_PM_QOS_MAX_FREQUENCY);
> +       if (ret) {
> +               dev_err(dev, "Failed to register MAX QoS notifier: %d (%*pbl)\n",
> +                       ret, cpumask_pr_args(policy->cpus));
> +               goto err_min_qos_notifier;
> +       }
> +
>         INIT_LIST_HEAD(&policy->policy_list);
>         init_rwsem(&policy->rwsem);
>         spin_lock_init(&policy->transition_lock);
>         init_waitqueue_head(&policy->transition_wait);
>         init_completion(&policy->kobj_unregister);
>         INIT_WORK(&policy->update, handle_update);
> +       INIT_WORK(&policy->req_work, cpufreq_update_freq_work);
>
>         policy->cpu = cpu;
>         return policy;
>
> +err_min_qos_notifier:
> +       dev_pm_qos_remove_notifier(dev, &policy->nb_min,
> +                                  DEV_PM_QOS_MIN_FREQUENCY);
> +err_kobj_remove:
> +       cpufreq_policy_put_kobj(policy);
>  err_free_real_cpus:
>         free_cpumask_var(policy->real_cpus);
>  err_free_rcpumask:
> @@ -1179,30 +1271,9 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>         return NULL;
>  }
>
> -static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
> -{
> -       struct kobject *kobj;
> -       struct completion *cmp;
> -
> -       down_write(&policy->rwsem);
> -       cpufreq_stats_free_table(policy);
> -       kobj = &policy->kobj;
> -       cmp = &policy->kobj_unregister;
> -       up_write(&policy->rwsem);
> -       kobject_put(kobj);
> -
> -       /*
> -        * We need to make sure that the underlying kobj is
> -        * actually not referenced anymore by anybody before we
> -        * proceed with unloading.
> -        */
> -       pr_debug("waiting for dropping of refcount\n");
> -       wait_for_completion(cmp);
> -       pr_debug("wait complete\n");
> -}
> -
>  static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  {
> +       struct device *dev = get_cpu_device(policy->cpu);
>         unsigned long flags;
>         int cpu;
>
> @@ -1214,6 +1285,10 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>                 per_cpu(cpufreq_cpu_data, cpu) = NULL;
>         write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>
> +       dev_pm_qos_remove_notifier(dev, &policy->nb_max,
> +                                  DEV_PM_QOS_MAX_FREQUENCY);
> +       dev_pm_qos_remove_notifier(dev, &policy->nb_min,
> +                                  DEV_PM_QOS_MIN_FREQUENCY);
>         cpufreq_policy_put_kobj(policy);
>         free_cpumask_var(policy->real_cpus);
>         free_cpumask_var(policy->related_cpus);
> @@ -2290,6 +2365,8 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
>                        struct cpufreq_policy *new_policy)
>  {
>         struct cpufreq_governor *old_gov;
> +       struct device *cpu_dev = get_cpu_device(policy->cpu);
> +       unsigned long min, max;
>         int ret;
>
>         pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
> @@ -2304,11 +2381,27 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
>         if (new_policy->min > new_policy->max)
>                 return -EINVAL;
>
> +       /*
> +        * PM QoS framework collects all the requests from users and provide us
> +        * the final aggregated value here.
> +        */
> +       min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
> +       max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
> +
> +       if (min > new_policy->min)
> +               new_policy->min = min;
> +       if (max < new_policy->max)
> +               new_policy->max = max;
> +
>         /* verify the cpu speed can be set within this limit */
>         ret = cpufreq_driver->verify(new_policy);
>         if (ret)
>                 return ret;
>
> +       /*
> +        * The notifier-chain shall be removed once all the users of
> +        * CPUFREQ_ADJUST are moved to use the QoS framework.
> +        */
>         /* adjust if necessary - all reasons */
>         blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>                         CPUFREQ_ADJUST, new_policy);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d01a74fbc4db..0fe7678da9c2 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -83,6 +83,7 @@ struct cpufreq_policy {
>
>         struct work_struct      update; /* if update_policy() needs to be
>                                          * called, but you're in IRQ context */
> +       struct work_struct      req_work;
>
>         struct cpufreq_user_policy user_policy;
>         struct cpufreq_frequency_table  *freq_table;
> @@ -147,6 +148,9 @@ struct cpufreq_policy {
>
>         /* Pointer to the cooling device if used for thermal mitigation */
>         struct thermal_cooling_device *cdev;
> +
> +       struct notifier_block nb_min;
> +       struct notifier_block nb_max;
>  };
>
>  struct cpufreq_freqs {
> --
> 2.21.0.rc0.269.g1a574e7a288b
>
