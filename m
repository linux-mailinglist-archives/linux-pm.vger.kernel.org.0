Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07F8C37759
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 17:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfFFPD1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 11:03:27 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41055 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbfFFPD1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jun 2019 11:03:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190606150325euoutp0257255a13d4c5c87ae3dedc943bf84675~lpDffIONZ3265432654euoutp02G
        for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2019 15:03:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190606150325euoutp0257255a13d4c5c87ae3dedc943bf84675~lpDffIONZ3265432654euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559833405;
        bh=lf3NtysweyoEv16QIEzPO8Xm5u1eQaNJ4nPrM5o5xAw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fjLE/BwvcERz/BZVnqtVqUmubtKN9zD+2XDnPbwUvwaafIX9yJ5JUBP44u02dwSdC
         AEo6dSanh1pGs8ls3DmJ5Z09om6PVLFkmr4elicXGczVMjxXVQSgaDRAAXNFOXRxEB
         CyCPW1q3z+CLy0I9+SKINHFE1rgc1ttBvNuwx28Y=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190606150324eucas1p2cf5e4be4ec04c1da69b00e7679367edb~lpDel-I5e1598915989eucas1p2n;
        Thu,  6 Jun 2019 15:03:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 86.B5.04298.C3B29FC5; Thu,  6
        Jun 2019 16:03:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190606150324eucas1p16fcd068025525704df3ccb9afb64e67c~lpDd1xbPy2365023650eucas1p1i;
        Thu,  6 Jun 2019 15:03:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190606150323eusmtrp1e7952e3af6f21e524e02bd886fcb7ceb~lpDdmA28w1121211212eusmtrp12;
        Thu,  6 Jun 2019 15:03:23 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-e6-5cf92b3cbf93
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A1.4A.04146.B3B29FC5; Thu,  6
        Jun 2019 16:03:23 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190606150322eusmtip185c1b85f91676387c126706d2479f284~lpDcxPOMy0891108911eusmtip1i;
        Thu,  6 Jun 2019 15:03:22 +0000 (GMT)
Subject: Re: [PATCH v8 00/13] Exynos5 Dynamic Memory Controller driver
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
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
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <e976f842-a2f6-e75b-25c8-0d1fa21cf05a@partner.samsung.com>
Date:   Thu, 6 Jun 2019 17:03:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b1024bed-a8d9-12d9-9e20-5e5624a1b189@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvZ2ZzrSxOBSUE3GJjQ+KAST6cCO4JWhGHwyauEKiVSdAoEU6
        gCAm4oKsFWMVsULYXKuAYIPUPaVYBdmNVgVipCpRcAMUIiHSDkbevvuf/9zzn+QwhHKMms1E
        axN4nVYdq5LKydonoy3+IUtGI5aWPFbh6oIqCr8a+kThYlsLhW/86EXY0Fgkwc9zNDiv9wuB
        W1tv0bj5WD+Nf+T2ULjzbqEUD+ptCBe0PpTgCls3jdsb1+G3R69JcX1/BoXHX1aT+NGLjfjt
        Hw/86+l7tGYm92v4DMl9c6TT3MW0dpKzGLtprsaUJeX0x79KuVNmE+JuN6VygzXzwmS75CH7
        +djoJF4XuGqPPKqhdOuBbnlyRkUzlYaqmWwkY4BdDg+MJ6QuVrLXEFQ+jMpG8gkeQqC/d10q
        PgYRGD45qX8d1uF0WixcRfD7fhYttg8gyB3XutiLXQ/PMzvcujcbCJdM7e6fCLaQhIaWU2Q2
        YhgpGwB1pniXRzHhL+4sI1xMsgsh82K9m2eyO2DIUoNEjyc8u+AkXSxjV8OH1w43E6wPvHEW
        S0SeD3cGCgnXLGArGMhxNk+mDgW7rWuSveCz3UyLPAeaDLmkyAKk6UuRyIehN69o0hMM9fZ2
        ypWZYBdD1d1AUV4L39N73DKwHuAY8BQjeMCZ2vOEKCsg86RSdC8Cc26bRORZcPVmPn0aqYxT
        FjNOWcY4ZRnj/7kliDQhHz5R0ETyQpCWPxggqDVCojYyYF+cpgZN3GTTuP1nHRru2GtFLINU
        0xUcPRqhpNRJQorGioAhVN6KpLaRCKVivzrlEK+L261LjOUFK/JlSJWPInXau3AlG6lO4GN4
        /gCv+1eVMLLZaSiKdIRf6ViZ77O9oM63lJzrn+JtHrMY8nZ4lcRTzhNbNnSO9Dn6sy+dPbc3
        LpQMQ6nyZS2Fvawm9UGg5lx432b7jEUxh1euSNhZpF0QWbTJcqRuW9nlpuTr5UlaMNi3fU/O
        15eYP8pslpjVRyVb+/xuN3Ye0QTvqrzRlRltLV8uV5FClDrIj9AJ6r80L0NKjwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsVy+t/xu7rW2j9jDN781rHYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aLyafmMlmc6c616H/8mtni/PkN7BZnm96wW3zsucdqcXnXHDaLz71HGC1m
        nN/HZLH2yF12i4unXC1uN65gszj8pp3V4t+1jSwW+694Wdz+zWfx7cQjRgdRj29fJ7F4vL/R
        yu4xu+Eii8fOWXfZPTat6mTz6G1+x+bRt2UVo8fm09UenzfJBXBG6dkU5ZeWpCpk5BeX2CpF
        G1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GUcXRhacJeron3tWdYGxo0cXYyc
        HBICJhKHvraydzFycQgJLGWU+HdqOSNEQkxi0r7t7BC2sMSfa11sEEWvGSXmzNnGApIQFnCT
        ONNxCaxIREBfYsmqi2BFzAJzWCQ6ly6HGnuCUeLHiQ9ADgcHm4CexI5VhSANvEDN8y8vYgax
        WQRUJDpmHwazRQUiJGbvamCBqBGUODnzCZjNKWAv8fTmDTCbWcBMYt7mh8wQtrjErSfzmSBs
        eYntb+cwT2AUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMD1s
        O/Zz8w7GSxuDDzEKcDAq8fA6MPyMEWJNLCuuzD3EKMHBrCTCW3bhR4wQb0piZVVqUX58UWlO
        avEhRlOg5yYyS4km5wNTV15JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4m
        Dk6pBkZbwf0WO63YS20nii9zrcpynvr4w1JGPpGvFiemOnsycer+/Mc968Mz/8PT5+3/JHf3
        pmSXbGB2MueVFe4XZe1/7vpf1qVyf4f8dG9/XmOfP4Zvm36s/flh74daT4UK4Wtfd6+otdnM
        u3XNDTl+n1c72J5oLzVnODMtNPlb/uy/3LVx7pMuzmBXYinOSDTUYi4qTgQAMf/3UCUDAAA=
X-CMS-MailID: 20190606150324eucas1p16fcd068025525704df3ccb9afb64e67c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165426eucas1p20524669a299f740b5502db24977b098f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165426eucas1p20524669a299f740b5502db24977b098f
References: <CGME20190605165426eucas1p20524669a299f740b5502db24977b098f@eucas1p2.samsung.com>
        <20190605165410.14606-1-l.luba@partner.samsung.com>
        <b1024bed-a8d9-12d9-9e20-5e5624a1b189@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sylwester,

On 6/6/19 3:57 PM, Sylwester Nawrocki wrote:
> On 6/5/19 18:53, Lukasz Luba wrote:
>> Lukasz Luba (13):
>>    clk: samsung: add needed IDs for DMC clocks in Exynos5420
>>    clk: samsung: add new clocks for DMC for Exynos5422 SoC
>>    clk: samsung: add BPLL rate table for Exynos 5422 SoC
>>    dt-bindings: ddr: rename lpddr2 directory
>>    dt-bindings: ddr: add LPDDR3 memories
>>    drivers: memory: extend of_memory by LPDDR3 support
>>    dt-bindings: memory-controllers: add Exynos5422 DMC device description
>>    drivers: memory: add DMC driver for Exynos5422
>>    drivers: devfreq: events: add Exynos PPMU new events
>>    ARM: dts: exynos: add chipid label and syscon compatible
>>    ARM: dts: exynos: add syscon to clock compatible
>>    ARM: dts: exynos: add DMC device for exynos5422
>>    ARM: exynos_defconfig: enable DMC driver
> 
> 
> I have applied first 3 patches from this series to clk/samsung tree.
Thank you
> 
> But can you please also send this series to linux-clk@vger.kernel.org
> ML, adding the clk maintainers (Stephen, Michael) at Cc?
I will. There are some minor clean-ups in patch 8/13 pointed by
Krzysztof, I am going to sent v9, so I will add them on CC.
> 
> Please make sure if future any clk patches are also sent to
> linux-clk@vger.kernel.org mailing list.
OK
> 

Regards,
Lukasz
