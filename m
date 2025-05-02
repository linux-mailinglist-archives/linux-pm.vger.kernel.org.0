Return-Path: <linux-pm+bounces-26569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FEDAA73AF
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 15:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF167462A9A
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22731255E2F;
	Fri,  2 May 2025 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Roylhygy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCE225484D
	for <linux-pm@vger.kernel.org>; Fri,  2 May 2025 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192662; cv=none; b=UcB0OJldy0Z7jtm/UwKl1jbo51e+7JMtQpC05LieFQfDPPMH8ejkT+120bydfyvncxi7s7mYBVaStclurLvr8k0GK3CtNQcd28btJGYPAUYm4mPqqKsi9co2uIirTmsNRmpaPqRk/nP74BpnvTO0bqO0sehmrVU0OzXWCzahSZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192662; c=relaxed/simple;
	bh=xwm4PR4J1pHQYqZeys9NZTAlKNXnL5uO4Imdg9Ky4pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QOy+sO9VZojYS2v9JOIpEE0Dl7Ajmdy+8P5+vzZuT+WxSXBm7sODs9fHv9IApey4NygqPVleB2YWXroFFA1arbm9dKUCfSsMBdlbVhuC7NkwDdROxedPxKSwrMrBEaGhkW20HIwT24xy2RcwXZ+sjHXVzZF5AFJwOtNATjhNYLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Roylhygy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso2119200f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 02 May 2025 06:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746192658; x=1746797458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kMgGRFDkxigeVP85QyWg0RWyuUUrnv+plnLqTjbVgnE=;
        b=RoylhygyyTe0ADYlysBnshjaMzfF89/vsPleULEriFBsLT6XFtVWry35e8ot77cj5F
         0s5LkAu9aXelg9H21IGKd58wQ3GBOi0gSeZyBo820JM3l4SciRGc+gmfT/SUNBd0j40B
         ok2vPn7S5GBBZ4wISjYF0bKxd/0SLsFUHGAZ0R4ZFCq0FBoW5vdKHZVIOh5o+9mB4ZNl
         tCdHomBjpt+yQXrA+m32L2MtL60bnPcco1krO3n8qC3T6XCp9CVUl5FkJMExPrqNTfs/
         c+WOHhb4vepuyZckvCsAmOy6/Zxcfh/VE/vjIaRk0FSM5UiZFNbqTtVfQLW+ahd38Wid
         /obQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746192658; x=1746797458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMgGRFDkxigeVP85QyWg0RWyuUUrnv+plnLqTjbVgnE=;
        b=hjDHngEMshDco/xlSIlZMtLAZmOwrFZt+nJvZO7/zVx9M55gCh5+t8ZfozPQ/CpP2u
         /BQnERE8CMDe1uV+mUnvETAY1MXZO+h3Q8x/tcmI3BQcwwxO9yx1Bjk5kAvl8xcDPzic
         QDfnS1DODo9AQESlP71Lm8knBTIOf86z1DFsVfZhwjetspeW8PIUaqI79hl1FSNIHHsw
         iIcCaJzYFwCn+QzqMdb6n9LzVtxhCyHV6y/cyH15D7i5K097bjo5B5C2rpihXy07sZWK
         yNi1pgqw7mMvKpjFrhRARA/HWZDacXyxn9oQmoAFmfx2QrdOo2jXocKXWBM1mZyB4mel
         c6pA==
X-Forwarded-Encrypted: i=1; AJvYcCULqdUf7wVGy39P+LNhVu9H7F46MzY3b/EkcwITQay0Ehn90cZ285OgWfbE1iRQ1vPDzsBqT5bT0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDputMH24zMQJToKZqPGFnuLqiN2yO6yQhEBB1oQG34Pivwgrn
	OT+K1oWW+WqKvYVKd+CK61D8xsaOTbIItIwADjywqSFclQnGJW6GTgTCOOKp4vE=
X-Gm-Gg: ASbGnctsKXSvBbG4RyylBv+3oPP5sazeQT52Ux3f5+T0Y1hLlmcee38FoLyd4XThueY
	kD0NuLsMVl2QzlRlA4/jTokzmUWkeyBGhEOtrXgcEgzFI1Lfs29/OJFynplfd5PPS47TWlYg7rj
	ZyR5+2W9XnsS13zB8S0VlMEUqF9U7LjDIn8Y7GXl/j8S05mtZLNHKQYKbQAqjo8dcNN9evxIz/H
	OoEEvmsKPKkVd5zWvSgntGCAl4zz2hDGfGln6CevfuIXvxNjGeh2IHQaGPVjw9Iwy61mPPUzotn
	5Vp00P3A4GQPOYxrgV2pj2i3Om/nhLHezdnNJT/L/mmm2zGtJCQHtLA6o60o/kyVSxnuDNlA5eW
	DDHe4
X-Google-Smtp-Source: AGHT+IEhNV/xlCdMw+Oc2CCiYFqdVlXKZQXVq4z+45X0TW5tIc8xQM22KI6qEwaK6y+ULeuHBJz7Qw==
X-Received: by 2002:a5d:5887:0:b0:3a0:870d:3152 with SMTP id ffacd0b85a97d-3a099add459mr2377048f8f.33.1746192658015;
        Fri, 02 May 2025 06:30:58 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a099ae3c1fsm2195661f8f.37.2025.05.02.06.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 06:30:57 -0700 (PDT)
Message-ID: <a9f58437-5992-4042-85cd-b9150c4855ff@linaro.org>
Date: Fri, 2 May 2025 15:30:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] thermal: Add support for Airoha EN7581 thermal
 sensor
To: Christian Marangi <ansuelsmth@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250226003608.8973-1-ansuelsmth@gmail.com>
 <20250226003608.8973-2-ansuelsmth@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250226003608.8973-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/02/2025 01:35, Christian Marangi wrote:
> Add support for Airoha EN7581 thermal sensor. This provide support for
> reading the CPU or SoC Package sensor and to setup trip points for hot
> and critical condition. An interrupt is fired to react on this and
> doesn't require passive poll to read the temperature.
> 
> The thermal regs provide a way to read the ADC value from an external
> register placed in the Chip SCU regs. Monitor will read this value and
> fire an interrupt if the trip condition configured is reached.
> 
> The Thermal Trip and Interrupt logic is conceptually similar to Mediatek
> LVTS Thermal but differ in register mapping and actual function/bug
> workaround. The implementation only share some register names but from
> functionality observation it's very different and used only for the
> basic function of periodically poll the temp and trip the interrupt.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v5:
> - Add additional info on difference from Mediatek LVTS driver

[ ... ]

> +static void airoha_init_thermal_ADC_mode(struct airoha_thermal_priv *priv)
> +{
> +	u32 adc_mux, pllrg;
> +
> +	/* Save PLLRG current value */
> +	regmap_read(priv->chip_scu, EN7581_PLLRG_PROTECT, &pllrg);
> +
> +	/* Give access to thermal regs */
> +	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, EN7581_SCU_THERMAL_PROTECT_KEY);
> +	adc_mux = FIELD_PREP(EN7581_MUX_TADC, EN7581_SCU_THERMAL_MUX_DIODE1);
> +	regmap_write(priv->chip_scu, EN7581_PWD_TADC, adc_mux);
> +
> +	/* Restore PLLRG value on exit */
> +	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, pllrg);
> +}
> +
> +static int airoha_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +	struct airoha_thermal_priv *priv = thermal_zone_device_priv(tz);
> +	int min, max, avg_temp, temp_adc;
> +	int i;
> +
> +	/* Get the starting temp */
> +	temp_adc = airoha_get_thermal_ADC(priv);
> +	min = temp_adc;
> +	max = temp_adc;
> +	avg_temp = temp_adc;
> +
> +	/* Make 5 more measurement and average the temp ADC difference */
> +	for (i = 0; i < 5; i++) {
> +		temp_adc = airoha_get_thermal_ADC(priv);
> +		avg_temp += temp_adc;
> +		if (temp_adc > max)
> +			max = temp_adc;
> +		if (temp_adc < min)
> +			min = temp_adc;
> +	}
> +	avg_temp = avg_temp - max - min;
> +	avg_temp /= 4;
> +
> +	*temp = RAW_TO_TEMP(priv, avg_temp);
> +	return 0;
> +}

Does this chip support the averaging with the filtered mode which 
prevent to do this expensive calls when getting the temperature ?

> +static int airoha_thermal_set_trips(struct thermal_zone_device *tz, int low,
> +				    int high)
> +{
> +	struct airoha_thermal_priv *priv = thermal_zone_device_priv(tz);
> +
> +	if (high != INT_MAX) {
> +		/* Validate high and clamp them a sane value */
> +		if (high > RAW_TO_TEMP(priv, FIELD_MAX(EN7581_DOUT_TADC_MASK)))
> +			high = 110000;

There are helpers in minmax.h

> +		/* We offset the high temp of 1°C to trigger correct event */
> +		writel(TEMP_TO_RAW(priv, high) >> 4,
> +		       priv->base + EN7581_TEMPOFFSETH);
> +	}
> +
> +	if (low != -INT_MAX) {
> +		/* Validate low and clamp them to a sane value */
> +		if (low < RAW_TO_TEMP(priv, 0))
> +			low = -33000;

Same.

> +		/* We offset the low temp of 1°C to trigger correct event */
> +		writel(TEMP_TO_RAW(priv, low) >> 4,
> +		       priv->base + EN7581_TEMPOFFSETL);
> +	}
> +
> +	/* Enable sensor 0 monitor */
> +	writel(EN7581_SENSE0_EN, priv->base + EN7581_TEMPMONCTL0);

The sensor is enabled in this routine but disabled anywhere else. Should 
it be enabled in the init routine or in the set_mode callbacks ?

> +	return 0;
> +}
> +
> +static const struct thermal_zone_device_ops thdev_ops = {
> +	.get_temp = airoha_thermal_get_temp,
> +	.set_trips = airoha_thermal_set_trips,
> +};
> +
> +static irqreturn_t airoha_thermal_irq(int irq, void *data)
> +{
> +	struct airoha_thermal_priv *priv = data;
> +	enum thermal_notify_event event;
> +	u32 status;
> +
> +	status = readl(priv->base + EN7581_TEMPMONINTSTS);
> +	switch (status & (EN7581_HOFSINTSTS0 | EN7581_LOFSINTSTS0)) {
> +	case EN7581_HOFSINTSTS0:
> +		event = THERMAL_TRIP_VIOLATED;
> +		break;
> +	case EN7581_LOFSINTSTS0:
> +		event = THERMAL_EVENT_UNSPECIFIED;
> +		break;
> +	default:
> +		goto exit;

Is the default case possible ?

> +	}
> +	thermal_zone_device_update(priv->tz, event);
> +
> +exit:
> +	/* reset interrupt */
> +	writel(status, priv->base + EN7581_TEMPMONINTSTS);

You may want to the ack the interrupt before calling 
thermal_zone_device_update() as the underlying code can interact with 
the driver like calling set_trips. I'm not sure if it has on impact or 
not but IMO it is a good practice.

> +	return IRQ_HANDLED;
> +}
> +

[ ... ]

> +static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
> +{
> +	/* Set measure mode */
> +	writel(FIELD_PREP(EN7581_MSRCTL0, EN7581_MSRCTL_6SAMPLE_MAX_MIX_AVG4),
> +	       priv->base + EN7581_TEMPMSRCTL0);
> +
> +	/*
> +	 * Configure ADC valid reading addr
> +	 * The AHB temp monitor system doesn't have direct access to the
> +	 * thermal sensor. It does instead work by providing all kind of
> +	 * address to configure how to access and setup an ADC for the
> +	 * sensor. EN7581 supports only one sensor hence the
> +	 * implementation is greatly simplified but the AHB supports
> +	 * up to 4 different sensor from the same ADC that can be
> +	 * switched by tuning the ADC mux or wiriting address.
> +	 *
> +	 * We set valid instead of volt as we don't enable valid/volt
> +	 * split reading and AHB read valid addr in such case.
> +	 */
> +	writel(priv->scu_adc_res.start + EN7581_DOUT_TADC,
> +	       priv->base + EN7581_TEMPADCVALIDADDR);
> +
> +	/*
> +	 * Configure valid bit on a fake value of bit 16. The ADC outputs
> +	 * max of 2 bytes for voltage.
> +	 */
> +	writel(FIELD_PREP(EN7581_ADV_RD_VALID_POS, 16),
> +	       priv->base + EN7581_TEMPADCVALIDMASK);
> +
> +	/*
> +	 * AHB supports max 12 bytes for ADC voltage. Shift the read
> +	 * value 4 bit to the right. Precision lost by this is minimal
> +	 * in the order of half a °C and is acceptable in the context
> +	 * of triggering interrupt in critical condition.
> +	 */
> +	writel(FIELD_PREP(EN7581_ADC_VOLTAGE_SHIFT, 4),
> +	       priv->base + EN7581_TEMPADCVOLTAGESHIFT);
> +
> +	/* BUS clock is 300MHz counting unit is 3 * 68.64 * 256 = 52.715us */
> +	writel(FIELD_PREP(EN7581_PERIOD_UNIT, 3),
> +	       priv->base + EN7581_TEMPMONCTL1);
> +
> +	/*
> +	 * filt interval is 1 * 52.715us = 52.715us,
> +	 * sen interval is 379 * 52.715us = 19.97ms
> +	 */
> +	writel(FIELD_PREP(EN7581_FILT_INTERVAL, 1) |
> +	       FIELD_PREP(EN7581_FILT_INTERVAL, 379),
> +	       priv->base + EN7581_TEMPMONCTL2);
> +
> +	/* AHB poll is set to 146 * 68.64 = 10.02us */
> +	writel(FIELD_PREP(EN7581_ADC_POLL_INTVL, 146),
> +	       priv->base + EN7581_TEMPAHBPOLL);
> +}

Thanks for documenting the different steps

> +static int airoha_thermal_probe(struct platform_device *pdev)
> +{
> +	struct airoha_thermal_priv *priv;
> +	struct device_node *chip_scu_np;
> +	struct device *dev = &pdev->dev;
> +	int irq, ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	chip_scu_np = of_parse_phandle(dev->of_node, "airoha,chip-scu", 0);
> +	if (!chip_scu_np)
> +		return -EINVAL;
> +
> +	priv->chip_scu = syscon_node_to_regmap(chip_scu_np);
> +	if (IS_ERR(priv->chip_scu))
> +		return PTR_ERR(priv->chip_scu);
> +
> +	of_address_to_resource(chip_scu_np, 0, &priv->scu_adc_res);
> +	of_node_put(chip_scu_np);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +					airoha_thermal_irq, IRQF_ONESHOT,
> +					pdev->name, (void *)priv);

(void *) cast is not needed

> +	if (ret) {
> +		dev_err(dev, "Can't get interrupt working.\n");
> +		return ret;
> +	}
> +
> +	airoha_thermal_setup_monitor(priv);
> +	airoha_thermal_setup_adc_val(dev, priv);
> +
> +	/* register of thermal sensor and get info from DT */
> +	priv->tz = devm_thermal_of_zone_register(dev, 0, priv, &thdev_ops);
> +	if (IS_ERR(priv->tz)) {
> +		dev_err(dev, "register thermal zone sensor failed\n");
> +		return PTR_ERR(priv->tz);
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	/* Enable LOW and HIGH interrupt */
> +	writel(EN7581_HOFSINTEN0 | EN7581_LOFSINTEN0,
> +	       priv->base + EN7581_TEMPMONINT);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id airoha_thermal_match[] = {
> +	{ .compatible = "airoha,en7581-thermal" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, airoha_thermal_match);
> +
> +static struct platform_driver airoha_thermal_driver = {
> +	.driver = {
> +		.name = "airoha-thermal",
> +		.of_match_table = airoha_thermal_match,
> +	},
> +	.probe = airoha_thermal_probe,
> +};
> +
> +module_platform_driver(airoha_thermal_driver);
> +
> +MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
> +MODULE_DESCRIPTION("Airoha thermal driver");
> +MODULE_LICENSE("GPL");


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

