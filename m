Return-Path: <linux-pm+bounces-39919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0496BCDD04C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 20:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F1803011EC2
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 19:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E05A33A031;
	Wed, 24 Dec 2025 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jt48wwVz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931CE30BBBB
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766603264; cv=none; b=QMoB3WcVoCXGVstIq6fj/h8fXiUeFLaSeEfGEd6AZGLJYK1+VCsmJWtA4lKRfl32D5+fl3PZfGpA/QkpJBXmDo380nvsLD9IgB3hVrF26iKDx35yPADbf39DeGEqvwd/yFz9leR5PWs7VWvSU+3zrhOlqTyT1GqODB0gz7Fi2kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766603264; c=relaxed/simple;
	bh=xGMey4A7iFVHAmrVZuSavckmgLulJhGs63Zh3metjjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAAGnT2VHMypMYEmw/AiL8B2QvNiQZpbuCfvwlVYG5Nk8wDQAFHQIoiKJzVhRSbXGvA9tOEtopx4BshjsBbHBAtq2AO5GMb0twcAkNacpjU63gAwA9qJXkZ2qIeWPziT3jbe66G485Qxy0fsvyr1abd4Lv3TOol20yUb8O5kHsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jt48wwVz; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-642fcb38f35so4994022d50.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 11:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766603261; x=1767208061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NzIVnDZpOLjchy2wgbEcpJaoavN6zFZmqhSGhoRwcq0=;
        b=jt48wwVzAY30EJsCgsBi7TrUZHYIH4B7dENfIKwBOgf+orFGCMZ9TbGni6VSrbHmdI
         LPK3rS9lwcDDXS6PnM9tsNqrFgZ7p2KuWtrjQMcqMm//eCk9BKnUomcvLXovIP2xunU2
         B6SbxvRopOesHK+AkV3hoIJG//jR3l+5+m301qKjGd44VvSJfsthjTX2uhcGj/bSFdIv
         /RNSYyo8UUlEjlTDCeM13EDgRLXa1Am1Xyvy1AR6PHvQqG9BJn9aCjzvQPJrv6iWzFDk
         EGY1aznIp1KannV8iZph+snCe15e2bn28pj/gkm5t81hhSPQDlAsc8A5HMnv1mP/5xq9
         uSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766603261; x=1767208061;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzIVnDZpOLjchy2wgbEcpJaoavN6zFZmqhSGhoRwcq0=;
        b=S/gbl6/1030w1byPY6mXUUfRJ2/CSA2vZyCkErkxkU3pGeT4axCKg/8eQMCV204A3d
         GWK/Y7e5LRbhWldxMlzzktoLgqKdAmBF4g3a2IblLkfavK0vHJPJGDiGSf5ABub4BnxE
         taiqxe9FcGv7kToAjVgLEp6pRBUXVT6KOumOkcxpHVUnjXBePDgLNNSl9b1B2gUZHs6L
         9xaLJsd1qaifxfapqEIXkufI+EEcBG2YBBDJKZ7bHVjW0qEamMH2PyQbAA4GslKBXTB0
         46QX1ZbV0biXMvSc60wSDc8xEmBzHf60FwQnFaOIK8bUBEvHjNipukwH6Br+RTY8zD4F
         o0nw==
X-Forwarded-Encrypted: i=1; AJvYcCXEfFZPyXnG/fy5aGJJTlWOpoBTC6MhVETbiZcZXRo+dV0DxmacN5aidpfyqN3TM7qgFqwuGB4RiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsy5KVFIKVTvXr5OVJlNFx7dpOhndLTjKBilfzLee+fqEN6G9u
	bVcnSaFxh43oOzj529HkxxFz1NyrxMCXh89USzOpQ+XixLKJtLFVZNqUkcldi8M6pw==
X-Gm-Gg: AY/fxX4nwvub/YaY1WxZittep58taHYN1cL/VW9ucugvf2oh21RyZvRHmALdMAcLQFE
	WSh3jeEI8oo9+bjQBlmQ4/MVVPPPLVaFqI9HhUxaMZqFKARS7X+10VSKVUorJ/B8l/OWtnaSa/H
	yaaQBn+NPX0ejI8wA1PCRZ6WObKcECQqyn1WaR5IllWpdqY2TD5fVCEkLYQuO7EW3+oP6lum4HE
	2HLkYZ5gibPqCa7j2NL4XNqVwbW2FrOuDQE2WcCZHL+9QayeFv2CAKY1EtgAbqXJbYrOwtQX/bM
	XD3H21VuSQwvuprNgLUQ5soRmEUB7dPkTUHlvnU8tqR0DgmTCVUUNDgqVHhSUIoxgr5WGQB1UxB
	yXy7qiyjEZezwoEYGr4G7fsWScdYptwO1JB7zDqANfpG3sw1H46cgxQuYuwktTd6jSEH66sLE4x
	yseuRr5BnnkriFA7zhhEzifzIeYuVPWvH7vLzZ0gFHyaFgjhACuu5bzlNSoeE=
X-Google-Smtp-Source: AGHT+IEY4Bkjt/yYbrhofiHe25t6FYtL51Cgg0/pcmheFBExP5e5Z7qmADlL5vL1uqS/fVBKeLgjpg==
X-Received: by 2002:a53:bdc5:0:b0:63f:2bc7:7074 with SMTP id 956f58d0204a3-6466a8aba62mr11525267d50.60.1766603261316;
        Wed, 24 Dec 2025 11:07:41 -0800 (PST)
Received: from ?IPV6:2600:1700:4570:89a0:6872:f79a:c2ff:4f4f? ([2600:1700:4570:89a0:6872:f79a:c2ff:4f4f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a8b16e2sm8621687d50.2.2025.12.24.11.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 11:07:40 -0800 (PST)
Message-ID: <c3599851-6e19-4ed9-9ce7-703746b978e7@google.com>
Date: Wed, 24 Dec 2025 11:07:38 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: mfd: maxim,max77759: add charger
 child node
To: Krzysztof Kozlowski <krzk@kernel.org>, Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Lee Jones <lee@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
References: <20251218-max77759-charger-v2-0-2b259980a686@google.com>
 <20251218-max77759-charger-v2-1-2b259980a686@google.com>
 <411802b6-517d-497e-bf7b-183e6e6d7a64@kernel.org>
From: Amit Sunil Dhamne <amitsd@google.com>
Content-Language: en-US
In-Reply-To: <411802b6-517d-497e-bf7b-183e6e6d7a64@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 12/19/25 12:17 AM, Krzysztof Kozlowski wrote:
> On 18/12/2025 23:49, Amit Sunil Dhamne via B4 Relay wrote:
>> From: Amit Sunil Dhamne <amitsd@google.com>
>>
>> The Maxim MAX77759 MFD includes a charger function. Extend the max77759
>> binding to include the charger. Also, update the example to include
>> charger.
>>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> ---
>>  .../devicetree/bindings/mfd/maxim,max77759.yaml    | 33 ++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
>> index 525de9ab3c2b..1cffdf2e5776 100644
>> --- a/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
>> @@ -37,6 +37,30 @@ properties:
>>    nvmem-0:
>>      $ref: /schemas/nvmem/maxim,max77759-nvmem.yaml
>>  
>> +  charger:
>> +    type: object
>> +    description: This is a dual input switch mode battery charger for portable
>> +      applications. It supports wired and wireless charging and can operate in
>> +      buck and boost mode.
>> +
>
> I do not see any improvements, so same comment: this should be folded
> into the parent.

I misunderstood the folding comment for merging the charger binding into
mfd.


> Please read DTS 101 slides or writing bindings or any other talks...

This gives a lot more context. Thanks for the pointer. I also reviewed a
few recently merged mfd (with charger being a cell) patches as well.

I realize that you're asking me to remove the charger node and re-anchor
its properties to the pmic mfd device. I will update it in the next
revision.


BR,

Amit

>
> Best regards,
> Krzysztof

