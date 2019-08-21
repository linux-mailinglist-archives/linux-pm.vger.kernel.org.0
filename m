Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED9D97851
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 13:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfHULvn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 07:51:43 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49032 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfHULvm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 07:51:42 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190821115140euoutp01bb6404fa43dd86717310eab12c993fd7~87dwtIrq-2561225612euoutp01v
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 11:51:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190821115140euoutp01bb6404fa43dd86717310eab12c993fd7~87dwtIrq-2561225612euoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566388300;
        bh=yBUfjQ3nbvD06XyHTq2L/29JP/gh9G+IfMlftFMxlxw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IM6rtdtePLhd+o/hEJEbCru8yapgntN3Ok8U6EAh2Ij9+rgx2IkTQwCzlvyoaogje
         mNa7+KxlA7PzhCsi2/cwiwSki5SdTjg2iiWihaJA3I04NKfmulfdb1It5nTWae+Kz1
         V3Ta66QFmICvgUJS+5UpLzIgL7gHkkjXpirgUiKQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190821115139eucas1p2b64dcab05491e1fcc9b9db48c7562a28~87dvzbRyS2160221602eucas1p2_;
        Wed, 21 Aug 2019 11:51:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 62.7F.04374.B403D5D5; Wed, 21
        Aug 2019 12:51:39 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190821115138eucas1p1d5934e448f84b6c0ae1f76636e64ade4~87du-2Vee2007520075eucas1p1N;
        Wed, 21 Aug 2019 11:51:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190821115138eusmtrp1985e650b0806b83f355f9f80b5c968fa~87du9sOmS3221232212eusmtrp1z;
        Wed, 21 Aug 2019 11:51:38 +0000 (GMT)
X-AuditID: cbfec7f5-92d689c000001116-3e-5d5d304bf851
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D9.30.04117.A403D5D5; Wed, 21
        Aug 2019 12:51:38 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190821115137eusmtip171d2e3bfcf321ec53b4221eaec8b2998~87duRUGk22315023150eusmtip1i;
        Wed, 21 Aug 2019 11:51:37 +0000 (GMT)
Subject: Re: [PATCH v3 2/9] soc: samsung: Convert exynos-chipid driver to
 use the regmap API
To:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
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
Message-ID: <72eea1ea-2433-2f76-6265-5851554e845d@samsung.com>
Date:   Wed, 21 Aug 2019 13:51:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1e428c8e-f4b5-0810-77f9-2c899c040fc7@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHfXzfvXsdTp5m4cmicF3oQmoY9lAiSn0Y+CUIorRpM1/UvG9q
        WkqmlWmZa9LFqVhRXhbVmrc0stKhieGKtJuZlpc0XSiusryQ26vkt98553/O+R84LCXpFriy
        kbGJnDJWES1lRHRty5+ObQGecrnnsyKazGpahKTU2CEgZ7S3aJLfP0oRk0kvJIb+twLypqGY
        IZN5RkSumxrtSY5Fy5B7xh4huVVjEZKzT4xC0jyWLSDZgyMUqeprYfywbPqvBskMuhxGVnX7
        lCwv6wcju1StQ7JJw5p9TKDIJ4yLjkzmlB6+R0QRmTVdTPwMpAwPP6Qy0JhzLnJgAe+AF22j
        glwkYiW4AsG4umghsCDIqh5lrCoJnkTQ82rlYsf77gs0LypHMFGTyfCBGUHXY7W9VeWMg+Gz
        scjWvRwfgDsDalsHhfNpKGsaF1oLDN4Fl7N1yMpi7Av6ggnKyjTeAIbBD7SVV+CD0NuiF/Ca
        ZdBWOGDLO8zrBztnbXMo7AIfB0rteV4LdeZiird6moUpzX6e98Iv/d2FvDN8b60W8rwa2gsu
        2swBvo9g9vwwxQd1CMoL5hhetRuaW1/Pu2DnN2yGBw0eVgTsD53PvXh0gvfmZbwFJ9DUXqP4
        tBjOn5PwMzaCvkzPLG7Nra+k1EiqXXKYdskx2iXHaP+vvYFoHXLhklQx4ZzKK5Y77q5SxKiS
        YsPdj8bFGND8y7XPtf58hBpnQpsQZpHUUazeJpdLBIpkVWpMEwKWki4XpxQHyiXiMEXqCU4Z
        F6JMiuZUTWgVS0tdxCft+oIkOFyRyEVxXDynXKzasw6uGWi1xl39UnTN21F2Bqd7lXjr1sR7
        b5WkDimn64nfN9NIJ1PiGeATmnahcF1QQNSxCnNvWsWHsCnLzrEyO7PbJ9P6B4fNCZ9+5Pjd
        LBkKOaQoUs8kZqV3CyLc9jhdLbTzb40SOaLk4B6PYeHXlKc+m74csfzuupLwztVN99Wzku53
        ldKqCMX2LZRSpfgH/Kvpcm4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xu7peBrGxBieOSFr8nXSM3WL+kXOs
        Fi2zFrFY9D9+zWxx/vwGdotNj6+xWlzeNYfN4nPvEUaLGef3MVl0fpnFZrH2yF12i0Vbv7Bb
        tO49wm5x+E07q0X705fMFpsfHGNzEPD4/WsSo8emVZ1sHpuX1Hv0Nr9j8+jbsorR4/MmuQC2
        KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mpq1X
        2Qr+SFS8eLGRuYHxjXAXIyeHhICJxI3b3SxdjFwcQgJLGSVWzt3A1sXIAZSQkTi+vgyiRlji
        z7UuNoia14wSdzeeYQZJCAvESSy7/4wdxBYRCJPYNPEq2CBmgYksEn1zNjOCJIQEPjBJXFpY
        CWKzCVhJTGxfBRbnFbCT2DD5I9ggFgFViU1Pb7KA2KICERJn3q9ggagRlDg58wmYzQlU//TK
        X7BlzALqEn/mXWKGsMUlbj2ZzwRhy0tsfzuHeQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW5
        6bnFRnrFibnFpXnpesn5uZsYgXG97djPLTsYu94FH2IU4GBU4uGdoBsbK8SaWFZcmXuIUYKD
        WUmEt2JOVKwQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wNTTl5JvKGpobmFpaG5sbmxmYWS
        OG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsbqmAnvo6aLGKyP3WkbaKdyiD+A2Zvv+tV5C8vF
        //jJFMbOvNzGPCUk9LBn2vVMldLJ38/NZrihfuldajrv/g1X+F9On/FQI+uMuMJ757MOmukc
        D5K3edcdYXy36BPzMlXWhVJ51jNTTX/VFVZKmWSU7Jt/VyP36upg4bCnUw7XHmrLfTDlygol
        luKMREMt5qLiRACNWWY6AQMAAA==
X-CMS-MailID: 20190821115138eucas1p1d5934e448f84b6c0ae1f76636e64ade4
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi,

On 8/20/19 11:38 PM, Sylwester Nawrocki wrote:
> On 8/20/19 21:37, Krzysztof Kozlowski wrote:
>>>> diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
> 
>>>> @@ -51,29 +48,24 @@ static const char * __init product_id_to_soc_id(unsigned int product_id)
>>>>   int __init exynos_chipid_early_init(void)
>>>>   {
>>>>        struct soc_device_attribute *soc_dev_attr;
>>>> -     void __iomem *exynos_chipid_base;
>>>>        struct soc_device *soc_dev;
>>>>        struct device_node *root;
>>>> -     struct device_node *np;
>>>> +     struct regmap *regmap;
>>>>        u32 product_id;
>>>>        u32 revision;
>>>> +     int ret;
>>>>
>>>> -     /* look up for chipid node */
>>>> -     np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-chipid");
>>>> -     if (!np)
>>>> -             return -ENODEV;
>>>> -
>>>> -     exynos_chipid_base = of_iomap(np, 0);
>>>> -     of_node_put(np);
>>>> -
>>>> -     if (!exynos_chipid_base) {
>>>> -             pr_err("Failed to map SoC chipid\n");
>>>> -             return -ENXIO;
>>>> +     regmap = syscon_regmap_lookup_by_compatible("samsung,exynos4210-chipid");
>>>> +     if (IS_ERR(regmap)) {
>>>> +             pr_err("Failed to get CHIPID regmap\n");
>>>> +             return PTR_ERR(regmap);
>>>>        }
>>> Following this change, I am now seeing the above error on our Tegra
>>> boards where this driver is enabled. This is triggering a kernel
>>> warnings test we have to fail. Hence, I don't think that you can remove
>>> the compatible node test here, unless you have a better way to determine
>>> if this is a samsung device.
>>
>> Right, this is really wrong... I missed that it is not a probe but
>> early init. And this init will be called on every board... Probably it
>> should be converted to a regular driver.

Early initialization is needed for SoC driver to be used from within
arch/arm/mach-exynos/ and _initcall() usage is the usual way for SoC
drivers to be initialized:

drivers/soc/amlogic/meson-gx-socinfo.c
drivers/soc/amlogic/meson-mx-socinfo.c
drivers/soc/atmel/soc.c
drivers/soc/bcm/brcmstb/common.c
drivers/soc/imx/soc-imx-scu.c
drivers/soc/imx/soc-imx8.c
drivers/soc/renesas/renesas-soc.c
drivers/soc/tegra/fuse/fuse-tegra.c
drivers/soc/ux500/ux500-soc-id.c
drivers/soc/versatile/soc-integrator.c
drivers/soc/versatile/soc-integrator.c

The only SoC drivers that are regular drivers are:

drivers/soc/fsl/guts.c
drivers/soc/versatile/soc-realview.c

> I'm also inclined to have it converted to a regular driver.  We already
> have "exynos-asv" driver matching on the chipid node (patch 3/9). 
> The ASV patches will not be merged soon anyway, all this needs some more
> thought. Krzysztof, can we abandon the chipid patches for now? Your

chipid driver is good and useful on its own. The preferred solution
IMHO would be to just revert "soc: samsung: Convert exynos-chipid
driver to use the regmap API" commit.

> pull request doesn't appear to be merged to arm-soc yet. Sorry about
> that.
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
