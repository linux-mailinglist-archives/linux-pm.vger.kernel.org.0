Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D917A3CB785
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jul 2021 14:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhGPMz1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jul 2021 08:55:27 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:40515 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbhGPMz0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jul 2021 08:55:26 -0400
Received: by mail-oi1-f182.google.com with SMTP id y66so1343273oie.7;
        Fri, 16 Jul 2021 05:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OhBcbe2dVSwxljU3THZHc5weqYHN49Maj4g0lBcFesI=;
        b=N/xb+nKjTT/rby5oFpohPCzbJBHeUTNzpfc4iB9pWNo58Fgr5fypvM+4W/4vMKErmL
         ZKibqd1c9U2n6BANloJJMKvbv9DagP3DkL0iIb0kCWh/+bRSj9tWcP8Lj62CmjwUzRKf
         urFcUSl2Oe6icZsdfojYDJiKemC+4OV3NURIDFlh5usV4zR19i0bTmtwYs0om/ALLaec
         nYVdHl40fEBmoNSlUqtN4RTbW4DE4e6hEWTFZEkfGggyqZSOgTYFsjrlCjnq49iDfAcq
         B4RwazFvmB05YNYoadZ6s6MUxudYpy2VbBOKGvK+ao0GWAgckcDq4fwU9/+UFJVClNwC
         ts+g==
X-Gm-Message-State: AOAM5310rjritaQVflSX/HL7tmqUQvo/0k7eDm8pSmOf+I8rY2wO7iFl
        3jaicATLrfQ9NCbQTNzwJz4C9IFqnjQKJDMb1Kg=
X-Google-Smtp-Source: ABdhPJyUZyO2re08hoo9vsf7166rXHZT/04sruY6Fk2rTLDKNBvM7NGzIrvcsP5I+IDtq5aWTFizOhEpIYPvFzgIIx4=
X-Received: by 2002:a05:6808:10d0:: with SMTP id s16mr7413089ois.69.1626439951624;
 Fri, 16 Jul 2021 05:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <1626427381-30131-1-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1626427381-30131-1-git-send-email-chunfeng.yun@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Jul 2021 14:52:20 +0200
Message-ID: <CAJZ5v0iH7D=D70ea7Q0LqP0iUdRYPf4GH2g7dC7J2_54WW1C8A@mail.gmail.com>
Subject: Re: [PATCH v2] PM: runtime: enable wake irq after runtime_suspend
 hook called
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ikjoon Jang <ikjn@chromium.org>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 16, 2021 at 11:23 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> When the dedicated wake-irq is level trigger, and it uses the
> consumer's sleep status as the wakeup source,

This is not a typical case, though, AFAICS.

So you seem to have a special requirement and you want to change a
generic framework in an incompatible way to accommodate it.

> that means if the
> consumer is not in sleep state, the wake-irq will be triggered
> when enable it; For this case, need enable the wake-irq after
> invoking the consumer's runtime_suspend() which make the consumer
> enter sleep state.
>
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
> In this example, can't fix it by using falling edge trigger without
> this patch, the issue will happen as below steps:
> 1. use another wakeup source to wake up the suspended system;
> 2. the consumer's resume() will be called, and exits sleep state;
> 3. the consumer's wakeup signal will fall into low level, due to
>    currently the wakeup irq is disabled, the wake-irq is pending;
> 4. the consumer tries to enter runtime suspend, but there is a
>    pending wakeup irq, so will resume again, this will repeat
>    endlessly.
>
> This patch seems no side effect on edge trigger wake-irq that works
> before.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: add more commit message
>
>   I use the falling edge trigger interrupt suggested by Ikjoon [1], it
> works well at firstly when only use this related wakeup source, but
> encounter issues if use other wakeup sources to wakeup platform as
> described in commit message.
>   Send out the patch again for further discussion.
>
> [1]: https://patchwork.kernel.org/patch/12190407
>
> ---
>  drivers/base/power/runtime.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 8a66eaf731e4..90a91b2b1364 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -639,12 +639,12 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>         __update_runtime_status(dev, RPM_SUSPENDING);
>
>         callback = RPM_GET_CALLBACK(dev, runtime_suspend);
> -
> -       dev_pm_enable_wake_irq_check(dev, true);

I would suggest adding a wake IRQ flag to indicate that it needs
special handling and modifying the above to take that new flag into
account.

>         retval = rpm_callback(callback, dev);
>         if (retval)
>                 goto fail;
>
> +       dev_pm_enable_wake_irq_check(dev, true);

Then, you can add an entirely new call here, say
dev_pm_enable_wake_irq_complete(dev), that will do the actual enable
for the wake IRQs with the new flag set and nothing for the others.

> +
>   no_callback:
>         __update_runtime_status(dev, RPM_SUSPENDED);
>         pm_runtime_deactivate_timer(dev);
> @@ -690,7 +690,6 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>         return retval;
>
>   fail:
> -       dev_pm_disable_wake_irq_check(dev);

And obviously this will really disable wake IRQs with the new flag unset only.

>         __update_runtime_status(dev, RPM_ACTIVE);
>         dev->power.deferred_resume = false;
>         wake_up_all(&dev->power.wait_queue);
> --
> 2.18.0
>
