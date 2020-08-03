Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5821D23A97D
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 17:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHCPgC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 11:36:02 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47645 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgHCPf6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2020 11:35:58 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200803153556euoutp02088d999d238433fb17fad4fa75e4bc26~nzA69n2Z-2120821208euoutp02o
        for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2020 15:35:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200803153556euoutp02088d999d238433fb17fad4fa75e4bc26~nzA69n2Z-2120821208euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596468956;
        bh=zaaAQhHr+G5KAp1EblCYce/6XgEeLyh+tfSOVg5NPdg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YsNM689JcrrXW6j7FQEpk766uWvm1YmVqyrW+KC1Y/Qwx+nI4GZXJQu7l7y2LydQk
         fWf3dr45/dr9BodFghEsU5sxL5beJP+24gvZm97jMxMWRBi8mkc9UTF3Uxm0CclPum
         6eRBrmmuNMAUIUn35STmf4Mp0IKyhANrLfQViyyM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200803153556eucas1p297b2224e6861b32226ea284d3c34c7eb~nzA6rUfrQ0425704257eucas1p2i;
        Mon,  3 Aug 2020 15:35:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 39.5D.06456.CDE282F5; Mon,  3
        Aug 2020 16:35:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200803153555eucas1p12cd471cea5b1674dfa5aa38ee669a2ac~nzA6UchAz2352423524eucas1p19;
        Mon,  3 Aug 2020 15:35:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200803153555eusmtrp24b5f7ced7bad754419fa435264f2f557~nzA6TjUdZ3080930809eusmtrp2g;
        Mon,  3 Aug 2020 15:35:55 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-62-5f282edc8bcc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9B.AC.06017.BDE282F5; Mon,  3
        Aug 2020 16:35:55 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200803153555eusmtip1d8db2ec29432bb2449eca306f6bc71ee~nzA5jtebj2941329413eusmtip1S;
        Mon,  3 Aug 2020 15:35:55 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] memory: samsung: exynos5422-dmc: Add module
 param to control IRQ mode
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     willy.mh.wolff.ml@gmail.com, k.konieczny@samsung.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, s.nawrocki@samsung.com, kgene@kernel.org
Message-ID: <ceaa668e-a60b-1916-243b-145b1bc7fc76@samsung.com>
Date:   Mon, 3 Aug 2020 17:35:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <db571467-48ec-8f11-de1d-00393d8aa99b@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTldVYqxaFiuKJgbIiA0SLqx0QU1JhYDYkkxmg0WgtOCqFUMgO4
        /FiLiKCASwxlMGxxAUQqVZElbqBUJFAjRpDFDRIUF6S4EjfKgPJ3zrnnvntO8mhM2Un40nHG
        JI436gwqUo5XN/1oW9SjDtIuflkyja2yWAn2ZOcTnO34PECwRU4Lweb0vcNYh+MKxbaa31Os
        re8pwbbXnSXZkax7iLU4bsnYYvNhiu0+VEqyje/TCfbrg9do1XRNRUEF0tSKvZTGVp5Baq6e
        O6jJvlaONCM2/yhym3zFbs4Ql8LxIeG75LH5HZV4opPZ13jmGGlCZs9M5E4DswzEmmd4JpLT
        SqYUQYE5j5LIZwT12f2EREYQDN7JxyZXnKNpE4OLCGrODMgkMoSg9HIz5XLNYGIgrf4N6cIk
        EwqZHzJJl8mbKUfwbeje+DrmevfUp+LxdxVMOGS0lY1FoWmcCQBT2UqXPJPZCda3N2SSxQua
        8/pxF3ZnIuBNb8X4KsbMhdTr+RPYB7r6C2VS1C8UVD+PlPBacFj6JyrMgEH7NUrCc+BPbeF4
        A2BSEbxqu0xJ5DiCdrMFSa4w6GkbJV3hMCYYrHUhkrwaHt66gLlkYDyh84OXlMETTlXnTsgK
        OHpEKbnng2iv/Hf27qPH2AmkEqc0E6e0Eae0Ef/fLUJ4OfLhkoUEPSeEGrm9akGXICQb9eqY
        PQk2NPbfWn7bnTXoy+PoBsTQSOWhKCKCtEpClyLsT2hAQGMqb8Wa1padSsVu3f4DHL9Hyycb
        OKEBzaZxlY9iacnbHUpGr0vi4jkukeMnpzLa3deEYjZ2f3Xb7lPpUTV/WD1r2DB9/bxXWzbn
        nvv1QvZ8iV93l+D/o2V5U52skQ9aN3je32T9nhOR7paclBpg2xSYN7DeyS/Uy6pTW6Oe+Hms
        vX+6+1JcT5jgZPmTiw/Hp920blDFVry0a8Ltedas21s5D/XHMPGnPlhM1wYHRkVHUq9VuBCr
        C12A8YLuLzupyChrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsVy+t/xu7q39TTiDTpPG1lsnLGe1WLijSss
        Fte/PGe1WPBpBqtF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFgubWtgt
        bjeuYLM4/Kad1eLbiUeMDvwea+atYfTYOesuu8emVZ1sHpuX1Hv0bVnF6PF5k1wAW5SeTVF+
        aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexuzr61gKPglU
        HJ7azdbA2MTXxcjJISFgIvHpVytrFyMXh5DAUkaJxkXXWSESMhInpzVA2cISf651sUEUvWWU
        uPf1JTtIQlggWeLPjlNsIDabgKFE11uIIhGBVUBF92+wgzjMAp8ZJdrf7GcBqRIS+MAosf20
        FYjNK2An0XluJVCcg4NFQEWiYaUtSFhUIE5i+Zb57BAlghInZz4Ba+UUsJd4cXcNM4jNLGAm
        MW/zQyhbXqJ562woW1zi1pP5TBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtIrTswt
        Ls1L10vOz93ECIznbcd+btnB2PUu+BCjAAejEg/vAlaNeCHWxLLiytxDjBIczEoivE5nT8cJ
        8aYkVlalFuXHF5XmpBYfYjQF+m0is5Rocj4w1eSVxBuaGppbWBqaG5sbm1koifN2CByMERJI
        TyxJzU5NLUgtgulj4uCUamA8f2dG3oaop/Kn64y67hzeyr51ynv+tM9u6YW+UanNG5njvBJm
        Xq66uNUutiO3x7ZpnQ1btu9piYRP7Fdaag9ZXnx13Efr9TUdnWa9QF37Q1+t2PuuHtp5xJ9L
        7Jpa3v3/y29b79PpfSV4+e3iDTOV+acFsMft+fvrn8oSWaWnTJZrwm6Jl75XYinOSDTUYi4q
        TgQAf0DYDf0CAAA=
X-CMS-MailID: 20200803153555eucas1p12cd471cea5b1674dfa5aa38ee669a2ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200710191154eucas1p296561f285ee0730e5040fdfe3fc7e75e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200710191154eucas1p296561f285ee0730e5040fdfe3fc7e75e
References: <20200710191122.11029-1-lukasz.luba@arm.com>
        <CGME20200710191154eucas1p296561f285ee0730e5040fdfe3fc7e75e@eucas1p2.samsung.com>
        <20200710191122.11029-3-lukasz.luba@arm.com>
        <db571467-48ec-8f11-de1d-00393d8aa99b@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

On 03.08.2020 17:30, Marek Szyprowski wrote:
> On 10.07.2020 21:11, Lukasz Luba wrote:
>> The driver can operate in two modes relaying on devfreq monitoring
>> mechanism which periodically checks the device status or it can use
>> interrupts when they are provided by loaded Device Tree. The newly
>> introduced module parameter can be used to choose between devfreq
>> monitoring and internal interrupts without modifying the Device Tree.
>> It also sets devfreq monitoring as default when the parameter is not set
>> (also the case for default when the driver is not built as a module).
>>
>> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>
> I've got back from my holidays and noticed that in meantime this 
> commit got merged as commit 4fc9a0470d2d. It revealed that there is a 
> race between registering exynos5422-dmc driver and exynos-ppmu driver, 
> which can be observed sometimes as the following message and freeze on 
> Odroid XU3 with multi_v7_defconfig:
>
> [    8.767708] exynos5-dmc 10c20000.memory-controller: couldn't probe 
> performance counters
>
> I will check this later why the EPROBE_DEFER error is not properly 
> propagated and why it causes a freeze.

It looks that simply propagating return value from 
exynos5_counters_get() in exynos5_dmc_get_status() fixes the boot:

# dmesg | grep dmc
[    8.838754] exynos-ppmu: new PPMU device registered 10d00000.ppmu 
(ppmu-event3-dmc0_0)
[    8.861344] exynos-ppmu: new PPMU device registered 10d10000.ppmu 
(ppmu-event3-dmc0_1)
[    8.868488] exynos5-dmc 10c20000.memory-controller: couldn't probe 
performance counters
[    8.874417] exynos-ppmu: new PPMU device registered 10d60000.ppmu 
(ppmu-event3-dmc1_0)
[    8.886612] exynos-ppmu: new PPMU device registered 10d70000.ppmu 
(ppmu-event3-dmc1_1)
[    9.396769] exynos5-dmc 10c20000.memory-controller: DMC initialized, 
in irq mode: 0

I'm still curious why it freezes if getting performance counters is not 
possible.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

