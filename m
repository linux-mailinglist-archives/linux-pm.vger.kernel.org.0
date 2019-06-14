Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCFAF45D43
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 14:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfFNM7K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 08:59:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbfFNM7K (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Jun 2019 08:59:10 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F629217D7;
        Fri, 14 Jun 2019 12:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560517148;
        bh=d5XKOHRlv9JZdac1o7rwUyg/Yr9lYppTOJuFXN+lS4s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QxTgsjt5ppQyUB47pRpIZqkG891XIXtlnRvxHcD9rgMTioeUc/N/j3eUlvT/ZkwDt
         uEfm3ZZqSEYsH99v+4sc9jY8rahLSQVh8S+9jkjjAZwCxKjCs0/xb414FLz3cuqI/b
         0+msLxD6tFOFtktEmJxcDJs17xDVP/M+kubU3PMc=
Received: by mail-lf1-f46.google.com with SMTP id u10so1648119lfm.12;
        Fri, 14 Jun 2019 05:59:08 -0700 (PDT)
X-Gm-Message-State: APjAAAW/Osq9z6M5D2ivv3aNtNgdcMihClVGMRZPuxbBaRCHYLU/ejg0
        jPtRR1p/nE1Js8Eh5FkUFOSLCNKZg79z2GHlrV0=
X-Google-Smtp-Source: APXvYqxvwcyD1geWDW+7ip6+JikZT/XjD7yYPtfcmB4v2ZBnUA35p45dCuJsJIJQESJjPfA/4kWIkvSmxx8WzRHb3rg=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr12738142lfc.60.1560517146467;
 Fri, 14 Jun 2019 05:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190614095327eucas1p19b6e522efa15c8fd21c51f3900e376e9@eucas1p1.samsung.com>
 <20190614095309.24100-1-l.luba@partner.samsung.com> <20190614095309.24100-9-l.luba@partner.samsung.com>
In-Reply-To: <20190614095309.24100-9-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 14 Jun 2019 14:58:55 +0200
X-Gmail-Original-Message-ID: <CAJKOXPehO2pKrTKMO4YRwDMaPPngmeWG9WF=kMuBG+=P1ix3NA@mail.gmail.com>
Message-ID: <CAJKOXPehO2pKrTKMO4YRwDMaPPngmeWG9WF=kMuBG+=P1ix3NA@mail.gmail.com>
Subject: Re: [PATCH v10 08/13] drivers: memory: add DMC driver for Exynos5422
To:     Lukasz Luba <l.luba@partner.samsung.com>
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
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 14 Jun 2019 at 11:53, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> This patch adds driver for Exynos5422 Dynamic Memory Controller.
> The driver provides support for dynamic frequency and voltage scaling for
> DMC and DRAM. It supports changing timings of DRAM running with different
> frequency. There is also an algorithm to calculate timigns based on
> memory description provided in DT.
> The patch also contains needed MAINTAINERS file update.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  MAINTAINERS                             |    8 +
>  drivers/memory/samsung/Kconfig          |   17 +
>  drivers/memory/samsung/Makefile         |    1 +
>  drivers/memory/samsung/exynos5422-dmc.c | 1262 +++++++++++++++++++++++
>  4 files changed, 1288 insertions(+)
>  create mode 100644 drivers/memory/samsung/exynos5422-dmc.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57f496cff999..6ffccfd95351 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3470,6 +3470,14 @@ S:       Maintained
>  F:     drivers/devfreq/exynos-bus.c
>  F:     Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>
> +DMC FREQUENCY DRIVER FOR SAMSUNG EXYNOS5422

Eh, more comments from my side.
"For the hard of thinking, this list is meant to remain in alphabetical order."

> +M:     Lukasz Luba <l.luba@partner.samsung.com>
> +L:     linux-pm@vger.kernel.org
> +L:     linux-samsung-soc@vger.kernel.org
> +S:     Maintained
> +F:     drivers/memory/samsung/exynos5422-dmc.c
> +F:     Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> +
>  BUSLOGIC SCSI DRIVER
>  M:     Khalid Aziz <khalid@gonehiking.org>
>  L:     linux-scsi@vger.kernel.org
> diff --git a/drivers/memory/samsung/Kconfig b/drivers/memory/samsung/Kconfig
> index 79ce7ea58903..c93baa029654 100644
> --- a/drivers/memory/samsung/Kconfig
> +++ b/drivers/memory/samsung/Kconfig
> @@ -5,6 +5,23 @@ config SAMSUNG_MC
>           Support for the Memory Controller (MC) devices found on
>           Samsung Exynos SoCs.
>
> +config ARM_EXYNOS5422_DMC

Why you added prefix of ARM to CONFIG_? I think none of other Exynos
Kconfig options follow such convention (except devfreq).

> +       tristate "ARM EXYNOS5422 Dynamic Memory Controller driver"
> +       depends on ARCH_EXYNOS
> +       select DDR

In general select should be used only for non-visible symbols and DDR
is visible. Use depends.

> +       select PM_DEVFREQ

This definitely cannot be select. You do not select entire subsystem
because some similar driver was chosen.

> +       select DEVFREQ_GOV_SIMPLE_ONDEMAND
> +       select DEVFREQ_GOV_USERSPACE

I think only simple_ondemand is needed. Is userspace governor
necessary for working? Or actually maybe both could be skipped?

> +       select PM_DEVFREQ_EVENT

Again, depends.

> +       select PM_OPP
> +       help
> +         This adds driver for Exynos5422 DMC (Dynamic Memory Controller).
> +         The driver provides support for Dynamic Voltage and Frequency Scaling in
> +         DMC and DRAM. It also supports changing timings of DRAM running with
> +         different frequency. The timings are calculated based on DT memory
> +         information.
> +
> +
>  if SAMSUNG_MC

Why this is outside of SAMSUNG_MC?

Best regards,
Krzysztof
