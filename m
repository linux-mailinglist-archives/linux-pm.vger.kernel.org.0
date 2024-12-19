Return-Path: <linux-pm+bounces-19503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCFC9F76FB
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 09:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A88C1657CF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 08:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06B321766A;
	Thu, 19 Dec 2024 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWXIgQkn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7AB1FAC26;
	Thu, 19 Dec 2024 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734595995; cv=none; b=h5YNDbyf5/WqkrJ2BaF8/kgrOB6faiRM4TTeFWL0f/jyZdWGnVtazl8XdYuEebTcsH2FDYYdj36sXFsqegJgds2YynqBY7e3kbLNig8Aei/5Lirs7miEoeqSDOJ41LEOLBP4cR3DG+YaBSyH+nQxcC/5knTr7WC3gB8EIHRH5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734595995; c=relaxed/simple;
	bh=djzTY7PPd0rJb6S6MlPCqmv652dWt/UD2wFzE4GtDkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kr75h9U+YhrBHN+gN75UaM2ttTiP7H+5EKJ0d/aDeG8ePnWydSmdCLY6NETHpmY4VO91YqMTY7fft8gXz88+C3+muSRL0+/YSljvz+PaDRK7rHYpUJFm8mnNw7fmHv+WwbDaNWh0tWeOnCG+Dqd41+Po8+rI/+lJnHd5NWklw+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWXIgQkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0C7C4CECE;
	Thu, 19 Dec 2024 08:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734595994;
	bh=djzTY7PPd0rJb6S6MlPCqmv652dWt/UD2wFzE4GtDkY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kWXIgQkn5RoHM6qAaPsovMQokU9goUpFqZfx3HIeuRHXFUuRu7ctt+5vUxgZFJbP6
	 9LRtO6lAL2hjymHdEvwpgxsDuQlCrcSYRPmAkS8/0An6kjL0vK5zoGr1LlpbEx9tJ3
	 t/fGnRWyEysqIpRAV/28wvh5nFLZUkX67DtHUUxTTscUWkpODW0RQJxAnfFhaOajZK
	 I4oj69gXhtrlqLL5ajRn68HG1MmmdaYtvjNCt11q5IGcksY0bkKKUQc6BUGKfix0AH
	 8Sa5NIZBsZQ4xM70wu4ShZozMrafoWlJ2Un4ntmjd4nLuXH7/7YiNfklEd8b5LydlE
	 VznEAIqy2niJQ==
Message-ID: <a319101a-ab6a-40fd-9753-0593641b08f6@kernel.org>
Date: Thu, 19 Dec 2024 09:13:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] power: supply: gpio-charger: Support to disable
 charger
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Stefan Raufhake <raufhakestefan@gmail.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 s.raufhake@beckhoff.com, s.dirkwinkel@beckhoff.com, s.raufhake@beckhoff.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
References: <4tvn5k6zbsbyc2n3r2jnkrasyfhzfua4cap6ql65yjfmwzu3xw@lx6jmqvzypqv>
 <20241213102825.5509-1-raufhakestefan@gmail.com>
 <8a7948f8-b80e-463d-95ef-2f3461b96896@kernel.org>
 <xmjsvdyp63clrjkef4up7k4cgk5wfyldbij5ycsb7kumitnypi@pz6jpyyz45rv>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <xmjsvdyp63clrjkef4up7k4cgk5wfyldbij5ycsb7kumitnypi@pz6jpyyz45rv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/12/2024 01:58, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Dec 16, 2024 at 08:30:45AM +0100, Krzysztof Kozlowski wrote:
>> On 13/12/2024 11:28, Stefan Raufhake wrote:
>>> Hallo Krzysztof,
>>>
>>>>
>>>> On Tue, Dec 10, 2024 at 09:23:43AM +0000, Stefan Raufhake wrote:
>>>>> From: Stefan Raufhake <s.raufhake@beckhoff.de>
>>>>>
>>>>> Some GPIO-controlled power supplies can be turned off (charging disabled).
>>>>> Support changing the charging state by setting charge_type to
>>>>> POWER_SUPPLY_CHARGE_TYPE_STANDARD and disabling charging by setting
>>>>> charge_type to POWER_SUPPLY_CHARGE_TYPE_NONE. One potential use case for
>>>>> this is disabling battery backup on a UPS.
>>>>>
>>>>> Signed-off-by: Stefan Raufhake <s.raufhake@beckhoff.de>
>>>>> ---
>>>>>  .../bindings/power/supply/gpio-charger.yaml   |  6 +++
>>>>>  drivers/power/supply/gpio-charger.c           | 43 +++++++++++++++++++
>>>>>  2 files changed, 49 insertions(+)
>>>>>
>>>>
>>>> <form letter>
>>>> This is a friendly reminder during the review process.
>>>>
>>>> It seems my or other reviewer's previous comments were not fully
>>>> addressed. Maybe the feedback got lost between the quotes, maybe you
>>>> just forgot to apply it. Please go back to the previous discussion and
>>>> either implement all requested changes or keep discussing them.
>>>>
>>>> Thank you.
>>>> </form letter>
>>>
>>> Sorry, it seems I made a mistake during the patch review process. 
>>> Should I reply to your email about version 1 of the patch or only about
>>> version 2? I don't want to make another mistake and open two discussions 
>>> at the same time. 
>>> I hope to do better in the future.
>>>
>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
>>>>> index 89f8e2bcb2d7..084520bfc040 100644
>>>>> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
>>>>> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
>>>>> @@ -44,6 +44,10 @@ properties:
>>>>>      maxItems: 32
>>>>>      description: GPIOs used for current limiting
>>>>>
>>>>> +  enable-gpios:
>>>>> +    maxItems: 1
>>>>> +    description: GPIO is used to enable/disable the charger
>>>>> +
>>>>
>>>> You did not respond to my comments, nothing improved. Without
>>>> explanation based on hardware - which I asked - this is still a no.
>>>>
>>>> Implement and respond fully to previous feedback.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>>
>>> Sorry, I'm new to this and don't really know what exactly you want for the
>>> hardware description and how best to represent our hardware in dts.
>>> For the gpio power supply, it can basically be any circuit that implements
>>> a "fully charged" GPIO and a "disable ups" GPIO.
>>>
>>> We're using a circuit built around the LTC3350 (super capacitor ups chip):
>>> We use this pin to indicate that our UPS is fully charged (once the input
>>> is gone, it's not fully charged anymore):
>>> PFO (pin 38): Power-Fail Status Output. This open-drain output is pulled
>>> low when a power failure has occurred.
>>>  
>>> For the "disable ups" GPIO, we have some external circuitry around the 
>>> LTC3350. I can't share the schematic, but it boils down to "disable usage
>>> of ups" so that the device shuts down immediately when power is lost.
>>>  
>>> We've implemented this in many of our devices, but first we're looking 
>>> at [1] and [2], which we also want to upstream the device trees for.
>>> [1] https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx9240-arm-r-cortex-r-a53/cx9240.html
>>> [2] https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx8200-arm-r-cortex-r-a53/cx8200.html
>>>
>>> For the LTC3350, there is a separate driver posted to the Linux kernel
>>> mail list [3] by another devolper that we would like to use in the future,
>>> but without this gpio, our circuit won't work.
>>> [3] https://lore.kernel.org/all/?q=power%3A+supply%3A+ltc3350-charger
>>
>> This does not address my concerns at all. Read the previous comments -
>> you are duplicating existing property.
> 
> I think there is some misunderstanding. IIUIC you (Krzysztof) are
> referencing the following existing gpios property without any
> prefix?
> 
>>  gpios:
>>    maxItems: 1
>>    description: GPIO indicating the charger presence
> 
> This informs the operating system, that the charger has been plugged
> in (so the GPIO is an input from operating system point of view).
> 
> The work from Stefan is not about presence detection, but
> controlling if the charging should happen at all (so the GPIO is an
> output from operating system point of view). So that's two very
> different things.

So the gpios and charging status are input GPIOs and this is an output?
If so this seems right, indeed.

> 
> Technically there is some overlap with another existing property:
> charge-current-limit-gpios. I suppose a charger device limited to
> 0 Microampere is effectively off. But I think its fair to have a
> dedicated GPIO for explicit disabling.
> 
> If my analysis of the situation is correct, the documentation seems
> to be bad. Please suggest better wording :)
> 
> P.S.: binding and driver should be send in separate patches.

Yeah, still all my comments should be addressed.


Best regards,
Krzysztof

