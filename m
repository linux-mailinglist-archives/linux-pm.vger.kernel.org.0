Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379561E211F
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 13:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgEZLnn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 07:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731539AbgEZLnm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 07:43:42 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB797C03E97E
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2020 04:43:42 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id a68so729483vsd.8
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2020 04:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nPdu7SPTh7JNX7Uc2Z7FhGt13qKrZbymgkVtLODSfA4=;
        b=ZwYOS+cV7mJ83i9sr2VExWXiEFDnq/JqhbFXX3fAzvAOd2oPuprKymA6ETAeP8GLqm
         vL5jZBCNjHihDatlNRKcDFnK8MmiWCN1sXxalNaD9LTWUIqelPlo0st0vrUa40U7qu7i
         XzjQoWcFOv8iMrkaQ+jw5n7utfuSi5UWtzQiNV6lglrMugIvxm1WbZM7DmEjLRwk4E83
         brPR3zg3zu/gefBQWQFSAo4/iRw204LTUubMH8VQ/uKzQwNZg2D6yDvHlnu1BUsgjm8I
         8tpFcbUsS0WLKUvjWWMw+sOg3wmf119zvHke6fIkU+5FdDPV2BX0y+bB8twggxD817B2
         qpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nPdu7SPTh7JNX7Uc2Z7FhGt13qKrZbymgkVtLODSfA4=;
        b=Aw2LltTeW7V7FozQXI6Npv+AJ4dqF3/5RCDwKpwwFKx1qgAH8/VKeUOG6wrgEC6aju
         8u0SgRTLF9qXjCrwXkcOomouUxeHZLfjvbDyqf8tWbiCXyvwW/8ACvBhsrukmNtxJw8/
         /mtk3HdzTL51Egl5yR1bszA0A02C//ZJKj+skpIkG7PXNzJb/R/5d9glG3nNv2LuxBT/
         1KfeHT7RFstcQeGppa1OAbl7IZR9KQIajMKroapimckkojMij6uBTrDXGP4eOfI+RhkA
         lgE0u7C0N1ERLtzDsjpCiTPWwDz20xxjia9nrJZiWKfQ7GhYLZJ/hJ+xJoUx3b8wSD2u
         X0bw==
X-Gm-Message-State: AOAM5318k8PgCnjCE3FqpDeUYcuU4X8tZTOvT22XtwE9dImeD9jP/e9Y
        wohynQ6Q10Z9JH3PRlQu2ufw5oVTTJDYh1zE0kTPFQ==
X-Google-Smtp-Source: ABdhPJxX3ByxW2H4N6c89dFaCJvwdMVe5SnL4enMfxjWHotYtz6hvN2m1vJ0v196TxJgcUHhkScnUgdJSyhPeOpEZus=
X-Received: by 2002:a67:690e:: with SMTP id e14mr512853vsc.34.1590493421821;
 Tue, 26 May 2020 04:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <1590481839-28603-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1590481839-28603-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 May 2020 13:43:05 +0200
Message-ID: <CAPDyKFqjZdN0zv2iW+Rq6WZSo56HfyPFYHvg-JvzYZPy_eTSBQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: add wakeup feature for GPIO
 CD pin
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+ Rafael, linux-pm

On Tue, 26 May 2020 at 10:41, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> When use the specific GPIO to detect the card insert/remove, we can
> also add the GPIO as a wakeup source. When system suspend, insert or
> remove the card can wakeup the system.

Yes, this makes perfect sense! However...

>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 5398af4824c3..7af9d87d4245 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1599,6 +1599,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>         if (esdhc_is_usdhc(imx_data)) {
>                 host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
>                 host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
> +
> +               /* GPIO CD can be set as a wakeup source */
> +               host->mmc->caps |= MMC_CAP_CD_WAKE;
> +               device_init_wakeup(&pdev->dev, true);
> +

... if the device is attached to a genpd (a PM domain), this may cause
it to stay powered on in the system suspend state. Not sure if that
can cause a problem for you? Wasting energy?

In any case, I think it's wrong to make "&pdev->dev" wakeup capable,
like this. Especially as at it's the GPIO controller that manages the
system wakeup irq.

>                 if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
>                         host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
>
> @@ -1734,8 +1739,15 @@ static int sdhci_esdhc_suspend(struct device *dev)
>                 mmc_retune_needed(host->mmc);
>
>         ret = sdhci_suspend_host(host);
> -       if (!ret)
> -               return pinctrl_pm_select_sleep_state(dev);
> +       if (ret)
> +               return ret;
> +
> +       ret = pinctrl_pm_select_sleep_state(dev);
> +       if (ret)
> +               return ret;
> +
> +       if (device_may_wakeup(dev))
> +               ret = mmc_gpio_set_cd_wake(host->mmc, true);

With the above said, I think the best available approach at this
point, is to just call mmc_gpio_set_cd_wake() - and just skip checking
device_may_wakeup().

BTW, mmc_gpio_set_cd_wake() calls enable_irq_wake(), which doesn't
require the "dev" to be wakeup capable. So this is fine!

Yes, it means that the IRQ will be configured as a system wakeup,
without letting user space to have a say about it. I guess we can live
with that limitation.

>
>         return ret;
>  }
> @@ -1759,6 +1771,9 @@ static int sdhci_esdhc_resume(struct device *dev)
>         if (host->mmc->caps2 & MMC_CAP2_CQE)
>                 ret = cqhci_resume(host->mmc);
>
> +       if (!ret && device_may_wakeup(dev))
> +               ret = mmc_gpio_set_cd_wake(host->mmc, false);
> +
>         return ret;
>  }
>  #endif
> --
> 2.17.1
>

Kind regards
Uffe
