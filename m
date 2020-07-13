Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE1621D2D2
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 11:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgGMJbX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 05:31:23 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36667 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbgGMJbX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 05:31:23 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200713093121euoutp01dfb9e4feca5d5aa9d282ca6b450c114c~hRfmOdyMj2852228522euoutp01d
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 09:31:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200713093121euoutp01dfb9e4feca5d5aa9d282ca6b450c114c~hRfmOdyMj2852228522euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594632681;
        bh=lhTH4DSK/6+Ag7ZxkZXN1caokc45eKCzYCQCPnhjUYc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=df6ntnJkpbO3sut7G89kvPLWwSukwjZ0GPWv+evjH7PJp3T2aUycrBclmuVviKC8i
         bw6JcuwpZhVz6eA447R9XXfWhjkbl/vYOVMFvKWOrO89t2KSwbn326M306SMFZZDMx
         INffcKkpcNiCmds95GPwB7VHKXCWm5cndRn8oB1M=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200713093120eucas1p2f772b7e0ab36759a364db1d3483ec3a0~hRfluNjMu0753407534eucas1p2G;
        Mon, 13 Jul 2020 09:31:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5A.89.06318.8E92C0F5; Mon, 13
        Jul 2020 10:31:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200713093120eucas1p20559a77ab67ac05958a4ba76c4bb20e0~hRflUVwHo0754007540eucas1p23;
        Mon, 13 Jul 2020 09:31:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200713093120eusmtrp28bc43157b17eb75a48604795c6414ac3~hRflTmibD1167711677eusmtrp28;
        Mon, 13 Jul 2020 09:31:20 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-74-5f0c29e8d687
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 78.CC.06017.8E92C0F5; Mon, 13
        Jul 2020 10:31:20 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200713093119eusmtip1c8791d44252feb62943156bcdec1a1d2~hRfkzpE6c1408514085eusmtip1O;
        Mon, 13 Jul 2020 09:31:19 +0000 (GMT)
Subject: Re: [PATCH v4 4/4] thermal: core: Add notifications call in the
 framework
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <41466d5a-24fb-b861-93ae-3ed190af7174@samsung.com>
Date:   Mon, 13 Jul 2020 11:31:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8a34e9c4-6457-cfd2-3d05-05f80a630a0d@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djPc7ovNHniDX4sVrdobljMZLFxxnpW
        i3mfZS0u75rDZvG59wijxedts9gtnjzsY7OYsHgjuwOHx+W+XiaPxXteMnncubaHzWPeyUCP
        vi2rGD0+b5ILYIvisklJzcksSy3St0vgynh7ir/gjlTFkrl1DYzHxLoYOTkkBEwkrn46zd7F
        yMUhJLCCUaL922xGCOcLo8SUxZuZIJzPjBKX33xlhGn5/OAsE4gtJLCcUaLjvyFE0XtGif+9
        y8ESwgIhEr9+fARrYBMwlOh628UGYosIOEtcPXkXbB+zwDlGiUen14MV8QrYSZx60gHWzCKg
        KnF13g52EFtUIE5i/cvtTBA1ghInZz5hAbE5BewlHk28BjaUWUBeonnrbGYIW1zi1pP5YGdL
        CGxjl3j0YikLxNkuEscWtzJB2MISr45vYYewZST+74RpaGaUeHhuLTuE0wP0dNMMqKetJe6c
        +wW0jgNohabE+l36EGFHiadvd4CFJQT4JG68FYQ4gk9i0rbpzBBhXomONiGIajWJWcfXwa09
        eOES8wRGpVlIXpuF5J1ZSN6ZhbB3ASPLKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k/NxNjMCU
        dPrf8a87GPf9STrEKMDBqMTDe0GPO16INbGsuDL3EKMEB7OSCK/T2dNxQrwpiZVVqUX58UWl
        OanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTBGtW26PXNp+Kf50mm3r8wzZ5ut
        fu/vayEp9n0yXd5O3vnsM3y2bD6xXOuhEkvPh0cTXz6Kf3a2/aCyvayMTaun5CbvNE029hVz
        Dd2n6Xv9fK3WtCHOa3daMR9DtfV8SxeBgO2NdTYrlTQ/PXI68D/VOuk5X/nLjv5LJ82CWNnq
        thSUh3uFhCqxFGckGmoxFxUnAgCkzq3yRQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xu7ovNHniDZoWclg0Nyxmstg4Yz2r
        xbzPshaXd81hs/jce4TR4vO2WewWTx72sVlMWLyR3YHD43JfL5PH4j0vmTzuXNvD5jHvZKBH
        35ZVjB6fN8kFsEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
        pRbp2yXoZbw9xV9wR6piydy6BsZjYl2MnBwSAiYSnx+cZQKxhQSWMkpsahKAiMtInJzWwAph
        C0v8udbF1sXIBVTzllHiyfLd7CAJYYEQiV8/PjKC2GwChhJdb0GKODlEBJwlrp68C1bDLHCO
        UWL9/QqI5sdMEs+OnQBL8ArYSZx60gG2mUVAVeLqvB1gcVGBOInlW+ZD1QhKnJz5hAXE5hSw
        l3g08RobxFAziXmbHzJD2PISzVtnQ9niEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGpp
        cW56brGRXnFibnFpXrpecn7uJkZgBG479nPLDsaud8GHGAU4GJV4eC/occcLsSaWFVfmHmKU
        4GBWEuF1Ons6Tog3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgckhryTe0NTQ3MLS0NzY3NjM
        Qkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo/ufO3c+9Hi9jz6hyMrbHNV9qfia/433DL/0
        OL/qPM6xf3zJPeb55lI7raX7V7l9NrKx+x5zwpTrwhRNnT070mYvXG5V5OZVx7ig7d1m1qSn
        rL949q2MqohOvMU/U8c+LfFaUpjp83tl4lt+8tYFTLNZXZE/92ds9sQL7J2FzQbMV7kjInlT
        lFiKMxINtZiLihMBZayc89YCAAA=
X-CMS-MailID: 20200713093120eucas1p20559a77ab67ac05958a4ba76c4bb20e0
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
        <8a34e9c4-6457-cfd2-3d05-05f80a630a0d@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi

On 07.07.2020 11:15, Marek Szyprowski wrote:
> On 06.07.2020 15:46, Daniel Lezcano wrote:
>> On 06/07/2020 15:17, Marek Szyprowski wrote:
>>> On 06.07.2020 12:55, Daniel Lezcano wrote:
>>>> The generic netlink protocol is implemented but the different
>>>> notification functions are not yet connected to the core code.
>>>>
>>>> These changes add the notification calls in the different
>>>> corresponding places.
>>>>
>>>> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> This patch landed in today's linux-next 20200706 as commit 5df786e46560
>>> ("thermal: core: Add notifications call in the framework"). Sadly it
>>> breaks booting various Samsung Exynos based boards. Here is an example
>>> log from Odroid U3 board:
>>>
>>> Unable to handle kernel NULL pointer dereference at virtual address 
>>> 00000010
>>> pgd = (ptrval)
>>> [00000010] *pgd=00000000
>>> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
>>> Modules linked in:
>>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3-00015-g5df786e46560
>>> #1146
>>> Hardware name: Samsung Exynos (Flattened Device Tree)
>>> PC is at kmem_cache_alloc+0x13c/0x418
>>> LR is at kmem_cache_alloc+0x48/0x418
>>> pc : [<c02b5cac>]    lr : [<c02b5bb8>]    psr: 20000053
>>> ...
>>> Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
>>> Control: 10c5387d  Table: 4000404a  DAC: 00000051
>>> Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
>>> Stack: (0xee8f1cf8 to 0xee8f2000)
>>> ...
>>> [<c02b5cac>] (kmem_cache_alloc) from [<c08cd170>] 
>>> (__alloc_skb+0x5c/0x170)
>>> [<c08cd170>] (__alloc_skb) from [<c07ec19c>]
>>> (thermal_genl_send_event+0x24/0x174)
>>> [<c07ec19c>] (thermal_genl_send_event) from [<c07ec648>]
>>> (thermal_notify_tz_create+0x58/0x74)
>>> [<c07ec648>] (thermal_notify_tz_create) from [<c07e9058>]
>>> (thermal_zone_device_register+0x358/0x650)
>>> [<c07e9058>] (thermal_zone_device_register) from [<c1028d34>]
>>> (of_parse_thermal_zones+0x304/0x7a4)
>>> [<c1028d34>] (of_parse_thermal_zones) from [<c1028964>]
>>> (thermal_init+0xdc/0x154)
>>> [<c1028964>] (thermal_init) from [<c0102378>] 
>>> (do_one_initcall+0x8c/0x424)
>>> [<c0102378>] (do_one_initcall) from [<c1001158>]
>>> (kernel_init_freeable+0x190/0x204)
>>> [<c1001158>] (kernel_init_freeable) from [<c0ab85f4>]
>>> (kernel_init+0x8/0x118)
>>> [<c0ab85f4>] (kernel_init) from [<c0100114>] (ret_from_fork+0x14/0x20)
>>>
>>> Reverting it on top of linux-next fixes the boot issue. I will
>>> investigate it further soon.
>> Thanks for reporting this.
>>
>> Can you send the addr2line result and code it points to ?
>
> addr2line of c02b5cac (kmem_cache_alloc+0x13c/0x418) points to 
> mm/slub.c +2839, but I'm not sure if we can trust it. imho it looks 
> like some trashed memory somewhere, but I don't have time right now to 
> analyze it further now...

Just one more thing I've noticed. The crash happens only if the kernel 
is compiled with old GCC (tested with arm-linux-gnueabi-gcc (Linaro GCC 
4.9-2017.01) 4.9.4). If I compile kernel with newed GCC (like 
arm-linux-gnueabi-gcc (Linaro GCC 6.4-2017.11) 6.4.1 20171012), it works 
fine...

This happens also with Linux next-20200710, which again got this commit.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

