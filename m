Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8921FA8E3
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 08:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgFPGlE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 02:41:04 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:33968 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgFPGkx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 02:40:53 -0400
Received: by mail-ej1-f65.google.com with SMTP id l27so20287661ejc.1;
        Mon, 15 Jun 2020 23:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u/4vSmgu7zEV2+P6cSXb2jtDV9rXudULQyS/T/uSyR0=;
        b=BjkNSStokEAG0CgLgq9m+V0Dhk4o8NkiZ4R0SAUeTl2XTpQj1/fq5TCNFEbvq1xK0K
         oVkK9SRp0Gc9x8B10wW+WrxO4+8VFytrzDfIW9AxoWIMeftQeNEpoi9PLRS0oquHZAGD
         Qi7lzI0E3lbxW5DqHEaly1GsdVKzCmRUHOq3vCg6fLPZgNv7P3cqfX9EIdJXUdcW1bqh
         15LDphiV4MiUEP52in3T2wfYRKbAOjT9uHkwE9klZ5hy1sRJPRO+d4fkiHlNCsBUqjtl
         He5na++5ZKJgruSANEyotak72+U7Ci1RhHnrKCHhQUJ708GSV1GybQLSxqga+Kw3qZpb
         /Y4g==
X-Gm-Message-State: AOAM533hQr67Wjm7SHzpYtwYPr/JM7Ax29Vyyc3/X32qhYVlf+sxzAkO
        mREpSwRJAqSAW2/RYxMSvMw=
X-Google-Smtp-Source: ABdhPJyCmClWqHNPMJfDb4skGVNDOJ+QQkzSNjCptWykPE4OLPUCsx17srNrPJPBh68cBEg0HVDKhg==
X-Received: by 2002:a17:906:fc06:: with SMTP id ov6mr1451644ejb.184.1592289648380;
        Mon, 15 Jun 2020 23:40:48 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id lw11sm10345527ejb.58.2020.06.15.23.40.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jun 2020 23:40:47 -0700 (PDT)
Date:   Tue, 16 Jun 2020 08:40:45 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v4] soc: samsung: Add simple voltage coupler for
 Exynos5800
Message-ID: <20200616064045.GA5246@kozik-lap>
References: <CGME20200615104323eucas1p2e86189786e06e69d4803769637cb4ec3@eucas1p2.samsung.com>
 <20200615104315.17200-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200615104315.17200-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 15, 2020 at 12:43:15PM +0200, Marek Szyprowski wrote:
> Add a simple custom voltage regulator coupler for Exynos5800 SoCs, which
> require coupling between "vdd_arm" and "vdd_int" regulators. This coupler
> ensures that the voltage values don't go below the bootloader-selected
> operation point during the boot process until a the clients sets their
> constraints. It is achieved by assuming minimal voltage value equal to
> the current value if no constraints are set. This also ensures proper
> voltage balancing if any of the client driver is missing.
> 
> The balancing code comes from the regulator/core.c with the additional
> logic for handling regulators without client constraints applied added.
> 
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> This patch is yet another attempt to fix the regulator coupling on
> Exynos5800/5422 SoCs. Here are links to the previous attempts and
> discussions:
> 
> https://lore.kernel.org/linux-samsung-soc/20191008101709.qVNy8eijBi0LynOteWFMnTg4GUwKG599n6OyYoX1Abs@z/
> https://lore.kernel.org/lkml/20191017102758.8104-1-m.szyprowski@samsung.com/
> https://lore.kernel.org/linux-pm/cover.1589528491.git.viresh.kumar@linaro.org/
> https://lore.kernel.org/linux-pm/20200528131130.17984-1-m.szyprowski@samsung.com/
> https://lore.kernel.org/linux-samsung-soc/57cf3a15-5d9b-7636-4c69-60742e8cfae6@samsung.com/
> https://lore.kernel.org/lkml/20200605063724.9030-1-m.szyprowski@samsung.com/
> 
> The problem is with "vdd_int" regulator coupled with "vdd_arm" on Odroid
> XU3/XU4 boards family. "vdd_arm" is handled by CPUfreq. "vdd_int" is
> handled by devfreq. CPUfreq initialized quite early during boot and it
> starts changing OPPs and "vdd_arm" value. Sometimes CPU activity during
> boot goes down and some low-frequency OPPs are selected, what in turn
> causes lowering "vdd_arm". This happens before devfreq applies its
> requirements on "vdd_int". Regulator balancing code reduces "vdd_arm"
> voltage value, what in turn causes lowering "vdd_int" value to the lowest
> possible value. This is much below the operation point of the wcore bus,
> which still runs at the highest frequency.
> 
> The issue was hard to notice because in the most cases the board managed
> to boot properly, even when the regulator was set to lowest value allowed
> by the regulator constraints. However, it caused some random issues,
> which can be observed as "Unhandled prefetch abort" or low USB stability.
> 
> Handling this case in the generic code has been rejected, so the only way
> to ensure the desired behavior on Exynos5800-based SoCs is to make a
> custom regulator coupler driver. I've tried hard to extract some common
> code to simplify the exynos-regulator-coupler driver as much as possible,
> but the difference between it and the generic code is so deep that this
> approach failed, so indead I simply copied and modified the balancing
> code.
> 
> Best regards
> Marek Szyprowski
> ---
>  arch/arm/mach-exynos/Kconfig                  |   1 +
>  drivers/soc/samsung/Kconfig                   |   3 +
>  drivers/soc/samsung/Makefile                  |   1 +
>  .../soc/samsung/exynos-regulator-coupler.c    | 221 ++++++++++++++++++
>  4 files changed, 226 insertions(+)
>  create mode 100644 drivers/soc/samsung/exynos-regulator-coupler.c
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 76838255b5fa..f185cd3d4c62 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -118,6 +118,7 @@ config SOC_EXYNOS5800
>  	bool "Samsung EXYNOS5800"
>  	default y
>  	depends on SOC_EXYNOS5420
> +	select EXYNOS_REGULATOR_COUPLER
>  
>  config EXYNOS_MCPM
>  	bool
> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> index 19c4d3f1437b..5d7819b52eed 100644
> --- a/drivers/soc/samsung/Kconfig
> +++ b/drivers/soc/samsung/Kconfig
> @@ -43,4 +43,7 @@ config EXYNOS_PM_DOMAINS
>  	bool "Exynos PM domains" if COMPILE_TEST
>  	depends on PM_GENERIC_DOMAINS || COMPILE_TEST
>  
> +config EXYNOS_REGULATOR_COUPLER
> +	bool "Exynos SoC Regulator Coupler" if COMPILE_TEST
> +	depends on ARCH_EXYNOS || COMPILE_TEST
>  endif
> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> index 31db65cb7aa3..93285faec416 100644
> --- a/drivers/soc/samsung/Makefile
> +++ b/drivers/soc/samsung/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
>  					exynos5250-pmu.o exynos5420-pmu.o
>  obj-$(CONFIG_EXYNOS_PMU_ARM64_DRIVERS)	+= exynos-pm.o exynos5433-pmu.o

You based this patch on some different tree. Does not apply.

Best regards,
Krzysztof

>  obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
> +obj-$(CONFIG_EXYNOS_REGULATOR_COUPLER) += exynos-regulator-coupler.o


