Return-Path: <linux-pm+bounces-16194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9379A9B81
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 09:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1D41C2115B
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 07:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C7F149E0E;
	Tue, 22 Oct 2024 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1WESULW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F64127E37
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583532; cv=none; b=bfgqEIMWCUPuBlnN4IdLhqggv4j6zTGPBC3GMe36vuHbcQpfaXBQYW1hPQdC5A/Wkk5u1UWLTQolIHNMiWBPg/oeJarj7/S75GajM77ROueBbrhwS3sVyCKg+FBWsZoZf6PDBOxx5/cQuLcbCglzYgh6lElTZJcUzZMtVw+AbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583532; c=relaxed/simple;
	bh=wX3IUhGASeJg4vDCcbgQgBrhQumD27aXhMl4QN7S6PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6gZDcRmmZ6M851C1SQD9Xh4gGBvaw/xzs538HJhaaW6U9zF/xhQvIUFh5YXx2N74MuGy/k5OjVITYDGaMR3hAwS5s0oyo7FP5ZDHcrEIyQBg48NhFqGJkJY49/r3Ifnhaafy+GNWcZOB5jBRFNaBkCW+pHU0nCarTBKrI3fVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q1WESULW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so51624625e9.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 00:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729583529; x=1730188329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnAx32/5JD8UKnmCoO/CQf1KlVcvj8zWm2UJ8ys3ivA=;
        b=q1WESULWzkCcAYxTAzAQEiqlG9yFOPsr1W7FA9CcoHaJ8eP9MXGAqOcNI7hslc4VKg
         LnHq8tHYkJTyArSGfr/glVuiA4T7322a1hYveiw39G8N1+2A2ZzwL8ZdxayXEh0Okh65
         MN3fabpP9+7L73ktfryOVp+5TnHG0o5QIT82hECAvou/YcfLeY9KyqKmff+sG+CUwdiN
         7K6/I7KO2/9XX2LbV1cThQv3hturF6/OXOx0LVSwb+OZNyhlIZRJQ/FGy+d7I08bWI1p
         1Inq9jLzZWCGShy2yfHpZpi0dLDbZj9SDirUg4WcZNcxQGEd+dOht2gXElk5vzBGcN/d
         4Odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729583529; x=1730188329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnAx32/5JD8UKnmCoO/CQf1KlVcvj8zWm2UJ8ys3ivA=;
        b=Yp7R8LP7jCXKbvH4oLTZFNf2jovDDeOFtMKvDOmwG2pIQZqmKQNGUQbu19HtfqFzZX
         KwHFFY1H5aloWpekKHVCY6MeMCCaHXKJr5FzCUUPJHiXj/PV3dEbE4op0WOcbjzFK5B4
         KRWW7pHCpzCcGwyp5Cfm0+VDaIV9apfoRpVIXtRY5ppSquMWlW4DLuCQ7HvQvQ6Bw3vP
         srzVg0Ct7jfJKtvWKWodb2bNCb4Zzx0/LFGQGgk5g3dn1C6MnuAI+FQ2575eZ9S/miZo
         X9fa0xSmZYUS5+eYPM2pBU4qlSuzCXQl2+loO90MfVyAprkPa8ocE7+ELDtw/sMIwvX/
         hDYA==
X-Gm-Message-State: AOJu0YxHOhq7ZvuVY5DL6fRd47M+v4smW+xLNCUtDAj30Zv/YWVADQEx
	YCcNyVUotjSnTZ37T0Y7S0t2+Fn3dDtjz8NZ6SUMLbpmdTavQBtMWmbmLqTsXp0=
X-Google-Smtp-Source: AGHT+IEK2QoOADtmJ4HMla7fmXs3AKfyTmheTaebWPk10gEuW6o4vz3f9rB9V0q5YUKGJW7uKyQNNw==
X-Received: by 2002:a05:600c:5489:b0:430:5356:ac8e with SMTP id 5b1f17b1804b1-43161632f4amr124082875e9.5.1729583528926;
        Tue, 22 Oct 2024 00:52:08 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-431805a8583sm2928425e9.48.2024.10.22.00.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 00:52:07 -0700 (PDT)
Message-ID: <dcc9623d-6705-4c16-aa11-3956f7279562@linaro.org>
Date: Tue, 22 Oct 2024 09:52:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] tools/thermal/thermal-engine: Take into account
 the thresholds API
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, quic_manafm@quicinc.com, rafael@kernel.org
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
 <20241014094309.1430126-5-daniel.lezcano@linaro.org>
 <deacf57b-08b3-4b1b-85b2-98be78da8339@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <deacf57b-08b3-4b1b-85b2-98be78da8339@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/10/2024 22:10, Lukasz Luba wrote:
> 
> 
> On 10/14/24 10:43, Daniel Lezcano wrote:
>> Enhance the thermal-engine skeleton with the thresholds added in the
>> kernel and use the API exported by the thermal library.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   tools/thermal/thermal-engine/thermal-engine.c | 105 +++++++++++++++---
>>   1 file changed, 92 insertions(+), 13 deletions(-)
>>
>> diff --git a/tools/thermal/thermal-engine/thermal-engine.c b/tools/ 
>> thermal/thermal-engine/thermal-engine.c
>> index 9b1476a2680f..0764dc754771 100644
>> --- a/tools/thermal/thermal-engine/thermal-engine.c
>> +++ b/tools/thermal/thermal-engine/thermal-engine.c
>> @@ -38,6 +38,14 @@ struct thermal_data {
>>       struct thermal_handler *th;
>>   };
>> +static int show_threshold(struct thermal_threshold *th, 
>> __maybe_unused void *arg)
>> +{
>> +    INFO("threshold temp=%d, direction=%d\n",
>> +         th->temperature, th->direction);
>> +
>> +    return 0;
>> +}
>> +
>>   static int show_trip(struct thermal_trip *tt, __maybe_unused void *arg)
>>   {
>>       INFO("trip id=%d, type=%d, temp=%d, hyst=%d\n",
>> @@ -70,6 +78,8 @@ static int show_tz(struct thermal_zone *tz, 
>> __maybe_unused void *arg)
>>       for_each_thermal_trip(tz->trip, show_trip, NULL);
>> +    for_each_thermal_threshold(tz->thresholds, show_threshold, NULL);
>> +
>>       show_temp(tz, arg);
>>       show_governor(tz, arg);
>> @@ -77,6 +87,30 @@ static int show_tz(struct thermal_zone *tz, 
>> __maybe_unused void *arg)
>>       return 0;
>>   }
>> +static int set_threshold(struct thermal_zone *tz, __maybe_unused void 
>> *arg)
>> +{
>> +    struct thermal_handler *th = arg;
>> +    int thresholds[] = { 43000, 65000, 49000, 55000, 57000 };
>> +    size_t i;
> 
> minor: I would just make it normal 'int'.

Why ? :)

The for loop compares i < sizeof(thresholds) / sizeof(thresholds[0])

sizeof() returns size_t

So we are comparing the same type.


>> +
>> +    INFO("Setting threshold for thermal zone '%s', id=%d\n", tz- 
>> >name, tz->id);
>> +

[ ... ]

> 
> LGTM,
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


Thanks for the review



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

