Return-Path: <linux-pm+bounces-39627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D61CC1D4C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 10:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40C6C30ABAB0
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C647A2F1FDD;
	Tue, 16 Dec 2025 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="A17Gapps"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E1225408;
	Tue, 16 Dec 2025 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765877619; cv=none; b=TnBNxiy94XbRRHFNYLyfdRzB8gQ9gm+m7pJQ39/hCPEDjX5hE4n3EYsAn/vh4NFCNAFDZYWGvOfKfjDLAWMqvPhMdxo2+UkXolWCOuPLzDPrPXmYUyrLeop3+kQSTAX9hhkWxWYUXhab6en5xipoHQyAv5VlwZkDcLExuUyFAtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765877619; c=relaxed/simple;
	bh=rkFINolgTNozR3ltyRkSRikFFQCQRpgkYmJrCQ2BdOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YieA0E+xZLXygs5k4Yj6otNEgAnRa8z0o1q4WGpaKs+IPcTeN7HGp24eY3WFRlaHJ96+3Te6QjeJydCV2XcdTLGXn0CE/1vyphP4Z+S9jYLNORT1HLfrkmjyj6i9S6SlwZPUiUTLOeXN2PB4cB6EQomk0hhmyOL9hiaLzKk+KRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=A17Gapps; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=TNA733PsBYBZkQ0bNttM0vjmR+VfrtvXtxcXQOSbpyE=;
	b=A17GappssN9YGqiyjqwselfNscYPni0E1hIigxOXZTgR472KYsNmaqqAj6eQ3h
	U+Xtn4gxvLlyCUNenJktWjGLXelEvenZnjt07IM8e6WQ48ZEkJV2P7VOOsctvxxd
	maIje05HwtHBGXNQOBxk9rvrFwQWCXorsGq1jqokJNClo=
Received: from [IPV6:240c:c983:3:5c03:81d3:caf5:2e64:be2] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3NMTaJkFpXxmRHg--.264S2;
	Tue, 16 Dec 2025 17:31:11 +0800 (CST)
Message-ID: <68620b24-256f-4032-8bc0-911d94bfb616@163.com>
Date: Tue, 16 Dec 2025 17:31:06 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] thermal: spacemit: k1: Add thermal sensor support
To: Yao Zi <me@ziyao.cc>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251216-patchv2-k1-thermal-v1-0-d4b31fe9c904@163.com>
 <20251216-patchv2-k1-thermal-v1-2-d4b31fe9c904@163.com>
 <aUDc-o63KJpY8xLG@pie>
Content-Language: en-US
From: wayne <shuweiwoo@163.com>
In-Reply-To: <aUDc-o63KJpY8xLG@pie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgD3NMTaJkFpXxmRHg--.264S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1xWry8uF1DKF4xArWUArb_yoWrurykpF
	WUKFZ3CFWkGF1xJwsxZr4kAw1Fqr4IyFWjgrn29w1Yywn8CFy7GFyUK34Y9Fy8u3s5ur1F
	vws0qr4Yka4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ut3kNUUUUU=
X-CM-SenderInfo: 5vkx4vplzr0qqrwthudrp/xtbDAABs+mlBJuCDsAAA3L

|On 2025/12/16 12:16, |Yao Zi wrote:

> On Tue, Dec 16, 2025 at 10:00:36AM +0800, Shuwei Wu wrote:
>> The thermal sensor on K1 supports monitoring five temperature zones.
>> The driver registers these sensors with the thermal framework
>> and supports standard operations:
>> - Reading temperature (millidegree Celsius)
>> - Setting high/low thresholds for interrupts
>>
>> Signed-off-by: Shuwei Wu <shuweiwoo@163.com>
>> ---
>> Changes in v2:
>> - Rename k1_thermal.c to k1_tsensor.c for better hardware alignment
>> - Move driver to drivers/thermal/spacemit/
>> - Add Kconfig/Makefile for spacemit and update top-level build files
>> - Refactor names, style, code alignment, and comments
>> - Simplify probe and error handling
>> ---
>>   drivers/thermal/Kconfig               |   2 +
>>   drivers/thermal/Makefile              |   1 +
>>   drivers/thermal/spacemit/Kconfig      |  19 +++
>>   drivers/thermal/spacemit/Makefile     |   3 +
>>   drivers/thermal/spacemit/k1_tsensor.c | 283 ++++++++++++++++++++++++++++++++++
>>   5 files changed, 308 insertions(+)
>> diff --git a/drivers/thermal/spacemit/k1_tsensor.c b/drivers/thermal/spacemit/k1_tsensor.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..f164754e807ddd311c8cf98bcc074fd580514aa2
>> --- /dev/null
>> +++ b/drivers/thermal/spacemit/k1_tsensor.c
> ...
>
>> +static void k1_tsensor_init(struct k1_tsensor *ts)
>> +{
> Configuration of K1_TSU_PCTRL2 (offset 0x04) is removed in this
> revision, but why? Isn't it necessary for the sensor to function?
>
> And you didn't ask my question raised in v1 about the source of 24MHz
> clock. I still suspect whether the binding is complete or not.

Thank you for pointing this out, and I apologize for not addressing your 
question

about the 24MHz clock earlier.

In v1, I referenced the vendor's implementation, though their device tree

did not specify this clock for the thermal node.

After your review, I revisited the SpacemiT K1 clock tree published by 
the vendor,

and found that TSENSOR relies only on the APBC clock, which in turn is 
ultimately

sourced from the 24MHz crystal via the PLL.

Disabling the 24MHz clock for the syscon_apbc node in the device tree 
had no impact

on TSENSOR operation in my testing, so I did not include it in the binding.

As for the PCTRL2 configuration, I confirmed that its default value 
after reset is zero,

and changing its configuration had no effect on the temperature sensor's 
behavior.

This led me to remove the PCTRL2 configuration code in v2.

>> +	u32 val;
>> +
>> +	/* Disable all the interrupts */
>> +	writel(0xffffffff, ts->base + K1_TSENSOR_INT_EN_REG);
>> +
>> +	/* Configure ADC sampling time and filter period */
>> +	val = readl(ts->base + K1_TSENSOR_TIME_REG);
>> +	val &= ~K1_TSENSOR_TIME_MASK;
>> +	val |= K1_TSENSOR_TIME_FILTER_PERIOD |
>> +		K1_TSENSOR_TIME_ADC_CNT_RST |
>> +		K1_TSENSOR_TIME_WAIT_REF_CNT;
> It's more natural to align K1_TSENSOR_TIME_ADC_CNT_RST and other
> following constants with K1_TSENSOR_TIME_FILTER_PERIOD. This applies for
> other multiple-line assignments, too.
>
> ...
>
>> +static int k1_tsensor_probe(struct platform_device *pdev)
>> +{
> ...
>
>> +	for (i = 0; i < MAX_SENSOR_NUMBER; ++i) {
>> +		ts->ch[i].id = i;
>> +		ts->ch[i].ts = ts;
>> +		ts->ch[i].tzd = devm_thermal_of_zone_register(dev, i, ts->ch + i, &k1_tsensor_ops);
>> +		if (IS_ERR(ts->ch[i].tzd))
>> +			return PTR_ERR(ts->ch[i].tzd);
> Would emitting a error message with dev_err_probe() help here?

In v1, the reviewer mentioned that it is no need to print extra error 
message.

See:

https://lore.kernel.org/spacemit/20251127225848-GYA1797866@gentoo.org/T/#mc335bea36323d2d8b3afb09aa40c9c7160440d39 

>> +
>> +		/* Attach sysfs hwmon attributes for userspace monitoring */
>> +		ret = devm_thermal_add_hwmon_sysfs(dev, ts->ch[i].tzd);
>> +		if (ret)
>> +			dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
>> +
>> +		k1_tsensor_enable_irq(ts->ch + i);
>> +	}
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0)
>> +		return irq;
> Same as the above question.
Ditto.
>> +	ret = devm_request_threaded_irq(dev, irq, NULL,
>> +					k1_tsensor_irq_thread,
>> +					IRQF_ONESHOT, "k1_tsensor", ts);
>> +	if (ret < 0)
>> +		return ret;
> Same as above.
Ditto.
> Besides these questions, the driver itself looks pretty nice to me :)
>
> Best regards,
> Yao Zi

|Please let me know if you need further details or test results. Thank 
you for reviewing my patch. Best regards, Shuwei Wu|


