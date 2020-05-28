Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3CA1E5CE3
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 12:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbgE1KPy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 06:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387753AbgE1KPV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 06:15:21 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9BDC08C5CB
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 03:15:10 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id c1so226152vsc.11
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 03:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wYvD4r1ulJrSPmdQw9SLGgFwZG+MxRo/QXyqHRDFej0=;
        b=CNJPDqLTi/IuZgQRPBMg2yxNxoePxYEAJVmhhtvE8OlJJFcBDQUOzDfbOfCRdSnmBm
         8uF8pKL4NTg9pkrglxDWZ43R5v8xOCf957HqPBm7Bhn60M/lvAwLr57p/Ec04gy7abhj
         /4Wr/kJ4dMPeVI264fensIP3MSNHMEexAFLX3Fzf3Lqf4WhgcXpcxmCS/Y7xgUxfTSxt
         jnKX1AM4ntK+UBYh2R3qgH0oZ8b7BSt6ccIfacVMJQzsWFM53tYNbs20i6aBM9XbeD/l
         DzQTZ3GEGyBcv9KYZSRZ+eLQTQgn6dhHS78QePY5HrkiMK0pbfisPhLL747if5W6pPEN
         SyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYvD4r1ulJrSPmdQw9SLGgFwZG+MxRo/QXyqHRDFej0=;
        b=neqFM95Pv9dEgOpiZQuitKmPAq7G5S9+GpZdPGwHnRokp/TWcGswNCgAhG89JfT6FS
         RvlW5//fNBmxNofBJqpfOrQpJJtQSjf6ct/X5B9gRGdfGGWIZqTlpphHrtfUHL/xnvso
         ZwUhEW1jazUEPH0bEhx+gaLPrupo4EOqpU0ntv/J4Lz8zv8SMIhy/Yqy/aIbt2Me4ssI
         Zs685Vl93HDMuQxpSHEMDrbEwi2JVn97m63F/oTj5XKV1COCLOXYHqg2lsptYZI5dP5q
         dr8o93u5HThcqNCiNZxYFyHWyPJ9eLtWgSDKtVuu64ldk17RK5Rm3Gu0wJpjJvxh9FDi
         cR1Q==
X-Gm-Message-State: AOAM530j66eiiKqR61y4/S7LS9e8DiRY/svBktnYX+FLQukDc3UJ6XNl
        3sLcZPwSbgLzluS3NevzCKf0/KmtqHT0EU/y/DUtvQ==
X-Google-Smtp-Source: ABdhPJxb2WnpVRS9U3plDTUUei62NNTnraVpSBNhYL/j1TslMciPD++P7b1aKtf45q8ShwLdi/3Vrx+gxW3AtR2NmzM=
X-Received: by 2002:a67:be05:: with SMTP id x5mr1263018vsq.35.1590660909658;
 Thu, 28 May 2020 03:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <1590547175-15070-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1590547175-15070-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 May 2020 12:14:33 +0200
Message-ID: <CAPDyKFrJMcKA89t7wMa8knOz4DwJ=ZPUf=RCeGcJK==UHjNQvw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: host: sdhci-esdhc-imx: add wakeup feature for
 GPIO CD pin
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 27 May 2020 at 04:50, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> When use the specific GPIO to detect the card insert/remove, we can
> also add the GPIO as a wakeup source. When system suspend, insert or
> remove the card can wakeup the system.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 5398af4824c3..5a27511438c8 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1599,6 +1599,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>         if (esdhc_is_usdhc(imx_data)) {
>                 host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
>                 host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
> +
> +               /* GPIO CD can be set as a wakeup source */
> +               host->mmc->caps |= MMC_CAP_CD_WAKE;
> +
>                 if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
>                         host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
>
> @@ -1734,8 +1738,14 @@ static int sdhci_esdhc_suspend(struct device *dev)
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
> +       ret = mmc_gpio_set_cd_wake(host->mmc, true);
>
>         return ret;
>  }
> @@ -1759,6 +1769,9 @@ static int sdhci_esdhc_resume(struct device *dev)
>         if (host->mmc->caps2 & MMC_CAP2_CQE)
>                 ret = cqhci_resume(host->mmc);
>
> +       if (!ret)
> +               ret = mmc_gpio_set_cd_wake(host->mmc, false);
> +
>         return ret;
>  }
>  #endif
> --
> 2.17.1
>
