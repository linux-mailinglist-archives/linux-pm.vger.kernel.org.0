Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26FF8BE864
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 00:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbfIYWlF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 18:41:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37785 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfIYWlF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 18:41:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id y5so415164pfo.4
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 15:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=DJZS+2hMW3BHIlvQqQIKWZQ/S9upQg+UWPkKnBDMHaY=;
        b=JB6Q2GHp1ZV70uEzjZQJ/AO6u5nX3s65TPoASr9MkSGdNQyIQ/0WXlmik2tJ5AF0bM
         zMM9MnNksBAQKlIfLF+LrCuJD6Np180fmKkkFjYu1a0RkLWb43TTUkiy58OdSa2U8Z6W
         004LqA6M4DeOJJ+E9vS5afyjUOvm3f7jguC0WgTHJmFwEY62dRZA0QxfucOwWX0eBwPu
         XcMr5uC3GssTrfeE58sdRAc6IJPOVyA+4uWwIAaBRc+d+SAXlrZMRyh9LoNQRZKONnfy
         4sq8BoEiSm4ra4nbgK+mdgZO9QiPd+30urNbhkelZ7Hy3CWDvi9HiEsSu1A2znaLjAGX
         3T/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DJZS+2hMW3BHIlvQqQIKWZQ/S9upQg+UWPkKnBDMHaY=;
        b=gD0sVgmK+hP7w/ISJtCRDKbmYFrYtJeYB1hQSyYVEoiiPSnZzVXOCECSa+yZTBZal0
         53lLZgwiQuPbWCTMl2hJlfLFXK0Tf3/7914ZgnEToJq7UVGAtv9VXs64OEUDjvx4Wa/U
         kgtB9gR6sCGA7o7Pv2aQSCHo904bmSO67CNd2GqENWvl+oLgBuZJ0Aq5D6oTNt8BKphV
         e/ZIM3tuizCLzEZVWeax7iKFdeosckQL/NIOd1x6X4iisZqffncoTwrfk7IaNrS3sEgY
         P2uaq2pKqFes+AK5np++jNOPnnraRAFKI2Q7d/evDp5eyT7wsljX3fA0KIpDc6/QbpuJ
         GxTg==
X-Gm-Message-State: APjAAAWyy6tnBT38g+Gms3gYfwIIXUXQdmvXGbiFFK+vCnagKF0Cvz7z
        R8BA0fTT/U2jCT9hZ+loYYJu8w==
X-Google-Smtp-Source: APXvYqxyMgJ5m1Xh8eUiGWUqSpHwcA3KjJXudlODQh+BYXuGy9MiW1RYEL7P75vrRNRYeQpn2BJWFg==
X-Received: by 2002:a17:90a:fc8c:: with SMTP id ci12mr86276pjb.38.1569451263240;
        Wed, 25 Sep 2019 15:41:03 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id e21sm53200pfd.149.2019.09.25.15.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Sep 2019 15:41:02 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Zhiqiang Liang <zhiqiang.liang@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH 2/3] soc: amlogic: Add support for Secure power domains controller
In-Reply-To: <1568895064-4116-3-git-send-email-jianxin.pan@amlogic.com>
References: <1568895064-4116-1-git-send-email-jianxin.pan@amlogic.com> <1568895064-4116-3-git-send-email-jianxin.pan@amlogic.com>
Date:   Wed, 25 Sep 2019 15:41:01 -0700
Message-ID: <7hh850t2wy.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Jianxin,

Jianxin Pan <jianxin.pan@amlogic.com> writes:

> Add support for the Amlogic Secure Power controller. In A1/C1 series, power
> control registers are in secure domain, and should be accessed by smc.
>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> Signed-off-by: Zhiqiang Liang <zhiqiang.liang@amlogic.com>

Thanks for the new power domain driver.

> ---
>  drivers/soc/amlogic/Kconfig             |  13 +++
>  drivers/soc/amlogic/Makefile            |   1 +
>  drivers/soc/amlogic/meson-secure-pwrc.c | 182 ++++++++++++++++++++++++++++++++
>  3 files changed, 196 insertions(+)
>  create mode 100644 drivers/soc/amlogic/meson-secure-pwrc.c
>
> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
> index bc2c912..6cb06e7 100644
> --- a/drivers/soc/amlogic/Kconfig
> +++ b/drivers/soc/amlogic/Kconfig
> @@ -48,6 +48,19 @@ config MESON_EE_PM_DOMAINS
>  	  Say yes to expose Amlogic Meson Everything-Else Power Domains as
>  	  Generic Power Domains.
>  
> +config MESON_SECURE_PM_DOMAINS
> +	bool "Amlogic Meson Secure Power Domains driver"
> +	depends on ARCH_MESON || COMPILE_TEST
> +	depends on PM && OF
> +	depends on HAVE_ARM_SMCCC
> +	default ARCH_MESON
> +	select PM_GENERIC_DOMAINS
> +	select PM_GENERIC_DOMAINS_OF
> +	help
> +	  Support for the power controller on Amlogic A1/C1 series.
> +	  Say yes to expose Amlogic Meson Secure Power Domains as Generic
> +	  Power Domains.
> +
>  config MESON_MX_SOCINFO
>  	bool "Amlogic Meson MX SoC Information driver"
>  	depends on ARCH_MESON || COMPILE_TEST
> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
> index de79d044..7b8c5d3 100644
> --- a/drivers/soc/amlogic/Makefile
> +++ b/drivers/soc/amlogic/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
>  obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
> +obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
> diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
> new file mode 100644
> index 00000000..00c7232
> --- /dev/null
> +++ b/drivers/soc/amlogic/meson-secure-pwrc.c
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Amlogic, Inc.
> + * Author: Jianxin Pan <jianxin.pan@amlogic.com>
> + */
> +#include <linux/io.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <dt-bindings/power/meson-a1-power.h>
> +#include <linux/arm-smccc.h>
> +
> +#define PWRC_ON		1
> +#define PWRC_OFF	0
> +#define SMC_PWRC_SET	0x82000093
> +#define SMC_PWRC_GET	0x82000095
> +
> +struct meson_secure_pwrc_domain {
> +	struct generic_pm_domain base;
> +	unsigned int index;
> +};
> +
> +struct meson_secure_pwrc {
> +	struct meson_secure_pwrc_domain *domains;
> +	struct genpd_onecell_data xlate;
> +};
> +
> +struct meson_secure_pwrc_domain_desc {
> +	unsigned int index;
> +	unsigned int flags;
> +	char *name;
> +	bool (*get_power)(struct meson_secure_pwrc_domain *pwrc_domain);
> +};
> +
> +struct meson_secure_pwrc_domain_data {
> +	unsigned int count;
> +	struct meson_secure_pwrc_domain_desc *domains;
> +};
> +
> +static bool pwrc_secure_get_power(struct meson_secure_pwrc_domain *pwrc_domain)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(SMC_PWRC_GET, pwrc_domain->index, 0,
> +		      0, 0, 0, 0, 0, &res);
> +
> +	return res.a0 & 0x1;

Please use a #define with a readable name for this mask.

> +}

What does the return value for this function mean?  Does true mean
"powered off" or "powered on"?

See the rename I just did on the ee-pwrc driver:
https://lore.kernel.org/linux-amlogic/20190925213528.21515-2-khilman@kernel.org/

> +static int meson_secure_pwrc_off(struct generic_pm_domain *domain)
> +{
> +	struct arm_smccc_res res;
> +	struct meson_secure_pwrc_domain *pwrc_domain =
> +		container_of(domain, struct meson_secure_pwrc_domain, base);
> +
> +	arm_smccc_smc(SMC_PWRC_SET, pwrc_domain->index, PWRC_OFF,
> +		      0, 0, 0, 0, 0, &res);
> +
> +	return 0;
> +}
> +
> +static int meson_secure_pwrc_on(struct generic_pm_domain *domain)
> +{
> +	struct arm_smccc_res res;
> +	struct meson_secure_pwrc_domain *pwrc_domain =
> +		container_of(domain, struct meson_secure_pwrc_domain, base);
> +
> +	arm_smccc_smc(SMC_PWRC_SET, pwrc_domain->index, PWRC_ON,
> +		      0, 0, 0, 0, 0, &res);
> +
> +	return 0;
> +}
> +
> +#define SEC_PD(__name, __flag)			\
> +{						\
> +	.name = #__name,			\
> +	.index = PWRC_##__name##_ID,		\
> +	.get_power = pwrc_secure_get_power,	\
> +	.flags = __flag,			\
> +}
> +
> +static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
> +	SEC_PD(DSPA,	0),
> +	SEC_PD(DSPB,	0),
> +	SEC_PD(UART,	GENPD_FLAG_ALWAYS_ON),

This flag should only be used for domains where there are no linux
drivers.

Rather than using this flag, you need to add a 'power-domain' property
to the uart driver in DT, and then update the meson_uart driver to use
the runtime PM API so that the domain is enabled whenever the UART is in
use.

> +	SEC_PD(DMC,	GENPD_FLAG_ALWAYS_ON),

Please explain the need for ALWAYS_ON.

> +	SEC_PD(I2C,	0),
> +	SEC_PD(PSRAM,	0),
> +	SEC_PD(ACODEC,	0),
> +	SEC_PD(AUDIO,	0),
> +	SEC_PD(OTP,	0),
> +	SEC_PD(DMA,	0),
> +	SEC_PD(SD_EMMC,	0),
> +	SEC_PD(RAMA,	0),
> +	SEC_PD(RAMB,	GENPD_FLAG_ALWAYS_ON),

Please explain the need for ALWAYS_ON.

> +	SEC_PD(IR,	0),
> +	SEC_PD(SPICC,	0),
> +	SEC_PD(SPIFC,	0),
> +	SEC_PD(USB,	0),
> +	SEC_PD(NIC,	GENPD_FLAG_ALWAYS_ON),

Please explain the need for ALWAYS_ON.

> +	SEC_PD(PDMIN,	0),
> +	SEC_PD(RSA,	0),
> +};
> +
> +static int meson_secure_pwrc_probe(struct platform_device *pdev)
> +{
> +	const struct meson_secure_pwrc_domain_data *match;
> +	struct meson_secure_pwrc *pwrc;
> +	int i;
> +
> +	match = of_device_get_match_data(&pdev->dev);
> +	if (!match) {
> +		dev_err(&pdev->dev, "failed to get match data\n");
> +		return -ENODEV;
> +	}
> +
> +	pwrc = devm_kzalloc(&pdev->dev, sizeof(*pwrc), GFP_KERNEL);
> +	if (!pwrc)
> +		return -ENOMEM;
> +
> +	pwrc->xlate.domains = devm_kcalloc(&pdev->dev, match->count,
> +					   sizeof(*pwrc->xlate.domains),
> +					   GFP_KERNEL);
> +	if (!pwrc->xlate.domains)
> +		return -ENOMEM;
> +
> +	pwrc->domains = devm_kcalloc(&pdev->dev, match->count,
> +				     sizeof(*pwrc->domains), GFP_KERNEL);
> +	if (!pwrc->domains)
> +		return -ENOMEM;
> +
> +	pwrc->xlate.num_domains = match->count;
> +	platform_set_drvdata(pdev, pwrc);
> +
> +	for (i = 0 ; i < match->count ; ++i) {
> +		struct meson_secure_pwrc_domain *dom = &pwrc->domains[i];
> +
> +		if (!match->domains[i].index)
> +			continue;
> +
> +		dom->index = match->domains[i].index;
> +		dom->base.name = match->domains[i].name;
> +		dom->base.flags = match->domains[i].flags;
> +		dom->base.power_on = meson_secure_pwrc_on;
> +		dom->base.power_off = meson_secure_pwrc_off;
> +
> +		pm_genpd_init(&dom->base, NULL,
> +			      (match->domains[i].get_power ?
> +			      match->domains[i].get_power(dom) : true));
> +
> +		pwrc->xlate.domains[i] = &dom->base;
> +	}
> +
> +	return of_genpd_add_provider_onecell(pdev->dev.of_node, &pwrc->xlate);
> +}
> +
> +static struct meson_secure_pwrc_domain_data meson_secure_a1_pwrc_data = {
> +	.domains = a1_pwrc_domains,
> +	.count = ARRAY_SIZE(a1_pwrc_domains),
> +};
> +
> +static const struct of_device_id meson_secure_pwrc_match_table[] = {
> +	{
> +		.compatible = "amlogic,meson-a1-pwrc",
> +		.data = &meson_secure_a1_pwrc_data,
> +	},
> +	{ }

as mentioned by Martin, please add the sentinel string here.  Helps for
readability.

> +};
> +
> +static struct platform_driver meson_secure_pwrc_driver = {
> +	.probe = meson_secure_pwrc_probe,
> +	.driver = {
> +		.name		= "meson_secure_pwrc",
> +		.of_match_table	= meson_secure_pwrc_match_table,
> +	},
> +};
> +
> +static int meson_secure_pwrc_init(void)
> +{
> +	return platform_driver_register(&meson_secure_pwrc_driver);
> +}
> +arch_initcall_sync(meson_secure_pwrc_init);

Please use builtin_platform_driver() or explain in detail why the
initcall is needed.

Thanks,

Kevin
