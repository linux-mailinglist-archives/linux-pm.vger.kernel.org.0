Return-Path: <linux-pm+bounces-37733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9027C46C86
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 14:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C352D3A4256
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 13:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CA7305968;
	Mon, 10 Nov 2025 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vf/otQfw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89C427280B
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780051; cv=none; b=S6tg7tco6fu/wd5nsgDkZz6tVOVWSyRA6+zEkJ6/8CyjDo+voNSSeVPznAwaR8wB9NASFTtTTdQgqf0Rar1tGMwCnuLiv0TAivfwqL1ffAkJobcdcy+ryHXxDh9uv2oGMYnSVhrhi9PrvZOm5MDoxNi/yMRVR7hh+Es+Mm0yTBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780051; c=relaxed/simple;
	bh=xLE0g0V6VtstEXCgX58na2I3K9PHtFDdOQGN69zLTms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PwMtfnrOd7YnFP437sWDo9DFmkFOCj2u+S3iTAv6xgqkeABYNOSxiq4NTirE3MmIbv0qiM1yLPRFvrxNN772irU3tZpEEw0HLbbansG5iH5cWTsvgJpT7uNNKq9PefKKBoWuSyDDwij/0Fw1ckVG2dOJTIowIXPHOZZZJvbgROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vf/otQfw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47721743fd0so14470255e9.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 05:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762780048; x=1763384848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4cJaSvdyQCbEMb76mhwbw00KVaPl98c0awaqdZ3M8o=;
        b=vf/otQfwqJttX7Cmx+sZy3Ed8WICcoJ58/hUXTGsHageFxn4m3AQAESc2NMFRZBGSJ
         Xasiu0RwIeVSI1pJ2bnUpy4PtKtU+/r74rWsLn1myMLYuzUd/emun1AHYDYPNq44V1ti
         2t4v7MjAZQAIyHg0mNe8tGhTRCUS/brU1c6R9eJWKmE7Qg3oAbwfcUqCLCv/iMV2Hwr1
         VMcPJhe6ECBZdbzqhfMcuyDjLeZCUkl6/dEAo3ysNHSTcEHj9qiML7bJjW1ukYDTGZuR
         tWWBOBvYtpSnIrNg5PoUcLi1gUFxJe6/C96L5Q0PKweRcR//W8iJFl1z+HsQJgsLC5ud
         okvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762780048; x=1763384848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4cJaSvdyQCbEMb76mhwbw00KVaPl98c0awaqdZ3M8o=;
        b=Ab02CU6j7f87Dzf6qM/Hcsocb4/io6i4o7yzCcpqNIvurAPjD4L03b1xheoKJqpr8O
         e0mb8z4n4pFn+c8jkFBbaxyFwpl8Sap56KRZ3vyw5CiQASMT9sdU8+BCtwmi7qqrxfWM
         OM5O11nNXhhGwZQ2eTr8hlYnaY2eERI+xbq9/EVShPNV7ZcdhTLhaZXwJkmalrCHIAF7
         cXXDTGMOB7sFms++s/+JbunhcOTyQmHKO8dYikGedBd9qlMb6qGo5gEmtZpDdhkZe1+b
         7YZE5A0iZGml97TFpVNiupohMVXgMsebEf/xBeb6HMtw5aRP5W1GdmUB4SS8zmbOrGPe
         ZcNw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ3sC08QkPgokbDswC8vHlT8RyVeb3O01vNI9xM5EKPXy1BzbkYl4xTWQowmknbyUPNkUHSg8GcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YztzJ4Hkf9GKVGxnVCTLx1Qg5E+bwQrUtJHi3icty4xOxfmu7DT
	CaYPaBDSrLh3vNRd58DX19NNBOuYc/f31+J6dTiHCuasHl2N3HiKmEe81yxXmmB/jw4=
X-Gm-Gg: ASbGncu1Mbrg+aeXbtpzwarCHbrMC6K+NVYyZdmpu4E5q5ePwHVKgyRB5mFQAT5wKVR
	RdyQfxdJdYJoFdR4PpVS2+K8eMIA8cEt6HFo1bVAFG0Ydv61Sboy3F4hDEhhgxthRD0sgJyh/RI
	NYtMEgXYEUX9J0XR8V5xeTLRKjItlollJEKF1nYHNg7Gpfi9h/1zFJKiIf/daiv1GMaM6JaGFk0
	XDOdk6VbWZlFIC77/7GF0+phgSiZkua6yC66h/3fM3UZaaAfuUMu6+0qewK5jfVCdkKaL0jpecg
	AorQPfYbFX+ZUxRDXY8nWv8HfN1ZOVawZwuVBD82wi5pY6QoeeAY6EW3I3BFsEfo56UeQhhEmjB
	ep2ugKAiUnVfkztZiSSwfOs8vRYJneJxk8zcisjqq3TtbULKVwZPdbzYI0YEnfcsnlxd+AI+Zlo
	KIoLr00M2xTlgAKuSWptHwFaR4x4hp5nK14YohnmEkdlrKHd4rGeJBRKE=
X-Google-Smtp-Source: AGHT+IHcCOONTIlqmfkXgQ46x6qRMAz8cIzqeP6tpBIy8/x9/ya7VMOfAxTxh9tydHHTLgqTp1lvxg==
X-Received: by 2002:a05:600c:3b8d:b0:477:641a:1402 with SMTP id 5b1f17b1804b1-477732308acmr85105745e9.4.1762780047939;
        Mon, 10 Nov 2025 05:07:27 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:2b20:d700:6e9c:533c? ([2a05:6e02:1041:c10:2b20:d700:6e9c:533c])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4776bd084d4sm252075645e9.14.2025.11.10.05.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 05:07:27 -0800 (PST)
Message-ID: <adceca49-acbc-4ae6-984c-5a8916aba8be@linaro.org>
Date: Mon, 10 Nov 2025 14:07:26 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 5/9] thermal/drivers/mediatek/lvts: Add
 lvts_temp_to_raw variant
To: Laura Nao <laura.nao@collabora.com>, srini@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 rui.zhang@intel.com, lukasz.luba@arm.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: nfraprado@collabora.com, arnd@arndb.de, colin.i.king@gmail.com,
 u.kleine-koenig@baylibre.com, andrew-ct.chen@mediatek.com,
 lala.lin@mediatek.com, bchihi@baylibre.com, frank-w@public-files.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com,
 Chen-Yu Tsai <wenst@chromium.org>, Fei Shao <fshao@chromium.org>
References: <20251016142158.740242-1-laura.nao@collabora.com>
 <20251016142158.740242-6-laura.nao@collabora.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251016142158.740242-6-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/25 16:21, Laura Nao wrote:
> MT8196/MT6991 require a different version of lvts_temp_to_raw(),
> specifically the multiplicative inverse of the existing implementation.
> Introduce a variant of the function with inverted calculation logic to
> match this requirement.
> 
> This ensures accurate raw value generation for temperature
> thresholds, avoiding spurious thermal interrupts or unintended hardware
> resets on MT8196/MT6991.
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Fei Shao <fshao@chromium.org>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index df1c0f059ad0..31796a5b8858 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -300,6 +300,18 @@ static u32 lvts_temp_to_raw(int temperature, int temp_factor)
>   	return div_s64(raw_temp, -temp_factor);
>   }
>   
> +static u32 lvts_temp_to_raw_v2(int temperature, int temp_factor)

Same comment as the previous patch ... _v2 ...




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

