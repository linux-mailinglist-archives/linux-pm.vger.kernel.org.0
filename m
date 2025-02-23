Return-Path: <linux-pm+bounces-22752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC30A40F35
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 15:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B53E3B8D00
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 14:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0C8207A14;
	Sun, 23 Feb 2025 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hk382ROu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB878460;
	Sun, 23 Feb 2025 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320086; cv=none; b=gV/ly6NzzOrh2+dyZtuMLoDTQeYrXLBNKeDcE2cvkC+WCmcEG+qm+75aEVZwCWRzNnCDFp+0BAiMuS1Hd7Dd7gpvIS6UqDje4XjqEr/RmJ+VU2pMffo6lkXbvYPQ8BjoFXyLDA8J6B6jSkKzyZhDRGacEod8rqLDv0JwsdHVuW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320086; c=relaxed/simple;
	bh=HgHLy86KRNyFbsaYavBMwLup/kMpfRHr2v8NrXSfXGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8rpnf9+oDbABGzQL7K2mE8wxdfhaGeAet6cXY+idEX0LSgSFmFl3qXHeQrSA+/d5Sd/rF35ZDArqFpeeo4WoeknoHBtzhJDMLb6Fpe1rubO4eXKHLvBi2IWa3S6HpDoRD668oc83euA5QsvT3+Maoow5qIMtjvtHJdRaKKDlpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hk382ROu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7789DC4CEDD;
	Sun, 23 Feb 2025 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740320086;
	bh=HgHLy86KRNyFbsaYavBMwLup/kMpfRHr2v8NrXSfXGQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hk382ROuvLA/5m/y0ZtixhVKUqRRj/upCE62Mai0QQ5eEIBLLxDRcyYnSUcCOgHLK
	 l3AeI8/yTedxISVIASjbg4VrUoTIuzqDVSRrig4BrPp20iuplEWEFEorWkQEY74M0E
	 BRSD1ICujRW3aPM/MBfS6aeg7KEZeUj9EUFFaRlvwsUXyYCl9G/gq9fHqHIgN4YS7x
	 syYO5zXknERDjEyr7//ittqlcvoLDamRQhRfItFU6Rgx/LgxktUyekPdw+m2uAQOu/
	 oUaoCBdujc7sr+3z97cWpvEpbqoRdcAbgqKZ9VLYzoaReMOKYksQ2t8xaFGoFd2j9N
	 9Ya6ft+AMC1iA==
Message-ID: <2b0500e7-70e2-4bfe-ae72-ebab0f060eeb@kernel.org>
Date: Sun, 23 Feb 2025 15:14:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: power: supply: Document Maxim MAX8971
 charger
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250221095943.57297-1-clamor95@gmail.com>
 <20250221095943.57297-2-clamor95@gmail.com>
 <20250223-daft-amethyst-pogona-e9edcc@krzk-bin>
 <CAPVz0n0-6ea0mzWig-gPx+8fuPgM7iWkZpnpMnp-9+Lq5oCdDw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAPVz0n0-6ea0mzWig-gPx+8fuPgM7iWkZpnpMnp-9+Lq5oCdDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/02/2025 12:56, Svyatoslav Ryhel wrote:
> нд, 23 лют. 2025 р. о 13:43 Krzysztof Kozlowski <krzk@kernel.org> пише:
>>
>> On Fri, Feb 21, 2025 at 11:59:42AM +0200, Svyatoslav Ryhel wrote:
>>> Add bindings for Maxim MAX8971 charger.
>>>
>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>> ---
>>>  .../bindings/power/supply/maxim,max8971.yaml  | 133 ++++++++++++++++++
>>>  1 file changed, 133 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
>>> new file mode 100644
>>> index 000000000000..26b37e6f662f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
>>> @@ -0,0 +1,133 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/power/supply/maxim,max8971.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Maxim MAX8971 IC charger
>>> +
>>> +maintainers:
>>> +  - Svyatoslav Ryhel <clamor95@gmail.com>
>>> +
>>> +description:
>>> +  The MAX8971 is a compact, high-frequency, high-efficiency switch-mode
>>> +  charger for a one-cell lithium-ion (Li+) battery.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: maxim,max8971
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  extcon:
>>> +    description:
>>> +      Special device used to detect type of plug.
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>
>> You rather miss proper connector or ports. Which device pins are
>> describbed here?
>>
> 
> This is an optional phandle to extcon, which can detect plug type. If

I know what is this, you just wrote. extcon property is not allowed anymore.

> extcon is provided, charger then can change its setup to better
> provide supply to the battery. If no extcon is provided, device itself
> can detect only the fact of charger without details about type.


> 
>>
>>> +
>>> +  maxim,fcharge-current-limit-microamp:
>>> +    description:
>>> +      Fast-Charge current limit
>>> +    minimum: 250000
>>> +    default: 500000
>>> +    maximum: 1550000
>>> +
>>> +  maxim,fcharge-timer-hours:
>>> +    description: |
>>> +      Fast-Charge timer in hours. Setting this value 3 and lower or 11 and
>>> +      higher will disable Fast-Charge timer.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    default: 5
>>> +
>>> +  maxim,fcharge-rst-threshold-high:
>>> +    description:
>>> +      Set Fast-Charge reset threshold to -100 mV
>>> +    type: boolean
>>> +
>>> +  maxim,in-current-limit-microamp:
>>> +    description:
>>> +      Input current limit
>>> +    minimum: 100000
>>> +    default: 500000
>>> +    maximum: 1500000
>>> +
>>> +  maxim,topoff-timer-minutes:
>>> +    description:
>>> +      Top-Off timer minutes
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [0, 10, 20, 30, 40, 50, 60, 70]
>>> +    default: 30
>>> +
>>> +  maxim,topoff-current-threshold-microamp:
>>> +    description:
>>> +      Top-Off current threshold
>>> +    enum: [50000, 100000, 150000, 200000]
>>> +    default: 50000
>>> +
>>> +  maxim,fcharge-usb-current-limit-microamp:
>>> +    description:
>>> +      Fast-Charge USB current limit
>>> +    minimum: 100000
>>> +    default: 500000
>>> +    maximum: 1500000
>>> +
>>> +  maxim,fcharge-ac-current-limit-microamp:
>>> +    description:
>>> +      Fast-Charge AC current limit
>>> +    minimum: 100000
>>> +    default: 500000
>>> +    maximum: 1500000
>>> +
>>> +  maxim,usb-in-current-limit-microamp:
>>> +    description:
>>> +      USB Input current limit
>>> +    minimum: 100000
>>> +    default: 500000
>>> +    maximum: 1500000
>>> +
>>> +  maxim,ac-in-current-limit-microamp:
>>> +    description:
>>> +      AC Input current limit
>>> +    minimum: 100000
>>> +    default: 500000
>>> +    maximum: 1500000
>>
>> For all or most of these you miss monitored batter.
>>
> 
> This is a charger, it does not monitor battery. There is a fuel gauge
> for that or a battery monitor.
> 
What does charger charge? Battery or something else?

Best regards,
Krzysztof

