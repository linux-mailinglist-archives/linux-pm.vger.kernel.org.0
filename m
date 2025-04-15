Return-Path: <linux-pm+bounces-25442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4044DA8970F
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A5E87A5808
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 08:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613641DDA2D;
	Tue, 15 Apr 2025 08:47:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C651C9B9B;
	Tue, 15 Apr 2025 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744706855; cv=none; b=tbP71i9+yGLzeBSMdKtrmLxfk0UmlmePBaxgfLQw7DiRdC20gSBR0Kk57kwv3soHEauA0TCLyxc72lNmVrYl6i/jzAF12aCXHF9KzSySquRQfw1DWwBkSm19StO+uE4WJzulJT1o/hGerO0QqdaMYi9gULA3HWdA7V++lobfpqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744706855; c=relaxed/simple;
	bh=6aaXfc25NEvE47B9WK+pF4wB4Ka8W/SaAt16XdAIFWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=pFrM6lFkxHozEr4HbIsw7VO4UhJAlPHmFBRVOL50NjRiHZCpKeCKvHbFqEZNSeFg9WSSHR/UpFRh58f/PoupX1nGit1yYggm+S8ApqMgvMM2yMqGhu+byD3frg3SIiIVYTzfQiA+NXu4nAZEfJvVtB6ejLUK4yl1CciimK6Edlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AF55339;
	Tue, 15 Apr 2025 01:47:31 -0700 (PDT)
Received: from [10.57.68.100] (unknown [10.57.68.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0AF53F694;
	Tue, 15 Apr 2025 01:47:29 -0700 (PDT)
Message-ID: <0658a7d4-3048-4078-af14-574b87e4122a@arm.com>
Date: Tue, 15 Apr 2025 09:47:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] drivers/thermal/exynos: Refactor clk_sec
 initialization inside SOC-specific case
To: Anand Moon <linux.amoon@gmail.com>
References: <20250410063754.5483-1-linux.amoon@gmail.com>
 <20250410063754.5483-2-linux.amoon@gmail.com>
Content-Language: en-US
Cc: open list <linux-kernel@vger.kernel.org>,
 Justin Stitt <justinstitt@google.com>, Bill Wendling <morbo@google.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>,
 "open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>,
 "open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250410063754.5483-2-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/25 07:37, Anand Moon wrote:
> Refactor the initialization of the clk_sec clock to be inside the
> SOC_ARCH_EXYNOS5420_TRIMINFO case. It ensures that the clk_sec clock
> is only initialized for the specified SOC and not for other SOCs,
> thereby simplifying the code. The clk_sec clock is used by the TMU
> for GPU on the Exynos 542x platform.
> 
> Removed redundant IS_ERR() checks for the clk_sec clock since error
> handling is already managed internally by clk_unprepare() functions.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v5: None
> v4: Fix the aligment of code clk for clk_prepare in proper if/else block.
>      update the commit for clk_sec used.
>      checked to goto clean up all the clks are proper.
>      drop IS_ERR() check for clk_sec.
> v3: improve the commit message.
> ---
>   drivers/thermal/samsung/exynos_tmu.c | 37 ++++++++++++++--------------
>   1 file changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 47a99b3c5395..3657920de000 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -1037,29 +1037,30 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>   		return ret;
>   
>   	data->clk = devm_clk_get(dev, "tmu_apbif");
> -	if (IS_ERR(data->clk))
> +	if (IS_ERR(data->clk)) {
>   		return dev_err_probe(dev, PTR_ERR(data->clk), "Failed to get clock\n");
> -
> -	data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
> -	if (IS_ERR(data->clk_sec)) {
> -		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
> -			return dev_err_probe(dev, PTR_ERR(data->clk_sec),
> -					     "Failed to get triminfo clock\n");
>   	} else {
> -		ret = clk_prepare(data->clk_sec);
> +		ret = clk_prepare(data->clk);
>   		if (ret) {
>   			dev_err(dev, "Failed to get clock\n");
>   			return ret;
>   		}
>   	}
>   
> -	ret = clk_prepare(data->clk);
> -	if (ret) {
> -		dev_err(dev, "Failed to get clock\n");
> -		goto err_clk_sec;
> -	}
> -
>   	switch (data->soc) {
> +	case SOC_ARCH_EXYNOS5420_TRIMINFO:
> +		data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
> +		if (IS_ERR(data->clk_sec)) {
> +			ret = dev_err_probe(dev, PTR_ERR(data->clk_sec),
> +					    "Failed to get clk_sec clock\n");
> +			goto err_clk;
> +		}
> +		ret = clk_prepare(data->clk_sec);
> +		if (ret) {
> +			dev_err(dev, "Failed to prepare clk_sec clock\n");
> +			goto err_clk_sec;
> +		}
> +		break;
>   	case SOC_ARCH_EXYNOS5433:
>   	case SOC_ARCH_EXYNOS7:
>   		data->sclk = devm_clk_get(dev, "tmu_sclk");
> @@ -1112,11 +1113,10 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>   
>   err_sclk:
>   	clk_disable_unprepare(data->sclk);
> +err_clk_sec:
> +	clk_unprepare(data->clk_sec);
>   err_clk:
>   	clk_unprepare(data->clk);
> -err_clk_sec:
> -	if (!IS_ERR(data->clk_sec))
> -		clk_unprepare(data->clk_sec);
>   	return ret;
>   }
>   
> @@ -1128,8 +1128,7 @@ static void exynos_tmu_remove(struct platform_device *pdev)
>   
>   	clk_disable_unprepare(data->sclk);
>   	clk_unprepare(data->clk);
> -	if (!IS_ERR(data->clk_sec))
> -		clk_unprepare(data->clk_sec);
> +	clk_unprepare(data->clk_sec);
>   }
>   
>   #ifdef CONFIG_PM_SLEEP

It looks good. I've missed the v4 where you addressed my comments.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

