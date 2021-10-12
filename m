Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF06242A0E4
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 11:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbhJLJVT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 05:21:19 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:41692
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235462AbhJLJVT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 05:21:19 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DC94A40018
        for <linux-pm@vger.kernel.org>; Tue, 12 Oct 2021 09:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634030356;
        bh=r5y5/vVnc4K5UB1TBSz+7rG5tu9PmtPkhFbjFAsJwpg=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=cwImSNq/tDdvmlpRvEiglE/iHCoz4pjnemv5hXDztHO6Orvx+iBICiIFk/FqJNLtX
         cWLuZwG2bZbrNnBBTR7QFNheDDF72P0kbPxKGsPasrmBo3luZADAmViL18Q4XXqtdD
         U3a0SqR22Rt+RHXVBL6GSSPaJsPI+mwtNZGFvmk647ygramO1644z7AgEIJmRWNGGE
         iuprmq3QPRX+ixOi3lRMWIKbELbAAOiQRTo6QQFN0BIh4BbcNhIOCo0d3b4RogKI/C
         wxlhZBQd2vthfLqoHtGCY7ziPApxBNunQ7cVZGhE4xGa/BqzH5smAuRVz3g6D8pegD
         VnaUYAMiiC+kQ==
Received: by mail-lf1-f72.google.com with SMTP id c6-20020a05651200c600b003fc6d39efa4so14709769lfp.12
        for <linux-pm@vger.kernel.org>; Tue, 12 Oct 2021 02:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r5y5/vVnc4K5UB1TBSz+7rG5tu9PmtPkhFbjFAsJwpg=;
        b=JTQ2uPLW7DvFoRIOxtSo0gPCvlxDim158xDMmesa/Ra3oRw8CgInvp3gw58DJq+9GV
         6eunmwYA+6Pa8DbZfNnFAihb4vLjbM1NShvPsBspMrt1rUnGr+dHTfK85EioAX18+m0J
         KdmWuaMlhxoMKDUSF8MZCnmC1llq9IUeOJoMM6qag+ahvm+3dlZUiVrfV98xuEtzGnaV
         4cpyh1piaglavsVGjoOpVE0vO2/y/mLJiXrQYdPDiaq+AQwWlcw1Uukgl/I1rA31nj+T
         CrQFhkoXex6y4WmMfK8QXlZBSU7kyCvK7x1dzK3bql/RNGXqY0AwEklKUJN10cCPU9Bs
         fEsg==
X-Gm-Message-State: AOAM531U31vZvdC9gET74BhjRzr4fcYzpLOC3agbULcNWE3GGzCZ8oku
        WFE9ZEEnAMZWPkz+qpOdMdNFJa4BzPN0jujEgUBOcLEr19qCdorHjLW1CBqsnYBQivs3TEj03Il
        Rn0JUZ9BcbI4CLyaPe9mRS3cmqNPjV0a1H0xv
X-Received: by 2002:ac2:4c48:: with SMTP id o8mr27115423lfk.286.1634030356154;
        Tue, 12 Oct 2021 02:19:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzq4pSLuFbcE7Kzfui9ayq9HU6yRKFDzy2Lesl+hVFgdjVy7SmfrAycDlAL4d25TBxgXwLBng==
X-Received: by 2002:ac2:4c48:: with SMTP id o8mr27115394lfk.286.1634030355941;
        Tue, 12 Oct 2021 02:19:15 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s3sm567364lfs.175.2021.10.12.02.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 02:19:15 -0700 (PDT)
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211011165707.138157-1-marcan@marcan.st>
 <20211011165707.138157-7-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [RFC PATCH 6/9] memory: apple: Add apple-mcc driver to manage MCC
 perf in Apple SoCs
Message-ID: <a9f6898d-bd76-b94e-52fc-98e9da1a04bd@canonical.com>
Date:   Tue, 12 Oct 2021 11:19:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011165707.138157-7-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/10/2021 18:57, Hector Martin wrote:
> This driver binds to the memory controller hardware in Apple SoCs such
> as the Apple M1, and provides a power domain that downstream devices can
> use to change the performance state of the memory controller.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/memory/Kconfig     |   9 +++
>  drivers/memory/Makefile    |   1 +
>  drivers/memory/apple-mcc.c | 130 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 140 insertions(+)
>  create mode 100644 drivers/memory/apple-mcc.c
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 72c0df129d5c..48ef3d563a1c 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -30,6 +30,15 @@ config ARM_PL172_MPMC
>  	  If you have an embedded system with an AMBA bus and a PL172
>  	  controller, say Y or M here.
>  
> +config APPLE_MCC
> +	tristate "Apple SoC MCC driver"
> +	default y if ARCH_APPLE
> +	select PM_GENERIC_DOMAINS
> +	depends on ARCH_APPLE || COMPILE_TEST
> +	help
> +	  This driver manages performance tuning for the memory controller in
> +	  Apple SoCs, such as the Apple M1.
> +
>  config ATMEL_SDRAMC
>  	bool "Atmel (Multi-port DDR-)SDRAM Controller"
>  	default y if ARCH_AT91
> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index bc7663ed1c25..947840cbd2d4 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -8,6 +8,7 @@ ifeq ($(CONFIG_DDR),y)
>  obj-$(CONFIG_OF)		+= of_memory.o
>  endif
>  obj-$(CONFIG_ARM_PL172_MPMC)	+= pl172.o
> +obj-$(CONFIG_APPLE_MCC)		+= apple-mcc.o
>  obj-$(CONFIG_ATMEL_SDRAMC)	+= atmel-sdramc.o
>  obj-$(CONFIG_ATMEL_EBI)		+= atmel-ebi.o
>  obj-$(CONFIG_BRCMSTB_DPFE)	+= brcmstb_dpfe.o
> diff --git a/drivers/memory/apple-mcc.c b/drivers/memory/apple-mcc.c
> new file mode 100644
> index 000000000000..55959f034b9a
> --- /dev/null
> +++ b/drivers/memory/apple-mcc.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Apple SoC MCC memory controller performance control driver
> + *
> + * Copyright The Asahi Linux Contributors

Copyright date?

> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_opp.h>
> +
> +#define APPLE_MCC_PERF_CONFIG1  0xdc4
> +#define APPLE_MCC_PERF_CONFIG2  0xdbc
> +#define APPLE_MCC_CHANNEL(x)	((x) * 0x40000)
> +
> +struct apple_mcc {
> +	struct device *dev;
> +	struct generic_pm_domain genpd;
> +	void __iomem *reg_base;
> +	u32 num_channels;
> +};
> +
> +#define to_apple_mcc(_genpd) container_of(_genpd, struct apple_mcc, genpd)
> +
> +static int apple_mcc_set_performance_state(struct generic_pm_domain *genpd, unsigned int state)
> +{
> +	struct apple_mcc *mcc = to_apple_mcc(genpd);
> +	struct dev_pm_opp *opp;
> +	struct device_node *np;
> +	u32 perf_config[2];
> +	unsigned int i;
> +
> +	dev_dbg(mcc->dev, "switching to perf state %d\n", state);
> +
> +	opp = dev_pm_opp_find_level_exact(&mcc->genpd.dev, state);
> +	if (IS_ERR(opp))
> +		return PTR_ERR(opp);
> +
> +	np = dev_pm_opp_get_of_node(opp);
> +	if (of_property_read_u32_array(np, "apple,memory-perf-config",
> +		perf_config, ARRAY_SIZE(perf_config))) {
> +		dev_err(mcc->dev, "missing apple,memory-perf-config property");
> +		of_node_put(np);
> +		return -EINVAL;
> +	}
> +	of_node_put(np);
> +
> +	for (i = 0; i < mcc->num_channels; i++) {
> +		writel_relaxed(perf_config[0],
> +			       mcc->reg_base + APPLE_MCC_CHANNEL(i) + APPLE_MCC_PERF_CONFIG1);
> +		writel_relaxed(perf_config[1],
> +			       mcc->reg_base + APPLE_MCC_CHANNEL(i) + APPLE_MCC_PERF_CONFIG2);
> +	}
> +
> +	return 0;
> +}
> +
> +static unsigned int apple_mcc_opp_to_performance_state(struct generic_pm_domain *genpd,
> +						       struct dev_pm_opp *opp)
> +{
> +	return dev_pm_opp_get_level(opp);
> +}
> +
> +static int apple_mcc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;

By convention mostly we call the variable "np".

> +	struct apple_mcc *mcc;
> +	int ret;
> +
> +	mcc = devm_kzalloc(dev, sizeof(*mcc), GFP_KERNEL);
> +	if (!mcc)
> +		return -ENOMEM;
> +
> +	mcc->reg_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(mcc->reg_base))
> +		return PTR_ERR(mcc->reg_base);
> +
> +	if (of_property_read_u32(node, "apple,num-channels", &mcc->num_channels)) {

Don't you have a limit of supported channels? It cannot be any uint32...

> +		dev_err(dev, "missing apple,num-channels property\n");

Use almost everywhere dev_err_probe - less code and you get error msg
printed.

> +		return -ENOENT;
> +	}
> +
> +	mcc->dev = dev;
> +	mcc->genpd.name = "apple-mcc-perf";
> +	mcc->genpd.opp_to_performance_state = apple_mcc_opp_to_performance_state;
> +	mcc->genpd.set_performance_state = apple_mcc_set_performance_state;
> +
> +	ret = pm_genpd_init(&mcc->genpd, NULL, false);
> +	if (ret < 0) {
> +		dev_err(dev, "pm_genpd_init failed\n");
> +		return ret;
> +	}
> +
> +	ret = of_genpd_add_provider_simple_noclk(node, &mcc->genpd);
> +	if (ret < 0) {
> +		dev_err(dev, "of_genpd_add_provider_simple failed\n");
> +		return ret;
> +	}
> +
> +	dev_info(dev, "Apple MCC performance driver initialized\n");

Please skip it, or at least make it a dev_dbg, you don't print any
valuable information here.

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id apple_mcc_of_match[] = {
> +	{ .compatible = "apple,mcc" },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, apple_mcc_of_match);
> +
> +static struct platform_driver apple_mcc_driver = {
> +	.probe = apple_mcc_probe,
> +	.driver = {
> +		.name = "apple-mcc",
> +		.of_match_table = apple_mcc_of_match,
> +	},
> +};

module_platform_driver() goes here.

> +
> +MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
> +MODULE_DESCRIPTION("MCC memory controller performance tuning driver for Apple SoCs");
> +MODULE_LICENSE("GPL v2");

I think this will be "Dual MIT/GPL", based on your SPDX.

> +
> +module_platform_driver(apple_mcc_driver);
> 


Best regards,
Krzysztof
