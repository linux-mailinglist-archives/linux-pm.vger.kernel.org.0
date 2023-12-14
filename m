Return-Path: <linux-pm+bounces-1130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2370F812A3F
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 09:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4791A1C20B70
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 08:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB469171BE;
	Thu, 14 Dec 2023 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USO2UvFW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73196107
	for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 00:25:03 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50e04354de0so4219986e87.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 00:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702542301; x=1703147101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M6vw2GLCUf7GT82hkqyE8vdLh4lYncoTJiucmBXSj5U=;
        b=USO2UvFWJILDpyBZXtK0KEyJZ38MTTR2PgCp86PWmG7E5RTctO3tg3KMdHTvyWIHwt
         BBJQrR99krKam9cf0FG90XS8OG6euhGIApE7+uiEcPHbGI2TgAOcudsQ5YFYkNIuAnWf
         C3lDxT5+u3Hpe5/Z/EoRCi1wKhLQ7HOD2EhEEs28j/guX5CvIZ8Dr3FeM6pcGrcM/qLt
         xXxgMmdwTLGpwaGGy9pGoWgbzh2Xgyl8ulusNu2VBi6J0yPMmcJCQgmEchKt5AX4whXh
         ZQ5aJ1HB/DYX8uYb25VK0SuSKoVSZb7AWdEUNPos3OqC39Ph19CUNo2TnB3StiLC0Cjk
         nmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702542301; x=1703147101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6vw2GLCUf7GT82hkqyE8vdLh4lYncoTJiucmBXSj5U=;
        b=nXwi1sHlSLO5qf2J1KZLEUCYp9otnw7F7AjTykXoBWHt8cRmLWytqiOstGsXIeKJst
         eeq9r6CrQCpt7EDfPKgz6E+AJ7cUUA7n912IUWUOHxSf7ozB2ATM/WFzuSueQci0XIcb
         nA4DyTbSIWCeUjics65sKvqlhoIBg7XeGAUBp1/AswHFpFfUxTFmHYnTz5U7YRe9/hyW
         fP+I/763sv/ov9aJ3nm6HdZpKQLfa3KNFaoPSouCYp5tNAmkAaSV6iHHc02JGkN976de
         sZgldXlE1yXAbceS5Wg5JOYOq00iNzJuxWG/8UAg21AY+Rx1Ib8CRelJOEjhNwhqFYcz
         BaKA==
X-Gm-Message-State: AOJu0YyUwfF4pyFXf+wFpjvgPVXP2cK2Buy9h+avOyOzuxMBojrTLIhJ
	lnSZBawe+E5An7qB7/GJW54HKtQMMcxAfVG0uPA=
X-Google-Smtp-Source: AGHT+IFgTxkF3PbxR5jjkJUxudBCobUc4+s5YLUeZD6NWMIOFrYpkKjqahc1vq9MWiBBl9o0PDvueQ==
X-Received: by 2002:a05:6512:a8b:b0:50e:d55:3927 with SMTP id m11-20020a0565120a8b00b0050e0d553927mr1916656lfu.66.1702542301497;
        Thu, 14 Dec 2023 00:25:01 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id n8-20020adfe788000000b003364448ae91sm1909027wrm.10.2023.12.14.00.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 00:25:01 -0800 (PST)
Message-ID: <b5d75de8-2006-40fa-add7-2db59f3e6cc4@linaro.org>
Date: Thu, 14 Dec 2023 09:25:00 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] thermal core: add option to run PM_POST_SUSPEND
 asynchronously
Content-Language: en-US
To: Radu Solea <radusolea@google.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org
References: <20231120234015.3273143-1-radusolea@google.com>
 <9d1009d9-b95b-4152-841f-19470a17ba97@linaro.org>
 <CAPpbzyhEkqjA0Kv=f_O1hy-dT8o-O4tPB_KpQqbE9b7vwC+2NA@mail.gmail.com>
 <570c9777-3d89-4f3c-b856-3e821883a7e2@linaro.org>
 <CAPpbzyiZmxhfQDOukEeuDv+B6j3CH43ugx_WyAvR3B-riRZChQ@mail.gmail.com>
 <0412fada-037d-47ea-bc3a-4634d134232c@linaro.org>
 <CAPpbzyiUEc0_5mDOWGQyXGbN4J4x8PHHBVRRUq4bSmqFdp4XtQ@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAPpbzyiUEc0_5mDOWGQyXGbN4J4x8PHHBVRRUq4bSmqFdp4XtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/12/2023 01:21, Radu Solea wrote:

[ ... ]

>>> I can't go into much detail about the hardware. But let's put it this
>>> way, if thermal_zone_device_update() takes 5 ms for each device (read
>>> temp, get trips, set trips, etc). Assume 5 onboard thermal zones, on a
>>> good day, ignoring system churn you'd get to around 25ms (already
>>> significant).
>>> Now on top of that add that these devices have multiple functions,
>>> like a PMIC for example. The resume sequence is the perfect time frame
>>> where you'd encounter more than one operation aimed at any one of
>>> these devices. Unless you have uncommonly smart drivers and devices,
>>> these will be queued.
>>> The driver in most cases will spin (hardly ideal, but realistic), even
>>> if they would yield the effect on the completion of the chain is at
>>> least the same or, likely, worse.
>>>
>>> To the patch itself, I realized I've been somewhat hamfisted.
>>> thermal_zone_device_init() should not be deferred, and likely should
>>> execute for all zones before the in_suspend lock-out is released. I'll
>>> correct that once we've landed on something.
>>>
>>> To my 50ms, it's almost the worst-case, but it happens way more often
>>> than would be comfortable.
>>
>> If you call monitor_thermal_zone() instead of
>> thermal_zone_device_update(), does it speed up the resume time ?
>>
> Looks like it does, I'll rework the patch. Don't think the config
> switch is useful anymore.

Well, we probably have to go a bit further in the concept.

There are some thermal zones which may need to be checked immediately 
and others no. That depends on the temperature speed behavior.

The higher is the temperature speed for a device, the lower is the 
polling (including zero).

So the monitoring delay can be used as a criteria to check if the 
thermal zone needs an update or postpone the monitoring.

As we don't want to change the current behavior, we can add a global 
option telling the polling delay above which we call 
monitor_thermal_zone() and defaulting to zero.

Does it make sense?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


