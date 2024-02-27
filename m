Return-Path: <linux-pm+bounces-4445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 440B2869A8B
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 16:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FC31F237D7
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 15:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF8D145B2A;
	Tue, 27 Feb 2024 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4lcmzsZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE8B145B0D
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048261; cv=none; b=OQOlqoxHqqabeR2P/UnQgPUG4NnqVNGXYNEZyramiQJmAu+Gxh+WYkeL9wyA+pPyTFCMWQDT9O6SsZnUFtS+eV7KYw+DFVbBDdbNDgNrkAvQgeLc3Si/l9M0tcX6zhA341HsjydrPxXhseUfCwunMQwrb+gm86yfDlJJ9eNuFms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048261; c=relaxed/simple;
	bh=WrNAavq49JnUtL9z1fXa8kbbV9Ll1HlVFnPdARwhMTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ednyjsm5I3u2pb8brwRVfZaGZAsHdLrUEhvIXbMJPU2fKa4YsyxLB948aADvL/maF5lsawJ6dL3KnOzzhAzAAu/5bN3CqM272msZ2Wp9RFX6JSnPEORS2qahD60eSKBjAd2FmAIh1r4unrpQ/QBopifZ4tb9CrBqudqctfX40wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q4lcmzsZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d2b354c72so3212065f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 07:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709048258; x=1709653058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f011dxj9zX/OM++lF4k76GO0m8hQN5ggQ81URSsSTBQ=;
        b=Q4lcmzsZg0Wfj89MmgWRwJxBhAAxcXHY0VDeWTjn+A2ZS91Bb3dtJdSIlt6AEIEVQy
         TppnKGk4Q9u2f0e/T2MhaeQMrh9+oeXoJA0G5HnKDEIerJvQmrYXOzlH+WMbnImBVrfW
         5EarXBPS5I+Tas/UmXsWp4uZCVmxbdPapWJNkFnz+qPpGwDz/5hZHoSqyfk6hQDUqkC1
         saDu2bN2q3O5picG9ZCe+rShRRbXDr6WdebGJoD5Iapt+SiWZJ7aSissS7hpIJmQN1J3
         +pUxPHNagthwOfGZxvwNrlPjlnDaXWAMDYl/Ujm6MbLhSkceLHszAWXXOpsesEX+G3hc
         MBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709048258; x=1709653058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f011dxj9zX/OM++lF4k76GO0m8hQN5ggQ81URSsSTBQ=;
        b=wC6ldJ2NSAiAxl0BYpv7T32POjNjSfFdOU/GqDU0VK87z/WYvTjQ+aC6FHBv+K9M3j
         HYxfCDYhu8xBrUMhroH0JFOEFyJf6RaAXYX0qU5NRttjfq5ZPxfZL9By9HvyWJ/XFK7n
         Wyc39mBUQsxJVZjCIGXlSJVGpdWXrrDOw5lOnDtLf+BrEKNVoNe49aEP/SrhDa0Fa4wT
         nJAKhK/w5UB5WM6u8eajPgCSAeWsFqA6NRr2X2VPsmdGVmigYqi2OpHBGhvVQ11ORX2y
         Wue//iFI/HpIHKxbd2RfAjaOp8+RaE8CaLLLTjs17g5MAkTZ8lq/MxB1iVz6LQhswb/B
         QIVw==
X-Forwarded-Encrypted: i=1; AJvYcCXbv2Q/+Ipr5z6CKnNZNdE1ZnRFFMaH9au4a4Cd6UPEtU+AQAtxXo/BVAHYp/daIovJol2TXZSjJ/CJLizk7/J+N7Kj0F6ccT4=
X-Gm-Message-State: AOJu0YyjkYcutk0bLMt2KD4by407ttdAlca66HvZm6eKB29Bbh7l6PCU
	mzRw3TbMNbJ1G2AXsD/N8q6hEM8F1y539fLtSqUEDaPwaIEgFhoev9wz2uYiXAc=
X-Google-Smtp-Source: AGHT+IEZ9Q2DpyJ+09LMJ9SXPvNjO+kk0h+b3Ur06pLLqMWUNExCixaGNE9ytC+Nwv3uhK01GyCZbQ==
X-Received: by 2002:adf:f150:0:b0:33d:1469:d254 with SMTP id y16-20020adff150000000b0033d1469d254mr3099982wro.70.1709048258133;
        Tue, 27 Feb 2024 07:37:38 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id t9-20020adfeb89000000b0033dbeb2eb4dsm11549365wrn.110.2024.02.27.07.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 07:37:37 -0800 (PST)
Message-ID: <f81af0ae-7458-47d3-90ae-71d5217ee7dd@linaro.org>
Date: Tue, 27 Feb 2024 16:37:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: core: Move initial num_trips assignment before
 memcpy()
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, rui.zhang@intel.com,
 lukasz.luba@arm.com, keescook@chromium.org, gustavoars@kernel.org,
 morbo@google.com, justinstitt@google.com, stanislaw.gruszka@linux.intel.com,
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, patches@lists.linux.dev
References: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>
 <6a6be01d-3453-4268-8b2e-0279cc20835d@linaro.org>
 <CAJZ5v0h87k6xoi-9V0Cfb2rHQcr-STfG_bNWpzfoj4Dy46U0Lw@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0h87k6xoi-9V0Cfb2rHQcr-STfG_bNWpzfoj4Dy46U0Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/02/2024 12:09, Rafael J. Wysocki wrote:
> On Tue, Feb 27, 2024 at 11:14 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 27/02/2024 01:54, Nathan Chancellor wrote:
>>> When booting a CONFIG_FORTIFY_SOURCE=y kernel compiled with a toolchain
>>> that supports __counted_by() (such as clang-18 and newer), there is a
>>> panic on boot:
>>>
>>>     [    2.913770] memcpy: detected buffer overflow: 72 byte write of buffer size 0
>>>     [    2.920834] WARNING: CPU: 2 PID: 1 at lib/string_helpers.c:1027 __fortify_report+0x5c/0x74
>>>     ...
>>>     [    3.039208] Call trace:
>>>     [    3.041643]  __fortify_report+0x5c/0x74
>>>     [    3.045469]  __fortify_panic+0x18/0x20
>>>     [    3.049209]  thermal_zone_device_register_with_trips+0x4c8/0x4f8
>>>
>>> This panic occurs because trips is counted by num_trips but num_trips is
>>> assigned after the call to memcpy(), so the fortify checks think the
>>> buffer size is zero because tz was allocated with kzalloc().
>>>
>>> Move the num_trips assignment before the memcpy() to resolve the panic
>>> and ensure that the fortify checks work properly.
>>>
>>> Fixes: 9b0a62758665 ("thermal: core: Store zone trips table in struct thermal_zone_device")
>>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>>> ---
>>>    drivers/thermal/thermal_core.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>>> index bb21f78b4bfa..1eabc8ebe27d 100644
>>> --- a/drivers/thermal/thermal_core.c
>>> +++ b/drivers/thermal/thermal_core.c
>>> @@ -1354,8 +1354,8 @@ thermal_zone_device_register_with_trips(const char *type,
>>>
>>>        tz->device.class = thermal_class;
>>>        tz->devdata = devdata;
>>> -     memcpy(tz->trips, trips, num_trips * sizeof(*trips));
>>>        tz->num_trips = num_trips;
>>> +     memcpy(tz->trips, trips, num_trips * sizeof(*trips));
>>
>> IIUC, clang-18 is used and supports __counted_by().
>>
>> Is it possible sizeof(*trips) returns already the real trips array size
>> and we are multiplying it again by num_trips ?
>>
>> While with an older compiler, __counted_by() does nothing and we have to
>> multiply by num_trips ?
>>
>> IOW, the array size arithmetic is different depending if we have
>> _counted_by supported or not ?
> 
> IIUC it is just the instrumentation using the current value of
> tz->num_trips (which is 0 before the initialization).

Right, but I am wondering if

	memcpy(tz->trips, trips, num_trips * sizeof(*trips));

	is still correct with __counted_by because:

  (1) if the compiler supports it:

	sizeof(*trips) == 24 bytes * num_trips

	then:

	memcpy(tz->trips, trips, num_trips * sizeof(*trips));

	memcpy(tz->trips, trips, num_trips * 24 * num_trips);

	==> memory size = 24 * num_trips^2

  (2) if the compiler does not support it:

	sizeof(*trips) == 24 bytes

	then:

	memcpy(tz->trips, trips, num_trips * sizeof(*trips));

	memcpy(tz->trips, trips, num_trips * 24);

	==> memory size = 24 * num_trips

Or did I misunderstand __counted_by ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


