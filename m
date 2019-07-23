Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE86718D9
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 15:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390030AbfGWNB0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 09:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387961AbfGWNB0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jul 2019 09:01:26 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8891921670;
        Tue, 23 Jul 2019 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563886884;
        bh=CbmDLMjMi+Nd5R6Pl1B66vsTFwAu0X8Od5ob6t3Otuw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kJ666ehfoUBAoI2YSx+SVUOL2NzcWGe+pasJx61NM0E2XfSz5lGrmUerxSGuy6lXL
         YHaLk0zDxiYnhzlDZ4vDTkSbddvYgI1I/A6hwhecveTCjW7DbHEDWDsSNunSb/rgj7
         2Fhuuj2LpNazuUXoan0XpsuOKxvCQ8EoLnBZDIso=
Received: by mail-lf1-f42.google.com with SMTP id z15so25009600lfh.13;
        Tue, 23 Jul 2019 06:01:24 -0700 (PDT)
X-Gm-Message-State: APjAAAW38tGBwuCn9IW8FRqUH3x2Kd93SZo9VfAhcYcEQNiN8kbnMqEt
        DODAAav8+5Mb0XUC0QAtv7wvbwp0LibAKfkTVcI=
X-Google-Smtp-Source: APXvYqzsrG6nB7kU6t/8CnaY5zo3+o2W69whzh4IdxhPied3z2PagTqPDK+dlEb0CHK06r8rm64qmI6oQ9U81EJSSZ8=
X-Received: by 2002:ac2:514b:: with SMTP id q11mr9488330lfd.33.1563886882779;
 Tue, 23 Jul 2019 06:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190718143128eucas1p2677ae16d229dddcd9a0db8084f0da5cf@eucas1p2.samsung.com>
 <20190718143044.25066-1-s.nawrocki@samsung.com> <20190718143044.25066-3-s.nawrocki@samsung.com>
In-Reply-To: <20190718143044.25066-3-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 23 Jul 2019 15:01:11 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfLPjmjgX01UAyu_=7etUO1G7osMQDmyHVBNxF2Sdh=yA@mail.gmail.com>
Message-ID: <CAJKOXPfLPjmjgX01UAyu_=7etUO1G7osMQDmyHVBNxF2Sdh=yA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] soc: samsung: Convert exynos-chipid driver to use
 the regmap API
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 18 Jul 2019 at 16:31, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> Convert the driver to use regmap API in order to allow other
> drivers, like ASV, to access the CHIPID registers.
>
> This patch adds definition of selected CHIPID register offsets
> and register bit fields for Exynos5422 SoC.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v1 (RFC):
>  - new patch
> ---
>  drivers/soc/samsung/exynos-chipid.c       | 33 ++++++----------
>  include/linux/soc/samsung/exynos-chipid.h | 48 +++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 20 deletions(-)
>  create mode 100644 include/linux/soc/samsung/exynos-chipid.h
>
> diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
> index 78b123ee60c0..594b00488013 100644
> --- a/drivers/soc/samsung/exynos-chipid.c
> +++ b/drivers/soc/samsung/exynos-chipid.c
> @@ -9,18 +9,16 @@
>   */
>
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/soc/samsung/exynos-chipid.h>
>  #include <linux/sys_soc.h>
>
> -#define EXYNOS_SUBREV_MASK     (0xF << 4)
> -#define EXYNOS_MAINREV_MASK    (0xF << 0)
> -#define EXYNOS_REV_MASK                (EXYNOS_SUBREV_MASK | EXYNOS_MAINREV_MASK)
> -#define EXYNOS_MASK            0xFFFFF000
> -
>  static const struct exynos_soc_id {
>         const char *name;
>         unsigned int id;
> @@ -53,29 +51,24 @@ static const char * __init product_id_to_soc_id(unsigned int product_id)
>  int __init exynos_chipid_early_init(void)
>  {
>         struct soc_device_attribute *soc_dev_attr;
> -       void __iomem *exynos_chipid_base;
>         struct soc_device *soc_dev;
>         struct device_node *root;
> -       struct device_node *np;
> +       struct regmap *regmap;
>         u32 product_id;
>         u32 revision;
> +       int ret;
>
> -       /* look up for chipid node */
> -       np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-chipid");
> -       if (!np)
> -               return -ENODEV;
> -
> -       exynos_chipid_base = of_iomap(np, 0);
> -       of_node_put(np);
> -
> -       if (!exynos_chipid_base) {
> -               pr_err("Failed to map SoC chipid\n");
> -               return -ENXIO;
> +       regmap = syscon_regmap_lookup_by_compatible("samsung,exynos4210-chipid");
> +       if (IS_ERR(regmap)) {
> +               pr_err("%s: failed to get regmap\n", __func__);

Other places do not use __func__ prefix so make it consistent. Add it
in patch #1?

> +               return PTR_ERR(regmap);
>         }
>
> -       product_id = readl_relaxed(exynos_chipid_base);
> +       ret = regmap_read(regmap, EXYNOS_CHIPID_REG_PRO_ID, &product_id);
> +       if (ret < 0)
> +               return ret;
> +
>         revision = product_id & EXYNOS_REV_MASK;
> -       iounmap(exynos_chipid_base);
>
>         soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
>         if (!soc_dev_attr)
> diff --git a/include/linux/soc/samsung/exynos-chipid.h b/include/linux/soc/samsung/exynos-chipid.h
> new file mode 100644
> index 000000000000..25359d70d617
> --- /dev/null
> +++ b/include/linux/soc/samsung/exynos-chipid.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 Samsung Electronics Co., Ltd.
> + *           http://www.samsung.com/
> + *
> + * Exynos - CHIPID support
> + */
> +
> +#define EXYNOS_CHIPID_REG_PRO_ID       0x00
> + #define EXYNOS_SUBREV_MASK            (0xf << 4)

" #define" is unusual syntax. I think not used anywhere else. Stick to
regular one.

Best regards,
Krzysztof
