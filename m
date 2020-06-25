Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1CB209E35
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 14:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404598AbgFYMMf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 08:12:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58138 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404596AbgFYMMe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 08:12:34 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200625121232euoutp0156bb45d681de220c6ce4554ef3b1ca80~byFMNP6Lg2215222152euoutp01K
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 12:12:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200625121232euoutp0156bb45d681de220c6ce4554ef3b1ca80~byFMNP6Lg2215222152euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593087152;
        bh=r2YT8qcUQvVggMMJZuYcGzmqkKrEtSaC/jUBzXklzHg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gZ9lm5GJX8zSYn6hxUqOx/nDBRXXrhKft0P5LrBDJOxgoyNLXqQ5TmGaGtIVK0ltJ
         FzoVajLwqkDd5k6XCsuCuH0Pd6ib1f/5XxGWZ1EkDlesdpnhPiGFNoB9Ca2zWH02JU
         8zc/unirqQEa/DMOYhbNdFw9SjhGLhnZXBd5RDVA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200625121231eucas1p25a695661397003624facaafce7eaba5c~byFL2OKhJ1012410124eucas1p2y;
        Thu, 25 Jun 2020 12:12:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 75.98.05997.FA494FE5; Thu, 25
        Jun 2020 13:12:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200625121231eucas1p15f9882e3d46aabd71835dbdba4c3e651~byFLbvHvC2321623216eucas1p1-;
        Thu, 25 Jun 2020 12:12:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200625121231eusmtrp236613c8ea77d6351fe1c2131faa508da~byFLa6jhA2442224422eusmtrp2U;
        Thu, 25 Jun 2020 12:12:31 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-e9-5ef494afc5bc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 87.C4.06314.FA494FE5; Thu, 25
        Jun 2020 13:12:31 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200625121230eusmtip2466d09df0997094c011652c8f475c6ad~byFKzbT-P0139301393eusmtip2-;
        Thu, 25 Jun 2020 12:12:30 +0000 (GMT)
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Kamil Konieczny <k.konieczny@samsung.com>
Message-ID: <ee2e4acb-3986-3227-da1f-177d2756d194@samsung.com>
Date:   Thu, 25 Jun 2020 14:12:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <6f8b1119-62b1-942d-cfde-6f1e9a28c40c@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djPc7rrp3yJMzi8z8hi44z1rBbXvzxn
        teh//JrZ4vz5DewWZ5vesFtsenyN1eLyrjlsFp97jzBazDi/j8liYVMLu8XtxhVsFofftLNa
        fDvxiNGB12PNvDWMHjtn3WX32LSqk81j85J6j74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL4Mr4
        d2w6S8EDlYrOTVuYGhifyHYxcnJICJhIrDu/m62LkYtDSGAFo8S/1u+sEM4XRolPp14wQzif
        GSWW7O9igWmZvOYaVGI5o0TT5UWsIAkhgbeMEtP7fUFsYQE7ifnXdoHFRQRCJNbNnQfWwCzw
        k1ni/aYTzCAJNgF9iYNnT4JN5QVq+DvjJiOIzSKgKvFnVgcTiC0qECFxvHsyO0SNoMTJmU+A
        6jk4OAWsJd6tFQUJMwuIS9x6Mp8JwpaX2P52DjPEoS/ZJc4fVYWwXSTunrrLBGELS7w6voUd
        wpaR+L8TpJcLyG5mlDjdMJUdwulhlNj7ZQsbRJW1xOePB9hAFjMLaEqs36UPEXaUeHvsDTNI
        WEKAT+LGW0GIG/gkJm2bDhXmlehoE4KoVpV4fqoH6gRpia7/61gnMCrNQvLYLCTfzELyzSyE
        vQsYWVYxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEprHT/45/2cG460/SIUYBDkYlHt4D
        E7/ECbEmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJ
        JanZqakFqUUwWSYOTqkGxqYghUV2vaHBRe9X1D9XmbKYdbGpVlfbtcfTFhmk/THmPLx+/dQj
        tfz/opsSo7dtm+nNy/fM7qLZS3fb7r9OEqeNyje6TTjdcLVIwW9tkt6tVyu558XJypXOUmSJ
        TRa8EmL4c2f5DKNsVd86dpezfnf+Hl6TyV7+oe3uJlWTEwsrDnEqqjP0K7EUZyQaajEXFScC
        AN29E6pfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsVy+t/xe7rrp3yJM2jrELXYOGM9q8X1L89Z
        Lfofv2a2OH9+A7vF2aY37BabHl9jtbi8aw6bxefeI4wWM87vY7JY2NTCbnG7cQWbxeE37awW
        3048YnTg9Vgzbw2jx85Zd9k9Nq3qZPPYvKTeo2/LKkaPz5vkAtii9GyK8ktLUhUy8otLbJWi
        DS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DL+HZvOUvBApaJz0xamBsYnsl2M
        nBwSAiYSk9dcY+5i5OIQEljKKDHx4CcmiIS0ROPp1VC2sMSfa11sILaQwGtGie830kFsYQE7
        ifnXdrGC2CICIRKXu88wggxiFvjNLNH77CPU1O/MEl+u7wXrZhPQlzh49iQLiM0L1P13xk1G
        EJtFQFXiz6wOsG2iAhESLff/sEPUCEqcnPkEqJ6Dg1PAWuLdWlGQMLOAusSfeZeYIWxxiVtP
        5jNB2PIS29/OYZ7AKDQLSfcsJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4m
        RmDkbjv2c/MOxksbgw8xCnAwKvHwHpj4JU6INbGsuDL3EKMEB7OSCK/T2dNxQrwpiZVVqUX5
        8UWlOanFhxhNgX6byCwlmpwPTCp5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtS
        i2D6mDg4pRoYPU9dknrJ+bF42r6Ev7s4JzCaq1/4/qZ+nlFI31+/3f7a/rPZ9OJXxIYpvDb+
        Vn1i32rby/5zZLs4OHO3y6mJnmPYclR+goyU8vTp7JzRm37ve/qUvXVzwpetqWrdThUhT0y7
        56w+2b5BLLtslmrii38xM7XK+y23rd19LmXl9TUJp19WaT3lVmIpzkg01GIuKk4EAKzmvUDy
        AgAA
X-CMS-MailID: 20200625121231eucas1p15f9882e3d46aabd71835dbdba4c3e651
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25.06.2020 14:02, Lukasz Luba wrote:
> 
> 
> On 6/25/20 12:30 PM, Kamil Konieczny wrote:
>> Hi Lukasz,
>>
>> On 25.06.2020 12:02, Lukasz Luba wrote:
>>> Hi Sylwester,
>>>
>>> On 6/24/20 4:11 PM, Sylwester Nawrocki wrote:
>>>> Hi All,
>>>>
>>>> On 24.06.2020 12:32, Lukasz Luba wrote:
>>>>> I had issues with devfreq governor which wasn't called by devfreq
>>>>> workqueue. The old DELAYED vs DEFERRED work discussions and my patches
>>>>> for it [1]. If the CPU which scheduled the next work went idle, the
>>>>> devfreq workqueue will not be kicked and devfreq governor won't check
>>>>> DMC status and will not decide to decrease the frequency based on low
>>>>> busy_time.
>>>>> The same applies for going up with the frequency. They both are
>>>>> done by the governor but the workqueue must be scheduled periodically.
>>>>
>>>> As I have been working on resolving the video mixer IOMMU fault issue
>>>> described here: https://patchwork.kernel.org/patch/10861757
>>>> I did some investigation of the devfreq operation, mostly on Odroid U3.
>>>>
>>>> My conclusions are similar to what Lukasz says above. I would like to add
>>>> that broken scheduling of the performance counters read and the devfreq
>>>> updates seems to have one more serious implication. In each call, which
>>>> normally should happen periodically with fixed interval we stop the counters,
>>>> read counter values and start the counters again. But if period between
>>>> calls becomes long enough to let any of the counters overflow, we will
>>>> get wrong performance measurement results. My observations are that
>>>> the workqueue job can be suspended for several seconds and conditions for
>>>> the counter overflow occur sooner or later, depending among others
>>>> on the CPUs load.
>>>> Wrong bus load measurement can lead to setting too low interconnect bus
>>>> clock frequency and then bad things happen in peripheral devices.
>>>>
>>>> I agree the workqueue issue needs to be fixed. I have some WIP code to use
>>>> the performance counters overflow interrupts instead of SW polling and with
>>>> that the interconnect bus clock control seems to work much better.
>>>>
>>>
>>> Thank you for sharing your use case and investigation results. I think
>>> we are reaching a decent number of developers to maybe address this
>>> issue: 'workqueue issue needs to be fixed'.
>>> I have been facing this devfreq workqueue issue ~5 times in different
>>> platforms.
>>>
>>> Regarding the 'performance counters overflow interrupts' there is one
>>> thing worth to keep in mind: variable utilization and frequency.
>>> For example, in order to make a conclusion in algorithm deciding that
>>> the device should increase or decrease the frequency, we fix the period
>>> of observation, i.e. to 500ms. That can cause the long delay if the
>>> utilization of the device suddenly drops. For example we set an
>>> overflow threshold to value i.e. 1000 and we know that at 1000MHz
>>> and full utilization (100%) the counter will reach that threshold
>>> after 500ms (which we want, because we don't want too many interrupts
>>> per sec). What if suddenly utilization drops to 2% (i.e. from 5GB/s
>>> to 250MB/s (what if it drops to 25MB/s?!)), the counter will reach the
>>> threshold after 50*500ms = 25s. It is impossible just for the counters
>>> to predict next utilization and adjust the threshold. [...]
>>
>> irq triggers for underflow and overflow, so driver can adjust freq
>>
> 
> Probably possible on some platforms, depends on how many PMU registers
> are available, what information can be can assign to them and type of
> interrupt. A lot of hassle and still - platform and device specific.
> Also, drivers should not adjust the freq, governors (different types
> of them with different settings that they can handle) should do it.
> 
> What the framework can do is to take this responsibility and provide
> generic way to monitor the devices (or stop if they are suspended).
> That should work nicely with the governors, which try to predict the
> next best frequency. From my experience the more fluctuating intervals
> the governors are called, the more odd decisions they make.
> That's why I think having a predictable interval i.e. 100ms is something
> desirable. Tuning the governors is easier in this case, statistics
> are easier to trace and interpret, solution is not to platform specific,
> etc.
> 
> Kamil do you have plans to refresh and push your next version of the
> workqueue solution?

I do not, as Bartek takes over my work,
+CC Bartek

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

