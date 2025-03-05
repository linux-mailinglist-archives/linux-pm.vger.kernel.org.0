Return-Path: <linux-pm+bounces-23476-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0171A4FAA2
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 10:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BCC1701CB
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 09:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CBE2054F5;
	Wed,  5 Mar 2025 09:52:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290ED2054E6;
	Wed,  5 Mar 2025 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168342; cv=none; b=CmTlZfo0Ao+YCZfgmSLdtJk5/wRVE8VRF6bj4MVOpQQJyhNahnBTvIDE7w7gIY49KGQkwLyBwD5Zg9HWBIVoEPpNP5BTp805u0HHPO4U+Ong90IIwCtfSf+yBWuRLxBCLxOrXBH+JGO9bnaLIazzWVIVV1aWx/nZoEr312AqIsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168342; c=relaxed/simple;
	bh=ceuSJAT3QrXodpoT1Pny1OHh3M18ay1mM3xm6QAoicE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXeT5TnpJE4R3Qcxbyl3yK89Hl6uR2+f0wEH6qxOBcr8t5MEpJKaowFgkSuGVdZGQuFLrRounVwzbftJI7mdbf1vqg7kX81i2w/Y2Z5Rq8BiBmApm7NgKVkk1dV0OiEDkYf+Btdo1NAlFqSE334xaZ6DwJdgC0IupGnr4e0nLVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF11AFEC;
	Wed,  5 Mar 2025 01:52:32 -0800 (PST)
Received: from [10.57.64.200] (unknown [10.57.64.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B87A3F673;
	Wed,  5 Mar 2025 01:52:17 -0800 (PST)
Message-ID: <3bc7c5a5-8fe7-4c4b-a80e-23522922debb@arm.com>
Date: Wed, 5 Mar 2025 09:52:15 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] thermal: thermal-generic-adc: add temperature
 sensor channel
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 Laxman Dewangan <ldewangan@nvidia.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20250303122151.91557-1-clamor95@gmail.com>
 <20250303122151.91557-3-clamor95@gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250303122151.91557-3-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/3/25 12:21, Svyatoslav Ryhel wrote:
> To avoid duplicating sensor functionality and conversion tables, this design
> allows converting an ADC IIO channel's output directly into a temperature IIO
> channel. This is particularly useful for devices where hwmon isn't suitable
> or where temperature data must be accessible through IIO.
> 
> One such device is, for example, the MAX17040 fuel gauge.
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

I would add the IIO_CHAN_INFO_SCALE and say it's in milli-degrees.

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

Therefore, here it would need to handle such case as well, when
a client is asking about scale.

> +
> +	ret = gadc_thermal_get_temp(gtinfo->tz_dev, temp);
> +	if (ret < 0)
> +		return ret;
> +
> +	*temp /= 1000;

IMO we shouldn't cut the precision if it's provided.
The user of this would know what to do with the value (when
the proper information about scale is also available).

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
> +}
> +
>   static int gadc_thermal_read_linear_lookup_table(struct device *dev,
>   						 struct gadc_thermal_info *gti)
>   {
> @@ -153,7 +205,7 @@ static int gadc_thermal_probe(struct platform_device *pdev)
>   
>   	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
>   
> -	return 0;
> +	return gadc_iio_register(&pdev->dev, gti);
>   }
>   
>   static const struct of_device_id of_adc_thermal_match[] = {

