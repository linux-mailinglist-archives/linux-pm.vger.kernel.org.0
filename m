Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D91B2071F3
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 13:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390567AbgFXLSs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 07:18:48 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50120 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390586AbgFXLSs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 07:18:48 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200624111844euoutp02853003e920d16d7d194147d75f28cbec~bds7uoGT20203102031euoutp02Q
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 11:18:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200624111844euoutp02853003e920d16d7d194147d75f28cbec~bds7uoGT20203102031euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592997524;
        bh=XnIpEzS+JmByzmKCFEgupSV6PWDHMERPPPnvUIciVls=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BiPP8GF8KmiErqx/xS9B9a7xU4QuFLogP38GTlimY3lOZe3im16I/0PYEJab+rLuZ
         ap5tUVBIwlMT97KexJCq03jhLP15jAJHH3XyIzBdMk0Zp1+3qsnuRzC6cj+57LPWgM
         OfcIlxP/kKa90xWpOJ6fdP9A13z2xi3Ed3k4hQrs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200624111844eucas1p2e327f4f369148d4623addc19d7722351~bds7fImUx2492924929eucas1p2Q;
        Wed, 24 Jun 2020 11:18:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A0.6B.05997.49633FE5; Wed, 24
        Jun 2020 12:18:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200624111843eucas1p1bcf65cc0939f6176937e43c8824bdd4a~bds7LyxFI2735727357eucas1p1n;
        Wed, 24 Jun 2020 11:18:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200624111843eusmtrp2a279f69527ec990b732e8841e624d9d9~bds7LGTVI1412614126eusmtrp2i;
        Wed, 24 Jun 2020 11:18:43 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-9d-5ef33694e65e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A2.01.06314.39633FE5; Wed, 24
        Jun 2020 12:18:43 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200624111843eusmtip27b23e45fbb32e0228cbbad65b02eabe7~bds6hf9Jg1274412744eusmtip2f;
        Wed, 24 Jun 2020 11:18:43 +0000 (GMT)
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Kamil Konieczny <k.konieczny@samsung.com>
Message-ID: <828b0d63-4d01-48d6-5971-64855adebed2@samsung.com>
Date:   Wed, 24 Jun 2020 13:18:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <85f5a8c0-7d48-f2cd-3385-c56d662f2c88@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djPc7pTzD7HGXyYxmxx/ctzVov+x6+Z
        Lc6f38BucbbpDbvFpsfXWC0u75rDZvG59wijxYzz+5gsFja1sFvcblzBZvHtxCNGB26PNfPW
        MHrsnHWX3WPTqk42j81L6j36tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoEr4+a6LqaCzzYVD1r7
        mRoYZ5h0MXJySAiYSJybdZK1i5GLQ0hgBaPElrPb2SCcL4wSv/bOYYJwPjNKzLo8gQ2m5WLH
        PaiW5YwSfacus0A4bxklbn7ZxAJSJSxgJzH/2i5WEFtEoFLi1szvYHOZBd4ySez5extsFJuA
        vsTBsyfBGniBGt6dOc0MYrMIqEr09nwAs0UFIiSOd09mh6gRlDg58wlYPaeAtcSSWW+ZQGxm
        AXGJW0/mQ9nyEs1bZzODLJMQuMYuseLRBFaIu10kjm/byw5hC0u8Or4FypaR+L9zPhNEQzOj
        xOmGqewQTg+jxN4vW6C+tpb4/PEAkM0BtEJTYv0ufYiwo8S5P0+YQcISAnwSN94KQhzBJzFp
        23SoMK9ER5sQRLWqxPNTPUwQtrRE1/91rBMYlWYheW0WkndmIXlnFsLeBYwsqxjFU0uLc9NT
        i43yUsv1ihNzi0vz0vWS83M3MQIT1+l/x7/sYNz1J+kQowAHoxIP74YHH+OEWBPLiitzDzFK
        cDArifA6nT0dJ8SbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwen
        VAPjpO4d0wL+f9nzLz/A5HBhc3369Y1+Utv7ij4qPMnmDt5UbbOsIuCEkPTzO0Hn5t5Tq9l1
        mkGT1YLld6NXV0J0Tv2FPWe1vn19O3Pv2Vv7NolFZvxVMpFz32cdcKVV9r7ZSis7Sfcbul7F
        tzj/Gya/DF0SsuB6d3pdVbHODsu5X9oj2Y3vLU1QYinOSDTUYi4qTgQAlNccUlgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7qTzT7HGfTt0LG4/uU5q0X/49fM
        FufPb2C3ONv0ht1i0+NrrBaXd81hs/jce4TRYsb5fUwWC5ta2C1uN65gs/h24hGjA7fHmnlr
        GD12zrrL7rFpVSebx+Yl9R59W1YxenzeJBfAFqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2Ri
        qWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXcXNdF1PBZ5uKB639TA2MM0y6GDk5JARMJC523GPt
        YuTiEBJYyiix4fMeFoiEtETj6dVMELawxJ9rXWwQRa8ZJSa8bWIFSQgL2EnMv7YLzBYRqJS4
        //MOM0gRs8B7Jom/J2YyQXSsZpJo/bKeEaSKTUBf4uDZk2AreIG63505zQxiswioSvT2fACz
        RQUiJFru/2GHqBGUODnzCVg9p4C1xJJZb8FOYhZQl/gz7xIzhC0ucevJfKi4vETz1tnMExiF
        ZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjNRtx35u3sF4aWPw
        IUYBDkYlHt4NDz7GCbEmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQoynQcxOZ
        pUST84FJJK8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA2PNjd0b
        ZXvWTwpqEjep+Su36ujWPzevRa9m9P5tyTSbwZor4quzkcONlCnT+a59NayVu/H4zYa/3u+/
        Xm/2y6/gXaBvknlP/FJBt8j30OULmBwL+/ZwP13PN/POBlOND7431H0/OU+bx+9UsFBqieT8
        mECTSW4CHpFJ147MkE9+u5x93qbXLyOUWIozEg21mIuKEwFVhWFS6gIAAA==
X-CMS-MailID: 20200624111843eucas1p1bcf65cc0939f6176937e43c8824bdd4a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200624103308eucas1p29c8572979809b129ff8ac729c6c728e2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200624103308eucas1p29c8572979809b129ff8ac729c6c728e2
References: <20200623164733.qbhua7b6cg2umafj@macmini.local>
        <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
        <20200623191129.GA4171@kozik-lap>
        <CGME20200624103308eucas1p29c8572979809b129ff8ac729c6c728e2@eucas1p2.samsung.com>
        <85f5a8c0-7d48-f2cd-3385-c56d662f2c88@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 24.06.2020 12:32, Lukasz Luba wrote:
> Hi Krzysztof and Willy
> 
> On 6/23/20 8:11 PM, Krzysztof Kozlowski wrote:
>> On Tue, Jun 23, 2020 at 09:02:38PM +0200, Krzysztof Kozlowski wrote:
>>> On Tue, 23 Jun 2020 at 18:47, Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
>>>>
>>>> Hi everybody,
>>>>
>>>> Is DVFS for memory bus really working on Odroid XU3/4 board?
>>>> Using a simple microbenchmark that is doing only memory accesses, memory DVFS
>>>> seems to not working properly:
>>>>
>>>> The microbenchmark is doing pointer chasing by following index in an array.
>>>> Indices in the array are set to follow a random pattern (cutting prefetcher),
>>>> and forcing RAM access.
>>>>
>>>> git clone https://protect2.fireeye.com/url?k=c364e88a-9eb6fe2f-c36563c5-0cc47a31bee8-631885f0a63a11a0&q=1&u=https%3A%2F%2Fgithub.com%2Fwwilly%2Fbenchmark.git \
>>>>    && cd benchmark \
>>>>    && source env.sh \
>>>>    && ./bench_build.sh \
>>>>    && bash source/scripts/test_dvfs_mem.sh
>>>>
>>>> Python 3, cmake and sudo rights are required.
>>>>
>>>> Results:
>>>> DVFS CPU with performance governor
>>>> mem_gov = simple_ondemand at 165000000 Hz in idle, should be bumped when the
>>>> benchmark is running.
>>>> - on the LITTLE cluster it takes 4.74308 s to run (683.004 c per memory access),
>>>> - on the big cluster it takes 4.76556 s to run (980.343 c per moemory access).
>>>>
>>>> While forcing DVFS memory bus to use performance governor,
>>>> mem_gov = performance at 825000000 Hz in idle,
>>>> - on the LITTLE cluster it takes 1.1451 s to run (164.894 c per memory access),
>>>> - on the big cluster it takes 1.18448 s to run (243.664 c per memory access).
>>>>
>>>> The kernel used is the last 5.7.5 stable with default exynos_defconfig.
>>>
>>> Thanks for the report. Few thoughts:
>>> 1. What trans_stat are saying? Except DMC driver you can also check
>>> all other devfreq devices (e.g. wcore) - maybe the devfreq events
>>> (nocp) are not properly assigned?
>>> 2. Try running the measurement for ~1 minutes or longer. The counters
>>> might have some delay (which would require probably fixing but the
>>> point is to narrow the problem).
>>> 3. What do you understand by "mem_gov"? Which device is it?
>>
>> +Cc Lukasz who was working on this.
> 
> Thanks Krzysztof for adding me here.
> 
>>
>> I just run memtester and more-or-less ondemand works (at least ramps
>> up):
>>
>> Before:
>> /sys/class/devfreq/10c20000.memory-controller$ cat trans_stat
>>       From  :   To
>>             : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
>> * 165000000:         0         0         0         0         0         0         0         0   1795950
>>    206000000:         1         0         0         0         0         0         0         0      4770
>>    275000000:         0         1         0         0         0         0         0         0     15540
>>    413000000:         0         0         1         0         0         0         0         0     20780
>>    543000000:         0         0         0         1         0         0         0         1     10760
>>    633000000:         0         0         0         0         2         0         0         0     10310
>>    728000000:         0         0         0         0         0         0         0         0         0
>>    825000000:         0         0         0         0         0         2         0         0     25920
>> Total transition : 9
>>
>>
>> $ sudo memtester 1G
>>
>> During memtester:
>> /sys/class/devfreq/10c20000.memory-controller$ cat trans_stat
>>       From  :   To
>>             : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
>>    165000000:         0         0         0         0         0         0         0         1   1801490
>>    206000000:         1         0         0         0         0         0         0         0      4770
>>    275000000:         0         1         0         0         0         0         0         0     15540
>>    413000000:         0         0         1         0         0         0         0         0     20780
>>    543000000:         0         0         0         1         0         0         0         2     11090
>>    633000000:         0         0         0         0         3         0         0         0     17210
>>    728000000:         0         0         0         0         0         0         0         0         0
>> * 825000000:         0         0         0         0         0         3         0         0    169020
>> Total transition : 13
>>
>> However after killing memtester it stays at 633 MHz for very long time
>> and does not slow down. This is indeed weird...
> 
> I had issues with devfreq governor which wasn't called by devfreq
> workqueue. The old DELAYED vs DEFERRED work discussions and my patches
> for it [1]. If the CPU which scheduled the next work went idle, the
> devfreq workqueue will not be kicked and devfreq governor won't check
> DMC status and will not decide to decrease the frequency based on low
> busy_time.
> The same applies for going up with the frequency. They both are
> done by the governor but the workqueue must be scheduled periodically.
> 
> I couldn't do much with this back then. I have given the example that
> this is causing issues with the DMC [2]. There is also a description
> of your situation staying at 633MHz for long time:
> ' When it is missing opportunity
> to change the frequency, it can either harm the performance or power
> consumption, depending of the frequency the device stuck on.'
> 
> The patches were not accepted because it will cause CPU wake-up from
> idle, which increases the energy consumption. I know that there were
> some other attempts, but I don't know the status.
> 
> I had also this devfreq workqueue issue when I have been working on
> thermal cooling for devfreq. The device status was not updated, because
> the devfreq workqueue didn't check the device [3].
> 
> Let me investigate if that is the case.
> 
> Regards,
> Lukasz
> 
> [1] https%3A%2F%2Flkml.org%2Flkml%2F2019%2F2%2F11%2F1146
> [2] https%3A%2F%2Flkml.org%2Flkml%2F2019%2F2%2F12%2F383
> [3] https%3A%2F%2Flwn.net%2Fml%2Flinux-kernel%2F20200511111912.3001-11-lukasz.luba%40arm.com%2F

and here was another try to fix wq: "PM / devfreq: add possibility for delayed work"

https://lkml.org/lkml/2019/12/9/486

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

