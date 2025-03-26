Return-Path: <linux-pm+bounces-24508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB04BA71786
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 14:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F033B09D3
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 13:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A4B1E833C;
	Wed, 26 Mar 2025 13:27:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8521E1E18;
	Wed, 26 Mar 2025 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995620; cv=none; b=VS1YuQB8IZN/Kz6jS5gJvmz6XUDV9HC0DhToKsB7Pl0p0jIixYhuKzyzcAy2PQ69Aq5aGGQMm35lwKoSAf8JGsahLF0gyBYCVgvaCEgLxbeSGuMbRVM1dwUX8XqSbQ8vCTNFEUKk95qDAVRbsXHi681FpCUCOyv5VJERTfOq5dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995620; c=relaxed/simple;
	bh=BfugzdJy1020xKX9PNyXbohhH1lWWG+ul9/669rea4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iT4RvgPYlWpHS82lZyQsB+aq0Z7cFjmLCIqG5oZJZ601CVWa9imRR4/jXnU24toxJCGpYGi6PEw0lczgPxHkaZgD+YAvE4Uhds46FOUI+3bQ+yJzPUcT7gflOdKUJMFwI33ZEA3wF9banNOjBYEH8FjZazMonqRrjTdqvknHfzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-520847ad493so6523286e0c.1;
        Wed, 26 Mar 2025 06:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742995616; x=1743600416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmOEoyHY2Ks0gUuytaK4wjrwLTqw4vCXipxUeutcC98=;
        b=gSlWjTfG2Kh+1odtGkBop9ikapZvxCja/bIpFa1ocSjSDpsg9vFKVtN5EMJhTABJBA
         L2gOegSDd+Z7maWtinNNJsGoXwlTwwNiPV7ct5wc8dcQdQPQfi92qsrgc/lkMpZxG8J9
         9npjp5Cou7nDcycwmNwam0VbbIRRu3cCHJSKO8aL0KPj9vTXTZVy78FPsIvuakoO0sj8
         LZGYN2Uc7JkV46KJXo6Vo1QtHwmBWfrQVnmD3gFhXLiN24lMu4OF2luY4F1OfhW36UYD
         qx0AzUPI03oQC1LOGlCwU303jZV2jSvVM5YbwCTNFCh1YhsrLHyRrOWG1zm/i9Z+4tBk
         Inuw==
X-Forwarded-Encrypted: i=1; AJvYcCUIChoi5MbG3ooh6nFrres2wcLZjbYJAQkixOCvj14KtpPGaAmU0meT4HV07jLGprKlV7nX3oVq/smmYqtYHXfL5yw=@vger.kernel.org, AJvYcCUbtH0RYvf5JVZSikLf2lPNpTyIaXMjBACprGajYeah29uFaNGHQ8w2C2HhLfDYMRuMz9oGPqOv7MEUTsDh@vger.kernel.org, AJvYcCW8yGu3MG9lYEN4mM6UvLCo1keaj1znOXcmoV0V2CcfvGrdd31bq5DdrlOCyd56W6riioMD0fpbjkJR@vger.kernel.org, AJvYcCX82Z7jM+I2gPU6nv8R2pabhfbRMKNAEWznzfMJs8qFkPIbLtNm/TP/cKfXRiCuMG3YNqzc9UfAWXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbGW5WvgMLwk0jm14B2QCmb0ol/AdrDfy1TW6jNlFm1suRRBWg
	65Az2PdfD8oBtGybTbRspFgPS6jXhQuNafLw+pBI6oiweVRmlVHyJxOHCI6Cefs=
X-Gm-Gg: ASbGncsVjddy7uSJNb7JKRF0r8jpUDIld3tRXdoesUwC8D9dzED0Wkto5Du0UvDwpU0
	MUiqaMfbg8AzJ51isyoBe39UC+sgVMqaP9kja96htj8D/J3Triyzf9Fp6UvfsHHM48zaYksMGRN
	kDEuBziJ2T9KhcK3MyXHG3jHmkfgroWR6p5+JiKGR6BEAfQ3qPvQBUGhmKjhUotuIAtLwqE6Fq+
	V+0/Mt4fsoim4UVOGkgAX+x3qudg1VrWhTYP9QyPVLt/92NxIVbLA4TmZBDI5h5km3GY5oZTY0C
	WwAT1L1JXT4R1hfxiMnoVovlYDmIAnUzzf/srA21MVqlff8wvfsjya15jq/uzUo8bm8bj8WWIds
	4BPnO9GqDfGnV9eCzQ8y6EQ==
X-Google-Smtp-Source: AGHT+IHUQLjZE7FzyRalMeA+QfRgRAwqGd60bRKNHApZ58Wzqi0GQn7ixD3u6fZA04MD9XQEVcqrPg==
X-Received: by 2002:a05:6122:6081:b0:51f:3eee:89e7 with SMTP id 71dfb90a1353d-525a854e0dcmr16250334e0c.11.1742995615767;
        Wed, 26 Mar 2025 06:26:55 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-525a735b95fsm2185583e0c.5.2025.03.26.06.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 06:26:55 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-51eb1a714bfso7180719e0c.3;
        Wed, 26 Mar 2025 06:26:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdhBFvceILJWFkePwva6TgGcch5AwbbnO/KSQ1CQYKf2vEfNeLRzcHNg3l1voIRERHqHcVq7J5PfJJNgMlVu1PI2E=@vger.kernel.org, AJvYcCVpjOOXiD/ZtR/x0UXz85cmAKO3AwawrB0CDZatrnS6xIhXdUCtp/J3X9kw50e/pLMed6mATc4Y5mKBtse8@vger.kernel.org, AJvYcCXbm1Oa7l6cSf9hIvDBeZfeTXdlWENGxhrMwOOP6yBkYNW2NT/K8iwuf58JpIpIPBH5gOzA2iV04Gfq@vger.kernel.org, AJvYcCXe1d8PxktcTHae9fBEWLXGBqtDOcP81ZMJz4gnodfQE86zTpSDsoc3RjxD/goimvgGE5inbPd1pxQ=@vger.kernel.org
X-Received: by 2002:a05:6122:251b:b0:520:61ee:c7f9 with SMTP id
 71dfb90a1353d-525a84c5e96mr16364284e0c.7.1742995615066; Wed, 26 Mar 2025
 06:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324135701.179827-1-claudiu.beznea.uj@bp.renesas.com> <20250324135701.179827-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250324135701.179827-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Mar 2025 14:26:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUUNFo4pqbXh1xMatsv7T7cnq0SmDxM_o9em0=gpurdCA@mail.gmail.com>
X-Gm-Features: AQ5f1Jo5c_rzCtK6r04J2m-KHiI22CUo11JxOin2-O__Lj4JFrTCJtdIWo19EQs
Message-ID: <CAMuHMdUUNFo4pqbXh1xMatsv7T7cnq0SmDxM_o9em0=gpurdCA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] thermal: renesas: rzg3s: Add thermal driver for
 the Renesas RZ/G3S SoC
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, p.zabel@pengutronix.de, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Mon, 24 Mar 2025 at 14:57, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The Renesas RZ/G3S SoC features a Thermal Sensor Unit (TSU) that reports
> the junction temperature. The temperature is reported through a dedicated
> ADC channel. Add a driver for the Renesas RZ/G3S TSU.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v3:
> - drop the runtime resume/suspend from rzg3s_thermal_get_temp(); this
>   is not needed as the temperature is read with ADC
> - opened the devres group id in rzg3s_thermal_probe() and rename
>   previsouly rzg3s_thermal_probe() to rzg3s_thermal_probe_helper(), to
>   have simpler code; this approach was suggested by Jonathan in [1];
>   as there is no positive feedback for the generic solution [2] this
>   looks currently the best approach

Thanks for the update!

> --- /dev/null
> +++ b/drivers/thermal/renesas/rzg3s_thermal.c

> +static int rzg3s_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +       struct rzg3s_thermal_priv *priv = thermal_zone_device_priv(tz);
> +       int ts_code_ave = 0;
> +       int ret, val;
> +
> +       if (priv->mode != THERMAL_DEVICE_ENABLED)
> +               return -EAGAIN;
> +
> +       for (u8 i = 0; i < TSU_READ_STEPS; i++) {
> +               ret = iio_read_channel_raw(priv->channel, &val);
> +               if (ret < 0)
> +                       return ret;
> +
> +               ts_code_ave += val;
> +               /*
> +                * According to the HW manual (section 40.4.4 Procedure for Measuring the
> +                * Temperature) we need to wait here at leat 3us.
> +                */
> +               usleep_range(5, 10);
> +       }
> +
> +       ret = 0;
> +       ts_code_ave = DIV_ROUND_CLOSEST(MCELSIUS(ts_code_ave), TSU_READ_STEPS);
> +
> +       /*
> +        * According to the HW manual (section 40.4.4 Procedure for Measuring the Temperature)
> +        * the computation formula is as follows:
> +        *
> +        * Tj = (ts_code_ave - priv->calib1) * 165 / (priv->calib0 - priv->calib1) - 40
> +        *
> +        * Convert everything to mili Celsius before applying the formula to avoid

milli

> +        * losing precision.
> +        */
> +
> +       *temp = DIV_ROUND_CLOSEST((s64)(ts_code_ave - MCELSIUS(priv->calib1)) * MCELSIUS(165),
> +                                 MCELSIUS(priv->calib0 - priv->calib1)) - MCELSIUS(40);

This is a 64-by-32 division. When compile-testing on arm32:

rzg3s_thermal.c:(.text+0x330): undefined reference to `__aeabi_ldivmod'

> +
> +       /* Report it in mili degrees Celsius and round it up to 0.5 degrees Celsius. */

milli


> +       *temp = roundup(*temp, 500);
> +
> +       return ret;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

