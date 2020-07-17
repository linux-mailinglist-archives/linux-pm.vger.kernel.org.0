Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9F2223B60
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 14:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgGQMb1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 08:31:27 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49277 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgGQMb0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2020 08:31:26 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200717123124euoutp02e76c84d955d554661dc94b7f2b55e339~iih8gggKh1852618526euoutp022
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 12:31:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200717123124euoutp02e76c84d955d554661dc94b7f2b55e339~iih8gggKh1852618526euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594989084;
        bh=Z5W2EOGc/ZuVFapok34VWhaEwDPiDxjuwKrZN4b8lF8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CbjgZFk3FqIbB/p21xYDwWNVjwMXlYBsRifIbFRiCF/6WzzZtyWvCHgcvSsY5EdYd
         +pLvExLutWrh2t0/cxqyg785wzzcQT5yYu4ESBDg2b+6/wI3CPx5S8ubwZ2wxkxCdc
         hScT+4ddN+CPU2RacjUOg4w1wIXc47nPKLT5AN54=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200717123123eucas1p2f504eac78f9e8d1eca8a3703eb84e9b8~iih71XKvz0614506145eucas1p2X;
        Fri, 17 Jul 2020 12:31:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 25.E0.05997.B1A911F5; Fri, 17
        Jul 2020 13:31:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200717123123eucas1p1d865ecb093f49f42cbafbd35d1958cd1~iih7da9si1667716677eucas1p1D;
        Fri, 17 Jul 2020 12:31:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200717123123eusmtrp2b7b6f1d9aa5d5aa6c58186ccba62677d~iih7cpwYw0269102691eusmtrp2F;
        Fri, 17 Jul 2020 12:31:23 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-ec-5f119a1b1dfd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 00.E6.06314.B1A911F5; Fri, 17
        Jul 2020 13:31:23 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200717123122eusmtip2d997d2de6d17d12c1cd3e51f12296194~iih6kKDEQ3261232612eusmtip2Q;
        Fri, 17 Jul 2020 12:31:22 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] memory: samsung: exynos5422-dmc: Add module
 param to control IRQ mode
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, cw00.choi@samsung.com, krzk@kernel.org,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, s.nawrocki@samsung.com, kgene@kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <4c73b414-df66-8451-7322-89da6244c4f8@samsung.com>
Date:   Fri, 17 Jul 2020 14:31:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <baadfe1a-89b6-9fd5-9ea8-e39b458af1aa@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0iTYRjl3XfZt9HsdSk+ObutDCuyUn98pKhF0OhHF/xRKLamfqjkzDbv
        fzLLNCFvFdqKWiHekLSZ2pYkXtBK5orKyhQlLe+FOibdZtu+JP+d85xznuc98DKE9BXlzSQm
        p3KaZFWSnBaTLT0/LLtlOnfl3u9f5Gzph7ck+946QbH6hQqKLR6bIViLpVHImnNnhaxhbIBi
        35ju0OzitW7EVlieCdj7uZeF7KeLNTTbNZtPsbbnn1G4m6L+bj1SGHXDQoWh7iqtaKq8oCh6
        XIcUi4aNx+lIcUgcl5SYzmn2hJ4RJxiGX9Mpo+sz7eboHNThUYhEDOAgaOjqJQqRmJHiGgRD
        zRUCnlgRzI/UUjxZdCh5F6mVyLf5qX+uagTfOpZcghTPIZidJJx4HY6FvKeTtBN7YF8YeDVM
        OgMEHhKAcaLYJdB4P5Tm1yEnluBQeLM85QqTjkC7vcY198SnYGG0i+I97vDi1jjpxCIcDD0v
        rS4/gb1gcPyegMeb4FLzbVchwPNCWKo0OsKMgxyC7mvBfIN1MN37WMhjH1g23hPw/ocI/hRM
        /gu3Iqi+bqd5VzAM9f+knYsIvAMaTHv4nQfAbsvgoRt8mHPnn+AGZS3lBD+WQMEVKb9jOzRW
        NdIrVwuNtUQJkutWFdOtKqNbVUb3/6wekXXIi0vTquM5bUAyl+GvVam1acnx/rHn1Abk+Gd9
        9l7rE2T6HdOJMIPkayT6I1gppVTp2ix1JwKGkHtIDpr7TkslcaqsbE5zTqlJS+K0nUjGkHIv
        SeCDqWgpjlelcmc5LoXTrKgCRuSdg3we0Sdbb5ac+DgeWDBpMh+LOf+rrXZpV14ReJijjpZu
        8B4I820ab4ZtVU1TVzzzt/tFbkFRMn9SWdC+eUPpVnFImyUqYkQvbB/0zDQcrl47UdwTIKvE
        KDf7xkzDaFRYoc3/a+1+W5n6iVwWIVKLSP07jZ/at788PChs2jIhlpPaBNW+nYRGq/oLlRMk
        fGMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xe7rSswTjDeZ/4rSYeOMKi8X1L89Z
        LRZ8msFq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XCphZ2i9uNK9gs
        Dr9pZ7X4duIRowOfx5p5axg9ds66y+6xaVUnm8fmJfUefVtWMXp83iQXwBalZ1OUX1qSqpCR
        X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7Hp7kW2ggeSFf/OxjYw
        HhTpYuTkkBAwkXj38SVTFyMXh5DAUkaJ3yumsHYxcgAlZCSOry+DqBGW+HOtiw2i5jWjxKpt
        exlBEsICyRJ/dpxiA7FFBFQlrl24ywJSxCxwh0ni9cFFYEVCApeYJFa+TwOx2QSsJCa2rwKL
        8wrYSVz+/5IZxGYBat7/bwVYXFQgQuLwjllQNYISJ2c+YQGxOQWsJY6d+gJWzyygLvFn3iUo
        W1zi1pP5TBC2vETz1tnMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy021CtOzC0uzUvX
        S87P3cQIjOBtx35u3sF4aWPwIUYBDkYlHt4FXgLxQqyJZcWVuYcYJTiYlUR4nc6ejhPiTUms
        rEotyo8vKs1JLT7EaAr03ERmKdHkfGByySuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKa
        nZpakFoE08fEwSnVwNjB2mO59JVHfOqB3GlyW86ujLy1w0n2zhaXGYGOZ0L1Z606ID3R9tSd
        /wqfqtT/bBZ9/mZe70ymWxE9sy69fMk71XPVN8PfehyO12wm5WvdbFZcndV7xabXh8H0Wd3X
        De9/3rY3l7S4wGzo9SpaOk+QK7Lu5IN3F68wZOwP1208YXV6LYvAj0lKLMUZiYZazEXFiQDv
        3n1k9gIAAA==
X-CMS-MailID: 20200717123123eucas1p1d865ecb093f49f42cbafbd35d1958cd1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200710191148eucas1p2552537bb911bde44c783d98808efa07f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200710191148eucas1p2552537bb911bde44c783d98808efa07f
References: <20200710191122.11029-1-lukasz.luba@arm.com>
        <CGME20200710191148eucas1p2552537bb911bde44c783d98808efa07f@eucas1p2.samsung.com>
        <20200710191122.11029-3-lukasz.luba@arm.com>
        <1a389137-cab5-124a-e198-8be3bc2ca841@samsung.com>
        <3154b8d2-1fa8-c69d-8a9d-05832e12fdd1@arm.com>
        <baadfe1a-89b6-9fd5-9ea8-e39b458af1aa@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/17/20 1:53 PM, Lukasz Luba wrote:
> 
> 
> On 7/14/20 10:01 AM, Lukasz Luba wrote:
>> Hi Bartek,
>>
>> On 7/14/20 8:42 AM, Bartlomiej Zolnierkiewicz wrote:
>>>
>>> Hi,
>>>
>>> On 7/10/20 9:11 PM, Lukasz Luba wrote:
>>>> The driver can operate in two modes relaying on devfreq monitoring
>>>> mechanism which periodically checks the device status or it can use
>>>> interrupts when they are provided by loaded Device Tree. The newly
>>>> introduced module parameter can be used to choose between devfreq
>>>> monitoring and internal interrupts without modifying the Device Tree.
>>>> It also sets devfreq monitoring as default when the parameter is not set
>>>> (also the case for default when the driver is not built as a module).
>>>
>>> Could you please explain why should we leave the IRQ mode
>>> support in the dmc driver?
>>
>> I am still experimenting with the IRQ mode in DMC, but have limited time
>> for it and no TRM.
>> The IRQ mode in memory controller or bus controller has one major
>> advantage: is more interactive. In polling we have fixed period, i.e.
>> 100ms - that's a lot when we have a sudden, latency sensitive workload.
>> There might be no check of the device load for i.e. 99ms, but the tasks
>> with such workload started running. That's a long period of a few frames
>> which are likely to be junked. Should we adjust polling interval to i.e.
>> 10ms, I don't think so. There is no easy way to address all of the
>> scenarios.
>>
>>>
>>> What are the advantages over the polling mode?
>>
>> As described above: more reactive to sudden workload, which might be
>> latency sensitive and cause junk frames.
>> Drawback: not best in benchmarks which are randomly jumping
>> over the data set, causing low traffic on memory.
>> It could be mitigated as Sylwester described with not only one type
>> of interrupt, but another, which could 'observe' also other information
>> type in the counters and fire.
>>
>>>
>>> In what scenarios it should be used?
>>
>> System like Android with GUI, when there is this sudden workload
>> quite often.
>>
>> I think the interconnect could help here and would adjust the DMC
>> freq upfront. Although I don't know if interconnect on Exynos5422 is in
>> your scope in near future. Of course the interconnect will not cover
>> all scenarios either.
>>
>>
>>>
>>> [ If this is only for documentation purposes then it should be
>>>    removed as it would stay in (easily accessible) git history
>>>    anyway.. ]
>>
>> The current interrupt mode is definitely not perfect and switching
>> to devfreq monitoring mode has more sense. On the other hand, it
>> still has potential, until there is no interconnect for this SoC.
>> I will continue experimenting with irq mode, so I would like to
>> still have the code in the driver.
>>
>> Regards,
>> Lukasz
>>
>>>
>>> Best regards,
>>> -- 
>>> Bartlomiej Zolnierkiewicz
>>> Samsung R&D Institute Poland
>>> Samsung Electronics
>>>
> 
> Bartek, do you have some objections to the patches or you think
> they can be taken via devfreq-next?

No objections from me, thank you for the IRQ mode explanation.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
