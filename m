Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928851FCA2A
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jun 2020 11:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgFQJsl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 05:48:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43228 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFQJsk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2020 05:48:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200617094838euoutp0299880b77366711c7315fb0728d383729~ZS9RVdQoy1511015110euoutp02U
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2020 09:48:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200617094838euoutp0299880b77366711c7315fb0728d383729~ZS9RVdQoy1511015110euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592387318;
        bh=1hn/86bQTTmfmak5bZLBcL+7yv5YdedGxXKkEAfzkb0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HEUIMnfoaZikpTeNKtCU9wzSdlWoI17KuUNMGjS1BGWFk7v5lp/grrip3I4VP+Ail
         f0/G/Y7LGyjB7zymuyoQM/gLSqzMqON+HBk9NPHov193EE8hL7cfTMMACU0ZhEf1p5
         XguYHUHNST2Q24roi+ecIw6ebbcH618SHzabx224=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200617094838eucas1p278ca479fb46c8e0f9358cb38926f7c77~ZS9RGrvB41583215832eucas1p2B;
        Wed, 17 Jun 2020 09:48:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 24.03.60698.6F6E9EE5; Wed, 17
        Jun 2020 10:48:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200617094837eucas1p2a59fc3e396618cd88b1b2fd344d56661~ZS9Qx5Rur1583615836eucas1p2M;
        Wed, 17 Jun 2020 09:48:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200617094837eusmtrp1cc2ede5f31119a9af238de47c53ad5c4~ZS9QxOT6Y1215412154eusmtrp1b;
        Wed, 17 Jun 2020 09:48:37 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-e2-5ee9e6f65bd8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D8.F6.07950.5F6E9EE5; Wed, 17
        Jun 2020 10:48:37 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200617094837eusmtip133d2047761def59ec87694796628e3a7~ZS9QTTWdc1575215752eusmtip12;
        Wed, 17 Jun 2020 09:48:37 +0000 (GMT)
Subject: Re: [PATCH 0/4] Restore big.LITTLE cpuidle driver for Exynos
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <3e6b5dbb-a8a2-e3db-d740-53e13676455c@samsung.com>
Date:   Wed, 17 Jun 2020 11:48:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CANAwSgStsYP5fBB7z7-Reo2BP4ZQPT6RN4s8QdLGVGhKCDA_Ng@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djP87rfnr2MM+g4LGyxccZ6Vot5n2Ut
        zp/fwG6x6fE1VovPvUcYLWac38dksW7jLXaLN79fsFssbGphd+D0WDNvDaPHzll32T02repk
        87hzbQ+bx+Yl9R59W1YxenzeJBfAHsVlk5Kak1mWWqRvl8CV8eq7f0EvT8WbQ81sDYw3OLsY
        OTkkBEwkpm55y9bFyMUhJLCCUeLS2rNsIAkhgS+MEv/eqkIkPjNKXG15xgrT8ffffxaIxHJG
        ib2PrjBDOO8ZJe59PckIUiUs4CqxduZ9dhBbREBN4srTFawgRcwCr5kkPrw8BZZgEzCU6Hrb
        BbaPV8BOoquvkxnEZhFQlbi/6SjYIFGBWIm+pQugagQlTs58wgJicwoESmz81gsWZxaQl9j+
        dg4zhC0ucevJfCaQZRICp9gl9i/uYIa420Vi8clWNghbWOLV8S3sELaMxOnJPSwQDc2MEg/P
        rWWHcHoYJS43zWCEqLKWuHPuF1A3B9AKTYn1u/Qhwo4SFxu3sYCEJQT4JG68FYQ4gk9i0rbp
        zBBhXomONiGIajWJWcfXwa09eOES8wRGpVlIXpuF5J1ZSN6ZhbB3ASPLKkbx1NLi3PTUYuO8
        1HK94sTc4tK8dL3k/NxNjMBEdfrf8a87GPf9STrEKMDBqMTD27DwRZwQa2JZcWXuIUYJDmYl
        EV6ns6fjhHhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQnliSmp2aWpBaBJNl4uCUamA8
        EhJoXm92wWhl2O0D8VM/zPoqaHdrS1LmrOyDlQ/yjv6tq/y579MLTa3iv+JTrnbXCse33y7v
        eXNVoO7R63mbZ4RF2ime0TnRn5O4vXjXVs17+/aISNV9mT9v6+mOJw84YpyUuH8evfCseiNf
        4fM5Z3Mv7HhQnabp+yCYzXpSgcz643KPz1n0KrEUZyQaajEXFScCACH1iMFQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xu7pfn72MM/jzzMpi44z1rBbzPsta
        nD+/gd1i0+NrrBafe48wWsw4v4/JYt3GW+wWb36/YLdY2NTC7sDpsWbeGkaPnbPusntsWtXJ
        5nHn2h42j81L6j36tqxi9Pi8SS6APUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzW
        yshUSd/OJiU1J7MstUjfLkEv49V3/4Jenoo3h5rZGhhvcHYxcnJICJhI/P33n6WLkYtDSGAp
        o8TBXd2sEAkZiZPTGqBsYYk/17rYQGwhgbeMEn0r9UFsYQFXibUz77OD2CICahJXnq5gBRnE
        LPCeSWJ11zuoqTcYJXbse8gMUsUmYCjR9RZiEq+AnURXXydYnEVAVeL+pqOMILaoQKzEt3tb
        oGoEJU7OfMICYnMKBEps/NYLFmcWMJOYtxliJrOAvMT2t3OgbHGJW0/mM01gFJqFpH0WkpZZ
        SFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzAytx37uWUHY9e74EOMAhyMSjy8
        DQtfxAmxJpYVV+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OBSSOv
        JN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAOj0+oDf5cFBKUasbGv
        S2to+NqSOqvZ+sBNpbdR8+zKVQTeBLFcK7t4MfnK7gzJxn2laX9uaz2+eChn2oPF6bemTJqX
        /jH1daVyoE2V0AHJcKPJoQaVzkkuD1ju31vWY7hD5LH068S7BtO+r+05cm8ac3KFhaf0+03P
        v075bG7yeOXte/LHXtj+VGIpzkg01GIuKk4EACPj+IHiAgAA
X-CMS-MailID: 20200617094837eucas1p2a59fc3e396618cd88b1b2fd344d56661
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200616081248eucas1p168faa343ce333a28c8fd3cf9a6a58b3c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200616081248eucas1p168faa343ce333a28c8fd3cf9a6a58b3c
References: <CGME20200616081248eucas1p168faa343ce333a28c8fd3cf9a6a58b3c@eucas1p1.samsung.com>
        <20200616081230.31198-1-m.szyprowski@samsung.com>
        <CANAwSgStsYP5fBB7z7-Reo2BP4ZQPT6RN4s8QdLGVGhKCDA_Ng@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Anand,

On 16.06.2020 22:58, Anand Moon wrote:
> On Tue, 16 Jun 2020 at 13:44, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> The ARM big.LITTLE cpuidle driver has been enabled and tested on Samsung
>> Exynos 5420/5800 based Peach Pit/Pi Chromebooks and in fact it worked
>> only on those boards.
>>
>> However, support for it was broken by the commit 833b5794e330 ("ARM:
>> EXYNOS: reset Little cores when cpu is up") and then never enabled in the
>> exynos_defconfig. This patchset provides the needed fix to the common
>> code and restores support for it. Thanks to Lukasz Luba who motivated me
>> to take a look into this issue.
>>
> Thanks for this updates.
>
> But I feel some DTS changes are missing for example
> d2e5c871ed8a drivers: cpuidle: initialize big.LITTLE driver through DT

This is not strictly needed. The bl-cpuidle matches also to the A7/A15 
CPU product ids and it is properly instantiated on the Peach Pit/Pi 
Chromebooks. Those CPU DT properties were added as a future-proof 
generic solution. I won't hurt to add them though.

> But I feel that this feature is not working as desired since
> still some missing code changes for cluster idle states are missing.
> like clock  PWR_CTR and PWR_CTRL2.

I cannot judge now. All I can test now is a that the boards enters those 
idle states and system works stable. I cannot measure power consumption, 
because currently I have only remote access to the boards.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

