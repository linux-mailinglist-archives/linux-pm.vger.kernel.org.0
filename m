Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA8347E41
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 11:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfFQJYM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 05:24:12 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:37502 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfFQJYM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 05:24:12 -0400
Received: by mail-vk1-f195.google.com with SMTP id 125so1922758vkb.4
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2019 02:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6aXZgmLZPYPeayJx1SCYArQJwbkSlpcZ7I7YbEPWUb4=;
        b=Bq3T3bSmuMZrEpScFdXw6xQdb54pbynqFCgDi9scSYnQKOMjPtbfd95Prf4YKZ2yiS
         RuIcJ0d1ERwqnuPoLv7MARUj7c0cisVUn/Q/PS6fp4tHy3KkxG/sIg1mOu7/b4LDQNsy
         elMEEcVplEMP/62n8xkAh9AU7WenWcEH+NnZUUUSogEdp02aHTA8gx3rEMIxvY+N5bWi
         B4BugBC3OvVcqnbfSLwVoTFEnMHAt3wfevWxdEyZV+eBeSCHMHLYAQbrYK8BzBqX3S5D
         VXhy3e7ZWbPY+320lLQKiUvdflWuUp20rKMpCkEDCap7zgNkiBCFw794B/R0SYcXq10N
         30Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6aXZgmLZPYPeayJx1SCYArQJwbkSlpcZ7I7YbEPWUb4=;
        b=m08rGfpRfbRqY0Yud5y0yT9vUIzGVZB7I/3NWpRsh8pQWy0m2BmbW4yIpNdEtFmhcX
         mnXUj3R3ZIZJQ8qWwzUF9pbg836nIv/vWcnYnA52F74uvHGFQECeLj/DFSRlDO5isRpo
         m44OYOS7x+tv4HzkdM69kxcNxOnbj4eFgYsEB89uQp/NL1xVKBJR9vMcJ6u9DQeQCxjn
         V6MHhThdCGUwBbRpXqx9ZnBeI4Q60a1uv7GbIarEOEKF9nPS3xnLM6qAJfITU/lEwGjU
         o4Zew1RH5wSHBeKw0oHLP7hysIDBZefjt2pNcs6Us0BUBjbw+7M9qvA3Cxq/+XdArvek
         oXmw==
X-Gm-Message-State: APjAAAVBjFH+NCn+ckbi1fKIvBmsnS4acm3Xc5A4zWRiC91eTuxtd8AX
        PlnGOoa2/X/50QtGrXNLSo5F9Hocpw3W/FtJLyKEXQ==
X-Google-Smtp-Source: APXvYqyJEAHjZiKxI2Ce3Bp1C65725Wk9/gkCgSdQfVj4pzQw1IRKwFj/meUAfSLCDDlAUAcHUa7G70LgZIuNNJK2nc=
X-Received: by 2002:a1f:8744:: with SMTP id j65mr43378630vkd.17.1560763450778;
 Mon, 17 Jun 2019 02:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560163748.git.viresh.kumar@linaro.org> <8c0ead9cc598f9eb7d15bd4878108b545368dd6e.1560163748.git.viresh.kumar@linaro.org>
In-Reply-To: <8c0ead9cc598f9eb7d15bd4878108b545368dd6e.1560163748.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Jun 2019 11:23:34 +0200
Message-ID: <CAPDyKFp_TERpK8QtBwYUreC8o8MYT1erxkcypdVRwyw6OtTnsQ@mail.gmail.com>
Subject: Re: [PATCH V3 3/5] PM / QoS: Add support for MIN/MAX frequency constraints
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
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
> This patch introduces the min-frequency and max-frequency device
> constraints, which will be used by the cpufreq core to begin with.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/power/qos.c | 103 +++++++++++++++++++++++++++++++++------
>  include/linux/pm_qos.h   |  18 +++++++
>  2 files changed, 107 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index 7bb88174371f..e977aef437a5 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -151,6 +151,14 @@ static int apply_constraint(struct dev_pm_qos_request *req,
>                         req->dev->power.set_latency_tolerance(req->dev, value);
>                 }
>                 break;
> +       case DEV_PM_QOS_MIN_FREQUENCY:
> +               ret = pm_qos_update_target(&qos->min_frequency,
> +                                          &req->data.pnode, action, value);
> +               break;
> +       case DEV_PM_QOS_MAX_FREQUENCY:
> +               ret = pm_qos_update_target(&qos->max_frequency,
> +                                          &req->data.pnode, action, value);
> +               break;
>         case DEV_PM_QOS_FLAGS:
>                 ret = pm_qos_update_flags(&qos->flags, &req->data.flr,
>                                           action, value);
> @@ -179,12 +187,11 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
>         if (!qos)
>                 return -ENOMEM;
>
> -       n = kzalloc(sizeof(*n), GFP_KERNEL);
> +       n = kzalloc(3 * sizeof(*n), GFP_KERNEL);
>         if (!n) {
>                 kfree(qos);
>                 return -ENOMEM;
>         }
> -       BLOCKING_INIT_NOTIFIER_HEAD(n);
>
>         c = &qos->resume_latency;
>         plist_head_init(&c->list);
> @@ -193,6 +200,7 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
>         c->no_constraint_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>         c->type = PM_QOS_MIN;
>         c->notifiers = n;
> +       BLOCKING_INIT_NOTIFIER_HEAD(n);
>
>         c = &qos->latency_tolerance;
>         plist_head_init(&c->list);
> @@ -201,6 +209,24 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
>         c->no_constraint_value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
>         c->type = PM_QOS_MIN;
>
> +       c = &qos->min_frequency;
> +       plist_head_init(&c->list);
> +       c->target_value = PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
> +       c->default_value = PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
> +       c->no_constraint_value = PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
> +       c->type = PM_QOS_MAX;
> +       c->notifiers = ++n;
> +       BLOCKING_INIT_NOTIFIER_HEAD(n);
> +
> +       c = &qos->max_frequency;
> +       plist_head_init(&c->list);
> +       c->target_value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
> +       c->default_value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
> +       c->no_constraint_value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
> +       c->type = PM_QOS_MIN;
> +       c->notifiers = ++n;
> +       BLOCKING_INIT_NOTIFIER_HEAD(n);
> +
>         INIT_LIST_HEAD(&qos->flags.list);
>
>         spin_lock_irq(&dev->power.lock);
> @@ -254,11 +280,25 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
>                 apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
>                 memset(req, 0, sizeof(*req));
>         }
> +
>         c = &qos->latency_tolerance;
>         plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
>                 apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
>                 memset(req, 0, sizeof(*req));
>         }
> +
> +       c = &qos->min_frequency;
> +       plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
> +               apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE);
> +               memset(req, 0, sizeof(*req));
> +       }
> +
> +       c = &qos->max_frequency;
> +       plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
> +               apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
> +               memset(req, 0, sizeof(*req));
> +       }
> +
>         f = &qos->flags;
>         list_for_each_entry_safe(req, tmp, &f->list, data.flr.node) {
>                 apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
> @@ -370,6 +410,8 @@ static int __dev_pm_qos_update_request(struct dev_pm_qos_request *req,
>         switch(req->type) {
>         case DEV_PM_QOS_RESUME_LATENCY:
>         case DEV_PM_QOS_LATENCY_TOLERANCE:
> +       case DEV_PM_QOS_MIN_FREQUENCY:
> +       case DEV_PM_QOS_MAX_FREQUENCY:
>                 curr_value = req->data.pnode.prio;
>                 break;
>         case DEV_PM_QOS_FLAGS:
> @@ -482,9 +524,6 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
>  {
>         int ret = 0;
>
> -       if (WARN_ON(type != DEV_PM_QOS_RESUME_LATENCY))
> -               return -EINVAL;
> -
>         mutex_lock(&dev_pm_qos_mtx);
>
>         if (IS_ERR(dev->power.qos))
> @@ -492,10 +531,28 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
>         else if (!dev->power.qos)
>                 ret = dev_pm_qos_constraints_allocate(dev);
>
> -       if (!ret)
> +       if (ret)
> +               goto unlock;
> +
> +       switch (type) {
> +       case DEV_PM_QOS_RESUME_LATENCY:
>                 ret = blocking_notifier_chain_register(dev->power.qos->resume_latency.notifiers,
>                                                        notifier);
> +               break;
> +       case DEV_PM_QOS_MIN_FREQUENCY:
> +               ret = blocking_notifier_chain_register(dev->power.qos->min_frequency.notifiers,
> +                                                      notifier);
> +               break;
> +       case DEV_PM_QOS_MAX_FREQUENCY:
> +               ret = blocking_notifier_chain_register(dev->power.qos->max_frequency.notifiers,
> +                                                      notifier);
> +               break;
> +       default:
> +               WARN_ON(1);
> +               ret = -EINVAL;
> +       }
>
> +unlock:
>         mutex_unlock(&dev_pm_qos_mtx);
>         return ret;
>  }
> @@ -516,20 +573,35 @@ int dev_pm_qos_remove_notifier(struct device *dev,
>                                struct notifier_block *notifier,
>                                enum dev_pm_qos_req_type type)
>  {
> -       int retval = 0;
> -
> -       if (WARN_ON(type != DEV_PM_QOS_RESUME_LATENCY))
> -               return -EINVAL;
> +       int ret = 0;
>
>         mutex_lock(&dev_pm_qos_mtx);
>
>         /* Silently return if the constraints object is not present. */
> -       if (!IS_ERR_OR_NULL(dev->power.qos))
> -               retval = blocking_notifier_chain_unregister(dev->power.qos->resume_latency.notifiers,
> -                                                           notifier);
> +       if (IS_ERR_OR_NULL(dev->power.qos))
> +               goto unlock;
>
> +       switch (type) {
> +       case DEV_PM_QOS_RESUME_LATENCY:
> +               ret = blocking_notifier_chain_unregister(dev->power.qos->resume_latency.notifiers,
> +                                                        notifier);
> +               break;
> +       case DEV_PM_QOS_MIN_FREQUENCY:
> +               ret = blocking_notifier_chain_unregister(dev->power.qos->min_frequency.notifiers,
> +                                                        notifier);
> +               break;
> +       case DEV_PM_QOS_MAX_FREQUENCY:
> +               ret = blocking_notifier_chain_unregister(dev->power.qos->max_frequency.notifiers,
> +                                                        notifier);
> +               break;
> +       default:
> +               WARN_ON(1);
> +               ret = -EINVAL;
> +       }
> +
> +unlock:
>         mutex_unlock(&dev_pm_qos_mtx);
> -       return retval;
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_qos_remove_notifier);
>
> @@ -589,6 +661,9 @@ static void __dev_pm_qos_drop_user_request(struct device *dev,
>                 req = dev->power.qos->flags_req;
>                 dev->power.qos->flags_req = NULL;
>                 break;
> +       default:
> +               WARN_ON(1);
> +               return;
>         }
>         __dev_pm_qos_remove_request(req);
>         kfree(req);
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 55814d48c39c..3f994283a5ae 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -40,6 +40,8 @@ enum pm_qos_flags_status {
>  #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT    PM_QOS_LATENCY_ANY
>  #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS PM_QOS_LATENCY_ANY_NS
>  #define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE 0
> +#define PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE     0
> +#define PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE     (-1)
>  #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT (-1)
>
>  #define PM_QOS_FLAG_NO_POWER_OFF       (1 << 0)
> @@ -58,6 +60,8 @@ struct pm_qos_flags_request {
>  enum dev_pm_qos_req_type {
>         DEV_PM_QOS_RESUME_LATENCY = 1,
>         DEV_PM_QOS_LATENCY_TOLERANCE,
> +       DEV_PM_QOS_MIN_FREQUENCY,
> +       DEV_PM_QOS_MAX_FREQUENCY,
>         DEV_PM_QOS_FLAGS,
>  };
>
> @@ -99,10 +103,14 @@ struct pm_qos_flags {
>  struct dev_pm_qos {
>         struct pm_qos_constraints resume_latency;
>         struct pm_qos_constraints latency_tolerance;
> +       struct pm_qos_constraints min_frequency;
> +       struct pm_qos_constraints max_frequency;
>         struct pm_qos_flags flags;
>         struct dev_pm_qos_request *resume_latency_req;
>         struct dev_pm_qos_request *latency_tolerance_req;
>         struct dev_pm_qos_request *flags_req;
> +       struct dev_pm_qos_request *min_frequency_req;
> +       struct dev_pm_qos_request *max_frequency_req;
>  };
>
>  /* Action requested to pm_qos_update_target */
> @@ -185,6 +193,12 @@ static inline s32 dev_pm_qos_raw_read_value(struct device *dev,
>         case DEV_PM_QOS_RESUME_LATENCY:
>                 return IS_ERR_OR_NULL(qos) ? PM_QOS_RESUME_LATENCY_NO_CONSTRAINT
>                         : pm_qos_read_value(&qos->resume_latency);
> +       case DEV_PM_QOS_MIN_FREQUENCY:
> +               return IS_ERR_OR_NULL(qos) ? PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE
> +                       : pm_qos_read_value(&qos->min_frequency);
> +       case DEV_PM_QOS_MAX_FREQUENCY:
> +               return IS_ERR_OR_NULL(qos) ? PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE
> +                       : pm_qos_read_value(&qos->max_frequency);
>         default:
>                 WARN_ON(1);
>                 return 0;
> @@ -256,6 +270,10 @@ static inline s32 dev_pm_qos_raw_read_value(struct device *dev,
>         switch type {
>         case DEV_PM_QOS_RESUME_LATENCY:
>                 return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> +       case DEV_PM_QOS_MIN_FREQUENCY:
> +               return PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
> +       case DEV_PM_QOS_MAX_FREQUENCY:
> +               return PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
>         default:
>                 WARN_ON(1);
>                 return 0;
> --
> 2.21.0.rc0.269.g1a574e7a288b
>
