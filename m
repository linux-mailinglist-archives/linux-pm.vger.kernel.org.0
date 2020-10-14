Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E990D28DEE7
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 12:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgJNK3Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 06:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgJNK3Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2020 06:29:16 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E68C0613D2
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2020 03:29:16 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id m3so619450vki.12
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2020 03:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZc7p/yXjlwtejIPKasIqbk8w2QB7cXxoT31xaRagPc=;
        b=WiWnekbHqYAFpOeJjX16VjNDbFx4mXLUavnJlWkkh9U7svzHGNkF5GkekQwyjw3uuY
         cRtRL2ACLNW1pkxAV7g+p99UaA+wETPYztQKN/iVubUpQ51ObjGKPPPXHxi2LUSXErhS
         q8/UybS/N8coPVyL4XSHtFv6IBSEt2wwdrmWI2fPDGKP6NSfYpJHVjwtVAVEM3m7YWuS
         XRC3igevIQwdp0Ylu/SZUtoRj6t3wZrfTHLV6Btadq/WUXJDAY9NQjHi2w+kK9Xyj6B7
         6Pj0608nCF44CVz75GNOVJyb/q0PaQ6EfScoQuFUwP5l4Omyk/hKQuukxefTlSO00dPm
         QkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZc7p/yXjlwtejIPKasIqbk8w2QB7cXxoT31xaRagPc=;
        b=DFwsFPjpAGPmzA23jmSlc5tDG+q4Iftbf4NaB9FZOHHUea8XiiVqlBk/SiVPkAscDA
         pZRFuFGU03lLOuyknkwNwNV5MpnFHuQPaKXTRr/1akqK6Nt/khaeetXutj5JBvxW4ag9
         gtU6T5R5emU1LUdUyzio9kQdAIILvbYVOsYJtjrR5xbeJz3flZ+CQQOgQQn1Ffox3MwD
         ysie8mWGTEcwiHlTCVhzye3Px7OvS27I/t3onNMgzywRc5zNbRkvULyGEIbBbloB+bxt
         TjlkbEQJoIJmfVpc7BzNkpKv1Hh9uaOVNRFVq1KSL7YVGNHyPO5vwkZhX2LqCsnF71/i
         xRDA==
X-Gm-Message-State: AOAM530D969MxYA0xkzTI3Q9dvXNrpQp0I5u8wivIOLSy6CV5kxXBb8q
        rwetschQOUEjN1ceFZqCAIA42LSQw78qtPzx8QNkQg==
X-Google-Smtp-Source: ABdhPJzv/N8FSDA85gSwEwSzYDkzUEXJNj6ioS7yOz/JkaGudw/ixLGpXJIokmvdKjpTO50l0o7NhE+fOgaTmXd+898=
X-Received: by 2002:a1f:1c2:: with SMTP id 185mr2615824vkb.15.1602671355474;
 Wed, 14 Oct 2020 03:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201012223400.23609-1-ilina@codeaurora.org> <20201012223400.23609-2-ilina@codeaurora.org>
In-Reply-To: <20201012223400.23609-2-ilina@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Oct 2020 12:28:39 +0200
Message-ID: <CAPDyKFo0KrxQ8W0pawEca0_Ae0gs3OSBzHN2KY85YMnQp3ek8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / runtime: register device's next wakeup
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 13 Oct 2020 at 00:34, Lina Iyer <ilina@codeaurora.org> wrote:
>
> Some devices have a predictable interrupt pattern while executing a
> particular usecase. An example would be the VSYNC interrupt on devices
> associated with displays. A 60 Hz display could cause a periodic
> interrupt every 16 ms. A PM domain that holds such a device could power
> off and on at similar intervals.
>
> Entering a domain idle state saves power, only if the domain remains in
> the idle state for the amount of time greater than or equal to the
> residency of the idle state. Knowing the next wakeup event of the device
> will help the PM domain governor make better idle state decisions.
>
> Let's add the pm_runtime_set_next_wake() API for the device and document
> the usage of the API.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  Documentation/power/runtime_pm.rst | 21 ++++++++++++++++++++
>  drivers/base/power/runtime.c       | 31 ++++++++++++++++++++++++++++++
>  include/linux/pm.h                 |  2 ++
>  include/linux/pm_runtime.h         |  1 +
>  4 files changed, 55 insertions(+)
>
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> index 0553008b6279..90a5ac481ad4 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -515,6 +515,14 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
>        power.use_autosuspend isn't set, otherwise returns the expiration time
>        in jiffies
>
> +  `int pm_runtime_set_next_event(struct device *dev, ktime_t next);`

Rather than specifying the next event, could it make sense to specify
the delta instead? I guess it depends on the behaviour of the
driver/client that calls this API...

> +    - notify runtime PM of the next event on the device. Devices that are

I would prefer to change from "notify" to "inform", just to make it
clear that this isn't a notification mechanism we are talking about.

> +      sensitive to their domain idle enter/exit latencies may provide this
> +      information for use by the PM domain governor. The governor may determine
> +      if it worthwhile to enter a domain idle state. If the residency of the
> +      domain idle state is not met, the domain would waste more power entering
> +      and exiting the said idle state.
> +
>  It is safe to execute the following helper functions from interrupt context:
>
>  - pm_request_idle()
> @@ -545,6 +553,7 @@ functions may also be used in interrupt context:
>  - pm_runtime_put_sync()
>  - pm_runtime_put_sync_suspend()
>  - pm_runtime_put_sync_autosuspend()
> +- pm_runtime_set_next_event()
>
>  5. Runtime PM Initialization, Device Probing and Removal
>  ========================================================
> @@ -639,6 +648,18 @@ suspend routine).  It may be necessary to resume the device and suspend it again
>  in order to do so.  The same is true if the driver uses different power levels
>  or other settings for runtime suspend and system sleep.
>
> +When a device enters idle at runtime, it may trigger the runtime PM up the
> +hierarchy. Devices that have an predictable interrupt pattern, may help
> +influence a better idle state determination of its parent. For example, a
> +display device could get a VSYNC interrupt every 16ms. A PM domain containing
> +the device, could also be entering and exiting idle due to runtime PM

/containing the device/that has the device attached to it

> +coordination. If the domain were also entering runtime idle, we would know when
> +the domain would be waken up as a result of the display device waking up. Using
> +the device's next_event, the PM domain governor can make a better choice of the
> +idle state for the domain, knowing it would be be woken up by the device in the
> +near future. This is specially useful when the device is sensitive to its PM
> +domain's idle state enter and exit latencies.

The above sounds a little hand wavy, can you try to be a little more exact?

Perhaps, rather than just saying "sensitive to it's PM domain's idle
state..", how about explaining that by using the "next event" the
governor is able to select a more optimal domain idle state, thus we
should avoid wasting energy and better conform to QoS latency
constraints.

> +
>  During system resume, the simplest approach is to bring all devices back to full
>  power, even if they had been suspended before the system suspend began.  There
>  are several reasons for this, including:
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 8143210a5c54..53c2b3d962bc 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -122,6 +122,33 @@ u64 pm_runtime_suspended_time(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
>
> +/**
> + * pm_runtime_set_next_wakeup_event - Notify PM framework of an impending event.
> + * @dev: Device to handle
> + * @next: impending interrupt/wakeup for the device

At what typical points do you expect this function to be called?

> + */
> +int pm_runtime_set_next_event(struct device *dev, ktime_t next)
> +{
> +       unsigned long flags;
> +       int ret = -EINVAL;
> +
> +       /*
> +        * Note the next pending wakeup of a device,
> +        * if the device does not have runtime PM enabled.
> +        */

/s/Note/Store

Do you really need to check if runtime PM is enabled? Does it matter?

> +       spin_lock_irqsave(&dev->power.lock, flags);
> +       if (!dev->power.disable_depth) {
> +               if (ktime_before(ktime_get(), next)) {
> +                       dev->power.next_event = next;
> +                       ret = 0;
> +               }
> +       }
> +       spin_unlock_irqrestore(&dev->power.lock, flags);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(pm_runtime_set_next_event);
> +
>  /**
>   * pm_runtime_deactivate_timer - Deactivate given device's suspend timer.
>   * @dev: Device to handle.
> @@ -1380,6 +1407,9 @@ void __pm_runtime_disable(struct device *dev, bool check_resume)
>         /* Update time accounting before disabling PM-runtime. */
>         update_pm_runtime_accounting(dev);
>
> +       /* Reset the next wakeup for the device */
> +       dev->power.next_event = KTIME_MAX;
> +

I am not sure I get the purpose of this, can you elaborate?

I am thinking that the genpd governor doesn't allow to power off of
the PM domain, unless all devices that are attached to it are runtime
PM enabled and runtime PM suspended (see pm_runtime_suspended). That
said, it looks like the above isn't needed? No?

Perhaps it's better to use pm_runtime_enable() as the point of
resetting the dev->power.next_event?

>         if (!dev->power.disable_depth++)
>                 __pm_runtime_barrier(dev);
>
> @@ -1609,6 +1639,7 @@ void pm_runtime_init(struct device *dev)
>         dev->power.deferred_resume = false;
>         INIT_WORK(&dev->power.work, pm_runtime_work);
>
> +       dev->power.next_event = KTIME_MAX;
>         dev->power.timer_expires = 0;
>         hrtimer_init(&dev->power.suspend_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
>         dev->power.suspend_timer.function = pm_suspend_timer_fn;
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index a30a4b54df52..9051658674a4 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -8,6 +8,7 @@
>  #ifndef _LINUX_PM_H
>  #define _LINUX_PM_H
>
> +#include <linux/ktime.h>
>  #include <linux/list.h>
>  #include <linux/workqueue.h>
>  #include <linux/spinlock.h>
> @@ -616,6 +617,7 @@ struct dev_pm_info {
>         u64                     active_time;
>         u64                     suspended_time;
>         u64                     accounting_timestamp;
> +       ktime_t                 next_event;
>  #endif
>         struct pm_subsys_data   *subsys_data;  /* Owned by the subsystem. */
>         void (*set_latency_tolerance)(struct device *, s32);
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 6245caa18034..af6d35178335 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -59,6 +59,7 @@ extern void pm_runtime_get_suppliers(struct device *dev);
>  extern void pm_runtime_put_suppliers(struct device *dev);
>  extern void pm_runtime_new_link(struct device *dev);
>  extern void pm_runtime_drop_link(struct device *dev);
> +extern int pm_runtime_set_next_event(struct device *dev, ktime_t next);
>
>  /**
>   * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>

Kind regards
Uffe
