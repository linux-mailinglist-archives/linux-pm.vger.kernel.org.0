Return-Path: <linux-pm+bounces-5150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60700881240
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 14:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80AA51C22ABB
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 13:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E8B4085F;
	Wed, 20 Mar 2024 13:22:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A9E1DFD9;
	Wed, 20 Mar 2024 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940969; cv=none; b=mBVeMZOvgF8u/yoaQvaaLBF5tBuFYlEUu6ksgExXwiG6jKdDajlHcflNjraKFp+MC/Lu5CFcxByjkw17cc6ONrGLXa8Rsx24OcGDBp8ePek8Ng/7IcHWdzYJY6+lzLvOwR5lNctQbJu4RVt0JaZ2lenhWvDjyzzBoVXDarKGngc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940969; c=relaxed/simple;
	bh=+83vQnzIGcFABvRGxdf8NdFsFVculRVmcgvy86r98/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyoD9GXzDDwdQdPTNlJzkglc5FQdC3cEF97f8r2pIl+Hl2QCh+Nao5Ph9ZFFSvkCQ2ZCKQiggZVqFLnFOgErINUBJ11FWnricz7oqwW5Sp5gAelBRnGw0o/oDtmL03MwnAPvkeiNr28oD3uqLZwsAvchz0wDL3CUuSw2DDjtG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so6535361276.3;
        Wed, 20 Mar 2024 06:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710940966; x=1711545766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iH55yLPNx3RLcttEy+8naBBsbABgYMQbhkuh3rSll8Y=;
        b=bo8/XLWfTM2jTjY63TJf2jVPpNpKaZcuERi3oAsUedrJOwByc5OUuAccQlXUKgvu9s
         nJN2cb4Lop7mjqQNJp5SSI9X2gbj7pAvcfPRWwnIZrp1hWQPUhFOJvuceL1uStnqxhI7
         xe2jE9p9PKQSQzrpghl0jBCuS118NQz4HCUE7uzWgOB/pkXylamkQXJQgJfk+zinBgny
         26FZlT+GdBk2fFryLbQH7A+g5bv0dwz239DOjJf4bOyVE6R8KgrSCULrbefTuu0pHmcV
         56ksT10NmiwDeS0uE4kOf3Lg1E6MMCVXp4vdyQIBDqGhxj1/HLNBn3lv3FgQlejYC0bQ
         hOow==
X-Forwarded-Encrypted: i=1; AJvYcCW+8qcicF6d+jtU9Qliw5UHhUZmpszUCUIDmXHhR/xDpj/B5/FsPAVkqLwBM72mKJ3ymSrckGmA7/cmgw/A6+kSlm2ZjZRU/5hA71INDYCcxVNT50LkEJs7cwVzYM8AgrI6f+oTj05GX0Di8g==
X-Gm-Message-State: AOJu0YwpnlAIFBTAwbykJw2uSVR4hnYAme44fFz4yc4LSE2m0qmhtWED
	00O6BI+RASkRZ2szfQP4HcSzMTTAfbr1Hy8BumGfAaANlpG3I2dN9k5iU6beSpI=
X-Google-Smtp-Source: AGHT+IH2KCyNs5AQWn/jIYmOT+Of9ILs1WW1NQsBuejj2fL9qYR7BsQQqb44d2lFW8xD0HN9+0S0pg==
X-Received: by 2002:a25:a526:0:b0:dc3:696f:167e with SMTP id h35-20020a25a526000000b00dc3696f167emr14361492ybi.64.1710940966070;
        Wed, 20 Mar 2024 06:22:46 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id h15-20020a255f4f000000b00dcdb3dffa3dsm1643730ybm.39.2024.03.20.06.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 06:22:44 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-609ed7ca444so63594367b3.1;
        Wed, 20 Mar 2024 06:22:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkF2qRM/MxpHvBx4lzHhw4AeJIrQ+KCWvVgX2rHDFSbHRwi9lVy1oCjk3xn97CdYv/oIR5twOLgbtr+pLj9wgUu9bxT2b5v2xE5zkCGxcnl+soiwKydErt5juSyAZFI8MFLKYevkK5HwFZPg==
X-Received: by 2002:a0d:e287:0:b0:609:fb34:4c52 with SMTP id
 l129-20020a0de287000000b00609fb344c52mr15925637ywe.21.1710940963948; Wed, 20
 Mar 2024 06:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307110216.2962918-1-niklas.soderlund+renesas@ragnatech.se> <20240307110216.2962918-3-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20240307110216.2962918-3-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Mar 2024 14:22:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU1RxN1iEnok8Hp6ZMWY1QVuu71PuG4OwWcKgPSv-kFiA@mail.gmail.com>
Message-ID: <CAMuHMdU1RxN1iEnok8Hp6ZMWY1QVuu71PuG4OwWcKgPSv-kFiA@mail.gmail.com>
Subject: Re: [PATCH 2/3] thermal: rcar_gen3: Update temperature approximation calculation
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

Thanks for your patch!

On Thu, Mar 7, 2024 at 12:03=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The initial driver used a formula to approximation the temperature and

approximate

> register value reversed engineered form an out-of-tree BSP driver. This

values ... from

> was needed as the datasheet at the time did not contain any information
> on how to do this. Later Gen3 (Rev 2.30) and Gen4 (all) now contains
> this information.
>
> Update the approximation formula to use the datasheets information

datasheet's

> instead of the reversed engineered one.

reverse-engineered

> On an idle M3-N without fused calibration values for PTAT and THCODE the
> old formula reports,
>
>     zone0: 52000
>     zone1: 53000
>     zone2: 52500
>
> While the new formula under the same circumstances reports,
>
>     zone0: 52500
>     zone1: 54000
>     zone2: 54000
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c

> @@ -112,51 +115,41 @@ static inline void rcar_gen3_thermal_write(struct r=
car_gen3_thermal_tsc *tsc,
>  /*
>   * Linear approximation for temperature
>   *
> - * [reg] =3D [temp] * a + b =3D> [temp] =3D ([reg] - b) / a
> + * [temp] =3D ((thadj - [reg]) * a) / b + adj
> + * [reg] =3D thadj - ([temp] - adj) * b / a
>   *
>   * The constants a and b are calculated using two triplets of int values=
 PTAT
>   * and THCODE. PTAT and THCODE can either be read from hardware or use h=
ard
>   * coded values from driver. The formula to calculate a and b are taken =
from

the driver

> - * BSP and sparsely documented and understood.
> + * the datasheet. Different calculations are needed for a and b dependin=
g on
> + * if the input variable ([temp] or [reg]) are above or below a threshol=
d. The

variables

> + * threshold is also calculated from PTAT and THCODE using formula from =
the

formulas

> + * datasheet.
>   *
> - * Examining the linear formula and the formula used to calculate consta=
nts a
> - * and b while knowing that the span for PTAT and THCODE values are betw=
een
> - * 0x000 and 0xfff the largest integer possible is 0xfff * 0xfff =3D=3D =
0xffe001.
> - * Integer also needs to be signed so that leaves 7 bits for binary
> - * fixed point scaling.
> + * The constant thadj is one of the THCODE values, which one to use depe=
nds on
> + * the threshold and input value.
> + *
> + * The constants adj is taken verbatim from the datasheet. Two values ex=
ists,
> + * which one to use depends on the input value and the calculated thresh=
old.
> + * Furthermore different SoCs models supported by the driver have differ=
ent sets

SoC

> + * of values. The values for each model is stored in the device match da=
ta.

are

>   */

> @@ -172,19 +165,29 @@ static int rcar_gen3_thermal_round(int temp)
>  static int rcar_gen3_thermal_get_temp(struct thermal_zone_device *tz, in=
t *temp)
>  {
>         struct rcar_gen3_thermal_tsc *tsc =3D thermal_zone_device_priv(tz=
);
> -       int mcelsius, val;
> -       int reg;
> +       struct rcar_gen3_thermal_priv *priv =3D tsc->priv;
> +       const struct equation_set_coef *coef;
> +       int adj, mcelsius, reg, thcode;
>
>         /* Read register and convert to mili Celsius */
>         reg =3D rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
>
> -       if (reg <=3D tsc->thcode[1])
> -               val =3D FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b1,
> -                               tsc->coef.a1);
> -       else
> -               val =3D FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b2,
> -                               tsc->coef.a2);
> -       mcelsius =3D FIXPT_TO_MCELSIUS(val);
> +       if (reg < tsc->thcode[1]) {
> +               adj =3D priv->info->adj_below;
> +               coef =3D &tsc->coef.below;
> +               thcode =3D tsc->thcode[2];
> +       } else {
> +               adj =3D priv->info->adj_above;
> +               coef =3D &tsc->coef.above;
> +               thcode =3D tsc->thcode[0];
> +       }
> +
> +       /*
> +        * The dividend can't be grown as it might overflow, instead shor=
ten the
> +        * divisor to convert to millidegree Celsius. If we convert after=
 the
> +        * division precision is lost to a full degree Celsius.
> +        */
> +       mcelsius =3D DIV_ROUND_CLOSEST(coef->a * (thcode - reg), coef->b =
/ 1000) + adj * 1000;

Don't you lose a lot of precision by pre-dividing b by 1000?

>
>         /* Guaranteed operating range is -40C to 125C. */
>
> @@ -198,15 +201,21 @@ static int rcar_gen3_thermal_mcelsius_to_temp(struc=
t rcar_gen3_thermal_tsc *tsc,
>                                               int mcelsius)
>  {
>         struct rcar_gen3_thermal_priv *priv =3D tsc->priv;
> -       int celsius, val;
> +       const struct equation_set_coef *coef;
> +       int adj, celsius, thcode;
>
>         celsius =3D DIV_ROUND_CLOSEST(mcelsius, 1000);

This is pre-existing, but I think it would be good if you could avoid
this (early) division by 1000.


> -       if (celsius <=3D INT_FIXPT(priv->tj_t))
> -               val =3D celsius * tsc->coef.a1 + tsc->coef.b1;
> -       else
> -               val =3D celsius * tsc->coef.a2 + tsc->coef.b2;
> +       if (celsius < priv->tj_t) {
> +               coef =3D &tsc->coef.below;
> +               adj =3D priv->info->adj_below;
> +               thcode =3D tsc->thcode[2];
> +       } else {
> +               coef =3D &tsc->coef.above;
> +               adj =3D priv->info->adj_above;
> +               thcode =3D tsc->thcode[0];
> +       }
>
> -       return INT_FIXPT(val);
> +       return thcode - DIV_ROUND_CLOSEST((celsius - adj) * coef->b, coef=
->a);
>  }

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

