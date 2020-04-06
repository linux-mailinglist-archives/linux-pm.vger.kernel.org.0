Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B94119F0CB
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 09:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgDFHb7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 03:31:59 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34910 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgDFHb6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 03:31:58 -0400
Received: by mail-ua1-f67.google.com with SMTP id a6so5143022uao.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2020 00:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tcs7bP7KM3PIrqJj8Hr62xEaLUtpUiqXHCb5QGQNylU=;
        b=ZCcu5A0KQmWcU5bmi1Kqt/A4CTZcApoKg1CWiTOY8Af2dGNzNsxP8p8+fKa51kPrDM
         EDDUiuqvatgTpoShc8v9N2Gg5evZH3A6p113f+M5sOsipWZyw8DVkpPke9TirEnhEK3/
         BvvpBtUzZzT7KVcfeGZ5iPAlfgZp37ksnF3PrPsyZNRYGxRIQP6ZUM1XDVTy7AFbRJko
         e0bXtLQdjoj8nkutSU9/f7TVQEiS9UlLIMr6iGhKq5kFDItQvVAeVslZ9HzbgjDUXebb
         pFyPedZGOBwLIkJU9yaYXI2YRuF3xLDjh6JTNqRWgA8ls/bCHHF0b6L4vVXhQfEyGXK9
         xx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tcs7bP7KM3PIrqJj8Hr62xEaLUtpUiqXHCb5QGQNylU=;
        b=pp7qPFAeLMGkOQW+DeXeCvT7ElqufDSBR2QO0n2LsN+qzMFKbroxAd4atxdbrVoVJo
         PepvWYjC6jYEhQyNW38HDqzv7FTGWc5R+DY4TQFowOy6dGRXOPjHp/xLR8ny7IK7cBRk
         YqbxiQrXmmABIMAj6b9wrcSNmndVjJVTIlESwNIT3UZ1bHLhpo5Q8LeMOY9Tk3sodOcW
         avI5ii7H7EaYnPVWjrnarpMyk81j5FvHodzE3Rhhkt+l5F5xg+Apdw8i+sCchvjTN/Mr
         MT6lrq17FrixjrM+n8CEhbgVRuOAfQ0NPGEqnJmJLwXuwA3EcxokmBIXYEjU72eKZmWb
         NRow==
X-Gm-Message-State: AGi0PuZcYHEvO8JC/QV1QeRYmVo4396Lz7g5PKoOK/dErdYRljmgwtdQ
        W1D1DNyaYKhy8i7nuNksDzs7ebMpwWz/AZzFkBJONg==
X-Google-Smtp-Source: APiQypK7NveNncZKcf8ZgGWKN34h9iznOE8Tk+T7PbfZ/mRj5uGhOR3oyEhU0l3b2UqurmrqrqJRVpVI/pXTGwXwNPw=
X-Received: by 2002:ab0:911:: with SMTP id w17mr13564370uag.60.1586158316231;
 Mon, 06 Apr 2020 00:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <05f49ae7-5cc7-d6a0-fc3d-abaf2a0b373c@web.de>
In-Reply-To: <05f49ae7-5cc7-d6a0-fc3d-abaf2a0b373c@web.de>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon, 6 Apr 2020 13:00:00 +0530
Message-ID: <CAHLCerMS5ghVXhOD7RAd5unxEe7w1W4_8hBP5Tf9HvuMEh5Lqg@mail.gmail.com>
Subject: Re: [PATCH] thermal: Delete an error message in four functions
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-omap@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Allison Randal <allison@lohutok.net>,
        Clark Williams <williams@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Keerthy <j-keerthy@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Pascal Paillet <p.paillet@st.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 5, 2020 at 10:21 PM Markus Elfring <Markus.Elfring@web.de> wrot=
e:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 5 Apr 2020 18:35:16 +0200
>
> The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error already.
> Thus omit redundant messages for the exception handling in the
> calling functions.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/rockchip_thermal.c          | 4 +---
>  drivers/thermal/st/st_thermal_memmap.c      | 4 +---
>  drivers/thermal/st/stm_thermal.c            | 4 +---
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c | 5 ++---
>  4 files changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchi=
p_thermal.c
> index 7c1a8bccdcba..15a71ecc916c 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1241,10 +1241,8 @@ static int rockchip_thermal_probe(struct platform_=
device *pdev)
>                 return -ENXIO;
>
>         irq =3D platform_get_irq(pdev, 0);
> -       if (irq < 0) {
> -               dev_err(&pdev->dev, "no irq resource?\n");
> +       if (irq < 0)
>                 return -EINVAL;
> -       }
>
>         thermal =3D devm_kzalloc(&pdev->dev, sizeof(struct rockchip_therm=
al_data),
>                                GFP_KERNEL);
> diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/=
st_thermal_memmap.c
> index a824b78dabf8..a0114452d11f 100644
> --- a/drivers/thermal/st/st_thermal_memmap.c
> +++ b/drivers/thermal/st/st_thermal_memmap.c
> @@ -94,10 +94,8 @@ static int st_mmap_register_enable_irq(struct st_therm=
al_sensor *sensor)
>         int ret;
>
>         sensor->irq =3D platform_get_irq(pdev, 0);
> -       if (sensor->irq < 0) {
> -               dev_err(dev, "failed to register IRQ\n");
> +       if (sensor->irq < 0)
>                 return sensor->irq;
> -       }
>
>         ret =3D devm_request_threaded_irq(dev, sensor->irq,
>                                         NULL, st_mmap_thermal_trip_handle=
r,
> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_th=
ermal.c
> index 9314e3df6a42..331e2b768df5 100644
> --- a/drivers/thermal/st/stm_thermal.c
> +++ b/drivers/thermal/st/stm_thermal.c
> @@ -385,10 +385,8 @@ static int stm_register_irq(struct stm_thermal_senso=
r *sensor)
>         int ret;
>
>         sensor->irq =3D platform_get_irq(pdev, 0);
> -       if (sensor->irq < 0) {
> -               dev_err(dev, "%s: Unable to find IRQ\n", __func__);
> +       if (sensor->irq < 0)
>                 return sensor->irq;
> -       }
>
>         ret =3D devm_request_threaded_irq(dev, sensor->irq,
>                                         NULL,
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/therma=
l/ti-soc-thermal/ti-bandgap.c
> index 263b0420fbe4..ab19ceff6e2a 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -772,10 +772,9 @@ static int ti_bandgap_talert_init(struct ti_bandgap =
*bgp,
>         int ret;
>
>         bgp->irq =3D platform_get_irq(pdev, 0);
> -       if (bgp->irq < 0) {
> -               dev_err(&pdev->dev, "get_irq failed\n");
> +       if (bgp->irq < 0)
>                 return bgp->irq;
> -       }
> +
>         ret =3D request_threaded_irq(bgp->irq, NULL,
>                                    ti_bandgap_talert_irq_handler,
>                                    IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> --
> 2.26.0
>
