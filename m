Return-Path: <linux-pm+bounces-38639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DBEC86327
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 18:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13B744E1598
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 17:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146B1329E45;
	Tue, 25 Nov 2025 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEres30K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3C2325735
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764091485; cv=none; b=sB67hPxbOqw4vJGEWxOI7IeGxyK2Pq1UGItg+gzlTluJugXrfKnVGypJkqSFIqgxfvMAcsOjr0gH8QiB4iQIdQ76KMlfC2U88//xMjdqSZwlCx1jQk9IICRSmIx1TwyOm/CrTbWl0CGBElyFRUi/vxavtHS/bMVaAbefSUZPBsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764091485; c=relaxed/simple;
	bh=mW5i4ZsYV6c3sNpVkny3bzcPjL6oaX17wg87dY/CGnA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lw7VECvn6JLm9jHiKoi44z0wRA2l4yUqOiNN6/YzGFoABVys6z9EhmHIXqr2DOmmI6oGqUtSFPuQ72Cud1GZdrjQDbVnUlyFVijKINLEp3nXTJuGsaE6GFPQ8zCJLHkp7kuo+HlBo65Dk+twcc1EqCHMnpS251H+rEm2g6t7qX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEres30K; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b32a3e78bso4799297f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 09:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764091481; x=1764696281; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RGATyOgXp42LDmRcNZq2Sktgd1PbMGibFdor1Yjljrc=;
        b=CEres30KTsDoNNoUOBBU1XK+Ex/BcxFIezJ+4KEuQO4zhTXnF8nf/E7ISBOuaMeEhV
         QjaWVeGzS8XB8jjYDTj1xKW3bYgfmgkZyQ6Vg1BE9n4ab66fIzXeq6zQVVlnwAdgFRaa
         WAoJXjvDSVJ1RuA4OadG6whDEl1eaybhqHqaPDql/gI/Ukio14bmw9yayyIf3YcKt4ig
         tt5f1TeIzO0GjLzcCsaqa4X4T/YrAbFw8awEo+REc1CwCeCjQHYvIE3PTUjOkqd0bLvi
         uoaOJ3YurPSsWC5mfh3Yz5oX+9kahVmeHYk2YQ+5qfoK3t+L+ODpuJShBYbl+CelwH+F
         FZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764091481; x=1764696281;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGATyOgXp42LDmRcNZq2Sktgd1PbMGibFdor1Yjljrc=;
        b=TQtEkKMtsRVFHNei0R/+mgcsfo/VzHiN/FZ0ud8IAgtOAJrxJwju0x/ALHtwqbYaQL
         RbMcVX8mQVk4BgWyNb/yzi9Udwv7GnegeziAsw3ejs4PPpBdcD2I+ZuoQvm9LlsfNUMo
         UUO01ohitz+Z7rjyiCog2MEqrOuOkW82C5x/URcvyzCX8e1MWE8NL8vddo7YOyFD7+cE
         guEEtNihnMSDgurqU5GceHv+rNirxKcWhyRzMyhjGph4SQGDMtRWnMs1jOrK83k9EWpx
         uIx/jv28y8Y5F3+OD2zaHmB5SrAI5dHdcrb7qnEU6bmUfMvWt6Ep//hrUVTPI6fz1yEz
         9ogw==
X-Forwarded-Encrypted: i=1; AJvYcCXP8zUSoEanJjiT2J2Z/amDu9gih742GnrpY/7sdIA3lsE+vbTpN5YBlHj/ycsAq6ysYWqVHJst4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGiOaK53w1LL+XqTCEm8invpxU4AaOV6sAvLC/CtSOtFtfKvvL
	YfuQQtsSQB6Wdr9rNiaKcNCx9Cbtr0jTvSZ58QnClPzx/qOIrWv7krAA
X-Gm-Gg: ASbGncv7RzGGofetZBHgZCThrM0R/vl9JC/e+8FVShDUHnCIhXzZxATjuZEqFOv6cLH
	H5LyPFD2dp4o2Ania47O3fI4BI1fS9P2DjXFsD6E2cjvd8o8BYti0rb2VWH7OdbfMCgldXX5jNi
	sTAS8CTGiSBGfKKhGuTnRq5ZC6zNX4IWq61YxWDZ0huUR7Xu7LveBdoEwLy7ATKdYgClhSYQEa5
	Jo1DRZ8HwXNkFIa9gjHGWXQUZULdLSYXrYX7pfGQr8XqC1rd0DbC1gvqHHoznrv7W7vKVMCHjAu
	2eWQT4phlL18WscFxcK637rNxR4K+TD2x3Z8uJv2iFomyFG4hf4pmt4DAaypG8/YjuJGt4syOwY
	xn4qdTLgR4d982YgcdoDN3phTWUl3I3oS8hXUu1XwupqasMe0Ep/+7PCpEgV8AMhznLXlc53Kop
	hP00TACbku1SO1uwgF4X2R8P9A56LvMPTB5edkEi0=
X-Google-Smtp-Source: AGHT+IGGlJILr1yxZUySqJ26o99QHy7vFsgnJsgmNTZWEb/+Nn2jYGW5G2u/LpbR4kGlV4rPRDup6w==
X-Received: by 2002:a05:6000:1a4f:b0:42b:3701:c4c0 with SMTP id ffacd0b85a97d-42cc1ac9df6mr14790639f8f.5.1764091481259;
        Tue, 25 Nov 2025 09:24:41 -0800 (PST)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm35465358f8f.33.2025.11.25.09.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 09:24:40 -0800 (PST)
Message-ID: <6925e658.df0a0220.2663e0.f992@mx.google.com>
X-Google-Original-Message-ID: <aSXmVHQ-F_Am-X2a@Ansuel-XPS.>
Date: Tue, 25 Nov 2025 18:24:36 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/5] thermal/drivers: airoha: Generalize probe function
References: <20251106225929.1778398-1-ansuelsmth@gmail.com>
 <20251106225929.1778398-3-ansuelsmth@gmail.com>
 <23a99187-0ca5-459e-8bf0-b3bf61dd12fe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23a99187-0ca5-459e-8bf0-b3bf61dd12fe@linaro.org>

On Tue, Nov 25, 2025 at 06:16:29PM +0100, Daniel Lezcano wrote:
> On 11/6/25 23:59, Christian Marangi wrote:
> > In preparation for support of Airoha AN7583, generalize the probe
> > function to address for the 2 SoC differece.
> > 
> > Implement a match_data struct where it's possible to define a more
> > specific probe and post_probe function and specific thermal ops and
> > pllrg protect value.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >   drivers/thermal/airoha_thermal.c | 102 +++++++++++++++++++++++--------
> >   1 file changed, 75 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
> > index 01ed49a4887e..864a01fd8fd8 100644
> > --- a/drivers/thermal/airoha_thermal.c
> > +++ b/drivers/thermal/airoha_thermal.c
> > @@ -198,12 +198,23 @@ struct airoha_thermal_priv {
> >   	struct regmap *chip_scu;
> >   	struct resource scu_adc_res;
> > +	u32 pllrg_protect;
> > +
> >   	struct thermal_zone_device *tz;
> >   	int init_temp;
> >   	int default_slope;
> >   	int default_offset;
> >   };
> > +struct airoha_thermal_soc_data {
> > +	u32 pllrg_protect;
> > +
> > +	const struct thermal_zone_device_ops *thdev_ops;
> > +	int (*probe)(struct platform_device *pdev,
> > +		     struct airoha_thermal_priv *priv);
> > +	int (*post_probe)(struct platform_device *pdev);
> 
> What the post-probe provides compared to calling the corresponding code in
> the probe function ?
>

Hi Daniel,

the usage would be to do those operation that should be done AFTER the
thermal zone are registered. In this specific case, to enable the
interrupt.

(they can't be enabled before as they will fire up immediately due to
wrong configuration of trip point)

I can also limit enabling the interrupt to AN7581 by checking the
compatible. I probably went too much with the modular approach.

> > +};
> > +
> >   static int airoha_get_thermal_ADC(struct airoha_thermal_priv *priv)
> >   {
> >   	u32 val;
> > @@ -220,7 +231,8 @@ static void airoha_init_thermal_ADC_mode(struct airoha_thermal_priv *priv)
> >   	regmap_read(priv->chip_scu, EN7581_PLLRG_PROTECT, &pllrg);
> >   	/* Give access to thermal regs */
> > -	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, EN7581_SCU_THERMAL_PROTECT_KEY);
> > +	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT,
> > +		     priv->pllrg_protect);
> >   	adc_mux = FIELD_PREP(EN7581_MUX_TADC, EN7581_SCU_THERMAL_MUX_DIODE1);
> >   	regmap_write(priv->chip_scu, EN7581_PWD_TADC, adc_mux);
> > @@ -228,7 +240,7 @@ static void airoha_init_thermal_ADC_mode(struct airoha_thermal_priv *priv)
> >   	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, pllrg);
> >   }
> > -static int airoha_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> > +static int en7581_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> 
> Please provide a separate patch before where s/airoha/en7581/
> 

Ok no problem.

> [ ... ]
> > +static int en7581_thermal_post_probe(struct platform_device *pdev)
> > +{
> > +	struct airoha_thermal_priv *priv = platform_get_drvdata(pdev);
> > +
> > +	/* Enable LOW and HIGH interrupt (if supported) */
> 
> Why "(if supported)" ?
> 

Airoha AN7583 won't support this. But I understand this is confusing
since this function is specific to AN7581.

> > +	regmap_write(priv->map, EN7581_TEMPMONINT,
> > +		     EN7581_HOFSINTEN0 | EN7581_LOFSINTEN0);
> > +
> > +	return 0;
> > +}
> > +
> > +static int airoha_thermal_probe(struct platform_device *pdev)
> > +{
> > +	const struct airoha_thermal_soc_data *soc_data;
> > +	struct airoha_thermal_priv *priv;
> > +	struct device *dev = &pdev->dev;
> > +	int ret;
> > +
> > +	soc_data = device_get_match_data(dev);
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->pllrg_protect = soc_data->pllrg_protect;
> > +
> > +	if (!soc_data->probe)
> > +		return -EINVAL;
> 
> Shall the driver check its own code ?
> > +	ret = soc_data->probe(pdev, priv);
> > +	if (ret)
> 

Well it's expected to be always present so I guess I can drop this.

> [ ... ]
> > +static const struct airoha_thermal_soc_data en7581_data = {
> > +	.pllrg_protect = EN7581_SCU_THERMAL_PROTECT_KEY,
> > +	.thdev_ops = &en7581_thdev_ops,
> > +	.probe = &en7581_thermal_probe,
> > +	.post_probe = &en7581_thermal_post_probe,
> 	.probe = en7581_thermal_probe,
> 	.post_probe = en7581_thermal_post_probe,
> 
> > +};
> > +
> >   static const struct of_device_id airoha_thermal_match[] = {
> > -	{ .compatible = "airoha,en7581-thermal" },
> > +	{ .compatible = "airoha,en7581-thermal", .data = &en7581_data },
> >   	{},
> >   };
> >   MODULE_DEVICE_TABLE(of, airoha_thermal_match);
> 
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

-- 
	Ansuel

