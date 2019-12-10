Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78BB311838D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 10:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfLJJ2g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 04:28:36 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47658 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfLJJ2d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 04:28:33 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191210092830euoutp01115e2d9bd626df2516f323f6b5acdbb2~e_HcowCw73212432124euoutp018
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 09:28:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191210092830euoutp01115e2d9bd626df2516f323f6b5acdbb2~e_HcowCw73212432124euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575970110;
        bh=dPlPWkaADTo1etmALgGe0F2k3QnnsfFpqhDu+iZww9c=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=g6KFfqG/fzmS5LQxe/nyv+5JHN5VrgcfoPh0SeLmmQotHKEKFOzUXxb/mdFAWNfjs
         o9IB80XWKV2NOn1Tut6Y4TyMUPGEuOIutCOXiIIEExBl0/eTj9x7l7nceXSaWGm6YR
         QTwRjgYX82zPCvsETcBpJqeb+JJLk7QrnpVsiXz0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191210092829eucas1p21ca8e3e5c0805c982a8b003d512b6c5a~e_HcO09Do3210732107eucas1p25;
        Tue, 10 Dec 2019 09:28:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AA.3D.60679.D356FED5; Tue, 10
        Dec 2019 09:28:29 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191210092829eucas1p12f2dae6c291fb3173af9688d1cdd9d43~e_Hb8_Fb51932419324eucas1p1y;
        Tue, 10 Dec 2019 09:28:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191210092829eusmtrp143a1262e10719f6068811c7123662e58~e_Hb8OJEY1354713547eusmtrp1Z;
        Tue, 10 Dec 2019 09:28:29 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-9d-5def653d21e4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 64.1C.07950.D356FED5; Tue, 10
        Dec 2019 09:28:29 +0000 (GMT)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191210092829eusmtip2386e210bd436dbc8262d4ec07a9c88ac~e_HberUUq0838608386eusmtip2N;
        Tue, 10 Dec 2019 09:28:29 +0000 (GMT)
Subject: Re: [PATCH 1/4] PM / devfreq: reuse system workqueue machanism
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Kamil Konieczny <k.konieczny@samsung.com>
Message-ID: <1e6f7bcd-78ef-17e2-c470-a546d58c70fa@samsung.com>
Date:   Tue, 10 Dec 2019 10:28:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9926005a-c030-a823-fd65-6b8578e39218@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTcRTG+e/ebdfl9O80dtKRtVAqUNMKLmlmYSTRh4KIjMRWXlRyKpsv
        WRQW4ctQ0yXmxPIlcDrn2yYaQyGnKGpmkmgkvaAzSzQLl2Kmy9tV8tvD73kO5zxwKEJSxfek
        4hNTGFWiIkEuEJFtvSuv/Y4zC1GH+pcC6ZbSJj49bp/h08PDzUJ66MGckH5rKRfQi/k9iG7o
        +SCkJ+7XCsKoCJMhVxBR0GpAEYum3eeJK6KQGCYhPo1RBYReE8UVtjSgZK3sli5XmIkeSTXI
        iQJ8BMYKh0kNElESXIug2lYpZA0JtiNwjIo4YxGBfqye2JoY+GTkcYYeQY1uBHET8wjezYdr
        EEW54zPQab7EYg+8H3Rro4jNE/gZD+ZK3vBZQ4ADoGuon2TzYhwKv5eDWExiHzAbrIjFO/Fl
        GPylYLEYu0G/zkay2gmfgLq6r/+2ElgK720VPE57Q/t8OcGuAmwSgrZ1YfPmcOisGRVy2h1m
        +1o3tQwGH+eRnE6H6aoCITf8EMHn7J+bRjB0943w2YMIfACaLAEcPglPHV8IFgN22Wjuxt3g
        Atq2J5tYDDlZEi7tAzMDeTxOe4HG0cgvRPKybc3KtrUp29am7P/eSkQakJRJVStjGXVQIpPu
        r1Yo1amJsf43kpQmtPE4g+t99hfI8ue6FWEKyZ3FlWHfoyR8RZo6Q2lFQBFyD3Ff1gYSxygy
        bjOqpGhVagKjtiIvipRLxYerv0VJcKwihbnJMMmMasvlUU6emci8NK+X6T46vFaPNU8y8Uaj
        o9nVMF1cctT/ztyi/a7tarB3x/hzvc8ez6jlHdFT+4p8dzXWE/khY8pube2UxT5bcNFsndwr
        nVg9V9i7Umwt8O5obb5nOqUd7ZK1O/td0P3IrhrLiV7z7y/1jlw//dJ3ps1c5GaMzHWtoF+d
        demVk+o4ReBBQqVW/AV6vpy5NAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xe7q2qe9jDXrXSVtsnLGe1eL6l+es
        FufPb2C3ONv0ht3i8q45bBafe48wWqw9cpfd4nbjCjYHDo9NqzrZPPq2rGL0+LxJLoA5Ss+m
        KL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9jwsa1jAWT
        ZCpmdrI3MPaLdzFyckgImEicur+GqYuRi0NIYCmjREPjeVaIhLRE4+nVTBC2sMSfa11sILaQ
        wGtGib8T/LsYOTiEBdwl9m4OAwmLCGhIzPx7hRFkDrPAAiaJ+TcnskAMfcQk0btjJdhQNgF9
        iYNnT7KANPMK2En8+m4EEmYRUJXYvOoQI4gtKhAh8Xz7DTCbV0BQ4uTMJywgNqeAvcTKlS/A
        4swC6hJ/5l1ihrDFJW49mc8EYctLbH87h3kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5
        xUZ6xYm5xaV56XrJ+bmbGIFxtu3Yzy07GLveBR9iFOBgVOLhXeDwLlaINbGsuDL3EKMEB7OS
        CO/xNqAQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wNTQF5JvKGpobmFpaG5sbmxmYWSOG+H
        wMEYIYH0xJLU7NTUgtQimD4mDk6pBsaN17+Jn92z8pf3pfnGn1TZ7xf+Xlb+Via19un3iQf/
        ZfVw/Kn92yU6yUs3XGC2TuEHa8E9c5udlsqGOt1Yc/SJvHzu6sWXJmhe2/Ja18VnF7dNUMq1
        e9OSDsp/F7J+PEPFK1Fl81Ux765I2Va5n10smps82Qz+y7BJFpQdqHl0gLNvnZDOMgElluKM
        REMt5qLiRABbcJqCyQIAAA==
X-CMS-MailID: 20191210092829eucas1p12f2dae6c291fb3173af9688d1cdd9d43
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191209144441eucas1p16945780c1a1ff3302a233414ae6aace2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191209144441eucas1p16945780c1a1ff3302a233414ae6aace2
References: <20191209144425.13321-1-k.konieczny@samsung.com>
        <CGME20191209144441eucas1p16945780c1a1ff3302a233414ae6aace2@eucas1p1.samsung.com>
        <20191209144425.13321-2-k.konieczny@samsung.com>
        <2eab8a20-1701-94dc-410a-bb072a5f5b4e@samsung.com>
        <6ead2998-ebe1-704b-7d89-3b0cf8beca70@samsung.com>
        <9926005a-c030-a823-fd65-6b8578e39218@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 10.12.2019 08:53, Chanwoo Choi wrote:
> On 12/10/19 4:28 PM, Kamil Konieczny wrote:
>> On 10.12.2019 02:41, Chanwoo Choi wrote:
>>> On 12/9/19 11:44 PM, Kamil Konieczny wrote:
>>>> There is no need for creating another workqueue, it is enough
>>>> to reuse system_freezable_power_efficient one.
>>>>
>>>> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
>>>> ---
>>>>  drivers/devfreq/devfreq.c | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>> index 46a7ff7c2994..955949c6fc1f 100644
>>>> --- a/drivers/devfreq/devfreq.c
>>>> +++ b/drivers/devfreq/devfreq.c
>>>> @@ -1532,11 +1532,11 @@ static int __init devfreq_init(void)
>>>>  		return PTR_ERR(devfreq_class);
>>>>  	}
>>>>  
>>>> -	devfreq_wq = create_freezable_workqueue("devfreq_wq");
>>>> +	devfreq_wq = system_freezable_power_efficient_wq;
>>>
>>> It affect the behaviors of whole device drivers using devfreq subsystem.
>>> It is not good to change the workqueue type without any reasonable
>>> data like experiment result, power-consumption result and performance
>>> result for almost device drivers using devfreq subsystem.
>>>
>>> Are there any problem or any benefit to change workqueue type?
>>
>> The workqueue is freezable with additional capability of 'power_efficient',
>> it is already developed by linux community so why not reuse it ?
> 
> As you agreed below, why don't you suggest the any reasonable test result
> with this patch? As I commented, it affects the all device drivers. 
> It is necessary to suggest the test result on multiple scenarios
> in order to prevent the any power-consumption and performance regression.
> It is not easy to change them without any data.
> 
> Frankly, if you test almost scenarios and suggest the reasonable result
> that anyone can understand, like there are never difference
> between "create_freezable_workqueue("devfreq_wq");" and system_freezable_power_efficient_wq.
> But you don't suggest any data.

I agree about tests data needed for deciding about change. As I already wrote in other
letter, I do not have such tests procedures, so if you have them and you may share
them with me or Marek, I can run them and gather tests results.

> - The original devfreq_wq include the only work related to devfreq.
> - system_freezable_power_efficient_wq include the all works registered
> from both other subsystem and device drivers in linux kernel.

I do not know that good system wq, devfreq_wq have only one work item so
imho it is not beneficial to use separate wq. Seperate wq can be good
during debugging problems with wq.

>>> Actually, it is not simple to change the like just one device driver
>>> because devfreq subsytem is very important for both performance
>>> and power-consumption.
>>
>> I agree. The name of this wq promises what you want, both freezable
>> and power efficiency.
>>
>>> If you hope to change the feature related to both performance 
>>> and power-consumption, please suggest the reasonable data
>>> with fundamental reason.
>>>
>>> So, I can't agree it.
>>>
>>>
>>>>  	if (!devfreq_wq) {
>>>>  		class_destroy(devfreq_class);
>>>> -		pr_err("%s: couldn't create workqueue\n", __FILE__);
>>>> -		return -ENOMEM;
>>>> +		pr_err("%s: system_freezable_power_efficient_wq isn't initialized\n", __FILE__);
>>>> +		return -EINVAL;
>>>>  	}
>>>>  	devfreq_class->dev_groups = devfreq_groups;

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

