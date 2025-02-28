Return-Path: <linux-pm+bounces-23175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 704A8A49A47
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 14:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 345367A3B8B
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 13:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0644726D5A6;
	Fri, 28 Feb 2025 13:12:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD9E26BDBB;
	Fri, 28 Feb 2025 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748319; cv=none; b=AuSJ1NY6WmyZgrhsEkyuLhigR+WJ7UHyg4o3tk3yiGVDkvGvKJGXYQi20xhB7zS5OylqD7A/fZzgpsA9NlTQEOGLWgvrFoDCOaPtAmF2O63dloaA4filCOZH5CuBX+p9r1atItPGsGDFZ5HVlhiazmCH80JBhUqls/rlA2qps9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748319; c=relaxed/simple;
	bh=5NIEALQQnGOdsbsJJspo0aA9XnKgPp6WO3Iul21ZOj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VmnNqTbbCS+trLEAxGFG/YuTTcVibrmUaLyWEruUvCUuc99HiMGZ+ntZk9GRL0ohF3AKeY5NWzFwV0ndlI15Zn86d/FL2I3o1x/i5Ov8KvPulM4loGhMUW8rYpTlq3/CrfC6z6BbkhxK+9yIFwOqCQz+La/mlbOT2pX6mYWEFrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A4B81688;
	Fri, 28 Feb 2025 05:12:12 -0800 (PST)
Received: from [10.57.79.187] (unknown [10.57.79.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4470B3F673;
	Fri, 28 Feb 2025 05:11:55 -0800 (PST)
Message-ID: <99ee61dc-abd5-45d9-8d26-a8f0ae94c8eb@arm.com>
Date: Fri, 28 Feb 2025 13:11:52 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] thermal: thermal-generic-adc: add temperature
 sensor channel
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-kernel@vger.kernel.org
References: <20250219082817.56339-1-clamor95@gmail.com>
 <20250219082817.56339-3-clamor95@gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250219082817.56339-3-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Svyatoslav,

On 2/19/25 08:28, Svyatoslav Ryhel wrote:
> Add IIO sensor channel along with existing thermal sensor cell. This
> would benefit devices that use adc sensors to detect temperature and
> need a custom conversion table.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   drivers/thermal/thermal-generic-adc.c | 54 ++++++++++++++++++++++++++-
>   1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
> index ee3d0aa31406..a8f3b965b39b 100644
> --- a/drivers/thermal/thermal-generic-adc.c
> +++ b/drivers/thermal/thermal-generic-adc.c
> @@ -7,6 +7,7 @@
>    * Author: Laxman Dewangan <ldewangan@nvidia.com>
>    */
>   #include <linux/iio/consumer.h>
> +#include <linux/iio/iio.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> @@ -73,6 +74,57 @@ static const struct thermal_zone_device_ops gadc_thermal_ops = {
>   	.get_temp = gadc_thermal_get_temp,
>   };
>   
> +static const struct iio_chan_spec gadc_thermal_iio_channel[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	}
> +};
> +
> +static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int *temp, int *val2, long mask)
> +{
> +	struct gadc_thermal_info *gtinfo = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (mask != IIO_CHAN_INFO_PROCESSED)
> +		return -EINVAL;
> +
> +	ret = gadc_thermal_get_temp(gtinfo->tz_dev, temp);
> +	if (ret < 0)
> +		return ret;
> +
> +	*temp /= 1000;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static const struct iio_info gadc_thermal_iio_info = {
> +	.read_raw = gadc_thermal_read_raw,
> +};
> +
> +static int gadc_iio_register(struct device *dev, struct gadc_thermal_info *gti)
> +{
> +	struct gadc_thermal_info *gtinfo;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct gadc_thermal_info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	gtinfo = iio_priv(indio_dev);
> +	memcpy(gtinfo, gti, sizeof(struct gadc_thermal_info));
> +
> +	indio_dev->name = dev_name(dev);
> +	indio_dev->info = &gadc_thermal_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = gadc_thermal_iio_channel;
> +	indio_dev->num_channels = ARRAY_SIZE(gadc_thermal_iio_channel);
> +
> +	return devm_iio_device_register(dev, indio_dev);

I don't get the idea why we need iio device, while we already have the
hwmon.

Could you explain this a bit more, the cover letter also misses
such justification and details.

Regards,
Lukasz

