Return-Path: <linux-pm+bounces-23185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FADA4A05E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 18:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E015017570E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 17:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC941AA1C9;
	Fri, 28 Feb 2025 17:28:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3113C1F4CBB;
	Fri, 28 Feb 2025 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763729; cv=none; b=YpGHAzozAoZksbggNPgpk+4r37Vrf8YB8AsmxptEXC1ELSMq9aYPMaQSu2xq8vzSUz1uICELaprKbFKelsBTCJ+NcHly6xJ7aBGu9rF+UzOf4lizBX/qZ/BLhLIyGTs2OqQlzsTLA3ObWHVdd+4GDmWEn/P++BFrC4+l56DlC4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763729; c=relaxed/simple;
	bh=a9kQ6V5sbEvFmQom4mCA9pxsi9vl5+Blzhr+rm9bAgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Pa9VMc0Zld16HiCTX4BbigVBdHTwzzucaj3b6VM6AAdmYLK1IBiWlQLiIqPqU0TnvXihU4jieu65Uws+st3o1YCe05FktXCdGTZ/7E9JQMSxXenQWr1FggjHY5C1z4uSP0anG8+4wAB/wxlrjN+vUeWTWthBRbW1/iacxMBn+oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98E59150C;
	Fri, 28 Feb 2025 09:29:02 -0800 (PST)
Received: from [10.57.79.187] (unknown [10.57.79.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BA9B3F6A8;
	Fri, 28 Feb 2025 09:28:45 -0800 (PST)
Message-ID: <f44efd1a-1f6e-456d-9395-de2a55ef2279@arm.com>
Date: Fri, 28 Feb 2025 17:28:43 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] drivers/thermal/exymos: Use guard notation when
 acquiring mutex
To: Anand Moon <linux.amoon@gmail.com>
References: <20250216195850.5352-1-linux.amoon@gmail.com>
 <20250216195850.5352-5-linux.amoon@gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 "open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>,
 "open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>, Zhang Rui <rui.zhang@intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>
In-Reply-To: <20250216195850.5352-5-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/16/25 19:58, Anand Moon wrote:
> Using guard notation makes the code more compact and error handling
> more robust by ensuring that mutexes are released in all code paths
> when control leaves critical section.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v3: new patch
> ---
>   drivers/thermal/samsung/exynos_tmu.c | 21 +++++++--------------
>   1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index fe090c1a93ab..a34ba3858d64 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -256,7 +256,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>   	unsigned int status;
>   	int ret = 0;
>   
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>   	clk_enable(data->clk);
>   	clk_enable(data->clk_sec);
>   
> @@ -270,7 +270,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>   
>   	clk_disable(data->clk_sec);
>   	clk_disable(data->clk);
> -	mutex_unlock(&data->lock);
>   
>   	return ret;
>   }
> @@ -292,13 +291,12 @@ static int exynos_thermal_zone_configure(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>   	clk_enable(data->clk);
>   
>   	data->tmu_set_crit_temp(data, temp / MCELSIUS);
>   
>   	clk_disable(data->clk);
> -	mutex_unlock(&data->lock);
>   
>   	return 0;
>   }
> @@ -325,12 +323,11 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
>   {
>   	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
>   
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>   	clk_enable(data->clk);
>   	data->tmu_control(pdev, on);
>   	data->enabled = on;
>   	clk_disable(data->clk);
> -	mutex_unlock(&data->lock);
>   }
>   
>   static void exynos_tmu_update_bit(struct exynos_tmu_data *data, int reg_off,
> @@ -645,7 +642,7 @@ static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
>   		 */
>   		return -EAGAIN;
>   
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>   	clk_enable(data->clk);
>   
>   	value = data->tmu_read(data);
> @@ -655,7 +652,6 @@ static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
>   		*temp = code_to_temp(data, value) * MCELSIUS;
>   
>   	clk_disable(data->clk);
> -	mutex_unlock(&data->lock);
>   
>   	return ret;
>   }
> @@ -720,11 +716,10 @@ static int exynos_tmu_set_emulation(struct thermal_zone_device *tz, int temp)
>   	if (temp && temp < MCELSIUS)
>   		goto out;
>   
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>   	clk_enable(data->clk);
>   	data->tmu_set_emulation(data, temp);
>   	clk_disable(data->clk);
> -	mutex_unlock(&data->lock);
>   	return 0;
>   out:
>   	return ret;
> @@ -760,14 +755,13 @@ static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
>   
>   	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
>   
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>   	clk_enable(data->clk);
>   
>   	/* TODO: take action based on particular interrupt */
>   	data->tmu_clear_irqs(data);
>   
>   	clk_disable(data->clk);
> -	mutex_unlock(&data->lock);
>   
>   	return IRQ_HANDLED;
>   }
> @@ -987,7 +981,7 @@ static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
>   {
>   	struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
>   
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>   	clk_enable(data->clk);
>   
>   	if (low > INT_MIN)
> @@ -1000,7 +994,6 @@ static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
>   		data->tmu_disable_high(data);
>   
>   	clk_disable(data->clk);
> -	mutex_unlock(&data->lock);
>   
>   	return 0;
>   }

IMO you should be able to even use something like we have
core framework:

guard(thermal_zone)(tz);

Your mutex name is simply 'lock' in the struct exynos_tmu_data
so you should be able to leverage this by:

guard(exynos_tmu_data)(data);

Please try that.

