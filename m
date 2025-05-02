Return-Path: <linux-pm+bounces-26577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F38EAA7572
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 17:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCCD9A3888
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 15:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7339925744F;
	Fri,  2 May 2025 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N14p/+W4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A34019004A;
	Fri,  2 May 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746198034; cv=none; b=jNX5BW+9PcZSUXvrv5sZSW142F9GYPB7A5ITZmnWl+6pN2oN8Geaz3+wLEgRPgYY2CKcfEbwMuo7P8xr0ORG5nqggHSk5yNnFZmlPLPEk7tAd2wYf3mP77BCCGYYfYMyvoxST5duWSfGThdlGEqs1OBml2cvm37nSXaTG98PpnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746198034; c=relaxed/simple;
	bh=YCaLeJJ8oxlx4RWpeoMHYLXvP61NicWmZQgdNQam4PM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNSofVAzgCrmL51tH2vyzAalhcTQGY7YHVl7y9gVsClppDOJ221kGaSxiQ98KudnmnrWOEOVmg9HkMVkwzhzHl+CfpH217DzVf1syAdE84jmxP6Sve7rpAIKyXhdi59TlJH4VKQweT+9RBEoHWpQpIvpUazi/FtaCB3yFqrwjPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N14p/+W4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso9486045e9.3;
        Fri, 02 May 2025 08:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746198030; x=1746802830; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bh+FKuJKEFXEfEJDk0owOsZcmwdLec3it7uqd7WJpoE=;
        b=N14p/+W45ML4tOLYXt0VgK7wwB09CzUDYQd8VucKcYkv/PGjOSaDNluBHRx4jZA31P
         OjfkPuluokbCLCEl7fWnYncdq8OkDGMODT9/O1vl3ZXx+Tpvr7DEyttGTpL+GuWt3uxh
         W14ALM+nxPCyO08ay9MQPFfkyQMfSfp/GjiL/kxaxBYtAiaZhTEQRMnSY3jSRviNCwqA
         Lxyx6HxXORbGsfGdEifKRA3ucW/mog6iguF9QUWwNOHaL0fGdruWwqu6BXeVsUJV/zDL
         X67Ot//43romCcrA1OVgEv+Kkx+5jpl4BNmMZ/B5Q7rGBecZKrl+FQTPWLbfWYuxEuPW
         AJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746198030; x=1746802830;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bh+FKuJKEFXEfEJDk0owOsZcmwdLec3it7uqd7WJpoE=;
        b=B9dCj1fao8uarFU9ADEQj3oMSpSgGSfH+cWLfiZRTHo5BvlRvcTIVPVn1U8bxalEYr
         jIqOC6Yxp88coO4c9G+cPzkScyvFHP/n1C1JX4MUxzIw7jHHVNylJ9ewmEafQ4SvbDjn
         SV2HL1kuSTEL6VT5Ge4q1B9KxDD9GzQWRWgNyCcQq6wLngZG37dUulYIm8K2knt+4IbR
         JN1mxuXYbVSQw59yUHeq4JME/oOOGZfbo2P1In1CeyHEnhywFrVqJsfZNcvpXAj7Ql0R
         WaYd/N0xVyQt7owJuq9kvZKxHccbDICkY8LpPNE/VFGDLxhn1odnTv4kFfPa0REC2z6N
         Hweg==
X-Forwarded-Encrypted: i=1; AJvYcCWCY2YQhM5NF7MlxK48khCr0owI/Qnxx6irqTIT+jlGvoaAuXMYaCYSDvlr3XkuB/qJmSR4cKU2zoM=@vger.kernel.org, AJvYcCWkoNPtcOOXiDxLm1emlZlZ19PFGUxFYSE8Sh/T9rJiH9nUtiYomNk8fyhWWsxW8oLCcqFEjETY/gCT@vger.kernel.org, AJvYcCXeJPwJ0Zz8hAOLNKpaWWQgQG2QUBKRPR0xMBB/9pzTk56i4kXoZNkhFqIKyHQtFaYObXewWnol9pXtjGrm@vger.kernel.org
X-Gm-Message-State: AOJu0YxQTZDELXlmtwwfxlXwfdIBj/mGVanGqXEarfj2nGd9q5xtuFus
	BAbk4rxs9fDwAhSEVsHAhI+dZJByIM2BB8OsyU2GIHn5LdkwGkWs
X-Gm-Gg: ASbGnctmjILiAnDSZtDpVOjzCuVnQ/PlDzq5uLGK1Nedooqby4JBc4KtyxS2g+GTz6R
	2pjlJG5MdKM8TCRITxV2SxkAn/P9+0zS/LUWhKijdn3d0zDaK/OEfLW6OQlBo9ZV/fSrN8fTGCk
	uVMpaHqzzDOQJk6eZWGbHEaap4RI/bMxGMceo+1wfrlEoL0Ucd9gGJHLS67/xA18dl36EnHWli6
	2sYQLLE8QUqf1JUP2P5pMhIhP5vZQjDCZR65Ozl0IX0DvgskA7Hg5DDj1lsIXjNpYIz2DNKx6mz
	VFsoyOSiDikP+i49tgh6Ae9Fyn8GuJIm+NCOyVdD9HVmR04FsRPWCGzmSyCkhDaHY1+0qbxjycA
	66rs15QuIeYX9zrtewg==
X-Google-Smtp-Source: AGHT+IEoogMNlr7/jkh7+0S2+X/h1OarNDapT1HesSwXWIEFA+VV6AIuJlEqbGSp8hNqDb4HgfIV1A==
X-Received: by 2002:a05:600c:8012:b0:43d:224:86b5 with SMTP id 5b1f17b1804b1-441bbe9002dmr29456415e9.4.1746198029694;
        Fri, 02 May 2025 08:00:29 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-21-27-29.retail.telecomitalia.it. [87.21.27.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b28045sm91764315e9.35.2025.05.02.08.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:00:29 -0700 (PDT)
Message-ID: <6814de0d.7b0a0220.2add1a.0689@mx.google.com>
X-Google-Original-Message-ID: <aBTeCMwdb_qV1LVp@Ansuel-XPS.>
Date: Fri, 2 May 2025 17:00:24 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] thermal: Add support for Airoha EN7581 thermal
 sensor
References: <20250226003608.8973-1-ansuelsmth@gmail.com>
 <20250226003608.8973-2-ansuelsmth@gmail.com>
 <a9f58437-5992-4042-85cd-b9150c4855ff@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9f58437-5992-4042-85cd-b9150c4855ff@linaro.org>

On Fri, May 02, 2025 at 03:30:56PM +0200, Daniel Lezcano wrote:
> On 26/02/2025 01:35, Christian Marangi wrote:
> > Add support for Airoha EN7581 thermal sensor. This provide support for
> > reading the CPU or SoC Package sensor and to setup trip points for hot
> > and critical condition. An interrupt is fired to react on this and
> > doesn't require passive poll to read the temperature.
> > 
> > The thermal regs provide a way to read the ADC value from an external
> > register placed in the Chip SCU regs. Monitor will read this value and
> > fire an interrupt if the trip condition configured is reached.
> > 
> > The Thermal Trip and Interrupt logic is conceptually similar to Mediatek
> > LVTS Thermal but differ in register mapping and actual function/bug
> > workaround. The implementation only share some register names but from
> > functionality observation it's very different and used only for the
> > basic function of periodically poll the temp and trip the interrupt.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Changes v5:
> > - Add additional info on difference from Mediatek LVTS driver
> 
> [ ... ]
> 
> > +static void airoha_init_thermal_ADC_mode(struct airoha_thermal_priv *priv)
> > +{
> > +	u32 adc_mux, pllrg;
> > +
> > +	/* Save PLLRG current value */
> > +	regmap_read(priv->chip_scu, EN7581_PLLRG_PROTECT, &pllrg);
> > +
> > +	/* Give access to thermal regs */
> > +	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, EN7581_SCU_THERMAL_PROTECT_KEY);
> > +	adc_mux = FIELD_PREP(EN7581_MUX_TADC, EN7581_SCU_THERMAL_MUX_DIODE1);
> > +	regmap_write(priv->chip_scu, EN7581_PWD_TADC, adc_mux);
> > +
> > +	/* Restore PLLRG value on exit */
> > +	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, pllrg);
> > +}
> > +
> > +static int airoha_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> > +{
> > +	struct airoha_thermal_priv *priv = thermal_zone_device_priv(tz);
> > +	int min, max, avg_temp, temp_adc;
> > +	int i;
> > +
> > +	/* Get the starting temp */
> > +	temp_adc = airoha_get_thermal_ADC(priv);
> > +	min = temp_adc;
> > +	max = temp_adc;
> > +	avg_temp = temp_adc;
> > +
> > +	/* Make 5 more measurement and average the temp ADC difference */
> > +	for (i = 0; i < 5; i++) {
> > +		temp_adc = airoha_get_thermal_ADC(priv);
> > +		avg_temp += temp_adc;
> > +		if (temp_adc > max)
> > +			max = temp_adc;
> > +		if (temp_adc < min)
> > +			min = temp_adc;
> > +	}
> > +	avg_temp = avg_temp - max - min;
> > +	avg_temp /= 4;
> > +
> > +	*temp = RAW_TO_TEMP(priv, avg_temp);
> > +	return 0;
> > +}
> 
> Does this chip support the averaging with the filtered mode which prevent to
> do this expensive calls when getting the temperature ?
>

If you notice in this function we read directly from the ADC sensor to
have a more precise and realtime temperature.

Yes the thermal module support averaging (and this is what is set for
the critical temperature monitor) but since we base everything on
interrupt the expensive call is called only when the user poll the
temperature with sysfs.

Do you prefer to use the thermal module entirely?

> > +static int airoha_thermal_set_trips(struct thermal_zone_device *tz, int low,
> > +				    int high)
> > +{
> > +	struct airoha_thermal_priv *priv = thermal_zone_device_priv(tz);
> > +
> > +	if (high != INT_MAX) {
> > +		/* Validate high and clamp them a sane value */
> > +		if (high > RAW_TO_TEMP(priv, FIELD_MAX(EN7581_DOUT_TADC_MASK)))
> > +			high = 110000;
> 
> There are helpers in minmax.h
> 

Ok will change to use the helper.

> > +		/* We offset the high temp of 1°C to trigger correct event */
> > +		writel(TEMP_TO_RAW(priv, high) >> 4,
> > +		       priv->base + EN7581_TEMPOFFSETH);
> > +	}
> > +
> > +	if (low != -INT_MAX) {
> > +		/* Validate low and clamp them to a sane value */
> > +		if (low < RAW_TO_TEMP(priv, 0))
> > +			low = -33000;
> 
> Same.
> 
> > +		/* We offset the low temp of 1°C to trigger correct event */
> > +		writel(TEMP_TO_RAW(priv, low) >> 4,
> > +		       priv->base + EN7581_TEMPOFFSETL);
> > +	}
> > +
> > +	/* Enable sensor 0 monitor */
> > +	writel(EN7581_SENSE0_EN, priv->base + EN7581_TEMPMONCTL0);
> 
> The sensor is enabled in this routine but disabled anywhere else. Should it
> be enabled in the init routine or in the set_mode callbacks ?
> 

It's expected, we enable sensor only when trip are actually set. I
observed that enabling before makes the thing fire interrupt with wrong
trip point or makes the module stuck in some strange way (due to
interrupt trip interval conflicts)

> > +	return 0;
> > +}
> > +
> > +static const struct thermal_zone_device_ops thdev_ops = {
> > +	.get_temp = airoha_thermal_get_temp,
> > +	.set_trips = airoha_thermal_set_trips,
> > +};
> > +
> > +static irqreturn_t airoha_thermal_irq(int irq, void *data)
> > +{
> > +	struct airoha_thermal_priv *priv = data;
> > +	enum thermal_notify_event event;
> > +	u32 status;
> > +
> > +	status = readl(priv->base + EN7581_TEMPMONINTSTS);
> > +	switch (status & (EN7581_HOFSINTSTS0 | EN7581_LOFSINTSTS0)) {
> > +	case EN7581_HOFSINTSTS0:
> > +		event = THERMAL_TRIP_VIOLATED;
> > +		break;
> > +	case EN7581_LOFSINTSTS0:
> > +		event = THERMAL_EVENT_UNSPECIFIED;
> > +		break;
> > +	default:
> > +		goto exit;
> 
> Is the default case possible ?
> 

No but it's really to make compile happy.

> > +	}
> > +	thermal_zone_device_update(priv->tz, event);
> > +
> > +exit:
> > +	/* reset interrupt */
> > +	writel(status, priv->base + EN7581_TEMPMONINTSTS);
> 
> You may want to the ack the interrupt before calling
> thermal_zone_device_update() as the underlying code can interact with the
> driver like calling set_trips. I'm not sure if it has on impact or not but
> IMO it is a good practice.
> 

Ok will move the interrupt reset before thermal_zone_device_update.

> > +	return IRQ_HANDLED;
> > +}
> > +
> 
> [ ... ]
> 
> > +static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
> > +{
> > +	/* Set measure mode */
> > +	writel(FIELD_PREP(EN7581_MSRCTL0, EN7581_MSRCTL_6SAMPLE_MAX_MIX_AVG4),
> > +	       priv->base + EN7581_TEMPMSRCTL0);
> > +
> > +	/*
> > +	 * Configure ADC valid reading addr
> > +	 * The AHB temp monitor system doesn't have direct access to the
> > +	 * thermal sensor. It does instead work by providing all kind of
> > +	 * address to configure how to access and setup an ADC for the
> > +	 * sensor. EN7581 supports only one sensor hence the
> > +	 * implementation is greatly simplified but the AHB supports
> > +	 * up to 4 different sensor from the same ADC that can be
> > +	 * switched by tuning the ADC mux or wiriting address.
> > +	 *
> > +	 * We set valid instead of volt as we don't enable valid/volt
> > +	 * split reading and AHB read valid addr in such case.
> > +	 */
> > +	writel(priv->scu_adc_res.start + EN7581_DOUT_TADC,
> > +	       priv->base + EN7581_TEMPADCVALIDADDR);
> > +
> > +	/*
> > +	 * Configure valid bit on a fake value of bit 16. The ADC outputs
> > +	 * max of 2 bytes for voltage.
> > +	 */
> > +	writel(FIELD_PREP(EN7581_ADV_RD_VALID_POS, 16),
> > +	       priv->base + EN7581_TEMPADCVALIDMASK);
> > +
> > +	/*
> > +	 * AHB supports max 12 bytes for ADC voltage. Shift the read
> > +	 * value 4 bit to the right. Precision lost by this is minimal
> > +	 * in the order of half a °C and is acceptable in the context
> > +	 * of triggering interrupt in critical condition.
> > +	 */
> > +	writel(FIELD_PREP(EN7581_ADC_VOLTAGE_SHIFT, 4),
> > +	       priv->base + EN7581_TEMPADCVOLTAGESHIFT);
> > +
> > +	/* BUS clock is 300MHz counting unit is 3 * 68.64 * 256 = 52.715us */
> > +	writel(FIELD_PREP(EN7581_PERIOD_UNIT, 3),
> > +	       priv->base + EN7581_TEMPMONCTL1);
> > +
> > +	/*
> > +	 * filt interval is 1 * 52.715us = 52.715us,
> > +	 * sen interval is 379 * 52.715us = 19.97ms
> > +	 */
> > +	writel(FIELD_PREP(EN7581_FILT_INTERVAL, 1) |
> > +	       FIELD_PREP(EN7581_FILT_INTERVAL, 379),
> > +	       priv->base + EN7581_TEMPMONCTL2);
> > +
> > +	/* AHB poll is set to 146 * 68.64 = 10.02us */
> > +	writel(FIELD_PREP(EN7581_ADC_POLL_INTVL, 146),
> > +	       priv->base + EN7581_TEMPAHBPOLL);
> > +}
> 
> Thanks for documenting the different steps
> 
> > +static int airoha_thermal_probe(struct platform_device *pdev)
> > +{
> > +	struct airoha_thermal_priv *priv;
> > +	struct device_node *chip_scu_np;
> > +	struct device *dev = &pdev->dev;
> > +	int irq, ret;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(priv->base))
> > +		return PTR_ERR(priv->base);
> > +
> > +	chip_scu_np = of_parse_phandle(dev->of_node, "airoha,chip-scu", 0);
> > +	if (!chip_scu_np)
> > +		return -EINVAL;
> > +
> > +	priv->chip_scu = syscon_node_to_regmap(chip_scu_np);
> > +	if (IS_ERR(priv->chip_scu))
> > +		return PTR_ERR(priv->chip_scu);
> > +
> > +	of_address_to_resource(chip_scu_np, 0, &priv->scu_adc_res);
> > +	of_node_put(chip_scu_np);
> > +
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq < 0)
> > +		return irq;
> > +
> > +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> > +					airoha_thermal_irq, IRQF_ONESHOT,
> > +					pdev->name, (void *)priv);
> 
> (void *) cast is not needed
> 
> > +	if (ret) {
> > +		dev_err(dev, "Can't get interrupt working.\n");
> > +		return ret;
> > +	}
> > +
> > +	airoha_thermal_setup_monitor(priv);
> > +	airoha_thermal_setup_adc_val(dev, priv);
> > +
> > +	/* register of thermal sensor and get info from DT */
> > +	priv->tz = devm_thermal_of_zone_register(dev, 0, priv, &thdev_ops);
> > +	if (IS_ERR(priv->tz)) {
> > +		dev_err(dev, "register thermal zone sensor failed\n");
> > +		return PTR_ERR(priv->tz);
> > +	}
> > +
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	/* Enable LOW and HIGH interrupt */
> > +	writel(EN7581_HOFSINTEN0 | EN7581_LOFSINTEN0,
> > +	       priv->base + EN7581_TEMPMONINT);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id airoha_thermal_match[] = {
> > +	{ .compatible = "airoha,en7581-thermal" },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, airoha_thermal_match);
> > +
> > +static struct platform_driver airoha_thermal_driver = {
> > +	.driver = {
> > +		.name = "airoha-thermal",
> > +		.of_match_table = airoha_thermal_match,
> > +	},
> > +	.probe = airoha_thermal_probe,
> > +};
> > +
> > +module_platform_driver(airoha_thermal_driver);
> > +
> > +MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
> > +MODULE_DESCRIPTION("Airoha thermal driver");
> > +MODULE_LICENSE("GPL");
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

