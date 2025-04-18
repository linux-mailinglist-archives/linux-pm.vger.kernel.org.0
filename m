Return-Path: <linux-pm+bounces-25691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE37A93433
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 10:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666481B61DFD
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 08:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24AE26AABC;
	Fri, 18 Apr 2025 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMLkeJl9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B826AA85
	for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744963883; cv=none; b=qdHW7JfagHlnWeBYZbLXf0S/OwfcR+8K/+MD1jOxQEcY8oT+G76sSrIhb6wmvSprOaNA4JuUn5Ob13D7W9xOcfEk4DqLR0R71lZTPUtpkCENtR/I02d7Pdop6zOMX0+kZxKiaoG2TBOG4jQJ2oQYyn60os8+00bf97PWgTYwCaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744963883; c=relaxed/simple;
	bh=JTfpzxPO7tlw1FRlN8arOMR/8L4Ql6vMZq9I1vDRuzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nl0KM+0kNwj6bwvMT2C+v0/6i/5jvuB5kq0baqvHNZqjnuD8fP4eM+Nn8zxl1xycHlNIS8z+eVLtSjoDfpnsLxq7899bAkH0T7Xyux/LAtlf/cy5MscGdyhs/GOJvB1ShIGWydkVn79lt0U+6JCdW1hfNhPOnlQf9lLkA7nHGsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WMLkeJl9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d0618746bso11574435e9.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 01:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744963878; x=1745568678; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hBAVQUSIG8/FVcTA2w6Be8v3FlriNZP6ZHZpLpZIhIc=;
        b=WMLkeJl9lZabsHs40IjQE+sxYfoS3TbFdDZ3RKrWXzxn/WMLfVPnXQWr+Nlby4D2+W
         TqURlXHe5M9V0icpM7CVVk9tlE8u1JphMBEb46tFjmQIWqpm4YYtBXHmYmv2gyr0FdIe
         RRDKGzxHieIwOCx/2ayR+LGNkzEdtmTvzVSqVtWUrEuKoUfsLT0iHVAUCY7mJR65jqui
         9Hwr+t9UTnMmsdS2KDWOCqDpBY+CmBabonpfZvIFs5gqLPj1YYU6qqSC3Q3lAU4pC4qo
         0hv2qroh1ax7fQxqKCgaPasGBUATg95TpanneKTUhI2ue67pvU086ne0Le+9KEf6ZTws
         aH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744963878; x=1745568678;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBAVQUSIG8/FVcTA2w6Be8v3FlriNZP6ZHZpLpZIhIc=;
        b=oJC9QF73fMLPq4U36CgF1wCqES7gS7v43Y1YQ5DHMatfB2uWX9jXmN9W1FiH3P+3zq
         rdA5dONY/rJn79I7Y/6vBnstcLqSIXTUEaRgWhcmWKvehvSax8V5+ylxaDke6DxJdvsF
         IsvbQJJ2l+sGT8i+Ic/kL14FSvOBG1NOWzYKuz5GKs/FP0zd5yAqI1n/3E3S5eJjFJwZ
         /P5/gcI8R9MNzN5cNi1bGXDhL+YzlwqUXhnf9BAk0+RntUKTYi/l7rTE+NCsmL8gaalP
         vx9BVxdZ0G4pmk+j20w1S3fsiIcLjgUqxX1UWGwdWKSdllT5xGJM3MXC+5ujOCaZMPp/
         lUrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6bQ+Pi1OtHernyzjDwR2FCIhB1Z5ezIPVTUVT7ng6ai2+j08ZO1glG4QsAbhpvpERjvcakMUgKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+lpodgvXdt0oU7Htr1UfEQHw/ROBHC5FVtyKA1iWbIE8f4K60
	n8DXsLr0iPCrlsVeSRlsGeMpDh7GsRJOIWm6wfCvzweUXWcf+taZ781LjPJ53zQ=
X-Gm-Gg: ASbGncvoxU/1hI1Hk0okeS0vqdmlFVrvNaj5pqnNgGDIAryRxy14PEE3+lCINqxGTZo
	+fKsp6bmqm1qG+xftAtIA1VVNAWl2XLQjmvn2dcIaEY55WxGNGBktmGrjqmC4Y53hlaSbemnd4S
	TbESYY8rGn02/ZdkCRyWkJ45YRHk597x92AxCkH1pPkm9tLqHyyH1WYqTtgLq1NrThB5zTpicO0
	yLYFbYKmAhkZz8oGtkPuRkXNk12wEhHRSjZ2FPoZ2gInSnj2W/xockOkm2ZSY/nj6gBj8ixaV+g
	FzJelJXzyRs5NrXUO36jrFCPeLjxGELLC+e80cCiim5BuKyIVPHqPqNGab/39INjavZF1lD+g/t
	0wGjK0ZwLDum6kw==
X-Google-Smtp-Source: AGHT+IEqy72HPc2JLxk7cwyoLf4zIk+ZCEFJN86qbQUa/AJZooBD3mTTOHD22C31nQiUieXQmKAm3g==
X-Received: by 2002:a05:600c:4ecc:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-4406ac0aec8mr10500975e9.22.1744963878336;
        Fri, 18 Apr 2025 01:11:18 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5bbd12sm12743035e9.20.2025.04.18.01.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 01:11:17 -0700 (PDT)
Date: Fri, 18 Apr 2025 10:11:16 +0200
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
Subject: Re: [PATCH v5 2/3] drivers/thermal/exymos: Remove redundant IS_ERR()
 checks for clk_sec clock
Message-ID: <aAIJJKGif3i3-97g@mai.linaro.org>
References: <20250410063754.5483-1-linux.amoon@gmail.com>
 <20250410063754.5483-3-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250410063754.5483-3-linux.amoon@gmail.com>

On Thu, Apr 10, 2025 at 12:07:49PM +0530, Anand Moon wrote:
> Remove unnecessary IS_ERR() checks for the clk_sec clock,
> the clk_enable() and clk_disable() functions can handle NULL clock
> pointers, so the additional checks are redundant and have been removed
> to simplify the code.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Typo in the subject: s/exymos/exynos/

> ---
> v5: None
> v4: drop IE_ERR() for clk_unprepare() as its handle in earlier code.
> v3: improve the commit message.
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 3657920de000..ac3b9d2c900c 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -258,8 +258,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>  
>  	mutex_lock(&data->lock);
>  	clk_enable(data->clk);
> -	if (!IS_ERR(data->clk_sec))
> -		clk_enable(data->clk_sec);
> +	clk_enable(data->clk_sec);
>  
>  	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
>  	if (!status) {
> @@ -269,8 +268,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>  		data->tmu_clear_irqs(data);
>  	}
>  
> -	if (!IS_ERR(data->clk_sec))
> -		clk_disable(data->clk_sec);
> +	clk_disable(data->clk_sec);
>  	clk_disable(data->clk);
>  	mutex_unlock(&data->lock);

To be replaced by devm_clk_get_enabled() ?

>  
> -- 
> 2.49.0
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

