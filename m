Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E475250C5D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 01:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgHXXbd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 19:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHXXbc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 19:31:32 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7696C061574;
        Mon, 24 Aug 2020 16:31:31 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w2so9592907edv.7;
        Mon, 24 Aug 2020 16:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UHsRpJGa7OFAbb4vq5Fa39pyffBPBXg6EKmIshItQbM=;
        b=ivSvgwxZmZ7FwBZLd0Z4heC4v699E7cS+MOIfDmq3XZyKuoD7+xc/GF5dGaAVTfpIm
         q4wA8P5ZqBNadVNTyRAtnGbNjSwq1E14NM6Ld4h53DfygRi9i+pPrmjhbTkSdBlGJ9e1
         LPgvYJG1st8aq3Or8OWqCJNsOnSxjFkvwS5fzpbPVX8YjpyD/4WGeY8rn68LHEjCLJJ7
         Kjg/rCFbOXCwrFy60ff1nHxA6Xfklao+Oy7PS2yZqDAvvIpIqnzEYKRVrbtxyp/M27B+
         hCxZnkY1zQXg1YUEmbqd0FXA1lYVWQ5W866E3Z6pIw9tAkAVf0dWAiMJJ1mkFIg0DbrK
         XW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UHsRpJGa7OFAbb4vq5Fa39pyffBPBXg6EKmIshItQbM=;
        b=I0U7o/ROsdTBPImXc3LjSM42T6t/WGTmbQdPZe1G+mojt1je941rzw/EQJYX5kxdCS
         SrTBxoQnLCiD2QYi+m718AEz9eYjaeza94jqy/4loeryyyDmftpcY64FxPafglLvmEo9
         5VoqV/ptMtn+CkZVzkW4dQmIeRyLIItdJduRcXmyZXt/GvRU98Wv8ILVaCCWzw6rv83x
         +s04nnMatnhNX4JrO7gMDcHQXae2f3JOUYkn87J8NSYi+HfQjyEN51YFp1kZVRuSUhg+
         eDoiEQdHUxVmM6emHvghDLwiQGR8UzGTBufbY977aDYT8/SDW8ahKLFbtImTjN+7RKWr
         uY5A==
X-Gm-Message-State: AOAM530B3anw4+13wDWwNhRYnhf9Nop7kntFxE9m2wp87pyOsxCBIICr
        Zu1sC7qTNbZPyLLdNdKlyO8=
X-Google-Smtp-Source: ABdhPJwkh7nLbLI0Z4k0HwmttgquGURpwaAFfmGBQophybdCW+8xsMc4UCOvVknRBzl0dAxqjNFa4Q==
X-Received: by 2002:aa7:cf94:: with SMTP id z20mr2348266edx.247.1598311890486;
        Mon, 24 Aug 2020 16:31:30 -0700 (PDT)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id r18sm6111450eju.25.2020.08.24.16.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 16:31:29 -0700 (PDT)
Date:   Tue, 25 Aug 2020 02:31:27 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 4/6] power: reset: Add poweroff driver for ATC260x
 PMICs
Message-ID: <20200824233127.GB2301286@BV030612LT>
References: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
 <1c83a46ac8c39edceee1d98da2cd9e7c6eae35e8.1598043782.git.cristian.ciocaltea@gmail.com>
 <20200824144113.zsze5ezrwih7d37i@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824144113.zsze5ezrwih7d37i@earth.universe>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

Thanks for the review!

On Mon, Aug 24, 2020 at 04:41:13PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Sat, Aug 22, 2020 at 01:19:50AM +0300, Cristian Ciocaltea wrote:
> > This driver provides poweroff and reboot support for a system through
> > the ATC2603C and ATC2609A chip variants of the Actions Semi ATC260x
> > family of PMICs.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> >  drivers/power/reset/Kconfig            |   8 +-
> >  drivers/power/reset/Makefile           |   1 +
> >  drivers/power/reset/atc260x-poweroff.c | 274 +++++++++++++++++++++++++
> >  3 files changed, 282 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/power/reset/atc260x-poweroff.c
> > 
> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > index 0a1fb5c74f83..df6c3676b892 100644
> > --- a/drivers/power/reset/Kconfig
> > +++ b/drivers/power/reset/Kconfig
> > @@ -39,6 +39,13 @@ config POWER_RESET_AT91_SAMA5D2_SHDWC
> >  	  This driver supports the alternate shutdown controller for some Atmel
> >  	  SAMA5 SoCs. It is present for example on SAMA5D2 SoC.
> >  
> > +config POWER_RESET_ATC260X
> > +	tristate "Actions Semi ATC260x PMIC power-off driver"
> > +	depends on MFD_ATC260X
> > +	help
> > +	  This driver provides power-off and restart support for a system
> > +	  through Actions Semi ATC260x series PMICs.
> > +
> >  config POWER_RESET_AXXIA
> >  	bool "LSI Axxia reset driver"
> >  	depends on ARCH_AXXIA
> > @@ -285,4 +292,3 @@ config NVMEM_REBOOT_MODE
> >  	  action according to the mode.
> >  
> >  endif
> > -
> > diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> > index c51eceba9ea3..829df1157540 100644
> > --- a/drivers/power/reset/Makefile
> > +++ b/drivers/power/reset/Makefile
> > @@ -3,6 +3,7 @@ obj-$(CONFIG_POWER_RESET_AS3722) += as3722-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_AT91_POWEROFF) += at91-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_AT91_RESET) += at91-reset.o
> >  obj-$(CONFIG_POWER_RESET_AT91_SAMA5D2_SHDWC) += at91-sama5d2_shdwc.o
> > +obj-$(CONFIG_POWER_RESET_ATC260X) += atc260x-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_AXXIA) += axxia-reset.o
> >  obj-$(CONFIG_POWER_RESET_BRCMKONA) += brcm-kona-reset.o
> >  obj-$(CONFIG_POWER_RESET_BRCMSTB) += brcmstb-reboot.o
> > diff --git a/drivers/power/reset/atc260x-poweroff.c b/drivers/power/reset/atc260x-poweroff.c
> > new file mode 100644
> > index 000000000000..81a99e7e4a91
> > --- /dev/null
> > +++ b/drivers/power/reset/atc260x-poweroff.c
> > @@ -0,0 +1,274 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Poweroff & reset driver for Actions Semi ATC260x PMICs
> > + *
> > + * Copyright (c) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/mfd/atc260x/core.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/reboot.h>
> > +#include <linux/regmap.h>
> > +
> > +struct atc260x_pwrc {
> > +	struct device *dev;
> > +	struct regmap *regmap;
> > +	struct notifier_block restart_nb;
> > +	int (*do_poweroff)(const struct atc260x_pwrc *pwrc, bool restart);
> > +};
> > +
> > +/* Global variable needed only for pm_power_off */
> > +static struct atc260x_pwrc *atc260x_pwrc_data;
> > +
> > +static int atc2603c_do_poweroff(const struct atc260x_pwrc *pwrc, bool restart)
> > +{
> > +	int ret, deep_sleep = 0;
> > +	uint reg_mask, reg_val;
> > +
> > +	/* S4-Deep Sleep Mode is NOT available for WALL/USB power */
> > +	if (!restart && !power_supply_is_system_supplied()) {
> > +		deep_sleep = 1;
> > +		dev_info(pwrc->dev, "Enabling S4-Deep Sleep Mode");
> > +	}
> > +
> > +	/* Update wakeup sources */
> > +	reg_val = ATC2603C_PMU_SYS_CTL0_ONOFF_LONG_WK_EN |
> > +		  (restart ? ATC2603C_PMU_SYS_CTL0_RESET_WK_EN
> > +			   : ATC2603C_PMU_SYS_CTL0_ONOFF_SHORT_WK_EN);
> > +
> > +	ret = regmap_update_bits(pwrc->regmap, ATC2603C_PMU_SYS_CTL0,
> > +				 ATC2603C_PMU_SYS_CTL0_WK_ALL, reg_val);
> > +	if (ret)
> > +		dev_warn(pwrc->dev, "failed to write SYS_CTL0: %d\n", ret);
> > +
> > +	/* Update power mode */
> > +	reg_mask = ATC2603C_PMU_SYS_CTL3_EN_S2 | ATC2603C_PMU_SYS_CTL3_EN_S3;
> > +
> > +	ret = regmap_update_bits(pwrc->regmap, ATC2603C_PMU_SYS_CTL3, reg_mask,
> > +				 deep_sleep ? 0 : ATC2603C_PMU_SYS_CTL3_EN_S3);
> > +	if (ret) {
> > +		dev_err(pwrc->dev, "failed to write SYS_CTL3: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/* Trigger poweroff / restart sequence */
> > +	reg_mask = restart ? ATC2603C_PMU_SYS_CTL0_RESTART_EN
> > +			   : ATC2603C_PMU_SYS_CTL1_EN_S1;
> > +	reg_val = restart ? ATC2603C_PMU_SYS_CTL0_RESTART_EN : 0;
> > +
> > +	ret = regmap_update_bits(pwrc->regmap,
> > +				 restart ? ATC2603C_PMU_SYS_CTL0 : ATC2603C_PMU_SYS_CTL1,
> > +				 reg_mask, reg_val);
> > +	if (ret) {
> > +		dev_err(pwrc->dev, "failed to write SYS_CTL%d: %d\n",
> > +			restart ? 0 : 1, ret);
> > +		return ret;
> > +	}
> > +
> > +	/* Wait for trigger completion */
> > +	mdelay(200);
> > +
> > +	return 0;
> > +}
> > +
> > +static int atc2609a_do_poweroff(const struct atc260x_pwrc *pwrc, bool restart)
> > +{
> > +	int ret, deep_sleep = 0;
> > +	uint reg_mask, reg_val;
> > +
> > +	/* S4-Deep Sleep Mode is NOT available for WALL/USB power */
> > +	if (!restart && !power_supply_is_system_supplied()) {
> > +		deep_sleep = 1;
> > +		dev_info(pwrc->dev, "Enabling S4-Deep Sleep Mode");
> > +	}
> > +
> > +	/* Update wakeup sources */
> > +	reg_val = ATC2609A_PMU_SYS_CTL0_ONOFF_LONG_WK_EN |
> > +		  (restart ? ATC2609A_PMU_SYS_CTL0_RESET_WK_EN
> > +			   : ATC2609A_PMU_SYS_CTL0_ONOFF_SHORT_WK_EN);
> > +
> > +	ret = regmap_update_bits(pwrc->regmap, ATC2609A_PMU_SYS_CTL0,
> > +				 ATC2609A_PMU_SYS_CTL0_WK_ALL, reg_val);
> > +	if (ret)
> > +		dev_warn(pwrc->dev, "failed to write SYS_CTL0: %d\n", ret);
> > +
> > +	/* Update power mode */
> > +	reg_mask = ATC2609A_PMU_SYS_CTL3_EN_S2 | ATC2609A_PMU_SYS_CTL3_EN_S3;
> > +
> > +	ret = regmap_update_bits(pwrc->regmap, ATC2609A_PMU_SYS_CTL3, reg_mask,
> > +				 deep_sleep ? 0 : ATC2609A_PMU_SYS_CTL3_EN_S3);
> > +	if (ret) {
> > +		dev_err(pwrc->dev, "failed to write SYS_CTL3: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/* Trigger poweroff / restart sequence */
> > +	reg_mask = restart ? ATC2609A_PMU_SYS_CTL0_RESTART_EN
> > +			   : ATC2609A_PMU_SYS_CTL1_EN_S1;
> > +	reg_val = restart ? ATC2609A_PMU_SYS_CTL0_RESTART_EN : 0;
> > +
> > +	ret = regmap_update_bits(pwrc->regmap,
> > +				 restart ? ATC2609A_PMU_SYS_CTL0 : ATC2609A_PMU_SYS_CTL1,
> > +				 reg_mask, reg_val);
> > +	if (ret) {
> > +		dev_err(pwrc->dev, "failed to write SYS_CTL%d: %d\n",
> > +			restart ? 0 : 1, ret);
> > +		return ret;
> > +	}
> > +
> > +	/* Wait for trigger completion */
> > +	mdelay(200);
> > +
> > +	return 0;
> > +}
> > +
> > +static int atc2603c_init(const struct atc260x_pwrc *pwrc)
> > +{
> > +	int ret;
> > +
> > +	/*
> > +	 * Delay transition from S2/S3 to S1 in order to avoid
> > +	 * DDR init failure in Bootloader.
> > +	 */
> > +	ret = regmap_update_bits(pwrc->regmap, ATC2603C_PMU_SYS_CTL3,
> > +				 ATC2603C_PMU_SYS_CTL3_S2S3TOS1_TIMER_EN,
> > +				 ATC2603C_PMU_SYS_CTL3_S2S3TOS1_TIMER_EN);
> > +	if (ret)
> > +		dev_warn(pwrc->dev, "failed to write SYS_CTL3: %d\n", ret);
> > +
> > +	/* Set wakeup sources */
> > +	ret = regmap_update_bits(pwrc->regmap, ATC2603C_PMU_SYS_CTL0,
> > +				 ATC2603C_PMU_SYS_CTL0_WK_ALL,
> > +				 ATC2603C_PMU_SYS_CTL0_HDSW_WK_EN |
> > +				 ATC2603C_PMU_SYS_CTL0_ONOFF_LONG_WK_EN);
> > +	if (ret)
> > +		dev_warn(pwrc->dev, "failed to write SYS_CTL0: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int atc2609a_init(const struct atc260x_pwrc *pwrc)
> > +{
> > +	int ret;
> > +
> > +	/* Set wakeup sources */
> > +	ret = regmap_update_bits(pwrc->regmap, ATC2609A_PMU_SYS_CTL0,
> > +				 ATC2609A_PMU_SYS_CTL0_WK_ALL,
> > +				 ATC2609A_PMU_SYS_CTL0_HDSW_WK_EN |
> > +				 ATC2609A_PMU_SYS_CTL0_ONOFF_LONG_WK_EN);
> > +	if (ret)
> > +		dev_warn(pwrc->dev, "failed to write SYS_CTL0: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static void atc260x_pwrc_pm_handler(void)
> > +{
> > +	atc260x_pwrc_data->do_poweroff(atc260x_pwrc_data, false);
> > +
> > +	WARN_ONCE(1, "Unable to power off system\n");
> > +}
> > +
> > +static int atc260x_pwrc_restart_handler(struct notifier_block *nb,
> > +					unsigned long mode, void *cmd)
> > +{
> > +	struct atc260x_pwrc *pwrc = container_of(nb, struct atc260x_pwrc,
> > +						 restart_nb);
> > +	pwrc->do_poweroff(pwrc, true);
> > +
> > +	return NOTIFY_DONE;
> > +}
> > +
> > +static int atc260x_pwrc_probe(struct platform_device *pdev)
> > +{
> > +	struct atc260x *atc260x = dev_get_drvdata(pdev->dev.parent);
> > +	struct atc260x_pwrc *priv;
> > +	int ret;
> > +
> > +	if (!pdev->dev.of_node)
> > +		return -ENXIO;
> > +
> > +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->dev = &pdev->dev;
> > +	priv->regmap = atc260x->regmap;
> > +	priv->restart_nb.notifier_call = atc260x_pwrc_restart_handler;
> > +	priv->restart_nb.priority = 192;
> > +
> > +	switch (atc260x->ic_type) {
> > +	case ATC2603C:
> > +		priv->do_poweroff = atc2603c_do_poweroff;
> > +		ret = atc2603c_init(priv);
> > +		break;
> > +	case ATC2609A:
> > +		priv->do_poweroff = atc2609a_do_poweroff;
> > +		ret = atc2609a_init(priv);
> > +		break;
> > +	default:
> > +		dev_err(priv->dev,
> > +			"Poweroff not supported for ATC260x PMIC type: %u\n",
> > +			atc260x->ic_type);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	if (!pm_power_off) {
> > +		atc260x_pwrc_data = priv;
> > +		pm_power_off = atc260x_pwrc_pm_handler;
> > +	} else {
> > +		dev_warn(priv->dev, "Poweroff callback already assigned\n");
> > +	}
> > +
> > +	ret = register_restart_handler(&priv->restart_nb);
> > +	if (ret)
> > +		dev_err(priv->dev, "failed to register restart handler: %d\n",
> > +			ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int atc260x_pwrc_remove(struct platform_device *pdev)
> > +{
> > +	struct atc260x_pwrc *priv = platform_get_drvdata(pdev);
> > +
> > +	if (atc260x_pwrc_data == priv) {
> > +		pm_power_off = NULL;
> > +		atc260x_pwrc_data = NULL;
> > +	}
> > +
> > +	unregister_restart_handler(&priv->restart_nb);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id atc260x_pwrc_of_match[] = {
> > +	{ .compatible = "actions,atc2603c-pwrc" },
> > +	{ .compatible = "actions,atc2609a-pwrc" },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, atc260x_pwrc_of_match);
> > +
> > +static struct platform_driver atc260x_pwrc_driver = {
> > +	.probe = atc260x_pwrc_probe,
> > +	.remove = atc260x_pwrc_remove,
> > +	.driver = {
> > +		.name = "atc260x-pwrc",
> > +		.of_match_table = of_match_ptr(atc260x_pwrc_of_match),
> 
> drop of_match_ptr() and directly use atc260x_pwrc_of_match. Current
> code would throw unused warning for atc260x_pwrc_of_match when OF is
> disabled.

Done.

> > +	},
> > +};
> > +
> > +module_platform_driver(atc260x_pwrc_driver);
> > +
> > +MODULE_DESCRIPTION("Poweroff & reset driver for ATC260x PMICs");
> > +MODULE_AUTHOR("Cristian Ciocaltea <cristian.ciocaltea@gmail.com>");
> > +MODULE_LICENSE("GPL");
> 
> Otherwise LGTM,
> 
> -- Sebastian

Regards,
Cristi
