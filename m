Return-Path: <linux-pm+bounces-32606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880A9B2BB16
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 09:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2ACB5E62CB
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 07:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6CD280CFC;
	Tue, 19 Aug 2025 07:50:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6C02264CA;
	Tue, 19 Aug 2025 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589812; cv=none; b=PzRfJfe1o5egAD7Gp6Z0yQfQXRJNl3vfWAdQN6grUZcdyZqn4NwUiSJcqzImaBMwciejn9UdF4FSAw5JimBEj3eu48p2cLffRIfxuu1cWfs+VA4WEqSrAyZNm28v824mG04yZSAA1JTQ+P/L9GH1msxCYBe2alRnVEUsqrDUp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589812; c=relaxed/simple;
	bh=Ee2ObxfbUVPNh/3Zn9sXgxV5tzIeW55PDABLP8PSNvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZXjVF5kKAYja2K/dmUKRfy2hvUdKaoznEuyGDmMgU0pxIKK5+slBBDFNRC39qi6LP2xkcNO9v/zZbiwP5fxcOG9/ukn4HX9aKMS7hpSjtjC3uDFHs6ZiMYXr0J1ht+oyNbDV7EU0+v323xmeISqDo+aEwIqyFvvF/AHmoxA5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-890190a3579so1158604241.2;
        Tue, 19 Aug 2025 00:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755589808; x=1756194608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDMewuo9x/cu2BhGLPhUvUnCverX/+1L6wQ/8F1rHP8=;
        b=csx9p4zbmKnbUWc3QLeqoeVJPiF6kAtAQGxYy6aAu6ZqF26RtUW0UtOpHxCld+vcB0
         Iou1zdJ8XrSSVVZCm7vAmrDFlltTLelSaw4s4/RO0yyLvJ621fvssQk262yb2oJ+UGhk
         Apixl1kwh+/4Y54Iuze74zviOX+1ww2+fGyCaTzvcTzBeAjeInxlcZ4xVBG9AoG9y61e
         DJDapfx/8VhSk82JSBmDC3AJ6HOxNu43qAjSWNka/6fE/fRfF3v0jN5Dc5lY/AossOxB
         K6b1R0752c+43/fOFsqY962AMa3jPR6bUtG+0vj+xmkKQOD9Mooq4Df7OarqkW+/yqnt
         U3jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu4bic3StEZHlcEh1h+AUuHxgTABkzLTscsetLDcbythAWJScsGO7ugTYWXfN0I2z+64/f6dYFU8SX@vger.kernel.org, AJvYcCWE3fadI8JfVHZTAx7d3TjpL4sf3P3ZzmsBgpahQMNBz41WuNkQUegGG4Xwsio+HvnXl4ycnHF3GBZkAMh3m5liW6M=@vger.kernel.org, AJvYcCWTNX/TvMi2D0GOV2LtJDX/Ft6VuccWycBmC+xichw8RCJsBiJ3cdQbx0sdUn3umDc0/Q8nnFa3ZH4=@vger.kernel.org, AJvYcCWiCOfyxq+Bv5tzoCSsQduH/X1IlXS6nKXpUl6bOB5ajM4KH41godp2XSU7fADFu5nCItCeNwOAFS3k3/c3@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuiz3RR0yC6TRHVQct5AYchE1BHNKQKrnNkrhvGBGpkUFcy9Zt
	0q65LmrrLkIB1DnkQJpx2I6yNdCBXdhfeXcr86+9gVT6V4kmwL2UWpJJ7r5E5miK
X-Gm-Gg: ASbGncuivd45jOucdZVWx3lNlL7x5XgTPL3LgSk5Nr2z4r9u8m4upSEBrSlA6Gxvv08
	dLboLo1Snm3ZyhnrpANiN8WUFwo1dNdlWn7tHJHTrlR79B8amoFOt+SppdYuw/U2TYMZX4ZEpM5
	1VZ3PmjCewQ5n6HrVQrV3ksXfAQHBtMkeJipXoR3H9N2ZDW0mNeI2rLvXJMH/QBclAt6xYVl8P1
	hPhIa1A28091zQUjqh9HPiqxPjg4BYBV/kGu8HuvARs9Q+/5aLdGqVQBIy0OK/JREA79BAckJ9S
	xRQjONkiNXDjAUq0PXilvvq9i2AebzV8X/wfqifo5Hx2v5m7W4wc18oPYe4oDXNj9unBcI1vHcF
	h81UXmbjJD80NeSnp9nTnAxZYote5uvbMJSLzWTu2sLO38EB85hUyXpQnZjgF
X-Google-Smtp-Source: AGHT+IFKq4T0NeEevXORUaCDXBpcYjO5cKqFjxNCJVDpy+7CvkxOvJPTjkbFWl1QZhRAjhdwSmrguQ==
X-Received: by 2002:a05:6102:3050:b0:4fc:1a18:aaa2 with SMTP id ada2fe7eead31-51922115df7mr394414137.5.1755589808538;
        Tue, 19 Aug 2025 00:50:08 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bf26276sm2717519e0c.32.2025.08.19.00.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 00:50:08 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-50f88eea7f0so1587239137.1;
        Tue, 19 Aug 2025 00:50:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUC+k5OQVctYWGsQGRN3xO13cDy0qpja63+zUFg0Ga3eYyVWHJt8LkbtcoNtMpN+HjWUN/2GlYN4JI9kuBJQW49eU0=@vger.kernel.org, AJvYcCUypm2/ifwOi7qskursdGQxtqso2Oamfa6hwQsKZee77hcDd9M6aJiAgcQExiLTMy1r7p9d+BYSpB8K@vger.kernel.org, AJvYcCVYuDSMVHA1gZa5y5zFRXy+y/btEcVd48kuDcLZF4ZLooqO3jyI+7hSlyhCmkS+Ik60YMMvPy+rtxY=@vger.kernel.org, AJvYcCXq7Ky4etFGEz3zP0TLNaCk4sWZzvl3vaH4FJtuhUUS+1ZihuiaKDCEhxE3VSEWFGiEx6fIMdA69/001cHS@vger.kernel.org
X-Received: by 2002:a05:6102:26d3:b0:4f9:a927:d9f8 with SMTP id
 ada2fe7eead31-51922708edbmr391773137.8.1755589807543; Tue, 19 Aug 2025
 00:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818162859.9661-1-john.madieu.xa@bp.renesas.com> <20250818162859.9661-4-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20250818162859.9661-4-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Aug 2025 09:49:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUGmbn1H2JV17+9gTYBbnEOmoR9vUevWVx5BTX973MfoQ@mail.gmail.com>
X-Gm-Features: Ac12FXxVEIoEldC7Y_cxbfmRxaBIBcU2E7FFzwjWz0bJ3Q0eWxEWXbpo_Rtft2U
Message-ID: <CAMuHMdUGmbn1H2JV17+9gTYBbnEOmoR9vUevWVx5BTX973MfoQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, catalin.marinas@arm.com, will@kernel.org, 
	john.madieu@gmail.com, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, biju.das.jz@bp.renesas.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Mon, 18 Aug 2025 at 18:29, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> The RZ/G3E SoC integrates a Temperature Sensor Unit (TSU) block designed
> to monitor the chip's junction temperature. This sensor is connected to
> channel 1 of the APB port clock/reset and provides temperature measurements.
>
> It also requires calibration values stored in the system controller registers
> for accurate temperature measurement. Add a driver for the Renesas RZ/G3E TSU.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

> v7: Refactored driver structure:
>   - removes splinlock usage
>   - updates polling timeout as per the datasheet
>   - uses average mode to be more accurate
>   - uses polling (faster than irq mode) for get_temp() while keeping IRQ for hw
>   trip-point cross detection.
>   - adds both runtime and sleep PM support

Thanks for the update!

I only looked at the code to obtain the trim register offsets.

> --- /dev/null
> +++ b/drivers/thermal/renesas/rzg3e_thermal.c

> +static int rzg3e_thermal_parse_dt(struct rzg3e_thermal_priv *priv)
> +{
> +       struct device_node *np = priv->dev->of_node;
> +       struct of_phandle_args args;
> +       int ret;
> +
> +       ret = of_parse_phandle_with_args(np, "renesas,tsu-trim",
> +                                        "#address-cells", 0, &args);

of_parse_phandle_with_fixed_args(np, "renesas,tsu-trim", 1, 0, &args)

> +       if (ret)
> +               return dev_err_probe(priv->dev, ret,
> +                                    "Failed to parse renesas,tsu-trim\n");
> +
> +       if (args.args_count < 1) {

"!= 1", however, I think this test is no longer needed after moving
to of_parse_phandle_with_fixed_args().

> +               dev_err(priv->dev, "Invalid renesas,tsu-trim property\n");
> +               of_node_put(args.np);
> +               return -EINVAL;
> +       }
> +
> +       priv->trim_offset = args.args[0];
> +
> +       priv->syscon = syscon_node_to_regmap(args.np);
> +       of_node_put(args.np);
> +
> +       if (IS_ERR(priv->syscon))
> +               return dev_err_probe(priv->dev, PTR_ERR(priv->syscon),
> +                                    "Failed to get syscon regmap\n");
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

