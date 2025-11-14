Return-Path: <linux-pm+bounces-38014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21281C5BD7B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 08:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 95ABB34FDD7
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 07:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1106A2F6904;
	Fri, 14 Nov 2025 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DxG0tymF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965482E719E;
	Fri, 14 Nov 2025 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763106614; cv=none; b=K3MfxCTN1Agmnwx0Pp49RvMirh/oWqaQjsWEZkvvT3dt/aeNEIeukmglkP3hrHQYdEYUvfLvMJ2LT9hK+1DvV2kpMexpA/IdQ0un+csgxicFm5rrt+MZKSpyFo/9v+2JdoYmJBW+2DJeqiEt5x4wTs2QTI+1w0cReLrC11A5zp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763106614; c=relaxed/simple;
	bh=My1DkSx6E8NH1/g/2YUqKSOXU94pnaYksctIemj4gWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Djkne36c1ihTibW4laqhMthCMUIRYC2kHB1olQnLTMKo6Pxqjxn4mUlhIxUm0Nt29eEegLxBpmMLiY0sf4GzmZFG1zBzvg6/ymcONjkFpBtMmbbxyEZJlo7uvNnS8/+0RRL2BJhJpYZNGgU+nCOrjUGEyTFHOaFaET8+nr0AlxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DxG0tymF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E84CF4E416AB;
	Fri, 14 Nov 2025 07:50:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BB2756060E;
	Fri, 14 Nov 2025 07:50:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22A71102F2A6F;
	Fri, 14 Nov 2025 08:50:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763106608; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=vou/PSvtoM9CuF1Iut3e8wcLV2zmRLJ9tzJ9Bc7FteA=;
	b=DxG0tymFHZP8aF0T9HNNjCVnOtqgWqBQZopOzLsGe+MG7KLBS4zvwmPb2xNNRrCkT+nrkD
	yil4rKK2fwvvvOC+Z+9QK6Aur4ok9ME9aaGiBROB50aI0G+zjNJSjP4LlVl5oin9PHUKm5
	nI+hL41DkAq14lsblJe0evNclURr5zQGvZkZFw0DqGD0wUqCUY9cwlXE2RFuyDHRnhGXiM
	ytuL5oJuyJNECkpMaInkO3/uNepVPmMrLBD/WjX39hgnceVCtw0kgw4YCDqNW2GKZQspJM
	q9OZ0HAscsCb1vyXLDXOCal4YNeRgm2QLHCE054nvuBiGsye+4PCvXe4w/EiPg==
Date: Fri, 14 Nov 2025 08:50:04 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 06/13] mfd: sec-irq: add support for creating multiple
 IRQ chips
Message-ID: <20251114075004a444bff0@mail.local>
References: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
 <20251114-s2mu005-pmic-v1-6-9e3184d3a0c9@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114-s2mu005-pmic-v1-6-9e3184d3a0c9@disroot.org>
X-Last-TLS-Session-Version: TLSv1.3

On 14/11/2025 00:35:07+0530, Kaustabh Chakraborty wrote:
> The current state of the driver only allows creating only one IRQ chip
> per PMIC. On some PMICs, such as Samsung's S2MU005, there are multiple
> interrupt blocks, for which the current implementation stands insufficient.
> 
> Add support for creating multiple IRQ chips for a PMIC. Every IRQ chip is
> given it's own index, which is used by sub-device drivers to request IRQs.
> 
> A macro is defined which states the maximum number of chips supported.
> It's set to 1 as currently, no PMIC requires more than one IRQ chip. The
> value must be changed accordingly on adding new PMICs requiring multiple
> IRQ chips.
> 
> Moreover, adjust the s5m RTC driver to initialize IRQs with the
> appropriate IRQ chip index.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/mfd/sec-irq.c            | 163 +++++++++++++++++++++++----------------
>  drivers/rtc/rtc-s5m.c            |  15 +++-
>  include/linux/mfd/samsung/core.h |   5 +-
>  include/linux/mfd/samsung/irq.h  |  14 ++++
>  4 files changed, 127 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/mfd/sec-irq.c b/drivers/mfd/sec-irq.c
> index c5c80b1ba104..053c28f31ec9 100644
> --- a/drivers/mfd/sec-irq.c
> +++ b/drivers/mfd/sec-irq.c
> @@ -181,25 +181,31 @@ static const struct regmap_irq s5m8767_irqs[] = {
>  };
>  
>  /* All S2MPG10 interrupt sources are read-only and don't require clearing */
> -static const struct regmap_irq_chip s2mpg10_irq_chip = {
> -	.name = "s2mpg10",
> -	.irqs = s2mpg10_irqs,
> -	.num_irqs = ARRAY_SIZE(s2mpg10_irqs),
> -	.num_regs = 6,
> -	.status_base = S2MPG10_PMIC_INT1,
> -	.mask_base = S2MPG10_PMIC_INT1M,
> +static const struct regmap_irq_chip s2mpg10_irq_chip[] = {
> +	[S2MPG10_IRQ_CHIP] = {
> +		.name = "s2mpg10",
> +		.irqs = s2mpg10_irqs,
> +		.num_irqs = ARRAY_SIZE(s2mpg10_irqs),
> +		.num_regs = 6,
> +		.status_base = S2MPG10_PMIC_INT1,
> +		.mask_base = S2MPG10_PMIC_INT1M,
> +	},
>  };
>  
> -static const struct regmap_irq_chip s2mps11_irq_chip = {
> -	.name = "s2mps11",
> -	.irqs = s2mps11_irqs,
> -	.num_irqs = ARRAY_SIZE(s2mps11_irqs),
> -	.num_regs = 3,
> -	.status_base = S2MPS11_REG_INT1,
> -	.mask_base = S2MPS11_REG_INT1M,
> -	.ack_base = S2MPS11_REG_INT1,
> +static const struct regmap_irq_chip s2mps11_irq_chip[] = {
> +	[S2MPS11_IRQ_CHIP] = {
> +		.name = "s2mps11",
> +		.irqs = s2mps11_irqs,
> +		.num_irqs = ARRAY_SIZE(s2mps11_irqs),
> +		.num_regs = 3,
> +		.status_base = S2MPS11_REG_INT1,
> +		.mask_base = S2MPS11_REG_INT1M,
> +		.ack_base = S2MPS11_REG_INT1,
> +	},
>  };
>  
> +#define S2MPS1X_IRQ_CHIP		S2MPS14_IRQ_CHIP
> +
>  #define S2MPS1X_IRQ_CHIP_COMMON_DATA		\
>  	.irqs = s2mps14_irqs,			\
>  	.num_irqs = ARRAY_SIZE(s2mps14_irqs),	\
> @@ -208,85 +214,106 @@ static const struct regmap_irq_chip s2mps11_irq_chip = {
>  	.mask_base = S2MPS14_REG_INT1M,		\
>  	.ack_base = S2MPS14_REG_INT1		\
>  
> -static const struct regmap_irq_chip s2mps13_irq_chip = {
> -	.name = "s2mps13",
> -	S2MPS1X_IRQ_CHIP_COMMON_DATA,
> +static const struct regmap_irq_chip s2mps13_irq_chip[] = {
> +	[S2MPS1X_IRQ_CHIP] = {
> +		.name = "s2mps13",
> +		S2MPS1X_IRQ_CHIP_COMMON_DATA,
> +	},
>  };
>  
> -static const struct regmap_irq_chip s2mps14_irq_chip = {
> -	.name = "s2mps14",
> -	S2MPS1X_IRQ_CHIP_COMMON_DATA,
> +static const struct regmap_irq_chip s2mps14_irq_chip[] = {
> +	[S2MPS1X_IRQ_CHIP] = {
> +		.name = "s2mps14",
> +		S2MPS1X_IRQ_CHIP_COMMON_DATA,
> +	},
>  };
>  
> -static const struct regmap_irq_chip s2mps15_irq_chip = {
> -	.name = "s2mps15",
> -	S2MPS1X_IRQ_CHIP_COMMON_DATA,
> +static const struct regmap_irq_chip s2mps15_irq_chip[] = {
> +	[S2MPS1X_IRQ_CHIP] = {
> +		.name = "s2mps15",
> +		S2MPS1X_IRQ_CHIP_COMMON_DATA,
> +	},
>  };
>  
> -static const struct regmap_irq_chip s2mpu02_irq_chip = {
> -	.name = "s2mpu02",
> -	.irqs = s2mpu02_irqs,
> -	.num_irqs = ARRAY_SIZE(s2mpu02_irqs),
> -	.num_regs = 3,
> -	.status_base = S2MPU02_REG_INT1,
> -	.mask_base = S2MPU02_REG_INT1M,
> -	.ack_base = S2MPU02_REG_INT1,
> +static const struct regmap_irq_chip s2mpu02_irq_chip[] = {
> +	[S2MPU02_IRQ_CHIP] = {
> +		.name = "s2mpu02",
> +		.irqs = s2mpu02_irqs,
> +		.num_irqs = ARRAY_SIZE(s2mpu02_irqs),
> +		.num_regs = 3,
> +		.status_base = S2MPU02_REG_INT1,
> +		.mask_base = S2MPU02_REG_INT1M,
> +		.ack_base = S2MPU02_REG_INT1,
> +	},
>  };
>  
> -static const struct regmap_irq_chip s2mpu05_irq_chip = {
> -	.name = "s2mpu05",
> -	.irqs = s2mpu05_irqs,
> -	.num_irqs = ARRAY_SIZE(s2mpu05_irqs),
> -	.num_regs = 3,
> -	.status_base = S2MPU05_REG_INT1,
> -	.mask_base = S2MPU05_REG_INT1M,
> -	.ack_base = S2MPU05_REG_INT1,
> +static const struct regmap_irq_chip s2mpu05_irq_chip[] = {
> +	[S2MPU05_IRQ_CHIP] = {
> +		.name = "s2mpu05",
> +		.irqs = s2mpu05_irqs,
> +		.num_irqs = ARRAY_SIZE(s2mpu05_irqs),
> +		.num_regs = 3,
> +		.status_base = S2MPU05_REG_INT1,
> +		.mask_base = S2MPU05_REG_INT1M,
> +		.ack_base = S2MPU05_REG_INT1,
> +	},
>  };
>  
> -static const struct regmap_irq_chip s5m8767_irq_chip = {
> -	.name = "s5m8767",
> -	.irqs = s5m8767_irqs,
> -	.num_irqs = ARRAY_SIZE(s5m8767_irqs),
> -	.num_regs = 3,
> -	.status_base = S5M8767_REG_INT1,
> -	.mask_base = S5M8767_REG_INT1M,
> -	.ack_base = S5M8767_REG_INT1,
> +static const struct regmap_irq_chip s5m8767_irq_chip[] = {
> +	[S5M8767_IRQ_CHIP] = {
> +		.name = "s5m8767",
> +		.irqs = s5m8767_irqs,
> +		.num_irqs = ARRAY_SIZE(s5m8767_irqs),
> +		.num_regs = 3,
> +		.status_base = S5M8767_REG_INT1,
> +		.mask_base = S5M8767_REG_INT1M,
> +		.ack_base = S5M8767_REG_INT1,
> +	},
>  };
>  
>  int sec_irq_init(struct sec_pmic_dev *sec_pmic)
>  {
>  	const struct regmap_irq_chip *sec_irq_chip;
> -	int ret;
> +	int sec_irq_chip_num, i, ret;
>  
>  	switch (sec_pmic->device_type) {
>  	case S5M8767X:
> -		sec_irq_chip = &s5m8767_irq_chip;
> +		sec_irq_chip = s5m8767_irq_chip;
> +		sec_irq_chip_num = ARRAY_SIZE(s5m8767_irq_chip);
>  		break;
>  	case S2DOS05:
>  		return 0;
>  	case S2MPA01:
> -		sec_irq_chip = &s2mps14_irq_chip;
> +		sec_irq_chip = s2mps14_irq_chip;
> +		sec_irq_chip_num = ARRAY_SIZE(s2mps14_irq_chip);
>  		break;
>  	case S2MPG10:
> -		sec_irq_chip = &s2mpg10_irq_chip;
> +		sec_irq_chip = s2mpg10_irq_chip;
> +		sec_irq_chip_num = ARRAY_SIZE(s2mpg10_irq_chip);
>  		break;
>  	case S2MPS11X:
> -		sec_irq_chip = &s2mps11_irq_chip;
> +		sec_irq_chip = s2mps11_irq_chip;
> +		sec_irq_chip_num = ARRAY_SIZE(s2mps11_irq_chip);
>  		break;
>  	case S2MPS13X:
> -		sec_irq_chip = &s2mps13_irq_chip;
> +		sec_irq_chip = s2mps13_irq_chip;
> +		sec_irq_chip_num = ARRAY_SIZE(s2mps13_irq_chip);
>  		break;
>  	case S2MPS14X:
> -		sec_irq_chip = &s2mps14_irq_chip;
> +		sec_irq_chip = s2mps14_irq_chip;
> +		sec_irq_chip_num = ARRAY_SIZE(s2mps14_irq_chip);
>  		break;
>  	case S2MPS15X:
> -		sec_irq_chip = &s2mps15_irq_chip;
> +		sec_irq_chip = s2mps15_irq_chip;
> +		sec_irq_chip_num = ARRAY_SIZE(s2mps15_irq_chip);
>  		break;
>  	case S2MPU02:
> -		sec_irq_chip = &s2mpu02_irq_chip;
> +		sec_irq_chip = s2mpu02_irq_chip;
> +		sec_irq_chip_num = ARRAY_SIZE(s2mpu02_irq_chip);
>  		break;
>  	case S2MPU05:
> -		sec_irq_chip = &s2mpu05_irq_chip;
> +		sec_irq_chip = s2mpu05_irq_chip;
> +		sec_irq_chip_num = ARRAY_SIZE(s2mpu05_irq_chip);
>  		break;
>  	default:
>  		return dev_err_probe(sec_pmic->dev, -EINVAL,
> @@ -300,13 +327,19 @@ int sec_irq_init(struct sec_pmic_dev *sec_pmic)
>  		return 0;
>  	}
>  
> -	ret = devm_regmap_add_irq_chip(sec_pmic->dev, sec_pmic->regmap_pmic,
> -				       sec_pmic->irq, IRQF_ONESHOT,
> -				       0, sec_irq_chip, &sec_pmic->irq_data);
> -	if (ret)
> -		return dev_err_probe(sec_pmic->dev, ret,
> -				     "Failed to add %s IRQ chip\n",
> -				     sec_irq_chip->name);
> +	for (i = 0; i < sec_irq_chip_num; i++) {
> +		ret = devm_regmap_add_irq_chip(sec_pmic->dev,
> +					       sec_pmic->regmap_pmic,
> +					       sec_pmic->irq,
> +					       IRQF_ONESHOT | IRQF_SHARED, 0,
> +					       sec_irq_chip + i,
> +					       sec_pmic->irq_data + i);
> +		if (ret) {
> +			return dev_err_probe(sec_pmic->dev, ret,
> +					     "Failed to add %s IRQ chip\n",
> +					     sec_irq_chip->name);
> +		}
> +	}
>  
>  	/*
>  	 * The rtc-s5m driver requests S2MPS14_IRQ_RTCA0 also for S2MPS11
> diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
> index a7220b4d0e8d..726915deff7a 100644
> --- a/drivers/rtc/rtc-s5m.c
> +++ b/drivers/rtc/rtc-s5m.c
> @@ -668,7 +668,7 @@ static int s5m_rtc_probe(struct platform_device *pdev)
>  	enum sec_device_type device_type =
>  		platform_get_device_id(pdev)->driver_data;
>  	struct s5m_rtc_info *info;
> -	int ret, alarm_irq;
> +	int ret, alarm_irq, irq_chip;
>  
>  	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
>  	if (!info)
> @@ -684,21 +684,25 @@ static int s5m_rtc_probe(struct platform_device *pdev)
>  			regmap_cfg = &s2mps14_rtc_regmap_config;
>  			info->regs = &s2mps15_rtc_regs;
>  			alarm_irq = S2MPS14_IRQ_RTCA0;
> +			irq_chip = S2MPS11_IRQ_CHIP;
>  			break;
>  		case S2MPS14X:
>  			regmap_cfg = &s2mps14_rtc_regmap_config;
>  			info->regs = &s2mps14_rtc_regs;
>  			alarm_irq = S2MPS14_IRQ_RTCA0;
> +			irq_chip = S2MPS14_IRQ_CHIP;
>  			break;
>  		case S2MPS13X:
>  			regmap_cfg = &s2mps14_rtc_regmap_config;
>  			info->regs = &s2mps13_rtc_regs;
>  			alarm_irq = S2MPS14_IRQ_RTCA0;
> +			irq_chip = S2MPS14_IRQ_CHIP;
>  			break;
>  		case S5M8767X:
>  			regmap_cfg = &s5m_rtc_regmap_config;
>  			info->regs = &s5m_rtc_regs;
>  			alarm_irq = S5M8767_IRQ_RTCA1;
> +			irq_chip = S5M8767_IRQ_CHIP;
>  			break;
>  		default:
>  			return dev_err_probe(&pdev->dev, -ENODEV,
> @@ -720,6 +724,7 @@ static int s5m_rtc_probe(struct platform_device *pdev)
>  	} else if (device_type == S2MPG10) {
>  		info->regs = &s2mpg10_rtc_regs;
>  		alarm_irq = S2MPG10_IRQ_RTCA0;
> +		irq_chip = S2MPG10_IRQ_CHIP;
>  	} else {
>  		return dev_err_probe(&pdev->dev, -ENODEV,
>  				     "Unsupported device type %d\n",
> @@ -730,12 +735,14 @@ static int s5m_rtc_probe(struct platform_device *pdev)
>  	info->s5m87xx = s5m87xx;
>  	info->device_type = device_type;
>  
> -	if (s5m87xx->irq_data) {
> -		info->irq = regmap_irq_get_virq(s5m87xx->irq_data, alarm_irq);
> -		if (info->irq <= 0)
> +	if (s5m87xx->irq_data[irq_chip]) {
> +		info->irq = regmap_irq_get_virq(s5m87xx->irq_data[irq_chip],
> +						alarm_irq);
> +		if (info->irq <= 0) {
>  			return dev_err_probe(&pdev->dev, -EINVAL,
>  					     "Failed to get virtual IRQ %d\n",
>  					     alarm_irq);
> +		}
>  	}
>  
>  	platform_set_drvdata(pdev, info);
> diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
> index d785e101fe79..dcd741c4f0d6 100644
> --- a/include/linux/mfd/samsung/core.h
> +++ b/include/linux/mfd/samsung/core.h
> @@ -33,6 +33,9 @@
>  #define STEP_12_5_MV		12500
>  #define STEP_6_25_MV		6250
>  
> +/* Maximum number of IRQ chips in a PMIC */
> +#define MAX_IRQ_CHIPS		1
> +
>  struct gpio_desc;
>  
>  enum sec_device_type {
> @@ -69,7 +72,7 @@ struct sec_pmic_dev {
>  
>  	int device_type;
>  	int irq;
> -	struct regmap_irq_chip_data *irq_data;
> +	struct regmap_irq_chip_data *irq_data[MAX_IRQ_CHIPS];
>  };
>  
>  struct sec_platform_data {
> diff --git a/include/linux/mfd/samsung/irq.h b/include/linux/mfd/samsung/irq.h
> index b4805cbd949b..78eb894e350e 100644
> --- a/include/linux/mfd/samsung/irq.h
> +++ b/include/linux/mfd/samsung/irq.h
> @@ -34,6 +34,8 @@ enum s2mpa01_irq {
>  	S2MPA01_IRQ_NR,
>  };
>  
> +#define S2MPA01_IRQ_CHIP		0
> +
>  #define S2MPA01_IRQ_PWRONF_MASK		(1 << 0)
>  #define S2MPA01_IRQ_PWRONR_MASK		(1 << 1)
>  #define S2MPA01_IRQ_JIGONBF_MASK	(1 << 2)
> @@ -58,6 +60,8 @@ enum s2mpa01_irq {
>  #define S2MPA01_IRQ_B35_TSD_MASK	(1 << 5)
>  
>  enum s2mpg10_irq {
> +#define S2MPG10_IRQ_CHIP		0
> +
>  	/* PMIC */
>  	S2MPG10_IRQ_PWRONF,
>  	S2MPG10_IRQ_PWRONR,
> @@ -183,6 +187,8 @@ enum s2mps11_irq {
>  	S2MPS11_IRQ_NR,
>  };
>  
> +#define S2MPS11_IRQ_CHIP		0
> +
>  #define S2MPS11_IRQ_PWRONF_MASK		(1 << 0)
>  #define S2MPS11_IRQ_PWRONR_MASK		(1 << 1)
>  #define S2MPS11_IRQ_JIGONBF_MASK	(1 << 2)
> @@ -226,6 +232,8 @@ enum s2mps14_irq {
>  	S2MPS14_IRQ_NR,
>  };
>  
> +#define S2MPS14_IRQ_CHIP		0
> +
>  enum s2mpu02_irq {
>  	S2MPU02_IRQ_PWRONF,
>  	S2MPU02_IRQ_PWRONR,
> @@ -250,6 +258,8 @@ enum s2mpu02_irq {
>  	S2MPU02_IRQ_NR,
>  };
>  
> +#define S2MPU02_IRQ_CHIP		0
> +
>  /* Masks for interrupts are the same as in s2mps11 */
>  #define S2MPS14_IRQ_TSD_MASK		(1 << 2)
>  
> @@ -277,6 +287,8 @@ enum s2mpu05_irq {
>  	S2MPU05_IRQ_NR,
>  };
>  
> +#define S2MPU05_IRQ_CHIP		0
> +
>  #define S2MPU05_IRQ_PWRONF_MASK		BIT(0)
>  #define S2MPU05_IRQ_PWRONR_MASK		BIT(1)
>  #define S2MPU05_IRQ_JIGONBF_MASK	BIT(2)
> @@ -321,6 +333,8 @@ enum s5m8767_irq {
>  	S5M8767_IRQ_NR,
>  };
>  
> +#define S5M8767_IRQ_CHIP		0
> +
>  #define S5M8767_IRQ_PWRR_MASK		(1 << 0)
>  #define S5M8767_IRQ_PWRF_MASK		(1 << 1)
>  #define S5M8767_IRQ_PWR1S_MASK		(1 << 3)
> 
> -- 
> 2.51.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

