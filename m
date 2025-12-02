Return-Path: <linux-pm+bounces-39070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF7AC9B8B2
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 14:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43C324E313D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 13:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3465B3112D2;
	Tue,  2 Dec 2025 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfxAjIPv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25201548C;
	Tue,  2 Dec 2025 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764680446; cv=none; b=Cb+bXN3NaDN8+OC3S+sPpJMCEWwXabFvAluEQoxtPsvVQMu+vp6wmG/FLKMwjooZBA5ryn3tMhMQk8p7pJGtx2wWS/hxCg08Uy8XCTxPEavCw/RRRp16XiFSPctl6fzHJBi4MMHr3kw2jcZR4xpp+tuU170g1vTwjOAOT0UFj2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764680446; c=relaxed/simple;
	bh=O5dADBbz0/9mG0iK1bzqcE79NAjPo9jdhr65mtDfkmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDU+kMq+xhJHR1z2VhOggwScFzAYqhW70lmqEV6svnL/z6hPsxLsE/5x8dqvsE91mkx0Z33oS3JUgYqu3Ro5TsDyAa+mCkO9ztR3F59tGWZE570iLUhmBP+m1FrryrLMnJvqMAoaswnBHdfNMJ0B48HBTRq3agic5nLWc6l5vZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfxAjIPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385DCC4CEF1;
	Tue,  2 Dec 2025 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764680445;
	bh=O5dADBbz0/9mG0iK1bzqcE79NAjPo9jdhr65mtDfkmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VfxAjIPvFyqYqC/XRJRci+Dzk6nWVaa57bdk0arWM2/FfysAB/JJx5zWj+YyHVSYJ
	 STZMh2WsDXmOHEY7/QeaL7yrf+8I0KZedS6d34BlyXtBx+FtNETtX4G14Isn0FuOxC
	 yrnM2NLMXGcqRlG7Pb5HGwxB/J3Ji7ECy30uoHhgsLZ5CTvssuNHlsdZ/jSPCmE9aL
	 YasY9N0op+CMjMDfMgWqIWHBZ99Fkp4sREf024I4MxwQ1r05rLQpZWg6gFMikLg5Y1
	 EEBjfQ1/vX62DQdxy1/lHym/FLuc4uzih65BOSW1ygX04BK4iQ4eVJ9Th08euKrwOn
	 AdsLHcR8J823A==
Message-ID: <076777c3-b238-4d1d-a11b-602027348ee4@kernel.org>
Date: Tue, 2 Dec 2025 14:00:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: power: supply: Add Maxim MAX77759
 charger
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Lee Jones <lee@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
 <20251123-max77759-charger-v1-1-6b2e4b8f7f54@google.com>
 <d4455f4b-2a0f-4bc0-b897-14f2e27af3ea@kernel.org>
 <c9b059f8-9219-4219-95c8-23a3733fea58@google.com>
 <20251125-amorphous-bobcat-of-whirlwind-afdab1@kuoka>
 <7ad91325-e881-461d-b39e-6ff15d98b3c5@google.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <7ad91325-e881-461d-b39e-6ff15d98b3c5@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2025 00:48, Amit Sunil Dhamne wrote:
> 
> On 11/25/25 1:56 AM, Krzysztof Kozlowski wrote:
>> On Sun, Nov 23, 2025 at 06:34:05PM -0800, Amit Sunil Dhamne wrote:
>>> Hi Krzysztof,
>>>
>>> On 11/23/25 1:28 AM, Krzysztof Kozlowski wrote:
>>>> On 23/11/2025 09:35, Amit Sunil Dhamne via B4 Relay wrote:
>>>>> From: Amit Sunil Dhamne <amitsd@google.com>
>>>>>
>>>>> Add bindings for Maxim max77759 charger device.
>>>>>
>>>>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>>>>> ---
>>>>>   .../power/supply/maxim,max77759-charger.yaml       | 36 ++++++++++++++++++++++
>>>>>   1 file changed, 36 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..71f866419774
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml
>>>>> @@ -0,0 +1,36 @@
>>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/power/supply/maxim,max77759-charger.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Maxim Integrated MAX77759 Battery charger
>>>>> +
>>>>> +maintainers:
>>>>> +  - Amit Sunil Dhamne <amitsd@google.com>
>>>>> +
>>>>> +description: |
>>>>> +  This module is part of the MAX77759 PMIC. For additional information, see
>>>>> +  Documentation/devicetree/bindings/mfd/maxim,max77759.yaml.
>>>>> +
>>>>> +  The Maxim MAX77759 is a dual input switch mode battery charger for portable
>>>>> +  applications. It supports wired and wireless charging and can operate in buck
>>>>> +  and boost mode.
>>>>> +
>>>>> +allOf:
>>>>> +  - $ref: power-supply.yaml#
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: maxim,max77759-charger
>>>>> +
>>>> This should be just folded into parent node, no need for separate
>>>> charger device or is just incomplete.
>>> Thanks for the review! You are right, the binding is incomplete. This
>>> charger block actually listens on its own I2C address, distinct from the
>>> main PMIC.
>>>
>>> I will update v2 to include the reg property. I will also add the
>> AFAIK, the main (parent) device schema does not reference children via
>> any sort of addressing, so reg here would not be suitable.
> 
> I agree that currently nvmem and gpio devices (which are children of 
> PMIC device) are not referenced using any address. But I was guessing 
> that's because they share the i2c client id with the PMIC and sharing 
> its address space (implied).
> 
> The charger device while being part of the MAX77759 PMIC package has 
> it's own i2c client id and address space that's why I proposed "reg". 
> The underlying assumption I made was separate client id implies that a 
> "reg" property required. But maybe that's incorrect.
> 
> I can understand the argument against having a "reg" property. As the 
> i2c client id will remain same for a max77759 charger device (as it's a 
> chip property and not a board property) it will always remain a 
> constant. I will drop the "reg" proposal.
> 
> 
>>
>>> standard properties `constant-charge-current-max-microamp` and
>>> `constant-charge-voltage-max-microvolt` to configure the hardware
>>> limits, as this charger device does not manage the battery profile
>>> directly (that is handled by a separate fuel gauge).
>> Well, still, what's the benefit for the bindings to have it as a
>> separate child? Kind of depends on your example, which is quite small -
>> one regulator and supply. Grow the example with battery and other
>> independent resources (if they are) to justify it. Or show arguments why
>> this is re-usable.
> 
> The primary reasons for keeping the charger as a distinct child node are 
> to model the hardware topology for the power supply subsystem and to 

You do not need children for that at all.

> house the OTG regulator provided by the charger block.
> The charger needs to be referenced by the Fuel Gauge (which handles the 
> battery profile) via power-supplies. Additionally, the charger block 
> provides a regulator for USB OTG VBUS, which is cleaner to represent as 
> a child node of the charger rather than mixing it into the top-level 
> PMIC node.

Sorry but argument that you need a child device to be able to construct
a phandle is just wrong. You can create phandles on every other way as well.


Best regards,
Krzysztof

