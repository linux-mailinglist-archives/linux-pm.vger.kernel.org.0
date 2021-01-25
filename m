Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4D230359B
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 06:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbhAZFrv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 00:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729562AbhAYOfc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2021 09:35:32 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47909C061788
        for <linux-pm@vger.kernel.org>; Mon, 25 Jan 2021 06:26:02 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h9so2502684wrr.9
        for <linux-pm@vger.kernel.org>; Mon, 25 Jan 2021 06:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Vji1Tx5QRSQNLp89Gs6e8lzkkwhzHlemOJyNOLZx/Vs=;
        b=C7OKxxXbzwcriXVOqt/vHbQNBqSMpqwjmlk7grSPzIT+mfxg/TvYC8aScaDUGk9ACp
         gzWErcI9AFx59YsvnMYwSFfJ54l8HWaKF4dBUDNv4WMe8eAPx1q2TLruc8ABW8gF7VcZ
         kFLUhRkp+NtHywqLT75AhPZOlXonh8UqhAnJAFV/ZHGRkOOb2hnPTZV2NbHg+XjWsxrX
         sIcgMjZlS4WJrYyTqBMC77lRyI/MEVCqczskgg79ZbERtAuP5kWXsw4BuGs5BhjSiw01
         cN8J8ba13f09b7WdFnqjNtXFF3ITRVAlsoVX+OrOWyQCD0uNQ6RI3XK4VuWKeDIvaKn+
         Gh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Vji1Tx5QRSQNLp89Gs6e8lzkkwhzHlemOJyNOLZx/Vs=;
        b=kgn9C2un6YWN90EHGPj40WfZ4Cqei/NKly3BnxcJUOkrZYcHptMHkrCQ5tbWuYG1zn
         GEzYEoPms++JXw1YCU/tEIDTLsyJMkvc7m75MZFVkiqQJtpf7A72/T9jRvO0Uio5dQYK
         0x9kxu9sf23lDhTOVF3oqunSNBvCiQJSR9urQbhCIk8bnim+A5Ypmiy8gM2oudgZs4rP
         YMbQFq7VVkcpGVa1AifDVHXMVE+k0P6EjHaDrIzT6vnwZKAeXpAjz/8LEVCqkyq8ltLo
         FUI4ZhwCR7IgZDC8EsZIw4nx8PFTtiC6/KeXH+a4RlQVAlVxPO/BSLs/yEYHw1IvEpIs
         IfmA==
X-Gm-Message-State: AOAM532WucRUxCSxtqfwaOjsdIFk5qOb9ybcsy5pHzyVonYJ3HmV/nU3
        oyMUkK5McsUQA2PJTyV0XOXpIQ==
X-Google-Smtp-Source: ABdhPJwRHIRT4t+tsU+w3Q4lxBuXQlIFUyjKY1apuZy7xv0+VfMOA1VLqRWa9iiUnXxm5EhLHf8Dww==
X-Received: by 2002:adf:d206:: with SMTP id j6mr1184505wrh.427.1611584760873;
        Mon, 25 Jan 2021 06:26:00 -0800 (PST)
Received: from dell ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r15sm23355806wrq.1.2021.01.25.06.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 06:26:00 -0800 (PST)
Date:   Mon, 25 Jan 2021 14:25:58 +0000
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
Subject: Re: [PATCH v6 3/7] mfd: Add MFD driver for ATC260x PMICs
Message-ID: <20210125142558.GA4903@dell>
References: <cover.1611165200.git.cristian.ciocaltea@gmail.com>
 <4bc76f9e3dc7204d7f407af6ee61c9f193a789d3.1611165200.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bc76f9e3dc7204d7f407af6ee61c9f193a789d3.1611165200.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 20 Jan 2021, Cristian Ciocaltea wrote:

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
> Changes in v6 - per Lee's feedback:
> - Added ATC260X_CHIP_REV_MAX magic number
> - Fixed code formattting arround atc260x_i2c_driver initialization
> - Replaced dev_init() callback in struct atc260x with a pointer to a new struct
> atc260x_init_regs to hold hardware specific registry information
> - Added a generic atc260x_dev_init() function and instantiated atc2603c_init_regs
> and atc2609a_init_regs
> 
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
>  drivers/mfd/atc260x-core.c           | 310 +++++++++++++++++++++++++++
>  drivers/mfd/atc260x-i2c.c            |  64 ++++++
>  include/linux/mfd/atc260x/atc2603c.h | 281 ++++++++++++++++++++++++
>  include/linux/mfd/atc260x/atc2609a.h | 308 ++++++++++++++++++++++++++
>  include/linux/mfd/atc260x/core.h     |  58 +++++
>  7 files changed, 1042 insertions(+)
>  create mode 100644 drivers/mfd/atc260x-core.c
>  create mode 100644 drivers/mfd/atc260x-i2c.c
>  create mode 100644 include/linux/mfd/atc260x/atc2603c.h
>  create mode 100644 include/linux/mfd/atc260x/atc2609a.h
>  create mode 100644 include/linux/mfd/atc260x/core.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index bdfce7b15621..a27ff2e83e7a 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2064,6 +2064,24 @@ config MFD_WCD934X
>  	  This driver provides common support WCD934x audio codec and its
>  	  associated Pin Controller, Soundwire Controller and Audio codec.
>  
> +config MFD_ATC260X
> +	tristate
> +	select MFD_CORE
> +	select REGMAP
> +	select REGMAP_IRQ
> +
> +config MFD_ATC260X_I2C
> +	tristate "Actions Semi ATC260x PMICs with I2C"
> +	select MFD_ATC260X
> +	select REGMAP_I2C
> +	depends on I2C
> +	help
> +	  Support for the Actions Semi ATC260x PMICs controlled via I2C.
> +
> +	  This driver provides common support for accessing the ATC2603C
> +	  and ATC2609A chip variants, additional drivers must be enabled
> +	  in order to use the functionality of the device.
> +
>  config MFD_KHADAS_MCU
>  	tristate "Support for Khadas System control Microcontroller"
>  	depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 14fdb188af02..1ea88d2c83b4 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -268,3 +268,6 @@ obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
>  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
>  obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
> +
> +obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
> +obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
> diff --git a/drivers/mfd/atc260x-core.c b/drivers/mfd/atc260x-core.c
> new file mode 100644
> index 000000000000..7148ff5b05b1
> --- /dev/null
> +++ b/drivers/mfd/atc260x-core.c
> @@ -0,0 +1,310 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Core support for ATC260x PMICs
> + *
> + * Copyright (C) 2019 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + * Copyright (C) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/mfd/atc260x/core.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#define ATC260X_CHIP_REV_MAX	31
> +
> +struct atc260x_init_regs {
> +	unsigned int cmu_devrst;
> +	unsigned int cmu_devrst_ints;
> +	unsigned int ints_msk;
> +	unsigned int pad_en;
> +	unsigned int pad_en_extirq;
> +};
> +
> +static void regmap_lock_mutex(void *__mutex)
> +{
> +	struct mutex *mutex = __mutex;
> +
> +	/*
> +	 * Using regmap within an atomic context (e.g. accessing a PMIC when
> +	 * powering system down) is normally allowed only if the regmap type
> +	 * is MMIO and the regcache type is either REGCACHE_NONE or
> +	 * REGCACHE_FLAT. For slow buses like I2C and SPI, the regmap is
> +	 * internally protected by a mutex which is acquired non-atomically.
> +	 *
> +	 * Let's improve this by using a customized locking scheme inspired
> +	 * from I2C atomic transfer. See i2c_in_atomic_xfer_mode() for a
> +	 * starting point.
> +	 */
> +	if (system_state > SYSTEM_RUNNING && irqs_disabled())
> +		mutex_trylock(mutex);
> +	else
> +		mutex_lock(mutex);
> +}

Would this be useful to anyone else?

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
