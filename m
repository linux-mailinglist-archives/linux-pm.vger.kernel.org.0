Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E52F911817C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 08:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfLJHrA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 02:47:00 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:12785 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLJHq7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 02:46:59 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191210074656epoutp04be460cb501a5ba51982e7580d474708c~e8uxEtpXO0307003070epoutp048
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 07:46:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191210074656epoutp04be460cb501a5ba51982e7580d474708c~e8uxEtpXO0307003070epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575964016;
        bh=ai8509VNNNtg7PGRnPyCmwNZWYdJnA3gZTpwHNd5lps=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qAyRZKwWEBlvZ/McDot32HUDVmY+bYtQ3kE7gefhugoVHN8FiJ1610vgzraw+K6TV
         JiJVZJSLFh7ggywev9cSU4IZ+gatjqhNgq921gJnxOh0ZikQsXbo/Jdj3/B5t/5+Ef
         KxbttGHfcRf38Cvzq4eKWK/pBayOGevBJreN4jMM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191210074655epcas1p13b9d26ccfbc8479be65da2b76c65eb9c~e8uwypRfr2849828498epcas1p1k;
        Tue, 10 Dec 2019 07:46:55 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47XBwD19bgzMqYm3; Tue, 10 Dec
        2019 07:46:52 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.53.48019.A6D4FED5; Tue, 10 Dec 2019 16:46:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191210074649epcas1p2a8c7a93753c45988558fe7e949758a70~e8uq3W_6X2887328873epcas1p2B;
        Tue, 10 Dec 2019 07:46:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191210074649epsmtrp1f117c9a11cc132cc00183cff65148b8a~e8uq2pLnT2121421214epsmtrp1p;
        Tue, 10 Dec 2019 07:46:49 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-73-5def4d6a1565
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.68.10238.96D4FED5; Tue, 10 Dec 2019 16:46:49 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191210074649epsmtip25dbe9c54d08beaf9b6c93e0d189400a2~e8uqmtnDd2402124021epsmtip2m;
        Tue, 10 Dec 2019 07:46:49 +0000 (GMT)
Subject: Re: [PATCH 1/4] PM / devfreq: reuse system workqueue machanism
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9926005a-c030-a823-fd65-6b8578e39218@samsung.com>
Date:   Tue, 10 Dec 2019 16:53:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <6ead2998-ebe1-704b-7d89-3b0cf8beca70@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTut7vdXZfLX/N1WlDrRoTG0quurpXLnjOyEgKDyOziLrrci90Z
        WREV5rP3SxtagyjLHpZZLSsEG4VSWViRlVBkZOUDzB4SPXa9i/zv+33nO3znO79DERovqaUs
        djfvsnNWmlTJr9+N0es3rhjIivdVhrJXquoVrHewSsG2t19Wsg939SrZjqZqkv2y14/Yi/4u
        Jftq51kylUprqCsj0/Y11qG0Lw2TMoi1+fPyeM7Mu3S8PcdhtthzU+jlq7MXZRtmxTN6Jpmd
        TevsnI1PoRenZ+iXWqyBCWjdJs5aEKAyOEGg44zzXI4CN6/LcwjuFJp3mq3OZOdMgbMJBfbc
        mTkO2xwmPj7BEBBuyM/7tbtd5hyK3rzvQR/agZ6Fl6MQCnASfC37hsqRitJgH4J3f9qU0mMQ
        wfDz1mDlGwLvb7+8HFEjLSWeUIm/g+BMbU9QNBBoHy4hRFE4NsGdq5miRQTWQ6/vNCFqCHxC
        Br3HHivEAoljobnnBSniMDwFnv14h0SsxkZ4f61nhJfjaXD2Q79SxJE4E1qvFwU146H1eLdc
        xCF4Phw98JkQMYGj4WX3SZmEJ8ONvuoRY8ADJAzX9iml0IvhbfGQTMLh8Ol+Y5DXwsf9xUG8
        Fc61+kmpuRRBY7M0NeBEaD59WCamJHAM1DfFSfQUuPmzBknG46D/6x6FtC01lBZrJMlU6HjT
        FbSdAKdKysgDiPaMiuMZFcEzKoLnv5kXyetQFO8UbLm8wDiTRv92Axq5zljWh24/Sm9BmEJ0
        qNqb2p+lUXCbhEJbCwKKoCPU94sDlNrMFW7hXY5sV4GVF1qQIbDtg4Q2MscRuHW7O5sxJCQm
        JrJJzCwDw9DRaurHkywNzuXcfD7PO3nXvz4ZFaLdgYo2HMlk8ZDuhknd1fmgTXd+SY12xkRr
        0dO7ay7ek71elXHtVmEY0aa6Kk81mbsqiXrv91pTeNT0zTH+McmWXQtMOOGC53FnRcmEGUbL
        2DF0EdM551PTwu3Mthajh5/dTKl8D+f2d5S+r1h3af3EldtVIRVpy4yDHtnGM8mRh14N03Ih
        j2NiCZfA/QWa7g0iswMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXjfT932swfSrkhYbZ6xntVjwaQar
        xfnzG9gtzja9Ybe4vGsOm8Xn3iOMFmuP3GW3uN24gs2Bw2PTqk42j74tqxg9Pm+SC2CO4rJJ
        Sc3JLEst0rdL4Mr423qeqeCLeEXfmbeMDYxXhbsYOTgkBEwk2mfxdDFycQgJ7GaUuNvwiamL
        kRMoLikx7eJRZogaYYnDh4shat4ySjz4vpgNJC4s4C6xd3MYSLmIgK7Emx1LmUFqmAUWMEnM
        vzmRBaJhLZPEjO8TWEGq2AS0JPa/uMEGYvMLKEpc/fGYEcTmFbCTeLr1BVicRUBVYsXzd+wg
        tqhAmMTOJY+ZIGoEJU7OfMICYnMK2EtMnfCaGcRmFlCX+DPvEpQtLnHryXwmCFteYvvbOcwT
        GIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4hLc0d
        jJeXxB9iFOBgVOLhXeDwLlaINbGsuDL3EKMEB7OSCO/xNqAQb0piZVVqUX58UWlOavEhRmkO
        FiVx3qd5xyKFBNITS1KzU1MLUotgskwcnFINjLMXdUSvef8/41329ojlSy8b7Cwrzv4bovRP
        /9ckoe/hX/41vL6kf8d17lobvh3Pn9x6cJpzis3ei/2Bz/P/8qlPeu/Gdks3YdGZwuzjyZ17
        W3Nm2Yhae2zhb8r6r/FDkyfk1pyi9Sl7mlKfn5QK7ki7KlkfMK03sWXDHq+At8st18hODJmg
        EKrEUpyRaKjFXFScCADfdg1UnQIAAA==
X-CMS-MailID: 20191210074649epcas1p2a8c7a93753c45988558fe7e949758a70
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209144441eucas1p16945780c1a1ff3302a233414ae6aace2
References: <20191209144425.13321-1-k.konieczny@samsung.com>
        <CGME20191209144441eucas1p16945780c1a1ff3302a233414ae6aace2@eucas1p1.samsung.com>
        <20191209144425.13321-2-k.konieczny@samsung.com>
        <2eab8a20-1701-94dc-410a-bb072a5f5b4e@samsung.com>
        <6ead2998-ebe1-704b-7d89-3b0cf8beca70@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/10/19 4:28 PM, Kamil Konieczny wrote:
> On 10.12.2019 02:41, Chanwoo Choi wrote:
>> On 12/9/19 11:44 PM, Kamil Konieczny wrote:
>>> There is no need for creating another workqueue, it is enough
>>> to reuse system_freezable_power_efficient one.
>>>
>>> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
>>> ---
>>>  drivers/devfreq/devfreq.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 46a7ff7c2994..955949c6fc1f 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -1532,11 +1532,11 @@ static int __init devfreq_init(void)
>>>  		return PTR_ERR(devfreq_class);
>>>  	}
>>>  
>>> -	devfreq_wq = create_freezable_workqueue("devfreq_wq");
>>> +	devfreq_wq = system_freezable_power_efficient_wq;
>>
>> It affect the behaviors of whole device drivers using devfreq subsystem.
>> It is not good to change the workqueue type without any reasonable
>> data like experiment result, power-consumption result and performance
>> result for almost device drivers using devfreq subsystem.
>>
>> Are there any problem or any benefit to change workqueue type?
> 
> The workqueue is freezable with additional capability of 'power_efficient',
> it is already developed by linux community so why not reuse it ?

As you agreed below, why don't you suggest the any reasonable test result
with this patch? As I commented, it affects the all device drivers. 
It is necessary to suggest the test result on multiple scenarios
in order to prevent the any power-consumption and performance regression.
It is not easy to change them without any data.

Frankly, if you test almost scenarios and suggest the reasonable result
that anyone can understand, like there are never difference
between "create_freezable_workqueue("devfreq_wq");" and system_freezable_power_efficient_wq.
But you don't suggest any data.

- The original devfreq_wq include the only work related to devfreq.
- system_freezable_power_efficient_wq include the all works registered
from both other subsystem and device drivers in linux kernel.

> 
>> Actually, it is not simple to change the like just one device driver
>> because devfreq subsytem is very important for both performance
>> and power-consumption.
> 
> I agree. The name of this wq promises what you want, both freezable
> and power efficiency.
> 
>> If you hope to change the feature related to both performance 
>> and power-consumption, please suggest the reasonable data
>> with fundamental reason.
>>
>> So, I can't agree it.
>>
>>
>>>  	if (!devfreq_wq) {
>>>  		class_destroy(devfreq_class);
>>> -		pr_err("%s: couldn't create workqueue\n", __FILE__);
>>> -		return -ENOMEM;
>>> +		pr_err("%s: system_freezable_power_efficient_wq isn't initialized\n", __FILE__);
>>> +		return -EINVAL;
>>>  	}
>>>  	devfreq_class->dev_groups = devfreq_groups;
>>>  
>>>
>>
>>
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
