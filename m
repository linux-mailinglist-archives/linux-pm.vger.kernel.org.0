Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C5A2925A9
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 12:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgJSKVu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 06:21:50 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43019 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgJSKVu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 06:21:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id l85so11831162oih.10;
        Mon, 19 Oct 2020 03:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eo8JiUHhuUK7IspmWk7F2lVsjE1RNjG2QNSD7jFijGE=;
        b=OtxCLrd67QyVE6RcQwUXKQ3/Tv0vzpl97AbSNMDoRPVB6+X8tT8xMRp2Gg9Lv9SYnh
         7nPfD2PdthK9AJ6VXRES8RwA/LimzLBsDN5Fwq0SqClNWh18moag8gtS5hNKQsFdhoYl
         jz5bmPRFO/VPxurlI1lSTdEdih7cVSrhlDdfotfIe8OmtXiKAAWBSFbeNs/q8X/cBUbb
         HHRrY+FunLfR04YNftBrAD/GNYxdorkf+ZRzVL12oXdPWFbmfXF+qaAfhjDp9qCPAXRD
         pBK4TPcuu7hLJzJn21EZy4tgJY778hFLuG91INVCLuAK0IMYhBof82bgMW6M8lcOmFZc
         pT2A==
X-Gm-Message-State: AOAM533MdiXjMeWgxDlh90PYYa8UXxM7hbhnPKPAdzshpKCvZM2q8wsH
        BdAVgYvOu0QKHBjfYYs97Tyma7HRQfF/gZEkd4E=
X-Google-Smtp-Source: ABdhPJyjHS6BMxsASjbjEcClwnrHpX7WJ3D5emE+hVmugZfXliMV9OTuWn/S+WLbTCDizzBwnK1KJhzgXzEztueG/ek=
X-Received: by 2002:aca:5256:: with SMTP id g83mr10780293oib.71.1603102907740;
 Mon, 19 Oct 2020 03:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201015193807.17423-1-ilina@codeaurora.org> <20201015193807.17423-2-ilina@codeaurora.org>
 <CAJZ5v0h4DewkbQnF84kO5bv7YYRu-7f67DhSTz-+aAy=c=32xQ@mail.gmail.com> <CAPDyKFow-QDSgPAhtJ5jMEyo0vitKstn_UChu3dbCcaj8XxBFA@mail.gmail.com>
In-Reply-To: <CAPDyKFow-QDSgPAhtJ5jMEyo0vitKstn_UChu3dbCcaj8XxBFA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Oct 2020 12:21:32 +0200
Message-ID: <CAJZ5v0gbXwhaMkFd1MdYPE2APTxQqd8Kv-MMhGTU6eQdJuAZnw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM / runtime: inform runtime PM of a device's next wakeup
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 19, 2020 at 12:01 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 16 Oct 2020 at 18:55, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Oct 15, 2020 at 9:38 PM Lina Iyer <ilina@codeaurora.org> wrote:
> > >
> > > Some devices may have a predictable interrupt pattern while executing
> > > usecases. An example would be the VSYNC interrupt associated with
> > > display devices. A 60 Hz display could cause a interrupt every 16 ms. If
> > > the device were in a PM domain, the domain would need to be powered up
> > > for device to resume and handle the interrupt.
> > >
> > > Entering a domain idle state saves power, only if the residency of the
> > > idle state is met. Without knowing the idle duration of the domain, the
> > > governor would just choose the deepest idle state that matches the QoS
> > > requirements. The domain might be powered off just as the device is
> > > expecting to wake up. If devices could inform runtime PM of their next
> > > event, the parent PM domain's idle duration can be determined.
> > >
> > > So let's add the pm_runtime_set_next_wake() API for the device to notify
> > > runtime PM of the impending wakeup and document it's usage.
> > >
> > > Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> > > ---
> > > Changes in v2:
> > >         - Update documentation
> > >         - Remove runtime PM enabled check
> > >         - Update commit text
> > > ---
> > >  Documentation/power/runtime_pm.rst | 17 +++++++++++++++++
> > >  drivers/base/power/runtime.c       | 24 ++++++++++++++++++++++++
> > >  include/linux/pm.h                 |  2 ++
> > >  include/linux/pm_runtime.h         |  1 +
> > >  4 files changed, 44 insertions(+)
> > >
> > > diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> > > index 0553008b6279..f6aaef15a511 100644
> > > --- a/Documentation/power/runtime_pm.rst
> > > +++ b/Documentation/power/runtime_pm.rst
> > > @@ -515,6 +515,12 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
> > >        power.use_autosuspend isn't set, otherwise returns the expiration time
> > >        in jiffies
> > >
> > > +  `int pm_runtime_set_next_event(struct device *dev, ktime_t next);`
> > > +    - inform runtime PM of the next event on the device. Devices that are
> > > +      sensitive to their domain idle enter/exit latencies may provide this
> > > +      information for use by the PM domain governor. The domain governor would
> > > +      use this information to calculate it's sleep length.
> > > +
> > >  It is safe to execute the following helper functions from interrupt context:
> > >
> > >  - pm_request_idle()
> > > @@ -545,6 +551,7 @@ functions may also be used in interrupt context:
> > >  - pm_runtime_put_sync()
> > >  - pm_runtime_put_sync_suspend()
> > >  - pm_runtime_put_sync_autosuspend()
> > > +- pm_runtime_set_next_event()
> > >
> > >  5. Runtime PM Initialization, Device Probing and Removal
> > >  ========================================================
> > > @@ -639,6 +646,16 @@ suspend routine).  It may be necessary to resume the device and suspend it again
> > >  in order to do so.  The same is true if the driver uses different power levels
> > >  or other settings for runtime suspend and system sleep.
> > >
> > > +When a device enters idle at runtime, it may trigger the runtime PM up the
> > > +hierarchy and if device has a predictable interrupt pattern, we can even do a
> > > +better job at determining the parent's idle state. For example, a display
> > > +device gets a VSYNC interrupt every 16 ms when running at 60 Hz. When it's PM
> > > +domain is powering down and happens to be at the boundary of the VSYNC
> > > +interrupt, it may not be efficient to power off the domain. Knowing the next
> > > +wake up (when available) for devices in the domain we can determine the idle
> > > +duration of the domain. By comparing idle duration with the residencies of the
> > > +domain idle states, we can be efficient in both power and performance.
> > > +
> > >  During system resume, the simplest approach is to bring all devices back to full
> > >  power, even if they had been suspended before the system suspend began.  There
> > >  are several reasons for this, including:
> > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > index 8143210a5c54..5d2ebacfd35e 100644
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -122,6 +122,27 @@ u64 pm_runtime_suspended_time(struct device *dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
> > >
> > > +/**
> > > + * pm_runtime_set_next_wakeup_event - Notify PM framework of an impending event.
> > > + * @dev: Device to handle
> > > + * @next: impending interrupt/wakeup for the device
> > > + */
> > > +int pm_runtime_set_next_event(struct device *dev, ktime_t next)
> > > +{
> > > +       unsigned long flags;
> > > +       int ret = -EINVAL;
> > > +
> > > +       spin_lock_irqsave(&dev->power.lock, flags);
> > > +       if (ktime_before(ktime_get(), next)) {
> > > +               dev->power.next_event = next;
> > > +               ret = 0;
> > > +       }
> > > +       spin_unlock_irqrestore(&dev->power.lock, flags);
> > > +
> > > +       return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pm_runtime_set_next_event);
> > > +
> > >  /**
> > >   * pm_runtime_deactivate_timer - Deactivate given device's suspend timer.
> > >   * @dev: Device to handle.
> > > @@ -1415,6 +1436,9 @@ void pm_runtime_enable(struct device *dev)
> > >              "Enabling runtime PM for inactive device (%s) with active children\n",
> > >              dev_name(dev));
> > >
> > > +       /* Reset the next wakeup for the device */
> > > +       dev->power.next_event = KTIME_MAX;
> > > +
> > >         spin_unlock_irqrestore(&dev->power.lock, flags);
> > >  }
> > >  EXPORT_SYMBOL_GPL(pm_runtime_enable);
> > > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > > index a30a4b54df52..9051658674a4 100644
> > > --- a/include/linux/pm.h
> > > +++ b/include/linux/pm.h
> > > @@ -8,6 +8,7 @@
> > >  #ifndef _LINUX_PM_H
> > >  #define _LINUX_PM_H
> > >
> > > +#include <linux/ktime.h>
> > >  #include <linux/list.h>
> > >  #include <linux/workqueue.h>
> > >  #include <linux/spinlock.h>
> > > @@ -616,6 +617,7 @@ struct dev_pm_info {
> > >         u64                     active_time;
> > >         u64                     suspended_time;
> > >         u64                     accounting_timestamp;
> > > +       ktime_t                 next_event;
> >
> > While there are some cosmetic changes to be made, this particular bit
> > is fundamentally questionable IMV, because next_event (which BTW would
> > better be called next_wakeup IMO) is not used by PM-runtime.
> >
> > The only user of it will be genpd AFAICS, so I don't quite see a
> > reason to inflict this extra memory cost on everybody, even if they
> > don't care about genpd and may not even compile it in.
>
> That's a good point!
>
> May I suggest that the new data is put into the "struct
> generic_pm_domain_data" instead, which means it will be allocated when
> a device is attached to a genpd.

Yes, something like that.

> Moreover, we should probably rename the API (and move the
> implementation of it accordingly) from pm_runtime_set_next_event() to
> dev_pm_genpd_set_next_wakeup().

Right.

> Unless we believe the interface could
> be useful for other PM domain types (ACPI ?), then we could consider
> adding a ->set_next_wakeup() callback to the struct dev_pm_domain and
> implement the interface through a common
> dev_pm_domain_set_next_wakeup() API.

Maybe.

That would depend on who the other user would be and I wouldn't worry
about that upfront.

Cheers!
