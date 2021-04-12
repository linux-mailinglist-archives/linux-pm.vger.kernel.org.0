Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DD135B9C1
	for <lists+linux-pm@lfdr.de>; Mon, 12 Apr 2021 07:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhDLFOh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 01:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhDLFOh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 01:14:37 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA63C061574
        for <linux-pm@vger.kernel.org>; Sun, 11 Apr 2021 22:14:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so8751690pjb.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Apr 2021 22:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QShRKzsEMp6U8GpuK5A8DEeE3/Uf7j3/vVAxV0LlqQc=;
        b=AIiw6hUM7qMzpIYYYhYaG+qhav+fbxWTnxxgdFbFOjCbtoFg1oVT8kC6jRXF5sTGG8
         OPedReYxorhiKILob9A256qYhQSr0Eonok0fGQTB1nvGMc/dzLnSXALXQ/XN7tH6n4vY
         3KKyoqnRbv1Av+paR2BV5f8gTACO88Qt5VhiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QShRKzsEMp6U8GpuK5A8DEeE3/Uf7j3/vVAxV0LlqQc=;
        b=oRBt+ZS32l1AwxnioOQ3GjsaHsETPJZsqjfUZQ2ye3TYh3QYO9J3CViiD5dPiJbs40
         w54z/MvLvcQIGkh4crsBokz0HbPn/aKQn7eG0wlnFZMEtaFiep1ML2TAdxjMLwOW8gDi
         WDTPh+u88BcENnA2bUV5829RV2F/4o74E2pGzE1almrZud467EcIhTsagB1+AMZWOkt9
         I/G41/fqw8yt4dirp1Yxp51smxK7Mkn0hVkJy/LsCWEDXZJaYlXdws+7Nq4GP5b+rv1y
         zsw8RB22spLH2gzgX00b628yAh1AMrJd6GKQkR1c3TldEuXPvXbnOBO6hGXBbT+76u1B
         BM4Q==
X-Gm-Message-State: AOAM531ZtJs3RI1Yao/SygIF2Zbw925OjAI6YsWsrB0HXPbQfBed6wWw
        6LcMZKdvY9OxVW84XHGKaoVuJUX/N/YFP97o/rxodg==
X-Google-Smtp-Source: ABdhPJyDO64UupsvHzKZ+uXicHV9pojGVjsnKvKeIpeBF5UnTZUYcv5/4kikw6z/aLV0TJ+GOWF+/7loV4mBXH53cLE=
X-Received: by 2002:a17:90b:349:: with SMTP id fh9mr4936936pjb.126.1618204459324;
 Sun, 11 Apr 2021 22:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <1617874514-12282-1-git-send-email-chunfeng.yun@mediatek.com>
 <1617874514-12282-4-git-send-email-chunfeng.yun@mediatek.com>
 <CAATdQgArnkdmbZefF4h7xp6=j-wHLgdQs1K0cDv06sP4eVdHmw@mail.gmail.com> <1617958441.12105.39.camel@mhfsdcap03>
In-Reply-To: <1617958441.12105.39.camel@mhfsdcap03>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Mon, 12 Apr 2021 13:14:09 +0800
Message-ID: <CAATdQgCjNbUKsJYZjr5wHbXV5y-7ZZrN=URKccCv1d+S4zFiDA@mail.gmail.com>
Subject: Re: [PATCH 4/6] usb: xhci-mtk: add support runtime PM
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-usb@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 9, 2021 at 4:54 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> On Fri, 2021-04-09 at 13:45 +0800, Ikjoon Jang wrote:
> > On Thu, Apr 8, 2021 at 5:35 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> > >
> > > A dedicated wakeup irq will be used to handle runtime suspend/resume,
> > > we use dev_pm_set_dedicated_wake_irq API to take care of requesting
> > > and attaching wakeup irq, then the suspend/resume framework will help
> > > to enable/disable wakeup irq.
> > >
> > > The runtime PM is default off since some platforms may not support it.
> > > users can enable it via power/control (set "auto") in sysfs.
> > >
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > ---
> > >  drivers/usb/host/xhci-mtk.c | 140 +++++++++++++++++++++++++++++++-----
> > >  1 file changed, 124 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> > > index a74764ab914a..30927f4064d4 100644
> > > --- a/drivers/usb/host/xhci-mtk.c
> > > +++ b/drivers/usb/host/xhci-mtk.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/of.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pm_runtime.h>
> > > +#include <linux/pm_wakeirq.h>
> > >  #include <linux/regmap.h>
> > >  #include <linux/regulator/consumer.h>
> > >
> > > @@ -358,7 +359,6 @@ static int usb_wakeup_of_property_parse(struct xhci_hcd_mtk *mtk,
> > >                         mtk->uwk_reg_base, mtk->uwk_vers);
> > >
> > >         return PTR_ERR_OR_ZERO(mtk->uwk);
> > > -
> > >  }
> > >
> > >  static void usb_wakeup_set(struct xhci_hcd_mtk *mtk, bool enable)
> > > @@ -458,6 +458,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
> > >         struct resource *res;
> > >         struct usb_hcd *hcd;
> > >         int ret = -ENODEV;
> > > +       int wakeup_irq;
> > >         int irq;
> > >
> > >         if (usb_disabled())
> > > @@ -485,6 +486,21 @@ static int xhci_mtk_probe(struct platform_device *pdev)
> > >         if (ret)
> > >                 return ret;
> > >
> > > +       irq = platform_get_irq_byname_optional(pdev, "host");
> > > +       if (irq < 0) {
> > > +               if (irq == -EPROBE_DEFER)
> > > +                       return irq;
> > > +
> > > +               /* for backward compatibility */
> > > +               irq = platform_get_irq(pdev, 0);
> > > +               if (irq < 0)
> > > +                       return irq;
> > > +       }
> > > +
> > > +       wakeup_irq = platform_get_irq_byname_optional(pdev, "wakeup");
> > > +       if (wakeup_irq == -EPROBE_DEFER)
> > > +               return wakeup_irq;
> > > +
> > >         mtk->lpm_support = of_property_read_bool(node, "usb3-lpm-capable");
> > >         /* optional property, ignore the error if it does not exist */
> > >         of_property_read_u32(node, "mediatek,u3p-dis-msk",
> > > @@ -496,9 +512,11 @@ static int xhci_mtk_probe(struct platform_device *pdev)
> > >                 return ret;
> > >         }
> > >
> > > +       pm_runtime_set_active(dev);
> > > +       pm_runtime_use_autosuspend(dev);
> > > +       pm_runtime_set_autosuspend_delay(dev, 4000);
> > >         pm_runtime_enable(dev);
> > >         pm_runtime_get_sync(dev);
> > > -       device_enable_async_suspend(dev);
> > >
> > >         ret = xhci_mtk_ldos_enable(mtk);
> > >         if (ret)
> > > @@ -508,12 +526,6 @@ static int xhci_mtk_probe(struct platform_device *pdev)
> > >         if (ret)
> > >                 goto disable_ldos;
> > >
> > > -       irq = platform_get_irq(pdev, 0);
> > > -       if (irq < 0) {
> > > -               ret = irq;
> > > -               goto disable_clk;
> > > -       }
> > > -
> > >         hcd = usb_create_hcd(driver, dev, dev_name(dev));
> > >         if (!hcd) {
> > >                 ret = -ENOMEM;
> > > @@ -579,8 +591,26 @@ static int xhci_mtk_probe(struct platform_device *pdev)
> > >         if (ret)
> > >                 goto dealloc_usb2_hcd;
> > >
> > > +       if (wakeup_irq > 0) {
> > > +               ret = dev_pm_set_dedicated_wake_irq(dev, wakeup_irq);
> > > +               if (ret) {
> > > +                       dev_err(dev, "set wakeup irq %d failed\n", wakeup_irq);
> > > +                       goto dealloc_usb3_hcd;
> > > +               }
> > > +               dev_info(dev, "wakeup irq %d\n", wakeup_irq);
> > > +       }
> > > +
> > > +       device_enable_async_suspend(dev);
> > > +       pm_runtime_mark_last_busy(dev);
> > > +       pm_runtime_put_autosuspend(dev);
> > > +       pm_runtime_forbid(dev);
> > > +
> > >         return 0;
> > >
> > > +dealloc_usb3_hcd:
> > > +       usb_remove_hcd(xhci->shared_hcd);
> > > +       xhci->shared_hcd = NULL;
> > > +
> > >  dealloc_usb2_hcd:
> > >         usb_remove_hcd(hcd);
> > >
> > > @@ -601,25 +631,26 @@ static int xhci_mtk_probe(struct platform_device *pdev)
> > >         xhci_mtk_ldos_disable(mtk);
> > >
> > >  disable_pm:
> > > -       pm_runtime_put_sync(dev);
> > > +       pm_runtime_put_sync_autosuspend(dev);
> > >         pm_runtime_disable(dev);
> > >         return ret;
> > >  }
> > >
> > > -static int xhci_mtk_remove(struct platform_device *dev)
> > > +static int xhci_mtk_remove(struct platform_device *pdev)
> > >  {
> > > -       struct xhci_hcd_mtk *mtk = platform_get_drvdata(dev);
> > > +       struct xhci_hcd_mtk *mtk = platform_get_drvdata(pdev);
> > >         struct usb_hcd  *hcd = mtk->hcd;
> > >         struct xhci_hcd *xhci = hcd_to_xhci(hcd);
> > >         struct usb_hcd  *shared_hcd = xhci->shared_hcd;
> > > +       struct device *dev = &pdev->dev;
> > >
> > > -       pm_runtime_put_noidle(&dev->dev);
> > > -       pm_runtime_disable(&dev->dev);
> > > +       pm_runtime_get_sync(dev);
> > > +       xhci->xhc_state |= XHCI_STATE_REMOVING;
> > > +       dev_pm_clear_wake_irq(dev);
> > > +       device_init_wakeup(dev, false);
> > >
> > >         usb_remove_hcd(shared_hcd);
> > >         xhci->shared_hcd = NULL;
> > > -       device_init_wakeup(&dev->dev, false);
> > > -
> > >         usb_remove_hcd(hcd);
> > >         usb_put_hcd(shared_hcd);
> > >         usb_put_hcd(hcd);
> > > @@ -627,6 +658,10 @@ static int xhci_mtk_remove(struct platform_device *dev)
> > >         xhci_mtk_clks_disable(mtk);
> > >         xhci_mtk_ldos_disable(mtk);
> > >
> > > +       pm_runtime_disable(dev);
> > > +       pm_runtime_put_noidle(dev);
> > > +       pm_runtime_set_suspended(dev);
> > > +
> > >         return 0;
> > >  }
> > >
> > > @@ -690,10 +725,83 @@ static int __maybe_unused xhci_mtk_resume(struct device *dev)
> > >         return ret;
> > >  }
> > >
> > > +static int check_rhub_status(struct xhci_hcd *xhci, struct xhci_hub *rhub)
> > > +{
> > > +       u32 suspended_ports;
> > > +       u32 status;
> > > +       int num_ports;
> > > +       int i;
> > > +
> > > +       num_ports = rhub->num_ports;
> > > +       suspended_ports = rhub->bus_state.suspended_ports;
> > > +       for (i = 0; i < num_ports; i++) {
> > > +               if (!(suspended_ports & BIT(i))) {
> > > +                       status = readl(rhub->ports[i]->addr);
> > > +                       if (status & PORT_CONNECT)
> >
> > So this pm_runtime support is activated only when there's no devices
> > connected at all?
> No, if the connected devices also support runtime suspend, it will enter
> suspend mode when no data transfer, then the controller can enter
> suspend too
> > I think this will always return -EBUSY with my board having an on-board hub
> > connected to both rhubs.
> the on-board hub supports runtime suspend by default, so if no devices
> connected, it will enter suspend

Sorry, you're correct. I was confused that the condition was
(suspended && connect)
My on-board hub connected to rhub is always in a suspended state
whenever it's called.

However, I don't think this could return -EBUSY
rpm_suspend() only be called when all the descendants are in sleep already.
Did you see any cases of this function returning -EBUSY or any concerns on here?


>
> >
> > > +                               return -EBUSY;
> > > +               }
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +/*
> > > + * check the bus whether it could suspend or not
> > > + * the bus will suspend if the downstream ports are already suspended,
> > > + * or no devices connected.
> > > + */
> > > +static int check_bus_status(struct xhci_hcd *xhci)
> > > +{
> > > +       int ret;
> > > +
> > > +       ret = check_rhub_status(xhci, &xhci->usb3_rhub);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       return check_rhub_status(xhci, &xhci->usb2_rhub);
> > > +}
> > > +
> > > +static int __maybe_unused xhci_mtk_runtime_suspend(struct device *dev)
> > > +{
> > > +       struct xhci_hcd_mtk  *mtk = dev_get_drvdata(dev);
> > > +       struct xhci_hcd *xhci = hcd_to_xhci(mtk->hcd);
> > > +       int ret = 0;
> > > +
> > > +       if (xhci->xhc_state)
> > > +               return -ESHUTDOWN;
> > > +
> > > +       if (device_may_wakeup(dev)) {
> > > +               ret = check_bus_status(xhci);
> > > +               if (!ret)
> > > +                       ret = xhci_mtk_suspend(dev);
> > > +       }
> > > +
> > > +       /* -EBUSY: let PM automatically reschedule another autosuspend */
> > > +       return ret ? -EBUSY : 0;
> > > +}
> > > +
> > > +static int __maybe_unused xhci_mtk_runtime_resume(struct device *dev)
> > > +{
> > > +       struct xhci_hcd_mtk  *mtk = dev_get_drvdata(dev);
> > > +       struct xhci_hcd *xhci = hcd_to_xhci(mtk->hcd);
> > > +       int ret = 0;
> > > +
> > > +       if (xhci->xhc_state)
> > > +               return -ESHUTDOWN;
> > > +
> > > +       if (device_may_wakeup(dev))
> > > +               ret = xhci_mtk_resume(dev);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > >  static const struct dev_pm_ops xhci_mtk_pm_ops = {
> > >         SET_SYSTEM_SLEEP_PM_OPS(xhci_mtk_suspend, xhci_mtk_resume)
> > > +       SET_RUNTIME_PM_OPS(xhci_mtk_runtime_suspend,
> > > +                          xhci_mtk_runtime_resume, NULL)
> > >  };
> > > -#define DEV_PM_OPS IS_ENABLED(CONFIG_PM) ? &xhci_mtk_pm_ops : NULL
> > > +
> > > +#define DEV_PM_OPS (IS_ENABLED(CONFIG_PM) ? &xhci_mtk_pm_ops : NULL)
> > >
> > >  static const struct of_device_id mtk_xhci_of_match[] = {
> > >         { .compatible = "mediatek,mt8173-xhci"},
> > > --
> > > 2.18.0
> > >
>
