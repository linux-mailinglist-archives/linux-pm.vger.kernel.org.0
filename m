Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A17B472D30
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 13:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfGXLOt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 07:14:49 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:64294 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfGXLOs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 07:14:48 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190724111446epoutp03cdf2544e723e13d18b43a3c927c3006b~0U5jB8ltL2486824868epoutp03E
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 11:14:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190724111446epoutp03cdf2544e723e13d18b43a3c927c3006b~0U5jB8ltL2486824868epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563966886;
        bh=iUb3DDdaq1+z/c+kVz+eb2QAc0/vpLHnRYZytmOAcgU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TgPitXps/xUf2p4t7B+/WgxW/sFlKSU3inJuEgkUj8cO6RQ1AcZuCC7VHtYmEH3Bw
         t0n64eA+sS+gCQJcyPxpIuEui0hr372V/zPC5w8h3cienrhlPvyXDTRtA6+d3RrCFa
         cJkCIsz2qJmN2bRzqjlDBb+NxAqglWkcsOoZa5/0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190724111445epcas1p37125476967e25a39dd8334bacffc5768~0U5iYVoeB1742317423epcas1p3f;
        Wed, 24 Jul 2019 11:14:45 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 45tt6C3Dc4zMqYkX; Wed, 24 Jul
        2019 11:14:43 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.FB.04085.3AD383D5; Wed, 24 Jul 2019 20:14:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190724111442epcas1p2cc5ccc22b11a12666b422ee07b1bcf0c~0U5gCuXib0122701227epcas1p22;
        Wed, 24 Jul 2019 11:14:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190724111442epsmtrp1d1ccffbb52dbcc8a5c5c2916d7d04756~0U5f-UudM1328313283epsmtrp1d;
        Wed, 24 Jul 2019 11:14:42 +0000 (GMT)
X-AuditID: b6c32a39-d03ff70000000ff5-81-5d383da363d0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.D5.03706.2AD383D5; Wed, 24 Jul 2019 20:14:42 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190724111442epsmtip1cbdbb28f734c31281f0bed58619755da~0U5fxllMg1352613526epsmtip1g;
        Wed, 24 Jul 2019 11:14:42 +0000 (GMT)
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
Message-ID: <6fa38946-7441-4c19-83fd-4da422be5732@samsung.com>
Date:   Wed, 24 Jul 2019 20:17:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <01b442e4-437d-799d-ed0d-4628bd0d683b@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURDHfd3udlGqz6I4EqNlPcGAXbGwqCVeMTVqxBgTYyS4gQ0gPTbd
        FkX9AEJAUEFiIlgRjWAUFEWCWmq0saCoiUZtNHjgEfA29cQjnm1XI99+85//ZGbeG5rQtFBR
        dI7FLtgsvImhBitPd8To4uoNXJqu0R/JHX3fi7hi50Eld23LGxXnc9dS3McdnYgr++SkuPuF
        Ryjum7tOyVU036LmhBldPQ3I2O7sURl3FPkpY0VbEzJ+bB2bSq7OnZ0t8JmCTStYMqyZOZYs
        A7N4Rfr8dH2ijo1jk7kkRmvhzYKBWbAkNW5hjikwEKPN402OgJTKSxIzLWW2zeqwC9psq2Q3
        MIKYaRKTxXiJN0sOS1Z8htU8k9XppusDxrW52aWnukhx+/gNrd1FZAFyjSlHYTTgGfDrdbmi
        HA2mNdiF4OnNbUgOPiCoul+tkoPPCO4VetG/kvPuL0o5cQ7B993XSTl4i+Bhe5Mi6IrAPNys
        fE4GeQSeBIcv/giZCHxSAV0tx0ImCseC50U3FeRhOBpuf+0NtVDjFCjuuBDQaVqJJ0LL7YVB
        eSReBR8ed5CyZThc2dOnDHIYNkCjuz7EBB4F9/r2K2QeB0Wn9hLBvoCLVFDWfZyQV1gApYVP
        /nIEvOpqU8kcBS8rS/7yJmi80knJxVsRtHlukHIiATyHdimCwxE4Bk64p8lyNLR/34fkxkPB
        37+dDFoAq2FriUa2jAff4x6FzKOhvrSM2okY54B1nANWcA5Ywfm/2QGkbEKRgiiZswSJFfUD
        v7sVha41NtmFLl1f4kWYRky4WjsoKU1D8nlSvtmLgCaYEerlBYlpGnUmn79RsFnTbQ6TIHmR
        PvDYVUTUyAxr4PYt9nRWPz0hIYGbwSbqWZYZpa77EZOmwVm8XcgVBFGw/atT0GFRBWhZ89pa
        4sjl6BXPfHlL85/N7Q9XTT5Tc3eu4wG2bjzncf+OjDQdBX9SmXinf/6F4pT1FQ1e/GjWlJ+1
        g/pr57mYdb5v1eHXVsb/WhrRndK3+Wp11dfVWw759Pt+T630jDm7qHlN5/5x3lUNJe9yky/X
        XVwmLk7dPKT304Q7/sn5VW/m1TBKKZtnYwmbxP8BEKAwlsMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnO4iW4tYgwW/9S1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgy2rceZy3oUa7YdKOZtYFxh0wXIyeHhICJxL5d
        31m6GLk4hAR2M0rMeHWLDSIhKTHt4lHmLkYOIFtY4vDhYpCwkMBbRolTG6RAbGGBRImL/c9Z
        QWwRATWJ5Uf/sILMYRbYzCRx9tRqNoihzSwS/YvnMoFUsQloSex/cQNsAb+AosTVH48ZQWxe
        ATuJlsMH2UCWsQioSmy46gYSFhWIkDi8YxZUiaDEyZlPWEBsTgFbiZW7FoPZzALqEn/mXWKG
        sMUlbj2ZzwRhy0s0b53NPIFReBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE
        3OLSvHS95PzcTYzgCNPS3MF4eUn8IUYBDkYlHl4FBvNYIdbEsuLK3EOMEhzMSiK8gQ1msUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5n+YdixQSSE8sSc1OTS1ILYLJMnFwSjUwNhTovz7VK19z
        KGrhcrHEqb5Hv/vtVn64Sc7AeEmwfOLChLMcrUcLTvT/y3qw91SU5k1lL5+kibPvCu+78bZS
        JSqf6WZ0sH7Usvp7j5mt1FMMxc1n/RQ+YetxPnf7vwaTz/tOva/YcoH/V9IP4TWzO+V3JNkZ
        7LcTnHRRVela2oaiyUeXhFoWKrEUZyQaajEXFScCAJ3OOtCsAgAA
X-CMS-MailID: 20190724111442epcas1p2cc5ccc22b11a12666b422ee07b1bcf0c
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 20. 오전 2:52, Dmitry Osipenko wrote:
> 19.07.2019 9:11, Chanwoo Choi пишет:
>> On 19. 7. 19. 오후 3:09, Chanwoo Choi wrote:
>>> On 19. 7. 19. 오전 11:21, Dmitry Osipenko wrote:
>>>> В Fri, 19 Jul 2019 11:06:05 +0900
>>>> Chanwoo Choi <cw00.choi@samsung.com> пишет:
>>>>
>>>>> On 19. 7. 19. 오전 10:59, Dmitry Osipenko wrote:
>>>>>> В Fri, 19 Jul 2019 10:36:30 +0900
>>>>>> Chanwoo Choi <cw00.choi@samsung.com> пишет:
>>>>>>   
>>>>>>> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:  
>>>>>>>> I noticed that CPU may be crossing the dependency threshold very
>>>>>>>> frequently for some workloads and this results in a lot of
>>>>>>>> interrupts which could be avoided if MCALL client is keeping
>>>>>>>> actual EMC frequency at a higher rate.
>>>>>>>>
>>>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>>> ---
>>>>>>>>  drivers/devfreq/tegra30-devfreq.c | 23 ++++++++++++++++++-----
>>>>>>>>  1 file changed, 18 insertions(+), 5 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/devfreq/tegra30-devfreq.c
>>>>>>>> b/drivers/devfreq/tegra30-devfreq.c index
>>>>>>>> c3cf87231d25..4d582809acb6 100644 ---
>>>>>>>> a/drivers/devfreq/tegra30-devfreq.c +++
>>>>>>>> b/drivers/devfreq/tegra30-devfreq.c @@ -314,7 +314,8 @@ static
>>>>>>>> void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra, }
>>>>>>>>  
>>>>>>>>  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq
>>>>>>>> *tegra,
>>>>>>>> -					   struct
>>>>>>>> tegra_devfreq_device *dev)
>>>>>>>> +					   struct
>>>>>>>> tegra_devfreq_device *dev,
>>>>>>>> +					   unsigned long freq)
>>>>>>>>  {
>>>>>>>>  	unsigned long avg_threshold, lower, upper;
>>>>>>>>  
>>>>>>>> @@ -323,6 +324,15 @@ static void
>>>>>>>> tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>>>>>>>> avg_threshold = dev->config->avg_dependency_threshold;
>>>>>>>> avg_threshold = avg_threshold * ACTMON_SAMPLING_PERIOD; 
>>>>>>>> +	/*
>>>>>>>> +	 * If cumulative EMC frequency selection is higher than
>>>>>>>> the
>>>>>>>> +	 * device's, then there is no need to set upper watermark
>>>>>>>> to
>>>>>>>> +	 * a lower value because it will result in unnecessary
>>>>>>>> upper
>>>>>>>> +	 * interrupts.
>>>>>>>> +	 */
>>>>>>>> +	if (freq * ACTMON_SAMPLING_PERIOD > upper)
>>>>>>>> +		upper = freq * ACTMON_SAMPLING_PERIOD;    
>>>>>>>
>>>>>>> Also, 'upper value is used on the patch5. You can combine this code
>>>>>>> to patch5 or if this patch depends on the cpu notifier, you can
>>>>>>> combine it to the patch of adding cpu notifier without separate
>>>>>>> patch.  
>>>>>>
>>>>>> Well okay, I'll try to squash some of the patches in the next
>>>>>> revision. Usually I'm receiving comments in the other direction,
>>>>>> asking to separate patches into smaller changes ;) So that's more a
>>>>>> personal preference of each maintainer, I'd say.
>>>>>>   
>>>>>
>>>>> Right. We have to make the patch with atomic attribute.
>>>>> But, if there are patches which touch the same code
>>>>> in the same patchset. We can squash or do refactorig
>>>>> of this code.
>>>>
>>>> The main benefit of having smaller logical changes is that when there is
>>>> a bug, it's easier to narrow down the offending change using bisection.
>>>> And it's just easier to review smaller patches, of course.
>>>
>>> I agree that the patch should contain the atomic feature.
>>> To remove the some communication confusion between us,
>>> I don't mean that you have to merge patches to only one patch.
>>
>> If each patch has the atomic attribute, it have to be made as the separate patch.
>> But, if some patches are included in the the following two case,
>> can combine patches to one patch.
>>
>>>
>>> It is important to remove the following two cases on the same patchset.
>>>
>>> 1. the front patch adds the code and then later patch remove the added code.
> 
> Okay, I agree that this is applicable to patch #11.
> 
>>> 2. the front patch changes the code and the later patch again modified
>>>    the changed code of the front patch
> 
> If patch A adds a new feature and then patch B adds another new feature
> on top of A, do you consider each of these patches as atomic?

Yes, if patch A and patch A have the different role
for the same device driver, it is possible to make them
as the separate patches.


> 
> [snip]
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
