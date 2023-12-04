Return-Path: <linux-pm+bounces-697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FA5804113
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 22:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7C71C20A53
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 21:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A78839FCC;
	Mon,  4 Dec 2023 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eb4RTXfB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EAEC0
	for <linux-pm@vger.kernel.org>; Mon,  4 Dec 2023 13:44:21 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so50809885e9.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Dec 2023 13:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701726260; x=1702331060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/w7gPHBXMUYQxVBMSHxKa0iPfJI5g4576m+rQXIaxU=;
        b=eb4RTXfBW1an/e8yMemL/ZcqN+819U5zfNQ2NEgqY8AkHye+vOThFh+BGzwkC/42uC
         0Zmir7SXyeUJGiGJr4v9oKgmRLvEeN7gzHv8XifRAx9bhkHJaVpMMOjL1KWaTph1s02B
         G5VWasdh+61OrBC7rhF4VQmw14lelG8kzkcdyq7I1iZLUnjY8gNeDTTw4dS4my6KHw5l
         r8UQILmnmtPwwlbZ+j3IvSinQiWQXYP/PtovOMOh6tRibI3kqNp5MPfRxBwrjwkB1UbF
         C6A6m8MSIYGEifIfCLpC6e46m1nDCwPPf/YFbtUUihlhNhF9yA41Jo5uZcJCV7mZker9
         FIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701726260; x=1702331060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/w7gPHBXMUYQxVBMSHxKa0iPfJI5g4576m+rQXIaxU=;
        b=t0mnGP2MbmUy74IL3FVtG1oBJYuuHsEeZOS2w4opHK3UElfLdSf4Rfdu2qBVi9Ai7s
         hC2hnx6nFN1hRPo1X6IM0oN/CGCTHbvnpZu+gFfoUPDpzRINU1K+vMI9EOflI4fbvLK1
         2VP3kQlvmcPXzvVTWV89NtVTpw0O0fcr6Zdr+/khMtHseHjbc+QgKgfz30VZBSpM1/Ft
         6oatKsa/ZFCAXRLEra4vf1IMNAL/gnNaYhzQAblJLtEOren+IW7qvRD6rG7B4BoNvkvY
         HMjP4Df3igypKOx6w0yZorysApptL7za/uaFr4+Nfm1+D5sT+bDxCcpZlm6kG2ig5WVp
         9usw==
X-Gm-Message-State: AOJu0YwyrbPE0DCh7xlWxSfJvT81qUx4WNcqFBee1jtJU3HQo5mumSOi
	G3eG03zPRqPu/A/Rd9axqzxSDw==
X-Google-Smtp-Source: AGHT+IEKr3w66+dxKPkpHMPBpU2XEHlRVOKP7Q2Cl6Hg4TXp/LQ1y5siBHOrozkPoICJuy1apjRKwg==
X-Received: by 2002:a05:600c:46c7:b0:40b:5e21:e26c with SMTP id q7-20020a05600c46c700b0040b5e21e26cmr2816769wmo.89.1701726259620;
        Mon, 04 Dec 2023 13:44:19 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:bbf5:3c34:edc0:c796? ([2a05:6e02:1041:c10:bbf5:3c34:edc0:c796])
        by smtp.googlemail.com with ESMTPSA id s8-20020a05600c45c800b00405c7591b09sm16579322wmo.35.2023.12.04.13.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 13:44:19 -0800 (PST)
Message-ID: <9750e644-8939-4ea2-a2fb-d2c7d7fbb264@linaro.org>
Date: Mon, 4 Dec 2023 22:44:18 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] thermal: sysfs: Rework the handling of trip point
 updates
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukasz Luba
 <lukasz.luba@arm.com>, Linux PM <linux-pm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <12338384.O9o76ZdvQC@kreacher> <4883151.31r3eYUQgx@kreacher>
 <b3c86caf-635d-416b-af98-9e26f2a68948@linaro.org>
 <CAJZ5v0hEo_HPMR=wVsHDTjPrEBLXgBHwom491rEiLJfapg6Rhg@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hEo_HPMR=wVsHDTjPrEBLXgBHwom491rEiLJfapg6Rhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/12/2023 18:47, Rafael J. Wysocki wrote:

[ ... ]

>>> +static int check_thermal_zone_and_trip_id(struct device *dev,
>>> +                                       struct thermal_zone_device *tz,
>>> +                                       int trip_id)
>>> +{
>>> +     if (!device_is_registered(dev))
>>> +             return -ENODEV;
>>> +
>>> +     if (trip_id < 0 || trip_id >= tz->num_trips)
>>> +             return -EINVAL;
>>
>> I'm not sure if this check is useful. The function is called from
>> trip_point_*_store() which is providing the trip id from the file name
>> parsing which is in turn built from an existing trip id. There is no
>> reason the trip id is going to be wrong.
> 
> I can drop the check just fine.
> 
> Do you have any other comments on this patch?

No, the rest LGTM


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


