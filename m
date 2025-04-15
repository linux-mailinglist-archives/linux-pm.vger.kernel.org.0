Return-Path: <linux-pm+bounces-25438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033D8A896E0
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696F3188AFB7
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 08:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C44275107;
	Tue, 15 Apr 2025 08:37:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C411D618A;
	Tue, 15 Apr 2025 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744706224; cv=none; b=NVsnQs8wC+cwJogAd5P/+LeUrn3g25EjtzqNAhby2oAXbARWVsJmlG4x2SMlMpxmo2sEUKNxvwkfDfOlDw/yCe6DjcEsjix8FrPWu9O6yX72msom0tFU+8kogfehWJLWbjcBcVn65+Bw3oOQ1nBSTzIUiuMt/p625ojfsmJTMC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744706224; c=relaxed/simple;
	bh=R/ubAIoevAV3mGWYv95flteGTRaTDejxRF0LQgRjdpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=WuGPL+mTE+rDfSHt9C8/h6ppC4A9v5edG+L5JnpjuJz1CsV72Zfs8I91Z1a3yscwe7MrGuBUqnseIZOypJkvt0nqdWGFzvvwoqZdk1+Q9fqmISl8pR674KzhCMWn5lTCeOvUu+j1P1WGKDPbHMFczzdQe9sCMSW2NWciMvGmi00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95EBF339;
	Tue, 15 Apr 2025 01:37:00 -0700 (PDT)
Received: from [10.57.68.100] (unknown [10.57.68.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58BBB3F694;
	Tue, 15 Apr 2025 01:36:59 -0700 (PDT)
Message-ID: <6abf897b-bbde-4586-941d-9915f15f1934@arm.com>
Date: Tue, 15 Apr 2025 09:36:56 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] drivers/thermal/exymos: Fixed the efuse min max
 value for exynos5422
To: Anand Moon <linux.amoon@gmail.com>
References: <20250410063754.5483-1-linux.amoon@gmail.com>
 <20250410063754.5483-4-linux.amoon@gmail.com>
Content-Language: en-US
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 "open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>,
 Justin Stitt <justinstitt@google.com>, Bill Wendling <morbo@google.com>,
 Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>,
 "open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250410063754.5483-4-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/25 07:37, Anand Moon wrote:
> As per Exynos5422 user manual e-Fuse range min~max range is 16~76.
> if e-Fuse value is out of this range, then thermal sensor may not
> sense thermal data properly. Refactors the efuse value
> initialization logic within exynos_map_dt_data function by
> replacing the nested if-else statements with a switch statement.
> Ensures proper initialization of efuse values based on the SOC type.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v5: None
> v4: None
> v3: Improve the logic to convert if/else to switch
> ---
>   drivers/thermal/samsung/exynos_tmu.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index ac3b9d2c900c..a71cde0a4b17 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -899,12 +899,23 @@ static int exynos_map_dt_data(struct platform_device *pdev)
>   		data->gain = 8;
>   		data->reference_voltage = 16;
>   		data->efuse_value = 55;
> -		if (data->soc != SOC_ARCH_EXYNOS5420 &&
> -		    data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO)
> +		data->max_efuse_value = 100;
> +		switch (data->soc) {
> +		case SOC_ARCH_EXYNOS3250:
> +		case SOC_ARCH_EXYNOS4412:
> +		case SOC_ARCH_EXYNOS5250:
> +		case SOC_ARCH_EXYNOS5260:
>   			data->min_efuse_value = 40;
> -		else
> +			break;
> +		case SOC_ARCH_EXYNOS5420:
> +		case SOC_ARCH_EXYNOS5420_TRIMINFO:
> +			data->min_efuse_value = 16;
> +			data->max_efuse_value = 76;
> +			break;
> +		default:
>   			data->min_efuse_value = 0;
> -		data->max_efuse_value = 100;
> +			break;
> +		}
>   		break;
>   	case SOC_ARCH_EXYNOS5433:
>   		data->tmu_set_low_temp = exynos5433_tmu_set_low_temp;

I should have added that in earlier version: LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

