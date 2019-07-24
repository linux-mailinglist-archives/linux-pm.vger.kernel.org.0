Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7427272D3B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 13:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfGXLQN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 07:16:13 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:33023 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfGXLQN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 07:16:13 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190724111610epoutp0408a0b153e4d441b55586f6be25dc0b3f~0U6xWXMoq1531615316epoutp04X
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 11:16:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190724111610epoutp0408a0b153e4d441b55586f6be25dc0b3f~0U6xWXMoq1531615316epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563966970;
        bh=5jLiBEeviujOy+8idoYcb2/EqToOJc5TZTqGgKL5PwU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mhMdEgpMUMO+PnrDb7emRcuOzfJC3VkNejAXYdZDgj8twNuVR75iOVZgtlYnNQ6Zw
         ZUjUUs2VmbLJCkvDZEMuDR/BsS/VqhzywKjt1fLVplJptSXCm8hAm77O96Ah0dKGSm
         4LdQdEQmj4U3yvX0+uLC4dcwf6FN5rs/ddyVWxoc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190724111609epcas1p2e4646cf7545b845ec1a3c9e5f1610146~0U6wgX6fs0404304043epcas1p2c;
        Wed, 24 Jul 2019 11:16:09 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 45tt7p6rMpzMqYkW; Wed, 24 Jul
        2019 11:16:06 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.56.04160.6FD383D5; Wed, 24 Jul 2019 20:16:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190724111606epcas1p447eebcab3649b6f1ae62547811e8b7fb~0U6tn8gNz2770927709epcas1p40;
        Wed, 24 Jul 2019 11:16:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190724111606epsmtrp17cce96d1bb49210245cc6904470a21d2~0U6tmm16D1328313283epsmtrp1Y;
        Wed, 24 Jul 2019 11:16:06 +0000 (GMT)
X-AuditID: b6c32a38-b33ff70000001040-09-5d383df61e9d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.E5.03706.6FD383D5; Wed, 24 Jul 2019 20:16:06 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190724111606epsmtip236522bcb23978b1efa0752709322ffeb~0U6tY_J0Q3168831688epsmtip2g;
        Wed, 24 Jul 2019 11:16:05 +0000 (GMT)
Subject: Re: [PATCH v4 20/24] PM / devfreq: tegra30: Optimize upper average
 watermark selection
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Organization: Samsung Electronics
Message-ID: <2c6a20e0-2e56-ea5a-76e6-bf17994fc7df@samsung.com>
Date:   Wed, 24 Jul 2019 20:19:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6fa38946-7441-4c19-83fd-4da422be5732@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTQRiGnW67XQzFsaB+1kTrGoyQVLpC69YIGlFs4oXxjzGSuoG1JfRK
        t8UrURQjXtw/1IpKFIPWAzVgCh41iFbiEVQMHiEialRiMIrgRdQui5F/z3zzvvN978xQhPo8
        qaFynV7e4+TsNDlafvlmgk43kMpm6a/0G9kzn18jdqf/uJy9v+Ojkn3cVEWyfcUtiN3z1U+y
        L7afItkfTUflbMm5R+T8KHOwswaZG/2dSnNxYS9pLqkPIHPfpcmZijV5c208l8N7tLwz25WT
        67Sm0ktWWdItBqOe0TEmdjatdXIOPpVeuDRTl5FrjwxEa/M5uy9SyuQEgU5Km+tx+by81uYS
        vKk0786xu03umQLnEHxO68xsl2MOo9fPMkSE6/Jsd0Nb3dXxG9892UEWoGOT96IoCnAK1F6v
        Vu5Foyk1DiKoedkqlxZfEPy8+oEUVWo8gKDk9up/jvDTEJJE1xCcamsfdnxC8PFrFRJVsZiD
        h6XvFCKTOBFC758OnRSHp0PtrUGFaCDwRRmEL5yViRtj8FR48v31kFmF0+BAf19kKIqS43jo
        urtcLI/Dq+FL102FJBkLrYfeyEWOwvOg43TTEBN4Ajx/c0wm8RQobDhMiL0AFyqh8Xw7IUVY
        CPX7vikkjoWecL1SYg18KN01zFvgdGsLKZl3I6gPtQ0bkiF0slImDkfgBKhrSpLKU6Hx1xEk
        NY6B3v79ClECWAW7d6klyTR43NUpk3ginCjaQ5Yh2j8ijn9EBP+ICP7/zaqRPIDG827BYeUF
        xp0y8rEvoaG/msgG0dUHS5sRphAdrdKOmp2lVnD5wiZHMwKKoONUKwuMWWpVDrdpM+9xWTw+
        Oy80I0PksssJzbhsV+TnO70WxjArOTmZTWGMBoahJ6iODiZkqbGV8/J5PO/mPf98MipKU4B0
        v7u9f+akjK3oWXvmclvGq6JlCwY/B9ISy9P7YrW+8rpl68xv/Ws+JdV1FDmu0GHTpLLoku6O
        isCWIm9lsGLgyPhFlg7TjZYVtVZTIIiY7GftvTcybLZ7B+MaNMpF9xumVW6LadwWXzxDkVs5
        z6pvX+tbvt5xZ8PZxfHRYWN+909aLtg4JpHwCNxfb11qKMEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvO43W4tYg28L2S1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyTu+vK1igWvH8ahNbA+N8uS5GTg4JAROJ4zf2
        M3YxcnEICexmlJhwbBYrREJSYtrFo8xdjBxAtrDE4cPFEDVvGSV2HzvHBFIjLJAocbH/OVg9
        m4CWxP4XN9hAbBEBNYnlR/+wgjQwC2xmkjh7ajUbRPcOFomjh/+yg1TxCyhKXP3xmBHE5hWw
        k5j+9TM7yDYWAVWJB6f9QMKiAhESh3fMgioRlDg58wkLiM0pYC9xfeUuMJtZQF3iz7xLzBC2
        uMStJ/OZIGx5ieats5knMArPQtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhb
        XJqXrpecn7uJERxhWpo7GC8viT/EKMDBqMTDq8BgHivEmlhWXJl7iFGCg1lJhDewwSxWiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp2ampBalFMFkmDk6pBkaJmBfrfzyvf51b
        f1frwK6rdyb/X2Y/f2VrmYPYo0+vZGe+Fet+8vvFxNNamndfMtTfjyvtyogxNVyYdrPjf+mj
        rtML47XT1851tNEVjf+hxsb8emk186xt3kxzAssXXGVzVbzYVxrffNLtquxkvrbVVcHM9ked
        W57Y/W29yH/4y5u/h5/KHORQYinOSDTUYi4qTgQANuoprqwCAAA=
X-CMS-MailID: 20190724111606epcas1p447eebcab3649b6f1ae62547811e8b7fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223619epcas4p333f556dcf5a477b5cad5c9362a6f9b97
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223619epcas4p333f556dcf5a477b5cad5c9362a6f9b97@epcas4p3.samsung.com>
        <20190707223303.6755-21-digetx@gmail.com>
        <e3358039-d1b3-a5a0-1a37-aeb8edd49d6b@samsung.com>
        <20190719045943.73b53e31@dimatab>
        <1cec80ae-c03e-98a7-1d9f-6b57690610c7@samsung.com>
        <20190719052111.6641285d@dimatab>
        <3c9c6a3a-8bce-d304-8472-029e6e673a99@samsung.com>
        <c3e4330a-a96c-1ae9-761e-9eb1179e9b01@samsung.com>
        <01b442e4-437d-799d-ed0d-4628bd0d683b@gmail.com>
        <6fa38946-7441-4c19-83fd-4da422be5732@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 24. 오후 8:17, Chanwoo Choi wrote:
> On 19. 7. 20. 오전 2:52, Dmitry Osipenko wrote:
>> 19.07.2019 9:11, Chanwoo Choi пишет:
>>> On 19. 7. 19. 오후 3:09, Chanwoo Choi wrote:
>>>> On 19. 7. 19. 오전 11:21, Dmitry Osipenko wrote:
>>>>> В Fri, 19 Jul 2019 11:06:05 +0900
>>>>> Chanwoo Choi <cw00.choi@samsung.com> пишет:
>>>>>
>>>>>> On 19. 7. 19. 오전 10:59, Dmitry Osipenko wrote:
>>>>>>> В Fri, 19 Jul 2019 10:36:30 +0900
>>>>>>> Chanwoo Choi <cw00.choi@samsung.com> пишет:
>>>>>>>   
>>>>>>>> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:  
>>>>>>>>> I noticed that CPU may be crossing the dependency threshold very
>>>>>>>>> frequently for some workloads and this results in a lot of
>>>>>>>>> interrupts which could be avoided if MCALL client is keeping
>>>>>>>>> actual EMC frequency at a higher rate.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>>>> ---
>>>>>>>>>  drivers/devfreq/tegra30-devfreq.c | 23 ++++++++++++++++++-----
>>>>>>>>>  1 file changed, 18 insertions(+), 5 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/devfreq/tegra30-devfreq.c
>>>>>>>>> b/drivers/devfreq/tegra30-devfreq.c index
>>>>>>>>> c3cf87231d25..4d582809acb6 100644 ---
>>>>>>>>> a/drivers/devfreq/tegra30-devfreq.c +++
>>>>>>>>> b/drivers/devfreq/tegra30-devfreq.c @@ -314,7 +314,8 @@ static
>>>>>>>>> void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra, }
>>>>>>>>>  
>>>>>>>>>  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq
>>>>>>>>> *tegra,
>>>>>>>>> -					   struct
>>>>>>>>> tegra_devfreq_device *dev)
>>>>>>>>> +					   struct
>>>>>>>>> tegra_devfreq_device *dev,
>>>>>>>>> +					   unsigned long freq)
>>>>>>>>>  {
>>>>>>>>>  	unsigned long avg_threshold, lower, upper;
>>>>>>>>>  
>>>>>>>>> @@ -323,6 +324,15 @@ static void
>>>>>>>>> tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>>>>>>>>> avg_threshold = dev->config->avg_dependency_threshold;
>>>>>>>>> avg_threshold = avg_threshold * ACTMON_SAMPLING_PERIOD; 
>>>>>>>>> +	/*
>>>>>>>>> +	 * If cumulative EMC frequency selection is higher than
>>>>>>>>> the
>>>>>>>>> +	 * device's, then there is no need to set upper watermark
>>>>>>>>> to
>>>>>>>>> +	 * a lower value because it will result in unnecessary
>>>>>>>>> upper
>>>>>>>>> +	 * interrupts.
>>>>>>>>> +	 */
>>>>>>>>> +	if (freq * ACTMON_SAMPLING_PERIOD > upper)
>>>>>>>>> +		upper = freq * ACTMON_SAMPLING_PERIOD;    
>>>>>>>>
>>>>>>>> Also, 'upper value is used on the patch5. You can combine this code
>>>>>>>> to patch5 or if this patch depends on the cpu notifier, you can
>>>>>>>> combine it to the patch of adding cpu notifier without separate
>>>>>>>> patch.  
>>>>>>>
>>>>>>> Well okay, I'll try to squash some of the patches in the next
>>>>>>> revision. Usually I'm receiving comments in the other direction,
>>>>>>> asking to separate patches into smaller changes ;) So that's more a
>>>>>>> personal preference of each maintainer, I'd say.
>>>>>>>   
>>>>>>
>>>>>> Right. We have to make the patch with atomic attribute.
>>>>>> But, if there are patches which touch the same code
>>>>>> in the same patchset. We can squash or do refactorig
>>>>>> of this code.
>>>>>
>>>>> The main benefit of having smaller logical changes is that when there is
>>>>> a bug, it's easier to narrow down the offending change using bisection.
>>>>> And it's just easier to review smaller patches, of course.
>>>>
>>>> I agree that the patch should contain the atomic feature.
>>>> To remove the some communication confusion between us,
>>>> I don't mean that you have to merge patches to only one patch.
>>>
>>> If each patch has the atomic attribute, it have to be made as the separate patch.
>>> But, if some patches are included in the the following two case,
>>> can combine patches to one patch.
>>>
>>>>
>>>> It is important to remove the following two cases on the same patchset.
>>>>
>>>> 1. the front patch adds the code and then later patch remove the added code.
>>
>> Okay, I agree that this is applicable to patch #11.
>>
>>>> 2. the front patch changes the code and the later patch again modified
>>>>    the changed code of the front patch
>>
>> If patch A adds a new feature and then patch B adds another new feature
>> on top of A, do you consider each of these patches as atomic?
> 
> Yes, if patch A and patch A have the different role

Sorry for my mistake. Modify the sentence as following:

Yes, if patch A and patch B have the different role
for the same device driver, it is possible to make them
as the separate patches.


> 
> 
>>
>> [snip]
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
