Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBCF2A2A9F
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 13:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgKBMXd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 07:23:33 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50168 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgKBMXc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 07:23:32 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201102122320euoutp01c85acf9ed90eb9a4527f4d61da6d78bb~DsFvRAVIN0723307233euoutp01J
        for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2020 12:23:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201102122320euoutp01c85acf9ed90eb9a4527f4d61da6d78bb~DsFvRAVIN0723307233euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604319800;
        bh=q7+ilGGLT18/vuSxWDQthCN3467HY9jEgT+ik8brKQk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nJ70JShet0S2a6Dqq8HgE/zaqAzGsrHM/nI+F5Iu7rDjZjC9ey0YXT3F8lRphW91K
         zagjVTkvu79AYGpDb7zgRtPlsJfW+U7opWVjDZTQ831O6gLBXBAGxG4fW/9V+7/ONk
         PKRtl4TBLewbaysAyJO2Rm47it72RrHttiZOswd0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201102122311eucas1p10c5ad39eb4e356d254f268fbda6ad4b4~DsFmsUMu80490104901eucas1p1R;
        Mon,  2 Nov 2020 12:23:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 77.30.06456.F2AFF9F5; Mon,  2
        Nov 2020 12:23:11 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201102122311eucas1p1805e9f745babaa133d80418bddf108a7~DsFmSwRB-2982429824eucas1p1e;
        Mon,  2 Nov 2020 12:23:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201102122311eusmtrp2d1c125a97c0549688cb333b9b5616db6~DsFmRWqTd2919729197eusmtrp2G;
        Mon,  2 Nov 2020 12:23:11 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-eb-5f9ffa2f975d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 85.B2.06314.E2AFF9F5; Mon,  2
        Nov 2020 12:23:10 +0000 (GMT)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201102122309eusmtip27199189c706b9bdf043f5960224f430e~DsFlQd0A40348203482eusmtip2a;
        Mon,  2 Nov 2020 12:23:09 +0000 (GMT)
Subject: Re: [PATCH v7 2/6] interconnect: Add generic interconnect driver
 for Exynos SoCs
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     georgi.djakov@linaro.org, cw00.choi@samsung.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <9ef1cf71-0729-d4f7-6a15-eb4ba1ffbefc@samsung.com>
Date:   Mon, 2 Nov 2020 13:23:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201031121747.GB9399@kozik-lap>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTm3e7ursPZdSo7zFKY/iihmSVxyTATi0EU/q3IufKmK522qaUQ
        +JGl+cFwhbrMjQK1lZjDWX5iMlshurBIScWyofkxxKaFWpp3V8l/z3PO85xznpeX4IqGeRJC
        pc6kNWplqhQXYG1vVx0Hw9eMikNl0xJqsq4IUS3VzTxqZHmGRxltQzzq08oiTlV1W3CqclKH
        UQ7HSz71saMWp9zlNkRVO3o4VJNtgk+N5TfiVFG3jU9V62fxmD1yi7kEl49/7sLlk6V2jryi
        1YzkbktQPO+C4HgSnarKpjXh0YmClM6pN5yM7163GrosvDzk5t9HXgSQkbDont/CAkJENiJY
        sM/xWLKM4GFPPZclbgQlw1P4jsX1dHVb1YBgetyJsWQJgaG316PyIy/CN30Hl8H+5AEY+fvb
        4+CS6xwoNA96tuNkBJT3VyAGC8lo6P9T66ljZCg4n1V5zAFkAuha7mCsxhfe1zDbCMKLlMEL
        61GmzCXF8MVp5LA4GAqtjzxnA7nEhy5dDWL0QMZB04SCTeAHc/bW7QfYC5vtjJfRFyIo6xzj
        s0SHYNJuQqwqCsaH1nBmEHcrTXNHODvzJAzb9rPQB0ZdvuwJPlDZxlzPlIVQfFfEzgiFdXMV
        h8USKHVuYjokNezKZdgVxrArjOH/WhPCzEhMZ2nTkmlthJq+KdMq07RZ6mTZlfQ0C9r6aQMb
        9p+v0crw5T5EEkjqLez1MypEPGW2NietDwHBlfoLYwcHEkTCJGVOLq1JV2iyUmltHwokMKlY
        eOTJ7CURmazMpK/TdAat2elyCC9JHuoOmLlmDBtzxmwcjiwMOX2GPmtNVp9vedBW8UGc5Doh
        vl3T/C6GLtgXJ5Wd+iHo94uOqss6duPVeEHfdL2+4B6uShxMUKktgbEb0K6vQ93eY7+C1kcf
        W0OCu75GufV6k8l17mp121pxfMBa8fPR3IWm+WJBTcGm0wTL+fcVzVJMm6KMCONqtMp/5Yoh
        qWUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xe7p6v+bHG/x9ZWlxf14ro8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C3uLxrDpvF594jjBYzzu9jslh75C67
        xe3GFWwWrXuPsFvMmPySzYHfY9OqTjaPO9f2sHnc7z7O5NG3ZRWjx+dNcgGsUXo2RfmlJakK
        GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZux8dZCp4zFmxfM8m
        1gbGz+xdjJwcEgImEm8X/2TtYuTiEBJYyiixv3sqWxcjB1BCSmJ+ixJEjbDEn2tdbBA17xkl
        JixZyQJSIywQLTH1gyNIjYiApsT1v9/B5jAL/GaSOHDvMgtEw2NGibVzj4BtYxMwlOg92scI
        YvMK2Ekc/TMHLM4ioCLxZOV0ZhBbVCBO4sfEXjaIGkGJkzOfgC3jFNCTWLPVDCTMLKAu8Wfe
        JWYIW1zi1pP5TBC2vETz1tnMExiFZiHpnoWkZRaSlllIWhYwsqxiFEktLc5Nzy021CtOzC0u
        zUvXS87P3cQIjOFtx35u3sF4aWPwIUYBDkYlHt4DwvPjhVgTy4orcw8xSnAwK4nwOp09HSfE
        m5JYWZValB9fVJqTWnyI0RTot4nMUqLJ+cD0klcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9
        sSQ1OzW1ILUIpo+Jg1OqgVFaYvOjLJ00Fn9z52VvVtq+ZPEvP/6Wx/q2QHrLFfcdZsI7Zj/6
        djMzcNr9yRZX381ill9aZlY70ex3QlVLzKHQL7+KPu5YG6cm7PV/37uQ5Pr7cTZxlgw1LMmh
        sWsy+Ga9vTJHVFeyKu5uPcfsFbav7qst71yQK71cwOOK4lFW4d0e9ak5lkosxRmJhlrMRcWJ
        AHWDOub3AgAA
X-CMS-MailID: 20201102122311eucas1p1805e9f745babaa133d80418bddf108a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9
References: <20201030125149.8227-1-s.nawrocki@samsung.com>
        <CGME20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9@eucas1p2.samsung.com>
        <20201030125149.8227-3-s.nawrocki@samsung.com>
        <20201031121747.GB9399@kozik-lap>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31.10.2020 13:17, Krzysztof Kozlowski wrote:
> On Fri, Oct 30, 2020 at 01:51:45PM +0100, Sylwester Nawrocki wrote:
>> This patch adds a generic interconnect driver for Exynos SoCs in order
>> to provide interconnect functionality for each "samsung,exynos-bus"
>> compatible device.

>> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

>>  drivers/interconnect/Kconfig         |   1 +
>>  drivers/interconnect/Makefile        |   1 +
>>  drivers/interconnect/exynos/Kconfig  |   6 ++
>>  drivers/interconnect/exynos/Makefile |   4 +
>>  drivers/interconnect/exynos/exynos.c | 198 +++++++++++++++++++++++++++++++++++
> 
> How about naming the directory as "samsung"? I don't expect interconnect
> drivers for the old Samsung S3C or S5P platforms, but it would be
> consisteny with other names (memory, clk, pinctrl).

Sure, I will rename the directory.

> How about adding separate maintainers entry for the driver with you and
> Artur (if he still works on this)?

I'm not sure what's the preference in the subsystem, I'm going to add
a patch introducing such a maintainers entry as it might be helpful 
for reviews/testing.  

-- 
Regards,
Sylwester
