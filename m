Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 337F5190E1D
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 13:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCXMwM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 08:52:12 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33876 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbgCXMwM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 08:52:12 -0400
Received: by mail-ot1-f68.google.com with SMTP id j16so16877792otl.1;
        Tue, 24 Mar 2020 05:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1y7q29ccSBq8K446tAqeOEfuaRdM468XCRlcAOC6f8Y=;
        b=bME7GtCR/fVKvtFQaSl6gjJpQrIRbGmh5t6oGeVA4kFxXqLQqr46uD1sONBg2xaVVQ
         6c95wXsXFZviv0Z5pQNH7Y4n4/5sblkbYjVMSUFx+4Sco0KRa0P50SaO8b80yO3W6zJm
         HaWNQg5Kjqtj7dtO2gOMcyLQ0Y46LCMgkJTpUsP7/B6E6xYrM0lZEiRdFnzecyw7tnGu
         8VkR4j8/BNYsva2le+TQf6PoNnVFfTQkRLa/RA2/uW+6ySgTm4qhAszwltm25+/+lcgj
         rhi8MaAKLhoRxWMWGbu67lojNfi9Uc4YyOTeWLFNI/w8LO4BobOt2AHF9/Oe12gigRm8
         9YzQ==
X-Gm-Message-State: ANhLgQ2g8jY5AKRcSPbxqT4+kc0abdGmqHuQx9t+dcS3G4ktDqDmNHbe
        Y8gJGtu9Q3XP7rJQuW13m+yOtECL1ta+hHOkZMQ=
X-Google-Smtp-Source: ADFU+vvTYb56pkOHejgFGwL15FFbXIlho+pXCfLh9iNwjPXmWdXUyZjIq1MNiCZ7ErxeufaVq24f7/P6CX2ZFBOt5yY=
X-Received: by 2002:a9d:1d07:: with SMTP id m7mr20698264otm.167.1585054331459;
 Tue, 24 Mar 2020 05:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200324122023.9649-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200324122023.9649-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Mar 2020 13:52:00 +0100
Message-ID: <CAJZ5v0hQ2vRE8QAWfxwN1auQd5bQS_ROd6do1bMt8GtLtRypRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] driver core: Break infinite loop when deferred
 probe can't be satisfied
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Ferry Toth <fntoth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 24, 2020 at 1:20 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Consider the following scenario.
>
> The main driver of USB OTG controller (dwc3-pci), which has the following
> functional dependencies on certain platform:
> - ULPI (tusb1210)
> - extcon (tested with extcon-intel-mrfld)
>
> Note, that first driver, tusb1210, is available at the moment of
> dwc3-pci probing, while extcon-intel-mrfld is built as a module and
> won't appear till user space does something about it.
>
> This is depicted by kernel configuration excerpt:
>
>         CONFIG_PHY_TUSB1210=y
>         CONFIG_USB_DWC3=y
>         CONFIG_USB_DWC3_ULPI=y
>         CONFIG_USB_DWC3_DUAL_ROLE=y
>         CONFIG_USB_DWC3_PCI=y
>         CONFIG_EXTCON_INTEL_MRFLD=m
>
> In the Buildroot environment the modules are probed by alphabetical ordering
> of their modaliases. The latter comes to the case when USB OTG driver will be
> probed first followed by extcon one.
>
> So, if the platform anticipates extcon device to be appeared, in the above case
> we will get deferred probe of USB OTG, because of ordering.
>
> Since current implementation, done by the commit 58b116bce136 ("drivercore:
> deferral race condition fix") counts the amount of triggered deferred probe,
> we never advance the situation -- the change makes it to be an infinite loop.
>
> ---8<---8<---
>
> [   22.187127] driver_deferred_probe_trigger <<< 1
>
> ...here is the late initcall triggers deferred probe...
>
> [   22.191725] platform dwc3.0.auto: deferred_probe_work_func in deferred list
>
> ...dwc3.0.auto is the only device in the deferred list...
>
> [   22.198727] platform dwc3.0.auto: deferred_probe_work_func 1 <<< counter 1
>
> ...the counter before mutex is unlocked is kept the same...
>
> [   22.205663] platform dwc3.0.auto: Retrying from deferred list
>
> ...mutes has been unlocked, we try to re-probe the driver...
>
> [   22.211487] bus: 'platform': driver_probe_device: matched device dwc3.0.auto with driver dwc3
> [   22.220060] bus: 'platform': really_probe: probing driver dwc3 with device dwc3.0.auto
> [   22.238735] bus: 'ulpi': driver_probe_device: matched device dwc3.0.auto.ulpi with driver tusb1210
> [   22.247743] bus: 'ulpi': really_probe: probing driver tusb1210 with device dwc3.0.auto.ulpi
> [   22.256292] driver: 'tusb1210': driver_bound: bound to device 'dwc3.0.auto.ulpi'
> [   22.263723] driver_deferred_probe_trigger <<< 2
>
> ...the dwc3.0.auto probes ULPI, we got successful bound and bumped counter...
>
> [   22.268304] bus: 'ulpi': really_probe: bound device dwc3.0.auto.ulpi to driver tusb1210
> [   22.276697] platform dwc3.0.auto: Driver dwc3 requests probe deferral
>
> ...but extcon driver is still missing...
>
> [   22.283174] platform dwc3.0.auto: Added to deferred list
> [   22.288513] platform dwc3.0.auto: driver_deferred_probe_add_trigger local counter: 1 new counter 2
>
> ...and since we had a successful probe, we got counter mismatch...
>
> [   22.297490] driver_deferred_probe_trigger <<< 3
> [   22.302074] platform dwc3.0.auto: deferred_probe_work_func 2 <<< counter 3
>
> ...at the end we have a new counter and loop repeats again, see 22.198727...
>
> ---8<---8<---
>
> Revert of the commit helps, but it is probably not helpful for the initially
> found regression. Artem Bityutskiy suggested to use counter of the successful
> probes instead. This fixes above mentioned case and shouldn't prevent driver
> to reprobe deferred ones.
>
> Fixes: 58b116bce136 ("drivercore: deferral race condition fix")
> Suggested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Cc: Grant Likely grant.likely@arm.com
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Tested-by: Ferry Toth <fntoth@gmail.com>
> ---
> v2: picked up tags, update Grant's email (Peter)
>  drivers/base/dd.c | 39 +++++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index b25bcab2a26b..43720beb5300 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -53,7 +53,6 @@
>  static DEFINE_MUTEX(deferred_probe_mutex);
>  static LIST_HEAD(deferred_probe_pending_list);
>  static LIST_HEAD(deferred_probe_active_list);
> -static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
>  static struct dentry *deferred_devices;
>  static bool initcalls_done;
>
> @@ -147,17 +146,6 @@ static bool driver_deferred_probe_enable = false;
>   * This functions moves all devices from the pending list to the active
>   * list and schedules the deferred probe workqueue to process them.  It
>   * should be called anytime a driver is successfully bound to a device.
> - *
> - * Note, there is a race condition in multi-threaded probe. In the case where
> - * more than one device is probing at the same time, it is possible for one
> - * probe to complete successfully while another is about to defer. If the second
> - * depends on the first, then it will get put on the pending list after the
> - * trigger event has already occurred and will be stuck there.
> - *
> - * The atomic 'deferred_trigger_count' is used to determine if a successful
> - * trigger has occurred in the midst of probing a driver. If the trigger count
> - * changes in the midst of a probe, then deferred processing should be triggered
> - * again.
>   */
>  static void driver_deferred_probe_trigger(void)
>  {
> @@ -170,7 +158,6 @@ static void driver_deferred_probe_trigger(void)
>          * into the active list so they can be retried by the workqueue
>          */
>         mutex_lock(&deferred_probe_mutex);
> -       atomic_inc(&deferred_trigger_count);
>         list_splice_tail_init(&deferred_probe_pending_list,
>                               &deferred_probe_active_list);
>         mutex_unlock(&deferred_probe_mutex);
> @@ -350,6 +337,19 @@ static void __exit deferred_probe_exit(void)
>  }
>  __exitcall(deferred_probe_exit);
>
> +/*
> + * Note, there is a race condition in multi-threaded probe. In the case where
> + * more than one device is probing at the same time, it is possible for one
> + * probe to complete successfully while another is about to defer. If the second
> + * depends on the first, then it will get put on the pending list after the
> + * trigger event has already occurred and will be stuck there.
> + *
> + * The atomic 'probe_okay' is used to determine if a successful probe has
> + * occurred in the midst of probing another driver. If the count changes in
> + * the midst of a probe, then deferred processing should be triggered again.
> + */
> +static atomic_t probe_okay = ATOMIC_INIT(0);
> +
>  /**
>   * device_is_bound() - Check if device is bound to a driver
>   * @dev: device to check
> @@ -375,6 +375,7 @@ static void driver_bound(struct device *dev)
>         pr_debug("driver: '%s': %s: bound to device '%s'\n", dev->driver->name,
>                  __func__, dev_name(dev));
>
> +       atomic_inc(&probe_okay);
>         klist_add_tail(&dev->p->knode_driver, &dev->driver->p->klist_devices);
>         device_links_driver_bound(dev);
>
> @@ -481,18 +482,18 @@ static atomic_t probe_count = ATOMIC_INIT(0);
>  static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
>
>  static void driver_deferred_probe_add_trigger(struct device *dev,
> -                                             int local_trigger_count)
> +                                             int local_probe_okay_count)
>  {
>         driver_deferred_probe_add(dev);
>         /* Did a trigger occur while probing? Need to re-trigger if yes */
> -       if (local_trigger_count != atomic_read(&deferred_trigger_count))
> +       if (local_probe_okay_count != atomic_read(&probe_okay))
>                 driver_deferred_probe_trigger();
>  }
>
>  static int really_probe(struct device *dev, struct device_driver *drv)
>  {
>         int ret = -EPROBE_DEFER;
> -       int local_trigger_count = atomic_read(&deferred_trigger_count);
> +       int local_probe_okay_count = atomic_read(&probe_okay);
>         bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
>                            !drv->suppress_bind_attrs;
>
> @@ -509,7 +510,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>
>         ret = device_links_check_suppliers(dev);
>         if (ret == -EPROBE_DEFER)
> -               driver_deferred_probe_add_trigger(dev, local_trigger_count);
> +               driver_deferred_probe_add_trigger(dev, local_probe_okay_count);
>         if (ret)
>                 return ret;
>
> @@ -619,7 +620,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>         case -EPROBE_DEFER:
>                 /* Driver requested deferred probing */
>                 dev_dbg(dev, "Driver %s requests probe deferral\n", drv->name);
> -               driver_deferred_probe_add_trigger(dev, local_trigger_count);
> +               driver_deferred_probe_add_trigger(dev, local_probe_okay_count);
>                 break;
>         case -ENODEV:
>         case -ENXIO:
> @@ -1148,6 +1149,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>                 dev_pm_set_driver_flags(dev, 0);
>
>                 klist_remove(&dev->p->knode_driver);
> +               atomic_dec(&probe_okay);
> +

Why is this needed?

>                 device_pm_check_callbacks(dev);
>                 if (dev->bus)
>                         blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> --
