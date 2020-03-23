Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8DF18EE9F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 04:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgCWDxT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Mar 2020 23:53:19 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58468 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgCWDxT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Mar 2020 23:53:19 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02N3qwla007132;
        Sun, 22 Mar 2020 22:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584935578;
        bh=J2EBw4R7xBK+XNXX1pVY/q3taGIhB/DfdmfHuKxeQEA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=c82liV2m0aVep6i5yfZTXdvhFw9gCECk/eJcpGbSDvSMsdvOQVFyNf0hSDYty+/XR
         8tETQuOkSWW3YjE2Iy/kF2j/Cus0MeORMdKnAad2tyDWVdXsIJBNUbBugHeG+09GKE
         bOUbS11kSwZt9T+YqleMuyjJGlpewt6vd5dLNMIk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02N3qwKh102607
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 22 Mar 2020 22:52:58 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sun, 22
 Mar 2020 22:52:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sun, 22 Mar 2020 22:52:57 -0500
Received: from [10.250.133.209] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02N3qrlP039017;
        Sun, 22 Mar 2020 22:52:54 -0500
Subject: Re: [RESEND PATCH v4 2/4] thermal: k3: Add support for bandgap
 sensors
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>
CC:     <amit.kucheria@verdurent.com>, <t-kristo@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>
References: <20200318083028.9984-1-j-keerthy@ti.com>
 <20200318083028.9984-3-j-keerthy@ti.com>
 <ea3b34dc-42e3-0b10-4b89-faf2621a4ee2@linaro.org>
 <03b837de-ff25-2308-8a56-15bc3377cd5f@ti.com>
 <d8bff098-f852-4c55-0afc-d7fd043dd10a@linaro.org>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <b73f1fdc-16d6-7320-ab63-e51bb388fb5d@ti.com>
Date:   Mon, 23 Mar 2020 09:22:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d8bff098-f852-4c55-0afc-d7fd043dd10a@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/19/2020 7:06 PM, Daniel Lezcano wrote:
> On 19/03/2020 13:52, Keerthy wrote:
>>
>>
>> On 19/03/20 6:08 pm, Daniel Lezcano wrote:
>>> On 18/03/2020 09:30, Keerthy wrote:
>>>> The bandgap provides current and voltage reference for its internal
>>>> circuits and other analog IP blocks. The analog-to-digital
>>>> converter (ADC) produces an output value that is proportional
>>>> to the silicon temperature.
>>>>
>>>> Currently reading temperatures and creating work to periodically
>>>> read temperatures from the zones are supported.
>>>> There are no active/passive cooling agent supported.
>>>>
>>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>>> ---
> 
> [ ... ]
> 
>>>> +static const int k3_adc_to_temp[] = {
>>>> +    -40000, -40000, -40000, -40000, -39800, -39400, -39000, -38600,
> 
> [ ... ]
> 
>>>> 123000,
>>>> +    123400, 123800, 124200, 124600, 124900, 125000,
>>>> +};
>>>
>>> Can be this array replaced by an initialization array with a formula?
>>>
>>> Why do we have most of the time a step of 400 then suddenly 500 and 400
>>> again? eg. 30600, 31000, 31400, 31900, 32500, 33000, 33400
>>
>> This has come from a polynomial equation which i do not want to
>> calculate every time we read the temperature. Hence prefer Look up table.
> 
> Agree, it makes sense to not calculate every time the temperature is read.
> 
> I was suggesting to fill the array at init time with this polynomial
> formula instead of hardcoding it.

As in case of OMAP this is a standard polynomial equation that does not
change so i would prefer not calculating in the driver and having the 
look up table from TRM.

> 
> [ ... ]
> 
>>>> +
>>>> +    /* Get the sensor count in the VTM */
>>>> +    val = readl(bgp->base + K3_VTM_DEVINFO_PWR0_OFFSET);
>>>> +    cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
>>>> +    cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
>>>> +
>>>> +    data = devm_kcalloc(dev, cnt, sizeof(*data), GFP_KERNEL);
>>>> +    if (!data) {
>>>> +        ret = -ENOMEM;
>>>> +        goto err_alloc;
>>>> +    }
>>>> +
>>>> +    /* Register the thermal sensors */
>>>> +    for (id = 0; id < cnt; id++) {
>>>> +        data[id].sensor_id = id;
>>>> +        data[id].bgp = bgp;
>>>> +        data[id].ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET +
>>>> +                    id * K3_VTM_REGS_PER_TS;
>>>> +        data[id].stat_offset = data[id].ctrl_offset + 0x8;
>>>> +        INIT_WORK(&data[id].thermal_wq, k3_thermal_work);
>>>
>>>          What is supposed to do ?
>>
>> Periodically poll temperature. I know there is no passive cooling agent
>> like cpufreq at the moment but i do have a critical trip do you
>> recommend to remove that?
> 
> Actually I was referring to the workq which is initialized, the callback
> set but it is never called. It can be removed.

Okay got it.

> 
> Please take also the opportunity to wrap the calls to the register with
> an explicit helper function name.

IIUC the comment asks me to define a separate function that takes care 
of the body of the for loop.

> 
> And remove reg_cnt which is unused.

Sure

Thanks,
Keerthy
> 
> Thanks
> 
>    -- Daniel
> 
