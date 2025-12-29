Return-Path: <linux-pm+bounces-40015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EA8CE6C2C
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 13:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABEC33008D54
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 12:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7DD312813;
	Mon, 29 Dec 2025 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdrQVnUy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE22223D288;
	Mon, 29 Dec 2025 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767012428; cv=none; b=BxmXZSf+qr4aXMH4aOiaeuKySfBhWlP2wOQAjmlDqvdcI+JCoehntx7Gvgo0iqf3MkjtqeSR4LWz7hCLzJpSe9ge9L5PwisEfzHYctAvukamV3I/b05JWl4rDOvYtvtpts0Sg0W/26vIzj/HQ5fdtnu0kIMJiW8QSUeqbHv2oL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767012428; c=relaxed/simple;
	bh=AWyCsD5z8XTiBaogb1lYO1zNJ3O45jf71lJcJFSyGSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZY7iLh9Yoi2sei/pkfo3WuAXtQGWtRPGilUDpxoeI4BXvAOfXtBiTwXH0ekEW2ePzd73yyrogDczEPLQe9dBhogckJgmPTCgJ3D+0vyZiIS3CUz1BJxn3D3J+uZOL1EopRk8IQ+/iz80xOKlGVrPSMYBDkGKedooOTPguDk0x7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdrQVnUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F05C4CEF7;
	Mon, 29 Dec 2025 12:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767012428;
	bh=AWyCsD5z8XTiBaogb1lYO1zNJ3O45jf71lJcJFSyGSs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OdrQVnUyeo3oDm+8aiStBPpYW+5rFs1jV0FPhSkEb5m2H/GBaA8g+PdruziFH8g3d
	 sDBzXomBPgRBfCnT2DHN8FimB+lSektt2+saNIPJNWpRdXm9W90WHk2Rq65SRdWzHu
	 YlJs169f44QPKgh1GgQ6ywnO/aZLXKXtVBOYU+VpvsanOKntKtpj2CU5BIErXub+AT
	 0gxXn3O+U1Udh1dxg59t6CHaWHrKIey1HQmC2CoSd6Af8hhuJ6s9Ml7knYJy65/VOL
	 arhLhAt8RMIW5q9OiHIVQMpclU4GR/SnD5p+aIkckg/8sXkLhj96MqQAHrqvMRuS4R
	 Jv4r5UGMSEY6g==
Message-ID: <4daabe4d-bebc-4072-b7c6-0c46ee087040@kernel.org>
Date: Mon, 29 Dec 2025 13:47:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/3] dt-bindings: power: sbs-battery: add polling
 interval property
To: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
 "sre@kernel.org" <sre@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
References: <20251229085636.4082852-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20251229085636.4082852-2-Qing-wu.Li@leica-geosystems.com.cn>
 <63f1fd11-6628-4a83-b376-1e4efad6fd63@kernel.org>
 <GV2PR06MB108094811EF351CEA446A1ACBD7BFA@GV2PR06MB10809.eurprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <GV2PR06MB108094811EF351CEA446A1ACBD7BFA@GV2PR06MB10809.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/12/2025 10:50, LI Qingwu wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Monday, December 29, 2025 5:16 PM
>> To: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>; sre@kernel.org;
>> robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
>> linux-pm@vger.kernel.org; devicetree@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Cc: GEO-CHHER-bsp-development
>> <bsp-development.geo@leica-geosystems.com>
>> Subject: Re: [PATCH V1 2/3] dt-bindings: power: sbs-battery: add polling interval
>> property
>>
>> This email is not from Hexagon’s Office 365 instance. Please be careful while
>> clicking links, opening attachments, or replying to this email.
>>
>>
>> On 29/12/2025 09:56, LI Qingwu wrote:
>>> Add the optional sbs,monitoring-interval-ms property for SBS-compliant
>>> batteries to configure a periodic polling interval on systems without
>>> interrupt support. The driver periodically checks the battery status
>>> and notifies userspace of changes when this property is set, and
>>> ignores it when a GPIO interrupt is available.
>>>
>>> The property defaults to 0 to preserve existing behaviour.
>>>
>>> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
>>> ---
>>>  .../bindings/power/supply/sbs,sbs-battery.yaml           | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
>>> b/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
>>> index 90b9d3d882a4..fbdd5dd5dda8 100644
>>> ---
>>> a/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
>>> +++ b/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.y
>>> +++ aml
>>> @@ -59,6 +59,15 @@ properties:
>>>        master implementation.
>>>      type: boolean
>>>
>>> +  sbs,monitoring-interval-ms:
>>> +    description:
>>> +      Polling interval in milliseconds for battery status monitoring on
>>> +      systems without interrupt support. The driver periodically checks
>>> +      the battery status and notifies userspace of changes. Ignored when
>>> +      GPIO interrupt is available.
>>
>>
>> You described the desired Linux feature or behavior, not the actual hardware.
>> The bindings are about the latter, so instead you need to rephrase the property
>> and its description to match actual hardware
>> capabilities/features/configuration etc.
>>
> 
> Thanks for the quick feedback!
> How about this?
> 
>   sbs,monitoring-interval-ms:
>     description:
>       Polling interval in milliseconds for battery status monitoring.
>       Intended for hardware designs where the battery's interrupt signal
>       is not connected, necessitating periodic status checks to detect
>       changes.


Nothing changed. It's exactly the same.

Explain me how "polling interval" by Linux driver is a hardware value?
What was not clear in my feedback?

Best regards,
Krzysztof

