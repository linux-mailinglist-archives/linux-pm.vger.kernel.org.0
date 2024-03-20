Return-Path: <linux-pm+bounces-5148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B7D8811DE
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 13:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B461C20C35
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 12:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7FD3FE36;
	Wed, 20 Mar 2024 12:47:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D19A1EB27;
	Wed, 20 Mar 2024 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938867; cv=none; b=bbQYPfWGiR3b/9iUNaZjWAgOTv+Z/fGvZarlEqaOdtvcIfpFwnYgnWFNb+3aWGNTaPiJnHz9Nm6Wl+ANdDLfy6xfhy8PdmiY1o00hVguIHspzKQJZDMO6JUo5z3sh5FdsiROtu0k7RXr+nI+K0MGwsPr3qRcHtJBOJMcGFVcgI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938867; c=relaxed/simple;
	bh=eDKg1s4LoJxiPClNE6HW4bWaPrh8ra5gSJ/WhFJuGtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZBAt1ycUhvkVgYOvu8sJhI01DDpDYy8Zx1x20U4hGCyZavrOYQvd/hCX2ay9OldG7ZjQmeUaHDsM5tOzSW4EZ4cA1ceg1d2YQWPeNN4ULPBFbK1IjQ2UtSl5t4BceJmmU/tWA/9OVMzu3Gct/cXZhC+ybD+HkkYYT+7PZ+C//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60fff981e2aso45532547b3.3;
        Wed, 20 Mar 2024 05:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710938864; x=1711543664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJ75aoLiK92aC4Nz1f8lbyWjM0XES8QsbLWv1hRuxrw=;
        b=AUUuSrQvhBCNldDLAmYfsL24cJXdFlBq8wOeZeN3di9pfHtreQIQEIJK/A9WIxoo5j
         b0T04AA6cu0ajGXUttQlkWQkaTKWDQdyVpRmNlA8ow0PnNGioRM6vTqdNxP8Z4vFR+vS
         pgVKY1CswreyKoth2hVGklYy0G8pcCHRH/axXruBVGJ6QPFfyvx3M1M5RI06fUBDF+iJ
         2D+meT9W9D8cIvJJqqjRmTX5aGTSah1H4SIupXSGDdpmrczQhyQzWKhrwGnM5SZLJCNG
         q8SD3Rnf2kIy3U+um889HqtuhMDU65PiVNkF1uAIP3ra3LRvqV7veiJ7cjS5Ty/zw5V2
         oeoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0Fl+OBy1hl/XPnPAfYVDaZ+7rBBuwrpeGZufWBRtgDO79/biJGE7cgOY5BM9O+CPybeM+t83VjGDRfsxrB7BL+0XzWdKR3cM8ztCFj58PaKdk9ZB+h3ei9jIZW2pmVOIkqO8UVQwV0m2aKw==
X-Gm-Message-State: AOJu0YxsQcTYGiAtKchF5VpzNoXbsC2KcSOJ2f7wiKYU3lUkPoACmDuv
	VZh+drJhhquwb6/iz78UIDRBE7P1iQPMG66OSdb/x6qJnXdwmDJ619Qxpx7xySE=
X-Google-Smtp-Source: AGHT+IHf2HBxw4Arq4senB3vGum1WrK4K6PE47636JtIrseeFYZZpK3MazymCrEURW5CxK2kwBWDHQ==
X-Received: by 2002:a0d:d403:0:b0:60a:16f:4c94 with SMTP id w3-20020a0dd403000000b0060a016f4c94mr16084355ywd.17.1710938863590;
        Wed, 20 Mar 2024 05:47:43 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id dg20-20020a05690c0fd400b00609f3d27022sm2744013ywb.113.2024.03.20.05.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 05:47:43 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60cbcd04de9so64135927b3.2;
        Wed, 20 Mar 2024 05:47:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2ELZUGMmMfMMgh362jZ2pgyt0LuAaCygjBR1a+oeE+uUUQFedPU2KH9KHvkSLj+rAbn5H9iIlxcic9BLrkjoYGWwsXMCZ9bkvT0Pd9odSh/Wgp+a6tY6DVFJ3ixoMCY3dijfoI2FQJix/Jw==
X-Received: by 2002:a81:9e0f:0:b0:608:b6d1:c334 with SMTP id
 m15-20020a819e0f000000b00608b6d1c334mr15716079ywj.52.1710938863026; Wed, 20
 Mar 2024 05:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307110216.2962918-1-niklas.soderlund+renesas@ragnatech.se> <20240307110216.2962918-2-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20240307110216.2962918-2-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Mar 2024 13:47:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVdZeWTX=Ge+hMKt-yQcvQnqJc_chV1c31A+6v4ZwnggA@mail.gmail.com>
Message-ID: <CAMuHMdVdZeWTX=Ge+hMKt-yQcvQnqJc_chV1c31A+6v4ZwnggA@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal: rcar_gen3: Move Tj_T storage to shared
 private data
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

On Thu, Mar 7, 2024 at 12:03=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The calculated Tj_T constant is calculated from the PTAT data either
> read from the first TSC zone on the device if calibration data is fused,
> or from fallback values in the driver itself. The value calculated is
> shared among all TSC zones.
>
> Move the Tj_T constant to the shared private data structure instead of
> duplicating it in each TSC private data. This requires adding a pointer
> to the shared data to the TSC private data structure. This back pointer
> make it easier to curter rework the temperature conversion logic.
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Thanks for your patch!

> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -81,10 +81,10 @@ struct rcar_thermal_info {
>  };
>
>  struct rcar_gen3_thermal_tsc {
> +       struct rcar_gen3_thermal_priv *priv;

I had hoped you could do without this, but I couldn't find a better way.
Even the contents of &priv->ops are copied (twice!) inside the thermal
core, so you can't go through that...

>         void __iomem *base;
>         struct thermal_zone_device *zone;
>         struct equation_coefs coef;
> -       int tj_t;
>         int thcode[3];
>  };
>
> @@ -92,6 +92,7 @@ struct rcar_gen3_thermal_priv {
>         struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
>         struct thermal_zone_device_ops ops;
>         unsigned int num_tscs;
> +       int tj_t;

Insert below ptat[3], as tj_t is calculated from ptat[3], and to better
approach reverse Christmas-tree ordering?

>         int ptat[3];
>         const struct rcar_thermal_info *info;
>  };
> @@ -146,15 +147,15 @@ static void rcar_gen3_thermal_calc_coefs(struct rca=
r_gen3_thermal_priv *priv,
>          * Division is not scaled in BSP and if scaled it might overflow
>          * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
>          */
> -       tsc->tj_t =3D (FIXPT_INT((priv->ptat[1] - priv->ptat[2]) * (ths_t=
j_1 - TJ_3))
> -                    / (priv->ptat[0] - priv->ptat[2])) + FIXPT_INT(TJ_3)=
;
> +       priv->tj_t =3D (FIXPT_INT((priv->ptat[1] - priv->ptat[2]) * (ths_=
tj_1 - TJ_3))
> +                     / (priv->ptat[0] - priv->ptat[2])) + FIXPT_INT(TJ_3=
);

Please move the calculation of priv->tj_t to rcar_gen3_thermal_probe()
or rcar_gen3_thermal_read_fuses(), so it is no longer done multiple
times.

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

