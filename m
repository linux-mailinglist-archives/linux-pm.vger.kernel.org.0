Return-Path: <linux-pm+bounces-19282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EA59F2AF5
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 08:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB10D7A1A30
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 07:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585FB1B87E0;
	Mon, 16 Dec 2024 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYxBCJbb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B14124B34;
	Mon, 16 Dec 2024 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734334252; cv=none; b=E8P/wgHL/1HKC5Y3orF/B3KOVrZXzNJYCugoTHU2fvYQuj/Xwd9hzStG9IqOgM3HkeuxopYK46ig+7/WXPzdX1CDyL1EHHs9cXGoOWtX6GnftRHUMVc0cCT+7kX5vromrwAqCEtkciAOKpm71Jg7rZjybIbc8dJVIolgv9vlvks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734334252; c=relaxed/simple;
	bh=j4Vx/25BVWcsUfPa9vEHLLSMS5ddhxS02oX3/QfJ+iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RU3DQFtI879RIY/QZ8JMX8b+sX+a2lBRU5GEi1JwlqTyzqPX9k6s1NUTL9UmsjzFM74JQanPHBT6hr3/CPHuqN+3pP8XOj9RmyKLtMVSyARu0xWYtIWLkD+UVfkdX4icgTC1uLN7BmCKMfxyxkZl5ukocYOMt1msaGG4ynXMZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYxBCJbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDB3C4CED0;
	Mon, 16 Dec 2024 07:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734334251;
	bh=j4Vx/25BVWcsUfPa9vEHLLSMS5ddhxS02oX3/QfJ+iU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hYxBCJbbQ2ZrxHgO4NOaEa6L/X9Rd/pKh+5I91jXH2Uxckpn3o5c6elAJyaDs68Vy
	 DqVRDfh5hC+I28YZtOrQ3maCqQED8kgp+5mXaVD6EUj8qn4tOBddopbBrS5j+7GaX2
	 pDdYq78dPCkZLtzsNsJ/5PlmRExgQvz1XO6yVeR5egFCI+J2TACc31hnpM42/vjGzF
	 CfvimzNVxFjR40EYcQnChDxnzyK96Jn+9hmHTjQQeL2NpUJ0Hwgm8r48Euj4oyPmpV
	 W8+LPJbYznJr243z5Wo6u04Bnq3e6Z785aCPU58UVtfAzf+gnrtYPpta7v9cL1bxrV
	 Mn3sfCCbnwGsw==
Message-ID: <8a7948f8-b80e-463d-95ef-2f3461b96896@kernel.org>
Date: Mon, 16 Dec 2024 08:30:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] power: supply: gpio-charger: Support to disable
 charger
To: Stefan Raufhake <raufhakestefan@gmail.com>
Cc: sre@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, s.raufhake@beckhoff.com,
 s.dirkwinkel@beckhoff.com, s.raufhake@beckhoff.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
References: <4tvn5k6zbsbyc2n3r2jnkrasyfhzfua4cap6ql65yjfmwzu3xw@lx6jmqvzypqv>
 <20241213102825.5509-1-raufhakestefan@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241213102825.5509-1-raufhakestefan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/12/2024 11:28, Stefan Raufhake wrote:
> Hallo Krzysztof,
> 
>>
>> On Tue, Dec 10, 2024 at 09:23:43AM +0000, Stefan Raufhake wrote:
>>> From: Stefan Raufhake <s.raufhake@beckhoff.de>
>>>
>>> Some GPIO-controlled power supplies can be turned off (charging disabled).
>>> Support changing the charging state by setting charge_type to
>>> POWER_SUPPLY_CHARGE_TYPE_STANDARD and disabling charging by setting
>>> charge_type to POWER_SUPPLY_CHARGE_TYPE_NONE. One potential use case for
>>> this is disabling battery backup on a UPS.
>>>
>>> Signed-off-by: Stefan Raufhake <s.raufhake@beckhoff.de>
>>> ---
>>>  .../bindings/power/supply/gpio-charger.yaml   |  6 +++
>>>  drivers/power/supply/gpio-charger.c           | 43 +++++++++++++++++++
>>>  2 files changed, 49 insertions(+)
>>>
>>
>> <form letter>
>> This is a friendly reminder during the review process.
>>
>> It seems my or other reviewer's previous comments were not fully
>> addressed. Maybe the feedback got lost between the quotes, maybe you
>> just forgot to apply it. Please go back to the previous discussion and
>> either implement all requested changes or keep discussing them.
>>
>> Thank you.
>> </form letter>
> 
> Sorry, it seems I made a mistake during the patch review process. 
> Should I reply to your email about version 1 of the patch or only about
> version 2? I don't want to make another mistake and open two discussions 
> at the same time. 
> I hope to do better in the future.
> 
>>
>>> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
>>> index 89f8e2bcb2d7..084520bfc040 100644
>>> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
>>> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
>>> @@ -44,6 +44,10 @@ properties:
>>>      maxItems: 32
>>>      description: GPIOs used for current limiting
>>>
>>> +  enable-gpios:
>>> +    maxItems: 1
>>> +    description: GPIO is used to enable/disable the charger
>>> +
>>
>> You did not respond to my comments, nothing improved. Without
>> explanation based on hardware - which I asked - this is still a no.
>>
>> Implement and respond fully to previous feedback.
>>
>> Best regards,
>> Krzysztof
>>
> 
> 
> Sorry, I'm new to this and don't really know what exactly you want for the
> hardware description and how best to represent our hardware in dts.
> For the gpio power supply, it can basically be any circuit that implements
> a "fully charged" GPIO and a "disable ups" GPIO.
> 
> We're using a circuit built around the LTC3350 (super capacitor ups chip):
> We use this pin to indicate that our UPS is fully charged (once the input
> is gone, it's not fully charged anymore):
> PFO (pin 38): Power-Fail Status Output. This open-drain output is pulled
> low when a power failure has occurred.
>  
> For the "disable ups" GPIO, we have some external circuitry around the 
> LTC3350. I can't share the schematic, but it boils down to "disable usage
> of ups" so that the device shuts down immediately when power is lost.
>  
> We've implemented this in many of our devices, but first we're looking 
> at [1] and [2], which we also want to upstream the device trees for.
> [1] https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx9240-arm-r-cortex-r-a53/cx9240.html
> [2] https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx8200-arm-r-cortex-r-a53/cx8200.html
> 
> For the LTC3350, there is a separate driver posted to the Linux kernel
> mail list [3] by another devolper that we would like to use in the future,
> but without this gpio, our circuit won't work.
> [3] https://lore.kernel.org/all/?q=power%3A+supply%3A+ltc3350-charger

This does not address my concerns at all. Read the previous comments -
you are duplicating existing property.


Best regards,
Krzysztof

