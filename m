Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 155D5135756
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 11:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgAIKrF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 05:47:05 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:47703 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729456AbgAIKrF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2020 05:47:05 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200109104701epoutp0169705a208b9d6294af8cc65b787983e1~oMik2vv_P1691916919epoutp01M
        for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2020 10:47:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200109104701epoutp0169705a208b9d6294af8cc65b787983e1~oMik2vv_P1691916919epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578566822;
        bh=q8vj0BcK18G8xmFgVWnFYICGZOyJli/3tcnfk3LTJ8A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TFdsY5I+gfk/+k57e9LfSF101gD4ofIdVndQx7rxhaDHGg7LKswmdkc1OZFunCorM
         yxHILJ678fwRwI3ozAiqAAFw7pVHM4Ki2/zmY29XsHcPbbsi3Yg7GEQDH1C3p2v8MJ
         yJ5nfZZSh/zCzhIfmeV8CBjCaJCU9DGEpYJjCcw0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200109104701epcas1p29b302a54bf7ad5b1f453de9d6e965274~oMikScT0K0845108451epcas1p20;
        Thu,  9 Jan 2020 10:47:01 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47tjVB1bSXzMqYkZ; Thu,  9 Jan
        2020 10:46:58 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.0F.48498.2A4071E5; Thu,  9 Jan 2020 19:46:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200109104657epcas1p41d90cb9037af506897e14e15b0ed43a0~oMihCjHQe2909129091epcas1p48;
        Thu,  9 Jan 2020 10:46:57 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200109104657epsmtrp1a2c3598f84f274456c8b5ffb4bc4a7de~oMihBp2MA0405704057epsmtrp1J;
        Thu,  9 Jan 2020 10:46:57 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-29-5e1704a2a1a7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.14.06569.1A4071E5; Thu,  9 Jan 2020 19:46:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200109104657epsmtip1cf3e05328ada9f32d7e46b8409ca6f84~oMigv4SII0075600756epsmtip1A;
        Thu,  9 Jan 2020 10:46:57 +0000 (GMT)
Subject: Re: [PATCH v2 02/11] PM / devfreq: Remove
 devfreq_get_devfreq_by_phandle function
To:     Lukasz Luba <lukasz.luba@arm.com>, robh+dt@kernel.org,
        krzk@kernel.org, heiko@sntech.de, leonard.crestez@nxp.com
Cc:     mark.rutland@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, kgene@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <22cde618-d51e-2d4d-461e-e2d2c1b52af2@samsung.com>
Date:   Thu, 9 Jan 2020 19:54:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <b9a1ebe5-e114-3a6b-6081-c794e1341329@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJsWRmVeSWpSXmKPExsWy7bCmvu4iFvE4g74OTov781oZLeYfOcdq
        8f/Ra1aL/sevmS3On9/AbnG26Q27xYq7H1ktNj2+xmpxedccNovPvUcYLT49+M9sMeP8PiaL
        hU0t7BZrj9xlt1h6/SKTxe3GFWwWrXuPsDsIeqyZt4bRY9OqTjaPzUvqPTa+28Hk0bdlFaPH
        9mvzmD0+b5ILYI/KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLx
        CdB1y8wB+kBJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BZoFecmFtcmpeul5yf
        a2VoYGBkClSYkJ3x4vBZpoKzyhVnJrYyNzD+ke1i5OSQEDCR2HO7hb2LkYtDSGAHo8SFj7dZ
        IZxPjBKLljyFcr4BZbYvYIZpeXblKBtEYi+jxKmXHVD97xkl1nxYygZSJSwQI/Fx4QZWEFtE
        oExiwp6bjCBFzAI3mCQutyxgB0mwCWhJ7H9xA6yBX0BR4uqPx4wgNq+AncSkzcvAmlkEVCR2
        7nsEFhcVCJM4ua0FqkZQ4uTMJywgNqeAtcSr17/B6pkFxCVuPZnPBGHLSzRvnQ119il2iVkd
        8RC2i0T/qrmsELawxKvjW9ghbCmJl/1tUHa1xMqTR8DelBDoYJTYsv8CVIOxxP6lk4EWcAAt
        0JRYv0sfIqwosfP3XEaIvXwS7772sIKUSAjwSnS0CUGUKEtcfnCXCcKWlFjc3sk2gVFpFpJv
        ZiH5YBaSD2YhLFvAyLKKUSy1oDg3PbXYsMAIObo3MYKTt5bZDsZF53wOMQpwMCrx8DIoicUJ
        sSaWFVfmHmKU4GBWEuE9egMoxJuSWFmVWpQfX1Sak1p8iNEUGNgTmaVEk/OBmSWvJN7Q1MjY
        2NjCxNDM1NBQSZyX48fFWCGB9MSS1OzU1ILUIpg+Jg5OqQZGn2uV/29Iz5SvZUlbrvWV6eJ9
        na9cUvL3bknN2cs0f5PrYcG1089F/9/B9zk9e79h1H3D1Y52F7oNHieu8711yCtHvqY5MGvj
        YWfR9I8H/vQKajPr8B95/Dvm49nP71KC1/DX30x4Hmh4Y+r+irB09V2v+uST66wj3m94z68q
        538rLi0vycxTiaU4I9FQi7moOBEAnoLKzfQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSnO5CFvE4g9tXdCzuz2tltJh/5Byr
        xf9Hr1kt+h+/ZrY4f34Du8XZpjfsFivufmS12PT4GqvF5V1z2Cw+9x5htPj04D+zxYzz+5gs
        Fja1sFusPXKX3WLp9YtMFrcbV7BZtO49wu4g6LFm3hpGj02rOtk8Ni+p99j4bgeTR9+WVYwe
        26/NY/b4vEkugD2KyyYlNSezLLVI3y6BK+PF4bNMBWeVK85MbGVuYPwj28XIySEhYCLx7MpR
        ti5GLg4hgd2MElP/fWaGSEhKTLt4FMjmALKFJQ4fLoaoecsoMefEHiaQGmGBGImPCzewgtgi
        AmUSm9YtZwcpYha4wSRx8PwMVoiOD4wS3d9nM4JUsQloSex/cYMNxOYXUJS4+uMxWJxXwE5i
        0uZlYJNYBFQkdu57BBYXFQiT2LnkMRNEjaDEyZlPWEBsTgFriVevf4PVMwuoS/yZd4kZwhaX
        uPVkPhOELS/RvHU28wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL
        89L1kvNzNzGC41hLawfjiRPxhxgFOBiVeHgZlMTihFgTy4orcw8xSnAwK4nwHr0BFOJNSays
        Si3Kjy8qzUktPsQozcGiJM4rn38sUkggPbEkNTs1tSC1CCbLxMEp1cAoxKLu+mJ/QL8pg9OO
        oxfW//qwcGq27BTnjyx/fMQOpZ4Onhj65flN97vteSpF7kq39wUcUkqyddrsZqIrzFhUuerP
        sQnJPTVZbJK7mz7LmJ5ewGL/42FFeX91Cv+0ne7LCzVYtNY4hGtemqvWpDPFlu/HhvrSJR38
        z1kVFkgynA1peRO+eKYSS3FGoqEWc1FxIgAEWzda3wIAAA==
X-CMS-MailID: 20200109104657epcas1p41d90cb9037af506897e14e15b0ed43a0
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
        <b9a1ebe5-e114-3a6b-6081-c794e1341329@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/9/20 7:37 PM, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 12/20/19 12:24 AM, Chanwoo Choi wrote:
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
>>   drivers/devfreq/devfreq.c    | 35 -----------------------------------
>>   drivers/devfreq/exynos-bus.c | 12 +++++++++++-
>>   include/linux/devfreq.h      |  8 --------
>>   3 files changed, 11 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index cb8ca81c8973..c3d3c7c802a0 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -991,48 +991,13 @@ struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
>>         return ERR_PTR(-ENODEV);
>>   }
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
>> -    struct device_node *node;
>> -    struct devfreq *devfreq;
>> -
>> -    if (!dev)
>> -        return ERR_PTR(-EINVAL);
>> -
>> -    if (!dev->of_node)
>> -        return ERR_PTR(-EINVAL);
>> -
>> -    node = of_parse_phandle(dev->of_node, "devfreq", index);
>> -    if (!node)
>> -        return ERR_PTR(-ENODEV);
>> -
>> -    devfreq = devfreq_get_devfreq_by_node(node);
>> -    of_node_put(node);
>> -
>> -    return devfreq;
>> -}
>> -
>>   #else
>>   struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
>>   {
>>       return ERR_PTR(-ENODEV);
>>   }
>> -
>> -struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
>> -{
>> -    return ERR_PTR(-ENODEV);
>> -}
>>   #endif /* CONFIG_OF */
>>   EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_node);
>> -EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_phandle);
>>     /**
>>    * devm_devfreq_remove_device() - Resource-managed devfreq_remove_device()
>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>> index 7f5917d59072..1bc4e3c81115 100644
>> --- a/drivers/devfreq/exynos-bus.c
>> +++ b/drivers/devfreq/exynos-bus.c
>> @@ -86,6 +86,16 @@ static int exynos_bus_get_event(struct exynos_bus *bus,
>>       return ret;
>>   }
>>   +static struct devfreq *exynos_bus_get_parent_devfreq(struct device_node *np)
>> +{
>> +    struct device_node *node = of_parse_phandle(np, "devfreq", 0);
>> +
>> +    if (!node)
>> +        return ERR_PTR(-ENODEV);
>> +
>> +    return devfreq_get_devfreq_by_node(node);
>> +}
>> +
>>   /*
>>    * devfreq function for both simple-ondemand and passive governor
>>    */
>> @@ -353,7 +363,7 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>>       profile->exit = exynos_bus_passive_exit;
>>         /* Get the instance of parent devfreq device */
>> -    parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
>> +    parent_devfreq = exynos_bus_get_parent_devfreq(dev->of_node);
>>       if (IS_ERR(parent_devfreq))
>>           return -EPROBE_DEFER;
>>   
> 
> These changes won't apply, probably I need some base for it.

I developed it on devfreq-next branch[1]
[1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-next

And I try to apply these patchset to linux-next[2] with tags/next-20200109.
But, patch10/11 of deviceetree has some merge conflict
because patch[3] related to exynos-bus was merged.
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/
[3] https://patchwork.kernel.org/cover/11303235/
    - [v2,0/2] Exynos5422: fix bus related OPPs for Odroid XU3/XU4/HC1

On next version, I'll rebase it on latest patches.

> 
> Regards,
> Lukasz
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
