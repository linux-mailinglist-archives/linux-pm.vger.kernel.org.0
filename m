Return-Path: <linux-pm+bounces-23077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55646A47FF4
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 14:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40A71883C90
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E97230275;
	Thu, 27 Feb 2025 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="i5P3hTgF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m49194.qiye.163.com (mail-m49194.qiye.163.com [45.254.49.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C12B22FF37;
	Thu, 27 Feb 2025 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664139; cv=none; b=oHgYY3yOKKXS7JxYexVi1Gqd7TBgiS13zAQ1SAuHCHWj70BsaMQCwiAT/19J38SNkGo2Z8oA7ZuUgHkXwgJ0SqB3vW6Nna0w39X31iSPDNmPsvLv0XfPO2i/+/PCzaKWV/N/bmMDW85E67zv9CPIfhIHF7tICoRYDXHPRxbyODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664139; c=relaxed/simple;
	bh=Oo5KVV7zBvZLUXwNgq6q2KgXzXuCfR/cjksy5rU+SBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfXj7auvE45OcznW7So3IBDZUGlEpOrAQOaGeYKbVO8PzUA3iz37QxD3a5fHNURkbboY4dYDyoSsdlLNChFH683uMRupCoPNUHZqLYYvXugocYJoBuGcv5ZnAZu34pQmJk1Qd201aT6EcyXfTnNgdDH+1A6NXbuNkr6FreYgIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=i5P3hTgF; arc=none smtp.client-ip=45.254.49.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c661e153;
	Thu, 27 Feb 2025 19:26:22 +0800 (GMT+08:00)
Message-ID: <d77bfb17-d875-4bd2-abb4-e9ff012d7bfc@rock-chips.com>
Date: Thu, 27 Feb 2025 19:26:21 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] thermal: rockchip: Support the rk3562 SoC in thermal
 driver
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
 Shaohan Yao <shaohan.yao@rock-chips.com>, linux-pm@vger.kernel.org,
 Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20241224094015.3816301-1-kever.yang@rock-chips.com>
 <20241224094015.3816301-2-kever.yang@rock-chips.com>
 <7f17cc55-a741-4bb8-9513-0580ca6fedd3@linaro.org> <17758610.geO5KgaWL5@diego>
 <e36a5771-d277-41d3-af9c-c5841c4060a2@linaro.org>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <e36a5771-d277-41d3-af9c-c5841c4060a2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUlDQlZOGEJJS0pKHk0eShhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9547285bae03afkunmc661e153
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NUk6CQw*CDIJTg0zATUcQlFW
	Nh4aCgJVSlVKTE9LTU5OTkNIT05OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISExMNwY+
DKIM-Signature:a=rsa-sha256;
	b=i5P3hTgFm+CnEdpL/8tNOszN+11tNwkNdYMuDt9fVuC8Q03OnD2woX8xplYkHaD0wN/kiOLdzgIqdtrYKqSTItqn0yZDr6UsDoeJEsJGMbFo4TEeXb1PWyBrA1oaHfIEP59NHeTDvRIc28/dGrSwmrds+jl2u6uyf9O7NJzGDKw=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=6AqLQisyWEDMQ8wooXXEp+oSjAf7xuTYbpqqo/XRzD8=;
	h=date:mime-version:subject:message-id:from;

Hi Daniel,

On 2025/2/19 03:43, Daniel Lezcano wrote:
> On 11/02/2025 11:19, Heiko Stübner wrote:
>> Hey Daniel,
>>
>> Am Dienstag, 11. Februar 2025, 10:36:09 MEZ schrieb Daniel Lezcano:
>>> On 24/12/2024 10:40, Kever Yang wrote:
>>>> From: Shaohan Yao <shaohan.yao@rock-chips.com>
>>>>
>>>> There are one Temperature Sensor on rk3562, channel 0 is for chip.
>>>
>>> A bit stingy in terms of description, no ?
>>>
>>>
>>>> Signed-off-by: Shaohan Yao <shaohan.yao@rock-chips.com>
>>>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>> [...]
>>>> +static const struct tsadc_table rk3562_code_table[] = {
>>>> +    {0, -40000},
>>>> +    {1419, -40000},
>>>> +    {1428, -35000},
>>>> +    {1436, -30000},
>>>> +    {1445, -25000},
>>>> +    {1453, -20000},
>>>> +    {1462, -15000},
>>>> +    {1470, -10000},
>>>> +    {1479, -5000},
>>>> +    {1487, 0},
>>>> +    {1496, 5000},
>>>> +    {1504, 10000},
>>>> +    {1512, 15000},
>>>> +    {1521, 20000},
>>>> +    {1529, 25000},
>>>> +    {1538, 30000},
>>>> +    {1546, 35000},
>>>> +    {1555, 40000},
>>>> +    {1563, 45000},
>>>> +    {1572, 50000},
>>>> +    {1580, 55000},
>>>> +    {1589, 60000},
>>>> +    {1598, 65000},
>>>> +    {1606, 70000},
>>>> +    {1615, 75000},
>>>> +    {1623, 80000},
>>>> +    {1632, 85000},
>>>> +    {1640, 90000},
>>>> +    {1648, 95000},
>>>> +    {1657, 100000},
>>>> +    {1666, 105000},
>>>> +    {1674, 110000},
>>>> +    {1682, 115000},
>>>> +    {1691, 120000},
>>>> +    {1699, 125000},
>>>> +    {TSADCV2_DATA_MASK, 125000},
>>>> +};
>>>
>>> May be it is time to optimize all these tables out of the memory 
>>> driver?
>>>
>>> It is the 9th table introduced.
>>
>> just to see if we think differently, what do you have in mind?
>>
>> For me the adc-to-temperature conversion _is_ part of the hw-block 
>> itself,
>> so should likely not spill into the devicetree, but you're right, 
>> defining
>> a big table for each soc also isn't really great.
>>
>> For the rk3562 in question, the stepping seems to be 8,9,8,9,....
>> where for the rk3568 the value stepping seems to be 32,36,32,36,...
>> and it looks similar for the other socs too, with the driver is already
>> interpolating between values it seems.
>>
>> So even just halving (or more) all the big tables (dropping every second
>> entry for example) should not really loose us real granularity.
>
> It can be just a formula to be reused in the adc_to_temp, temp_to_adc 
> or precompute the table from the formula:
>
> For instance the following formulas:
>
> rk3588_code_table:
>
>     y = ((x^2 + 23315x - 5949300) * 100) / 2457
>
> rk3568_code_table:
>
>     y = ((x^2 - 2660x + 1547712) * 625) / 2448
I can understand, it looks much better if we can use the formula instead 
of the table.

We got all these data from different vendor/foundry ,  some of vendor do 
provide the formula while others not.

And I think there is a key issue is that the formula may not fit for all 
the situation, sometimes need to calibrate

after chips are out, only the table is available in this case.

And in this case, we send the table as-is from the vendor.


Thanks,

- Kever

>
> etc ...
>
>

