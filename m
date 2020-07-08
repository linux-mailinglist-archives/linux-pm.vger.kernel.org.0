Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2222B21854A
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 12:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgGHKw6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 06:52:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35570 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728521AbgGHKw5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2020 06:52:57 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200708105256euoutp02d8454f6904e6bd2e789669a72dd30df6~fwYZpMMdC2351323513euoutp02n
        for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2020 10:52:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200708105256euoutp02d8454f6904e6bd2e789669a72dd30df6~fwYZpMMdC2351323513euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594205576;
        bh=8cv3BY8rhZiowdOYtWgygGS3Rx7HHvw149D4xWAek5I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IOgkAyBe9rai7kVAAu2QAZFlsXPPukhVQgHPkbFJzDcf6uJ+Djcl0dZL/hQax0ATm
         rW5KZTWo2yzXYgotabHBzNM+P4blYvn5/fCMRXLHZSmI+KRQ9byDgV1LKg2Gotrkzt
         8mdstTMz1Rd+0FN8ettgstiPwqxuO4hB9sQhYFeU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200708105255eucas1p2548e027b63151ddbc3930e14a909af0f~fwYZKwzd51536015360eucas1p2V;
        Wed,  8 Jul 2020 10:52:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3B.1C.06456.785A50F5; Wed,  8
        Jul 2020 11:52:55 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200708105255eucas1p229180d35b47e4a350fbb72ea5e2df2a9~fwYY45EE11334013340eucas1p2W;
        Wed,  8 Jul 2020 10:52:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200708105255eusmtrp1930ecde1efb1a571e8a06dc715f2a286~fwYY4Lw011950319503eusmtrp1o;
        Wed,  8 Jul 2020 10:52:55 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-ea-5f05a587f0e1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5B.6B.06017.785A50F5; Wed,  8
        Jul 2020 11:52:55 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200708105254eusmtip233ca8aacc24a7fc9b0dafeafbd0a6fc0~fwYYRV4Cb0877408774eusmtip2J;
        Wed,  8 Jul 2020 10:52:54 +0000 (GMT)
Subject: Re: [RFC PATCH 0/2] PM / devfreq: Add delayed timer for polling
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     lukasz.luba@arm.com, k.konieczny@samsung.com, krzk@kernel.org,
        kgene@kernel.org, s.nawrocki@samsung.com,
        willy.mh.wolff.ml@gmail.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <bb3a5b29-c90f-5668-e46d-9eeeb5a9b973@samsung.com>
Date:   Wed, 8 Jul 2020 12:52:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200703062622.11773-1-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7djP87rtS1njDY7NUrWYeOMKi8X1L89Z
        LRZ8msFq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XCphZ2i9uNK9gs
        Dr9pZ7X4duIRowOfx5p5axg9ds66y+6xaVUnm8fmJfUefVtWMXp83iQXwBbFZZOSmpNZllqk
        b5fAlfH3yU7Wgm/CFWsW/GFuYJwt0MXIySEhYCJxbeVSxi5GLg4hgRWMEntmr2KBcL4wSsx/
        d58JwvnMKHFg+Sd2mJaTbz5DtSxnlFja8wzKecsoMf3HCmaQKmEBD4m797vBOkQENCRm/r0C
        VsQscItJ4tThG4wgCTYBK4mJ7avAbF4BO4mFV26CNbMIqEj8P3CVCcQWFYiQ+PTgMCtEjaDE
        yZlPWEBsTgFriTs999hAbGYBcYlbT+YzQdjyEtvfzmEGWSYh8JZd4veNu8wQd7tIfDnwCuoH
        YYlXx7dA2TISpyf3sEA0rGOU+NvxAqp7O6PE8sn/2CCqgNad+wVkcwCt0JRYv0sfxJQQcJS4
        1CUFYfJJ3HgrCHEDn8SkbdOZIcK8Eh1tQhAz1CQ2LNvABrO1a+dK5gmMSrOQfDYLyTezkHwz
        C2HtAkaWVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIFJ7fS/4592MH69lHSIUYCDUYmH
        NyORJV6INbGsuDL3EKMEB7OSCK/T2dNxQrwpiZVVqUX58UWlOanFhxilOViUxHmNF72MFRJI
        TyxJzU5NLUgtgskycXBKNTC6TEhKsdwrlboobJ1PvaLfus16S86funKyW4f5g3DwhLX/7P9M
        2XMy9Ntua+73r/sUjLTuHLjioWC4ccbFJQwfWNdeOJ29Iyhhe0RV1OygBgfe73NWnfa5sXTB
        Htf0Sa4Cp9/71V+zSzO7fO51rkZmQswWTU0uwXsXZh86tvD5v7PGl0Jfhn/eqsRSnJFoqMVc
        VJwIAAvvUe1mAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xe7rtS1njDVZ/F7SYeOMKi8X1L89Z
        LRZ8msFq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XCphZ2i9uNK9gs
        Dr9pZ7X4duIRowOfx5p5axg9ds66y+6xaVUnm8fmJfUefVtWMXp83iQXwBalZ1OUX1qSqpCR
        X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl/H3yU7Wgm/CFWsW/GFu
        YJwt0MXIySEhYCJx8s1nxi5GLg4hgaWMEg+XfgJyOIASMhLH15dB1AhL/LnWxQZR85pR4lFH
        CxtIQljAQ+Lu/W52EFtEQENi5t8rjCA2s8AtJokVr0JB5ggJ9DFKfIoDCbMJWElMbF8FVsIr
        YCex8MpNZhCbRUBF4v+Bq0wgtqhAhMThHbOgagQlTs58wgJicwpYS9zpuccGMV5d4s+8S8wQ
        trjErSfzmSBseYntb+cwT2AUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYSK84Mbe4NC9d
        Lzk/dxMjMH63Hfu5ZQdj17vgQ4wCHIxKPLwZiSzxQqyJZcWVuYcYJTiYlUR4nc6ejhPiTUms
        rEotyo8vKs1JLT7EaAr03ERmKdHkfGBqySuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKa
        nZpakFoE08fEwSnVwJhqd0DUlXGCz9YDIYH1E6eYyzzMPq23TvBdxddJt7OPC0+5bXGhilXM
        K8hHJeuVRMgsH1/9NPEv5VVp/IaOuyYb/nnx/a2w9AuPn29Xdfv4f7/yksHgJLNAjYdarTz7
        78P6rS+k/lwQbl2xs0nh2CyFFVHv07aIHZQ7PVEi/FSrILdo+S3PiUosxRmJhlrMRcWJACZW
        R3/1AgAA
X-CMS-MailID: 20200708105255eucas1p229180d35b47e4a350fbb72ea5e2df2a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200703061508epcas1p171aa3c0ab832b77e5837d8bd1e563742
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200703061508epcas1p171aa3c0ab832b77e5837d8bd1e563742
References: <CGME20200703061508epcas1p171aa3c0ab832b77e5837d8bd1e563742@epcas1p1.samsung.com>
        <20200703062622.11773-1-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Chanwoo,

On 7/3/20 8:26 AM, Chanwoo Choi wrote:
> Add the delayed timer to devfreq framework in order to support
> the periodical polling mode without stop caused by CPU idle state.

Thank you, this patchset looks fine to me and is a step in the right
direction:

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> Some Non-CPU device must need to monitor the device status like
> utilization regardless of CPU state.

This is probably true for all devfreq devices using simple_ondemand
governor by default:

drivers/devfreq/exynos-bus.c
drivers/devfreq/rk3399_dmc.c
drivers/devfreq/tegra20-devfreq.c
drivers/gpu/drm/lima/lima_devfreq.c
drivers/gpu/drm/msm/msm_gpu.c
drivers/gpu/drm/panfrost/panfrost_devfreq.c
drivers/memory/samsung/exynos5422-dmc.c
drivers/scsi/ufs/ufshcd.c

With devfreq device polling being "coupled" to CPU idle state
the devfreq subsystem behavior is completely unpredictable and
unreliable.

It affects both performance (device opp change up happening too
late) and power consumption (device opp change down happening too
late).

It also causes hardware usage counters support to report too high
values (because of CPU idle "coupling" the real polling period
becomes larger than maximum period supported by the counter and
the counter becomes fully "saturated") which negatively affects
power consumption (as has been observed when using Odroid XU3/4).

[ The only upside of using such "coupling" is lowered CPU power
  usage (in some situations) but at the (unacceptable IMHO) cost
  of the correctness of operations of devfreq subsystem. ]

Unfortunately this patchset currently fixes only exynos5422-dmc
devfreq driver. To fix problems for Exynos platforms we need to
also fix exynos-bus devfreq driver.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> - patch1 explains the detailed reason why the delayed timer is required.
> - patch2 initializes that exynos5422-dmc device use delayed timer as default
> instead of deferrable timer.
> 
> Chanwoo Choi (2):
>   PM / devfreq: Add support delayed timer for polling mode
>   memory: samsung: exynos5422-dmc: Use delayed timer as default
> 
>  Documentation/ABI/testing/sysfs-class-devfreq | 12 +++
>  drivers/devfreq/devfreq.c                     | 83 ++++++++++++++++++-
>  drivers/memory/samsung/exynos5422-dmc.c       |  1 +
>  include/linux/devfreq.h                       |  9 ++
>  4 files changed, 104 insertions(+), 1 deletion(-)
