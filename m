Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5378433A54
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 17:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhJSPbD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 11:31:03 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:38588 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhJSPbD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 11:31:03 -0400
Received: by mail-ot1-f54.google.com with SMTP id l10-20020a056830154a00b00552b74d629aso3233355otp.5;
        Tue, 19 Oct 2021 08:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vHf2SXNgvFEN9EG1nkXySGLE14k38If7KxbUxMVZr8Q=;
        b=t/SJRj4wsbWKbBSq/zYxlECAlB8ZRIbV/gxzl+Lox9DyaQ+Kx3rtZ61OtbIQav2qAf
         yRfJq1vRR2m6J+VQhXzPMF/1jyjI60ue+oFkqP9rxj2NKXo9iDGkRBCdOPFgtctPx68l
         NSLfyDDxxNozen1Epwh6AYAm1qsxhY5m8alS00zSSDvqqA+ce0V8ruHAFnrlkrbB/c4x
         JSXXRGMPQ5VkJuJgwr0sYlYdKsGBmOtovAoJVIg6APh13zOuK2eNS+Yxs2BFnTqfqd12
         n7FWUY9WCZGj1Z4AtOYuhkMQlEdkGl+YabyJWd3txEHrQaNks660qpzjT2OCXBQSki5k
         l0Gw==
X-Gm-Message-State: AOAM530rioqi1UqJrvsSnV4G0c+YU+s2nSGOCgaAjhzd74M1RlSQIviV
        I3Z6LHrIjTEY0PB+KG52Gh+HDwbd2hQtylnO5gU=
X-Google-Smtp-Source: ABdhPJxaGI2wAHKaZ3Grm/2d2cfd4A0aUYk+aJ/xB/kpO1E5Wkfk74LMwcfKPAOeFPhSTBR9ezSKoJv/fHc5v4T8/gY=
X-Received: by 2002:a9d:65c1:: with SMTP id z1mr5791180oth.198.1634657329992;
 Tue, 19 Oct 2021 08:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <1628651069-22162-1-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1628651069-22162-1-git-send-email-chunfeng.yun@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Oct 2021 17:28:38 +0200
Message-ID: <CAJZ5v0hTR2mZk7FuUVciX766qq0AwWXFBZoBsV3Sd9ToYuErdQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM / wakeirq: support enabling wake-up irq after
 runtime_suspend called
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 11, 2021 at 5:05 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> When the dedicated wake-irq is level trigger, and it uses the
> consumer's sleep status as the wakeup source, that means if the
> consumer is not in sleep state, the wake-irq will be triggered
> when enable it; For this case, need enable the wake-irq after
> invoking the consumer's runtime_suspend() which make the consumer
> enter sleep state.

The terminology above is confusing.

As a rule, the term "sleep state" applies to the whole system, not to
an individual component.  It is better to use the term "low-power
state" instead.  Also, there may be multiple low-power states per
device and it is not clear which of them is relevant here.  My guess
is that the IRQ will trigger unless power is removed from the device
and you want to remove power from the device in ->runtime_suspend().

Moreover, I'm assuming that "the consumer" means "the device using the
wake IRQ", but this is not particularly clear either.

Now, the problem is that you need the device using the wake IRQ to be
in a low-power state in which the IRQ doesn't trigger automatically
before enabling the IRQ, and so you need to enable the IRQ after
running ->runtime_suspend() for that device and IMO this is how it
needs to be described.

> e.g.
> Assume the wake-irq is a low level trigger type, and the wakeup
> signal comes from the sleep status of consumer.
> The wakeup signal is low level at running time (0), and becomes
> high level when the consumer enters sleep state (runtime_suspend
> (1) is called), a wakeup event at (2) make the consumer exit sleep
> state, then the wakeup signal also becomes low level.
>
>                 ------------------
>                |           ^     ^|
> ----------------           |     | --------------
>  |<---(0)--->|<--(1)--|   (3)   (2)    (4)
>
> if enable the wake-irq before calling runtime_suspend during (0),
> an interrupt will arise, it causes resume immediately;
> it works if enable wake-irq ( e.g. at (3) or (4)) after calling
> runtime_suspend.
>
> This patch introduces a new status WAKE_IRQ_DEDICATED_LATE_ENABLED
> to optionally support enabling wake-irq after calling runtime_suspend().
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v3: add new status suggested by Rafael
>
> v2: add more commit message
>
>   Use the falling edge trigger interrupt suggested by Ikjoon [1], it
> works well at firstly when only use this related wakeup source, but
> encounter issues if use other wakeup sources to wakeup platform as
> below steps:
> 1. use another wakeup source to wake up the suspended system;
> 2. the consumer's resume() will be called, and exits sleep state;
> 3. the consumer's wakeup signal will fall into low level, due to
>    currently the wakeup irq is disabled, the wake-irq is pending;
> 4. the consumer tries to enter runtime suspend, but there is a
>    pending wakeup irq, so will resume again, this will repeat
>    endlessly.
>
>   Send out the patch again for further discussion.
>
> [1]: https://patchwork.kernel.org/patch/12190407
>
> ---
>  drivers/base/power/power.h   |  7 ++++--
>  drivers/base/power/runtime.c |  6 +++--
>  drivers/base/power/wakeirq.c | 49 +++++++++++++++++++++++++++++++++---
>  include/linux/pm_wakeirq.h   |  5 ++++
>  4 files changed, 60 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index 54292cdd7808..2d5dfc886f0b 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -25,8 +25,10 @@ extern u64 pm_runtime_active_time(struct device *dev);
>
>  #define WAKE_IRQ_DEDICATED_ALLOCATED   BIT(0)
>  #define WAKE_IRQ_DEDICATED_MANAGED     BIT(1)
> +#define WAKE_IRQ_DEDICATED_LATE_ENABLED        BIT(2)

This name is a bit long and it doesn't reflect the nautre of the
problem, which is that you need code ordering that is a reverse of the
usual flow.

WAKE_IRQ_DEDICATED_REVERSE may be a better name.

>  #define WAKE_IRQ_DEDICATED_MASK                (WAKE_IRQ_DEDICATED_ALLOCATED | \
> -                                        WAKE_IRQ_DEDICATED_MANAGED)
> +                                        WAKE_IRQ_DEDICATED_MANAGED | \
> +                                        WAKE_IRQ_DEDICATED_LATE_ENABLED)
>
>  struct wake_irq {
>         struct device *dev;
> @@ -39,7 +41,8 @@ extern void dev_pm_arm_wake_irq(struct wake_irq *wirq);
>  extern void dev_pm_disarm_wake_irq(struct wake_irq *wirq);
>  extern void dev_pm_enable_wake_irq_check(struct device *dev,
>                                          bool can_change_status);
> -extern void dev_pm_disable_wake_irq_check(struct device *dev);
> +extern void dev_pm_disable_wake_irq_check(struct device *dev, bool skip_enable_late);
> +extern void dev_pm_enable_wake_irq_complete(struct device *dev);
>
>  #ifdef CONFIG_PM_SLEEP
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 8a66eaf731e4..97646aa11376 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -645,6 +645,8 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>         if (retval)
>                 goto fail;
>
> +       dev_pm_enable_wake_irq_complete(dev);
> +
>   no_callback:
>         __update_runtime_status(dev, RPM_SUSPENDED);
>         pm_runtime_deactivate_timer(dev);
> @@ -690,7 +692,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>         return retval;
>
>   fail:
> -       dev_pm_disable_wake_irq_check(dev);
> +       dev_pm_disable_wake_irq_check(dev, false);
>         __update_runtime_status(dev, RPM_ACTIVE);
>         dev->power.deferred_resume = false;
>         wake_up_all(&dev->power.wait_queue);
> @@ -873,7 +875,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
>
>         callback = RPM_GET_CALLBACK(dev, runtime_resume);
>
> -       dev_pm_disable_wake_irq_check(dev);
> +       dev_pm_disable_wake_irq_check(dev, true);
>         retval = rpm_callback(callback, dev);
>         if (retval) {
>                 __update_runtime_status(dev, RPM_SUSPENDED);
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index 3bad3266a2ad..a612f5c26c6c 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -215,6 +215,24 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
>
> +/**
> + * dev_pm_wake_irq_set_late_enabled_status - set status WAKE_IRQ_DEDICATED_LATE_ENABLED
> + * @dev: Device
> + *
> + * Set the status of WAKE_IRQ_DEDICATED_LATE_ENABLED to tell rpm_suspend()
> + * to enable dedicated wake-up interrupt after invoking the runtime_suspend(),
> + *
> + * Should be called after setting dedicated wake-up interrupt.
> + */
> +void dev_pm_wake_irq_set_late_enabled_status(struct device *dev)
> +{
> +       struct wake_irq *wirq = dev->power.wakeirq;
> +
> +       if (wirq && (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED))
> +               wirq->status |= WAKE_IRQ_DEDICATED_LATE_ENABLED;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_wake_irq_set_late_enabled_status);

Instead of doing this, I would provide a special version of
dev_pm_set_dedicated_wake_irq() for this special use case such that it
will set WAKE_IRQ_DEDICATED_LATE_ENABLED (or whatever you call it) at
the allocation time (because this is a property of the IRQ and not
something that can change).

Maybe call it dev_pm_set_dedicated_wake_irq_reverse() and implemet
both it and dev_pm_set_dedicated_wake_irq() as wrappers around
something like __dev_pm_set_dedicated_wake_irq() taking an extra
argument that will indicate whether or not to set the new flag for
this IRQ.

> +
>  /**
>   * dev_pm_enable_wake_irq - Enable device wake-up interrupt
>   * @dev: Device
> @@ -285,27 +303,52 @@ void dev_pm_enable_wake_irq_check(struct device *dev,
>         return;
>
>  enable:
> -       enable_irq(wirq->irq);
> +       if (!can_change_status || !(wirq->status & WAKE_IRQ_DEDICATED_LATE_ENABLED))
> +               enable_irq(wirq->irq);
>  }
>
>  /**
>   * dev_pm_disable_wake_irq_check - Checks and disables wake-up interrupt
>   * @dev: Device
> + * @skip_late_enabled_status: skip checking WAKE_IRQ_DEDICATED_LATE_ENABLED

I would call this argument "cond_disable" or similarly to mean that
the IRQ should be disabled conditionally depending on the new flag.

And the description of it would be "If set, also check
WAKE_IRQ_DEDICATED_LATE_ENABLED".

>   *
>   * Disables wake-up interrupt conditionally based on status.
>   * Should be only called from rpm_suspend() and rpm_resume() path.
>   */
> -void dev_pm_disable_wake_irq_check(struct device *dev)
> +void dev_pm_disable_wake_irq_check(struct device *dev, bool skip_late_enabled_status)

Can't this function be static?

>  {
>         struct wake_irq *wirq = dev->power.wakeirq;
>
>         if (!wirq || !(wirq->status & WAKE_IRQ_DEDICATED_MASK))
>                 return;

And I would just add the following line here:

if (cond_disable && (wirq->status & WAKE_IRQ_DEDICATED_LATE_ENABLED))
        return;

>
> -       if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED)
> +       if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED &&
> +           (skip_late_enabled_status ||
> +            !(wirq->status & WAKE_IRQ_DEDICATED_LATE_ENABLED)))
>                 disable_irq_nosync(wirq->irq);
>  }
>
> +/**
> + * dev_pm_enable_wake_irq_complete - enable wake irq based on status

"Enable wake IRQ not enabled before"

> + * @dev: Device

"Device using the wake IRQ"

> + *
> + * Enable wake-up interrupt conditionally based on status, mainly for
> + * enabling wake-up interrupt after runtime_suspend() is called.
> + *
> + * Should be only called from rpm_suspend() path.

This part of the kerneldoc comment needs to be rewritten too, but it
looks like the function can be static, in which case it won't need the
kerneldoc comment at all.

> + */
> +void dev_pm_enable_wake_irq_complete(struct device *dev)
> +{
> +       struct wake_irq *wirq = dev->power.wakeirq;
> +
> +       if (!wirq || !(wirq->status & WAKE_IRQ_DEDICATED_MASK))
> +               return;
> +
> +       if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED &&
> +           wirq->status & WAKE_IRQ_DEDICATED_LATE_ENABLED)
> +               enable_irq(wirq->irq);
> +}
> +
>  /**
>   * dev_pm_arm_wake_irq - Arm device wake-up
>   * @wirq: Device wake-up interrupt
> diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
> index cd5b62db9084..92f814d583f8 100644
> --- a/include/linux/pm_wakeirq.h
> +++ b/include/linux/pm_wakeirq.h
> @@ -22,6 +22,7 @@ extern int dev_pm_set_dedicated_wake_irq(struct device *dev,
>  extern void dev_pm_clear_wake_irq(struct device *dev);
>  extern void dev_pm_enable_wake_irq(struct device *dev);
>  extern void dev_pm_disable_wake_irq(struct device *dev);
> +extern void dev_pm_wake_irq_set_late_enabled_status(struct device *dev);
>
>  #else  /* !CONFIG_PM */
>
> @@ -47,5 +48,9 @@ static inline void dev_pm_disable_wake_irq(struct device *dev)
>  {
>  }
>
> +static inline void dev_pm_wake_irq_set_late_enabled_status(struct device *dev)
> +{
> +}
> +
>  #endif /* CONFIG_PM */
>  #endif /* _LINUX_PM_WAKEIRQ_H */
> --
