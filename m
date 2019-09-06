Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C51D6AB42B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 10:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390061AbfIFIlJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 04:41:09 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58998 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390116AbfIFIlJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Sep 2019 04:41:09 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190906084107euoutp0280871dd34a77a09b3d79d22f27edff38~BzL9RIuSZ2450724507euoutp02P
        for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2019 08:41:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190906084107euoutp0280871dd34a77a09b3d79d22f27edff38~BzL9RIuSZ2450724507euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567759267;
        bh=VDDT/Czk56Q8E3rDNHryVqDUwRioVZmeqMXokNXW/GM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CR1mib4seThpxQRYBtFUxo1v8BRrv8710OzFqMpVQKwHrzbNa+lUW6n2p8vTOg5gF
         fILj1bWTw7hUJJn3a5AtnOWPs1RlM+DQCO3DAjH9LFmyzdqTd3k9YKXapySYNE1B1O
         RWZhIeeO0fTltik3xdHdv1N5s8DdEV1cW3Eqa9S0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190906084106eucas1p1e7088d31f850b8a5d1a35c22223d6e17~BzL8GtIA41368513685eucas1p1Y;
        Fri,  6 Sep 2019 08:41:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 76.DB.04469.1AB127D5; Fri,  6
        Sep 2019 09:41:05 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190906084105eucas1p20e119fc8906ab29e152f25fc58dc6fe8~BzL7MPDqB1877418774eucas1p2J;
        Fri,  6 Sep 2019 08:41:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190906084105eusmtrp2d8cdc9fbce4541250ed29748ecc695e2~BzL7LVGxf1162711627eusmtrp2E;
        Fri,  6 Sep 2019 08:41:05 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-e0-5d721ba17a6e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5C.27.04117.0AB127D5; Fri,  6
        Sep 2019 09:41:05 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190906084103eusmtip2bb70a340d3fdaa68eeda4d094ca6c88b~BzL6FvdLl0736807368eusmtip2g;
        Fri,  6 Sep 2019 08:41:03 +0000 (GMT)
Subject: Re: [PATCH v13 7/8] ARM: dts: exynos: add DMC device for exynos5422
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, b.zolnierkie@samsung.com, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <c178d316-a6b8-5b0a-af97-e6a049da14ca@partner.samsung.com>
Date:   Fri, 6 Sep 2019 10:41:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904182502.GA12918@kozik-lap>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUxTURTktm+jWvKoC0ckkjR+qIngGq+iRFyfy4cxmhiMYNUXJFLEPlAB
        o8UGlU20uJTaiksUU2qwpYFCcKNVxA3rhtJg0BpNUDDYKipxoT6M/M3MmbnnTHIZqeIYFcmk
        pmfymnRVmpKSEbW3vz+cfHasZsOUqq4Z2GaoJnFb4D2JK9wPSVzV60NYd76awmV3zRJ8v0iN
        S30fpLi19QqNH+z/SOPe4lckftJgorC/xI2wofWaBF92d9D4QptHgj13F2Nv3iUK519109j1
        8SCJfz23Efj60+XY2x+Gv955g+YDZz1tRdzXL3qC+/Qin+ZOaT0EV2/soDm7pYDirputNFei
        66G4ww4L4mru5XJ++7hVwxJlc7fwaak7eU1s/EbZVl8dnfEtdHeLeZoWFTCFKJQBdgbonQZJ
        IZIxCvYSgh57DS2SwAB52UaIxI+gv7SL/Bd5XN48GKlEcCvvHRJJN4IT3Z0o6BrBroQWg5gY
        yU6Etp99f7GUbSRAqx9TiBiGYmPAadkRlOXsEmjwnpQEMcGOhw5d1V88il0HnztdpOgJh5by
        t0QwGsrGQvFxufhiBLS/rZCIOBrquk3S4DnAPmLgqOkbJR69CF4bdRIRj4CuZgct4ij4XV8x
        qAugLTmLRLwHfKXmQU8cuJo9ZHCvdKBKdUOsKCeA29FIB2Vgw+BFd7h4Qhjoa09KRVkOhw4o
        RPcEcBQ/Glw0GiqtJ+gjSGkc0ss4pIxxSBnj/71nEGFBEXyWoE7hhanp/K4YQaUWstJTYjZv
        V9vRwF+996v5sxN9ebypCbEMUg6Xs4GMDQpStVPIVjchYKTKkfJq24Ak36LKzuE125M1WWm8
        0ITGMoQyQp4b0rlewaaoMvltPJ/Ba/5NJUxopBatdVkXLtDLci4mnepno9v75mT2VSXcNseP
        L5q+7E2c3dKe5v1hy09NzLG7egJlk721sckxexvzZLPXrFpQcOFm62VTXEhx7rn4uPoV0U5/
        5LOkluwxv2syH+y+4VsWKO+1uZYKR/bVeQx7FiZeHdeuK3XMc3pnrY5q8HvfbUtYMXOTkhC2
        qqZOkmoE1R/GxVWtpwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fO2TlmJ05T68WoZNQHBbe2qXs1k75UhxAq7IalNvIwLbfZ
        zrSsD5li1rI7pi4vRRh5CZ1aXsucoqmVaEOzpVBKmrcSSwtT2lyB3348z//3wAN/ChMVEZ5U
        rNbA6bWqOLFwJd652Dbo+2C9PmLrtBEgc3YZgfp+jBCooOUtgUqmhwBKfVgmRHc68gTo9VUN
        ujE0jqGurnISvUmZINF0xiCB3tXlCtHMtRaAsrteCNCTlgESFfZ1C1B3x05ku/hYiNKet5Co
        eSKdQIu9Zhw1Wvcg2/xqNPvqM9gB2dL8UsDO/ryNs9/ep5HsveRunK01DZBsRfEVIduYV0qy
        11KnhOz1qmLAVnaeZ2cqNu5zDZcE63UJBs4rRscbtouPypBcIgtEErlfoESmUEYEyf3F0pDg
        aC4uNpHTS0OOS2KGqsn4Xy5n2/PkyeAKZQQuFGT8YE9Om8AIVlIiphDAgoZJzLlYC2+/qCad
        7Ab/9BqFztA4gJZR69LCjQmF7dljhIPdGW/YtzBHOEIY04DDsULrv7NTAM6/bLbrFCVkJLCm
        +LRDoJldsM6WJXAwzmyGA6klS+zBHIHNNSbgzKyB7TnDuEN1YaQwI5N2jDEmAOZXfsKcvA5+
        GC4QOHkTrJ7MxW4CkWmZbVqmmJYppmXKfYAXA3cugdeoNbxcwqs0fIJWLTmh01QAe02etf6u
        qgHGqTALYCggXkUzP+IjRIQqkU/SWACkMLE7XWa2j+hoVdI5Tq+L0ifEcbwF+Nt/u4V5epzQ
        2UunNUTJ/GVKFChTKpSKACReR19mmo6JGLXKwJ3iuHhO/98TUC6eySC5iT6cKQs6Y6unQ+ei
        F7ykfvj3fNcwLzaoZswNrbrk26/eFp5VUNlxIGr/rZDsu7W2n/krTlIfpyYOwuCRQ5fG633a
        ZyO3aGKHzdPEzF463Vorj+xJ609VjabLAx6pdxd9VcNW5dMvOZUZ3ikp5R5BZit9ofmq73xv
        JLkhSyHG+RiVzAfT86q/H1W5tjwDAAA=
X-CMS-MailID: 20190906084105eucas1p20e119fc8906ab29e152f25fc58dc6fe8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190821104324eucas1p16bdeb27250c8c9fa87591d6bd9743a17
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190821104324eucas1p16bdeb27250c8c9fa87591d6bd9743a17
References: <20190821104303.32079-1-l.luba@partner.samsung.com>
        <CGME20190821104324eucas1p16bdeb27250c8c9fa87591d6bd9743a17@eucas1p1.samsung.com>
        <20190821104303.32079-8-l.luba@partner.samsung.com>
        <20190904182502.GA12918@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 9/4/19 8:25 PM, Krzysztof Kozlowski wrote:
> On Wed, Aug 21, 2019 at 12:43:02PM +0200, Lukasz Luba wrote:
>> Add description of Dynamic Memory Controller and PPMU counters.
>> They are used by exynos5422-dmc driver.
>> There is a definition of the memory chip, which is then used during
>> calculation of timings for each OPP.
>> The algorithm in the driver needs these two sets to bound the timings.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5420.dtsi             |  71 +++++++++++
>>   arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 116 ++++++++++++++++++
>>   2 files changed, 187 insertions(+)
> 
> Thanks, applied conditionally. Please send a follow up fixing the
> checkpatch error about undocumented binding:
> https://krzk.eu/#/builders/26/builds/392
> 
> You should not skip such checkpatch warning.
Right, I will keep it in mind next time. I have just ignore it based on
Elpida lpddr2 memory which is also missing DT binding documentation.
https://elixir.bootlin.com/linux/v5.3-rc7/source/arch/arm/boot/dts/elpida_ecb240abacn.dtsi

I will send a follow up patch based on your 'for-next' branch.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
> 
