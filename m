Return-Path: <linux-pm+bounces-23258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3484A4B948
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 09:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758393B1EAA
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 08:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1322A1F0992;
	Mon,  3 Mar 2025 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AitvrlnU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A31EF389;
	Mon,  3 Mar 2025 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990299; cv=none; b=BZ3grjqNfFuijCbUUrUNVmLR71XdoJgJ7LX29el8m42jINd4RKoC+xgoUtzH5fj/PL+S3qW+4NElSeAJR1Ki1f8ehgGSvIWi/AMKAUC0p6KEQKM8yC3mAtyeCxUPvhYN0Krn1/b3LB8guXM0dwjIhHuoFM5fD/gC15JTMaxzDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990299; c=relaxed/simple;
	bh=oDZLgjN7IToV0/+diks17qyXPqajN4Spi1ShjEZES1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlnCBB6azUxa2bn/CV5qZ9KBoiJyo2K+G0+mxEvzXbBw20Pe5VUwMHYfKFxgk3+wuR2FQYLzbp74h6wdYVTeXx69OA/W+r5PsClXMDMgqIrTowS73pQ3SnJSupfVtav33jaH2LYH106LE5jVT5mqEdCDgMnBOnG8fkQRcXzEZqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AitvrlnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B907C4CED6;
	Mon,  3 Mar 2025 08:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740990298;
	bh=oDZLgjN7IToV0/+diks17qyXPqajN4Spi1ShjEZES1I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AitvrlnUrB65mhIOmclW3UtpdRhY3icPAx40PgkXb+pt5NFpLNgtfAPYolPIjqAmJ
	 vEcZEN0K9XQ3bzeTsS5zPfIU7CPCMHy7bgRt7COHqJEE38y5feBV4CYiK+G0qJaqy3
	 fYbCQYJOyBJzagc06mkC+Q69tD3sWkHlFiMWCgFmyXSMOKXUyOnNbcqyPMbBpZVfGu
	 STgnDuKjXMC0/CM7rYuxPygpqfPx1N6DOpC6xeQipPfBrbSc850vg4XSfUx9MGpojM
	 WlmySuMTY3CipB+mFWMHyQ2SGtx8h7VgZ77oN2CsDzbYnw7hD7rXqPR86M6BvNWMQg
	 0/PJt8WqDUaSg==
Message-ID: <f15fe8bf-1114-416c-8a3a-a0addcb0d5a7@kernel.org>
Date: Mon, 3 Mar 2025 09:24:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: Document Maxim MAX8971
 charger
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250226093700.44726-1-clamor95@gmail.com>
 <20250226093700.44726-2-clamor95@gmail.com>
 <20250227-cherubic-mantis-from-betelgeuse-86f5ff@krzk-bin>
 <CAPVz0n0ygR=ygsvG2+z-zST7kmJ_P3nxf29tqdgHpRs_Nw6D5Q@mail.gmail.com>
 <fbd307ae-1dfa-497b-a597-d15b6baa30f4@kernel.org>
 <CAPVz0n2no1EJnf4GKSJWfYA_8h8x6BRk_ducufie90YPZR-k3g@mail.gmail.com>
 <0b2a76e6-ad64-4c98-b6ab-e1f41cb54684@kernel.org>
 <CAPVz0n2+=m93MXNV-0Lvu5OQzquNSyV2EBRQPDEnpSw-AZFo+g@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAPVz0n2+=m93MXNV-0Lvu5OQzquNSyV2EBRQPDEnpSw-AZFo+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/03/2025 09:20, Svyatoslav Ryhel wrote:
> пн, 3 бер. 2025 р. о 10:18 Krzysztof Kozlowski <krzk@kernel.org> пише:
>>
>> On 03/03/2025 09:11, Svyatoslav Ryhel wrote:
>>> пн, 3 бер. 2025 р. о 09:54 Krzysztof Kozlowski <krzk@kernel.org> пише:
>>>>
>>>> On 27/02/2025 11:55, Svyatoslav Ryhel wrote:
>>>>>>> +
>>>>
>>>> Please kindly trim the replies from unnecessary context. It makes it
>>>> much easier to find new content.
>>>>
>>>>>>> +  maxim,usb-in-current-limit-microamp:
>>>>>>> +    description:
>>>>>>> +      USB Input current limit
>>>>>>> +    minimum: 100000
>>>>>>> +    default: 500000
>>>>>>> +    maximum: 1500000
>>>>>>> +
>>>>>>> +  maxim,ac-in-current-limit-microamp:
>>>>>>> +    description:
>>>>>>> +      AC Input current limit
>>>>>>> +    minimum: 100000
>>>>>>> +    default: 500000
>>>>>>> +    maximum: 1500000
>>>>>>
>>>>>> Half of these properties as well are not suitable and duplicate existing
>>>>>> sysfs interface.
>>>>>>
>>>>>
>>>>> All these properties allow configure the charger to suit the device on
>>>>> which it is used. None of them are required but are a nice addition.
>>>>> Why you are denying me an ability to fully utilize hardware I have and
>>>>> tune it to the device? All those values represent hardware registers
>>>>> which can be customized for the device, not for the end user to mess
>>>>> with.
>>>>
>>>> Because you put user-space choice or OS policy into the DT and DT is not
>>>> for that.
>>>>
>>>
>>> Those are NOT user-space choice or OS policy those are vendor
>>> configuration for a specific device and are NOT and NEVER were exposed
>>
>> Then look at existing devices. We had these discussions in the past and
>> these are usually exposed to user-space.
>>
> 
> Provide an example, where there is same or similar configuration.

If you tried even a bit, you would easily find them by grep for
timer/hours/minutes.

You do not even try but put this work on maintainer.

Do the homework and try a bit harder instead of pushing this on me.

Best regards,
Krzysztof

