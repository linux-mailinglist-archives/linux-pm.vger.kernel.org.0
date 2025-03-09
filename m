Return-Path: <linux-pm+bounces-23720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258E7A587F6
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 20:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA98188D8EF
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 19:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA9B21858F;
	Sun,  9 Mar 2025 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vL4uHPJ9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5082217F48;
	Sun,  9 Mar 2025 19:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741549850; cv=none; b=O8dCXTg7rIJQDgk6nwgw0SfoOQSNbTjfU8Jl0zf6jAwoqFO0go+YY6juTlwGIebB7Ory2bFA41HrRMVTla93Si+jjUH2LVtr1BbxiCZwrw96vqLgv+UP5G9CtoecJ+/Mnbu21ZHUPN6m8OlelVe7sJg5EJ5Iv9Ssfmj5mCA70SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741549850; c=relaxed/simple;
	bh=8ySbkKhFRXNuJHrR+dQojieyUf+Le6VlZ6dqAVE1rBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9UuMLxCMGcaW20YuUdHXqyYJc6O6SBN4gahnoTBbZ5QsBvqRDPNIRv+j6G5gVFprqWhQZCl8FzRSSXV+udNjstJwMabzmzAnsBTg5uNsZrEoy6mbZSWZccj7x7rX8eQSYntiK+BauCREJuUZmzbuwA2aApVrUin4sW9ekHJsnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vL4uHPJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01DDC4CEED;
	Sun,  9 Mar 2025 19:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741549849;
	bh=8ySbkKhFRXNuJHrR+dQojieyUf+Le6VlZ6dqAVE1rBA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vL4uHPJ9xNFvMEfLN4Ec7wuCyQBk4CvGg96VRLiQVjTdErydTSp7ri+PuMR/AqNvE
	 Kmgts1dW8zJBzTEUubXkXyzukwbGalmCnd/ojq/0vSQE12plU3rrF54+8cge6/zdoz
	 Bbnjlswtzje1uBkOeg6DHIWLXh07ojZf0+S86fVRH1SplUiVWdh0Rq58oevPcccqC1
	 tu0B8TVkzt2MJsS4wJjDkZPYnQfIRa1yNK1V7pmaD2/CCmWCK3bbQAdvYACbUdlPqT
	 Z80aksp2iPxS9LGFWTaCTU8qI5zHnwm9m6z3Fr2E2A8w72C8vFdVyOpUDGr50KAjPO
	 TaRGpHsWSquBQ==
Message-ID: <668ada6a-3e53-474d-be81-d69d75277c26@kernel.org>
Date: Sun, 9 Mar 2025 20:50:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/19] dt-bindings: mfd: mediatek: mt6397: Add accdet
 subnode
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 kernel@collabora.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org
References: <20250305-mt6359-accdet-dts-v4-0-e5ffa5ee9991@collabora.com>
 <20250305-mt6359-accdet-dts-v4-1-e5ffa5ee9991@collabora.com>
 <20250306-certain-jasmine-mastiff-fd67ba@krzk-bin>
 <2fa6037d-b5e9-45b2-a5d5-dbc92fb3434b@notapiano>
 <0663e03e-e331-4a06-be95-ce8d9059ed6b@kernel.org>
 <cb2820d8-84e8-49ca-b497-1ea815679a3d@notapiano>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <cb2820d8-84e8-49ca-b497-1ea815679a3d@notapiano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/03/2025 14:22, Nícolas F. R. A. Prado wrote:
> On Fri, Mar 07, 2025 at 08:11:26AM +0100, Krzysztof Kozlowski wrote:
>> On 06/03/2025 13:19, Nícolas F. R. A. Prado wrote:
>>>>>    It is interfaced to host controller using SPI interface by a proprietary hardware
>>>>>    called PMIC wrapper or pwrap. MT6397/MT6323 PMIC is a child device of pwrap.
>>>>> @@ -224,6 +225,30 @@ properties:
>>>>>      description:
>>>>>        Pin controller
>>>>>  
>>>>> +  accdet:
>>>>> +    type: object
>>>>> +    additionalProperties: false
>>>>> +    description:
>>>>> +      The Accessory Detection module found on the PMIC allows detecting audio
>>>>> +      jack insertion and removal, as well as identifying the type of events
>>>>> +      connected to the jack.
>>>>> +
>>>>> +    properties:
>>>>> +      compatible:
>>>>> +        const: mediatek,mt6359-accdet
>>>>
>>>> You just removed the other file, no folding happened here. Drop the
>>>> accdet node and fold this into parent.
>>>
>>> Sorry, I'm still not sure what you mean by folding here then. Right now the
>>> accdet is a subnode of the PMIC. If you want me to remove the accdet node, where
>>
>> Yes
>>
>>> would its compatible and property go?
>>
>> compatible: nowhere, because it is close to redundancy.
>>
>> property: to the parent pmic node.
>>
>>     pmic {
>>         compatible = "mediatek,mt6359";
>>         interrupt-controller;
>>         #interrupt-cells = <2>;
>>
>>         mediatek,hp-eint-high;
>>     };
> 
> I'm not sure that's right. The ACCDET submodule does have some resources, IRQs,
> that it registers in its mfd cell, see patch 2 of this series [1]. It also has

Binding is supposed to be complete, so why suddenly we have here some
resources which you did not add?

Post complete binding, so you will get proper review.

> its own driver (sound/soc/codecs/mt6359-accdet.c) that probes based on this

Drivers do not define bindings.

> compatible and handles those interrupts. Why would it not get its own node like

Sorry, cannot go. You cannot document binding post factum and claim "I
have a driver which uses that compatible".

This would be a nice way to bypass review.

> the other MFD cells?

I explained why. I gave you the exact reason.

Best regards,
Krzysztof

