Return-Path: <linux-pm+bounces-10587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9A29271E9
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 10:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3F42857B4
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 08:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1031A4F01;
	Thu,  4 Jul 2024 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTDk1Bn/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9158B1891DE;
	Thu,  4 Jul 2024 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082508; cv=none; b=ArvifYuy2KAzxiuqcBzryGcOeeXrkrD2zc/lD4p5XUhk0nv6CC2I3OoVg4gqwPd5hLn7SI0CRB8a8HKSObieXxn/PKfLw2H5XOI8sVRjQ0nR2WQPrFLc75KmCOWVfLM2tpQVA+fk//zXK6Jyk2uwn7DORmOnTv1AFM3Vx8sewZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082508; c=relaxed/simple;
	bh=Sau6sfpL8YENzLqulrYTW3c5o0opYWelOaoKQ6Xul0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMvqQ/DQxrB1ThS0GF9Gst5AMqxpd7TrigFTS7DP94O2r+N7QxXHnb7KLXwz4dyfksziZlCVBaziW2RromuOdh5A3vysr9//EPQwzJ/Tfvwl+b0w5IQ1vmcR+Ty+ZbugYZJPsaZcObeTShn7TgKBI/oIMT5lOIwDT6XR0RbvXsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTDk1Bn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30918C3277B;
	Thu,  4 Jul 2024 08:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720082508;
	bh=Sau6sfpL8YENzLqulrYTW3c5o0opYWelOaoKQ6Xul0w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lTDk1Bn/swFidPHgAbv4aU/XRXRGAiGXXiLjNU7aJSlta56Gp81ZTZfFHWB8EKASc
	 80whYvfFt7BFitqrMNQtpaoT9uCTeLvnxyKmk7EfVHgKSxH/gDWB6/3i6S7IctKHav
	 1Q6JMKtM2Udx8TlrfysBHLekLS2kUkZx16p4FL8cmgqAxb1fgCc9I2H62Z7GZV8rhw
	 pdyDOOH0XcDAkZ6nzhzK6u7OYKCSmApcpVehzstlYzzXoUstD3zIFS35IZA4IWF/1K
	 VlbnWWOsx6CXb2T9pAqQ+KtsdLN7/KYVAx3DFe6fyQPcY7m+iSgwUg4B9KfiDL6rCH
	 IRWtJSgQ2xHYA==
Message-ID: <b5a056f1-a733-4d8b-94ad-49489ff26da2@kernel.org>
Date: Thu, 4 Jul 2024 10:41:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: thermal: sophgo,cv1800-thermal: Add
 Sophgo CV1800 thermal
To: Haylen Chu <heylenay@outlook.com>, Conor Dooley <conor@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Inochi Amaoto <inochiama@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <SEYPR01MB42213F3A032C60C6AF5EB677D7DC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB42217228213F5F2C739088DED7DC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <20240702-aptitude-overripe-8ac9aa3c6b90@spud>
 <d4b71376-2864-45af-8ad9-92c8a7cde291@kernel.org>
 <SEYPR01MB4221C23C14DB53299E2E2F12D7DE2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <SEYPR01MB4221C23C14DB53299E2E2F12D7DE2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/07/2024 10:25, Haylen Chu wrote:
> On Tue, Jul 02, 2024 at 05:09:35PM +0200, Krzysztof Kozlowski wrote:
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - sophgo,cv1800-thermal
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    description: The thermal sensor clock
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  accumulation-period:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description: Accumulation period for a sample
>>>> +    enum:
>>>> +      - 512
>>>> +      - 1024
>>>> +      - 2048
>>>> +      - 4096
>>>> +    default: 2048
>>>> +
>>>> +  chop-period:
>>
>> period in what sort of units? Sounds like time to me, so this would
>> require proper unit suffix.
> 
> In clock ticks.

Then please mention it in the property description.

> 
> When setting to 1024, a time of sample takes (1024 + 2 + 64) clock
> ticks. The clock runs at (25MHz / divider) and the divider is
> configurable.

> 
>>>
>>>> +    description: Period between samples. Should be greater than 524us.
>>>
>>> The constraint here should be "minimum: 524". What's the upper limit?
>>>
>>>> +    default: 1000000
>>>
>>> Rob/Krzysztof, could you comment on the suitability of the three custom
>>> properties here? I know if this was an IIO device, these kinds of things
>>> would be controllable from userspace, and not in the binding. I
>>> mentioned this on the previous version, but I'm not really sure if
>>> thermal devices are somehow different:
>>> https://lore.kernel.org/all/SEYPR01MB4221A739D0645EF0255336EBD7CE2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com/
>>>
>>
>> Why would different boards have different values here? Does it affect
>> accuracy? If so, how much?
>>
>> I doubt there are any boards with different values, thus it sounds like
>> unnecessary tuning parameter.
> 
> Theses values affect accuracy in a minor way (about 1 Celsius degree in
> my test) and could be shared between CV18xx/SG20xx SoCs as they have the
> same design.
> 
> In the first revision, fixed values are used, and I was asked to add
> support for all possible configuration[1]. Now I think this introduces
> extra unnecessary complexity and should be avoided, since this is a
> simple thermal sensor, tuning seems to be useless.
> 
> I suggest renaming "sample-cycle-us" to "sample-rate-hz" and dropping
> other parameters for simplicity.

Ack for me.

Best regards,
Krzysztof


