Return-Path: <linux-pm+bounces-28798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72C3ADAC0A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 11:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54EF13AA43C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 09:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D69273D77;
	Mon, 16 Jun 2025 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="W7+MozSm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4AF26E179
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750066668; cv=none; b=FpLi3MjChUmjh77vCNaMIBm9AFNILR3KagvGzgmbQs60HJN9cUZxqOW+1pEo9ImFYG9B0ezklDwbteF0SFoP9Uwb/hffLUeBuCnX15brp1mUE3XuiQZb0OpThTwdvVZ74FM8mw8JFwrKIz0Gw/2plPBdZjW0sFpg38AEfByatpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750066668; c=relaxed/simple;
	bh=v7iwsXmtI/7HuEw8E5jMH8gjGCJ/PmdbDct0UukEscI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRAu8vK3HMLkVs8H62G2N8ric3liLWmr/9D/5gZI5VOSODL4u+CvtHKS2ZIoL8Vb3QzTtJ1UB81Qya6kXRoJmbWMNgxD7fcDHdap0lrOm8mf28yJvGiKBOMSmXkVFI/ciYXGT+OyEio+SxIL5UMMkmwWT20UHohqUpqWudx22kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=W7+MozSm; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-607b59b447bso7528468a12.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 02:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1750066664; x=1750671464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dfP8v62XGv6w7z/ZmGpzfijGDXvy28lSonmS90eMeCc=;
        b=W7+MozSmJ0KttRNUxdO2NaTes8jsh6mtJkE40GPIZHfMhgoWxq2VW7+1KnpgkdA933
         bY8dZsdRaZck6xWd/OnGzO+o2NR+cJ+Nx25Mz+OrDcekVJf6zgrAedgZRPV6Tf+FUtDZ
         xrwLb+8K3BvFq5a0SAywDWXOT75BAc+vVTo7a2uHxTA09UixEhyQFRteBTYH6TmIWfaJ
         St/CGkf8CZtkZLD5RvoVIz7Y3y0T5JYxd8AfKeK98PDDW6zL1kj+nZYicAa9qERwKJfV
         UVTwTCUy1RT+Yy9XM32X9TmqVQrFxLb/ik9wd1YqDxyzuyEC242Y5ZJNTBlxp1HgbuZF
         F/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750066664; x=1750671464;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfP8v62XGv6w7z/ZmGpzfijGDXvy28lSonmS90eMeCc=;
        b=MN6kYyIEiTLp7K88LNmQ6hEPFODHwcJIhf4DRcRl5CZZ5wLTtd22ifZqwLwtBYnrt7
         iIC2MQ1tS3KIH6QbHI9guSyzvSQtT8tVjvUd7LRtlp2H8R6EKpeoaCo+ETsmoFlhy1K9
         +UtKPJ6DX18r64IamKd9Xkkeqg7IoJldtYXH/icGvKk/0pWwki0Y01mEA3MgVEQHBCYa
         cS6aI+RhuJZ5fciKBWJ+O2+Jy9zFiUy6qwPtiD4/1b+HU7yaf2oGWpe8i5BEhOzMLkwY
         ZDtxZs3yfCV+KHO58OXxPdYT4Moggxz2NS8PBvJZeEucEojXmdT7W5shUErEx6icU5XM
         gOkg==
X-Forwarded-Encrypted: i=1; AJvYcCXvwQo51TmuR00CxIqj8wONzcsPj4Tnx/Oxh2UWx9HV+W68gyRpwwE/7KzDGvEgblljfxEypJC2vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqMa0RU7mGJYlwna1KWGR78KO0nFygZBHExCtYFVZti9pc6/7M
	U+W+Q3sb2GubcCyd4IQMHqWdnRgG7TE5X8D4lWSqGyl54+pxn5waIbONiUKKCxkZ6MQ=
X-Gm-Gg: ASbGncttsLlgF6k6t1hCbPV/FzThNDF7TUOoABxET+5HVALM39Q6R4xaIpIcUc2tB0s
	9aD5huD8nMjUVohdxX20KkfS6BZf02O/aXpDPmk7I3sBESwFgSel8WnVTi4hqafoS9bOh96asQT
	HjAHIFU3LoV8JrTzK4gQIgl8EhJI4U/J9Hmof6ic4ejR77VCjPVxAqxoJ5z+iC6Nma6reaNMQ6z
	Chq1ApJNSnJ4CQDi0wJ+Gh6UbClC45qVBHWrMdCLlSn4yMvddRugNn3exVh67fstXF8xLK6iYTS
	Ov4yCljDZh04UG6sJhIZRa0iQFXm4d+WXUqzGZk0S0tz/8Z58jjX9uqTFXjvkZ9/iMasxu3C6pL
	JxXB5PQ==
X-Google-Smtp-Source: AGHT+IGstgDvCZ7kkheENEgwtKA2GsdZiS2gQeWTudsZRkiraVvavy0/6m9lYQPhBNBoWFt98BlCYg==
X-Received: by 2002:a17:906:9f88:b0:ad8:96d2:f3e with SMTP id a640c23a62f3a-adfad326d9cmr714122866b.22.1750066663863;
        Mon, 16 Jun 2025 02:37:43 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adfddc96709sm126821866b.134.2025.06.16.02.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 02:37:43 -0700 (PDT)
Message-ID: <4360ee7a-d85a-4fa0-a1d6-d09a3b9d57c0@tuxon.dev>
Date: Mon, 16 Jun 2025 12:37:41 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] PM: domains: Add devres variant for
 dev_pm_domain_attach()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, gregkh@linuxfoundation.org,
 dakr@kernel.org, len.brown@intel.com, pavel@kernel.org,
 ulf.hansson@linaro.org, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bhelgaas@google.com,
 geert@linux-m68k.org, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, fabrizio.castro.jz@renesas.com,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250606111749.3142348-1-claudiu.beznea.uj@bp.renesas.com>
 <20250606111749.3142348-2-claudiu.beznea.uj@bp.renesas.com>
 <CAJZ5v0i_Ey+OVpSZHXru=tubMaZi=y-uOh_0M6zmWZ2DqqA7Vg@mail.gmail.com>
 <zhjytvj35lknj7v3jhva3n3nbv6qctvqgykwyi5huj6omet7lz@wchd7f4p4dpv>
 <CAJZ5v0hsT-Q2hz=qoBo409oungaCmexJwwGheN7KRLFqz=6_Dw@mail.gmail.com>
 <20250607140600.76e87ea5@jic23-huawei>
 <CAJZ5v0jqZ6gYKb85dpR-X5RwFeUBcbbcJ_b-AOe+JypBXod-MA@mail.gmail.com>
 <486a1110-5336-42fd-82b8-a7b1452bad65@tuxon.dev>
 <CAJZ5v0hqBm4L2V9aUjB0tmW67eRRCnM7FScgdJQ=ihnpAZuMfA@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAJZ5v0hqBm4L2V9aUjB0tmW67eRRCnM7FScgdJQ=ihnpAZuMfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Rafael,

On 13.06.2025 13:02, Rafael J. Wysocki wrote:
> On Fri, Jun 13, 2025 at 9:39 AM Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>>
>> Hi, Rafael,
>>
>> On 09.06.2025 22:59, Rafael J. Wysocki wrote:
>>> On Sat, Jun 7, 2025 at 3:06 PM Jonathan Cameron <jic23@kernel.org> wrote:
>>>>
>>>> On Fri, 6 Jun 2025 22:01:52 +0200
>>>> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>>> On Fri, Jun 6, 2025 at 8:55 PM Dmitry Torokhov
>>>>> <dmitry.torokhov@gmail.com> wrote:
>>>>>>
>>>>>> On Fri, Jun 06, 2025 at 06:00:34PM +0200, Rafael J. Wysocki wrote:
>>>>>>> On Fri, Jun 6, 2025 at 1:18 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>>>>>>
>>>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>>>
>>>>>>>> The dev_pm_domain_attach() function is typically used in bus code alongside
>>>>>>>> dev_pm_domain_detach(), often following patterns like:
>>>>>>>>
>>>>>>>> static int bus_probe(struct device *_dev)
>>>>>>>> {
>>>>>>>>     struct bus_driver *drv = to_bus_driver(dev->driver);
>>>>>>>>     struct bus_device *dev = to_bus_device(_dev);
>>>>>>>>     int ret;
>>>>>>>>
>>>>>>>>     // ...
>>>>>>>>
>>>>>>>>     ret = dev_pm_domain_attach(_dev, true);
>>>>>>>>     if (ret)
>>>>>>>>         return ret;
>>>>>>>>
>>>>>>>>     if (drv->probe)
>>>>>>>>         ret = drv->probe(dev);
>>>>>>>>
>>>>>>>>     // ...
>>>>>>>> }
>>>>>>>>
>>>>>>>> static void bus_remove(struct device *_dev)
>>>>>>>> {
>>>>>>>>     struct bus_driver *drv = to_bus_driver(dev->driver);
>>>>>>>>     struct bus_device *dev = to_bus_device(_dev);
>>>>>>>>
>>>>>>>>     if (drv->remove)
>>>>>>>>         drv->remove(dev);
>>>>>>>>     dev_pm_domain_detach(_dev);
>>>>>>>> }
>>>>>>>>
>>>>>>>> When the driver's probe function uses devres-managed resources that depend
>>>>>>>> on the power domain state, those resources are released later during
>>>>>>>> device_unbind_cleanup().
>>>>>>>>
>>>>>>>> Releasing devres-managed resources that depend on the power domain state
>>>>>>>> after detaching the device from its PM domain can cause failures.
>>>>>>>>
>>>>>>>> For example, if the driver uses devm_pm_runtime_enable() in its probe
>>>>>>>> function, and the device's clocks are managed by the PM domain, then
>>>>>>>> during removal the runtime PM is disabled in device_unbind_cleanup() after
>>>>>>>> the clocks have been removed from the PM domain. It may happen that the
>>>>>>>> devm_pm_runtime_enable() action causes the device to be runtime-resumed.
>>>>>>>
>>>>>>> Don't use devm_pm_runtime_enable() then.
>>>>>>
>>>>>> What about other devm_ APIs? Are you suggesting that platform drivers
>>>>>> should not be using devm_clk*(), devm_regulator_*(),
>>>>>> devm_request_*_irq() and devm_add_action_or_reset()? Because again,
>>>>>> dev_pm_domain_detach() that is called by platform bus_remove() may shut
>>>>>> off the device too early, before cleanup code has a chance to execute
>>>>>> proper cleanup.
>>>>>>
>>>>>> The issue is not limited to runtime PM.
>>>>>>
>>>>>>>
>>>>>>>> If the driver specific runtime PM APIs access registers directly, this
>>>>>>>> will lead to accessing device registers without clocks being enabled.
>>>>>>>> Similar issues may occur with other devres actions that access device
>>>>>>>> registers.
>>>>>>>>
>>>>>>>> Add devm_pm_domain_attach(). When replacing the dev_pm_domain_attach() and
>>>>>>>> dev_pm_domain_detach() in bus probe and bus remove, it ensures that the
>>>>>>>> device is detached from its PM domain in device_unbind_cleanup(), only
>>>>>>>> after all driver's devres-managed resources have been release.
>>>>>>>>
>>>>>>>> For flexibility, the implemented devm_pm_domain_attach() has 2 state
>>>>>>>> arguments, one for the domain state on attach, one for the domain state on
>>>>>>>> detach.
>>>>>>>
>>>>>>> dev_pm_domain_attach() is not part driver API and I'm not convinced at
>>>>>>
>>>>>> Is the concern that devm_pm_domain_attach() will be [ab]used by drivers?
>>>>>
>>>>> Yes, among other things.
>>>>
>>>> Maybe naming could make abuse at least obvious to spot? e.g.
>>>> pm_domain_attach_with_devm_release()
>>>
>>> If I'm not mistaken, it is not even necessary to use devres for this.
>>>
>>> You might as well add a dev_pm_domain_detach() call to
>>> device_unbind_cleanup() after devres_release_all().  There is a slight
>>> complication related to the second argument of it, but I suppose that
>>> this can be determined at the attach time and stored in a new device
>>> PM flag, or similar.
>>>
>>
>> I looked into this solution. I've tested it for all my failure cases and
>> went good.
> 
> OK
> 
>>> Note that dev->pm_domain is expected to be cleared by ->detach(), so
>>> this should not cause the domain to be detached twice in a row from
>>> the same device, but that needs to be double-checked.
>>
>> The genpd_dev_pm_detach() calls genpd_remove_device() ->
>> dev_pm_domain_set(dev, NULL) which sets the dev->pm_domain = NULL. I can't
>> find any other detach function in the current code base.
> 
> There is also acpi_dev_pm_detach() which can be somewhat hard to find,
> but it calls dev_pm_domain_set(dev, NULL) either.
> 
>> The code I've tested for this solution is this one:
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index b526e0e0f52d..5e9750d007b4 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/kthread.h>
>>  #include <linux/wait.h>
>>  #include <linux/async.h>
>> +#include <linux/pm_domain.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/pinctrl/devinfo.h>
>>  #include <linux/slab.h>
>> @@ -552,8 +553,11 @@ static void device_unbind_cleanup(struct device *dev)
>>         dev->dma_range_map = NULL;
>>         device_set_driver(dev, NULL);
>>         dev_set_drvdata(dev, NULL);
>> -       if (dev->pm_domain && dev->pm_domain->dismiss)
>> -               dev->pm_domain->dismiss(dev);
>> +       if (dev->pm_domain) {
>> +               if (dev->pm_domain->dismiss)
>> +                       dev->pm_domain->dismiss(dev);
>> +               dev_pm_domain_detach(dev, dev->pm_domain->detach_power_off);
> 
> I would do the "detach" before the "dismiss" to retain the current ordering.

I applied on my local development branch all your suggestions except this
one because genpd_dev_pm_detach() as well as acpi_dev_pm_detach() set
dev->pm_domain = NULL.

Due to this I would call first ->dismiss() then ->detach(), as initially
proposed. Please let me know if you consider it otherwise.

Thank you,
Claudiu

