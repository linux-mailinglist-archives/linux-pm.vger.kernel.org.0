Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD64979BC
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 14:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfHUMlZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 08:41:25 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49718 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfHUMlZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 08:41:25 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190821124123euoutp023207d2cd3d8be04de8735557e7e72a9f~88JLLng550448204482euoutp02s
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 12:41:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190821124123euoutp023207d2cd3d8be04de8735557e7e72a9f~88JLLng550448204482euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566391283;
        bh=AWVH8ErKQTpBej/vG98z0OHhZ8Sbjr1RrRMUtFdjqBs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Wm3RKf7rH0wUFAZZPqQbwO187t32Y7Ad/sUEllz+0+59j13bEdTNXqDwTwBRMLnb4
         NQqjKfoCGBmYIGWyimpXeZz4OuS65vwjxCQMIW/DJXXs4CG/iEe6ZnOF22JxoI3lrS
         J61Own9lr6ifGWitj+07w/GOqEd7QiaYa+gtLBCI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190821124122eucas1p1c61d22736ae1d2d482271ec608f455ce~88JKft-Ul1714117141eucas1p1B;
        Wed, 21 Aug 2019 12:41:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BE.DB.04309.2FB3D5D5; Wed, 21
        Aug 2019 13:41:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190821124121eucas1p29a471a96f26a9e2ec83f7785be6c6766~88JJkYuH92485024850eucas1p2j;
        Wed, 21 Aug 2019 12:41:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190821124121eusmtrp224b366b1d01b12eb7caf90744d1af89a~88JJWK8z32343923439eusmtrp2y;
        Wed, 21 Aug 2019 12:41:21 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-ce-5d5d3bf2a42e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6A.D6.04117.1FB3D5D5; Wed, 21
        Aug 2019 13:41:21 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190821124120eusmtip1748aeac163f204dbb76025899603aefa~88JIRL0bz1934619346eusmtip1G;
        Wed, 21 Aug 2019 12:41:20 +0000 (GMT)
Subject: Re: [PATCH v3 2/9] soc: samsung: Convert exynos-chipid driver to
 use the regmap API
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, robh+dt@kernel.org,
        vireshk@kernel.org, devicetree@vger.kernel.org, kgene@kernel.org,
        pankaj.dubey@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <537999b7-b0e8-33a7-4bdc-c6952a0a5d06@samsung.com>
Date:   Wed, 21 Aug 2019 14:41:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdh9eHrAuCxHkQBvJMqEnUCeU2xwkK=9yyiJ6BuTLJ+_A@mail.gmail.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0iTYRTGe/2ujlavU/NgUjDqjwI1K+gLTSoKVkEUQZax8lO/VHIqm5p2
        la7zMpMFamvgrLCchDrNW6Q55zSNVmgX6Dawi12mpAtqpeb8lPzvd855znmfB16WkL2mgtmU
        tExBncanymkJ2WT/7Qgdi1Qq17zsWslN6O0MV19eS3EVticUd8Fwg+SuDH0jOIejjuEsQy8o
        bqDNSHPjOhviyh3tPly+20Bzd21vGe7GPTfDXXxgY7jLH78QXIPTTm/Gij8ePVJYzPm0ouHW
        WYXu/AitKG40I8W4ZdkeOlYSlSikpmQL6vDoOElyYWUrmdEtyfH07c5DHWwB8mUBr4f2Ghdd
        gCSsDN9B0GsYJcTCjaD5+WtGLMYRWO1D5NxKcfEnUhzcRqD9WYTEwoXg52M35VX548PwznZ9
        +jDLBmAeJod5r4bAOhJKjS0zl2gcAbruYuRlKY6G1gYn4WUSr4SrN2sYLwfiAzDm7KJEjR88
        uvZhZtcX74W3wx7aywQOgnPuakrk5dDsMs5kADzBwEN9LyPa3gbOKb2PyP7wtadxth8CU60V
        PuLCeQRF98XQgEsQvO8xIVEVCV09zyhvHAKvgtq2cC8C3gKDnetEXASvXH6ih0WgbyojxLYU
        tJdk4o0V8MdcNusgGAo/TJElSG6Yl8wwL41hXhrD/2dNiDSjICFLo0oSNGvThONhGl6lyUpL
        CktIV1nQ9Jfrn+xxt6C2v/FWhFkkXygtCVUqZRSfrclVWRGwhDxAmmOMVcqkiXzuCUGdfkSd
        lSporGgpS8qDpCcXOA/JcBKfKRwThAxBPTf1YX2D81DJ9lb/TP1o31FrjD4mwbZxLNCQ5Lo0
        ua9jsWcg25xSmnxwRNv1eW9dUPTjiaexF7MjTlee2tpr7zhnOkvmTXRWjcf/MFG5Gy0QVZXe
        MZjxPS7jWI3i+RlPX3+jn2pd/S5Jxc7qph2JT/cvqR2QG8tbfi1vC9nk/+abdoPjjfa37qSc
        1CTzEasJtYb/B8merxpuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xu7ofrWNjDWb807D4O+kYu8XGGetZ
        LeYfOcdq0TJrEYtF/+PXzBbnz29gt9j0+BqrxeVdc9gsPvceYbSYcX4fk0Xnl1lsFmuP3GW3
        WLT1C7tF694j7BbtT18yW2x+cIzNQcDj969JjB6bVnWyeWxeUu/R2/yOzaNvyypGj8+b5ALY
        ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyuhfu
        ZCk4ylXx65RfA+N+ji5GTg4JAROJvr5nLF2MXBxCAksZJT6ce8HWxcgBlJCSmN+iBFEjLPHn
        WhcbRM1rRom+hrfsIAlhgTiJZfefgdkiAokS064fYgcpYhboZZFY8vMBO0THG2aJjp/XwKrY
        BAwleo/2MYLYvAJ2Ejs3P2AGsVkEVCUmL14NViMqECFxeMcsqBpBiZMzn7CA2JwCgRJ3X/xi
        A7GZBdQl/sy7xAxhi0s0fVnJCmHLS2x/O4d5AqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnp
        ucVGesWJucWleel6yfm5mxiBcb3t2M8tOxi73gUfYhTgYFTi4Z2gGxsrxJpYVlyZe4hRgoNZ
        SYS3Yk5UrBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA1NOXkm8oamhuYWlobmxubGZhZI4
        b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxvU/gg1zVlSFTXaUVFkla/E4173o4LfZb4wOtDB0
        PD26u5bF4XYI283lGVYanX27Vv/RK97+ZpuY49Y1Z82NZN5ruVhqVn169vRL+QIF768zrQK5
        Ohr0ExSiw3uu7+0QFYuYUP3v/slT6redL7kY1a8VWmapuuBl0POJ8hce1C/NPxI2zeWekxJL
        cUaioRZzUXEiAH60K+8BAwAA
X-CMS-MailID: 20190821124121eucas1p29a471a96f26a9e2ec83f7785be6c6766
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190813150852eucas1p2be4c0ab5ec2c079e3daf1af24283b27c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190813150852eucas1p2be4c0ab5ec2c079e3daf1af24283b27c
References: <20190813150827.31972-1-s.nawrocki@samsung.com>
        <CGME20190813150852eucas1p2be4c0ab5ec2c079e3daf1af24283b27c@eucas1p2.samsung.com>
        <20190813150827.31972-3-s.nawrocki@samsung.com>
        <b5359603-b337-dcd8-b025-ca7dff5f4a06@nvidia.com>
        <CAJKOXPf597CMx=M2JmSTWe2GzBfcHFefgzSJbJ+njZGp-WfR1A@mail.gmail.com>
        <1e428c8e-f4b5-0810-77f9-2c899c040fc7@kernel.org>
        <72eea1ea-2433-2f76-6265-5851554e845d@samsung.com>
        <CAJKOXPdh9eHrAuCxHkQBvJMqEnUCeU2xwkK=9yyiJ6BuTLJ+_A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/21/19 14:16, Krzysztof Kozlowski wrote:
>>> I'm also inclined to have it converted to a regular driver.  We already
>>> have "exynos-asv" driver matching on the chipid node (patch 3/9).
>>> The ASV patches will not be merged soon anyway, all this needs some more
>>> thought. Krzysztof, can we abandon the chipid patches for now? Your
>>
>> chipid driver is good and useful on its own. The preferred solution
>> IMHO would be to just revert "soc: samsung: Convert exynos-chipid
>> driver to use the regmap API" commit.
>
> I queued the chipid as a dependency for ASV but ASV requires the
> regmap. What would be left after reverting the regmap part? Simple
> unused printk driver? No need for such. If reverting, then let's drop
> entire driver and rework it offline.

In fact there is now no dependency between the chipid and the ASV 
driver (patch 3/9), the regmap is provided by the syscon driver/API.
I should have added "depends on REGMAP && MFD_SYSCON" to Kconfig.
Both drivers (chipid, ASV) share the registers region so the regmap 
API seemed appropriate here.
Converting the chipid code to platform driver wouldn't make sense as
it wouldn't be useful early in arch/arm/mach-exynos and we can't have
two drivers for same device (the ASV driver matches on the chipid 
compatible now).

-- 
Regards,
Sylwester
