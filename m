Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8AC9973D5
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 09:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfHUHtv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 03:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfHUHtv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Aug 2019 03:49:51 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CADD7233FF;
        Wed, 21 Aug 2019 07:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566373790;
        bh=48hZbPJtzSxx3b/A53I4PAXECxqgXTQufB/rcB8xTZM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P7/gmtEOu+07urJK1FBTX+Ba4qDgS5ToQMx4eze7JbceXNNUR4u4m49iHD74LH3cp
         ZheENFVTNDmU4heunGKuD/ax/z6UiPmx6Al6Q1gc9brqPjwPysWKUVE5GyeFPUNyvH
         dXNfVYg87CsT9axD9YizhBrmwa4WId7PNziUkEjU=
Received: by mail-lj1-f170.google.com with SMTP id x3so1228163lji.5;
        Wed, 21 Aug 2019 00:49:49 -0700 (PDT)
X-Gm-Message-State: APjAAAW3jPLlNI4HDPu2txBHd0BvA44pljrd4VYETRb4z2WeGoqa4dgh
        rJtoteaF8SkbsbjCCh+B7xl8vh4c7iIExez2pwI=
X-Google-Smtp-Source: APXvYqyKZ6hp0isd++pSIdiygMNPAboh6ydC5w3pg7nv0BqAltG/55Aw8qIwfJ3UWnul58T3CByp6jMBOZQDlen5WuM=
X-Received: by 2002:a2e:9acf:: with SMTP id p15mr18348273ljj.13.1566373787954;
 Wed, 21 Aug 2019 00:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190813150827.31972-1-s.nawrocki@samsung.com>
 <CGME20190813150852eucas1p2be4c0ab5ec2c079e3daf1af24283b27c@eucas1p2.samsung.com>
 <20190813150827.31972-3-s.nawrocki@samsung.com> <b5359603-b337-dcd8-b025-ca7dff5f4a06@nvidia.com>
 <CAJKOXPf597CMx=M2JmSTWe2GzBfcHFefgzSJbJ+njZGp-WfR1A@mail.gmail.com> <1e428c8e-f4b5-0810-77f9-2c899c040fc7@kernel.org>
In-Reply-To: <1e428c8e-f4b5-0810-77f9-2c899c040fc7@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 21 Aug 2019 09:49:36 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcdeb08-2Xsmjpw_CsJCTah03GJaLUjQYw6n7=Xhiwoow@mail.gmail.com>
Message-ID: <CAJKOXPcdeb08-2Xsmjpw_CsJCTah03GJaLUjQYw6n7=Xhiwoow@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] soc: samsung: Convert exynos-chipid driver to use
 the regmap API
To:     Sylwester Nawrocki <snawrocki@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 20 Aug 2019 at 23:38, Sylwester Nawrocki <snawrocki@kernel.org> wrote:
>
> On 8/20/19 21:37, Krzysztof Kozlowski wrote:
> >>> diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
>
> >>> @@ -51,29 +48,24 @@ static const char * __init product_id_to_soc_id(unsigned int product_id)
> >>>   int __init exynos_chipid_early_init(void)
> >>>   {
> >>>        struct soc_device_attribute *soc_dev_attr;
> >>> -     void __iomem *exynos_chipid_base;
> >>>        struct soc_device *soc_dev;
> >>>        struct device_node *root;
> >>> -     struct device_node *np;
> >>> +     struct regmap *regmap;
> >>>        u32 product_id;
> >>>        u32 revision;
> >>> +     int ret;
> >>>
> >>> -     /* look up for chipid node */
> >>> -     np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-chipid");
> >>> -     if (!np)
> >>> -             return -ENODEV;
> >>> -
> >>> -     exynos_chipid_base = of_iomap(np, 0);
> >>> -     of_node_put(np);
> >>> -
> >>> -     if (!exynos_chipid_base) {
> >>> -             pr_err("Failed to map SoC chipid\n");
> >>> -             return -ENXIO;
> >>> +     regmap = syscon_regmap_lookup_by_compatible("samsung,exynos4210-chipid");
> >>> +     if (IS_ERR(regmap)) {
> >>> +             pr_err("Failed to get CHIPID regmap\n");
> >>> +             return PTR_ERR(regmap);
> >>>        }
> >> Following this change, I am now seeing the above error on our Tegra
> >> boards where this driver is enabled. This is triggering a kernel
> >> warnings test we have to fail. Hence, I don't think that you can remove
> >> the compatible node test here, unless you have a better way to determine
> >> if this is a samsung device.
> >
> > Right, this is really wrong... I missed that it is not a probe but
> > early init. And this init will be called on every board... Probably it
> > should be converted to a regular driver.
>
> I'm also inclined to have it converted to a regular driver.  We already
> have "exynos-asv" driver matching on the chipid node (patch 3/9).
> The ASV patches will not be merged soon anyway, all this needs some more
> thought. Krzysztof, can we abandon the chipid patches for now? Your
> pull request doesn't appear to be merged to arm-soc yet. Sorry about
> that.

Yes, let's abandon the pull request and rework the concept.

Best regards,
Krzysztof
