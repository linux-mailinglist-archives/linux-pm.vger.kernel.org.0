Return-Path: <linux-pm+bounces-13791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA1396F594
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 15:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A001F246CF
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199D91CF2A4;
	Fri,  6 Sep 2024 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="U+1eM/4q"
X-Original-To: linux-pm@vger.kernel.org
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86221CEAD6;
	Fri,  6 Sep 2024 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630018; cv=none; b=b8AJN9vVS8LrP7VYjobk7/glQ5DexrjV94DR+HJZ9OxsOgwZQFKphSh08FjZh9ueWy4GzEjP6wnBmiqK+hunWbOiBF/NwbrkB7SM3NDaN6B6FGFZgyEST9kdEYJc4tlZueeF0vg0F28m+iP/5dcqnPcwV/dsgHHuxV+PGniNY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630018; c=relaxed/simple;
	bh=1RLdC7O4/AuL7/4SO2U2uqqpXyawhm+W3oQSmgLTBws=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=HewotgwyrozD1tVRjGThffX+jBEdKDKoVO7BA0IKWG6TeflQl+Coih1EZaZ3fhT83a+9kOGgmYoOdvQO68hwvZ6Hsu/Y2E3y9XZHYo65NB490LIIRhxRYCZlBK2qV3jJiHpid78A7G5eDsGGtAS27rFQyQOy+ILNj5NgIEsV6MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=U+1eM/4q; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 8E88C789F3;
	Fri,  6 Sep 2024 21:40:03 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 8E88C789F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725630005;
	bh=THWh+jTU82Bk2jmaEr2jKdyj00Le9PDV8sXnbY3W8pw=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=U+1eM/4q7hMnhB/H/vmuwrkYpiweMg1aAhliFX9aUjFYAPCWIdmQuYDFeLLtYir6Y
	 B/nfatTkjew4Gbl4eXGwKfR6TGQre/dQbAzqzZV2/Sy/BHl8FjNNO9ov05Q1okXk+j
	 /UsUdrhs/RISXZ3poemVDMTGg3BLm+eN/rBMsYoE=
Message-ID: <a1e96682-4eb5-486e-97bf-472634642553@classfun.cn>
Date: Fri, 6 Sep 2024 21:41:30 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] watchdog: Add Photonicat PMU watchdog driver
To: Guenter Roeck <linux@roeck-us.net>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
 <20240906093630.2428329-4-bigfoot@classfun.cn>
 <8e2cecbe-aa48-4e84-93cc-8c028c5e649e@roeck-us.net>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor Dooley,"
 <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Heiko Stuebner <heiko@sntech.de>,
 Chukun Pan <amadeus@jmu.edu.cn>, Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <8e2cecbe-aa48-4e84-93cc-8c028c5e649e@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/9/6 19:52, Guenter Roeck wrote:
> On 9/6/24 02:36, Junhao Xie wrote:
>> This driver provides access to Photonicat PMU watchdog functionality.
>>
[...]
>> +
>> +struct pcat_watchdog {
>> +    struct device *dev;
> 
> I don't see what this is used for.

I used to use this for logging, but now they are gone, I will delete it.

> 
[...]
>> +
>> +static int pcat_wdt_setup(struct pcat_watchdog *data, int timeout)
>> +{
>> +    int ret;
>> +    u8 time = 0;
> 
> Unnecessary initialization.
> 
>> +    u8 times[3] = { 60, 60, 0 };
>> +
>> +    time = MIN(255, MAX(0, timeout));
>> +
>> +    ret = pcat_pmu_write_data(data->pmu, PCAT_CMD_WATCHDOG_TIMEOUT_SET,
>> +                  times, sizeof(times));
> 
> Where does this actually send the timeout to the chip ?
> 

I forgot to fill in timeout into times[2] during refactoring process, I will fix it.

>> +    if (!ret)
[...]>> +
>> +static int pcat_wdt_set_timeout(struct watchdog_device *wdev, unsigned int val)
>> +{
>> +    int ret = 0;
>> +    struct pcat_watchdog *data = watchdog_get_drvdata(wdev);
>> +
>> +    data->timeout = val;
> 
> This needs to store 'timeout' in wdev. Storing it locally is unnecessary.
> 
>> +    if (data->started)
>> +        ret = pcat_wdt_setup(data, data->timeout);
> 
> This is misleading because it would permit setting the timeout to
> 0 when the watchdog isn't running, and then when the watchdog is started
> it would not really start it. The code should not use a local "started"
> variable but call watchdog_active(). It should also not accept "0"
> as a valid timeout.
> 

I will fix the pcat_wdt_set_timeout.

>> +
[...]
>> +
>> +    watchdog->dev = dev;
>> +    watchdog->pmu = dev_get_drvdata(dev->parent);
>> +    watchdog->wdd.info = &pcat_wdt_info;
>> +    watchdog->wdd.ops = &pcat_wdt_ops;
>> +    watchdog->wdd.timeout = 60;
>> +    watchdog->wdd.max_timeout = U8_MAX;
>> +    watchdog->wdd.min_timeout = 0;
> 
> This effectively lets the user ... kind of ... stop the watchdog
> by setting the timeout to 0. This is not acceptable.
> 
>> +    watchdog->wdd.parent = dev;
>> +
>> +    watchdog_stop_on_reboot(&watchdog->wdd);
>> +    watchdog_set_drvdata(&watchdog->wdd, watchdog);
>> +    platform_set_drvdata(pdev, watchdog);
>> +
> No watchdog_init_timeout() ?

Thanks for your correction, I will fix it.

> 
>> +    return devm_watchdog_register_device(dev, &watchdog->wdd);
[...]
>> +MODULE_LICENSE("GPL");
> 

Thanks for your review, I will fix all problems in next version!

Best regards,
Junhao

