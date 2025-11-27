Return-Path: <linux-pm+bounces-38767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ACFC8D2D1
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 08:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B168C4E4FBB
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 07:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430C4322DC1;
	Thu, 27 Nov 2025 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSmq4RHR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB43E320CD6
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229577; cv=none; b=kLTdvweJHd9t+/uWKr1lHIQ6lb4MX4OmsARfwn8nQ1FZEv3RHHUYWpEXkkcL3FdbmF20FvTOESZiXxLYl8B+ZiaAQ7qPELO7J4c/Hs+xiWv1EfcezXaM/NiaoFjneiiO0i/ikp4O7svIngLgMiiXy9+OtCMWhPXO0wuHPe1PFRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229577; c=relaxed/simple;
	bh=eixrv2CdiGHk1MmiwyukM55rvIC4y05XI7ZWqeHAQvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cdx7ZwWlCuAIv6EMN3ZxYsjja/ryLl/sFdYOI3z/aHim1U44Hctl7v2bZapF/E7Rm2ZpQyhDT8pX+ddvDzfwuYAw1Z2weHj4TgpN41Z8p1Wg3HoDuVVoVqdakJAV82D887GtQznX7o6imDevbd2ixRlACT2ZbpNMiLjwMqfFvEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSmq4RHR; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-595825c8eb3so558113e87.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 23:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764229572; x=1764834372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hnj14zijJRhbSEOBE/unb9XqHQn52yQ1cvvxZ0DFyqE=;
        b=nSmq4RHRUsjIsmho2ujm1TeyNB0Mfs92BmkhKmaKjrxY5Hxp3Pg34YrahjAlDnNN1/
         dG7ktJFimwoUG8rq7oWKmVvhI396ad68pO1UziJ/QDZ5I+lhAk97mnZUmgPiGd2K/1Uf
         oL02pjbheZoUh5e94mnbVCNR9yIavH0WGqyfk70pxPYI0H+xt0GCB7URFrtVWqRke/0P
         5NlO6t4H97b4q+8GDUZxBg+QMol4YtasALG9EP8IURnDt2rw8/CoEe0NaDCpLQP/vTMb
         SbKWw+ebzNOCObefJMkJIqWC097X0J+M3tXPuyEcfocyAjsp/85bzMRwSMI/GD7YglER
         30Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229572; x=1764834372;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hnj14zijJRhbSEOBE/unb9XqHQn52yQ1cvvxZ0DFyqE=;
        b=SQkKDRRYVBQaNKYuZuNFMzXNByn3X196h+NUayukTaJQgPPdUuPzi2hlbVcJq6OH62
         Yup6pitTnaUraizCvBcDqzC2gkZ7umjyLdhXMdAFBE/GwqC5+Q7ywNWwMjoyPRFV/XJU
         wQvAH9lecWaS460Zh/4mUJXhdtxE5t3Qe567b/4M9GociKkvqa7iLxAoMcs2d6PXbMpT
         lPTRrD6rM7ShkDWmNgo5ojonen7d0DHRHuVLAsCwVvkOTX3v0Dm/tATR9HP1ZSvhJf91
         Z4Ajf/yRhkdzNSXWM1Cmu2p0vD6OpMpk7F6ccWwBKSeTmLrAtME4CEFbcS1/fuQVL8AV
         1pPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaopdn8eUVTn4Ngi4BCBbocPbTqQND2ckADJH+DVtkLFYPKSRpcMSkfazrrqrQbqv2bUPkIP7aPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0W8LKNmyzfUNek6r3zq+a+TxqjMqFshhSrs8unF91CQOAqBcO
	idJuixIWq+p0jw9Ge387QycOqW3gvw6hO/+FJUiSOihTna41GVrmC8WQ
X-Gm-Gg: ASbGncvHmWy2DUgnC7hjrOf8wcwij6UJ8Mgd+uXdCZ3DG4G+ffSlr5OBBTpALMugSJ/
	70bf9dNLx/QtoUVnYlMhzVaVwKmix1K0OYG8Ixc9xo3+02Ye4JEd8dkxd025V8xL5ElfzhNinmH
	K0bu+8tlvO5fnDUKnHfEPNiP8iLM2MRkmxYg690vDW4p0fh/c926YUEl4v5cSKC6mY1O37d6K7H
	MKOHsIbEaE+83lR9AEoTmtZcNH4O/cH/Ahahot/EB11Mo+olQkzeIsF+3o7HW3tfPQbngb4er/L
	23/YBuO23d47aKhICe+Rze9SUl9KrGs7pauGAk7nhE3evRZnShTNKncbW6iSAF55++Yu8P/zjWR
	jsIzh5Egtv0NV+5DtFJq8SV2d70qv3sw5rBjjzH6i0KlzwPfK04OBEr59l0G8O/9u5nd0nzRgaV
	KqRG5Fq6lpyfH/QAEaIMvF/pI+wL6VdunL/lqXzQur0R9P6D1anNoORvXurIwrN+WrDHuI
X-Google-Smtp-Source: AGHT+IE0AX+RugWE0+4LM7mYSSpRxls5r75Ssa4ZNDWg6K4RRVvhPkZhmvV5UTirnjSMOo+4ntezOw==
X-Received: by 2002:a05:6512:b17:b0:595:7854:af7c with SMTP id 2adb3069b0e04-596b5277bfemr3434647e87.24.1764229571533;
        Wed, 26 Nov 2025 23:46:11 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bf8a7cffsm202938e87.18.2025.11.26.23.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 23:46:10 -0800 (PST)
Message-ID: <01285891-a73f-4916-8c5a-ef187c676edd@gmail.com>
Date: Thu, 27 Nov 2025 09:46:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/16] mfd: bd71828: Support ROHM BD72720
To: Lee Jones <lee@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
References: <cover.1763625920.git.mazziesaccount@gmail.com>
 <ffdc1c2f380959c792ad39817ba5e9cf4bbc1131.1763625920.git.mazziesaccount@gmail.com>
 <20251126142809.GD3070764@google.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251126142809.GD3070764@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/11/2025 16:28, Lee Jones wrote:
> On Thu, 20 Nov 2025, Matti Vaittinen wrote:
> 
>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> The ROHM BD72720 is a power management IC which continues the BD71828
>> family of PMICs. Similarly to the BD71815 and BD71828, the BD72720
>> integrates regulators, charger, RTC, clock gate and GPIOs.
>>
>> The main difference to the earlier PMICs is that the BD72720 has two
>> different I2C slave addresses. In addition to the registers behind the
>> 'main I2C address', most of the charger (and to some extent LED) control
>> is done via registers behind a 'secondary I2C slave address', 0x4c.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> Revision history:
>>   v2 =>:
>>   - no changes
>>
>>   RFCv1 => v2: (Mostly addressed comments from Lee and Andreas)
>>   - Use stacked regmaps to avoid platform data and the tango with
>>     multiple regmaps in the power-supply driver
>>   - Use regmap_reg_range()
>>   - make it clear bd72720_irq_type_base is an array
>>   - tab-out definitions in the bd72720 header
>>   - minor styling
>>
>> Note: This patch depends on the series: "power: supply: add charger for
>> BD71828" by Andreas:
>> https://lore.kernel.org/all/20250918-bd71828-charger-v5-0-851164839c28@kemnade.info/
>>
>> There are some new variants being planned. Most notably, the BD73900
>> should be almost identical to the BD72720 - for everything else except
>> the charger block.
>> ---
>>   drivers/mfd/Kconfig              |  18 +-
>>   drivers/mfd/rohm-bd71828.c       | 488 +++++++++++++++++++++++-
>>   include/linux/mfd/rohm-bd72720.h | 634 +++++++++++++++++++++++++++++++
>>   include/linux/mfd/rohm-generic.h |   1 +
>>   4 files changed, 1126 insertions(+), 15 deletions(-)
>>   create mode 100644 include/linux/mfd/rohm-bd72720.h

// snip

>> diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
>> index 2a43005b67ee..2e546aa60ffd 100644
>> --- a/drivers/mfd/rohm-bd71828.c
>> +++ b/drivers/mfd/rohm-bd71828.c
>> @@ -2,7 +2,7 @@
>>   //
>>   // Copyright (C) 2019 ROHM Semiconductors
>>   //
>> -// ROHM BD71828/BD71815 PMIC driver
>> +// ROHM BD718[15/28/79] and BD72720 PMIC driver
> 
> Looks like this header format slipped in.
> 
> I would appreciate a follow-up patch to change it to standard C
> multi-line format (except the SPDX line).

Sure.

// snip

>>   
>> +static int regmap_write_wrapper(void *context, unsigned int reg, unsigned int val)
>> +{
>> +	struct bd72720_regmaps *maps = context;
>> +
>> +	if (reg < 0x100)
> 
> Define this to something human readable please.
> 
> Some kind of PAGE or BOUNDARY.  Perhaps something better.

I will use 'BD72720_SECONDARY_I2C_REG_OFFSET'. A tad long, but it's not 
used on a long lines.

> 
>> +		return regmap_write(maps->map1_4b, reg, val);
>> +
>> +	reg = BD72720_REG_UNWRAP(reg);
>> +
>> +	return regmap_write(maps->map2_4c, reg, val);
>> +}

// snip

> 
>> +		return (struct regmap *)secondary_i2c;
> 
> *shudders* -- that's a hack, right!
> 
> /me does some grepping around ...
> 
> Shouldn't this be:
> 
> 		return ERR_CAST(secondary_i2c);

I didn't know about the ERR_CAST(). Thanks for going the extra mile and 
looking

> 
>> +	}

//snip

>> diff --git a/include/linux/mfd/rohm-bd72720.h b/include/linux/mfd/rohm-bd72720.h
>> new file mode 100644
>> index 000000000000..42fcf8f81b2f
>> --- /dev/null
>> +++ b/include/linux/mfd/rohm-bd72720.h
>> @@ -0,0 +1,634 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Copyright 2024 ROHM Semiconductors.
> 
> Still out of date.

Ah. Indeed. Thanks.

>> + * Author: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
>> + */
>> +
// snip

>> +
>> +/* BD72720 interrupts */
>> +#define BD72720_INT_LONGPUSH_MASK	BIT(0)
>> +#define BD72720_INT_MIDPUSH_MASK	BIT(1)
>> +#define BD72720_INT_SHORTPUSH_MASK	BIT(2)
>> +#define BD72720_INT_PUSH_MASK		BIT(3)
>> +#define BD72720_INT_HALL_DET_MASK	BIT(4)
>> +#define BD72720_INT_HALL_TGL_MASK	BIT(5)
>> +#define BD72720_INT_WDOG_MASK		BIT(6)
>> +#define BD72720_INT_SWRESET_MASK	BIT(7)
>> +#define BD72720_INT_SEQ_DONE_MASK	BIT(0)
>> +#define BD72720_INT_PGFAULT_MASK	BIT(4)
>> +#define BD72720_INT_BUCK1_DVS_MASK	BIT(0)
>> +#define BD72720_INT_BUCK2_DVS_MASK	BIT(1)
>> +#define BD72720_INT_BUCK3_DVS_MASK	BIT(2)
>> +#define BD72720_INT_BUCK4_DVS_MASK	BIT(3)
>> +#define BD72720_INT_BUCK5_DVS_MASK	BIT(4)
>> +#define BD72720_INT_BUCK6_DVS_MASK	BIT(5)
>> +#define BD72720_INT_BUCK7_DVS_MASK	BIT(6)
>> +#define BD72720_INT_BUCK8_DVS_MASK	BIT(7)
>> +#define BD72720_INT_BUCK9_DVS_MASK	BIT(0)
>> +#define BD72720_INT_BUCK10_DVS_MASK	BIT(1)
>> +#define BD72720_INT_LDO1_DVS_MASK	BIT(4)
>> +#define BD72720_INT_LDO2_DVS_MASK	BIT(5)
>> +#define BD72720_INT_LDO3_DVS_MASK	BIT(6)
>> +#define BD72720_INT_LDO4_DVS_MASK	BIT(7)
>> +#define BD72720_INT_VBUS_RMV_MASK	BIT(0)
>> +#define BD72720_INT_VBUS_DET_MASK	BIT(1)
>> +#define BD72720_INT_VBUS_MON_RES_MASK	BIT(2)
>> +#define BD72720_INT_VBUS_MON_DET_MASK	BIT(3)
>> +#define BD72720_INT_VSYS_MON_RES_MASK	BIT(0)
>> +#define BD72720_INT_VSYS_MON_DET_MASK	BIT(1)
>> +#define BD72720_INT_VSYS_UV_RES_MASK	BIT(2)
>> +#define BD72720_INT_VSYS_UV_DET_MASK	BIT(3)
>> +#define BD72720_INT_VSYS_LO_RES_MASK	BIT(4)
>> +#define BD72720_INT_VSYS_LO_DET_MASK	BIT(5)
>> +#define BD72720_INT_VSYS_OV_RES_MASK	BIT(6)
>> +#define BD72720_INT_VSYS_OV_DET_MASK	BIT(7)
>> +#define BD72720_INT_BAT_ILIM_MASK	BIT(0)
>> +#define BD72720_INT_CHG_DONE_MASK	BIT(1)
>> +#define BD72720_INT_EXTEMP_TOUT_MASK	BIT(2)
>> +#define BD72720_INT_CHG_WDT_EXP_MASK	BIT(3)
>> +#define BD72720_INT_BAT_MNT_OUT_MASK	BIT(4)
>> +#define BD72720_INT_BAT_MNT_IN_MASK	BIT(5)
>> +#define BD72720_INT_CHG_TRNS_MASK	BIT(7)
>> +#define BD72720_INT_VBAT_MON_RES_MASK	BIT(0)
>> +#define BD72720_INT_VBAT_MON_DET_MASK	BIT(1)
>> +#define BD72720_INT_VBAT_SHT_RES_MASK	BIT(2)
>> +#define BD72720_INT_VBAT_SHT_DET_MASK	BIT(3)
>> +#define BD72720_INT_VBAT_LO_RES_MASK	BIT(4)
>> +#define BD72720_INT_VBAT_LO_DET_MASK	BIT(5)
>> +#define BD72720_INT_VBAT_OV_RES_MASK	BIT(6)
>> +#define BD72720_INT_VBAT_OV_DET_MASK	BIT(7)
>> +#define BD72720_INT_BAT_RMV_MASK	BIT(0)
>> +#define BD72720_INT_BAT_DET_MASK	BIT(1)
>> +#define BD72720_INT_DBAT_DET_MASK	BIT(2)
>> +#define BD72720_INT_BAT_TEMP_TRNS_MASK	BIT(3)
>> +#define BD72720_INT_LOBTMP_RES_MASK	BIT(4)
>> +#define BD72720_INT_LOBTMP_DET_MASK	BIT(5)
>> +#define BD72720_INT_OVBTMP_RES_MASK	BIT(6)
>> +#define BD72720_INT_OVBTMP_DET_MASK	BIT(7)
>> +#define BD72720_INT_OCUR1_RES_MASK	BIT(0)
>> +#define BD72720_INT_OCUR1_DET_MASK	BIT(1)
>> +#define BD72720_INT_OCUR2_RES_MASK	BIT(2)
>> +#define BD72720_INT_OCUR2_DET_MASK	BIT(3)
>> +#define BD72720_INT_OCUR3_RES_MASK	BIT(4)
>> +#define BD72720_INT_OCUR3_DET_MASK	BIT(5)
>> +#define BD72720_INT_CC_MON1_DET_MASK	BIT(0)
>> +#define BD72720_INT_CC_MON2_DET_MASK	BIT(1)
>> +#define BD72720_INT_CC_MON3_DET_MASK	BIT(2)
>> +#define BD72720_INT_GPIO1_IN_MASK	BIT(4)
>> +#define BD72720_INT_GPIO2_IN_MASK	BIT(5)
>> +#define BD72720_INT_VF125_RES_MASK	BIT(0)
>> +#define BD72720_INT_VF125_DET_MASK	BIT(1)
>> +#define BD72720_INT_VF_RES_MASK		BIT(2)
>> +#define BD72720_INT_VF_DET_MASK		BIT(3)
>> +#define BD72720_INT_RTC0_MASK		BIT(4)
>> +#define BD72720_INT_RTC1_MASK		BIT(5)
>> +#define BD72720_INT_RTC2_MASK		BIT(6)
> 
> I'd be able to sleep better if these all lined up.

Hm. I think they are when this is applied?

Thanks for the review! I agree with all the comments I didn't comment 
on. I'll prepare v6 fixing these :)

Yours,
	-- Matti

---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

