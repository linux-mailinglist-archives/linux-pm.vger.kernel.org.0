Return-Path: <linux-pm+bounces-15347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEBC9952FD
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 17:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83A9FB24C40
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 14:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4C71E0483;
	Tue,  8 Oct 2024 14:58:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004F4DDDC;
	Tue,  8 Oct 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399481; cv=none; b=sjdEoD4R+h6129bYSEO+owhDEjlBGb2FEBFnW+MUAl2eWLS0GcuPh1jgcCfhZzsPp6wGTux7pgOQZCX6Asu8W2VK+WxhoQ1XMXB/q/sLdUCKFHQdYG54InpxQV0tR9CjlxBgHjQJhaiHqAfhu+gcUWWNJlYDIY1ForaWsLpinqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399481; c=relaxed/simple;
	bh=crsaGLA86y3yVVmaeedcq9KGFgZIFkhLNiw4C3UVM7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WN+KyAhZN2s5oyW5jC6HpN6AlQWalTcWfzSvgcRWdkCB80fBwrh59vwoR+Z81cDAOoNZk0T7eoAnOY+RxaszUP/dICo+bqAWHhb9NgPJb+38SvNZFwOo44PyM+VYUt2KeiWQzmViKxL0272NfqMRrXA/ve+y46sEDo3woAz9pYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e28eaf56ffcso1086504276.1;
        Tue, 08 Oct 2024 07:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399479; x=1729004279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vO87qeXV19lbaBjCeBCh8V3ciNo8R07ViYu/d9MCKE=;
        b=lUsrnTQMo7k5ub59dKbrJXdBP4KnTJ9y6S270UcGhV5fpGwTrIiH/jhViYVdqwsndG
         LT222nJpN4ZVCS0RvR14HKinoFIukRIxw9Mk6Nav+vZF7mTTfIC4nk+E4JTBnG1u2iyZ
         HZ/OyhmlbJJMrNtKy7hAZ9IA+eJlBvQXL203GTWbIp+L5IhDU1Fj8ke3Bb8ZDFRbrStg
         ZEeEY5/2+ViPouNqHg1I2NuVRbyCqGbUpEcUmSmx6/kzTE/Ig3dTbR99nV2WOtDMzaAx
         5H9+fb1ePf0+ad7f9eNBSeaY2tPDQ3XkbbDESZFMYs2iw4GjSpfm7ETbR7ZpFrReIu5Y
         nIFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1YN8Hig3GIkAFPRtI7jLsLCRVNTcXzg18ynVXzLNi5ONufIwqXtVvYdG+kb4gZplE4UlpqZfugqGx@vger.kernel.org, AJvYcCV2Tqmg0vz1rrh0cUAWQYla63Fe/FPT2rBGY5+UZ6hMrVg7U0sbvBRUmxx1bCAZ6HuTG/IgEugIPy1R@vger.kernel.org, AJvYcCWkIJsapsAmE4wngkZEvWYQRkZxnMKhWwil34shcb58r2Dkh2gV+nRSV81hTx8/4bEqIFPNbcTzu7uCf5EpWdFhUBk=@vger.kernel.org, AJvYcCXDJ8yAS4JFya1g7X1uFM3H4EZbuvNOhj2EOTf/AcCOy3+c9VSCc+P4f1Fgfu8XIRQNhm16W/DbqCJbsgYa@vger.kernel.org, AJvYcCXItA0/7R4aJ5ugH1vwxAkIfFcuc7LVHCif4VZDuNKxIkCyAw4YxWl3B/W/1FXcL09J4d1tpDUKRRE=@vger.kernel.org, AJvYcCXOHXHiRpsuwINKGAqoxQHPkqbDjOQIRG5NvilAZbkaSkav19J2fpI9SbjrBIzgbAqPLT2/ZwO1BXQM@vger.kernel.org
X-Gm-Message-State: AOJu0YxDENpIhbHpDMzIeC1u27eZKGKYXCDL6fiu5JsyX83Tc8/jV8rH
	6QCmh7bbUgdS8+LV2AhLIbL6Zpwtf5gpRSSKeku5OUTJcl1WSLMgxJkqW7BO
X-Google-Smtp-Source: AGHT+IEzeUj/GR3NdeWZ+FpB/SRbfASBkQk/vsnPol2V+nI8FqjuhFcx/Eyp88pgjF7KuDTagm46Vw==
X-Received: by 2002:a05:6902:188a:b0:e25:8411:5fcd with SMTP id 3f1490d57ef6-e2893922469mr13502844276.44.1728399478665;
        Tue, 08 Oct 2024 07:57:58 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28a5dbd2e8sm1362887276.60.2024.10.08.07.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 07:57:58 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6dbb24ee2ebso57826647b3.1;
        Tue, 08 Oct 2024 07:57:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFvhVC67PdgJfw4J9ap6IB5b7OUQvrrZ4Q0oO31SwMv+r/r6GXpRqCQXlRbjzgXWjS+USwnkjV78Yi@vger.kernel.org, AJvYcCUfuxDVPFBTwEShrIFZJ5qJw+Y3gAZX9ujzGeNnPjvee8RvZ8cg9QTKjJRDilPGhXPHJMAJd4bmoDP6r8Mf@vger.kernel.org, AJvYcCV+hBx3V6w2Uny4llW2+eEIXNegtznCqiefUnekdKVMIM8ZlgiGnp+vdGTvGxcADBu3WE3Cxr7kCmA=@vger.kernel.org, AJvYcCV3KeviHMM6ramvMfdeK5sVy7jOYrvj4gvgLAmcaP4y18hiAH4rGVEj0NhYyJd1aflWB+oNe2L1td5k5+lSm6JOaOA=@vger.kernel.org, AJvYcCWx4V1+wsjCCnQEKSKCOXrwgIjP+Fw9np74TjtlyXW1piJkBtpuMwhG28NbtSnZJt+4qMlmC7JVo3pm@vger.kernel.org, AJvYcCXsJEWeC5a3BmTW/O5CnUv1fNHY5xoZQu2Fckshu5ihtHGonDUg4uKol2jD9d7guijMO4VW/JGvhUCP@vger.kernel.org
X-Received: by 2002:a05:690c:81:b0:6e2:f61e:c52 with SMTP id
 00721157ae682-6e2f61e3ec4mr68204077b3.34.1728399475345; Tue, 08 Oct 2024
 07:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com> <20240822152801.602318-11-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-11-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Oct 2024 16:57:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1b5ZZaO+G1h=E8uv+WV7oS8xg8Hx=_+uORO7Qu33eNw@mail.gmail.com>
Message-ID: <CAMuHMdX1b5ZZaO+G1h=E8uv+WV7oS8xg8Hx=_+uORO7Qu33eNw@mail.gmail.com>
Subject: Re: [PATCH 10/16] phy: renesas: rcar-gen3-usb2: Add support to
 initialize the bus
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be, 
	magnus.damm@gmail.com, gregkh@linuxfoundation.org, mturquette@baylibre.com, 
	sboyd@kernel.org, yoshihiro.shimoda.uh@renesas.com, 
	biju.das.jz@bp.renesas.com, ulf.hansson@linaro.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Aug 22, 2024 at 5:28=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The Renesas RZ/G3S need to initialize the USB BUS before transferring dat=
a
> due to hardware limitation. As the register that need to be touched for
> this is in the address space of the USB PHY, and the UBS PHY need to be
> initialized before any other USB drivers handling data transfer, add
> support to initialize the USB BUS.
>
> As the USB PHY is probed before any other USB drivers that enables
> clocks and de-assert the reset signals and the BUS initialization is done
> in the probe phase, we need to add code to de-assert reset signal and
> runtime resume the device (which enables its clocks) before accessing
> the registers.
>
> As the reset signals are not required by the USB PHY driver for the other
> USB PHY hardware variants, the reset signals and runtime PM was handled
> only in the function that initialize the USB BUS.
>
> The PHY initialization was done right after runtime PM enable to have
> all in place when the PHYs are registered.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch, which is now commit 4eae16375357a2a7 ("phy:
renesas: rcar-gen3-usb2: Add support to initialize the bus") in
v6.12-rc1.

> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> @@ -650,6 +658,35 @@ static enum usb_dr_mode rcar_gen3_get_dr_mode(struct=
 device_node *np)
>         return candidate;
>  }
>
> +static int rcar_gen3_phy_usb2_init_bus(struct rcar_gen3_chan *channel)
> +{
> +       struct device *dev =3D channel->dev;
> +       int ret;
> +       u32 val;
> +
> +       channel->rstc =3D devm_reset_control_array_get_shared(dev);
> +       if (IS_ERR(channel->rstc))
> +               return PTR_ERR(channel->rstc);
> +
> +       ret =3D pm_runtime_resume_and_get(dev);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D reset_control_deassert(channel->rstc);
> +       if (ret)
> +               goto rpm_put;
> +
> +       val =3D readl(channel->base + USB2_AHB_BUS_CTR);
> +       val &=3D ~USB2_AHB_BUS_CTR_MBL_MASK;
> +       val |=3D USB2_AHB_BUS_CTR_MBL_INCR4;
> +       writel(val, channel->base + USB2_AHB_BUS_CTR);
> +
> +rpm_put:
> +       pm_runtime_put(dev);
> +
> +       return ret;
> +}
> +
>  static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
>  {
>         const struct rcar_gen3_phy_drv_data *phy_data;
> @@ -703,6 +740,15 @@ static int rcar_gen3_phy_usb2_probe(struct platform_=
device *pdev)
>                 goto error;
>         }
>
> +       platform_set_drvdata(pdev, channel);
> +       channel->dev =3D dev;

Unrelated change?

> +
> +       if (phy_data->init_bus) {
> +               ret =3D rcar_gen3_phy_usb2_init_bus(channel);
> +               if (ret)
> +                       goto error;
> +       }
> +
>         channel->soc_no_adp_ctrl =3D phy_data->no_adp_ctrl;
>         if (phy_data->no_adp_ctrl)
>                 channel->obint_enable_bits =3D USB2_OBINT_IDCHG_EN;
> @@ -733,9 +779,6 @@ static int rcar_gen3_phy_usb2_probe(struct platform_d=
evice *pdev)
>                 channel->vbus =3D NULL;
>         }
>
> -       platform_set_drvdata(pdev, channel);
> -       channel->dev =3D dev;
> -
>         provider =3D devm_of_phy_provider_register(dev, rcar_gen3_phy_usb=
2_xlate);
>         if (IS_ERR(provider)) {
>                 dev_err(dev, "Failed to register PHY provider\n");

The reset is not asserted in the error path, only in .remove().

Oh, Christophe already sent a fix for that...
"[PATCH v3] phy: renesas: rcar-gen3-usb2: Fix an error handling path
in rcar_gen3_phy_usb2_probe()"
https://lore.kernel.org/all/290b25827e3f0742808940719455ff0c5cb9d01d.172632=
9925.git.christophe.jaillet@wanadoo.fr

> @@ -762,6 +805,7 @@ static void rcar_gen3_phy_usb2_remove(struct platform=
_device *pdev)
>         if (channel->is_otg_channel)
>                 device_remove_file(&pdev->dev, &dev_attr_role);
>
> +       reset_control_assert(channel->rstc);
>         pm_runtime_disable(&pdev->dev);
>  };

The rest LGTM.

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

