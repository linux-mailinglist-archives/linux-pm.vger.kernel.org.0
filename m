Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5B116448B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 13:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgBSMoX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 07:44:23 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59690 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgBSMoX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 07:44:23 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01JChssQ013710;
        Wed, 19 Feb 2020 06:43:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582116234;
        bh=kuB+R4Zi2k9ASFrC2H+1rMHduNuNh5eA+AYg21v4g+Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mgC9phzEV5AoGxOpxa9dqlRaMAh35GL8N/ozSJsrZkZ0AacLYwTRLnkd//EeSZ+td
         4y9qgpiinOlXbKtKlim4XT6T0fOxNVLMJQjrjnro6tthhrlsIJ3dfXHfXY5+ramSIm
         lh8X8J+xBm4c1c4M9+NFA94EAj0TX+F1dcjfFfqw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01JChsaV064935
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Feb 2020 06:43:54 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 19
 Feb 2020 06:43:54 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 19 Feb 2020 06:43:54 -0600
Received: from [10.24.69.174] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01JChowE126704;
        Wed, 19 Feb 2020 06:43:51 -0600
Subject: Re: [PATCH v3 2/4] thermal: k3: Add support for bandgap sensors
To:     Randy Dunlap <rdunlap@infradead.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <daniel.lezcano@linaro.org>
CC:     <amit.kucheria@verdurent.com>, <t-kristo@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>
References: <20200219074314.22829-1-j-keerthy@ti.com>
 <20200219074314.22829-3-j-keerthy@ti.com>
 <ab0bc84b-189f-a9be-e838-a38c14fa702a@infradead.org>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <6b4ce7aa-4211-218f-68c2-5c451d8b7677@ti.com>
Date:   Wed, 19 Feb 2020 18:13:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ab0bc84b-189f-a9be-e838-a38c14fa702a@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 19/02/20 1:20 pm, Randy Dunlap wrote:
> On 2/18/20 11:43 PM, Keerthy wrote:
>> The bandgap provides current and voltage reference for its internal
>> circuits and other analog IP blocks. The analog-to-digital
>> converter (ADC) produces an output value that is proportional
>> to the silicon temperature.
>>
>> Currently reading temperatures and trend computing is supported
>> as there are no active/passive cooling agent supported.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   drivers/thermal/Kconfig      |  12 ++
>>   drivers/thermal/Makefile     |   1 +
>>   drivers/thermal/k3_bandgap.c | 342 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 355 insertions(+)
>>   create mode 100644 drivers/thermal/k3_bandgap.c
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 5a05db5438d6..fa598eddc7ac 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -251,6 +251,18 @@ config IMX_THERMAL
>>   	  cpufreq is used as the cooling device to throttle CPUs when the
>>   	  passive trip is crossed.
>>   
>> +config K3_THERMAL
>> +	bool "Texas Instruments K3 thermal support"
> 
> Hi,
> Why is this bool and not tristate?

Definitely can work as tristate. I will fix it next version.

> 
>> +	depends on THERMAL
>> +	depends on ARCH_K3 || COMPILE_TEST
>> +	help
>> +	  If you say yes here you get thermal support for the Texas Instruments
>> +	  K3 SoC family. The current chip supported is:
>> +	   - AM654
>> +
>> +	  This includes temperature reading functionality and also trend
>> +	  computation.
>> +
>>   config MAX77620_THERMAL
>>   	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
>>   	depends on MFD_MAX77620
> 
>> diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
>> new file mode 100644
>> index 000000000000..35d904eb9857
>> --- /dev/null
>> +++ b/drivers/thermal/k3_bandgap.c
>> @@ -0,0 +1,342 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * TI Bandgap temperature sensor driver for K3 SoC Family
>> + *
>> + * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
>> + */
> 
>> +static int k3_bgp_read_temp(struct k3_thermal_data *devdata,
>> +			    int *temp)
>> +{
>> +	struct k3_bandgap *bgp;
>> +	unsigned int dtemp, s0, s1, s2;
>> +
>> +	bgp = devdata->bgp;
>> +	/**
> 
> "/**" is used to indicate kernel-doc notation in the Linux kernel source files,
> but this comment is not kernel-doc notation, so please just use "/*".

Okay

> 
>> +	 * Errata is applicable for am654 pg 1.0 silicon. There
>> +	 * is a variation of the order for 8-10 degree centigrade.
>> +	 * Work around that by getting the average of two closest
>> +	 * readings out of three readings everytime we want to
>> +	 * report temperatures.
>> +	 *
>> +	 * Errata workaround.
>> +	 */
> thanks.

Thanks for the review.

- Keerthy
> 
