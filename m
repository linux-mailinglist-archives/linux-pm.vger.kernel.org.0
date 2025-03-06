Return-Path: <linux-pm+bounces-23555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0717A54754
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 11:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BEF07AA26D
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 10:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C591FF1B1;
	Thu,  6 Mar 2025 10:04:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A54202971;
	Thu,  6 Mar 2025 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255448; cv=none; b=orv5vsHQwislctzef21SwHxY8m3mAg/ETNGqpCfjLNSwVGaXt594gSrMMJe6CLgH6gaC0lRPDNV6bGANvhbcuKfO5vkHwSt1sIOW90BHox+WcSv4m2Kbt7ESfQ/fGE+GTKzyQutPThJAI/hOnV+rf5Z0O5Rs/ExJZtsLaZa8V8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255448; c=relaxed/simple;
	bh=Oy3sdejRyxIC9YUWZWkva5gjh/7c3mBVfg/OHYuRFjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ny0R3jTFbadQ+GVinrgFWfBV05n2iFENyUFY1h+6lyvY5WRvn1ohEiReNPjSvBQv3R2vxRT0RTGtlJvDvcgs4Jb1pz3gXQmcfHrfUKPnAx5pknSnCYQeoFlbY4o1k1v/J4lXhX9v9BBU2nbWqEetNOQ/R03hrLrJqwJQHlZl6ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAF44FEC;
	Thu,  6 Mar 2025 02:04:18 -0800 (PST)
Received: from [10.57.83.26] (unknown [10.57.83.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79E4A3F66E;
	Thu,  6 Mar 2025 02:04:03 -0800 (PST)
Message-ID: <67659d9d-f228-42ac-b096-01020bf66b7f@arm.com>
Date: Thu, 6 Mar 2025 10:04:01 +0000
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
 <f56596fe-92e8-481b-b15b-29b531eaec32@arm.com>
 <CAPVz0n2ywjm+nLQ+ZAYbR1P6yCr8FQgOMeDT07s_YHZ7xA_6uA@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAPVz0n2ywjm+nLQ+ZAYbR1P6yCr8FQgOMeDT07s_YHZ7xA_6uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/6/25 09:49, Svyatoslav Ryhel wrote:
> ср, 5 бер. 2025 р. о 16:37 Lukasz Luba <lukasz.luba@arm.com> пише:
>>
>>
>>
>> On 3/5/25 10:06, Svyatoslav Ryhel wrote:
>>> ср, 5 бер. 2025 р. о 11:52 Lukasz Luba <lukasz.luba@arm.com> пише:
>>>>
>>>>
>>>>
>>>> On 3/3/25 12:21, Svyatoslav Ryhel wrote:
>>>>> To avoid duplicating sensor functionality and conversion tables, this design
>>>>> allows converting an ADC IIO channel's output directly into a temperature IIO
>>>>> channel. This is particularly useful for devices where hwmon isn't suitable
>>>>> or where temperature data must be accessible through IIO.
>>>>>
>>>>> One such device is, for example, the MAX17040 fuel gauge.
>>>>>
>>>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>>>> ---
>>>>>     drivers/thermal/thermal-generic-adc.c | 54 ++++++++++++++++++++++++++-
>>>>>     1 file changed, 53 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
>>> ...
>>>>>
>>>>> +static const struct iio_chan_spec gadc_thermal_iio_channel[] = {
>>>>> +     {
>>>>> +             .type = IIO_TEMP,
>>>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>>>>
>>>> I would add the IIO_CHAN_INFO_SCALE and say it's in milli-degrees.
>>>>
>>>
>>> I have hit this issue already with als sensor. This should definitely
>>> be a IIO_CHAN_INFO_PROCESSED since there is no raw temp data we have,
>>> it gets processed into temp data via conversion table. I will add
>>> Jonathan Cameron to list if you don't mind, he might give some good
>>> advice.
>>
>> I'm not talking about 'PROCESSED' vs 'RAW'...
>> I'm asking if you can add the 'SCALE' case to handle and report
>> that this device will report 'processed' temp value in milli-degrees
>> of Celsius.
>>
> 
> It seems that SCALE is not applied to PROCESSED channel. I can use RAW
> which would work as intended and I will add a note in commit
> description why I used RAW. Would that be acceptable?
> 

In that case, yes that would be the preferred solution.

