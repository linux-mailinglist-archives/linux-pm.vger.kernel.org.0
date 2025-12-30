Return-Path: <linux-pm+bounces-40038-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA37CE940F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 10:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DAE9C3002891
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 09:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E2E29E10F;
	Tue, 30 Dec 2025 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2Euhmft"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E898810A1E;
	Tue, 30 Dec 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767087981; cv=none; b=RqB8RfGmtMvaRRYfG5t02VI6bOyqc6DGYWTSmKFZgNRExiv+zS3dLO703tNjXnEtjeZzDPglO0Zpmt4XpM0EC5HAXHxI+EB2S0TeGX1/wJRuPp2qW4ExFy4tq01gKc2lTPnV99WARdvMrwyBF0BAB9B/XliV+ftVv7B+GxBPV78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767087981; c=relaxed/simple;
	bh=SEQUa79uEvWv531W+skrNW9gbSRbjNis425aTF7oAvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gmzqd/v4810WCf28+xRhUAL0v07jLZDKjZVB5M4MZUFNE9FpvmWjohT3dMs1L4I0dBD8SNI9MTaTsyZTRcxiTxeAMLBz7GykP51xxPeDT5dQkUHPROIxBR1tApEPmZjg65qi1wp+5mW/xCdGAqT5M47LKJDi2qXPsQWnTl3f0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2Euhmft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D163C4CEFB;
	Tue, 30 Dec 2025 09:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767087980;
	bh=SEQUa79uEvWv531W+skrNW9gbSRbjNis425aTF7oAvs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G2Euhmft0LO48dwnaRTj4GdHGftayG0F2WtRuRC74GB6GwLlQeJs5z9jMKfAe+crj
	 jSUHCWUe9c/MgEsGZ9aHoyd0grkE/oDeNTIzoZVZ3byCAwe1T2LrbOaxR10c5ON9Zc
	 75tJAFadJHxFqJRfx52Ja2vlcgZsgQA3Om0XB6GhKf4ljStGidUdnl9/Jc5UXFhqfV
	 6QK4XHNnmGll2nwWZ8eCbvpG9oBo24sO7gSHExMjezSSg5w308xcUQ6b+NGU/6Maw7
	 L9fCpOZDjWwfLPPW9Kb6y1vEK1yLO9LcutGT2vqZBJ6s/NrXRFnNejtJE4rkNs5bbM
	 lRIzN/m729oBw==
Message-ID: <5c52b138-38ef-42c9-9f81-c605df68792e@kernel.org>
Date: Tue, 30 Dec 2025 10:46:16 +0100
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
 <4daabe4d-bebc-4072-b7c6-0c46ee087040@kernel.org>
 <GV2PR06MB108091652BE6C23A6F9A7127CD7BCA@GV2PR06MB10809.eurprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <GV2PR06MB108091652BE6C23A6F9A7127CD7BCA@GV2PR06MB10809.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/12/2025 10:40, LI Qingwu wrote:
>>>>>
>>>>> +  sbs,monitoring-interval-ms:
>>>>> +    description:
>>>>> +      Polling interval in milliseconds for battery status monitoring on
>>>>> +      systems without interrupt support. The driver periodically checks
>>>>> +      the battery status and notifies userspace of changes. Ignored when
>>>>> +      GPIO interrupt is available.
>>>>
>>>>
>>>> You described the desired Linux feature or behavior, not the actual hardware.
>>>> The bindings are about the latter, so instead you need to rephrase
>>>> the property and its description to match actual hardware
>>>> capabilities/features/configuration etc.
>>>>
>>>
>>> Thanks for the quick feedback!
>>> How about this?
>>>
>>>   sbs,monitoring-interval-ms:
>>>     description:
>>>       Polling interval in milliseconds for battery status monitoring.
>>>       Intended for hardware designs where the battery's interrupt signal
>>>       is not connected, necessitating periodic status checks to detect
>>>       changes.
>>
>>
>> Nothing changed. It's exactly the same.
>>
>> Explain me how "polling interval" by Linux driver is a hardware value?
>> What was not clear in my feedback?
>>
> 
> Thank you for the feedback. I apologize, but I am still not clear on
> the correct approach.
> 
> I understand that "polling interval" is software policy and should not
> be in device tree. However, I am unsure whether:
> 
> 1. I should rephrase the property to describe the hardware fact (e.g.,
>    "battery alert signal is not wired"), or

Isn't this already described in the binding implicitly by missing
interrupt? Or the device is not using dedicated interrupt pins and only
SMBus Alert? But if the latter, then alert is always available.


> 2. I should remove this from device tree entirely and use a module
>    parameter instead.

Module parameters are usually not the way to configure anything. Look at
other devices and how they do it. Usually this is sysfs interface.

Regardless, I don't give you advice nor instruction how to implement
this. I just do not agree with current phrasing for DT. If you come with
proper hardware description for DT, it could be fine. If you want to
remove it from DT completely, I am fine as well.


Best regards,
Krzysztof

