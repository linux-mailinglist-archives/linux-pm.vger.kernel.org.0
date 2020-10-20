Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7502941A9
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 19:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391772AbgJTRoT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 13:44:19 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34493 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391771AbgJTRoS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 13:44:18 -0400
Received: by mail-oi1-f194.google.com with SMTP id n3so3034006oie.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 10:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwM+oHGYyaKFQxvWDCBNLQLma9Ytjb9tBcj+VURgZT4=;
        b=ln7BNJxctUUB9wvxpEiNUIg+IMPpT3T5pT9y5IP1P5hmLShUBa7M/26EnK7/9Bu+M8
         FmF6Wn1KTw12eFiaIa15jpT6Tk/tNhFiMdaKCwPZAiFNlrji2zQJSQKUKTbxYsFtdomj
         JgeEC25YRVjZCD+v+EjxcewirKBphDNk2h7MqFWwoJ0A4cBOzFVTisGO/r5HYGxk1nvt
         Y3zANntdESU5iMoQdXQJcQVB1ztOwRhbQt574nopRpAK36WhfhcbxV00y3rwjGdcFuLe
         dFm0UB+I7HTMYqmpSPZVZxV9FTAZUTH5vQEdGv5Z3fYJaMDpDRvER3sns1ACxSAV9Dui
         Xdgw==
X-Gm-Message-State: AOAM532aMvQcazEtlr3x7H+FipMhGZACM7tNTFSAy/fcfwTT4XirP9wM
        kAmuxXHjDYmhOLeDa12yBM6evB0jMpnttTHTVvg=
X-Google-Smtp-Source: ABdhPJzzJ7OB7OmNdHBeLythO4I9lErxMY5zcpN8R+7J7znDBWEjMiaekpLuAcVDkqph0r8/YWeGGWIaOGa5Uw17e+Q=
X-Received: by 2002:aca:fd52:: with SMTP id b79mr2606887oii.69.1603215857804;
 Tue, 20 Oct 2020 10:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201020081035.563849-1-ulf.hansson@linaro.org>
In-Reply-To: <20201020081035.563849-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Oct 2020 19:44:06 +0200
Message-ID: <CAJZ5v0hep9-wUqGdzXqOR9ELqkkTvUaSyjRq0BVGbUVx8d09Rg@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Fix build error for genpd notifiers
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Kevin Hilman <khilman@kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 20, 2020 at 10:10 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The __raw_notifier_call_chain() was recently removed and replaced with
> raw_notifier_call_chain_robust(). Recent changes to genpd didn't take that
> into account, which causes a build error. Let's fix this by converting to
> the raw_notifier_call_chain_robust() in genpd.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Rafael, feel free to to squash this into the patch "PM: domains: Add support
> for PM domain on/off notifiers for genpd".

Applied separately, thanks!

> ---
>  drivers/base/power/domain.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 859cdb207010..743268996336 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -413,15 +413,15 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>         unsigned int state_idx = genpd->state_idx;
>         ktime_t time_start;
>         s64 elapsed_ns;
> -       int ret, nr_calls = 0;
> +       int ret;
>
>         /* Notify consumers that we are about to power on. */
> -       ret = __raw_notifier_call_chain(&genpd->power_notifiers,
> -                                       GENPD_NOTIFY_PRE_ON, NULL, -1,
> -                                       &nr_calls);
> +       ret = raw_notifier_call_chain_robust(&genpd->power_notifiers,
> +                                            GENPD_NOTIFY_PRE_ON,
> +                                            GENPD_NOTIFY_OFF, NULL);
>         ret = notifier_to_errno(ret);
>         if (ret)
> -               goto err;
> +               return ret;
>
>         if (!genpd->power_on)
>                 goto out;
> @@ -462,15 +462,15 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
>         unsigned int state_idx = genpd->state_idx;
>         ktime_t time_start;
>         s64 elapsed_ns;
> -       int ret, nr_calls = 0;
> +       int ret;
>
>         /* Notify consumers that we are about to power off. */
> -       ret = __raw_notifier_call_chain(&genpd->power_notifiers,
> -                                       GENPD_NOTIFY_PRE_OFF, NULL, -1,
> -                                       &nr_calls);
> +       ret = raw_notifier_call_chain_robust(&genpd->power_notifiers,
> +                                            GENPD_NOTIFY_PRE_OFF,
> +                                            GENPD_NOTIFY_ON, NULL);
>         ret = notifier_to_errno(ret);
>         if (ret)
> -               goto busy;
> +               return ret;
>
>         if (!genpd->power_off)
>                 goto out;
> @@ -502,10 +502,7 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
>                                 NULL);
>         return 0;
>  busy:
> -       if (nr_calls)
> -               __raw_notifier_call_chain(&genpd->power_notifiers,
> -                                         GENPD_NOTIFY_ON, NULL, nr_calls - 1,
> -                                         NULL);
> +       raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON, NULL);
>         return ret;
>  }
>
> --
> 2.25.1
>
