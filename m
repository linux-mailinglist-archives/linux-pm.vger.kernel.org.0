Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBAA8A0202
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 14:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfH1Mk2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 08:40:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:53769 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfH1Mk1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Aug 2019 08:40:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 05:40:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="210152703"
Received: from deyangko-mobl.ccr.corp.intel.com ([10.249.168.35])
  by fmsmga002.fm.intel.com with ESMTP; 28 Aug 2019 05:40:23 -0700
Message-ID: <63b8753a2a58688e75f6e03c46c84a064a123d85.camel@intel.com>
Subject: Re: [PATCH v5 03/18] thermal: fix indentation in makefile
From:   Zhang Rui <rui.zhang@intel.com>
To:     Yangtao Li <tiny.windzz@gmail.com>, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 28 Aug 2019 20:40:33 +0800
In-Reply-To: <20190810052829.6032-4-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
         <20190810052829.6032-4-tiny.windzz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 2019-08-10 at 05:28 +0000, Yangtao Li wrote:
> To unify code style.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

the later patches in this series does not change Makefile.
So this seems to be a cleanup patch independent of this patch set.
It's better to remove this patch from this patch series.

thanks,
rui
> ---
>  drivers/thermal/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index fa6f8b206281..d7eafb5ef8ef 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -5,7 +5,7 @@
>  
>  obj-$(CONFIG_THERMAL)		+= thermal_sys.o
>  thermal_sys-y			+= thermal_core.o
> thermal_sysfs.o \
> -					thermal_helpers.o
> +				   thermal_helpers.o
>  
>  # interface to/from other layers providing sensors
>  thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
> @@ -25,11 +25,11 @@ thermal_sys-$(CONFIG_CPU_THERMAL)	+=
> cpu_cooling.o
>  thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
>  
>  # devfreq cooling
> -thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
> +thermal_sys-$(CONFIG_DEVFREQ_THERMAL) 	+= devfreq_cooling.o
>  
>  # platform thermal drivers
>  obj-y				+= broadcom/
> -obj-$(CONFIG_THERMAL_MMIO)		+= thermal_mmio.o
> +obj-$(CONFIG_THERMAL_MMIO)	+= thermal_mmio.o
>  obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
>  obj-$(CONFIG_SUN8I_THERMAL)     += sun8i_thermal.o
>  obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
> @@ -50,7 +50,7 @@ obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-
> thermal/
>  obj-y				+= st/
>  obj-$(CONFIG_QCOM_TSENS)	+= qcom/
>  obj-y				+= tegra/
> -obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
> +obj-$(CONFIG_HISI_THERMAL)     	+= hisi_thermal.o
>  obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
>  obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
>  obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o

