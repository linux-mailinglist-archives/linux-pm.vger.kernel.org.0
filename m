Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFFC192466
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 10:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgCYJmm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 05:42:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42041 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYJmm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 05:42:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15so2015782wrx.9
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2020 02:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vRDeYiMCG4XXoUnQTgsGkl8d/lvzN+sIbey00XaX5XM=;
        b=QDwl2z2ZAKFLg9mCSI/yr6ImooOPb5Fbs+CphasVocI/0SI+R5F+v5p7dMsBsVu/sm
         nj+rxcBs7M7oOB3To5sLYPfUhGzDtzeVXP9I08hkoRRQAkp32UihUKBCYgPVs1vtS3Qa
         PbO0r02L+BfDBd7P4MzuC1Sn0jbIB5gVhiw43nLmKg98NPo4pxshHKRNPWtb3wumxT17
         oFXTCCi/KZpHwm0F5Sph+oQIeujRyngu1j6ae4xUSS6A9TaRjEBRg3kxWAeWar/0cYej
         he5RWQlC0Ib8sddoq57miNpslYhx9gGXdmjZHuLocgjCeR7MQWMSKw9nt5HCA9DMMftx
         gBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vRDeYiMCG4XXoUnQTgsGkl8d/lvzN+sIbey00XaX5XM=;
        b=PNUdUe8VZgdDOTWwEYlxr8qdox9KTHRhuRnXccEBBiWKYen9MxpXZ2ZippX7n/eCvS
         pu6GW3mp29FVOoQq8d593GchGo5EVejN/PGMZOmOrT7tiYZ+eaRW1oC6s1rxQUhu53wO
         IOk3Pujss3qoZdG8s8AycNjfLnDgli7sdCEe6/PGMr1e5qX5pHCbH7CKZ51K5fWBSIVI
         5KWpJHaTUuKk7mY9Eg01PieWAbv93pOCxxc1e5FHlebnu1jrmFM31wPhj5WqigOgnfPn
         AIYqti2CWL0RVQ4iPewZ+k2B6jEBG5H7Lue7+ROnNH3nqy3Z1izrn1jnalnA1sWjKSRd
         z68w==
X-Gm-Message-State: ANhLgQ33AvXV+bhsRLCJVOyABCcBpwpY/1aYrpD9ZlhIMIFakCtU8tTn
        UO72iH2encE+KW+AwmDCgAT6MQ==
X-Google-Smtp-Source: ADFU+vur7iuRbEAFb8kp1fAHSb42z9lGv7s7JibA/ubrGXmJU2SV6uYfUAdsdWWve6Y7oB1Tmo891A==
X-Received: by 2002:adf:9ccb:: with SMTP id h11mr2382792wre.22.1585129358113;
        Wed, 25 Mar 2020 02:42:38 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id h26sm8323017wmb.19.2020.03.25.02.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 02:42:37 -0700 (PDT)
Date:   Wed, 25 Mar 2020 09:43:26 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Frank Wunderlich <frank-w@public-files.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Ran Bi <ran.bi@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v10 3/5] mfd: Add support for the MediaTek MT6358 PMIC
Message-ID: <20200325094326.GH442973@dell>
References: <1583918223-22506-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1583918223-22506-4-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1583918223-22506-4-git-send-email-hsin-hsiung.wang@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 11 Mar 2020, Hsin-Hsiung Wang wrote:

> This adds support for the MediaTek MT6358 PMIC. This is a
> multifunction device with the following sub modules:
> 
> - Regulator
> - RTC
> - Codec
> - Interrupt
> 
> It is interfaced to the host controller using SPI interface
> by a proprietary hardware called PMIC wrapper or pwrap.
> MT6358 MFD is a child device of the pwrap.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  drivers/mfd/Makefile                 |   2 +-
>  drivers/mfd/mt6358-irq.c             | 236 +++++++++++++++++++++++++++++
>  drivers/mfd/mt6397-core.c            |  55 ++++++-
>  include/linux/mfd/mt6358/core.h      | 158 ++++++++++++++++++++
>  include/linux/mfd/mt6358/registers.h | 282 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6397/core.h      |   3 +
>  6 files changed, 731 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/mfd/mt6358-irq.c
>  create mode 100644 include/linux/mfd/mt6358/core.h
>  create mode 100644 include/linux/mfd/mt6358/registers.h
> 
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index b83f172..9af1414 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -238,7 +238,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)	+= intel_soc_pmic_bxtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)	+= intel_soc_pmic_chtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
> -mt6397-objs	:= mt6397-core.o mt6397-irq.o
> +mt6397-objs			:= mt6397-core.o mt6397-irq.o mt6358-irq.o
>  obj-$(CONFIG_MFD_MT6397)	+= mt6397.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_MRFLD)	+= intel_soc_pmic_mrfld.o
>  
> diff --git a/drivers/mfd/mt6358-irq.c b/drivers/mfd/mt6358-irq.c
> new file mode 100644
> index 0000000..022e5f5
> --- /dev/null
> +++ b/drivers/mfd/mt6358-irq.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2019 MediaTek Inc.

This is out of date.

> +#include <linux/interrupt.h>
> +#include <linux/mfd/mt6358/core.h>
> +#include <linux/mfd/mt6358/registers.h>
> +#include <linux/mfd/mt6397/core.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +static struct irq_top_t mt6358_ints[] = {
> +	MT6358_TOP_GEN(BUCK),
> +	MT6358_TOP_GEN(LDO),
> +	MT6358_TOP_GEN(PSC),
> +	MT6358_TOP_GEN(SCK),
> +	MT6358_TOP_GEN(BM),
> +	MT6358_TOP_GEN(HK),
> +	MT6358_TOP_GEN(AUD),
> +	MT6358_TOP_GEN(MISC),
> +};
> +
> +static void pmic_irq_enable(struct irq_data *data)
> +{
> +	unsigned int hwirq = irqd_to_hwirq(data);
> +	struct mt6397_chip *chip = irq_data_get_irq_chip_data(data);

6397?

This does make me wonder how different this file is to the existing
support for the MT6397.  What is the justification for not extending
that instead of creating a brand new file?

> +	struct pmic_irq_data *irqd = chip->irq_data;
> +
> +	irqd->enable_hwirq[hwirq] = true;
> +}
> +
> +static void pmic_irq_disable(struct irq_data *data)
> +{
> +	unsigned int hwirq = irqd_to_hwirq(data);
> +	struct mt6397_chip *chip = irq_data_get_irq_chip_data(data);
> +	struct pmic_irq_data *irqd = chip->irq_data;
> +
> +	irqd->enable_hwirq[hwirq] = false;
> +}
> +
> +static void pmic_irq_lock(struct irq_data *data)
> +{
> +	struct mt6397_chip *chip = irq_data_get_irq_chip_data(data);
> +
> +	mutex_lock(&chip->irqlock);
> +}
> +
> +static void pmic_irq_sync_unlock(struct irq_data *data)
> +{
> +	unsigned int i, top_gp, gp_offset, en_reg, int_regs, shift;
> +	struct mt6397_chip *chip = irq_data_get_irq_chip_data(data);
> +	struct pmic_irq_data *irqd = chip->irq_data;
> +
> +	for (i = 0; i < irqd->num_pmic_irqs; i++) {
> +		if (irqd->enable_hwirq[i] == irqd->cache_hwirq[i])
> +			continue;
> +
> +		/* Find out the IRQ group */
> +		top_gp = 0;
> +		while ((top_gp + 1) < irqd->num_top &&
> +		       i >= mt6358_ints[top_gp + 1].hwirq_base)
> +			top_gp++;
> +
> +		/* Find the irq registers */

Nit: "IRQ"

> +		gp_offset = i - mt6358_ints[top_gp].hwirq_base;
> +		int_regs = gp_offset / MT6358_REG_WIDTH;
> +		shift = gp_offset % MT6358_REG_WIDTH;
> +		en_reg = mt6358_ints[top_gp].en_reg +
> +			 (mt6358_ints[top_gp].en_reg_shift * int_regs);
> +
> +		regmap_update_bits(chip->regmap, en_reg, BIT(shift),
> +				   irqd->enable_hwirq[i] << shift);
> +
> +		irqd->cache_hwirq[i] = irqd->enable_hwirq[i];
> +	}
> +	mutex_unlock(&chip->irqlock);
> +}

[...]

> +int mt6358_irq_init(struct mt6397_chip *chip)
> +{
> +	int i, j, ret;
> +	struct pmic_irq_data *irqd;
> +
> +	irqd = devm_kzalloc(chip->dev, sizeof(struct pmic_irq_data *),

sizeof(*irqd)

[...]

>  static const struct chip_data mt6397_core = {
>  	.cid_addr = MT6397_CID,
>  	.cid_shift = 0,
> @@ -154,19 +184,33 @@ static int mt6397_probe(struct platform_device *pdev)
>  	if (pmic->irq <= 0)
>  		return pmic->irq;
>  
> -	ret = mt6397_irq_init(pmic);
> -	if (ret)
> -		return ret;
> -
>  	switch (pmic->chip_id) {
>  	case MT6323_CHIP_ID:
> +		ret = mt6397_irq_init(pmic);
> +		if (ret)
> +			return ret;
> +
>  		ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
>  					   mt6323_devs, ARRAY_SIZE(mt6323_devs),
>  					   NULL, 0, pmic->irq_domain);
>  		break;
>  
> +	case MT6358_CHIP_ID:
> +		ret = mt6358_irq_init(pmic);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> +					   mt6358_devs, ARRAY_SIZE(mt6358_devs),
> +					   NULL, 0, pmic->irq_domain);

In a subsequent patch you can choose the correct mtXXXX_devs structure
to pass and call devm_mfd_add_devices() only once below the switch().

> +		break;
> +
>  	case MT6391_CHIP_ID:
>  	case MT6397_CHIP_ID:
> +		ret = mt6397_irq_init(pmic);
> +		if (ret)
> +			return ret;
> +
>  		ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
>  					   mt6397_devs, ARRAY_SIZE(mt6397_devs),
>  					   NULL, 0, pmic->irq_domain);

[...]

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
