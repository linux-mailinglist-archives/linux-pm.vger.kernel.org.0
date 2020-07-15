Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E272204C8
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 08:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgGOGJ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 02:09:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57362 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgGOGJ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 02:09:27 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200715060925euoutp0187c01691451226aac90dc829a653bdaf~h2B2ywUxs1898718987euoutp01D
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 06:09:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200715060925euoutp0187c01691451226aac90dc829a653bdaf~h2B2ywUxs1898718987euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594793365;
        bh=4RyTK5YdV7uLppFPF96u+pYNl8SDIfUmV01BP93CLnA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=k1c9QrmWS/NN0JHA4h7URElYKG6WOFoiLMw23S3Ot15kLxizEpyYqb+4vyzSc39Bb
         UsVfvyds95dhA/OjMoGWYJu70jl6JEaariUNRwU1mviHcPOqRq3MyBA9Sx/aTtB1oY
         Ey826WSHXSrvh7eBjN5VhY2lPDkbBgHwIG2EuAPQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200715060924eucas1p14a1dcd4ae7990c795f08245390a0abb7~h2B2g2YZO1886318863eucas1p1E;
        Wed, 15 Jul 2020 06:09:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5B.2B.06456.49D9E0F5; Wed, 15
        Jul 2020 07:09:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200715060924eucas1p154109f1cd1316452c5c8330461d9423e~h2B2KoEBk1046610466eucas1p1Y;
        Wed, 15 Jul 2020 06:09:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200715060924eusmtrp1c4fdd160ecb2e64e5f00aceb0d554b53~h2B2J2rde0891608916eusmtrp1U;
        Wed, 15 Jul 2020 06:09:24 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-d5-5f0e9d949b19
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F7.B1.06017.49D9E0F5; Wed, 15
        Jul 2020 07:09:24 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200715060923eusmtip1d6f71525cd30663353dca8cd30f9d34a~h2B1oTFqg1110011100eusmtip1X;
        Wed, 15 Jul 2020 06:09:23 +0000 (GMT)
Subject: Re: [PATCH v4 4/4] thermal: core: Add notifications call in the
 framework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Arnd Bergmann <arnd.bergmann@linaro.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <6cf5d9a9-a142-d2e0-10e3-10271a4bb926@samsung.com>
Date:   Wed, 15 Jul 2020 08:09:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4cfb15f6-2801-3386-c7cf-6296a54571a1@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djPc7pT5vLFG7T2Glo0NyxmsljZ422x
        ccZ6Vot5n2UtLu+aw2bxufcIo8XnbbPYLZ487GOzmLB4I7sDp8flvl4mj8V7XjJ53Lm2h81j
        3slAj74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL4MrYPuMhS8EK1YrrM8IbGNfLdzFyckgImEis
        XnKaGcQWEljBKLFzbV0XIxeQ/YVR4tX1L8wQzmdGia+TjjPBdCztfckOkVjOKHGg8R4ThPOe
        UeLP2xY2kCphgRCJXz8+MoLYIgLOEldP3gXrYBb4wSixZW43K0iCTcBQouttF1gDr4CdxIvJ
        nUCTODhYBFQllt0RAQmLCsRJrH+5nQmiRFDi5MwnLCA2J1B5//ulYDazgLxE89bZzBC2uMSt
        J/PBDpIQOMYu0TH1KxvE2S4SO9sfsEDYwhKvjm9hh7BlJE5P7mGBaGhmlHh4bi07hNPDKHG5
        aQYjRJW1xJ1zv9hArmMW0JRYv0sfIuwo8fTtDrCwhACfxI23ghBH8ElM2jadGSLMK9HRJgRR
        rSYx6/g6uLUHL1xinsCoNAvJa7OQvDMLyTuzEPYuYGRZxSieWlqcm55abJiXWq5XnJhbXJqX
        rpecn7uJEZiaTv87/mkH49dLSYcYBTgYlXh4LabzxguxJpYVV+YeYpTgYFYS4XU6ezpOiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOK/xopexQgLpiSWp2ampBalFMFkmDk6pBsa5JQusbr67bXN4
        /v7jFU8LPTNsJv869GnxS87nbxSZLopnPMsvnW2/kGHHrg1zQmOdVF1kzNpmL3zxvP1hvYLA
        9QS+83skxdIcyz3E4yUlbb9tfz/v9Z8/S2bFcN13PTlfeHrzkZWv9xkVsR6+blXCUtzecVKt
        KHrSzXN2O5cyF2bMa4hbxPVTiaU4I9FQi7moOBEAUMJpgkkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7pT5vLFG1w+KWbR3LCYyWJlj7fF
        xhnrWS3mfZa1uLxrDpvF594jjBaft81it3jysI/NYsLijewOnB6X+3qZPBbvecnkcefaHjaP
        eScDPfq2rGL0+LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384m
        JTUnsyy1SN8uQS9j+4yHLAUrVCuuzwhvYFwv38XIySEhYCKxtPclexcjF4eQwFJGiQsf/rBA
        JGQkTk5rYIWwhSX+XOtigyh6yyjxeNpRdpCEsECIxK8fHxlBbBEBZ4mrJ++CTWIW+MUo8Xvv
        DVaIjgYWiTPXNoKNYhMwlOh6CzKKk4NXwE7ixeROpi5GDg4WAVWJZXdEQMKiAnESy7fMZ4co
        EZQ4OfMJ2EWcQOX975eC2cwCZhLzNj9khrDlJZq3zoayxSVuPZnPNIFRaBaS9llIWmYhaZmF
        pGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwGjcduznlh2MXe+CDzEKcDAq8fBOmMkb
        L8SaWFZcmXuIUYKDWUmE1+ns6Tgh3pTEyqrUovz4otKc1OJDjKZAv01klhJNzgcmirySeENT
        Q3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYwF274pK+ycvV2scPVGXpv3
        lZ6VTmdksntKZvkxO2zbd1S9Vz2Yy0w+fWvfgltBNVLxvMZrDRlPJdusDpO7rGXFf/Oct2hc
        xBtji8JX93UnqVxhfdgwW/zcBbadV/+rvufQ7Og2m3Hvq8ST4xIzumL33v6xS539yvwdPTP5
        XeozVkR33GvnLlNiKc5INNRiLipOBADKyG3E3AIAAA==
X-CMS-MailID: 20200715060924eucas1p154109f1cd1316452c5c8330461d9423e
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
        <41466d5a-24fb-b861-93ae-3ed190af7174@samsung.com>
        <75683b75-6e1b-6e4e-2354-477c487a5f5f@linaro.org>
        <4cfb15f6-2801-3386-c7cf-6296a54571a1@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 15.07.2020 01:20, Daniel Lezcano wrote:
> On 13/07/2020 22:32, Daniel Lezcano wrote:
>> On 13/07/2020 11:31, Marek Szyprowski wrote:
>>> On 07.07.2020 11:15, Marek Szyprowski wrote:
>>>> On 06.07.2020 15:46, Daniel Lezcano wrote:
>>>>> On 06/07/2020 15:17, Marek Szyprowski wrote:
>>>>>> On 06.07.2020 12:55, Daniel Lezcano wrote:
>>>>>>> The generic netlink protocol is implemented but the different
>>>>>>> notification functions are not yet connected to the core code.
>>>>>>>
>>>>>>> These changes add the notification calls in the different
>>>>>>> corresponding places.
>>>>>>>
>>>>>>> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
>>>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>>> This patch landed in today's linux-next 20200706 as commit 5df786e46560
>>>>>> ("thermal: core: Add notifications call in the framework"). Sadly it
>>>>>> breaks booting various Samsung Exynos based boards. Here is an example
>>>>>> log from Odroid U3 board:
>>>>>>
>>>>>> Unable to handle kernel NULL pointer dereference at virtual address
>>>>>> 00000010
>>>>>> pgd = (ptrval)
>>>>>> [00000010] *pgd=00000000
>>>>>> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
>>>>>> Modules linked in:
>>>>>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3-00015-g5df786e46560
>>>>>> #1146
>>>>>> Hardware name: Samsung Exynos (Flattened Device Tree)
>>>>>> PC is at kmem_cache_alloc+0x13c/0x418
>>>>>> LR is at kmem_cache_alloc+0x48/0x418
>>>>>> pc : [<c02b5cac>]    lr : [<c02b5bb8>]    psr: 20000053
>>>>>> ...
>>>>>> Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
>>>>>> Control: 10c5387d  Table: 4000404a  DAC: 00000051
>>>>>> Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
>>>>>> Stack: (0xee8f1cf8 to 0xee8f2000)
>>>>>> ...
>>>>>> [<c02b5cac>] (kmem_cache_alloc) from [<c08cd170>]
>>>>>> (__alloc_skb+0x5c/0x170)
>>>>>> [<c08cd170>] (__alloc_skb) from [<c07ec19c>]
>>>>>> (thermal_genl_send_event+0x24/0x174)
>>>>>> [<c07ec19c>] (thermal_genl_send_event) from [<c07ec648>]
>>>>>> (thermal_notify_tz_create+0x58/0x74)
>>>>>> [<c07ec648>] (thermal_notify_tz_create) from [<c07e9058>]
>>>>>> (thermal_zone_device_register+0x358/0x650)
>>>>>> [<c07e9058>] (thermal_zone_device_register) from [<c1028d34>]
>>>>>> (of_parse_thermal_zones+0x304/0x7a4)
>>>>>> [<c1028d34>] (of_parse_thermal_zones) from [<c1028964>]
>>>>>> (thermal_init+0xdc/0x154)
>>>>>> [<c1028964>] (thermal_init) from [<c0102378>]
>>>>>> (do_one_initcall+0x8c/0x424)
>>>>>> [<c0102378>] (do_one_initcall) from [<c1001158>]
>>>>>> (kernel_init_freeable+0x190/0x204)
>>>>>> [<c1001158>] (kernel_init_freeable) from [<c0ab85f4>]
>>>>>> (kernel_init+0x8/0x118)
>>>>>> [<c0ab85f4>] (kernel_init) from [<c0100114>] (ret_from_fork+0x14/0x20)
>>>>>>
>>>>>> Reverting it on top of linux-next fixes the boot issue. I will
>>>>>> investigate it further soon.
>>>>> Thanks for reporting this.
>>>>>
>>>>> Can you send the addr2line result and code it points to ?
>>>> addr2line of c02b5cac (kmem_cache_alloc+0x13c/0x418) points to
>>>> mm/slub.c +2839, but I'm not sure if we can trust it. imho it looks
>>>> like some trashed memory somewhere, but I don't have time right now to
>>>> analyze it further now...
>>> Just one more thing I've noticed. The crash happens only if the kernel
>>> is compiled with old GCC (tested with arm-linux-gnueabi-gcc (Linaro GCC
>>> 4.9-2017.01) 4.9.4). If I compile kernel with newed GCC (like
>>> arm-linux-gnueabi-gcc (Linaro GCC 6.4-2017.11) 6.4.1 20171012), it works
>>> fine...
>>>
>>> This happens also with Linux next-20200710, which again got this commit.
>> So I finally succeed to reproduce on an ARM64 with a recent compiler,
>> earlycon, and the option CONFIG_INIT_ON_ALLOC_DEFAULT_ON.
>
> Finally, narrowed down the issue.
>
>   - genetlink initialization is done at subsys initcall.
>   - thermal netlink init is done at core initcall
>   - netlink is done at core initcall
>
> By changing the order:
>
>   - netlink and genetlink at core initcall
>   - thermal init at postcore initcall
>
> That fixes the problem.
I confirm that such change fixes the issue! Feel free to add:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

to the final patch.

> The genetlink initcall order is from 2005 and
> IMO it makes sense to come right after the netlink initialization.
>
> It is acceptable to have the thermal init at the postcore initcall. It
> is very recently we moved from fs_initcall to core_initcall.
>
> Thanks to Arnd who give me a direction to look at.
Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

