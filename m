Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1471375D1
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 15:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfFFN5c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 09:57:32 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49979 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfFFN5c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jun 2019 09:57:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190606135730euoutp0292adafde8c7cdd882bedfe14a26da6b9~loJ8A10pT2892328923euoutp02V
        for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2019 13:57:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190606135730euoutp0292adafde8c7cdd882bedfe14a26da6b9~loJ8A10pT2892328923euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559829450;
        bh=qfiWKm4oy633kNOl1n1lWHSeQY0kLY/qBAJbe3ytBCE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Cb5lisiBKO6qZiBki0s0PKkBepHhIWKBzOSIqCHKB888IRsa9ULUOEcnifHfuXM9t
         LWbZg6zW3pRWXjM249R3sjd43cVoBJbsDPi4M20PKmatMTGWegaTMQZt1NNWIWra+5
         GxXvXfjafz5YV0OpjdzfzLcXMjRFKHI+YoCOoJ88=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190606135729eucas1p285cb608519e7e78c76b567dffb4c0ae5~loJ6745aX1661816618eucas1p2J;
        Thu,  6 Jun 2019 13:57:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2A.2E.04298.9CB19FC5; Thu,  6
        Jun 2019 14:57:29 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190606135728eucas1p1bd7e94ec2de4343cbf63a5a51ae1164b~loJ56lXAq1775117751eucas1p10;
        Thu,  6 Jun 2019 13:57:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190606135728eusmtrp28bdc9e69bdf7cda337307cd3862199a7~loJ5q3LZl1085410854eusmtrp2S;
        Thu,  6 Jun 2019 13:57:28 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-f2-5cf91bc9cc62
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 97.2E.04140.8CB19FC5; Thu,  6
        Jun 2019 14:57:28 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190606135727eusmtip2fd0deda65f36dbda83992becd8ba388c~loJ4yRMU-3116631166eusmtip2p;
        Thu,  6 Jun 2019 13:57:27 +0000 (GMT)
Subject: Re: [PATCH v8 00/13] Exynos5 Dynamic Memory Controller driver
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com,
        linux-clk <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <b1024bed-a8d9-12d9-9e20-5e5624a1b189@samsung.com>
Date:   Thu, 6 Jun 2019 15:57:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605165410.14606-1-l.luba@partner.samsung.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUyMcRz3u3vueZ47Lk+X1rfyMrc2YyqZ5bcxw8jjZcY/XpI4PHrRXe0e
        RcxWTta7lug6pbwNWUvXLYWRpEulk7xcL2iqJSS9UYvS3ZPpv8/38/189vl+ti8tVpwh3egQ
        zVFOq1GFKUkZUVI1YvF87j4SsOSCYTou0hdK8LvBLgnOrayX4Dt97Qifr8kR4bokNT7X/lWM
        LZa7FH5x+huFm2Nm477kDxLceD+bxAMplQjrLY9EuKDyPYUbatbjlthbJB57W0Tgx6834ZZR
        B/yz+hNa7cz+HEon2F5rHMVeimkg2DLDe4o15ieQbIruO8k++f5QxKaa8hFbXHuSHTDO3Sbz
        l608xIWFRHFa71X7ZcFWXRIR0U0f/5xSJYlBY2QiktLALIOMjgzKhhXMLQSFv0MSkWwCDyJ4
        UpRGCcMAgurGZOqfo7GshBQcNxHoTV6CqAfB1T8G+8KJ8YO6+Fd2wyxmMVj6e0U2kZjJJuBZ
        fSphW5CMD6Q8S0U2LGdWQZPeYjcQjAc8NebaNc7MLhgsM05qHOF5VoedlzKr4aK52I7FjAuc
        HrwtEfA8uNeTLbaFAVNKgzlHh4Sz14G1bogQsBN8MZsm68yG8bJckWDQIUh+0EIJQxqCj+a8
        SfcKeGpumIigJyIWQuF9b4FeAz/iPthpYBzA2uMoHOEA6SWZYoGWQ/xZhaD2gNH8TJGA3SCp
        Y5xIQ0rDlGqGKXUMU+oY/ufmISIfuXCRvDqI43003DEvXqXmIzVBXgfD1UY08Zu1Y+b+UjT0
        6kAFYmiknCFnqZEAhUQVxUerKxDQYuUsedTL4QCF/JAq+gSnDd+njQzj+ArkThNKF/nJaW17
        FEyQ6ih3hOMiOO2/rYiWusUggrYm9Nc0XbnsCy5d9em838Zd7ldCD+gDTTc2hHcv3v4go/f4
        nGD/HVt5TadC4+k7c0+59VqxNnN5SfOW2pq1b5Z0mlUDfYnzTe6brifs7YgrUEjLF5B+Hq4b
        pAtPuZaaDw+34p0nfnUFLv1WsPmSLtb/eptXbC3du3nv7tCM0NYsJcEHq3wWibW86i+Ik8nj
        lwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsVy+t/xe7onpH/GGExewWaxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGPxseceq8XlXXPYLD73
        HmG0mHF+H5PF2iN32S0unnK1uN0INPHftY0sFvuveFnc/s1n8e3EI0YHUY9vXyexeLy/0cru
        MbvhIovHzll32T02repk8+htfsfmcfDdHiaPvi2rGD02n672+LxJLoArSs+mKL+0JFUhI7+4
        xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/jRnM3S8FLjooXvcdYGxj/
        sXUxcnJICJhIXN65Dcjm4hASWMooMXfqayCHAyghJTG/RQmiRljiz7UuqJrXjBKLLx5lBUkI
        C7hJnOm4xA5iiwjoSJz/9J4JpIhZYA6LROfS5ewQHZMZJf5NXQi2jk3AUKL3aB8jiM0rYCdx
        c8Z5sG4WARWJw5vms4DYogIRErN3NbBA1AhKnJz5BMzmFHCQmHZ8M5jNLKAu8WfeJWYIW1yi
        6ctKVghbXmL72znMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P
        3cQITBTbjv3csoOx613wIUYBDkYlHt4ZTD9jhFgTy4orcw8xSnAwK4nwll34ESPEm5JYWZVa
        lB9fVJqTWnyI0RTouYnMUqLJ+cAkllcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1
        ILUIpo+Jg1OqgfHY56MZVh92/u0p+V16fdPdHQoOzv4fZm1bIiPc79Lgq+P260+VZfCXjSuD
        OzoceV1nTRLvmDktpepVHctf3l+cHoeqTr03Fy5U2/LD7Pame94f/upM+HHzlX2YTPqr3+kX
        uCN+nmCbeMY715qB8dds451pRl9jtJ5rvk9m7JNbuHrPRJNdBw8qsRRnJBpqMRcVJwIAHcs0
        wyoDAAA=
X-CMS-MailID: 20190606135728eucas1p1bd7e94ec2de4343cbf63a5a51ae1164b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165426eucas1p20524669a299f740b5502db24977b098f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165426eucas1p20524669a299f740b5502db24977b098f
References: <CGME20190605165426eucas1p20524669a299f740b5502db24977b098f@eucas1p2.samsung.com>
        <20190605165410.14606-1-l.luba@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/5/19 18:53, Lukasz Luba wrote:
> Lukasz Luba (13):
>   clk: samsung: add needed IDs for DMC clocks in Exynos5420
>   clk: samsung: add new clocks for DMC for Exynos5422 SoC
>   clk: samsung: add BPLL rate table for Exynos 5422 SoC
>   dt-bindings: ddr: rename lpddr2 directory
>   dt-bindings: ddr: add LPDDR3 memories
>   drivers: memory: extend of_memory by LPDDR3 support
>   dt-bindings: memory-controllers: add Exynos5422 DMC device description
>   drivers: memory: add DMC driver for Exynos5422
>   drivers: devfreq: events: add Exynos PPMU new events
>   ARM: dts: exynos: add chipid label and syscon compatible
>   ARM: dts: exynos: add syscon to clock compatible
>   ARM: dts: exynos: add DMC device for exynos5422
>   ARM: exynos_defconfig: enable DMC driver


I have applied first 3 patches from this series to clk/samsung tree.

But can you please also send this series to linux-clk@vger.kernel.org 
ML, adding the clk maintainers (Stephen, Michael) at Cc?

Please make sure if future any clk patches are also sent to 
linux-clk@vger.kernel.org mailing list.

-- 
Thanks,
Sylwester

