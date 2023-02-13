Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47FA694777
	for <lists+linux-pm@lfdr.de>; Mon, 13 Feb 2023 14:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjBMNxV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Feb 2023 08:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjBMNxU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Feb 2023 08:53:20 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9620B55BE
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 05:53:19 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id h19so13054518vsv.13
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 05:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0DMXcQ/Xr9AOEHvP493Rxbl8zppGqGOxCQPtcsMIis=;
        b=m4cnRnXkLYroIo5/TW82kK8nxL75P9Gv+do7twWXRtervMa7QhfrhOGFEWNmCV4S7K
         I6kcHZivxUpvTSFEmIAWeNmNmb4lxdQay8xvu1Yep8n5qBKvXUzBO4m23B0W2zj7UUhU
         PvlCIRKwlR5NmGhvN1JypQZwvBtjki+TJ8rwkS2aUf4y/S42o6BdwRkyo51TmJrnCP0T
         W0ohVE3r5srxXUI1OCCuZLGasoT4h6KBgTli5TO81D9FfgEbooXBA7EPb0qZQbTtjEcL
         HoT3lOx24NXEty9mkykLqjj/LkqdvwotHtCSgO8XWahPDMk3JnGR8dNJboCen3CrjtVg
         Ej8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0DMXcQ/Xr9AOEHvP493Rxbl8zppGqGOxCQPtcsMIis=;
        b=rmdn91qTC0fN71u/DG6cPFsp2BL4iesODWpHqS1ZLeo+tpvYYtYxeZ2i9DjBWS4ZVX
         /TGS+ouqctNZLwQdyjvsRciXUfsHWE7A5kJCFxGIF6y4o1KVLesLqdGZ6np0LUBkoazJ
         QwfbkTQDphEHzW3gW0j5o1sNZt2mbKI2rxBuUaUtOF2LZrREqmpcvgh7NEcu7pPCBFUL
         E/5UCq9UEezOpiKkK9NOIKUFhFOTp5DzsPa/Te89eDiPb7ZaNyIm74ANTQ8CltAm2k3V
         U6VuRQCVg4p0Cmk/Ikn370VwlI54NLOgUot8Zs6ZxOYD/LGS8rhs1dBWPeazYRu/cyNd
         uldw==
X-Gm-Message-State: AO0yUKVqMahMU6SsJa4XJSMQIVI97Auc4wo+EMwxDEmkVejkF3lvDNBZ
        MHF0iORHRLB8jakvd5/WYUOgiuea0IoDCfVWYjN5txxXw8sPVQ==
X-Google-Smtp-Source: AK7set8gjGVlrvnoj9rnZ8LvHhhCbcmA05SEjzpxgMmMO0JUBisdf3fmVpvizDtVgtAGcA1Zx0MRZ17tA6el7GGoEVg=
X-Received: by 2002:a05:6102:d86:b0:3fd:7046:9232 with SMTP id
 d6-20020a0561020d8600b003fd70469232mr4197051vst.29.1676296398667; Mon, 13 Feb
 2023 05:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20230210212528.179627-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230210212528.179627-1-u.kleine-koenig@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 13 Feb 2023 14:53:07 +0100
Message-ID: <CAMRc=Md-997mohAyUGGrf28zvTX1voKO24DWgfCjCLDKsRYu+A@mail.gmail.com>
Subject: Re: [PATCH] power: supply: max77650: Make max77650_charger_disable()
 return void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 10, 2023 at 10:25 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The return value of max77650_charger_disable() is ignored by all but one
> caller. That one caller propagates the error code in the platform driver'=
s
> remove function. The only effect of that is that the driver core emits
> a generic error message (but still removes the device). As
> max77650_charger_disable() already emits an error message, this can bette=
r
> be changed to return zero.
>
> This is a preparation for making struct platform_driver::remove return
> void, too.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/power/supply/max77650-charger.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/power/supply/max77650-charger.c b/drivers/power/supp=
ly/max77650-charger.c
> index d913428bedc0..e8c25da40ab2 100644
> --- a/drivers/power/supply/max77650-charger.c
> +++ b/drivers/power/supply/max77650-charger.c
> @@ -141,7 +141,7 @@ static int max77650_charger_enable(struct max77650_ch=
arger_data *chg)
>         return rv;
>  }
>
> -static int max77650_charger_disable(struct max77650_charger_data *chg)
> +static void max77650_charger_disable(struct max77650_charger_data *chg)
>  {
>         int rv;
>
> @@ -151,8 +151,6 @@ static int max77650_charger_disable(struct max77650_c=
harger_data *chg)
>                                 MAX77650_CHARGER_DISABLED);
>         if (rv)
>                 dev_err(chg->dev, "unable to disable the charger: %d\n", =
rv);
> -
> -       return rv;
>  }
>
>  static irqreturn_t max77650_charger_check_status(int irq, void *data)
> @@ -351,7 +349,9 @@ static int max77650_charger_remove(struct platform_de=
vice *pdev)
>  {
>         struct max77650_charger_data *chg =3D platform_get_drvdata(pdev);
>
> -       return max77650_charger_disable(chg);
> +       max77650_charger_disable(chg);
> +
> +       return 0;
>  }
>
>  static const struct of_device_id max77650_charger_of_match[] =3D {
>
> base-commit: 4f72a263e162938de26866b862ed6015f5725946
> --
> 2.39.0
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
