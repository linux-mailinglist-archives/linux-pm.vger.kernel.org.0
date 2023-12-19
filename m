Return-Path: <linux-pm+bounces-1361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8C4818784
	for <lists+linux-pm@lfdr.de>; Tue, 19 Dec 2023 13:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4CF51C236A6
	for <lists+linux-pm@lfdr.de>; Tue, 19 Dec 2023 12:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9213210E5;
	Tue, 19 Dec 2023 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRbNSKsh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07C18E0E
	for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2023 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so44773335e9.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2023 04:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702989207; x=1703594007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xA3u4t+UtUJ0McmzJljzqmFtcCuyXSppyAwUPeBeqLw=;
        b=mRbNSKshcWCp5A30JNBv22Pht0GAk/9P4UH8anqaUOPwVPr8n7cFCy4hAVaWcZc37W
         mzOTeWh0GWdnMImrCCECamLsycicic+uMGaPRb3PTTVtvIocV90761fTrMvIF/i5T+Z9
         HHEyQDuP4q4tzvPph2CxYm6c4aRlu98e/uUc1kOlFvXNThwsJD2MLgHbXPZuN2XKQpaM
         cRFz3JSG/wUOFZl5S1Tmep8Q5kOd8aEgEJGELuMlGiEwGLbBCF9Q3tXRTnFuRBXwpeZD
         GAZYBtQ8YhBXjdTT0Hy9YYGXD8kuCvnztJ9H/Yh4yOEnU/AIIgulfiIZ+fbSREuZdMhZ
         g+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702989207; x=1703594007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xA3u4t+UtUJ0McmzJljzqmFtcCuyXSppyAwUPeBeqLw=;
        b=AQRmSOzRPLYAviJxeBI5ICe7qeuOH1p8DDLZs9NeIiH9y4fpftvewtg+z/CUI6qR0v
         9ioq5Bzan6M4K1pOPFnt+eTXAsyo7bdN4uA6YHebliqIAxKDT3AgCPq05BTNLMCAq5hL
         b9Cm79XAWeUViB/DfaSfAzlReQvS6tZJ8KYwLi2R66XBYPJeUj/pfPChv+1qoPItEkaf
         ON+OnJYoANLiZl1H1UvAJLgJdcFSvihsrzzM9EksWuo/CLY4Oi4r/isH7S4fgQf/zo8O
         bImx3VZn6sALvea2dXXz23b/TlvqshkLhpyaPWhqUGTOYSvb8bzfIf4WewytxOtvTv6x
         N/xQ==
X-Gm-Message-State: AOJu0Yz4vUeBtbJeQhJN8mntTplCAIi4ogKb8ZsGUZBqaCLLsZ2VaG1x
	ui5vkhJdLXu4XT2fC7EeWbWlNg==
X-Google-Smtp-Source: AGHT+IFzoKKAKbnPL7LRL39CV2dy6y+u+klABAwXLT5Oif8aLNSfNjfHBHfrrjrqv4ztFu1wS+PLvA==
X-Received: by 2002:a05:600c:3502:b0:40d:18e2:895 with SMTP id h2-20020a05600c350200b0040d18e20895mr1948499wmq.98.1702989207121;
        Tue, 19 Dec 2023 04:33:27 -0800 (PST)
Received: from [192.168.10.46] ([37.167.119.56])
        by smtp.googlemail.com with ESMTPSA id n33-20020a05600c502100b004030e8ff964sm2697092wmr.34.2023.12.19.04.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 04:33:26 -0800 (PST)
Message-ID: <3a61d2d9-158f-4728-af19-a8700d5ce1a1@linaro.org>
Date: Tue, 19 Dec 2023 13:33:25 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] PM: QoS: Add a performance QoS
Content-Language: en-US
To: Caleb Connolly <caleb.connolly@linaro.org>, rafael@kernel.org
Cc: lina.iyer@linaro.org, lukasz.luba@arm.com, quic_manafm@quicinc.com,
 quic_priyjain@quicinc.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
References: <20231213175818.2826876-1-daniel.lezcano@linaro.org>
 <20231213175818.2826876-2-daniel.lezcano@linaro.org>
 <9f8566b8-71d3-4dbd-8bde-f9a4cfde8372@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <9f8566b8-71d3-4dbd-8bde-f9a4cfde8372@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Caleb,

[Cc'ed Viresh]

On 13/12/2023 19:35, Caleb Connolly wrote:
> Hi Daniel,
> 
> On 13/12/2023 17:58, Daniel Lezcano wrote:
>> Currently cpufreq and devfreq are using the freq QoS to aggregate the
>> requests for frequency ranges.
>>
>> However, there are new devices wanting to act not on a frequency range
>> but on a performance index range. Those need also to export to
>> userspace the knob to act on their performance limits.
>>
>> This change provides a performance limiter QoS based on a minimum /
>> maximum performance values. At init time, the limits of the interval
>> are 0 / 1024. It is up to the backend to convert the 1024 to the
>> maximum performance state. So if the performance must be limited to
>> 50%, it should set to maximum limit to 512 where the backend will end
>> up by converting (max performance index / 2). The same applies for the
>> minimum. Obviously, the min can not be greater than the max.
> 
> I really feel like it should be possible to have arbitrary min/max
> performance values. As is the case with latency and frequency.

We had an initial discussion about the performance QoS some weeks ago. 
Rafael is reluctant to have arbitrary values. So it was proposed a 1024 
based approach and let the back end to convert the value to its index.

If we go for a similar approach to the frequencies, then we should have 
more files to describe the different states. At least one defining the 
current state, the min and the max.


>>   1. With the example above, if there is a odd number like 5 for the
>>   number of performance indexes and we ask for 512 (so 50%), what would
>>   be the performance index computed? (5/2=2 or 5/2=3)? (I would say the
>>   minimum otherwise we end up with a performance limit greater than
>>   what we actually asked for).
> 
> For a device with just a handful of performance indices this is quite a
> large margin for error. If there are just 3 for example, and some
> algorithm is decreasing the performance level over time (e.g. due to
> some thermal condition), the algorithm cannot determine at what point
> the devices performance level has actually changed, making debugging and
> tuning of behaviour needlessly difficult.

Yes, it is a valid point. May be we can find an intermediate approach.

If we define an additional information, let's call it "granularity" for 
example and keep the 0-1023, then the userspace can rely on this 
information to build the steps.

If we take your example with a 3 performance states device, then the 
granularity would be:

1024 / 3 = 341.3

As floating does not exist in the kernel, then it would be 342.

State 0 = 0 x 342 = 0
State 1 = 1 x 342 = 342
State 2 = 2 x 342 = 684
State 3 = 3 x 342 = 1026 (floored to 1024)

So we end up with a fixed range, a way to quickly escalate the stairs 
and three files in the device's power sysfs entry.

> This also leaves it up to the backend driver to decide if it should
> round up or down, something that should definitely be handled by the
> framework.

> Maybe I missed some previous discussion, but isn't this what
> operating-points is designed for?
> 
> It has an `opp-level` property, but that is meant to be device-specific.
> With the `opp-hz` property being the "normalised" values that the
> framework deals with.
> 
> We would just want some way to defined an `opp-level` as a percentage
> (or whatever), with an arbitrary `opp-performance-index` being the
> device-specific property.
> 
> This also gracefully handles non-linear performance scaling.

I think it is a different subject, we are talking about how to describe 
the hardware and these performance states. But I agree, it is worth to 
keep the opp description in mind.

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


