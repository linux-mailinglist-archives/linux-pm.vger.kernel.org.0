Return-Path: <linux-pm+bounces-2390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E80832DA6
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 18:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826D91C20AFB
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 17:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2BB55796;
	Fri, 19 Jan 2024 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJ9N/BQs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A3E4C624
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705683849; cv=none; b=a89zrMi4ciWG9kze0OTqy/20yHLHPeaYT2N81+2xJVAk/Twzh06uDklIY4wFc9skc3eyvYo7NEIv0RU9WkBjk2YsZcDVjz1pGeL+6fb52zasPlVPzPRggN46OoXN3T6sxXS/D+W31R/S9RUT0fNe8OeNXUTmcjWaDPv6jqZl/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705683849; c=relaxed/simple;
	bh=laQ5R2ljp5sOAD1PeJjNCx3V7TzWD7aQzqRo6lgnvpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGYl0KsSmpoXI4LdCzmqBr6JLBIrWM9ijMAkmiPyMr65jYRBlReW7gpt9jkIxLesQX6HYc3uzTWFmYER1F/xUAt6/4v89HLFdNZyL5R49vEJpaG5NRH0LpIzg2wohhFZFSlMzaOVHexyBWhdgX1/U3Pi9na1IHz7h5cj9xEygWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BJ9N/BQs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e8f710d44so12228295e9.3
        for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 09:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705683846; x=1706288646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fp4lNGKb8aVlGOpRF8y9CMoD/VH0i42/Ixsz2vaouoM=;
        b=BJ9N/BQsWfarmO0yB7Rj3+FfHxHhRbHxHNw8XngRIUSPlp2zbgrMLu+CbEP/LyZk0r
         cKLu3BR0XmT1suuLMX9UgwMMlf7088ew0rU9Qx+2g+Tv1mp8zZes/I3M7t321sgnyiIx
         HLDiw1uFrF0+ti9ksgnYCkrMp2LCQ2fidfL4jdkJAoUmfuTdRQJVFyCdpewUH5bM9wz0
         vTjz++K9zeR+Bb4xnwEH4Ji8quD+Je04GJg+3HkmULla6Oq24TwOE3xgdG1K1tYehDtu
         nwoPWHAvVAMusi6MyTBZxKrDmlYpxfUA3qL/W9JBxDlP5dIJHho7KgUxaLkqDhRTNDXa
         DLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705683846; x=1706288646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fp4lNGKb8aVlGOpRF8y9CMoD/VH0i42/Ixsz2vaouoM=;
        b=PxtlCV/mwApHSDk10C+pGmEMKGL5UdYGNFHIUFPfCsOgW2DNKjkOYuYTooOoYBoHz+
         ULtrkKsp6E/6sLO+VOXpYEiXd+fN25voPmb4CfgoSOHXthGEOLHv9AEWYW9L0AtvDOUS
         6/RD/BjG5IxJyM8opnVlRJBIKPOZcstauK7B4b7Tj8W1FKQLchvudby7xDQzIYTk/+Ck
         pZFioZPHk6G/ygu2087cm6Gkv6YQPj0wWf3fMa48K98H9tYBSXCmo08wdwv35WhuNoFf
         jWndAS1GQpuQwnGoqhoDMByjre50JveKFxLenpUCKIz0lNR003wb1ZGccGW7kbekRKz5
         4pDw==
X-Gm-Message-State: AOJu0YxOBkyG4fmPCL0GG39ex1ACVZte9vtrwymP1oMSFLTrnmwDlCtV
	q/zIbs2QdvSW67D2FRe/DTiZyLL4c2M+pB4xEbYwrg93j3VRj+CtLOuQw2/MEPQ=
X-Google-Smtp-Source: AGHT+IGEA8WJp2FihijH5hF1ivVCC8ljmyKvQ7c/6EH1MKuwIUL9qtRlaeRJu4EVpr+Lalz6DsbNdA==
X-Received: by 2002:a05:600c:35c5:b0:40e:691f:23ad with SMTP id r5-20020a05600c35c500b0040e691f23admr40987wmq.10.1705683845595;
        Fri, 19 Jan 2024 09:04:05 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:80ec:9cf:f853:831a? ([2a05:6e02:1041:c10:80ec:9cf:f853:831a])
        by smtp.googlemail.com with ESMTPSA id w4-20020a05600c474400b0040d5ae2906esm33848731wmo.30.2024.01.19.09.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 09:04:05 -0800 (PST)
Message-ID: <6a5dc670-42bc-4d4c-bc27-e75234602333@linaro.org>
Date: Fri, 19 Jan 2024 18:04:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] arm64: dts: mediatek: mt8186: add default thermal
 zones
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Nicolas Pitre <nico@fluxnic.net>
Cc: linux-pm@vger.kernel.org
References: <20240111223020.3593558-1-nico@fluxnic.net>
 <20240111223020.3593558-7-nico@fluxnic.net>
 <d11047b4-2a7b-4007-801d-dd9d2955fe02@kernel.org>
 <n63rs2o2-7osn-9srn-3r9r-65081rs05r68@syhkavp.arg>
 <b91bada2-d9bf-4d98-b541-c41bcadc490a@kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <b91bada2-d9bf-4d98-b541-c41bcadc490a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/01/2024 18:52, Krzysztof Kozlowski wrote:
> On 15/01/2024 18:46, Nicolas Pitre wrote:
>>>> @@ -2115,4 +2117,238 @@ larb19: smi@1c10f000 {
>>>>   			power-domains = <&spm MT8186_POWER_DOMAIN_IPE>;
>>>>   		};
>>>>   	};
>>>> +
>>>> +	thermal_zones: thermal-zones {
>>>> +		cpu_zone0-thermal {
>>>
>>> No underscores in node names. Could one CPU have multiple names? If not,
>>> then it is just "cpu0-thermal".
>>
>> Well... I'm not completely clear about this given the available info,
>> but this thermal zone would not be matching a single CPU but a few of
>> them, hence several "zones of CPUs".
> 
> OK, then just: cpu-zone0-thermal

Given the node name is used as the thermal zone name. The 'zone' is 
duplicate in the namespace.

/sys/class/thermal/thermal_zone0/type = cpu-zone0-thermal

Furthermore, if other thermal zones are registered before, that could be:

/sys/class/thermal/thermal_zone4/type = cpu-zone0-thermal

Kind of inconsistent :/

If it is a group of CPUS, they are probably belonging to the same 
performance domain, may be we can use the name 'cluster' here:

	cluster0-thermal



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


