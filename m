Return-Path: <linux-pm+bounces-25439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88947A896E5
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEA01893196
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 08:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E33275860;
	Tue, 15 Apr 2025 08:38:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B741D618A;
	Tue, 15 Apr 2025 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744706298; cv=none; b=cOOKjsQXyvTo7CNcyc3ANXN4HlJnBnYuzibSmTQa3IwvLX3nk58kLDFX+AFRyx7bB4GCBsFhfWvdvFhC3D8xXnAEZ8tLmkZWAVvqgUEeaaZ9WLqDRe+fgK/+y+mADvnK2OYLqU+LGbLCtB3TND6rP9ljx38Qfsc9QP/6V3W1Ur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744706298; c=relaxed/simple;
	bh=6nyT0B2Wu/FJxNO/grPfVw0tV/iEqvAx/3v/1AOBHWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=UkMNHK6+59R1l1iZaYP/NYVIFrTh+kVyinmCdOILYPkR3/8BrXwp1XcYy29leDVWiwQcAu3RTaiO+BsERJN5ziy649ZunxvJBE01iYsbCGooO5dsGvdggwBMLohBnvIIaT2zhKS5fAEOASvdETeLnHd3bnwm8YWazqKWoLy79YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17008339;
	Tue, 15 Apr 2025 01:38:14 -0700 (PDT)
Received: from [10.57.68.100] (unknown [10.57.68.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB1983F694;
	Tue, 15 Apr 2025 01:38:12 -0700 (PDT)
Message-ID: <9d73c1e0-d60d-4c3e-91ff-e38cc2cd1b98@arm.com>
Date: Tue, 15 Apr 2025 09:38:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] drivers/thermal/exymos: Remove redundant IS_ERR()
 checks for clk_sec clock
To: Anand Moon <linux.amoon@gmail.com>
References: <20250410063754.5483-1-linux.amoon@gmail.com>
 <20250410063754.5483-3-linux.amoon@gmail.com>
Content-Language: en-US
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 "open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>,
 Justin Stitt <justinstitt@google.com>, Bill Wendling <morbo@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>,
 "open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250410063754.5483-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/25 07:37, Anand Moon wrote:
> Remove unnecessary IS_ERR() checks for the clk_sec clock,
> the clk_enable() and clk_disable() functions can handle NULL clock
> pointers, so the additional checks are redundant and have been removed
> to simplify the code.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v5: None
> v4: drop IE_ERR() for clk_unprepare() as its handle in earlier code.
> v3: improve the commit message.
> ---
>   drivers/thermal/samsung/exynos_tmu.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 3657920de000..ac3b9d2c900c 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -258,8 +258,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>   
>   	mutex_lock(&data->lock);
>   	clk_enable(data->clk);
> -	if (!IS_ERR(data->clk_sec))
> -		clk_enable(data->clk_sec);
> +	clk_enable(data->clk_sec);
>   
>   	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
>   	if (!status) {
> @@ -269,8 +268,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>   		data->tmu_clear_irqs(data);
>   	}
>   
> -	if (!IS_ERR(data->clk_sec))
> -		clk_disable(data->clk_sec);
> +	clk_disable(data->clk_sec);
>   	clk_disable(data->clk);
>   	mutex_unlock(&data->lock);
>   


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

