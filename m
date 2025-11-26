Return-Path: <linux-pm+bounces-38687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B21C88E75
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 10:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1855F354694
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 09:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000042E03F2;
	Wed, 26 Nov 2025 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pURHCUCD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F2D22172C
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148902; cv=none; b=EVhtUGDkincPQsqOd/MPbMX0scvIfsGfxk9EwlAjY2jXrgXB6QpexVLw4U8gHrgEtmBdUK+zgE470fmFQ1FRWICKVeAAjtiVkGN50odp/tS2v+YeeMRE4matKwUSMgoPNQK9dCcyzH5XVeH6YQn6Ri0H9XzJRAmHukeEzdTDSPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148902; c=relaxed/simple;
	bh=CF1ETXPe1PugLHsavs1SU5GJc3PtBPy6SGKx8TYf/E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cafn11awZCtLShQ0I8haM89trTglO2wOwLATR7rmlZWeByv1G+pvxDMoK37tDDRm/Y5O6VHJWW3Wrrs8dKA9DH9YYW1cZ2bE4OjbRJULVxkljCUL/8Yob6dSWRO27ZDV0n39Bb0xkwv3rGOU3HJuBjwyT/LRodCchGCHi2G+YVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pURHCUCD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so38269655e9.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 01:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764148899; x=1764753699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPZr/XNvb8iNxFUbgomB4BCl6EzqteQOa6tv7krwi+o=;
        b=pURHCUCD7dh5yvlceB996fV6H2s/Jtxu3c1EEyE0Vlu5xeZWdAPQygVhTSkH315hOE
         FovsgPHs5yrrSO0Q4P40ZbKcZfO/dkDE8oS+FRytE2m6qba+soWAVet2lzpL2teADnO8
         ioMe4wzEWYuRkSkJhG2Miax2CP6ccsVzIPdhLgWAheV7jwmMKajm34o2atuc4R7Gl+5C
         NrqDwYcfz+5v1xsqzY0w4NeMD2EtJLHr/8tWYpijoDEHPPqs2/+wpz0xPduuwyhK29eR
         iB2Lutu5lPRdRv1bwP7EVf/ayndHvx9YG8qJvqBJYcuJJO8SSI1PiT4V9DtN/ATiGDF2
         zNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764148899; x=1764753699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPZr/XNvb8iNxFUbgomB4BCl6EzqteQOa6tv7krwi+o=;
        b=ReVp5naEUAnxIDlUSGLQwST2ZhwGGYjtOup/OvSzVwwXE+yVuwhZSxXX/m6LWpfZsg
         nOo1Cwo4B79Umbbxu80B5zOpC+aCVV/YjKmConAbZ5AvOAl6uV7KzNz8sEksPpootpcF
         Ge5QRMwHkzALq+KX2Q8qrIHO0gCChR5sU0KxwW8rZPcEYJlvFDX61tmbp2sRhyaA6wBg
         mzI/DZBQgZeZNfpUD8yDaHBuTUX4LjNXQp47xhKb3H8gupU9cj03Xqw3cgoydvDbUEjz
         m/mcnJCr8ZO4Zrwo3RfW3pNdnkfUe1uvOQXaKLrtkaa6AwkgNWRy3C+XK0nrliEafpar
         Z18g==
X-Forwarded-Encrypted: i=1; AJvYcCXM8urvNVnRp9hyIFbVQS71VkK4Q37er4RNcg72iwK25BTLSzaW2DJHY4Aq4ZHs3MorVwQRnp8uDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuqWQqXCGm9xMavzaygFXVsqs0mL/cIzMtN3P15QYpRLghEq6C
	/rdmyXbWNn6F4Z5T7HQEhCzcZ55uUonBHEInj9lxCd9+u4UBdtlVIbOvM4aHmlKnS00=
X-Gm-Gg: ASbGncsW8zUEWohSsBlI2psZlfOV5yMju4C1Kefb8dszfm8F/Qkj8/GnzSgoabhfMd8
	1I66qmIng0jzicVPHRIVw02HwpIxvdmCOD6s83Fv2Yt9gMg7m4WCtGtmyrMrZKgTjqPz+53lijN
	0dO5wXpcuIhaIoq6GQDO/VHfHUE+IWPbLWKCz1Llqp6N01sg5znxh+gbnH52Osi6rnlH2HsSdcb
	NIjSVjgKTQnfsdnfhJCUt8Srlg8gZFH28LqwYlNyUJLTDf/VWSE3gTtTQL1o5NpChsCmS0YS4Js
	jXT67puDZGi1SircC7G/TeX3nFzz1/cAKrBbvNZIVsJwNelVGAZ5ONKeUcgLwWtgGbfFnvEr5eV
	K04W3vcEE7FkYI4WYw1Z6JXScJcAB7ycE1IvV05qBkcXgZ+zrRHKPQhDpFGenSllmw3inyHZNr6
	GJIBsnDDRSNY8w35ti
X-Google-Smtp-Source: AGHT+IHu5mjVSJftAmmd8mkUWGgVLFw7C7td0QXt6C37n/EMphfyxyx6zRNAnmmqGIwLaBqQANGUSw==
X-Received: by 2002:a05:600c:6287:b0:477:7bca:8b34 with SMTP id 5b1f17b1804b1-47904acae5fmr50881635e9.6.1764148899568;
        Wed, 26 Nov 2025 01:21:39 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040b3092sm39152885e9.1.2025.11.26.01.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 01:21:38 -0800 (PST)
Message-ID: <401ed9b9-19a4-4a19-b397-0f353e9f0c97@linaro.org>
Date: Wed, 26 Nov 2025 11:21:36 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 RESEND 2/3] thermal: exynos_tmu: Support new hardware
 and update TMU interface
To: =?UTF-8?B?7IaQ7Iug?= <shin.son@samsung.com>,
 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>,
 'Krzysztof Kozlowski' <krzk@kernel.org>,
 "'Rafael J . Wysocki'" <rafael@kernel.org>,
 'Daniel Lezcano' <daniel.lezcano@linaro.org>,
 'Zhang Rui' <rui.zhang@intel.com>, 'Lukasz Luba' <lukasz.luba@arm.com>,
 'Rob Herring' <robh@kernel.org>, 'Conor Dooley' <conor+dt@kernel.org>,
 'Alim Akhtar' <alim.akhtar@samsung.com>, youngmin.nam@samsung.com
Cc: 'Henrik Grimler' <henrik@grimler.se>, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 'Peter Griffin' <peter.griffin@linaro.org>,
 =?UTF-8?Q?=27Andr=C3=A9_Draszik=27?= <andre.draszik@linaro.org>,
 'William McVicker' <willmcvicker@google.com>, jyescas@google.com
References: <20251113064022.2701578-1-shin.son@samsung.com>
 <CGME20251113064044epcas2p1b87addb21473eca7cc52052e4e2e9237@epcas2p1.samsung.com>
 <20251113064022.2701578-3-shin.son@samsung.com>
 <5a6a749b-b2b7-41bb-bcb4-a2342e7f4e98@linaro.org>
 <015501dc5ea5$0c7dd460$25797d20$@samsung.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <015501dc5ea5$0c7dd460$25797d20$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Shin Son,

On 11/26/25 9:19 AM, 손신 wrote:
>> Looking at the exynosautov9 registers that you described and comparing
>> them with
>> gs101 I see just 2 differences:
>> 1/ exnosautov2 has a TRIMINFO_CONFIG2 register, while gs101 doesn't 2/
>> EXYNOSAUTOV920_PEND register fields differ from GS101
> TRIMINFO_CONFIG2 doesn't exist on eav920 either; I simply misnamed it.
> However, the PEND register indeed differs from GS101.
> 
>> Given the similarities, and considering the EXYNOS9_ registers rename from:
>> https://lore.kernel.org/linux-samsung-soc/20251117074140.4090939-5-
>> youngmin.nam@samsung.com/
>> would it make sense to use the SoC-era name instead of specific SoC, i.e.
>> s/EXYNOSAUTOV920_/EXYNOS9_ and use the latter for both exynosautov9 and
>> gs101?
>>
> First of all, as far as I know, EXYNOS9 is not the same as exynosautov9, and exynosautov920 also differs from exynosautov9.

See also see this patch, or maybe the entire patch set:
https://lore.kernel.org/linux-samsung-soc/20251117074140.4090939-2-youngmin.nam@samsung.com/

It's not just autov9 and gs101 that have similar TMU registers (with the two
exceptions AFAICT), it's also exynos850 that seems identical with autov9.

All seem to be part of the same "Exynos9-era" SoCs. Let's think about how
gs101/exynos850 TMU addition will follow. Shall one use the EXYNOSAUTOV920
registers? That seems misleading. Shall one redefine the entire register set?
That won't fly because of the code duplication.

Thus I propose to use the EXYNOS9 prefix for the register definitions, and if
there are SoCs with slight differences, that can be handled with compatible
match data and specific SoC definitions, but only where things differ.

> So while sharing a common prefix is a good suggestion in general, I believe it's not appropriate here
> Because the register definitions are not fully compatible across these SoCs. Using a common name array may introduce confusion later.

Please reconsider this. Maybe Youngmin Nam or others can intervene.

Thanks!
ta

