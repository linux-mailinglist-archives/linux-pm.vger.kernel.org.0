Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 601A8123D81
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 03:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfLRCxH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 21:53:07 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:14554 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLRCxH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 21:53:07 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191218025303epoutp03082732917e97e6d2aaba3340c7f227a9~hV4dO95YL0223002230epoutp03s
        for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2019 02:53:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191218025303epoutp03082732917e97e6d2aaba3340c7f227a9~hV4dO95YL0223002230epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576637583;
        bh=c+4b2JtjeOV7nV7TSHhA4nxZS2ZGNLBNR1j7Lbe1LRw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dqC+52kofAWJcAYS1g2tq7yEXraGF0LP7Z6j1c3Y4qQgz6oQIpdN3jZ9jiBD763sq
         hMhfTqB0zGAJwxJVHGupK56O4u3go+TYDBhKYRRWEb+VsFy+KYSzEhHonH072sv+Rf
         twboYpc4XJ32EYVakVi3LIV0Z5CP2qt/bab8oOl0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191218025302epcas1p204aea3ef06bd51a22d6f2256d961881c~hV4cMIn4Z0169501695epcas1p2U;
        Wed, 18 Dec 2019 02:53:02 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47d01Q411PzMqYkb; Wed, 18 Dec
        2019 02:52:58 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.81.52419.A8499FD5; Wed, 18 Dec 2019 11:52:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191218025257epcas1p2f0f98db75a84ad49afa7991914692811~hV4Xz1wnc0169101691epcas1p2V;
        Wed, 18 Dec 2019 02:52:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191218025257epsmtrp2e27711cbc5521e5eb8d548d544559c5d~hV4Xy9fB10080900809epsmtrp29;
        Wed, 18 Dec 2019 02:52:57 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-c2-5df9948a59e8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.7F.10238.98499FD5; Wed, 18 Dec 2019 11:52:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191218025257epsmtip1ff3f36f46894ece64fb7700aeb9cc6a7~hV4XhoMv33109831098epsmtip1v;
        Wed, 18 Dec 2019 02:52:57 +0000 (GMT)
Subject: Re: [PATCH 2/9] PM / devfreq: Remove devfreq_get_devfreq_by_phandle
 function
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
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <1967cf03-d1e8-8197-c767-3c8d5f403708@samsung.com>
Date:   Wed, 18 Dec 2019 11:59:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB70231FA16F12ACA3A3C01772EE500@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAJsWRmVeSWpSXmKPExsWy7bCmnm7XlJ+xBjM65Szuz2tltJh/5Byr
        xf9Hr1kt+h+/ZrY4f34Du8XZpjfsFivufmS12PT4GqvF5V1z2Cw+9x5htPj04D+zxYzz+5gs
        Fja1sFusPXKX3WLp9YtMFrcbV7BZtO49wu4g6LFm3hpGj02rOtk8Ni+p99j4bgeTR9+WVYwe
        26/NY/b4vEkugD0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
        J0DXLTMH6AMlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFlgV5xYm5xaV66XnJ+
        rpWhgYGRKVBhQnbGzQOzmQtOqFfM+L2evYFxpUIXIyeHhICJxPGJm5m7GLk4hAR2MEo8ePKI
        HcL5xCjxc8N0FgjnG6PEksONjDAtq3p+MUIk9jJKnPk+kQ3Cec8o8f3ROyaQKmGBcInnC1aC
        2SIC9RLz1kxmBbGZBdawSfz9UAtiswloSex/cYMNxOYXUJS4+uMx2AZeATuJ399awOIsAqoS
        U+4dB5sjKhAmcXJbC1SNoMTJmU9YQGxOgViJzRf3MUHMF5e49WQ+lC0vsf3tHLDnJATOsUvc
        /bQGyOEAclwkHrywgPhGWOLV8S3sELaUxOd3e9kg7GqJlSePsEH0djBKbNl/gRUiYSyxf+lk
        JpA5zAKaEut36UOEFSV2/p7LCLGXT+Ld1x5WiFW8Eh1tQhAlyhKXH9xlgrAlJRa3d7JNYFSa
        heSbWUg+mIXkg1kIyxYwsqxiFEstKM5NTy02LDBGju1NjODUrWW+g3HDOZ9DjAIcjEo8vAYM
        P2OFWBPLiitzDzFKcDArifDe7gAK8aYkVlalFuXHF5XmpBYfYjQFBvZEZinR5HxgXskriTc0
        NTI2NrYwMTQzNTRUEufl+HExVkggPbEkNTs1tSC1CKaPiYNTqoHR0bTQ/Px2U5UtJXFHrjpm
        azw79fjR5E1lYbwP09Y5N18w0j3dK7JiTWTi+4p98p/PPMgxrcz6GPOKa9OK4NXb7sj6vD/3
        YO3DU15+qo+/LahZ3GLJv+vHsucxcpLSb3v2+oXHveYtZv6xhdnelynHNfyM/J30BgWZ/Gff
        GOe+5d/Lyn7rgrKyEktxRqKhFnNRcSIAq+X5GPMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSnG7nlJ+xBnt/CVncn9fKaDH/yDlW
        i/+PXrNa9D9+zWxx/vwGdouzTW/YLVbc/chqsenxNVaLy7vmsFl87j3CaPHpwX9mixnn9zFZ
        LGxqYbdYe+Quu8XS6xeZLG43rmCzaN17hN1B0GPNvDWMHptWdbJ5bF5S77Hx3Q4mj74tqxg9
        tl+bx+zxeZNcAHsUl01Kak5mWWqRvl0CV8bNA7OZC06oV8z4vZ69gXGlQhcjJ4eEgInEqp5f
        jF2MXBxCArsZJbYfnsQOkZCUmHbxKHMXIweQLSxx+HAxSFhI4C2jxNyX8iC2sEC4xPMFK5lA
        ekUEGhklnkz/wQ7iMAtsYJPY8+Q+G8TUSUwSN9fNYANpYRPQktj/4gaYzS+gKHH1x2NGEJtX
        wE7i97cWsDiLgKrElHvHmUBsUYEwiZ1LHjNB1AhKnJz5hAXE5hSIldh8cR9YnFlAXeLPvEvM
        ELa4xK0n86Hi8hLb385hnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFi
        bnFpXrpecn7uJkZwHGtp7mC8vCT+EKMAB6MSD68Bw89YIdbEsuLK3EOMEhzMSiK8tzuAQrwp
        iZVVqUX58UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTAWSnVo6GrpXX8w
        bbrrv8N2F14U3F9Qmll84/BZi0WLFN6nSFm56V8T9ru/fN+mOIHqN92dDzpnPfRsKF214W3D
        g0blwvT7gcHPY+Yt0M+VsNoh7t+zSs4qqvqOxqe3PKVTPhyVuMnbZS1xksFs4VeTz2d91x8T
        MDoq6Fn3pa5c5cSteOmnrNuUWIozEg21mIuKEwE2T4ya3wIAAA==
X-CMS-MailID: 20191218025257epcas1p2f0f98db75a84ad49afa7991914692811
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/17/19 11:33 PM, Leonard Crestez wrote:
> On 17.12.2019 07:51, Chanwoo Choi wrote:
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
>>   drivers/devfreq/exynos-bus.c | 14 ++++++++++++--
>>   include/linux/devfreq.h      |  8 --------
>>   3 files changed, 12 insertions(+), 45 deletions(-)
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
>> index 7f5917d59072..9aac2db956d5 100644
>> --- a/drivers/devfreq/exynos-bus.c
>> +++ b/drivers/devfreq/exynos-bus.c
>> @@ -146,6 +146,16 @@ static int exynos_bus_get_dev_status(struct device *dev,
>>   	return ret;
>>   }
>>   
>> +static struct devfreq *get_parent_devfreq_by_node(struct device_node *np)
>> +{
>> +	struct device_node *node = of_parse_phandle(np, "devfreq", 0);
>> +
>> +	if (!node)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	return devfreq_get_devfreq_by_node(node);
>> +}
> 
> The _by_node suffix here is confusing because it actually fetches a 
> property of the node unlike devfreq_get_devfreq_by_node. Maybe call this 
> get_parent_devfreq_from_node?
> 
> Since it's a static function it could just be called get_parent_devfreq?

OK.

> 
>> +
>>   static void exynos_bus_exit(struct device *dev)
>>   {
>>   	struct exynos_bus *bus = dev_get_drvdata(dev);
>> @@ -353,8 +363,8 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>>   	profile->exit = exynos_bus_passive_exit;
>>   
>>   	/* Get the instance of parent devfreq device */
>> -	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
>> -	if (IS_ERR(parent_devfreq))
>> +	parent_devfreq = get_parent_devfreq_by_node(dev->of_node);
>> +	if (IS_ERR(parent_devfreq)) {
>>   		return -EPROBE_DEFER;
>>   
>>   	passive_data = devm_kzalloc(dev, sizeof(*passive_data), GFP_KERNEL);
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index e3633ae43349..3ed96426302e 100644
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
>> @@ -413,12 +411,6 @@ struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
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
