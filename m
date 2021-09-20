Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39DB4111F4
	for <lists+linux-pm@lfdr.de>; Mon, 20 Sep 2021 11:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhITJkJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Sep 2021 05:40:09 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46538 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhITJkH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Sep 2021 05:40:07 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210920093835euoutp01e734e6a5edc023a1155339d1eec8431f~mfj0gMuo90671506715euoutp01K
        for <linux-pm@vger.kernel.org>; Mon, 20 Sep 2021 09:38:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210920093835euoutp01e734e6a5edc023a1155339d1eec8431f~mfj0gMuo90671506715euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1632130716;
        bh=e6isLm0fq/xkM6oDTJGwHszCngzBJExBJzDBgTBtJs0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=l/ElDmCoYjJa66ScBu2HKInHkEAD4KiX1K8uZXGwnOCzdZIkI2isYApN4VrMzvpr6
         m9Pem7H6dlKDJb/BgdnWvtF8gjWNMlx6FNGCqatR6E12I18pz6vPoi4zQmwWfVSHPL
         y5EVUGFBo+5s1aq8lhwNQb+DQ/pPqJrvVsyLk+2s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210920093835eucas1p1c9dda5ed24ec95143ab290b506c8f2b8~mfjz7AyFA0165601656eucas1p1n;
        Mon, 20 Sep 2021 09:38:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 50.0F.42068.B9658416; Mon, 20
        Sep 2021 10:38:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210920093834eucas1p2a0187690220f466590d390b9775ced84~mfjzKw59e2473024730eucas1p2R;
        Mon, 20 Sep 2021 09:38:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210920093834eusmtrp2bcae9c6411b3f96dcbeba51ad7144439~mfjzJwm1L2829128291eusmtrp22;
        Mon, 20 Sep 2021 09:38:34 +0000 (GMT)
X-AuditID: cbfec7f4-c71ff7000002a454-e7-6148569bd40a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 18.20.31287.A9658416; Mon, 20
        Sep 2021 10:38:34 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210920093833eusmtip24b53e66487ae49756c55d09b113c5c6e~mfjyXLVVq1258312583eusmtip2n;
        Mon, 20 Sep 2021 09:38:33 +0000 (GMT)
Subject: Re: [PATCH v2 0/3] devfreq: exynos-ppmu: conform to dt naming
 convention
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <04270892-0952-49ca-d9b7-eb8406e283ff@samsung.com>
Date:   Mon, 20 Sep 2021 11:38:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210920071540.38337-1-krzysztof.kozlowski@canonical.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djPc7qzwzwSDZ71ClhsnLGe1eL6l+es
        FvOPnGO12Pj2B5PF2aY37BabHl9jtbi8aw6bxefeI4wWM87vY7K43biCzaJ17xF2i/anL5kd
        eDxmNfSyeWxa1cnmsXlJvUffllWMHp83yQWwRnHZpKTmZJalFunbJXBlXJh8hbXgLkfFlT3N
        7A2Mk9m7GDk5JARMJK7NmsHSxcjFISSwglHi34FeJgjnC6NEx95PzCBVQgKfGSUeTbCD6fi4
        +gkbRNFyoPiLD4wQzkdGiYk3b7OAVAkLBEucXLsaLCEi8I9JYs/+BYwgCWaBVIn/D3vAxrIJ
        GEp0ve1iA7F5Bewkmr73gjWzCKhKXP3ZCnagqECyxLS/TcwQNYISJ2c+AavhFHCXaDx+AWqm
        vMT2t3OYIWxxiVtP5oP9ICHwg0PiTMMhJoi7XSSunN/ADGELS7w6vgUaAjIS/3fCNDQzSjw8
        t5YdwulhlLjcNIMRospa4s65X0CncgCt0JRYv0sfIuwosWDhEkaQsIQAn8SNt4IQR/BJTNo2
        nRkizCvR0SYEUa0mMev4Ori1By9cYp7AqDQLyWuzkLwzC8k7sxD2LmBkWcUonlpanJueWmyU
        l1quV5yYW1yal66XnJ+7iRGYtk7/O/5lB+PyVx/1DjEycTAeYpTgYFYS4U194pYoxJuSWFmV
        WpQfX1Sak1p8iFGag0VJnDdpy5p4IYH0xJLU7NTUgtQimCwTB6dUA5OxMV/3rL6NM+ZFrM8L
        7QjgCwuWTK6IL7ylurr39+4nz7/O5PXKZVqpsHRJTFHan8jOs4EH03Q+TIhPZZPIl0+ZdVhW
        QPv9JvHdN9vVPM66fGNIn6TL7WXLoPu4tsAseecMW4436z5/97apf3STKXyKVfePrWe3rrXp
        udywwqLAXNT1ivx0dv2TMdsrjG7sFfmhmMUj/sNVjd+Y06Lza/L7O7/X/76ufPa8zJI/JssX
        f1/oWVz43pV1YpnrOZPmvFWzpwn/DblWF1yel7F40baHNRcn7b0QrJWWsGRG1Zqd9V15tfcV
        8iP5rM1/Xv13XeVG9eF8xTmHHdaZnAx8pDZ1/f3gv8kJLetyNqXVvFdiKc5INNRiLipOBACp
        dacpygMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xe7qzwjwSDXrmSVlsnLGe1eL6l+es
        FvOPnGO12Pj2B5PF2aY37BabHl9jtbi8aw6bxefeI4wWM87vY7K43biCzaJ17xF2i/anL5kd
        eDxmNfSyeWxa1cnmsXlJvUffllWMHp83yQWwRunZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY
        6hkam8daGZkq6dvZpKTmZJalFunbJehlXJh8hbXgLkfFlT3N7A2Mk9m7GDk5JARMJD6ufsLW
        xcjFISSwlFHiYsckZoiEjMTJaQ2sELawxJ9rXVBF7xklus78A+sWFgiWOLl2NSOILSLwj0ni
        0VdDEJtZIFVi+sQP7BANsxgl7rz9CTaJTcBQoustyCRODl4BO4mm770sIDaLgKrE1Z+tYENF
        BZIl3r7+zgRRIyhxcuYTsBpOAXeJxuMXGCEWmEnM2/yQGcKWl9j+dg6ULS5x68l8pgmMQrOQ
        tM9C0jILScssJC0LGFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBMbptmM/N+9gnPfqo94h
        RiYOxkOMEhzMSiK8qU/cEoV4UxIrq1KL8uOLSnNSiw8xmgL9M5FZSjQ5H5go8kriDc0MTA1N
        zCwNTC3NjJXEebfOXRMvJJCeWJKanZpakFoE08fEwSnVwHRI5pkaR6q8kamo8/UDF0KWXtwS
        pVW7u3Tm+6o9dg0bpnmWbinYOD9HeetysU/6exx4NqlOVN89Syv/b9nSk3leb+fOOSEYGRZs
        enJqTkBiUnHsJPEsnYAeRlFTCYFVBSFL/u3kDxVerquSvYyhgyUx1eWD4uROxf5H2w8KPhQq
        yOzWfV3cltq4aE179+bfGz2NDXVsWTgvmU/j87fOYFTzWFzZwdW6mPP9J/b7vybKa75w/Kix
        J0tswbHdv3gVc8MW7zQLqmLbo363kokvZGuETMb69/9XqBW0i/22OGLBOPWUq1nwbTHNmcd6
        HXVcV0ywULVcekeiNL04xUf62J8srXD1b2y9dtzLgsSVWIozEg21mIuKEwHHLAXgXAMAAA==
X-CMS-MailID: 20210920093834eucas1p2a0187690220f466590d390b9775ced84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210920071554eucas1p195184c73f79e7bc12ea83cb43e14adc5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210920071554eucas1p195184c73f79e7bc12ea83cb43e14adc5
References: <CGME20210920071554eucas1p195184c73f79e7bc12ea83cb43e14adc5@eucas1p1.samsung.com>
        <20210920071540.38337-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20.09.2021 09:15, Krzysztof Kozlowski wrote:
> My previous patch 3/3 (ARM: dts: exynos: align PPMU event node names
> with dtschema) caused issues reported by Marek [1].
>
> Tested on Exynos5422. Testing on Exynso5433 board would be very useful.

Works fine on both 5422 and 5433.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> Changes since v1:
> 1. New patches 1/3 and 2/3.
> 2. Patch 3/3: rename event-name to match node name.
>
> [1] https://lore.kernel.org/linux-samsung-soc/0212a402-1490-0f8f-005e-32bb6f636a13@canonical.com/T/#m570c0257204af553fe11f9122551311beb56c15e
>
> Best regards,
> Krzysztof
>
>
> Krzysztof Kozlowski (3):
>    devfreq: exynos-ppmu: use node names with hyphens
>    devfreq: exynos-ppmu: simplify parsing event-type from DT
>    ARM: dts: exynos: align PPMU event node names with dtschema
>
>   arch/arm/boot/dts/exynos5420.dtsi   | 16 ++++++++--------
>   drivers/devfreq/event/exynos-ppmu.c | 12 +++++++-----
>   2 files changed, 15 insertions(+), 13 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

