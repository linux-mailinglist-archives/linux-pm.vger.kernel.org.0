Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B6029251D
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 12:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgJSKBN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 06:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgJSKBN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 06:01:13 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08769C0613D0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 03:01:12 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id q20so3005244uar.7
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 03:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXKSsslBWiutWvDLA9qO0f0XrS91JIRa/+CbvcwxVAk=;
        b=y2ucjuoRxI/P60RkBBtrawHQLzZTgBvFkZ6DpXpb4mKxqrdRah73FhQIm0aJ2NZUqi
         z5TbMo5zI+I+MvSGbDvVDedXN/HxXjsiYRwcSTBzHq3tn7tWyjeqEivcDdq2id0nF+FM
         OiNYmkLE+N6p3mo9YhfiKXczwflspKqTr8uSdu+XEZ7FTMR6Q7UkKlvrQZ0+APPEZgjg
         +4m8VNX9kF2R6dh2KeKC/wcLg3uwvTk6ODghc91z+7vZh4zhqLV0GyFZwkmG35Qjbi/V
         TpJMJTFV+34y9IIP75+ue8+37xDoznmVgeWdBvqZYnTIA8cKU0uAAWs6KnBxtcb4vakJ
         pPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXKSsslBWiutWvDLA9qO0f0XrS91JIRa/+CbvcwxVAk=;
        b=ZpiDmbokmB5hje221lrZHxpjU9Fy0rgFLeP8p99Zmn51oF1Uju57Wf76Z7nCpeiFSS
         mGsMmiaWzMOI0r5FIVvYAsh5u9krhom6WNkF5qG20OVcUwBUBZeJqtclrYmB/GGzqzsf
         +frq7cOrnZZ6fVw6/NYb/NMtJ80QU3K58XcNrxXMA9+C79N4hnVjX4UhjW/ytXk+kH6P
         sFcavftpVkYEv+0a49aWmuX3c0EG2cJb625Qgv3P7hVPT4dK/60jr3eo793p3ezrhcYh
         JWqGbuAzEqhDfDb6iKS41BJhE/dk4NT2CTvxA7Rda9Sf8IyzNyMG1jShhDSw4ByNfQS8
         4c8A==
X-Gm-Message-State: AOAM531BtB0N91acrdSI/jx+8IhpxpnIV/y73Okj6KxbS1nqpKIbkm2l
        ShnN6lY7plz50ZI4spzP+x+fe0pvLZewdluLMDt2IP3OuPVLrIdw
X-Google-Smtp-Source: ABdhPJwXRJhEYXllAKqUCJZ+CkMBnB1HXoV9v057KXSLGuRORCMZOdhyDQK69cg5wgIdRT9JVxrrvDUDMUAsCDCQGNI=
X-Received: by 2002:ab0:907:: with SMTP id w7mr7638849uag.100.1603101671008;
 Mon, 19 Oct 2020 03:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201015193807.17423-1-ilina@codeaurora.org> <20201015193807.17423-2-ilina@codeaurora.org>
 <CAJZ5v0h4DewkbQnF84kO5bv7YYRu-7f67DhSTz-+aAy=c=32xQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h4DewkbQnF84kO5bv7YYRu-7f67DhSTz-+aAy=c=32xQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 19 Oct 2020 12:00:34 +0200
Message-ID: <CAPDyKFow-QDSgPAhtJ5jMEyo0vitKstn_UChu3dbCcaj8XxBFA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM / runtime: inform runtime PM of a device's next wakeup
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 16 Oct 2020 at 18:55, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 15, 2020 at 9:38 PM Lina Iyer <ilina@codeaurora.org> wrote:
> >
> > Some devices may have a predictable interrupt pattern while executing
> > usecases. An example would be the VSYNC interrupt associated with
> > display devices. A 60 Hz display could cause a interrupt every 16 ms. If
> > the device were in a PM domain, the domain would need to be powered up
> > for device to resume and handle the interrupt.
> >
> > Entering a domain idle state saves power, only if the residency of the
> > idle state is met. Without knowing the idle duration of the domain, the
> > governor would just choose the deepest idle state that matches the QoS
> > requirements. The domain might be powered off just as the device is
> > expecting to wake up. If devices could inform runtime PM of their next
> > event, the parent PM domain's idle duration can be determined.
> >
> > So let's add the pm_runtime_set_next_wake() API for the device to notify
> > runtime PM of the impending wakeup and document it's usage.
> >
> > Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> > ---
> > Changes in v2:
> >         - Update documentation
> >         - Remove runtime PM enabled check
> >         - Update commit text
> > ---
> >  Documentation/power/runtime_pm.rst | 17 +++++++++++++++++
> >  drivers/base/power/runtime.c       | 24 ++++++++++++++++++++++++
> >  include/linux/pm.h                 |  2 ++
> >  include/linux/pm_runtime.h         |  1 +
> >  4 files changed, 44 insertions(+)
> >
> > diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> > index 0553008b6279..f6aaef15a511 100644
> > --- a/Documentation/power/runtime_pm.rst
> > +++ b/Documentation/power/runtime_pm.rst
> > @@ -515,6 +515,12 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
> >        power.use_autosuspend isn't set, otherwise returns the expiration time
> >        in jiffies
> >
> > +  `int pm_runtime_set_next_event(struct device *dev, ktime_t next);`
> > +    - inform runtime PM of the next event on the device. Devices that are
> > +      sensitive to their domain idle enter/exit latencies may provide this
> > +      information for use by the PM domain governor. The domain governor would
> > +      use this information to calculate it's sleep length.
> > +
> >  It is safe to execute the following helper functions from interrupt context:
> >
> >  - pm_request_idle()
> > @@ -545,6 +551,7 @@ functions may also be used in interrupt context:
> >  - pm_runtime_put_sync()
> >  - pm_runtime_put_sync_suspend()
> >  - pm_runtime_put_sync_autosuspend()
> > +- pm_runtime_set_next_event()
> >
> >  5. Runtime PM Initialization, Device Probing and Removal
> >  ========================================================
> > @@ -639,6 +646,16 @@ suspend routine).  It may be necessary to resume the device and suspend it again
> >  in order to do so.  The same is true if the driver uses different power levels
> >  or other settings for runtime suspend and system sleep.
> >
> > +When a device enters idle at runtime, it may trigger the runtime PM up the
> > +hierarchy and if device has a predictable interrupt pattern, we can even do a
> > +better job at determining the parent's idle state. For example, a display
> > +device gets a VSYNC interrupt every 16 ms when running at 60 Hz. When it's PM
> > +domain is powering down and happens to be at the boundary of the VSYNC
> > +interrupt, it may not be efficient to power off the domain. Knowing the next
> > +wake up (when available) for devices in the domain we can determine the idle
> > +duration of the domain. By comparing idle duration with the residencies of the
> > +domain idle states, we can be efficient in both power and performance.
> > +
> >  During system resume, the simplest approach is to bring all devices back to full
> >  power, even if they had been suspended before the system suspend began.  There
> >  are several reasons for this, including:
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 8143210a5c54..5d2ebacfd35e 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -122,6 +122,27 @@ u64 pm_runtime_suspended_time(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
> >
> > +/**
> > + * pm_runtime_set_next_wakeup_event - Notify PM framework of an impending event.
> > + * @dev: Device to handle
> > + * @next: impending interrupt/wakeup for the device
> > + */
> > +int pm_runtime_set_next_event(struct device *dev, ktime_t next)
> > +{
> > +       unsigned long flags;
> > +       int ret = -EINVAL;
> > +
> > +       spin_lock_irqsave(&dev->power.lock, flags);
> > +       if (ktime_before(ktime_get(), next)) {
> > +               dev->power.next_event = next;
> > +               ret = 0;
> > +       }
> > +       spin_unlock_irqrestore(&dev->power.lock, flags);
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pm_runtime_set_next_event);
> > +
> >  /**
> >   * pm_runtime_deactivate_timer - Deactivate given device's suspend timer.
> >   * @dev: Device to handle.
> > @@ -1415,6 +1436,9 @@ void pm_runtime_enable(struct device *dev)
> >              "Enabling runtime PM for inactive device (%s) with active children\n",
> >              dev_name(dev));
> >
> > +       /* Reset the next wakeup for the device */
> > +       dev->power.next_event = KTIME_MAX;
> > +
> >         spin_unlock_irqrestore(&dev->power.lock, flags);
> >  }
> >  EXPORT_SYMBOL_GPL(pm_runtime_enable);
> > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > index a30a4b54df52..9051658674a4 100644
> > --- a/include/linux/pm.h
> > +++ b/include/linux/pm.h
> > @@ -8,6 +8,7 @@
> >  #ifndef _LINUX_PM_H
> >  #define _LINUX_PM_H
> >
> > +#include <linux/ktime.h>
> >  #include <linux/list.h>
> >  #include <linux/workqueue.h>
> >  #include <linux/spinlock.h>
> > @@ -616,6 +617,7 @@ struct dev_pm_info {
> >         u64                     active_time;
> >         u64                     suspended_time;
> >         u64                     accounting_timestamp;
> > +       ktime_t                 next_event;
>
> While there are some cosmetic changes to be made, this particular bit
> is fundamentally questionable IMV, because next_event (which BTW would
> better be called next_wakeup IMO) is not used by PM-runtime.
>
> The only user of it will be genpd AFAICS, so I don't quite see a
> reason to inflict this extra memory cost on everybody, even if they
> don't care about genpd and may not even compile it in.

That's a good point!

May I suggest that the new data is put into the "struct
generic_pm_domain_data" instead, which means it will be allocated when
a device is attached to a genpd.

Moreover, we should probably rename the API (and move the
implementation of it accordingly) from pm_runtime_set_next_event() to
dev_pm_genpd_set_next_wakeup(). Unless we believe the interface could
be useful for other PM domain types (ACPI ?), then we could consider
adding a ->set_next_wakeup() callback to the struct dev_pm_domain and
implement the interface through a common
dev_pm_domain_set_next_wakeup() API.

>
> >  #endif
> >         struct pm_subsys_data   *subsys_data;  /* Owned by the subsystem. */
> >         void (*set_latency_tolerance)(struct device *, s32);
> > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > index 6245caa18034..af6d35178335 100644
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -59,6 +59,7 @@ extern void pm_runtime_get_suppliers(struct device *dev);
> >  extern void pm_runtime_put_suppliers(struct device *dev);
> >  extern void pm_runtime_new_link(struct device *dev);
> >  extern void pm_runtime_drop_link(struct device *dev);
> > +extern int pm_runtime_set_next_event(struct device *dev, ktime_t next);
> >
> >  /**
> >   * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
> > --
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> >

Kind regards
Uffe
