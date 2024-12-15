Return-Path: <linux-pm+bounces-19268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D28B89F25D2
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 20:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF571885CB1
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 19:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4471B983E;
	Sun, 15 Dec 2024 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eAP7FSl6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405581B6CE7
	for <linux-pm@vger.kernel.org>; Sun, 15 Dec 2024 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734290859; cv=none; b=hW0WWzPrjswUayJbu+Ybnmpi3L4SGy7YLKjC/qER0QB9cjbhiDo+gXxeTC7UVoCfWFEcyhzNupdBfpWhTKsmGsQp3z+VpZovSUoetjXMUki1TpXyXNnAZ6NIusOMfYhsosU6SBPdTofUJHmxcI/Q1X7tCal7x67xFXE48j3NU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734290859; c=relaxed/simple;
	bh=Lp3QgwN092NgYPoIq07B4SsgKiam+NuBK/RRZz64B0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJ2hIOzbsjsiBkUuybd4TVf5oj5DgHNlUqmUddf7Ni/WrECPOPHLKYX0tjJn1JlVCbemMpNYDqljxISSzKz4QDjwpYlQt4vit8Rrw5SdSX7vXsWWq2zK2TS+y9kXCrPOIawOtVZ/csq/9gW8J7gflPsi7ObFjJ6y8Cp5m4oARBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eAP7FSl6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385df53e559so2851312f8f.3
        for <linux-pm@vger.kernel.org>; Sun, 15 Dec 2024 11:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734290855; x=1734895655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDnM1N2rNeRvgJIofwk86bRtIBtCyFmPSZDetB3QfXU=;
        b=eAP7FSl6omM2vdYs1xqcybgSns27vfC790vatsnt7pigN36ReAD+RGOHGor6IvXtN2
         GO9vMfNWrn1KruRwYiXOH34ACVSA8HmaaxNGfiJhznxkue7TmxuAlsyYAYk0QcQnZOIl
         pT88zwgDkwU3etvrOgZ8te4PSnT4258uwR199yTFQ7nkmxEtgwbspH27RHjz2xnMgRD4
         VjjuM6TT93NXOq9h6qp4aLc7rGBXkcmr6UNx89iWzSauay3J40Sxar/7tYBtEcCHYfHh
         Li5QyNxQb04VJmD/jlu9iIqZChq42VvdVgeJn9zuVYn1ueml19jHUhupTo2Z+BTc4Z3L
         BRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734290856; x=1734895656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDnM1N2rNeRvgJIofwk86bRtIBtCyFmPSZDetB3QfXU=;
        b=GzcaDNDxNmtPkpHzQi3hzR0OeKnpS/PZMSAjn8JexCNQD1MtytJo/lL46m7Zj1VLto
         Jgb9W3CmnFxdKUcsZ0JY1kVWWhmiM7lvpz/3BcA8fZHa5zks4HgyQeNCWnzIrD6Fnx22
         30anJWj0di7IEMLhEM1TMIbXMQf/alVI1RC73eAZOgPp0ZiX0vxar8HPVCSEOXYGxAf7
         DYZffhocogXEmE+Ja1UH7T7p4ZatTAZkVno/PQo1j5h27LDEwTWxw0WpWqgMS73aCB0k
         1Go1xPny+XUBIVaqaE4U9w9zeEy19WzRjwqzZFKPiWOqAFHPOKTPNV34J2MD6CVvN+0K
         MoYw==
X-Forwarded-Encrypted: i=1; AJvYcCXumHbxJoKNnAm8fi6HXCPa8v8d4DsxrKe2m6Aqi3zon5ofM/qvQqetk+M/82rJRpEyN5lddBR5nA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZzRAX45lqXjl/GEVefdLQLMNmUL7aE99NdNw7GGLqPctOE82
	0ygUqTvAaMK/EOaF7STCMTwS26sMwZQ+bcHSQmfYyhjqHGGjsX2Qlj7jx0IvE1g=
X-Gm-Gg: ASbGncufyuQ+I8RI9AC22aZ9c2J2m0FIBL3sZHVZvOwsHedul6Vlo+8VBAjhbUsL9Hi
	/jcUNZluTn2Z6vHY3WrzWYElCRrqSk8QFHgTtvPLVVrXm9bZd9+tRCi3Qe2dAY96aiRgXuqEsY4
	BBQ0IEQ4YRR67OmCFMpRO5iRIw2+iu8mgY9OgfBt2DQGDlpsueKK233DUB28X1hxYaZQ3I40wbz
	POWn9+/dexpwNmznLtmz/5vCUeuVIxzpkSXMpIcgEcJEUKzhqnRchof4qjCvV6y6KKBsUcf9Bef
	S17NtlBDOh2KUsgASQ==
X-Google-Smtp-Source: AGHT+IGYv+YjJBOd9gePDmOf/2CBPRN6WjHZKIPJkn5O8OueV58hVZDki7Fq3l9lgtHvOIEBVCZumQ==
X-Received: by 2002:a5d:6d8b:0:b0:382:3c7b:9ae with SMTP id ffacd0b85a97d-3888dcd460amr8574033f8f.16.1734290855621;
        Sun, 15 Dec 2024 11:27:35 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-388c8012170sm5998227f8f.14.2024.12.15.11.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 11:27:35 -0800 (PST)
Message-ID: <f3bf44a5-c0db-4970-b03f-c2ea553de7d3@linaro.org>
Date: Sun, 15 Dec 2024 20:27:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/thresholds: Fix boundaries and detection routine
To: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
 rafael@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241212190737.4127274-1-daniel.lezcano@linaro.org>
 <3a8685b4-c18e-e3ca-60f2-893e3a9e0ecd@quicinc.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3a8685b4-c18e-e3ca-60f2-893e3a9e0ecd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Manaf,

On 12/15/24 20:02, Manaf Meethalavalappu Pallikunhi wrote:
> 
> Hi Daniel,

[ ... ]

>> -static bool thermal_thresholds_handle_raising(struct list_head 
>> *thresholds, int temperature,
>> -                          int last_temperature, int *low, int *high)
>> +static bool thermal_thresholds_handle_dropping(struct list_head 
>> *thresholds, int temperature,
>> +                           int last_temperature)
>>   {
>>       struct user_threshold *t;
>> -    list_for_each_entry(t, thresholds, list_node) {
>> -        if (__thermal_threshold_is_crossed(t, temperature, 
>> last_temperature,
>> -                           THERMAL_THRESHOLD_WAY_UP, low, high))
>> +    list_for_each_entry_reverse(t, thresholds, list_node) {
>> +
>> +        if (!(t->direction & THERMAL_THRESHOLD_WAY_DOWN))
>> +            continue;
>> +
>> +        if (temperature < t->temperature &&
>> +            last_temperature >= t->temperature)
>>               return true;
> 
> Currently WAY_UP notification triggers if temperature is greater than or 
> equal to t-> temperature, but for WAY_DOWN
> 
> it is only checking temperature is less than t->temperature. Why don't 
> we include temperature = t->temperature
> 
> for WAY_DOWN threshold ? In that case it will be consistent for both 
> WAY_UP and WAY_DOWN notification for userspace.
> 
> If we are not considering 'equal to' for WAY_DOWN, there is a 
> possibility of missing WAY_DOWN notification if a sensor
> 
> is violated with same WAY_DOWN threshold temperature and only interrupt 
> mode is enabled for that sensor.

You are right, we should detect when the temperature is lesser or equal 
to the threshold to be crossed the way down.

I'll send a V2 with this condition fixed.

Thanks for reporting this

>>       }
>>       return false;
>>   }
>> -static bool thermal_thresholds_handle_dropping(struct list_head 
>> *thresholds, int temperature,
>> -                           int last_temperature, int *low, int *high)
>> +static void thermal_threshold_find_boundaries(struct list_head 
>> *thresholds, int temperature,
>> +                          int *low, int *high)
>>   {
>>       struct user_threshold *t;
>> -    list_for_each_entry_reverse(t, thresholds, list_node) {
>> -        if (__thermal_threshold_is_crossed(t, temperature, 
>> last_temperature,
>> -                           THERMAL_THRESHOLD_WAY_DOWN, low, high))
>> -            return true;
>> +    list_for_each_entry(t, thresholds, list_node) {
>> +        if (temperature < t->temperature &&
>> +            (t->direction & THERMAL_THRESHOLD_WAY_UP) &&
>> +            *high > t->temperature)
>> +            *high = t->temperature;
>>       }
>> -    return false;
>> +    list_for_each_entry_reverse(t, thresholds, list_node) {
>> +        if (temperature > t->temperature &&
>> +            (t->direction & THERMAL_THRESHOLD_WAY_DOWN) &&
>> +            *low < t->temperature)
>> +            *low = t->temperature;
>> +    }
>>   }
>>   void thermal_thresholds_handle(struct thermal_zone_device *tz, int 
>> *low, int *high)
>> @@ -132,6 +134,8 @@ void thermal_thresholds_handle(struct 
>> thermal_zone_device *tz, int *low, int *hi
>>       lockdep_assert_held(&tz->lock);
>> +    thermal_threshold_find_boundaries(thresholds, temperature, low, 
>> high);
>> +
>>       /*
>>        * We need a second update in order to detect a threshold being 
>> crossed
>>        */
>> @@ -151,12 +155,12 @@ void thermal_thresholds_handle(struct 
>> thermal_zone_device *tz, int *low, int *hi
>>        * - decreased : thresholds are crossed the way down
>>        */
>>       if (temperature > last_temperature) {
>> -        if (thermal_thresholds_handle_raising(thresholds, temperature,
>> -                              last_temperature, low, high))
>> +        if (thermal_thresholds_handle_raising(thresholds,
>> +                              temperature, last_temperature))
>>               thermal_notify_threshold_up(tz);
>>       } else {
>> -        if (thermal_thresholds_handle_dropping(thresholds, temperature,
>> -                               last_temperature, low, high))
>> +        if (thermal_thresholds_handle_dropping(thresholds,
>> +                               temperature, last_temperature))
>>               thermal_notify_threshold_down(tz);
>>       }
>>   }


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

