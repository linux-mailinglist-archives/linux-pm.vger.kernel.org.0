Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787B642C162
	for <lists+linux-pm@lfdr.de>; Wed, 13 Oct 2021 15:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhJMN3V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 13 Oct 2021 09:29:21 -0400
Received: from mail-ua1-f41.google.com ([209.85.222.41]:36520 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhJMN3U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Oct 2021 09:29:20 -0400
Received: by mail-ua1-f41.google.com with SMTP id g13so4475254uaj.3;
        Wed, 13 Oct 2021 06:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/CNqjYylJrKWKcPRGnOfpIoJdWTb6vOhLBg4h/E8o8o=;
        b=CB5SUBS0vlBmAx5fwfWs0Q+UCkPv8vv/mtLjkJG9RgQorov+qnLcGvcjzrAZDRp117
         fAX2CXoZS5Qx726UiMQSkzTDgxpFDIzGZ0Sh6pnPL7CvFd4lTk0fviIaNSheKoiYy5Dk
         C/eixMaUSM77+TmwnZ2ONUthXTuTfmUiOq/t3gNltyepTquPNCjlXMh+jb9p3AgZ1FuY
         roa/Oi+KPRye1iN3L03zf3w7v5BD6FAepxNy0y1XvWVVN4PPBwp66QFbCCjuZVZCXNzh
         d1WrO0ZxehNpbpYfsgQquL5pvj4VKmxsG5Ibg0uFcMou9OfGeeNGoNL+U/hagG9V+Xo1
         0mVA==
X-Gm-Message-State: AOAM531f7jvOQE08moYfvU3vxZN5O91FZzVwkg38hWu080yHHUrebFSI
        /SWhY9xwLrGciSncGGSrypeHlYDp4aPFNjyorSY=
X-Google-Smtp-Source: ABdhPJx+EdvYep8kGp87ymb5T0vvYxd7kfXkkiiy3iL/dD8ZlxapNaxtL3rXJwnyi+jJ3MRu4dOoEBtPEaIJqh/6gi8=
X-Received: by 2002:ab0:538a:: with SMTP id k10mr29804439uaa.14.1634131636954;
 Wed, 13 Oct 2021 06:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211011225802.11497-1-niklas.soderlund+renesas@ragnatech.se> <20211011225802.11497-3-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20211011225802.11497-3-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Oct 2021 15:27:05 +0200
Message-ID: <CAMuHMdXXBtoQ78=ePkw4ja3Lh7YoPhd4XZAaGX79Huz3Khw51g@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: rcar_gen3_thermal: Read calibration from hardware
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On Tue, Oct 12, 2021 at 12:58 AM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> In production hardware the calibration values used to convert register
> values to temperatures can be read from hardware. While pre-production
> hardware still depends on pseudo values hard-coded in the driver.
>
> Add support for reading out calibration values from hardware if it's
> fused. The presence of fused calibration is indicated in the THSCP
> register.
>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
> * Changes since RFT
> - Keep thcodes array static.

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

A few minor bike sheddings^W^Wnits below...

> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c

> @@ -245,6 +252,64 @@ static const struct soc_device_attribute r8a7795es1[] = {
>         { /* sentinel */ }
>  };
>
> +static bool rcar_gen3_thermal_update_fuses(struct rcar_gen3_thermal_priv *priv)

This doesn't sound like a good name to me, as the function does not
update the fuses, but reads their values.

> +{
> +       unsigned int i;
> +       u32 thscp;
> +
> +       /* Default THCODE values in case FUSEs are not set. */
> +       static const int thcodes[TSC_MAX_NUM][3] = {
> +               { 3397, 2800, 2221 },
> +               { 3393, 2795, 2216 },
> +               { 3389, 2805, 2237 },
> +               { 3415, 2694, 2195 },
> +               { 3356, 2724, 2244 },
> +       };

Given this is used only inside the if statement below, perhaps it
should be moved there?

> +
> +       /* If fuses are not set, fallback to pseudo values. */
> +       thscp = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_THSCP);
> +       if ((thscp & THSCP_COR_PARA_VLD) != THSCP_COR_PARA_VLD) {
> +               priv->ptat[0] = 2631;
> +               priv->ptat[1] = 1509;
> +               priv->ptat[2] = 435;
> +
> +               for (i = 0; i < priv->num_tscs; i++) {
> +                       struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
> +
> +                       tsc->thcode[0] = thcodes[i][0];
> +                       tsc->thcode[1] = thcodes[i][1];
> +                       tsc->thcode[2] = thcodes[i][2];
> +               }
> +
> +               return false;
> +       }
> +
> +       /*
> +        * Set the pseudo calibration points with fused values.
> +        * PTAT is shared between all TSCs but only fused for the first
> +        * TSC while THCODEs are fused for each TSC.
> +        */
> +       priv->ptat[0] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT1) &
> +               GEN3_FUSE_MASK;
> +       priv->ptat[1] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT2) &
> +               GEN3_FUSE_MASK;
> +       priv->ptat[2] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT3) &
> +               GEN3_FUSE_MASK;
> +
> +       for (i = 0; i < priv->num_tscs; i++) {
> +               struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
> +
> +               tsc->thcode[0] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE1) &
> +                       GEN3_FUSE_MASK;
> +               tsc->thcode[1] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE2) &
> +                       GEN3_FUSE_MASK;
> +               tsc->thcode[2] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE3) &
> +                       GEN3_FUSE_MASK;
> +       }
> +
> +       return true;
> +}
> +
>  static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
>  {
>         rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  CTSR_THBGR);

> @@ -442,11 +493,16 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>                         goto error_unregister;
>                 }
>
> -               tsc->thcode[0] = thcodes[i][0];
> -               tsc->thcode[1] = thcodes[i][1];
> -               tsc->thcode[2] = thcodes[i][2];
> -
>                 priv->tscs[i] = tsc;
> +       }
> +
> +       priv->num_tscs = i;
> +
> +       if (rcar_gen3_thermal_update_fuses(priv))
> +               dev_info(dev, "Using fused calibration values\n");

Despite our lack of test hardware having programmed fuses, using the
values from the fuses should be the normal situation, right?
So perhaps print a message when falling back to the default values
instead?

> +
> +       for (i = 0; i < priv->num_tscs; i++) {
> +               struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
>
>                 zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
>                                                             &rcar_gen3_tz_of_ops);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
