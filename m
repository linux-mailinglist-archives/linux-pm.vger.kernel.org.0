Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7751F2168DB
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 11:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgGGJPW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 05:15:22 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40666 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGJPW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 05:15:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200707091520euoutp01c304a05d46b098f4b6ace58102ae1d19~fbZ6OPp8R2576225762euoutp01u
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 09:15:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200707091520euoutp01c304a05d46b098f4b6ace58102ae1d19~fbZ6OPp8R2576225762euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594113320;
        bh=2wj30Safnq/65gvxG47mTYGg1L0FRwFQCT45FoRfvwQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qU4L9RW8PHybXalXiFyx2feGd6NEPWYCWh28GkGXk5wrXoJoQOuYohIbc4utoEDCd
         dwkKjb5mogll7OVbXdhbsv/CGUk22Cpa3quP7dQZZOtlVS0No8A3NTC8DOqwL0rEO/
         xSStt3Kvlf2yVOGnqNK1N9HZaMy6i+jevNwYS8tk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200707091520eucas1p26d705c4dc70ab7a32af072af6eec3e04~fbZ55kP6H0418104181eucas1p2x;
        Tue,  7 Jul 2020 09:15:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C4.2F.06318.82D340F5; Tue,  7
        Jul 2020 10:15:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200707091520eucas1p2f044ce3b9aa2ea62f1835f8d8fb58f24~fbZ5eDd9F0414204142eucas1p2u;
        Tue,  7 Jul 2020 09:15:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200707091520eusmtrp1510cda210928898265551fa77c2f928f~fbZ5dWsov1147511475eusmtrp1G;
        Tue,  7 Jul 2020 09:15:20 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-7b-5f043d28439e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1F.44.06017.72D340F5; Tue,  7
        Jul 2020 10:15:20 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200707091519eusmtip1d76fa0b42719ec58c1e81a3ede22918a~fbZ5AyYc20791107911eusmtip1W;
        Tue,  7 Jul 2020 09:15:19 +0000 (GMT)
Subject: Re: [PATCH v4 4/4] thermal: core: Add notifications call in the
 framework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <8a34e9c4-6457-cfd2-3d05-05f80a630a0d@samsung.com>
Date:   Tue, 7 Jul 2020 11:15:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <23c5830d-0a7c-9e87-e859-821d2dccb200@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjt3b27uxtNrpu5BzOjYaKBmhg0Ki0raNYfheiHlHPlZRO3KXdq
        aWiiFTLckvqhzjRRzNJ0aOqmLNEhMxlptDLxI7BmZDD6WFKKSm4Xy3/nnOc873kOvCQm6uOG
        kTm6AprRKTVSQoAPOFenYqOTcMXh2g/hssryVo6sp87ClTX59sncQw8Jmc84hmS+ATNP5lk0
        EbKa1h7eKVLuNhk58lb7Mkc+P20n5E0T6XJTXweS+3oj0ogMwYlsWpNTRDPxyVkC9Qu7F8v3
        ht6Y6+xG5ahbbEB8Eqgj0G6sQgYkIEXUEwRTn5o5LPmFoGvuDpclPgQtHS+J7RXrWB3BDtoR
        TNtacZZ8Q/Dl9gjud4mpi7D25wfy4xDqDLybWOD5TRg1ieCjyxIYEFQCGLyGwLNCKhl6Xe85
        foxTkdA/tx7w7KEywbJs5bCeYJio92wFkCR/yz/zJyBj1H6o7G/AWCyBWc+jQAeghnngdI5y
        2LPPQoOtAmexGL6O9/FYHA6uB9U4u1CJYHGyi8eSagTuijrEuo7D/OQa4U/GqBiwDMWzcgos
        eW0BGaggmPEGs0cEwf2BWoyVhVB1V8S6o8A83v0vdvT1G6wGSc07mpl31DHvqGP+n9uM8A4k
        oQv1WhWtT9TR1+P0Sq2+UKeKu5an7UVbf8m1Ob5iQ8PrVx2IIpF0tzBrDFOIuMoifbHWgYDE
        pCHC069cmSJhtrK4hGbyFEyhhtY70F4Sl0qEiS3LV0SUSllA59J0Ps1sTzkkP6wcVdsvRS1o
        BhlnbURaW2z70tsycUVkfHddhvlmNPz8zo+w32rX7KpPPWhWML9FQekbx+4xTNvJHAF1Iffy
        M4dcNegeyT6giT2fFFeWYvU8t5Z2fjbMhjIzMY0mIly92Riz+tRW3JP+eMqoPecskZSuYKk5
        6qTInqjxyo0F1VEprlcrEw5hjF75F9IeAmxHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7oatizxBvfnMVo0Nyxmstg4Yz2r
        xbzPshaXd81hs/jce4TR4vO2WewWTx72sVlMWLyR3YHD43JfL5PH4j0vmTzuXNvD5jHvZKBH
        35ZVjB6fN8kFsEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
        pRbp2yXoZezd85a54K1Yxe3V6xgbGNcJdzFyckgImEhsPzKDrYuRi0NIYCmjxJllm9khEjIS
        J6c1sELYwhJ/rnVBFb1llPj+rp0FJCEsECLx68dHRhBbRMBZ4urJu2DNzALnGCXW36+AaFjH
        JPF58SmwIjYBQ4mutyCTODl4BewkNp2+zgRiswioSGy9/QesRlQgTmL5lvnsEDWCEidnPgFa
        xsHBCVR/4wcTxHwziXmbHzJD2PISzVtnQ9niEreezGeawCg0C0n3LCQts5C0zELSsoCRZRWj
        SGppcW56brGRXnFibnFpXrpecn7uJkZgFG479nPLDsaud8GHGAU4GJV4eBOOMMcLsSaWFVfm
        HmKU4GBWEuF1Ons6Tog3JbGyKrUoP76oNCe1+BCjKdBvE5mlRJPzgQkiryTe0NTQ3MLS0NzY
        3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDYyvPrYZ/Sf2+r9/Pt1CvXP/5a1Zp0QMp
        3YkqWtP2/DsWeOPIgtRzSy+F8ovNu3ZT/rz2iR2vWKedcvipfemjZtSPlsi9f6pa2/Q7bOqF
        Xx7R6PzaeUJux46b9Y93Vp+NVb6QGH7ickfAB2btZ4+OB7F9OedzcerXr1tuR2y/PitEp9Zy
        hvMK53NKLMUZiYZazEXFiQCdv2O22AIAAA==
X-CMS-MailID: 20200707091520eucas1p2f044ce3b9aa2ea62f1835f8d8fb58f24
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200706131708eucas1p1487955a7632584c17df724399f48825a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200706131708eucas1p1487955a7632584c17df724399f48825a
References: <20200706105538.2159-1-daniel.lezcano@linaro.org>
        <20200706105538.2159-4-daniel.lezcano@linaro.org>
        <CGME20200706131708eucas1p1487955a7632584c17df724399f48825a@eucas1p1.samsung.com>
        <c7ed6c63-cbb5-07dc-c292-2c473af8c4fb@samsung.com>
        <23c5830d-0a7c-9e87-e859-821d2dccb200@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 06.07.2020 15:46, Daniel Lezcano wrote:
> On 06/07/2020 15:17, Marek Szyprowski wrote:
>> On 06.07.2020 12:55, Daniel Lezcano wrote:
>>> The generic netlink protocol is implemented but the different
>>> notification functions are not yet connected to the core code.
>>>
>>> These changes add the notification calls in the different
>>> corresponding places.
>>>
>>> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> This patch landed in today's linux-next 20200706 as commit 5df786e46560
>> ("thermal: core: Add notifications call in the framework"). Sadly it
>> breaks booting various Samsung Exynos based boards. Here is an example
>> log from Odroid U3 board:
>>
>> Unable to handle kernel NULL pointer dereference at virtual address 00000010
>> pgd = (ptrval)
>> [00000010] *pgd=00000000
>> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3-00015-g5df786e46560
>> #1146
>> Hardware name: Samsung Exynos (Flattened Device Tree)
>> PC is at kmem_cache_alloc+0x13c/0x418
>> LR is at kmem_cache_alloc+0x48/0x418
>> pc : [<c02b5cac>]    lr : [<c02b5bb8>]    psr: 20000053
>> ...
>> Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
>> Control: 10c5387d  Table: 4000404a  DAC: 00000051
>> Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
>> Stack: (0xee8f1cf8 to 0xee8f2000)
>> ...
>> [<c02b5cac>] (kmem_cache_alloc) from [<c08cd170>] (__alloc_skb+0x5c/0x170)
>> [<c08cd170>] (__alloc_skb) from [<c07ec19c>]
>> (thermal_genl_send_event+0x24/0x174)
>> [<c07ec19c>] (thermal_genl_send_event) from [<c07ec648>]
>> (thermal_notify_tz_create+0x58/0x74)
>> [<c07ec648>] (thermal_notify_tz_create) from [<c07e9058>]
>> (thermal_zone_device_register+0x358/0x650)
>> [<c07e9058>] (thermal_zone_device_register) from [<c1028d34>]
>> (of_parse_thermal_zones+0x304/0x7a4)
>> [<c1028d34>] (of_parse_thermal_zones) from [<c1028964>]
>> (thermal_init+0xdc/0x154)
>> [<c1028964>] (thermal_init) from [<c0102378>] (do_one_initcall+0x8c/0x424)
>> [<c0102378>] (do_one_initcall) from [<c1001158>]
>> (kernel_init_freeable+0x190/0x204)
>> [<c1001158>] (kernel_init_freeable) from [<c0ab85f4>]
>> (kernel_init+0x8/0x118)
>> [<c0ab85f4>] (kernel_init) from [<c0100114>] (ret_from_fork+0x14/0x20)
>>
>> Reverting it on top of linux-next fixes the boot issue. I will
>> investigate it further soon.
> Thanks for reporting this.
>
> Can you send the addr2line result and code it points to ?

addr2line of c02b5cac (kmem_cache_alloc+0x13c/0x418) points to mm/slub.c 
+2839, but I'm not sure if we can trust it. imho it looks like some 
trashed memory somewhere, but I don't have time right now to analyze it 
further now...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

