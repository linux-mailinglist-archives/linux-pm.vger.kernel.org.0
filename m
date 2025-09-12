Return-Path: <linux-pm+bounces-34550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98667B54CF3
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 14:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C930188E6E5
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 12:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400393126C5;
	Fri, 12 Sep 2025 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HNzN4pnm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCF73074A1;
	Fri, 12 Sep 2025 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678737; cv=none; b=NJqXPr4Gxx7urMWEYApVw7Ji4xGxD17jle+ah1X0nrd9WQR+tp4P33eTDRjpOoV7YWIEshvSeiOHBGv6bsyKlUCJKlym2GR3iVsILUZIOtFcnm4JYAxL9CvCJmgkRs0ygMq+RgY9Qey4/UOSZ97DcRQCCIRqrwKu4LR7qSO0Mp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678737; c=relaxed/simple;
	bh=62kRCy0Lecwngu5XyJL7Q/h8e6j2Hfo+Zv8tEA/KkEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxhKg0srO1y/bh85UjPaKsrQlXpcwv3i9J2bQiMw6ri//141yq05NYYa3++lrb8Eaywufv/qVygHz6H/9LvsAhkkbIo73tSoYyHlNZ01PX8s5QRZXF/q9dEpanLUsqziUiYEEF9/wcqUo4mGZuBNyBnbbBQmbE5w2eWi35Oj1MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HNzN4pnm; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c1b4de4e8fd011f0bd5779446731db89-20250912
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eHNHsVdRsc/Scpp0WBtSUTtBCe/Tih4JRfZIZp6IZF0=;
	b=HNzN4pnmOpjRelty2s6ncJHpsY007F1RWnZerBaSBtUiAnFlxGHl7kNOun/cWTo3SWhn2hnqv8L7BfqKX2pY94X/y4KasSNYPeAVFqkrclhbVWYhxH43geNGxwIqCx+ZhfpFBoljC/Oq/kJ54RfE7WQOgK/RfX3uctfXITgBEtY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:28df4657-d0e1-428a-bd91-96658f2e7071,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:1ca6b93,CLOUDID:5aec7c6c-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:1,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c1b4de4e8fd011f0bd5779446731db89-20250912
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1207480599; Fri, 12 Sep 2025 20:05:21 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 12 Sep 2025 20:05:19 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 12 Sep 2025 20:05:19 +0800
From: irving.ch.lin <irving-ch.lin@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Richard Cochran <richardcochran@gmail.com>
CC: Qiqi Wang <qiqi.wang@mediatek.com>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <irving-ch.lin@mediatek.com>
Subject: [PATCH v2 3/4] clk: mediatek: Add clock drivers for MT8189 SoC
Date: Fri, 12 Sep 2025 20:04:52 +0800
Message-ID: <20250912120508.3180067-4-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250912120508.3180067-1-irving-ch.lin@mediatek.com>
References: <20250912120508.3180067-1-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Irving-ch Lin <irving-ch.lin@mediatek.com>

Introduce a new clock (clk) driver port for the MediaTek
MT8189 SoC. The driver is newly implemented based on the hardware
layout and register settings of the MT8189 chip, enabling correct clk
management and operation for various modules.

With clock topology, we need to register clock sequence below:
apmixedsys(pll) -> topckgen(div/mux) -> others(cgs)

Signed-off-by: Irving-ch Lin <irving-ch.lin@mediatek.com>
---
 drivers/clk/mediatek/Kconfig                 |  146 +++
 drivers/clk/mediatek/Makefile                |   14 +
 drivers/clk/mediatek/clk-mt8189-apmixedsys.c |  135 +++
 drivers/clk/mediatek/clk-mt8189-bus.c        |  289 +++++
 drivers/clk/mediatek/clk-mt8189-cam.c        |  131 +++
 drivers/clk/mediatek/clk-mt8189-dbgao.c      |  115 ++
 drivers/clk/mediatek/clk-mt8189-dvfsrc.c     |   61 +
 drivers/clk/mediatek/clk-mt8189-iic.c        |  149 +++
 drivers/clk/mediatek/clk-mt8189-img.c        |  122 ++
 drivers/clk/mediatek/clk-mt8189-mdpsys.c     |  100 ++
 drivers/clk/mediatek/clk-mt8189-mfg.c        |   56 +
 drivers/clk/mediatek/clk-mt8189-mmsys.c      |  233 ++++
 drivers/clk/mediatek/clk-mt8189-scp.c        |   92 ++
 drivers/clk/mediatek/clk-mt8189-topckgen.c   | 1057 ++++++++++++++++++
 drivers/clk/mediatek/clk-mt8189-ufs.c        |  106 ++
 drivers/clk/mediatek/clk-mt8189-vcodec.c     |  119 ++
 drivers/clk/mediatek/clk-mt8189-vlpcfg.c     |  145 +++
 drivers/clk/mediatek/clk-mt8189-vlpckgen.c   |  280 +++++
 drivers/clk/mediatek/clk-mux.c               |    4 +
 19 files changed, 3354 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8189-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-bus.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-dbgao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-dvfsrc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-iic.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mdpsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mmsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-scp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-ufs.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vcodec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vlpcfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vlpckgen.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 5f8e6d68fa14..c7ad75b090d3 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -815,6 +815,152 @@ config COMMON_CLK_MT8188_WPESYS
 	help
 	  This driver supports MediaTek MT8188 Warp Engine clocks.
 
+config COMMON_CLK_MT8189
+	bool "Clock driver for MediaTek MT8189"
+	depends on ARM64 || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	select COMMON_CLK_MEDIATEK_FHCTL
+	default ARCH_MEDIATEK
+	help
+	  Enable this option to support the clock management for MediaTek MT8189 SoC. This
+	  includes handling of all primary clock functions and features specific to the MT8189
+	  platform. Enabling this driver ensures that the system's clock functionality aligns
+	  with the MediaTek MT8189 hardware capabilities, providing efficient management of
+	  clock speeds and power consumption.
+
+config COMMON_CLK_MT8189_BUS
+	tristate "Clock driver for MediaTek MT8189 bus"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this configuration option to support the clock framework for
+	  MediaTek MT8189 SoC bus clocks. It includes the necessary clock
+	  management for bus-related peripherals and interconnects within the
+	  MT8189 chipset, ensuring that all bus-related components receive the
+	  correct clock signals for optimal performance.
+
+config COMMON_CLK_MT8189_CAM
+	tristate "Clock driver for MediaTek MT8189 cam"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this to support the clock management for the camera interface
+	  on MediaTek MT8189 SoCs. This includes enabling, disabling, and
+	  setting the rate for camera-related clocks. If you have a camera
+	  that relies on this SoC and you want to control its clocks, say Y or M
+	  to include this driver in your kernel build.
+
+config COMMON_CLK_MT8189_DBGAO
+	tristate "Clock driver for MediaTek MT8189 debug ao"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this to support the clock management for the debug function
+	  on MediaTek MT8189 SoCs. This includes enabling and disabling
+	  vcore debug system clocks. If you want to control its clocks, say Y or M
+	  to include this driver in your kernel build.
+
+config COMMON_CLK_MT8189_DVFSRC
+	tristate "Clock driver for MediaTek MT8189 dvfsrc"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this to support the clock management for the dvfsrc
+	  on MediaTek MT8189 SoCs. This includes enabling and disabling
+	  vcore dvfs clocks. If you want to control its clocks, say Y or M
+	  to include this driver in your kernel build.
+
+config COMMON_CLK_MT8189_IIC
+	tristate "Clock driver for MediaTek MT8189 iic"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this option to support the clock framework for MediaTek MT8189
+	  integrated circuits (iic). This driver is responsible for managing
+	  clock sources, dividers, and gates specifically designed for MT8189
+	  SoCs. Enabling this driver ensures that the system can correctly
+	  manage clock frequencies and power for various components within
+	  the MT8189 chipset, improving the overall performance and power
+	  efficiency of the device.
+
+config COMMON_CLK_MT8189_IMG
+	tristate "Clock driver for MediaTek MT8189 img"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this to support the clock framework for MediaTek MT8189 SoC's
+	  image processing units. This includes clocks necessary for the operation
+	  of image-related hardware blocks such as ISP, VENC, and VDEC. If you
+	  are building a kernel for a device that uses the MT8189 SoC and requires
+	  image processing capabilities, say Y or M to include this driver.
+
+config COMMON_CLK_MT8189_MDPSYS
+	tristate "Clock driver for MediaTek MT8189 mdpsys"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  This driver supports the display system clocks on the MediaTek MT8189
+	  SoC. By enabling this option, it allows for the control of the clocks
+	  related to the display subsystem. This is crucial for the proper
+	  functionality of the display features on devices powered by the MT8189
+	  chipset, ensuring that the display system operates efficiently and
+	  effectively.
+
+config COMMON_CLK_MT8189_MFG
+	tristate "Clock driver for MediaTek MT8189 mfg"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this option to support the manufacturing clocks for the MediaTek
+	  MT8189 chipset. This driver provides the necessary clock framework
+	  integration for manufacturing tests and operations that are specific to
+	  the MT8189 chipset. Enabling this will allow the manufacturing mode of
+	  the chipset to function correctly with the appropriate clock settings.
+
+config COMMON_CLK_MT8189_MMSYS
+	tristate "Clock driver for MediaTek MT8189 mmsys"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this to support the clock framework for MediaTek MT8189
+	  multimedia systems (mmsys). This driver is responsible for managing
+	  the clocks for various multimedia components within the SoC, such as
+	  video, audio, and image processing units. Enabling this option will
+	  ensure that these components receive the correct clock frequencies
+	  for proper operation.
+
+config COMMON_CLK_MT8189_SCP
+	tristate "Clock driver for MediaTek MT8189 scp"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this to support the clock framework for the System Control
+	  Processor (SCP) in the MediaTek MT8189 SoC. This includes clock
+	  management for SCP-related features, ensuring proper clock
+	  distribution and gating for power efficiency and functionality.
+
+config COMMON_CLK_MT8189_UFS
+	tristate "Clock driver for MediaTek MT8189 ufs"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this to support the clock management for the Universal Flash
+	  Storage (UFS) interface on MediaTek MT8189 SoCs. This includes
+	  clock sources, dividers, and gates that are specific to the UFS
+	  feature of the MT8189 platform. It is recommended to enable this
+	  option if the system includes a UFS device that relies on the MT8189
+	  SoC for clock management.
+
+config COMMON_CLK_MT8189_VCODEC
+	tristate "Clock driver for MediaTek MT8189 vcodec"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  This driver supports the video codec (VCODEC) clocks on the MediaTek
+	  MT8189 SoCs. Enabling this option will allow the system to manage
+	  clocks required for the operation of hardware video encoding and
+	  decoding features provided by the VCODEC unit of the MT8189 platform.
+
 config COMMON_CLK_MT8192
 	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 6efec95406bd..96b3643ff507 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -123,6 +123,20 @@ obj-$(CONFIG_COMMON_CLK_MT8188_VDOSYS) += clk-mt8188-vdo0.o clk-mt8188-vdo1.o
 obj-$(CONFIG_COMMON_CLK_MT8188_VENCSYS) += clk-mt8188-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8188_VPPSYS) += clk-mt8188-vpp0.o clk-mt8188-vpp1.o
 obj-$(CONFIG_COMMON_CLK_MT8188_WPESYS) += clk-mt8188-wpe.o
+obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o clk-mt8189-topckgen.o \
+				   clk-mt8189-vlpckgen.o clk-mt8189-vlpcfg.o
+obj-$(CONFIG_COMMON_CLK_MT8189_BUS) += clk-mt8189-bus.o
+obj-$(CONFIG_COMMON_CLK_MT8189_CAM) += clk-mt8189-cam.o
+obj-$(CONFIG_COMMON_CLK_MT8189_DBGAO) += clk-mt8189-dbgao.o
+obj-$(CONFIG_COMMON_CLK_MT8189_DVFSRC) += clk-mt8189-dvfsrc.o
+obj-$(CONFIG_COMMON_CLK_MT8189_IIC) += clk-mt8189-iic.o
+obj-$(CONFIG_COMMON_CLK_MT8189_IMG) += clk-mt8189-img.o
+obj-$(CONFIG_COMMON_CLK_MT8189_MDPSYS) += clk-mt8189-mdpsys.o
+obj-$(CONFIG_COMMON_CLK_MT8189_MFG) += clk-mt8189-mfg.o
+obj-$(CONFIG_COMMON_CLK_MT8189_MMSYS) += clk-mt8189-mmsys.o
+obj-$(CONFIG_COMMON_CLK_MT8189_SCP) += clk-mt8189-scp.o
+obj-$(CONFIG_COMMON_CLK_MT8189_UFS) += clk-mt8189-ufs.o
+obj-$(CONFIG_COMMON_CLK_MT8189_VCODEC) += clk-mt8189-vcodec.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-apmixedsys.c b/drivers/clk/mediatek/clk-mt8189-apmixedsys.c
new file mode 100644
index 000000000000..12ce502cdfac
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-apmixedsys.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "clk-mtk.h"
+#include "clk-pll.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+#define MT8189_PLL_FMAX		(3800UL * MHZ)
+#define MT8189_PLL_FMIN		(1500UL * MHZ)
+#define MT8189_PLLEN_OFS	0x70
+#define MT8189_INTEGER_BITS	8
+
+#define PLL_SETCLR(_id, _name, _reg, _en_setclr_bit,		\
+			_rstb_setclr_bit, _flags, _pd_reg,	\
+			_pd_shift, _tuner_reg, _tuner_en_reg,	\
+			_tuner_en_bit, _pcw_reg, _pcw_shift,	\
+			_pcwbits) {				\
+		.id = _id,					\
+		.name = _name,					\
+		.en_reg = MT8189_PLLEN_OFS,			\
+		.reg = _reg,					\
+		.pll_en_bit = _en_setclr_bit,			\
+		.rst_bar_mask = BIT(_rstb_setclr_bit),		\
+		.flags = _flags,				\
+		.fmax = MT8189_PLL_FMAX,			\
+		.fmin = MT8189_PLL_FMIN,			\
+		.pd_reg = _pd_reg,				\
+		.pd_shift = _pd_shift,				\
+		.tuner_reg = _tuner_reg,			\
+		.tuner_en_reg = _tuner_en_reg,			\
+		.tuner_en_bit = _tuner_en_bit,			\
+		.pcw_reg = _pcw_reg,				\
+		.pcw_shift = _pcw_shift,			\
+		.pcwbits = _pcwbits,				\
+		.pcwibits = MT8189_INTEGER_BITS,		\
+	}
+
+static const struct mtk_pll_data apmixed_plls[] = {
+	PLL_SETCLR(CLK_APMIXED_ARMPLL_LL, "armpll-ll", 0x204, 18,
+		   0, PLL_AO, 0x208, 24, 0, 0, 0, 0x208, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_ARMPLL_BL, "armpll-bl", 0x214, 17,
+		   0, PLL_AO, 0x218, 24, 0, 0, 0, 0x218, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_CCIPLL, "ccipll", 0x224, 16,
+		   0, PLL_AO, 0x228, 24, 0, 0, 0, 0x228, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MAINPLL, "mainpll", 0x304, 15,
+		   23, HAVE_RST_BAR | PLL_AO,
+		   0x308, 24, 0, 0, 0, 0x308, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_UNIVPLL, "univpll", 0x314, 14,
+		   23, HAVE_RST_BAR, 0x318, 24, 0, 0, 0, 0x318, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MMPLL, "mmpll", 0x324, 13,
+		   23, HAVE_RST_BAR, 0x328, 24, 0, 0, 0, 0x328, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MFGPLL, "mfgpll", 0x504, 7,
+		   0, 0, 0x508, 24, 0, 0, 0, 0x508, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_APLL1, "apll1", 0x404, 11,
+		   0, 0, 0x408, 24, 0x040, 0x00C, 0, 0x40C, 0, 32),
+	PLL_SETCLR(CLK_APMIXED_APLL2, "apll2", 0x418, 10,
+		   0, 0, 0x41C, 24, 0x044, 0x00C, 1, 0x420, 0, 32),
+	PLL_SETCLR(CLK_APMIXED_EMIPLL, "emipll", 0x334, 12,
+		   0, PLL_AO, 0x338, 24, 0, 0, 0, 0x338, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_APUPLL2, "apupll2", 0x614, 2,
+		   0, 0, 0x618, 24, 0, 0, 0, 0x618, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_APUPLL, "apupll", 0x604, 3,
+		   0, 0, 0x608, 24, 0, 0, 0, 0x608, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_TVDPLL1, "tvdpll1", 0x42C, 9,
+		   0, 0, 0x430, 24, 0, 0, 0, 0x430, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_TVDPLL2, "tvdpll2", 0x43C, 8,
+		   0, 0, 0x440, 24, 0, 0, 0, 0x440, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_ETHPLL, "ethpll", 0x514, 6,
+		   0, 0, 0x518, 24, 0, 0, 0, 0x518, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MSDCPLL, "msdcpll", 0x524, 5,
+		   0, 0, 0x528, 24, 0, 0, 0, 0x528, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_UFSPLL, "ufspll", 0x534, 4,
+		   0, 0, 0x538, 24, 0, 0, 0, 0x538, 0, 22),
+};
+
+static const struct of_device_id of_match_clk_mt8189_apmixed[] = {
+	{ .compatible = "mediatek,mt8189-apmixedsys" },
+	{ /* sentinel */ }
+};
+
+static int clk_mt8189_apmixed_probe(struct platform_device *pdev)
+{
+	int r;
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+
+	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(apmixed_plls));
+	if (!clk_data)
+		return -ENOMEM;
+
+	r = mtk_clk_register_plls(node, apmixed_plls,
+				  ARRAY_SIZE(apmixed_plls), clk_data);
+	if (r)
+		goto free_apmixed_data;
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r)
+		goto unregister_plls;
+
+	platform_set_drvdata(pdev, clk_data);
+
+	return 0;
+
+unregister_plls:
+	mtk_clk_unregister_plls(apmixed_plls, ARRAY_SIZE(apmixed_plls),
+				clk_data);
+free_apmixed_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static struct platform_driver clk_mt8189_apmixed_drv = {
+	.probe = clk_mt8189_apmixed_probe,
+	.driver = {
+		.name = "clk-mt8189-apmixed",
+		.of_match_table = of_match_clk_mt8189_apmixed,
+	},
+};
+
+module_platform_driver(clk_mt8189_apmixed_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-bus.c b/drivers/clk/mediatek/clk-mt8189-bus.c
new file mode 100644
index 000000000000..a803ab1dce21
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-bus.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static const struct mtk_gate_regs ifrao0_cg_regs = {
+	.set_ofs = 0x80,
+	.clr_ofs = 0x84,
+	.sta_ofs = 0x90,
+};
+
+static const struct mtk_gate_regs ifrao1_cg_regs = {
+	.set_ofs = 0x88,
+	.clr_ofs = 0x8C,
+	.sta_ofs = 0x94,
+};
+
+static const struct mtk_gate_regs ifrao2_cg_regs = {
+	.set_ofs = 0xA4,
+	.clr_ofs = 0xA8,
+	.sta_ofs = 0xAC,
+};
+
+#define GATE_IFRAO0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ifrao0_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_IFRAO1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ifrao1_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_IFRAO2(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ifrao2_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate ifrao_clks[] = {
+	/* IFRAO0 */
+	GATE_IFRAO0(CLK_IFRAO_CQ_DMA_FPC, "ifrao_dma", "clk26m", 28),
+	/* IFRAO1 */
+	GATE_IFRAO1(CLK_IFRAO_DEBUGSYS, "ifrao_debugsys", "axi_sel", 24),
+	GATE_IFRAO1(CLK_IFRAO_DBG_TRACE, "ifrao_dbg_trace", "axi_sel", 29),
+	/* IFRAO2 */
+	GATE_IFRAO2(CLK_IFRAO_CQ_DMA, "ifrao_cq_dma", "axi_sel", 27),
+};
+
+static const struct mtk_clk_desc ifrao_mcd = {
+	.clks = ifrao_clks,
+	.num_clks = ARRAY_SIZE(ifrao_clks),
+};
+
+static const struct mtk_gate_regs perao0_cg_regs = {
+	.set_ofs = 0x24,
+	.clr_ofs = 0x28,
+	.sta_ofs = 0x10,
+};
+
+static const struct mtk_gate_regs perao1_cg_regs = {
+	.set_ofs = 0x2C,
+	.clr_ofs = 0x30,
+	.sta_ofs = 0x14,
+};
+
+static const struct mtk_gate_regs perao2_cg_regs = {
+	.set_ofs = 0x34,
+	.clr_ofs = 0x38,
+	.sta_ofs = 0x18,
+};
+
+#define GATE_PERAO0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &perao0_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_PERAO1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &perao1_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_PERAO2(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &perao2_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate perao_clks[] = {
+	/* PERAO0 */
+	GATE_PERAO0(CLK_PERAO_UART0, "perao_uart0", "uart_sel", 0),
+	GATE_PERAO0(CLK_PERAO_UART1, "perao_uart1", "uart_sel", 1),
+	GATE_PERAO0(CLK_PERAO_UART2, "perao_uart2", "uart_sel", 2),
+	GATE_PERAO0(CLK_PERAO_UART3, "perao_uart3", "uart_sel", 3),
+	GATE_PERAO0(CLK_PERAO_PWM_H, "perao_pwm_h", "axi_peri_sel", 4),
+	GATE_PERAO0(CLK_PERAO_PWM_B, "perao_pwm_b", "pwm_sel", 5),
+	GATE_PERAO0(CLK_PERAO_PWM_FB1, "perao_pwm_fb1", "pwm_sel", 6),
+	GATE_PERAO0(CLK_PERAO_PWM_FB2, "perao_pwm_fb2", "pwm_sel", 7),
+	GATE_PERAO0(CLK_PERAO_PWM_FB3, "perao_pwm_fb3", "pwm_sel", 8),
+	GATE_PERAO0(CLK_PERAO_PWM_FB4, "perao_pwm_fb4", "pwm_sel", 9),
+	GATE_PERAO0(CLK_PERAO_DISP_PWM0, "perao_disp_pwm0",
+		    "disp_pwm_sel", 10),
+	GATE_PERAO0(CLK_PERAO_DISP_PWM1, "perao_disp_pwm1",
+		    "disp_pwm_sel", 11),
+	GATE_PERAO0(CLK_PERAO_SPI0_B, "perao_spi0_b", "spi0_sel", 12),
+	GATE_PERAO0(CLK_PERAO_SPI1_B, "perao_spi1_b", "spi1_sel", 13),
+	GATE_PERAO0(CLK_PERAO_SPI2_B, "perao_spi2_b", "spi2_sel", 14),
+	GATE_PERAO0(CLK_PERAO_SPI3_B, "perao_spi3_b", "spi3_sel", 15),
+	GATE_PERAO0(CLK_PERAO_SPI4_B, "perao_spi4_b", "spi4_sel", 16),
+	GATE_PERAO0(CLK_PERAO_SPI5_B, "perao_spi5_b", "spi5_sel", 17),
+	GATE_PERAO0(CLK_PERAO_SPI0_H, "perao_spi0_h", "axi_peri_sel", 18),
+	GATE_PERAO0(CLK_PERAO_SPI1_H, "perao_spi1_h", "axi_peri_sel", 19),
+	GATE_PERAO0(CLK_PERAO_SPI2_H, "perao_spi2_h", "axi_peri_sel", 20),
+	GATE_PERAO0(CLK_PERAO_SPI3_H, "perao_spi3_h", "axi_peri_sel", 21),
+	GATE_PERAO0(CLK_PERAO_SPI4_H, "perao_spi4_h", "axi_peri_sel", 22),
+	GATE_PERAO0(CLK_PERAO_SPI5_H, "perao_spi5_h", "axi_peri_sel", 23),
+	GATE_PERAO0(CLK_PERAO_AXI, "perao_axi", "mem_sub_peri_sel", 24),
+	GATE_PERAO0(CLK_PERAO_AHB_APB, "perao_ahb_apb",
+		    "axi_peri_sel", 25),
+	GATE_PERAO0(CLK_PERAO_TL, "perao_tl", "pcie_mac_tl_sel", 26),
+	GATE_PERAO0(CLK_PERAO_REF, "perao_ref", "clk26m", 27),
+	GATE_PERAO0(CLK_PERAO_I2C, "perao_i2c", "axi_peri_sel", 28),
+	GATE_PERAO0(CLK_PERAO_DMA_B, "perao_dma_b", "axi_peri_sel", 29),
+	/* PERAO1 */
+	GATE_PERAO1(CLK_PERAO_SSUSB0_REF, "perao_ssusb0_ref",
+		    "clk26m", 1),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_FRMCNT, "perao_ssusb0_frmcnt",
+		    "univpll_192m_d4", 2),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_SYS, "perao_ssusb0_sys",
+		    "usb_p0_sel", 4),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_XHCI, "perao_ssusb0_xhci",
+		    "ssusb_xhci_p0_sel", 5),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_F, "perao_ssusb0_f",
+		    "axi_peri_sel", 6),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_H, "perao_ssusb0_h",
+		    "axi_peri_sel", 7),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_REF, "perao_ssusb1_ref",
+		    "clk26m", 8),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_FRMCNT, "perao_ssusb1_frmcnt",
+		    "univpll_192m_d4", 9),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_SYS, "perao_ssusb1_sys",
+		    "usb_p1_sel", 11),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_XHCI, "perao_ssusb1_xhci",
+		    "ssusb_xhci_p1_sel", 12),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_F, "perao_ssusb1_f",
+		    "axi_peri_sel", 13),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_H, "perao_ssusb1_h",
+		    "axi_peri_sel", 14),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_REF, "perao_ssusb2_ref",
+		    "clk26m", 15),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_FRMCNT, "perao_ssusb2_frmcnt",
+		    "univpll_192m_d4", 16),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_SYS, "perao_ssusb2_sys",
+		    "usb_p2_sel", 18),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_XHCI, "perao_ssusb2_xhci",
+		    "ssusb_xhci_p2_sel", 19),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_F, "perao_ssusb2_f",
+		    "axi_peri_sel", 20),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_H, "perao_ssusb2_h",
+		    "axi_peri_sel", 21),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_REF, "perao_ssusb3_ref",
+		    "clk26m", 23),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_FRMCNT, "perao_ssusb3_frmcnt",
+		    "univpll_192m_d4", 24),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_SYS, "perao_ssusb3_sys",
+		    "usb_p3_sel", 26),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_XHCI, "perao_ssusb3_xhci",
+		    "ssusb_xhci_p3_sel", 27),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_F, "perao_ssusb3_f",
+		    "axi_peri_sel", 28),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_H, "perao_ssusb3_h",
+		    "axi_peri_sel", 29),
+	/* PERAO2 */
+	GATE_PERAO2(CLK_PERAO_SSUSB4_REF, "perao_ssusb4_ref",
+		    "clk26m", 0),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_FRMCNT, "perao_ssusb4_frmcnt",
+		    "univpll_192m_d4", 1),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_SYS, "perao_ssusb4_sys",
+		    "usb_p4_sel", 3),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_XHCI, "perao_ssusb4_xhci",
+		    "ssusb_xhci_p4_sel", 4),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_F, "perao_ssusb4_f",
+		    "axi_peri_sel", 5),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_H, "perao_ssusb4_h",
+		    "axi_peri_sel", 6),
+	GATE_PERAO2(CLK_PERAO_MSDC0, "perao_msdc0",
+		    "msdc50_0_sel", 7),
+	GATE_PERAO2(CLK_PERAO_MSDC0_H, "perao_msdc0_h",
+		    "msdc5hclk_sel", 8),
+	GATE_PERAO2(CLK_PERAO_MSDC0_FAES, "perao_msdc0_faes",
+		    "aes_msdcfde_sel", 9),
+	GATE_PERAO2(CLK_PERAO_MSDC0_MST_F, "perao_msdc0_mst_f",
+		    "axi_peri_sel", 10),
+	GATE_PERAO2(CLK_PERAO_MSDC0_SLV_H, "perao_msdc0_slv_h",
+		    "axi_peri_sel", 11),
+	GATE_PERAO2(CLK_PERAO_MSDC1, "perao_msdc1",
+		    "msdc30_1_sel", 12),
+	GATE_PERAO2(CLK_PERAO_MSDC1_H, "perao_msdc1_h",
+		    "msdc30_1_h_sel", 13),
+	GATE_PERAO2(CLK_PERAO_MSDC1_MST_F, "perao_msdc1_mst_f",
+		    "axi_peri_sel", 14),
+	GATE_PERAO2(CLK_PERAO_MSDC1_SLV_H, "perao_msdc1_slv_h",
+		    "axi_peri_sel", 15),
+	GATE_PERAO2(CLK_PERAO_MSDC2, "perao_msdc2",
+		    "msdc30_2_sel", 16),
+	GATE_PERAO2(CLK_PERAO_MSDC2_H, "perao_msdc2_h",
+		    "msdc30_2_h_sel", 17),
+	GATE_PERAO2(CLK_PERAO_MSDC2_MST_F, "perao_msdc2_mst_f",
+		    "axi_peri_sel", 18),
+	GATE_PERAO2(CLK_PERAO_MSDC2_SLV_H, "perao_msdc2_slv_h",
+		    "axi_peri_sel", 19),
+	GATE_PERAO2(CLK_PERAO_SFLASH, "perao_sflash",
+		    "sflash_sel", 20),
+	GATE_PERAO2(CLK_PERAO_SFLASH_F, "perao_sflash_f",
+		    "axi_peri_sel", 21),
+	GATE_PERAO2(CLK_PERAO_SFLASH_H, "perao_sflash_h",
+		    "axi_peri_sel", 22),
+	GATE_PERAO2(CLK_PERAO_SFLASH_P, "perao_sflash_p",
+		    "axi_peri_sel", 23),
+	GATE_PERAO2(CLK_PERAO_AUDIO0, "perao_audio0",
+		    "axi_peri_sel", 24),
+	GATE_PERAO2(CLK_PERAO_AUDIO1, "perao_audio1",
+		    "axi_peri_sel", 25),
+	GATE_PERAO2(CLK_PERAO_AUDIO2, "perao_audio2",
+		    "aud_intbus_sel", 26),
+	GATE_PERAO2(CLK_PERAO_AUXADC_26M, "perao_auxadc_26m",
+		    "clk26m", 27),
+};
+
+static const struct mtk_clk_desc perao_mcd = {
+	.clks = perao_clks,
+	.num_clks = ARRAY_SIZE(perao_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_bus[] = {
+	{ .compatible = "mediatek,mt8189-infra-ao", .data = &ifrao_mcd },
+	{ .compatible = "mediatek,mt8189-peri-ao", .data = &perao_mcd },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8189_bus_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8189-bus",
+		.of_match_table = of_match_clk_mt8189_bus,
+	},
+};
+
+module_platform_driver(clk_mt8189_bus_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-cam.c b/drivers/clk/mediatek/clk-mt8189-cam.c
new file mode 100644
index 000000000000..de7a73bfec5e
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-cam.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static const struct mtk_gate_regs cam_m_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_CAM_M(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &cam_m_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate cam_m_clks[] = {
+	GATE_CAM_M(CLK_CAM_M_LARB13, "cam_m_larb13", "cam_sel", 0),
+	GATE_CAM_M(CLK_CAM_M_LARB14, "cam_m_larb14", "cam_sel", 2),
+	GATE_CAM_M(CLK_CAM_M_CAMSYS_MAIN_CAM, "cam_m_camsys_main_cam",
+		   "cam_sel", 6),
+	GATE_CAM_M(CLK_CAM_M_CAMSYS_MAIN_CAMTG, "cam_m_camsys_main_camtg",
+		   "cam_sel", 7),
+	GATE_CAM_M(CLK_CAM_M_SENINF, "cam_m_seninf", "cam_sel", 8),
+	GATE_CAM_M(CLK_CAM_M_CAMSV1, "cam_m_camsv1", "cam_sel", 10),
+	GATE_CAM_M(CLK_CAM_M_CAMSV2, "cam_m_camsv2", "cam_sel", 11),
+	GATE_CAM_M(CLK_CAM_M_CAMSV3, "cam_m_camsv3", "cam_sel", 12),
+	GATE_CAM_M(CLK_CAM_M_FAKE_ENG, "cam_m_fake_eng", "cam_sel", 17),
+	GATE_CAM_M(CLK_CAM_M_CAM2MM_GALS, "cam_m_cam2mm_gals", "cam_sel", 19),
+	GATE_CAM_M(CLK_CAM_M_CAMSV4, "cam_m_camsv4", "cam_sel", 20),
+	GATE_CAM_M(CLK_CAM_M_PDA, "cam_m_pda", "cam_sel", 21),
+};
+
+static const struct mtk_clk_desc cam_m_mcd = {
+	.clks = cam_m_clks,
+	.num_clks = ARRAY_SIZE(cam_m_clks),
+};
+
+static const struct mtk_gate_regs cam_ra_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_CAM_RA(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &cam_ra_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate cam_ra_clks[] = {
+	GATE_CAM_RA(CLK_CAM_RA_CAMSYS_RAWA_LARBX, "cam_ra_camsys_rawa_larbx",
+		    "cam_sel", 0),
+	GATE_CAM_RA(CLK_CAM_RA_CAMSYS_RAWA_CAM, "cam_ra_camsys_rawa_cam",
+		    "cam_sel", 1),
+	GATE_CAM_RA(CLK_CAM_RA_CAMSYS_RAWA_CAMTG, "cam_ra_camsys_rawa_camtg",
+		    "cam_sel", 2),
+};
+
+static const struct mtk_clk_desc cam_ra_mcd = {
+	.clks = cam_ra_clks,
+	.num_clks = ARRAY_SIZE(cam_ra_clks),
+};
+
+static const struct mtk_gate_regs cam_rb_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_CAM_RB(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &cam_rb_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate cam_rb_clks[] = {
+	GATE_CAM_RB(CLK_CAM_RB_CAMSYS_RAWB_LARBX, "cam_rb_camsys_rawb_larbx",
+		    "cam_sel", 0),
+	GATE_CAM_RB(CLK_CAM_RB_CAMSYS_RAWB_CAM, "cam_rb_camsys_rawb_cam",
+		    "cam_sel", 1),
+	GATE_CAM_RB(CLK_CAM_RB_CAMSYS_RAWB_CAMTG, "cam_rb_camsys_rawb_camtg",
+		    "cam_sel", 2),
+};
+
+static const struct mtk_clk_desc cam_rb_mcd = {
+	.clks = cam_rb_clks,
+	.num_clks = ARRAY_SIZE(cam_rb_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_cam[] = {
+	{ .compatible = "mediatek,mt8189-camsys-main", .data = &cam_m_mcd },
+	{ .compatible = "mediatek,mt8189-camsys-rawa", .data = &cam_ra_mcd },
+	{ .compatible = "mediatek,mt8189-camsys-rawb", .data = &cam_rb_mcd },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8189_cam_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8189-cam",
+		.of_match_table = of_match_clk_mt8189_cam,
+	},
+};
+
+module_platform_driver(clk_mt8189_cam_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-dbgao.c b/drivers/clk/mediatek/clk-mt8189-dbgao.c
new file mode 100644
index 000000000000..173bdac61475
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-dbgao.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static const struct mtk_gate_regs dbgao_cg_regs = {
+	.set_ofs = 0x70,
+	.clr_ofs = 0x70,
+	.sta_ofs = 0x70,
+};
+
+#define GATE_DBGAO(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &dbgao_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
+	}
+
+static const struct mtk_gate dbgao_clks[] = {
+	GATE_DBGAO(CLK_DBGAO_ATB_EN, "dbgao_atb_en", "atb_sel", 0),
+};
+
+static const struct mtk_clk_desc dbgao_mcd = {
+	.clks = dbgao_clks,
+	.num_clks = ARRAY_SIZE(dbgao_clks),
+};
+
+static const struct mtk_gate_regs dem0_cg_regs = {
+	.set_ofs = 0x2C,
+	.clr_ofs = 0x2C,
+	.sta_ofs = 0x2C,
+};
+
+static const struct mtk_gate_regs dem1_cg_regs = {
+	.set_ofs = 0x30,
+	.clr_ofs = 0x30,
+	.sta_ofs = 0x30,
+};
+
+static const struct mtk_gate_regs dem2_cg_regs = {
+	.set_ofs = 0x70,
+	.clr_ofs = 0x70,
+	.sta_ofs = 0x70,
+};
+
+#define GATE_DEM0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &dem0_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
+	}
+
+#define GATE_DEM1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &dem1_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
+	}
+
+#define GATE_DEM2(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &dem2_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
+	}
+
+static const struct mtk_gate dem_clks[] = {
+	/* DEM0 */
+	GATE_DEM0(CLK_DEM_BUSCLK_EN, "dem_busclk_en", "axi_sel", 0),
+	/* DEM1 */
+	GATE_DEM1(CLK_DEM_SYSCLK_EN, "dem_sysclk_en", "axi_sel", 0),
+	/* DEM2 */
+	GATE_DEM2(CLK_DEM_ATB_EN, "dem_atb_en", "atb_sel", 0),
+};
+
+static const struct mtk_clk_desc dem_mcd = {
+	.clks = dem_clks,
+	.num_clks = ARRAY_SIZE(dem_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_dbgao[] = {
+	{ .compatible = "mediatek,mt8189-dbg-ao", .data = &dbgao_mcd },
+	{ .compatible = "mediatek,mt8189-dem", .data = &dem_mcd },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8189_dbgao_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8189-dbgao",
+		.of_match_table = of_match_clk_mt8189_dbgao,
+	},
+};
+
+module_platform_driver(clk_mt8189_dbgao_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-dvfsrc.c b/drivers/clk/mediatek/clk-mt8189-dvfsrc.c
new file mode 100644
index 000000000000..abdf2d14306b
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-dvfsrc.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static const struct mtk_gate_regs dvfsrc_top_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_DVFSRC_TOP_FLAGS(_id, _name, _parent, _shift, _flags) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &dvfsrc_top_cg_regs,		\
+		.shift = _shift,			\
+		.flags = _flags,			\
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
+	}
+
+static const struct mtk_gate dvfsrc_top_clks[] = {
+	GATE_DVFSRC_TOP_FLAGS(CLK_DVFSRC_TOP_DVFSRC_EN, "dvfsrc_dvfsrc_en",
+			      "clk26m", 0, CLK_IS_CRITICAL),
+};
+
+static const struct mtk_clk_desc dvfsrc_top_mcd = {
+	.clks = dvfsrc_top_clks,
+	.num_clks = ARRAY_SIZE(dvfsrc_top_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_dvfsrc[] = {
+	{
+		.compatible = "mediatek,mt8189-dvfsrc-top",
+		.data = &dvfsrc_top_mcd
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8189_dvfsrc_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8189-dvfsrc",
+		.of_match_table = of_match_clk_mt8189_dvfsrc,
+	},
+};
+
+module_platform_driver(clk_mt8189_dvfsrc_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-iic.c b/drivers/clk/mediatek/clk-mt8189-iic.c
new file mode 100644
index 000000000000..08c5a9b3063f
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-iic.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static const struct mtk_gate_regs impe_cg_regs = {
+	.set_ofs = 0xE08,
+	.clr_ofs = 0xE04,
+	.sta_ofs = 0xE00,
+};
+
+#define GATE_IMPE(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &impe_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate impe_clks[] = {
+	GATE_IMPE(CLK_IMPE_I2C0, "impe_i2c0", "i2c_sel", 0),
+	GATE_IMPE(CLK_IMPE_I2C1, "impe_i2c1", "i2c_sel", 1),
+};
+
+static const struct mtk_clk_desc impe_mcd = {
+	.clks = impe_clks,
+	.num_clks = ARRAY_SIZE(impe_clks),
+};
+
+static const struct mtk_gate_regs impen_cg_regs = {
+	.set_ofs = 0xE08,
+	.clr_ofs = 0xE04,
+	.sta_ofs = 0xE00,
+};
+
+#define GATE_IMPEN(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &impen_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate impen_clks[] = {
+	GATE_IMPEN(CLK_IMPEN_I2C7, "impen_i2c7", "i2c_sel", 0),
+	GATE_IMPEN(CLK_IMPEN_I2C8, "impen_i2c8", "i2c_sel", 1),
+};
+
+static const struct mtk_clk_desc impen_mcd = {
+	.clks = impen_clks,
+	.num_clks = ARRAY_SIZE(impen_clks),
+};
+
+static const struct mtk_gate_regs imps_cg_regs = {
+	.set_ofs = 0xE08,
+	.clr_ofs = 0xE04,
+	.sta_ofs = 0xE00,
+};
+
+#define GATE_IMPS(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &imps_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate imps_clks[] = {
+	GATE_IMPS(CLK_IMPS_I2C3, "imps_i2c3", "i2c_sel", 0),
+	GATE_IMPS(CLK_IMPS_I2C4, "imps_i2c4", "i2c_sel", 1),
+	GATE_IMPS(CLK_IMPS_I2C5, "imps_i2c5", "i2c_sel", 2),
+	GATE_IMPS(CLK_IMPS_I2C6, "imps_i2c6", "i2c_sel", 3),
+};
+
+static const struct mtk_clk_desc imps_mcd = {
+	.clks = imps_clks,
+	.num_clks = ARRAY_SIZE(imps_clks),
+};
+
+static const struct mtk_gate_regs impws_cg_regs = {
+	.set_ofs = 0xE08,
+	.clr_ofs = 0xE04,
+	.sta_ofs = 0xE00,
+};
+
+#define GATE_IMPWS(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &impws_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate impws_clks[] = {
+	GATE_IMPWS(CLK_IMPWS_I2C2, "impws_i2c2", "i2c_sel", 0),
+};
+
+static const struct mtk_clk_desc impws_mcd = {
+	.clks = impws_clks,
+	.num_clks = ARRAY_SIZE(impws_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_iic[] = {
+	{
+		.compatible = "mediatek,mt8189-iic-wrap-e",
+		.data = &impe_mcd
+	}, {
+		.compatible = "mediatek,mt8189-iic-wrap-en",
+		.data = &impen_mcd
+	}, {
+		.compatible = "mediatek,mt8189-iic-wrap-s",
+		.data = &imps_mcd
+	}, {
+		.compatible = "mediatek,mt8189-iic-wrap-ws",
+		.data = &impws_mcd
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8189_iic_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8189-iic",
+		.of_match_table = of_match_clk_mt8189_iic,
+	},
+};
+
+module_platform_driver(clk_mt8189_iic_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-img.c b/drivers/clk/mediatek/clk-mt8189-img.c
new file mode 100644
index 000000000000..53649a04c422
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-img.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static const struct mtk_gate_regs imgsys1_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_IMGSYS1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &imgsys1_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate imgsys1_clks[] = {
+	GATE_IMGSYS1(CLK_IMGSYS1_LARB9, "imgsys1_larb9", "img1_sel", 0),
+	GATE_IMGSYS1(CLK_IMGSYS1_LARB11, "imgsys1_larb11", "img1_sel", 1),
+	GATE_IMGSYS1(CLK_IMGSYS1_DIP, "imgsys1_dip", "img1_sel", 2),
+	GATE_IMGSYS1(CLK_IMGSYS1_GALS, "imgsys1_gals", "img1_sel", 12),
+};
+
+static const struct mtk_clk_desc imgsys1_mcd = {
+	.clks = imgsys1_clks,
+	.num_clks = ARRAY_SIZE(imgsys1_clks),
+};
+
+static const struct mtk_gate_regs imgsys2_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_IMGSYS2(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &imgsys2_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate imgsys2_clks[] = {
+	GATE_IMGSYS2(CLK_IMGSYS2_LARB9, "imgsys2_larb9", "img1_sel", 0),
+	GATE_IMGSYS2(CLK_IMGSYS2_LARB11, "imgsys2_larb11", "img1_sel", 1),
+	GATE_IMGSYS2(CLK_IMGSYS2_MFB, "imgsys2_mfb", "img1_sel", 6),
+	GATE_IMGSYS2(CLK_IMGSYS2_WPE, "imgsys2_wpe", "img1_sel", 7),
+	GATE_IMGSYS2(CLK_IMGSYS2_MSS, "imgsys2_mss", "img1_sel", 8),
+	GATE_IMGSYS2(CLK_IMGSYS2_GALS, "imgsys2_gals", "img1_sel", 12),
+};
+
+static const struct mtk_clk_desc imgsys2_mcd = {
+	.clks = imgsys2_clks,
+	.num_clks = ARRAY_SIZE(imgsys2_clks),
+};
+
+static const struct mtk_gate_regs ipe_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_IPE(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ipe_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate ipe_clks[] = {
+	GATE_IPE(CLK_IPE_LARB19, "ipe_larb19", "ipe_sel", 0),
+	GATE_IPE(CLK_IPE_LARB20, "ipe_larb20", "ipe_sel", 1),
+	GATE_IPE(CLK_IPE_SMI_SUBCOM, "ipe_smi_subcom", "ipe_sel", 2),
+	GATE_IPE(CLK_IPE_FD, "ipe_fd", "ipe_sel", 3),
+	GATE_IPE(CLK_IPE_FE, "ipe_fe", "ipe_sel", 4),
+	GATE_IPE(CLK_IPE_RSC, "ipe_rsc", "ipe_sel", 5),
+	GATE_IPE(CLK_IPESYS_GALS, "ipesys_gals", "ipe_sel", 8),
+};
+
+static const struct mtk_clk_desc ipe_mcd = {
+	.clks = ipe_clks,
+	.num_clks = ARRAY_SIZE(ipe_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_img[] = {
+	{ .compatible = "mediatek,mt8189-imgsys1", .data = &imgsys1_mcd },
+	{ .compatible = "mediatek,mt8189-imgsys2", .data = &imgsys2_mcd },
+	{ .compatible = "mediatek,mt8189-ipesys", .data = &ipe_mcd },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8189_img_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8189-img",
+		.of_match_table = of_match_clk_mt8189_img,
+	},
+};
+
+module_platform_driver(clk_mt8189_img_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-mdpsys.c b/drivers/clk/mediatek/clk-mt8189-mdpsys.c
new file mode 100644
index 000000000000..176447dc971f
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-mdpsys.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static const struct mtk_gate_regs mdp0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mdp1_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+#define GATE_MDP0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mdp0_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+#define GATE_MDP1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mdp1_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate mdp_clks[] = {
+	/* MDP0 */
+	GATE_MDP0(CLK_MDP_MUTEX0, "mdp_mutex0", "mdp0_sel", 0),
+	GATE_MDP0(CLK_MDP_APB_BUS, "mdp_apb_bus", "mdp0_sel", 1),
+	GATE_MDP0(CLK_MDP_SMI0, "mdp_smi0", "mdp0_sel", 2),
+	GATE_MDP0(CLK_MDP_RDMA0, "mdp_rdma0", "mdp0_sel", 3),
+	GATE_MDP0(CLK_MDP_RDMA2, "mdp_rdma2", "mdp0_sel", 4),
+	GATE_MDP0(CLK_MDP_HDR0, "mdp_hdr0", "mdp0_sel", 5),
+	GATE_MDP0(CLK_MDP_AAL0, "mdp_aal0", "mdp0_sel", 6),
+	GATE_MDP0(CLK_MDP_RSZ0, "mdp_rsz0", "mdp0_sel", 7),
+	GATE_MDP0(CLK_MDP_TDSHP0, "mdp_tdshp0", "mdp0_sel", 8),
+	GATE_MDP0(CLK_MDP_COLOR0, "mdp_color0", "mdp0_sel", 9),
+	GATE_MDP0(CLK_MDP_WROT0, "mdp_wrot0", "mdp0_sel", 10),
+	GATE_MDP0(CLK_MDP_FAKE_ENG0, "mdp_fake_eng0", "mdp0_sel", 11),
+	GATE_MDP0(CLK_MDPSYS_CONFIG, "mdpsys_config", "mdp0_sel", 14),
+	GATE_MDP0(CLK_MDP_RDMA1, "mdp_rdma1", "mdp0_sel", 15),
+	GATE_MDP0(CLK_MDP_RDMA3, "mdp_rdma3", "mdp0_sel", 16),
+	GATE_MDP0(CLK_MDP_HDR1, "mdp_hdr1", "mdp0_sel", 17),
+	GATE_MDP0(CLK_MDP_AAL1, "mdp_aal1", "mdp0_sel", 18),
+	GATE_MDP0(CLK_MDP_RSZ1, "mdp_rsz1", "mdp0_sel", 19),
+	GATE_MDP0(CLK_MDP_TDSHP1, "mdp_tdshp1", "mdp0_sel", 20),
+	GATE_MDP0(CLK_MDP_COLOR1, "mdp_color1", "mdp0_sel", 21),
+	GATE_MDP0(CLK_MDP_WROT1, "mdp_wrot1", "mdp0_sel", 22),
+	GATE_MDP0(CLK_MDP_RSZ2, "mdp_rsz2", "mdp0_sel", 24),
+	GATE_MDP0(CLK_MDP_WROT2, "mdp_wrot2", "mdp0_sel", 25),
+	GATE_MDP0(CLK_MDP_RSZ3, "mdp_rsz3", "mdp0_sel", 28),
+	GATE_MDP0(CLK_MDP_WROT3, "mdp_wrot3", "mdp0_sel", 29),
+	/* MDP1 */
+	GATE_MDP1(CLK_MDP_BIRSZ0, "mdp_birsz0", "mdp0_sel", 3),
+	GATE_MDP1(CLK_MDP_BIRSZ1, "mdp_birsz1", "mdp0_sel", 4),
+};
+
+static const struct mtk_clk_desc mdp_mcd = {
+	.clks = mdp_clks,
+	.num_clks = ARRAY_SIZE(mdp_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_mdpsys[] = {
+	{ .compatible = "mediatek,mt8189-mdpsys", .data = &mdp_mcd },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8189_mdpsys_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8189-mdpsys",
+		.of_match_table = of_match_clk_mt8189_mdpsys,
+	},
+};
+
+module_platform_driver(clk_mt8189_mdpsys_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-mfg.c b/drivers/clk/mediatek/clk-mt8189-mfg.c
new file mode 100644
index 000000000000..d4c20118247f
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-mfg.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static const struct mtk_gate_regs mfg_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_MFG(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mfg_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate mfg_clks[] = {
+	GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "mfg_sel_mfgpll", 0),
+};
+
+static const struct mtk_clk_desc mfg_mcd = {
+	.clks = mfg_clks,
+	.num_clks = ARRAY_SIZE(mfg_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_mfg[] = {
+	{ .compatible = "mediatek,mt8189-mfgcfg", .data = &mfg_mcd },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8189_mfg_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8189-mfg",
+		.of_match_table = of_match_clk_mt8189_mfg,
+	},
+};
+
+module_platform_driver(clk_mt8189_mfg_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-mmsys.c b/drivers/clk/mediatek/clk-mt8189-mmsys.c
new file mode 100644
index 000000000000..be7ba16569f3
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-mmsys.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static const struct mtk_gate_regs mm0_cg_regs = {
+	.set_ofs = 0x04,
+	.clr_ofs = 0x08,
+	.sta_ofs = 0x00,
+};
+
+static const struct mtk_gate_regs mm1_cg_regs = {
+	.set_ofs = 0x14,
+	.clr_ofs = 0x18,
+	.sta_ofs = 0x10,
+};
+
+#define GATE_MM0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mm0_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_MM1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mm1_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate mm_clks[] = {
+	/* MM0 */
+	GATE_MM0(CLK_MM_DISP_OVL0_4L, "mm_disp_ovl0_4l", "disp0_sel", 0),
+	GATE_MM0(CLK_MM_DISP_OVL1_4L, "mm_disp_ovl1_4l", "disp0_sel", 1),
+	GATE_MM0(CLK_MM_VPP_RSZ0, "mm_vpp_rsz0", "disp0_sel", 2),
+	GATE_MM0(CLK_MM_VPP_RSZ1, "mm_vpp_rsz1", "disp0_sel", 3),
+	GATE_MM0(CLK_MM_DISP_RDMA0, "mm_disp_rdma0", "disp0_sel", 4),
+	GATE_MM0(CLK_MM_DISP_RDMA1, "mm_disp_rdma1", "disp0_sel", 5),
+	GATE_MM0(CLK_MM_DISP_COLOR0, "mm_disp_color0", "disp0_sel", 6),
+	GATE_MM0(CLK_MM_DISP_COLOR1, "mm_disp_color1", "disp0_sel", 7),
+	GATE_MM0(CLK_MM_DISP_CCORR0, "mm_disp_ccorr0", "disp0_sel", 8),
+	GATE_MM0(CLK_MM_DISP_CCORR1, "mm_disp_ccorr1", "disp0_sel", 9),
+	GATE_MM0(CLK_MM_DISP_CCORR2, "mm_disp_ccorr2", "disp0_sel", 10),
+	GATE_MM0(CLK_MM_DISP_CCORR3, "mm_disp_ccorr3", "disp0_sel", 11),
+	GATE_MM0(CLK_MM_DISP_AAL0, "mm_disp_aal0", "disp0_sel", 12),
+	GATE_MM0(CLK_MM_DISP_AAL1, "mm_disp_aal1", "disp0_sel", 13),
+	GATE_MM0(CLK_MM_DISP_GAMMA0, "mm_disp_gamma0", "disp0_sel", 14),
+	GATE_MM0(CLK_MM_DISP_GAMMA1, "mm_disp_gamma1", "disp0_sel", 15),
+	GATE_MM0(CLK_MM_DISP_DITHER0, "mm_disp_dither0", "disp0_sel", 16),
+	GATE_MM0(CLK_MM_DISP_DITHER1, "mm_disp_dither1", "disp0_sel", 17),
+	GATE_MM0(CLK_MM_DISP_DSC_WRAP0, "mm_disp_dsc_wrap0",
+		 "disp0_sel", 18),
+	GATE_MM0(CLK_MM_VPP_MERGE0, "mm_vpp_merge0", "disp0_sel", 19),
+	GATE_MM0(CLK_MMSYS_0_DISP_DVO, "mmsys_0_disp_dvo",
+		 "disp0_sel", 20),
+	GATE_MM0(CLK_MMSYS_0_DISP_DSI0, "mmsys_0_CLK0", "disp0_sel", 21),
+	GATE_MM0(CLK_MM_DP_INTF0, "mm_dp_intf0", "disp0_sel", 22),
+	GATE_MM0(CLK_MM_DPI0, "mm_dpi0", "disp0_sel", 23),
+	GATE_MM0(CLK_MM_DISP_WDMA0, "mm_disp_wdma0", "disp0_sel", 24),
+	GATE_MM0(CLK_MM_DISP_WDMA1, "mm_disp_wdma1", "disp0_sel", 25),
+	GATE_MM0(CLK_MM_DISP_FAKE_ENG0, "mm_disp_fake_eng0",
+		 "disp0_sel", 26),
+	GATE_MM0(CLK_MM_DISP_FAKE_ENG1, "mm_disp_fake_eng1",
+		 "disp0_sel", 27),
+	GATE_MM0(CLK_MM_SMI_LARB, "mm_smi_larb", "disp0_sel", 28),
+	GATE_MM0(CLK_MM_DISP_MUTEX0, "mm_disp_mutex0", "disp0_sel", 29),
+	GATE_MM0(CLK_MM_DIPSYS_CONFIG, "mm_dipsys_config",
+		 "disp0_sel", 30),
+	GATE_MM0(CLK_MM_DUMMY, "mm_dummy", "disp0_sel", 31),
+	/* MM1 */
+	GATE_MM1(CLK_MMSYS_1_DISP_DSI0, "mmsys_1_CLK0", "dsi_occ_sel", 0),
+	GATE_MM1(CLK_MMSYS_1_LVDS_ENCODER, "mmsys_1_lvds_encoder",
+		 "pll_dpix_sel", 1),
+	GATE_MM1(CLK_MMSYS_1_DPI0, "mmsys_1_dpi0", "pll_dpix_sel", 2),
+	GATE_MM1(CLK_MMSYS_1_DISP_DVO, "mmsys_1_disp_dvo", "edp_sel", 3),
+	GATE_MM1(CLK_MM_DP_INTF, "mm_dp_intf", "dp_sel", 4),
+	GATE_MM1(CLK_MMSYS_1_LVDS_ENCODER_CTS, "mmsys_1_lvds_encoder_cts",
+		 "vdstx_dg_cts_sel", 5),
+	GATE_MM1(CLK_MMSYS_1_DISP_DVO_AVT, "mmsys_1_disp_dvo_avt",
+		 "edp_favt_sel", 6),
+};
+
+static const struct mtk_clk_desc mm_mcd = {
+	.clks = mm_clks,
+	.num_clks = ARRAY_SIZE(mm_clks),
+};
+
+static const struct mtk_gate_regs gce_d_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_GCE_D(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &gce_d_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate gce_d_clks[] = {
+	GATE_GCE_D(CLK_GCE_D_TOP, "gce_d_top", "mminfra_gce_d", 16),
+};
+
+static const struct mtk_clk_desc gce_d_mcd = {
+	.clks = gce_d_clks,
+	.num_clks = ARRAY_SIZE(gce_d_clks),
+};
+
+static const struct mtk_gate_regs gce_m_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_GCE_M(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &gce_m_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate gce_m_clks[] = {
+	GATE_GCE_M(CLK_GCE_M_TOP, "gce_m_top", "mminfra_gce_m", 16),
+};
+
+static const struct mtk_clk_desc gce_m_mcd = {
+	.clks = gce_m_clks,
+	.num_clks = ARRAY_SIZE(gce_m_clks),
+};
+
+static const struct mtk_gate_regs mminfra_config0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mminfra_config1_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+#define GATE_MMINFRA_CONFIG0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mminfra_config0_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_MMINFRA_CONFIG1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mminfra_config1_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate mminfra_config_clks[] = {
+	/* MMINFRA_CONFIG0 */
+	GATE_MMINFRA_CONFIG0(CLK_MMINFRA_GCE_D, "mminfra_gce_d",
+			     "mminfra_sel", 0),
+	GATE_MMINFRA_CONFIG0(CLK_MMINFRA_GCE_M, "mminfra_gce_m",
+			     "mminfra_sel", 1),
+	GATE_MMINFRA_CONFIG0(CLK_MMINFRA_SMI, "mminfra_smi",
+			     "mminfra_sel", 2),
+	/* MMINFRA_CONFIG1 */
+	GATE_MMINFRA_CONFIG1(CLK_MMINFRA_GCE_26M, "mminfra_gce_26m",
+			     "mminfra_sel", 17),
+};
+
+static const struct mtk_clk_desc mminfra_config_mcd = {
+	.clks = mminfra_config_clks,
+	.num_clks = ARRAY_SIZE(mminfra_config_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_mmsys[] = {
+	{
+		.compatible = "mediatek,mt8189-dispsys",
+		.data = &mm_mcd
+	}, {
+		.compatible = "mediatek,mt8189-gce-d",
+		.data = &gce_d_mcd
+	}, {
+		.compatible = "mediatek,mt8189-gce-m",
+		.data = &gce_m_mcd
+	}, {
+		.compatible = "mediatek,mt8189-mm-infra",
+		.data = &mminfra_config_mcd
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8189_mmsys_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8189-mmsys",
+		.of_match_table = of_match_clk_mt8189_mmsys,
+	},
+};
+
+module_platform_driver(clk_mt8189_mmsys_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-scp.c b/drivers/clk/mediatek/clk-mt8189-scp.c
new file mode 100644
index 000000000000..8a5b5bff495f
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-scp.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static const struct mtk_gate_regs scp_cg_regs = {
+	.set_ofs = 0x154,
+	.clr_ofs = 0x158,
+	.sta_ofs = 0x154,
+};
+
+#define GATE_SCP(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &scp_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate scp_clks[] = {
+	GATE_SCP(CLK_SCP_SET_SPI0, "scp_set_spi0", "clk26m", 0),
+	GATE_SCP(CLK_SCP_SET_SPI1, "scp_set_spi1", "clk26m", 1),
+};
+
+static const struct mtk_clk_desc scp_mcd = {
+	.clks = scp_clks,
+	.num_clks = ARRAY_SIZE(scp_clks),
+};
+
+static const struct mtk_gate_regs scp_iic_cg_regs = {
+	.set_ofs = 0xE18,
+	.clr_ofs = 0xE14,
+	.sta_ofs = 0xE10,
+};
+
+#define GATE_SCP_IIC(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &scp_iic_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate scp_iic_clks[] = {
+	GATE_SCP_IIC(CLK_SCP_IIC_I2C0_W1S, "scp_iic_i2c0_w1s",
+		     "vlp_scp_iic_sel", 0),
+	GATE_SCP_IIC(CLK_SCP_IIC_I2C1_W1S, "scp_iic_i2c1_w1s",
+		     "vlp_scp_iic_sel", 1),
+};
+
+static const struct mtk_clk_desc scp_iic_mcd = {
+	.clks = scp_iic_clks,
+	.num_clks = ARRAY_SIZE(scp_iic_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_scp[] = {
+	{
+		.compatible = "mediatek,mt8189-scp-clk",
+		.data = &scp_mcd
+	}, {
+		.compatible = "mediatek,mt8189-scp-i2c-clk",
+		.data = &scp_iic_mcd
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8189_scp_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8189-scp",
+		.of_match_table = of_match_clk_mt8189_scp,
+	},
+};
+
+module_platform_driver(clk_mt8189_scp_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-topckgen.c b/drivers/clk/mediatek/clk-mt8189-topckgen.c
new file mode 100644
index 000000000000..2ac8bcc1895c
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-topckgen.c
@@ -0,0 +1,1057 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "clk-mtk.h"
+#include "clk-mux.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static DEFINE_SPINLOCK(mt8189_clk_lock);
+
+static const struct mtk_fixed_clk top_fixed_clks[] = {
+	FIXED_CLK(CLK_TOP_VOWPLL, "vowpll_ck", NULL, 26000000),
+};
+
+static const struct mtk_fixed_factor top_divs[] = {
+	FACTOR(CLK_TOP_MAINPLL_D3, "mainpll_d3", "mainpll", 1, 3),
+	FACTOR(CLK_TOP_MAINPLL_D4, "mainpll_d4", "mainpll", 1, 4),
+	FACTOR(CLK_TOP_MAINPLL_D4_D2, "mainpll_d4_d2", "mainpll", 1, 8),
+	FACTOR(CLK_TOP_MAINPLL_D4_D4, "mainpll_d4_d4", "mainpll", 1, 16),
+	FACTOR(CLK_TOP_MAINPLL_D4_D8, "mainpll_d4_d8",
+	       "mainpll", 43, 1375),
+	FACTOR(CLK_TOP_MAINPLL_D5, "mainpll_d5", "mainpll", 1, 5),
+	FACTOR(CLK_TOP_MAINPLL_D5_D2, "mainpll_d5_d2", "mainpll", 1, 10),
+	FACTOR(CLK_TOP_MAINPLL_D5_D4, "mainpll_d5_d4", "mainpll", 1, 20),
+	FACTOR(CLK_TOP_MAINPLL_D5_D8, "mainpll_d5_d8", "mainpll", 1, 40),
+	FACTOR(CLK_TOP_MAINPLL_D6, "mainpll_d6", "mainpll", 1, 6),
+	FACTOR(CLK_TOP_MAINPLL_D6_D2, "mainpll_d6_d2", "mainpll", 1, 12),
+	FACTOR(CLK_TOP_MAINPLL_D6_D4, "mainpll_d6_d4", "mainpll", 1, 24),
+	FACTOR(CLK_TOP_MAINPLL_D6_D8, "mainpll_d6_d8", "mainpll", 1, 48),
+	FACTOR(CLK_TOP_MAINPLL_D7, "mainpll_d7", "mainpll", 1, 7),
+	FACTOR(CLK_TOP_MAINPLL_D7_D2, "mainpll_d7_d2", "mainpll", 1, 14),
+	FACTOR(CLK_TOP_MAINPLL_D7_D4, "mainpll_d7_d4", "mainpll", 1, 28),
+	FACTOR(CLK_TOP_MAINPLL_D7_D8, "mainpll_d7_d8", "mainpll", 1, 56),
+	FACTOR(CLK_TOP_MAINPLL_D9, "mainpll_d9", "mainpll", 1, 9),
+	FACTOR(CLK_TOP_UNIVPLL_D2, "univpll_d2", "univpll", 1, 2),
+	FACTOR(CLK_TOP_UNIVPLL_D3, "univpll_d3", "univpll", 1, 3),
+	FACTOR(CLK_TOP_UNIVPLL_D4, "univpll_d4", "univpll", 1, 4),
+	FACTOR(CLK_TOP_UNIVPLL_D4_D2, "univpll_d4_d2", "univpll", 1, 8),
+	FACTOR(CLK_TOP_UNIVPLL_D4_D4, "univpll_d4_d4", "univpll", 1, 16),
+	FACTOR(CLK_TOP_UNIVPLL_D4_D8, "univpll_d4_d8", "univpll", 1, 32),
+	FACTOR(CLK_TOP_UNIVPLL_D5, "univpll_d5", "univpll", 1, 5),
+	FACTOR(CLK_TOP_UNIVPLL_D5_D2, "univpll_d5_d2", "univpll", 1, 10),
+	FACTOR(CLK_TOP_UNIVPLL_D5_D4, "univpll_d5_d4", "univpll", 1, 20),
+	FACTOR(CLK_TOP_UNIVPLL_D6, "univpll_d6", "univpll", 1, 6),
+	FACTOR(CLK_TOP_UNIVPLL_D6_D2, "univpll_d6_d2", "univpll", 1, 12),
+	FACTOR(CLK_TOP_UNIVPLL_D6_D4, "univpll_d6_d4", "univpll", 1, 24),
+	FACTOR(CLK_TOP_UNIVPLL_D6_D8, "univpll_d6_d8", "univpll", 1, 48),
+	FACTOR(CLK_TOP_UNIVPLL_D6_D16, "univpll_d6_d16", "univpll", 1, 96),
+	FACTOR(CLK_TOP_UNIVPLL_D7, "univpll_d7", "univpll", 1, 7),
+	FACTOR(CLK_TOP_UNIVPLL_D7_D2, "univpll_d7_d2", "univpll", 1, 14),
+	FACTOR(CLK_TOP_UNIVPLL_D7_D3, "univpll_d7_d3", "univpll", 1, 21),
+	FACTOR(CLK_TOP_LVDSTX_DG_CTS, "lvdstx_dg_cts_ck",
+	       "univpll", 1, 21),
+	FACTOR(CLK_TOP_UNIVPLL_192M, "univpll_192m_ck",
+	       "univpll", 1, 13),
+	FACTOR(CLK_TOP_UNIVPLL_192M_D2, "univpll_192m_d2",
+	       "univpll", 1, 26),
+	FACTOR(CLK_TOP_UNIVPLL_192M_D4, "univpll_192m_d4",
+	       "univpll", 1, 52),
+	FACTOR(CLK_TOP_UNIVPLL_192M_D8, "univpll_192m_d8",
+	       "univpll", 1, 104),
+	FACTOR(CLK_TOP_UNIVPLL_192M_D10, "univpll_192m_d10",
+	       "univpll", 1, 130),
+	FACTOR(CLK_TOP_UNIVPLL_192M_D16, "univpll_192m_d16",
+	       "univpll", 1, 208),
+	FACTOR(CLK_TOP_UNIVPLL_192M_D32, "univpll_192m_d32",
+	       "univpll", 1, 416),
+	FACTOR(CLK_TOP_APLL1_D2, "apll1_d2", "apll1", 1, 2),
+	FACTOR(CLK_TOP_APLL1_D4, "apll1_d4", "apll1", 1, 4),
+	FACTOR(CLK_TOP_APLL1_D8, "apll1_d8", "apll1", 1, 8),
+	FACTOR(CLK_TOP_APLL1_D3, "apll1_d3", "apll1", 1, 3),
+	FACTOR(CLK_TOP_APLL2_D2, "apll2_d2", "apll2", 1, 2),
+	FACTOR(CLK_TOP_APLL2_D4, "apll2_d4", "apll2", 1, 4),
+	FACTOR(CLK_TOP_APLL2_D8, "apll2_d8", "apll2", 1, 8),
+	FACTOR(CLK_TOP_APLL2_D3, "apll2_d3", "apll2", 1, 3),
+	FACTOR(CLK_TOP_MMPLL_D4, "mmpll_d4", "mmpll", 1, 4),
+	FACTOR(CLK_TOP_MMPLL_D4_D2, "mmpll_d4_d2", "mmpll", 1, 8),
+	FACTOR(CLK_TOP_MMPLL_D4_D4, "mmpll_d4_d4", "mmpll", 1, 16),
+	FACTOR(CLK_TOP_VPLL_DPIX, "vpll_dpix_ck", "mmpll", 1, 16),
+	FACTOR(CLK_TOP_MMPLL_D5, "mmpll_d5", "mmpll", 1, 5),
+	FACTOR(CLK_TOP_MMPLL_D5_D2, "mmpll_d5_d2", "mmpll", 1, 10),
+	FACTOR(CLK_TOP_MMPLL_D5_D4, "mmpll_d5_d4", "mmpll", 1, 20),
+	FACTOR(CLK_TOP_MMPLL_D6, "mmpll_d6", "mmpll", 1, 6),
+	FACTOR(CLK_TOP_MMPLL_D6_D2, "mmpll_d6_d2", "mmpll", 1, 12),
+	FACTOR(CLK_TOP_MMPLL_D7, "mmpll_d7", "mmpll", 1, 7),
+	FACTOR(CLK_TOP_MMPLL_D9, "mmpll_d9", "mmpll", 1, 9),
+	FACTOR(CLK_TOP_TVDPLL1_D2, "tvdpll1_d2", "tvdpll1", 1, 2),
+	FACTOR(CLK_TOP_TVDPLL1_D4, "tvdpll1_d4", "tvdpll1", 1, 4),
+	FACTOR(CLK_TOP_TVDPLL1_D8, "tvdpll1_d8", "tvdpll1", 1, 8),
+	FACTOR(CLK_TOP_TVDPLL1_D16, "tvdpll1_d16", "tvdpll1", 92, 1473),
+	FACTOR(CLK_TOP_TVDPLL2_D2, "tvdpll2_d2", "tvdpll2", 1, 2),
+	FACTOR(CLK_TOP_TVDPLL2_D4, "tvdpll2_d4", "tvdpll2", 1, 4),
+	FACTOR(CLK_TOP_TVDPLL2_D8, "tvdpll2_d8", "tvdpll2", 1, 8),
+	FACTOR(CLK_TOP_TVDPLL2_D16, "tvdpll2_d16", "tvdpll2", 92, 1473),
+	FACTOR(CLK_TOP_ETHPLL_D2, "ethpll_d2", "ethpll", 1, 2),
+	FACTOR(CLK_TOP_ETHPLL_D8, "ethpll_d8", "ethpll", 1, 8),
+	FACTOR(CLK_TOP_ETHPLL_D10, "ethpll_d10", "ethpll", 1, 10),
+	FACTOR(CLK_TOP_MSDCPLL_D2, "msdcpll_d2", "msdcpll", 1, 2),
+	FACTOR(CLK_TOP_UFSPLL_D2, "ufspll_d2", "ufspll", 1, 2),
+	FACTOR(CLK_TOP_F26M_CK_D2, "f26m_d2", "clk26m", 1, 2),
+	FACTOR(CLK_TOP_OSC_D2, "osc_d2", "ulposc", 1, 2),
+	FACTOR(CLK_TOP_OSC_D4, "osc_d4", "ulposc", 1, 4),
+	FACTOR(CLK_TOP_OSC_D8, "osc_d8", "ulposc", 1, 8),
+	FACTOR(CLK_TOP_OSC_D16, "osc_d16", "ulposc", 61, 973),
+	FACTOR(CLK_TOP_OSC_D3, "osc_d3", "ulposc", 1, 3),
+	FACTOR(CLK_TOP_OSC_D7, "osc_d7", "ulposc", 1, 7),
+	FACTOR(CLK_TOP_OSC_D10, "osc_d10", "ulposc", 1, 10),
+	FACTOR(CLK_TOP_OSC_D20, "osc_d20", "ulposc", 1, 20),
+};
+
+static const char * const ap2conn_host_parents[] = {
+	"clk26m",
+	"mainpll_d7_d4"
+};
+
+static const char * const apll_m_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const aud_1_parents[] = {
+	"clk26m",
+	"apll1"
+};
+
+static const char * const aud_2_parents[] = {
+	"clk26m",
+	"apll2"
+};
+
+static const char * const mfg_sel_mfgpll_parents[] = {
+	"mfg_ref_sel",
+	"mfgpll"
+};
+
+static const char * const pwm_parents[] = {
+	"clk26m",
+	"univpll_d4_d8"
+};
+
+static const char * const snps_eth_250m_parents[] = {
+	"clk26m",
+	"ethpll_d2"
+};
+
+static const char * const snps_eth_50m_rmii_parents[] = {
+	"clk26m",
+	"ethpll_d10"
+};
+
+static const char * const uart_parents[] = {
+	"clk26m",
+	"univpll_d6_d8"
+};
+
+static const char * const atb_parents[] = {
+	"clk26m",
+	"mainpll_d4_d2",
+	"mainpll_d5_d2"
+};
+
+static const char * const aud_intbus_parents[] = {
+	"clk26m",
+	"mainpll_d4_d4",
+	"mainpll_d7_d4"
+};
+
+static const char * const msdc5hclk_parents[] = {
+	"clk26m",
+	"mainpll_d4_d2",
+	"mainpll_d6_d2"
+};
+
+static const char * const pcie_mac_tl_parents[] = {
+	"clk26m",
+	"mainpll_d4_d4",
+	"univpll_d5_d4"
+};
+
+static const char * const pll_dpix_parents[] = {
+	"clk26m",
+	"vpll_dpix_ck",
+	"mmpll_d4_d4"
+};
+
+static const char * const usb_parents[] = {
+	"clk26m",
+	"univpll_d5_d4",
+	"univpll_d6_d4"
+};
+
+static const char * const vdstx_dg_cts_parents[] = {
+	"clk26m",
+	"lvdstx_dg_cts_ck",
+	"univpll_d7_d3"
+};
+
+static const char * const audio_h_parents[] = {
+	"clk26m",
+	"univpll_d7_d2",
+	"apll1",
+	"apll2"
+};
+
+static const char * const aud_engen1_parents[] = {
+	"clk26m",
+	"apll1_d2",
+	"apll1_d4",
+	"apll1_d8"
+};
+
+static const char * const aud_engen2_parents[] = {
+	"clk26m",
+	"apll2_d2",
+	"apll2_d4",
+	"apll2_d8"
+};
+
+static const char * const axi_peri_parents[] = {
+	"clk26m",
+	"mainpll_d4_d4",
+	"mainpll_d7_d2",
+	"osc_d4"
+};
+
+static const char * const axi_u_parents[] = {
+	"clk26m",
+	"mainpll_d4_d8",
+	"mainpll_d7_d4",
+	"osc_d8"
+};
+
+static const char * const camtm_parents[] = {
+	"clk26m",
+	"osc_d2",
+	"univpll_d6_d2",
+	"univpll_d6_d4"
+};
+
+static const char * const dsi_occ_parents[] = {
+	"clk26m",
+	"univpll_d6_d2",
+	"univpll_d5_d2",
+	"univpll_d4_d2"
+};
+
+static const char * const dxcc_parents[] = {
+	"clk26m",
+	"mainpll_d4_d8",
+	"mainpll_d4_d4",
+	"mainpll_d4_d2"
+};
+
+static const char * const i2c_parents[] = {
+	"clk26m",
+	"mainpll_d4_d8",
+	"univpll_d5_d4",
+	"mainpll_d4_d4"
+};
+
+static const char * const mcupm_parents[] = {
+	"clk26m",
+	"univpll_d6_d2",
+	"mainpll_d5_d2",
+	"mainpll_d6_d2"
+};
+
+static const char * const mfg_ref_parents[] = {
+	"clk26m",
+	"mainpll_d6_d2",
+	"mainpll_d6",
+	"mainpll_d5_d2"
+};
+
+static const char * const msdc30_h_parents[] = {
+	"clk26m",
+	"msdcpll_d2",
+	"mainpll_d4_d4",
+	"mainpll_d6_d4"
+};
+
+static const char * const msdc_macro_p_parents[] = {
+	"clk26m",
+	"msdcpll",
+	"mmpll_d5_d4",
+	"univpll_d4_d2"
+};
+
+static const char * const snps_eth_62p4m_ptp_parents[] = {
+	"clk26m",
+	"ethpll_d8",
+	"apll1_d3",
+	"apll2_d3"
+};
+
+static const char * const ufs_mbist_parents[] = {
+	"clk26m",
+	"mainpll_d4_d2",
+	"univpll_d4_d2",
+	"ufspll_d2"
+};
+
+static const char * const aes_msdcfde_parents[] = {
+	"clk26m",
+	"mainpll_d4_d2",
+	"mainpll_d6",
+	"mainpll_d4_d4",
+	"msdcpll"
+};
+
+static const char * const bus_aximem_parents[] = {
+	"clk26m",
+	"mainpll_d7_d2",
+	"mainpll_d5_d2",
+	"mainpll_d4_d2",
+	"mainpll_d6"
+};
+
+static const char * const dp_parents[] = {
+	"clk26m",
+	"tvdpll1_d16",
+	"tvdpll1_d8",
+	"tvdpll1_d4",
+	"tvdpll1_d2"
+};
+
+static const char * const msdc30_parents[] = {
+	"clk26m",
+	"univpll_d6_d2",
+	"mainpll_d6_d2",
+	"mainpll_d7_d2",
+	"msdcpll_d2"
+};
+
+static const char * const ecc_parents[] = {
+	"clk26m",
+	"univpll_d6_d2",
+	"univpll_d4_d2",
+	"univpll_d6",
+	"mainpll_d4",
+	"univpll_d4"
+};
+
+static const char * const emi_n_parents[] = {
+	"clk26m",
+	"osc_d2",
+	"mainpll_d9",
+	"mainpll_d6",
+	"mainpll_d5",
+	"emipll"
+};
+
+static const char * const sr_pka_parents[] = {
+	"clk26m",
+	"mainpll_d4_d4",
+	"mainpll_d4_d2",
+	"mainpll_d7",
+	"mainpll_d6",
+	"mainpll_d5"
+};
+
+static const char * const aes_ufsfde_parents[] = {
+	"clk26m",
+	"mainpll_d4",
+	"mainpll_d4_d2",
+	"mainpll_d6",
+	"mainpll_d4_d4",
+	"univpll_d4_d2",
+	"univpll_d6"
+};
+
+static const char * const axi_parents[] = {
+	"clk26m",
+	"mainpll_d4_d4",
+	"mainpll_d7_d2",
+	"mainpll_d4_d2",
+	"mainpll_d5_d2",
+	"mainpll_d6_d2",
+	"osc_d4"
+};
+
+static const char * const disp_pwm_parents[] = {
+	"clk26m",
+	"univpll_d6_d4",
+	"osc_d2",
+	"osc_d4",
+	"osc_d16",
+	"univpll_d5_d4",
+	"mainpll_d4_d4"
+};
+
+static const char * const edp_parents[] = {
+	"clk26m",
+	"tvdpll2_d16",
+	"tvdpll2_d8",
+	"tvdpll2_d4",
+	"tvdpll2_d2"
+};
+
+static const char * const gcpu_parents[] = {
+	"clk26m",
+	"mainpll_d6",
+	"mainpll_d4_d2",
+	"univpll_d4_d2",
+	"univpll_d5_d2",
+	"univpll_d5_d4",
+	"univpll_d6"
+};
+
+static const char * const msdc50_0_parents[] = {
+	"clk26m",
+	"msdcpll",
+	"msdcpll_d2",
+	"mainpll_d6_d2",
+	"mainpll_d4_d4",
+	"mainpll_d6",
+	"univpll_d4_d4"
+};
+
+static const char * const ufs_parents[] = {
+	"clk26m",
+	"mainpll_d4_d8",
+	"mainpll_d4_d4",
+	"mainpll_d5_d2",
+	"mainpll_d6_d2",
+	"univpll_d6_d2",
+	"msdcpll_d2"
+};
+
+static const char * const dsp_parents[] = {
+	"clk26m",
+	"osc_d4",
+	"osc_d3",
+	"osc_d2",
+	"univpll_d7_d2",
+	"univpll_d6_d2",
+	"mainpll_d6",
+	"univpll_d5"
+};
+
+static const char * const mem_sub_peri_u_parents[] = {
+	"clk26m",
+	"univpll_d4_d4",
+	"mainpll_d5_d2",
+	"mainpll_d4_d2",
+	"mainpll_d6",
+	"mainpll_d5",
+	"univpll_d5",
+	"mainpll_d4"
+};
+
+static const char * const seninf_parents[] = {
+	"clk26m",
+	"osc_d2",
+	"univpll_d6_d2",
+	"mainpll_d4_d2",
+	"univpll_d4_d2",
+	"mmpll_d7",
+	"univpll_d6",
+	"univpll_d5"
+};
+
+static const char * const sflash_parents[] = {
+	"clk26m",
+	"mainpll_d7_d8",
+	"univpll_d6_d8",
+	"mainpll_d7_d4",
+	"mainpll_d6_d4",
+	"univpll_d6_d4",
+	"univpll_d7_d3",
+	"univpll_d5_d4"
+};
+
+static const char * const spi_parents[] = {
+	"clk26m",
+	"univpll_d6_d2",
+	"univpll_192m_ck",
+	"mainpll_d6_d2",
+	"univpll_d4_d4",
+	"mainpll_d4_d4",
+	"univpll_d5_d4",
+	"univpll_d6_d4"
+};
+
+static const char * const img1_parents[] = {
+	"clk26m",
+	"univpll_d4",
+	"mmpll_d5",
+	"mmpll_d6",
+	"univpll_d6",
+	"mmpll_d7",
+	"mmpll_d4_d2",
+	"univpll_d4_d2",
+	"mainpll_d4_d2",
+	"mmpll_d6_d2",
+	"mmpll_d5_d2"
+};
+
+static const char * const ipe_parents[] = {
+	"clk26m",
+	"univpll_d4",
+	"mainpll_d4",
+	"mmpll_d6",
+	"univpll_d6",
+	"mainpll_d6",
+	"mmpll_d4_d2",
+	"univpll_d4_d2",
+	"mainpll_d4_d2",
+	"mmpll_d6_d2",
+	"mmpll_d5_d2"
+};
+
+static const char * const mem_sub_parents[] = {
+	"clk26m",
+	"univpll_d4_d4",
+	"mainpll_d6_d2",
+	"mainpll_d5_d2",
+	"mainpll_d4_d2",
+	"mainpll_d6",
+	"mmpll_d7",
+	"mainpll_d5",
+	"univpll_d5",
+	"mainpll_d4",
+	"univpll_d4"
+};
+
+static const char * const cam_parents[] = {
+	"clk26m",
+	"mainpll_d4",
+	"mmpll_d4",
+	"univpll_d4",
+	"univpll_d5",
+	"mmpll_d7",
+	"mmpll_d6",
+	"univpll_d6",
+	"univpll_d4_d2",
+	"mmpll_d9",
+	"mainpll_d4_d2",
+	"osc_d2"
+};
+
+static const char * const mmsys_parents[] = {
+	"clk26m",
+	"mainpll_d5_d2",
+	"univpll_d5_d2",
+	"mainpll_d4_d2",
+	"univpll_d4_d2",
+	"mainpll_d6",
+	"univpll_d6",
+	"mmpll_d6",
+	"tvdpll1",
+	"tvdpll2",
+	"univpll_d4",
+	"mmpll_d4"
+};
+
+static const char * const mminfra_parents[] = {
+	"clk26m",
+	"osc_d2",
+	"mainpll_d5_d2",
+	"mmpll_d6_d2",
+	"mainpll_d4_d2",
+	"mmpll_d4_d2",
+	"mainpll_d6",
+	"mmpll_d7",
+	"univpll_d6",
+	"mainpll_d5",
+	"mmpll_d6",
+	"univpll_d5",
+	"mainpll_d4",
+	"univpll_d4",
+	"mmpll_d4",
+	"emipll"
+};
+
+static const char * const vdec_parents[] = {
+	"clk26m",
+	"univpll_192m_d2",
+	"univpll_d5_d4",
+	"mainpll_d5",
+	"mainpll_d5_d2",
+	"mmpll_d6_d2",
+	"univpll_d5_d2",
+	"mainpll_d4_d2",
+	"univpll_d4_d2",
+	"univpll_d7",
+	"mmpll_d7",
+	"mmpll_d6",
+	"univpll_d6",
+	"mainpll_d4",
+	"univpll_d4",
+	"mmpll_d5_d2"
+};
+
+static const char * const venc_parents[] = {
+	"clk26m",
+	"mmpll_d4_d2",
+	"mainpll_d6",
+	"univpll_d4_d2",
+	"mainpll_d4_d2",
+	"univpll_d6",
+	"mmpll_d6",
+	"mainpll_d5_d2",
+	"mainpll_d6_d2",
+	"mmpll_d9",
+	"mmpll_d4",
+	"mainpll_d4",
+	"univpll_d4",
+	"univpll_d5",
+	"univpll_d5_d2",
+	"mainpll_d5"
+};
+
+static const struct mtk_mux top_muxes[] = {
+	/* CLK_CFG_0 */
+	MUX_CLR_SET_UPD(CLK_TOP_AXI_SEL, "axi_sel",
+			axi_parents, 0x010, 0x014, 0x018, 0, 3, 0x04, 0),
+	MUX_CLR_SET_UPD(CLK_TOP_AXI_PERI_SEL, "axi_peri_sel",
+			axi_peri_parents, 0x010, 0x014, 0x018,
+			8, 2, 0x04, 1),
+	MUX_CLR_SET_UPD(CLK_TOP_AXI_U_SEL, "axi_u_sel",
+			axi_u_parents, 0x010, 0x014, 0x018,
+			16, 2, 0x04, 2),
+	MUX_CLR_SET_UPD(CLK_TOP_BUS_AXIMEM_SEL, "bus_aximem_sel",
+			bus_aximem_parents, 0x010, 0x014, 0x018,
+			24, 3, 0x04, 3),
+	/* CLK_CFG_1 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DISP0_SEL, "disp0_sel",
+			     mmsys_parents, 0x020, 0x024, 0x028,
+			     0, 4, 7, 0x04, 4),
+	MUX_CLR_SET_UPD(CLK_TOP_MMINFRA_SEL, "mminfra_sel",
+			mminfra_parents, 0x020, 0x024, 0x028,
+			8, 4, 0x04, 5),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_UART_SEL, "uart_sel",
+			     uart_parents, 0x020, 0x024, 0x028,
+			     16, 1, 23, 0x04, 6),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI0_SEL, "spi0_sel",
+			     spi_parents, 0x020, 0x024, 0x028,
+			     24, 3, 31, 0x04, 7),
+	/* CLK_CFG_2 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI1_SEL, "spi1_sel",
+			     spi_parents, 0x030, 0x034, 0x038,
+			     0, 3, 7, 0x04, 8),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI2_SEL, "spi2_sel",
+			     spi_parents, 0x030, 0x034, 0x038,
+			     8, 3, 15, 0x04, 9),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI3_SEL, "spi3_sel",
+			     spi_parents, 0x030, 0x034, 0x038,
+			     16, 3, 23, 0x04, 10),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI4_SEL, "spi4_sel",
+			     spi_parents, 0x030, 0x034, 0x038,
+			     24, 3, 31, 0x04, 11),
+	/* CLK_CFG_3 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI5_SEL, "spi5_sel",
+			     spi_parents, 0x040, 0x044, 0x048,
+			     0, 3, 7, 0x04, 12),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC_MACRO_0P_SEL, "msdc_macro_0p_sel",
+			     msdc_macro_p_parents, 0x040, 0x044, 0x048,
+			     8, 2, 15, 0x04, 13),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_HCLK_SEL, "msdc5hclk_sel",
+			     msdc5hclk_parents, 0x040, 0x044, 0x048,
+			     16, 2, 23, 0x04, 14),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel",
+			     msdc50_0_parents, 0x040, 0x044, 0x048,
+			     24, 3, 31, 0x04, 15),
+	/* CLK_CFG_4 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AES_MSDCFDE_SEL, "aes_msdcfde_sel",
+			     aes_msdcfde_parents, 0x050, 0x054, 0x058,
+			     0, 3, 7, 0x04, 16),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC_MACRO_1P_SEL, "msdc_macro_1p_sel",
+			     msdc_macro_p_parents, 0x050, 0x054, 0x058,
+			     8, 2, 15, 0x04, 17),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel",
+			     msdc30_parents, 0x050, 0x054, 0x058,
+			     16, 3, 23, 0x04, 18),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1_HCLK_SEL, "msdc30_1_h_sel",
+			     msdc30_h_parents, 0x050, 0x054, 0x058,
+			     24, 2, 31, 0x04, 19),
+	/* CLK_CFG_5 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC_MACRO_2P_SEL, "msdc_macro_2p_sel",
+			     msdc_macro_p_parents, 0x060, 0x064, 0x068,
+			     0, 2, 7, 0x04, 20),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_2_SEL, "msdc30_2_sel",
+			     msdc30_parents, 0x060, 0x064, 0x068,
+			     8, 3, 15, 0x04, 21),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_2_HCLK_SEL, "msdc30_2_h_sel",
+			     msdc30_h_parents, 0x060, 0x064, 0x068,
+			     16, 2, 23, 0x04, 22),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_INTBUS_SEL, "aud_intbus_sel",
+			     aud_intbus_parents, 0x060, 0x064, 0x068,
+			     24, 2, 31, 0x04, 23),
+	/* CLK_CFG_6 */
+	MUX_CLR_SET_UPD(CLK_TOP_ATB_SEL, "atb_sel",
+			atb_parents, 0x070, 0x074, 0x078, 0, 2, 0x04, 24),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DISP_PWM_SEL, "disp_pwm_sel",
+			     disp_pwm_parents, 0x070, 0x074, 0x078,
+			     8, 3, 15, 0x04, 25),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_P0_SEL, "usb_p0_sel",
+			     usb_parents, 0x070, 0x074, 0x078,
+			     16, 2, 23, 0x04, 26),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_XHCI_P0_SEL, "ssusb_xhci_p0_sel",
+			     usb_parents, 0x070, 0x074, 0x078,
+			     24, 2, 31, 0x04, 27),
+	/* CLK_CFG_7 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_P1_SEL, "usb_p1_sel",
+			     usb_parents, 0x080, 0x084, 0x088,
+			     0, 2, 7, 0x04, 28),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_XHCI_P1_SEL, "ssusb_xhci_p1_sel",
+			     usb_parents, 0x080, 0x084, 0x088,
+			     8, 2, 15, 0x04, 29),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_P2_SEL, "usb_p2_sel",
+			     usb_parents, 0x080, 0x084, 0x088,
+			     16, 2, 23, 0x04, 30),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_XHCI_P2_SEL, "ssusb_xhci_p2_sel",
+			     usb_parents, 0x080, 0x084, 0x088,
+			     24, 2, 31, 0x08, 0),
+	/* CLK_CFG_8 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_P3_SEL, "usb_p3_sel",
+			     usb_parents, 0x090, 0x094, 0x098,
+			     0, 2, 7, 0x08, 1),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_XHCI_P3_SEL, "ssusb_xhci_p3_sel",
+			     usb_parents, 0x090, 0x094, 0x098,
+			     8, 2, 15, 0x08, 2),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_P4_SEL, "usb_p4_sel",
+			     usb_parents, 0x090, 0x094, 0x098,
+			     16, 2, 23, 0x08, 3),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_XHCI_P4_SEL, "ssusb_xhci_p4_sel",
+			     usb_parents, 0x090, 0x094, 0x098,
+			     24, 2, 31, 0x08, 4),
+	/* CLK_CFG_9 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_I2C_SEL, "i2c_sel",
+			     i2c_parents, 0x0A0, 0x0A4, 0x0A8,
+			     0, 2, 7, 0x08, 5),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF_SEL, "seninf_sel",
+			     seninf_parents, 0x0A0, 0x0A4, 0x0A8,
+			     8, 3, 15, 0x08, 6),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF1_SEL, "seninf1_sel",
+			     seninf_parents, 0x0A0, 0x0A4, 0x0A8,
+			     16, 3, 23, 0x08, 7),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_ENGEN1_SEL, "aud_engen1_sel",
+			     aud_engen1_parents, 0x0A0, 0x0A4, 0x0A8,
+			     24, 2, 31, 0x08, 8),
+	/* CLK_CFG_10 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_ENGEN2_SEL, "aud_engen2_sel",
+			     aud_engen2_parents, 0x0B0, 0x0B4, 0x0B8,
+			     0, 2, 7, 0x08, 9),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AES_UFSFDE_SEL, "aes_ufsfde_sel",
+			     aes_ufsfde_parents, 0x0B0, 0x0B4, 0x0B8,
+			     8, 3, 15, 0x08, 10),
+	MUX_CLR_SET_UPD(CLK_TOP_U_SEL, "ufs_sel",
+			ufs_parents, 0x0B0, 0x0B4, 0x0B8,
+			16, 3, 0x08, 11),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_U_MBIST_SEL, "ufs_mbist_sel",
+			     ufs_mbist_parents, 0x0B0, 0x0B4, 0x0B8,
+			     24, 2, 31, 0x08, 12),
+	/* CLK_CFG_11 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_1_SEL, "aud_1_sel",
+			     aud_1_parents, 0x0C0, 0x0C4, 0x0C8,
+			     0, 1, 7, 0x08, 13),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_2_SEL, "aud_2_sel",
+			     aud_2_parents, 0x0C0, 0x0C4, 0x0C8,
+			     8, 1, 15, 0x08, 14),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_VENC_SEL, "venc_sel",
+			     venc_parents, 0x0C0, 0x0C4, 0x0C8,
+			     16, 4, 23, 0x08, 15),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_VDEC_SEL, "vdec_sel",
+			     vdec_parents, 0x0C0, 0x0C4, 0x0C8,
+			     24, 4, 31, 0x08, 16),
+	/* CLK_CFG_12 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_PWM_SEL, "pwm_sel",
+			     pwm_parents, 0x0D0, 0x0D4, 0x0D8,
+			     0, 1, 7, 0x08, 17),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUDIO_H_SEL, "audio_h_sel",
+			     audio_h_parents, 0x0D0, 0x0D4, 0x0D8,
+			     8, 2, 15, 0x08, 18),
+	MUX_CLR_SET_UPD(CLK_TOP_MCUPM_SEL, "mcupm_sel",
+			mcupm_parents, 0x0D0, 0x0D4, 0x0D8,
+			16, 2, 0x08, 19),
+	MUX_CLR_SET_UPD(CLK_TOP_MEM_SUB_SEL, "mem_sub_sel",
+			mem_sub_parents, 0x0D0, 0x0D4, 0x0D8,
+			24, 4, 0x08, 20),
+	/* CLK_CFG_13 */
+	MUX_CLR_SET_UPD(CLK_TOP_MEM_SUB_PERI_SEL, "mem_sub_peri_sel",
+			mem_sub_peri_u_parents, 0x0E0, 0x0E4, 0x0E8,
+			0, 3, 0x08, 21),
+	MUX_CLR_SET_UPD(CLK_TOP_MEM_SUB_U_SEL, "mem_sub_u_sel",
+			mem_sub_peri_u_parents, 0x0E0, 0x0E4, 0x0E8,
+			8, 3, 0x08, 22),
+	MUX_CLR_SET_UPD(CLK_TOP_EMI_N_SEL, "emi_n_sel",
+			emi_n_parents, 0x0E0, 0x0E4, 0x0E8,
+			16, 3, 0x08, 23),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DSI_OCC_SEL, "dsi_occ_sel",
+			     dsi_occ_parents, 0x0E0, 0x0E4, 0x0E8,
+			     24, 2, 31, 0x08, 24),
+	/* CLK_CFG_14 */
+	MUX_CLR_SET_UPD(CLK_TOP_AP2CONN_HOST_SEL, "ap2conn_host_sel",
+			ap2conn_host_parents, 0x0F0, 0x0F4, 0x0F8,
+			0, 1, 0x08, 25),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_IMG1_SEL, "img1_sel",
+			     img1_parents, 0x0F0, 0x0F4, 0x0F8,
+			     8, 4, 15, 0x08, 26),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_IPE_SEL, "ipe_sel",
+			     ipe_parents, 0x0F0, 0x0F4, 0x0F8,
+			     16, 4, 23, 0x08, 27),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAM_SEL, "cam_sel",
+			     cam_parents, 0x0F0, 0x0F4, 0x0F8,
+			     24, 4, 31, 0x08, 28),
+	/* CLK_CFG_15 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTM_SEL, "camtm_sel",
+			     camtm_parents, 0x100, 0x104, 0x108,
+			     0, 2, 7, 0x08, 29),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DSP_SEL, "dsp_sel",
+			     dsp_parents, 0x100, 0x104, 0x108,
+			     8, 3, 15, 0x08, 30),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SR_PKA_SEL, "sr_pka_sel",
+			     sr_pka_parents, 0x100, 0x104, 0x108,
+			     16, 3, 23, 0x0c, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DXCC_SEL, "dxcc_sel",
+			     dxcc_parents, 0x100, 0x104, 0x108,
+			     24, 2, 31, 0x0c, 1),
+	/* CLK_CFG_16 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MFG_REF_SEL, "mfg_ref_sel",
+			     mfg_ref_parents, 0x110, 0x114, 0x118,
+			     0, 2, 7, 0x0c, 2),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MDP0_SEL, "mdp0_sel",
+			     mmsys_parents, 0x110, 0x114, 0x118,
+			     8, 4, 15, 0x0c, 3),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DP_SEL, "dp_sel",
+			     dp_parents, 0x110, 0x114, 0x118,
+			     16, 3, 23, 0x0c, 4),
+	MUX_CLR_SET_UPD(CLK_TOP_EDP_SEL, "edp_sel",
+			edp_parents, 0x110, 0x114, 0x118,
+			24, 3, 0x0c, 5),
+	/* CLK_CFG_17 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_EDP_FAVT_SEL, "edp_favt_sel",
+			     edp_parents, 0x180, 0x184, 0x188,
+			     0, 3, 7, 0x0c, 6),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ETH_250M_SEL, "snps_eth_250m_sel",
+			     snps_eth_250m_parents, 0x180, 0x184, 0x188,
+			     8, 1, 15, 0x0c, 7),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ETH_62P4M_PTP_SEL,
+			     "snps_eth_62p4m_ptp_sel",
+			     snps_eth_62p4m_ptp_parents,
+			     0x180, 0x184, 0x188, 16, 2, 23, 0x0c, 8),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ETH_50M_RMII_SEL,
+			     "snps_eth_50m_rmii_sel",
+			     snps_eth_50m_rmii_parents,
+			     0x180, 0x184, 0x188, 24, 1, 31, 0x0c, 9),
+	/* CLK_CFG_18 */
+	MUX_CLR_SET_UPD(CLK_TOP_SFLASH_SEL, "sflash_sel",
+			sflash_parents, 0x190, 0x194, 0x198,
+			0, 3, 0x0c, 10),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_GCPU_SEL, "gcpu_sel",
+			     gcpu_parents, 0x190, 0x194, 0x198,
+			     8, 3, 15, 0x0c, 11),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MAC_TL_SEL, "pcie_mac_tl_sel",
+			     pcie_mac_tl_parents, 0x190, 0x194, 0x198,
+			     16, 2, 23, 0x0c, 12),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_VDSTX_DG_CTS_SEL, "vdstx_dg_cts_sel",
+			     vdstx_dg_cts_parents, 0x190, 0x194, 0x198,
+			     24, 2, 31, 0x0c, 13),
+	/* CLK_CFG_19 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_PLL_DPIX_SEL, "pll_dpix_sel",
+			     pll_dpix_parents, 0x240, 0x244, 0x248,
+			     0, 2, 7, 0x0c, 14),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ECC_SEL, "ecc_sel",
+			     ecc_parents, 0x240, 0x244, 0x248,
+			     8, 3, 15, 0x0c, 15),
+	/* CLK_MISC_CFG_3 */
+	GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MFG_SEL_MFGPLL, "mfg_sel_mfgpll",
+			       mfg_sel_mfgpll_parents,
+			       0x510, 0x514, 0x0518, 16, 1, 0, -1, -1,
+			       CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+			       mtk_mux_clr_set_upd_ops)
+};
+
+static const struct mtk_composite top_composites[] = {
+	/* CLK_AUDDIV_0 */
+	MUX(CLK_TOP_APLL_I2SIN0_MCK_SEL, "apll_i2sin0_m_sel",
+	    apll_m_parents, 0x0320, 16, 1),
+	MUX(CLK_TOP_APLL_I2SIN1_MCK_SEL, "apll_i2sin1_m_sel",
+	    apll_m_parents, 0x0320, 17, 1),
+	MUX(CLK_TOP_APLL_I2SIN2_MCK_SEL, "apll_i2sin2_m_sel",
+	    apll_m_parents, 0x0320, 18, 1),
+	MUX(CLK_TOP_APLL_I2SIN3_MCK_SEL, "apll_i2sin3_m_sel",
+	    apll_m_parents, 0x0320, 19, 1),
+	MUX(CLK_TOP_APLL_I2SIN4_MCK_SEL, "apll_i2sin4_m_sel",
+	    apll_m_parents, 0x0320, 20, 1),
+	MUX(CLK_TOP_APLL_I2SIN6_MCK_SEL, "apll_i2sin6_m_sel",
+	    apll_m_parents, 0x0320, 21, 1),
+	MUX(CLK_TOP_APLL_I2SOUT0_MCK_SEL, "apll_i2sout0_m_sel",
+	    apll_m_parents, 0x0320, 22, 1),
+	MUX(CLK_TOP_APLL_I2SOUT1_MCK_SEL, "apll_i2sout1_m_sel",
+	    apll_m_parents, 0x0320, 23, 1),
+	MUX(CLK_TOP_APLL_I2SOUT2_MCK_SEL, "apll_i2sout2_m_sel",
+	    apll_m_parents, 0x0320, 24, 1),
+	MUX(CLK_TOP_APLL_I2SOUT3_MCK_SEL, "apll_i2sout3_m_sel",
+	    apll_m_parents, 0x0320, 25, 1),
+	MUX(CLK_TOP_APLL_I2SOUT4_MCK_SEL, "apll_i2sout4_m_sel",
+	    apll_m_parents, 0x0320, 26, 1),
+	MUX(CLK_TOP_APLL_I2SOUT6_MCK_SEL, "apll_i2sout6_m_sel",
+	    apll_m_parents, 0x0320, 27, 1),
+	MUX(CLK_TOP_APLL_FMI2S_MCK_SEL, "apll_fmi2s_m_sel",
+	    apll_m_parents, 0x0320, 28, 1),
+	MUX(CLK_TOP_APLL_TDMOUT_MCK_SEL, "apll_tdmout_m_sel",
+	    apll_m_parents, 0x0320, 29, 1),
+	/* CLK_AUDDIV_2 */
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV_I2SIN0, "apll12_div_i2sin0",
+		 "apll_i2sin0_m_sel", 0x0320, 0, 0x0328, 8, 0),
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV_I2SIN1, "apll12_div_i2sin1",
+		 "apll_i2sin1_m_sel", 0x0320, 1, 0x0328, 8, 8),
+	/* CLK_AUDDIV_3 */
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV_I2SOUT0, "apll12_div_i2sout0",
+		 "apll_i2sout0_m_sel", 0x0320, 6, 0x0334, 8, 16),
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV_I2SOUT1, "apll12_div_i2sout1",
+		 "apll_i2sout1_m_sel", 0x0320, 7, 0x0334, 8, 24),
+	/* CLK_AUDDIV_5 */
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV_FMI2S, "apll12_div_fmi2s",
+		 "apll_fmi2s_m_sel", 0x0320, 12, 0x033C, 8, 0),
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV_TDMOUT_M, "apll12_div_tdmout_m",
+		 "apll_tdmout_m_sel", 0x0320, 13, 0x033C, 8, 8),
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV_TDMOUT_B, "apll12_div_tdmout_b",
+		 "apll12_div_tdmout_m", 0x0320, 14, 0x033C, 8, 16),
+};
+
+static const struct mtk_gate_regs top_cg_regs = {
+	.set_ofs = 0x514,
+	.clr_ofs = 0x518,
+	.sta_ofs = 0x510,
+};
+
+#define GATE_TOP_FLAGS(_id, _name, _parent, _shift, _flag) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &top_cg_regs,			\
+		.shift = _shift,			\
+		.flags = _flag,				\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+	}
+
+#define GATE_TOP(_id, _name, _parent, _shift)		\
+	GATE_TOP_FLAGS(_id, _name, _parent, _shift, 0)
+
+static const struct mtk_gate top_clks[] = {
+	GATE_TOP_FLAGS(CLK_TOP_FMCNT_P0_EN, "fmcnt_p0_en",
+		       "univpll_192m_d4", 0, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_FMCNT_P1_EN, "fmcnt_p1_en",
+		       "univpll_192m_d4", 1, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_FMCNT_P2_EN, "fmcnt_p2_en",
+		       "univpll_192m_d4", 2, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_FMCNT_P3_EN, "fmcnt_p3_en",
+		       "univpll_192m_d4", 3, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_FMCNT_P4_EN, "fmcnt_p4_en",
+		       "univpll_192m_d4", 4, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_USB_F26M_CK_EN, "ssusb_f26m",
+		       "clk26m", 5, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_SSPXTP_F26M_CK_EN, "sspxtp_f26m",
+		       "clk26m", 6, CLK_IS_CRITICAL),
+	GATE_TOP(CLK_TOP_USB2_PHY_RF_P0_EN, "usb2_phy_rf_p0_en",
+		 "clk26m", 7),
+	GATE_TOP(CLK_TOP_USB2_PHY_RF_P1_EN, "usb2_phy_rf_p1_en",
+		 "clk26m", 10),
+	GATE_TOP(CLK_TOP_USB2_PHY_RF_P2_EN, "usb2_phy_rf_p2_en",
+		 "clk26m", 11),
+	GATE_TOP(CLK_TOP_USB2_PHY_RF_P3_EN, "usb2_phy_rf_p3_en",
+		 "clk26m", 12),
+	GATE_TOP(CLK_TOP_USB2_PHY_RF_P4_EN, "usb2_phy_rf_p4_en",
+		 "clk26m", 13),
+	GATE_TOP_FLAGS(CLK_TOP_USB2_26M_CK_P0_EN, "usb2_26m_p0_en",
+		       "clk26m", 14, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_USB2_26M_CK_P1_EN, "usb2_26m_p1_en",
+		       "clk26m", 15, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_USB2_26M_CK_P2_EN, "usb2_26m_p2_en",
+		       "clk26m", 18, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_USB2_26M_CK_P3_EN, "usb2_26m_p3_en",
+		       "clk26m", 19, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_USB2_26M_CK_P4_EN, "usb2_26m_p4_en",
+		       "clk26m", 20, CLK_IS_CRITICAL),
+	GATE_TOP(CLK_TOP_F26M_CK_EN, "pcie_f26m",
+		 "clk26m", 21),
+	GATE_TOP_FLAGS(CLK_TOP_AP2CON_EN, "ap2con",
+		       "clk26m", 24, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_EINT_N_EN, "eint_n",
+		       "clk26m", 25, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_TOPCKGEN_FMIPI_CSI_UP26M_CK_EN,
+		       "TOPCKGEN_fmipi_csi_up26m",
+		       "osc_d10", 26, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_EINT_E_EN, "eint_e",
+		       "clk26m", 28, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_EINT_W_EN, "eint_w",
+		       "clk26m", 30, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_EINT_S_EN, "eint_s",
+		       "clk26m", 31, CLK_IS_CRITICAL),
+};
+
+/* Register mux notifier for MFG mux */
+static int clk_mt8189_reg_mfg_mux_notifier(struct device *dev,
+					   struct clk *clk)
+{
+	struct mtk_mux_nb *mfg_mux_nb;
+
+	mfg_mux_nb = devm_kzalloc(dev, sizeof(*mfg_mux_nb), GFP_KERNEL);
+	if (!mfg_mux_nb)
+		return -ENOMEM;
+
+	mfg_mux_nb->ops = &mtk_mux_clr_set_upd_ops;
+	mfg_mux_nb->bypass_index = 0; /* Bypass to CLK_TOP_MFG_REF_SEL */
+
+	return devm_mtk_clk_mux_notifier_register(dev, clk, mfg_mux_nb);
+}
+
+static const struct mtk_clk_desc topck_desc = {
+	.fixed_clks = top_fixed_clks,
+	.num_fixed_clks = ARRAY_SIZE(top_fixed_clks),
+	.factor_clks = top_divs,
+	.num_factor_clks = ARRAY_SIZE(top_divs),
+	.mux_clks = top_muxes,
+	.num_mux_clks = ARRAY_SIZE(top_muxes),
+	.composite_clks = top_composites,
+	.num_composite_clks = ARRAY_SIZE(top_composites),
+	.clks = top_clks,
+	.num_clks = ARRAY_SIZE(top_clks),
+	.clk_notifier_func = clk_mt8189_reg_mfg_mux_notifier,
+	.mfg_clk_idx = CLK_TOP_MFG_SEL_MFGPLL,
+	.clk_lock = &mt8189_clk_lock,
+};
+
+static const struct of_device_id of_match_clk_mt8189_topck[] = {
+	{ .compatible = "mediatek,mt8189-topckgen", .data = &topck_desc },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8189_topck_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8189-topck",
+		.of_match_table = of_match_clk_mt8189_topck,
+	},
+};
+
+module_platform_driver(clk_mt8189_topck_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-ufs.c b/drivers/clk/mediatek/clk-mt8189-ufs.c
new file mode 100644
index 000000000000..f1e8bc4e4061
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-ufs.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static const struct mtk_gate_regs ufscfg_ao_reg_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xC,
+	.sta_ofs = 0x4,
+};
+
+#define GATE_UFSCFG_AO_REG(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ufscfg_ao_reg_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate ufscfg_ao_reg_clks[] = {
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_TX_SYM,
+			   "ufscfg_ao_unipro_tx_sym", "clk26m", 1),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM0,
+			   "ufscfg_ao_unipro_rx_sym0", "clk26m", 2),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM1,
+			   "ufscfg_ao_unipro_rx_sym1", "clk26m", 3),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_SYS,
+			   "ufscfg_ao_unipro_sys", "ufs_sel", 4),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_U_SAP_CFG,
+			   "ufscfg_ao_u_sap_cfg", "clk26m", 5),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_U_PHY_TOP_AHB_S_BUS,
+			   "ufscfg_ao_u_phy_ahb_s_bus", "axi_u_sel", 6),
+};
+
+static const struct mtk_clk_desc ufscfg_ao_reg_mcd = {
+	.clks = ufscfg_ao_reg_clks,
+	.num_clks = ARRAY_SIZE(ufscfg_ao_reg_clks),
+};
+
+static const struct mtk_gate_regs ufscfg_pdn_reg_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xC,
+	.sta_ofs = 0x4,
+};
+
+#define GATE_UFSCFG_PDN_REG(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ufscfg_pdn_reg_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate ufscfg_pdn_reg_clks[] = {
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_UFS,
+			    "ufscfg_ufshci_ufs", "ufs_sel", 0),
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_AES,
+			    "ufscfg_ufshci_aes", "aes_ufsfde_sel", 1),
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_U_AHB,
+			    "ufscfg_ufshci_u_ahb", "axi_u_sel", 3),
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_U_AXI,
+			    "ufscfg_ufshci_u_axi", "mem_sub_u_sel", 5),
+};
+
+static const struct mtk_clk_desc ufscfg_pdn_reg_mcd = {
+	.clks = ufscfg_pdn_reg_clks,
+	.num_clks = ARRAY_SIZE(ufscfg_pdn_reg_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_ufs[] = {
+	{
+		.compatible = "mediatek,mt8189-ufscfg-ao",
+		.data = &ufscfg_ao_reg_mcd
+	}, {
+		.compatible = "mediatek,mt8189-ufscfg-pdn",
+		.data = &ufscfg_pdn_reg_mcd
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8189_ufs_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8189-ufs",
+		.of_match_table = of_match_clk_mt8189_ufs,
+	},
+};
+
+module_platform_driver(clk_mt8189_ufs_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-vcodec.c b/drivers/clk/mediatek/clk-mt8189-vcodec.c
new file mode 100644
index 000000000000..c6fc453a6ff0
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-vcodec.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static const struct mtk_gate_regs vdec_core0_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs vdec_core1_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xC,
+	.sta_ofs = 0x8,
+};
+
+#define GATE_VDEC_CORE0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vdec_core0_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+#define GATE_VDEC_CORE1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vdec_core1_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate vdec_core_clks[] = {
+	/* VDEC_CORE0 */
+	GATE_VDEC_CORE0(CLK_VDEC_CORE_VDEC_CKEN, "vdec_core_vdec_cken",
+			"vdec_sel", 0),
+	GATE_VDEC_CORE0(CLK_VDEC_CORE_VDEC_ACTIVE, "vdec_core_vdec_active",
+			"vdec_sel", 4),
+	/* VDEC_CORE1 */
+	GATE_VDEC_CORE1(CLK_VDEC_CORE_LARB_CKEN, "vdec_core_larb_cken",
+			"vdec_sel", 0),
+};
+
+static const struct mtk_clk_desc vdec_core_mcd = {
+	.clks = vdec_core_clks,
+	.num_clks = ARRAY_SIZE(vdec_core_clks),
+};
+
+static const struct mtk_gate_regs ven1_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_VEN1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ven1_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate ven1_clks[] = {
+	GATE_VEN1(CLK_VEN1_CKE0_LARB, "ven1_larb", "venc_sel", 0),
+	GATE_VEN1(CLK_VEN1_CKE1_VENC, "ven1_venc", "venc_sel", 4),
+	GATE_VEN1(CLK_VEN1_CKE2_JPGENC, "ven1_jpgenc", "venc_sel", 8),
+	GATE_VEN1(CLK_VEN1_CKE3_JPGDEC, "ven1_jpgdec", "venc_sel", 12),
+	GATE_VEN1(CLK_VEN1_CKE4_JPGDEC_C1, "ven1_jpgdec_c1",
+		  "venc_sel", 16),
+	GATE_VEN1(CLK_VEN1_CKE5_GALS, "ven1_gals", "venc_sel", 28),
+	GATE_VEN1(CLK_VEN1_CKE6_GALS_SRAM, "ven1_gals_sram",
+		  "venc_sel", 31),
+};
+
+static const struct mtk_clk_desc ven1_mcd = {
+	.clks = ven1_clks,
+	.num_clks = ARRAY_SIZE(ven1_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_vcodec[] = {
+	{
+		.compatible = "mediatek,mt8189-vdec-core",
+		.data = &vdec_core_mcd
+	}, {
+		.compatible = "mediatek,mt8189-venc",
+		.data = &ven1_mcd
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8189_vcodec_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8189-vcodec",
+		.of_match_table = of_match_clk_mt8189_vcodec,
+	},
+};
+
+module_platform_driver(clk_mt8189_vcodec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-vlpcfg.c b/drivers/clk/mediatek/clk-mt8189-vlpcfg.c
new file mode 100644
index 000000000000..e9c0240c6bb6
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-vlpcfg.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static const struct mtk_gate_regs vlpcfg_ao_reg_cg_regs = {
+	.set_ofs = 0x800,
+	.clr_ofs = 0x800,
+	.sta_ofs = 0x800,
+};
+
+#define GATE_VLPCFG_AO_REG(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vlpcfg_ao_reg_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+	}
+
+static const struct mtk_gate vlpcfg_ao_reg_clks[] = {
+	GATE_VLPCFG_AO_REG(EN, "en", "clk26m", 8),
+};
+
+static const struct mtk_clk_desc vlpcfg_ao_reg_mcd = {
+	.clks = vlpcfg_ao_reg_clks,
+	.num_clks = ARRAY_SIZE(vlpcfg_ao_reg_clks),
+};
+
+static const struct mtk_gate_regs vlpcfg_reg_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x4,
+};
+
+#define GATE_VLPCFG_REG_FLAGS(_id, _name, _parent, _shift, _flags) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vlpcfg_reg_cg_regs,		\
+		.shift = _shift,			\
+		.flags = _flags,			\
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
+	}
+
+#define GATE_VLPCFG_REG(_id, _name, _parent, _shift)		\
+	GATE_VLPCFG_REG_FLAGS(_id, _name, _parent, _shift, 0)
+
+static const struct mtk_gate vlpcfg_reg_clks[] = {
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SCP, "vlpcfg_scp_ck",
+			      "vlp_scp_sel", 28, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_RG_R_APXGPT_26M,
+			      "vlpcfg_r_apxgpt_26m_ck",
+			      "clk26m", 24, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_DPMSRCK_TEST,
+			      "vlpcfg_dpmsrck_test_ck",
+			      "clk26m", 23, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_RG_DPMSRRTC_TEST,
+			      "vlpcfg_dpmsrrtc_test_ck",
+			      "clk32k", 22, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_DPMSRULP_TEST,
+			      "vlpcfg_dpmsrulp_test_ck",
+			      "osc_d10", 21, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SPMI_P_MST,
+			      "vlpcfg_spmi_p_ck",
+			      "vlp_spmi_p_sel", 20, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SPMI_P_MST_32K,
+			      "vlpcfg_spmi_p_32k_ck",
+			      "clk32k", 18, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_PMIF_SPMI_P_SYS,
+			      "vlpcfg_pmif_spmi_p_sys_ck",
+			      "vlp_pwrap_ulposc_sel", 13, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_PMIF_SPMI_P_TMR,
+			      "vlpcfg_pmif_spmi_p_tmr_ck",
+			      "vlp_pwrap_ulposc_sel", 12, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG(CLK_VLPCFG_REG_PMIF_SPMI_M_SYS,
+			"vlpcfg_pmif_spmi_m_sys_ck",
+			"vlp_pwrap_ulposc_sel", 11),
+	GATE_VLPCFG_REG(CLK_VLPCFG_REG_PMIF_SPMI_M_TMR,
+			"vlpcfg_pmif_spmi_m_tmr_ck",
+			"vlp_pwrap_ulposc_sel", 10),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_DVFSRC,
+			      "vlpcfg_dvfsrc_ck",
+			      "vlp_dvfsrc_sel", 9, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_PWM_VLP,
+			      "vlpcfg_pwm_vlp_ck",
+			      "vlp_pwm_vlp_sel", 8, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SRCK,
+			      "vlpcfg_srck_ck",
+			      "vlp_srck_sel", 7, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SSPM_F26M,
+			      "vlpcfg_sspm_f26m_ck",
+			      "vlp_sspm_f26m_sel", 4, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SSPM_F32K,
+			      "vlpcfg_sspm_f32k_ck",
+			      "clk32k", 3, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SSPM_ULPOSC,
+			      "vlpcfg_sspm_ulposc_ck",
+			      "vlp_sspm_ulposc_sel", 2, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_VLP_32K_COM,
+			      "vlpcfg_vlp_32k_com_ck",
+			      "clk32k", 1, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_VLP_26M_COM,
+			      "vlpcfg_vlp_26m_com_ck",
+			      "clk26m", 0, CLK_IS_CRITICAL),
+};
+
+static const struct mtk_clk_desc vlpcfg_reg_mcd = {
+	.clks = vlpcfg_reg_clks,
+	.num_clks = ARRAY_SIZE(vlpcfg_reg_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_vlpcfg[] = {
+	{
+		.compatible = "mediatek,mt8189-vlp-ao-ckgen",
+		.data = &vlpcfg_ao_reg_mcd
+	}, {
+		.compatible = "mediatek,mt8189-vlpcfg-reg-bus",
+		.data = &vlpcfg_reg_mcd
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8189_vlpcfg_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8189-vlpcfg",
+		.of_match_table = of_match_clk_mt8189_vlpcfg,
+	},
+};
+
+module_platform_driver(clk_mt8189_vlpcfg_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-vlpckgen.c b/drivers/clk/mediatek/clk-mt8189-vlpckgen.c
new file mode 100644
index 000000000000..ff30a79a207f
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-vlpckgen.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "clk-mtk.h"
+#include "clk-mux.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static DEFINE_SPINLOCK(mt8189_vlpclk_lock);
+
+static const char * const vlp_26m_oscd10_parents[] = {
+	"clk26m",
+	"osc_d10"
+};
+
+static const char * const vlp_vadsp_vowpll_parents[] = {
+	"clk26m",
+	"vowpll_ck"
+};
+
+static const char * const vlp_sspm_ulposc_parents[] = {
+	"ulposc",
+	"univpll_d5_d2",
+	"osc_d10"
+};
+
+static const char * const vlp_aud_adc_parents[] = {
+	"clk26m",
+	"vowpll_ck",
+	"aud_adc_ext_ck",
+	"osc_d10"
+};
+
+static const char * const vlp_scp_iic_spi_parents[] = {
+	"clk26m",
+	"mainpll_d5_d4",
+	"mainpll_d7_d2",
+	"osc_d10"
+};
+
+static const char * const vlp_vadsp_uarthub_b_parents[] = {
+	"clk26m",
+	"osc_d10",
+	"univpll_d6_d4",
+	"univpll_d6_d2"
+};
+
+static const char * const vlp_axi_kp_parents[] = {
+	"clk26m",
+	"osc_d10",
+	"osc_d2",
+	"mainpll_d7_d4",
+	"mainpll_d7_d2"
+};
+
+static const char * const vlp_sspm_parents[] = {
+	"clk26m",
+	"osc_d10",
+	"mainpll_d5_d2",
+	"ulposc",
+	"mainpll_d6"
+};
+
+static const char * const vlp_pwm_vlp_parents[] = {
+	"clk26m",
+	"osc_d4",
+	"clk32k",
+	"osc_d10",
+	"mainpll_d4_d8"
+};
+
+static const char * const vlp_pwrap_ulposc_parents[] = {
+	"clk26m",
+	"osc_d10",
+	"osc_d7",
+	"osc_d8",
+	"osc_d16",
+	"mainpll_d7_d8"
+};
+
+static const char * const vlp_vadsp_parents[] = {
+	"clk26m",
+	"osc_d20",
+	"osc_d10",
+	"osc_d2",
+	"ulposc",
+	"mainpll_d4_d2"
+};
+
+static const char * const vlp_scp_parents[] = {
+	"clk26m",
+	"univpll_d4",
+	"univpll_d3",
+	"mainpll_d3",
+	"univpll_d6",
+	"apll1",
+	"mainpll_d4",
+	"mainpll_d6",
+	"mainpll_d7",
+	"osc_d10"
+};
+
+static const char * const vlp_spmi_p_parents[] = {
+	"clk26m",
+	"f26m_d2",
+	"osc_d8",
+	"osc_d10",
+	"osc_d16",
+	"osc_d7",
+	"clk32k",
+	"mainpll_d7_d8",
+	"mainpll_d6_d8",
+	"mainpll_d5_d8"
+};
+
+static const char * const vlp_camtg_parents[] = {
+	"clk26m",
+	"univpll_192m_d8",
+	"univpll_d6_d8",
+	"univpll_192m_d4",
+	"osc_d16",
+	"osc_d20",
+	"osc_d10",
+	"univpll_d6_d16",
+	"tvdpll1_d16",
+	"f26m_d2",
+	"univpll_192m_d10",
+	"univpll_192m_d16",
+	"univpll_192m_d32"
+};
+
+static const struct mtk_mux vlp_ck_muxes[] = {
+	/* VLP_CLK_CFG_0 */
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_SCP_SEL, "vlp_scp_sel",
+			     vlp_scp_parents, 0x008, 0x00C, 0x010,
+			     0, 4, 7, 0x04, 0),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_PWRAP_ULPOSC_SEL, "vlp_pwrap_osc_sel",
+			vlp_pwrap_ulposc_parents, 0x008, 0x00C, 0x010,
+			8, 3, 0x04, 1),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SPMI_P_MST_SEL, "vlp_spmi_p_sel",
+			vlp_spmi_p_parents, 0x008, 0x00C, 0x010,
+			16, 4, 0x04, 2),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_DVFSRC_SEL, "vlp_dvfsrc_sel",
+			vlp_26m_oscd10_parents, 0x008, 0x00C, 0x010,
+			24, 1, 0x04, 3),
+	/* VLP_CLK_CFG_1 */
+	MUX_CLR_SET_UPD(CLK_VLP_CK_PWM_VLP_SEL, "vlp_pwm_vlp_sel",
+			vlp_pwm_vlp_parents, 0x014, 0x018, 0x01C,
+			0, 3, 0x04, 4),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_AXI_VLP_SEL, "vlp_axi_vlp_sel",
+			vlp_axi_kp_parents, 0x014, 0x018, 0x01C,
+			8, 3, 0x04, 5),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SYSTIMER_26M_SEL, "vlp_timer_26m_sel",
+			vlp_26m_oscd10_parents, 0x014, 0x018, 0x01C,
+			16, 1, 0x04, 6),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SSPM_SEL, "vlp_sspm_sel",
+			vlp_sspm_parents, 0x014, 0x018, 0x01C,
+			24, 3, 0x04, 7),
+	/* VLP_CLK_CFG_2 */
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SSPM_F26M_SEL, "vlp_sspm_f26m_sel",
+			vlp_26m_oscd10_parents, 0x020, 0x024, 0x028,
+			0, 1, 0x04, 8),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SRCK_SEL, "vlp_srck_sel",
+			vlp_26m_oscd10_parents, 0x020, 0x024, 0x028,
+			8, 1, 0x04, 9),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_SPI_SEL, "vlp_scp_spi_sel",
+			vlp_scp_iic_spi_parents, 0x020, 0x024, 0x028,
+			16, 2, 0x04, 10),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_IIC_SEL, "vlp_scp_iic_sel",
+			vlp_scp_iic_spi_parents, 0x020, 0x024, 0x028,
+			24, 2, 0x04, 11),
+	/* VLP_CLK_CFG_3 */
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_SPI_HIGH_SPD_SEL,
+			"vlp_scp_spi_hs_sel",
+			vlp_scp_iic_spi_parents, 0x02C, 0x030, 0x034,
+			0, 2, 0x04, 12),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_IIC_HIGH_SPD_SEL,
+			"vlp_scp_iic_hs_sel",
+			vlp_scp_iic_spi_parents, 0x02C, 0x030, 0x034,
+			8, 2, 0x04, 13),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SSPM_ULPOSC_SEL, "vlp_sspm_ulposc_sel",
+			vlp_sspm_ulposc_parents, 0x02C, 0x030, 0x034,
+			16, 2, 0x04, 14),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_APXGPT_26M_SEL, "vlp_apxgpt_26m_sel",
+			vlp_26m_oscd10_parents, 0x02C, 0x030, 0x034,
+			24, 1, 0x04, 15),
+	/* VLP_CLK_CFG_4 */
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_VADSP_SEL, "vlp_vadsp_sel",
+			     vlp_vadsp_parents, 0x038, 0x03C, 0x040,
+			     0, 3, 7, 0x04, 16),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_VADSP_VOWPLL_SEL,
+			     "vlp_vadsp_vowpll_sel",
+			     vlp_vadsp_vowpll_parents, 0x038, 0x03C, 0x040,
+			     8, 1, 15, 0x04, 17),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_VADSP_UARTHUB_BCLK_SEL,
+			     "vlp_vadsp_uarthub_b_sel",
+			     vlp_vadsp_uarthub_b_parents,
+			     0x038, 0x03C, 0x040, 16, 2, 23, 0x04, 18),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_CAMTG0_SEL, "vlp_camtg0_sel",
+			     vlp_camtg_parents, 0x038, 0x03C, 0x040,
+			     24, 4, 31, 0x04, 19),
+	/* VLP_CLK_CFG_5 */
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_CAMTG1_SEL, "vlp_camtg1_sel",
+			     vlp_camtg_parents, 0x044, 0x048, 0x04C,
+			     0, 4, 7, 0x04, 20),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_CAMTG2_SEL, "vlp_camtg2_sel",
+			     vlp_camtg_parents, 0x044, 0x048, 0x04C,
+			     8, 4, 15, 0x04, 21),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_AUD_ADC_SEL, "vlp_aud_adc_sel",
+			     vlp_aud_adc_parents, 0x044, 0x048, 0x04C,
+			     16, 2, 23, 0x04, 22),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_KP_IRQ_GEN_SEL, "vlp_kp_irq_sel",
+			     vlp_axi_kp_parents, 0x044, 0x048, 0x04C,
+			     24, 3, 31, 0x04, 23),
+};
+
+static const struct mtk_gate_regs vlp_ck_cg_regs = {
+	.set_ofs = 0x1F4,
+	.clr_ofs = 0x1F8,
+	.sta_ofs = 0x1F0,
+};
+
+#define GATE_VLP_CK_FLAGS(_id, _name, _parent, _shift, _flag) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vlp_ck_cg_regs,		\
+		.shift = _shift,			\
+		.flags = _flag,				\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+	}
+
+#define GATE_VLP_CK(_id, _name, _parent, _shift)	\
+	GATE_VLP_CK_FLAGS(_id, _name, _parent, _shift, 0)
+
+static const struct mtk_gate vlp_ck_clks[] = {
+	GATE_VLP_CK(CLK_VLP_CK_VADSYS_VLP_26M_EN, "vlp_vadsys_vlp_26m",
+		    "clk26m", 1),
+	GATE_VLP_CK_FLAGS(CLK_VLP_CK_FMIPI_CSI_UP26M_CK_EN,
+			  "VLP_fmipi_csi_up26m",
+			  "osc_d10", 11, CLK_IS_CRITICAL),
+};
+
+static const struct mtk_clk_desc vlpck_desc = {
+	.mux_clks = vlp_ck_muxes,
+	.num_mux_clks = ARRAY_SIZE(vlp_ck_muxes),
+	.clks = vlp_ck_clks,
+	.num_clks = ARRAY_SIZE(vlp_ck_clks),
+	.clk_lock = &mt8189_vlpclk_lock,
+};
+
+static const struct of_device_id of_match_clk_mt8189_vlpck[] = {
+	{ .compatible = "mediatek,mt8189-vlp-ckgen", .data = &vlpck_desc },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8189_vlpck_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8189-vlpck",
+		.of_match_table = of_match_clk_mt8189_vlpck,
+	},
+};
+
+module_platform_driver(clk_mt8189_vlpck_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 60990296450b..66f483807de9 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -298,16 +298,20 @@ static int mtk_clk_mux_notifier_cb(struct notifier_block *nb,
 	struct clk_notifier_data *data = _data;
 	struct clk_hw *hw = __clk_get_hw(data->clk);
 	struct mtk_mux_nb *mux_nb = to_mtk_mux_nb(nb);
+	struct clk_hw *p_hw = clk_hw_get_parent_by_index(hw,
+							 mux_nb->bypass_index);
 	int ret = 0;
 
 	switch (event) {
 	case PRE_RATE_CHANGE:
+		clk_prepare_enable(p_hw->clk);
 		mux_nb->original_index = mux_nb->ops->get_parent(hw);
 		ret = mux_nb->ops->set_parent(hw, mux_nb->bypass_index);
 		break;
 	case POST_RATE_CHANGE:
 	case ABORT_RATE_CHANGE:
 		ret = mux_nb->ops->set_parent(hw, mux_nb->original_index);
+		clk_disable_unprepare(p_hw->clk);
 		break;
 	}
 
-- 
2.45.2


