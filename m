Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0DA121F2A
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2019 01:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfLQABX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 19:01:23 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:18364 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLQABX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 19:01:23 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191217000116epoutp021c9d4d817d2143115c58132e16af84f5~g-5MKiCve2638226382epoutp02h
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2019 00:01:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191217000116epoutp021c9d4d817d2143115c58132e16af84f5~g-5MKiCve2638226382epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576540876;
        bh=JKRNWmz9CnPDsa/TOiSezO6bQitTL56xpcKuqv+nXd4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BcQYXYxHGkYj+NSnUMrapniZE3586jGcpxsRsRkrcDSmPUhOo6ZLob7i13kKQ0zyl
         YWLgeRJCO/GAvssoWF6UuhyWTsu7YBTFpOWnipuE/9XBOJlzelSICzQ2U2qochrq57
         Y9dEDTQhPSuTIMO8krEpK16OkZLYYH/QvJxR9zFk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191217000115epcas1p1fb9cd47065ae11f0ba945473dccdecd5~g-5LknqvI2770627706epcas1p1e;
        Tue, 17 Dec 2019 00:01:15 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47cJFj5rDgzMqYkb; Tue, 17 Dec
        2019 00:01:13 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.22.52419.9CA18FD5; Tue, 17 Dec 2019 09:01:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191217000113epcas1p13ed3bdae2650350aa3659aed02d75d06~g-5I_94_W2770627706epcas1p1Q;
        Tue, 17 Dec 2019 00:01:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191217000113epsmtrp1ae6ad8c60b6408a3506924b7b748e03f~g-5I91d3M3214632146epsmtrp1N;
        Tue, 17 Dec 2019 00:01:13 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-a4-5df81ac9f84a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.9F.10238.8CA18FD5; Tue, 17 Dec 2019 09:01:12 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191217000112epsmtip14fceca2b4d96a095eae8b8e60924df24~g-5IkLOS80178801788epsmtip1B;
        Tue, 17 Dec 2019 00:01:12 +0000 (GMT)
Subject: Re: [PATCH 7/7] devfreq: move statistics to separate struct
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Javi Merino <javi.merino@arm.com>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamil Konieczny <k.konieczny@samsung.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        =?UTF-8?Q?=c3=98rjan_Eide?= <orjan.eide@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        a.hajda@samsung.com, robin.murphy@arm.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <09c52ab9-fb99-62e1-07b3-1e124f0e96f8@samsung.com>
Date:   Tue, 17 Dec 2019 09:07:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <d710f606-0013-ade3-904e-a56f0404eca7@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFJsWRmVeSWpSXmKPExsWy7bCmru5JqR+xBk8X61vcWneO1WLjjPWs
        Fk8nbGW2mH/lGqvFlj/N7BYLPs1gteh//JrZ4vz5DewWZ5vesFtsegyUvbxrDpvF594jjBYz
        zu9jsljY1MJusfbIXXaL240r2Cz2bT7MYnHwwxNWiycP+9gchD3WzFvD6LFz1l12j8V7XjJ5
        bFrVyeaxeUm9R9+WVYwenzfJBbBHZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqY
        KynkJeam2iq5+AToumXmAP2ipFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNAr
        TswtLs1L10vOz7UyNDAwMgUqTMjOuNvfxVhwoY2pYsn2N8wNjJeeMHYxcnBICJhIfLir3cXI
        xSEksINRYv6VWcwQzidGiQfPl7NDON8YJe58Pc7axcgJ1rHm6kVGEFtIYC+jxM6T9hBF7xkl
        Xix5AlYkLOAicWZSExvIChGBWIkHZ3NBapgFfrNIfLj3iQmkhk1AS2L/ixtsIDa/gKLE1R+P
        wU7iFbCT+LvCDyTMIqAqsX/qSbCRogJhEie3tYDt5RUQlDg58wkLiM0pYC3R3nEMzGYWEJe4
        9WQ+E4QtL9G8dTbYNxICt9glehbcZ4J4wEXi4Yc97BC2sMSr41ugbCmJl/1tUHa1xMqTR9gg
        mjsYJbbsvwD1vbHE/qWTmUAOZRbQlFi/Sx8irCix8/dcRojFfBLvvvawQoKXV6KjTQiiRFni
        8oO7UCdISixu72SbwKg0C8k7s5C8MAvJC7MQli1gZFnFKJZaUJybnlpsWGCMHNubGMHpXMt8
        B+OGcz6HGAU4GJV4eAvKvscKsSaWFVfmHmKU4GBWEuHdoQAU4k1JrKxKLcqPLyrNSS0+xGgK
        DO2JzFKiyfnAXJNXEm9oamRsbGxhYmhmamioJM7L8eNirJBAemJJanZqakFqEUwfEwenVAOj
        qf31ihN7XduNUx9KLtw5+9Xpn2ySOSdrbzq0brD/6l5fdWSH5LLeB0nzSvh/v4z7urTul5FN
        Y3HNsmhutQ8Ml9ZWeT3+rGrII6jGkxicPotLXli37G2Hw4TvyXnLHssEPHu2Y9IX4Ut390gx
        sXh0OqZv3tEx9fjRaA2Bmf/rdQ/fiXB1CTusxFKckWioxVxUnAgAWLlpev0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsWy7bCSnO5JqR+xBtPZLG6tO8dqsXHGelaL
        pxO2MlvMv3KN1WLLn2Z2iwWfZrBa9D9+zWxx/vwGdouzTW/YLTY9Bspe3jWHzeJz7xFGixnn
        9zFZLGxqYbdYe+Quu8XtxhVsFvs2H2axOPjhCavFk4d9bA7CHmvmrWH02DnrLrvH4j0vmTw2
        repk89i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4Mu72dzEWXGhjqliy/Q1zA+OlJ4xd
        jJwcEgImEmuuXgSyuTiEBHYzSsx9do8ZIiEpMe3iUSCbA8gWljh8uBgkLCTwllHi11x1EFtY
        wEXizKQmNhBbRCBW4tO0VmaQOcwC/1kk+o88ZocY+ptZYvvFoywgVWwCWhL7X9wA6+AXUJS4
        +uMxI8gCXgE7ib8r/EDCLAKqEvunnmQFsUUFwiR2LnnMBGLzCghKnJz5BGwMp4C1RHvHMTCb
        WUBd4s+8S8wQtrjErSfzmSBseYnmrbOZJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJybnlts
        WGCYl1quV5yYW1yal66XnJ+7iREc2VqaOxgvL4k/xCjAwajEwytR8j1WiDWxrLgy9xCjBAez
        kgjvDgWgEG9KYmVValF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYwr
        n9xq+mlX5tmamtqSOH0K61KDF0rrd/n53ve2ufh9YTB762XbVEnpazczoicffvH/pq3Bu4+L
        pt1WEbjG3L3q74M+1XqevGvx25/+O3bl26l3huzmW3TSrs52ym1p3ffuJbfIkr1czz//5Hnc
        cntvOYvBnZce6851d3C9q1a0zhKw9jkkdLNUiaU4I9FQi7moOBEAGnQODOgCAAA=
X-CMS-MailID: 20191217000113epcas1p13ed3bdae2650350aa3659aed02d75d06
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113091354eucas1p265de4985d167814f5080fbdf21b75a0a
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091354eucas1p265de4985d167814f5080fbdf21b75a0a@eucas1p2.samsung.com>
        <20191113091336.5218-8-k.konieczny@samsung.com>
        <4942d2ad-fef7-89be-91c1-c02c319546ff@samsung.com>
        <38350d81-e916-b386-6727-f4c85689c172@samsung.com>
        <85a29ce4-0f89-2b50-b046-dba747208933@samsung.com>
        <4ed6b8bf-b415-c42d-33d6-d2ed0504eaf4@samsung.com>
        <d9d13537-f4c9-4420-c3bc-438bc87c5e6a@samsung.com>
        <d710f606-0013-ade3-904e-a56f0404eca7@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukaz,

On 12/16/19 10:01 PM, Lukasz Luba wrote:
> Hi Bartek,
> 
> [added Dietmar, Robin, Andrzej (for upcoming DRM drm-misc-next)]
> 
> On 11/15/19 12:40 PM, Bartlomiej Zolnierkiewicz wrote:
>>
>> [ added Zhang, Eduardo, Ørjan and Javi to Cc: ]
>>
>> On 11/15/19 7:21 AM, Chanwoo Choi wrote:
>>> Hi Bartlomiej,
>>>
>>> On 11/15/19 12:25 PM, Chanwoo Choi wrote:
>>>> Hi Bartlomiej,
>>>>
>>>> On 11/15/19 3:01 AM, Bartlomiej Zolnierkiewicz wrote:
>>>>>
>>>>> Hi Chanwoo,
>>>>>
>>>>> On 11/14/19 2:52 AM, Chanwoo Choi wrote:
>>>>>> Hi Kamil,
>>>>>>
>>>>>> The 'freq_table' and 'max_state' in the devfreq_dev_profile
>>>>>> were used in the ARM Mali device driver[1][2][3]. Although ARM Mali
>>>>>> device driver was posted to mainline kernel, they used
>>>>>> them for a long time. It means that this patch break
>>>>>> the compatibility. The ARM Mali drivers are very
>>>>>> important devfreq device driver.
>>>>>
>>>>> This argument is not a a technical one and the official upstream
>>>>> kernel policy is to not depend on out-of-tree drivers.
>>>>>
>>>>> Besides the ARM Mali drivers are full of code like:
>>>>>
>>>>> #if LINUX_VERSION_CODE >= KERNEL_VERSION(x, y, z)
>>>>> ...
>>>>> #else
>>>>> ...
>>>>> #endif
>>>>>
>>>>> so few more instances of similar code won't do any harm.. ;-)
>>>>>
>>>>>> [1] https://protect2.fireeye.com/url?k=909caa5c-cd52abe8-909d2113-000babdfecba-812f16576c3614a3&u=https://developer.arm.com/tools-and-software/graphics-and-gaming/mali-drivers/bifrost-kernel#
>>>>>> [2] https://protect2.fireeye.com/url?k=33265f96-6ee85e22-3327d4d9-000babdfecba-44c2daec328712e6&u=https://developer.arm.com/tools-and-software/graphics-and-gaming/mali-drivers/midgard-kernel
>>>>>> [3] https://protect2.fireeye.com/url?k=69bdcab0-3473cb04-69bc41ff-000babdfecba-4b576facf85e0208&u=https://developer.arm.com/tools-and-software/graphics-and-gaming/mali-drivers/utgard-kernel
>>>>>
>>>>> I took a look at ARM Mali drivers source code anyway and I fail to
>>>>> see a rationale behind their behavior of doing 'freq_table' and
>>>>> 'max_state' initialization in the driver itself (instead of leaving
>>>>> it up to the devfreq core code, like all in-kernel drivers are doing
>>>>> already).
>>>>>
>>>>> Could you please explain rationale behind ARM Mali drivers' special
>>>>> needs?
>>>>>
>>>>> [ Both ARM Mali and devfreq core code are using generic PM OPP code
>>>>>    these days to do 'freq_table' and 'max_state' initialization, the
>>>>>    only difference seems to be that ARM Mali creates the frequency
>>>>>    table in the descending order (but there also seems to be no real
>>>>>    need for it). ]
>>>>>
>>>>> Maybe this is an opportunity to simplify also the ARM Mali driver?
>>>>
>>>> OK. I agree to simplify them on this time.
>>>> For touching the 'freq_table' and 'max_state', need to fix
>>>> the descending order of freq_table.
>>>>
>>>> The partition_enable_ops() in the drivers/thermal/devfreq_cooling.c
>>>> requires the descending order of freq_table. Have to change it by using
>>>> the ascending time or support both ascending and descending order for freq_table.
>>>>
>>>> 1. Move freq_table, max_state of devfreq_dev_profile to struct devfreq
>>>> 2. Edit partition_enable_ops() in the drivers/thermal/devfreq_cooling.c
>>>>     by using ascending order instead of descending order.
>>>>
>>>
>>> After changed about 'freq_table' and 'max_state', the build error
>>> will happen on ARM mail driver because the initialization code of
>>> 'freq_table' in ARM mali driver, didn't check the kernel version.
>>>
>>> The first devfreq patch provided the 'freq_table' as optional variable
>>> in the 'struct devfreq_dev_profile'. Even if ARM mali driver is out of mainline tree,
>>> this change seems that break the usage rule of 'freq_table' in 'struct devfreq_dev_profile'.
>>>
>>> So, if there are no any beneficial reason, I just keep the current status of 'freq_table'
>>> in order to keep the previous usage rule of 'freq_table' in 'struct devfreq_dev_profile'.
>>>
>>> Frankly, I'm note sure that it is necessary. I don't want to make
>>> the side-effect without any useful reason.
>>>
>>> But,
>>> Separately, have to fix the ordering issue of partition_enable_ops()
>>> in the drivers/thermal/devfreq_cooling.c.
>>
>> Hmmm.. fixing partition_enable_opps() should be trivial but I wonder
>> why we are carrying devfreq_cooling.c code in upstream kernel at all?
> 
> Well, the devfreq_cooling.c is going to have a client in mainline:
> the GPU driver - Panfrost.
> 
> It is already in DRM branch 'drm-misc-next':
> https://protect2.fireeye.com/url?k=75a0e087-283b1ce4-75a16bc8-0cc47a31cdbc-4953aa9e0574f6dc&u=https://patchwork.freedesktop.org/patch/342848/
> 
> Regarding the devfreq_cooling.c code structure.
> I am currently working on cleaning up the devfreq cooling code and
> adding Energy Model instead for private freq, power tables. It will be
> in similar fashion as it is done in cpufreq_cooling. The model will
> be also simplified so hopefully more clients would come.
> It is under internal review and will be posted shortly.

Good news about Energy Model. When you send the patch related to Energy model,
please add me to Cc list.

> 
>>
>> It has been merged in the following commit:
>>
>> commit a76caf55e5b356ba20a5a43ac4d9f7a04b20941d
>> Author: Ørjan Eide <orjan.eide@arm.com>
>> Date:   Thu Sep 10 18:09:30 2015 +0100
>>
>>      thermal: Add devfreq cooling
>>           Add a generic thermal cooling device for devfreq, that is similar to
>>      cpu_cooling.
>>           The device must use devfreq.  In order to use the power extension of the
>>      cooling device, it must have registered its OPPs using the OPP library.
>>           Cc: Zhang Rui <rui.zhang@intel.com>
>>      Cc: Eduardo Valentin <edubezval@gmail.com>
>>      Signed-off-by: Javi Merino <javi.merino@arm.com>
>>      Signed-off-by: Ørjan Eide <orjan.eide@arm.com>
>>      Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
>> ...
>>
>> but 4 years later there is still no single in-kernel user for this code?
> 
> There will be, via DRM tree.
> 
> Regards,
> Lukasz
> 
>>
>> Best regards,
>> -- 
>> Bartlomiej Zolnierkiewicz
>> Samsung R&D Institute Poland
>> Samsung Electronics
>>
>>>>>
>>>>>> Also, the devfreq device driver specifies their own
>>>>>> information and data into devfreq_dev_profile structure
>>>>>> before registering the devfreq device with devfreq_add_device().
>>>>>> This patch breaks the basic usage rule of devfreq_dev_profile structure.
>>>>>
>>>>> Well, 'struct devfreq_stats *stats' can be trivially moved out of
>>>>> 'struct devfreq_profile' to 'struct devfreq' if you prefer it that
>>>>> way..
>>>>>
>>>>> Best regards,
>>>>> -- 
>>>>> Bartlomiej Zolnierkiewicz
>>>>> Samsung R&D Institute Poland
>>>>> Samsung Electronics
>>>>>
>>>>>> So, I can't agree this patch. Not ack.
>>>>>>
>>>>>> Regards,
>>>>>> Chanwoo Choi
>>>>>>
>>>>>> On 11/13/19 6:13 PM, Kamil Konieczny wrote:
>>>>>>> Count time and transitions between devfreq frequencies in separate struct
>>>>>>> for improved code readability and maintenance.
>>>>>>>
>>>>>>> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
>>>>>>> ---
>>>>>>>   drivers/devfreq/devfreq.c          | 156 ++++++++++++++++-------------
>>>>>>>   drivers/devfreq/exynos-bus.c       |   6 +-
>>>>>>>   drivers/devfreq/governor_passive.c |  26 +++--
>>>>>>>   include/linux/devfreq.h            |  43 ++++----
>>>>>>>   4 files changed, 129 insertions(+), 102 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>>>> index d79412b0de59..d85867a91230 100644
>>>>>>> --- a/drivers/devfreq/devfreq.c
>>>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>>>> @@ -105,10 +105,11 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>>>>>>>    */
>>>>>>>   static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
>>>>>>>   {
>>>>>>> +    struct devfreq_stats *stats = devfreq->profile->stats;
>>>>>>>       int lev;
>>>>>>>   -    for (lev = 0; lev < devfreq->profile->max_state; lev++)
>>>>>>> -        if (freq == devfreq->profile->freq_table[lev])
>>>>>>> +    for (lev = 0; lev < stats->max_state; lev++)
>>>>>>> +        if (freq == stats->freq_table[lev])
>>>>>>>               return lev;
>>>>>>>         return -EINVAL;
>>>>>>> @@ -117,56 +118,64 @@ static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
>>>>>>>   static int set_freq_table(struct devfreq *devfreq)
>>>>>>>   {
>>>>>>>       struct devfreq_dev_profile *profile = devfreq->profile;
>>>>>>> +    struct devfreq_stats *stats;
>>>>>>>       struct dev_pm_opp *opp;
>>>>>>>       unsigned long freq;
>>>>>>> -    int i, count;
>>>>>>> +    int i, count, err = -ENOMEM;
>>>>>>>         /* Initialize the freq_table from OPP table */
>>>>>>>       count = dev_pm_opp_get_opp_count(devfreq->dev.parent);
>>>>>>>       if (count <= 0)
>>>>>>>           return -EINVAL;
>>>>>>>   -    profile->max_state = count;
>>>>>>> -    profile->freq_table = devm_kcalloc(devfreq->dev.parent,
>>>>>>> -                    count,
>>>>>>> -                    sizeof(*profile->freq_table),
>>>>>>> -                    GFP_KERNEL);
>>>>>>> -    if (!profile->freq_table) {
>>>>>>> -        profile->max_state = 0;
>>>>>>> +    stats = devm_kzalloc(devfreq->dev.parent,
>>>>>>> +                 sizeof(struct devfreq_stats), GFP_KERNEL);
>>>>>>> +    if (!stats)
>>>>>>>           return -ENOMEM;
>>>>>>> -    }
>>>>>>>   -    for (i = 0, freq = 0; i < profile->max_state; i++, freq++) {
>>>>>>> +    profile->stats = stats;
>>>>>>> +    stats->max_state = count;
>>>>>>> +    stats->freq_table = devm_kcalloc(devfreq->dev.parent,
>>>>>>> +                     count,
>>>>>>> +                     sizeof(*stats->freq_table),
>>>>>>> +                     GFP_KERNEL);
>>>>>>> +    if (!stats->freq_table)
>>>>>>> +        goto err_no_mem;
>>>>>>> +
>>>>>>> +    for (i = 0, freq = 0; i < count; i++, freq++) {
>>>>>>>           opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &freq);
>>>>>>>           if (IS_ERR(opp)) {
>>>>>>> -            devm_kfree(devfreq->dev.parent, profile->freq_table);
>>>>>>> -            profile->max_state = 0;
>>>>>>> -            return PTR_ERR(opp);
>>>>>>> +            devm_kfree(devfreq->dev.parent, stats->freq_table);
>>>>>>> +            stats->max_state = 0;
>>>>>>> +            err = PTR_ERR(opp);
>>>>>>> +            goto err_no_mem;
>>>>>>>           }
>>>>>>>           dev_pm_opp_put(opp);
>>>>>>> -        profile->freq_table[i] = freq;
>>>>>>> +        stats->freq_table[i] = freq;
>>>>>>>       }
>>>>>>>   -    profile->trans_table = devm_kzalloc(devfreq->dev.parent,
>>>>>>> -                        array3_size(sizeof(unsigned int),
>>>>>>> -                            count, count),
>>>>>>> -                        GFP_KERNEL);
>>>>>>> -    if (!profile->trans_table)
>>>>>>> +    stats->trans_table = devm_kzalloc(devfreq->dev.parent,
>>>>>>> +                      array3_size(sizeof(unsigned int),
>>>>>>> +                              count, count),
>>>>>>> +                      GFP_KERNEL);
>>>>>>> +    if (!stats->trans_table)
>>>>>>>           goto err_no_mem;
>>>>>>>   -    profile->time_in_state = devm_kcalloc(devfreq->dev.parent, count,
>>>>>>> -                          sizeof(*profile->time_in_state),
>>>>>>> -                          GFP_KERNEL);
>>>>>>> -    if (!profile->time_in_state)
>>>>>>> +    stats->time_in_state = devm_kcalloc(devfreq->dev.parent, count,
>>>>>>> +                        sizeof(*stats->time_in_state),
>>>>>>> +                        GFP_KERNEL);
>>>>>>> +    if (!stats->time_in_state)
>>>>>>>           goto err_no_mem;
>>>>>>>   -    profile->last_time = get_jiffies_64();
>>>>>>> -    spin_lock_init(&profile->stats_lock);
>>>>>>> +    stats->last_time = get_jiffies_64();
>>>>>>> +    spin_lock_init(&stats->stats_lock);
>>>>>>>         return 0;
>>>>>>>   err_no_mem:
>>>>>>> -    profile->max_state = 0;
>>>>>>> -    return -ENOMEM;
>>>>>>> +    stats->max_state = 0;
>>>>>>> +    devm_kfree(devfreq->dev.parent, profile->stats);
>>>>>>> +    profile->stats = NULL;
>>>>>>> +    return err;
>>>>>>>   }
>>>>>>>     /**
>>>>>>> @@ -176,7 +185,7 @@ static int set_freq_table(struct devfreq *devfreq)
>>>>>>>    */
>>>>>>>   int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>>>>>>   {
>>>>>>> -    struct devfreq_dev_profile *profile = devfreq->profile;
>>>>>>> +    struct devfreq_stats *stats = devfreq->profile->stats;
>>>>>>>       unsigned long long cur_time;
>>>>>>>       int lev, prev_lev, ret = 0;
>>>>>>>   @@ -184,22 +193,21 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>>>>>>         /* Immediately exit if previous_freq is not initialized yet. */
>>>>>>>       if (!devfreq->previous_freq) {
>>>>>>> -        spin_lock(&profile->stats_lock);
>>>>>>> -        profile->last_time = cur_time;
>>>>>>> -        spin_unlock(&profile->stats_lock);
>>>>>>> +        spin_lock(&stats->stats_lock);
>>>>>>> +        stats->last_time = cur_time;
>>>>>>> +        spin_unlock(&stats->stats_lock);
>>>>>>>           return 0;
>>>>>>>       }
>>>>>>>         prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
>>>>>>>   -    spin_lock(&profile->stats_lock);
>>>>>>> +    spin_lock(&stats->stats_lock);
>>>>>>>       if (prev_lev < 0) {
>>>>>>>           ret = prev_lev;
>>>>>>>           goto out;
>>>>>>>       }
>>>>>>>   -    profile->time_in_state[prev_lev] +=
>>>>>>> -             cur_time - profile->last_time;
>>>>>>> +    stats->time_in_state[prev_lev] += cur_time - stats->last_time;
>>>>>>>       lev = devfreq_get_freq_level(devfreq, freq);
>>>>>>>       if (lev < 0) {
>>>>>>>           ret = lev;
>>>>>>> @@ -207,14 +215,14 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>>>>>>       }
>>>>>>>         if (lev != prev_lev) {
>>>>>>> -        profile->trans_table[(prev_lev *
>>>>>>> -                profile->max_state) + lev]++;
>>>>>>> -        profile->total_trans++;
>>>>>>> +        stats->trans_table[(prev_lev *
>>>>>>> +                stats->max_state) + lev]++;
>>>>>>> +        stats->total_trans++;
>>>>>>>       }
>>>>>>>     out:
>>>>>>> -    profile->last_time = cur_time;
>>>>>>> -    spin_unlock(&profile->stats_lock);
>>>>>>> +    stats->last_time = cur_time;
>>>>>>> +    spin_unlock(&stats->stats_lock);
>>>>>>>       return ret;
>>>>>>>   }
>>>>>>>   EXPORT_SYMBOL(devfreq_update_status);
>>>>>>> @@ -504,9 +512,9 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>>>>>>>           queue_delayed_work(devfreq_wq, &devfreq->work,
>>>>>>>               msecs_to_jiffies(profile->polling_ms));
>>>>>>>   -    spin_lock(&profile->stats_lock);
>>>>>>> -    profile->last_time = get_jiffies_64();
>>>>>>> -    spin_unlock(&profile->stats_lock);
>>>>>>> +    spin_lock(&profile->stats->stats_lock);
>>>>>>> +    profile->stats->last_time = get_jiffies_64();
>>>>>>> +    spin_unlock(&profile->stats->stats_lock);
>>>>>>>       devfreq->stop_polling = false;
>>>>>>>         if (profile->get_cur_freq &&
>>>>>>> @@ -677,7 +685,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>>>       devfreq->data = data;
>>>>>>>       devfreq->nb.notifier_call = devfreq_notifier_call;
>>>>>>>   -    if (!profile->max_state && !profile->freq_table) {
>>>>>>> +    if (!profile->stats) {
>>>>>>>           mutex_unlock(&devfreq->lock);
>>>>>>>           err = set_freq_table(devfreq);
>>>>>>>           if (err < 0)
>>>>>>> @@ -1282,6 +1290,7 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>>>>>>>                     const char *buf, size_t count)
>>>>>>>   {
>>>>>>>       struct devfreq *df = to_devfreq(dev);
>>>>>>> +    struct devfreq_stats *stats = df->profile->stats;
>>>>>>>       unsigned long value;
>>>>>>>       int ret;
>>>>>>>   @@ -1297,13 +1306,13 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>>>>>>>               goto unlock;
>>>>>>>           }
>>>>>>>       } else {
>>>>>>> -        unsigned long *freq_table = df->profile->freq_table;
>>>>>>> +        unsigned long *freq_table = stats->freq_table;
>>>>>>>             /* Get minimum frequency according to sorting order */
>>>>>>> -        if (freq_table[0] < freq_table[df->profile->max_state - 1])
>>>>>>> +        if (freq_table[0] < freq_table[stats->max_state - 1])
>>>>>>>               value = freq_table[0];
>>>>>>>           else
>>>>>>> -            value = freq_table[df->profile->max_state - 1];
>>>>>>> +            value = freq_table[stats->max_state - 1];
>>>>>>>       }
>>>>>>>         df->min_freq = value;
>>>>>>> @@ -1326,6 +1335,7 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>>>>>>>                     const char *buf, size_t count)
>>>>>>>   {
>>>>>>>       struct devfreq *df = to_devfreq(dev);
>>>>>>> +    struct devfreq_stats *stats = df->profile->stats;
>>>>>>>       unsigned long value;
>>>>>>>       int ret;
>>>>>>>   @@ -1341,11 +1351,11 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>>>>>>>               goto unlock;
>>>>>>>           }
>>>>>>>       } else {
>>>>>>> -        unsigned long *freq_table = df->profile->freq_table;
>>>>>>> +        unsigned long *freq_table = stats->freq_table;
>>>>>>>             /* Get maximum frequency according to sorting order */
>>>>>>> -        if (freq_table[0] < freq_table[df->profile->max_state - 1])
>>>>>>> -            value = freq_table[df->profile->max_state - 1];
>>>>>>> +        if (freq_table[0] < freq_table[stats->max_state - 1])
>>>>>>> +            value = freq_table[stats->max_state - 1];
>>>>>>>           else
>>>>>>>               value = freq_table[0];
>>>>>>>       }
>>>>>>> @@ -1373,14 +1383,15 @@ static ssize_t available_frequencies_show(struct device *d,
>>>>>>>                         char *buf)
>>>>>>>   {
>>>>>>>       struct devfreq *df = to_devfreq(d);
>>>>>>> +    struct devfreq_stats *stats = df->profile->stats;
>>>>>>>       ssize_t count = 0;
>>>>>>>       int i;
>>>>>>>         mutex_lock(&df->lock);
>>>>>>>   -    for (i = 0; i < df->profile->max_state; i++)
>>>>>>> +    for (i = 0; i < stats->max_state; i++)
>>>>>>>           count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
>>>>>>> -                "%lu ", df->profile->freq_table[i]);
>>>>>>> +                "%lu ", stats->freq_table[i]);
>>>>>>>         mutex_unlock(&df->lock);
>>>>>>>       /* Truncate the trailing space */
>>>>>>> @@ -1398,9 +1409,10 @@ static ssize_t trans_stat_show(struct device *dev,
>>>>>>>   {
>>>>>>>       struct devfreq *devfreq = to_devfreq(dev);
>>>>>>>       struct devfreq_dev_profile *profile = devfreq->profile;
>>>>>>> +    struct devfreq_stats *stats = profile->stats;
>>>>>>> +    unsigned int max_state = stats->max_state;
>>>>>>>       ssize_t len;
>>>>>>>       int i, j;
>>>>>>> -    unsigned int max_state = profile->max_state;
>>>>>>>         if (!devfreq->stop_polling &&
>>>>>>>               devfreq_update_status(devfreq, devfreq->previous_freq))
>>>>>>> @@ -1411,45 +1423,45 @@ static ssize_t trans_stat_show(struct device *dev,
>>>>>>>       len = sprintf(buf, "     From  :   To\n");
>>>>>>>       len += sprintf(buf + len, "           :");
>>>>>>>   -    spin_lock(&profile->stats_lock);
>>>>>>> +    spin_lock(&stats->stats_lock);
>>>>>>>       for (i = 0; i < max_state; i++)
>>>>>>>           len += sprintf(buf + len, "%10lu",
>>>>>>> -                profile->freq_table[i]);
>>>>>>> +                stats->freq_table[i]);
>>>>>>>         len += sprintf(buf + len, "   time(ms)\n");
>>>>>>>         for (i = 0; i < max_state; i++) {
>>>>>>> -        if (profile->freq_table[i] == devfreq->previous_freq)
>>>>>>> +        if (stats->freq_table[i] == devfreq->previous_freq)
>>>>>>>               len += sprintf(buf + len, "*");
>>>>>>>           else
>>>>>>>               len += sprintf(buf + len, " ");
>>>>>>>             len += sprintf(buf + len, "%10lu:",
>>>>>>> -                profile->freq_table[i]);
>>>>>>> +                stats->freq_table[i]);
>>>>>>>           for (j = 0; j < max_state; j++)
>>>>>>>               len += sprintf(buf + len, "%10u",
>>>>>>> -                profile->trans_table[(i * max_state) + j]);
>>>>>>> +                stats->trans_table[(i * max_state) + j]);
>>>>>>>           len += sprintf(buf + len, "%10llu\n", (u64)
>>>>>>> -            jiffies64_to_msecs(profile->time_in_state[i]));
>>>>>>> +            jiffies64_to_msecs(stats->time_in_state[i]));
>>>>>>>       }
>>>>>>>         len += sprintf(buf + len, "Total transition : %u\n",
>>>>>>> -                    profile->total_trans);
>>>>>>> -    spin_unlock(&profile->stats_lock);
>>>>>>> +                    stats->total_trans);
>>>>>>> +    spin_unlock(&stats->stats_lock);
>>>>>>>       return len;
>>>>>>>   }
>>>>>>>   static DEVICE_ATTR_RO(trans_stat);
>>>>>>>   -static void defvreq_stats_clear_table(struct devfreq_dev_profile *profile)
>>>>>>> +static void defvreq_stats_clear_table(struct devfreq_stats *stats)
>>>>>>>   {
>>>>>>> -    unsigned int count = profile->max_state;
>>>>>>> -
>>>>>>> -    spin_lock(&profile->stats_lock);
>>>>>>> -    memset(profile->time_in_state, 0, count * sizeof(u64));
>>>>>>> -    memset(profile->trans_table, 0, count * count * sizeof(int));
>>>>>>> -    profile->last_time = get_jiffies_64();
>>>>>>> -    profile->total_trans = 0;
>>>>>>> -    spin_unlock(&profile->stats_lock);
>>>>>>> +    unsigned int count = stats->max_state;
>>>>>>> +
>>>>>>> +    spin_lock(&stats->stats_lock);
>>>>>>> +    memset(stats->time_in_state, 0, count * sizeof(u64));
>>>>>>> +    memset(stats->trans_table, 0, count * count * sizeof(int));
>>>>>>> +    stats->last_time = get_jiffies_64();
>>>>>>> +    stats->total_trans = 0;
>>>>>>> +    spin_unlock(&stats->stats_lock);
>>>>>>>   }
>>>>>>>     static ssize_t trans_reset_store(struct device *dev,
>>>>>>> @@ -1459,7 +1471,7 @@ static ssize_t trans_reset_store(struct device *dev,
>>>>>>>   {
>>>>>>>       struct devfreq *devfreq = to_devfreq(dev);
>>>>>>>   -    defvreq_stats_clear_table(devfreq->profile);
>>>>>>> +    defvreq_stats_clear_table(devfreq->profile->stats);
>>>>>>>         return count;
>>>>>>>   }
>>>>>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>>>>>> index d9f377912c10..b212aae2bb3e 100644
>>>>>>> --- a/drivers/devfreq/exynos-bus.c
>>>>>>> +++ b/drivers/devfreq/exynos-bus.c
>>>>>>> @@ -496,9 +496,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>>>>>       }
>>>>>>>     out:
>>>>>>> -    max_state = bus->devfreq->profile->max_state;
>>>>>>> -    min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
>>>>>>> -    max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
>>>>>>> +    max_state = profile->stats->max_state;
>>>>>>> +    min_freq = (profile->stats->freq_table[0] / 1000);
>>>>>>> +    max_freq = (profile->stats->freq_table[max_state - 1] / 1000);
>>>>>>>       pr_info("exynos-bus: new bus device registered: %s (%6ld KHz ~ %6ld KHz)\n",
>>>>>>>               dev_name(dev), min_freq, max_freq);
>>>>>>>   diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>>>>>>> index 58308948b863..b2d87a88335c 100644
>>>>>>> --- a/drivers/devfreq/governor_passive.c
>>>>>>> +++ b/drivers/devfreq/governor_passive.c
>>>>>>> @@ -18,6 +18,8 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>>>>>>       struct devfreq_passive_data *p_data
>>>>>>>               = (struct devfreq_passive_data *)devfreq->data;
>>>>>>>       struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
>>>>>>> +    struct devfreq_stats *parent_stats = parent_devfreq->profile->stats;
>>>>>>> +    struct devfreq_stats *stats;
>>>>>>>       unsigned long child_freq = ULONG_MAX;
>>>>>>>       struct dev_pm_opp *opp;
>>>>>>>       int i, count, ret = 0;
>>>>>>> @@ -47,10 +49,14 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>>>>>>        * device. And then the index is used for getting the suitable
>>>>>>>        * new frequency for passive devfreq device.
>>>>>>>        */
>>>>>>> -    if (!devfreq->profile || !devfreq->profile->freq_table
>>>>>>> -        || devfreq->profile->max_state <= 0)
>>>>>>> +    if (!devfreq->profile || !devfreq->profile->stats ||
>>>>>>> +        devfreq->profile->stats->max_state <= 0 ||
>>>>>>> +        !parent_devfreq->profile ||    !parent_devfreq->profile->stats ||
>>>>>>> +        parent_devfreq->profile->stats->max_state <= 0)
>>>>>>>           return -EINVAL;
>>>>>>>   +    stats = devfreq->profile->stats;
>>>>>>> +    parent_stats = parent_devfreq->profile->stats;
>>>>>>>       /*
>>>>>>>        * The passive governor have to get the correct frequency from OPP
>>>>>>>        * list of parent device. Because in this case, *freq is temporary
>>>>>>> @@ -68,21 +74,21 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>>>>>>        * Get the OPP table's index of decided freqeuncy by governor
>>>>>>>        * of parent device.
>>>>>>>        */
>>>>>>> -    for (i = 0; i < parent_devfreq->profile->max_state; i++)
>>>>>>> -        if (parent_devfreq->profile->freq_table[i] == *freq)
>>>>>>> +    for (i = 0; i < parent_stats->max_state; i++)
>>>>>>> +        if (parent_stats->freq_table[i] == *freq)
>>>>>>>               break;
>>>>>>>   -    if (i == parent_devfreq->profile->max_state) {
>>>>>>> +    if (i == parent_stats->max_state) {
>>>>>>>           ret = -EINVAL;
>>>>>>>           goto out;
>>>>>>>       }
>>>>>>>         /* Get the suitable frequency by using index of parent device. */
>>>>>>> -    if (i < devfreq->profile->max_state) {
>>>>>>> -        child_freq = devfreq->profile->freq_table[i];
>>>>>>> +    if (i < stats->max_state) {
>>>>>>> +        child_freq = stats->freq_table[i];
>>>>>>>       } else {
>>>>>>> -        count = devfreq->profile->max_state;
>>>>>>> -        child_freq = devfreq->profile->freq_table[count - 1];
>>>>>>> +        count = stats->max_state;
>>>>>>> +        child_freq = stats->freq_table[count - 1];
>>>>>>>       }
>>>>>>>         /* Return the suitable frequency for passive device. */
>>>>>>> @@ -109,7 +115,7 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
>>>>>>>       if (ret < 0)
>>>>>>>           goto out;
>>>>>>>   -    if (devfreq->profile->freq_table
>>>>>>> +    if (devfreq->profile->stats
>>>>>>>           && (devfreq_update_status(devfreq, freq)))
>>>>>>>           dev_err(&devfreq->dev,
>>>>>>>               "Couldn't update frequency transition information.\n");
>>>>>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>>>>>> index 4ceb2a517a9c..8459af1a1583 100644
>>>>>>> --- a/include/linux/devfreq.h
>>>>>>> +++ b/include/linux/devfreq.h
>>>>>>> @@ -64,6 +64,30 @@ struct devfreq_dev_status {
>>>>>>>    */
>>>>>>>   #define DEVFREQ_FLAG_LEAST_UPPER_BOUND        0x1
>>>>>>>   +/**
>>>>>>> + * struct devfreq_stats - Devfreq's transitions stats counters
>>>>>>> + * @freq_table:        Optional list of frequencies to support statistics
>>>>>>> + *            and freq_table must be generated in ascending order.
>>>>>>> + * @max_state:        The size of freq_table.
>>>>>>> + * @total_trans:    Number of devfreq transitions
>>>>>>> + * @trans_table:    Statistics of devfreq transitions
>>>>>>> + * @time_in_state:    Statistics of devfreq states
>>>>>>> + * @last_time:        The last time stats were updated
>>>>>>> + * @stats_lock:        Lock protecting trans_table, time_in_state,
>>>>>>> + *            last_time and total_trans used for statistics
>>>>>>> + */
>>>>>>> +struct devfreq_stats {
>>>>>>> +    unsigned long *freq_table;
>>>>>>> +    unsigned int max_state;
>>>>>>> +
>>>>>>> +    /* information for device frequency transition */
>>>>>>> +    unsigned int total_trans;
>>>>>>> +    unsigned int *trans_table;
>>>>>>> +    u64 *time_in_state;
>>>>>>> +    unsigned long long last_time;
>>>>>>> +    spinlock_t stats_lock;
>>>>>>> +};
>>>>>>> +
>>>>>>>   /**
>>>>>>>    * struct devfreq_dev_profile - Devfreq's user device profile
>>>>>>>    * @initial_freq:    The operating frequency when devfreq_add_device() is
>>>>>>> @@ -88,15 +112,7 @@ struct devfreq_dev_status {
>>>>>>>    *            from devfreq_remove_device() call. If the user
>>>>>>>    *            has registered devfreq->nb at a notifier-head,
>>>>>>>    *            this is the time to unregister it.
>>>>>>> - * @freq_table:        Optional list of frequencies to support statistics
>>>>>>> - *            and freq_table must be generated in ascending order.
>>>>>>> - * @max_state:        The size of freq_table.
>>>>>>> - * @total_trans:    Number of devfreq transitions
>>>>>>> - * @trans_table:    Statistics of devfreq transitions
>>>>>>> - * @time_in_state:    Statistics of devfreq states
>>>>>>> - * @last_time:        The last time stats were updated
>>>>>>> - * @stats_lock:        Lock protecting trans_table, time_in_state,
>>>>>>> - *            last_time and total_trans used for statistics
>>>>>>> + * @stats:        Statistics of devfreq states and state transitions
>>>>>>>    */
>>>>>>>   struct devfreq_dev_profile {
>>>>>>>       unsigned long initial_freq;
>>>>>>> @@ -108,14 +124,7 @@ struct devfreq_dev_profile {
>>>>>>>       int (*get_cur_freq)(struct device *dev, unsigned long *freq);
>>>>>>>       void (*exit)(struct device *dev);
>>>>>>>   -    unsigned long *freq_table;
>>>>>>> -    unsigned int max_state;
>>>>>>> -    /* information for device frequency transition */
>>>>>>> -    unsigned int total_trans;
>>>>>>> -    unsigned int *trans_table;
>>>>>>> -    u64 *time_in_state;
>>>>>>> -    unsigned long long last_time;
>>>>>>> -    spinlock_t stats_lock;
>>>>>>> +    struct devfreq_stats *stats;
>>>>>>>   };
>>>>>>>     /**
>>>>>>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> https://protect2.fireeye.com/url?k=856913bb-d8f2efd8-856898f4-0cc47a31cdbc-5cb40ce5f31ed8ed&u=http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
