Return-Path: <linux-pm+bounces-40472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0E2D041CE
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 17:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8989E31E9155
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 15:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43262E5B3D;
	Thu,  8 Jan 2026 15:26:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6690319E97B
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885981; cv=none; b=Pawhnpm4b+VIJrtLfRfA9gK9QJ6MpXvPmtkz4iuowTfj3smVPfLIFxVdj4YJd1ZpjWJHp/z8H6UXyh5IhGz9MVUJb4lU4imz/SA7xgWuyfzpgWH93aX81i20aojgtw7kJzyYZfw2jfoOGCppCoNPtvluubY7h5IIGWFEdQvWoq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885981; c=relaxed/simple;
	bh=e+OtGCe5Sk6t9FVB5mpfIVm/rpc9dmyJ4vUAETdRSQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muhKENe1SH7SMvGO4DvOhOk7gpPcDxucxtB5U77XzSgyXpLTLnDb0R15uY5mHcqck+RiMQ2IC69lk2g1UMl35nh400Ss/1kr8+z1XYabk9Wl0eNxe2GdM070TS9Wu9jBsvxe8bPtQlappxBZuMaMrlixS4bYCj5CZzWOQ3SSN4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5eea5ed4efaso114166137.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767885979; x=1768490779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Myx/T2jiAzQj13PVTSJwAglhfaduo0kFw6dVkLRm/Kw=;
        b=CwZJNkKaSt5UHPrqzr4YTr8N423MCiqTItCmXFJMNiH9J2yTXKaqbses8k/TmGStxh
         I9b118u3w/jj0UYGDSSVnK3oDJZS1LN2tVJs7wKpWH1l4OuoZlJ7JwSVa6tuyDXOlIS2
         +5h22HDUmbIds7+Mf4zeny/Ebtvjz1U+xrQuSd30d7Pgd0HNa1dixu8siW3hBZt4htiH
         WI2bjoRJMi9E3ddcKZ+p0HA7pU2Ws4D8vngTB8GAM7ml944si08HQpYZV4BDUZZtLiL6
         aTO8R1/XMCfcEq+67NuNtJghYdPolEIhD0BpgK0Ia6c9/oMLluydw3lO4YtdPGiDwaFX
         WIAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvYAVFJyygQ1y8cE3GKEzVZMz0C9uUalxhFPriMUl6XiO9GDa2cLhYQNA0xZJsZozEpYnOdraFHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKbmqlp4VEHlesk4rxkK88OR/yjXl2J8BKlj3M/Qqa0HNi87vr
	vKVt2hpwYINvezKdQsoahW6y1PeZsnopNRWfXADGOkbHlsZYpuwAZtiUF3afAL6V
X-Gm-Gg: AY/fxX6GRfKya5+SW+7PLOIeBgKVF6AsT3P8HfxSeFiPCG+nbN0AVxbFp7NBq4lcYOg
	XC+PMcJQColen4m2zr1DcAzFeRILJ+xPuuiiALpxdZrlNwKOiUbxjwZdz4Ug2GfLuadwE3LjY0S
	3E6VQasFcYswt0LrBuqDmwEFPuh6gJY1V7HGJ8vAQ2tRopAu0rRfueVylyzMT9q/9MVS+pgFS17
	Sc0McBVxXyxBTvcUFcEjs+KdROjOYTpam3YeoJj5cERXHUaEgGBhRGwXT8OSEHzyiL/GOl9vHLq
	D0gs0t+bmc1QAf/9AJDhixYaP5jzy39n0AQ+qvVP6cTGQnodphgej57Cr/B0enQ8wdtXCARvcZT
	zll2gEo9cw1BkemxXYn4s2FjTlW2PJkHyHfu6qAuIEiCqg1w9rC7YzwZgCbzcDk88mzzABldG1n
	ZXRAAiY1gZsuFxTUj5RfdNUV9fpXi9+dQ3tGwLp98nf7aQoRXC
X-Google-Smtp-Source: AGHT+IGtNVW1mGfpbFjwniId22/GND7Fo/ttD+vhGCCnDcJFFwKWdM5z4WgSsZtas3x/q9n7Yb965A==
X-Received: by 2002:a67:e704:0:b0:5df:b5d4:e45d with SMTP id ada2fe7eead31-5ecb6974d48mr2651454137.33.1767885977779;
        Thu, 08 Jan 2026 07:26:17 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ee9d013b3csm1995178137.5.2026.01.08.07.26.17
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 07:26:17 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5dd6fbe5091so1352919137.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:26:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX672zBP3tHzMfwXRKrE/xeqBggxIN1lD1jI17hyh9b+PFz0DT5bC31O125RwqaYjfaHz5ZYMrMJA==@vger.kernel.org
X-Received: by 2002:a05:6102:4a83:b0:5ee:a81a:dea4 with SMTP id
 ada2fe7eead31-5eea81ae785mr282830137.27.1767885976851; Thu, 08 Jan 2026
 07:26:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251126130356.2768625-4-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251126130356.2768625-4-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Jan 2026 16:26:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWEj=3dLMPtFLtvoQ2aW_qRBLes_viCKmiWzK3bUe7uxA@mail.gmail.com>
X-Gm-Features: AQt7F2qzrssQHw0k6aAqGzzh2oKOX1eJ3p9c7BCb14ihkvvK0IAUBKGlnhMTeis
Message-ID: <CAMuHMdWEj=3dLMPtFLtvoQ2aW_qRBLes_viCKmiWzK3bUe7uxA@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] thermal: renesas: rzg3e: make calibration value
 retrieval per-chip
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Wed, 26 Nov 2025 at 14:05, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the
> temperature calibration data via SMC SIP calls.
>
> Prepare for them by moving the syscon usage into a single function, and
> placing it in the chip-specific struct.
>
> Rename the functions to match their functionality, and remove single-use
> variables from the private state.
>
> Also, move the calibration value mask into a macro.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Thanks for your patch!

> --- a/drivers/thermal/renesas/rzg3e_thermal.c
> +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> @@ -70,7 +70,12 @@
>  #define TSU_POLL_DELAY_US      10      /* Polling interval */
>  #define TSU_MIN_CLOCK_RATE     24000000  /* TSU_PCLK minimum 24MHz */
>
> +#define TSU_TEMP_MASK          GENMASK(11, 0)

This is the value same as the existing TSU_CODE_MAX definition.

> +
> +struct rzg3e_thermal_priv;
> +
>  struct rzg3e_thermal_info {
> +       int (*get_trim)(struct rzg3e_thermal_priv *priv);
>         int temp_d_mc;
>         int temp_e_mc;
>  };

> @@ -334,22 +337,8 @@ static const struct thermal_zone_device_ops rzg3e_tz_ops = {
>         .set_trips = rzg3e_thermal_set_trips,
>  };
>
> -static int rzg3e_thermal_get_calibration(struct rzg3e_thermal_priv *priv)
> +static int rzg3e_validate_calibration(struct rzg3e_thermal_priv *priv)
>  {
> -       u32 val;
> -       int ret;
> -
> -       /* Read calibration values from syscon */
> -       ret = regmap_read(priv->syscon, priv->trim_offset, &val);
> -       if (ret)
> -               return ret;
> -       priv->trmval0 = val & GENMASK(11, 0);
> -
> -       ret = regmap_read(priv->syscon, priv->trim_offset + 4, &val);
> -       if (ret)
> -               return ret;
> -       priv->trmval1 = val & GENMASK(11, 0);
> -
>         /* Validate calibration data */

I think this comment can be dropped, as this is clear from the
function name.

>         if (!priv->trmval0 || !priv->trmval1 ||
>             priv->trmval0 == priv->trmval1 ||

> @@ -402,11 +404,16 @@ static int rzg3e_thermal_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->base))
>                 return PTR_ERR(priv->base);
>
> -       /* Parse device tree for trim register info */
> -       ret = rzg3e_thermal_parse_dt(priv);
> +       ret = priv->info->get_trim(priv);
>         if (ret)
>                 return ret;
>
> +       /* Validate calibration data */

Obvious, so please drop this comment.

> +       ret = rzg3e_validate_calibration(priv);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "Failed to get valid calibration data\n");

rzg3e_validate_calibration() already prints its own error message.
As this function became small, perhaps inline it here, and use a single
dev_err_probe() in case of failure?

> +
>         /* Get clock to verify frequency - clock is managed by power domain */
>         clk = devm_clk_get(dev, NULL);
>         if (IS_ERR(clk))

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

