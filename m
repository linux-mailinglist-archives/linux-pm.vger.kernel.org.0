Return-Path: <linux-pm+bounces-35969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C094BD3209
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 15:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE2194EF154
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733662652B7;
	Mon, 13 Oct 2025 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZUXheY5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77803202F65
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760360457; cv=none; b=R16TqdGKnETdPs645Ebp1c5Wd7pRPc0poiEJ8hd8WKZZh8CXIiMOoAKjDq3nDQhNZSVnrQkmKK6P3XVxW3zDTkA5n9CqWOK5tM8vL+STDHKDmIU1WZIMwkTRq5yOJYbuI2qSBqppxWp4JQopadILuAPTzbTzo70nRGpp2RxAKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760360457; c=relaxed/simple;
	bh=i9iJGo0KJ+KjP0rOALL8y9Ze3unbPpntnRn8FZ5ZXLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGR8fQpVVgKJZx6OgyTr7j4gjrMGuMNG64ucDqWx13jRsaD6Wr23uiYWmDTZDZRnkMAJQ2m7AeSV5J2U+qPqYlNL9tCMYqDsuvruN5OnJ98kAzyRG6ob2rxHEqYToUzO+hH//JazqlTCxrJQh5QzlKzepiYpp4xxD/xKSzC35Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZUXheY5; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-373ac916b35so41004811fa.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 06:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760360454; x=1760965254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RwPM/Z5O0yHOLH9LwU+Zo7JSbbUS2MnSJ7z2h3tfSbk=;
        b=GZUXheY5g16g+NcrpryYGGM/s9f9xN6ZFJVkK1cKl9cIZ6S7zhv6f0U38d1PRNqfO+
         ihKAqQtBSRVcLRwwKK2L0iPgY16fracELTQznMg9Ws7AdgoJ8laNGfR0uOJEEjR6pbl+
         n2Xvbcd3tMv6p4RZQg13Iqun1nOiKfVtXxToMw5bRRxdYALFy4HVS3Z4qUDoKNnSsvMf
         O0SmaAdghKGRZDuV2vjT6XE6NDuoZDvoAsgSBtjGaIQuwHHMn+5BESZhG/nNqioqqSxf
         iBQW64XUDL0babWe/AjkiQWL9WYAVivQa+pyPFTJ7I/3ycdXV2nKxUFYdq9kzpf5Zytg
         JbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760360454; x=1760965254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwPM/Z5O0yHOLH9LwU+Zo7JSbbUS2MnSJ7z2h3tfSbk=;
        b=Mpd/azj1R16BoUu8BHqSZQAeI9c4L0MmzaPhVFCWDbcUoyp3W7TsjVi0chafetwuqS
         5NGiwT0lN4/X0n5TftOavL+cM4HIYR2HkwlehD98I4j/Hn7WUhaA8oOnlBFbmfNZXEsr
         n5gTO7GZVEUrxSnRtl+dRfoFMyQUBlm4MFa1cNVD1W0P/UENBFxiWCgQTZA1uowrtrO7
         fxUh7Y+R2QputFj2IisW+XJEOeeVEmCo7VsVK8EM4qL8x9uCvAzIoZpDT5bYCzKO6rAi
         z7uOlY3wFNy+4X9vS5z7nFhkad4eYnllqGnQZZF+ZhrUrsKPGfRZFks6kOmQNVYEM88P
         gjFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxRJ6kDUSfhdUJMoZj8HECTyc2gp03NuMrtzPCoSQcn1ItrVqoa2n+tt0Or/DBRfhEpMyqhRKFVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjCKb3Ri2l1TJV/dr6bF+cPQ+Ll84YgC05MPVhV4EJC4yWIQQP
	bvmmWqYa3UI2NUgYyVQMUbJ1ffz5hlLlmx2oCW0anR5pRmEUdk0GfuBC
X-Gm-Gg: ASbGncuFSl81g8/yjewcbXcQZZLrOCZIYNwkgq0K5pM0KxZQfa8N7P8W8+cvnlTlmRi
	QyF5/oFTCqyMwrGBEKA0Ayyg8h6uK76iGJebDdszU9dAzkSIZL/Netv+1pau8qOFZcv6tukBKrP
	gGhhSkaxh6GcBATE1o1Rl6v+FDI99yYXpjLi4Y7HnIhUh5NIKxw1c/Eg/4aOMzOq9ysKl2mN8Ly
	g4Y5q++9jYDVIcA4rPVLwFIHwqo8H8Bvi0CE96GNsSpmjqK9L2lfAQmoC1nPZT8sbs9mP9nTJjB
	qi5DQs1xTmuk2SyFNNUFNdkPOy+G7DxRwi/J+IbY5Q/10ME2Q6Ww7gvCrx7O7Fr+4dekXDebo8b
	FnRH+IfZ2k70WtqG7BXpGAdVs7l2s6yC+mUz7SlTRg3o9Vbf+1IxiK7ZW0YXz3nvmpIUTUIshMG
	DL60SGkFAjHNBYKU6ALQ+jxb+9lORW/fzM4g==
X-Google-Smtp-Source: AGHT+IEaz0DBFlUyV6gGttivlYi+polxLg5u2E3jx0S0U111cfv9lqTIiGXjrdbkq2K8MBx4IO/Dbg==
X-Received: by 2002:a2e:be27:0:b0:352:7dce:2e15 with SMTP id 38308e7fff4ca-375f50b8a2dmr76806371fa.5.1760360453227;
        Mon, 13 Oct 2025 06:00:53 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762eb6a98esm31283941fa.59.2025.10.13.06.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 06:00:52 -0700 (PDT)
Message-ID: <f2e6f0eb-b412-4cf6-8615-d669b8066393@gmail.com>
Date: Mon, 13 Oct 2025 16:00:50 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/13] dt-bindings: power: supply: BD72720 managed
 battery
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andreas Kemnade <andreas@kemnade.info>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <cover.1759824376.git.mazziesaccount@gmail.com>
 <19d537f9920cae5fa849b649e5bc42ba0b8e52f8.1759824376.git.mazziesaccount@gmail.com>
 <CACRpkdbHBQQnnTUrUzOrYxzQKCzDyy8aNK7w8OEFz-ic8ic1FQ@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CACRpkdbHBQQnnTUrUzOrYxzQKCzDyy8aNK7w8OEFz-ic8ic1FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/10/2025 15:45, Linus Walleij wrote:
> Hi Matti,
> 
> thanks for your patch!
> 
> On Tue, Oct 7, 2025 at 10:33 AM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
> 
>> The BD72720 PMIC has a battery charger + coulomb counter block. These
>> can be used to manage charging of a lithium-ion battery and to do fuel
>> gauging.
>>
>> ROHM has developed a so called "zero-correction" -algotihm to improve
> 
> algorithm?

Indeed :)

> 
>> the fuel-gauging accuracy close to the point where battery is depleted.
>> This relies on battery specific "VDR" tables, which are measured from
>> the battery, and which describe the voltage drop rate. More thorough
>> explanation about the "zero correction" and "VDR" parameters is here:
>> https://lore.kernel.org/all/676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeurope.com/
>>
>> Document the VDR zero-correction specific battery properties used by the
>> BD72720 and some other ROHM chargers.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
>> The parameters are describing the battery voltage drop rates - so they
>> are properties of the battery, not the charger. Thus they do not belong
>> in the charger node.
> 
> Right!
> 
>> The right place for them is the battery node, which is described by the
>> generic "battery.yaml". I was not comfortable with adding these
>> properties to the generic battery.yaml because they are:
>>    - Meaningful only for those charger drivers which have the VDR
>>      algorithm implemented. (And even though the algorithm is not charger
>>      specific, AFAICS, it is currently only used by some ROHM PMIC
>>      drivers).
>>    - Technique of measuring the VDR tables for a battery is not widely
>>      known. AFAICS, only folks at ROHM are measuring those for some
>>      customer products. We do have those tables available for some of the
>>      products though (Kobo?).
> 
> It would be sad if we later on have to convert it to a standard property
> because it turns out to be wider used than we know.
> 
> But I buy your reasoning!
> 
>> +properties:
>> +  rohm,voltage-vdr-thresh-microvolt:
>> +    description: Threshold for starting the VDR correction
>> +
>> +  rohm,volt-drop-soc:
>> +    description: Table of capacity values matching the values in VDR tables.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> 
> Which unit is this? Seems to be capacity in % *10?

Ah, right. Should've documented this! Thanks.

>> +  rohm,volt-drop-high-temp-microvolt:
>> +    description: VDR table for high temperature
>> +
>> +  rohm,volt-drop-normal-temp-microvolt:
>> +    description: VDR table for normal temperature
>> +
>> +  rohm,volt-drop-low-temp-microvolt:
>> +    description: VDR table for low temperature
>> +
>> +  rohm,volt-drop-very-low-temp-microvolt:
>> +    description: VDR table for very low temperature
> 
> Doesn't the four last properties require to be defined as uint32-array?

I have been under impression that the "-microvolt" ending suffices, but 
I may be wrong. At last the 'make dt_binding_check' didn't give me a shout.

> 
>> +        rohm,volt-drop-soc = <1000 1000 950 900 850 800 750 700 650 600 550 500
>> +          450 400 350 300 250 200 150 100 50 00 (-50)>;
> 
> This one makes a lot of sense.
> 
>> +        rohm,volt-drop-high-temp-microvolt =  <100 100 102 104 106 109 114 124
>> +          117 107 107 109 112 116 117 108 109 109 108 109 122 126 130>;
>> +
>> +        rohm,volt-drop-normal-temp-microvolt = <100 100 102 105 98 100 105 102
>> +          101 99 98 100 103 105 109 117 111 109 110 114 128 141 154>;
>> +
>> +        rohm,volt-drop-low-temp-microvolt = <100 100 98 107 112 114 118 118 112
>> +          108 108 110 111 113 117 123 131 144 157 181 220 283 399>;
>> +
>> +        rohm,volt-drop-very-low-temp-microvolt = <86 86 105 109 114 110 115 115
>> +          110 108 110 112 114 118 124 134 136 160 177 201 241 322 403>;
> 
> I would have expected something like this, to avoid the a bit fuzzy definitions
> of high, normal, low and very low temperature either:
> 
> Provide an array of temperatures in millicentigrades (I just guessed
> these temperatures, you will know the real ones!):
> 
> rohm,vold-drop-temperatures-millicelsius = <500, 250, 100, (-50)>;
> rohm,volt-drop-microvolt-0 = <...>;
> rohm,volt-drop-microvolt-1 = <...>;
> rohm,volt-drop-microvolt-2 = <...>;
> rohm,volt-drop-microvolt-3 = <...>;
> 
> Where each array correspond to the temperature, or if you wanna
> go all-out custom:
> 
> rohm,volt-drop-50-celsius-microvolt = <...>;
> (...)
> 
> So we get the actual temperature in there one way or the other.

I agree. This is a good idea. I'll try one of these :)

> 
>> +        rohm,voltage-vdr-thresh-microvolt = <4150000>;
> 
> This property seems to be missing from the bindings?

I think it is the first binding in the file :)

Yours,
	-- Matti


