Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01A3E6E0DB
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 08:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfGSGGi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 02:06:38 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:50627 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfGSGGh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 02:06:37 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190719060633epoutp04ab564613fcfbff457ace9257e6281cb8~yueA0DE6I2554225542epoutp04y
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 06:06:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190719060633epoutp04ab564613fcfbff457ace9257e6281cb8~yueA0DE6I2554225542epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563516393;
        bh=4PKDuMRdZXsZY/A8Stw2Oa1AaKHI6FYNZBBnzTlN8NA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dPMJUjEp9nlIOG2nWHrCbH9rF6s6o/89ZkfpHewYGpQ6W6rIsVD4V9vdwN1/Qspjd
         SJ9DE9EP6FAJWGvQOje0yCTsSpR/oa7BtEco+z8oX0F9mQwXborppYhEKSKYq0p23w
         hbAVHp2Z8b99g4NxEgMbPLUzjZRHuCa5uZRRCCRI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190719060632epcas1p4b20c395b31af38398ec73ece60d7517d~yueAYQHjE1472514725epcas1p4Z;
        Fri, 19 Jul 2019 06:06:32 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 45qgVt20rczMqYkh; Fri, 19 Jul
        2019 06:06:30 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.16.04075.5ED513D5; Fri, 19 Jul 2019 15:06:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190719060629epcas1p33ed4a6918bed09f34fff8b287b049757~yud9WXLLb2069020690epcas1p3U;
        Fri, 19 Jul 2019 06:06:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190719060629epsmtrp25f33e1f4935aceb5c76aba3b1d3ef85a~yud9VbD3G0848208482epsmtrp2-;
        Fri, 19 Jul 2019 06:06:29 +0000 (GMT)
X-AuditID: b6c32a36-b61ff70000000feb-99-5d315de527e3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.20.03638.5ED513D5; Fri, 19 Jul 2019 15:06:29 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190719060629epsmtip23d2c0bfd4bd87a1440055135801b368c~yud9FRz6S1724617246epsmtip2N;
        Fri, 19 Jul 2019 06:06:29 +0000 (GMT)
Subject: Re: [PATCH v4 20/24] PM / devfreq: tegra30: Optimize upper average
 watermark selection
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <3c9c6a3a-8bce-d304-8472-029e6e673a99@samsung.com>
Date:   Fri, 19 Jul 2019 15:09:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719052111.6641285d@dimatab>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXd2jsdq9bqsnoxyni6kMbejzU6l0o1a2AcjggiGHd3BmdvZ
        2JmRBmVpZaZWRFCzLHTR/SYauhDJLMkulmZlJkiTLiJa2sUwom2nyG//5//8Xp7L+9CE+joV
        QWeJLsEp8laGmqC8fS9ap31vYk366reIu/LFh7hCd6WSe7JvIITr8J6muJHSZsQd+uqmuO69
        Fynup7dCyZVda6dWhBrrejzIWO/uCTGWFgxSxrKay8g4Uj0nldyanWgReLPg1Ahiht2cJWYm
        MSmb0lanGRL0rJZdyi1hNCJvE5KYNRtStWuzrP6GGM0O3prjt1J5SWJ0yYlOe45L0FjskiuJ
        ERxmq2OpI1bibVKOmBmbYbctY/X6OIMf3JZtGbrzXen4PHvnQPcJMh8VQjEKpQEvhuL8NqoY
        TaDVuA7BUH8vIQfDCC7tvaCQg+8IvC+aiX9PTpQMkwGtxg0I7j4WZWgIQdG7VkUgMRXz8PzI
        hyAUjhfAhfu/yABE4FsKaLl5NQhROAYaP76mAnoKjoLOUR8KaBVOhrdjJ4O+Es+Hjk/lwcrT
        8BYY7r1HykwYPDzVpyxGNB2KY+FD/56ATeAZ8KbvrELWkVBQW/636YIQaLgTKes18HigjZL1
        VOhvqQmRdQSMDDb89XfBpYfNwb0ALkJQ0/iMlBPx0Hj+uCJQl8DRcMOrk+0oqB87g+S6k2Hw
        WwkZQACroOiAWkbmQkdvj0LWM6Hq4CHqKGLc44Zxj5vAPW4C9/9i55DyMpouOCRbpiCxjrjx
        n12Ngrcak1CHKp9uaEKYRswk1eh2vUlN8jukXFsTAppgwlXdn3QmtcrM5+YJTnuaM8cqSE3I
        4N/1MSJiWobdf/miK401xMXHx3OL2QQDyzIzVBW/ok1qnMm7hGxBcAjOf+8UdGhEPppYxdw9
        Wjh5q07l3XRs0bNtVVGT0l9tHFruY9YTb8Z0gxpfa61+tNTStuhrZIuHNK9M+biutH3hbu32
        l6802lVdiPc84qbsfxCbfKZTYWxPz+0KEyrqzhGdTo/nwY/0332v8+b9gPCSRDGlNjzsKb95
        1mEy+UBXZauvjEmk6vMYpWTh2RjCKfF/AAbOEjfBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvO7TWMNYg5nbZS1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgy3u/+xlLwQbbize2prA2MLRJdjJwcEgImElN7
        PrGC2EICuxklbuzWgYhLSky7eJS5i5EDyBaWOHy4uIuRC6jkLaPE291PmUFqhAUSJS72Pwfr
        FRFQk1h+9A8rSBGzwGYmibOnVrNBdDxjkpjccp0RpIpNQEti/4sbbCA2v4CixNUfj8HivAJ2
        End+zwCLswioSlx+ORtsg6hAhMThHbOgagQlTs58wgJyEaeAnsTzV/UgYWYBdYk/8y4xQ9ji
        EreezGeCsOUlmrfOZp7AKDwLSfcsJC2zkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5x
        aV66XnJ+7iZGcIRpae1gPHEi/hCjAAejEg9vQK5BrBBrYllxZe4hRgkOZiUR3tsv9WOFeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ88rnH4sUEkhPLEnNTk0tSC2CyTJxcEo1MPZYrZ2suez6c8V0
        hlvi/54tk5l0o+ud7LvVb5pqmuYu/BRw7f+T3zoixkaZvYI9d2e/qNY2XFp80/Nnv6dAQlDQ
        5lcHps68zGzN115wY/eNUy9Feycv5JDb/1vz1oGNpzJez7fzWpK9NWmnp6jeuwAf/5LlzY1a
        ftnilom3/Cf2Jm9rdq0OFVdiKc5INNRiLipOBABfyQ5SrAIAAA==
X-CMS-MailID: 20190719060629epcas1p33ed4a6918bed09f34fff8b287b049757
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 19. 오전 11:21, Dmitry Osipenko wrote:
> В Fri, 19 Jul 2019 11:06:05 +0900
> Chanwoo Choi <cw00.choi@samsung.com> пишет:
> 
>> On 19. 7. 19. 오전 10:59, Dmitry Osipenko wrote:
>>> В Fri, 19 Jul 2019 10:36:30 +0900
>>> Chanwoo Choi <cw00.choi@samsung.com> пишет:
>>>   
>>>> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:  
>>>>> I noticed that CPU may be crossing the dependency threshold very
>>>>> frequently for some workloads and this results in a lot of
>>>>> interrupts which could be avoided if MCALL client is keeping
>>>>> actual EMC frequency at a higher rate.
>>>>>
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>> ---
>>>>>  drivers/devfreq/tegra30-devfreq.c | 23 ++++++++++++++++++-----
>>>>>  1 file changed, 18 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/devfreq/tegra30-devfreq.c
>>>>> b/drivers/devfreq/tegra30-devfreq.c index
>>>>> c3cf87231d25..4d582809acb6 100644 ---
>>>>> a/drivers/devfreq/tegra30-devfreq.c +++
>>>>> b/drivers/devfreq/tegra30-devfreq.c @@ -314,7 +314,8 @@ static
>>>>> void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra, }
>>>>>  
>>>>>  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq
>>>>> *tegra,
>>>>> -					   struct
>>>>> tegra_devfreq_device *dev)
>>>>> +					   struct
>>>>> tegra_devfreq_device *dev,
>>>>> +					   unsigned long freq)
>>>>>  {
>>>>>  	unsigned long avg_threshold, lower, upper;
>>>>>  
>>>>> @@ -323,6 +324,15 @@ static void
>>>>> tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>>>>> avg_threshold = dev->config->avg_dependency_threshold;
>>>>> avg_threshold = avg_threshold * ACTMON_SAMPLING_PERIOD; 
>>>>> +	/*
>>>>> +	 * If cumulative EMC frequency selection is higher than
>>>>> the
>>>>> +	 * device's, then there is no need to set upper watermark
>>>>> to
>>>>> +	 * a lower value because it will result in unnecessary
>>>>> upper
>>>>> +	 * interrupts.
>>>>> +	 */
>>>>> +	if (freq * ACTMON_SAMPLING_PERIOD > upper)
>>>>> +		upper = freq * ACTMON_SAMPLING_PERIOD;    
>>>>
>>>> Also, 'upper value is used on the patch5. You can combine this code
>>>> to patch5 or if this patch depends on the cpu notifier, you can
>>>> combine it to the patch of adding cpu notifier without separate
>>>> patch.  
>>>
>>> Well okay, I'll try to squash some of the patches in the next
>>> revision. Usually I'm receiving comments in the other direction,
>>> asking to separate patches into smaller changes ;) So that's more a
>>> personal preference of each maintainer, I'd say.
>>>   
>>
>> Right. We have to make the patch with atomic attribute.
>> But, if there are patches which touch the same code
>> in the same patchset. We can squash or do refactorig
>> of this code.
> 
> The main benefit of having smaller logical changes is that when there is
> a bug, it's easier to narrow down the offending change using bisection.
> And it's just easier to review smaller patches, of course.

I agree that the patch should contain the atomic feature.
To remove the some communication confusion between us,
I don't mean that you have to merge patches to only one patch.

It is important to remove the following two cases on the same patchset.

1. the front patch adds the code and then later patch remove the added code.
2. the front patch changes the code and the later patch again modified
   the changed code of the front patch


> 
>> And also, if possible, I'd like you to make the patch
>> list according to the role of patch. For example,
>> the patches related to the 'watermark' could be sequentially
>> listed. But, it is not forced opinion. If just possible.
> 
> Okay, will take this into account.
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
