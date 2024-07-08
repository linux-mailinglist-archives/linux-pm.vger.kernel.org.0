Return-Path: <linux-pm+bounces-10754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 928EB929EB1
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 11:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1871F22339
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 09:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ED84DA00;
	Mon,  8 Jul 2024 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT+SLy+D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31039219F3;
	Mon,  8 Jul 2024 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720429824; cv=none; b=AID0PTitW5TPqgGZ06Ael6lmM6212f5wHhzxOnHlD7J7K3/ZLXy7BJiYqo/B2LSX+WqKCTe6NvYGvXMIok/7w3AR1iac0zeCrdcx8nOOeEFlH97ydzE4a96n5/LsGQ//j2G3O6v+mgsd31sh3bsWJOrbz/e9ePLF62dkQmNUw8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720429824; c=relaxed/simple;
	bh=AuzOmWIxG3jTWVum4y8+8Lc6vfI9lgPYT1Wp/Q8wmms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8rij5c+nXLOAx36q3kJuva7Jt1PT7Y6V1CLYjh4a+Kz1Si3uaEabk1iGlv3y6OWNiNEpf4hKEmgjV5wS8M8PfqtQNTCRfjL2MeemkD1FoFqmbQQfGRWwCy5IKTYZxC6pcmgckFikyhJt9zqUaWfj5/oMhA6P8jVWhBK3B1VOdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT+SLy+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C550AC116B1;
	Mon,  8 Jul 2024 09:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720429823;
	bh=AuzOmWIxG3jTWVum4y8+8Lc6vfI9lgPYT1Wp/Q8wmms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mT+SLy+DopjjwCiD7ovp5hicIF7srnkLzzCJTsCMeH7WWwOeoD1+Y0vKDzpKl9kIv
	 OpOr8maktMyHQXUgYVVgVESlE1S+zKzrhlfFyeVkQbseh58GDMIVen/EqHFYxl/xFG
	 pLjI7hXz9Cgaja2eXExClzHNb6fBeeQyL3vbBHTBgq/rPQUdUWKelJ0tcfZVk8q/od
	 aAe+eh0MetBQWBMVL9qaEl30hkOazVsaHAeq3VtPBsgzbKo4sSQfsCKMWksCVp1Nnd
	 0+iXi3r78oJ3GEp7VOBkIavMDZh2o93SZ7kgvtfvkSbCHkZY1exAgit0vsy9Jxgbkt
	 L5GbUM8LW2n5Q==
Message-ID: <aab8fae1-c0ba-4fab-8690-88c6cfe569e5@kernel.org>
Date: Mon, 8 Jul 2024 11:10:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: power: Add power sequence for Amloigc
 WCN chips
To: Yang Li <yang.li@amlogic.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240705-pwrseq-v1-0-31829b47fc72@amlogic.com>
 <20240705-pwrseq-v1-1-31829b47fc72@amlogic.com>
 <a4d08999-55ea-4674-bb0f-6d618b7bdea7@kernel.org>
 <9c550278-2205-4663-917c-c303c65726ad@amlogic.com>
 <726a0561-b3fc-46bb-a834-3ed8b0e993e1@kernel.org>
 <91e42fbc-712e-44b4-8200-23aaf1fade43@amlogic.com>
 <7d109ab0-ebd0-4739-a15e-958e82552a7d@kernel.org>
 <2c51fff5-bc63-4f30-bb6d-f5fe91854d6d@amlogic.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <2c51fff5-bc63-4f30-bb6d-f5fe91854d6d@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/07/2024 10:21, Yang Li wrote:
> 
> On 2024/7/8 15:32, Krzysztof Kozlowski wrote:
>> On 08/07/2024 08:32, Yang Li wrote:
>>> 在 2024/7/8 14:11, Krzysztof Kozlowski wrote:
>>>> On 08/07/2024 08:04, Yang Li wrote:
>>>>>>> +
>>>>>>> +required:
>>>>>>> +  - compatible
>>>>>>> +  - clocks
>>>>>>> +  - clock-names
>>>>>>> +  - amlogic,chip-enable-gpios
>>>>>>> +  - amlogic,bt-enable-gpios
>>>>>>> +
>>>>>>> +additionalProperties: false
>>>>>>> +
>>>>>>> +examples:
>>>>>>> +  - |
>>>>>>> +    #include <dt-bindings/gpio/gpio.h>
>>>>>>> +    wcn_pwrseq {
>>>>>> No underscores in node names, generic node names.
>>>>>>
>>>>>> There is no device as "pwrseq". I also do not get what "wcn" means here.
>>>>> Yes, I understand.
>>>>>
>>>>> Can I change "wcn_pwrseq" to "pmu", and do I need to change the binding
>>>> What is pmu for your device? What is this device in the first place you
>>>> are documenting? Where is the datasheet?
>>> ^_^ Well, You are right, the "pmu" wasn't really fit in here.

So no datasheet? Then you are on your own.

>>>
>>> I'd like to explain the current usage first, and could you please give
>>> me a suggestion?
>>>
>>> This module(pwrseq) used to power on Bluetooth & Wi-Fi combo chip, both
>>> Bluetooth and
>>>
>>> Wi-Fi driver need to control "chip-en-gpios" pins, so we introduced the
>>> power sequence module.
>>>
>>> What should we call it in this case?
>> Sorry, you describe driver, not a device.
>>
>> That would be a no-go for entire binding. Please describe the hardware,
>> not what you want to achieve in Linux drivers.
> W155s2 is a Bluetooth and WiFi combination chip. Bluetooth requires the 

I asked about this device here.

You speak now about W155s2 but everywhere else you were using "WCN".
What is that WCN?

> bt-en pin to be pulled up, the chip-en pin to be pulled up, and the 
> 32.768KHz clock. WiFi requires the chip-en pin to be pulled up, and the 
> 32.768KHz clock. It can be seen that Bluetooth and WiFi are coupled to 
> the chip-en pin and the 32.768KHz clock. When Bluetooth and WiFi are 
> working at the same time, no matter which one is turned off, it will 
> affect the other device. Therefore, a pwrseq device is now abstracted to 

It is the first time you mention pwrseq device from above paragraph.
Nothing above describes pwrseq.

Stop describing your problem, we all know it exactly if you follow the
discussions about power sequencing. Instead describe this particular
device you add binding for. What is this pwrseq in hardware? How does it
look? Where is it located? What are its pins? What are its supplies?

> manage the chip-en pin, bt-en pin, and the 32.768KHz clock.

> 
> There is currently no matching device name for the pwrseq composite device.

? No clue what does this mean.
> 
> Could you please give me some advice?

Again, you do not describe the device for the binding but something
else. Something for your drivers, sorry. No.

If you disagree, respond accurately to all questions above, not to only
some of them...

Best regards,
Krzysztof


