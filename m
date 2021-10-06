Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF4F4238DB
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 09:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbhJFH37 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 03:29:59 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35468
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231465AbhJFH36 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 03:29:58 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ECBDD3FFE3
        for <linux-pm@vger.kernel.org>; Wed,  6 Oct 2021 07:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633505285;
        bh=VWtr+qJrwlMHknueyuRRcERaLM8hU3I6LcyF8dpt6aw=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=ptVtX4V306wokdkQXLNz2Mzk9Tq39AMf4X5CJSlZ22BATqBuaIponRO+jlHNzL7cP
         e2BLXpxHid81nS0lOOQiGX5N0tE/aYOXtCeZNBiBdDWk3HrkrdO6qjpreGISsuYZcp
         DuUJjgA28wDw7XSdha5t+Oy0Q0z+t6oL18xEBh37UHpdjO1MWl13pEdtf3i9pe544U
         qMooCeSd6a5FbI0nhHy8hEdZVuaZMgNUoOet9FV/ioAr710yqp52MPV/IdyZAKxfY2
         oUYfFMs/NQFkT/cSNJxECTayvujEvzPAv/5SXl1QF07qudSlNP778CuTyhon5IVmfM
         1XqWiyNeyb2vg==
Received: by mail-lf1-f72.google.com with SMTP id k7-20020ac257c7000000b003fd3ab38ddeso1314366lfo.0
        for <linux-pm@vger.kernel.org>; Wed, 06 Oct 2021 00:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VWtr+qJrwlMHknueyuRRcERaLM8hU3I6LcyF8dpt6aw=;
        b=fxmU0TpqRXGdAeYy3O+FVIG/qLRk2tr1qHy6Bkzl23t6Ndm1NhHxp4IT4KD9yZriTi
         jT+jFuLzpouAHUUEUoj6F5mN0SZ325I1ARCDhoot9sv1XPc/zfyomHAVlYe3L0u/sp1O
         ANX0EDyaz02p3cUUSKbMXifcJ/drkzeqgBvbE7rrw8ERfMwWLK0avx4xwAXRkLDH0HJn
         g/1oVyypdGvL1+h/GlmSiKfG3kcXXJZy3tDNuBK1n4cE5gL61WcQgp5txJjiWa1dtdRP
         vvF2TxnQ4fNtesuZRC8aYuYQQJRUusGj6ILd2LQCsWIK3VIQvTNiZheITvVQj66hll6F
         ICow==
X-Gm-Message-State: AOAM531W0bwVLvsv1b2TIJevEmkmaLLLR4VW56cJbTGfGJe4H2QAK1lV
        RHOyTkbFVjdkHdvWxaq7RX4cFlX9VkgFliG5oRNfIABfo2BvyGsKaz8PO0ZVqDpSEnMJqIofalk
        8ITL2nEdSYCGfjQDU8nlxMAjs16KWZxGMxU3c
X-Received: by 2002:ac2:5f92:: with SMTP id r18mr7892555lfe.445.1633505285108;
        Wed, 06 Oct 2021 00:28:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe/KJXnRUep0I8u9k0neV72dGFZ0ogxPxKg4nXPg6SAKIHTD864ghyBvf54qLgjceznCn/1A==
X-Received: by 2002:ac2:5f92:: with SMTP id r18mr7892525lfe.445.1633505284837;
        Wed, 06 Oct 2021 00:28:04 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j27sm593280lfp.261.2021.10.06.00.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 00:28:04 -0700 (PDT)
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-4-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 3/7] soc: apple: Add driver for Apple PMGR power state
 controls
Message-ID: <bee16b95-964c-f515-a196-cd267391d4eb@canonical.com>
Date:   Wed, 6 Oct 2021 09:28:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005155923.173399-4-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/10/2021 17:59, Hector Martin wrote:
> Implements genpd and reset providers for downstream devices. Each
> instance of the driver binds to a single register and represents a
> single SoC power domain.
> 
> The driver does not currently implement all features (auto-pm,
> clockgate-only state), but we declare the respective registers for
> documentation purposes. These features will be added as they become
> useful for downstream devices.
> 
> This also creates the apple/soc tree and Kconfig submenu.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  MAINTAINERS                             |   1 +
>  drivers/soc/Kconfig                     |   1 +
>  drivers/soc/Makefile                    |   1 +
>  drivers/soc/apple/Kconfig               |  21 ++
>  drivers/soc/apple/Makefile              |   2 +
>  drivers/soc/apple/apple-pmgr-pwrstate.c | 281 ++++++++++++++++++++++++
>  6 files changed, 307 insertions(+)
>  create mode 100644 drivers/soc/apple/Kconfig
>  create mode 100644 drivers/soc/apple/Makefile
>  create mode 100644 drivers/soc/apple/apple-pmgr-pwrstate.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5fe53d9a2956..def5e05da2bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1725,6 +1725,7 @@ F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
>  F:	Documentation/devicetree/bindings/power/apple*
>  F:	arch/arm64/boot/dts/apple/
>  F:	drivers/irqchip/irq-apple-aic.c
> +F:	drivers/soc/apple/*
>  F:	include/dt-bindings/interrupt-controller/apple-aic.h
>  F:	include/dt-bindings/pinctrl/apple.h
>  
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index e8a30c4c5aec..a8562678c437 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -3,6 +3,7 @@ menu "SOC (System On Chip) specific Drivers"
>  
>  source "drivers/soc/actions/Kconfig"
>  source "drivers/soc/amlogic/Kconfig"
> +source "drivers/soc/apple/Kconfig"
>  source "drivers/soc/aspeed/Kconfig"
>  source "drivers/soc/atmel/Kconfig"
>  source "drivers/soc/bcm/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index a05e9fbcd3e0..adb30c2d4fea 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -4,6 +4,7 @@
>  #
>  
>  obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
> +obj-$(CONFIG_ARCH_APPLE)	+= apple/
>  obj-y				+= aspeed/
>  obj-$(CONFIG_ARCH_AT91)		+= atmel/
>  obj-y				+= bcm/
> diff --git a/drivers/soc/apple/Kconfig b/drivers/soc/apple/Kconfig
> new file mode 100644
> index 000000000000..271092b6aee7
> --- /dev/null
> +++ b/drivers/soc/apple/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +if ARCH_APPLE || COMPILE_TEST
> +
> +menu "Apple SoC drivers"
> +
> +config APPLE_PMGR_PWRSTATE
> +	tristate "Apple SoC PMGR power state control"
> +	select REGMAP
> +	select MFD_SYSCON
> +	select PM_GENERIC_DOMAINS
> +	select RESET_CONTROLLER
> +	default ARCH_APPLE
> +	help
> +	  The PMGR block in Apple SoCs provides high-level power state
> +	  controls for SoC devices. This driver manages them through the
> +	  generic power domain framework, and also provides reset support.
> +
> +endmenu
> +
> +endif
> diff --git a/drivers/soc/apple/Makefile b/drivers/soc/apple/Makefile
> new file mode 100644
> index 000000000000..c114e84667e4
> --- /dev/null
> +++ b/drivers/soc/apple/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_APPLE_PMGR_PWRSTATE)	+= apple-pmgr-pwrstate.o
> diff --git a/drivers/soc/apple/apple-pmgr-pwrstate.c b/drivers/soc/apple/apple-pmgr-pwrstate.c
> new file mode 100644
> index 000000000000..a0338dbb29b8
> --- /dev/null
> +++ b/drivers/soc/apple/apple-pmgr-pwrstate.c
> @@ -0,0 +1,281 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Apple SoC PMGR device power state driver
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/reset-controller.h>
> +#include <linux/module.h>
> +
> +#define APPLE_PMGR_RESET        BIT(31)
> +#define APPLE_PMGR_AUTO_ENABLE  BIT(28)
> +#define APPLE_PMGR_PS_AUTO      GENMASK(27, 24)
> +#define APPLE_PMGR_PARENT_OFF   BIT(11)
> +#define APPLE_PMGR_DEV_DISABLE  BIT(10)
> +#define APPLE_PMGR_WAS_CLKGATED BIT(9)
> +#define APPLE_PMGR_WAS_PWRGATED BIT(8)
> +#define APPLE_PMGR_PS_ACTUAL    GENMASK(7, 4)
> +#define APPLE_PMGR_PS_TARGET    GENMASK(3, 0)
> +
> +#define APPLE_PMGR_PS_ACTIVE    0xf
> +#define APPLE_PMGR_PS_CLKGATE   0x4
> +#define APPLE_PMGR_PS_PWRGATE   0x0
> +
> +#define APPLE_PMGR_PS_SET_TIMEOUT 100
> +#define APPLE_PMGR_RESET_TIME 1
> +
> +struct apple_pmgr_ps {
> +	struct device *dev;
> +	struct generic_pm_domain genpd;
> +	struct reset_controller_dev rcdev;
> +	struct regmap *regmap;
> +	u32 offset;
> +};
> +
> +#define genpd_to_apple_pmgr_ps(_genpd) container_of(_genpd, struct apple_pmgr_ps, genpd)
> +#define rcdev_to_apple_pmgr_ps(_rcdev) container_of(_rcdev, struct apple_pmgr_ps, rcdev)
> +
> +static int apple_pmgr_ps_set(struct generic_pm_domain *genpd, u32 pstate)
> +{
> +	int ret;
> +	struct apple_pmgr_ps *ps = genpd_to_apple_pmgr_ps(genpd);
> +	u32 reg;
> +
> +	regmap_read(ps->regmap, ps->offset, &reg);

MMIO accesses should not fail, but regmap API could fail if for example
clk_enable() fails. In such case you will write below value based on
random stack init. Please check the return value here.

> +
> +	/* Resets are synchronous, and only work if the device is powered and clocked. */
> +	if (reg & APPLE_PMGR_RESET && pstate != APPLE_PMGR_PS_ACTIVE)
> +		dev_err(ps->dev, "PS 0x%x: powering off with RESET active\n", ps->offset);
> +
> +	reg &= ~(APPLE_PMGR_AUTO_ENABLE | APPLE_PMGR_WAS_CLKGATED | APPLE_PMGR_WAS_PWRGATED |
> +		 APPLE_PMGR_PS_TARGET);
> +	reg |= FIELD_PREP(APPLE_PMGR_PS_TARGET, pstate);
> +
> +	dev_dbg(ps->dev, "PS 0x%x: pwrstate = 0x%x: 0x%x\n", ps->offset, pstate, reg);
> +
> +	regmap_write(ps->regmap, ps->offset, reg);
> +
> +	ret = regmap_read_poll_timeout_atomic(
> +		ps->regmap, ps->offset, reg,
> +		(FIELD_GET(APPLE_PMGR_PS_ACTUAL, reg) == pstate), 1,
> +		APPLE_PMGR_PS_SET_TIMEOUT);
> +	if (ret < 0)
> +		dev_err(ps->dev, "PS 0x%x: Failed to reach power state 0x%x (now: 0x%x)\n",
> +			ps->offset, pstate, reg);
> +	return ret;
> +}
> +
> +static bool apple_pmgr_ps_is_active(struct apple_pmgr_ps *ps)
> +{
> +	u32 reg;
> +
> +	regmap_read(ps->regmap, ps->offset, &reg);

Check the return value or initialize reg to 0.

> +	return FIELD_GET(APPLE_PMGR_PS_ACTUAL, reg) == APPLE_PMGR_PS_ACTIVE;
> +}
> +
> +static int apple_pmgr_ps_power_on(struct generic_pm_domain *genpd)
> +{
> +	return apple_pmgr_ps_set(genpd, APPLE_PMGR_PS_ACTIVE);
> +}
> +
> +static int apple_pmgr_ps_power_off(struct generic_pm_domain *genpd)
> +{
> +	return apple_pmgr_ps_set(genpd, APPLE_PMGR_PS_PWRGATE);
> +}
> +
> +static int apple_pmgr_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct apple_pmgr_ps *ps = rcdev_to_apple_pmgr_ps(rcdev);
> +
> +	mutex_lock(&ps->genpd.mlock);
> +
> +	if (ps->genpd.status == GENPD_STATE_OFF)
> +		dev_err(ps->dev, "PS 0x%x: asserting RESET while powered down\n", ps->offset);
> +
> +	dev_dbg(ps->dev, "PS 0x%x: assert reset\n", ps->offset);
> +	/* Quiesce device before asserting reset */
> +	regmap_set_bits(ps->regmap, ps->offset, APPLE_PMGR_DEV_DISABLE);
> +	regmap_set_bits(ps->regmap, ps->offset, APPLE_PMGR_RESET);
> +
> +	mutex_unlock(&ps->genpd.mlock);
> +
> +	return 0;
> +}
> +
> +static int apple_pmgr_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct apple_pmgr_ps *ps = rcdev_to_apple_pmgr_ps(rcdev);
> +
> +	mutex_lock(&ps->genpd.mlock);

This looks wrong: it can be a spin-lock, not mutex, so you should use
genpd_lock.

However now I wonder if there could be a case when a reset-controller
consumer calls it from it's GENPD_NOTIFY_ON notifier? In such case you
would have this lock taken.

> +
> +	dev_dbg(ps->dev, "PS 0x%x: deassert reset\n", ps->offset);
> +	regmap_clear_bits(ps->regmap, ps->offset, APPLE_PMGR_RESET);
> +	regmap_clear_bits(ps->regmap, ps->offset, APPLE_PMGR_DEV_DISABLE);
> +
> +	if (ps->genpd.status == GENPD_STATE_OFF)
> +		dev_err(ps->dev, "PS 0x%x: RESET was deasserted while powered down\n", ps->offset);
> +
> +	mutex_unlock(&ps->genpd.mlock);
> +
> +	return 0;
> +}
> +
> +static int apple_pmgr_reset_reset(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	int ret;
> +
> +	ret = apple_pmgr_reset_assert(rcdev, id);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(APPLE_PMGR_RESET_TIME, 2 * APPLE_PMGR_RESET_TIME);
> +
> +	return apple_pmgr_reset_deassert(rcdev, id);
> +}
> +
> +static int apple_pmgr_reset_status(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct apple_pmgr_ps *ps = rcdev_to_apple_pmgr_ps(rcdev);
> +	u32 reg;
> +
> +	regmap_read(ps->regmap, ps->offset, &reg);
> +
> +	return !!(reg & APPLE_PMGR_RESET);
> +}
> +
> +const struct reset_control_ops apple_pmgr_reset_ops = {
> +	.assert		= apple_pmgr_reset_assert,
> +	.deassert	= apple_pmgr_reset_deassert,
> +	.reset		= apple_pmgr_reset_reset,
> +	.status		= apple_pmgr_reset_status,
> +};
> +
> +static int apple_pmgr_reset_xlate(struct reset_controller_dev *rcdev,
> +				  const struct of_phandle_args *reset_spec)
> +{
> +	return 0;
> +}
> +
> +static int apple_pmgr_ps_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct apple_pmgr_ps *ps;
> +	struct regmap *regmap;
> +	struct of_phandle_iterator it;
> +	int ret;
> +	const char *name;
> +
> +	regmap = syscon_node_to_regmap(node->parent);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ps = devm_kzalloc(dev, sizeof(*ps), GFP_KERNEL);
> +	if (!ps)
> +		return -ENOMEM;
> +
> +	ps->dev = dev;
> +	ps->regmap = regmap;
> +
> +	ret = of_property_read_string(node, "apple,domain-name", &name);
> +	if (ret < 0) {
> +		dev_err(dev, "missing apple,domain-name property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(node, "reg", &ps->offset);
> +	if (ret < 0) {
> +		dev_err(dev, "missing reg property\n");
> +		return ret;
> +	}
> +
> +	if (of_property_read_bool(node, "apple,always-on"))
> +		ps->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
> +
> +	ps->genpd.name = name;
> +	ps->genpd.power_on = apple_pmgr_ps_power_on;
> +	ps->genpd.power_off = apple_pmgr_ps_power_off;
> +
> +	ret = pm_genpd_init(&ps->genpd, NULL, !apple_pmgr_ps_is_active(ps));
> +	if (ret < 0) {
> +		dev_err(dev, "pm_genpd_init failed\n");
> +		return ret;
> +	}
> +
> +	ret = of_genpd_add_provider_simple(node, &ps->genpd);
> +	if (ret < 0) {
> +		dev_err(dev, "of_genpd_add_provider_simple failed\n");
> +		return ret;
> +	}
> +
> +	of_for_each_phandle(&it, ret, node, "power-domains", "#power-domain-cells", -1) {
> +		struct of_phandle_args parent, child;
> +
> +		parent.np = it.node;
> +		parent.args_count = of_phandle_iterator_args(&it, parent.args, MAX_PHANDLE_ARGS);
> +		child.np = node;
> +		child.args_count = 0;
> +		ret = of_genpd_add_subdomain(&parent, &child);
> +
> +		if (ret == -EPROBE_DEFER) {
> +			of_node_put(parent.np);
> +			goto err_remove;
> +		} else if (ret < 0) {
> +			dev_err(dev, "failed to add to parent domain: %d (%s -> %s)\n",
> +				ret, it.node->name, node->name);
> +			of_node_put(parent.np);
> +			goto err_remove;
> +		}
> +	}
> +
> +	pm_genpd_remove_device(dev);
> +
> +	ps->rcdev.owner = THIS_MODULE;
> +	ps->rcdev.nr_resets = 1;
> +	ps->rcdev.ops = &apple_pmgr_reset_ops;
> +	ps->rcdev.of_node = dev->of_node;
> +	ps->rcdev.of_reset_n_cells = 0;
> +	ps->rcdev.of_xlate = apple_pmgr_reset_xlate;
> +
> +	ret = devm_reset_controller_register(dev, &ps->rcdev);
> +	if (ret < 0)
> +		goto err_remove;
> +
> +	return 0;
> +err_remove:
> +	of_genpd_del_provider(node);
> +	pm_genpd_remove(&ps->genpd);
> +	return ret;
> +}
> +
> +static const struct of_device_id apple_pmgr_ps_of_match[] = {
> +	{ .compatible = "apple,t8103-pmgr-pwrstate" },
> +	{ .compatible = "apple,pmgr-pwrstate" },

You call the device/driver "pwrstate", which it seems is "power state".
These are not power states. These are power controllers or power
domains. Power state is rather a state of power domain - e.g. on or
gated. How about renaming it to power domain or pd?

> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, apple_pmgr_ps_of_match);
> +
> +static struct platform_driver apple_pmgr_ps_driver = {
> +	.probe = apple_pmgr_ps_probe,
> +	.driver = {
> +		.name = "apple-pmgr-pwrstate",
> +		.of_match_table = apple_pmgr_ps_of_match,
> +	},
> +};
> +
> +MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
> +MODULE_DESCRIPTION("PMGR power state driver for Apple SoCs");
> +MODULE_LICENSE("GPL v2");
> +
> +module_platform_driver(apple_pmgr_ps_driver);
> 


Best regards,
Krzysztof
