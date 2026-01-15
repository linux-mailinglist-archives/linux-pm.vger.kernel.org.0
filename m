Return-Path: <linux-pm+bounces-40927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2398FD24B6E
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 14:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 976CA300EE6E
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 13:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411093A0B33;
	Thu, 15 Jan 2026 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jlAon3Pp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8768539526D
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483267; cv=none; b=K5hrd40g6rgh0LMFunc8u/ggQodYr0iT9UH4TcR2CAO+MXoB0mrKRYM6Tpnzg66hVUubGXBlnb9vEzuBnoRZ2s1ChThOInz4Z1juNw46JeTSHhq5RjwML4PhEE8bru8YgMSVBXIY/UJ6TmfO+/cdG6Chqfx8hAmGUfmnqR0upm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483267; c=relaxed/simple;
	bh=abcUDzMsgI0NC3SXlFQOTmLmr7KJcSauM8GeBtGxewE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlbQQ8AJJRfN+30l+vOTxLMSVWML6kPDyUeNunKcRfNxdPYLG6TYRZoDd26Bn2arEDgEVbq4YjUObBCckC9rr5yU3GFKtLedtHXDbtrS2vld7Ye8xnIcudNG/bwAEZDdzDE5rBNntroyXx0XUQx8PPYiuthHptNc8QuWBDMMJlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jlAon3Pp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b872cf905d3so149563566b.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 05:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768483263; x=1769088063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=po4SDkFceK6L+A0r9CoW5e+XAeuKVFUf0lqkYgvkprY=;
        b=jlAon3PpurmiNxWJFMaLDcAYNMKICmkJqYtl9t8bvsbkTI8e2QStLKRG0ix0u4K+Xf
         FBT0a6gsS02xlw9J3T2s8hOvnUqxmYldl+HR07gQZ8syA9WxINMNlg2I7+46eHx95N4Q
         LzxwsVNdqW28NDIhereW4XkwFVDmmLBCd2en05MpuevG9pYEQ0nS/AGeiahTOclholuP
         4yaVkClhSr7kTI/5eyV782R8c5LteKYjKeNkGxayIFTrgY7FBixIj3B5KPdpEIMWXwah
         fJ7qqfSHUFEP5zEHILOd4i446EEYZ9HFzFgWPMFhNw5opMHvTIwvXZmg0Gnorv+5R2J9
         HArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768483263; x=1769088063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=po4SDkFceK6L+A0r9CoW5e+XAeuKVFUf0lqkYgvkprY=;
        b=bmFB5FNBvpt7lmGjnTqQccJXYRv3LW95rCMIDIV9s6P1zJLdSWmR04QTK909b7ThrX
         zaUj4LyGsqf1xvGqG2wW1UAW4mSDzUyflF+Y0imEu/3w+Ez3zXEtmu0SmodanW3bS5HD
         LPcL9mYFM3wxjldqz+BwMtWajuj4K6uZmW8ZEc+xK4i3hs5b5X8lUVSgDwkVrW5rTJc6
         lvZafC/yZeRTUiv7voRuiNuNy5jJTQTPMtoycHY7bG8Ez7CkJxtBF1Ssm0B8mdxZisl2
         o0SNkAvZ2yWOvUo21pFlz3mAI5PjTziDXKilD2dqXYkgyzAdrc0Zr9KbaUxc8k0A4iyZ
         36ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXm6d/903YY9YUh23G5GL/HwN33tiahbjqClQ8FxFm5GyYEuu5d857E7n3BgVKKchw55pigiE/KWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1QKaCUj7U0AkVnCOrbM7YlLrW5eXtKZ6epr23GIysQ45/2lm7
	8vWTOSVpwXG7gs7IZ024KlUaZRZtxCNoVe99wEibVdv1Bjd/2vk7ZV60F2vZEzVs1Ps=
X-Gm-Gg: AY/fxX5PpkV7Zoa2ct1BESx/0SLBhuaLsaLe3wJSikDFOI7UDPOmz1qlSgpAznFQr6G
	QCHcsuvzrE1m+MlGCMfUKGHmPhJzehpQTp/seCCVPS4biCrUuBcdY6fqGNYmxEhjO8KSs7ArIrA
	70FpoXsyXYRM7d0SsKVlUw15bVyanfQd9aTwOLUuAjdu7R4Rwcc6Fi9wh+mgoYL8ChSiy77N+A0
	zG1DuNwneWMexeoTSKm2+utN6S0nG+GMI/ABbvqJPd7S7CYAzcB35Sjc6D+BRwOHoAYYV+7pVP7
	uIiQN0byNE7SNnCnYC2jmirpf+3JXJIfLXfxWi4ZE2oME0n9KNAvss0qhGHCsQ6nfXFZAf/VPld
	G90tVyNMtAKYstZuq8rR0K4RahmRag/3MJ/ZpA3nRL1wcS7aJFfXhb3agV+tYwFeHObT8OGMg2U
	i55CyM/8dtfMWdKkoSWQ==
X-Received: by 2002:a17:906:f58a:b0:b7a:39a2:7f50 with SMTP id a640c23a62f3a-b876113a364mr534982066b.39.1768483262801;
        Thu, 15 Jan 2026 05:21:02 -0800 (PST)
Received: from [10.11.12.107] ([86.127.43.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8767042186sm467121766b.0.2026.01.15.05.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 05:21:02 -0800 (PST)
Message-ID: <f7d75089-732b-42c8-a5f6-2e42e6e82c26@linaro.org>
Date: Thu, 15 Jan 2026 15:21:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: defconfig: enable Exynos ACPM thermal support
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
 <20260114-acpm-tmu-v1-8-cfe56d93e90f@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260114-acpm-tmu-v1-8-cfe56d93e90f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 4:16 PM, Tudor Ambarus wrote:
> Enable the Exynos ACPM thermal driver (CONFIG_EXYNOS_ACPM_THERMAL)
> to allow temperature monitoring and thermal management on Samsung
> Exynos SoCs that use the Alive Clock and Power Manager (ACPM)
> protocol.
> 
> This ensures that thermal zones are properly exposed and handled on
> platforms such as the GS101.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 45288ec9eaf7365427d98195c48e2f8065a8bb1b..1bfe37857f51663c9d745cd575f107fef183008f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -752,6 +752,7 @@ CONFIG_BCM2711_THERMAL=m
>  CONFIG_BCM2835_THERMAL=m
>  CONFIG_BRCMSTB_THERMAL=m
>  CONFIG_EXYNOS_THERMAL=y
> +CONFIG_EXYNOS_ACPM_THERMAL=y

I should have made this a module. Will update after I get some feedback
on the rest of the patches.

>  CONFIG_TEGRA_SOCTHERM=m
>  CONFIG_TEGRA_BPMP_THERMAL=m
>  CONFIG_GENERIC_ADC_THERMAL=m
> 


