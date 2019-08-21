Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B6197AE5
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 15:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfHUNbc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 09:31:32 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42324 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfHUNbc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 09:31:32 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190821133129euoutp02787c7dc666bafe6038383e23e6835843~8806t9MOo0181701817euoutp024
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 13:31:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190821133129euoutp02787c7dc666bafe6038383e23e6835843~8806t9MOo0181701817euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566394289;
        bh=/D2caZgtkM4Mtk1ImVESN+kr9D/hyd6bSDCa0+RCcXU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GR7rQsQoDx+bA2Zq4SW3lrdrn0LfjOXxtFlsbBUd+mFCY6vqFzQ/STPIx3+eQntfu
         5cm2uosnnhLrL2uchOhwqYPtBenOjxzl+ZDHJFJ9xCQZ6pg6C6ujcXTK7pVJp2h+sO
         GEuGg3y9oa9q9FYKco/3ZT0B2fYZ3UUW4osEAjl0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190821133128eucas1p1620bed3555fea4cc5ed3c77029591c86~88054BbWa1122211222eucas1p15;
        Wed, 21 Aug 2019 13:31:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 87.B3.04309.0B74D5D5; Wed, 21
        Aug 2019 14:31:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190821133127eucas1p243b7ca9ead6067c4980534cca2cb435c~8805FTILe2077520775eucas1p26;
        Wed, 21 Aug 2019 13:31:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190821133127eusmtrp1abc4ffc11ae7364b72bf4e51ede9ff57~88042v3dX2187721877eusmtrp1l;
        Wed, 21 Aug 2019 13:31:27 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-c9-5d5d47b05a11
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5E.0C.04166.FA74D5D5; Wed, 21
        Aug 2019 14:31:27 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190821133126eusmtip210afd004be05403649fb557e52ca5563~8804Hjb-m0921809218eusmtip2C;
        Wed, 21 Aug 2019 13:31:26 +0000 (GMT)
Subject: Re: [PATCH v3 2/9] soc: samsung: Convert exynos-chipid driver to
 use the regmap API
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <d9a20ae5-4bdf-cb05-d68f-a7631517c87c@samsung.com>
Date:   Wed, 21 Aug 2019 15:31:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdh9eHrAuCxHkQBvJMqEnUCeU2xwkK=9yyiJ6BuTLJ+_A@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0iTYRTGe/0u+xRnr1PxYGowKDBQs0S+Loii4SCiy19hzFz5oZKabN4L
        Wql5oZrOoLUE7eZloC7vWkm6T00kpSzNwkumodUqcmhqas5Pyf9+7znPc55z4GUIyUfKjYlN
        SOKUCYo4KW1HNnYt9Hkbw+TyveZmT3ZZ2yViS/g+is3SPyBZzedvBNvfbxSxtZ8HKXagtZhm
        Z2/yiNX1t9mweRY9zVbxIyL2QYNFxGY/50Ws6XsOxeZMzRBs3XgXHYRlS4taJKs15NGyukdX
        ZDczf9CyW/UGJJut9TxBh9sdjuLiYlM4pW9gpF2M7t0wnWjxSJsxVFJqVA35yJYB7A+mhzyZ
        j+wYCa5AYB4apoSHBUFDvYmwqiR4FsGAxnnT8UQ3tlEvR/B0NFEwmBFMaKvXG044Akb5e7SV
        nbEXDC3Pr08l8DMSNFWvRNYGjQ9CYY4BWVmMA4EfuE9ZmcS7QMe/Xte44NMw1mWkBI0j9Nyd
        JK1si0/CyPTiegCBXeHDZImNwDuhyVxMWMMAX2XglaaHEtYOhWzTF0JgJ/jaXS8S2B16i26Q
        gqEawXLu9Ia7CUF50QotqA6Bqfv12iRmLcILalp9rQg4GN627xfQAd6bHYUdHEDbeIcQymLI
        vS4RZuwGY5mR3kzNb6kkCpBUv+Uy/ZZr9Fuu0f+PLUWkAblyyar4aE61L4FL9VEp4lXJCdE+
        5y/G16K1L9e70m1pRq1/z3UgzCCpvbjAWy6XUIoUVXp8BwKGkDqL04rD5RJxlCI9g1NePKtM
        juNUHWgHQ0pdxZe2jZ+R4GhFEneB4xI55WbXhrF1UyPbwr7hFsql7e68/zOZJqKzifL4o6tr
        d/g11zmbFdPuHpnx9XJw7IRTSlqIxqPq+OGK24WrmXt+rvimNjx2DLMXh4aG1x+onrq2rZRf
        CghQ1uTN+aoHZU9W/UzbqezVF09fHvF780mUhMa7Q1pOjQWVqaX34o4eU0dpva79XnD3OS0l
        VTEKvz2EUqX4B67VEr1uAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsVy+t/xe7rr3WNjDebdU7b4O+kYu8X8I+dY
        LVpmLWKx6H/8mtni/PkN7BabHl9jtbi8aw6bxefeI4wWM87vY7Lo/DKLzWLtkbvsFou2fmG3
        aN17hN3i8Jt2Vov2py+ZLTY/OMbmIODx+9ckRo9NqzrZPDYvqffobX7H5tG3ZRWjx+dNcgFs
        UXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZM67e
        ZCv4IlvxctVK1gbGdRJdjJwcEgImEhtn3GfuYuTiEBJYyihxeNF9li5GDqCEjMTx9WUQNcIS
        f651sUHUvGaUOLmkgwkkISwQJ7Hs/jN2EFtEQFPi+t/vrCBFzAL7WCTaDvxgh+h4wyzR8fMa
        WBWbgJXExPZVjCA2r4CdxJHLC1lBbBYBVYkZRy6C1YgKREiceb+CBaJGUOLkzCdgNqdAoMTd
        F7/YQGxmAXWJP/MuMUPY4hK3nsxngrDlJba/ncM8gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS
        4tz03GJDveLE3OLSvHS95PzcTYzAyN527OfmHYyXNgYfYhTgYFTi4Z2gGxsrxJpYVlyZe4hR
        goNZSYS3Yk5UrBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA5NOXkm8oamhuYWlobmxubGZ
        hZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxj4bRrkvhSXOYbKnPFI/R01w4/30Z3dZgpJM
        9Kr9u6b+vCmyK386M/eDZnfJBVf1jDcdlWq6ciRG5qT62isS87/dXy9/ZHe2o86crFYxc+31
        BvXz7zXNnRs1V0RzVWt9QGfkp7mmNT557b82hkkZ3Lltuddu9nZnS72gkM32pw2WrO3/W9jZ
        q8RSnJFoqMVcVJwIANlgoLoCAwAA
X-CMS-MailID: 20190821133127eucas1p243b7ca9ead6067c4980534cca2cb435c
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


On 8/21/19 2:16 PM, Krzysztof Kozlowski wrote:
> On Wed, 21 Aug 2019 at 13:51, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>>>>> Following this change, I am now seeing the above error on our Tegra
>>>>> boards where this driver is enabled. This is triggering a kernel
>>>>> warnings test we have to fail. Hence, I don't think that you can remove
>>>>> the compatible node test here, unless you have a better way to determine
>>>>> if this is a samsung device.
>>>>
>>>> Right, this is really wrong... I missed that it is not a probe but
>>>> early init. And this init will be called on every board... Probably it
>>>> should be converted to a regular driver.
>>
>> Early initialization is needed for SoC driver to be used from within
>> arch/arm/mach-exynos/ and _initcall() usage is the usual way for SoC
>> drivers to be initialized:
>>
>> drivers/soc/amlogic/meson-gx-socinfo.c
>> drivers/soc/amlogic/meson-mx-socinfo.c
>> drivers/soc/atmel/soc.c
>> drivers/soc/bcm/brcmstb/common.c
>> drivers/soc/imx/soc-imx-scu.c
>> drivers/soc/imx/soc-imx8.c
>> drivers/soc/renesas/renesas-soc.c
>> drivers/soc/tegra/fuse/fuse-tegra.c
>> drivers/soc/ux500/ux500-soc-id.c
>> drivers/soc/versatile/soc-integrator.c
>> drivers/soc/versatile/soc-integrator.c
>>
>> The only SoC drivers that are regular drivers are:
>>
>> drivers/soc/fsl/guts.c
>> drivers/soc/versatile/soc-realview.c
> 
> Thanks for pointing it out.
> 
> Indeed, the initcall was needed in your set of patches here:
> https://patchwork.kernel.org/project/linux-samsung-soc/list/?series=43565&state=*
> but this work was not continued here. Maybe it will be later
> resubmitted... maybe not... who knows? Therefore I would prefer proper

The work got delayed mainly because of the request for the formal
audit of each usage vs cache coherency. Since it is rather small
cleanup and such audit is time consuming it became a low priority.

> solution for current case (driver), unless patches for mach are being
> brought back to life now.
> 
>>> I'm also inclined to have it converted to a regular driver.  We already
>>> have "exynos-asv" driver matching on the chipid node (patch 3/9).
>>> The ASV patches will not be merged soon anyway, all this needs some more
>>> thought. Krzysztof, can we abandon the chipid patches for now? Your
>>
>> chipid driver is good and useful on its own. The preferred solution
>> IMHO would be to just revert "soc: samsung: Convert exynos-chipid
>> driver to use the regmap API" commit.

Or just fix it by re-adding removed Exynos chipid compatible checking:

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 006a95feb618..d9912bd52479 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -55,6 +55,11 @@ int __init exynos_chipid_early_init(void)
        u32 revision;
        int ret;
 
+       /* look up for chipid node */
+       np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-chipid");
+       if (!np)
+               return -ENODEV;
+
        regmap = syscon_regmap_lookup_by_compatible("samsung,exynos4210-chipid");
        if (IS_ERR(regmap)) {
                pr_err("Failed to get CHIPID regmap\n");

> I queued the chipid as a dependency for ASV but ASV requires the
> regmap. What would be left after reverting the regmap part? Simple
> unused printk driver? No need for such. If reverting, then let's drop

It provides sysfs information about SoC/platform and is useful on its
own (for debugging, reporting etc. purposes). Maybe not terrible useful
but on OTOH the driver is only ~100 LOC.

> entire driver and rework it offline.
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
