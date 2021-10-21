Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B31643602D
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 13:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhJUL3Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 07:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhJUL3W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 07:29:22 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49F0C06161C
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 04:27:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 84-20020a1c0457000000b003232b0f78f8so1611570wme.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 04:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HRccYAAxKQH+n0Ne7PXP5DxOUX/iyOBZsE6vUgryPPA=;
        b=wCYYjM4NSyxWT4PSGKrKws6r32sIgJNKs34OdlwLebZBAaAVP+417F8eBMUbSvsGYl
         8H/0QZsL5tNohQsHBRbu9L+SLBZMrzXg68OSPaEoLqBwnysv9ryUlqY+D5aZVJHhTS2e
         tvCuD3hx0xGS3Qx7qIH5lrx+xJIqA5BGp14Bq3RBQaD6ErdnkLDqx9Y7459uZEKcstLU
         Ge+S9FFM/2k8rUSCq+oJ4Vqenn8ZNoix8iyR//SUt9vozAFV2cDfnlbQBeS1UA6rpK0I
         Ru4aN8sz2Hp/Kd7XXsG9OKGikOtg5jWYIXtVKM3xOqfr6ELXJQTFFCK+0Jq0qx8OMbuK
         MfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HRccYAAxKQH+n0Ne7PXP5DxOUX/iyOBZsE6vUgryPPA=;
        b=clCOBCOMW5uEgccQtM5V6vvowxdQuHTQh/iyiJ4IaDw83a5tc+PH+4QsI4C35WPdUf
         XYGt5irI2rH+u3+DZ0c9z/wNGqReQJr/BXYlbuNySCmGRJ64KK7EVmnKuc8tjRgd5YWr
         jnlFFf3nXP9jqrKU77bxjzEbz0qdFaPw1EPPvcuteLZQruvahpTyCtftfrwcakvMbHzh
         bEHW1A5D1qXnjew+7OUbjBWE83bLaG4GOnnHDRFGcEExBChApWDHZ5BM3+LeuI2fudGI
         wX/ePh887qW1g+XCQoSKj44f98CGIZ1aNtr+vX+m8RjXF0jf4w32rvrq4ULWVKCMjg4T
         vBew==
X-Gm-Message-State: AOAM533GHESCD5tRCosWd7pbH2EmOFzmWjjkqhGc+D0+jJuY6wHL4oeJ
        AjdmBxUp2cCtc8Wyr74+/pp3tQ==
X-Google-Smtp-Source: ABdhPJzKFS7TlSxmG2+szgwLYfdptm119KR6wx8JCvIzN5lFi1GpLvMQsHTeuyE50hGZRY9NTLnbQQ==
X-Received: by 2002:a05:600c:1c1b:: with SMTP id j27mr5689836wms.1.1634815625514;
        Thu, 21 Oct 2021 04:27:05 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id f8sm53282wrj.41.2021.10.21.04.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:27:05 -0700 (PDT)
Date:   Thu, 21 Oct 2021 12:27:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        kernel@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, amitk@kernel.org, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v13 3/9] mfd: simple-mfd-i2c: Enable support for the
 silergy,sy7636a
Message-ID: <YXFOh6nubOYKv5ua@google.com>
References: <20211015122551.38951-1-alistair@alistair23.me>
 <20211015122551.38951-4-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211015122551.38951-4-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 15 Oct 2021, Alistair Francis wrote:

> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/simple-mfd-i2c.c | 12 +++++++++++
>  include/linux/mfd/sy7636a.h  | 41 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 include/linux/mfd/sy7636a.h
> 
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index 51536691ad9d..fbc6d6aed6c0 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -62,8 +62,20 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
>  	return ret;
>  }
>  
> +static const struct mfd_cell sy7636a_cells[] = {
> +	{ .name = "sy7636a-regulator", },
> +	{ .name = "sy7636a-temperature", },
> +	{ .name = "sy7636a-thermal", },
> +};
> +
> +static const struct simple_mfd_data silergy_sy7636a = {
> +	.mfd_cell = sy7636a_cells,
> +	.mfd_cell_size = ARRAY_SIZE(sy7636a_cells),
> +};
> +
>  static const struct of_device_id simple_mfd_i2c_of_match[] = {
>  	{ .compatible = "kontron,sl28cpld" },
> +	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
> diff --git a/include/linux/mfd/sy7636a.h b/include/linux/mfd/sy7636a.h
> new file mode 100644
> index 000000000000..15caa54f0432
> --- /dev/null
> +++ b/include/linux/mfd/sy7636a.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Functions to access SY3686A power management chip.
> + *
> + * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
> + */
> +
> +#ifndef __MFD_SY7636A_H
> +#define __MFD_SY7636A_H
> +
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>

Why are these needed?

> +#define SY7636A_REG_OPERATION_MODE_CRL		0x00
> +#define SY7636A_OPERATION_MODE_CRL_VCOMCTL	BIT(6)
> +#define SY7636A_OPERATION_MODE_CRL_ONOFF	BIT(7)
> +#define SY7636A_REG_VCOM_ADJUST_CTRL_L		0x01
> +#define SY7636A_REG_VCOM_ADJUST_CTRL_H		0x02
> +#define SY7636A_REG_VCOM_ADJUST_CTRL_MASK	0x01ff
> +#define SY7636A_REG_VLDO_VOLTAGE_ADJULST_CTRL	0x03
> +#define SY7636A_REG_POWER_ON_DELAY_TIME		0x06
> +#define SY7636A_REG_FAULT_FLAG			0x07
> +#define SY7636A_FAULT_FLAG_PG			BIT(0)
> +#define SY7636A_REG_TERMISTOR_READOUT		0x08
> +
> +#define SY7636A_REG_MAX				0x08
> +
> +#define VCOM_MIN		0
> +#define VCOM_MAX		5000
> +
> +#define VCOM_ADJUST_CTRL_MASK	0x1ff
> +// Used to shift the high byte
> +#define VCOM_ADJUST_CTRL_SHIFT	8
> +// Used to scale from VCOM_ADJUST_CTRL to mv
> +#define VCOM_ADJUST_CTRL_SCAL	10000
> +
> +#define FAULT_FLAG_SHIFT	1
> +
> +#endif /* __LINUX_MFD_SY7636A_H */

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
