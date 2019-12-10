Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 717AE1183AE
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 10:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfLJJgB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 04:36:01 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:20654 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfLJJgA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 04:36:00 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191210093557epoutp04406ec4b089179c74c3dceabef3f0592d~e_N800N1I2620926209epoutp04r
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 09:35:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191210093557epoutp04406ec4b089179c74c3dceabef3f0592d~e_N800N1I2620926209epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575970557;
        bh=S/zcAwknwHag4hPCqjtT6WQekQdAA80vjLRcE8LWAp4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LZuhUqL7T5RkowSsjFYg9BVm1Z1nncir7cRagsw76lp99oRoGlmMHk6RmUp+VMqAi
         fE1IA6i92xCSiT/GTj7QzFzLTw5NSeUL/9OX2eLMhYjda8pKi2ZBmmruPC176vqTP8
         oVOkW4piLgCxfpF15fEP4uDdsiAiqujyE80HIqH0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191210093556epcas1p1960e9dc4ab635df8eedac28b2832c497~e_N8RS-ui1079610796epcas1p16;
        Tue, 10 Dec 2019 09:35:56 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47XFL23XDTzMqYkn; Tue, 10 Dec
        2019 09:35:54 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.8E.48019.AF66FED5; Tue, 10 Dec 2019 18:35:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191210093553epcas1p37d23659cdd8782d951c4e004d300fc0f~e_N5kAIHH2199621996epcas1p3S;
        Tue, 10 Dec 2019 09:35:53 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191210093552epsmtrp1be3673b26ce9f3320c8f4d6b00e32080~e_N4p4EFo0605106051epsmtrp1B;
        Tue, 10 Dec 2019 09:35:52 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-08-5def66faddf5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.65.06569.8F66FED5; Tue, 10 Dec 2019 18:35:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191210093552epsmtip2b5edd78e8d7497be702d5b9873b16ebd~e_N4XdZ-C1063110631epsmtip2F;
        Tue, 10 Dec 2019 09:35:52 +0000 (GMT)
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
Message-ID: <6a8daabc-4a18-36de-8070-77803271e681@samsung.com>
Date:   Tue, 10 Dec 2019 18:42:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1e6f7bcd-78ef-17e2-c470-a546d58c70fa@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29k5O0arr6n5uh+ppwskmTvp6iiZdjcyEQKDSuykJyfuxs4m
        drEsS81aN7vosBqEVOuqiZlUlkmyJE1WYFeiu6YN7IIVRduOkv+e9/K8z/t830sTqlOUms43
        WgWLkdcz1Dh5072Zmphfm7xZGu9fNVdffYXknEPVJNfdfVXBPdw1oOA8LbUU99XejrhL7S8V
        3POd56gUOrXBtZdKPdDoQqlfG6ZkEGsL5usEPlewRArGHFNuvjEviVm5Ontxtnauho1hE7h5
        TKSRNwhJzJK0jJhl+XrfBkxkIa+3+VIZvCgysQvmW0w2qxCpM4nWJEYw5+rNCebZIm8Qbca8
        2TkmQyKr0czR+ho3FOh2Xe4lzeURRQ9KNSWoLbwSBdGA46G6pV5WicbRKtyMwHH/nEIKhhAM
        u98iKfiB4Mirn9Qo5X1VHyUVbiGob+8coXgRvLE/9A2j6WC8HG5dy/QTQnAMDDTXEf4eAp+S
        wcDxR6S/QOFoaP3UG5g6EUfBk2G/HE0r8QJ4fULpT8vxdHBW2mV+HIozwd20G/mxEk8Cd807
        uR8H4WQ4ar8dwAQOg2fvTsskHAHXB2sDuoC9FNRefBzYDfAS+OM0SWaCob+jUSFhNfQdLBvB
        W+G8u52SuBUIGlulnQHHQWtdVWAOgWfClZZYKR0FN36fRJLuBPjyfT8pSSmhokwltUwFz+uX
        MgmHw5nyvdQhxDjGuHGMceAY48DxX8yJ5C40WTCLhjxBZM3xY/+6AQVuM5prRje70toQphEz
        XulM+ZKlIvlCcbOhDQFNMCHKjjJfSpnLb94iWEzZFpteENuQ1vfYhwl1aI7Jd+lGazarnRMX
        F8fFs3O1LMuEKenhniwVzuOtQoEgmAXLKE9GB6lLUEt5UbXXuezYmhd3t8UX15H93VU4+M3n
        86XMtHQyvTs8NnPpxo89xe6zybZ1sz5QqR0LucGTz3oG6jzvJ3ZuT8txpdxVDTr6/3b+uZBc
        Y1ox9annx3rF929U4p0dQyHppasu7TF7aid0NfUtn3F5S8iTVp0ttNeVYE8kP4bt64r6vIiR
        izqejSYsIv8PbuYWX7EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJXvdH2vtYg9XfFS02zljParHg0wxW
        i/PnN7BbnG16w25xedccNovPvUcYLdYeuctucbtxBZsDh8emVZ1sHn1bVjF6fN4kF8AcxWWT
        kpqTWZZapG+XwJXRtO4Ga0G7fMWpZoMGxkOSXYycHBICJhJPJ79k62Lk4hAS2M0ocb5pKyNE
        QlJi2sWjzF2MHEC2sMThw8UQNW8ZJR4f+MEKEhcWcJfYuzkMpFxEQFfizY6lzCA1zAILmCTm
        35zIApIQEpjOLLH1VQWIzSagJbH/xQ02EJtfQFHi6o/HjCBzeAXsJB5M5wUJswioSizo6mUC
        sUUFwiR2LnkMZvMKCEqcnPkEbCSngL3ElN59YDazgLrEn3mXmCFscYlbT+YzQdjyEtvfzmGe
        wCg8C0n7LCQts5C0zELSsoCRZRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnD8aGnt
        YDxxIv4QowAHoxIPr4fdu1gh1sSy4srcQ4wSHMxKIrzH24BCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeeXzj0UKCaQnlqRmp6YWpBbBZJk4OKUaGCecK58zxWmP7gpmiYfqJ/iF9tW/4daX1lzD
        LpX401XtdrLNnKfORmUvwuKntqssEsiXSji++dNtlrZZ/Cd0ImYnLWqM+7tJi+tM3MzrXLt4
        lpx88st3HVPbobsXnDlllD7PuCZ7zCzm6iylS5LvloR6/V/P3KK4QDwt7r7v1fn6K5MSVgWr
        RCmxFGckGmoxFxUnAgAl1itXmwIAAA==
X-CMS-MailID: 20191210093553epcas1p37d23659cdd8782d951c4e004d300fc0f
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
        <9926005a-c030-a823-fd65-6b8578e39218@samsung.com>
        <1e6f7bcd-78ef-17e2-c470-a546d58c70fa@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/10/19 6:28 PM, Kamil Konieczny wrote:
> Hi Chanwoo,
> 
> On 10.12.2019 08:53, Chanwoo Choi wrote:
>> On 12/10/19 4:28 PM, Kamil Konieczny wrote:
>>> On 10.12.2019 02:41, Chanwoo Choi wrote:
>>>> On 12/9/19 11:44 PM, Kamil Konieczny wrote:
>>>>> There is no need for creating another workqueue, it is enough
>>>>> to reuse system_freezable_power_efficient one.
>>>>>
>>>>> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
>>>>> ---
>>>>>  drivers/devfreq/devfreq.c | 6 +++---
>>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>> index 46a7ff7c2994..955949c6fc1f 100644
>>>>> --- a/drivers/devfreq/devfreq.c
>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>> @@ -1532,11 +1532,11 @@ static int __init devfreq_init(void)
>>>>>  		return PTR_ERR(devfreq_class);
>>>>>  	}
>>>>>  
>>>>> -	devfreq_wq = create_freezable_workqueue("devfreq_wq");
>>>>> +	devfreq_wq = system_freezable_power_efficient_wq;
>>>>
>>>> It affect the behaviors of whole device drivers using devfreq subsystem.
>>>> It is not good to change the workqueue type without any reasonable
>>>> data like experiment result, power-consumption result and performance
>>>> result for almost device drivers using devfreq subsystem.
>>>>
>>>> Are there any problem or any benefit to change workqueue type?
>>>
>>> The workqueue is freezable with additional capability of 'power_efficient',
>>> it is already developed by linux community so why not reuse it ?
>>
>> As you agreed below, why don't you suggest the any reasonable test result
>> with this patch? As I commented, it affects the all device drivers. 
>> It is necessary to suggest the test result on multiple scenarios
>> in order to prevent the any power-consumption and performance regression.
>> It is not easy to change them without any data.
>>
>> Frankly, if you test almost scenarios and suggest the reasonable result
>> that anyone can understand, like there are never difference
>> between "create_freezable_workqueue("devfreq_wq");" and system_freezable_power_efficient_wq.
>> But you don't suggest any data.
> 
> I agree about tests data needed for deciding about change. As I already wrote in other
> letter, I do not have such tests procedures, so if you have them and you may share
> them with me or Marek, I can run them and gather tests results.
> 
>> - The original devfreq_wq include the only work related to devfreq.
>> - system_freezable_power_efficient_wq include the all works registered
>> from both other subsystem and device drivers in linux kernel.
> 
> I do not know that good system wq, devfreq_wq have only one work item so
> imho it is not beneficial to use separate wq. Seperate wq can be good
> during debugging problems with wq.

No, devfreq_wq has not ony one work item. If one target use the multiple
devfreq device with simple_ondemand governor, devfreq_wq has the 
the multiple work item. It depends on the number of devfreq device
with simple_ondemand governor.

> 
>>>> Actually, it is not simple to change the like just one device driver
>>>> because devfreq subsytem is very important for both performance
>>>> and power-consumption.
>>>
>>> I agree. The name of this wq promises what you want, both freezable
>>> and power efficiency.
>>>
>>>> If you hope to change the feature related to both performance 
>>>> and power-consumption, please suggest the reasonable data
>>>> with fundamental reason.
>>>>
>>>> So, I can't agree it.
>>>>
>>>>
>>>>>  	if (!devfreq_wq) {
>>>>>  		class_destroy(devfreq_class);
>>>>> -		pr_err("%s: couldn't create workqueue\n", __FILE__);
>>>>> -		return -ENOMEM;
>>>>> +		pr_err("%s: system_freezable_power_efficient_wq isn't initialized\n", __FILE__);
>>>>> +		return -EINVAL;
>>>>>  	}
>>>>>  	devfreq_class->dev_groups = devfreq_groups;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
