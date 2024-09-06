Return-Path: <linux-pm+bounces-13792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9783F96F5C2
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 15:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57553284626
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 13:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B401CEAB5;
	Fri,  6 Sep 2024 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="n0RKf9b/"
X-Original-To: linux-pm@vger.kernel.org
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64651CBE89;
	Fri,  6 Sep 2024 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630511; cv=none; b=MB6bnbyJWL1xJGEO9EbBcVzt0lqHd9n9vUggSZfeGSss+rZQw54GFx8Wjai9+HtvRkb7ppHdYkJiRGchaw7b9+8ksrhtQaO3xgL2cJUogHdM5dFFB+eZ6hRUqssfAeUoN7nbeXh5UzhUuvwFc9e4O0kIKMZ+qm+RcjlrzlmGybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630511; c=relaxed/simple;
	bh=de27J4yiTEMCkWp47eHD/sFM0Yeb9I683sS0iZ0vUHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=i3t9/yJrWoS5wIlLJODAUD9Kt1NaHMjio2nHi0LpfB4IeSmaeofP+boVAT3CtROPvDU/xkGx1wMMsHEhxXSAKVkJdEhd6Hn7b/mLTZIGB5OR4/BX0sfyhWd1EYXESaqXII2sOsewaUoMkCBsVxDwm3KnuFjYC6vhCgfAUUlRK60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=n0RKf9b/; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 87A39789F3;
	Fri,  6 Sep 2024 21:48:25 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 87A39789F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725630506;
	bh=naamg7UNm6mx3z8yDA7GqJbR3zn2wb64TfuOIljta10=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=n0RKf9b/BT9pj0TqQuZAJCtA+K9QdxCzyNV2W+mW02toJQh7G1JEjiqdtQto5j+QZ
	 z3U8LTHHqrtkvIKGlcR1XEsiqaGremCMy13hGmd7uhkTIGoEifo+PeGrMzy8GMcy/d
	 BZez3KgmN0sFed3e726VlCfDBh5NFNzJ5o8toZtc=
Message-ID: <e1f98265-ab75-45fe-a7a9-8e65cc13908e@classfun.cn>
Date: Fri, 6 Sep 2024 21:49:53 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] hwmon: Add support for Photonicat PMU board
 temperature sensor
To: Guenter Roeck <linux@roeck-us.net>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
 <20240906093630.2428329-7-bigfoot@classfun.cn>
 <a33633be-800c-4ca0-9d1e-f190e23384d5@roeck-us.net>
Content-Language: en-US
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
From: Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <a33633be-800c-4ca0-9d1e-f190e23384d5@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/9/6 19:41, Guenter Roeck wrote:
> On 9/6/24 02:36, Junhao Xie wrote:
>> Photonicat PMU MCU will send status reports regularly,
>> including board temperature.
>>
> 
> This is not an appropriate description.

I will change to a better description.

> 
>> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
>> ---
>>   drivers/hwmon/Kconfig            |  10 +++
>>   drivers/hwmon/Makefile           |   1 +
>>   drivers/hwmon/photonicat-hwmon.c | 129 +++++++++++++++++++++++++++++++
> 
> Documentation missing.

Does it need to be placed in Documentation/hwmon/photonicat-hwmon.rst?

> 
>> +static int pcat_hwmon_probe(struct platform_device *pdev)
>> +{
> ...
>> +    dev_info(dev, "Board Temprature: %d degress C\n", hwmon->temperature);
>> +
> 
> Unacceptable (misspelled) noise.
> 
>> +    hwmon->hwmon = devm_hwmon_device_register_with_groups(
>> +        dev, label, hwmon, pcat_pmu_temp_groups);
>> +
> 
> Please use the with_info API. I am not going to review the code because
> it will need to be completely rewritten.
> 
> Guenter
> 

Thanks for your review, I will rewrite this driver!

Best regards,
Junhao

