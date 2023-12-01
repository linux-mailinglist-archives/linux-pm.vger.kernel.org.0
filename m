Return-Path: <linux-pm+bounces-593-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F22080069F
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 10:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2914A2815C7
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 09:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFED8C13C;
	Fri,  1 Dec 2023 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNtZTK7A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A2612A
	for <linux-pm@vger.kernel.org>; Fri,  1 Dec 2023 01:12:10 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9afe6e21fso25353091fa.0
        for <linux-pm@vger.kernel.org>; Fri, 01 Dec 2023 01:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701421928; x=1702026728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KhQP3xCo8HXzrspkeB1Wnqhp+gRrglFiHCK+ArRb5iQ=;
        b=MNtZTK7AQ6FPZ6SbeD5OmXv1EBOANvEYgBIB9A32/xhXS3PqoLhT9SEQzRLg5Y4tqO
         U23kmdMFgUvDOT/A2+uGxbmUJkO1oYIbmklNGpblB9KbHvPOVL8FXIivAtI+f60Zx4nx
         Q90P2k0k0Ifle4mypPVXBstt2I72kd09RLEG29diKYW1dvTDGr+cyJChTsSWowTHFgqP
         sJqBaksPUcePey9SOvGx+Ot0s2JZB1bkjDjIvps4Xfnqjb1mLIsar82LYw7uxxQOdueg
         4C0ORCKuF/WH/HkluV0Gy8+flzl2NNyOdaGz0JPlgO9xcEB/HXEfhnZqBLdySJS1bqVC
         STSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701421928; x=1702026728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhQP3xCo8HXzrspkeB1Wnqhp+gRrglFiHCK+ArRb5iQ=;
        b=GGKQOcwgqkRvoHUtvCR2mX/kIyGx7ti6OFum1Yz7wU3jRiKvxO6Dvf57KNXOcJNMuz
         IL38IAKMhQUkAWi9cGIwknNf8CDNB+h4ZDhYBDsfleOk4IvPoryE0l6ngx/ASQ+CcMa1
         W7Kz4U9iwkvGBQogroVg+zPCdAUz2fgQtb0t6uVrGsWYsDUdpTGuX2lh+q9ugLT627oC
         SxJS/Td5avkLPDeBHJRZyRtc5ULnNL9KCm3X8BXOoE+InoSjJMFpIbrTzarZbz7/cgo6
         mS/bAmSpXKq5XHxchjvb8K3gu95HqKRP84DojyJOBZ1glgh4wTsAh959SXfiG6bnOPtI
         94jg==
X-Gm-Message-State: AOJu0YyR4T90vGmKHg/rai8duCd/OV+Tzj3JbFa9pOLZg0u1KE2yA117
	M7OcF4yZJYKjxGtgiSv4uNQzHWFEEU3CZtIXf+U=
X-Google-Smtp-Source: AGHT+IGfRAsEl9ICW6q+Ta8z4/PxM03esfoi7+uY+5X5UtZBgEQwKWEfxNP0N6Bm4dM4IU3pzdAxJA==
X-Received: by 2002:a2e:90cf:0:b0:2c9:d863:2c2a with SMTP id o15-20020a2e90cf000000b002c9d8632c2amr489466ljg.83.1701421928459;
        Fri, 01 Dec 2023 01:12:08 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:cafc:3e65:338f:2bec? ([2a05:6e02:1041:c10:cafc:3e65:338f:2bec])
        by smtp.googlemail.com with ESMTPSA id d9-20020adffd89000000b0033330846e76sm1338394wrr.86.2023.12.01.01.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 01:12:07 -0800 (PST)
Message-ID: <39f9f662-aafd-45e5-a529-faaa5a131618@linaro.org>
Date: Fri, 1 Dec 2023 10:12:07 +0100
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
To: Radu Solea <radusolea@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org
References: <20231120234015.3273143-1-radusolea@google.com>
 <CAJZ5v0jB9ObOWR5xWme--DZxFdjCYpdf9K6=KpywYxuq6F2c3Q@mail.gmail.com>
 <CAPpbzygYCRR1OQTXSGZATU_U0bcL1t_vMu4foPiWah0C2C3-=Q@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAPpbzygYCRR1OQTXSGZATU_U0bcL1t_vMu4foPiWah0C2C3-=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Radu,

On 30/11/2023 21:33, Radu Solea wrote:
> Thank you for taking the time to discuss this.
> In the context of PM_POST_SUSPEND, there are not many guarantees. It
> mainly just guarantees that the code is executed at a particular step
> in the resume sequence and, implicitly, that the execution happens
> before another power transition. There are no order or timing promises
> made.
> Doing work on the notification chain impacts at least two things
> relevant to this change: triggering of the next items on the chain and
> completion of the write() to /sys/power/state. In a multicore context,
> both of these matter.
> The system context is battery-powered embedded devices with thermal
> zones on-board. These thermal zones are bus connected and operate
> asynchronously to the executing core, introducing delays.
> I proposed the change as optional because I cannot account for all
> possible cases. However, in the specific context of these devices,
> custom kernel configurations are the norm and it is expected that the
> integration team validates system assumptions (such as system
> unbounded queue load).
> The ultimate reason for this change is that I want my 50ms back.
> Joking aside, there are not many ways to determine that the system has
> completed a resume cycle. The write() to /sys/power/state completing
> is important in signaling that to the system at large.
> I did not include numbers in the initial submission because I do not
> expect that the numbers I see on a particular integration are easily
> replicable in other situations. However, the 50ms I am currently
> chasing are important in user-interactive systems and impact overall
> power consumption.
> Thank you,
> Radu

Please, respond inline the questions Rafael and I asked.

Thanks

   -- Daniel

> On Wed, Nov 29, 2023 at 5:09 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Tue, Nov 21, 2023 at 12:40 AM Radu Solea <radusolea@google.com> wrote:
>>>
>>> Some thermal zones are bus connected and slow to resume, thus
>>> delaying actions which depend on completion of PM_POST_SUSPEND.
>>
>> What actions in particular?
>>
>>> Add optional execution path to resume thermal zones on the system
>>> unbounded workqueue.
>>
>> Why optional?
>>
>> This is only useful for people building their own custom kernels.
>>
>>> Signed-off-by: Radu Solea <radusolea@google.com>
>>> ---
>>>   drivers/thermal/Kconfig        | 11 +++++++
>>>   drivers/thermal/thermal_core.c | 58 ++++++++++++++++++++++++++++++----
>>>   2 files changed, 62 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>>> index c81a00fbca7d..148d6e9734c6 100644
>>> --- a/drivers/thermal/Kconfig
>>> +++ b/drivers/thermal/Kconfig
>>> @@ -91,6 +91,17 @@ config THERMAL_WRITABLE_TRIPS
>>>            Say 'Y' here if you would like to allow userspace tools to
>>>            change trip temperatures.
>>>
>>> +config THERMAL_ASYNC_RESUME
>>> +       bool "Thermal async init zones on system resume"
>>> +       default n
>>> +       help
>>> +         Re-initialize thermal zones asynchronously on system resume.
>>> +         Thermal zone sensors may be attached on slow buses, impacting
>>
>> "Slow" relative to what?  How can it be determined?
>>
>>> +         the duration of PM_POST_SUSPEND. If that is a concern enable
>>> +         this switch.
>>> +
>>> +         If in doubt, say N.
>>> +
>>>   choice
>>>          prompt "Default Thermal governor"
>>>          default THERMAL_DEFAULT_GOV_STEP_WISE
>>
>> In the first place, I would like to know the exact motivation for this change.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


