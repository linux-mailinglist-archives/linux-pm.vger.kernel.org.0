Return-Path: <linux-pm+bounces-17169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2C89C14D7
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 04:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0954FB22179
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 03:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA8919DF8C;
	Fri,  8 Nov 2024 03:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="E+ALW2Mn"
X-Original-To: linux-pm@vger.kernel.org
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724A88F54;
	Fri,  8 Nov 2024 03:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731037755; cv=none; b=gvaLsWNhShKBwQL/oxCFpJIPAOuNDIYRChr7BoXc+hX/w/vQwnErWkgrE++BVE2wU7axPnXKk5946oLlKiaQLfnagxjEMLz7uu1fTg2KTVS7OWiZzqALaVKQSVMaojYnhDOuI9cBFZ74wgdv6Lno42J0shjtHaFfzf9K1EuzTZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731037755; c=relaxed/simple;
	bh=MXe6IYQzEOrzfZcmjrcC+xeinHkhz6G2TN1/BMXAynw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0gg32oJrdu4jzrfONHZRE1fp2rUPOf/U6xJeW9r2o37DnkOj9qjNB82xLkRVk3HWex3JVFxyp+WbAjPdDhd2k2vjWIcSYWNjj1rk2rAgB5qjnKSmor3xGJUbzHzM1va1WNAPo/YIgBwJkRHlvmgwTS/MFlXcME09fJLlCsXa3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=E+ALW2Mn; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [120.32.101.155])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 2CD777892D;
	Fri,  8 Nov 2024 11:49:04 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 2CD777892D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1731037750;
	bh=3B/wDt2bOqNsA638987AnsCuaRwFSHdyN6e3dd6uRWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E+ALW2MnvftkIzO17VOsGIQg22QbPsXe9/be2g7Px6bhaYtwj8TYvzBsOxmMG9qxZ
	 TaZetswj/qwGv/3WW0NWlFX5iLYKHNEgI9fru2ysjzYR5Ehb05WjLXS6Ve1oIADmei
	 eoZTqSBOtrKCyPPAWju58G0dTUgIIQ8za1/rhogE=
Message-ID: <6e748aa6-de2c-4a90-b07f-7a9d3e441d19@classfun.cn>
Date: Fri, 8 Nov 2024 11:48:50 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] leds: add Photonicat PMU LED driver
To: Lee Jones <lee@kernel.org>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Sebastian Reichel <sre@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Heiko Stuebner <heiko@sntech.de>,
 Chukun Pan <amadeus@jmu.edu.cn>, Junhao Xie <bigfoot@classfun.cn>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
 <20240906093630.2428329-8-bigfoot@classfun.cn>
 <20241002153536.GG7504@google.com>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <20241002153536.GG7504@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/10/2 23:35, Lee Jones wrote:
> On Fri, 06 Sep 2024, Junhao Xie wrote:
> 
>> Photonicat has a network status LED that can be controlled by system.
>> The LED status can be set through command 0x19.
[...]
>> +config LEDS_PHOTONICAT_PMU
>> +	tristate "LED Support for Photonicat PMU"
>> +	depends on LEDS_CLASS
>> +	depends on MFD_PHOTONICAT_PMU
>> +	help
>> +	  Photonicat has a network status LED that can be controlled by system,
> 
> "the system"
> 
>> +	  this option enables support for LEDs connected to the Photonicat PMU.
[...]
>> +++ b/drivers/leds/leds-photonicat.c
>> @@ -0,0 +1,75 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2024 Junhao Xie <bigfoot@classfun.cn>
>> + */
>> +
>> +#include <linux/mfd/photonicat-pmu.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/leds.h>
> 
> Alphabetical.
> 
>> +struct pcat_leds {
>> +	struct device *dev;
> 
> Where is this used?

I used it to print logs, but now it doesn't, I will remove it.

> 
>> +	struct pcat_pmu *pmu;
> 
> Why do you need to store this?
> 
> Can't you get this at the call-site by:
> 
>   dev_get_drvdata(cdev->dev->parent)

Yes, I will change it.

>> +	struct led_classdev cdev;
>> +};
[...]
>> +static int pcat_leds_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
> 
> Small sized variables at the bottom please.
> 
>> +	struct device *dev = &pdev->dev;
>> +	struct pcat_leds *leds;
>> +	const char *label;
>> +
>> +	leds = devm_kzalloc(dev, sizeof(*leds), GFP_KERNEL);
>> +	if (!leds)
>> +		return -ENOMEM;
>> +
>> +	leds->dev = dev;
> 
> Where is this used?
> 
>> +	leds->pmu = dev_get_drvdata(dev->parent);
>> +	platform_set_drvdata(pdev, leds);
> 
> Where do you platform_get_drvdata()
> 
>> +	ret = of_property_read_string(dev->of_node, "label", &label);
[...]
>> +static const struct of_device_id pcat_leds_dt_ids[] = {
>> +	{ .compatible = "ariaboard,photonicat-pmu-leds", },
> 
> How many LEDs are there?

Photonicat has three LEDs:
 - system operation status indicator
 - charging status indicator
 - network status indicator
and currently only one LED (network status indicator) can be controlled.

>> +	{ /* sentinel */ }
>> +};
[...]
>> -- 
>> 2.46.0

Thanks for your review, I will fix all problems in next version!

Best regards,
Junhao

