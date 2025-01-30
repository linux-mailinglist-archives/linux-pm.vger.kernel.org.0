Return-Path: <linux-pm+bounces-21121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 435F9A22B9F
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 11:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923FA167C3A
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 10:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215191BCA0F;
	Thu, 30 Jan 2025 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="amRDREqI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8012CAB
	for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2025 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738233020; cv=none; b=cuJM3vuPiJAL0xTYmexjMcFrdq04SIPbcrOAdc8wR4aH7BV0tscN3XrEHGVnW6frjCy1ctk6k50aAEhxpZB9qaLYD6W73E7HbFmgwYooayEDk/DaylXKczKbGqcBdJPHSf5eT5e4ToPKJj3WNGjjSp+FKEJC6lmjWyR+aLqWQ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738233020; c=relaxed/simple;
	bh=9BITPfhJak9yxr63zwmqmILswJmVJcpMs/eWfAuDZB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIAxHJ3Oraltv4AlpMhoBj0veBD7tiPycFTRTgvXEpupkHA0ELlesmrkF57Vqooggb2y18dQa417bXrX/MyAQtzcB1TiMq5AE73F1j/5FWzPvwlNWGIl7SJiz9GDtLH3dBh0hkGAtKNrbOtR7fF10Nh1WLQQewlgT/+v1OV9lyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=amRDREqI; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so327874f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2025 02:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1738233014; x=1738837814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wXtZy6LMBzv/duDzrc4vs7XbX/T/7y1xABAgQu3rKE=;
        b=amRDREqIMrQuoHZoASBVKJ7NUt8cZ4T1zPYQrt8+vOm+dYYulOoaszWsJdT+3S/3iZ
         YwOnZ24TqPCSXY1Nvv4op1yEWDyDuZLByXNluHiTf/j2mFjLMGVJDk7nioG2nY3kjXWn
         AYtwqD80r4zz5u6nnnrh1XWQalSMJGkjykf+BDG7Q6TvrDJhOWuAjY1KkZqi0Y0/bfWi
         Yp+AkMlflx1SZqCtZ4B9+ujzJU0zs/d+sNOI+UGd3q2xdyXX46o5a1UDh9sAkX73/VfE
         4jeMQHRPvNVEYv2sAAY65QfERAQzzbZlg+KG8rtWFGzhqgm+bMqptjeOlsoDpSVWtqNw
         b8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738233014; x=1738837814;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wXtZy6LMBzv/duDzrc4vs7XbX/T/7y1xABAgQu3rKE=;
        b=P+ezfVUIOA1jj3dR7x1p6HsmUUCZWlYcLGhM2Ff3SS4bwaEBGN4q9pDNbBc1VGFdtt
         6mvxpZS0dUAeaQATNb5KndmDa/+TOQXbZqTU4x4dpQOSZd/ERCgdjmhvi0Kl307sDI4p
         n+HQiWDVkkWiTkPtvlnhGdcGkC32WSHWpx1QFGkeZePjeUTepSSQpaW7g8A5kh69oy0C
         J9gJveojHRX/KdTs1HiViitlYtgMF+dZ4ZR3OEOPabQrtf8KxjONiRddePbsIqnb31Q5
         KLyZqsGy11MDeIn0OtEfsA/e9a/pc901ck0rGf2vHsRXUkUYVwq+uHd1COrcZV1J3OJK
         672A==
X-Forwarded-Encrypted: i=1; AJvYcCUSD2UaB/OnH/U0Aae61q2RK29rdCeOo7OCTmG+tq27254wq3xIXw2WS5WhFrxmvTBpKrYMtzj79Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gPsMn+dDiv5QH4e5QDAjwWuYj0cITKoqfi6xz5rqhSmyi4Ol
	XfYEFGMIvuMrwxg49joFWzgwwE7lQro54aCZGY3nQoGSj2bnrTZNFnli9d9oLvs=
X-Gm-Gg: ASbGncu9iV1DuCyB33lumWCWWUNILv5Voyv2b/BXVnWRBWkVLVtsfnU0bR2eej6kCIU
	gFXI5ndlRojn7qPww7VIW8B2YP275qF147RYdIeMFsvowjHKi9zqeQm3g0PqO8gEJ5bCXqkOI9k
	S7xin4wTWM4LjD013SlAZkn+FQnOWL74vJYPRtO9lY1sCBuRu+SfZTjiHdImXoSLtO6JSYP9wrQ
	Gip8WkWe6ExgkamCa5JN6CqqZ3qTohDIWbvdBY0EXfBMfTqSUDDVKB+PQwM/Vpk31Ahi9lBL4qb
	0+Hx0rb6c3OzTH0VHVBgoct0
X-Google-Smtp-Source: AGHT+IFRsLdabS1EP/8zZABqYuIxLkY55xahqM3ApidGDdm8kd9LPTBfoVk1hedbQbX+OgyCR0PRRg==
X-Received: by 2002:a05:6000:1548:b0:385:e429:e591 with SMTP id ffacd0b85a97d-38c51973d2fmr6410045f8f.23.1738233014363;
        Thu, 30 Jan 2025 02:30:14 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1cf53asm1512693f8f.87.2025.01.30.02.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 02:30:13 -0800 (PST)
Message-ID: <6ed7d545-82d7-4bca-95ec-95447586bb58@tuxon.dev>
Date: Thu, 30 Jan 2025 12:30:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] thermal: of: Export non-devres helper to
 register/unregister thermal zone
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, ulf.hansson@linaro.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com>
 <20250103163805.1775705-3-claudiu.beznea.uj@bp.renesas.com>
 <Z5pkUNNvsWPjRQvy@mai.linaro.org>
 <65a16c3f-456e-40ec-91b0-afb57269ed46@tuxon.dev>
 <Z5tPR_tv7vWDkUI7@mai.linaro.org>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <Z5tPR_tv7vWDkUI7@mai.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30.01.2025 12:07, Daniel Lezcano wrote:
> On Thu, Jan 30, 2025 at 11:08:03AM +0200, Claudiu Beznea wrote:
>> Hi, Daniel,
>>
>> On 29.01.2025 19:24, Daniel Lezcano wrote:
>>> Hi Claudiu,
>>>
>>> On Fri, Jan 03, 2025 at 06:38:01PM +0200, Claudiu wrote:
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> On the Renesas RZ/G3S (and other Renesas SoCs, e.g., RZ/G2{L, LC, UL}),
>>>> clocks are managed through PM domains. These PM domains, registered on
>>>> behalf of the clock controller driver, are configured with
>>>> GENPD_FLAG_PM_CLK. In most of the Renesas drivers used by RZ SoCs, the
>>>> clocks are enabled/disabled using runtime PM APIs.
>>>>
>>>> During probe, devices are attached to the PM domain controlling their
>>>> clocks. Similarly, during removal, devices are detached from the PM domain.
>>>>
>>>> The detachment call stack is as follows:
>>>>
>>>> device_driver_detach() ->
>>>>   device_release_driver_internal() ->
>>>>     __device_release_driver() ->
>>>>       device_remove() ->
>>>>         platform_remove() ->
>>>> 	  dev_pm_domain_detach()
>>>>
>>>> In the upcoming Renesas RZ/G3S thermal driver, the
>>>> struct thermal_zone_device_ops::change_mode API is implemented to
>>>> start/stop the thermal sensor unit. Register settings are updated within
>>>> the change_mode API.
>>>>
>>>> In case devres helpers are used for thermal zone register/unregister the
>>>> struct thermal_zone_device_ops::change_mode API is invoked when the
>>>> driver is unbound. The identified call stack is as follows:
>>>>
>>>> device_driver_detach() ->
>>>>   device_release_driver_internal() ->
>>>>     device_unbind_cleanup() ->
>>>>       devres_release_all() ->
>>>>         devm_thermal_of_zone_release() ->
>>>> 	  thermal_zone_device_disable() ->
>>>> 	    thermal_zone_device_set_mode() ->
>>>> 	      rzg3s_thermal_change_mode()
>>>>
>>>> The device_unbind_cleanup() function is called after the thermal device is
>>>> detached from the PM domain (via dev_pm_domain_detach()).
>>>>
>>>> The rzg3s_thermal_change_mode() implementation calls
>>>> pm_runtime_resume_and_get()/pm_runtime_put_autosuspend() before/after
>>>> accessing the registers. However, during the unbind scenario, the
>>>> devm_thermal_of_zone_release() is invoked after dev_pm_domain_detach().
>>>> Consequently, the clocks are not enabled, as the device is removed from
>>>> the PM domain at this time, leading to an Asynchronous SError Interrupt.
>>>> The system cannot be used after this.
>>>
>>> I've been through the driver before responding to this change. What is the
>>> benefit of powering down / up (or clock off / on) the thermal sensor when
>>> reading the temperature ?
>>>
>>> I can understand for disable / enable but I don't get for the classic usage
>>> where a governor will be reading the temperature regularly.
>>
>> I tried to be as power saving as possible both at runtime and after the IP
>> is not used anymore as the HW manual doesn't mentioned anything about
>> accuracy or implications of disabling the IP clock at runtime. We use
>> similar approach (of disabling clocks at runtime) for other IPs in the
>> RZ/G3S SoC as well.
>>
>>>
>>> Would the IP need some cycles to capture the temperature accurately after the
>>> clock is enabled ?
>>
>> There is nothing about this mentioned about this in the HW manual of the
>> RZ/G3S SoC. The only points mentioned are as described in the driver code:
>> - wait at least 3us after each IIO channel read
>> - wait at least 30us after enabling the sensor
>> - wait at least 50us after setting OE bit in TSU_SM
>>
>> For this I chose to have it implemented as proposed.
> 
> IMO, disabling/enabling the clock between two reads through the pm runtime may
> not be a good thing, especially if the system enters a thermal situation where
> it has to mitigate.
> 
> Without any testing capturing the temperatures and compare between the always-on
> and on/off, it is hard to say if it is true or not. Up to you to test that or
> not. If you think it is fine, then let's go with it.

I tested it with and w/o the runtime PM and on/off support (so, everything
ON from the probe) and the reported temperature values were similar.

Thank you,
Claudiu

>  
>> If any, the HW manual is available here
>> https://www.renesas.com/en/document/mah/rzg3s-group-users-manual-hardware?r=25458591
>> (an archive is here; the manual is in Deliverables/r01uh1014ej0110-rzg3s.pdf)
>>
>> Thank you for your review,
>> Claudiu
>>
>>>
>>>> Add thermal_of_zone_register()/thermal_of_zone_unregister(). These will
>>>> be used in the upcomming RZ/G3S thermal driver.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
> 


