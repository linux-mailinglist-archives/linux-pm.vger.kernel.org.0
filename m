Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DEC2FCCD2
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 09:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbhATIfi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 03:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730947AbhATIec (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 03:34:32 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA57BC061575
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 00:33:51 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c127so2015055wmf.5
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 00:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kf68twK2VJqQ9rG90iy/Ey4koGBofqxtFe6BH41DE2U=;
        b=ugv47AZmMA+xT9rztkNUf1l1ZWJmiwwKfuZcduQNMyAoiXL1mZ4978OKPr3LEWr7vz
         KNR0D99j9aUzgV+TNPAvrOBbhn7PIvz7iQEtTR8K7v2JE6FekzIw1fz+7P8nFv0cCABa
         DFK85L7PJVYKs3/kbL4eFwcH8lwz93GswENPw+JUpWOI4HzhyrwL1SkCK8duQCmGJj/J
         Zykl2cLd1X48gVne+VuwLslmUSSTeNwdoTkcr/PaN0H1vjdySHEBNArm4zAIzxcmNa3P
         /oxAmhso1coeEuToHfQMLoUafrOJ1eonMC542hB3+fycgWMDpuMVbNSJBoZp6Aee3GnB
         yUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kf68twK2VJqQ9rG90iy/Ey4koGBofqxtFe6BH41DE2U=;
        b=r/tPys7b8dhyOTxdjIxrrIgl//0hASGvidah77kI7WoZNxUnShLYHdXAtSjgbaq5tf
         5CMZ5525adUr/8gIGXERj/LklKZOjerTDcGQYNx5QgrtYVjKIln491QKCnnfRtM6Blz7
         FJBM7YIw0siHB54nAPTwnKgxl/Pob940YypTqqsaDV2NS+v1eRRWN6HFoQqFJCmMqoNt
         54VO05mclyMxNQidK6axAWLx0AeESzTGFxW8xyEGR3Xx2xhX1CtiYjvVcpHzsiWx4B+N
         8k3rl7kDJXbOzhEAbyYdptANuULHuDR1fmQ3POTf7cBtr4PZ+pg0UpNgtFzQbzikKycj
         +3yQ==
X-Gm-Message-State: AOAM533xh9m5ukTgpTfRfYl6aqUdsXRyr/eyoj/y3ArqocnC/57Q3TOa
        9xclZgLSHLy2Rja3too9ja1f5w==
X-Google-Smtp-Source: ABdhPJzEiyHU50818frV69xIg7wQLT2H4SHkDbjF641qDAzxYiCtZvuG6UsYBlE6su9suTh5V1Du6g==
X-Received: by 2002:a1c:6005:: with SMTP id u5mr3248278wmb.122.1611131630513;
        Wed, 20 Jan 2021 00:33:50 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id h13sm2480169wrm.28.2021.01.20.00.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 00:33:49 -0800 (PST)
Date:   Wed, 20 Jan 2021 08:33:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 3/7] mfd: Add MFD driver for ATC260x PMICs
Message-ID: <20210120083348.GM4903@dell>
References: <cover.1610534765.git.cristian.ciocaltea@gmail.com>
 <81546cf3265f51374a1b38b9e801003fd6c3e298.1610534765.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81546cf3265f51374a1b38b9e801003fd6c3e298.1610534765.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 13 Jan 2021, Cristian Ciocaltea wrote:

> Add initial support for the Actions Semi ATC260x PMICs which integrates
> Audio Codec, Power management, Clock generation and GPIO controller
> blocks.
> 
> For the moment this driver only supports Regulator, Poweroff and Onkey
> functionalities for the ATC2603C and ATC2609A chip variants.
> 
> Since the PMICs can be accessed using both I2C and SPI buses, the
> following driver structure has been adopted:
> 
>            -----> atc260x-core.c (Implements core functionalities)
>           /
> ATC260x --------> atc260x-i2c.c (Implements I2C interface)
>           \
>            -----> atc260x-spi.c (Implements SPI interface - TODO)
> 
> Co-developed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
> Changes in v5:
>  - None
> 
> Changes in v4 - according to Lee's review:
>  - Replaced 'regmap_add_irq_chip()' with 'devm' counterpart and dropped
>    'atc260x_device_remove()' and 'atc260x_i2c_remove()' functions
>  - Moved kerneldoc sections from prototypes to real functions
>  - Placed single line entries on one line for mfd_cells[]
>  - Several other minor changes
> 
> Changes in v3:
>  - Fixed the issues reported by Lee's kernel test robot:
>    WARNING: modpost: missing MODULE_LICENSE() in drivers/mfd/atc260x-core.o
>    >> FATAL: modpost: drivers/mfd/atc260x-i2c: sizeof(struct i2c_device_id)=24 is
>       not a modulo of the size of section __mod_i2c__<identifier>_device_table=588.
>    >> Fix definition of struct i2c_device_id in mod_devicetable.h
>  - Dropped the usage of '.of_compatible' fields in {atc2603c,atc2609a}_mfd_cells[]
>  - Added 'Co-developed-by' tag in commit message and dropped [cristian: ...] line
> 
>  drivers/mfd/Kconfig                  |  18 ++
>  drivers/mfd/Makefile                 |   3 +
>  drivers/mfd/atc260x-core.c           | 293 +++++++++++++++++++++++++
>  drivers/mfd/atc260x-i2c.c            |  64 ++++++
>  include/linux/mfd/atc260x/atc2603c.h | 281 ++++++++++++++++++++++++
>  include/linux/mfd/atc260x/atc2609a.h | 308 +++++++++++++++++++++++++++
>  include/linux/mfd/atc260x/core.h     |  58 +++++
>  7 files changed, 1025 insertions(+)
>  create mode 100644 drivers/mfd/atc260x-core.c
>  create mode 100644 drivers/mfd/atc260x-i2c.c
>  create mode 100644 include/linux/mfd/atc260x/atc2603c.h
>  create mode 100644 include/linux/mfd/atc260x/atc2609a.h
>  create mode 100644 include/linux/mfd/atc260x/core.h

[...]

> +/**
> + * atc260x_device_probe(): Probe a configured ATC260x device
> + *
> + * @atc260x: ATC260x device to probe (must be configured)
> + *
> + * This function lets the ATC260x core register the ATC260x MFD devices
> + * and IRQCHIP. The ATC260x device passed in must be fully configured
> + * with atc260x_match_device, its IRQ set, and regmap created.
> + */
> +int atc260x_device_probe(struct atc260x *atc260x)
> +{
> +	struct device *dev = atc260x->dev;
> +	unsigned int chip_rev;
> +	int ret;
> +
> +	if (!atc260x->irq) {
> +		dev_err(dev, "No interrupt support\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Initialize the hardware */
> +	atc260x->dev_init(atc260x);
> +
> +	ret = regmap_read(atc260x->regmap, atc260x->rev_reg, &chip_rev);
> +	if (ret) {
> +		dev_err(dev, "Failed to get chip revision\n");
> +		return ret;
> +	}
> +
> +	if (chip_rev > 31) {

Nit: If you have to respin this, please define this magic number.

> +		dev_err(dev, "Unknown chip revision: %u\n", chip_rev);
> +		return -EINVAL;
> +	}
> +
> +	atc260x->ic_ver = __ffs(chip_rev + 1U);
> +
> +	dev_info(dev, "Detected chip type %s rev.%c\n",
> +		 atc260x->type_name, 'A' + atc260x->ic_ver);
> +
> +	ret = devm_regmap_add_irq_chip(dev, atc260x->regmap, atc260x->irq, IRQF_ONESHOT,
> +				       -1, atc260x->regmap_irq_chip, &atc260x->irq_data);
> +	if (ret) {
> +		dev_err(dev, "Failed to add IRQ chip: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> +				   atc260x->cells, atc260x->nr_cells, NULL, 0,
> +				   regmap_irq_get_domain(atc260x->irq_data));
> +	if (ret) {
> +		dev_err(dev, "Failed to add child devices: %d\n", ret);
> +		regmap_del_irq_chip(atc260x->irq, atc260x->irq_data);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(atc260x_device_probe);

[...]

> +static struct i2c_driver atc260x_i2c_driver = {
> +	.driver = {
> +		.name	= "atc260x",
> +		.of_match_table	= of_match_ptr(atc260x_i2c_of_match),
> +	},
> +	.probe		= atc260x_i2c_probe,
> +};

Nit: These spacings/line-ups just look odd.

Please stick to one ' ' after the '='.

> +module_i2c_driver(atc260x_i2c_driver);

[...]

> +struct atc260x {
> +	struct device *dev;
> +
> +	struct regmap *regmap;
> +	const struct regmap_irq_chip *regmap_irq_chip;
> +	struct regmap_irq_chip_data *irq_data;
> +
> +	struct mutex *regmap_mutex;	/* mutex for custom regmap locking */
> +
> +	const struct mfd_cell *cells;
> +	int nr_cells;
> +	int irq;
> +
> +	enum atc260x_type ic_type;
> +	enum atc260x_ver ic_ver;
> +	const char *type_name;
> +	unsigned int rev_reg;
> +
> +	int (*dev_init)(struct atc260x *atc260x);

Ah, I didn't see this before.

Call-backs of this nature are the devil.  Please populate a struct
with the differentiating register addresses/values instead and always
call a generic deivce_init().

> +};
> +
> +struct regmap_config;
> +
> +int atc260x_match_device(struct atc260x *atc260x, struct regmap_config *regmap_cfg);
> +int atc260x_device_probe(struct atc260x *atc260x);
> +
> +#endif /* __LINUX_MFD_ATC260X_CORE_H */

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
