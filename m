Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED26BE9DD
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 03:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfIZBD1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 21:03:27 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:15677 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfIZBD1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 21:03:27 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190926010324epoutp03a5646df08187a725df615e7bbd7bda57~H12Bz1cOf3233432334epoutp03T
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2019 01:03:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190926010324epoutp03a5646df08187a725df615e7bbd7bda57~H12Bz1cOf3233432334epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569459804;
        bh=Yqpkx4BCEja08YHcDCpzNi4z57TCOeCeLIIybRZTEyE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MPMNErV2qY1BF4t2pzdLhCBRpqxCDiloREu6f7HWZYItHSbAr2K0063jc2dhv+S8n
         xIcY3o3oD7cTXNXIUerBGIOxq43q9LAq0J/vXT0/LLhzFIbAWffSOc5f53Ezw1TRjq
         xhizmkkwJ79Q/UjlYV7JLU0Q3oEjiD66ebJl4HP4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190926010323epcas1p293ad50585fbf8750f02b64768785c4c3~H12BD7VLe0177201772epcas1p2V;
        Thu, 26 Sep 2019 01:03:23 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 46dxWF2kbczMqYkZ; Thu, 26 Sep
        2019 01:03:21 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.E3.04085.95E0C8D5; Thu, 26 Sep 2019 10:03:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190926010320epcas1p4cfb1f724d67da870e657f0a4483c8e3b~H11_etUap1100411004epcas1p4M;
        Thu, 26 Sep 2019 01:03:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190926010320epsmtrp15b0d05597ba8c8698e5c5dbb04c422ab~H11_dqJra1220412204epsmtrp1d;
        Thu, 26 Sep 2019 01:03:20 +0000 (GMT)
X-AuditID: b6c32a37-e31ff70000000ff5-9e-5d8c0e59e369
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.1D.04081.85E0C8D5; Thu, 26 Sep 2019 10:03:20 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190926010320epsmtip2288b7d5cec1706a5df38966fe4465b17~H11_N6lDo2189421894epsmtip2a;
        Thu, 26 Sep 2019 01:03:20 +0000 (GMT)
Subject: Re: [PATCH v8 5/6] PM / devfreq: Add PM QoS support
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <48e271f5-58d3-845a-538f-6fb75eb3deb6@samsung.com>
Date:   Thu, 26 Sep 2019 10:08:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023910B94E4920D329427C8EE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJsWRmVeSWpSXmKPExsWy7bCmnm4kX0+swc5XAhaHjm1lt/h6+hSj
        xbJLRxktpu/dxGZx/vwGdouzTW/YLW41yFisuPuR1WLT42usFl2/VjJbfO49wmjxecNjRovb
        jSvYLFafO8hm0XXoL5vFxq8eDgIe72+0snvMbrjI4rFgU6nHplWdbB53ru1h89i8pN5j47sd
        TB4H3+1h8ujbsorR4/MmuQCuqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWF
        vMTcVFslF58AXbfMHKBHlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFlgV6xYm5
        xaV56XrJ+blWhgYGRqZAhQnZGf/v32At+ClV8W7Xb5YGxquiXYycHBICJhJr/qxi7mLk4hAS
        2MEocWvNMnYI5xOjxMGDn1ggnG+MEltubWCHaTm25ARUYi+jxLpdX5ggnPeMEhf6VrOAVAkL
        2Ej8v/qRDcQWEQiV+PL0EjOIzSzQxCrx6UgZiM0moCWx/8UNsBp+AUWJqz8eM4LYvAJ2Enu3
        3GECsVkEVCVm3/wI1isqECHx6cFhVogaQYmTM5+A7eIUiJW48nQ6O8R8cYlbT+YzQdjyEs1b
        Z4M9JyFwjV1ix57njBAvuEhM2r+aCcIWlnh1fAvUa1ISL/vboOxqiZUnj7BBNHcA/b//AitE
        wlhi/9LJQM0cQBs0Jdbv0ocIK0rs/D2XEWIxn8S7rz2sICUSArwSHW1CECXKEpcf3IVaKymx
        uL2TbQKj0iwk78xC8sIsJC/MQli2gJFlFaNYakFxbnpqsWGBMXJ0b2IEp3It8x2MG875HGIU
        4GBU4uGViOyOFWJNLCuuzD3EKMHBrCTCO0umK1aINyWxsiq1KD++qDQntfgQoykwtCcyS4km
        5wPzTF5JvKGpkbGxsYWJoZmpoaGSOK9HekOskEB6YklqdmpqQWoRTB8TB6dUA6P4m5u9YhM2
        ynE9yWzl4LmucWjvHV0vpoqdWlNsJ75sqZaZ+STuQ8vd6INsPh5z9y/e/uPSjelOydZGM2Uv
        /LY4cqjBZHvxeY8t154ee/F1nuLFZrncQ1uP7v/ZZHpKc07+tVBFm5s/jzMtZ75ulJSyO2Cm
        cHln6OSWM+pqPUsL/6fb5Osv/vtbiaU4I9FQi7moOBEAAmeKgPsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7bCSvG4EX0+sweIuXYtDx7ayW3w9fYrR
        Ytmlo4wW0/duYrM4f34Du8XZpjfsFrcaZCxW3P3IarHp8TVWi65fK5ktPvceYbT4vOExo8Xt
        xhVsFqvPHWSz6Dr0l81i41cPBwGP9zda2T1mN1xk8ViwqdRj06pONo871/aweWxeUu+x8d0O
        Jo+D7/YwefRtWcXo8XmTXABXFJdNSmpOZllqkb5dAlfG//s3WAt+SlW82/WbpYHxqmgXIyeH
        hICJxLElJ1i6GLk4hAR2M0rMmvWIGSIhKTHt4lEgmwPIFpY4fLgYouYto8T9ztUsIDXCAjYS
        /69+ZAOxRQRCJf50LmcFKWIWaGKV6Pp+nRGi4wmzxJsVd9lBqtgEtCT2v7gB1sEvoChx9cdj
        RhCbV8BOYu+WO0wgNouAqsTsmx/BrhAViJA4vGMWVI2gxMmZT8A2cwrESlx5Oh1sJrOAusSf
        eZeYIWxxiVtP5jNB2PISzVtnM09gFJ6FpH0WkpZZSFpmIWlZwMiyilEytaA4Nz232LDAMC+1
        XK84Mbe4NC9dLzk/dxMjOKq1NHcwXl4Sf4hRgINRiYf3QFh3rBBrYllxZe4hRgkOZiUR3lky
        XbFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0tSC2CyTJxcEo1MPJGFJve
        EBSqOh2ydN+F//UnBNelFG8x/l1662iuXLUmR9UZLRvLUxbmtS/ruttLqr9/FN68bu7Muy6a
        1y1dDT7d2LCZe33pn4piV6t/hZOOTrFOTGlN8vx2xPC8Wc9aXunTf7cUvRO7HGbVu6L5q03O
        zz3HDqkcbBIverVkeWHfJMb9zOfO/ldiKc5INNRiLipOBAAgoGxU5gIAAA==
X-CMS-MailID: 20190926010320epcas1p4cfb1f724d67da870e657f0a4483c8e3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190924192429epcas3p196a7de011d3e78508d1e643efd27e717
References: <cover.1569319738.git.leonard.crestez@nxp.com>
        <58fdd2c226a4e76a3d9427baab7dd5c23af842ab.1569319738.git.leonard.crestez@nxp.com>
        <20190924191124.GJ133864@google.com>
        <CGME20190924192429epcas3p196a7de011d3e78508d1e643efd27e717@epcas3p1.samsung.com>
        <VI1PR04MB7023034123415F86CC045CCDEE840@VI1PR04MB7023.eurprd04.prod.outlook.com>
        <080027a2-d807-5fa4-f148-4469678ce849@samsung.com>
        <VI1PR04MB7023910B94E4920D329427C8EE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 9. 26. 오전 4:40, Leonard Crestez wrote:
> On 25.09.2019 05:13, Chanwoo Choi wrote:
>> On 19. 9. 25. 오전 4:22, Leonard Crestez wrote:
>>> On 24.09.2019 22:11, Matthias Kaehlcke wrote:
>>>> On Tue, Sep 24, 2019 at 01:11:29PM +0300, Leonard Crestez wrote:
>>>>> Register notifiers with the PM QoS framework in order to respond to
>>>>> requests for DEV_PM_QOS_MIN_FREQUENCY and DEV_PM_QOS_MAX_FREQUENCY.
>>>>>
>>>>> No notifiers are added by this patch but PM QoS constraints can be
>>>>> imposed externally (for example from other devices).
>>>>>
>>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>>>> ---
>>>>>    drivers/devfreq/devfreq.c | 75 +++++++++++++++++++++++++++++++++++++++
>>>>>    include/linux/devfreq.h   |  5 +++
>>>>>    2 files changed, 80 insertions(+)
>>>>>
>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>> index eee403e70c84..784f3e40536a 100644
>>>>> --- a/drivers/devfreq/devfreq.c
>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>> @@ -22,15 +22,18 @@
>>>>>    #include <linux/platform_device.h>
>>>>>    #include <linux/list.h>
>>>>>    #include <linux/printk.h>
>>>>>    #include <linux/hrtimer.h>
>>>>>    #include <linux/of.h>
>>>>> +#include <linux/pm_qos.h>
>>>>>    #include "governor.h"
>>>>>    
>>>>>    #define CREATE_TRACE_POINTS
>>>>>    #include <trace/events/devfreq.h>
>>>>>    
>>>>> +#define HZ_PER_KHZ	1000
>>>>> +
>>>>>    static struct class *devfreq_class;
>>>>>    
>>>>>    /*
>>>>>     * devfreq core provides delayed work based load monitoring helper
>>>>>     * functions. Governors can use these or can implement their own
>>>>> @@ -109,10 +112,11 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>>>>>    static void get_freq_range(struct devfreq *devfreq,
>>>>>    			   unsigned long *min_freq,
>>>>>    			   unsigned long *max_freq)
>>>>>    {
>>>>>    	unsigned long *freq_table = devfreq->profile->freq_table;
>>>>> +	unsigned long qos_min_freq, qos_max_freq;
>>>>>    
>>>>>    	lockdep_assert_held(&devfreq->lock);
>>>>>    
>>>>>    	/*
>>>>>    	 * Init min/max frequency from freq table.
>>>>> @@ -125,10 +129,18 @@ static void get_freq_range(struct devfreq *devfreq,
>>>>>    	} else {
>>>>>    		*min_freq = freq_table[devfreq->profile->max_state - 1];
>>>>>    		*max_freq = freq_table[0];
>>>>>    	}
>>>>>    
>>>>> +	/* constraints from PM QoS */
>>>>> +	qos_min_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>>>>> +					     DEV_PM_QOS_MIN_FREQUENCY);
>>>>> +	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>>>>> +					     DEV_PM_QOS_MIN_FREQUENCY); >
>>>> This needs to be DEV_PM_QOS_MAX_FREQUENCY. I missed this in the earlier
>>>> reviews, but stumbled across it when testing.
>>>>
>>>> !Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>>
>>> I broke it in v8 while processing comments. Thanks for catching it.
>>
>> Did you test this patchset with v8?
>> Maybe it is not working with this mistake.
> 
> I ran some scripts which test that min_freq requests work as expected 
> (using imx interconnect+devfreq). They don't touch max_freq.

We always have to test the code before contributing the patch.
Please test all cases for these patches.

> 
> --
> Regards,
> Leonard
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
