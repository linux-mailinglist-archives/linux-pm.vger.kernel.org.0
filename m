Return-Path: <linux-pm+bounces-40634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5D2D10BC7
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 07:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C47F3022835
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 06:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1BB3164DC;
	Mon, 12 Jan 2026 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekpFp9zO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672043161BA
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200293; cv=none; b=cL3M/w9d7yHfDshE9cT8Ng/66qGCL0VMGU8svPjUz3glE5+GrOd3nPWQubQpNI9mxayzHdEYE/p5hDJWIq/3W+tOXXxjoD0YbW32YqAxoR5MYO5EvGxrMDGxynfdoGv7NGwS9khwv9uP61eiijvE/KsEBCviid569dXfqGD6U/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200293; c=relaxed/simple;
	bh=zfdNkIcBOiVr8OwilGFhJRlfsq+4+153/P8cpC2UC2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FON6/6XUJv6GH07U9X3AVhcV6VJOcu11c2rekg7l3+IypqFaOLMZFrkyJtsc90QPSD8zpabeNmZOSWxWIRzyh4D92krjPq26yg+Lj1mjfoifxBFTCCWJ+j5hfjd2uK9t6LNvY+KgRRzznqgzwA0ZsKLqPrLtSlRPpmoBimTOQ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekpFp9zO; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-382fb535b73so46492411fa.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Jan 2026 22:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768200289; x=1768805089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+aTDpJKFzih88kCdAP65ssAJslh2uJxvPnVKQWLfIA=;
        b=ekpFp9zOcdu8v6aU0U9qa9Mm/f7r+Bn1amGsgFLCvHW2yI8bnxUNLuDZZrRf4VzDDM
         fZ91lEH6HhSZoiAd0lBCaYCxWXh/9P18F1MlXF8j2XFPJ3XAIYaw28u7e+QnlwP1u2QP
         AYxh9LkIO01LpWs7RI7NOJoKvuIwwq/gsDiR/vaBEjLNy2ch54vt0L+elO7BdjXdXrJ4
         lj+gxLks5cHckI67bsjR78eU9SlVI4alZC+GROEv3wlcaZ2hbguQVXv78DZJ1CwOwvWY
         51Zg7rPX1yVNIvjSP0AM51CJYvz8pPxo0K629v1XWg1OmVBvLrNlNYb+ozI+jBKO7vI0
         2EDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768200289; x=1768805089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+aTDpJKFzih88kCdAP65ssAJslh2uJxvPnVKQWLfIA=;
        b=DQU3JTm6EpdjEBqWyXTEmcNsXD+dRQfSU0ihGmNB0ce48G/a7lHtmwstEma7vj8rVq
         M10F+fdccyu1BEn5M30nGrNoChfpZykGDxEcO0RbVHVZuoaPLNUPP1eKniqtQZy3KmU/
         LkIFSyNKwjTqxgt1WMeoOD5hHub91K6PsN0BQuPLe+neUuoVpsrW5y79hcMksoZyRbM9
         IpScBErSQ6CElj0MGKmpK4dc9y+mN0hqpq3E0MAvonwcTfuD2L7Tlw0arQBBhxfhtGmF
         zdlNqsyOX0mkA+3ZfkVRHKbdiZT4M0F73frazyWPfKKg/dbVu21VzpwfNKtRl99p+Y0n
         eGpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyoOgdY/OISGN/o76H4RypgaJEn6e/LetewxqEsc//BWZxo2Oqup11+kjrccOWOqupBuvb0jDtmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxB5NSC8r+yZNaj8FbfO9ZqU1BUBY/5uMQ6yS3m2VUNUhf7PqWD
	+vSLLRgSAquKN4Yq4xEU4Qn8d+q8IwTaRn+z8DPIYnyDLLidVeCiwBel
X-Gm-Gg: AY/fxX6qGB1vnOOAGWSQycQz34V5nuFt/cqMi8zp1b3jKp8I1XmKxbboYQ2dcFUE4YG
	dtXucXIwGMF+8YAoBRAV1RS7hVm1I6EMWpuvAEYofhl6/B9ZaChxjp4aG3FdLgFJBYdT+3qXT5J
	XsfQUfYK7mOkuDyEUJlwIyKpJNQG90ZO+GRCAfM3lIN7u6V4rDl0VFLNpBAfCLSLUM2+KMq0y+k
	FrJVBYD0ttR2LWEX7wFcK+4cXC6UNJ6jf7jDXkPReE7uy+FOOfUA58AZwViXVicuMSBtYWmHqiC
	f8faFN8d1hmt2Q8itn8Fzep0v+u6NwhXw7WhFLX/N8U+sZ6ElewfUJcuErlDP6z7rtrM7orvQtH
	r/VgdZQAv7kLNAgJAlQ4IvNfwqv+uzbSZmJcscUfoAvUA8VWWcHplpwNZ3RtnBxCq/uLVVwOw4j
	BvkJZHLwMv7PSgd5HudPREI80181Gj/iMgrv7rzRzwzuqTMYL7Gh0FEHzqFL0t4Wkq5ZS/
X-Google-Smtp-Source: AGHT+IHpuxr8uDmHUpBx93Hk8o3UZa27eBQvlaVc9Y5wYrI/nFTMdUIo/B+CoBNRsZZ57UO1DmaH1w==
X-Received: by 2002:a05:651c:30c9:b0:37b:967e:d73 with SMTP id 38308e7fff4ca-382ff8115efmr56528091fa.29.1768200288212;
        Sun, 11 Jan 2026 22:44:48 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb8e0e29sm37899581fa.35.2026.01.11.22.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:44:47 -0800 (PST)
Message-ID: <33787eea-f0e0-4041-b9e6-102209af5138@gmail.com>
Date: Mon, 12 Jan 2026 08:44:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v6 16/17] power: supply: bd71828-power: Support
 ROHM BD72720
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
References: <cover.1765804226.git.mazziesaccount@gmail.com>
 <fb74c0cab3dfe534135d26dbbb9c66699678c2de.1765804226.git.mazziesaccount@gmail.com>
 <aWRERf70jg-IzqIx@venus>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <aWRERf70jg-IzqIx@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/01/2026 02:51, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Dec 15, 2025 at 03:21:19PM +0200, Matti Vaittinen wrote:
>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> The ROHM BD72720 is a power management IC with a charger and coulomb
>> counter block which is closely related to the charger / coulomb counter
>> found from the BD71815, BD71828, BD71879 which are all supported by the
>> bd71828-power driver. Due to the similarities it makes sense to support
>> also the BD72720 with the same driver.
>>
>> Add basic support for the charger logic on ROHM BD72720.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> Revision history:
>>   v2 => :
>>   - No changes
>>
>>   RFCv1 => v2:
>>   - Support using 9-bit register addresses (offset of 0x100) with the
>>     BD72720
>>   - Simplify probe and IC data as we don't need two regmaps
>>   - Drop two BD72720 specific functions as we no longer need different
>>     regmap for it.
>>
>> Note: This patch depends on the series: "power: supply: add charger for
>> BD71828" by Andreas:
>> https://lore.kernel.org/all/20250918-bd71828-charger-v5-0-851164839c28@kemnade.info/
> 
> That should be in v6.19?

Ah, right. As Andreas also stated, yes. This is no longer relevant. I 
simply forgot to clean-up the note from this patch.

>> @@ -958,21 +1043,27 @@ static int bd71828_power_probe(struct platform_device *pdev)
>>   	struct power_supply_config ac_cfg = {};
>>   	struct power_supply_config bat_cfg = {};
>>   	int ret;
>> -	struct regmap *regmap;
>> -
>> -	regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> -	if (!regmap) {
>> -		dev_err(&pdev->dev, "No parent regmap\n");
>> -		return -EINVAL;
>> -	}
>>   
>>   	pwr = devm_kzalloc(&pdev->dev, sizeof(*pwr), GFP_KERNEL);
>>   	if (!pwr)
>>   		return -ENOMEM;
>>   
>> -	pwr->regmap = regmap;
>> -	pwr->dev = &pdev->dev;
>> +	/*
>> +	 * The BD72720 MFD device registers two regmaps. Power-supply driver
>> +	 * uses the "wrap-map", which provides access to both of the I2C slave
>> +	 * addresses used by the BD72720
>> +	 */
>>   	pwr->chip_type = platform_get_device_id(pdev)->driver_data;
>> +	if (pwr->chip_type != ROHM_CHIP_TYPE_BD72720)
>> +		pwr->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> +	else
>> +		pwr->regmap = dev_get_regmap(pdev->dev.parent, "wrap-map");
>> +	if (!pwr->regmap) {
>> +		dev_err(&pdev->dev, "No parent regmap\n");
>> +		return -EINVAL;
>> +	}
> 
> return dev_err_probe(&pdev->dev, -EINVAL, "No parent regmap\n");
> 
> Otherwise LGTM.

Thanks Sebastian! I appreciate the review!

This driver uses dev_err_probe() only in cases where the error to be 
returned is not hard-coded. The design dates back to when I was first 
introduced to the dev_err_probe() - and using pattern like:

ret = -EINVAL;
if (ret == -EPROBE_DEFER)
  ...

(which results from calling the dev_err_probe with hard-coded error) 
felt very repulsive to me.

I have since quit resisting the 'use dev_err_probe() for all probe error 
paths' -policy (since Resistance is futile - and because there are other 
benefits besides the deferred probe handling) - but I suppose we should 
clean-up also the other similar cases in this driver (I see at least one 
other occurrence in the chip_type-check below). Is it Ok to merge this 
as is, and do a follow-up patch to clean-up all the occurrences? If yes, 
then this might go "as-is" via MFD, together with the other stuff, right?

I can also re-spin this with the print fixed and:
  - add new patch to fix the other occurrence.
  - meld the fix for existing print in this patch.

Just please let me know your preference.



>>   	switch (pwr->chip_type) {
>>   	case ROHM_CHIP_TYPE_BD71828:
>> @@ -985,6 +1076,12 @@ static int bd71828_power_probe(struct platform_device *pdev)
>>   		pwr->get_temp = bd71815_get_temp;
>>   		pwr->regs = &pwr_regs_bd71815;
>>   		break;
>> +	case ROHM_CHIP_TYPE_BD72720:
>> +		pwr->bat_inserted = bd71828_bat_inserted;
>> +		pwr->regs = &pwr_regs_bd72720;
>> +		pwr->get_temp = bd71828_get_temp;
>> +		dev_dbg(pwr->dev, "Found ROHM BD72720\n");
>> +		break;
>>   	default:
>>   		dev_err(pwr->dev, "Unknown PMIC\n");
>>   		return -EINVAL;

The other occurrence --^

>> @@ -1030,6 +1127,7 @@ static int bd71828_power_probe(struct platform_device *pdev)
>>   static const struct platform_device_id bd71828_charger_id[] = {
>>   	{ "bd71815-power", ROHM_CHIP_TYPE_BD71815 },
>>   	{ "bd71828-power", ROHM_CHIP_TYPE_BD71828 },
>> +	{ "bd72720-power", ROHM_CHIP_TYPE_BD72720 },
>>   	{ },
>>   };
>>   MODULE_DEVICE_TABLE(platform, bd71828_charger_id);
>> -- 
>> 2.52.0

Yours,
	-- Matti


-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

