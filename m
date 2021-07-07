Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A1E3BEA2F
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 17:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhGGPEH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 7 Jul 2021 11:04:07 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:33284 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhGGPB0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 11:01:26 -0400
Received: by mail-ua1-f50.google.com with SMTP id d2so914953uan.0;
        Wed, 07 Jul 2021 07:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vlm292106JybCSEG0JoaJ6H+Y0Gf+RBNZMwDxvh4Ogk=;
        b=ngaS64kcsj0I+jaYV0f0T5O0VuNS4wSmAN5S3hI4wYO6DAhje6Rr8VAWaxHI6MUM1N
         2tuU89nyLiQhkdJMxJ6duVM//EyR4XTOuY0IqKKTDgZdXnSMJ5XhDladBIPZCN6xGUMd
         zxBj/abmBN8ommKfFoaGxJ5kqSbkVnloO/prOKcrbEKAf4/TLvWAcFAYGtveY6yI9yit
         NYS+/RxTVBsBjiRpRFEMSAMV2CQJgThsTpqOITVtl1nkUWwklTAs0WB0PJPHqq8rPAbh
         WaHIuB7b+9VvUONX+GwXnFRgPOcSYgZ4JYSumxyV7YpshvQ3ZdBJEgEycBL2qqSYbzhN
         cGgw==
X-Gm-Message-State: AOAM532QNhCqs9h2/AXu3L8ixUZvsLSHyDCPRiIGlX+Mcy3Kyk+WNbA5
        uDsfG3Zx2KbBDgdAUDyTdUfN3qjpJuYTPuTNqpo=
X-Google-Smtp-Source: ABdhPJxIYn3S7WWqdQhEdzjXqMj6/MXPlOLJz0j1yvhjySL0rhP0QiGgYwcd1nCk9orFy4zyNLCQ78OXsRdHh2oKGz4=
X-Received: by 2002:a9f:3f0d:: with SMTP id h13mr19060607uaj.100.1625669924846;
 Wed, 07 Jul 2021 07:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210707131306.4098443-1-niklas.soderlund+renesas@ragnatech.se> <20210707131306.4098443-3-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20210707131306.4098443-3-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Jul 2021 16:58:33 +0200
Message-ID: <CAMuHMdWTm79PXOgvuwDuFb8_LhvQxcR4wGsVKmP1vCbHN-3Mhg@mail.gmail.com>
Subject: Re: [PATCH 2/3] thermal: rcar_gen3_thermal: Add support for hardware
 trip points
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On Wed, Jul 7, 2021 at 3:14 PM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> All supported hardware except V3U is capable of generating interrupts
> to the CPU when the temperature go below or above a set value. Use this
> to implement support for the set_trip() feature of the thermal core on
> supported hardware.
>
> The V3U have its interrupts routed to the ECM module and therefore can
> not be used to implement set_trip() as the driver can't be made aware of
> when the interrupt triggers.
>
> Each TSC is capable of tracking up-to three different temperatures while
> only two are needed to implement the tracking of the thermal window.
>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Thanks for your patch!

> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -81,6 +81,7 @@ struct equation_coefs {
>
>  struct rcar_gen3_thermal_info {
>         int ths_tj_1;
> +       bool have_irq;

Do you need this flag? See below.

>  };
>
>  struct rcar_gen3_thermal_tsc {
> @@ -95,7 +96,8 @@ struct rcar_gen3_thermal_priv {
>         const struct rcar_gen3_thermal_info *info;
>         struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
>         unsigned int num_tscs;
> -       void (*thermal_init)(struct rcar_gen3_thermal_tsc *tsc);
> +       void (*thermal_init)(struct rcar_gen3_thermal_priv *priv,

Do you need priv? See below.

> +                            struct rcar_gen3_thermal_tsc *tsc);
>  };
>
>  static inline u32 rcar_gen3_thermal_read(struct rcar_gen3_thermal_tsc *tsc,
> @@ -195,16 +197,75 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)

>  static const struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
>         .get_temp       = rcar_gen3_thermal_get_temp,
> +       .set_trips      = rcar_gen3_thermal_set_trips,
>  };
>
> +static const struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops_no_irq = {
> +       .get_temp       = rcar_gen3_thermal_get_temp,
> +};

What about having a single non-const thermal_zone_of_device_ops,
and filling in .set_trip when interrupts are present?

> @@ -240,6 +305,9 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
>
>         rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0);
>         rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
> +       if (priv->info->have_irq)

I think you can check for the presence of tsc->zone->ops->set_trips instead.

> +               rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
> +                                       IRQ_TEMPD1 | IRQ_TEMP2);
>
>         reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
>         reg_val |= THCTR_THSST;

> @@ -314,8 +388,37 @@ static void rcar_gen3_hwmon_action(void *data)
>         thermal_remove_hwmon_sysfs(zone);
>  }
>
> +static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *priv,
> +                                         struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       unsigned int i;
> +       char *irqname;
> +       int ret, irq;
> +
> +       for (i = 0; i < 2; i++) {
> +               irq = platform_get_irq(pdev, i);

Would it make sense to use platform_get_irq_optional() instead,
to auto-detect variants with and without interrupt support?

> +               if (irq < 0)
> +                       return irq;
> +
> +               irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
> +                                        dev_name(dev), i);
> +               if (!irqname)
> +                       return -ENOMEM;
> +
> +               ret = devm_request_threaded_irq(dev, irq, NULL,
> +                                               rcar_gen3_thermal_irq,
> +                                               IRQF_ONESHOT, irqname, priv);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
