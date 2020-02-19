Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A786163E24
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 08:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgBSHub (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 02:50:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgBSHua (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 02:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=8mFw61Czqg56/JxSmBKdUElYWIaIMTtisEbvrwNrP2k=; b=vDd3UE8R4dQygKI901pT7mIRLT
        idFLmDlF/QiEq0wgvfbAD1gc9ivo1jGIjMKt3jONTogs+pWxEfvC6JN/gfmiLzyJ4bfCD8ufAIMiq
        MYaebz1SFBThc64yw1bd5sP/m0EAHVXvi++NXX8sqylLQqo2R22QSdXPY4MBENp67jwJ1RHwfWuKv
        WtEAT9w3xuQ7QEcDpU6HzzMF+BoHhI5H+OBM/+tdNi+CGqGd81YK71vRb6NG7QSKyDsm73PcqD0q1
        2X3ipwMefMUaNNDeUxXOg7pYYMAo8LKz2L9rRqocTaG5G7lxa3sVz9qs318H5mChwfQr/M2XE/wrV
        sElu2zAg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4K7q-0003cQ-2R; Wed, 19 Feb 2020 07:50:30 +0000
Subject: Re: [PATCH v3 2/4] thermal: k3: Add support for bandgap sensors
To:     Keerthy <j-keerthy@ti.com>, rui.zhang@intel.com,
        robh+dt@kernel.org, daniel.lezcano@linaro.org
Cc:     amit.kucheria@verdurent.com, t-kristo@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        mark.rutland@arm.com
References: <20200219074314.22829-1-j-keerthy@ti.com>
 <20200219074314.22829-3-j-keerthy@ti.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ab0bc84b-189f-a9be-e838-a38c14fa702a@infradead.org>
Date:   Tue, 18 Feb 2020 23:50:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219074314.22829-3-j-keerthy@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/18/20 11:43 PM, Keerthy wrote:
> The bandgap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.
> 
> Currently reading temperatures and trend computing is supported
> as there are no active/passive cooling agent supported.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/thermal/Kconfig      |  12 ++
>  drivers/thermal/Makefile     |   1 +
>  drivers/thermal/k3_bandgap.c | 342 +++++++++++++++++++++++++++++++++++
>  3 files changed, 355 insertions(+)
>  create mode 100644 drivers/thermal/k3_bandgap.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 5a05db5438d6..fa598eddc7ac 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -251,6 +251,18 @@ config IMX_THERMAL
>  	  cpufreq is used as the cooling device to throttle CPUs when the
>  	  passive trip is crossed.
>  
> +config K3_THERMAL
> +	bool "Texas Instruments K3 thermal support"

Hi,
Why is this bool and not tristate?

> +	depends on THERMAL
> +	depends on ARCH_K3 || COMPILE_TEST
> +	help
> +	  If you say yes here you get thermal support for the Texas Instruments
> +	  K3 SoC family. The current chip supported is:
> +	   - AM654
> +
> +	  This includes temperature reading functionality and also trend
> +	  computation.
> +
>  config MAX77620_THERMAL
>  	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
>  	depends on MFD_MAX77620

> diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
> new file mode 100644
> index 000000000000..35d904eb9857
> --- /dev/null
> +++ b/drivers/thermal/k3_bandgap.c
> @@ -0,0 +1,342 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TI Bandgap temperature sensor driver for K3 SoC Family
> + *
> + * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
> + */

> +static int k3_bgp_read_temp(struct k3_thermal_data *devdata,
> +			    int *temp)
> +{
> +	struct k3_bandgap *bgp;
> +	unsigned int dtemp, s0, s1, s2;
> +
> +	bgp = devdata->bgp;
> +	/**

"/**" is used to indicate kernel-doc notation in the Linux kernel source files,
but this comment is not kernel-doc notation, so please just use "/*".

> +	 * Errata is applicable for am654 pg 1.0 silicon. There
> +	 * is a variation of the order for 8-10 degree centigrade.
> +	 * Work around that by getting the average of two closest
> +	 * readings out of three readings everytime we want to
> +	 * report temperatures.
> +	 *
> +	 * Errata workaround.
> +	 */
thanks.
-- 
~Randy

