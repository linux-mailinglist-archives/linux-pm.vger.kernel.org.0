Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A020B058
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 13:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgFZLWn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 07:22:43 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41030 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgFZLWn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 07:22:43 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200626112241euoutp027e49e0d1d64f7c8c54b339f63b7f79a7~cFC86CTLf1252312523euoutp02F
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2020 11:22:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200626112241euoutp027e49e0d1d64f7c8c54b339f63b7f79a7~cFC86CTLf1252312523euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593170561;
        bh=oYAxSME9rGr+KdmCubJZndLweXdUns26lunyy7YRftc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=S4PDTMbjPkbp5Zkm8uVkE0wUDlSRG15QWfidONIFSUCoeWYB/dPRoAPqTxBvZyfDz
         E786sB8o6yDUd1i4xet+Ogss9lP2PQIkl7G44VRjVTGGsnC1ZRcHEx5Tu1PD2DjUyt
         lZZWQsNXyeFBvo3OlA4q2NpBJT0f0U7jc/VbWPwE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200626112240eucas1p223ac51a4c3c2d2d7abc6dbdd9f8cb921~cFC8lkAZp1651616516eucas1p2h;
        Fri, 26 Jun 2020 11:22:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6A.98.06318.08AD5FE5; Fri, 26
        Jun 2020 12:22:40 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200626112240eucas1p137a7bda25922a02faec6ee6f3c5b5c4f~cFC8NmtFs1960819608eucas1p1g;
        Fri, 26 Jun 2020 11:22:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200626112240eusmtrp1c2d7840e1fc2b85a059df1d67667114f~cFC8MyUO71855018550eusmtrp1i;
        Fri, 26 Jun 2020 11:22:40 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-18-5ef5da806ee3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 86.F1.06017.08AD5FE5; Fri, 26
        Jun 2020 12:22:40 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200626112239eusmtip1541fce56f819f0cfa8cd94a4a9d15e6b~cFC7qffwH1044410444eusmtip1K;
        Fri, 26 Jun 2020 11:22:39 +0000 (GMT)
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Kamil Konieczny <k.konieczny@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <ad4e1a73-6de3-68ee-e3b3-b30bc315bd31@samsung.com>
Date:   Fri, 26 Jun 2020 13:22:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ee2e4acb-3986-3227-da1f-177d2756d194@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSyUcRzf756753nI6XHId3rbbmXrjYq1ZzTRoptq+aeojbryhLzuzkuy
        SjQkClfhJm8zL5dhl3mrLjs5IW8zMrQJJXIxR9RkuXtY/vt8ft/P5/P9frYfiQm6eNZkYGgE
        IwkVBwtxY26t5nfXobihRd/D43MO9KeFSR5dMJ/No5+M/8Do7u5qgu6MnyFo5fgAj+5rzMVp
        Xdp7RGd3qzh0YfwDgh6+X4bTzTNJPPrXhzHkwhdV5FUgUYP8MyFSKh7iolfF90SPaxRIpFPu
        8sQvGx/3Y4IDoxiJnfNV4wD10ggRPm97ayIjDcUhlU0KMiKBcoDy+iyUgoxJAVWGIHm6EWPJ
        AoKcF73rRIdgsvQlZ8PSK1sm2EEpgsTB1xyWaBG0ZrcQepU55Qz5A408PbagzsAjdZzBgVE6
        DHSFzYYonHKEjCQF0mP+mkHWXIvrMZfaC1+etxmCLClvmB9t5rEaM2jLmeDqsRF1AlQNRQY9
        RlnB0EQ+h8W7oU6ba7gbqCkCNB39a0HkGjkFb/JM2ArmMN1aQ7B4B3TIUrmsvhLB3+Tv6+Y6
        BKWyVZxVOcFI1x9cH4RR+6Cq0Y59dgWtZgZj801hUGvG3mAKmbVZ6898SE4UsGobqC6pxjfW
        pjSUY+lIKN/UTL6pjXxTG/n/vQWIq0BWTKQ0xJ+R2ocy0bZScYg0MtTf9npYiBKt/bKO1dbF
        eqRauaZGFImEJvymjAVfAU8cJY0JUSMgMaEF/2Rnh6+A7yeOuc1Iwq5IIoMZqRptJ7lCK759
        0ZSPgPIXRzBBDBPOSDamHNLIOg65cCsL7t7oaYem9lEji1SnQa3lMMeuWDOr8TrfM58gc9y5
        7LNV9q3KY0vJWbuWFOG5oFzvgZ/RfZfczKxFS+61gqKvBxXiO5E3LQLcZ98+uyDnS7a92zPn
        mreYrmkZE2bn1lUXj3AyV5aPeczVlHgeFXklzD09MNF/MdatO/a0/0chVxogPrIfk0jF/wBc
        eMSgYQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsVy+t/xu7oNt77GGZy4IWNx/ctzVosFn2aw
        WvQ/fs1scf78BnaLs01v2C02Pb7GanF51xw2i8+9RxgtZpzfx2SxsKmF3eJ24wo2i8Nv2lkt
        vp14xOjA67Fm3hpGj52z7rJ7bFrVyeaxeUm9R9+WVYwenzfJBbBF6dkU5ZeWpCpk5BeX2CpF
        G1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GUc+n6HveCTXsWTib2MDYz71LoY
        OTkkBEwkLk7+wd7FyMUhJLCUUeLzi2NADgdQQkbi+PoyiBphiT/Xutggal4zSuw/eY8FJCEs
        YCcx/9ouVhBbRMBbovtQA9ggZoGfzBKf585jBkkICaxhkfjzqR7EZhOwkpjYvooRxOYFap58
        eBsbiM0ioCrxcNpJdhBbVCBC4vCOWVA1ghInZz4BW8YpYC+xb+cisHpmAXWJP/MuMUPY4hK3
        nsxngrDlJba/ncM8gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GIjveLE3OLSvHS95Pzc
        TYzAyN127OeWHYxd74IPMQpwMCrx8B6Y+CVOiDWxrLgy9xCjBAezkgiv09nTcUK8KYmVValF
        +fFFpTmpxYcYTYGem8gsJZqcD0wqeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1ML
        Uotg+pg4OKUaGIVrvjLt95z1asGc1nQn71ierkOTbD5Uh3G+Y64x+Pdx88+SRYv8HzMvzC5Z
        K+ekwhJ4sej5Uw3lHDuuwvWPP579lP/vs4jenA1sZdXlatN3iEovXbfk5bmjEr4ljseWWn9m
        2rZazjRAX0xS6ayHOX/lbrmy40JG7nf0rFoKT698ZLr/NY/nJiWW4oxEQy3mouJEAE/eSVvy
        AgAA
X-CMS-MailID: 20200626112240eucas1p137a7bda25922a02faec6ee6f3c5b5c4f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3
References: <20200623164733.qbhua7b6cg2umafj@macmini.local>
        <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
        <20200623191129.GA4171@kozik-lap>
        <CGME20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3@eucas1p1.samsung.com>
        <85f5a8c0-7d48-f2cd-3385-c56d662f2c88@arm.com>
        <ef5184ed-00ff-4226-5ece-b0fc8eb16fb6@samsung.com>
        <4a72fcab-e8da-8323-1fbe-98a6a4b3e0f1@arm.com>
        <4c3b01af-2337-1eba-4675-6488105144c8@samsung.com>
        <6f8b1119-62b1-942d-cfde-6f1e9a28c40c@arm.com>
        <ee2e4acb-3986-3227-da1f-177d2756d194@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 6/25/20 2:12 PM, Kamil Konieczny wrote:
> On 25.06.2020 14:02, Lukasz Luba wrote:
>>
>>
>> On 6/25/20 12:30 PM, Kamil Konieczny wrote:
>>> Hi Lukasz,
>>>
>>> On 25.06.2020 12:02, Lukasz Luba wrote:
>>>> Hi Sylwester,
>>>>
>>>> On 6/24/20 4:11 PM, Sylwester Nawrocki wrote:
>>>>> Hi All,
>>>>>
>>>>> On 24.06.2020 12:32, Lukasz Luba wrote:
>>>>>> I had issues with devfreq governor which wasn't called by devfreq
>>>>>> workqueue. The old DELAYED vs DEFERRED work discussions and my patches
>>>>>> for it [1]. If the CPU which scheduled the next work went idle, the
>>>>>> devfreq workqueue will not be kicked and devfreq governor won't check
>>>>>> DMC status and will not decide to decrease the frequency based on low
>>>>>> busy_time.
>>>>>> The same applies for going up with the frequency. They both are
>>>>>> done by the governor but the workqueue must be scheduled periodically.
>>>>>
>>>>> As I have been working on resolving the video mixer IOMMU fault issue
>>>>> described here: https://patchwork.kernel.org/patch/10861757
>>>>> I did some investigation of the devfreq operation, mostly on Odroid U3.
>>>>>
>>>>> My conclusions are similar to what Lukasz says above. I would like to add
>>>>> that broken scheduling of the performance counters read and the devfreq
>>>>> updates seems to have one more serious implication. In each call, which
>>>>> normally should happen periodically with fixed interval we stop the counters,
>>>>> read counter values and start the counters again. But if period between
>>>>> calls becomes long enough to let any of the counters overflow, we will
>>>>> get wrong performance measurement results. My observations are that
>>>>> the workqueue job can be suspended for several seconds and conditions for
>>>>> the counter overflow occur sooner or later, depending among others
>>>>> on the CPUs load.
>>>>> Wrong bus load measurement can lead to setting too low interconnect bus
>>>>> clock frequency and then bad things happen in peripheral devices.
>>>>>
>>>>> I agree the workqueue issue needs to be fixed. I have some WIP code to use
>>>>> the performance counters overflow interrupts instead of SW polling and with
>>>>> that the interconnect bus clock control seems to work much better.
>>>>>
>>>>
>>>> Thank you for sharing your use case and investigation results. I think
>>>> we are reaching a decent number of developers to maybe address this
>>>> issue: 'workqueue issue needs to be fixed'.
>>>> I have been facing this devfreq workqueue issue ~5 times in different
>>>> platforms.
>>>>
>>>> Regarding the 'performance counters overflow interrupts' there is one
>>>> thing worth to keep in mind: variable utilization and frequency.
>>>> For example, in order to make a conclusion in algorithm deciding that
>>>> the device should increase or decrease the frequency, we fix the period
>>>> of observation, i.e. to 500ms. That can cause the long delay if the
>>>> utilization of the device suddenly drops. For example we set an
>>>> overflow threshold to value i.e. 1000 and we know that at 1000MHz
>>>> and full utilization (100%) the counter will reach that threshold
>>>> after 500ms (which we want, because we don't want too many interrupts
>>>> per sec). What if suddenly utilization drops to 2% (i.e. from 5GB/s
>>>> to 250MB/s (what if it drops to 25MB/s?!)), the counter will reach the
>>>> threshold after 50*500ms = 25s. It is impossible just for the counters
>>>> to predict next utilization and adjust the threshold. [...]
>>>
>>> irq triggers for underflow and overflow, so driver can adjust freq
>>>
>>
>> Probably possible on some platforms, depends on how many PMU registers
>> are available, what information can be can assign to them and type of
>> interrupt. A lot of hassle and still - platform and device specific.
>> Also, drivers should not adjust the freq, governors (different types
>> of them with different settings that they can handle) should do it.
>>
>> What the framework can do is to take this responsibility and provide
>> generic way to monitor the devices (or stop if they are suspended).
>> That should work nicely with the governors, which try to predict the
>> next best frequency. From my experience the more fluctuating intervals
>> the governors are called, the more odd decisions they make.
>> That's why I think having a predictable interval i.e. 100ms is something
>> desirable. Tuning the governors is easier in this case, statistics
>> are easier to trace and interpret, solution is not to platform specific,
>> etc.
>>
>> Kamil do you have plans to refresh and push your next version of the
>> workqueue solution?
> 
> I do not, as Bartek takes over my work,
> +CC Bartek

Hi Lukasz,

As you remember in January Chanwoo has proposed another idea (to allow
selecting workqueue type by devfreq device driver):

"I'm developing the RFC patch and then I'll send it as soon as possible."
(https://lore.kernel.org/linux-pm/6107fa2b-81ad-060d-89a2-d8941ac4d17e@samsung.com/)

"After posting my suggestion, we can discuss it"
(https://lore.kernel.org/linux-pm/f5c5cd64-b72c-2802-f6ea-ab3d28483260@samsung.com/)

so we have been waiting on the patch to be posted..

Similarly we have been waiting on (any) feedback for exynos-bus/nocp
fixes for Exynos5422 support (which have been posted by Kamil also in
January):

https://lore.kernel.org/linux-pm/8f82d8d5-927b-afb4-272f-45c16b5a23b9@samsung.com/

Considering the above and how hard it has been to push the changes
through review/merge process last year we are near giving up when it
comes to upstream devfreq contributions. Sylwester is still working on
exynos-bus & interconnect integration (continuation of Artur Swigon's
work from last year) & related issues (IRQ support for PPMU)  but
I'm seriously considering putting it all on-hold..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
