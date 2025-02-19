Return-Path: <linux-pm+bounces-22422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0854BA3BE63
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 13:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD48A16903B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 12:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4611E1A33;
	Wed, 19 Feb 2025 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="dWM/VX4j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4265C1E102E
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969114; cv=none; b=dosDjGJ4E48JHXO8nJm2ONmY6OBnyMB4zaHdkkHMdaPqkHdrd4dKdAKAnfxUNl0lcyLEb53afCYn0HelRcgDNs4wkpTr1dZv0eYGaBaNVIsw+H9MOZnV99ytGIQlwNorGncq5lOk0pSWflzRG2ZTtyqLlBLE6U/iKdrl8SR7nF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969114; c=relaxed/simple;
	bh=P+gV28lKZRdfBrqRS0IUOyxV12AN6CkJXtnoB0Q4LhU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EB09QI+GljR1y0nyZ/Hyci/ODDzfqha/hzRo4QooGIfF32jVoOD6v16KbAoUthQPNeIWiACvF5JXqh7/N9OD8tVVAbKglZxfmJf6N6ChO4aRZii/sFy3xVnzZh+l1S53vEo+Pi0jw1IosxtjW7vaD2uVOTBEdv8daWngVlOcEXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=dWM/VX4j; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abbac134a19so413558766b.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 04:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739969110; x=1740573910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8aWk9ACxeOktVt7eviYGo7lrFquCo7Eax3iBYmtuH50=;
        b=dWM/VX4jF8QeQNKpWe2OLTFW8wbKTbTTiIMq1bsxMfuTG2YipiwIiZUaQ6GxkdVdZ2
         l8UdB1AuEhi5QNzq9ILiAp/HYh98lZCyPCiLlPAJZO6NI3k4YV5G9YAgUamcJZ7nxbw1
         qOCCHwIFrZkqF9FH/T2SX/EVAvHc8zuyIQBnNrqkSs2CtT4z43xntwrWw/gJA6w91DgR
         gZ8LnN1d7K4THpjnYEpXDq8YdK4emLB3jEjw3/7nlQK1HQwuQeRSTNgrONi4zHtg9brU
         I1kZNvW7LQafC94NMLgj61QeMiZzw/hqD3DGCsMlLnUfPCFz7l+mxh1iH7JJ513C4dMs
         qq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969110; x=1740573910;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aWk9ACxeOktVt7eviYGo7lrFquCo7Eax3iBYmtuH50=;
        b=gTXFrKIa/pMghcyNapCVhONARu4nnjMnnqQE7D6i2KhBLLVNo6XP/EyIzmG1SjOI6f
         8XfCWxBMOe318Lv3sfU3HoFu2TMQgfdsSfHMpaI4J//5cEI3MnMIvRHx4OT5spxSkY8h
         62+CKdZdgDpAbXpcIiMAg0j36Qy9+jIOHXSS+bipj3iosNd3vUF/V+dcIOMl4FEsp+mG
         nkEc/yJF3A15w0fhKrBQd3+x/dq4zPPL8nOD78rF96+kDJ1OVPFp/OO9VbeiRmM1VFZ4
         ifo64KW5qe+6zfIfYpDlrxas3dGFADQUq+m5gzs+1zLiA7ck8Ca/wU8Rih8Vn/3wV959
         I5CA==
X-Forwarded-Encrypted: i=1; AJvYcCUoXlSxxvfioGILChEQvfTqwlNPiOEPCH5UqTs3zjzovfJfV6YFjms/tM9AuQDoS0avPwzHI/hsLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFicACIxtWajgNSzsiHnnnGZ4sKBm9pkn7D2i0lXAjGwBK1cdm
	XaM8eqrmwPVOMQW5M7lQJxOILo0/OGA7Qfspv9xKUXJbTCMjP4Xqmab9tgHN8MI=
X-Gm-Gg: ASbGncv5Q9zfEswIzpyZgDsBezvzYiTlUR7OIb6a2vBAUI9qgEiIIW6d76PvWa68YQc
	XKKbUuagU3y0YkT1jH9XBAkFVLLbRCMgEDH1oILDLs0mnZxMD+4+mwSztfURYIhEuUBLviFLtx5
	0MnKOvbX9K+K05nfI93NKleoKB3Cx+qOyCXLNYbUWHosJfJRPq7AUiaQWdP4o5xVaDZDwdA3MAM
	F5RVg4qOoR/hb1HzKozVzQf3cBUw/g7ziYj2O1GK4TV1EROnUpqi+uB/j3TnBmueTCc+PcwLQrK
	8Vek2JbIhvUB/lFFtEWObBQ=
X-Google-Smtp-Source: AGHT+IFYOVix0/dEDuKvIlQRX7Je/rbWqPWV9hEJk5Bq1TOCsIV+uU9vL3eEn13Z0cJvKpMHBrX2xQ==
X-Received: by 2002:a17:907:72cf:b0:aa6:96ad:f903 with SMTP id a640c23a62f3a-abb70db0230mr1396162866b.31.1739969109935;
        Wed, 19 Feb 2025 04:45:09 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb836ee14dsm771388866b.47.2025.02.19.04.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 04:45:09 -0800 (PST)
Message-ID: <8d83ea72-bb81-4c63-bf69-28cf5848ae20@tuxon.dev>
Date: Wed, 19 Feb 2025 14:45:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: Jonathan Cameron <jic23@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, dakr@kernel.org, ulf.hansson@linaro.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com>
 <2025021539-untrained-prompter-a48f@gregkh>
 <4bf01946-90e3-4169-91fa-10d9f90310e9@tuxon.dev>
Content-Language: en-US
In-Reply-To: <4bf01946-90e3-4169-91fa-10d9f90310e9@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Daniel, Jonathan,

On 15.02.2025 15:51, Claudiu Beznea wrote:
> Hi, Greg,
> 
> On 15.02.2025 15:25, Greg KH wrote:
>> On Sat, Feb 15, 2025 at 03:08:49PM +0200, Claudiu wrote:
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> On the Renesas RZ/G3S (and other Renesas SoCs, e.g., RZ/G2{L, LC, UL}),
>>> clocks are managed through PM domains. These PM domains, registered on
>>> behalf of the clock controller driver, are configured with
>>> GENPD_FLAG_PM_CLK. In most of the Renesas drivers used by RZ SoCs, the
>>> clocks are enabled/disabled using runtime PM APIs. The power domains may
>>> also have power_on/power_off support implemented. After the device PM
>>> domain is powered off any CPU accesses to these domains leads to system
>>> aborts.
>>>
>>> During probe, devices are attached to the PM domain controlling their
>>> clocks and power. Similarly, during removal, devices are detached from the
>>> PM domain.
>>>
>>> The detachment call stack is as follows:
>>>
>>> device_driver_detach() ->
>>>   device_release_driver_internal() ->
>>>     __device_release_driver() ->
>>>       device_remove() ->
>>>         platform_remove() ->
>>> 	  dev_pm_domain_detach()
>>>
>>> During driver unbind, after the device is detached from its PM domain,
>>> the device_unbind_cleanup() function is called, which subsequently invokes
>>> devres_release_all(). This function handles devres resource cleanup.
>>>
>>> If runtime PM is enabled in driver probe via devm_pm_runtime_enable(), the
>>> cleanup process triggers the action or reset function for disabling runtime
>>> PM. This function is pm_runtime_disable_action(), which leads to the
>>> following call stack of interest when called:
>>>
>>> pm_runtime_disable_action() ->
>>>   pm_runtime_dont_use_autosuspend() ->
>>>     __pm_runtime_use_autosuspend() ->
>>>       update_autosuspend() ->
>>>         rpm_idle()
>>>
>>> The rpm_idle() function attempts to resume the device at runtime. However,
>>> at the point it is called, the device is no longer part of a PM domain
>>> (which manages clocks and power states). If the driver implements its own
>>> runtime PM APIs for specific functionalities - such as the rzg2l_adc
>>> driver - while also relying on the power domain subsystem for power
>>> management, rpm_idle() will invoke the driver's runtime PM API. However,
>>> since the device is no longer part of a PM domain at this point, the PM
>>> domain's runtime PM APIs will not be called. This leads to system aborts on
>>> Renesas SoCs.
>>>
>>> Another identified case is when a subsystem performs various cleanups
>>> using device_unbind_cleanup(), calling driver-specific APIs in the process.
>>> A known example is the thermal subsystem, which may call driver-specific
>>> APIs to disable the thermal device. The relevant call stack in this case
>>> is:
>>>
>>> device_driver_detach() ->
>>>   device_release_driver_internal() ->
>>>     device_unbind_cleanup() ->
>>>       devres_release_all() ->
>>>         devm_thermal_of_zone_release() ->
>>> 	  thermal_zone_device_disable() ->
>>> 	    thermal_zone_device_set_mode() ->
>>> 	      struct thermal_zone_device_ops::change_mode()
>>>
>>> At the moment the driver-specific change_mode() API is called, the device
>>> is no longer part of its PM domain. Accessing its registers without proper
>>> power management leads to system aborts.
>>>
>>> Open a devres group before calling the driver probe, and close it
>>> immediately after the driver remove function is called and before
>>> dev_pm_domain_detach(). This ensures that driver-specific devm actions or
>>> reset functions are executed immediately after the driver remove function
>>> completes. Additionally, it prevents driver-specific runtime PM APIs from
>>> being called when the device is no longer part of its power domain.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>> ---
>>>
>>> Hi,
>>>
>>> Although Ulf gave its green light for the approaches on both IIO [1],
>>> [2] and thermal subsystems [3], Jonathan considered unacceptable the
>>> approaches in [1], [2] as he considered it may lead to dificult to
>>> maintain code and code opened to subtle bugs (due to the potential of
>>> mixing devres and non-devres calls). He pointed out a similar approach
>>> that was done for the I2C bus [4], [5].
>>>
>>> As the discussions in [1], [2] stopped w/o a clear conclusion, this
>>> patch tries to revive it by proposing a similar approach that was done
>>> for the I2C bus.
>>>
>>> Please let me know you input.
>>
>> I'm with Jonathan here, the devres stuff is getting crazy here and you
>> have drivers mixing them and side affects happening and lots of
>> confusion.  Your change here is only going to make it even more
>> confusing, and shouldn't actually solve it for other busses (i.e. what
>> about iio devices NOT on the platform bus?)
> 
> You're right, other busses will still have this problem.
> 
>>
>> Why can't your individual driver handle this instead?
> 
> Initially I tried it at the driver level by using non-devres PM runtime
> enable API but wasn't considered OK by all parties.
> 
> I haven't thought about having devres_open_group()/devres_close_group() in
> the driver itself but it should work.

Are you OK with having the devres_open_group()/devres_close_group() in the
currently known affected drivers (drivers/iio/adc/rzg2l_adc.c and the
proposed drivers/thermal/renesas/rzg3s_thermal.c [1]) ?

Thank you,
Claudiu

[1]
https://lore.kernel.org/all/20250103163805.1775705-5-claudiu.beznea.uj@bp.renesas.com

> 
> Thank you,
> Claudiu
> 
>>
>> thanks,
>>
>> greg k-h
> 


