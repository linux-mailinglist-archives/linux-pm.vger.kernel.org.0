Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519AE340D56
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 19:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhCRSlf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 14:41:35 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:41692 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbhCRSlK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 14:41:10 -0400
Received: by mail-oi1-f171.google.com with SMTP id z15so1993812oic.8;
        Thu, 18 Mar 2021 11:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50YLVfDsFXQ/kGjvlV5rl7kbysJ3W1UnGtW1SEXmj2E=;
        b=MtKu408gR8Guxk3jMn8uawHXrOxhZXUjP1gxXcvYEFfY6hoqIBVQaaGCdKrMmrVP8V
         RSkEJii9Pyn6+107RHZ0qngyISeTJPXicnCAhP9SxbxMKL+7yDYjvO9W5QovchOXUIW0
         WWjFrTwzWf8TeFR27qjXl2iwKd+tbTEwx3FC6vv9NDQ0JXPsi5TmZK/esuf2/Qzr6f4S
         6Mpgfzzk7lr8PZoP1BydUH1j27EYmshiB8zyCJtWHyLR8/BGRu+GpI139wA89KOaXbu6
         SmKeSiLmpaHYUfrx5mX2H3g4RbZ9lkCaH35a+Iva31bj7bsCKnuqxEbkMzOQi+YaJpIB
         d/VA==
X-Gm-Message-State: AOAM531aW9udCTWVf9RgONvDwh01SGkRCXbuWsFHZk59fASfMfWt9SU0
        KIUP8C4SA1cOuM8K5H2S82rA+92hxHenwgcbSBI=
X-Google-Smtp-Source: ABdhPJz0qrQoo/myTzHMNUyB7rMPK90G379owMKxA8PT8Jkc4eGWT1DJyYdwTs5AlD1NcVaxSrbKQJOVZKaYntjxVaA=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr3938616oib.69.1616092870064;
 Thu, 18 Mar 2021 11:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210304192843.216829-1-ulf.hansson@linaro.org>
In-Reply-To: <20210304192843.216829-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Mar 2021 19:40:59 +0100
Message-ID: <CAJZ5v0h7PeqXXtj0J=JaBJkuMTvKXXOCN3xL5Omu6vej_vWCwg@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Don't runtime resume devices at genpd_prepare()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 4, 2021 at 8:30 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Runtime resuming a device upfront in the genpd_prepare() callback, to check
> if there is a wakeup pending for it, seems like an unnecessary thing to do.
> The PM core already manages these kind of things in a common way in
> __device_suspend(), via calling pm_runtime_barrier() and
> pm_wakeup_pending().
>
> Therefore, let's simply drop this behaviour from genpd_prepare().
>
> Note that, this change is applicable only for devices that are attached to
> a genpd that has the GENPD_FLAG_ACTIVE_WAKEUP set (Renesas, Mediatek, and
> Rockchip platforms). Moreover, a driver that needs to restore power for its
> device to re-configure it for a system wakeup, may still call
> pm_runtime_get_sync(), for example, to do this.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 36 ------------------------------------
>  1 file changed, 36 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 78c310d3179d..b6a782c31613 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1087,34 +1087,6 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
>         genpd->status = GENPD_STATE_ON;
>  }
>
> -/**
> - * resume_needed - Check whether to resume a device before system suspend.
> - * @dev: Device to check.
> - * @genpd: PM domain the device belongs to.
> - *
> - * There are two cases in which a device that can wake up the system from sleep
> - * states should be resumed by genpd_prepare(): (1) if the device is enabled
> - * to wake up the system and it has to remain active for this purpose while the
> - * system is in the sleep state and (2) if the device is not enabled to wake up
> - * the system from sleep states and it generally doesn't generate wakeup signals
> - * by itself (those signals are generated on its behalf by other parts of the
> - * system).  In the latter case it may be necessary to reconfigure the device's
> - * wakeup settings during system suspend, because it may have been set up to
> - * signal remote wakeup from the system's working state as needed by runtime PM.
> - * Return 'true' in either of the above cases.
> - */
> -static bool resume_needed(struct device *dev,
> -                         const struct generic_pm_domain *genpd)
> -{
> -       bool active_wakeup;
> -
> -       if (!device_can_wakeup(dev))
> -               return false;
> -
> -       active_wakeup = genpd_is_active_wakeup(genpd);
> -       return device_may_wakeup(dev) ? active_wakeup : !active_wakeup;
> -}
> -
>  /**
>   * genpd_prepare - Start power transition of a device in a PM domain.
>   * @dev: Device to start the transition of.
> @@ -1135,14 +1107,6 @@ static int genpd_prepare(struct device *dev)
>         if (IS_ERR(genpd))
>                 return -EINVAL;
>
> -       /*
> -        * If a wakeup request is pending for the device, it should be woken up
> -        * at this point and a system wakeup event should be reported if it's
> -        * set up to wake up the system from sleep states.
> -        */
> -       if (resume_needed(dev, genpd))
> -               pm_runtime_resume(dev);
> -
>         genpd_lock(genpd);
>
>         if (genpd->prepared_count++ == 0)
> --

Applied as 5.13 material, thanks!
