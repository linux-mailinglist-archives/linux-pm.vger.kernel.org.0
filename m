Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC0FC1756EA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 10:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgCBJXG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 04:23:06 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56626 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgCBJXF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2020 04:23:05 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0229N1sO087046;
        Mon, 2 Mar 2020 03:23:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583140981;
        bh=EN0Dk2LYuFwCwIullgFBLCxgS4RYp5ZL1N4I2VeJ7C4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wN51pkEkS8BjnL5hSOFowd9XkLW3DOn2DbHoZxqncY7BBCDmxnVtY/kW4JE09vB08
         GhKqqooSn1wbKC95T0OS+9Agj5IRaDLOFpzLvZ+JEK4YeiPiFS0iKkC4uV05OzV8XH
         +0eXHYo9kgeWiNmftF3/uQBtMCcNen/NukCg93Os=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0229N1iv124318
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Mar 2020 03:23:01 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 2 Mar
 2020 03:23:01 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 2 Mar 2020 03:23:00 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0229Mw01071647;
        Mon, 2 Mar 2020 03:22:59 -0600
Subject: Re: [PATCH] cpufreq: ti-cpufreq: Add support for OPP_PLUS
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
References: <20200228144529.14548-1-t-kristo@ti.com>
 <20200302041933.uuoa5kbvgtde37oq@vireshk-i7>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <99717846-743e-ba87-9dda-4cf39d562518@ti.com>
Date:   Mon, 2 Mar 2020 11:22:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302041933.uuoa5kbvgtde37oq@vireshk-i7>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/03/2020 06:19, Viresh Kumar wrote:
> On 28-02-20, 16:45, Tero Kristo wrote:
>> From: Lokesh Vutla <lokeshvutla@ti.com>
>>
>> DRA762 SoC introduces OPP_PLUS which runs at 1.8GHz. Add
>> support for this OPP in ti-cpufreq driver.
>>
>> Acked-by: Dave Gerlach <d-gerlach@ti.com>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/cpufreq/ti-cpufreq.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
>> index 557cb513bf7f..d62b6b21325a 100644
>> --- a/drivers/cpufreq/ti-cpufreq.c
>> +++ b/drivers/cpufreq/ti-cpufreq.c
>> @@ -25,11 +25,14 @@
>>   
>>   #define DRA7_EFUSE_HAS_OD_MPU_OPP		11
>>   #define DRA7_EFUSE_HAS_HIGH_MPU_OPP		15
>> +#define DRA76_EFUSE_HAS_PLUS_MPU_OPP		18
>>   #define DRA7_EFUSE_HAS_ALL_MPU_OPP		2
>> +#define DRA76_EFUSE_HAS_ALL_MPU_OPP		24
>>   
>>   #define DRA7_EFUSE_NOM_MPU_OPP			BIT(0)
>>   #define DRA7_EFUSE_OD_MPU_OPP			BIT(1)
>>   #define DRA7_EFUSE_HIGH_MPU_OPP			BIT(2)
>> +#define DRA76_EFUSE_PLUS_MPU_OPP		BIT(3)
>>   
>>   #define OMAP3_CONTROL_DEVICE_STATUS		0x4800244C
>>   #define OMAP3_CONTROL_IDCODE			0x4830A204
>> @@ -80,6 +83,9 @@ static unsigned long dra7_efuse_xlate(struct ti_cpufreq_data *opp_data,
>>   	 */
>>   
>>   	switch (efuse) {
>> +	case DRA76_EFUSE_HAS_PLUS_MPU_OPP:
>> +	case DRA76_EFUSE_HAS_ALL_MPU_OPP:
>> +		calculated_efuse |= DRA76_EFUSE_PLUS_MPU_OPP;
>>   	case DRA7_EFUSE_HAS_ALL_MPU_OPP:
>>   	case DRA7_EFUSE_HAS_HIGH_MPU_OPP:
>>   		calculated_efuse |= DRA7_EFUSE_HIGH_MPU_OPP;
> 
> This is already merged, why sending it again ?

Oops sorry, seems I was looking at stale local upstream branch when 
checking what is still missing upstream. Please ignore.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
