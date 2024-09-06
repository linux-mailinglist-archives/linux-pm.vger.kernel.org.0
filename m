Return-Path: <linux-pm+bounces-13783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F29396F0D0
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 12:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5852853B1
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 10:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A040D1C9DC8;
	Fri,  6 Sep 2024 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="WE6SXh89"
X-Original-To: linux-pm@vger.kernel.org
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599ED17BBE;
	Fri,  6 Sep 2024 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617026; cv=none; b=bmOJP8V5iF+jlDYmeyq7aj5voG0PlFagaMzJoloDCAT/KiIRJQv3XRlKbj7s7KSLSn81yGe0gY/MN3XK7+jLPd9Wrvb2F+xrpIhCQDU+qMCfOFiplozMN0Ww2g2HyyeX0eSgGOHIT8G1Tg3k+CfNVYLI5JrJgtWPgESl9d1sKp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617026; c=relaxed/simple;
	bh=kGYUHSPbs7BzxRX9GfvJB2nRCmdf54+hKrCwzehBMfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=VIo169rT6QSLMNd5j03S9CEY+67QfLfOchli5UzJBscuYvmwpGAhNU9IiymTnAP5yeKzAq+/5/ITiJkwUwatKucitGnpbSLbA3wpd7ggA4CI/NWTlqoXdEtdqNWSmlv/sHVEn7S2r14D8mWiQl367no/pNYTR0hnS0iHr7pNjMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=WE6SXh89; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 5FBBF78A00;
	Fri,  6 Sep 2024 18:03:40 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 5FBBF78A00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725617021;
	bh=RXgSAcGpbpRjtg/Lu9qBHYbFOwSMuMouT1SYO/BDTjI=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=WE6SXh89M0C/7VzQvzLylEBoKSv8L/syI05FX+mrzecU9n6k/2IGOR2Wz74saikIL
	 /GUGTKldD7t+jit+ZoyJ4BLBVb9wqQ0pTYrMABy/r6cfLe9P+wzNn0BhvgKmQK1uaD
	 8ukgXMphkxcRJyalVtMXEnLKbOmWTCdh397Ev9TY=
Message-ID: <02c2c7cc-df70-4e97-b4f1-2f160039403f@classfun.cn>
Date: Fri, 6 Sep 2024 18:05:02 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] power: reset: add Photonicat PMU poweroff driver
To: Krzysztof Kozlowski <krzk@kernel.org>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
 <20240906093630.2428329-3-bigfoot@classfun.cn>
 <90a5b41b-84cd-4daa-b102-04a29c2cd46b@kernel.org>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Heiko Stuebner <heiko@sntech.de>,
 Chukun Pan <amadeus@jmu.edu.cn>
In-Reply-To: <90a5b41b-84cd-4daa-b102-04a29c2cd46b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/6 17:44, Krzysztof Kozlowski wrote:
> On 06/09/2024 11:36, Junhao Xie wrote:
>> This driver implements the shutdown function of Photonicat PMU:
>>
[...]
>>  
>> +config POWER_RESET_PHOTONICAT_POWEROFF
>> +	tristate "Photonicat PMU power-off driver"
>> +	depends on MFD_PHOTONICAT_PMU
> 
> || COMPILE_TEST, no?

I will add it
depends on MFD_PHOTONICAT_PMU || COMPILE_TEST

> 
>> +	help
>> +	  This driver supports Power off for Photonicat PMU device.
[...]
>> +
>> +static int pcat_poweroff_notify(struct notifier_block *nb, unsigned long action,
>> +				void *data)
>> +{
>> +	struct pcat_poweroff *poweroff =
>> +		container_of(nb, struct pcat_poweroff, nb);
>> +
>> +	if (action != PCAT_CMD_PMU_REQUEST_SHUTDOWN)
>> +		return NOTIFY_DONE;
>> +
>> +	dev_info(poweroff->dev, "PMU request host shutdown\n");
> 
> Nope. Drop.

I will remove this log print.
The PMU will send a shutdown command when the power button is long pressed
or the battery is low. I added this line of log to indicate the shutdown command
initiated by the PMU so that users will not be confused by the sudden shutdown.

> 
>> +	orderly_poweroff(true);
>> +
>> +	return NOTIFY_DONE;
> Best regards,
> Krzysztof
> 

Thanks for your review, I will fix all problems in next version!

Best regards,
Junhao

