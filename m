Return-Path: <linux-pm+bounces-37025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C21C1A7D4
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 14:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E4D1A250E8
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 12:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F29634AB1F;
	Wed, 29 Oct 2025 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ksgt5AE3"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796CF260587;
	Wed, 29 Oct 2025 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741458; cv=none; b=PK/Fvy1grGfK/Eh/QjgLKkY+qYjXVl03TpPGmiU7dUnYtAz+gHOGj2uP/4NzlhNIIeNjwEmjmE7mom4hM1FU0uK2hhB9oQbTEekn9XmYzqwl5F5FTNM14ZbhHF5oyhM3a06Ouz8EeY2aDUgte2YyKNRylVxTUZ22FZmACk4vTY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741458; c=relaxed/simple;
	bh=aBlvhZqE5Mmg42yQ4WWw23XOm6ZaGxEnXmDPRJhmCII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMLC0HRzTcBgEhDPUzwgIc5ibYPtaIFCfW0vHA7chbPVgP/merK0kD+zV4TwJHebfQEdBgjD4VPsnCh+A1W1HcZikEjvIuCMWnLQ6RFd85GNyKzP/a3OWH8rV/q9DEQ2x8cXMe3QSfktcYbYbb3g4hRcBEztUD1srQk6aLtJBCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ksgt5AE3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761741452;
	bh=aBlvhZqE5Mmg42yQ4WWw23XOm6ZaGxEnXmDPRJhmCII=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ksgt5AE3M7/68eZLxLHKNy4Qr1XZx6XTYsMiNJm4rVp+twygGlZu4LYLvmDdcQUIR
	 B8kftJExfJbHmCguplr0552OX1mLEEGEwqN8qf62sTAPuQJFOjFDnYCD2OIrKacMWK
	 Upg1QfUEugJr4D8i/9iuW9247FZz+0GB+E+Eh5f3QxDGqSt3cCIoiPANQfRHiF3j/8
	 GT7UjgpM/C52edU/qZC4jWxHMEDkE5mpF2ZjSKrozfuxJtyEAUcX6fS97s/kl9k+L/
	 odwxehDx0zNKOfXCD+BOeD+8KyxarpIJUwuxio5P9gy1Uegglw9Cu/4WbEJ/ghsNm3
	 6HGw1wC4glfZw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C8E3A17E013C;
	Wed, 29 Oct 2025 13:37:31 +0100 (CET)
Message-ID: <3f9cba56-609f-43cf-ab38-5c9f6bcd4e49@collabora.com>
Date: Wed, 29 Oct 2025 13:37:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] clk: mediatek: Add clock drivers for MT8189 SoC
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Qiqi Wang <qiqi.wang@mediatek.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, netdev@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
References: <20250818115754.1067154-1-irving-ch.lin@mediatek.com>
 <20250818115754.1067154-6-irving-ch.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250818115754.1067154-6-irving-ch.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/08/25 13:57, irving.ch.lin ha scritto:
> From: Irving-ch Lin <irving-ch.lin@mediatek.com>
> 
> Introduce a new clock (clk) driver port for the MediaTek
> MT8189 SoC. The driver is newly implemented based on the hardware
> layout and register settings of the MT8189 chip, enabling correct clk
> management and operation for various modules.
> 
> Signed-off-by: Irving-ch Lin <irving-ch.lin@mediatek.com>
> ---
>   drivers/clk/mediatek/Kconfig                 |  146 +++
>   drivers/clk/mediatek/Makefile                |   14 +
>   drivers/clk/mediatek/clk-mt8189-apmixedsys.c |  135 +++
>   drivers/clk/mediatek/clk-mt8189-bus.c        |  289 +++++
>   drivers/clk/mediatek/clk-mt8189-cam.c        |  131 +++
>   drivers/clk/mediatek/clk-mt8189-dbgao.c      |  115 ++
>   drivers/clk/mediatek/clk-mt8189-dvfsrc.c     |   61 +
>   drivers/clk/mediatek/clk-mt8189-iic.c        |  149 +++
>   drivers/clk/mediatek/clk-mt8189-img.c        |  122 ++
>   drivers/clk/mediatek/clk-mt8189-mdpsys.c     |  100 ++
>   drivers/clk/mediatek/clk-mt8189-mfg.c        |   56 +
>   drivers/clk/mediatek/clk-mt8189-mmsys.c      |  233 ++++
>   drivers/clk/mediatek/clk-mt8189-scp.c        |   92 ++
>   drivers/clk/mediatek/clk-mt8189-topckgen.c   | 1059 ++++++++++++++++++
>   drivers/clk/mediatek/clk-mt8189-ufs.c        |  106 ++
>   drivers/clk/mediatek/clk-mt8189-vcodec.c     |  119 ++
>   drivers/clk/mediatek/clk-mt8189-vlpcfg.c     |  145 +++
>   drivers/clk/mediatek/clk-mt8189-vlpckgen.c   |  280 +++++
>   drivers/clk/mediatek/clk-mux.c               |    4 +
>   19 files changed, 3356 insertions(+)
>   create mode 100644 drivers/clk/mediatek/clk-mt8189-apmixedsys.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8189-bus.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8189-cam.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8189-dbgao.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8189-dvfsrc.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8189-iic.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8189-img.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8189-mdpsys.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8189-mfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8189-mmsys.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8189-scp.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8189-topckgen.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8189-ufs.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8189-vcodec.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8189-vlpcfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8189-vlpckgen.c
> 
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 5f8e6d68fa14..c7ad75b090d3 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -815,6 +815,152 @@ config COMMON_CLK_MT8188_WPESYS
>   	help
>   	  This driver supports MediaTek MT8188 Warp Engine clocks.
>   
> +config COMMON_CLK_MT8189
> +	bool "Clock driver for MediaTek MT8189"
> +	depends on ARM64 || COMPILE_TEST
> +	select COMMON_CLK_MEDIATEK
> +	select COMMON_CLK_MEDIATEK_FHCTL
> +	default ARCH_MEDIATEK
> +	help
> +	  Enable this option to support the clock management for MediaTek MT8189 SoC. This
> +	  includes handling of all primary clock functions and features specific to the MT8189
> +	  platform. Enabling this driver ensures that the system's clock functionality aligns
> +	  with the MediaTek MT8189 hardware capabilities, providing efficient management of
> +	  clock speeds and power consumption.
> +
> +config COMMON_CLK_MT8189_BUS
> +	tristate "Clock driver for MediaTek MT8189 bus"
> +	depends on COMMON_CLK_MT8189
> +	default COMMON_CLK_MT8189
> +	help
> +	  Enable this configuration option to support the clock framework for
> +	  MediaTek MT8189 SoC bus clocks. It includes the necessary clock
> +	  management for bus-related peripherals and interconnects within the
> +	  MT8189 chipset, ensuring that all bus-related components receive the
> +	  correct clock signals for optimal performance.
> +
> +config COMMON_CLK_MT8189_CAM
> +	tristate "Clock driver for MediaTek MT8189 cam"
> +	depends on COMMON_CLK_MT8189
> +	default COMMON_CLK_MT8189
> +	help
> +	  Enable this to support the clock management for the camera interface
> +	  on MediaTek MT8189 SoCs. This includes enabling, disabling, and
> +	  setting the rate for camera-related clocks. If you have a camera
> +	  that relies on this SoC and you want to control its clocks, say Y or M
> +	  to include this driver in your kernel build.
> +
> +config COMMON_CLK_MT8189_DBGAO
> +	tristate "Clock driver for MediaTek MT8189 debug ao"
> +	depends on COMMON_CLK_MT8189
> +	default COMMON_CLK_MT8189
> +	help
> +	  Enable this to support the clock management for the debug function
> +	  on MediaTek MT8189 SoCs. This includes enabling and disabling
> +	  vcore debug system clocks. If you want to control its clocks, say Y or M
> +	  to include this driver in your kernel build.
> +
> +config COMMON_CLK_MT8189_DVFSRC
> +	tristate "Clock driver for MediaTek MT8189 dvfsrc"
> +	depends on COMMON_CLK_MT8189
> +	default COMMON_CLK_MT8189
> +	help
> +	  Enable this to support the clock management for the dvfsrc
> +	  on MediaTek MT8189 SoCs. This includes enabling and disabling
> +	  vcore dvfs clocks. If you want to control its clocks, say Y or M
> +	  to include this driver in your kernel build.
> +
> +config COMMON_CLK_MT8189_IIC
> +	tristate "Clock driver for MediaTek MT8189 iic"
> +	depends on COMMON_CLK_MT8189
> +	default COMMON_CLK_MT8189
> +	help
> +	  Enable this option to support the clock framework for MediaTek MT8189
> +	  integrated circuits (iic). This driver is responsible for managing
> +	  clock sources, dividers, and gates specifically designed for MT8189
> +	  SoCs. Enabling this driver ensures that the system can correctly
> +	  manage clock frequencies and power for various components within
> +	  the MT8189 chipset, improving the overall performance and power
> +	  efficiency of the device.
> +
> +config COMMON_CLK_MT8189_IMG
> +	tristate "Clock driver for MediaTek MT8189 img"
> +	depends on COMMON_CLK_MT8189
> +	default COMMON_CLK_MT8189
> +	help
> +	  Enable this to support the clock framework for MediaTek MT8189 SoC's
> +	  image processing units. This includes clocks necessary for the operation
> +	  of image-related hardware blocks such as ISP, VENC, and VDEC. If you
> +	  are building a kernel for a device that uses the MT8189 SoC and requires
> +	  image processing capabilities, say Y or M to include this driver.
> +
> +config COMMON_CLK_MT8189_MDPSYS
> +	tristate "Clock driver for MediaTek MT8189 mdpsys"
> +	depends on COMMON_CLK_MT8189
> +	default COMMON_CLK_MT8189
> +	help
> +	  This driver supports the display system clocks on the MediaTek MT8189
> +	  SoC. By enabling this option, it allows for the control of the clocks
> +	  related to the display subsystem. This is crucial for the proper
> +	  functionality of the display features on devices powered by the MT8189
> +	  chipset, ensuring that the display system operates efficiently and
> +	  effectively.
> +
> +config COMMON_CLK_MT8189_MFG
> +	tristate "Clock driver for MediaTek MT8189 mfg"
> +	depends on COMMON_CLK_MT8189
> +	default COMMON_CLK_MT8189
> +	help
> +	  Enable this option to support the manufacturing clocks for the MediaTek
> +	  MT8189 chipset. This driver provides the necessary clock framework
> +	  integration for manufacturing tests and operations that are specific to
> +	  the MT8189 chipset. Enabling this will allow the manufacturing mode of
> +	  the chipset to function correctly with the appropriate clock settings.
> +
> +config COMMON_CLK_MT8189_MMSYS
> +	tristate "Clock driver for MediaTek MT8189 mmsys"
> +	depends on COMMON_CLK_MT8189
> +	default COMMON_CLK_MT8189
> +	help
> +	  Enable this to support the clock framework for MediaTek MT8189
> +	  multimedia systems (mmsys). This driver is responsible for managing
> +	  the clocks for various multimedia components within the SoC, such as
> +	  video, audio, and image processing units. Enabling this option will
> +	  ensure that these components receive the correct clock frequencies
> +	  for proper operation.
> +
> +config COMMON_CLK_MT8189_SCP
> +	tristate "Clock driver for MediaTek MT8189 scp"
> +	depends on COMMON_CLK_MT8189
> +	default COMMON_CLK_MT8189
> +	help
> +	  Enable this to support the clock framework for the System Control
> +	  Processor (SCP) in the MediaTek MT8189 SoC. This includes clock
> +	  management for SCP-related features, ensuring proper clock
> +	  distribution and gating for power efficiency and functionality.
> +
> +config COMMON_CLK_MT8189_UFS
> +	tristate "Clock driver for MediaTek MT8189 ufs"
> +	depends on COMMON_CLK_MT8189
> +	default COMMON_CLK_MT8189
> +	help
> +	  Enable this to support the clock management for the Universal Flash
> +	  Storage (UFS) interface on MediaTek MT8189 SoCs. This includes
> +	  clock sources, dividers, and gates that are specific to the UFS
> +	  feature of the MT8189 platform. It is recommended to enable this
> +	  option if the system includes a UFS device that relies on the MT8189
> +	  SoC for clock management.
> +
> +config COMMON_CLK_MT8189_VCODEC
> +	tristate "Clock driver for MediaTek MT8189 vcodec"
> +	depends on COMMON_CLK_MT8189
> +	default COMMON_CLK_MT8189
> +	help
> +	  This driver supports the video codec (VCODEC) clocks on the MediaTek
> +	  MT8189 SoCs. Enabling this option will allow the system to manage
> +	  clocks required for the operation of hardware video encoding and
> +	  decoding features provided by the VCODEC unit of the MT8189 platform.
> +
>   config COMMON_CLK_MT8192
>   	tristate "Clock driver for MediaTek MT8192"
>   	depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 6efec95406bd..96b3643ff507 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -123,6 +123,20 @@ obj-$(CONFIG_COMMON_CLK_MT8188_VDOSYS) += clk-mt8188-vdo0.o clk-mt8188-vdo1.o
>   obj-$(CONFIG_COMMON_CLK_MT8188_VENCSYS) += clk-mt8188-venc.o
>   obj-$(CONFIG_COMMON_CLK_MT8188_VPPSYS) += clk-mt8188-vpp0.o clk-mt8188-vpp1.o
>   obj-$(CONFIG_COMMON_CLK_MT8188_WPESYS) += clk-mt8188-wpe.o
> +obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o clk-mt8189-topckgen.o \
> +				   clk-mt8189-vlpckgen.o clk-mt8189-vlpcfg.o
> +obj-$(CONFIG_COMMON_CLK_MT8189_BUS) += clk-mt8189-bus.o
> +obj-$(CONFIG_COMMON_CLK_MT8189_CAM) += clk-mt8189-cam.o
> +obj-$(CONFIG_COMMON_CLK_MT8189_DBGAO) += clk-mt8189-dbgao.o
> +obj-$(CONFIG_COMMON_CLK_MT8189_DVFSRC) += clk-mt8189-dvfsrc.o
> +obj-$(CONFIG_COMMON_CLK_MT8189_IIC) += clk-mt8189-iic.o
> +obj-$(CONFIG_COMMON_CLK_MT8189_IMG) += clk-mt8189-img.o
> +obj-$(CONFIG_COMMON_CLK_MT8189_MDPSYS) += clk-mt8189-mdpsys.o
> +obj-$(CONFIG_COMMON_CLK_MT8189_MFG) += clk-mt8189-mfg.o
> +obj-$(CONFIG_COMMON_CLK_MT8189_MMSYS) += clk-mt8189-mmsys.o
> +obj-$(CONFIG_COMMON_CLK_MT8189_SCP) += clk-mt8189-scp.o
> +obj-$(CONFIG_COMMON_CLK_MT8189_UFS) += clk-mt8189-ufs.o
> +obj-$(CONFIG_COMMON_CLK_MT8189_VCODEC) += clk-mt8189-vcodec.o
>   obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
>   obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
>   obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt8189-apmixedsys.c b/drivers/clk/mediatek/clk-mt8189-apmixedsys.c
> new file mode 100644
> index 000000000000..1c22a2b8f787
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-apmixedsys.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + * Author: Qiqi Wang <qiqi.wang@mediatek.com>
> + */
> +

..snip..

> +
> +static const struct of_device_id of_match_clk_mt8189_apmixed[] = {
> +	{ .compatible = "mediatek,mt8189-apmixedsys" },
> +	{ /* sentinel */ }
> +};
> +
> +static int clk_mt8189_apmixed_probe(struct platform_device *pdev)
> +{
> +	int r;
> +	struct clk_hw_onecell_data *clk_data;
> +	struct device_node *node = pdev->dev.of_node;
> +
> +	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);

Where is FHCTL?! This SoC supports it. What's the reason why you ignored it?

> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	r = mtk_clk_register_plls(node, apmixed_plls,
> +				  ARRAY_SIZE(apmixed_plls), clk_data);
> +	if (r)
> +		goto free_apmixed_data;
> +
> +	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +	if (r)
> +		goto unregister_plls;
> +
> +	platform_set_drvdata(pdev, clk_data);
> +
> +	return 0;
> +
> +unregister_plls:
> +	mtk_clk_unregister_plls(apmixed_plls, ARRAY_SIZE(apmixed_plls),
> +				clk_data);
> +free_apmixed_data:
> +	mtk_free_clk_data(clk_data);
> +	return r;
> +}
> +
> +static struct platform_driver clk_mt8189_apmixed_drv = {
> +	.probe = clk_mt8189_apmixed_probe,
> +	.driver = {
> +		.name = "clk-mt8189-apmixed",
> +		.of_match_table = of_match_clk_mt8189_apmixed,
> +	},
> +};
> +
> +module_platform_driver(clk_mt8189_apmixed_drv);
> +MODULE_LICENSE("GPL");

..snip..

> diff --git a/drivers/clk/mediatek/clk-mt8189-img.c b/drivers/clk/mediatek/clk-mt8189-img.c
> new file mode 100644
> index 000000000000..97f9257294b4
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-img.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + * Author: Qiqi Wang <qiqi.wang@mediatek.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +
> +#include <dt-bindings/clock/mt8189-clk.h>
> +
> +static const struct mtk_gate_regs imgsys1_cg_regs = {
> +	.set_ofs = 0x4,
> +	.clr_ofs = 0x8,
> +	.sta_ofs = 0x0,
> +};
> +
> +#define GATE_IMGSYS1(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &imgsys1_cg_regs,		\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr,	\
> +		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\

Drop flags.

> +	}
> +
> +static const struct mtk_gate imgsys1_clks[] = {
> +	GATE_IMGSYS1(CLK_IMGSYS1_LARB9, "imgsys1_larb9", "img1_sel", 0),
> +	GATE_IMGSYS1(CLK_IMGSYS1_LARB11, "imgsys1_larb11", "img1_sel", 1),
> +	GATE_IMGSYS1(CLK_IMGSYS1_DIP, "imgsys1_dip", "img1_sel", 2),
> +	GATE_IMGSYS1(CLK_IMGSYS1_GALS, "imgsys1_gals", "img1_sel", 12),
> +};
> +
> +static const struct mtk_clk_desc imgsys1_mcd = {
> +	.clks = imgsys1_clks,
> +	.num_clks = CLK_IMGSYS1_NR_CLK,
> +};
> +
> +static const struct mtk_gate_regs imgsys2_cg_regs = {
> +	.set_ofs = 0x4,
> +	.clr_ofs = 0x8,
> +	.sta_ofs = 0x0,
> +};
> +
> +#define GATE_IMGSYS2(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &imgsys2_cg_regs,		\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr,	\
> +		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\

Drop flags.

> +	}
> +
> +static const struct mtk_gate imgsys2_clks[] = {
> +	GATE_IMGSYS2(CLK_IMGSYS2_LARB9, "imgsys2_larb9", "img1_sel", 0),
> +	GATE_IMGSYS2(CLK_IMGSYS2_LARB11, "imgsys2_larb11", "img1_sel", 1),
> +	GATE_IMGSYS2(CLK_IMGSYS2_MFB, "imgsys2_mfb", "img1_sel", 6),
> +	GATE_IMGSYS2(CLK_IMGSYS2_WPE, "imgsys2_wpe", "img1_sel", 7),
> +	GATE_IMGSYS2(CLK_IMGSYS2_MSS, "imgsys2_mss", "img1_sel", 8),
> +	GATE_IMGSYS2(CLK_IMGSYS2_GALS, "imgsys2_gals", "img1_sel", 12),
> +};
> +
> +static const struct mtk_clk_desc imgsys2_mcd = {
> +	.clks = imgsys2_clks,
> +	.num_clks = CLK_IMGSYS2_NR_CLK,
> +};
> +
> +static const struct mtk_gate_regs ipe_cg_regs = {
> +	.set_ofs = 0x4,
> +	.clr_ofs = 0x8,
> +	.sta_ofs = 0x0,
> +};
> +
> +#define GATE_IPE(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &ipe_cg_regs,			\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr,	\
> +		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\

Drop flags.

> +	}
> +
> +static const struct mtk_gate ipe_clks[] = {
> +	GATE_IPE(CLK_IPE_LARB19, "ipe_larb19", "ipe_sel", 0),
> +	GATE_IPE(CLK_IPE_LARB20, "ipe_larb20", "ipe_sel", 1),
> +	GATE_IPE(CLK_IPE_SMI_SUBCOM, "ipe_smi_subcom", "ipe_sel", 2),
> +	GATE_IPE(CLK_IPE_FD, "ipe_fd", "ipe_sel", 3),
> +	GATE_IPE(CLK_IPE_FE, "ipe_fe", "ipe_sel", 4),
> +	GATE_IPE(CLK_IPE_RSC, "ipe_rsc", "ipe_sel", 5),
> +	GATE_IPE(CLK_IPESYS_GALS, "ipesys_gals", "ipe_sel", 8),
> +};
> +
> +static const struct mtk_clk_desc ipe_mcd = {
> +	.clks = ipe_clks,
> +	.num_clks = CLK_IPE_NR_CLK,
> +};
> +
> +static const struct of_device_id of_match_clk_mt8189_img[] = {
> +	{ .compatible = "mediatek,mt8189-imgsys1", .data = &imgsys1_mcd },
> +	{ .compatible = "mediatek,mt8189-imgsys2", .data = &imgsys2_mcd },
> +	{ .compatible = "mediatek,mt8189-ipesys", .data = &ipe_mcd },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver clk_mt8189_img_drv = {
> +	.probe = mtk_clk_simple_probe,
> +	.driver = {
> +		.name = "clk-mt8189-img",
> +		.of_match_table = of_match_clk_mt8189_img,
> +	},
> +};
> +
> +module_platform_driver(clk_mt8189_img_drv);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mt8189-mdpsys.c b/drivers/clk/mediatek/clk-mt8189-mdpsys.c
> new file mode 100644
> index 000000000000..9f20d6578032
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-mdpsys.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + * Author: Qiqi Wang <qiqi.wang@mediatek.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +
> +#include <dt-bindings/clock/mt8189-clk.h>

mediatek,mt8189-clk.h

> +
> +static const struct mtk_gate_regs mdp0_cg_regs = {
> +	.set_ofs = 0x104,
> +	.clr_ofs = 0x108,
> +	.sta_ofs = 0x100,
> +};
> +
> +static const struct mtk_gate_regs mdp1_cg_regs = {
> +	.set_ofs = 0x114,
> +	.clr_ofs = 0x118,
> +	.sta_ofs = 0x110,
> +};
> +
> +#define GATE_MDP0(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &mdp0_cg_regs,			\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr,	\
> +		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\

Drop flags.

> +	}
> +
> +#define GATE_MDP1(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &mdp1_cg_regs,			\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr,	\
> +		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\

Drop flags.

> +	}
> +
> +static const struct mtk_gate mdp_clks[] = {
> +	/* MDP0 */
> +	GATE_MDP0(CLK_MDP_MUTEX0, "mdp_mutex0", "mdp0_sel", 0),
> +	GATE_MDP0(CLK_MDP_APB_BUS, "mdp_apb_bus", "mdp0_sel", 1),
> +	GATE_MDP0(CLK_MDP_SMI0, "mdp_smi0", "mdp0_sel", 2),
> +	GATE_MDP0(CLK_MDP_RDMA0, "mdp_rdma0", "mdp0_sel", 3),
> +	GATE_MDP0(CLK_MDP_RDMA2, "mdp_rdma2", "mdp0_sel", 4),
> +	GATE_MDP0(CLK_MDP_HDR0, "mdp_hdr0", "mdp0_sel", 5),
> +	GATE_MDP0(CLK_MDP_AAL0, "mdp_aal0", "mdp0_sel", 6),
> +	GATE_MDP0(CLK_MDP_RSZ0, "mdp_rsz0", "mdp0_sel", 7),
> +	GATE_MDP0(CLK_MDP_TDSHP0, "mdp_tdshp0", "mdp0_sel", 8),
> +	GATE_MDP0(CLK_MDP_COLOR0, "mdp_color0", "mdp0_sel", 9),
> +	GATE_MDP0(CLK_MDP_WROT0, "mdp_wrot0", "mdp0_sel", 10),
> +	GATE_MDP0(CLK_MDP_FAKE_ENG0, "mdp_fake_eng0", "mdp0_sel", 11),
> +	GATE_MDP0(CLK_MDPSYS_CONFIG, "mdpsys_config", "mdp0_sel", 14),
> +	GATE_MDP0(CLK_MDP_RDMA1, "mdp_rdma1", "mdp0_sel", 15),
> +	GATE_MDP0(CLK_MDP_RDMA3, "mdp_rdma3", "mdp0_sel", 16),
> +	GATE_MDP0(CLK_MDP_HDR1, "mdp_hdr1", "mdp0_sel", 17),
> +	GATE_MDP0(CLK_MDP_AAL1, "mdp_aal1", "mdp0_sel", 18),
> +	GATE_MDP0(CLK_MDP_RSZ1, "mdp_rsz1", "mdp0_sel", 19),
> +	GATE_MDP0(CLK_MDP_TDSHP1, "mdp_tdshp1", "mdp0_sel", 20),
> +	GATE_MDP0(CLK_MDP_COLOR1, "mdp_color1", "mdp0_sel", 21),
> +	GATE_MDP0(CLK_MDP_WROT1, "mdp_wrot1", "mdp0_sel", 22),
> +	GATE_MDP0(CLK_MDP_RSZ2, "mdp_rsz2", "mdp0_sel", 24),
> +	GATE_MDP0(CLK_MDP_WROT2, "mdp_wrot2", "mdp0_sel", 25),
> +	GATE_MDP0(CLK_MDP_RSZ3, "mdp_rsz3", "mdp0_sel", 28),
> +	GATE_MDP0(CLK_MDP_WROT3, "mdp_wrot3", "mdp0_sel", 29),
> +	/* MDP1 */
> +	GATE_MDP1(CLK_MDP_BIRSZ0, "mdp_birsz0", "mdp0_sel", 3),
> +	GATE_MDP1(CLK_MDP_BIRSZ1, "mdp_birsz1", "mdp0_sel", 4),
> +};
> +
> +static const struct mtk_clk_desc mdp_mcd = {
> +	.clks = mdp_clks,
> +	.num_clks = CLK_MDP_NR_CLK,
> +};
> +
> +static const struct of_device_id of_match_clk_mt8189_mdpsys[] = {
> +	{ .compatible = "mediatek,mt8189-mdpsys", .data = &mdp_mcd },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver clk_mt8189_mdpsys_drv = {
> +	.probe = mtk_clk_simple_probe,
> +	.driver = {
> +		.name = "clk-mt8189-mdpsys",
> +		.of_match_table = of_match_clk_mt8189_mdpsys,
> +	},
> +};
> +
> +module_platform_driver(clk_mt8189_mdpsys_drv);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mt8189-mfg.c b/drivers/clk/mediatek/clk-mt8189-mfg.c
> new file mode 100644
> index 000000000000..8bb9965031aa
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-mfg.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + * Author: Qiqi Wang <qiqi.wang@mediatek.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +
> +#include <dt-bindings/clock/mt8189-clk.h>

mediatek,mt8189-clk.h

> +
> +static const struct mtk_gate_regs mfg_cg_regs = {
> +	.set_ofs = 0x4,
> +	.clr_ofs = 0x8,
> +	.sta_ofs = 0x0,
> +};
> +
> +#define GATE_MFG(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &mfg_cg_regs,			\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr,	\
> +		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\

Drop flags.

> +	}
> +
> +static const struct mtk_gate mfg_clks[] = {
> +	GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "mfg_sel_mfgpll", 0),
> +};
> +
> +static const struct mtk_clk_desc mfg_mcd = {
> +	.clks = mfg_clks,
> +	.num_clks = CLK_MFG_NR_CLK,
> +};
> +
> +static const struct of_device_id of_match_clk_mt8189_mfg[] = {
> +	{ .compatible = "mediatek,mt8189-mfgcfg", .data = &mfg_mcd },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver clk_mt8189_mfg_drv = {
> +	.probe = mtk_clk_simple_probe,
> +	.driver = {
> +		.name = "clk-mt8189-mfg",
> +		.of_match_table = of_match_clk_mt8189_mfg,
> +	},
> +};
> +
> +module_platform_driver(clk_mt8189_mfg_drv);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mt8189-mmsys.c b/drivers/clk/mediatek/clk-mt8189-mmsys.c
> new file mode 100644
> index 000000000000..497aeac80c25
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-mmsys.c

clk-mt8189-dispsys

> @@ -0,0 +1,233 @@

..snip..

> +static const struct mtk_gate_regs gce_m_cg_regs = {
> +	.set_ofs = 0x0,
> +	.clr_ofs = 0x0,
> +	.sta_ofs = 0x0,
> +};
> +
> +#define GATE_GCE_M(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &gce_m_cg_regs,			\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_no_setclr,	\
> +		.flags = CLK_OPS_PARENT_ENABLE,		\
> +	}
> +
> +static const struct mtk_gate gce_m_clks[] = {
> +	GATE_GCE_M(CLK_GCE_M_TOP, "gce_m_top", "mminfra_gce_m", 16),
> +};
> +
> +static const struct mtk_clk_desc gce_m_mcd = {
> +	.clks = gce_m_clks,
> +	.num_clks = CLK_GCE_M_NR_CLK,
> +};
> +
> +static const struct mtk_gate_regs mminfra_config0_cg_regs = {
> +	.set_ofs = 0x104,
> +	.clr_ofs = 0x108,
> +	.sta_ofs = 0x100,
> +};
> +
> +static const struct mtk_gate_regs mminfra_config1_cg_regs = {
> +	.set_ofs = 0x114,
> +	.clr_ofs = 0x118,
> +	.sta_ofs = 0x110,
> +};

config0 -> 0x4, 0x8, 0x0
config1 -> 0x14, 0x18, 0x10

> +
> +#define GATE_MMINFRA_CONFIG0(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &mminfra_config0_cg_regs,		\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr,	\
> +		.flags = CLK_OPS_PARENT_ENABLE,		\
> +	}
> +
> +#define GATE_MMINFRA_CONFIG1(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &mminfra_config1_cg_regs,		\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr,	\
> +		.flags = CLK_OPS_PARENT_ENABLE,		\
> +	}
> +
> +static const struct mtk_gate mminfra_config_clks[] = {
> +	/* MMINFRA_CONFIG0 */
> +	GATE_MMINFRA_CONFIG0(CLK_MMINFRA_GCE_D, "mminfra_gce_d",
> +			     "mminfra_sel", 0),
> +	GATE_MMINFRA_CONFIG0(CLK_MMINFRA_GCE_M, "mminfra_gce_m",
> +			     "mminfra_sel", 1),
> +	GATE_MMINFRA_CONFIG0(CLK_MMINFRA_SMI, "mminfra_smi",
> +			     "mminfra_sel", 2),
> +	/* MMINFRA_CONFIG1 */
> +	GATE_MMINFRA_CONFIG1(CLK_MMINFRA_GCE_26M, "mminfra_gce_26m",
> +			     "mminfra_sel", 17),
> +};
> +
> +static const struct mtk_clk_desc mminfra_config_mcd = {
> +	.clks = mminfra_config_clks,
> +	.num_clks = CLK_MMINFRA_CONFIG_NR_CLK,
> +};
> +
> +static const struct of_device_id of_match_clk_mt8189_mmsys[] = {
> +	{
> +		.compatible = "mediatek,mt8189-dispsys",
> +		.data = &mm_mcd
> +	}, {
> +		.compatible = "mediatek,mt8189-gce-d",
> +		.data = &gce_d_mcd
> +	}, {
> +		.compatible = "mediatek,mt8189-gce-m",
> +		.data = &gce_m_mcd
> +	}, {
> +		.compatible = "mediatek,mt8189-mm-infra",
> +		.data = &mminfra_config_mcd

Each entry fits in one line.

> +	}, {
> +		/* sentinel */
> +	}
> +};
> +
> +static struct platform_driver clk_mt8189_mmsys_drv = {
> +	.probe = mtk_clk_simple_probe,
> +	.driver = {
> +		.name = "clk-mt8189-mmsys",

clk-mt8189-dispsys

> +		.of_match_table = of_match_clk_mt8189_mmsys,
> +	},
> +};
> +
> +module_platform_driver(clk_mt8189_mmsys_drv);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mt8189-scp.c b/drivers/clk/mediatek/clk-mt8189-scp.c
> new file mode 100644
> index 000000000000..01ffe7016931
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-scp.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + * Author: Qiqi Wang <qiqi.wang@mediatek.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +
> +#include <dt-bindings/clock/mt8189-clk.h>
> +
> +static const struct mtk_gate_regs scp_cg_regs = {
> +	.set_ofs = 0x154,
> +	.clr_ofs = 0x158,
> +	.sta_ofs = 0x154,
> +};

This doesn't feel right, as much as the ones at 0xe10 - define those as
0x4, 0x8, 0x4 - and define the iic ones as 0x8, 0x4, 0x0.

Use devicetree to define the right MMIO for those clock controllers.

> +
> +#define GATE_SCP(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &scp_cg_regs,			\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr_inv,	\
> +		.flags = CLK_OPS_PARENT_ENABLE,		\
> +	}
> +
> +static const struct mtk_gate scp_clks[] = {
> +	GATE_SCP(CLK_SCP_SET_SPI0, "scp_set_spi0", "clk26m", 0),
> +	GATE_SCP(CLK_SCP_SET_SPI1, "scp_set_spi1", "clk26m", 1),
> +};
> +
> +static const struct mtk_clk_desc scp_mcd = {
> +	.clks = scp_clks,
> +	.num_clks = CLK_SCP_NR_CLK,
> +};
> +
> +static const struct mtk_gate_regs scp_iic_cg_regs = {
> +	.set_ofs = 0xE18,
> +	.clr_ofs = 0xE14,
> +	.sta_ofs = 0xE10,
> +};
> +
> +#define GATE_SCP_IIC(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &scp_iic_cg_regs,		\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr_inv,	\
> +		.flags = CLK_OPS_PARENT_ENABLE,		\
> +	}
> +
> +static const struct mtk_gate scp_iic_clks[] = {
> +	GATE_SCP_IIC(CLK_SCP_IIC_I2C0_W1S, "scp_iic_i2c0_w1s",
> +		     "vlp_scp_iic_sel", 0),
> +	GATE_SCP_IIC(CLK_SCP_IIC_I2C1_W1S, "scp_iic_i2c1_w1s",
> +		     "vlp_scp_iic_sel", 1),
> +};
> +
> +static const struct mtk_clk_desc scp_iic_mcd = {
> +	.clks = scp_iic_clks,
> +	.num_clks = CLK_SCP_IIC_NR_CLK,
> +};
> +
> +static const struct of_device_id of_match_clk_mt8189_scp[] = {
> +	{
> +		.compatible = "mediatek,mt8189-scp-clk",
> +		.data = &scp_mcd
> +	}, {
> +		.compatible = "mediatek,mt8189-scp-i2c-clk",
> +		.data = &scp_iic_mcd
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +
> +static struct platform_driver clk_mt8189_scp_drv = {
> +	.probe = mtk_clk_simple_probe,
> +	.driver = {
> +		.name = "clk-mt8189-scp",
> +		.of_match_table = of_match_clk_mt8189_scp,
> +	},
> +};
> +
> +module_platform_driver(clk_mt8189_scp_drv);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mt8189-topckgen.c b/drivers/clk/mediatek/clk-mt8189-topckgen.c
> new file mode 100644
> index 000000000000..9573ea2d9dd6
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-topckgen.c
> @@ -0,0 +1,1059 @@

..snip..

> +
> +static const struct mtk_fixed_clk top_fixed_clks[] = {
> +	FIXED_CLK(CLK_TOP_VOWPLL, "vowpll_ck", NULL, 26000000),

This has to be defined in the devicetree with compatible = "fixed-clock" and
not in the driver. Also, just "vowpll" please.

Also, is this a PLL or what?! If this is a PLL, it has to be defined as such,
as PLLs need locking, etc, for rate changes et al (so not in DT as fixed clock).

> +};
> +

..snip..

> +
> +#define GATE_TOP(_id, _name, _parent, _shift)		\
> +	GATE_TOP_FLAGS(_id, _name, _parent, _shift, 0)
> +
> +static const struct mtk_gate top_clks[] = {
> +	GATE_TOP_FLAGS(CLK_TOP_FMCNT_P0_EN, "fmcnt_p0_en",
> +		       "univpll_192m_d4", 0, CLK_IS_CRITICAL),
> +	GATE_TOP_FLAGS(CLK_TOP_FMCNT_P1_EN, "fmcnt_p1_en",
> +		       "univpll_192m_d4", 1, CLK_IS_CRITICAL),
> +	GATE_TOP_FLAGS(CLK_TOP_FMCNT_P2_EN, "fmcnt_p2_en",
> +		       "univpll_192m_d4", 2, CLK_IS_CRITICAL),
> +	GATE_TOP_FLAGS(CLK_TOP_FMCNT_P3_EN, "fmcnt_p3_en",
> +		       "univpll_192m_d4", 3, CLK_IS_CRITICAL),
> +	GATE_TOP_FLAGS(CLK_TOP_FMCNT_P4_EN, "fmcnt_p4_en",
> +		       "univpll_192m_d4", 4, CLK_IS_CRITICAL),
> +	GATE_TOP_FLAGS(CLK_TOP_USB_F26M_CK_EN, "ssusb_f26m",
> +		       "clk26m", 5, CLK_IS_CRITICAL),
> +	GATE_TOP_FLAGS(CLK_TOP_SSPXTP_F26M_CK_EN, "sspxtp_f26m",
> +		       "clk26m", 6, CLK_IS_CRITICAL),
> +	GATE_TOP(CLK_TOP_USB2_PHY_RF_P0_EN, "usb2_phy_rf_p0_en",
> +		 "clk26m", 7),
> +	GATE_TOP(CLK_TOP_USB2_PHY_RF_P1_EN, "usb2_phy_rf_p1_en",
> +		 "clk26m", 10),
> +	GATE_TOP(CLK_TOP_USB2_PHY_RF_P2_EN, "usb2_phy_rf_p2_en",
> +		 "clk26m", 11),
> +	GATE_TOP(CLK_TOP_USB2_PHY_RF_P3_EN, "usb2_phy_rf_p3_en",
> +		 "clk26m", 12),
> +	GATE_TOP(CLK_TOP_USB2_PHY_RF_P4_EN, "usb2_phy_rf_p4_en",
> +		 "clk26m", 13),
> +	GATE_TOP_FLAGS(CLK_TOP_USB2_26M_CK_P0_EN, "usb2_26m_p0_en",
> +		       "clk26m", 14, CLK_IS_CRITICAL),
> +	GATE_TOP_FLAGS(CLK_TOP_USB2_26M_CK_P1_EN, "usb2_26m_p1_en",
> +		       "clk26m", 15, CLK_IS_CRITICAL),
> +	GATE_TOP_FLAGS(CLK_TOP_USB2_26M_CK_P2_EN, "usb2_26m_p2_en",
> +		       "clk26m", 18, CLK_IS_CRITICAL),
> +	GATE_TOP_FLAGS(CLK_TOP_USB2_26M_CK_P3_EN, "usb2_26m_p3_en",
> +		       "clk26m", 19, CLK_IS_CRITICAL),
> +	GATE_TOP_FLAGS(CLK_TOP_USB2_26M_CK_P4_EN, "usb2_26m_p4_en",
> +		       "clk26m", 20, CLK_IS_CRITICAL),

Why are all of the USB clocks always-on?!
Doesn't look right. USB should not be a critical function of the SoC, and those
clocks should be enabled by the USB driver instead.

> +	GATE_TOP(CLK_TOP_F26M_CK_EN, "pcie_f26m",
> +		 "clk26m", 21),
> +	GATE_TOP_FLAGS(CLK_TOP_AP2CON_EN, "ap2con",
> +		       "clk26m", 24, CLK_IS_CRITICAL),
> +	GATE_TOP_FLAGS(CLK_TOP_EINT_N_EN, "eint_n",
> +		       "clk26m", 25, CLK_IS_CRITICAL),
> +	GATE_TOP_FLAGS(CLK_TOP_TOPCKGEN_FMIPI_CSI_UP26M_CK_EN,
> +		       "TOPCKGEN_fmipi_csi_up26m",
> +		       "osc_d10", 26, CLK_IS_CRITICAL),
> +	GATE_TOP_FLAGS(CLK_TOP_EINT_E_EN, "eint_e",
> +		       "clk26m", 28, CLK_IS_CRITICAL),
> +	GATE_TOP_FLAGS(CLK_TOP_EINT_W_EN, "eint_w",
> +		       "clk26m", 30, CLK_IS_CRITICAL),
> +	GATE_TOP_FLAGS(CLK_TOP_EINT_S_EN, "eint_s",
> +		       "clk26m", 31, CLK_IS_CRITICAL),
> +};
> +
> +/* Register mux notifier for MFG mux */
> +static int clk_mt8189_reg_mfg_mux_notifier(struct device *dev,
> +					   struct clk *clk)
> +{
> +	struct mtk_mux_nb *mfg_mux_nb;
> +
> +	mfg_mux_nb = devm_kzalloc(dev, sizeof(*mfg_mux_nb), GFP_KERNEL);
> +	if (!mfg_mux_nb)
> +		return -ENOMEM;
> +
> +	mfg_mux_nb->ops = &mtk_mux_clr_set_upd_ops;
> +	mfg_mux_nb->bypass_index = 0; /* Bypass to CLK_TOP_MFG_REF_SEL */
> +
> +	return devm_mtk_clk_mux_notifier_register(dev, clk, mfg_mux_nb);
> +}
> +
> +static const struct mtk_clk_desc topck_desc = {
> +	.fixed_clks = top_fixed_clks,
> +	.num_fixed_clks = ARRAY_SIZE(top_fixed_clks),
> +	.factor_clks = top_divs,
> +	.num_factor_clks = ARRAY_SIZE(top_divs),
> +	.mux_clks = top_muxes,
> +	.num_mux_clks = ARRAY_SIZE(top_muxes),
> +	.composite_clks = top_composites,
> +	.num_composite_clks = ARRAY_SIZE(top_composites),
> +	.clks = top_clks,
> +	.num_clks = ARRAY_SIZE(top_clks),
> +	.clk_notifier_func = clk_mt8189_reg_mfg_mux_notifier,
> +	.mfg_clk_idx = CLK_TOP_MFG_SEL_MFGPLL,
> +	.clk_lock = &mt8189_clk_lock,
> +};
> +
> +static const struct of_device_id of_match_clk_mt8189_topck[] = {
> +	{ .compatible = "mediatek,mt8189-topckgen", .data = &topck_desc },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver clk_mt8189_topck_drv = {
> +	.probe = mtk_clk_simple_probe,
> +	.driver = {
> +		.name = "clk-mt8189-topck",
> +		.of_match_table = of_match_clk_mt8189_topck,
> +	},
> +};
> +
> +module_platform_driver(clk_mt8189_topck_drv);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mt8189-ufs.c b/drivers/clk/mediatek/clk-mt8189-ufs.c
> new file mode 100644
> index 000000000000..6eb49c545ffb
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-ufs.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + * Author: Qiqi Wang <qiqi.wang@mediatek.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +
> +#include <dt-bindings/clock/mt8189-clk.h>

mediatek,mt8189-clk.h

> +
> +static const struct mtk_gate_regs ufscfg_ao_reg_cg_regs = {
> +	.set_ofs = 0x8,
> +	.clr_ofs = 0xC,

lower case hex.

> +	.sta_ofs = 0x4,
> +};
> +
> +#define GATE_UFSCFG_AO_REG(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &ufscfg_ao_reg_cg_regs,		\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr,	\
> +		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
> +	}
> +
> +static const struct mtk_gate ufscfg_ao_reg_clks[] = {
> +	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_TX_SYM,
> +			   "ufscfg_ao_unipro_tx_sym", "clk26m", 1),
> +	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM0,
> +			   "ufscfg_ao_unipro_rx_sym0", "clk26m", 2),
> +	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM1,
> +			   "ufscfg_ao_unipro_rx_sym1", "clk26m", 3),
> +	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_SYS,
> +			   "ufscfg_ao_unipro_sys", "ufs_sel", 4),
> +	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_U_SAP_CFG,
> +			   "ufscfg_ao_u_sap_cfg", "clk26m", 5),
> +	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_U_PHY_TOP_AHB_S_BUS,
> +			   "ufscfg_ao_u_phy_ahb_s_bus", "axi_u_sel", 6),
> +};
> +
> +static const struct mtk_clk_desc ufscfg_ao_reg_mcd = {
> +	.clks = ufscfg_ao_reg_clks,
> +	.num_clks = CLK_UFSCFG_AO_REG_NR_CLK,
> +};
> +
> +static const struct mtk_gate_regs ufscfg_pdn_reg_cg_regs = {
> +	.set_ofs = 0x8,
> +	.clr_ofs = 0xC,

lower case hex.

> +	.sta_ofs = 0x4,
> +};
> +
> +#define GATE_UFSCFG_PDN_REG(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &ufscfg_pdn_reg_cg_regs,		\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr,	\
> +		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\

Why are those all CLK_IGNORE_UNUSED? Doesn't feel right.

Also, CLK_OPS_PARENT_ENABLE means that enabling one clock needs the parent
enabled or the SoC crashes. That's not your situation here; drop.

> +	}
> +
> +static const struct mtk_gate ufscfg_pdn_reg_clks[] = {
> +	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_UFS,
> +			    "ufscfg_ufshci_ufs", "ufs_sel", 0),
> +	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_AES,
> +			    "ufscfg_ufshci_aes", "aes_ufsfde_sel", 1),
> +	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_U_AHB,
> +			    "ufscfg_ufshci_u_ahb", "axi_u_sel", 3),
> +	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_U_AXI,
> +			    "ufscfg_ufshci_u_axi", "mem_sub_u_sel", 5),
> +};
> +
> +static const struct mtk_clk_desc ufscfg_pdn_reg_mcd = {
> +	.clks = ufscfg_pdn_reg_clks,
> +	.num_clks = CLK_UFSCFG_PDN_REG_NR_CLK,
> +};
> +
> +static const struct of_device_id of_match_clk_mt8189_ufs[] = {
> +	{
> +		.compatible = "mediatek,mt8189-ufscfg-ao",
> +		.data = &ufscfg_ao_reg_mcd

fits in one line.

> +	}, {
> +		.compatible = "mediatek,mt8189-ufscfg-pdn",
> +		.data = &ufscfg_pdn_reg_mcd

same.

> +	}, {
> +		/* sentinel */
> +	}
> +};
> +
> +static struct platform_driver clk_mt8189_ufs_drv = {
> +	.probe = mtk_clk_simple_probe,
> +	.driver = {
> +		.name = "clk-mt8189-ufs",
> +		.of_match_table = of_match_clk_mt8189_ufs,
> +	},
> +};
> +
> +module_platform_driver(clk_mt8189_ufs_drv);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mt8189-vcodec.c b/drivers/clk/mediatek/clk-mt8189-vcodec.c
> new file mode 100644
> index 000000000000..1827eac9ee83
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-vcodec.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + * Author: Qiqi Wang <qiqi.wang@mediatek.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +
> +#include <dt-bindings/clock/mt8189-clk.h>
> +
> +static const struct mtk_gate_regs vdec_core0_cg_regs = {
> +	.set_ofs = 0x0,
> +	.clr_ofs = 0x4,
> +	.sta_ofs = 0x0,
> +};
> +
> +static const struct mtk_gate_regs vdec_core1_cg_regs = {
> +	.set_ofs = 0x8,
> +	.clr_ofs = 0xC,

lower case hex.

> +	.sta_ofs = 0x8,
> +};
> +
> +#define GATE_VDEC_CORE0(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &vdec_core0_cg_regs,		\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr_inv,	\
> +		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\

Why are those all CLK_IGNORE_UNUSED? Doesn't feel right.

Also, CLK_OPS_PARENT_ENABLE means that enabling one clock needs the parent
enabled or the SoC crashes. That's not your situation here; drop.

> +	}
> +
> +#define GATE_VDEC_CORE1(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &vdec_core1_cg_regs,		\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr_inv,	\
> +		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
> +	}
> +
> +static const struct mtk_gate vdec_core_clks[] = {
> +	/* VDEC_CORE0 */
> +	GATE_VDEC_CORE0(CLK_VDEC_CORE_VDEC_CKEN, "vdec_core_vdec_cken",
> +			"vdec_sel", 0),
> +	GATE_VDEC_CORE0(CLK_VDEC_CORE_VDEC_ACTIVE, "vdec_core_vdec_active",
> +			"vdec_sel", 4),
> +	/* VDEC_CORE1 */
> +	GATE_VDEC_CORE1(CLK_VDEC_CORE_LARB_CKEN, "vdec_core_larb_cken",
> +			"vdec_sel", 0),
> +};
> +
> +static const struct mtk_clk_desc vdec_core_mcd = {
> +	.clks = vdec_core_clks,
> +	.num_clks = CLK_VDEC_CORE_NR_CLK,
> +};
> +
> +static const struct mtk_gate_regs ven1_cg_regs = {
> +	.set_ofs = 0x4,
> +	.clr_ofs = 0x8,
> +	.sta_ofs = 0x0,
> +};
> +
> +#define GATE_VEN1(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &ven1_cg_regs,			\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr_inv,	\
> +		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
> +	}
> +
> +static const struct mtk_gate ven1_clks[] = {
> +	GATE_VEN1(CLK_VEN1_CKE0_LARB, "ven1_larb", "venc_sel", 0),
> +	GATE_VEN1(CLK_VEN1_CKE1_VENC, "ven1_venc", "venc_sel", 4),
> +	GATE_VEN1(CLK_VEN1_CKE2_JPGENC, "ven1_jpgenc", "venc_sel", 8),
> +	GATE_VEN1(CLK_VEN1_CKE3_JPGDEC, "ven1_jpgdec", "venc_sel", 12),
> +	GATE_VEN1(CLK_VEN1_CKE4_JPGDEC_C1, "ven1_jpgdec_c1",
> +		  "venc_sel", 16),

fits in one line.

> +	GATE_VEN1(CLK_VEN1_CKE5_GALS, "ven1_gals", "venc_sel", 28),
> +	GATE_VEN1(CLK_VEN1_CKE6_GALS_SRAM, "ven1_gals_sram",
> +		  "venc_sel", 31),

same.

> +};
> +
> +static const struct mtk_clk_desc ven1_mcd = {
> +	.clks = ven1_clks,
> +	.num_clks = CLK_VEN1_NR_CLK,
> +};
> +
> +static const struct of_device_id of_match_clk_mt8189_vcodec[] = {
> +	{
> +		.compatible = "mediatek,mt8189-vdec-core",
> +		.data = &vdec_core_mcd
> +	}, {
> +		.compatible = "mediatek,mt8189-venc",
> +		.data = &ven1_mcd
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +
> +static struct platform_driver clk_mt8189_vcodec_drv = {
> +	.probe = mtk_clk_simple_probe,
> +	.driver = {
> +		.name = "clk-mt8189-vcodec",

This definitely is not "vcodec"... what's the real name of this HW block?
is it VCP?

clk_mt8189_vcp_drv, of_match_clk_mt8189_vcp, "clk-mt8189-vcp", etc.

> +		.of_match_table = of_match_clk_mt8189_vcodec,
> +	},
> +};
> +
> +module_platform_driver(clk_mt8189_vcodec_drv);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mt8189-vlpcfg.c b/drivers/clk/mediatek/clk-mt8189-vlpcfg.c
> new file mode 100644
> index 000000000000..f8fa3acd7318
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-vlpcfg.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + * Author: Qiqi Wang <qiqi.wang@mediatek.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +
> +#include <dt-bindings/clock/mt8189-clk.h>
> +
> +static const struct mtk_gate_regs vlpcfg_ao_reg_cg_regs = {
> +	.set_ofs = 0x800,
> +	.clr_ofs = 0x800,
> +	.sta_ofs = 0x800,

Hmm. This doesn't look like being a clock... is it?!

Besides, you are defining two compatibles, so - if this is really a clock,

.{set,clr.sta}_ofs = 0x0

...because your "reg" MMIO in DT can have the offset instead.

Reason for this is that you really should not use the entire MMIO space of
this IP for its clock controller - as the clock controller is located at
vlpcfg_ao base + 0x800 - and before that there are other registers that are
not related to the clock controller, but to something else, and may be used
by other future drivers.

Besides, I repeat my concern: is that "EN" really a clock? It really, really,
really doesn't seem to be one.

> +};
> +
> +#define GATE_VLPCFG_AO_REG(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &vlpcfg_ao_reg_cg_regs,		\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_no_setclr,	\
> +	}
> +
> +static const struct mtk_gate vlpcfg_ao_reg_clks[] = {
> +	GATE_VLPCFG_AO_REG(EN, "en", "clk26m", 8),
> +};
> +
> +static const struct mtk_clk_desc vlpcfg_ao_reg_mcd = {
> +	.clks = vlpcfg_ao_reg_clks,
> +	.num_clks = CLK_VLPCFG_AO_REG_NR_CLK,
> +};
> +
> +static const struct mtk_gate_regs vlpcfg_reg_cg_regs = {
> +	.set_ofs = 0x4,
> +	.clr_ofs = 0x4,
> +	.sta_ofs = 0x4,
> +};
> +
> +#define GATE_VLPCFG_REG_FLAGS(_id, _name, _parent, _shift, _flags) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &vlpcfg_reg_cg_regs,		\
> +		.shift = _shift,			\
> +		.flags = _flags,			\
> +		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
> +	}
> +
> +#define GATE_VLPCFG_REG(_id, _name, _parent, _shift)		\
> +	GATE_VLPCFG_REG_FLAGS(_id, _name, _parent, _shift, 0)
> +
> +static const struct mtk_gate vlpcfg_reg_clks[] = {
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SCP, "vlpcfg_scp_ck",

Please drop all those "_ck" suffixes. Those stand for "clock", and they're stating
the obvious.

> +			      "vlp_scp_sel", 28, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_RG_R_APXGPT_26M,
> +			      "vlpcfg_r_apxgpt_26m_ck",
> +			      "clk26m", 24, CLK_IS_CRITICAL),

..snip..

> +
> +static const struct mtk_clk_desc vlpcfg_reg_mcd = {
> +	.clks = vlpcfg_reg_clks,
> +	.num_clks = CLK_VLPCFG_REG_NR_CLK,
> +};
> +
> +static const struct of_device_id of_match_clk_mt8189_vlpcfg[] = {
> +	{
> +		.compatible = "mediatek,mt8189-vlp-ao-ckgen",

"mediatek,mt8189-vlp-ao"

> +		.data = &vlpcfg_ao_reg_mcd
> +	}, {
> +		.compatible = "mediatek,mt8189-vlpcfg-reg-bus",

It's not a bus, it's a clock controller.

"mediatek,mt8189-vlpcfg-ao"

> +		.data = &vlpcfg_reg_mcd

Also, each entry fits in one line. Please compress. Up to 100 columns it's ok.

> +	}, {
> +		/* sentinel */
> +	}
> +};
> +
> +static struct platform_driver clk_mt8189_vlpcfg_drv = {
> +	.probe = mtk_clk_simple_probe,
> +	.driver = {
> +		.name = "clk-mt8189-vlpcfg",
> +		.of_match_table = of_match_clk_mt8189_vlpcfg,
> +	},
> +};
> +
> +module_platform_driver(clk_mt8189_vlpcfg_drv);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mt8189-vlpckgen.c b/drivers/clk/mediatek/clk-mt8189-vlpckgen.c
> new file mode 100644
> index 000000000000..7016152c7844
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-vlpckgen.c
> @@ -0,0 +1,280 @@

> +#include "clk-gate.h"
> +
> +#include <dt-bindings/clock/mt8189-clk.h>

mediatek,mt8189-clk.h

> +};
> +
> +static const struct mtk_gate_regs vlp_ck_cg_regs = {
> +	.set_ofs = 0x1F4,
> +	.clr_ofs = 0x1F8,
> +	.sta_ofs = 0x1F0,

lower case hex please.

> +};
> +
> +#define GATE_VLP_CK_FLAGS(_id, _name, _parent, _shift, _flag) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &vlp_ck_cg_regs,		\
> +		.shift = _shift,			\
> +		.flags = _flag,				\
> +		.ops = &mtk_clk_gate_ops_setclr_inv,	\
> +	}
> +
> +#define GATE_VLP_CK(_id, _name, _parent, _shift)	\
> +	GATE_VLP_CK_FLAGS(_id, _name, _parent, _shift, 0)
> +
> +static const struct mtk_gate vlp_ck_clks[] = {
> +	GATE_VLP_CK(CLK_VLP_CK_VADSYS_VLP_26M_EN, "vlp_vadsys_vlp_26m",
> +		    "clk26m", 1),
> +	GATE_VLP_CK_FLAGS(CLK_VLP_CK_FMIPI_CSI_UP26M_CK_EN,
> +			  "VLP_fmipi_csi_up26m",
> +			  "osc_d10", 11, CLK_IS_CRITICAL),
> +};
> +
> +static const struct mtk_clk_desc vlpck_desc = {
> +	.mux_clks = vlp_ck_muxes,
> +	.num_mux_clks = ARRAY_SIZE(vlp_ck_muxes),
> +	.clks = vlp_ck_clks,
> +	.num_clks = ARRAY_SIZE(vlp_ck_clks),
> +	.clk_lock = &mt8189_vlpclk_lock,
> +};
> +
> +static const struct of_device_id of_match_clk_mt8189_vlpck[] = {
> +	{ .compatible = "mediatek,mt8189-vlp-ckgen", .data = &vlpck_desc },

mediatek,mt8189-vlpckgen

> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver clk_mt8189_vlpck_drv = {
> +	.probe = mtk_clk_simple_probe,
> +	.driver = {
> +		.name = "clk-mt8189-vlpck",
> +		.of_match_table = of_match_clk_mt8189_vlpck,
> +	},
> +};
> +
> +module_platform_driver(clk_mt8189_vlpck_drv);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
> index 60990296450b..66f483807de9 100644
> --- a/drivers/clk/mediatek/clk-mux.c
> +++ b/drivers/clk/mediatek/clk-mux.c
> @@ -298,16 +298,20 @@ static int mtk_clk_mux_notifier_cb(struct notifier_block *nb,
>   	struct clk_notifier_data *data = _data;
>   	struct clk_hw *hw = __clk_get_hw(data->clk);
>   	struct mtk_mux_nb *mux_nb = to_mtk_mux_nb(nb);
> +	struct clk_hw *p_hw = clk_hw_get_parent_by_index(hw,
> +							 mux_nb->bypass_index);

This change needs a different commit.

>   	int ret = 0;
>   
>   	switch (event) {
>   	case PRE_RATE_CHANGE:
> +		clk_prepare_enable(p_hw->clk);
>   		mux_nb->original_index = mux_nb->ops->get_parent(hw);
>   		ret = mux_nb->ops->set_parent(hw, mux_nb->bypass_index);
>   		break;
>   	case POST_RATE_CHANGE:
>   	case ABORT_RATE_CHANGE:
>   		ret = mux_nb->ops->set_parent(hw, mux_nb->original_index);
> +		clk_disable_unprepare(p_hw->clk);
>   		break;
>   	}
>   


Please apply the comments to all drivers (as I missed some on purpose, because
repeating the same thing over and over is useless).

Regards,
Angelo

