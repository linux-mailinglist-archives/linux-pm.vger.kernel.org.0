Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CE71B23FE
	for <lists+linux-pm@lfdr.de>; Tue, 21 Apr 2020 12:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgDUKkA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Apr 2020 06:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgDUKj7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2020 06:39:59 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE39C061A0F
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2020 03:39:59 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id o3so8088667vsd.4
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2020 03:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWOnko77txal0K7pJvRHJBebpvxdOfp3TVzw/ZvqiSM=;
        b=sZb0j1ADnFw2pQCOR1I1/JAIJ2vP4Lj+6zzr6vrUr1JZpY+SKjo0VNeVwo35qRCV+F
         1PPJMFAXIMfTGbxOXoZVrDf4gUZcRWtESA1GBPl60kn1gEdf5gq6fuwNsXgGh4eG28Yz
         ZCr/66YuuY54OOylETzfZ17pWqnkCBWP/fxDWULm5idzduPopFhWtKSajwoZg2GehXJx
         nbIQcoW8hWGVGSw73GXi1zBuTqJzyH0yKhBtjNENJlQ/1Hhp6xz73dZStiIjb+jT/Jkd
         KedNNlRpRTAdqOhMd/jZ2wkg5Fv6T82MGFWxWfAM8S9LMNKw6ywmJ9bqrBm6MTtBi3tb
         CRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWOnko77txal0K7pJvRHJBebpvxdOfp3TVzw/ZvqiSM=;
        b=aAv4Yv84nDSz02sDA57JynNa8g0Ojk3LXZ35av2S2vF1DIAeSKz2g9oj9UcT03km5U
         eW//Dy+wYH3KPqWm5G3f8yOhUuSkLFJuHgd7ExX+lq3DSQNzrnJ1KYdPD8ZEvqvQV8f/
         8cIfSsppcZ7nLMnMmxiLTP8wDvThUtS0Eht4sj1s7yV3kwexjhbaRdGWcoVcah2wGjyY
         8qem8+7ZMi7SaALOIG913a0cnz2rrC5gbBm9T8/kRZZennv76Z8XHt3FrHA6QbQfCzka
         agc1SvPK3g6xSLA7zy+WzhZIcJ5gsKQsENfoV9b/J4HexTpT3bJPiGzRuoRCeDDZ5jCx
         +1Qg==
X-Gm-Message-State: AGi0PuZjBgpueGJCBcMjKGWtN3fb/hltCtQ8Blo6DZhuuuxMChUxpbbV
        yKg2Dw4Chh9zG2I4kQoZZsutGQSSff54SCpjHkSX6g==
X-Google-Smtp-Source: APiQypKISV66Pw/5T+dsPNqBQ+0UbOK10keNAQzmOGZsGfLJ0yfsb04HQOYUoTZ32K7OtcDuVGegOMCuwdmU2fcyQrk=
X-Received: by 2002:a67:ead1:: with SMTP id s17mr14820744vso.200.1587465598574;
 Tue, 21 Apr 2020 03:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200413123207.74552-1-paul@crapouillou.net> <20200413123207.74552-3-paul@crapouillou.net>
In-Reply-To: <20200413123207.74552-3-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Apr 2020 12:39:22 +0200
Message-ID: <CAPDyKFrRMzzodhWSC2tgMSSNBwLcowd7q48_6dFPGuHUD_CUZg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: jz4740: Use pm_ptr() macro
To:     Paul Cercueil <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        od@zcrc.me,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 13 Apr 2020 at 14:32, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Use the newly introduced pm_ptr() macro to simplify the code.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

To me, the series is a step in the right direction. Perhaps there is a
better name than "pm_ptr", but that's just a nitpick.

That said, feel free to add (for all three patches in the series):
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Let's see what Rafael thinks about this.

Kind regards
Uffe

> ---
>
> Notes:
>     v2: Use pm_ptr() macro instead of pm_sleep_ptr()
>
>  drivers/mmc/host/jz4740_mmc.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index fbae87d1f017..2d41e7e5ec43 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -1099,24 +1099,18 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM_SLEEP
> -
> -static int jz4740_mmc_suspend(struct device *dev)
> +static int __maybe_unused jz4740_mmc_suspend(struct device *dev)
>  {
>         return pinctrl_pm_select_sleep_state(dev);
>  }
>
> -static int jz4740_mmc_resume(struct device *dev)
> +static int __maybe_unused jz4740_mmc_resume(struct device *dev)
>  {
>         return pinctrl_select_default_state(dev);
>  }
>
>  static SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
>         jz4740_mmc_resume);
> -#define JZ4740_MMC_PM_OPS (&jz4740_mmc_pm_ops)
> -#else
> -#define JZ4740_MMC_PM_OPS NULL
> -#endif
>
>  static struct platform_driver jz4740_mmc_driver = {
>         .probe = jz4740_mmc_probe,
> @@ -1124,7 +1118,7 @@ static struct platform_driver jz4740_mmc_driver = {
>         .driver = {
>                 .name = "jz4740-mmc",
>                 .of_match_table = of_match_ptr(jz4740_mmc_of_match),
> -               .pm = JZ4740_MMC_PM_OPS,
> +               .pm = pm_ptr(&jz4740_mmc_pm_ops),
>         },
>  };
>
> --
> 2.25.1
>
