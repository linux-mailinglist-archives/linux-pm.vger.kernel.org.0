Return-Path: <linux-pm+bounces-8469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 681A68D618E
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 14:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8E41C203B3
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 12:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212FA158219;
	Fri, 31 May 2024 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWRuyjUc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19A153E2B;
	Fri, 31 May 2024 12:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717157909; cv=none; b=dHjaAlju82O+ROuKxqCB67MMFJsjHLNXKqv5mnEby6e6B8WpV+MavkIWyFQ5md5ai8HUfZLUtuWzaLcRpqRu+4Z4xsMVGJnZFrmrQPPlxxq/Q1VNnGbrD2ktm/z/o1akAlUOwd4qkjV0KIHGnh8igFkZ5J8R03QhFFotyHC1qEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717157909; c=relaxed/simple;
	bh=ifVab3Wxr0lAYt4gS0iw75OZMmNpu+97JiSkGCX9p04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YH+XjmHnDht+u6GHEgUk6qHdB2eRJGDePzpgYdx6AyjBbsthZe3NXn1YcbFO1kMVIcuIlZpaYZkf01pEmGkwe8LyaySDOhrViNPVc8TXrS8nG8cx3egzqg7B9AQ8BiQ1SHcssIk4JYv4mjMajtkER9nrrCwvaM2gamY/wBVNHws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWRuyjUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871C7C32781;
	Fri, 31 May 2024 12:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717157908;
	bh=ifVab3Wxr0lAYt4gS0iw75OZMmNpu+97JiSkGCX9p04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HWRuyjUcJGHVYgIitwOPsbNCX7MZRry6xkmWKF9DexyOs7bw3mopWMKg8/5h9+q3s
	 lWE/nWjjkKbjBdlg0p5QhCPV5m7t6ULXRNjR9JS+1pt6VRwblmbMNGp6++uanGUjIZ
	 JlURe3CWuMV+7CpwbQReaxOuvqMEv4WKesvG5X4OdjXtrxg9NRgxNJecOteQHelfj0
	 +T1+bzLqaPGG71BAbi+wPGk1BsF5YyxnSJ8ZnF2FXxmLxgT2WJ/vJoDoSFIbG21gcq
	 uQX1pPgz4z7tMjjUFGYHjfQAksvD+CCDht3Fjlzm4PGZWWxU06OkAh/Tn2xXM//QdC
	 hFhtlwfW/RBkQ==
Message-ID: <311c13e0-2f14-4134-afb5-128bc82111e7@kernel.org>
Date: Fri, 31 May 2024 14:18:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/11] power: supply: max77693: Set charge current
 limits during init
To: Artur Weber <aweber.kernel@gmail.com>,
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>,
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>,
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
References: <20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com>
 <20240530-max77693-charger-extcon-v1-6-dc2a9e5bdf30@gmail.com>
 <d740ff64-2de6-424c-9fc0-f1064f8c4f8b@kernel.org>
 <0b611c4b-23d2-4c33-a6be-c15a04e8b99a@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <0b611c4b-23d2-4c33-a6be-c15a04e8b99a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/05/2024 13:55, Artur Weber wrote:
> On 31.05.2024 11:47, Krzysztof Kozlowski wrote:
>> On 30/05/2024 10:55, Artur Weber wrote:
>>> There are two charger current limit registers:
>>>
>>> - Fast charge current limit (which controls current going from the
>>>    charger to the battery);
>>> - CHGIN input current limit (which controls current going into the
>>>    charger through the cable, and is managed by the CHARGER regulator).
>>>
>>> Add functions for setting both of the values, and set them to a
>>> safe default value of 500mA at initialization.
>>>
>>> The default value for the fast charge current limit can be modified
>>> by setting the maxim,fast-charge-current-microamp DT property; the
>>> CHGIN input current limit will be set up later in the charger detection
>>> mechanism.
>>>
>>> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
>>> ---
>>>   drivers/power/supply/max77693_charger.c | 45 +++++++++++++++++++++++++++++++++
>>>   1 file changed, 45 insertions(+)
>>>
>>> diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
>>> index 894c35b750b3..d59b1524b0a4 100644
>>> --- a/drivers/power/supply/max77693_charger.c
>>> +++ b/drivers/power/supply/max77693_charger.c
>>> @@ -28,6 +28,7 @@ struct max77693_charger {
>>>   	u32 min_system_volt;
>>>   	u32 thermal_regulation_temp;
>>>   	u32 batttery_overcurrent;
>>> +	u32 fast_charge_current;
>>>   	u32 charge_input_threshold_volt;
>>>   };
>>>   
>>> @@ -591,6 +592,35 @@ static int max77693_set_batttery_overcurrent(struct max77693_charger *chg,
>>>   			CHG_CNFG_12_B2SOVRC_MASK, data);
>>>   }
>>>   
>>> +static int max77693_set_input_current_limit(struct max77693_charger *chg,
>>> +		unsigned int uamp)
>>> +{
>>> +	dev_dbg(chg->dev, "CHGIN input current limit: %u\n", uamp);
>>
>> That's quite useless debug. It duplicates
>> max77693_set_fast_charge_current(). Just drop entire wrapper.
> 
> It doesn't duplicate max77693_set_fast_charge_current, they modify two
> separate registers. Quote from the commit message: 

But it is the same uamp value. Debug messages should not be per register
write, because we are not debugging here registers...

> 
>> There are two charger current limit registers:
>>
>> - Fast charge current limit (which controls current going from the
>>  charger to the battery);
>> - CHGIN input current limit (which controls current going into the
>>   charger through the cable, and is managed by the CHARGER regulator).
> 
> max77693_set_fast_charge_current sets up the "fast charge current"
> register (in CNFG_02, CHG_CNFG_02_CC). The CHARGER regulators sets the
> CHGIN input current (in CNFG_09, CHG_CNFG_09_CHGIN_ILIM).
> 
> (Apparently the CHARGER regulator is supposed to handle the fast
> charge current, but it does not; I wrote about this in the "CHARGER
> regulator" section of the patchset description.)
> 
>>> +
>>> +	return regulator_set_current_limit(chg->regu, (int)uamp, (int)uamp);
>>> +}
>>> +
>>> +static int max77693_set_fast_charge_current(struct max77693_charger *chg,
>>> +		unsigned int uamp)
>>> +{
>>> +	unsigned int data;
>>> +
>>> +	data = (uamp / 1000) * 10 / 333; /* 0.1A/3 steps */
>>> +
>>> +	if (data > CHG_CNFG_02_CC_MASK) {
>>> +		dev_err(chg->dev, "Wrong value for fast charge current\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	data <<= CHG_CNFG_02_CC_SHIFT;
>>> +
>>> +	dev_dbg(chg->dev, "Fast charge current: %u (0x%x)\n", uamp, data);
>>> +
>>> +	return regmap_update_bits(chg->max77693->regmap,
>>> +			MAX77693_CHG_REG_CHG_CNFG_02,
>>> +			CHG_CNFG_02_CC_MASK, data);
>>
>> I am surprised that you set current limit via regulator but actual
>> charging current value here. I think both should go to regulator in such
>> case.
> 
> As in, both fast charge current and input current should be set up by
> the CHARGER regulator? Sure, sounds good to me.
> 
> I've noticed that on the original kernel, both of the values are
> modified together too (only exception is that fast charge current would
> be set to 0 when the cable was unplugged, but the input current stayed
> at 500mA. This doesn't seem to affect anything, though.).
> 
> At one point I actually considered going the other way around - moving
> all charger register handling into the charger driver, instead of having
> it be a regulator. As far as I can tell, only some Samsung-submitted
> charger drivers (max77693, max8997, max8998, max14577) use a regulator
> to manage the charger current (if anything, some power supply drivers
> expose an OTG/VBUS regulator, might be something for us to consider as
> well...).

regulator choice was to match userspace design that time (long time
ago), but I think now preference is to use writeable properties of power
supply class. I'll defer here to Sebastian.

> 
> I see you wrote at least the max14577 and part of the max77693 driver;
> out of curiosity, what's the benefit of doing it through a current
> regulator (as opposed to adding set functions for the relevant
> properties in the charger driver)? I've noticed the downstream driver
> has a very similar pattern[1], I wonder if it's just a port of that or
> if there's a more concrete reason.
> 


Best regards,
Krzysztof


