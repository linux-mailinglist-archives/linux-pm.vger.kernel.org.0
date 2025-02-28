Return-Path: <linux-pm+bounces-23179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65190A49C29
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 15:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E65577A3C15
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 14:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE6B26FDA1;
	Fri, 28 Feb 2025 14:37:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA8E26FD84;
	Fri, 28 Feb 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753451; cv=none; b=Gx/GtLg61jpUqgA1sZbsxA2dfkeQ3kv6Ua5gCzFw8XBIVL5KsvbAEkx0XXuBSkURZOqbkOp+hGVYygrzqqxEw9RbvLw7MSjRc9ZyhkkPbqefK5rmUNRSx6cg6WPUkLJTanhY9upzCEKRCEmFUAXCnkJuKT/ixCxKlB+Y2ZgfuB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753451; c=relaxed/simple;
	bh=yMgIGlMHYKOZUSzIfEj56HpFq1oS5jJiBWijR4VLAog=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=k4gHhrUzQguQtYwp/ua87YORF1odJ9gYbLgp7NvB3KQSmy7gvLtJ9kQGCn2fQHn1Ni7YpZ8n8GRFOTW2cBXRFK8ghdegsDwyreWB74158S539Fx+Yc/9eWe96yLtTBdUT8nHEEIpJt+n6z6F/fcMdBoMOoJ8ITez0NmocfkLmWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 567C91515;
	Fri, 28 Feb 2025 06:37:44 -0800 (PST)
Received: from [10.57.79.187] (unknown [10.57.79.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E15E3F6A8;
	Fri, 28 Feb 2025 06:37:26 -0800 (PST)
Message-ID: <e101aff2-a08e-4fed-8e38-df1aea44d23e@arm.com>
Date: Fri, 28 Feb 2025 14:37:24 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drivers/thermal/exynos: Refactor clk_sec
 initialization inside SOC-specific case
To: Anand Moon <linux.amoon@gmail.com>
References: <20250216195850.5352-1-linux.amoon@gmail.com>
 <20250216195850.5352-2-linux.amoon@gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 "open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>,
 Zhang Rui <rui.zhang@intel.com>,
 "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20250216195850.5352-2-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Anand,

On 2/16/25 19:58, Anand Moon wrote:
> Refactor the initialization of the clk_sec clock to be inside the
> SOC_ARCH_EXYNOS5420_TRIMINFO case. It ensures that the clk_sec clock
> is only initialized for the specified SOC and not for other SOCs,
> thereby simplifying the code.

So IIUC there was no need to init that clock for other types of SoCs...
Do we know that for sure (e.g. from other TRMs)?

If that was the case, then simplification here can go further, but after
some fixes.

> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v3: improve the commit message
> ---
>   drivers/thermal/samsung/exynos_tmu.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 47a99b3c5395..9c138772d380 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -1040,19 +1040,6 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>   	if (IS_ERR(data->clk))
>   		return dev_err_probe(dev, PTR_ERR(data->clk), "Failed to get clock\n");
>   
> -	data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
> -	if (IS_ERR(data->clk_sec)) {
> -		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
> -			return dev_err_probe(dev, PTR_ERR(data->clk_sec),
> -					     "Failed to get triminfo clock\n");
> -	} else {
> -		ret = clk_prepare(data->clk_sec);
> -		if (ret) {
> -			dev_err(dev, "Failed to get clock\n");
> -			return ret;
> -		}
> -	}
> -
>   	ret = clk_prepare(data->clk);

Here the data->clk is now used in different order.

>   	if (ret) {
>   		dev_err(dev, "Failed to get clock\n");
> @@ -1060,6 +1047,19 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>   	}
>   
>   	switch (data->soc) {
> +	case SOC_ARCH_EXYNOS5420_TRIMINFO:
> +		data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
> +		if (IS_ERR(data->clk_sec)) {
> +			return dev_err_probe(dev, PTR_ERR(data->clk_sec),
> +					     "Failed to get triminfo clock\n");

Then here you shouldn't simply copy the old code. Now the data->clk
is first, so should be 'clk_unprepare()' before return of the function.

> +		} else {

You can get rid of this 'else' above and still be safe in your
refactoring.

> +			ret = clk_prepare(data->clk_sec);
> +			if (ret) {
> +				dev_err(dev, "Failed to get clock\n");
> +				return ret;
> +			}

Here you can further simplify this to something like:
-----------------------8<-------------------------------------

+	case SOC_ARCH_EXYNOS5420_TRIMINFO:
+		data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
+		if (IS_ERR(data->clk_sec)) {
+			clk_unprepare(data->clk); ///// <----
+			return dev_err_probe(dev, PTR_ERR(data->clk_sec),
+					     "Failed to get triminfo clock\n");
+		}
+		ret = clk_prepare(data->clk_sec);
+		if (ret) {
+			dev_err(dev, "Failed to get clock\n");
+			clk_unprepare(data->clk); ///// <----
+			return ret;
+		}
+
+	break;

--------------------------->8---------------------------------

Or with better 'goto' flow.

> +		}
> +	break;
>   	case SOC_ARCH_EXYNOS5433:
>   	case SOC_ARCH_EXYNOS7:
>   		data->sclk = devm_clk_get(dev, "tmu_sclk");


Also, you should revisit the 'goto' cleanup section at the bottom.

Regards,
Lukasz

