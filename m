Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD3C127296
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 01:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfLTAyZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 19:54:25 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:19394 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfLTAyY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 19:54:24 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191220005420epoutp03ab7c254d5ac943502297d3d7c3f74158~h7jX1TdXA1149811498epoutp03I
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 00:54:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191220005420epoutp03ab7c254d5ac943502297d3d7c3f74158~h7jX1TdXA1149811498epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576803260;
        bh=V7U3VumFo0nUAtyifHEmVEByUWo4iAOoKH8fKt6nBCI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nPjJUqFxCQT5v12h0Q6PhyRxR+2ths3iAkaLE8M9cbtokV5mbc1cvzSZL8OsPKcHS
         YL2YRYYJB3z+Kp8TtZIxoNN/ssxU/LZ+c9mYq2RpCTOKt7vQ0v1poIzCQEh0x5MtTI
         cLZ+Zzz2grBXAT1w+UoOaf/sJoScoAoJny9Qudmg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191220005419epcas1p49978660954303b810a10a1733e7e9090~h7jXLTk4o2694726947epcas1p4m;
        Fri, 20 Dec 2019 00:54:19 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47f9HX2QpbzMqYm7; Fri, 20 Dec
        2019 00:54:16 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.CF.51241.4BB1CFD5; Fri, 20 Dec 2019 09:54:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191220005412epcas1p191afcc20fc8ff95891f1570cb9d85df7~h7jQUv8v72171721717epcas1p1d;
        Fri, 20 Dec 2019 00:54:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191220005411epsmtrp1076b9711cd356ce46c27b46087643a85~h7jQTlkkV0350703507epsmtrp1w;
        Fri, 20 Dec 2019 00:54:11 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-c4-5dfc1bb481dc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.9D.10238.3BB1CFD5; Fri, 20 Dec 2019 09:54:11 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191220005411epsmtip2b05ce6a0164691926ba3490dfbb2733a~h7jQB03gQ3127531275epsmtip2G;
        Fri, 20 Dec 2019 00:54:11 +0000 (GMT)
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
Message-ID: <46e629e0-fee4-21a6-3baa-f347ff6417d8@samsung.com>
Date:   Fri, 20 Dec 2019 10:00:43 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB70235291D8E40CB6225A0AF0EE2D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAJsWRmVeSWpSXmKPExsWy7bCmge4W6T+xBgd2m1jcn9fKaDH/yDlW
        i/+PXrNa9D9+zWxx/vwGdouzTW/YLVbc/chqsenxNVaLy7vmsFl87j3CaPHpwX9mixnn9zFZ
        LGxqYbdYe+Quu8XS6xeZLG43rmCzaN17hN1B0GPNvDWMHptWdbJ5bF5S77Hx3Q4mj74tqxg9
        tl+bx+zxeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AdKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALLAr3ixNzi0rx0veT8
        XCtDAwMjU6DChOyME7fa2AvWaVXsXfGGvYHxiFIXIyeHhICJRMvqFYxdjFwcQgI7GCVONO1l
        h3A+MUp8nzcdKvONUeL8mwYghwOs5cmeMoj4XqCiFy+YIZz3jBJLrv9gBZkrLBAj8XHhBlaQ
        BhGBEIkjB9NAapgFbrJJXLg1hQmkhk1AS2L/ixtsIDa/gKLE1R+PGUFsXgE7iU0Pm8HiLAKq
        EqeOzgWzRQXCJE5ua4GqEZQ4OfMJC4jNKRArsXPaYjCbWUBc4taT+UwQtrzE9rdzwI6TEDjH
        LtHw4xELxNMuEj3rbkPZwhKvjm9hh7ClJF72t0HZ1RIrTx5hg2juYJTYsv8CK0TCWGL/0slM
        IJ8xC2hKrN+lDxFWlNj5ey4jxGI+iXdfe1ghocUr0dEmBFGiLHH5wV0mCFtSYnF7J9sERqVZ
        SN6ZheSFWUhemIWwbAEjyypGsdSC4tz01GLDAlPk2N7ECE7dWpY7GI+d8znEKMDBqMTD65D2
        O1aINbGsuDL3EKMEB7OSCO/tjp+xQrwpiZVVqUX58UWlOanFhxhNgaE9kVlKNDkfmFfySuIN
        TY2MjY0tTAzNTA0NlcR5OX5cjBUSSE8sSc1OTS1ILYLpY+LglGpglNrdvODx55KgW+Eb2XuT
        j9yIfd562Z3xXdPqhrn/Y1WMamU32rdcLf50abNAb/3XZdGhGy7WbQgP3VdrHrdJ5sibCTw6
        Du0d3geDL4kvN2hWbmEMVY53+7TLg315v/qmAA+NyvKLfCkZrYFTOzY96xfZwCtTemTTy73V
        ntG7H4if2Lst4/osJZbijERDLeai4kQACubJ+vMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsWy7bCSvO5m6T+xBht/mFvcn9fKaDH/yDlW
        i/+PXrNa9D9+zWxx/vwGdouzTW/YLVbc/chqsenxNVaLy7vmsFl87j3CaPHpwX9mixnn9zFZ
        LGxqYbdYe+Quu8XS6xeZLG43rmCzaN17hN1B0GPNvDWMHptWdbJ5bF5S77Hx3Q4mj74tqxg9
        tl+bx+zxeZNcAHsUl01Kak5mWWqRvl0CV8aJW23sBeu0KvaueMPewHhEqYuRg0NCwETiyZ6y
        LkYuDiGB3YwSzRO3snUxcgLFJSWmXTzKDFEjLHH4cDFEzVtGiU2XDzKB1AgLxEh8XLiBFcQW
        EQiR6H+7mAWkiFngLpvEl53/mUESQgKTmCTa15aC2GwCWhL7X9wAW8AvoChx9cdjRhCbV8BO
        YtPDZrA4i4CqxKmjc8FsUYEwiZ1LHjNB1AhKnJz5hAXE5hSIldg5bTGYzSygLvFn3iVmCFtc
        4taT+UwQtrzE9rdzmCcwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtc
        mpeul5yfu4kRHMNamjsYLy+JP8QowMGoxMPrkPY7Vog1say4MvcQowQHs5II7+2On7FCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0tSC2CyTJxcEo1MKpHvd711etDram2
        3RzN6YqrD9w//z2q2/3Evvvy89UXb3rF8+bPrJ5JrIZW5sUnzMukEyew65/bqGagtOvYOhGT
        r4+vx5sXOL9a9IJfbRXLPKXIQ0yH1VWfbF8klCcsNXXnu1n+z3/yB4ZlZv/7FNDtO2Wf3/ZP
        P2/VLn4W4/R9TW+qy1/Pd3ZKLMUZiYZazEXFiQACGwif3QIAAA==
X-CMS-MailID: 20191220005412epcas1p191afcc20fc8ff95891f1570cb9d85df7
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/20/19 9:46 AM, Leonard Crestez wrote:
> On 20.12.2019 02:18, Chanwoo Choi wrote:
>> Previously, devfreq core support 'devfreq' property in order to get
>> the devfreq device by phandle. But, 'devfreq' property name is not proper
>> on devicetree binding because this name doesn't mean the any h/w attribute.
>>
>> The devfreq core hand over the right to decide the property name
>> for getting the devfreq device on devicetree. Each devfreq driver
>> will decide the property name on devicetree binding and then get
>> the devfreq device by using devfreq_get_devfreq_by_node().
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c    | 35 -----------------------------------
>>   drivers/devfreq/exynos-bus.c | 12 +++++++++++-
>>   include/linux/devfreq.h      |  8 --------
>>   3 files changed, 11 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index cb8ca81c8973..c3d3c7c802a0 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -991,48 +991,13 @@ struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
>>   
>>   	return ERR_PTR(-ENODEV);
>>   }
>> -
>> -/*
>> - * devfreq_get_devfreq_by_phandle - Get the devfreq device from devicetree
>> - * @dev - instance to the given device
>> - * @index - index into list of devfreq
>> - *
>> - * return the instance of devfreq device
>> - */
>> -struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
>> -{
>> -	struct device_node *node;
>> -	struct devfreq *devfreq;
>> -
>> -	if (!dev)
>> -		return ERR_PTR(-EINVAL);
>> -
>> -	if (!dev->of_node)
>> -		return ERR_PTR(-EINVAL);
>> -
>> -	node = of_parse_phandle(dev->of_node, "devfreq", index);
>> -	if (!node)
>> -		return ERR_PTR(-ENODEV);
>> -
>> -	devfreq = devfreq_get_devfreq_by_node(node);
>> -	of_node_put(node);
>> -
>> -	return devfreq;
>> -}
>> -
>>   #else
>>   struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
>>   {
>>   	return ERR_PTR(-ENODEV);
>>   }
>> -
>> -struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
>> -{
>> -	return ERR_PTR(-ENODEV);
>> -}
>>   #endif /* CONFIG_OF */
>>   EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_node);
>> -EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_phandle);
>>   
>>   /**
>>    * devm_devfreq_remove_device() - Resource-managed devfreq_remove_device()
>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>> index 7f5917d59072..1bc4e3c81115 100644
>> --- a/drivers/devfreq/exynos-bus.c
>> +++ b/drivers/devfreq/exynos-bus.c
>> @@ -86,6 +86,16 @@ static int exynos_bus_get_event(struct exynos_bus *bus,
>>   	return ret;
>>   }
>>   
>> +static struct devfreq *exynos_bus_get_parent_devfreq(struct device_node *np)
>> +{
>> +	struct device_node *node = of_parse_phandle(np, "devfreq", 0);
>> +
>> +	if (!node)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	return devfreq_get_devfreq_by_node(node);
> 
> You need to call of_node_put(node) here and in several other places.
> 
> The old devfreq_get_devfreq_by_phandle API handled this internally but 
> devfreq_get_devfreq_by_node doesn't.

Thanks. I'll fix it.

> 
> Maybe the _by_phandle API could be kept and just take the property name 
> instead of always using "devfreq"?

Do you mean like below?
devfreq_get_devfreq_by_phandle(struct device *dev, int index)
-> devfreq_get_devfreq_by_phandle(struct device *dev, char *property_name, int index)

In case of devfreq-event.c,
struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(
						struct device *dev,
						char property_name,
						int index)
int devfreq_event_get_edev_count(struct device *dev, char *property_name)

> 
>> +}
>> +
>>   /*
>>    * devfreq function for both simple-ondemand and passive governor
>>    */
>> @@ -353,7 +363,7 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>>   	profile->exit = exynos_bus_passive_exit;
>>   
>>   	/* Get the instance of parent devfreq device */
>> -	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
>> +	parent_devfreq = exynos_bus_get_parent_devfreq(dev->of_node);
>>   	if (IS_ERR(parent_devfreq))
>>   		return -EPROBE_DEFER;
>>   
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index 1dccc47acbce..a4351698fb64 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -254,8 +254,6 @@ extern void devm_devfreq_unregister_notifier(struct device *dev,
>>   				struct notifier_block *nb,
>>   				unsigned int list);
>>   extern struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node);
>> -extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
>> -						int index);
>>   
>>   #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
>>   /**
>> @@ -413,12 +411,6 @@ static inline struct devfreq *devfreq_get_devfreq_by_node(struct device_node *no
>>   	return ERR_PTR(-ENODEV);
>>   }
>>   
>> -static inline struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
>> -							int index)
>> -{
>> -	return ERR_PTR(-ENODEV);
>> -}
>> -
>>   static inline int devfreq_update_stats(struct devfreq *df)
>>   {
>>   	return -EINVAL;
>>
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
