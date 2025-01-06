Return-Path: <linux-pm+bounces-19980-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69EDA02198
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 10:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D606F7A17C5
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903B61D63F7;
	Mon,  6 Jan 2025 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="CJU69mBi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA347EEB2
	for <linux-pm@vger.kernel.org>; Mon,  6 Jan 2025 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155128; cv=none; b=Wkc27ANtI0r0qWz3xUQI6wMT78K9H+2zXCzVNvP8CW9CnI8dCderIwlk8ULXRTHW7gnpaXyTex3qdKXGR4hcUxrSukvjZwZmd/o6D1HS6LoejhDm71l5x9wZcwsimLKGS+fUb8F08NTtYRMP88n9yRoyoybTzMMl8SUqD99umwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155128; c=relaxed/simple;
	bh=RnTORvbm0gnQw+JAYaXlL1z80u4lpfomXvVmpfqsKWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWppqxRh0wcXWv0Ao9M17v9+pn26bWXQF7FSoETzoC1XwylnaMEf2d28mw2YI4KY2FzWgSnQUKMDiz6fApu7oLJvwtDW6e4dBNY0pO6xUs3nvQz/L12DCGj+bo/eNVLD6cv38ePxaQ/NW3cf9j1h4eAgTeS/bxOG9CqhcT278Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=CJU69mBi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so161280315e9.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2025 01:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1736155123; x=1736759923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RytLxRZxC8L+SoHq2QUPWp7tJd9AZXXGwn4jAy0YyYg=;
        b=CJU69mBiG7V8NwDeYmoX0qJIauhfFeTyzPkSn4nS/B9u4QbZ+MqSn/caf4crkhxifD
         x8Yt6oSCf/lzY10JKzE0tQ8xRoMgTJKdRNS1QQ46Tv3HzoWEBANvhryjtnaz1A7T5AwC
         HpX1h9OkkXDFlpAEiA6JMr+mnKyHgr39N/BxjnO8tJo/SUkfCkt020wLxeBzxkS8O0Mb
         2k+9HuY58F/qVOpbeouCC2f6vkjwcUSccXMmM6ekqXF42S6M1pYGc40UsBr0nGAwN+nN
         zx9LRTVM5vi0kOOzYMUbjGOyzmb3PQ/xiIovxnAIlKGYOdiLYgnYCde2pIkjhjmXiphy
         742Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736155123; x=1736759923;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RytLxRZxC8L+SoHq2QUPWp7tJd9AZXXGwn4jAy0YyYg=;
        b=EmDUeWCJhOoLSdwwRLuRd+8z7TPWy2jP+okP8l75bagRbT4PmolpXrN+edId1oNx/H
         SDQ3tecVKkjSU/69RsoKUVEMn9lWN4n0Uwf4mh4jELeS86dN0dU0bnCUkpuTrp+jt5hA
         mp3Gu+HysWWwbMKjXiliFUjSoxtm+nBcuY6PFJyOKcRBA+WFZZmy+rhSmrYCIx9FjeXU
         qr2LoLZCZUN+DCcJVTnqvrhyWYZImvhX7iJshbTVc+hWpD4uy1g10JqtE7/7gqD4U8/S
         M4ioRL4jopYri7XKWpNMBsnWk0ELdYBZqsCr9cuOQemnFEy8BrURF217d0pIEPRse4/K
         WNlw==
X-Forwarded-Encrypted: i=1; AJvYcCV/hEGtE1E7Y0vkl8gzQ6mjcjvIYWSADiSkKQdVCCXkMVIgqWVtOBS4mS63UdGiHyf5xdPX8u8Ryw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzX6gkdsIhgYntBnkoHvE4SQe72rD6YlqC5WV7588kU/pw/V0Uz
	a+H960Kb91PFOC2F6zvzLbgYlv7DOnzrEIlHpFRAo2pIzhn7rHMDeyCFMgKaJek=
X-Gm-Gg: ASbGnctsoUakwPh49yXuGdaMVt+eJrdkku0V2UgWjn+eQ1VRZ7l5RbvUag6F/ai2T+n
	6AEXQ9mkItK4xVOkZN1issjuMfOg/zXiMRkzboscbd8x3ZekuHe0iwW5nSAuNqIRTB7dDCeVBH3
	OdUQXplC/U+TPXOYLbx09vjhoa7S1Kho57DSGJaavaeShti3Ni7OSJQNz1qdTOzGPGAxPuJDkuZ
	jUh0licEOYrc/pZ7N7+U2Jv1hfLYt9z/DMRxV3BWe9Si9f7QaFQPiPqQb296X4feg==
X-Google-Smtp-Source: AGHT+IE2i/BEt1LhXm6aBI8xTYmzok77BKFnrRyh1Do/v27tAGefsSGEkvLFuko9CQOF3izyTVZFGw==
X-Received: by 2002:a05:600c:154a:b0:434:fd15:3adc with SMTP id 5b1f17b1804b1-43668b786bamr431393875e9.25.1736155122879;
        Mon, 06 Jan 2025 01:18:42 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8472b3sm47328729f8f.58.2025.01.06.01.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 01:18:42 -0800 (PST)
Message-ID: <44e4a6b4-39a4-49d0-b3a5-fc5545c39a56@tuxon.dev>
Date: Mon, 6 Jan 2025 11:18:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
To: Jonathan Cameron <jic23@kernel.org>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 ulf.hansson@linaro.org, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
References: <20250103140042.1619703-1-claudiu.beznea.uj@bp.renesas.com>
 <20250103140042.1619703-2-claudiu.beznea.uj@bp.renesas.com>
 <20250104135225.2573285b@jic23-huawei>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250104135225.2573285b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Jonathan,


On 04.01.2025 15:52, Jonathan Cameron wrote:
> On Fri,  3 Jan 2025 16:00:41 +0200
> Claudiu <claudiu.beznea@tuxon.dev> wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> +CC Rafael and linux-pm
> 
>>
>> On all systems where the rzg2l_adc driver is used, the ADC clocks are part
>> of a PM domain. The code that implements the PM domains support is in
>> drivers/clk/renesas/rzg2l-cpg.c, the functions of interest for this commit
>> being rzg2l_cpg_attach_dev() and rzg2l_cpg_deattach_dev(). The PM
>> domains support is registered with GENPD_FLAG_PM_CLK which, according to
>> the documentation, instructs genpd to use the PM clk framework while
>> powering on/off attached devices.
>>
>> During probe, the ADC device is attached to the PM domain
>> controlling the ADC clocks. Similarly, during removal, the ADC device is
>> detached from the PM domain.
>>
>> The detachment call stack is as follows:
>>
>> device_driver_detach() ->
>>   device_release_driver_internal() ->
>>     __device_release_driver() ->
>>       device_remove() ->
>>         platform_remove() ->
>>           dev_pm_domain_detach()
>>
>> During driver unbind, after the ADC device is detached from its PM domain,
>> the device_unbind_cleanup() function is called, which subsequently invokes
>> devres_release_all(). This function handles devres resource cleanup.
>>
>> If runtime PM is enabled via devm_pm_runtime_enable(), the cleanup process
>> triggers the action or reset function for disabling runtime PM. This
>> function is pm_runtime_disable_action(), which leads to the following call
>> stack of interest when called:
>>
>> pm_runtime_disable_action() ->
>>   pm_runtime_dont_use_autosuspend() ->
> 
> So is the only real difference that in the code below you disable runtime pm
> before autosuspend?

No, the difference is that now, the driver specific runtime PM APIs are not
called anymore (through the pointed call stack) after the ADC was removed
from it's PM domain.


>  Can you still do that with a devm callback just not
> the standard one?

No. It doesn't matter if we call the standard devm callback or driver
specific one. As long as it is devm it will impact us as long as the driver
specific runtime PM APIs are called through devres_release_all() after
dev_pm_domain_detach(). And at that time the PM domain may be off along
with its clocks disabled.

> 
> 
>>     __pm_runtime_use_autosuspend() ->
>>       update_autosuspend() ->
>>         rpm_idle()
>>
>> The rpm_idle() function attempts to runtime resume the ADC device.
> 
> Can you give a little more on that path. I'm not immediately spotting
> how rpm_idle() is causing a resume

It is not in particular about the resume. Runtime suspend/resume after
devres_release_all() will be affected.

In particular, the rpm_idle() can call rpm_suspend() (called on the out
label of rpm_idle()) and rpm_suspend() may call the driver specific
runtime_suspend API through the following code (from the rpm_suspend()
function):

        callback = RPM_GET_CALLBACK(dev, runtime_suspend);



        dev_pm_enable_wake_irq_check(dev, true);

        retval = rpm_callback(callback, dev);

        if (retval)

                goto fail;



The full stack generated when running:
# cd /sys/bus/platform/drivers/rzg2l-adc
# while :; do echo 10058000.adc > unbind ; echo 10058000.adc > bind; done

is as follows:

[   24.801195] Call trace:
[   24.803633]  rzg2l_adc_pm_runtime_suspend+0x18/0x54 (P)
[   24.808847]  pm_generic_runtime_suspend+0x2c/0x44 (L)
[   24.813887]  pm_generic_runtime_suspend+0x2c/0x44
[   24.818580]  __rpm_callback+0x48/0x198
[   24.822319]  rpm_callback+0x68/0x74
[   24.825798]  rpm_suspend+0x100/0x578
[   24.829362]  rpm_idle+0xd0/0x17c
[   24.832582]  update_autosuspend+0x30/0xc4
[   24.836580]  pm_runtime_disable_action+0x40/0x64
[   24.841184]  devm_action_release+0x14/0x20
[   24.845274]  devres_release_all+0xa0/0x100
[   24.849361]  device_unbind_cleanup+0x18/0x60
[   24.853618]  device_release_driver_internal+0x1ec/0x228
[   24.858828]  device_driver_detach+0x18/0x24
[   24.862998]  unbind_store+0xb4/0xb8
[   24.866478]  drv_attr_store+0x24/0x38
[   24.870135]  sysfs_kf_write+0x44/0x54
[   24.873795]  kernfs_fop_write_iter+0x118/0x1a8
[   24.878229]  vfs_write+0x2ac/0x358
[   24.881627]  ksys_write+0x68/0xfc
[   24.884934]  __arm64_sys_write+0x1c/0x28
[   24.888846]  invoke_syscall+0x48/0x110
[   24.892592]  el0_svc_common.constprop.0+0xc0/0xe0
[   24.897285]  do_el0_svc+0x1c/0x28
[   24.900593]  el0_svc+0x30/0xd0
[   24.903647]  el0t_64_sync_handler+0xc8/0xcc
[   24.907821]  el0t_64_sync+0x198/0x19c
[   24.911481] Code: 910003fd f9403c00 f941bc01 f9400020 (b9400000)


Digging it further today: on the Renesas RZ/G3S we implement the power
domain on/off and we register the PM domain with GENPD_FLAG_PM_CLK. The
on/off PM domain functionality is implemented though the clock controller
MSTOP functionality which blocks the bus access to the specific IP (in this
particular case to the ADC).

The issue is reproducible when doing:
# cd /sys/bus/platform/drivers/rzg2l-adc
# while :; do echo 10058000.adc > unbind ; echo 10058000.adc > bind; done

I noticed today that doing single manual unbind+bind doesn't always leads
to aborts. It may be related to the fact that, as I noticed, the genpd
power off is called asynchronously as a work (through
genpd_power_off_work_fn()).

I also noticed today what when there is no on/off functionality implemented
on the PM domain we have no failures (as the MSTOP is not implemented and
the bus access to the specific IP is not blocked as there is no PM domain
on/off available).



> 
>> However,
>> at the point it is called, the ADC device is no longer part of the PM
>> domain (which manages the ADC clocks). Since the rzg2l_adc runtime PM
>> APIs directly modifies hardware registers, the
>> rzg2l_adc_pm_runtime_resume() function is invoked without the ADC clocks
>> being enabled. This is because the PM domain no longer resumes along with
>> the ADC device. As a result, this leads to system aborts.
>>
>> Drop the devres API for runtime PM enable.
>>
>> Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> See below. I'm doubtful in general about the sequence changes and
> specifically you can't just remove one devm callback from a driver without
> modifying a lot of other code / leaving really fragile ordering.
> 
> Jonathan
> 
>> ---
>>  drivers/iio/adc/rzg2l_adc.c | 33 ++++++++++++++++++++++++---------
>>  1 file changed, 24 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
>> index 883c167c0670..f12f3daf08cc 100644
>> --- a/drivers/iio/adc/rzg2l_adc.c
>> +++ b/drivers/iio/adc/rzg2l_adc.c
>> @@ -464,25 +464,26 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>>  
>>  	pm_runtime_set_autosuspend_delay(dev, 300);
>>  	pm_runtime_use_autosuspend(dev);
>> -	ret = devm_pm_runtime_enable(dev);
>> -	if (ret)
>> -		return ret;
>> +	pm_runtime_enable(dev);
>>  
>>  	platform_set_drvdata(pdev, indio_dev);
>>  
>>  	ret = rzg2l_adc_hw_init(dev, adc);
>> -	if (ret)
>> -		return dev_err_probe(&pdev->dev, ret,
>> -				     "failed to initialize ADC HW\n");
>> +	if (ret) {
>> +		dev_err_probe(&pdev->dev, ret, "failed to initialize ADC HW\n");
>> +		goto rpm_disable;
>> +	}
>>  
>>  	irq = platform_get_irq(pdev, 0);
>> -	if (irq < 0)
>> -		return irq;
>> +	if (irq < 0) {
>> +		ret = irq;
>> +		goto rpm_disable;
>> +	}
>>  
>>  	ret = devm_request_irq(dev, irq, rzg2l_adc_isr,
>>  			       0, dev_name(dev), adc);
>>  	if (ret < 0)
>> -		return ret;
>> +		goto rpm_disable;
>>  
>>  	init_completion(&adc->completion);
>>  
>> @@ -493,6 +494,19 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>>  	indio_dev->num_channels = adc->data->num_channels;
>>  
>>  	return devm_iio_device_register(dev, indio_dev);
>> +
>> +rpm_disable:
>> +	pm_runtime_disable(dev);
>> +	pm_runtime_dont_use_autosuspend(dev);
>> +	return ret;
> If you have to move away from devm you must do it for all calls after
> the first thing that is manually cleaned up.
> As you have it here the userspace interfaces are left available at a point
> well after power down.

I see, thank you for pointing it.

And thank you for checking this,
Claudiu

> 
>> +}
>> +
>> +static void rzg2l_adc_remove(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +
>> +	pm_runtime_disable(dev);
>> +	pm_runtime_dont_use_autosuspend(dev);
>>  }
>>  
>>  static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
>> @@ -614,6 +628,7 @@ static const struct dev_pm_ops rzg2l_adc_pm_ops = {
>>  
>>  static struct platform_driver rzg2l_adc_driver = {
>>  	.probe		= rzg2l_adc_probe,
>> +	.remove		= rzg2l_adc_remove,
>>  	.driver		= {
>>  		.name		= DRIVER_NAME,
>>  		.of_match_table = rzg2l_adc_match,
> 


