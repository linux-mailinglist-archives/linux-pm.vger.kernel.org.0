Return-Path: <linux-pm+bounces-23273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF02CA4BCF5
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61B4170015
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 10:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2D71F4179;
	Mon,  3 Mar 2025 10:53:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF63E1D86DC;
	Mon,  3 Mar 2025 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999209; cv=none; b=Hfe5RD4LKxqvlI7fnjIh7gC7QS4GIjETAS3UDTJeuULZXMDxLYAt9e2TcE0QQH9pDhk516ZAC5ngGfLnEqSAiIscQg04WcUcDxKjNiUh9b3IVbPlKr5/3QFRAmuXSMvMr2ZdkenMnx9ezTdUHtQK569eHO6jp5mF5vjlerzNkp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999209; c=relaxed/simple;
	bh=D/JJYc7CC4L1PwjxPEAjthi7kwvPmgsbn4RERhgQtLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+UMx2DQ/RkcIvGNQ7TVK03HE5P1zx9zwVQrYVCWa/aDN05x1bZbVq0hEViBC6J3BkzXdJusI0EAA0Jpysb3vB1tt2IoxN0g0sVxhmxf0BW0jQsW5YWKom36z4qWkQ77AfCk54YokHeigCPT+0bg56COmLm5hxWTlpjd6fKmv2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29C9E1FC7;
	Mon,  3 Mar 2025 02:53:41 -0800 (PST)
Received: from [10.57.66.216] (unknown [10.57.66.216])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 491443F778;
	Mon,  3 Mar 2025 02:53:25 -0800 (PST)
Message-ID: <93ddb2d9-ce3d-4e6d-bf5f-0b30b2d04d84@arm.com>
Date: Mon, 3 Mar 2025 10:53:23 +0000
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
 <99ee61dc-abd5-45d9-8d26-a8f0ae94c8eb@arm.com>
 <CAPVz0n0uWEY+-evrfpci9-1c3icGyHfTHMbXi=P9Sv=Uh3AUaA@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAPVz0n0uWEY+-evrfpci9-1c3icGyHfTHMbXi=P9Sv=Uh3AUaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/28/25 13:22, Svyatoslav Ryhel wrote:
> пт, 28 лют. 2025 р. о 15:11 Lukasz Luba <lukasz.luba@arm.com> пише:
>>
>> Hi Svyatoslav,
>>
>> On 2/19/25 08:28, Svyatoslav Ryhel wrote:
>>> Add IIO sensor channel along with existing thermal sensor cell. This
>>> would benefit devices that use adc sensors to detect temperature and
>>> need a custom conversion table.
>>>
>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>> ---
>>>    drivers/thermal/thermal-generic-adc.c | 54 ++++++++++++++++++++++++++-
>>>    1 file changed, 53 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
>>> index ee3d0aa31406..a8f3b965b39b 100644
>>> --- a/drivers/thermal/thermal-generic-adc.c
>>> +++ b/drivers/thermal/thermal-generic-adc.c
>>> @@ -7,6 +7,7 @@
>>>     * Author: Laxman Dewangan <ldewangan@nvidia.com>
>>>     */
>>>    #include <linux/iio/consumer.h>
>>> +#include <linux/iio/iio.h>
>>>    #include <linux/kernel.h>
>>>    #include <linux/module.h>
>>>    #include <linux/platform_device.h>
>>> @@ -73,6 +74,57 @@ static const struct thermal_zone_device_ops gadc_thermal_ops = {
>>>        .get_temp = gadc_thermal_get_temp,
>>>    };
>>>
>>> +static const struct iio_chan_spec gadc_thermal_iio_channel[] = {
>>> +     {
>>> +             .type = IIO_TEMP,
>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>>> +     }
>>> +};
>>> +
>>> +static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
>>> +                              struct iio_chan_spec const *chan,
>>> +                              int *temp, int *val2, long mask)
>>> +{
>>> +     struct gadc_thermal_info *gtinfo = iio_priv(indio_dev);
>>> +     int ret;
>>> +
>>> +     if (mask != IIO_CHAN_INFO_PROCESSED)
>>> +             return -EINVAL;
>>> +
>>> +     ret = gadc_thermal_get_temp(gtinfo->tz_dev, temp);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     *temp /= 1000;
>>> +
>>> +     return IIO_VAL_INT;
>>> +}
>>> +
>>> +static const struct iio_info gadc_thermal_iio_info = {
>>> +     .read_raw = gadc_thermal_read_raw,
>>> +};
>>> +
>>> +static int gadc_iio_register(struct device *dev, struct gadc_thermal_info *gti)
>>> +{
>>> +     struct gadc_thermal_info *gtinfo;
>>> +     struct iio_dev *indio_dev;
>>> +
>>> +     indio_dev = devm_iio_device_alloc(dev, sizeof(struct gadc_thermal_info));
>>> +     if (!indio_dev)
>>> +             return -ENOMEM;
>>> +
>>> +     gtinfo = iio_priv(indio_dev);
>>> +     memcpy(gtinfo, gti, sizeof(struct gadc_thermal_info));
>>> +
>>> +     indio_dev->name = dev_name(dev);
>>> +     indio_dev->info = &gadc_thermal_iio_info;
>>> +     indio_dev->modes = INDIO_DIRECT_MODE;
>>> +     indio_dev->channels = gadc_thermal_iio_channel;
>>> +     indio_dev->num_channels = ARRAY_SIZE(gadc_thermal_iio_channel);
>>> +
>>> +     return devm_iio_device_register(dev, indio_dev);
>>
>> I don't get the idea why we need iio device, while we already have the
>> hwmon.
>>
> 
> Idea behind this is to be able to convert adc iio channel into temp
> iio channel without introducing a new sensor which will duplicate
> behavior of existing one (by this I mean conversion table use). Not
> all devices can or have to use hwmon and some may require iio channel
> hooked up.
> 
> Real life example. I own a device (LG P985) which has a fuel gauge
> that does not support battery thermal readings. Vendor provided a
> dedicated adc sensor and one of its channels is used as thermal sensor
> with device specific conversion table. Fuel gauge on the other hand
> supports linking in a dedicated temp iio channel to get thermal
> readings.

Thanks. IMO you can add these two sentences into the patch header.
It's telling more about the need of this change.

BTW, I would like to see later how you use it in your battery driver
(please add me on CC, because I'm curious).

The code looks good, so please resend with better patch header
and I'll review the whole patch

