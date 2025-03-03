Return-Path: <linux-pm+bounces-23257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF806A4B932
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 09:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892D418878CA
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 08:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751B71EF393;
	Mon,  3 Mar 2025 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVDm6mrH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449631EF370;
	Mon,  3 Mar 2025 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990224; cv=none; b=YeNpwptjQ6U6jfGrrQ4F8XoyNBWy3PsMWutDR1se33zfZVIgbrkhMRjxQjE2s0yC8eBNKg4kI8lgGWvU1Svgm6PGXyLvo2EbQLqdk3Y/9oLtT2fWC42+zzkdkUvVGtsNmUMaB8oILDEk34m2hehRcrn+otTCC4vApBeTspbKlZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990224; c=relaxed/simple;
	bh=JBYtPPedySIRtCIdRicfOKbQHdjbOfdWis8gttwCsKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6FvrZqC+W6V46yPb7Ff2eN6i0EMkbFPh34rTayNVUaJgabFpd/9qkyZsX5igcK8kk7b5IP01g/jrDjs/5peB0zUHk8qGYjbKeAAdZgbNKy79DCn6UcbgKQEMW8H4wXjlxSm3ptd4fV21BO1C2a1EY/2vKaJegxgi4BaEieV08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVDm6mrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC04C4CED6;
	Mon,  3 Mar 2025 08:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740990223;
	bh=JBYtPPedySIRtCIdRicfOKbQHdjbOfdWis8gttwCsKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nVDm6mrH12QLK3/qUGEVPT3+GKwhphezMCb3UYIFD2ammHyvoXLfegpFXS35yl7wP
	 iXAtbjJ81a3G3cAnJPMh2gX7ThMNXotuiezB1R2iwBozQKUtI/az9KcGpGrKa0hbfX
	 sxIFGSWyqRiLFmiKd/sTiAynk6ZlSoW0DEPRoCOz6hRNJiNqnkJO8N8YaYaj9VEbrL
	 I+RMLenU3E2DKzLx13fWN3rbKamCKZf30X6qYN21gC7d4+1b1HheP+KW4go/pQ8uTh
	 pzlUSNBjBBx3Y1gdu86czAZdr9zQiESi4E2sLVt5KZcR86KqZIs6zji4qpoCidL2Gn
	 GrbFt881OjQNQ==
Message-ID: <a091f085-a7f0-4aaa-997d-cd478764c18a@kernel.org>
Date: Mon, 3 Mar 2025 09:23:38 +0100
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
 <CAPVz0n2kfxTJUkqrtLia6xBJ8t+fwjujjsc9k=mOk-P06bJH7A@mail.gmail.com>
 <f83b2a95-e8f6-4e16-bd7f-f7dc96264c04@kernel.org>
 <CAPVz0n0KVE8baFyGSgM+0rNfY8+Y2LFZbAhHHzPWTV358gc+Bw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAPVz0n0KVE8baFyGSgM+0rNfY8+Y2LFZbAhHHzPWTV358gc+Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/03/2025 09:13, Svyatoslav Ryhel wrote:
> пн, 3 бер. 2025 р. о 09:52 Krzysztof Kozlowski <krzk@kernel.org> пише:
>>
>> On 27/02/2025 12:03, Svyatoslav Ryhel wrote:
>>> чт, 27 лют. 2025 р. о 12:45 Krzysztof Kozlowski <krzk@kernel.org> пише:
>>>>
>>>> On Wed, Feb 26, 2025 at 11:36:59AM +0200, Svyatoslav Ryhel wrote:
>>>>> +  maxim,fcharge-current-limit-microamp:
>>>>> +    description:
>>>>> +      Fast-Charge current limit
>>>>> +    minimum: 250000
>>>>> +    default: 500000
>>>>> +    maximum: 1550000
>>>>> +
>>>>> +  maxim,fcharge-timer-hours:
>>>>> +    description:
>>>>> +      Fast-Charge timer in hours. Setting this value 3 and lower or 11 and higher
>>>>> +      will disable Fast-Charge timer.
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    default: 5
>>>>
>>>> You still did not answer why this is board specific. This was rejected
>>>> in the past because of that reason and nothing here changed. Nothing

Where are the arguments to existing/previous decisions?

>>>> will change without detailed explanation, so use other interfaces if you

Again, where is detailed explanation why time is determined per board,
unlike previously agreed that it is not?

>>>> need user-space to configure it (see other drivers, e.g. maxim)




>>>>
>>>
>>> Btw, I have used this awesome example you have provided. Take a look
>>
>> Where did I provide this example?
>>
> 
> Its presence in the docs is an example on its no? You have explicitly
> told to check other maxim devices, I did so, they all have similar set
> of convifurations.

Choose rather later or latest, not 12 YO, binding as an example.

> 
>>>
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml?h=v6.14-rc4
>>
>> I opened it and I do not see anything about time. Please point to
>> specific line.
>>
>> But regardless, how did I propose to use 12 year old binding? Where did
>> I suggest that one?
>>
>>>
>>> Oh, I wonder why it uses so much values which duplicate battery? I
>>> know, it lacks battery, I assume that is why?
>>
>> No. You added to DT something which is not a hardware property, but
>> user-space choice or policy.
>>
> 
> It is NOT a user-space choice or policy!
Previous discussions on the lists - since you mention 12 year old
binding, so also discussions 12 years ago - determined that they are
closer to them than board configuration.

I already said - this was rejected in the past - so now I am repeating
myself.

You did not bring any arguments just keep repeating "no", so I suggest
reading previous discussions and coming with arguments against them.

Best regards,
Krzysztof

