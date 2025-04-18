Return-Path: <linux-pm+bounces-25690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9160A9342A
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 10:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F157D3A7386
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 08:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207BC26AA85;
	Fri, 18 Apr 2025 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yAAwBdLl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1810D202F92
	for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744963622; cv=none; b=sAJMepzWEqztsDHLx/n94X+AAAHmY9+1xlRzyfwki2w47mVCiItxnLwO6Fguen0S9gj3oVg4oaKEtX1aoUhqzuiZVW4xHxYA8xhqSrOTgNynLGVtkcRlwjxGlT57CAJJTD2SpabGiUfIRmTWfBG+8OF4iGPPS4lNDWQsUuqSud8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744963622; c=relaxed/simple;
	bh=4SeNgi1wLdy5CHoMa+2nCAoVEtUaMl4h182JOclLDMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk5F6qK+d1us7OVULn4Gfuye9t1ID61klLJ9EXh/bxSen5NgWT2NqWz/bmlQVcKGAfswMj5gCd5llSFDJ7qt2po6N6AnwRpmZJWNsh9KQxkKZQfQ2Rs5sBatI2pL9PU2o+j6Ry3bCK7ZwzztpEffqfUC8mCJF4c/azF2hC4jzyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yAAwBdLl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso18859905e9.3
        for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 01:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744963618; x=1745568418; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8R7Qp36puqcIKgf+lMIiPQAk3WNF5lMseB0RPPm+UOE=;
        b=yAAwBdLlQpm4RtZYUBRx5AO8726RCP5kRUBLAltRPcYahuwrK1XTDveqrwzDMWByMM
         12UY8xPHXnPbAJIQoOIiWCz6MD52aJMVIxqxU9jVb/ihLfIzGuX6CDVjn6YGeHOgNxvM
         OTt/V0IE/Sikub3PbOVfgEix9FVmHBeQCliVRDhXWvPpgDZInwtcOwwAYOPfqU2TI3bz
         /mDr3IJ+JrJnGdCU/KhjRiltWJ7uwCQBO6aFAkjrvSqZ+OIKTAJ16QdzkOzL1S67OH1y
         JrFYZ27a6v0Kw53I0UhFb0kjz3yGQy53BnYXqRtGm9EmEVsTgyQk5rkJrgnqC4+S+zjG
         YQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744963618; x=1745568418;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8R7Qp36puqcIKgf+lMIiPQAk3WNF5lMseB0RPPm+UOE=;
        b=kTAgbZHijdyeZINjcoikkdxCu6MQ68Elj1JQLuWL3n/NZcZOxV0u7GT0UJTtLZnbIp
         UtGLF+97rz0dprlKQ9rvHZ/8fDIKv/SsI3DaxPXovDTDoVFWOGRcts3nwhYTvAeEdNnO
         zR9LdsYlGJHvnwE4T1DEDPp6sxAhcvr4oPMczwsnJeQEP+KFOlafA46e/aprgous81Q+
         7CHwSIwp0DtBLIRmpTI155xsGv5Vng209WhiCove86dX6eKShDP5W6YmxOXNqwgwru3+
         0RbolB9N1D2NgVUHxJn6bc1ht2fHJvKU1vffLmWr8m/ZcSeZIy5mepUKoLueB26blk+5
         KeHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY5YGNV2JTm0GwULcqSCULZVSX/2lcHuw/d8yMwK46AHRA4vx0UxKZCGuUOQ9PBvEx40SnXH2n7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxodBKmu1o+a+mEOTXKTjujDk+DPh6FRK8NQtFHWSPqPJL3bhqk
	vGmqUBe2moaYkfWa9/aytsUPAgZKtuASnruI/Eqs2CJV+GpTAkUC73exOL8uYEU=
X-Gm-Gg: ASbGncvmlFpQhT8/fO7Zg8BJ8D6oqvB7TvKJLog++IiHVIQwDfXZjG6MSY91iI2vQ33
	dCl3Fu1N2GjmS90xFPav4m59n6ROyDCOMEzQQLw57T91CY2oAxZxJghFbFSN/mnldcAwB4BLhaD
	TrPtMeiQnON6vESZlH6zerZixko8OPMluRT/2La/queM8EZ5cps5ZhGqeWEz8PsEnm+4TT5Lzip
	MUXx4bA78aTD6sGNHqU8ciGF/weK/+wZff0R2sdOZ814Um/pNN/yJMduBoFuLNuH/VHWGmQ6RRx
	/UFZnXKL74FXqTPOyxJPtn6QLtWFdtJTt25G+hSQhOJb1n7QJGKaczOSWjWa16RVzGU/oCYNNaT
	VEKw=
X-Google-Smtp-Source: AGHT+IGroX56fUpTWu8kdLamlS3WqtQ3AvZMCdPeD85f7x29lyEmfTuKBJbY/GKTp63EX5l2l7D2JQ==
X-Received: by 2002:a05:6000:458f:b0:399:7f43:b3a4 with SMTP id ffacd0b85a97d-39efba46366mr1072505f8f.24.1744963618329;
        Fri, 18 Apr 2025 01:06:58 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406e0056c0sm7725435e9.0.2025.04.18.01.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 01:06:57 -0700 (PDT)
Date: Fri, 18 Apr 2025 10:06:55 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>,
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>,
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCH v5 1/3] drivers/thermal/exynos: Refactor clk_sec
 initialization inside SOC-specific case
Message-ID: <aAIIH7H1oQH8cf-6@mai.linaro.org>
References: <20250410063754.5483-1-linux.amoon@gmail.com>
 <20250410063754.5483-2-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250410063754.5483-2-linux.amoon@gmail.com>

On Thu, Apr 10, 2025 at 12:07:48PM +0530, Anand Moon wrote:
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
>     update the commit for clk_sec used.
>     checked to goto clean up all the clks are proper.
>     drop IS_ERR() check for clk_sec.
> v3: improve the commit message.
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 37 ++++++++++++++--------------
>  1 file changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 47a99b3c5395..3657920de000 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -1037,29 +1037,30 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	data->clk = devm_clk_get(dev, "tmu_apbif");
> -	if (IS_ERR(data->clk))
> +	if (IS_ERR(data->clk)) {
>  		return dev_err_probe(dev, PTR_ERR(data->clk), "Failed to get clock\n");

As this branch returns, the else block can be removed.

	if (IS_ERR(data->clk))
		return dev_err_probe(dev, PTR_ERR(data->clk), "Failed to get clock\n");

	ret = clk_prepare(data->clk);
	if (ret) {
		...
	}

May be worth to group both calls with devm_clk_get_enabled()

> -
> -	data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
> -	if (IS_ERR(data->clk_sec)) {
> -		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
> -			return dev_err_probe(dev, PTR_ERR(data->clk_sec),
> -					     "Failed to get triminfo clock\n");
>  	} else {
> -		ret = clk_prepare(data->clk_sec);
> +		ret = clk_prepare(data->clk);
>  		if (ret) {
>  			dev_err(dev, "Failed to get clock\n");
>  			return ret;
>  		}
>  	}
>  
> -	ret = clk_prepare(data->clk);
> -	if (ret) {
> -		dev_err(dev, "Failed to get clock\n");
> -		goto err_clk_sec;
> -	}
> -
>  	switch (data->soc) {
> +	case SOC_ARCH_EXYNOS5420_TRIMINFO:
> +		data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
> +		if (IS_ERR(data->clk_sec)) {
> +			ret = dev_err_probe(dev, PTR_ERR(data->clk_sec),
> +					    "Failed to get clk_sec clock\n");
> +			goto err_clk;
> +		}
> +		ret = clk_prepare(data->clk_sec);

Same comment, devm_clk_get_enabled()

> +		if (ret) {
> +			dev_err(dev, "Failed to prepare clk_sec clock\n");
> +			goto err_clk_sec;
> +		}
> +		break;
>  	case SOC_ARCH_EXYNOS5433:
>  	case SOC_ARCH_EXYNOS7:
>  		data->sclk = devm_clk_get(dev, "tmu_sclk");
> @@ -1112,11 +1113,10 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>  
>  err_sclk:
>  	clk_disable_unprepare(data->sclk);
> +err_clk_sec:
> +	clk_unprepare(data->clk_sec);
>  err_clk:
>  	clk_unprepare(data->clk);
> -err_clk_sec:
> -	if (!IS_ERR(data->clk_sec))
> -		clk_unprepare(data->clk_sec);

With devm_ variant those labels should go away

>  	return ret;
>  }
>  
> @@ -1128,8 +1128,7 @@ static void exynos_tmu_remove(struct platform_device *pdev)
>  
>  	clk_disable_unprepare(data->sclk);
>  	clk_unprepare(data->clk);
> -	if (!IS_ERR(data->clk_sec))
> -		clk_unprepare(data->clk_sec);
> +	clk_unprepare(data->clk_sec);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -- 
> 2.49.0
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

