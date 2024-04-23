Return-Path: <linux-pm+bounces-6913-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3588AE08C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 11:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87531C21BE4
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 09:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB8F5644F;
	Tue, 23 Apr 2024 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5vodbmY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A131A5578A
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863173; cv=none; b=IcqeujMt59mzxZ24BTOeoMBqe3/h87OuaogzBKIdIHqS226MgshBRMgKiBxzBOmczIANQYZXfuD5+xuZG/M7TSNB2xjTxY8yrai260DH76j/XH2hWmBqeynXoX3n72nAecDnoRe4U0PH8vrE/a6j0rSiWTrBj2FZPEXpsY5jNMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863173; c=relaxed/simple;
	bh=JQG2DHaylaKVY1UHfizY1eaq/F2qkHVRo3sTzXgTqTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGpJbT16gPg8dJpQE5J4LnNweeSC0/58su/vzAHPczq88/pPm5BK0Dj7jWyKowfk8gJMzRPNBcAoCHdTaKdL9LG1l2chrlm9AVXRxDRPQS0eMORUk6wVySY4GqbGRzrnV3cjmvRrMuyG4mMj9fZLRIDRhfy8pwC7IC8H/hip5MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a5vodbmY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34b64b7728cso552179f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713863168; x=1714467968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZvKemPhdZXx1a5wAZJqa8euX8d+AR9YE7+2VTNoqyA=;
        b=a5vodbmYSUTc1tn51JwLknEwBLFLpkPjOwKojQE64fHIVm3z9qbjwZO92nyDGF0scS
         r6rhiQWV461fgzcSpB3p6F4WvGiWEaJKRPuAPfprnE0CoicMrOXR9tqpV1ncHgAGL397
         gTEsAw9V+9eqx8r9b/SdXg6Q3JE82Yp5WrJRKzxJrqIjX8VRgrip+4ACHfS/CicS/GII
         OmA5S+GbjjpwyRGrI/H4l1a+AZPb5NIKRdr5LjAB4Wqda6zM/mJfMxcek8ccsKoyDwRk
         lOjtzMQhi2Sbc7ruRV/yyhNEMJCsNStkz8oM9+9aDxeMXc/h60r7beOsno25tix13+eJ
         0raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713863168; x=1714467968;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZvKemPhdZXx1a5wAZJqa8euX8d+AR9YE7+2VTNoqyA=;
        b=tP75dQ/qz8e91vN2JUqJQJbGUSxSXLsEVka+cCZcf9MDS9A7XKfNu1zhRBa6NhwqMw
         xiXqm0fFm/Ffc/N8wlK9O57yVcb9zC5gTOG5ij+J0TO5+J9BsOuVwvc+reugGYtRKgnv
         XD0a2mZmhjLDQDM0vOn4F1l/aGW8WYJ+gyzqb8a+Kh0/InTB65RL9N9uyyfUb8uFgDn0
         a78e0WnXAdNggypOrIByFIzJIqVrZ/GPBkMt2EEV59QPt1cK2orkQJ31kZ4lRbaLPhv6
         LF8oKwY1q7uDtp1UsGYlTaS8YPrs+gRVZz4/hy4sd3R4eZOsu+VhxUxwsAwy/q9jYdDL
         NJcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX79UyUKs+E9/bG8CJkTFXReFETidzD19hCerSDAN15u0b89D+7fkjfvi187RdGZ+giJ+FmQuGk7SyLpDsm5H3NOA3OQ7lJQZM=
X-Gm-Message-State: AOJu0YweD8vWgwvFmHNCjl6GIHKM6vljM56OaOVInNBPse/UwhuY8W21
	1e7b+Yzhg9wQWe2LX2tcixsjwL56Cn5hJixfPr4+LoWWuJ8niIAJbZhul/+Gej8=
X-Google-Smtp-Source: AGHT+IHG4sDArZk8hnzhxx9ggspr37j2e30TIdiJYyOlEmHIcaoKuInnRHqczfjjQmlkFqUJcqEnXA==
X-Received: by 2002:a05:6000:12c4:b0:34a:e6aa:bc01 with SMTP id l4-20020a05600012c400b0034ae6aabc01mr4790936wrx.5.1713863167966;
        Tue, 23 Apr 2024 02:06:07 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id o12-20020a5d62cc000000b00349c42f2559sm14036551wrv.11.2024.04.23.02.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 02:06:07 -0700 (PDT)
Message-ID: <3fabe40f-2353-48c5-a29c-fa0ae9ddf3ce@linaro.org>
Date: Tue, 23 Apr 2024 11:06:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Mediatek thermal sensor driver support for
 MT8186 and MT8188
Content-Language: en-US
To: Nicolas Pitre <nico@fluxnic.net>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20240402032729.2736685-1-nico@fluxnic.net>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240402032729.2736685-1-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Nico,

applied the series, except the DT changes

Thanks

   -- Daniel

On 02/04/2024 05:25, Nicolas Pitre wrote:
> This is a bunch of patches to support the MT8186 and MT8188 thermal
> sensor configurations. Several changes are needed to cope with oddities
> these SOCs implement.
> 
> All values (calibration data offsets, etc.) were lifted and adapted from
> the vendor driver source code.
> 
> Changes from v2:
> 
>   - use meaningful name for binding index definitions
>   - reuse LVTS_COEFF_*_MT7988 on MT8186 per reviewer request
>   - do similarly for MT8188 that now reuses LVTS_COEFF_*_MT8195
>   - use thermal zone names the svs driver wants
>   - adjust some DT node names and iospace length
>   - remove variable .hw_tshut_temp as it is constant across all SOCs
> 
> Version 2 can be found here:
> 
>   https://lore.kernel.org/all/20240318212428.3843952-1-nico@fluxnic.net/
> 
> Changes from v1:
> 
>   - renamed CPU cluster thermal zones in DT
>   - fixed logic to cope with empty controller slots at the beginning
>   - isolated bindings to their own patches
>   - added MT8188 default thermal zones
> 
> Version 1 can be found here:
> 
>   https://lore.kernel.org/all/20240111223020.3593558-1-nico@fluxnic.net/T/
> 
> diffstat:
> 
>   .../thermal/mediatek,lvts-thermal.yaml        |   6 +
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi      | 256 +++++++++++
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 383 ++++++++++++++++
>   drivers/thermal/mediatek/lvts_thermal.c       | 434 +++++++++++++-----
>   .../thermal/mediatek,lvts-thermal.h           |  26 ++
>   5 files changed, 987 insertions(+), 118 deletions(-)



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


