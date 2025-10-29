Return-Path: <linux-pm+bounces-37010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2712BC1874C
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 07:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCAA1C26070
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 06:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104F4305948;
	Wed, 29 Oct 2025 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmPWOHLN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D29230170D
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 06:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718974; cv=none; b=qRwHRN0TKdo+Ea0XlV682w2aVvqpQIddYGVUpaLZlCIC4Ti21PoSAsFdRApQCWLPQm3ZfiDVjsjLWLN7czq6bQ0QeNnu1NSEXcRHJuv5yA48Sm4cIO2vwYe0PHZe5mx1DezZ0XbCX9RH4qnEihY82v5K5HRTLi/ahX4kbs9M2aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718974; c=relaxed/simple;
	bh=4O+7pwhIGGS1RUIpdH+/fPlWfKqvKw0rWPYTnh4gGvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHomJPmbeL7PF9lzNRCyCI4PSXOfI35ZTBF/LV6hFlFuZZLdq6l5FnyduByigH9MnofLHMR22jDiDQU9BXQZfpvz+2EZJKuLEJLK01K50VJPvhzbwkg0w+P7CinAOdF8ZNpeGluzBBtTUZBl9V3lVDwSjVB3jpqEtDW2W2x1PeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmPWOHLN; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-378cfd75fb0so72807001fa.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 23:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761718969; x=1762323769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VW27OesVv2Xc3xIV1cd4ruvQQ3oOkSUpb7LoylGMQM=;
        b=RmPWOHLN/k1SZE1C1pzZaUFRLoYJ/eZhIZUMYc49u01SncpgT8mOtQNsL2gQDEedfo
         5CpJnOpxZBO7380lAf+Ol3agJ06sFj6TWqJGxuwGZdZmJsQVcoVByeVKGGcxwbo8uVZX
         crZ4jmXLSkmGIDznrxFbm0jGmEghzPr/XI4jUmW+ncHaO6lbdFpexiOy7GnQ0Ne1uGko
         9RhRxUshJQGhSe7JVXD0YRz16Gd7N5SQU6rrhSm7Eaoj4I7aABKqlmQUu5IeQbJrFpPD
         kXyO7yX2Q7KFZm1ljoQFqLkr7O6kwkJNOasXDZHPJp7nt3tftK9IegqVacOecORCL9rx
         Ogmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761718969; x=1762323769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0VW27OesVv2Xc3xIV1cd4ruvQQ3oOkSUpb7LoylGMQM=;
        b=sbSyf23NURLRPlBdA+bj+vuHDu/QbHEumkxHEGO9JC2E+9j0Di2gGGjFAxzPtQOTVQ
         TXBOmPfG0sQK81HSZYxbC2LPRigtDYjEak1GVjh7L+OXN4xuPSf1VP3Lv+ZkX+xnHvHJ
         EddfQEqyFqNKyt+1Bv8zZ0cDCcdlJzyUvLunc1y2SoqdIyvtFVxqGGGmrHL5UiLBeiRe
         g3f15IxUIW/n+qOeFEiidqlyFjgrXx2x8UDtmrVhkPpOjJn3g+6+x9Qa1ZdNvFOcptEF
         v9Ia98ymTIrF1/297tAVwDmwTA8Z3BNW3bfRSruxb3nm+3yfM9XA85neElqQc6pgU3Yv
         R6GQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5fX69YibgjKH7P0+mIm7JaDvkYtD3nhcVRb01BzLWZnl+bRxoOaCbRu7FWpBCXCiTJhDelZfckw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwLulobsZNjhSG8aYPe5aMb99jVBEvw/CsDOTWgrSJe8cGAMmN
	WjCwj/WKTGTeyf1JFyohTAE+FVWMeunURLTdKMH0ACtP0nzCQYBllG+P
X-Gm-Gg: ASbGncuwpeL+YSMfH2qWe5BzksZ0YGVSW3dKEWtlXS+wReCEYi9bDMG5IfKbIIRYy77
	3vwNboZAl4OKPprSZKaUmPZLw00Az9iQ+KurFbH9u6fbtb+Hr5OeYU08avF58PGZhEkPES+/Flz
	XGTpzNkR8pllyg6Ldk3b6mvOZ921mkRyv/JZnpzu2Kpvp0RPS6Dq+ywawGZ0dFjrZa3nMmt2QaS
	hoOTsshknjfZo13j78NipRgvOlIRu0I4BIrXeQo+qlk5ESbFYXFVcxMnhED1Q2/X13fCJhCz6c3
	Dgpesh9jE0u2UTGD7u47Us02F/DVfLV38bEfGGsGnfSNgLuCu9JWsJ7h8ILBrXbEgPWHo3A4B6p
	gtraLr3EmfRpwqlQ5cVHb6nX3ufxjb6F0jL9shYC07gsP3mKfek3R/NvwV8Ne0GKkiMFXp6ozf6
	fH3t8hRQ1M6QQkBdSVBI/K0ShPSb11RHwtXlIryoDH8FxXlCxw0fn5qncFWQ==
X-Google-Smtp-Source: AGHT+IGanoJgPw6WF2DjE1gIdmQz7mXfEW+doSVsuxKGJlYO+QYEE07542eS5+8tipXltZ0hgrDYBA==
X-Received: by 2002:a05:6512:3a8b:b0:591:ce58:1def with SMTP id 2adb3069b0e04-5941286524emr697925e87.2.1761718968884;
        Tue, 28 Oct 2025 23:22:48 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-593041884c9sm3239104e87.96.2025.10.28.23.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 23:22:47 -0700 (PDT)
Message-ID: <a81fba66-adf0-440f-96e1-bf3a83d504d8@gmail.com>
Date: Wed, 29 Oct 2025 08:22:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] dt-bindings: Add trickle-charge upper limit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andreas Kemnade <andreas@kemnade.info>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org
References: <cover.1761564043.git.mazziesaccount@gmail.com>
 <b13b733e7e0fba05652f49f727412fed9e0ceb02.1761564043.git.mazziesaccount@gmail.com>
 <20251029-adamant-mamba-of-patience-cddb65@kuoka>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251029-adamant-mamba-of-patience-cddb65@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2025 08:03, Krzysztof Kozlowski wrote:
> On Mon, Oct 27, 2025 at 01:45:05PM +0200, Matti Vaittinen wrote:
>> Some of the chargers for lithium-ion batteries use a trickle-charging as
>> a first charging phase for very empty batteries, to "wake-up" the battery.
> 
> In the few cases I was dealing with charging circuits, trickle charging
> was used in context of top-off charging, so when battery is 100%. It's
> also documented at Wiki like that:
> https://en.wikipedia.org/wiki/Trickle_charging
> 
>> Trickle-charging is a low current, constant current phase. After the
>> voltage of the very empty battery has reached an upper limit for
>> trickle charging, the pre-charge phase is started with a higher current.
>>
>> Allow defining the upper limit for trickle charging voltage, after which
>> the charging should be changed to the pre-charging.


> pre-charging is the trickle charging, no? Or you want to say that
> trickle-charging is pre-pre-charging? But then what is pre-charging in
> this binding?

There are the (usual?) pre-charging and fast-charging phases in the Rohm 
devices. Furthermore, the fast-charging is divided to constant current 
and constant voltage phases.

In addition to this, there is a 'trickle-charging' -phase for a very 
empty battery. This is already reflected by existing bindings:
trickle-charge-current-microamp, Please, see:
bbcecd1b9335 ("dt-bindings: Add trickle-charge upper limit")

I also did do some ASCII art for my very first charger driver binding:
https://elixir.bootlin.com/linux/v6.18-rc1/source/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml

Do you think a comment linking to this drawing would help?

> 
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> ---
>> Revision history:
>>   RFCv1 =>:
>>   - No changes
>> ---
>>   Documentation/devicetree/bindings/power/supply/battery.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/Documentation/devicetree/bindings/power/supply/battery.yaml
>> index 491488e7b970..66bed24b3dee 100644
>> --- a/Documentation/devicetree/bindings/power/supply/battery.yaml
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
>> @@ -66,6 +66,9 @@ properties:
>>     trickle-charge-current-microamp:
>>       description: current for trickle-charge phase
>>   
>> +  tricklecharge-upper-limit-microvolt:
> 
> Please keep existing format, look three lines above. trickle-charge-....
> 
> But I believe this is wrong. Trickle charging does not switch to
> anything more, there is no fast charging after trickle. You have some
> sort of pre-pre-charging, which is just pre-charging.

There is trickle, pre and fast-charge phases. Furthermore, the 
fast-charge is further divided to CC and CV. Finally, if my memory 
serves me well, Linus W did explain me that some chargers use 
'trickle-charging' as a _last_ charging phase for a full battery. Thus 
the term 'trickle-charging' is slightly confusing - but it is already 
used by the existing bindings...

https://lore.kernel.org/all/20211116001755.2132036-1-linus.walleij@linaro.org/


Yours,
	-- Matti

