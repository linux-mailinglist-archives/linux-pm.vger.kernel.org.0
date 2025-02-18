Return-Path: <linux-pm+bounces-22342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8072A3A7EA
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 20:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C080172DA3
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 19:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CA21EB5C9;
	Tue, 18 Feb 2025 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/R0YUhg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39181E833C
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907828; cv=none; b=ct/DB7pA4yNKKxPVietEcwvTRND8b3xrLqNLcMx/oLX2j5T7XD83GYlAGpA31k/pfjWDgooRUb790StxvvxcxaTB2UcBsQePu894cB23zWcyJYcInx7+6rHpare65+26xD6AW62D0/t9mQ9QOY+dvjJwd+jB5A0x/EJRN6W9PuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907828; c=relaxed/simple;
	bh=pMvVG7fqHk6x9Lp+bc7lGWvpOYPn7WYP6O203zRn38I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtpGafSxcrHmlBYkftj7IF0ZpbG6zVPG/3HrUh/XrKLveAOoSMEN6jwX7XggeDA3Da5rx9nO016rKYOmds0eGcYF/taM9omMaBRlN6/ktSsnTBL7LpOXWez6/EQuiWqnzMluW6ufDertCrBjzC70QlMzqnRcfW3qBaKStPkphkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u/R0YUhg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43937cf2131so40058075e9.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 11:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739907823; x=1740512623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t6NET/R65D4fhygY4ZNz4mV2mBN1Fn/fSAZnL4GhO6k=;
        b=u/R0YUhgtjl6EfbPcb8jg9FhB7sdaLo28saWnHxydKEUBmFosb1V6FvqLF0xdwVoVh
         Lhhg13FMZIxapnOinJsH4WyuMjpfiOLe3YVLkM7HiW25OIqEweTj+n8ccn0F6Miyjk8P
         AfgEJrII53/vz4J5HCtjElb5XTFWj4UulpP/UUNdn/DedruDtwunHxOMf02/tQGUU5gV
         N5J4cH16mSfIU2GpeIjBJdBQeERlsEBAeNS2OZkUpUAB7y2a8Afd/NOQ6oNelPBgOihv
         m2Z7E0Bg8TM6VdSsBO9Xcso8+2gRDeh3yjLL1w6GX/G0H07RWcj/eDaolDTWtwwV5OTP
         fmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907823; x=1740512623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6NET/R65D4fhygY4ZNz4mV2mBN1Fn/fSAZnL4GhO6k=;
        b=clu4+hCAmOBXsLGkasyn+vlEPJBYzHtareNHVhJkrLiBBwJlnlGlwwLGqswmyd9bhp
         HOzN+w0XFBb/eNMTluP7iD9SBIBCCvFXcJ2yHZnSGTaWB8F2F0DMs70Ho/DaROiX95fz
         KcFsr8RnXFQRYMuh2RYcjr8Yh+J3hL2iK38bDF0deGZCAXw+zj1Z9fnyeHYjbx8pjgxO
         UoABrEP/J4ElZcVM3vhWPbJxJWHK2akOdBYxWUQHt8NcHEAhV3B2mrtAvdyF5Zrz0/ss
         LT131XzwX2X79dInghJvfRamzZV5K6cTUuwBxhZNaZs+9iVzggJh+iaEqvxko22F37oD
         kARQ==
X-Forwarded-Encrypted: i=1; AJvYcCViPJuMeNLDmGp+TY8RfqZFb/SFOHHqDOIz4BOgsOx6UmFzII7IP0S6k/WLUnZmqAU+aUBsgiIuKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/nm4WY91DnV7ez7So1RMJfXvDyXR5slwFrFd+DxjziDb+vOtO
	9b8Y1iGDnSLeGIDUxV5qat631rkJfCbEKyAjMc8W441ORyvhPcLrunawX6UweHY=
X-Gm-Gg: ASbGnctBCmG9qoH4rTzAl1PkjqdYe7ywBRy1Fo5p6kwbtmZMUhcpL542PxbPBQ2LVZs
	Lo/fUHYiO2KjSVNe1cJVzNStQutY8wlOdBI6CIp+iIpsCSbn1hj8K3p/9nXJ1IB1AWs4G0kYVM4
	x3U+gJyDFClJPknW1Wypvd3lUTyovvcpQpH1spyKMpeFWFwp9KwiKmTF82hDY9vf1pXj6Kfn40C
	YZDelXmbcQuQ7JXmlmPcGuxRCALNTB8ZHnNKG+BgR8XZDffj7URUbw6ZBwdbmUfVNGnPPLi10QH
	qDRDCy/TrmNMJOV7NLMsjNVWWhfmRY13uBFMMHIPVp+20kg9EULQvRk=
X-Google-Smtp-Source: AGHT+IE0UW/mzN+qXiFnRcnySUoZloCoBhk1jxMNyKm7/6Uvfk8YLL036J9/dJuG/NFnq4RdsX52mw==
X-Received: by 2002:a05:600c:3b0e:b0:439:987c:2309 with SMTP id 5b1f17b1804b1-439987c256dmr19864515e9.27.1739907823188;
        Tue, 18 Feb 2025 11:43:43 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4395a055910sm190528525e9.9.2025.02.18.11.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 11:43:42 -0800 (PST)
Message-ID: <e36a5771-d277-41d3-af9c-c5841c4060a2@linaro.org>
Date: Tue, 18 Feb 2025 20:43:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] thermal: rockchip: Support the rk3562 SoC in thermal
 driver
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org,
 Shaohan Yao <shaohan.yao@rock-chips.com>, linux-pm@vger.kernel.org,
 Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20241224094015.3816301-1-kever.yang@rock-chips.com>
 <20241224094015.3816301-2-kever.yang@rock-chips.com>
 <7f17cc55-a741-4bb8-9513-0580ca6fedd3@linaro.org> <17758610.geO5KgaWL5@diego>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <17758610.geO5KgaWL5@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/02/2025 11:19, Heiko Stübner wrote:
> Hey Daniel,
> 
> Am Dienstag, 11. Februar 2025, 10:36:09 MEZ schrieb Daniel Lezcano:
>> On 24/12/2024 10:40, Kever Yang wrote:
>>> From: Shaohan Yao <shaohan.yao@rock-chips.com>
>>>
>>> There are one Temperature Sensor on rk3562, channel 0 is for chip.
>>
>> A bit stingy in terms of description, no ?
>>
>>
>>> Signed-off-by: Shaohan Yao <shaohan.yao@rock-chips.com>
>>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> [...]
>>> +static const struct tsadc_table rk3562_code_table[] = {
>>> +	{0, -40000},
>>> +	{1419, -40000},
>>> +	{1428, -35000},
>>> +	{1436, -30000},
>>> +	{1445, -25000},
>>> +	{1453, -20000},
>>> +	{1462, -15000},
>>> +	{1470, -10000},
>>> +	{1479, -5000},
>>> +	{1487, 0},
>>> +	{1496, 5000},
>>> +	{1504, 10000},
>>> +	{1512, 15000},
>>> +	{1521, 20000},
>>> +	{1529, 25000},
>>> +	{1538, 30000},
>>> +	{1546, 35000},
>>> +	{1555, 40000},
>>> +	{1563, 45000},
>>> +	{1572, 50000},
>>> +	{1580, 55000},
>>> +	{1589, 60000},
>>> +	{1598, 65000},
>>> +	{1606, 70000},
>>> +	{1615, 75000},
>>> +	{1623, 80000},
>>> +	{1632, 85000},
>>> +	{1640, 90000},
>>> +	{1648, 95000},
>>> +	{1657, 100000},
>>> +	{1666, 105000},
>>> +	{1674, 110000},
>>> +	{1682, 115000},
>>> +	{1691, 120000},
>>> +	{1699, 125000},
>>> +	{TSADCV2_DATA_MASK, 125000},
>>> +};
>>
>> May be it is time to optimize all these tables out of the memory driver?
>>
>> It is the 9th table introduced.
> 
> just to see if we think differently, what do you have in mind?
> 
> For me the adc-to-temperature conversion _is_ part of the hw-block itself,
> so should likely not spill into the devicetree, but you're right, defining
> a big table for each soc also isn't really great.
> 
> For the rk3562 in question, the stepping seems to be 8,9,8,9,....
> where for the rk3568 the value stepping seems to be 32,36,32,36,...
> and it looks similar for the other socs too, with the driver is already
> interpolating between values it seems.
> 
> So even just halving (or more) all the big tables (dropping every second
> entry for example) should not really loose us real granularity.

It can be just a formula to be reused in the adc_to_temp, temp_to_adc or 
precompute the table from the formula:

For instance the following formulas:

rk3588_code_table:

	y = ((x^2 + 23315x - 5949300) * 100) / 2457

rk3568_code_table:

	y = ((x^2 - 2660x + 1547712) * 625) / 2448

etc ...


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

