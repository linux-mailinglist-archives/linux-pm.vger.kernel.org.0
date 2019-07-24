Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9E472C86
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 12:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfGXKrb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 06:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfGXKra (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Jul 2019 06:47:30 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 740DD229FA;
        Wed, 24 Jul 2019 10:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563965249;
        bh=XqKYmTUOX1jzb8jQJM2UMIUVBoEiIefjBqEXYZC6+Q8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OoGNIGo9n4Dw84KdQMXHr14YIuwr2v8gYyq0EpRSCa9WKf+y7ws5X9/vH4LRw6p+8
         SFkjNiyvQVYGlIeX6ckPa0c4raZaFSEN47cp/ldLMzJbn7Up0Ewl89osIHve4t2YQ+
         BVe0+JzQteGkevspNOcHU9wHbFz3urZEyVZ27h2M=
Received: by mail-lf1-f44.google.com with SMTP id h28so31595219lfj.5;
        Wed, 24 Jul 2019 03:47:29 -0700 (PDT)
X-Gm-Message-State: APjAAAVB0sEi4uWalFek4V1AiMFr2wUOuHO9542zz4BABQoUX2SLR3Bx
        0Q4k5zTwQNPviarwR8hNKZbODZc5+62xCYshOMM=
X-Google-Smtp-Source: APXvYqy9K5E4hGCz/s/b0MY68jWI8cr4JC7OTnKDyAKC2ApiptG9TrpIaoDaLUgFlFXSddwxu9vPHeV69/haNP5yOT0=
X-Received: by 2002:a19:4f4a:: with SMTP id a10mr37712878lfk.30.1563965247598;
 Wed, 24 Jul 2019 03:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190718143127eucas1p13b1e2c98d270140a87f09562ef46c9a3@eucas1p1.samsung.com>
 <20190718143044.25066-1-s.nawrocki@samsung.com> <20190718143044.25066-2-s.nawrocki@samsung.com>
 <CAJKOXPfLBif-=09B9jZ3qN1kWdTAcrBQZGvZ+A-MUifXK4si9Q@mail.gmail.com> <1117f432-8adf-fbe9-f4af-f8acb755326e@samsung.com>
In-Reply-To: <1117f432-8adf-fbe9-f4af-f8acb755326e@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 24 Jul 2019 12:47:16 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf2dsnaV4cRT3JxvY=uFEH1hr8SempEHUXq5GiLwmwEzA@mail.gmail.com>
Message-ID: <CAJKOXPf2dsnaV4cRT3JxvY=uFEH1hr8SempEHUXq5GiLwmwEzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] soc: samsung: Add exynos chipid driver support
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>, robh+dt@kernel.org,
        vireshk@kernel.org, devicetree@vger.kernel.org, kgene@kernel.org,
        pankaj.dubey@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 23 Jul 2019 at 16:10, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
>
> Hi Krzysztof,
>
> On 7/23/19 2:57 PM, Krzysztof Kozlowski wrote:
> > On Thu, 18 Jul 2019 at 16:31, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
> >>
> >> From: Pankaj Dubey <pankaj.dubey@samsung.com>
> >>
> >> Exynos SoCs have Chipid, for identification of product IDs and SoC
> >> revisions. This patch intends to provide initialization code for all
> >> these functionalities, at the same time it provides some sysfs entries
> >> for accessing these information to user-space.
> >>
> >> This driver uses existing binding for exynos-chipid.
> >>
> >> Changes by Bartlomiej:
> >> - fixed return values on errors
> >> - removed bogus kfree_const()
> >> - added missing Exynos4210 EVT0 id
> >> - converted code to use EXYNOS_MASK define
> >> - fixed np use after of_node_put()
> >> - fixed too early use of dev_info()
> >> - made driver fail for unknown SoC-s
> >> - added SPDX tag
> >> - updated Copyrights
> >>
> >> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> >> [m.szyprowski: for suggestion and code snippet of product_id_to_soc_id]
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >> [s.nawrocki: updated copyright date]
> >> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> >> ---
> >>  drivers/soc/samsung/Kconfig         |   5 ++
> >>  drivers/soc/samsung/Makefile        |   2 +
> >>  drivers/soc/samsung/exynos-chipid.c | 111 ++++++++++++++++++++++++++++
> >>  3 files changed, 118 insertions(+)
> >>  create mode 100644 drivers/soc/samsung/exynos-chipid.c
> >>
> >> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> >> index 2186285fda92..2905f5262197 100644
> >> --- a/drivers/soc/samsung/Kconfig
> >> +++ b/drivers/soc/samsung/Kconfig
> >> @@ -7,6 +7,11 @@ menuconfig SOC_SAMSUNG
> >>
> >>  if SOC_SAMSUNG
> >>
> >> +config EXYNOS_CHIPID
> >> +       bool "Exynos Chipid controller driver" if COMPILE_TEST
> >> +       depends on ARCH_EXYNOS || COMPILE_TEST
> >> +       select SOC_BUS
> >> +
> >>  config EXYNOS_PMU
> >>         bool "Exynos PMU controller driver" if COMPILE_TEST
> >>         depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
> >> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> >> index 29f294baac6e..3b6a8797416c 100644
> >> --- a/drivers/soc/samsung/Makefile
> >> +++ b/drivers/soc/samsung/Makefile
> >> @@ -1,4 +1,6 @@
> >>  # SPDX-License-Identifier: GPL-2.0
> >> +
> >> +obj-$(CONFIG_EXYNOS_CHIPID)    += exynos-chipid.o
> >>  obj-$(CONFIG_EXYNOS_PMU)       += exynos-pmu.o
> >>
> >>  obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)   += exynos3250-pmu.o exynos4-pmu.o \
> >> diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
> >> new file mode 100644
> >> index 000000000000..78b123ee60c0
> >> --- /dev/null
> >> +++ b/drivers/soc/samsung/exynos-chipid.c
> >> @@ -0,0 +1,111 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) 2019 Samsung Electronics Co., Ltd.
> >> + *           http://www.samsung.com/
> >> + *
> >> + * EXYNOS - CHIP ID support
> >> + * Author: Pankaj Dubey <pankaj.dubey@samsung.com>
> >> + * Author: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >> + */
> >> +
> >> +#include <linux/io.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_address.h>
> >> +#include <linux/of_platform.h>
> >> +#include <linux/platform_device.h>
> >
> > Any changes here from my previous comments?
> >
> > I have also one more new thought later.
> >
> >> +#include <linux/slab.h>
> >> +#include <linux/sys_soc.h>
> >> +
> >> +#define EXYNOS_SUBREV_MASK     (0xF << 4)
> >> +#define EXYNOS_MAINREV_MASK    (0xF << 0)
> >> +#define EXYNOS_REV_MASK                (EXYNOS_SUBREV_MASK | EXYNOS_MAINREV_MASK)
> >> +#define EXYNOS_MASK            0xFFFFF000
> >> +
> >> +static const struct exynos_soc_id {
> >> +       const char *name;
> >> +       unsigned int id;
> >> +} soc_ids[] = {
> >> +       { "EXYNOS3250", 0xE3472000 },
> >> +       { "EXYNOS4210", 0x43200000 },   /* EVT0 revision */
> >> +       { "EXYNOS4210", 0x43210000 },
> >> +       { "EXYNOS4212", 0x43220000 },
> >> +       { "EXYNOS4412", 0xE4412000 },
> >> +       { "EXYNOS5250", 0x43520000 },
> >> +       { "EXYNOS5260", 0xE5260000 },
> >> +       { "EXYNOS5410", 0xE5410000 },
> >> +       { "EXYNOS5420", 0xE5420000 },
> >> +       { "EXYNOS5440", 0xE5440000 },
> >> +       { "EXYNOS5800", 0xE5422000 },
> >> +       { "EXYNOS7420", 0xE7420000 },
> >> +       { "EXYNOS5433", 0xE5433000 },
> >> +};
> >> +
> >> +static const char * __init product_id_to_soc_id(unsigned int product_id)
> >> +{
> >> +       int i;
> >> +
> >> +       for (i = 0; i < ARRAY_SIZE(soc_ids); i++)
> >> +               if ((product_id & EXYNOS_MASK) == soc_ids[i].id)
> >> +                       return soc_ids[i].name;
> >> +       return NULL;
> >> +}
> >> +
> >> +int __init exynos_chipid_early_init(void)
> >> +{
> >> +       struct soc_device_attribute *soc_dev_attr;
> >> +       void __iomem *exynos_chipid_base;
> >> +       struct soc_device *soc_dev;
> >> +       struct device_node *root;
> >> +       struct device_node *np;
> >> +       u32 product_id;
> >> +       u32 revision;
> >> +
> >> +       /* look up for chipid node */
> >> +       np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-chipid");
> >> +       if (!np)
> >> +               return -ENODEV;
> >> +
> >> +       exynos_chipid_base = of_iomap(np, 0);
> >> +       of_node_put(np);
> >> +
> >> +       if (!exynos_chipid_base) {
> >> +               pr_err("Failed to map SoC chipid\n");
> >> +               return -ENXIO;
> >> +       }
> >> +
> >> +       product_id = readl_relaxed(exynos_chipid_base);
> >> +       revision = product_id & EXYNOS_REV_MASK;
> >> +       iounmap(exynos_chipid_base);
> >> +
> >> +       soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> >> +       if (!soc_dev_attr)
> >> +               return -ENOMEM;
> >> +
> >> +       soc_dev_attr->family = "Samsung Exynos";
> >> +
> >> +       root = of_find_node_by_path("/");
> >> +       of_property_read_string(root, "model", &soc_dev_attr->machine);
> >> +       of_node_put(root);
> >> +
> >> +       soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x", revision);
> >> +       soc_dev_attr->soc_id = product_id_to_soc_id(product_id);
> >> +       if (!soc_dev_attr->soc_id) {
> >> +               pr_err("Unknown SoC\n");
> >
> > In case of running old kernel on unknown SoC (new revision of existing
> > one or older design not longer supported like 4415), the device will
> > not bind. This was added by Bartlomiej. Why? I imagine that soc driver
> > could be still matched and just report "Unknown". I am not sure if
> > this changes anything, though.
>
> I was thinking that we shouldn't be pretending that we know how to
> handle unsupported SoCs, i.e. that we know how to correctly read its
> product_id and revision.

Reasonable, thanks for explanation.
Best regards,
Krzysztof
