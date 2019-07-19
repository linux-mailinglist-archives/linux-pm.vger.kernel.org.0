Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9156E0DE
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 08:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfGSGIm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 02:08:42 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:51635 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfGSGIm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 02:08:42 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190719060839epoutp0442158a1d2741a344e45f1da482e09d3a~yuf2PzCxc2729427294epoutp04F
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 06:08:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190719060839epoutp0442158a1d2741a344e45f1da482e09d3a~yuf2PzCxc2729427294epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563516519;
        bh=NU+ul+l+BwlLq0RKOFf7PsXfqwtG25DMcSpVBs9CAXM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g1IJvpmrk32nBCmtbeeHs84/LkJWmT4u/m+dfJEvW+jBymkTyN3QaUnvfAYVRcv8d
         w1B01FC+3atZbQaxNCZmzmGCuz1iVdXZqRG8x0oV8gR8Dajn+w93n+eEhhDzhMXmWH
         LvlBR6Kn1wafPNlaGfjKQQomwHSVMg8OpWeIqTdU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190719060838epcas1p47f5871a30b5e53238b0b122876ef0e25~yuf1rdYO32304523045epcas1p4e;
        Fri, 19 Jul 2019 06:08:38 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 45qgYH61xKzMqYlm; Fri, 19 Jul
        2019 06:08:35 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.D8.04085.36E513D5; Fri, 19 Jul 2019 15:08:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190719060835epcas1p3e73e654c4f013dfcec3164b4d02c1ac2~yufyoJZpj3137431374epcas1p3n;
        Fri, 19 Jul 2019 06:08:35 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190719060835epsmtrp22595b4ccaa1bb36e84ce82ea7cddaa83~yufynY3vx1058710587epsmtrp2D;
        Fri, 19 Jul 2019 06:08:35 +0000 (GMT)
X-AuditID: b6c32a39-cebff70000000ff5-eb-5d315e635faa
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.50.03638.36E513D5; Fri, 19 Jul 2019 15:08:35 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190719060835epsmtip2ce3815d72739fe949dc7f31a28f21422~yufyTdC9K1448114481epsmtip2j;
        Fri, 19 Jul 2019 06:08:35 +0000 (GMT)
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
Message-ID: <c3e4330a-a96c-1ae9-761e-9eb1179e9b01@samsung.com>
Date:   Fri, 19 Jul 2019 15:11:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3c9c6a3a-8bce-d304-8472-029e6e673a99@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zk726LV1+zytqjmiQIFdSdbHUMtqGSVP4T6YYWtg5422e20
        s4UW3VzY1UwMymVm2bK7FWpqlLQsMSoyMSSRLosuZkZeKimwbafIf8/7vs/zPd/zfa+S0NRQ
        WmWuw827HJyNpsaR9fdj9HHZG5ks/YuuePbytyBi9/rOkuyTgj4F29FUTrGDRS2IPTDko9ju
        PRcodqSpgmSPXH1OLVUZG3rOIWOjr0dhLPL2U8YjtZeQcfDmrAz5emuyhedyeJeOd2Q7c3Id
        5hR69RrTMpNhoZ6JY5LYRbTOwdn5FHp5ekZcWq4tdCFat5WzeUKtDE4U6YTUZJfT4+Z1Fqfo
        TqF5IccmJAnxImcXPQ5zfLbTvpjR6+cbQsRNVsujex6hVZdXdaaU2I3KtQeRSgl4ATwY9hIH
        0TilBjcgqK/0yqRiAMFQzyFKKr4jaPtSqvgnKSv3y8JYg+8g6G7ZIZG+IvDXtZPhQRTmoL34
        gzyMKRwLzR+7qDCejOdB9YPf8rCAwDdk0Hr9SuSkiTgaOn8GURircSo8u3wrIibxXDh3tDfS
        n4IzYeD1fbnEmQRtZe8iZiq8BEarTkYMCDwNXr47LZPwbPDWnYyEAzxKgd9/F0kRlkPd2QAh
        4Sjoba39G00Lg/13KAlvh4ttLZQk3o+gtvmZXBokQrO/NOSgDDnEQE1TgtSOhsZfp5BkPAH6
        hw/LwxTAathfqJEoc6DjdY9MwtOhat8B6iiifWPi+MZE8I2J4PtvVonIS2gqL4h2My8ygmHs
        b99EkWWNTWpAD5+mBxBWInq8OsOuz9LIua1ivj2AQEnQk9XdnxKyNOocLn8b73KaXB4bLwaQ
        IfTaJYR2SrYztPoOt4kxzE9MTGQXMAsNDENPU1f8jsnSYDPn5q08L/CufzqZUqXdjdYS1TNP
        qZzXNs/Jt9+yZ45uf7Xhbebj4cpis3Xo80drn21lZVRJvftHYBfTW8i+T7s9obrCdHWAFKxD
        3klBayyy3I7Kmy2vTc/fVBNdMtI5q7VvRfrxEx3B84WGguIZRRZ1wvgt6xSkJSi0aFdpC5qv
        eKwdOz8cUzQmLfveNfMNTYoWjoklXCL3BwpHMXnCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvG5ynGGswcz9oharPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZpw6WFhxXqFi8cDJzA+McqS5GTg4JAROJmXOW
        MnUxcnEICexmlHjfP4UVIiEpMe3iUeYuRg4gW1ji8OFiiJq3jBIHFs1hBqkRFkiUuNj/HKye
        TUBLYv+LG2wgtoiAmsTyo39YQRqYBTYzSZw9tZoNons2s8TjxrVgHfwCihJXfzxmBLF5Bewk
        LqzeDhZnEVCVWDLhFVhcVCBC4vCOWVA1ghInZz5hAbE5Bewl/i+eDbaNWUBd4s+8S8wQtrjE
        rSfzmSBseYnmrbOZJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1ya
        l66XnJ+7iREcY1paOxhPnIg/xCjAwajEwxuQaxArxJpYVlyZe4hRgoNZSYT39kv9WCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2CyTBycUg2Mqz4yBmaXLTjuODdi
        9crtG/wswwPLagqCl70pSTwp6Fousuz3UpfYoI7KTP5ev7235xbEBPUHbDkXr3Z110mNOKuk
        SYtF9K7OmbVexH39DbegjJBfgkdquK3vFIq82V/FpDPxz+tlWlvd0vb+cyrllDd2kU0xnL0r
        77BwEI/cn/LfC775rt2oxFKckWioxVxUnAgA1ngb6q0CAAA=
X-CMS-MailID: 20190719060835epcas1p3e73e654c4f013dfcec3164b4d02c1ac2
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 19. 오후 3:09, Chanwoo Choi wrote:
> On 19. 7. 19. 오전 11:21, Dmitry Osipenko wrote:
>> В Fri, 19 Jul 2019 11:06:05 +0900
>> Chanwoo Choi <cw00.choi@samsung.com> пишет:
>>
>>> On 19. 7. 19. 오전 10:59, Dmitry Osipenko wrote:
>>>> В Fri, 19 Jul 2019 10:36:30 +0900
>>>> Chanwoo Choi <cw00.choi@samsung.com> пишет:
>>>>   
>>>>> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:  
>>>>>> I noticed that CPU may be crossing the dependency threshold very
>>>>>> frequently for some workloads and this results in a lot of
>>>>>> interrupts which could be avoided if MCALL client is keeping
>>>>>> actual EMC frequency at a higher rate.
>>>>>>
>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>> ---
>>>>>>  drivers/devfreq/tegra30-devfreq.c | 23 ++++++++++++++++++-----
>>>>>>  1 file changed, 18 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/devfreq/tegra30-devfreq.c
>>>>>> b/drivers/devfreq/tegra30-devfreq.c index
>>>>>> c3cf87231d25..4d582809acb6 100644 ---
>>>>>> a/drivers/devfreq/tegra30-devfreq.c +++
>>>>>> b/drivers/devfreq/tegra30-devfreq.c @@ -314,7 +314,8 @@ static
>>>>>> void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra, }
>>>>>>  
>>>>>>  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq
>>>>>> *tegra,
>>>>>> -					   struct
>>>>>> tegra_devfreq_device *dev)
>>>>>> +					   struct
>>>>>> tegra_devfreq_device *dev,
>>>>>> +					   unsigned long freq)
>>>>>>  {
>>>>>>  	unsigned long avg_threshold, lower, upper;
>>>>>>  
>>>>>> @@ -323,6 +324,15 @@ static void
>>>>>> tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>>>>>> avg_threshold = dev->config->avg_dependency_threshold;
>>>>>> avg_threshold = avg_threshold * ACTMON_SAMPLING_PERIOD; 
>>>>>> +	/*
>>>>>> +	 * If cumulative EMC frequency selection is higher than
>>>>>> the
>>>>>> +	 * device's, then there is no need to set upper watermark
>>>>>> to
>>>>>> +	 * a lower value because it will result in unnecessary
>>>>>> upper
>>>>>> +	 * interrupts.
>>>>>> +	 */
>>>>>> +	if (freq * ACTMON_SAMPLING_PERIOD > upper)
>>>>>> +		upper = freq * ACTMON_SAMPLING_PERIOD;    
>>>>>
>>>>> Also, 'upper value is used on the patch5. You can combine this code
>>>>> to patch5 or if this patch depends on the cpu notifier, you can
>>>>> combine it to the patch of adding cpu notifier without separate
>>>>> patch.  
>>>>
>>>> Well okay, I'll try to squash some of the patches in the next
>>>> revision. Usually I'm receiving comments in the other direction,
>>>> asking to separate patches into smaller changes ;) So that's more a
>>>> personal preference of each maintainer, I'd say.
>>>>   
>>>
>>> Right. We have to make the patch with atomic attribute.
>>> But, if there are patches which touch the same code
>>> in the same patchset. We can squash or do refactorig
>>> of this code.
>>
>> The main benefit of having smaller logical changes is that when there is
>> a bug, it's easier to narrow down the offending change using bisection.
>> And it's just easier to review smaller patches, of course.
> 
> I agree that the patch should contain the atomic feature.
> To remove the some communication confusion between us,
> I don't mean that you have to merge patches to only one patch.

If each patch has the atomic attribute, it have to be made as the separate patch.
But, if some patches are included in the the following two case,
can combine patches to one patch.

> 
> It is important to remove the following two cases on the same patchset.
> 
> 1. the front patch adds the code and then later patch remove the added code.
> 2. the front patch changes the code and the later patch again modified
>    the changed code of the front patch
> 
> 
>>
>>> And also, if possible, I'd like you to make the patch
>>> list according to the role of patch. For example,
>>> the patches related to the 'watermark' could be sequentially
>>> listed. But, it is not forced opinion. If just possible.
>>
>> Okay, will take this into account.
>>
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
