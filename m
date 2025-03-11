Return-Path: <linux-pm+bounces-23856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C805A5C76A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE55C188E27D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145F325EFBB;
	Tue, 11 Mar 2025 15:29:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101C71DF749;
	Tue, 11 Mar 2025 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706978; cv=none; b=VGjai8LMv6ahtn5e9TM29/KMPY62tH43Fi78/L4PtnGaZuI+fUe2jNW8nZj9cyQq6wksAU+un7o0QeDAGwtJdpohjpsBGjTcW4uhpXN116DPwGv9cCi1B4jf0EwjR3PHMjA5MO1mhuA1pRCmKCYN1CRlx67q34I8robhDnDt5MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706978; c=relaxed/simple;
	bh=s1LuYLP8EsnOtLEdw1A7/euy88xVMYSC2fYBv3AKRiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYbG87YSyanPMGeqFOeD6Au0OIepp8xQY5lImU27XE7Bh2N/DKW109/nYoYqkCQXepa9b+1zDWF3Ni7LsW2u4ZPOTGsR7T0WkBovlU1N35RHedMmCtMcW1qpBCxW/AmusQozJaOuL0/6uYTC4LyDRuo2YcMp5IqpBw/sNkip0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DD2F152B;
	Tue, 11 Mar 2025 08:29:45 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD6253F694;
	Tue, 11 Mar 2025 08:29:30 -0700 (PDT)
Message-ID: <647d38d6-e64b-47dc-9280-05b0d7ddcb43@arm.com>
Date: Tue, 11 Mar 2025 15:29:28 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] arm64: dts: renesas: r9a09g047: Add thermal
 hotplug trip point
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "niklas.soderlund+renesas@ragnatech.se"
 <niklas.soderlund+renesas@ragnatech.se>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc: "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "john.madieu@gmail.com" <john.madieu@gmail.com>,
 "rui.zhang@intel.com" <rui.zhang@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20250309121324.29633-1-john.madieu.xa@bp.renesas.com>
 <20250309121324.29633-4-john.madieu.xa@bp.renesas.com>
 <9b44d0ff-b28f-4d79-ad7b-b452db1db87a@arm.com>
 <OSBPR01MB2775232DECBB0A67D74BCE3DFFD12@OSBPR01MB2775.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <OSBPR01MB2775232DECBB0A67D74BCE3DFFD12@OSBPR01MB2775.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/11/25 11:57, John Madieu wrote:
> Hi Christian,
> 
> Thanks for reviewing.
> 
>> -----Original Message-----
>> From: Christian Loehle <christian.loehle@arm.com>
>> Sent: Tuesday, March 11, 2025 11:53 AM
>> To: John Madieu <john.madieu.xa@bp.renesas.com>; geert+renesas@glider.be;
>> niklas.soderlund+renesas@ragnatech.se; conor+dt@kernel.org;
>> krzk+dt@kernel.org; robh@kernel.org; rafael@kernel.org;
>> daniel.lezcano@linaro.org
>> Cc: magnus.damm@gmail.com; Claudiu Beznea
>> <claudiu.beznea.uj@bp.renesas.com>; devicetree@vger.kernel.org;
>> john.madieu@gmail.com; rui.zhang@intel.com; linux-kernel@vger.kernel.org;
>> linux-renesas-soc@vger.kernel.org; Biju Das <biju.das.jz@bp.renesas.com>;
>> linux-pm@vger.kernel.org
>> Subject: Re: [RFC PATCH 3/3] arm64: dts: renesas: r9a09g047: Add thermal
>> hotplug trip point
>>
>> On 3/9/25 12:13, John Madieu wrote:
>>> Add CPU hotplug trip point to shutdown CPU1 and CPU2 when exceeding
>> 110°C.
>>>
>>> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
>>> ---
>>>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
>>> b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
>>> index 93b57d7ad7b9..06bd394582e2 100644
>>> --- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
>>> +++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
>>> @@ -533,6 +533,13 @@ map0 {
>>>  							 <&cpu2 0 3>, <&cpu3 0 3>;
>>>  					contribution = <1024>;
>>>  				};
>>> +
>>> +				map1 {
>>> +					trip = <&trip_emergency>;
>>> +					cooling-device = <&cpu1 0 1>, <&cpu2 0 1>;
>>> +					contribution = <1024>;
>>> +				};
>>> +
>>>  			};
>>>
>>>  			trips {
>>> @@ -542,6 +549,12 @@ target: trip-point {
>>>  					type = "passive";
>>>  				};
>>>
>>> +				trip_emergency: emergency {
>>> +					temperature = <110000>;
>>> +					hysteresis = <1000>;
>>> +					type = "plug";
>>> +				};
>>> +
>>>  				sensor_crit: sensor-crit {
>>>  					temperature = <120000>;
>>>  					hysteresis = <1000>;
>>
>>
>> Are there no other cooling methods?
>> How does it compare to idle inject?
>>
>> Furthermore, couldn't the offlining of some CPUs lead to the rest being
>> operated at much higher OPPs therefore the overall power increase, too?
>> (Without having looked at if this is a possibility for this particular
>> SoC.)
>> Some numbers would be helpful IMO.
> 
> To clarify this, I tested with CPUFreq cooling, along with performance
> Governor, with "plug" threshold higher than "passive" one. When passive
> trip is crossed, we observe proper CPUs throttling, and when "plug" trip
> is crossed, we observe target CPUs being put offline, while throttling
> remains.
> 
> When "plug" targeted CPUs come back online, throttling is still operational.
> 
> Once I get comparison results with CPU idle cooling, I'll keep you posted.
> 

Thanks John!
Might make sense to also try this with schedutil, because my argument doesn't
hold with performance governor.
As long as we also have throttling that's not a concern anyway.

