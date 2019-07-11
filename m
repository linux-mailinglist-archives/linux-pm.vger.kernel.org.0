Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1B8657F0
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 15:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfGKNgw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jul 2019 09:36:52 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53909 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbfGKNgu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2019 09:36:50 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190711133648euoutp01e30e74cc923ebb328dc0b12df73a6cca~wXc2GcxSN1328313283euoutp012
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2019 13:36:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190711133648euoutp01e30e74cc923ebb328dc0b12df73a6cca~wXc2GcxSN1328313283euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562852208;
        bh=hapnjd460596E34R5EF9h7HtShY2YdFfJ/cJBJjjuB8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=a6sSMETdviIDhrWlA/cN3THO5YD/K8ol53OpmCB0ezjXTle1BI1qsMeH9ZjasWxnd
         JYoBPsFOTqGqXLZbDI43JJPAkVVbJhiWz0TThQTCLhLAgp4usbqH9EGVSLNxPYlWD5
         8EA3a64DFJ0oa4sSfSUYYs3T//V604ed0CrZBxnc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190711133647eucas1p10e90994cb5ce5a56b1b9f13c3f6937f3~wXc1PY2YM1292912929eucas1p14;
        Thu, 11 Jul 2019 13:36:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 21.D6.04377.E6B372D5; Thu, 11
        Jul 2019 14:36:46 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190711133646eucas1p17268f944b0a1f3ab0a023b0379481326~wXc0fRNOx0579005790eucas1p1g;
        Thu, 11 Jul 2019 13:36:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190711133646eusmtrp14a1606e8fd467e4612fa8ac535f42643~wXc0Q58Mf1914719147eusmtrp1x;
        Thu, 11 Jul 2019 13:36:46 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-b5-5d273b6ed68f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 06.69.04140.D6B372D5; Thu, 11
        Jul 2019 14:36:45 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190711133645eusmtip2fdfcf3a65fdaf9568af38b0b88a7aefc~wXczjIZwg1545915459eusmtip2Q;
        Thu, 11 Jul 2019 13:36:45 +0000 (GMT)
Subject: Re: [PATCH 2/3] devfreq: exynos-bus: convert to use
 dev_pm_opp_set_rate()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
Message-ID: <a5da4135-0471-3628-c78a-c4fffc75723b@partner.samsung.com>
Date:   Thu, 11 Jul 2019 15:36:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfWr-2t_e3f6oi7E6KLLRAbskzgEKz26XyK5n_9C8wV1w@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUhUURTGu/NWB0eeY+FJo2BEwkCtKLqVmUHLCEUWBW1SYz1M0qlmcssk
        l1wzDSvSUcaETJnMnSaXBtFBK7VnlnulaCmZQqGhgUvOPCX/+53vfIdzvstlCfkA5cQGqW/w
        GrUqWEFLyZdNfwV39e6N/psHRjxxeVYphbunRimcZ35P4YzhnwQWhDIGt8WNM7hiuIvCH2ty
        aTx5z4xwlmCS4BfmLwwu6P4gwf2xRTQen2mT4ITXZgbPd5WTuHKwifaxVxbri5GywpBCKyuf
        3lamVxmQsrnHKFFOVqz3o89IvS7xwUFhvMbT+4L0stDmdy2HidB3PGNi0AKVimxY4LbBUJuR
        SEVSVs4VITA8qUdiMYUgY7ZTIhaTCPJKO8jlkbS3JsLCcq4QQUnOddE0gaCz6Y/V5MCdgMa7
        gnXHas4NuuemKYuJ4GZIiBmrtppobgcMGVslFpZxB6Gu/4tVJzlX6BvopS28hjsF78x6UvTY
        w9vsb4vMsjbcMXhTFmSRCc4R+r7lSUTeAMaJXGse4BJYGCl/SIhX71+MM0SL7ABjzVWMyOug
        5UHaUrJw+J6fzojDdxAMJv1eauyGxuYPlGUxsZimtMZTlPdBaVy99R7g7KBnwl68wQ4yXz4m
        RFkGyYly0e0O+oXWpWd3htSFEuo+UuhWBNOtSKNbkUb3f+8TRBqQIx+qDQnktVvVfLiHVhWi
        DVUHely8GlKBFr9dy3zz1CtUMxvQgDgWKWxlPTs3+sspVZg2MqQBAUsoVstMh1z85bJLqsib
        vObqeU1oMK9tQM4sqXCURa0aPCvnAlU3+Cs8f43XLHclrI1TDPIiyxnvN8m+0eOZrSRvl8bn
        j0pjt5+zHTlZ/YNJr3MTUl4UChOfEg/hj0ecWB+Xr2f1h48bvNqjPFzT4jtNvaZP26a7yKSR
        PTbScGMtjq4jkgt8s0vC1nbW7nKPGV3wihiL/ywcSD6a9Gtt6um7c8ytpOr2vdm+z1+NPTIG
        dMcrSO1l1ZZNhEar+gesG9MScgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsVy+t/xe7p51uqxBluFLDbOWM9qcf3Lc1aL
        +UfOsVr0P37NbHH+/AZ2i7NNb9gtNj2+xmpxedccNovPvUcYLWac38dksfbIXXaLpdcvMlnc
        blzBZvHmx1kmi9a9R9gt/l3byGKx+cExNgdBjzXz1jB6bFrVyeaxeUm9R9+WVYwex29sZ/L4
        vEkugC1Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5B
        L+P82YCC2ewV8y4tY29g/M/axcjJISFgItFzch9zFyMXh5DAUkaJjXNmM0IkpCUaT69mgrCF
        Jf5c62KDKHrNKPHj6mxmkISwQIjE4e7zYJNEBDQlrv/9zgpSxCzwh0Wiq3EGI0THLCaJs5vf
        gVWxCZhLPNp+Bmwsr4CbxJ7bd1lAbBYBVYlb92+ygdiiAhESk67tZIGoEZQ4OfMJkM3BwSkQ
        KHFiQyZImFlAXeLPvEvMELa4xK0n85kgbHmJ7W/nME9gFJqFpHsWkpZZSFpmIWlZwMiyilEk
        tbQ4Nz232EivODG3uDQvXS85P3cTIzC+tx37uWUHY9e74EOMAhyMSjy8NyzVY4VYE8uKK3MP
        MUpwMCuJ8O5zV44V4k1JrKxKLcqPLyrNSS0+xGgK9NtEZinR5Hxg6skriTc0NTS3sDQ0NzY3
        NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cDo/FlD3l5zWX/3uzCfuCt1WyrXfQoImTTl
        5mfNn9Mm6jpedt67++uX5NPRJ8suBM254Mv94VuIX8nmkMpozyNz5KfoGlWFf5kd+Els7jdH
        iR/rHor75fiwFTAfqnNeOVnk1L4/xXWzrzrlPD+t6HlikvDO5sdnDRbbz0ifY3Co5Y6u9MPD
        H2uXKbEUZyQaajEXFScCAGLPHXUFAwAA
X-CMS-MailID: 20190711133646eucas1p17268f944b0a1f3ab0a023b0379481326
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190708141200eucas1p144ca3b2a5b4019aaa5773d23c0236f31
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190708141200eucas1p144ca3b2a5b4019aaa5773d23c0236f31
References: <CGME20190708141200eucas1p144ca3b2a5b4019aaa5773d23c0236f31@eucas1p1.samsung.com>
        <20190708141140.24379-1-k.konieczny@partner.samsung.com>
        <20190708141140.24379-3-k.konieczny@partner.samsung.com>
        <CAJKOXPfWr-2t_e3f6oi7E6KLLRAbskzgEKz26XyK5n_9C8wV1w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10.07.2019 19:04, Krzysztof Kozlowski wrote:
> On Mon, 8 Jul 2019 at 16:12, <k.konieczny@partner.samsung.com> wrote:
>>
>> From: Kamil Konieczny <k.konieczny@partner.samsung.com>
>>
>> Reuse opp core code for setting bus clock and voltage. As a side
>> effect this allow useage of coupled regulators feature (required
>> for boards using Exynos5422/5800 SoCs) because dev_pm_opp_set_rate()
>> uses regulator_set_voltage_triplet() for setting regulator voltage
>> while the old code used regulator_set_voltage_tol() with fixed
>> tolerance. This patch also removes no longer needed parsing of DT
>> property "exynos,voltage-tolerance" (no Exynos devfreq DT node uses
> 
> Please also update the bindings in such case. Both with removal of
> unused property and with example/recommended regulator couplings.

Right, I will remove it.

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

