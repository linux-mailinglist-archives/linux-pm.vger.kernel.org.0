Return-Path: <linux-pm+bounces-32493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A16B299C3
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 08:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDBB189EA1A
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 06:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253E9275105;
	Mon, 18 Aug 2025 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRGdX3gS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385942741CD;
	Mon, 18 Aug 2025 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755498849; cv=none; b=Y6DHHtmz6q7DJ4blzdGH6w2gEZoHKSlxEkdJFTAw1t+SqNCfRmvCUNIbEaLDmtxIc02N49DzFGqhhBTPdkKMkovz53tIDN3gTeQC1Vp02zf1KsEJa0p4kE89SJFE/wQxXU5Tix6Z8csEwtJOpSVOtGFN9FzOPCsVf3QARtKzdm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755498849; c=relaxed/simple;
	bh=9t9CvCcLh0Ah0PbjRt7HDJcr6X7Xx2b+z5PrmhAJzxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eP0ttIhqSY8+C+qaVtluK2cGt9tCWpQdYrhQT2clWuiKsUqF+e53JUo1pNc/l+5o9ZtQE8GDx1FMfiLGz3yVpqEjrEdeVAUDj5nt7efp1CiH7VHYAPRYT7N3oDfZA03G4kNYg+KWL934cp8PY93N1zY9j6l+KVkYFYtzr5zxo34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRGdX3gS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55ce526627dso3824360e87.3;
        Sun, 17 Aug 2025 23:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755498845; x=1756103645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQbiaF+h+tdVwxDePvpUAoUcuBTMLBOe3mQn1/A9q6M=;
        b=NRGdX3gS4U6DoYJKvy72K4ZDDaX8zOrmu65MpHN0HhLGIMH3zanxay+sctJ2durSwD
         htJX+Z3w+wiZgiajaaO8NyNq1VLWvRQzSG2rLIDAZlNCABsRrFHqTj+x2WYF1go8iASZ
         6/8f2aCdko/SvocmycdZJm36AVYgpfSX3dG/1icDzPE3GCAcwmPJHO4yAYL8AkMf6Nau
         2LQpiPBKH3jd8PFtePWfhuDiJymPlEKk1B1zkfmhEIWAltffTKoRWtuFZm9OKMQ8yoNS
         JR0g9TIHPeDmEzNFosCks+4RZvIAGJWnhvDXLTS32eQqfxEic/QpEp9MwXuZR9R4kDry
         j7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755498845; x=1756103645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQbiaF+h+tdVwxDePvpUAoUcuBTMLBOe3mQn1/A9q6M=;
        b=Iq7iXHnrvsbiHX93K8UoRZ0jcaWvDj/G9BLtt4hUlPhJJe7aYq4rAc1QUwpAohiM6I
         v/VCorybsX1+J5K9zJXPZ/rQOlnMGM5wuvK0tEeyGJXFVmp54Twh54vHet9tVzfwHH8R
         d/K2eeh75neoaJD7fCxH0j/hXoNU8I5X3bpfY7iksHrYHfjSUVNbeid0EqRd/iaUaUFL
         JXptvkWVX1Wpa0giQ5nJnEoeW0+qSaJmOCwSnk5opi1K7lLMVlrenKj7LjFehxyFSrSz
         Z6zcBEPhVU4/nXKu1u/+3r0Jgc7DOGAFfgtbAn55U3sQ79fF5rJAoiMMAJB8LN3OClzm
         UZQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+dyNBgP8XAGdDdmZUwGyOtGXANK4da5utVAJ/V9US0TcULeBN2pd0GzYysWg8GGItoxNkw4COnqo=@vger.kernel.org, AJvYcCW+OdA5GYxOsYW/tysH+eq+jVcbsW60HbleAWB6Qe3huRzt/E1dXnb6XERVfmttUsULDTpVFImEza2fFCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPT8wIsnpm/A4RFaGENm2B4rEgSo0wuvza34aHRnyCDEaQCVYl
	eXllJILvGCv2cf3szcyMs60yvc/+aGYHj4Zc+zz9uQtVEmRbXPTSZryb
X-Gm-Gg: ASbGncsCEUU7MWdWTHCGsneI4rri7sQjIAARi+tER0vrnsCxxdB0OpMaOh3O1/4YIzF
	5V00wqP+JucRbN6SWsVaurM3sHhyv+tX+T+Rwfa30RNBW68Bfzcbsn/fGNa6UHv9nDQ9T5IZVPU
	0Rr2rr31GDyDGqGlfEtC8wQGD9TNDBpD8mthRZp3n8yXA7ieIFzcxjX31PN8qUIRfzgOeD9sukP
	En9hL/DJWXdOhH7i02dFcZUftKkdLRx+eiiK4L2MFWhG8SpIwarzj6GBmy1CuznWgoxTQbQVVg4
	eeEE+MhC/lHcCCr25TURQK7uLIpmATPiZDmM3j/40yVHjMB/HazJtUJ0QXtwyunsSf5cL2FdAZg
	ExZH6msiJL+ksB7FEiXaHHIsjsVN7xLfpICIx3Lmvr+LPwx8DBwAY4JeDmVAoA210kAO/aB0c19
	3GWJ4=
X-Google-Smtp-Source: AGHT+IHhkDplfYNkF9fYnwuUpH0be76nuZhF+NZu0mtBXTD1IfVeL06KfVh5dMx8oTEevjZgnyqqbA==
X-Received: by 2002:a05:6512:4016:b0:55b:81d8:dcf3 with SMTP id 2adb3069b0e04-55cf2cc4cd8mr2382794e87.32.1755498845016;
        Sun, 17 Aug 2025 23:34:05 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef455fa4sm1491035e87.155.2025.08.17.23.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 23:34:03 -0700 (PDT)
Message-ID: <e8955365-73c0-4c7a-a579-0ee6940340b2@gmail.com>
Date: Mon, 18 Aug 2025 09:34:02 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] power: supply: Add bd718(15/28/78) charger driver
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Andreas Kemnade <andreas@kemnade.info>
Cc: Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250816-bd71828-charger-v1-0-71b11bde5c73@kemnade.info>
 <20250816-bd71828-charger-v1-2-71b11bde5c73@kemnade.info>
 <bf82cd81-bcc7-4929-aa84-b749533d5b95@kernel.org>
 <20250817101121.19a86716@akair>
 <bbd17f22-8834-42d8-a109-971bdd2e0fa1@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <bbd17f22-8834-42d8-a109-971bdd2e0fa1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/08/2025 11:13, Krzysztof Kozlowski wrote:
> On 17/08/2025 10:11, Andreas Kemnade wrote:
>> Am Sun, 17 Aug 2025 07:58:35 +0200
>> schrieb Krzysztof Kozlowski <krzk@kernel.org>:
>>
>>> On 16/08/2025 21:19, Andreas Kemnade wrote:
>>>> Add charger driver for ROHM BD718(15/28/78) PMIC charger block.
>>>> It is a stripped down version of the driver here:
>>>> https://lore.kernel.org/lkml/dbd97c1b0d715aa35a8b4d79741e433d97c562aa.1637061794.git.matti.vaittinen@fi.rohmeurope.com/
>>>
>>> Why are you duplicating the driver? Why original cannot be used?
>>>
>>>
>> I am not duplicating the driver. That patch series never went in. I am
>> stripping it down to let things go in step by step. I have also talked
>> with Sebastian about this. And he also prefers a step by step approach
>> to have it more easily reviewed.
>> I also do not have the infrastructure to test things like capacity
>> degradation over time. There is non-trivial rebasing work involved, so
>> I even do not feel confident submitting such at all.
> 
> 
> OK, but if you refer to other work, then also please explain why this is
> stripped down.

First of all, thanks a ton Andreas for continuing this work which I 
never managed to finish!

Battery fuel-gauging with coulomb-counter is hard. I believe we can get 
some results with the original RFC code - but it requires quite a bit of 
effort. AFAIR, there are (at least) 4 "pain-points".

1. Lack of persistent storage for charging cycles. For proper 
fuel-gauging, we would need information about battery aging. The PMIC 
has nothing to store the charging cycle counter when power is cut. 
That'd require some user-space solution which could store the cycle 
information in a persistent storage && tell it to the driver at 
start-up. I don't know if there is open-source userspace solution for this.

2. Battery parameters. This is the real problem. In order to make the 
fuel-gauging work, the driver needs proper battery information. I wrote 
the original driver to be able to retrieve the data from a 
static-battery DT node - but I have a feeling the device-vendor using 
this PMIC provided battery-info via module parameters. I am not sure if 
those parameters can be recovered - and as Andreas said, defining them 
is not easy task. By minimum we would need the OCV-tables and some aging 
+ temperature degradation effects (or VDR-tables which ROHM uses for 
it's zero-correction algorithm - but AFAIR, defining those VDR tables is 
not widely known information).

3. ADC offset. The coulomb-counter operates by measuring and integrating 
voltage-drop over known Rsense resistor. If (when) the ADC has some 
measurement offset, it will produce a systematic error which accumulates 
over time. Hence a calibration is required. The BD718[15/28] have an ADC 
calibration routine, but AFAIR, there was some limitations. I don't 
remember all the dirty details, but it probably didn't work too well if 
current consumption was varying during the calibration(?). I think 
running the calibration is not supported by the driver.

4. Maintaining all this. The fuel-gauging is maths which uses quite a 
few of battery parameters. Pinpointing an error from parameters, 
algorithm(s) or hardware is far from trivial because errors can specific 
to the very battery/system they were detected at.

There are probably more problems (some of which I have forgotten, and 
some of which I haven't even hit yet).

TLDR; It'd be hard to do accurate fuel-gauging without proper battery 
information and some extra work. We could probably get some rough 
estimates about the capacity - but implementing it only makes sense if 
there is someone really using it. Charger control on the other hand 
makes some sense. [It at least allows Andreas to charge his eReader 
using solar-power when on a biking hiking! How cool is that? ;)]

So, dropping fuel-gauge (for now), and upstreaming the rest seems like a 
very good approach to me.

Thanks for CC'in me Andreas. I don't have much time to work on this (as 
I never do), but please keep me in loop and let me know if I can help... 
I can at very least review things :)

Thanks again for working with this!

(Ps. Are you joining ELCE in Amsterdam? It'd be nice to see you there if 
you do).

Yours,
	-- Matti

