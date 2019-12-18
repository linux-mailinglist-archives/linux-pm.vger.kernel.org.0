Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44218123DF8
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 04:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLRDat (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 22:30:49 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:16215 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfLRDat (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 22:30:49 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191218031345epoutp04d856b250fed19b4fb28954517610ecab~hWKiVaNZz2045520455epoutp04V
        for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2019 03:13:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191218031345epoutp04d856b250fed19b4fb28954517610ecab~hWKiVaNZz2045520455epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576638825;
        bh=ryabqhCNmLssM4nF4hSx9N7TUQla1FNTPF+4CXXgJsE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Q/QKQGsdXVuSVuC46wULkUNYCh0HB643ssgy/C7NDZLQyIZh695E1+kGLRMe2941g
         USHjCT1l0DCvIkNRgwBVpXsoShgAGA4T32XdeonPyDWTpsxlWlf5IR/+5VMM8jac4l
         V9tm0AsXG8iHSig7lxBDzPs/G5CnuAOW3xqPvFn4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191218031344epcas1p1676b6effb77febaea4e5e455e7f712e8~hWKhcey4U3244132441epcas1p1b;
        Wed, 18 Dec 2019 03:13:44 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47d0TJ6NwfzMqYlh; Wed, 18 Dec
        2019 03:13:40 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.0E.48498.46999FD5; Wed, 18 Dec 2019 12:13:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191218031340epcas1p1ea6fac621b67d5ce766d82518b5c13ee~hWKdoaaEz2352023520epcas1p1M;
        Wed, 18 Dec 2019 03:13:40 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191218031340epsmtrp2f04419844d14615d2e951e03d1c27276~hWKdniLS31830618306epsmtrp2Y;
        Wed, 18 Dec 2019 03:13:40 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-e4-5df99964d540
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.02.06569.46999FD5; Wed, 18 Dec 2019 12:13:40 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191218031340epsmtip144b1402acc29eaf9764477d392f916b4~hWKdWR0X_1182411824epsmtip1g;
        Wed, 18 Dec 2019 03:13:40 +0000 (GMT)
Subject: Re: [PATCH 2/9] PM / devfreq: Remove devfreq_get_devfreq_by_phandle
 function
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
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
Organization: Samsung Electronics
Message-ID: <304cb931-46da-d525-811d-51d932081b84@samsung.com>
Date:   Wed, 18 Dec 2019 12:20:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1967cf03-d1e8-8197-c767-3c8d5f403708@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPJsWRmVeSWpSXmKPExsWy7bCmvm7KzJ+xBrvvm1jcn9fKaDH/yDlW
        i/+PXrNa9D9+zWxx/vwGdouzTW/YLVbc/chqsenxNVaLy7vmsFl87j3CaPHpwX9mixnn9zFZ
        LGxqYbdYe+Quu8XS6xeZLG43rmCzaN17hN1B0GPNvDWMHptWdbJ5bF5S77Hx3Q4mj74tqxg9
        tl+bx+zxeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AdKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALLAr3ixNzi0rx0veT8
        XCtDAwMjU6DChOyMhY/WsRRM1Kr4uuIYSwPjBaUuRk4OCQETic6NP5m6GLk4hAR2MEocvnua
        BcL5xCjx+84vVgjnG6PEqh/r2WBamndch0rsZZSY9uIpG4TznlHiyLQX7CBVwgLhEs8XrGQC
        sdkEtCT2v7gB1i0iUC8xb81kVhCbWWANm8TfD7UgNr+AosTVH48ZQWxeATuJR/P3g9ksAqoS
        e661gc0UFQiTOLmtBapGUOLkzCcsIDangL3ElQ+bGCFmikvcejKfCcKWl9j+dg4zxNXn2CV6
        rhl3MXIA2S4Sl9ug/heWeHV8CzuELSXx+d1eqCerJVaePAL2l4RAB6PElv0XWCESxhL7l05m
        ApnDLKApsX6XPkRYUWLn77lQJ/BJvPvawwqxileio00IokRZ4vKDu0wQtqTE4vZOtgmMSrOQ
        PDMLyQOzkDwwC2HZAkaWVYxiqQXFuempxYYFRsiRvYkRnLi1zHYwLjrnc4hRgINRiYfXgOFn
        rBBrYllxZe4hRgkOZiUR3tsdQCHelMTKqtSi/Pii0pzU4kOMpsCwnsgsJZqcD8wqeSXxhqZG
        xsbGFiaGZqaGhkrivBw/LsYKCaQnlqRmp6YWpBbB9DFxcEo1MLb0fN6yfuUhrtV9c5Z3zn4g
        z3+wY9ee81bK248UZGxkPy714VbKpWbe3UsiOoTeHf7FfMWLv/6/zZbd3pNPiPlU/vW8V+ck
        O+uz+rkHAVsLd3Kx7bRLji+SPWbjJ1d7b7eazJS9c46drb8WniC98GzG7jOCgav0T4a8sZ1q
        wf5uh6zkgyOLFDmUWIozEg21mIuKEwG8gIoQ8gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSnG7KzJ+xBk/OyVncn9fKaDH/yDlW
        i/+PXrNa9D9+zWxx/vwGdouzTW/YLVbc/chqsenxNVaLy7vmsFl87j3CaPHpwX9mixnn9zFZ
        LGxqYbdYe+Quu8XS6xeZLG43rmCzaN17hN1B0GPNvDWMHptWdbJ5bF5S77Hx3Q4mj74tqxg9
        tl+bx+zxeZNcAHsUl01Kak5mWWqRvl0CV8bCR+tYCiZqVXxdcYylgfGCUhcjJ4eEgIlE847r
        rF2MXBxCArsZJRa/7WGHSEhKTLt4lLmLkQPIFpY4fLgYouYto8Tsj7cYQWqEBcIlni9YyQRi
        swloSex/cYMNpEhEoJFR4sn0H+wgDrPABjaJPU/us4FUCQkcZ5K4/U8axOYXUJS4+uMx2CRe
        ATuJR/P3g9ksAqoSe661gV0hKhAmsXPJYyaIGkGJkzOfsIDYnAL2Elc+bAKrZxZQl/gz7xIz
        hC0ucevJfCYIW15i+9s5zBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwykst1ytO
        zC0uzUvXS87P3cQIjmMtrR2MJ07EH2IU4GBU4uG98fdHrBBrYllxZe4hRgkOZiUR3tsdP2OF
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ88rnH4sUEkhPLEnNTk0tSC2CyTJxcEo1MOYIXzzE2uVs
        uzstMtLo5aJ15heOssuqbYmedDuvt9X+5fKL/6XT97k53/syXXmxkU1b7YrVvuq9brmzAjfp
        WTqJ+UtYaRw3bDu4X6r+lPpzD8eKU16yxpdXnN7RedL50xwfjVZ/xjM/FwtlF0wvdrO4EVU2
        Lb+pYqGD/KdPsgcfh83aveZOsxJLcUaioRZzUXEiANOYkvffAgAA
X-CMS-MailID: 20191218031340epcas1p1ea6fac621b67d5ce766d82518b5c13ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191217055105epcas1p2d2930402a559e381a7854f515a683d15
References: <20191217055738.28445-1-cw00.choi@samsung.com>
        <CGME20191217055105epcas1p2d2930402a559e381a7854f515a683d15@epcas1p2.samsung.com>
        <20191217055738.28445-3-cw00.choi@samsung.com>
        <VI1PR04MB70231FA16F12ACA3A3C01772EE500@VI1PR04MB7023.eurprd04.prod.outlook.com>
        <1967cf03-d1e8-8197-c767-3c8d5f403708@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/18/19 11:59 AM, Chanwoo Choi wrote:
> On 12/17/19 11:33 PM, Leonard Crestez wrote:
>> On 17.12.2019 07:51, Chanwoo Choi wrote:
>>> Previously, devfreq core support 'devfreq' property in order to get
>>> the devfreq device by phandle. But, 'devfreq' property name is not proper
>>> on devicetree binding because this name doesn't mean the any h/w attribute.
>>>
>>> The devfreq core hand over the right to decide the property name
>>> for getting the devfreq device on devicetree. Each devfreq driver
>>> will decide the property name on devicetree binding and then get
>>> the devfreq device by using devfreq_get_devfreq_by_node().
>>>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>>   drivers/devfreq/devfreq.c    | 35 -----------------------------------
>>>   drivers/devfreq/exynos-bus.c | 14 ++++++++++++--
>>>   include/linux/devfreq.h      |  8 --------
>>>   3 files changed, 12 insertions(+), 45 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index cb8ca81c8973..c3d3c7c802a0 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -991,48 +991,13 @@ struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
>>>   
>>>   	return ERR_PTR(-ENODEV);
>>>   }
>>> -
>>> -/*
>>> - * devfreq_get_devfreq_by_phandle - Get the devfreq device from devicetree
>>> - * @dev - instance to the given device
>>> - * @index - index into list of devfreq
>>> - *
>>> - * return the instance of devfreq device
>>> - */
>>> -struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
>>> -{
>>> -	struct device_node *node;
>>> -	struct devfreq *devfreq;
>>> -
>>> -	if (!dev)
>>> -		return ERR_PTR(-EINVAL);
>>> -
>>> -	if (!dev->of_node)
>>> -		return ERR_PTR(-EINVAL);
>>> -
>>> -	node = of_parse_phandle(dev->of_node, "devfreq", index);
>>> -	if (!node)
>>> -		return ERR_PTR(-ENODEV);
>>> -
>>> -	devfreq = devfreq_get_devfreq_by_node(node);
>>> -	of_node_put(node);
>>> -
>>> -	return devfreq;
>>> -}
>>> -
>>>   #else
>>>   struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
>>>   {
>>>   	return ERR_PTR(-ENODEV);
>>>   }
>>> -
>>> -struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
>>> -{
>>> -	return ERR_PTR(-ENODEV);
>>> -}
>>>   #endif /* CONFIG_OF */
>>>   EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_node);
>>> -EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_phandle);
>>>   
>>>   /**
>>>    * devm_devfreq_remove_device() - Resource-managed devfreq_remove_device()
>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>> index 7f5917d59072..9aac2db956d5 100644
>>> --- a/drivers/devfreq/exynos-bus.c
>>> +++ b/drivers/devfreq/exynos-bus.c
>>> @@ -146,6 +146,16 @@ static int exynos_bus_get_dev_status(struct device *dev,
>>>   	return ret;
>>>   }
>>>   
>>> +static struct devfreq *get_parent_devfreq_by_node(struct device_node *np)
>>> +{
>>> +	struct device_node *node = of_parse_phandle(np, "devfreq", 0);
>>> +
>>> +	if (!node)
>>> +		return ERR_PTR(-ENODEV);
>>> +
>>> +	return devfreq_get_devfreq_by_node(node);
>>> +}
>>
>> The _by_node suffix here is confusing because it actually fetches a 
>> property of the node unlike devfreq_get_devfreq_by_node. Maybe call this 
>> get_parent_devfreq_from_node?
>>
>> Since it's a static function it could just be called get_parent_devfreq?
> 
> OK.

I'll rename as following because all functions of exynos-bus.c
which used 'exynos_bus_' prefix.
- exynos_bus_get_parent_devfreq()

> 
>>
>>> +
>>>   static void exynos_bus_exit(struct device *dev)
>>>   {
>>>   	struct exynos_bus *bus = dev_get_drvdata(dev);
>>> @@ -353,8 +363,8 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>>>   	profile->exit = exynos_bus_passive_exit;
>>>   
>>>   	/* Get the instance of parent devfreq device */
>>> -	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
>>> -	if (IS_ERR(parent_devfreq))
>>> +	parent_devfreq = get_parent_devfreq_by_node(dev->of_node);
>>> +	if (IS_ERR(parent_devfreq)) {
>>>   		return -EPROBE_DEFER;
>>>   
>>>   	passive_data = devm_kzalloc(dev, sizeof(*passive_data), GFP_KERNEL);
>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>> index e3633ae43349..3ed96426302e 100644
>>> --- a/include/linux/devfreq.h
>>> +++ b/include/linux/devfreq.h
>>> @@ -254,8 +254,6 @@ extern void devm_devfreq_unregister_notifier(struct device *dev,
>>>   				struct notifier_block *nb,
>>>   				unsigned int list);
>>>   extern struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node);
>>> -extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
>>> -						int index);
>>>   
>>>   #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
>>>   /**
>>> @@ -413,12 +411,6 @@ struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
>>>   	return ERR_PTR(-ENODEV);
>>>   }
>>>   
>>> -static inline struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
>>> -							int index)
>>> -{
>>> -	return ERR_PTR(-ENODEV);
>>> -}
>>> -
>>>   static inline int devfreq_update_stats(struct devfreq *df)
>>>   {
>>>   	return -EINVAL;
>>>
>>
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
