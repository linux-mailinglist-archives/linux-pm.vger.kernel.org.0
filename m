Return-Path: <linux-pm+bounces-23436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD032A4E95E
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 18:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01BF189E7A4
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 17:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A6B294F14;
	Tue,  4 Mar 2025 17:08:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A31127F4CA
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108101; cv=fail; b=IqWv15DEe1Um1l+Hgn3InuldJCkmUZcZex/scGuh64ieUfvRUR3zw4lrasnpzgcqQzJPyFGGMK4o13RBwAgFGky1WXfGkAbZOzj6WXFuGxb+onRaq0rZcpNYiZXfehZCe4Gs1/4pkrsKa085BcAF32aByp+NaEBPrqI7sMf9Yzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108101; c=relaxed/simple;
	bh=w+4w4uW3jmwCDb9GE5NDmAdo4YER2QhtiGfUNFJ1RZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCLBxi0dZ39rYneD9AH4uI8MkQdCxcPKDsWUnLeRVf5ohXBEe4oAQwjJnGlfEt5dk91KMENRHADcc87eQVJC66MCWiY+Etx75aC4f7yGwJFWlsixhJNYjNMZCawHmKKPFhtDjLScDvUocZZVa9yvABaXDDiFFkmt04eSXq6ZYgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=217.140.110.172; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 4310940D1F43
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 20:08:17 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fnN205zzG0Wx
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 18:32:24 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id E238842737; Tue,  4 Mar 2025 18:32:10 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541440-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 7AFD442331
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:55:05 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 582253063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:55:05 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12981894B94
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0911F4634;
	Mon,  3 Mar 2025 10:53:31 +0000 (UTC)
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
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fnN205zzG0Wx
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712773.15802@guslJSKRKCP8G9i6syNPkA
X-ITU-MailScanner-SpamCheck: not spam



On 2/28/25 13:22, Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 28 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 15:11 =
Lukasz Luba <lukasz.luba@arm.com> =D0=BF=D0=B8=D1=88=D0=B5:
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
>>>    drivers/thermal/thermal-generic-adc.c | 54 +++++++++++++++++++++++=
+++-
>>>    1 file changed, 53 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/=
thermal-generic-adc.c
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
>>> @@ -73,6 +74,57 @@ static const struct thermal_zone_device_ops gadc_t=
hermal_ops =3D {
>>>        .get_temp =3D gadc_thermal_get_temp,
>>>    };
>>>
>>> +static const struct iio_chan_spec gadc_thermal_iio_channel[] =3D {
>>> +     {
>>> +             .type =3D IIO_TEMP,
>>> +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
>>> +     }
>>> +};
>>> +
>>> +static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
>>> +                              struct iio_chan_spec const *chan,
>>> +                              int *temp, int *val2, long mask)
>>> +{
>>> +     struct gadc_thermal_info *gtinfo =3D iio_priv(indio_dev);
>>> +     int ret;
>>> +
>>> +     if (mask !=3D IIO_CHAN_INFO_PROCESSED)
>>> +             return -EINVAL;
>>> +
>>> +     ret =3D gadc_thermal_get_temp(gtinfo->tz_dev, temp);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     *temp /=3D 1000;
>>> +
>>> +     return IIO_VAL_INT;
>>> +}
>>> +
>>> +static const struct iio_info gadc_thermal_iio_info =3D {
>>> +     .read_raw =3D gadc_thermal_read_raw,
>>> +};
>>> +
>>> +static int gadc_iio_register(struct device *dev, struct gadc_thermal=
_info *gti)
>>> +{
>>> +     struct gadc_thermal_info *gtinfo;
>>> +     struct iio_dev *indio_dev;
>>> +
>>> +     indio_dev =3D devm_iio_device_alloc(dev, sizeof(struct gadc_the=
rmal_info));
>>> +     if (!indio_dev)
>>> +             return -ENOMEM;
>>> +
>>> +     gtinfo =3D iio_priv(indio_dev);
>>> +     memcpy(gtinfo, gti, sizeof(struct gadc_thermal_info));
>>> +
>>> +     indio_dev->name =3D dev_name(dev);
>>> +     indio_dev->info =3D &gadc_thermal_iio_info;
>>> +     indio_dev->modes =3D INDIO_DIRECT_MODE;
>>> +     indio_dev->channels =3D gadc_thermal_iio_channel;
>>> +     indio_dev->num_channels =3D ARRAY_SIZE(gadc_thermal_iio_channel=
);
>>> +
>>> +     return devm_iio_device_register(dev, indio_dev);
>>
>> I don't get the idea why we need iio device, while we already have the
>> hwmon.
>>
>=20
> Idea behind this is to be able to convert adc iio channel into temp
> iio channel without introducing a new sensor which will duplicate
> behavior of existing one (by this I mean conversion table use). Not
> all devices can or have to use hwmon and some may require iio channel
> hooked up.
>=20
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


