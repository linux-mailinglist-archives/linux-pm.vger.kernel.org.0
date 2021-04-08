Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12CB358B8D
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 19:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhDHRle (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 13:41:34 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:38693 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbhDHRld (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 13:41:33 -0400
Received: by mail-oi1-f181.google.com with SMTP id 25so1533671oiy.5;
        Thu, 08 Apr 2021 10:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MxPv9rGDLS4kNaUwF1zjTD50xd/6Z8XGBbW4dmhPKD8=;
        b=A2lp3oM0ItWq0xqfVnnJ3qVaiuOO3KsJ94X+E1AqzUrxBH2KeRrfGIxLILWRiuXIJv
         ZjNkaAtXAnZ31OcKco2QcSOMQ57i87H0SlKSeVPyMRKdvkGfyQ9Av/vc57KHDHfIUvaZ
         sKh0tG7XXhSdtAe5CEl3fj/jkgyOTz5XaX1QuOaWljBtXt/TDCH8gSDW6zVkiNOHY52a
         cvW/Jg4xTcREQcda3OuZlTzOekZTMk3n7LLJnVEzIlJNSRE1dAdMYPn/w4syyK3DrtZ/
         t+M218Ihp4d6s/pnuU/UuXJLtUhsK2dpD3Smv65BYbTmSXTUk4Pf6p+SW6CtZcmqkML+
         qU6g==
X-Gm-Message-State: AOAM5313SyItVaHcVZmvPqqnJoNik09lQ95dqpaVLoTurNQCm0Drw/Pg
        pU6RHC/mwiNFTdFYm1FrfhEaDQYjpWt3wRdbvhs=
X-Google-Smtp-Source: ABdhPJzwd+elJ0tSpUAZ/bAgTRpxq7RiABgs8Q08DleA2nKQdp22al42iOL7Z8aA5oAFMXMC6gZjSOTm29nDYVKPpLc=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr6817482oib.69.1617903681158;
 Thu, 08 Apr 2021 10:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <1617874514-12282-1-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1617874514-12282-1-git-send-email-chunfeng.yun@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 19:41:10 +0200
Message-ID: <CAJZ5v0gGntbfnvAP5A491_hUh-JUuqZjZRdPPLwWJjnZRtemcQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] PM: runtime: enable wake irq after runtime_suspend
 hook called
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 8, 2021 at 11:35 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> When the dedicated wake irq is level trigger, enable it before
> calling runtime_suspend, will trigger an interrupt.
>
> e.g.
> for a low level trigger type, it's low level at running time (0),
> and becomes high level when enters suspend (runtime_suspend (1) is
> called), a wakeup signal at (2) make it become low level, wake irq
> will be triggered.
>
>                 ------------------
>                |           ^     ^|
> ----------------           |     | --------------
>  |<---(0)--->|<--(1)--|   (3)   (2)    (4)
>
> if we enable the wake irq before calling runtime_suspend during (0),
> an interrupt will arise, it causes resume immediately;

But that's necessary to avoid missing a wakeup interrupt, isn't it?

> enable wake irq after calling runtime_suspend, e.g. at (3) or (4),
> will works.
>
> This patch seems no side effect on edge trigger wake irq.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/base/power/runtime.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index a46a7e30881b..796739a015a5 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -619,12 +619,12 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>         __update_runtime_status(dev, RPM_SUSPENDING);
>
>         callback = RPM_GET_CALLBACK(dev, runtime_suspend);
> -
> -       dev_pm_enable_wake_irq_check(dev, true);
>         retval = rpm_callback(callback, dev);
>         if (retval)
>                 goto fail;
>
> +       dev_pm_enable_wake_irq_check(dev, true);
> +
>   no_callback:
>         __update_runtime_status(dev, RPM_SUSPENDED);
>         pm_runtime_deactivate_timer(dev);
> @@ -659,7 +659,6 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>         return retval;
>
>   fail:
> -       dev_pm_disable_wake_irq_check(dev);
>         __update_runtime_status(dev, RPM_ACTIVE);
>         dev->power.deferred_resume = false;
>         wake_up_all(&dev->power.wait_queue);
> --
> 2.18.0
>
