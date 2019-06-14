Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8ED045D1D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 14:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfFNMoH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 08:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfFNMoH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Jun 2019 08:44:07 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D6E621744;
        Fri, 14 Jun 2019 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560516245;
        bh=HS28RNy+S6sp0Hoy4qNpEXF9makghMXDyaBdeIIS6ms=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k6t5ryuP18viGWC8DiMBMqN21FdCvQ0zsWQZOA5M1+5IbDeX4leDc96etrJUjKYt7
         r7ZqhRg0tOESGR30BS0FTwy2QTXFommvopNUZc+m0Zmj4EGnc5imYoW5poHFOUsHXk
         nXKuJY2fyL/6rqG5T0UqX/a+jhlixrBb1LdnZj9Y=
Received: by mail-lj1-f177.google.com with SMTP id k18so2227268ljc.11;
        Fri, 14 Jun 2019 05:44:05 -0700 (PDT)
X-Gm-Message-State: APjAAAXwKHncBO9RXm2TWPuPcJlyPUylrJymNTce6Y/CW3PkRHKwxW1N
        5meyX+FAjXE3vV9IGJg0xKCy7v3EUFRX/XRWMEk=
X-Google-Smtp-Source: APXvYqxz7zbhWEnI3AEDaxlmSYav0zCw8TVKKD95nT3ZafzGPyXWZ+upq4xQbINj8skrcrAA5+9GMVfJZDGAFhaWj+0=
X-Received: by 2002:a2e:9e4d:: with SMTP id g13mr44769356ljk.80.1560516243323;
 Fri, 14 Jun 2019 05:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190614095325eucas1p20083d9290b36eca945ec3f1428bdbd4f@eucas1p2.samsung.com>
 <20190614095309.24100-1-l.luba@partner.samsung.com> <20190614095309.24100-7-l.luba@partner.samsung.com>
In-Reply-To: <20190614095309.24100-7-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 14 Jun 2019 14:43:52 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcDDyYmuX-RpkpxKSBK2JfV=tYakn+g8FM5Lau+rmkm+g@mail.gmail.com>
Message-ID: <CAJKOXPcDDyYmuX-RpkpxKSBK2JfV=tYakn+g8FM5Lau+rmkm+g@mail.gmail.com>
Subject: Re: [PATCH v10 06/13] drivers: memory: extend of_memory by LPDDR3 support
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        gregkh@linuxfoundation.org, Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 14 Jun 2019 at 11:53, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> The patch adds AC timings information needed to support LPDDR3 and memory
> controllers. The structure is used in of_memory and currently in Exynos
> 5422 DMC. Add parsing data needed for LPDDR3 support.
> It is currently used in Exynos5422 Dynamic Memory Controller.
>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/memory/of_memory.c | 154 +++++++++++++++++++++++++++++++++++++
>  drivers/memory/of_memory.h |  18 +++++
>  include/memory/jedec_ddr.h |  62 +++++++++++++++
>  3 files changed, 234 insertions(+)

Previously this was going through Greg, so if I am going to take it
along with drivers/memory/samsung patches, I need some acks.

Greg, Rob,
Are you okay with this patch and with taking it through samsung-soc?

Best regards,
Krzysztof
> diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
> index 12a61f558644..30f3a3e75063 100644
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
> @@ -148,3 +154,151 @@ const struct lpddr2_timings *of_get_ddr_timings(struct device_node *np_ddr,
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
> +       return NULL;
> +}
> +EXPORT_SYMBOL(of_lpddr3_get_min_tck);
> +
> +static int of_lpddr3_do_get_timings(struct device_node *np,
> +                                   struct lpddr3_timings *tim)
> +{
> +       int ret;
> +
> +       /* The 'reg' param required since DT has changed, used as 'max-freq' */
> +       ret = of_property_read_u32(np, "reg", &tim->max_freq);
> +       ret |= of_property_read_u32(np, "min-freq", &tim->min_freq);
> +       ret |= of_property_read_u32(np, "tRFC", &tim->tRFC);
> +       ret |= of_property_read_u32(np, "tRRD", &tim->tRRD);
> +       ret |= of_property_read_u32(np, "tRPab", &tim->tRPab);
> +       ret |= of_property_read_u32(np, "tRPpb", &tim->tRPpb);
> +       ret |= of_property_read_u32(np, "tRCD", &tim->tRCD);
> +       ret |= of_property_read_u32(np, "tRC", &tim->tRC);
> +       ret |= of_property_read_u32(np, "tRAS", &tim->tRAS);
> +       ret |= of_property_read_u32(np, "tWTR", &tim->tWTR);
> +       ret |= of_property_read_u32(np, "tWR", &tim->tWR);
> +       ret |= of_property_read_u32(np, "tRTP", &tim->tRTP);
> +       ret |= of_property_read_u32(np, "tW2W-C2C", &tim->tW2W_C2C);
> +       ret |= of_property_read_u32(np, "tR2R-C2C", &tim->tR2R_C2C);
> +       ret |= of_property_read_u32(np, "tFAW", &tim->tFAW);
> +       ret |= of_property_read_u32(np, "tXSR", &tim->tXSR);
> +       ret |= of_property_read_u32(np, "tXP", &tim->tXP);
> +       ret |= of_property_read_u32(np, "tCKE", &tim->tCKE);
> +       ret |= of_property_read_u32(np, "tCKESR", &tim->tCKESR);
> +       ret |= of_property_read_u32(np, "tMRD", &tim->tMRD);
> +
> +       return ret;
> +}
> +
> +/**
> + * of_lpddr3_get_ddr_timings() - extracts the lpddr3 timings and updates no of
> + * frequencies available.
> + * @np_ddr: Pointer to ddr device tree node
> + * @dev: Device requesting for ddr timings
> + * @device_type: Type of ddr
> + * @nr_frequencies: No of frequencies available for ddr
> + * (updated by this function)
> + *
> + * Populates lpddr3_timings structure by extracting data from device
> + * tree node. Returns pointer to populated structure. If any error
> + * while populating, returns NULL.
> + */
> +const struct lpddr3_timings
> +*of_lpddr3_get_ddr_timings(struct device_node *np_ddr, struct device *dev,
> +                          u32 device_type, u32 *nr_frequencies)
> +{
> +       struct lpddr3_timings   *timings = NULL;
> +       u32                     arr_sz = 0, i = 0;
> +       struct device_node      *np_tim;
> +       char                    *tim_compat = NULL;
> +
> +       switch (device_type) {
> +       case DDR_TYPE_LPDDR3:
> +               tim_compat = "jedec,lpddr3-timings";
> +               break;
> +       default:
> +               dev_warn(dev, "%s: un-supported memory type\n", __func__);
> +       }
> +
> +       for_each_child_of_node(np_ddr, np_tim)
> +               if (of_device_is_compatible(np_tim, tim_compat))
> +                       arr_sz++;
> +
> +       if (arr_sz)
> +               timings = devm_kcalloc(dev, arr_sz, sizeof(*timings),
> +                                      GFP_KERNEL);
> +
> +       if (!timings)
> +               goto default_timings;
> +
> +       for_each_child_of_node(np_ddr, np_tim) {
> +               if (of_device_is_compatible(np_tim, tim_compat)) {
> +                       if (of_lpddr3_do_get_timings(np_tim, &timings[i])) {
> +                               devm_kfree(dev, timings);
> +                               goto default_timings;
> +                       }
> +                       i++;
> +               }
> +       }
> +
> +       *nr_frequencies = arr_sz;
> +
> +       return timings;
> +
> +default_timings:
> +       dev_warn(dev, "%s: using default timings\n", __func__);
> +       *nr_frequencies = 0;
> +       return NULL;
> +}
> +EXPORT_SYMBOL(of_lpddr3_get_ddr_timings);
> diff --git a/drivers/memory/of_memory.h b/drivers/memory/of_memory.h
> index b077cc836b0b..e39ecc4c733d 100644
> --- a/drivers/memory/of_memory.h
> +++ b/drivers/memory/of_memory.h
> @@ -14,6 +14,11 @@ extern const struct lpddr2_min_tck *of_get_min_tck(struct device_node *np,
>  extern const struct lpddr2_timings
>         *of_get_ddr_timings(struct device_node *np_ddr, struct device *dev,
>         u32 device_type, u32 *nr_frequencies);
> +extern const struct lpddr3_min_tck
> +       *of_lpddr3_get_min_tck(struct device_node *np, struct device *dev);
> +extern const struct lpddr3_timings
> +       *of_lpddr3_get_ddr_timings(struct device_node *np_ddr,
> +       struct device *dev, u32 device_type, u32 *nr_frequencies);
>  #else
>  static inline const struct lpddr2_min_tck
>         *of_get_min_tck(struct device_node *np, struct device *dev)
> @@ -27,6 +32,19 @@ static inline const struct lpddr2_timings
>  {
>         return NULL;
>  }
> +
> +static inline const struct lpddr3_min_tck
> +       *of_lpddr3_get_min_tck(struct device_node *np, struct device *dev)
> +{
> +       return NULL;
> +}
> +
> +static inline const struct lpddr3_timings
> +       *of_lpddr3_get_ddr_timings(struct device_node *np_ddr,
> +       struct device *dev, u32 device_type, u32 *nr_frequencies)
> +{
> +       return NULL;
> +}
>  #endif /* CONFIG_OF && CONFIG_DDR */
>
>  #endif /* __LINUX_MEMORY_OF_REG_ */
> diff --git a/include/memory/jedec_ddr.h b/include/memory/jedec_ddr.h
> index ddad0f870e5d..3601825f807d 100644
> --- a/include/memory/jedec_ddr.h
> +++ b/include/memory/jedec_ddr.h
> @@ -32,6 +32,7 @@
>  #define DDR_TYPE_LPDDR2_S4     3
>  #define DDR_TYPE_LPDDR2_S2     4
>  #define DDR_TYPE_LPDDR2_NVM    5
> +#define DDR_TYPE_LPDDR3                6
>
>  /* DDR IO width */
>  #define DDR_IO_WIDTH_4         1
> @@ -172,4 +173,65 @@ extern const struct lpddr2_timings
>         lpddr2_jedec_timings[NUM_DDR_TIMING_TABLE_ENTRIES];
>  extern const struct lpddr2_min_tck lpddr2_jedec_min_tck;
>
> +
> +/*
> + * Structure for timings for LPDDR3 based on LPDDR2 plus additional fields.
> + * All parameters are in pico seconds(ps) unless explicitly indicated
> + * with a suffix like tRAS_max_ns below
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
>  #endif /* __LINUX_JEDEC_DDR_H */
> --
> 2.17.1
>
