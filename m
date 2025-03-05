Return-Path: <linux-pm+bounces-23484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68135A5025E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 15:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F7A3B0B28
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 14:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803DC24EA82;
	Wed,  5 Mar 2025 14:37:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52A4248863;
	Wed,  5 Mar 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185451; cv=none; b=BWRp0GhaMbrmnszorY9Ttom/wAPwB8yjXRtENO0n1A6WV7RFE8pKKhdOZhU5MgTbJIqKShGhnXa4fvSRSPvUnIoq0GpAk1abIIw30vAC0S32kRq9MVweIV8Tbai7GT5mm6KXenRQgKLHB97+FHr466Z1mJxecaqUEgK8W7XElkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185451; c=relaxed/simple;
	bh=FCa9GNr5wiSR3agXv7JxEUWV07u9VhwbOu9Cr08Q50Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PuGLrTUyJYvsHPpda6ssH/XInF22L8IsN8eybwaQS5KES+CHJN79Mm6Vdw82BapbSm2DgsszBForVh6EaG/4aSfaOAJn7LVGRFPx/fQx+hqeuM3N0QCvMSpBYXaNwpmxkhG3jfv8Z5gHkJIGAHuJxxyEj7B7NSKnlC1+WnbIffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A2F4FEC;
	Wed,  5 Mar 2025 06:37:41 -0800 (PST)
Received: from [10.57.64.200] (unknown [10.57.64.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0698C3F673;
	Wed,  5 Mar 2025 06:37:25 -0800 (PST)
Message-ID: <f56596fe-92e8-481b-b15b-29b531eaec32@arm.com>
Date: Wed, 5 Mar 2025 14:37:23 +0000
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
 Jonathan Cameron <jic23@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20250303122151.91557-1-clamor95@gmail.com>
 <20250303122151.91557-3-clamor95@gmail.com>
 <3bc7c5a5-8fe7-4c4b-a80e-23522922debb@arm.com>
 <CAPVz0n0yvw4kyYKSve9sSZEvcZrCYZ6RqCjFSO5OCqtvRZSfJg@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAPVz0n0yvw4kyYKSve9sSZEvcZrCYZ6RqCjFSO5OCqtvRZSfJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/5/25 10:06, Svyatoslav Ryhel wrote:
> ср, 5 бер. 2025 р. о 11:52 Lukasz Luba <lukasz.luba@arm.com> пише:
>>
>>
>>
>> On 3/3/25 12:21, Svyatoslav Ryhel wrote:
>>> To avoid duplicating sensor functionality and conversion tables, this design
>>> allows converting an ADC IIO channel's output directly into a temperature IIO
>>> channel. This is particularly useful for devices where hwmon isn't suitable
>>> or where temperature data must be accessible through IIO.
>>>
>>> One such device is, for example, the MAX17040 fuel gauge.
>>>
>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>> ---
>>>    drivers/thermal/thermal-generic-adc.c | 54 ++++++++++++++++++++++++++-
>>>    1 file changed, 53 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
> ...
>>>
>>> +static const struct iio_chan_spec gadc_thermal_iio_channel[] = {
>>> +     {
>>> +             .type = IIO_TEMP,
>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>>
>> I would add the IIO_CHAN_INFO_SCALE and say it's in milli-degrees.
>>
> 
> I have hit this issue already with als sensor. This should definitely
> be a IIO_CHAN_INFO_PROCESSED since there is no raw temp data we have,
> it gets processed into temp data via conversion table. I will add
> Jonathan Cameron to list if you don't mind, he might give some good
> advice.

I'm not talking about 'PROCESSED' vs 'RAW'...
I'm asking if you can add the 'SCALE' case to handle and report
that this device will report 'processed' temp value in milli-degrees
of Celsius.

> 
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
>>
>> Therefore, here it would need to handle such case as well, when
>> a client is asking about scale.
>>
>>> +
>>> +     ret = gadc_thermal_get_temp(gtinfo->tz_dev, temp);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     *temp /= 1000;
>>
>> IMO we shouldn't cut the precision if it's provided.
>> The user of this would know what to do with the value (when
>> the proper information about scale is also available).
>>
> 
> The it will not fit existing IIO framework and thermal readings will
> be 1000 off. I have had to adjust this since my battery suddenly got
> temperature reading of 23200C which obviously was not true. With
> adjustment temperature will be in 10th of C (yes, odd, I know but it
> is what it is).

Your battery driver should get and check the 'SCALE' info first, then
it will know that the value is in higher resolution than it needs.
Therefore, it can divide the value inside its code.
Your proposed division here is creating a limitation.

You shouldn't force all other drivers to ignore and drop the
available information about milli-degC (which is done in this patch).

