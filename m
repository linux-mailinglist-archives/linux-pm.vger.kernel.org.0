Return-Path: <linux-pm+bounces-41099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5933D3A952
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 13:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80CD4304DE04
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 12:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C6335CBDA;
	Mon, 19 Jan 2026 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BtWO1BDm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB6309EFA
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768826713; cv=none; b=jooU7tCcX37CuhMCszejkGa+pP9K6fDsZpIh5rdstFXbT364Gq8E35z2qMoigL1rgztuf9/rET6MhjjqTgSN5eMJLELHgriO0ctGb5S0gKzMIzUoJFgkvjFu4H+jkMlb0pMs3GWctD1ZAS49IjGzVo3119K+BFCZDr/4dvo6YbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768826713; c=relaxed/simple;
	bh=58zqf0QRhFos7cRmq8vTrHcguHAy4GxQXQGtoEUAomg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4pQk/OMe3/CcFxFgOCEDpTzfYqNTowcvQGjvoKBo8YH07o919C2l40tcwd9RcKjILB4bhNV2aO+ki7NlFfU69hjo8uuppLwa1La/tIPdBGN4QxnoqJOj6wgpgCYVRVkqbotYqnDmOhC5SHVqnnOI7cmxA1d0NlwkGy1xy0VG88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BtWO1BDm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so37674355e9.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 04:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768826710; x=1769431510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGK/JHtGxCZWFp0R8SxdcXdTEhWhNtsWilx8eiq1+lY=;
        b=BtWO1BDmiVo2a+LE6cgUTsZ8jaxNUH9MtBX8uJ1u8xKxB38JPizBLil9z4kOjX+B57
         wr4BaAuKf7MirYS275jTJPtH27QPbiXjHk4xAFZx/bY0HuKYE5oXctZXiW45y02/Hdwp
         xSMBZcMaGe0a8bmC7B4nLLEZFVKX7L1SIuvTcXvZ1gfzyT/iIIDTh4g7iZnNOw0/HmcQ
         f1TMHoR//S+BUUJ/uWNvG2Ay1vLfHYYcVeXf2MvTJ8z1QixnebAPMdyACfuAu9FglG2R
         DQDiGe/rSLVXnlNYjtHElIVTYzuhqQaUxv1pxlXwPrEnWlPoP83GJmNCRVqeWprxu79k
         wNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768826710; x=1769431510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGK/JHtGxCZWFp0R8SxdcXdTEhWhNtsWilx8eiq1+lY=;
        b=SIpGKoWWH+ocFEt4iV0QUqwjNg097Q/53VWI97B1CY5k/f7WuTxuPCj1QHNz2cNq6V
         rt906FlBd185gcvt4W3mSqdCCX7ecpGqSKK79w4P+XJStxuQeXi3vn1OkLdN8R+ltMED
         YV6W+Oxje6sB87fDKKxkp5L70eOGsTUFnU7vUmW3jL6oNawLfCY/0V4ky7MPRXDn1eC6
         oAKz7xCHj3+O7yriIUvFweP4+2UAFKGhbfjNYjMPOhVbDd6kL90RBSIyJhJxRBFu1NjJ
         B6ifFofuwnZnokOqyB6ZiW97idLr2siALPkLbvdxT2QY9HKFtWitPSEZqxer3w78U3uw
         S27A==
X-Forwarded-Encrypted: i=1; AJvYcCVkjsoLJM6hPEJg0BkdwVHPEZiAs3C1TI8EHieQiY+Ww0tTyWo65jIKz6CHZHJpDZJJmWfoTY+5Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zysuGSQbn4zYZHg9F0X+1wGLThYnbNjNr+7RWpziqwv0X/06
	8HAIKLj6gZzvVGkOdwkOQRPW9WwB4BYt/g6RzL5oW4HqBufdZDG8DUhSru2BR7x0VcQ=
X-Gm-Gg: AY/fxX4iOtslA06IyftcGnttPsJuWBc5JnckV774NUQEwB71TB4Kz5p6KEzpluMgkzH
	2ask4iMi/VUIbtRwSyKY/+GbGraFZieb8emRRZ8HZ6yMpdC+nCJ6/hvALSTypLs1Y+GyvcW2p1N
	TAsxmVE2UkdSeKKz7q2h88LBAHgZqUms/Q17SfCORjlv1y6tC9RUV4iv2HLI6aoGCjr2xKaIYUF
	MKBT5vco1IDImUhyzo0KpDeO4B3yBX3CN2tBiNYVvxbketyGm/ccWQcqDMbbg4I9n72JiOT+GtR
	d10rHgnmCNSfL3y25M1iHGyuwsPBM7B2/mJF960Iisc/iKULk7Xo9S9a2GLF2eTEmqAgm3/bCPT
	nxD1uOc6MZj/X42kuEVhnXB0aMrtrjmS4x4dPrJWz0PVeZSpBk3rgXHvhFeLWcRwUT0u6kx08Pe
	Pxsv6yii70J9V/wVy96XoISsSnAndja7fRdA==
X-Received: by 2002:a05:600c:6098:b0:480:3a72:5238 with SMTP id 5b1f17b1804b1-4803a7253d1mr13426025e9.30.1768826710239;
        Mon, 19 Jan 2026 04:45:10 -0800 (PST)
Received: from [10.255.242.87] ([109.166.183.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c197sm193288675e9.1.2026.01.19.04.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 04:45:09 -0800 (PST)
Message-ID: <10cb51ae-9cec-49a9-96c4-757cd1410d8a@linaro.org>
Date: Mon, 19 Jan 2026 14:45:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] dt-bindings: thermal: Add Google GS101 TMU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, willmcvicker@google.com,
 jyescas@google.com, shin.son@samsung.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
 <20260114-acpm-tmu-v1-1-cfe56d93e90f@linaro.org>
 <20260115-ultramarine-wildebeest-of-completion-ea1bc0@quoll>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260115-ultramarine-wildebeest-of-completion-ea1bc0@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/15/26 3:32 PM, Krzysztof Kozlowski wrote:
> On Wed, Jan 14, 2026 at 02:16:29PM +0000, Tudor Ambarus wrote:
>> Add device tree bindings for the Google GS101 Thermal Management Unit
>> (TMU).
>>
>> The GS101 TMU is a hybrid thermal solution:
>> 1. Configuration (thresholds, hysteresis) is handled via the Alive
>>    Clock and Power Manager (ACPM) firmware protocol.
>> 2. Interrupt handling is handled by the kernel via direct register
>>    access.
>>
>> This binding documents the required resources, including the APB clock
>> for register access and the phandle to the associated syscon node.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  .../bindings/thermal/google,gs101-tmu-top.yaml     | 64 ++++++++++++++++++++++
>>  1 file changed, 64 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..ecf4a315ecf1ea0649c4e96a207d531c696282f4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
>> @@ -0,0 +1,64 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/thermal/google,gs101-tmu-top.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Google GS101 Thermal Management Unit (TMU)
>> +
>> +maintainers:
>> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
>> +
>> +description: |
>> +  The Google GS101 TMU is a thermal sensor block managed via the ACPM
>> +  (Active Core Power Management) firmware. While the firmware handles
>> +  the thermal algorithm and thresholds, the kernel requires direct
>> +  access to the interrupt pending registers via a syscon interface to
>> +  acknowledge and clear thermal interrupts.
>> +
>> +properties:
>> +  compatible:
>> +    const: google,gs101-tmu-top
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: |
>> +      Phandle to the APB peripheral clock (PCLK) required to access
>> +      the TMU registers.
> 
> Drop all the redundancies, so:
> items:
>  - description: APB peripheral clock (PCLK) for TMU register access
> 

ack
> 
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +    description: |
>> +      The combined thermal interrupt signal (Level High).
> 
> Drop description
> 

ack

>> +
>> +  syscon:
> 
> I feel like suddenly you sent something completely different than what
> have you been working for the past 4 years.
> 
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: |
>> +      Phandle to the device node representing the TMU System Controller
>> +      (compatible with "google,gs101-tmu-syscon"). This node provides the
>> +      regmap for INTPEND and INTCLEAR registers.
>> +
>> +  "#thermal-sensor-cells":
>> +    const: 1
>> +
> 
> No supply?

It seems not. Nothing specified downstream. Couldn't find anything in the
schematics that I have either.

I addressed the rest of the feedback in v2.

Thanks,
ta

