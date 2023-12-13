Return-Path: <linux-pm+bounces-1046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193E9810D8B
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 10:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5BB1C20969
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 09:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220E02031B;
	Wed, 13 Dec 2023 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dM7WcHCx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25D5D5;
	Wed, 13 Dec 2023 01:41:42 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-55226029d17so418006a12.0;
        Wed, 13 Dec 2023 01:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702460501; x=1703065301; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C83DAGlgLjSSq6kThFj4INGY4aLqpVekjXi2FmsqvB8=;
        b=dM7WcHCxtTMhH2KhR49nSSY+dAd/7DlWP6KpUuzqN/y9xj9XgKCoJahjrOS0hsXuFD
         B5J6WFTh6qCH1RVQsiML/FtoRSCPkILYBBFWdUYe2r7U0X2Hepp3PK1C5gryPagMtC3q
         RnS+G0MQQVJpI6XB2rKJj/GfCqyLR+oWR8PUQgDGK0VaDG/lxYkXSYHx8Ml4eM83v7ws
         Cn5mbFDt/nuLRbLgt4iIOE9CgFNe+sBJ3gONGRqwbjY8yW0A7p8deI+9ZkiZipziNoZL
         3sL6y43KM8XMscidnLYTC2skPHLmYDwkKdIsmzRHKwJtzCcTdSfsAroBaIKB3T/sFIqI
         vU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702460501; x=1703065301;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C83DAGlgLjSSq6kThFj4INGY4aLqpVekjXi2FmsqvB8=;
        b=VUIZOLlgRnkFuWtPEMvnLWhZ33eaW0fpStnwLQOUeVsjV0ODA3aGqY6iPtzw5isfPF
         DuJHYf0HkE0JQQOxivYnWnHoOCGQRfHVVR6rQlhaBmU7nIwbTo5Q4qozBNIOom4JQi1P
         TWE7jG4oBCPFlXzRdbK3D3gzAMB9qhtrBUzQRTLpdoj5OJm4AZ4cRNnPkjMKUmtKlJyA
         ur4+2Wcq7SdbkxDGWV2hs+8BnxHttWgBUoxavGv5uR738OYXRDViyMPMyM48aQUm1gG4
         51+P64z/VH8/MMCRAAYxliUfQlWkdvkwQhB98KIN5OzjX04xnDAjV1kmNOEfJFsDEJ2a
         sCrg==
X-Gm-Message-State: AOJu0YyRPkribyxv/2qIkpW5sbH2fK0XeeEuj1VKZjLN8rNN2cxddkq9
	kW4dOsdNaXRp4rdM+hjuo3GTRArwJ9vQO/YvW14VL8fmSJNhfg==
X-Google-Smtp-Source: AGHT+IG0bBWmjm6NcYA2QyCq5cfwbQDssTLyiI6RX1jLAlo6UEOqt8P078NxAt96sT8oxJMzFlNusGWOMWuo3iQnNhY=
X-Received: by 2002:a17:906:3390:b0:a1d:b97b:58d4 with SMTP id
 v16-20020a170906339000b00a1db97b58d4mr3482432eja.98.1702460501003; Wed, 13
 Dec 2023 01:41:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Wed, 13 Dec 2023 12:41:29 +0300
Message-ID: <CALHCpMj3+g5MD1vHdtZeYP3=2xBYvXMBH9ai376YwETGJRyeyA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] thermal: sun8i: add support for H616 THS controller
To: Andre Przywara <andre.przywara@arm.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, bob@electricworry.net, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev, lukasz.luba@arm.com, 
	martin.botka@somainline.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Samuel Holland <samuel@sholland.org>, Yangtao Li <tiny.windzz@gmail.com>, 
	Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"

Hello, again!

On 28.11.2023 03:58, Andre Przywara wrote:
> From: Martin Botka <martin.botka@somainline.org>
>
> Add support for the thermal sensor found in H616 SoCs, which slightly
> resembles the H6 thermal sensor controller, with a few changes like
> four sensors.
> Also the registers readings are wrong, unless a bit in the first SYS_CFG
> register cleared, so set needs_syscon to trigger that code
>
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> drivers/thermal/sun8i_thermal.c | 73 +++++++++++++++++++++++++++++++++
> 1 file changed, 73 insertions(+)
>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index 920e419ce7343..9a404fa9d76a9 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -280,6 +280,64 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
> return 0;
> }
>
> +static int sun50i_h616_ths_calibrate(struct ths_device *tmdev,
> + u16 *caldata, int callen)
> +{
> + struct device *dev = tmdev->dev;
> + int i, ft_temp;
> +
> + if (!caldata[0])
> + return -EINVAL;
> +
> + /*
> + * h616 efuse THS calibration data layout:
> + *
> + * 0 11 16 27 32 43 48 57
> + * +----------+-----------+-----------+-----------+
> + * | temp | |sensor0| |sensor1| |sensor2| |
> + * +----------+-----------+-----------+-----------+
> + * ^ ^ ^
> + * | | |
> + * | | sensor3[11:8]
> + * | sensor3[7:4]
> + * sensor3[3:0]
> + *
> + * The calibration data on the H616 is the ambient temperature and
> + * sensor values that are filled during the factory test stage.
> + *
> + * The unit of stored FT temperature is 0.1 degree celsius.
> + */
> + ft_temp = caldata[0] & FT_TEMP_MASK;
> +
> + for (i = 0; i < tmdev->chip->sensor_num; i++) {
> + int delta, cdata, offset, reg, temp;
> +
> + if (i == 3)
> + reg = (caldata[1] >> 12)
> + | ((caldata[2] >> 12) << 4)
> + | ((caldata[3] >> 12) << 8);
> + else
> + reg = (int)caldata[i + 1] & TEMP_CALIB_MASK;
> +
> + temp = tmdev->chip->calc_temp(tmdev, i, reg);
> + delta = ((temp - ft_temp * 100) * 10) / tmdev->chip->scale;
> + cdata = CALIBRATE_DEFAULT - delta;
> + if (cdata & ~TEMP_CALIB_MASK) {
> + dev_warn(dev, "sensor%d is not calibrated.\n", i);
> +
> + continue;
> + }
> +
> + offset = (i % 2) * 16;
> + regmap_update_bits(tmdev->regmap,
> + SUN50I_H6_THS_TEMP_CALIB + (i / 2 * 4),
> + TEMP_CALIB_MASK << offset,
> + cdata << offset);
> + }
> +
> + return 0;
> +}
> +
> static int sun8i_ths_calibrate(struct ths_device *tmdev)
> {
> struct nvmem_cell *calcell;
> @@ -659,6 +717,20 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
> .calc_temp = sun8i_ths_calc_temp,
> };
>
> +static const struct ths_thermal_chip sun50i_h616_ths = {
> + .sensor_num = 4,
> + .has_bus_clk_reset = true,
> + .needs_syscon = true,
> + .ft_deviation = 8000,
> + .offset = 263655,
> + .scale = 810,

Can I ask you, how did you get the offset and the scale values?

In the H616 user manual (3.10.3.4. THS Temperature Conversion Formula)
we can find this formula:

T = (sensor_data - 3255)/(-12.401)

I calculated offset and scale values, and this is what I got:

scale = 1 / 12.401 = 806,38658173 ~ 806
offset = 3255 / 12.401 = 262478,832352 ~ 262479

Let me assume that you got offset and scale values from Tina Linux
Here for example
https://github.com/Tina-Linux/linux-5.4/blob/ff6b1361f7041be75d4486559141e13134d164ef/drivers/thermal/sunxi_thermal.c#L373

In Tina Linux the scale is rounded to 81 (that equals to 810 in
mainline driver).
And looks like you used this rounded value to recalculate the offset:
3255 * 81 = 263655

I would be glad to know your thoughts about this.

> + .temp_data_base = SUN50I_H6_THS_TEMP_DATA,
> + .calibrate = sun50i_h616_ths_calibrate,
> + .init = sun50i_h6_thermal_init,
> + .irq_ack = sun50i_h6_irq_ack,
> + .calc_temp = sun8i_ths_calc_temp,
> +};
> +
> static const struct of_device_id of_ths_match[] = {
> { .compatible = "allwinner,sun8i-a83t-ths", .data = &sun8i_a83t_ths },
> { .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
> @@ -667,6 +739,7 @@ static const struct of_device_id of_ths_match[] = {
> { .compatible = "allwinner,sun50i-a100-ths", .data = &sun50i_a100_ths },
> { .compatible = "allwinner,sun50i-h5-ths", .data = &sun50i_h5_ths },
> { .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
> + { .compatible = "allwinner,sun50i-h616-ths", .data = &sun50i_h616_ths },
> { /* sentinel */ },
> };
> MODULE_DEVICE_TABLE(of, of_ths_match);

Best regards,
Maksim

