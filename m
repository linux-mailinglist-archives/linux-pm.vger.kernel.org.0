Return-Path: <linux-pm+bounces-13786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6885296F1AB
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 12:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28498284664
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 10:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D761C9ED1;
	Fri,  6 Sep 2024 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="FNFMKHya"
X-Original-To: linux-pm@vger.kernel.org
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356BB1C8FC7;
	Fri,  6 Sep 2024 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619141; cv=none; b=R4oT5lTdZpy49s7vr9QH/Jfy1ZLirtqpY1tdhSL/60cDPzjfBrJJlOY8fatpg+R16u8lgwW7e8QhcXATaNi00YpIaTU2LozaMP8XRryNpooJxWehBNmsww4Pg1oMXqFvSWXDUdf5AmrGHP0sB3bj/hI1ZnOpMdgiThJjJR6z6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619141; c=relaxed/simple;
	bh=05KjF2XPr/hICg9p1IUhg3U7t26HXoWZBUdtqY6Tsx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=o2Pn0fLh0MjFzmH/Wkaj1eO6djF+FSEDSQZLgm5TbVTnFjOCFX/Z9G/bPPSVLoeE5nVziYBwao+UeGtWi0sM5gO21w1X/bHyNeoXrv3+9CSgvr8HD6w+oq0L24gFlC2nnn6lh+7SveumjvxttONuF0r7bNW4t14pk37Ht4dcU54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=FNFMKHya; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id B0B1F78A00;
	Fri,  6 Sep 2024 18:38:55 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn B0B1F78A00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725619136;
	bh=8rF690V9mxP9B5MKXF/MRXog3KWCE9DsM6auRSLOXzk=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=FNFMKHyau1cg/FaXUCYgUv0fzbUE2FHQRJlL5jYLYwVzGyaJ2vRMQXyt61NzmpH8v
	 PCpi1+bahB9oEv0ktn1DEbTVKpfrumG60lLdvBjqbyRa3ptauqaQd4//b+cr/Ox1I4
	 vsMjjLL+oFDBXc1aPncIrFVsMZB4udQ3HeB2DL4o=
Message-ID: <f538ee4b-82ed-4ee1-b4e8-768a4500283e@classfun.cn>
Date: Fri, 6 Sep 2024 18:40:23 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] mfd: Add driver for Photonicat power management MCU
To: Krzysztof Kozlowski <krzk@kernel.org>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
 <20240906093630.2428329-2-bigfoot@classfun.cn>
 <e4ee504b-98a8-4b35-9e1a-195395cdacf8@kernel.org>
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
In-Reply-To: <e4ee504b-98a8-4b35-9e1a-195395cdacf8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/6 17:43, Krzysztof Kozlowski wrote:
> On 06/09/2024 11:36, Junhao Xie wrote:
>> Add a driver for Photonicat power management MCU, which
[...]>> +void *pcat_data_get_data(struct pcat_data *data)
>> +{
>> +	if (!data)
>> +		return NULL;
>> +	return data->data;
>> +}
>> +EXPORT_SYMBOL_GPL(pcat_data_get_data);
> 
> You need kerneldoc... or just drop it. Looks a bit useless as an
> export... Is it because you want to hide from your own driver pcat_data?
> What for? It's your driver...

Now struct pcat_data is in mfd-photonicat.c,
I will move it to photonicat-pmu.h and remove pcat_data_get_data.

> 
[...]
>> +void pcat_pmu_unregister_notify(struct pcat_pmu *pmu, struct notifier_block *nb)
> 
> You need kerneldoc.

I will add missing kernel documentation for all exported functions.

> 
[...]
>> +
>> +static const struct of_device_id pcat_pmu_dt_ids[] = {
>> +	{ .compatible = "ariaboard,photonicat-pmu", },
> 
> Undocumented compatible.
> 
> Remember about correct order of patches. ABI documentation is before users.
> 

I will adjust order of patches.

> 
[...]
>> +
>> +MODULE_ALIAS("platform:photonicat-pmu");
> 
> You should not need MODULE_ALIAS() in normal cases. If you need it,
> usually it means your device ID table is wrong (e.g. misses either
> entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
> for incomplete ID table.
> 
> And it is not even correct. This is not a platform driver!
> 

Yes, I will remove MODULE_ALIAS line

> 
> Best regards,
> Krzysztof
> 

Thanks for your review, I will fix all problems in next version!

Best regards,
Junhao

