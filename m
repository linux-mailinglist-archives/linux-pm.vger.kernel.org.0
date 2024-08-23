Return-Path: <linux-pm+bounces-12838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A0A95D344
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 18:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A47B1F22D7D
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A2B18BB80;
	Fri, 23 Aug 2024 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="VFlzcOjW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A018A6C7
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430410; cv=none; b=S1ptmv5zriM9I+wpskD83bf5ovjd2+uB+SEcJN/JmNz+CiF5+3NSRQ3rpOm2YMpSMC93LBjuiDgwNtJyAm4ax/57Iq2hND2ZzvflNCq4IWT23dxX/UTC9wdarJUWcBgPHL0REX98inGJVpd1GHEl8bi+8MkN8GHb0upQogNj7ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430410; c=relaxed/simple;
	bh=n8ZGaQpMVmAooqMlUbx9CPaYIP1qo2CpAVV9NzwgAek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KK5H6bzTi8+2RChz445nKTH7m8cLMGaGrAcOtkT+x0oSCwWyRRX74l+1Qb0PGGZShJfMUReHfba507mlP9Kzo7kLj64E2odeyDOH1+k3uUq4c2ZVhB3SFQl9HqXovO5Wep+hObsbU0KYez6GPV3Kj9+b55JhddKFiVFf1L/f4wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=VFlzcOjW; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f3f90295a9so23036511fa.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 09:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724430406; x=1725035206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZWSBeG+QwbjFSDvLyDhLEv05keKw5jJM6jqldDdTU5o=;
        b=VFlzcOjW/uHGZCpOk3JJ34p935zH3b2AIvvKPRkHSI7LdThpBMwcNTibmN5DZfbT8P
         hzWewDPMl0EyQ9Fv71GKcYcm7OS/NPJSWh8e4AdosCPvnjJcQOzWPju+338y/1bLKMJe
         MI17+LzIVUDt2SaKDr/Fz1+mBoauwVhaUj9mMxMw8umSV7ms0FkjScPGFcN/fWj2YoRo
         H0WnD+i8t9oIWBTae44omGcdAv+YPjiV77LRPIHTRZVjsVabOk4Qoo59x86EVoOpxvkv
         Tsj6ak3a/+oehUefI9xcoLdf9ENb+K+YeG5b/0NFLsIH97vS4bhCHJcljBPH/hzr5ufC
         VZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724430406; x=1725035206;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWSBeG+QwbjFSDvLyDhLEv05keKw5jJM6jqldDdTU5o=;
        b=QfTXCCsm3n46DT3Jff4NH6yeUTQPi97uKo5r2POBGOP7KCFW0qzudBBE71MHDz27QC
         6dZpSzK7vaLxHlAisvXI/a3EtRXnD+tcmBmCmXvddVZy+D61zjSQvQ2OeuJkQvgyM6WC
         02dCS2I8dIBBJXAvZLqVLCokfNrNPrODBxwUqnRNiGqXUC0Ri0yeP0a0fZeN+BBD5If8
         Em/E4NUY2cAaWZnu/Z+3ipT2PgHqvbbaaKW20Oqvf+ivTf+1YBnrT/UDX+Ur62o7NefA
         0r2lXDiwlP6uZ/hoatMKYkMip73Cpt2Ih5IaMqXMFl+p+7hcKCO8wWuNvvVr8ilI4EHW
         8I6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXExpPB5DmQwwPqqZiQrRV9OmyyChh8vGXp6ieoxTSWkGlBmEpQIL1X0nQGGUeuU5AmLG3SzeVSEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzA0d4yNB3Lgrt3+VDwbbqVppQTEAYMBaxfDdgnN0Ospn0SzNS7
	sDk6cv87CB3q+lmbBxPT4l/O4k/SX0uOh30lgZWdjTnv6F+dBZiDtBZYo83kgRg=
X-Google-Smtp-Source: AGHT+IGq9Z87mcKzdsOfA4Kh7hIWO8zyssaqdNEEpmiVif++gK9Zdc/x8LpKsPD+5iPCumWhJubVcQ==
X-Received: by 2002:a2e:9996:0:b0:2f2:9a2e:c257 with SMTP id 38308e7fff4ca-2f4f4941e50mr16465901fa.41.1724430405344;
        Fri, 23 Aug 2024 09:26:45 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3ea610sm2309974a12.51.2024.08.23.09.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 09:26:44 -0700 (PDT)
Message-ID: <5eae2ddb-2a7b-4c1d-a7f7-41fb39058de1@tuxon.dev>
Date: Fri, 23 Aug 2024 19:26:42 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] dt-bindings: soc: renesas: renesas,rzg2l-sysc: Add
 #reset-cells for RZ/G3S
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be,
 magnus.damm@gmail.com, gregkh@linuxfoundation.org, mturquette@baylibre.com,
 sboyd@kernel.org, yoshihiro.shimoda.uh@renesas.com,
 biju.das.jz@bp.renesas.com, ulf.hansson@linaro.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-3-claudiu.beznea.uj@bp.renesas.com>
 <20240822-vanilla-enigmatic-f0b05ecca4b6@spud>
 <0d8b1322-cf15-4ed9-b958-06516bbb64c7@tuxon.dev>
 <20240823-plywood-unfixed-d8d8a2d93f14@spud>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240823-plywood-unfixed-d8d8a2d93f14@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23.08.2024 19:18, Conor Dooley wrote:
> On Fri, Aug 23, 2024 at 10:54:06AM +0300, claudiu beznea wrote:
>> Hi, Conor,
>>
>> On 22.08.2024 19:42, Conor Dooley wrote:
>>> On Thu, Aug 22, 2024 at 06:27:47PM +0300, Claudiu wrote:
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> The RZ/G3S System controller has registers to control signals that need
>>>> to be de-asserted/asserted before/after different SoC areas are power
>>>> on/off. This signals are implemented as reset signals. For this document
>>>> the #reset-cells property.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>> ---
>>>>  .../bindings/soc/renesas/renesas,rzg2l-sysc.yaml | 16 ++++++++++++++++
>>>>  1 file changed, 16 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
>>>> index 4386b2c3fa4d..6b0bb34485d9 100644
>>>> --- a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
>>>> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
>>>> @@ -42,12 +42,28 @@ properties:
>>>>        - const: cm33stbyr_int
>>>>        - const: ca55_deny
>>>>  
>>>> +  "#reset-cells":
>>>> +    const: 1
>>>> +
>>>>  required:
>>>>    - compatible
>>>>    - reg
>>>>  
>>>>  additionalProperties: false
>>>>  
>>>> +allOf:
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            const: renesas,r9a08g045-sysc
>>>> +    then:
>>>> +      required:
>>>> +        - "#reset-cells"
>>>
>>> Given this is new required property on an existing platform, I'd expect
>>> some mention of why it used to be okay to not have this but is now
>>> required. Did firmware or a bootloader stage take things out of reset?
>>
>> On previous SoCs the SYS controller has no support for controlling the
>> signals going to different peripherals (USB, PCIE in case of RZ/G3S).
>> I'll add a note about this on next version.
> 
> My initial thought here wasn't about previous SoCs though, it was
> because you didn't add the compatible in this series for /this/ SoC.

RZ/G3S compatible is already present in this file:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml#n26

Thank you,
Claudiu Beznea

> What's worth noting isn't about the prior SoCs, it is about what makes
> it okay for this one.

