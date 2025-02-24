Return-Path: <linux-pm+bounces-22779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146B7A41739
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 09:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261213AFBBD
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 08:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F906158558;
	Mon, 24 Feb 2025 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuMnDsYo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D818C11;
	Mon, 24 Feb 2025 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385425; cv=none; b=HawKuDlvXucHY2Lm8KrsXOSG2J8zoRJQUhc7uxuOgnXOeYy4eS8BuAYqtKRmrkul5mN/RzLNJ98dtEPPdmmSrT9I9XBTZ0+jwYGJmKFfLcfvZ5m6IPmr20Yn0MhpVEQavtH18Ru35eBkZuJDjG9JYSxyAEZQKWxcmqpRmKmJM9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385425; c=relaxed/simple;
	bh=P8Wr7RQijEqPeB9TFh7hBcVO/bNtGpwHnfXXy/LJowY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KR2AZDIVWyClNN4daAq2OAZxTYhJ7pxC8dgtmATrPH2iDK31hl4IwxuZ9ekMLnuvr7scCLvcXeULdGpjixoRXvIq4IoDAbWmfufpe3DwHENjNzWkQe58QU5f6OTC/EtQuyoCq40zJ62ZmXszCGqV96pICQ1Lq8qYQRpJO0YpS8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuMnDsYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B6EC4CED6;
	Mon, 24 Feb 2025 08:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740385425;
	bh=P8Wr7RQijEqPeB9TFh7hBcVO/bNtGpwHnfXXy/LJowY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PuMnDsYo8upUNoWaa1m/tt0Eyf3VRtomLi2uyoco1nLCKtCUm5J5MohheXBkuPxzx
	 NJyBolNdFHTvSRvdzZVI6HVqu0b/QrX8KxpRXYks9gw9FEESwLVnzYdO/1Z0xIczvL
	 MBGq1y3IZfSq2rzL0kbo1FH1OTi6QpOD6keB6JCSENrRuHNj0PVqGuP4SAik+gpKEK
	 JDb3m0ZXvFzjc6v0b1Szgjbb1aYIvqYTqZTKcKZWYRgZVOzxt238fVpzclNQlMG41V
	 HEXIkGUC3UisxPDSYxe0QLXf5FUl1TZoPnbKJ2LUZPCWpm700t45xNAcaAX57/vLz4
	 lFMBZYQaj0nIQ==
Message-ID: <7084415c-63f8-429d-999a-ed84c4586e26@kernel.org>
Date: Mon, 24 Feb 2025 09:23:40 +0100
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
 <2b0500e7-70e2-4bfe-ae72-ebab0f060eeb@kernel.org>
 <CAPVz0n2CMzU1bqV_jiTw+VgLUSB-CdEwF6uPS7aJzaPN+eGhmg@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAPVz0n2CMzU1bqV_jiTw+VgLUSB-CdEwF6uPS7aJzaPN+eGhmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/02/2025 15:28, Svyatoslav Ryhel wrote:
>>>>> +  extcon:
>>>>> +    description:
>>>>> +      Special device used to detect type of plug.
>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>>
>>>> You rather miss proper connector or ports. Which device pins are
>>>> describbed here?
>>>>
>>>
>>> This is an optional phandle to extcon, which can detect plug type. If
>>
>> I know what is this, you just wrote. extcon property is not allowed anymore.
>>
> 
> There is no helper for obtaining extcon via graph endpoint I am aware
> of. Can you provide an example of graph parsing extcon helper?

Most of recent drivers have the same problem and they solved it somehow
without introducing 'extcon' property.

> 
>>> extcon is provided, charger then can change its setup to better
>>> provide supply to the battery. If no extcon is provided, device itself
>>> can detect only the fact of charger without details about type.
>>
>>
>>>
>>>>
>>>>> +
>>>>> +  maxim,fcharge-current-limit-microamp:
>>>>> +    description:
>>>>> +      Fast-Charge current limit
>>>>> +    minimum: 250000
>>>>> +    default: 500000
>>>>> +    maximum: 1550000
>>>>> +
>>>>> +  maxim,fcharge-timer-hours:
>>>>> +    description: |
>>>>> +      Fast-Charge timer in hours. Setting this value 3 and lower or 11 and
>>>>> +      higher will disable Fast-Charge timer.
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    default: 5
>>>>> +
>>>>> +  maxim,fcharge-rst-threshold-high:
>>>>> +    description:
>>>>> +      Set Fast-Charge reset threshold to -100 mV
>>>>> +    type: boolean
>>>>> +
>>>>> +  maxim,in-current-limit-microamp:
>>>>> +    description:
>>>>> +      Input current limit
>>>>> +    minimum: 100000
>>>>> +    default: 500000
>>>>> +    maximum: 1500000
>>>>> +
>>>>> +  maxim,topoff-timer-minutes:
>>>>> +    description:
>>>>> +      Top-Off timer minutes
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    enum: [0, 10, 20, 30, 40, 50, 60, 70]
>>>>> +    default: 30
>>>>> +
>>>>> +  maxim,topoff-current-threshold-microamp:
>>>>> +    description:
>>>>> +      Top-Off current threshold
>>>>> +    enum: [50000, 100000, 150000, 200000]
>>>>> +    default: 50000
>>>>> +
>>>>> +  maxim,fcharge-usb-current-limit-microamp:
>>>>> +    description:
>>>>> +      Fast-Charge USB current limit
>>>>> +    minimum: 100000
>>>>> +    default: 500000
>>>>> +    maximum: 1500000
>>>>> +
>>>>> +  maxim,fcharge-ac-current-limit-microamp:
>>>>> +    description:
>>>>> +      Fast-Charge AC current limit
>>>>> +    minimum: 100000
>>>>> +    default: 500000
>>>>> +    maximum: 1500000
>>>>> +
>>>>> +  maxim,usb-in-current-limit-microamp:
>>>>> +    description:
>>>>> +      USB Input current limit
>>>>> +    minimum: 100000
>>>>> +    default: 500000
>>>>> +    maximum: 1500000
>>>>> +
>>>>> +  maxim,ac-in-current-limit-microamp:
>>>>> +    description:
>>>>> +      AC Input current limit
>>>>> +    minimum: 100000
>>>>> +    default: 500000
>>>>> +    maximum: 1500000
>>>>
>>>> For all or most of these you miss monitored batter.
>>>>
>>>
>>> This is a charger, it does not monitor battery. There is a fuel gauge
>>> for that or a battery monitor.
>>>
>> What does charger charge? Battery or something else?
>>
> 
> Anything it is linked to. Moreover ref to power supply is not needed

Not true. I opened datasheet and it clearly says:
"1-Cell Li+ charger".

It cannot charge other things properly, so it cannot charge "anything".
It only charges batteries.

"The MAX8971 is a compact, high-frequency, high-effi-
ciency switch-mode charger for a one-cell lithium-ion (Li+)
battery. "

> since properties from there are not relevant to this driver.

We talk about hardware here.

> monitored-battery refers to a simple battery cell, which has nothing
> to do with charger and power-supplies is irrelevant since this device

battery cell has everything to do with charger because it describes the
characteristic of what device you are charging: e.g. maximum input
current or top-off currents, which you define here as well.

You are duplicating some properties and adding some which are not DT at
all (all timers). Look how other devices do it.


Best regards,
Krzysztof

