Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07C7F12734C
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 03:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfLTCIG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 21:08:06 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:61439 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfLTCIF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 21:08:05 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191220020803epoutp03a611dfbe0d992c2ba4f0515e04389d23~h8jvLU8bV1191811918epoutp03x
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 02:08:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191220020803epoutp03a611dfbe0d992c2ba4f0515e04389d23~h8jvLU8bV1191811918epoutp03x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576807683;
        bh=eSs+MwiRJJZo0ItAbtDipT1NsXBGbUd77PDZ4na95io=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hIQnQhoJYMaAWTc7l80AV3oHem0P3lPS0BOy693GAqQhioNDswV6CwhZxznZ8SjHA
         wRzLgVvO18aMOXZIjpuXEe4Vow+XlrxpZnO91Ks+pMcZNuz+NWRFfBUHozzT1oQ8AV
         I0vSj/ZkMPbOCpJ0X+eFOoNnGxPH5ByF+68QLazY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191220020802epcas1p108d12b986890536113a2606dea22d0b2~h8juYXHfO1615416154epcas1p1K;
        Fri, 20 Dec 2019 02:08:02 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47fBwZ6GCQzMqYm4; Fri, 20 Dec
        2019 02:07:58 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.5B.48019.EFC2CFD5; Fri, 20 Dec 2019 11:07:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191220020758epcas1p15aa38ab68b96cfdf9491166fa8b6fe1e~h8jqZ6Txc1617816178epcas1p1t;
        Fri, 20 Dec 2019 02:07:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191220020758epsmtrp1768c093c0d73d55aececf5ac2738683d~h8jqY-7wa1131511315epsmtrp1D;
        Fri, 20 Dec 2019 02:07:58 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-82-5dfc2cfef306
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.25.10238.DFC2CFD5; Fri, 20 Dec 2019 11:07:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191220020757epsmtip1c89599970371f05d80681d316d666094~h8jqBJH4R1567315673epsmtip1B;
        Fri, 20 Dec 2019 02:07:57 +0000 (GMT)
Subject: Re: [PATCH v2 02/11] PM / devfreq: Remove
 devfreq_get_devfreq_by_phandle function
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "a.swigon@samsung.com" <a.swigon@samsung.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "kgene@kernel.org" <kgene@kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <4aedc0fc-db5b-95bd-cf25-c3d711f512d2@samsung.com>
Date:   Fri, 20 Dec 2019 11:14:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023160888F88B5800A90189EE2D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAJsWRmVeSWpSXmKPExsWy7bCmvu4/nT+xBl+WG1vcn9fKaDH/yDlW
        i/+PXrNa9D9+zWxx/vwGdouzTW/YLVbc/chqsenxNVaLy7vmsFl87j3CaPHpwX9mixnn9zFZ
        LGxqYbdYe+Quu8XS6xeZLG43rmCzaN17hN1B0GPNvDWMHptWdbJ5bF5S77Hx3Q4mj74tqxg9
        tl+bx+zxeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AdKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALLAr3ixNzi0rx0veT8
        XCtDAwMjU6DChOyMxT9esBY0GlQcO36fuYFxuXoXIyeHhICJRNfNDSxdjFwcQgI7GCVuXNoG
        5XxilLh4+wIbhPONUeLmvicsMC2zX79jgkjsZZT4sLwHquo9o8TChomMIFXCAjESHxduYO1i
        5OAQEQiROHIwDaSGWeAmm8SFW1OYQGrYBLQk9r+4wQZi8wsoSlz98Risl1fATuLBh1VgNSwC
        qhJ73j1iBrFFBcIkTm5rgaoRlDg5E+QiDg5OgViJQ5PUQMLMAuISt57MZ4Kw5SW2v53DDLJX
        QuAcu8SDTcuhPnCRuHb3BCOELSzx6vgWdghbSuJlfxuUXS2x8uQRNojmDkaJLfsvsEIkjCX2
        L53MBLKYWUBTYv0ufYiwosTO33MZIRbzSbz72gP2u4QAr0RHmxBEibLE5Qd3mSBsSYnF7Z1s
        ExiVZiH5ZhaSF2YheWEWwrIFjCyrGMVSC4pz01OLDQtMkGN7EyM4dWtZ7GDcc87nEKMAB6MS
        D69D2u9YIdbEsuLK3EOMEhzMSiK8tzt+xgrxpiRWVqUW5ccXleakFh9iNAUG9kRmKdHkfGBe
        ySuJNzQ1MjY2tjAxNDM1NFQS5+X4cTFWSCA9sSQ1OzW1ILUIpo+Jg1OqgXGF3qIQvQ1ix2Ju
        p/C1xwSnzEvVUjIM8GR55cfa9FDKoE3vufazJrMHx9JXFd1S43pkvLBkw103q2M7z+q4/uBU
        W/v67sonEYEKat8uCCY03DrNble9Z7mnzE/NmS/f7Up7u3jNPf24UBsf3X7WgtR1iVVX574W
        /yK2//C3wxMVVxgLBqpeTVFiKc5INNRiLipOBAB5BPO58wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsWy7bCSnO5fnT+xBkcfmVrcn9fKaDH/yDlW
        i/+PXrNa9D9+zWxx/vwGdouzTW/YLVbc/chqsenxNVaLy7vmsFl87j3CaPHpwX9mixnn9zFZ
        LGxqYbdYe+Quu8XS6xeZLG43rmCzaN17hN1B0GPNvDWMHptWdbJ5bF5S77Hx3Q4mj74tqxg9
        tl+bx+zxeZNcAHsUl01Kak5mWWqRvl0CV8biHy9YCxoNKo4dv8/cwLhcvYuRk0NCwERi9ut3
        TF2MXBxCArsZJa7c2c8MkZCUmHbxKJDNAWQLSxw+XAwSFhJ4yyjx/G4eiC0sECPxceEGVhBb
        RCBEov/tYhaQOcwCd9kkvuz8zwwxdBazxKK9/9hAqtgEtCT2v7gBZvMLKEpc/fGYEcTmFbCT
        ePBhFROIzSKgKrHn3SOwI0QFwiR2LnnMBFEjKHFy5hMWkIM4BWIlDk1SAwkzC6hL/Jl3iRnC
        Fpe49WQ+E4QtL7H97RzmCYzCs5B0z0LSMgtJyywkLQsYWVYxSqYWFOem5xYbFhjmpZbrFSfm
        Fpfmpesl5+duYgTHsJbmDsbLS+IPMQpwMCrx8Dqk/Y4VYk0sK67MPcQowcGsJMJ7u+NnrBBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXHep3nHIoUE0hNLUrNTUwtSi2CyTBycUg2Mc3JMDzbemhMi
        yxfTpJ4kEryx1To8fcqBGat4BPU1HBPztVknKETb6PKkLGeZutMl8/nxaDGpO20b47Sq4xrY
        Hs6bxj/L8OKz1P1NUi9+mzdqCCt2y+mcZZus7sJn6NDRe1q8u51x8z2rU9cbpdd895u/fk3i
        7sUK6yUqf93ik9MVuT7121UlluKMREMt5qLiRABUckrr3QIAAA==
X-CMS-MailID: 20191220020758epcas1p15aa38ab68b96cfdf9491166fa8b6fe1e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220001759epcas1p4ce1c2017937a35de84eab720b9732df0
References: <20191220002430.11995-1-cw00.choi@samsung.com>
        <CGME20191220001759epcas1p4ce1c2017937a35de84eab720b9732df0@epcas1p4.samsung.com>
        <20191220002430.11995-3-cw00.choi@samsung.com>
        <VI1PR04MB70235291D8E40CB6225A0AF0EE2D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
        <46e629e0-fee4-21a6-3baa-f347ff6417d8@samsung.com>
        <VI1PR04MB7023160888F88B5800A90189EE2D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/20/19 10:40 AM, Leonard Crestez wrote:
> On 2019-12-20 2:54 AM, Chanwoo Choi wrote:
>> On 12/20/19 9:46 AM, Leonard Crestez wrote:
>>> On 20.12.2019 02:18, Chanwoo Choi wrote:
>>>> Previously, devfreq core support 'devfreq' property in order to get
>>>> the devfreq device by phandle. But, 'devfreq' property name is not proper
>>>> on devicetree binding because this name doesn't mean the any h/w attribute.
>>>>
>>>> The devfreq core hand over the right to decide the property name
>>>> for getting the devfreq device on devicetree. Each devfreq driver
>>>> will decide the property name on devicetree binding and then get
>>>> the devfreq device by using devfreq_get_devfreq_by_node().
>>>>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> ---
>>>>    drivers/devfreq/devfreq.c    | 35 -----------------------------------
>>>>    drivers/devfreq/exynos-bus.c | 12 +++++++++++-
>>>>    include/linux/devfreq.h      |  8 --------
>>>>    3 files changed, 11 insertions(+), 44 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>> index cb8ca81c8973..c3d3c7c802a0 100644
>>>> --- a/drivers/devfreq/devfreq.c
>>>> +++ b/drivers/devfreq/devfreq.c
>>>> @@ -991,48 +991,13 @@ struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
>>>>    
>>>>    	return ERR_PTR(-ENODEV);
>>>>    }
>>>> -
>>>> -/*
>>>> - * devfreq_get_devfreq_by_phandle - Get the devfreq device from devicetree
>>>> - * @dev - instance to the given device
>>>> - * @index - index into list of devfreq
>>>> - *
>>>> - * return the instance of devfreq device
>>>> - */
>>>> -struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
>>>> -{
>>>> -	struct device_node *node;
>>>> -	struct devfreq *devfreq;
>>>> -
>>>> -	if (!dev)
>>>> -		return ERR_PTR(-EINVAL);
>>>> -
>>>> -	if (!dev->of_node)
>>>> -		return ERR_PTR(-EINVAL);
>>>> -
>>>> -	node = of_parse_phandle(dev->of_node, "devfreq", index);
>>>> -	if (!node)
>>>> -		return ERR_PTR(-ENODEV);
>>>> -
>>>> -	devfreq = devfreq_get_devfreq_by_node(node);
>>>> -	of_node_put(node);
>>>> -
>>>> -	return devfreq;
>>>> -}
>>>> -
>>>>    #else
>>>>    struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
>>>>    {
>>>>    	return ERR_PTR(-ENODEV);
>>>>    }
>>>> -
>>>> -struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
>>>> -{
>>>> -	return ERR_PTR(-ENODEV);
>>>> -}
>>>>    #endif /* CONFIG_OF */
>>>>    EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_node);
>>>> -EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_phandle);
>>>>    
>>>>    /**
>>>>     * devm_devfreq_remove_device() - Resource-managed devfreq_remove_device()
>>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>>> index 7f5917d59072..1bc4e3c81115 100644
>>>> --- a/drivers/devfreq/exynos-bus.c
>>>> +++ b/drivers/devfreq/exynos-bus.c
>>>> @@ -86,6 +86,16 @@ static int exynos_bus_get_event(struct exynos_bus *bus,
>>>>    	return ret;
>>>>    }
>>>>    
>>>> +static struct devfreq *exynos_bus_get_parent_devfreq(struct device_node *np)
>>>> +{
>>>> +	struct device_node *node = of_parse_phandle(np, "devfreq", 0);
>>>> +
>>>> +	if (!node)
>>>> +		return ERR_PTR(-ENODEV);
>>>> +
>>>> +	return devfreq_get_devfreq_by_node(node);
>>>
>>> You need to call of_node_put(node) here and in several other places.
>>>
>>> The old devfreq_get_devfreq_by_phandle API handled this internally but
>>> devfreq_get_devfreq_by_node doesn't.
>>
>> Thanks. I'll fix it.
>>
>>>
>>> Maybe the _by_phandle API could be kept and just take the property name
>>> instead of always using "devfreq"?
>>
>> Do you mean like below?
>> devfreq_get_devfreq_by_phandle(struct device *dev, int index)
>> -> devfreq_get_devfreq_by_phandle(struct device *dev, char *property_name, int index)
>>
>> In case of devfreq-event.c,
>> struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(
>> 						struct device *dev,
>> 						char property_name,
>> 						int index)
>> int devfreq_event_get_edev_count(struct device *dev, char *property_name)
> 
> Yes. These helpers would avoid the need for explicit of_node_put.

OK. Instead of removing devfreq_event_get_edev_by_phandle,
change the function property of devfreq_event_get_edev_by_phandle on v3.

After getting the review for dt-binding patch, I'll send v3 patches.

> 
>>
>>>
>>>> +}
>>>> +
>>>>    /*
>>>>     * devfreq function for both simple-ondemand and passive governor
>>>>     */
>>>> @@ -353,7 +363,7 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>>>>    	profile->exit = exynos_bus_passive_exit;
>>>>    
>>>>    	/* Get the instance of parent devfreq device */
>>>> -	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
>>>> +	parent_devfreq = exynos_bus_get_parent_devfreq(dev->of_node);
>>>>    	if (IS_ERR(parent_devfreq))
>>>>    		return -EPROBE_DEFER;
>>>>    
>>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>>> index 1dccc47acbce..a4351698fb64 100644
>>>> --- a/include/linux/devfreq.h
>>>> +++ b/include/linux/devfreq.h
>>>> @@ -254,8 +254,6 @@ extern void devm_devfreq_unregister_notifier(struct device *dev,
>>>>    				struct notifier_block *nb,
>>>>    				unsigned int list);
>>>>    extern struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node);
>>>> -extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
>>>> -						int index);
>>>>    
>>>>    #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
>>>>    /**
>>>> @@ -413,12 +411,6 @@ static inline struct devfreq *devfreq_get_devfreq_by_node(struct device_node *no
>>>>    	return ERR_PTR(-ENODEV);
>>>>    }
>>>>    
>>>> -static inline struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
>>>> -							int index)
>>>> -{
>>>> -	return ERR_PTR(-ENODEV);
>>>> -}
>>>> -
>>>>    static inline int devfreq_update_stats(struct devfreq *df)
>>>>    {
>>>>    	return -EINVAL;
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
