Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49087443850
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 23:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhKBWV7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 2 Nov 2021 18:21:59 -0400
Received: from aposti.net ([89.234.176.197]:39610 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhKBWV6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Nov 2021 18:21:58 -0400
Date:   Tue, 02 Nov 2021 22:19:10 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/9] Remove unused headers <linux/jz4740-adc.h> and
 <linux/power/jz4740-battery.h>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Message-Id: <YZTY1R.N4GQ4QE9HBNA2@crapouillou.net>
In-Reply-To: <20211102220203.940290-2-corbet@lwn.net>
References: <20211102220203.940290-1-corbet@lwn.net>
        <20211102220203.940290-2-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Jonathan,

Le mar., nov. 2 2021 at 16:01:55 -0600, Jonathan Corbet 
<corbet@lwn.net> a écrit :
> Commit ff71266aa490 ("mfd: Drop obsolete JZ4740 driver") removed the 
> last
> file to include <linux/jz4740-adc.h> but left the header file itself
> behind.  Nothing uses it, remove it now.
> 
> Similarly, aea12071d6fc ("power/supply: Drop obsolete JZ4740 driver")
> deleted the last use of <linux/power/jz4740-battery.h>, so remove 
> that one
> too.
> 
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Thanks!
-Paul

> ---
>  include/linux/jz4740-adc.h           | 33 
> ----------------------------
>  include/linux/power/jz4740-battery.h | 15 -------------
>  2 files changed, 48 deletions(-)
>  delete mode 100644 include/linux/jz4740-adc.h
>  delete mode 100644 include/linux/power/jz4740-battery.h
> 
> diff --git a/include/linux/jz4740-adc.h b/include/linux/jz4740-adc.h
> deleted file mode 100644
> index 19d995c8bf06..000000000000
> --- a/include/linux/jz4740-adc.h
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -
> -#ifndef __LINUX_JZ4740_ADC
> -#define __LINUX_JZ4740_ADC
> -
> -struct device;
> -
> -/*
> - * jz4740_adc_set_config - Configure a JZ4740 adc device
> - * @dev: Pointer to a jz4740-adc device
> - * @mask: Mask for the config value to be set
> - * @val: Value to be set
> - *
> - * This function can be used by the JZ4740 ADC mfd cells to 
> configure their
> - * options in the shared config register.
> -*/
> -int jz4740_adc_set_config(struct device *dev, uint32_t mask, 
> uint32_t val);
> -
> -#define JZ_ADC_CONFIG_SPZZ		BIT(31)
> -#define JZ_ADC_CONFIG_EX_IN		BIT(30)
> -#define JZ_ADC_CONFIG_DNUM_MASK		(0x7 << 16)
> -#define JZ_ADC_CONFIG_DMA_ENABLE	BIT(15)
> -#define JZ_ADC_CONFIG_XYZ_MASK		(0x2 << 13)
> -#define JZ_ADC_CONFIG_SAMPLE_NUM_MASK	(0x7 << 10)
> -#define JZ_ADC_CONFIG_CLKDIV_MASK	(0xf << 5)
> -#define JZ_ADC_CONFIG_BAT_MB		BIT(4)
> -
> -#define JZ_ADC_CONFIG_DNUM(dnum)	((dnum) << 16)
> -#define JZ_ADC_CONFIG_XYZ_OFFSET(dnum)	((xyz) << 13)
> -#define JZ_ADC_CONFIG_SAMPLE_NUM(x)	((x) << 10)
> -#define JZ_ADC_CONFIG_CLKDIV(div)	((div) << 5)
> -
> -#endif
> diff --git a/include/linux/power/jz4740-battery.h 
> b/include/linux/power/jz4740-battery.h
> deleted file mode 100644
> index 10da211678c8..000000000000
> --- a/include/linux/power/jz4740-battery.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - *  Copyright (C) 2009, Jiejing Zhang <kzjeef@gmail.com>
> - */
> -
> -#ifndef __JZ4740_BATTERY_H
> -#define __JZ4740_BATTERY_H
> -
> -struct jz_battery_platform_data {
> -	struct power_supply_info info;
> -	int gpio_charge;	/* GPIO port of Charger state */
> -	int gpio_charge_active_low;
> -};
> -
> -#endif
> --
> 2.31.1
> 


