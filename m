Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC9D596B95
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 23:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbfHTViL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 17:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730773AbfHTViK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Aug 2019 17:38:10 -0400
Received: from [192.168.0.26] (89-70-52-201.dynamic.chello.pl [89.70.52.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC0BF22D6D;
        Tue, 20 Aug 2019 21:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566337089;
        bh=gLlIXUezQ3H0zuhcdhL9pLDm+sYyFfXAb5ejydPRRmo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YSKysIziONSdYqDaBp1ouXGTLLHWaQibOh262t4q8PqwcS1xHNYPe/dQwWYeTWl6A
         mVEskQ4pZhKpl0mK5B/28GUIIVpvfdjEH60nAHGv3fSCz434vvwZyCNxJDnDUxhTja
         /1OxRfvJm9udJI/sh3ViWVKapHq8bT4gSwBQ+bvE=
Subject: Re: [PATCH v3 2/9] soc: samsung: Convert exynos-chipid driver to use
 the regmap API
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20190813150827.31972-1-s.nawrocki@samsung.com>
 <CGME20190813150852eucas1p2be4c0ab5ec2c079e3daf1af24283b27c@eucas1p2.samsung.com>
 <20190813150827.31972-3-s.nawrocki@samsung.com>
 <b5359603-b337-dcd8-b025-ca7dff5f4a06@nvidia.com>
 <CAJKOXPf597CMx=M2JmSTWe2GzBfcHFefgzSJbJ+njZGp-WfR1A@mail.gmail.com>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <1e428c8e-f4b5-0810-77f9-2c899c040fc7@kernel.org>
Date:   Tue, 20 Aug 2019 23:38:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPf597CMx=M2JmSTWe2GzBfcHFefgzSJbJ+njZGp-WfR1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/20/19 21:37, Krzysztof Kozlowski wrote:
>>> diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c

>>> @@ -51,29 +48,24 @@ static const char * __init product_id_to_soc_id(unsigned int product_id)
>>>   int __init exynos_chipid_early_init(void)
>>>   {
>>>        struct soc_device_attribute *soc_dev_attr;
>>> -     void __iomem *exynos_chipid_base;
>>>        struct soc_device *soc_dev;
>>>        struct device_node *root;
>>> -     struct device_node *np;
>>> +     struct regmap *regmap;
>>>        u32 product_id;
>>>        u32 revision;
>>> +     int ret;
>>>
>>> -     /* look up for chipid node */
>>> -     np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-chipid");
>>> -     if (!np)
>>> -             return -ENODEV;
>>> -
>>> -     exynos_chipid_base = of_iomap(np, 0);
>>> -     of_node_put(np);
>>> -
>>> -     if (!exynos_chipid_base) {
>>> -             pr_err("Failed to map SoC chipid\n");
>>> -             return -ENXIO;
>>> +     regmap = syscon_regmap_lookup_by_compatible("samsung,exynos4210-chipid");
>>> +     if (IS_ERR(regmap)) {
>>> +             pr_err("Failed to get CHIPID regmap\n");
>>> +             return PTR_ERR(regmap);
>>>        }
>> Following this change, I am now seeing the above error on our Tegra
>> boards where this driver is enabled. This is triggering a kernel
>> warnings test we have to fail. Hence, I don't think that you can remove
>> the compatible node test here, unless you have a better way to determine
>> if this is a samsung device.
>
> Right, this is really wrong... I missed that it is not a probe but
> early init. And this init will be called on every board... Probably it
> should be converted to a regular driver.

I'm also inclined to have it converted to a regular driver.  We already
have "exynos-asv" driver matching on the chipid node (patch 3/9). 
The ASV patches will not be merged soon anyway, all this needs some more
thought. Krzysztof, can we abandon the chipid patches for now? Your
pull request doesn't appear to be merged to arm-soc yet. Sorry about
that.

--
Regards,
Sylwester

