Return-Path: <linux-pm+bounces-40759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75504D1A982
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 18:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33C27302AFA2
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941EA32B98F;
	Tue, 13 Jan 2026 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4OE6i6l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E512EC090
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325017; cv=none; b=bU2SpKfHHx4AF/Iobksxxvv8YMizi2p1JSiAcu/18jZh5swSJPdSKVwH7X30XzpeSsSSoG0bWIZK4wqz1nK8o6kCnwQ2LjvE5zn/gtzFBEbC1O/4X4tU5Jr61CHluWxerIhLE9f3Ofv6aOvXTV1dEIuV4bZrkllf8cC7+HSNuqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325017; c=relaxed/simple;
	bh=P7aE1Qa3WVLlpttH3UXpmJbSePs8WKbe0bTGb7NXfWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMehuEOQPvdL/GNtfl8Ty9AB34uNu1aHOpnwUnXgeeoq703Hz/Gzjft6r+gbCphv1Iny80HPv9O7zl1l5spIr3VoUvSPcpsd/xgf6UVvL7Y0jhTcoUka0O66Tsdx7DdEK6avU4ERTJaqrMMdbNz9v/HuHasUw2bSsli4iIOj4/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4OE6i6l; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50146fcf927so299261cf.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 09:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768325015; x=1768929815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z5Bnm7HgbucF89WDkbcJd+qDxBtmrALRfhqTrZMCy6Y=;
        b=I4OE6i6lnUGujiomvv9KF4mrH3ytoogxdfL61d0eITz7I8UPxXxXSJhietWWSul1o7
         8j/SP9dKuwIiIa382i7UWb5Qv7vPV+wzXsd2tp8fv4Uep3H+wYknI41NkuaKN4HZLaWU
         nPALxloYiGRjyhaRY5AeejBDgX18pDykOqxCnY8awBgqcCNgSYCx+GIn9ADj5BjKrc2m
         6SS4FQHLfR1J9Br4U7+N5IW3+ROR9oRJkQ0SsOR9umNqF/yWcT/sL1iX4Ulj1y0VWAtW
         796WuhvL8NJ0FMSdLUpiSDSsHf62/ULROzNc6E8gqaEPnmFLVFmd/Pg8UD4mIrmVu6rd
         YtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325015; x=1768929815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5Bnm7HgbucF89WDkbcJd+qDxBtmrALRfhqTrZMCy6Y=;
        b=SxKqQY75nP6Ot7tzt104eVWCcloAyYi/XkLG11lY+YvAorXETJr4L3RsQbNJrg/23m
         7HTQs5CWYR/Lt0PfqJOtb9Okdg+kTETYv9VhC8aCUzsYFFBOMCbx2h0jAiBTE3BM0ALs
         ZzbylvWobP0512DvQgdo/93XFgIpr2nozJH4jCuPUGnw3tHAw5Dw5vbmd/wPGZooRkEl
         Jfewp/7V/W8Y7ABhvWeRRbeVTHWzSg50wxUbrppKvaByTAxEoSKTzUwu+G92hRIoPK/e
         1mkPQxSvtCdKUTeTWBGtRsogF/SXTfmuy0E+f6XPDeW4bwSNPwcdvhV6W+xDgnifObFV
         DFDA==
X-Forwarded-Encrypted: i=1; AJvYcCXUXsujLoVJb10YZQ2q11CSm2X7dvX7iJXzQrwiTL2b21StKx5Gcb4QenSfRkCrIC50WEzjKAwV8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ROGfvpO4b4U1t0DodDwWyPnBnsKOuxI3J8owpm09V33QgzQE
	f0ha8HB6Z6J9m1aVRvKK/V1XeNf+44P0NzEPo+PE84z7D5BbxsLOAQgO
X-Gm-Gg: AY/fxX4RFJju7bFjLqHD4cAFeGqh07b4+qbZYF4y63HJBVv/XdAuq/ImKxlaE+b7W6u
	Z+Kb6FRjAYTfir13EERFlWys0td977/kBJWYcimVFXpLJ7ifthrHWGHcXaOrRrnhdDpL08E+ojG
	bSqGmR6H2P3UB0UFxqLOcRxXHGRCmx9M5vxvXlRqYUzOlb2qzp1nAOaBgzA/4XQjUXi3jWN+PVp
	jrzT88NxUbQLmbwc3puw7NfmHSqG/8cIcp7RCi95NMxfZye0H6VQFhKkCGqS1wgPufaMpvC1+Ps
	vNMS4tqbNnQ+NKbZRD4l2VSbpm6wErLyGpI7Zc53r2hDJbI18GkMQRe0mSdGGVkHVcMlvT3a2yf
	9zkHPVT5EZ8otuQIYRBdMn9QIbW2qu1HNvYgYCOC0Pb2nZJD3+XCC2jCMkoBQibvP2R0GxxHq8i
	mANOR/rQR94iVJhsb437Q1dMWOZ8ayo8kHB6yxlA==
X-Google-Smtp-Source: AGHT+IFRuEumeFruv6mA2Hy4fQiK41BpjEOJSmGvbRDdB5MnNJjmYB/QnnJKE/+rie6ONCbWC7LSdg==
X-Received: by 2002:ac8:6f19:0:b0:4b3:8ee:520c with SMTP id d75a77b69052e-50139784c7emr46319131cf.19.1768325015003;
        Tue, 13 Jan 2026 09:23:35 -0800 (PST)
Received: from [192.168.0.155] ([170.10.253.128])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffb9e97ef2sm122859951cf.10.2026.01.13.09.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 09:23:34 -0800 (PST)
Message-ID: <5f33c687-63e3-4d3a-8117-106b41584c53@gmail.com>
Date: Tue, 13 Jan 2026 13:23:33 -0400
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: max77620: fix kernel-doc for
 max77620_thermal_read_temp
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20251201054036.2143455-1-vivek.balachandhar@gmail.com>
 <2a3dc51e-ead2-4612-bf7f-6cdb49bf9570@gmail.com>
 <12ba1c1d-fb20-476c-ae24-3e1007afb199@arm.com>
Content-Language: en-CA
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
In-Reply-To: <12ba1c1d-fb20-476c-ae24-3e1007afb199@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks a lot, Lukasz — appreciate the review.

Understood regarding the Fixes/stable point.
I’ll make sure to include a Fixes tag for similar cases in future 
contributions.

Thanks again.

Best
Vivek


On 2026-01-13 8:30 a.m., Lukasz Luba wrote:
> Hi Vivek,
>
> On 1/13/26 01:54, Vivek BalachandharTN wrote:
>> Hi Rafael, Daniel,
>>
>> Just a gentle follow-up on this patch — I wanted to check if there 
>> are any concerns or if any changes are needed from my side.
>>
>> Happy to revise or resend if required.
>
> I think it was just missed.
>
>>
>> Thanks for your time.
>>
>> Best,
>> Vivek
>>
>>
>> On 2025-12-01 1:40 a.m., Vivek BalachandharTN wrote:
>>> Building with W=1 reports a kernel-doc warning in
>>> drivers/thermal/max77620_thermal.c:
>>>
>>>    Warning: max77620_thermal.c:47 function parameter 'tz'
>>>    not described in 'max77620_thermal_read_temp'
>>>
>>> Update the kernel-doc comment for max77620_thermal_read_temp() to match
>>> the current function prototype. Replace the stale @data entry with @tz
>>> and describe the thermal zone device argument so that all parameters 
>>> are
>>> documented.
>>>
>>> This fixes the W=1 kernel-doc warning and keeps the documentation in
>>> sync with the code.
>>>
>>> Signed-off-by: Vivek BalachandharTN<vivek.balachandhar@gmail.com>
>>> ---
>>>   drivers/thermal/max77620_thermal.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/thermal/max77620_thermal.c 
>>> b/drivers/thermal/max77620_thermal.c
>>> index 85a12e98d6dc..8d37a04eb5a8 100644
>>> --- a/drivers/thermal/max77620_thermal.c
>>> +++ b/drivers/thermal/max77620_thermal.c
>>> @@ -32,7 +32,7 @@ struct max77620_therm_info {
>>>     /**
>>>    * max77620_thermal_read_temp: Read PMIC die temperatue.
>>> - * @data:    Device specific data.
>>> + * @tz:    Thermal zone device
>>>    * @temp:    Temperature in millidegrees Celsius
>>>    *
>>>    * The actual temperature of PMIC die is not available from PMIC.
>
>
> The patch looks good. Although, I'm not sure if such change
> should go through the stable tree.
> Usually we would ask you to add 'Fixes:' line with the
> hash of the commit which left that stale comment in this case.
> If we were strict to the processes that should be there.
> If we judge the effort and traffic for stable-linux folks
> I would say, not needed.
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>
> Regards,
> Lukasz
>

