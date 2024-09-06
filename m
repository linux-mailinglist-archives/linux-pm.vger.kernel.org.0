Return-Path: <linux-pm+bounces-13793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4725E96F5F5
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 15:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCBC1B20EAA
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 13:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F318B1CF29B;
	Fri,  6 Sep 2024 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="oFbfivdU"
X-Original-To: linux-pm@vger.kernel.org
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AA11C86F2;
	Fri,  6 Sep 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630892; cv=none; b=niFTpbtWSTjgom7mwB5vQJz8PQDffoFeNJui84F/ZJ07ZemHUAFg0y9Yx3t6ssdzh2ZUbhJJTuq1RlPYZ8NlukKoQPSFD0p5sAjFdBgBQ8i5W+OomORxRHECZkzKBMPGMRYV+dy5RVOHo1dGlzHiawZ06IOtxfiJVaSWWwxpn7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630892; c=relaxed/simple;
	bh=9WWBF0vNemNruglb+p+KfWnChiPqLkfoAm3OlvIE97c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=QV2VE0KNBE8cmtoAQ5UQDaOKNyAorqUfvUlQL7G5tnxTJaC3IjSPTZjE6yN/u+PjwnMKuKvdE7nRlWnEfWLoOgm7Qo5VKAAGWzoBjIEdgwRA/2uE93fvi+Yu58fQkLYPTPSzGW3VfPKlOEpcJ7qEXSUKjwV/4LW3sSlZCvZz3Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=oFbfivdU; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id EFF35789F3;
	Fri,  6 Sep 2024 21:54:45 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn EFF35789F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725630887;
	bh=wOZLoc1VDKIe8bHEaqWxsCpDohRt7GpQMLR8FChOFow=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=oFbfivdU+ElB44kvOY6XvYwCFSDnQNjpRzm2FrujSuqG6ussWcxw5uhFcUFEaKuLR
	 caSzTX9D8F6qgZfXAYDJt1iUdiSjIom4SDFREXOGu50ZLm4gwNf1PT1Pzrn9btM5yt
	 miy2/8z6PcYDo72ELgtkFoqo2pVMcWu9y6rJRGAo=
Message-ID: <c1312339-60be-4625-a33d-c558ad529aaf@classfun.cn>
Date: Fri, 6 Sep 2024 21:56:13 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] arm64: dts: rockchip: add Photonicat PMU support for
 Ariaboard Photonicat
To: Krzysztof Kozlowski <krzk@kernel.org>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
 <20240906093630.2428329-10-bigfoot@classfun.cn>
 <5c8b066c-6e61-44c1-b99d-4ae1a2313033@kernel.org>
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
In-Reply-To: <5c8b066c-6e61-44c1-b99d-4ae1a2313033@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/6 17:53, Krzysztof Kozlowski wrote:
> On 06/09/2024 11:36, Junhao Xie wrote:
>> This commit adds support for Photonicat power management MCU on
>> Ariaboard Photonicat.
>>
[...]
>> +
>> +		pcat_pmu_battery: supply-battery {
> 
> Drop unused labels. Everywhere. You are not making the code more readable.

I will remove them.

> 
>> +			compatible = "ariaboard,photonicat-pmu-supply";
>> +			label = "battery";
>> +			monitored-battery = <&battery>;
>> +			power-supplies = <&pcat_pmu_charger>;
> 
> Why do you reference internal design of the device as DTS? You cannot
> have here other power supply, can you?

I mistakenly thought power_supply_am_i_supplied() required power-supplies
property, it actually does not, I will remove it.

> 
> Best regards,
> Krzysztof
> 

Thanks for your review, I will fix all problems in next version!

Best regards,
Junhao

