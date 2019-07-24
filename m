Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 329AB72DA5
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 13:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfGXLb1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 07:31:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbfGXLb0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Jul 2019 07:31:26 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7D8322ADF;
        Wed, 24 Jul 2019 11:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563967885;
        bh=gfIL8bDOerniMLTjoBQgfStiVE5avoo5zJE4+oSl/Xg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LLAUo5IlXo7iOvU1R9iDk5o9oAkcQRztoxvR4TjpNmsAQ1X3f5UfxIEtucTUvSNxW
         QBpoXwSJI/IF7aDT2K+DRwyRgTCe2Lz1tSmIIrJdUWYUxMu3uQLFiTQrvWneZl9j0j
         mWxpKGmLakVqlZX+ltZRpdwGoo5YWdcxxB+hQZnQ=
Received: by mail-lj1-f171.google.com with SMTP id r9so44147785ljg.5;
        Wed, 24 Jul 2019 04:31:24 -0700 (PDT)
X-Gm-Message-State: APjAAAVczsUPRYykC6Ddu8TiNVjKIfyTKmJL1xBt8+6qmOzXCXotHFyM
        aliVVnfKOua5WDs05Zy83xO+HYWTaA+4klERHfM=
X-Google-Smtp-Source: APXvYqwVZ0v5NoytspFUxCleMPfAfFqneEmr3GUNPhJ2AwALmaOWrWUIkhHCaB/fZ1wmSKcbQJxcpnLoU4i89LeTVRc=
X-Received: by 2002:a2e:980a:: with SMTP id a10mr43119196ljj.40.1563967882920;
 Wed, 24 Jul 2019 04:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190722094727eucas1p10041ba25819e6e62d639423a97435f2d@eucas1p1.samsung.com>
 <20190722094646.13342-1-l.luba@partner.samsung.com> <20190722094646.13342-4-l.luba@partner.samsung.com>
In-Reply-To: <20190722094646.13342-4-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 24 Jul 2019 13:31:11 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd96ExoCR-SiJfRqTbwO+_aQ6LSDVOQcrrt8JQHsoZBEw@mail.gmail.com>
Message-ID: <CAJKOXPd96ExoCR-SiJfRqTbwO+_aQ6LSDVOQcrrt8JQHsoZBEw@mail.gmail.com>
Subject: Re: [PATCH v12 3/9] drivers: memory: extend of_memory by LPDDR3 support
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 22 Jul 2019 at 11:47, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> The patch adds AC timings information needed to support LPDDR3 and memory
> controllers. The structure is used in of_memory and currently in Exynos
> 5422 DMC. Add parsing data needed for LPDDR3 support.
> It is currently used in Exynos5422 Dynamic Memory Controller.
>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/memory/jedec_ddr.h |  61 +++++++++++++++
>  drivers/memory/of_memory.c | 154 +++++++++++++++++++++++++++++++++++++
>  drivers/memory/of_memory.h |  18 +++++
>  3 files changed, 233 insertions(+)
>
> diff --git a/drivers/memory/jedec_ddr.h b/drivers/memory/jedec_ddr.h
> index 4a21b5044ff8..38e26d461bdb 100644
> --- a/drivers/memory/jedec_ddr.h
> +++ b/drivers/memory/jedec_ddr.h
> @@ -29,6 +29,7 @@
>  #define DDR_TYPE_LPDDR2_S4     3
>  #define DDR_TYPE_LPDDR2_S2     4
>  #define DDR_TYPE_LPDDR2_NVM    5
> +#define DDR_TYPE_LPDDR3                6
>
>  /* DDR IO width */
>  #define DDR_IO_WIDTH_4         1
> @@ -169,4 +170,64 @@ extern const struct lpddr2_timings
>         lpddr2_jedec_timings[NUM_DDR_TIMING_TABLE_ENTRIES];
>  extern const struct lpddr2_min_tck lpddr2_jedec_min_tck;
>
> +/*
> + * Structure for timings for LPDDR3 based on LPDDR2 plus additional fields.
> + * All parameters are in pico seconds(ps) unless explicitly indicated
> + * with a suffix like tRAS_max_ns below

To which tRAS_max_ns are you referring?

> + */
> +struct lpddr3_timings {
> +       u32 max_freq;
> +       u32 min_freq;
> +       u32 tRFC;
> +       u32 tRRD;
> +       u32 tRPab;
> +       u32 tRPpb;
> +       u32 tRCD;
> +       u32 tRC;
> +       u32 tRAS;
> +       u32 tWTR;
> +       u32 tWR;
> +       u32 tRTP;
> +       u32 tW2W_C2C;
> +       u32 tR2R_C2C;
> +       u32 tWL;
> +       u32 tDQSCK;
> +       u32 tRL;
> +       u32 tFAW;
> +       u32 tXSR;
> +       u32 tXP;
> +       u32 tCKE;
> +       u32 tCKESR;
> +       u32 tMRD;
> +};
> +
> +/*
> + * Min value for some parameters in terms of number of tCK cycles(nCK)
> + * Please set to zero parameters that are not valid for a given memory
> + * type
> + */
> +struct lpddr3_min_tck {
> +       u32 tRFC;
> +       u32 tRRD;
> +       u32 tRPab;
> +       u32 tRPpb;
> +       u32 tRCD;
> +       u32 tRC;
> +       u32 tRAS;
> +       u32 tWTR;
> +       u32 tWR;
> +       u32 tRTP;
> +       u32 tW2W_C2C;
> +       u32 tR2R_C2C;
> +       u32 tWL;
> +       u32 tDQSCK;
> +       u32 tRL;
> +       u32 tFAW;
> +       u32 tXSR;
> +       u32 tXP;
> +       u32 tCKE;
> +       u32 tCKESR;
> +       u32 tMRD;
> +};
> +
>  #endif /* __JEDEC_DDR_H */
> diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
> index 46539b27a3fb..4f5b8c81669f 100644
> --- a/drivers/memory/of_memory.c
> +++ b/drivers/memory/of_memory.c
> @@ -3,6 +3,12 @@
>   * OpenFirmware helpers for memory drivers
>   *
>   * Copyright (C) 2012 Texas Instruments, Inc.
> + * Copyright (C) 2019 Samsung Electronics Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
>   */
>
>  #include <linux/device.h>
> @@ -149,3 +155,151 @@ const struct lpddr2_timings *of_get_ddr_timings(struct device_node *np_ddr,
>         return lpddr2_jedec_timings;
>  }
>  EXPORT_SYMBOL(of_get_ddr_timings);
> +
> +/**
> + * of_lpddr3_get_min_tck() - extract min timing values for lpddr3
> + * @np: pointer to ddr device tree node
> + * @device: device requesting for min timing values
> + *
> + * Populates the lpddr3_min_tck structure by extracting data
> + * from device tree node. Returns a pointer to the populated
> + * structure. If any error in populating the structure, returns NULL.
> + */
> +const struct lpddr3_min_tck *of_lpddr3_get_min_tck(struct device_node *np,
> +                                                  struct device *dev)
> +{
> +       int                     ret = 0;
> +       struct lpddr3_min_tck   *min;
> +
> +       min = devm_kzalloc(dev, sizeof(*min), GFP_KERNEL);
> +       if (!min)
> +               goto default_min_tck;
> +
> +       ret |= of_property_read_u32(np, "tRFC-min-tck", &min->tRFC);
> +       ret |= of_property_read_u32(np, "tRRD-min-tck", &min->tRRD);
> +       ret |= of_property_read_u32(np, "tRPab-min-tck", &min->tRPab);
> +       ret |= of_property_read_u32(np, "tRPpb-min-tck", &min->tRPpb);
> +       ret |= of_property_read_u32(np, "tRCD-min-tck", &min->tRCD);
> +       ret |= of_property_read_u32(np, "tRC-min-tck", &min->tRC);
> +       ret |= of_property_read_u32(np, "tRAS-min-tck", &min->tRAS);
> +       ret |= of_property_read_u32(np, "tWTR-min-tck", &min->tWTR);
> +       ret |= of_property_read_u32(np, "tWR-min-tck", &min->tWR);
> +       ret |= of_property_read_u32(np, "tRTP-min-tck", &min->tRTP);
> +       ret |= of_property_read_u32(np, "tW2W-C2C-min-tck", &min->tW2W_C2C);
> +       ret |= of_property_read_u32(np, "tR2R-C2C-min-tck", &min->tR2R_C2C);
> +       ret |= of_property_read_u32(np, "tWL-min-tck", &min->tWL);
> +       ret |= of_property_read_u32(np, "tDQSCK-min-tck", &min->tDQSCK);
> +       ret |= of_property_read_u32(np, "tRL-min-tck", &min->tRL);
> +       ret |= of_property_read_u32(np, "tFAW-min-tck", &min->tFAW);
> +       ret |= of_property_read_u32(np, "tXSR-min-tck", &min->tXSR);
> +       ret |= of_property_read_u32(np, "tXP-min-tck", &min->tXP);
> +       ret |= of_property_read_u32(np, "tCKE-min-tck", &min->tCKE);
> +       ret |= of_property_read_u32(np, "tCKESR-min-tck", &min->tCKESR);
> +       ret |= of_property_read_u32(np, "tMRD-min-tck", &min->tMRD);
> +
> +       if (ret) {
> +               dev_warn(dev, "%s: errors while parsing min-tck values\n",
> +                        __func__);
> +               devm_kfree(dev, min);
> +               goto default_min_tck;
> +       }
> +
> +       return min;
> +
> +default_min_tck:
> +       dev_warn(dev, "%s: using default min-tck values\n", __func__);

Here and later - you return NULL, not default values. Your driver -
consumer - also behaves like with error condition, not like with
default values. Print just that you cannot get timings, I guess.

Best regards,
Krzysztof
