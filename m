Return-Path: <linux-pm+bounces-27955-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BFEACAA89
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 10:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94107177BE8
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 08:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A70B1CDFD4;
	Mon,  2 Jun 2025 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tnqWXleK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63DA2F50;
	Mon,  2 Jun 2025 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748852796; cv=none; b=kWAEg8rjbC4FJWh8WV6ZVRK7Ef6orFfTVimuYyjW++3qp9HIzmkOngvW8a3oJYrh7CylZgi2zsMHAF1bxb2eX3egrNSM21S8wpq32gNnvlwuAEVaH68rgdok3XXV0gId6wI1qqwY6q/NNm7ZXZRqqxFlb3Iwzxba2bAd2bKIUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748852796; c=relaxed/simple;
	bh=fdGSk6ExgiyrgykNNl/bAX4rSjAwjXBFUh0aRvprziY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sbzWA2N5vFFLZKHCT6q5eJxMHJz5tV8RZEeaBIMptZk4rKxxPotucQ6Lm/jtmtS6lJBkHtMlzr+SAVSpPjBevacNXTrICaXUpszs5yeEQCSO9jw+f5RXP/LfZAqpbgJMQpEgRjMAddbswZOc1njNpgTm0JlbkNWH/fqzVGczmm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tnqWXleK; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 40c71dd23f8b11f0813e4fe1310efc19-20250602
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZHyqXKJvG//QuFHBvvsz//dAyOL0/pb/Z57AMzqsp8w=;
	b=tnqWXleKEK4r8RUMVmCut+k5B23N+mY1P1hQQmNlSSG0NclOGrIbhKqS+Xm94YT+etUmf1lAkXFtaM9r9lxYzpbuWaso3T08y+whsVbFlrvA6FhQPsfGQW3zzU+vUuacCQ03uwT+sRXH2RGO4sOOx1kxg77lQ4TFGDV+rYEx9Do=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:f4a45a04-d570-49ac-8bd3-f9891dc1d29d,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:aeee87f1-2ded-45ed-94e2-b3e9fa87100d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:1,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,OSH|NGT
X-CID-BAS: 2,OSH|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 40c71dd23f8b11f0813e4fe1310efc19-20250602
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1607773242; Mon, 02 Jun 2025 16:26:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 2 Jun 2025 16:26:13 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 2 Jun 2025 16:26:13 +0800
From: irving.ch.lin <irving-ch.lin@mediatek.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
	<linux@roeck-us.net>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, <nfraprado@collabora.com>
CC: <angelogioacchino.delregno@collabora.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Irving lin
	<irving-ch.lin@mediatek.corp-partner.google.com>
Subject: clk: mt8189: Porting driver for clk
Date: Mon, 2 Jun 2025 16:25:53 +0800
Message-ID: <20250602082610.1848291-1-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Irving lin <irving-ch.lin@mediatek.corp-partner.google.com>

1. Add mt8189 clk driver
2. Fix mux failed
3. Add apll12_div_tdmout_b
4. Add disable-unused configs

BUG=b:387252012
TEST=emerge-skywalker chromeos-kernel-6_6

Signed-off-by: Irving lin <irving-ch.lin@mediatek.corp-partner.google.com>
---
 drivers/clk/mediatek/Kconfig             |  137 +
 drivers/clk/mediatek/Makefile            |   13 +
 drivers/clk/mediatek/clk-bringup.c       |  107 +
 drivers/clk/mediatek/clk-fmeter-mt8189.c |  537 ++++
 drivers/clk/mediatek/clk-mt8189-adsp.c   |  303 ++
 drivers/clk/mediatek/clk-mt8189-bus.c    |  354 +++
 drivers/clk/mediatek/clk-mt8189-cam.c    |  177 ++
 drivers/clk/mediatek/clk-mt8189-fmeter.h |  156 +
 drivers/clk/mediatek/clk-mt8189-iic.c    |  186 ++
 drivers/clk/mediatek/clk-mt8189-img.c    |  175 ++
 drivers/clk/mediatek/clk-mt8189-mdpsys.c |  159 +
 drivers/clk/mediatek/clk-mt8189-mfg.c    |   89 +
 drivers/clk/mediatek/clk-mt8189-mmsys.c  |  294 ++
 drivers/clk/mediatek/clk-mt8189-scp.c    |  121 +
 drivers/clk/mediatek/clk-mt8189-ufs.c    |  134 +
 drivers/clk/mediatek/clk-mt8189-vcodec.c |  152 +
 drivers/clk/mediatek/clk-mt8189.c        | 3563 ++++++++++++++++++++++
 drivers/clk/mediatek/clk-mux.c           |   22 +-
 drivers/clk/mediatek/clk-pll.h           |   10 +
 drivers/clk/mediatek/clkchk-mt8189.c     | 1550 ++++++++++
 drivers/clk/mediatek/clkchk-mt8189.h     |   95 +
 drivers/clk/mediatek/clkdbg-mt8189.c     |  772 +++++
 23 files changed, 9107 insertions(+), 15 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-bringup.c
 create mode 100644 drivers/clk/mediatek/clk-fmeter-mt8189.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-adsp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-bus.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-fmeter.h
 create mode 100644 drivers/clk/mediatek/clk-mt8189-iic.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mdpsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mmsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-scp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-ufs.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vcodec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189.c
 create mode 100644 drivers/clk/mediatek/clkchk-mt8189.c
 create mode 100644 drivers/clk/mediatek/clkchk-mt8189.h
 create mode 100644 drivers/clk/mediatek/clkdbg-mt8189.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index d541f70dcd7c..6fe29aa76783 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1106,4 +1106,141 @@ config COMMON_CLK_MT8516_AUDSYS
 	help
 	  This driver supports MediaTek MT8516 audsys clocks.
 
+config COMMON_CLK_MT8189
+    bool "Clock driver for MediaTek MT8189"
+    depends on ARM64 || COMPILE_TEST
+    select COMMON_CLK_MEDIATEK
+	select COMMON_CLK_MEDIATEK_FHCTL
+    default ARCH_MEDIATEK
+    help
+      Enable this option to support the clock management for MediaTek MT8189 SoC. This
+	  includes handling of all primary clock functions and features specific to the MT8189
+	  platform. Enabling this driver ensures that the system's clock functionality aligns
+	  with the MediaTek MT8189 hardware capabilities, providing efficient management of
+	  clock speeds and power consumption.
+
+config COMMON_CLK_MT8189_ADSP
+	tristate "Clock driver for MediaTek MT8189 adsp"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this to support the clock management for the adsp interface
+	  on MediaTek MT8189 SoCs. This includes enabling, disabling, and
+	  setting the rate for adsp-related clocks. If you have a adsp
+	  that relies on this SoC and you want to control its clocks, say Y or M
+	  to include this driver in your kernel build.
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
 endmenu
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index f17badea1a46..15b6844ad18d 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -164,3 +164,16 @@ obj-$(CONFIG_COMMON_CLK_MT8365_VDEC) += clk-mt8365-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8365_VENC) += clk-mt8365-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516-apmixedsys.o clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
+
+obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189.o clk-bringup.o
+obj-$(CONFIG_COMMON_CLK_MT8189_ADSP) += clk-mt8189-adsp.o
+obj-$(CONFIG_COMMON_CLK_MT8189_CAM) += clk-mt8189-cam.o
+obj-$(CONFIG_COMMON_CLK_MT8189_MMSYS) += clk-mt8189-mmsys.o
+obj-$(CONFIG_COMMON_CLK_MT8189_IMG) += clk-mt8189-img.o
+obj-$(CONFIG_COMMON_CLK_MT8189_IIC) += clk-mt8189-iic.o
+obj-$(CONFIG_COMMON_CLK_MT8189_BUS) += clk-mt8189-bus.o
+obj-$(CONFIG_COMMON_CLK_MT8189_MDPSYS) += clk-mt8189-mdpsys.o
+obj-$(CONFIG_COMMON_CLK_MT8189_MFG) += clk-mt8189-mfg.o
+obj-$(CONFIG_COMMON_CLK_MT8189_SCP) += clk-mt8189-scp.o
+obj-$(CONFIG_COMMON_CLK_MT8189_UFS) += clk-mt8189-ufs.o
+obj-$(CONFIG_COMMON_CLK_MT8189_VCODEC) += clk-mt8189-vcodec.o
diff --git a/drivers/clk/mediatek/clk-bringup.c b/drivers/clk/mediatek/clk-bringup.c
new file mode 100644
index 000000000000..8f865be3060c
--- /dev/null
+++ b/drivers/clk/mediatek/clk-bringup.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 MediaTek Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
+static int __bring_up_enable(struct platform_device *pdev)
+{
+	struct clk *clk;
+	int clk_con, i;
+
+	clk_con = of_count_phandle_with_args(pdev->dev.of_node, "clocks",
+			"#clock-cells");
+
+	for (i = 0; i < clk_con; i++) {
+		clk = of_clk_get(pdev->dev.of_node, i);
+		if (IS_ERR(clk)) {
+			long ret = PTR_ERR(clk);
+
+			if (ret == -EPROBE_DEFER)
+				pr_notice("clk %d is not ready\n", i);
+			else
+				pr_notice("get clk %d fail, ret=%d, clk_con=%d\n",
+				       i, (int)ret, clk_con);
+		} else {
+			pr_notice("get clk [%d]: %s ok\n", i,
+					__clk_get_name(clk));
+			clk_prepare_enable(clk);
+		}
+	}
+
+	return 0;
+}
+
+static int clk_bring_up_probe(struct platform_device *pdev)
+{
+	return __bring_up_enable(pdev);
+}
+
+static int clk_post_ao_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	u32 enabled;
+
+	of_property_read_u32(node, "mediatek,post_ao", &enabled);
+
+	if (enabled != 1) {
+		pr_notice("btypass_clk_post_ao\n");
+		return 0;
+	}
+
+	return __bring_up_enable(pdev);
+}
+
+static const struct of_device_id bring_up_id_table[] = {
+	{
+		.compatible = "mediatek,clk-bring-up",
+		.data = clk_bring_up_probe,
+	}, {
+		.compatible = "mediatek,clk-post-ao",
+		.data = clk_post_ao_probe,
+	}, {
+		/* sentinel */
+	}
+};
+
+static int bring_up_probe(struct platform_device *pdev)
+{
+	int (*clk_probe)(struct platform_device *pd);
+	int r;
+
+	clk_probe = of_device_get_match_data(&pdev->dev);
+	if (!clk_probe)
+		return -EINVAL;
+
+	r = clk_probe(pdev);
+	if (r)
+		dev_err(&pdev->dev,
+			"could not register clock provider: %s: %d\n",
+			pdev->name, r);
+
+	return r;
+}
+
+static int bring_up_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver bring_up = {
+	.probe		= bring_up_probe,
+	.remove		= bring_up_remove,
+	.driver		= {
+		.name	= "bring_up",
+		.owner	= THIS_MODULE,
+		.of_match_table = bring_up_id_table,
+	},
+};
+
+module_platform_driver(bring_up);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-fmeter-mt8189.c b/drivers/clk/mediatek/clk-fmeter-mt8189.c
new file mode 100644
index 000000000000..96e999c4af0b
--- /dev/null
+++ b/drivers/clk/mediatek/clk-fmeter-mt8189.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "clk-fmeter.h"
+#include "clk-mt8189-fmeter.h"
+
+#define FM_TIMEOUT			30
+
+#define FM_PLL_CK			0
+#define FM_PLL_CKDIV_CK			1
+#define FM_CKDIV_SHIFT			(7)
+#define FM_CKDIV_MASK			GENMASK(10, 7)
+#define FM_POSTDIV_SHIFT		(24)
+#define FM_POSTDIV_MASK			GENMASK(26, 24)
+
+static DEFINE_SPINLOCK(meter_lock);
+#define fmeter_lock(flags)   spin_lock_irqsave(&meter_lock, flags)
+#define fmeter_unlock(flags) spin_unlock_irqrestore(&meter_lock, flags)
+
+#define clk_readl(addr)		readl(addr)
+#define clk_writel(addr, val)	\
+	do { writel(val, addr); wmb(); } while (0) /* sync write */
+
+/* check from topckgen&vlpcksys CODA */
+#define CLK26CALI_0					(0x220)
+#define CLK26CALI_1					(0x224)
+#define CLK_MISC_CFG_0					(0x140)
+#define CLK_DBG_CFG					(0x17C)
+#define VLP_FQMTR_CON0					(0x230)
+#define VLP_FQMTR_CON1					(0x234)
+
+static void __iomem *fm_base[FM_SYS_NUM];
+
+struct fmeter_data {
+	enum fm_sys_id type;
+	const char *name;
+	unsigned int pll_con0;
+	unsigned int pll_con1;
+	unsigned int con0;
+	unsigned int con1;
+};
+
+static struct fmeter_data subsys_fm[] = {
+	[FM_VLP_CKSYS] = {FM_VLP_CKSYS, "fm_vlp_cksys",
+		0, 0, VLP_FQMTR_CON0, VLP_FQMTR_CON1},
+};
+
+const char *comp_list[] = {
+	[FM_APMIXEDSYS] = "mediatek,mt8189-apmixedsys",
+	[FM_TOPCKGEN] = "mediatek,mt8189-topckgen",
+	[FM_VLP_CKSYS] = "mediatek,mt8189-vlp_ckgen",
+};
+
+/*
+ * clk fmeter
+ */
+
+#define FMCLK3(_t, _i, _n, _o, _g, _c) { .type = _t, \
+		.id = _i, .name = _n, .ofs = _o, .grp = _g, .ck_div = _c}
+#define FMCLK2(_t, _i, _n, _o, _p, _c) { .type = _t, \
+		.id = _i, .name = _n, .ofs = _o, .pdn = _p, .ck_div = _c}
+#define FMCLK(_t, _i, _n, _c) { .type = _t, .id = _i, .name = _n, .ck_div = _c}
+
+static const struct fmeter_clk fclks[] = {
+	/* CKGEN Part */
+	FMCLK2(CKGEN, FM_AXI_CK, "fm_axi_ck", 0x0010, 7, 1),
+	FMCLK2(CKGEN, FM_AXI_PERI_CK, "fm_axi_peri_ck", 0x0010, 15, 1),
+	FMCLK2(CKGEN, FM_AXI_U_CK, "fm_axi_u_ck", 0x0010, 23, 1),
+	FMCLK2(CKGEN, FM_BUS_AXIMEM_CK, "fm_bus_aximem_ck", 0x0010, 31, 1),
+	FMCLK2(CKGEN, FM_DISP0_CK, "fm_disp0_ck", 0x0020, 7, 1),
+	FMCLK2(CKGEN, FM_MMINFRA_CK, "fm_mminfra_ck", 0x0020, 15, 1),
+	FMCLK2(CKGEN, FM_UART_CK, "fm_uart_ck", 0x0020, 23, 1),
+	FMCLK2(CKGEN, FM_SPI0_CK, "fm_spi0_ck", 0x0020, 31, 1),
+	FMCLK2(CKGEN, FM_SPI1_CK, "fm_spi1_ck", 0x0030, 7, 1),
+	FMCLK2(CKGEN, FM_SPI2_CK, "fm_spi2_ck", 0x0030, 15, 1),
+	FMCLK2(CKGEN, FM_SPI3_CK, "fm_spi3_ck", 0x0030, 23, 1),
+	FMCLK2(CKGEN, FM_SPI4_CK, "fm_spi4_ck", 0x0030, 31, 1),
+	FMCLK2(CKGEN, FM_SPI5_CK, "fm_spi5_ck", 0x0040, 7, 1),
+	FMCLK2(CKGEN, FM_MSDC_MACRO_0P_CK, "fm_msdc_macro_0p_ck", 0x0040, 15, 1),
+	FMCLK2(CKGEN, FM_MSDC5HCLK_CK, "fm_msdc5hclk_ck", 0x0040, 23, 1),
+	FMCLK2(CKGEN, FM_MSDC50_0_CK, "fm_msdc50_0_ck", 0x0040, 31, 1),
+	FMCLK2(CKGEN, FM_AES_MSDCFDE_CK, "fm_aes_msdcfde_ck", 0x0050, 7, 1),
+	FMCLK2(CKGEN, FM_MSDC_MACRO_1P_CK, "fm_msdc_macro_1p_ck", 0x0050, 15, 1),
+	FMCLK2(CKGEN, FM_MSDC30_1_CK, "fm_msdc30_1_ck", 0x0050, 23, 1),
+	FMCLK2(CKGEN, FM_MSDC30_1_H_CK, "fm_msdc30_1_h_ck", 0x0050, 31, 1),
+	FMCLK2(CKGEN, FM_MSDC_MACRO_2P_CK, "fm_msdc_macro_2p_ck", 0x0060, 7, 1),
+	FMCLK2(CKGEN, FM_MSDC30_2_CK, "fm_msdc30_2_ck", 0x0060, 15, 1),
+	FMCLK2(CKGEN, FM_MSDC30_2_2, "fm_msdc30_2_2", 0x0060, 15, 1),
+	FMCLK2(CKGEN, FM_AUD_INTBUS_CK, "fm_aud_intbus_ck", 0x0060, 31, 1),
+	FMCLK2(CKGEN, FM_ATB_CK, "fm_atb_ck", 0x0070, 7, 1),
+	FMCLK2(CKGEN, FM_DISP_PWM_CK, "fm_disp_pwm_ck", 0x0070, 15, 1),
+	FMCLK2(CKGEN, FM_USB_P0_CK, "fm_usb_p0_ck", 0x0070, 23, 1),
+	FMCLK2(CKGEN, FM_USB_XHCI_P0_CK, "fm_usb_xhci_p0_ck", 0x0070, 31, 1),
+	FMCLK2(CKGEN, FM_USB_P1_CK, "fm_usb_p1_ck", 0x0080, 7, 1),
+	FMCLK2(CKGEN, FM_USB_XHCI_P1_CK, "fm_usb_xhci_p1_ck", 0x0080, 15, 1),
+	FMCLK2(CKGEN, FM_USB_P2_CK, "fm_usb_p2_ck", 0x0080, 23, 1),
+	FMCLK2(CKGEN, FM_USB_XHCI_P2_CK, "fm_usb_xhci_p2_ck", 0x0080, 31, 1),
+	FMCLK2(CKGEN, FM_USB_P3_CK, "fm_usb_p3_ck", 0x0090, 7, 1),
+	FMCLK2(CKGEN, FM_USB_XHCI_P3_CK, "fm_usb_xhci_p3_ck", 0x0090, 15, 1),
+	FMCLK2(CKGEN, FM_USB_P4_CK, "fm_usb_p4_ck", 0x0090, 23, 1),
+	FMCLK2(CKGEN, FM_USB_XHCI_P4_CK, "fm_usb_xhci_p4_ck", 0x0090, 31, 1),
+	FMCLK2(CKGEN, FM_I2C_CK, "fm_i2c_ck", 0x00A0, 7, 1),
+	FMCLK2(CKGEN, FM_SENINF_CK, "fm_seninf_ck", 0x00A0, 15, 1),
+	FMCLK2(CKGEN, FM_SENINF1_CK, "fm_seninf1_ck", 0x00A0, 23, 1),
+	FMCLK2(CKGEN, FM_AUD_ENGEN1_CK, "fm_aud_engen1_ck", 0x00A0, 31, 1),
+	FMCLK2(CKGEN, FM_AUD_ENGEN2_CK, "fm_aud_engen2_ck", 0x00B0, 7, 1),
+	FMCLK2(CKGEN, FM_AES_UFSFDE_CK, "fm_aes_ufsfde_ck", 0x00B0, 15, 1),
+	FMCLK2(CKGEN, FM_U_CK, "fm_u_ck", 0x00B0, 23, 1),
+	FMCLK2(CKGEN, FM_U_MBIST_CK, "fm_u_mbist_ck", 0x00B0, 31, 1),
+	FMCLK2(CKGEN, FM_AUD_1_CK, "fm_aud_1_ck", 0x00C0, 7, 1),
+	FMCLK2(CKGEN, FM_AUD_2_CK, "fm_aud_2_ck", 0x00C0, 15, 1),
+	FMCLK2(CKGEN, FM_VENC_CK, "fm_venc_ck", 0x00C0, 23, 1),
+	FMCLK2(CKGEN, FM_VDEC_CK, "fm_vdec_ck", 0x00C0, 31, 1),
+	FMCLK2(CKGEN, FM_PWM_CK, "fm_pwm_ck", 0x00D0, 7, 1),
+	FMCLK2(CKGEN, FM_AUDIO_H_CK, "fm_audio_h_ck", 0x00D0, 15, 1),
+	FMCLK2(CKGEN, FM_MCUPM_CK, "fm_mcupm_ck", 0x00D0, 23, 1),
+	FMCLK2(CKGEN, FM_MEM_SUB_CK, "fm_mem_sub_ck", 0x00D0, 31, 1),
+	FMCLK2(CKGEN, FM_MEM_SUB_PERI_CK, "fm_mem_sub_peri_ck", 0x00E0, 7, 1),
+	FMCLK2(CKGEN, FM_MEM_SUB_U_CK, "fm_mem_sub_u_ck", 0x00E0, 15, 1),
+	FMCLK2(CKGEN, FM_EMI_N_CK, "fm_emi_n_ck", 0x00E0, 23, 1),
+	FMCLK2(CKGEN, FM_DSI_OCC_CK, "fm_dsi_occ_ck", 0x00E0, 31, 1),
+	FMCLK2(CKGEN, FM_AP2CONN_HOST_CK, "fm_ap2conn_host_ck", 0x00F0, 7, 1),
+	FMCLK2(CKGEN, FM_IMG1_CK, "fm_img1_ck", 0x00F0, 15, 1),
+	FMCLK2(CKGEN, FM_IPE_CK, "fm_ipe_ck", 0x00F0, 23, 1),
+	FMCLK2(CKGEN, FM_CAM_CK, "fm_cam_ck", 0x00F0, 31, 1),
+	FMCLK2(CKGEN, FM_CAMTM_CK, "fm_camtm_ck", 0x0100, 7, 1),
+	FMCLK2(CKGEN, FM_DSP_CK, "fm_dsp_ck", 0x0100, 15, 1),
+	FMCLK2(CKGEN, FM_SR_PKA_CK, "fm_sr_pka_ck", 0x0100, 23, 1),
+	FMCLK2(CKGEN, FM_DXCC_CK, "fm_dxcc_ck", 0x0100, 31, 1),
+	FMCLK2(CKGEN, FM_MFG_REF_CK, "fm_mfg_ref_ck", 0x0110, 7, 1),
+	FMCLK2(CKGEN, FM_MDP0_CK, "fm_mdp0_ck", 0x0110, 15, 1),
+	FMCLK2(CKGEN, FM_DP_CK, "fm_dp_ck", 0x0110, 23, 1),
+	FMCLK2(CKGEN, FM_EDP_CK, "fm_edp_ck", 0x0110, 31, 1),
+	FMCLK2(CKGEN, FM_EDP_FAVT_CK, "fm_edp_favt_ck", 0x0180, 7, 1),
+	FMCLK2(CKGEN, FM_ETH_250M_CK, "fm_eth_250m_ck", 0x0180, 15, 1),
+	FMCLK2(CKGEN, FM_ETH_62P4M_PTP_CK, "fm_eth_62p4m_ptp_ck", 0x0180, 23, 1),
+	FMCLK2(CKGEN, FM_ETH_50M_RMII_CK, "fm_eth_50m_rmii_ck", 0x0180, 31, 1),
+	FMCLK2(CKGEN, FM_SFLASH_CK, "fm_sflash_ck", 0x0190, 7, 1),
+	FMCLK2(CKGEN, FM_GCPU_CK, "fm_gcpu_ck", 0x0190, 15, 1),
+	FMCLK2(CKGEN, FM_CIE_MAC_TL_CK, "fm_cie_mac_tl_ck", 0x0190, 23, 1),
+	FMCLK2(CKGEN, FM_VDSTX_DG_CTS_CK, "fm_vdstx_dg_cts_ck", 0x0190, 31, 1),
+	FMCLK2(CKGEN, FM_PLL_DPIX_CK, "fm_pll_dpix_ck", 0x0240, 7, 1),
+	FMCLK2(CKGEN, FM_ECC_CK, "fm_ecc_ck", 0x0240, 15, 1),
+	/* ABIST Part */
+	FMCLK(ABIST, FM_APLL1_CK, "fm_apll1_ck", 1),
+	FMCLK(ABIST, FM_APLL2_CK, "fm_apll2_ck", 1),
+	FMCLK(ABIST, FM_ARMPLL_BL_CK, "fm_armpll_bl_ck", 1),
+	FMCLK3(ABIST, FM_ARMPLL_BL_CKDIV_CK, "fm_armpll_bl_ckdiv_ck", 0x0218, 3, 13),
+	FMCLK(ABIST, FM_ARMPLL_LL_CK, "fm_armpll_ll_ck", 1),
+	FMCLK3(ABIST, FM_ARMPLL_LL_CKDIV_CK, "fm_armpll_ll_ckdiv_ck", 0x0208, 3, 13),
+	FMCLK(ABIST, FM_CCIPLL_CK, "fm_ccipll_ck", 1),
+	FMCLK3(ABIST, FM_CCIPLL_CKDIV_CK, "fm_ccipll_ckdiv_ck", 0x0228, 3, 13),
+	FMCLK3(ABIST, FM_MAINPLL_CKDIV_CK, "fm_mainpll_ckdiv_ck", 0x0308, 3, 13),
+	FMCLK(ABIST, FM_MAINPLL_CK, "fm_mainpll_ck", 1),
+	FMCLK3(ABIST, FM_MMPLL_CKDIV_CK, "fm_mmpll_ckdiv_ck", 0x0328, 3, 13),
+	FMCLK(ABIST, FM_MMPLL_CK, "fm_mmpll_ck", 1),
+	FMCLK(ABIST, FM_MMPLL_D3_CK, "fm_mmpll_d3_ck", 1),
+	FMCLK(ABIST, FM_MSDCPLL_CK, "fm_msdcpll_ck", 1),
+	FMCLK(ABIST, FM_UFSPLL_CK, "fm_ufspll_ck", 1),
+	FMCLK(ABIST, FM_UNIVPLL_CK, "fm_univpll_ck", 1),
+	FMCLK(ABIST, FM_UNIVPLL_192M_CK, "fm_univpll_192m_ck", 1),
+	FMCLK3(ABIST, FM_APLL1_CKDIV_CK, "fm_apll1_ckdiv_ck", 0x0408, 3, 13),
+	FMCLK3(ABIST, FM_APLL2_CKDIV_CK, "fm_apll2_ckdiv_ck", 0x041C, 3, 13),
+	FMCLK3(ABIST, FM_UFSPLL_CKDIV_CK, "fm_ufspll_ckdiv_ck", 0x0538, 3, 13),
+	FMCLK3(ABIST, FM_MSDCPLL_CKDIV_CK, "fm_msdcpll_ckdiv_ck", 0x0528, 3, 13),
+	FMCLK(ABIST, FM_EMIPLL_CK, "fm_emipll_ck", 1),
+	FMCLK(ABIST, FM_TVDPLL1_CK, "fm_tvdpll1_ck", 1),
+	FMCLK(ABIST, FM_TVDPLL2_CK, "fm_tvdpll2_ck", 1),
+	FMCLK(ABIST, FM_MFGPLL_OPP_CK, "fm_mfgpll_opp_ck", 1),
+	FMCLK(ABIST, FM_ETHPLL_CK, "fm_ethpll_ck", 1),
+	FMCLK(ABIST, FM_APUPLL_CK, "fm_apupll_ck", 1),
+	FMCLK(ABIST, FM_APUPLL2_CK, "fm_apupll2_ck", 1),
+	/* VLPCK Part */
+	FMCLK2(VLPCK, FM_SCP_CK, "fm_scp_ck", 0x0008, 7, 1),
+	FMCLK2(VLPCK, FM_PWRAP_ULPOSC_CK, "fm_pwrap_ulposc_ck", 0x0008, 15, 1),
+	FMCLK2(VLPCK, FM_SPMI_P_CK, "fm_spmi_p_ck", 0x0008, 23, 1),
+	FMCLK2(VLPCK, FM_DVFSRC_CK, "fm_dvfsrc_ck", 0x0008, 31, 1),
+	FMCLK2(VLPCK, FM_PWM_VLP_CK, "fm_pwm_vlp_ck", 0x0014, 7, 1),
+	FMCLK2(VLPCK, FM_AXI_VLP_CK, "fm_axi_vlp_ck", 0x0014, 15, 1),
+	FMCLK2(VLPCK, FM_SYSTIMER_26M_CK, "fm_systimer_26m_ck", 0x0014, 23, 1),
+	FMCLK2(VLPCK, FM_SSPM_CK, "fm_sspm_ck", 0x0014, 31, 1),
+	FMCLK2(VLPCK, FM_SSPM_F26M_CK, "fm_sspm_f26m_ck", 0x0020, 7, 1),
+	FMCLK2(VLPCK, FM_SRCK_CK, "fm_srck_ck", 0x0020, 15, 1),
+	FMCLK2(VLPCK, FM_SCP_SPI_CK, "fm_scp_spi_ck", 0x0020, 23, 1),
+	FMCLK2(VLPCK, FM_SCP_IIC_CK, "fm_scp_iic_ck", 0x0020, 31, 1),
+	FMCLK2(VLPCK, FM_SCP_SPI_HS_CK, "fm_scp_spi_hs_ck", 0x002C, 7, 1),
+	FMCLK2(VLPCK, FM_SCP_IIC_HS_CK, "fm_scp_iic_hs_ck", 0x002C, 15, 1),
+	FMCLK2(VLPCK, FM_SSPM_ULPOSC_CK, "fm_sspm_ulposc_ck", 0x002C, 23, 1),
+	FMCLK2(VLPCK, FM_APXGPT_26M_CK, "fm_apxgpt_26m_ck", 0x002C, 31, 1),
+	FMCLK2(VLPCK, FM_VADSP_CK, "fm_vadsp_ck", 0x0038, 7, 1),
+	FMCLK2(VLPCK, FM_VADSP_VOWPLL_CK, "fm_vadsp_vowpll_ck", 0x0038, 15, 1),
+	FMCLK2(VLPCK, FM_VADSP_UARTHUB_B_CK, "fm_vadsp_uarthub_b_ck", 0x0038, 23, 1),
+	FMCLK2(VLPCK, FM_CAMTG0_CK, "fm_camtg0_ck", 0x0038, 31, 1),
+	FMCLK2(VLPCK, FM_CAMTG1_CK, "fm_camtg1_ck", 0x0044, 7, 1),
+	FMCLK2(VLPCK, FM_CAMTG2_CK, "fm_camtg2_ck", 0x0044, 15, 1),
+	FMCLK2(VLPCK, FM_AUD_ADC_CK, "fm_aud_adc_ck", 0x0044, 23, 1),
+	FMCLK2(VLPCK, FM_KP_IRQ_GEN_CK, "fm_kp_irq_gen_ck", 0x0044, 31, 1),
+	/* SUBSYS Part */
+	{},
+};
+
+const struct fmeter_clk *mt8189_get_fmeter_clks(void)
+{
+	return fclks;
+}
+
+static unsigned int check_pdn(void __iomem *base,
+		unsigned int type, unsigned int ID)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fclks) - 1; i++) {
+		if (fclks[i].type == type && fclks[i].id == ID)
+			break;
+	}
+
+	if (i >= ARRAY_SIZE(fclks) - 1)
+		return 1;
+
+	if (!fclks[i].ofs)
+		return 0;
+
+	if (type == SUBSYS) {
+		if ((clk_readl(base + fclks[i].ofs) & fclks[i].pdn)
+				!= fclks[i].pdn) {
+			return 1;
+		}
+	} else if (type != SUBSYS && ((clk_readl(base + fclks[i].ofs)
+			& BIT(fclks[i].pdn)) == BIT(fclks[i].pdn)))
+		return 1;
+
+	return 0;
+}
+
+static unsigned int get_post_div(unsigned int type, unsigned int ID)
+{
+	unsigned int post_div = 1;
+	int i;
+
+	if ((ID <= 0) || (ID >= FM_ABIST_NUM))
+		return post_div;
+
+	for (i = 0; i < ARRAY_SIZE(fclks) - 1; i++) {
+		if (fclks[i].type == type && fclks[i].id == ID
+				&& fclks[i].grp != 0) {
+			post_div =  clk_readl(fm_base[FM_APMIXEDSYS] + fclks[i].ofs);
+			post_div = 1 << ((post_div >> 24) & 0x7);
+			break;
+		}
+	}
+
+	return post_div;
+}
+
+static unsigned int get_clk_div(unsigned int type, unsigned int ID)
+{
+	unsigned int clk_div = 1;
+	int i;
+
+	if ((ID <= 0) || (ID >= FM_CKGEN_NUM))
+		return clk_div;
+
+	for (i = 0; i < ARRAY_SIZE(fclks) - 1; i++)
+		if (fclks[i].type == type && fclks[i].id == ID)
+			break;
+
+	if (i >= ARRAY_SIZE(fclks) - 1)
+		return clk_div;
+
+	return fclks[i].ck_div;
+}
+
+/* implement ckgen&abist api (example as below) */
+
+static int __mt_get_freq(unsigned int ID, int type)
+{
+	void __iomem *dbg_addr = fm_base[FM_TOPCKGEN] + CLK_DBG_CFG;
+	void __iomem *misc_addr = fm_base[FM_TOPCKGEN] + CLK_MISC_CFG_0;
+	void __iomem *cali0_addr = fm_base[FM_TOPCKGEN] + CLK26CALI_0;
+	void __iomem *cali1_addr = fm_base[FM_TOPCKGEN] + CLK26CALI_1;
+	unsigned int temp, clk_dbg_cfg, clk_misc_cfg_0, clk26cali_1 = 0;
+	unsigned int clk_div = 1, post_div = 1;
+	unsigned long flags;
+	int output = 0, i = 0;
+
+	fmeter_lock(flags);
+
+	if (type == CKGEN && check_pdn(fm_base[FM_TOPCKGEN], CKGEN, ID)) {
+		pr_notice("ID-%d: MUX PDN, return 0.\n", ID);
+		fmeter_unlock(flags);
+		return 0;
+	}
+
+	while (clk_readl(cali0_addr) & 0x10) {
+		udelay(10);
+		i++;
+		if (i > FM_TIMEOUT)
+			break;
+	}
+
+	/* CLK26CALI_0[15]: rst 1 -> 0 */
+	clk_writel(cali0_addr, (clk_readl(cali0_addr) & 0xFFFF7FFF));
+	/* CLK26CALI_0[15]: rst 0 -> 1 */
+	clk_writel(cali0_addr, (clk_readl(cali0_addr) | 0x00008000));
+
+	if (type == CKGEN) {
+		clk_dbg_cfg = clk_readl(dbg_addr);
+		clk_writel(dbg_addr,
+			(clk_dbg_cfg & 0xFFFF80FC) | (ID << 8) | (0x1));
+	} else if (type == ABIST) {
+		clk_dbg_cfg = clk_readl(dbg_addr);
+		clk_writel(dbg_addr,
+			(clk_dbg_cfg & 0xFF80FFFC) | (ID << 16));
+	} else {
+		fmeter_unlock(flags);
+		return 0;
+	}
+
+	clk_misc_cfg_0 = clk_readl(misc_addr);
+	clk_writel(misc_addr, (clk_misc_cfg_0 & 0x00FFFFFF) | (3 << 24));
+
+	clk26cali_1 = clk_readl(cali1_addr);
+	clk_writel(cali0_addr, 0x9000);
+	clk_writel(cali0_addr, 0x9010);
+
+	/* wait frequency meter finish */
+	i = 0;
+	do {
+		udelay(10);
+		i++;
+		if (i > FM_TIMEOUT)
+			break;
+	} while (clk_readl(cali0_addr) & 0x10);
+
+	temp = clk_readl(cali1_addr) & 0xFFFF;
+
+	if (type == ABIST)
+		post_div = get_post_div(type, ID);
+
+	clk_div = get_clk_div(type, ID);
+
+	output = (temp * 26000) / 1024 * clk_div / post_div;
+
+	clk_writel(dbg_addr, clk_dbg_cfg);
+	clk_writel(misc_addr, clk_misc_cfg_0);
+	clk_writel(cali0_addr, 0x8000);
+	clk_writel(cali1_addr, clk26cali_1);
+
+	fmeter_unlock(flags);
+
+	if (i > FM_TIMEOUT)
+		return 0;
+
+	if ((output * 4) < 1000) {
+		pr_notice("%s(%d): CLK_DBG_CFG = 0x%x, CLK_MISC_CFG_0 = 0x%x, CLK26CALI_0 = 0x%x, CLK26CALI_1 = 0x%x\n",
+			__func__,
+			ID,
+			clk_readl(dbg_addr),
+			clk_readl(misc_addr),
+			clk_readl(cali0_addr),
+			clk_readl(cali1_addr));
+	}
+
+	return (output * 4);
+}
+
+/* implement ckgen&abist api (example as below) */
+static int __mt_get_freq2(unsigned int  type, unsigned int id)
+{
+	void __iomem *con0 = fm_base[type] + subsys_fm[type].con0;
+	void __iomem *con1 = fm_base[type] + subsys_fm[type].con1;
+	unsigned int temp, clk_div = 1, post_div = 1;
+	unsigned long flags;
+	int output = 0, i = 0;
+
+	fmeter_lock(flags);
+
+	/* PLL4H_FQMTR_CON1[15]: rst 1 -> 0 */
+	clk_writel(con0, clk_readl(con0) & 0xFFFF7FFF);
+	/* PLL4H_FQMTR_CON1[15]: rst 0 -> 1 */
+	clk_writel(con0, clk_readl(con0) | 0x8000);
+
+	/* sel fqmtr_cksel */
+	if (type == FM_VLP_CKSYS)
+		clk_writel(con0, (clk_readl(con0) & 0xFFE0FFFF) | (id << 16));
+	else
+		clk_writel(con0, (clk_readl(con0) & 0x00FFFFF8) | (id << 0));
+	/* set ckgen_load_cnt to 1024 */
+	clk_writel(con1, (clk_readl(con1) & 0xFC00FFFF) | (0x3FF << 16));
+
+	/* sel fqmtr_cksel and set ckgen_k1 to 0(DIV4) */
+	clk_writel(con0, (clk_readl(con0) & 0x00FFFFFF) | (3 << 24));
+
+	/* fqmtr_en set to 1, fqmtr_exc set to 0, fqmtr_start set to 0 */
+	clk_writel(con0, (clk_readl(con0) & 0xFFFF8007) | 0x1000);
+	/*fqmtr_start set to 1 */
+	clk_writel(con0, clk_readl(con0) | 0x10);
+
+	/* wait frequency meter finish */
+	while (clk_readl(con0) & 0x10) {
+		udelay(10);
+		i++;
+		if (i > 30) {
+			pr_notice("[%d]con0: 0x%x, con1: 0x%x\n",
+				id, clk_readl(con0), clk_readl(con1));
+			break;
+		}
+	}
+
+	temp = clk_readl(con1) & 0xFFFF;
+	output = ((temp * 26000)) / 1024; // Khz
+
+	if (clk_div == 0)
+		clk_div = 1;
+
+	clk_writel(con0, 0x8000);
+
+	fmeter_unlock(flags);
+
+	return (output * 4 * clk_div) / post_div;
+}
+
+static unsigned int mt8189_get_ckgen_freq(unsigned int ID)
+{
+	return __mt_get_freq(ID, CKGEN);
+}
+
+static unsigned int mt8189_get_abist_freq(unsigned int ID)
+{
+	return __mt_get_freq(ID, ABIST);
+}
+
+static unsigned int mt8189_get_vlpck_freq(unsigned int ID)
+{
+	return __mt_get_freq2(FM_VLP_CKSYS, ID);
+}
+
+static unsigned int mt8189_get_fmeter_freq(unsigned int id,
+		enum FMETER_TYPE type)
+{
+	if (type == CKGEN)
+		return mt8189_get_ckgen_freq(id);
+	else if (type == ABIST)
+		return mt8189_get_abist_freq(id);
+	else if (type == VLPCK)
+		return mt8189_get_vlpck_freq(id);
+
+	return FT_NULL;
+}
+
+static void __iomem *get_base_from_comp(const char *comp)
+{
+	struct device_node *node;
+	static void __iomem *base;
+
+	node = of_find_compatible_node(NULL, NULL, comp);
+	if (node) {
+		base = of_iomap(node, 0);
+		if (!base) {
+			pr_info("%s() can't find iomem for %s\n",
+					__func__, comp);
+			return ERR_PTR(-EINVAL);
+		}
+
+		return base;
+	}
+
+	pr_info("%s can't find compatible node\n", __func__);
+
+	return ERR_PTR(-EINVAL);
+}
+
+/*
+ * init functions
+ */
+
+static struct fmeter_ops fm_ops = {
+	.get_fmeter_clks = mt8189_get_fmeter_clks,
+	.get_fmeter_freq = mt8189_get_fmeter_freq,
+};
+
+static int clk_fmeter_mt8189_probe(struct platform_device *pdev)
+{
+	int i;
+
+	for (i = 0; i < FM_SYS_NUM; i++) {
+		fm_base[i] = get_base_from_comp(comp_list[i]);
+		if (IS_ERR(fm_base[i]))
+			goto ERR;
+
+	}
+
+	fmeter_set_ops(&fm_ops);
+
+	return 0;
+ERR:
+	pr_info("%s(%s) can't find base\n", __func__, comp_list[i]);
+
+	return -EINVAL;
+}
+
+static struct platform_driver clk_fmeter_mt8189_drv = {
+	.probe = clk_fmeter_mt8189_probe,
+	.driver = {
+		.name = "clk-fmeter-mt8189",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init clk_fmeter_init(void)
+{
+	static struct platform_device *clk_fmeter_dev;
+
+	clk_fmeter_dev = platform_device_register_simple("clk-fmeter-mt8189", -1, NULL, 0);
+	if (IS_ERR(clk_fmeter_dev))
+		pr_info("unable to register clk-fmeter device");
+
+	return platform_driver_register(&clk_fmeter_mt8189_drv);
+}
+
+static void __exit clk_fmeter_exit(void)
+{
+	platform_driver_unregister(&clk_fmeter_mt8189_drv);
+}
+
+subsys_initcall(clk_fmeter_init);
+module_exit(clk_fmeter_exit);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-adsp.c b/drivers/clk/mediatek/clk-mt8189-adsp.c
new file mode 100644
index 000000000000..b93c4a04ce48
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-adsp.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
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
+#include <dt-bindings/clock/mt8189-clk.h>
+
+#define MT_CCF_BRINGUP		1
+
+/* Regular Number Definition */
+#define INV_OFS			-1
+#define INV_BIT			-1
+
+static const struct mtk_gate_regs afe0_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs afe1_cg_regs = {
+	.set_ofs = 0x10,
+	.clr_ofs = 0x10,
+	.sta_ofs = 0x10,
+};
+
+static const struct mtk_gate_regs afe2_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x4,
+};
+
+static const struct mtk_gate_regs afe3_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x8,
+};
+
+static const struct mtk_gate_regs afe4_cg_regs = {
+	.set_ofs = 0xC,
+	.clr_ofs = 0xC,
+	.sta_ofs = 0xC,
+};
+
+#define GATE_AFE0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &afe0_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_AFE1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &afe1_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_AFE2(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &afe2_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_AFE3(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &afe3_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_AFE4(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &afe4_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate afe_clks[] = {
+	/* AFE0 */
+	GATE_AFE0(CLK_AFE_DL0_DAC_TML, "afe_dl0_dac_tml",
+			"f26m_ck"/* parent */, 7),
+	GATE_AFE0(CLK_AFE_DL0_DAC_HIRES, "afe_dl0_dac_hires",
+			"audio_h_ck"/* parent */, 8),
+	GATE_AFE0(CLK_AFE_DL0_DAC, "afe_dl0_dac",
+			"f26m_ck"/* parent */, 9),
+	GATE_AFE0(CLK_AFE_DL0_PREDIS, "afe_dl0_predis",
+			"f26m_ck"/* parent */, 10),
+	GATE_AFE0(CLK_AFE_DL0_NLE, "afe_dl0_nle",
+			"f26m_ck"/* parent */, 11),
+	GATE_AFE0(CLK_AFE_PCM0, "afe_pcm0",
+			"aud_engen1_ck"/* parent */, 14),
+	GATE_AFE0(CLK_AFE_CM1, "afe_cm1",
+			"f26m_ck"/* parent */, 17),
+	GATE_AFE0(CLK_AFE_CM0, "afe_cm0",
+			"f26m_ck"/* parent */, 18),
+	GATE_AFE0(CLK_AFE_HW_GAIN23, "afe_hw_gain23",
+			"f26m_ck"/* parent */, 20),
+	GATE_AFE0(CLK_AFE_HW_GAIN01, "afe_hw_gain01",
+			"f26m_ck"/* parent */, 21),
+	GATE_AFE0(CLK_AFE_FM_I2S, "afe_fm_i2s",
+			"aud_engen1_ck"/* parent */, 24),
+	GATE_AFE0(CLK_AFE_MTKAIFV4, "afe_mtkaifv4",
+			"f26m_ck"/* parent */, 25),
+	/* AFE1 */
+	GATE_AFE1(CLK_AFE_AUDIO_HOPPING, "afe_audio_hopping_ck",
+			"f26m_ck"/* parent */, 0),
+	GATE_AFE1(CLK_AFE_AUDIO_F26M, "afe_audio_f26m_ck",
+			"f26m_ck"/* parent */, 1),
+	GATE_AFE1(CLK_AFE_APLL1, "afe_apll1_ck",
+			"aud_1_ck"/* parent */, 2),
+	GATE_AFE1(CLK_AFE_APLL2, "afe_apll2_ck",
+			"aud_2_ck"/* parent */, 3),
+	GATE_AFE1(CLK_AFE_H208M, "afe_h208m_ck",
+			"audio_h_ck"/* parent */, 4),
+	GATE_AFE1(CLK_AFE_APLL_TUNER2, "afe_apll_tuner2",
+			"aud_engen2_ck"/* parent */, 12),
+	GATE_AFE1(CLK_AFE_APLL_TUNER1, "afe_apll_tuner1",
+			"aud_engen1_ck"/* parent */, 13),
+	/* AFE2 */
+	GATE_AFE2(CLK_AFE_DMIC1_ADC_HIRES_TML, "afe_dmic1_aht",
+			"audio_h_ck"/* parent */, 0),
+	GATE_AFE2(CLK_AFE_DMIC1_ADC_HIRES, "afe_dmic1_adc_hires",
+			"audio_h_ck"/* parent */, 1),
+	GATE_AFE2(CLK_AFE_DMIC1_TML, "afe_dmic1_tml",
+			"f26m_ck"/* parent */, 2),
+	GATE_AFE2(CLK_AFE_DMIC1_ADC, "afe_dmic1_adc",
+			"f26m_ck"/* parent */, 3),
+	GATE_AFE2(CLK_AFE_DMIC0_ADC_HIRES_TML, "afe_dmic0_aht",
+			"audio_h_ck"/* parent */, 4),
+	GATE_AFE2(CLK_AFE_DMIC0_ADC_HIRES, "afe_dmic0_adc_hires",
+			"audio_h_ck"/* parent */, 5),
+	GATE_AFE2(CLK_AFE_DMIC0_TML, "afe_dmic0_tml",
+			"f26m_ck"/* parent */, 6),
+	GATE_AFE2(CLK_AFE_DMIC0_ADC, "afe_dmic0_adc",
+			"f26m_ck"/* parent */, 7),
+	GATE_AFE2(CLK_AFE_UL0_ADC_HIRES_TML, "afe_ul0_aht",
+			"audio_h_ck"/* parent */, 20),
+	GATE_AFE2(CLK_AFE_UL0_ADC_HIRES, "afe_ul0_adc_hires",
+			"audio_h_ck"/* parent */, 21),
+	GATE_AFE2(CLK_AFE_UL0_TML, "afe_ul0_tml",
+			"f26m_ck"/* parent */, 22),
+	GATE_AFE2(CLK_AFE_UL0_ADC, "afe_ul0_adc",
+			"f26m_ck"/* parent */, 23),
+	/* AFE3 */
+	GATE_AFE3(CLK_AFE_ETDM_IN1, "afe_etdm_in1",
+			"aud_engen1_ck"/* parent */, 12),
+	GATE_AFE3(CLK_AFE_ETDM_IN0, "afe_etdm_in0",
+			"aud_engen1_ck"/* parent */, 13),
+	GATE_AFE3(CLK_AFE_ETDM_OUT4, "afe_etdm_out4",
+			"aud_engen1_ck"/* parent */, 17),
+	GATE_AFE3(CLK_AFE_ETDM_OUT1, "afe_etdm_out1",
+			"aud_engen1_ck"/* parent */, 20),
+	GATE_AFE3(CLK_AFE_ETDM_OUT0, "afe_etdm_out0",
+			"aud_engen1_ck"/* parent */, 21),
+	GATE_AFE3(CLK_AFE_TDM_OUT, "afe_tdm_out",
+			"aud_1_ck"/* parent */, 24),
+	/* AFE4 */
+	GATE_AFE4(CLK_AFE_GENERAL4_ASRC, "afe_general4_asrc",
+			"audio_h_ck"/* parent */, 20),
+	GATE_AFE4(CLK_AFE_GENERAL3_ASRC, "afe_general3_asrc",
+			"audio_h_ck"/* parent */, 21),
+	GATE_AFE4(CLK_AFE_GENERAL2_ASRC, "afe_general2_asrc",
+			"audio_h_ck"/* parent */, 22),
+	GATE_AFE4(CLK_AFE_GENERAL1_ASRC, "afe_general1_asrc",
+			"audio_h_ck"/* parent */, 23),
+	GATE_AFE4(CLK_AFE_GENERAL0_ASRC, "afe_general0_asrc",
+			"audio_h_ck"/* parent */, 24),
+	GATE_AFE4(CLK_AFE_CONNSYS_I2S_ASRC, "afe_connsys_i2s_asrc",
+			"audio_h_ck"/* parent */, 25),
+};
+
+static const struct mtk_clk_desc afe_mcd = {
+	.clks = afe_clks,
+	.num_clks = CLK_AFE_NR_CLK,
+};
+
+static const struct mtk_gate_regs vad0_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs vad1_cg_regs = {
+	.set_ofs = 0x180,
+	.clr_ofs = 0x180,
+	.sta_ofs = 0x180,
+};
+
+#define GATE_VAD0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vad0_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+#define GATE_VAD1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vad1_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate vad_clks[] = {
+	/* VAD0 */
+	GATE_VAD0(CLK_VAD_CORE0_EN, "vad_core0",
+			"vlp_vadsp_ck"/* parent */, 0),
+	GATE_VAD0(CLK_VAD_BUSEMI_EN, "vad_busemi_en",
+			"vlp_vadsp_ck"/* parent */, 2),
+	GATE_VAD0(CLK_VAD_TIMER_EN, "vad_timer_en",
+			"vlp_vadsp_ck"/* parent */, 3),
+	GATE_VAD0(CLK_VAD_DMA0_EN, "vad_dma0_en",
+			"vlp_vadsp_ck"/* parent */, 4),
+	GATE_VAD0(CLK_VAD_UART_EN, "vad_uart_en",
+			"vlp_vadsp_ck"/* parent */, 5),
+	GATE_VAD0(CLK_VAD_VOWPLL_EN, "vad_vowpll_en",
+			"vlp_vadsp_vowpll_ck"/* parent */, 16),
+	/* VAD1 */
+	GATE_VAD1(CLK_VADSYS_26M, "vadsys_26m",
+			"vlp_vadsp_vlp_26m_ck"/* parent */, 2),
+	GATE_VAD1(CLK_VADSYS_BUS, "vadsys_bus",
+			"vlp_vadsp_ck"/* parent */, 5),
+};
+
+static const struct mtk_clk_desc vad_mcd = {
+	.clks = vad_clks,
+	.num_clks = CLK_VAD_NR_CLK,
+};
+
+static const struct of_device_id of_match_clk_mt8189_adsp[] = {
+	{
+		.compatible = "mediatek,mt8189-audiosys",
+		.data = &afe_mcd,
+	}, {
+		.compatible = "mediatek,mt8189-vadsys",
+		.data = &vad_mcd,
+	}, {
+		/* sentinel */
+	}
+};
+
+
+static int clk_mt8189_adsp_grp_probe(struct platform_device *pdev)
+{
+	int r;
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init begin\n", __func__, pdev->name);
+#endif
+
+	r = mtk_clk_simple_probe(pdev);
+	if (r)
+		dev_info(&pdev->dev,
+			"could not register clock provider: %s: %d\n",
+			pdev->name, r);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init end\n", __func__, pdev->name);
+#endif
+
+	return r;
+}
+
+static struct platform_driver clk_mt8189_adsp_drv = {
+	.probe = clk_mt8189_adsp_grp_probe,
+	.driver = {
+		.name = "clk-mt8189-adsp",
+		.of_match_table = of_match_clk_mt8189_adsp,
+	},
+};
+
+module_platform_driver(clk_mt8189_adsp_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-bus.c b/drivers/clk/mediatek/clk-mt8189-bus.c
new file mode 100644
index 000000000000..6121aed94806
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-bus.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
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
+#include <dt-bindings/clock/mt8189-clk.h>
+
+#define MT_CCF_BRINGUP		1
+
+/* Regular Number Definition */
+#define INV_OFS			-1
+#define INV_BIT			-1
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
+		.regs = &ifrao0_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_IFRAO1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ifrao1_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_IFRAO2(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ifrao2_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate ifrao_clks[] = {
+	/* IFRAO0 */
+	GATE_IFRAO0(CLK_IFRAO_CQ_DMA_FPC, "ifrao_dma",
+			"f26m_ck"/* parent */, 28),
+	/* IFRAO1 */
+	GATE_IFRAO1(CLK_IFRAO_DEBUGSYS, "ifrao_debugsys",
+			"axi_ck"/* parent */, 24),
+	GATE_IFRAO1(CLK_IFRAO_DBG_TRACE, "ifrao_dbg_trace",
+			"axi_ck"/* parent */, 29),
+	/* IFRAO2 */
+	GATE_IFRAO2(CLK_IFRAO_CQ_DMA, "ifrao_cq_dma",
+			"axi_ck"/* parent */, 27),
+};
+
+static const struct mtk_clk_desc ifrao_mcd = {
+	.clks = ifrao_clks,
+	.num_clks = CLK_IFRAO_NR_CLK,
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
+		.regs = &perao0_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_PERAO1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &perao1_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_PERAO2(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &perao2_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate perao_clks[] = {
+	/* PERAO0 */
+	GATE_PERAO0(CLK_PERAO_UART0, "perao_uart0",
+			"uart_ck"/* parent */, 0),
+	GATE_PERAO0(CLK_PERAO_UART1, "perao_uart1",
+			"uart_ck"/* parent */, 1),
+	GATE_PERAO0(CLK_PERAO_UART2, "perao_uart2",
+			"uart_ck"/* parent */, 2),
+	GATE_PERAO0(CLK_PERAO_UART3, "perao_uart3",
+			"uart_ck"/* parent */, 3),
+	GATE_PERAO0(CLK_PERAO_PWM_H, "perao_pwm_h",
+			"axi_peri_ck"/* parent */, 4),
+	GATE_PERAO0(CLK_PERAO_PWM_B, "perao_pwm_b",
+			"pwm_ck"/* parent */, 5),
+	GATE_PERAO0(CLK_PERAO_PWM_FB1, "perao_pwm_fb1",
+			"pwm_ck"/* parent */, 6),
+	GATE_PERAO0(CLK_PERAO_PWM_FB2, "perao_pwm_fb2",
+			"pwm_ck"/* parent */, 7),
+	GATE_PERAO0(CLK_PERAO_PWM_FB3, "perao_pwm_fb3",
+			"pwm_ck"/* parent */, 8),
+	GATE_PERAO0(CLK_PERAO_PWM_FB4, "perao_pwm_fb4",
+			"pwm_ck"/* parent */, 9),
+	GATE_PERAO0(CLK_PERAO_DISP_PWM0, "perao_disp_pwm0",
+			"disp_pwm_ck"/* parent */, 10),
+	GATE_PERAO0(CLK_PERAO_DISP_PWM1, "perao_disp_pwm1",
+			"disp_pwm_ck"/* parent */, 11),
+	GATE_PERAO0(CLK_PERAO_SPI0_B, "perao_spi0_b",
+			"spi0_ck"/* parent */, 12),
+	GATE_PERAO0(CLK_PERAO_SPI1_B, "perao_spi1_b",
+			"spi1_ck"/* parent */, 13),
+	GATE_PERAO0(CLK_PERAO_SPI2_B, "perao_spi2_b",
+			"spi2_ck"/* parent */, 14),
+	GATE_PERAO0(CLK_PERAO_SPI3_B, "perao_spi3_b",
+			"spi3_ck"/* parent */, 15),
+	GATE_PERAO0(CLK_PERAO_SPI4_B, "perao_spi4_b",
+			"spi4_ck"/* parent */, 16),
+	GATE_PERAO0(CLK_PERAO_SPI5_B, "perao_spi5_b",
+			"spi5_ck"/* parent */, 17),
+	GATE_PERAO0(CLK_PERAO_SPI0_H, "perao_spi0_h",
+			"axi_peri_ck"/* parent */, 18),
+	GATE_PERAO0(CLK_PERAO_SPI1_H, "perao_spi1_h",
+			"axi_peri_ck"/* parent */, 19),
+	GATE_PERAO0(CLK_PERAO_SPI2_H, "perao_spi2_h",
+			"axi_peri_ck"/* parent */, 20),
+	GATE_PERAO0(CLK_PERAO_SPI3_H, "perao_spi3_h",
+			"axi_peri_ck"/* parent */, 21),
+	GATE_PERAO0(CLK_PERAO_SPI4_H, "perao_spi4_h",
+			"axi_peri_ck"/* parent */, 22),
+	GATE_PERAO0(CLK_PERAO_SPI5_H, "perao_spi5_h",
+			"axi_peri_ck"/* parent */, 23),
+	GATE_PERAO0(CLK_PERAO_AXI, "perao_axi",
+			"mem_sub_peri_ck"/* parent */, 24),
+	GATE_PERAO0(CLK_PERAO_AHB_APB, "perao_ahb_apb",
+			"axi_peri_ck"/* parent */, 25),
+	GATE_PERAO0(CLK_PERAO_TL, "perao_tl",
+			"pcie_mac_tl_ck"/* parent */, 26),
+	GATE_PERAO0(CLK_PERAO_REF, "perao_ref",
+			"f26m_ck"/* parent */, 27),
+	GATE_PERAO0(CLK_PERAO_I2C, "perao_i2c",
+			"axi_peri_ck"/* parent */, 28),
+	GATE_PERAO0(CLK_PERAO_DMA_B, "perao_dma_b",
+			"axi_peri_ck"/* parent */, 29),
+	/* PERAO1 */
+	GATE_PERAO1(CLK_PERAO_SSUSB0_REF, "perao_ssusb0_ref",
+			"f26m_ck"/* parent */, 1),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_FRMCNT, "perao_ssusb0_frmcnt",
+			"ssusb_frmcnt_p0"/* parent */, 2),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_SYS, "perao_ssusb0_sys",
+			"usb_p0_ck"/* parent */, 4),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_XHCI, "perao_ssusb0_xhci",
+			"ssusb_xhci_p0_ck"/* parent */, 5),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_F, "perao_ssusb0_f",
+			"axi_peri_ck"/* parent */, 6),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_H, "perao_ssusb0_h",
+			"axi_peri_ck"/* parent */, 7),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_REF, "perao_ssusb1_ref",
+			"f26m_ck"/* parent */, 8),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_FRMCNT, "perao_ssusb1_frmcnt",
+			"ssusb_frmcnt_p1"/* parent */, 9),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_SYS, "perao_ssusb1_sys",
+			"usb_p1_ck"/* parent */, 11),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_XHCI, "perao_ssusb1_xhci",
+			"ssusb_xhci_p1_ck"/* parent */, 12),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_F, "perao_ssusb1_f",
+			"axi_peri_ck"/* parent */, 13),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_H, "perao_ssusb1_h",
+			"axi_peri_ck"/* parent */, 14),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_REF, "perao_ssusb2_ref",
+			"f26m_ck"/* parent */, 15),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_FRMCNT, "perao_ssusb2_frmcnt",
+			"ssusb_frmcnt_p2"/* parent */, 16),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_SYS, "perao_ssusb2_sys",
+			"usb_p2_ck"/* parent */, 18),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_XHCI, "perao_ssusb2_xhci",
+			"ssusb_xhci_p2_ck"/* parent */, 19),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_F, "perao_ssusb2_f",
+			"axi_peri_ck"/* parent */, 20),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_H, "perao_ssusb2_h",
+			"axi_peri_ck"/* parent */, 21),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_REF, "perao_ssusb3_ref",
+			"f26m_ck"/* parent */, 23),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_FRMCNT, "perao_ssusb3_frmcnt",
+			"ssusb_frmcnt_p3"/* parent */, 24),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_SYS, "perao_ssusb3_sys",
+			"usb_p3_ck"/* parent */, 26),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_XHCI, "perao_ssusb3_xhci",
+			"ssusb_xhci_p3_ck"/* parent */, 27),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_F, "perao_ssusb3_f",
+			"axi_peri_ck"/* parent */, 28),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_H, "perao_ssusb3_h",
+			"axi_peri_ck"/* parent */, 29),
+	/* PERAO2 */
+	GATE_PERAO2(CLK_PERAO_SSUSB4_REF, "perao_ssusb4_ref",
+			"f26m_ck"/* parent */, 0),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_FRMCNT, "perao_ssusb4_frmcnt",
+			"ssusb_frmcnt_p4"/* parent */, 1),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_SYS, "perao_ssusb4_sys",
+			"usb_p4_ck"/* parent */, 3),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_XHCI, "perao_ssusb4_xhci",
+			"ssusb_xhci_p4_ck"/* parent */, 4),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_F, "perao_ssusb4_f",
+			"axi_peri_ck"/* parent */, 5),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_H, "perao_ssusb4_h",
+			"axi_peri_ck"/* parent */, 6),
+	GATE_PERAO2(CLK_PERAO_MSDC0, "perao_msdc0",
+			"msdc50_0_ck"/* parent */, 7),
+	GATE_PERAO2(CLK_PERAO_MSDC0_H, "perao_msdc0_h",
+			"msdc5hclk_ck"/* parent */, 8),
+	GATE_PERAO2(CLK_PERAO_MSDC0_FAES, "perao_msdc0_faes",
+			"aes_msdcfde_ck"/* parent */, 9),
+	GATE_PERAO2(CLK_PERAO_MSDC0_MST_F, "perao_msdc0_mst_f",
+			"axi_peri_ck"/* parent */, 10),
+	GATE_PERAO2(CLK_PERAO_MSDC0_SLV_H, "perao_msdc0_slv_h",
+			"axi_peri_ck"/* parent */, 11),
+	GATE_PERAO2(CLK_PERAO_MSDC1, "perao_msdc1",
+			"msdc30_1_ck"/* parent */, 12),
+	GATE_PERAO2(CLK_PERAO_MSDC1_H, "perao_msdc1_h",
+			"msdc30_1_h_ck"/* parent */, 13),
+	GATE_PERAO2(CLK_PERAO_MSDC1_MST_F, "perao_msdc1_mst_f",
+			"axi_peri_ck"/* parent */, 14),
+	GATE_PERAO2(CLK_PERAO_MSDC1_SLV_H, "perao_msdc1_slv_h",
+			"axi_peri_ck"/* parent */, 15),
+	GATE_PERAO2(CLK_PERAO_MSDC2, "perao_msdc2",
+			"msdc30_2_ck"/* parent */, 16),
+	GATE_PERAO2(CLK_PERAO_MSDC2_H, "perao_msdc2_h",
+			"msdc30_2_h_ck"/* parent */, 17),
+	GATE_PERAO2(CLK_PERAO_MSDC2_MST_F, "perao_msdc2_mst_f",
+			"axi_peri_ck"/* parent */, 18),
+	GATE_PERAO2(CLK_PERAO_MSDC2_SLV_H, "perao_msdc2_slv_h",
+			"axi_peri_ck"/* parent */, 19),
+	GATE_PERAO2(CLK_PERAO_SFLASH, "perao_sflash",
+			"sflash_ck"/* parent */, 20),
+	GATE_PERAO2(CLK_PERAO_SFLASH_F, "perao_sflash_f",
+			"axi_peri_ck"/* parent */, 21),
+	GATE_PERAO2(CLK_PERAO_SFLASH_H, "perao_sflash_h",
+			"axi_peri_ck"/* parent */, 22),
+	GATE_PERAO2(CLK_PERAO_SFLASH_P, "perao_sflash_p",
+			"axi_peri_ck"/* parent */, 23),
+	GATE_PERAO2(CLK_PERAO_AUDIO0, "perao_audio0",
+			"axi_peri_ck"/* parent */, 24),
+	GATE_PERAO2(CLK_PERAO_AUDIO1, "perao_audio1",
+			"axi_peri_ck"/* parent */, 25),
+	GATE_PERAO2(CLK_PERAO_AUDIO2, "perao_audio2",
+			"aud_intbus_ck"/* parent */, 26),
+	GATE_PERAO2(CLK_PERAO_AUXADC_26M, "perao_auxadc_26m",
+			"f26m_ck"/* parent */, 27),
+};
+
+static const struct mtk_clk_desc perao_mcd = {
+	.clks = perao_clks,
+	.num_clks = CLK_PERAO_NR_CLK,
+};
+
+static const struct of_device_id of_match_clk_mt8189_bus[] = {
+	{
+		.compatible = "mediatek,mt8189-infra_ao",
+		.data = &ifrao_mcd,
+	}, {
+		.compatible = "mediatek,mt8189-peri_ao",
+		.data = &perao_mcd,
+	}, {
+		/* sentinel */
+	}
+};
+
+
+static int clk_mt8189_bus_grp_probe(struct platform_device *pdev)
+{
+	int r;
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init begin\n", __func__, pdev->name);
+#endif
+
+	r = mtk_clk_simple_probe(pdev);
+	if (r)
+		dev_info(&pdev->dev,
+			"could not register clock provider: %s: %d\n",
+			pdev->name, r);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init end\n", __func__, pdev->name);
+#endif
+
+	return r;
+}
+
+static struct platform_driver clk_mt8189_bus_drv = {
+	.probe = clk_mt8189_bus_grp_probe,
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
index 000000000000..c4221068ce15
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-cam.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
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
+#include <dt-bindings/clock/mt8189-clk.h>
+
+#define MT_CCF_BRINGUP		1
+
+/* Regular Number Definition */
+#define INV_OFS			-1
+#define INV_BIT			-1
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
+	GATE_CAM_M(CLK_CAM_M_LARB13, "cam_m_larb13",
+			"cam_ck"/* parent */, 0),
+	GATE_CAM_M(CLK_CAM_M_LARB14, "cam_m_larb14",
+			"cam_ck"/* parent */, 2),
+	GATE_CAM_M(CLK_CAM_M_CAMSYS_MAIN_CAM, "cam_m_camsys_main_cam",
+			"cam_ck"/* parent */, 6),
+	GATE_CAM_M(CLK_CAM_M_CAMSYS_MAIN_CAMTG, "cam_m_camsys_main_camtg",
+			"cam_ck"/* parent */, 7),
+	GATE_CAM_M(CLK_CAM_M_SENINF, "cam_m_seninf",
+			"cam_ck"/* parent */, 8),
+	GATE_CAM_M(CLK_CAM_M_CAMSV1, "cam_m_camsv1",
+			"cam_ck"/* parent */, 10),
+	GATE_CAM_M(CLK_CAM_M_CAMSV2, "cam_m_camsv2",
+			"cam_ck"/* parent */, 11),
+	GATE_CAM_M(CLK_CAM_M_CAMSV3, "cam_m_camsv3",
+			"cam_ck"/* parent */, 12),
+	GATE_CAM_M(CLK_CAM_M_FAKE_ENG, "cam_m_fake_eng",
+			"cam_ck"/* parent */, 17),
+	GATE_CAM_M(CLK_CAM_M_CAM2MM_GALS, "cam_m_cam2mm_gals",
+			"cam_ck"/* parent */, 19),
+	GATE_CAM_M(CLK_CAM_M_CAMSV4, "cam_m_camsv4",
+			"cam_ck"/* parent */, 20),
+	GATE_CAM_M(CLK_CAM_M_PDA, "cam_m_pda",
+			"cam_ck"/* parent */, 21),
+};
+
+static const struct mtk_clk_desc cam_m_mcd = {
+	.clks = cam_m_clks,
+	.num_clks = CLK_CAM_M_NR_CLK,
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
+		.regs = &cam_ra_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate cam_ra_clks[] = {
+	GATE_CAM_RA(CLK_CAM_RA_CAMSYS_RAWA_LARBX, "cam_ra_camsys_rawa_larbx",
+			"cam_ck"/* parent */, 0),
+	GATE_CAM_RA(CLK_CAM_RA_CAMSYS_RAWA_CAM, "cam_ra_camsys_rawa_cam",
+			"cam_ck"/* parent */, 1),
+	GATE_CAM_RA(CLK_CAM_RA_CAMSYS_RAWA_CAMTG, "cam_ra_camsys_rawa_camtg",
+			"cam_ck"/* parent */, 2),
+};
+
+static const struct mtk_clk_desc cam_ra_mcd = {
+	.clks = cam_ra_clks,
+	.num_clks = CLK_CAM_RA_NR_CLK,
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
+		.regs = &cam_rb_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate cam_rb_clks[] = {
+	GATE_CAM_RB(CLK_CAM_RB_CAMSYS_RAWB_LARBX, "cam_rb_camsys_rawb_larbx",
+			"cam_ck"/* parent */, 0),
+	GATE_CAM_RB(CLK_CAM_RB_CAMSYS_RAWB_CAM, "cam_rb_camsys_rawb_cam",
+			"cam_ck"/* parent */, 1),
+	GATE_CAM_RB(CLK_CAM_RB_CAMSYS_RAWB_CAMTG, "cam_rb_camsys_rawb_camtg",
+			"cam_ck"/* parent */, 2),
+};
+
+static const struct mtk_clk_desc cam_rb_mcd = {
+	.clks = cam_rb_clks,
+	.num_clks = CLK_CAM_RB_NR_CLK,
+};
+
+static const struct of_device_id of_match_clk_mt8189_cam[] = {
+	{
+		.compatible = "mediatek,mt8189-camsys_main",
+		.data = &cam_m_mcd,
+	}, {
+		.compatible = "mediatek,mt8189-camsys_rawa",
+		.data = &cam_ra_mcd,
+	}, {
+		.compatible = "mediatek,mt8189-camsys_rawb",
+		.data = &cam_rb_mcd,
+	}, {
+		/* sentinel */
+	}
+};
+
+
+static int clk_mt8189_cam_grp_probe(struct platform_device *pdev)
+{
+	int r;
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init begin\n", __func__, pdev->name);
+#endif
+
+	r = mtk_clk_simple_probe(pdev);
+	if (r)
+		dev_info(&pdev->dev,
+			"could not register clock provider: %s: %d\n",
+			pdev->name, r);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init end\n", __func__, pdev->name);
+#endif
+
+	return r;
+}
+
+static struct platform_driver clk_mt8189_cam_drv = {
+	.probe = clk_mt8189_cam_grp_probe,
+	.driver = {
+		.name = "clk-mt8189-cam",
+		.of_match_table = of_match_clk_mt8189_cam,
+	},
+};
+
+module_platform_driver(clk_mt8189_cam_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-fmeter.h b/drivers/clk/mediatek/clk-mt8189-fmeter.h
new file mode 100644
index 000000000000..16791d045a11
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-fmeter.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#ifndef _CLK_MT8189_FMETER_H
+#define _CLK_MT8189_FMETER_H
+
+/* generate from clock_table.xlsx from TOPCKGEN DE */
+
+/* CKGEN Part */
+#define FM_AXI_CK				1
+#define FM_AXI_PERI_CK				2
+#define FM_AXI_U_CK				3
+#define FM_BUS_AXIMEM_CK			4
+#define FM_DISP0_CK				5
+#define FM_MMINFRA_CK				6
+#define FM_UART_CK				7
+#define FM_SPI0_CK				8
+#define FM_SPI1_CK				9
+#define FM_SPI2_CK				10
+#define FM_SPI3_CK				11
+#define FM_SPI4_CK				12
+#define FM_SPI5_CK				13
+#define FM_MSDC_MACRO_0P_CK			14
+#define FM_MSDC5HCLK_CK				15
+#define FM_MSDC50_0_CK				16
+#define FM_AES_MSDCFDE_CK			17
+#define FM_MSDC_MACRO_1P_CK			18
+#define FM_MSDC30_1_CK				19
+#define FM_MSDC30_1_H_CK			20
+#define FM_MSDC_MACRO_2P_CK			21
+#define FM_MSDC30_2_CK				22
+#define FM_MSDC30_2_2				23
+#define FM_AUD_INTBUS_CK			24
+#define FM_ATB_CK				25
+#define FM_DISP_PWM_CK				26
+#define FM_USB_P0_CK				27
+#define FM_USB_XHCI_P0_CK			28
+#define FM_USB_P1_CK				29
+#define FM_USB_XHCI_P1_CK			30
+#define FM_USB_P2_CK				31
+#define FM_USB_XHCI_P2_CK			32
+#define FM_USB_P3_CK				33
+#define FM_USB_XHCI_P3_CK			34
+#define FM_USB_P4_CK				35
+#define FM_USB_XHCI_P4_CK			36
+#define FM_I2C_CK				37
+#define FM_SENINF_CK				38
+#define FM_SENINF1_CK				39
+#define FM_AUD_ENGEN1_CK			40
+#define FM_AUD_ENGEN2_CK			41
+#define FM_AES_UFSFDE_CK			42
+#define FM_U_CK					43
+#define FM_U_MBIST_CK				44
+#define FM_AUD_1_CK				45
+#define FM_AUD_2_CK				46
+#define FM_VENC_CK				47
+#define FM_VDEC_CK				48
+#define FM_PWM_CK				49
+#define FM_AUDIO_H_CK				50
+#define FM_MCUPM_CK				51
+#define FM_MEM_SUB_CK				52
+#define FM_MEM_SUB_PERI_CK			53
+#define FM_MEM_SUB_U_CK				54
+#define FM_EMI_N_CK				55
+#define FM_DSI_OCC_CK				56
+#define FM_AP2CONN_HOST_CK			57
+#define FM_IMG1_CK				58
+#define FM_IPE_CK				59
+#define FM_CAM_CK				60
+#define FM_CAMTM_CK				61
+#define FM_DSP_CK				62
+#define FM_SR_PKA_CK				63
+#define FM_DXCC_CK				64
+#define FM_MFG_REF_CK				65
+#define FM_MDP0_CK				66
+#define FM_DP_CK				67
+#define FM_EDP_CK				68
+#define FM_EDP_FAVT_CK				69
+#define FM_ETH_250M_CK				70
+#define FM_ETH_62P4M_PTP_CK			71
+#define FM_ETH_50M_RMII_CK			72
+#define FM_SFLASH_CK				73
+#define FM_GCPU_CK				74
+#define FM_CIE_MAC_TL_CK			75
+#define FM_VDSTX_DG_CTS_CK			76
+#define FM_PLL_DPIX_CK				77
+#define FM_ECC_CK				78
+#define FM_CKGEN_NUM				79
+/* ABIST Part */
+#define FM_APLL1_CK				2
+#define FM_APLL2_CK				3
+#define FM_ARMPLL_BL_CK				6
+#define FM_ARMPLL_BL_CKDIV_CK			7
+#define FM_ARMPLL_LL_CK				8
+#define FM_ARMPLL_LL_CKDIV_CK			9
+#define FM_CCIPLL_CK				10
+#define FM_CCIPLL_CKDIV_CK			11
+#define FM_MAINPLL_CKDIV_CK			23
+#define FM_MAINPLL_CK				24
+#define FM_MMPLL_CKDIV_CK			26
+#define FM_MMPLL_CK				27
+#define FM_MMPLL_D3_CK				28
+#define FM_MSDCPLL_CK				30
+#define FM_UFSPLL_CK				35
+#define FM_UNIVPLL_CK				38
+#define FM_UNIVPLL_192M_CK			40
+#define FM_APLL1_CKDIV_CK			71
+#define FM_APLL2_CKDIV_CK			72
+#define FM_UFSPLL_CKDIV_CK			74
+#define FM_MSDCPLL_CKDIV_CK			77
+#define FM_EMIPLL_CK				78
+#define FM_TVDPLL1_CK				79
+#define FM_TVDPLL2_CK				80
+#define FM_MFGPLL_OPP_CK			81
+#define FM_ETHPLL_CK				82
+#define FM_APUPLL_CK				83
+#define FM_APUPLL2_CK				84
+#define FM_ABIST_NUM				85
+/* VLPCK Part */
+#define FM_SCP_CK				1
+#define FM_PWRAP_ULPOSC_CK			2
+#define FM_SPMI_P_CK				3
+#define FM_DVFSRC_CK				4
+#define FM_PWM_VLP_CK				5
+#define FM_AXI_VLP_CK				6
+#define FM_SYSTIMER_26M_CK			7
+#define FM_SSPM_CK				8
+#define FM_SSPM_F26M_CK				9
+#define FM_SRCK_CK				10
+#define FM_SCP_SPI_CK				11
+#define FM_SCP_IIC_CK				12
+#define FM_SCP_SPI_HS_CK			13
+#define FM_SCP_IIC_HS_CK			14
+#define FM_SSPM_ULPOSC_CK			15
+#define FM_APXGPT_26M_CK			16
+#define FM_VADSP_CK				17
+#define FM_VADSP_VOWPLL_CK			18
+#define FM_VADSP_UARTHUB_B_CK			19
+#define FM_CAMTG0_CK				20
+#define FM_CAMTG1_CK				21
+#define FM_CAMTG2_CK				22
+#define FM_AUD_ADC_CK				23
+#define FM_KP_IRQ_GEN_CK			24
+#define FM_VLPCK_NUM				25
+
+enum fm_sys_id {
+	FM_APMIXEDSYS = 0,
+	FM_TOPCKGEN = 1,
+	FM_VLP_CKSYS = 2,
+	FM_SYS_NUM = 3,
+};
+
+#endif /* _CLK_MT8189_FMETER_H */
diff --git a/drivers/clk/mediatek/clk-mt8189-iic.c b/drivers/clk/mediatek/clk-mt8189-iic.c
new file mode 100644
index 000000000000..20d8c4805ad1
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-iic.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
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
+#include <dt-bindings/clock/mt8189-clk.h>
+
+#define MT_CCF_BRINGUP		1
+
+/* Regular Number Definition */
+#define INV_OFS			-1
+#define INV_BIT			-1
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
+	GATE_IMPE(CLK_IMPE_I2C0, "impe_i2c0",
+			"i2c_ck"/* parent */, 0),
+	GATE_IMPE(CLK_IMPE_I2C1, "impe_i2c1",
+			"i2c_ck"/* parent */, 1),
+};
+
+static const struct mtk_clk_desc impe_mcd = {
+	.clks = impe_clks,
+	.num_clks = CLK_IMPE_NR_CLK,
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
+	GATE_IMPEN(CLK_IMPEN_I2C7, "impen_i2c7",
+			"i2c_ck"/* parent */, 0),
+	GATE_IMPEN(CLK_IMPEN_I2C8, "impen_i2c8",
+			"i2c_ck"/* parent */, 1),
+};
+
+static const struct mtk_clk_desc impen_mcd = {
+	.clks = impen_clks,
+	.num_clks = CLK_IMPEN_NR_CLK,
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
+	GATE_IMPS(CLK_IMPS_I2C3, "imps_i2c3",
+			"i2c_ck"/* parent */, 0),
+	GATE_IMPS(CLK_IMPS_I2C4, "imps_i2c4",
+			"i2c_ck"/* parent */, 1),
+	GATE_IMPS(CLK_IMPS_I2C5, "imps_i2c5",
+			"i2c_ck"/* parent */, 2),
+	GATE_IMPS(CLK_IMPS_I2C6, "imps_i2c6",
+			"i2c_ck"/* parent */, 3),
+};
+
+static const struct mtk_clk_desc imps_mcd = {
+	.clks = imps_clks,
+	.num_clks = CLK_IMPS_NR_CLK,
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
+	GATE_IMPWS(CLK_IMPWS_I2C2, "impws_i2c2",
+			"i2c_ck"/* parent */, 0),
+};
+
+static const struct mtk_clk_desc impws_mcd = {
+	.clks = impws_clks,
+	.num_clks = CLK_IMPWS_NR_CLK,
+};
+
+static const struct of_device_id of_match_clk_mt8189_iic[] = {
+	{
+		.compatible = "mediatek,mt8189-iic_wrap_e",
+		.data = &impe_mcd,
+	}, {
+		.compatible = "mediatek,mt8189-iic_wrap_en",
+		.data = &impen_mcd,
+	}, {
+		.compatible = "mediatek,mt8189-iic_wrap_s",
+		.data = &imps_mcd,
+	}, {
+		.compatible = "mediatek,mt8189-iic_wrap_ws",
+		.data = &impws_mcd,
+	}, {
+		/* sentinel */
+	}
+};
+
+
+static int clk_mt8189_iic_grp_probe(struct platform_device *pdev)
+{
+	int r;
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init begin\n", __func__, pdev->name);
+#endif
+
+	r = mtk_clk_simple_probe(pdev);
+	if (r)
+		dev_info(&pdev->dev,
+			"could not register clock provider: %s: %d\n",
+			pdev->name, r);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init end\n", __func__, pdev->name);
+#endif
+
+	return r;
+}
+
+static struct platform_driver clk_mt8189_iic_drv = {
+	.probe = clk_mt8189_iic_grp_probe,
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
index 000000000000..ff5f6abe9dca
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-img.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
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
+#include <dt-bindings/clock/mt8189-clk.h>
+
+#define MT_CCF_BRINGUP		1
+
+/* Regular Number Definition */
+#define INV_OFS			-1
+#define INV_BIT			-1
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
+		.regs = &imgsys1_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate imgsys1_clks[] = {
+	GATE_IMGSYS1(CLK_IMGSYS1_LARB9, "imgsys1_larb9",
+			"img1_ck"/* parent */, 0),
+	GATE_IMGSYS1(CLK_IMGSYS1_LARB11, "imgsys1_larb11",
+			"img1_ck"/* parent */, 1),
+	GATE_IMGSYS1(CLK_IMGSYS1_DIP, "imgsys1_dip",
+			"img1_ck"/* parent */, 2),
+	GATE_IMGSYS1(CLK_IMGSYS1_GALS, "imgsys1_gals",
+			"img1_ck"/* parent */, 12),
+};
+
+static const struct mtk_clk_desc imgsys1_mcd = {
+	.clks = imgsys1_clks,
+	.num_clks = CLK_IMGSYS1_NR_CLK,
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
+		.regs = &imgsys2_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate imgsys2_clks[] = {
+	GATE_IMGSYS2(CLK_IMGSYS2_LARB9, "imgsys2_larb9",
+			"img1_ck"/* parent */, 0),
+	GATE_IMGSYS2(CLK_IMGSYS2_LARB11, "imgsys2_larb11",
+			"img1_ck"/* parent */, 1),
+	GATE_IMGSYS2(CLK_IMGSYS2_MFB, "imgsys2_mfb",
+			"img1_ck"/* parent */, 6),
+	GATE_IMGSYS2(CLK_IMGSYS2_WPE, "imgsys2_wpe",
+			"img1_ck"/* parent */, 7),
+	GATE_IMGSYS2(CLK_IMGSYS2_MSS, "imgsys2_mss",
+			"img1_ck"/* parent */, 8),
+	GATE_IMGSYS2(CLK_IMGSYS2_GALS, "imgsys2_gals",
+			"img1_ck"/* parent */, 12),
+};
+
+static const struct mtk_clk_desc imgsys2_mcd = {
+	.clks = imgsys2_clks,
+	.num_clks = CLK_IMGSYS2_NR_CLK,
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
+	GATE_IPE(CLK_IPE_LARB19, "ipe_larb19",
+			"ipe_ck"/* parent */, 0),
+	GATE_IPE(CLK_IPE_LARB20, "ipe_larb20",
+			"ipe_ck"/* parent */, 1),
+	GATE_IPE(CLK_IPE_SMI_SUBCOM, "ipe_smi_subcom",
+			"ipe_ck"/* parent */, 2),
+	GATE_IPE(CLK_IPE_FD, "ipe_fd",
+			"ipe_ck"/* parent */, 3),
+	GATE_IPE(CLK_IPE_FE, "ipe_fe",
+			"ipe_ck"/* parent */, 4),
+	GATE_IPE(CLK_IPE_RSC, "ipe_rsc",
+			"ipe_ck"/* parent */, 5),
+	GATE_IPE(CLK_IPESYS_GALS, "ipesys_gals",
+			"ipe_ck"/* parent */, 8),
+};
+
+static const struct mtk_clk_desc ipe_mcd = {
+	.clks = ipe_clks,
+	.num_clks = CLK_IPE_NR_CLK,
+};
+
+static const struct of_device_id of_match_clk_mt8189_img[] = {
+	{
+		.compatible = "mediatek,mt8189-imgsys1",
+		.data = &imgsys1_mcd,
+	}, {
+		.compatible = "mediatek,mt8189-imgsys2",
+		.data = &imgsys2_mcd,
+	}, {
+		.compatible = "mediatek,mt8189-ipesys",
+		.data = &ipe_mcd,
+	}, {
+		/* sentinel */
+	}
+};
+
+
+static int clk_mt8189_img_grp_probe(struct platform_device *pdev)
+{
+	int r;
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init begin\n", __func__, pdev->name);
+#endif
+
+	r = mtk_clk_simple_probe(pdev);
+	if (r)
+		dev_info(&pdev->dev,
+			"could not register clock provider: %s: %d\n",
+			pdev->name, r);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init end\n", __func__, pdev->name);
+#endif
+
+	return r;
+}
+
+static struct platform_driver clk_mt8189_img_drv = {
+	.probe = clk_mt8189_img_grp_probe,
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
index 000000000000..7ad34b3ff1e6
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-mdpsys.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
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
+#include <dt-bindings/clock/mt8189-clk.h>
+
+#define MT_CCF_BRINGUP		1
+
+/* Regular Number Definition */
+#define INV_OFS			-1
+#define INV_BIT			-1
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
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_MDP1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mdp1_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate mdp_clks[] = {
+	/* MDP0 */
+	GATE_MDP0(CLK_MDP_MUTEX0, "mdp_mutex0",
+			"mdp0_ck"/* parent */, 0),
+	GATE_MDP0(CLK_MDP_APB_BUS, "mdp_apb_bus",
+			"mdp0_ck"/* parent */, 1),
+	GATE_MDP0(CLK_MDP_SMI0, "mdp_smi0",
+			"mdp0_ck"/* parent */, 2),
+	GATE_MDP0(CLK_MDP_RDMA0, "mdp_rdma0",
+			"mdp0_ck"/* parent */, 3),
+	GATE_MDP0(CLK_MDP_RDMA2, "mdp_rdma2",
+			"mdp0_ck"/* parent */, 4),
+	GATE_MDP0(CLK_MDP_HDR0, "mdp_hdr0",
+			"mdp0_ck"/* parent */, 5),
+	GATE_MDP0(CLK_MDP_AAL0, "mdp_aal0",
+			"mdp0_ck"/* parent */, 6),
+	GATE_MDP0(CLK_MDP_RSZ0, "mdp_rsz0",
+			"mdp0_ck"/* parent */, 7),
+	GATE_MDP0(CLK_MDP_TDSHP0, "mdp_tdshp0",
+			"mdp0_ck"/* parent */, 8),
+	GATE_MDP0(CLK_MDP_COLOR0, "mdp_color0",
+			"mdp0_ck"/* parent */, 9),
+	GATE_MDP0(CLK_MDP_WROT0, "mdp_wrot0",
+			"mdp0_ck"/* parent */, 10),
+	GATE_MDP0(CLK_MDP_FAKE_ENG0, "mdp_fake_eng0",
+			"mdp0_ck"/* parent */, 11),
+	GATE_MDP0(CLK_MDPSYS_CONFIG, "mdpsys_config",
+			"mdp0_ck"/* parent */, 14),
+	GATE_MDP0(CLK_MDP_RDMA1, "mdp_rdma1",
+			"mdp0_ck"/* parent */, 15),
+	GATE_MDP0(CLK_MDP_RDMA3, "mdp_rdma3",
+			"mdp0_ck"/* parent */, 16),
+	GATE_MDP0(CLK_MDP_HDR1, "mdp_hdr1",
+			"mdp0_ck"/* parent */, 17),
+	GATE_MDP0(CLK_MDP_AAL1, "mdp_aal1",
+			"mdp0_ck"/* parent */, 18),
+	GATE_MDP0(CLK_MDP_RSZ1, "mdp_rsz1",
+			"mdp0_ck"/* parent */, 19),
+	GATE_MDP0(CLK_MDP_TDSHP1, "mdp_tdshp1",
+			"mdp0_ck"/* parent */, 20),
+	GATE_MDP0(CLK_MDP_COLOR1, "mdp_color1",
+			"mdp0_ck"/* parent */, 21),
+	GATE_MDP0(CLK_MDP_WROT1, "mdp_wrot1",
+			"mdp0_ck"/* parent */, 22),
+	GATE_MDP0(CLK_MDP_RSZ2, "mdp_rsz2",
+			"mdp0_ck"/* parent */, 24),
+	GATE_MDP0(CLK_MDP_WROT2, "mdp_wrot2",
+			"mdp0_ck"/* parent */, 25),
+	GATE_MDP0(CLK_MDP_RSZ3, "mdp_rsz3",
+			"mdp0_ck"/* parent */, 28),
+	GATE_MDP0(CLK_MDP_WROT3, "mdp_wrot3",
+			"mdp0_ck"/* parent */, 29),
+	/* MDP1 */
+	GATE_MDP1(CLK_MDP_BIRSZ0, "mdp_birsz0",
+			"mdp0_ck"/* parent */, 3),
+	GATE_MDP1(CLK_MDP_BIRSZ1, "mdp_birsz1",
+			"mdp0_ck"/* parent */, 4),
+};
+
+static const struct mtk_clk_desc mdp_mcd = {
+	.clks = mdp_clks,
+	.num_clks = CLK_MDP_NR_CLK,
+};
+
+static const struct of_device_id of_match_clk_mt8189_mdpsys[] = {
+	{
+		.compatible = "mediatek,mt8189-mdpsys",
+		.data = &mdp_mcd,
+	}, {
+		/* sentinel */
+	}
+};
+
+
+static int clk_mt8189_mdpsys_grp_probe(struct platform_device *pdev)
+{
+	int r;
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init begin\n", __func__, pdev->name);
+#endif
+
+	r = mtk_clk_simple_probe(pdev);
+	if (r)
+		dev_info(&pdev->dev,
+			"could not register clock provider: %s: %d\n",
+			pdev->name, r);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init end\n", __func__, pdev->name);
+#endif
+
+	return r;
+}
+
+static struct platform_driver clk_mt8189_mdpsys_drv = {
+	.probe = clk_mt8189_mdpsys_grp_probe,
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
index 000000000000..646f5483c61f
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-mfg.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
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
+#include <dt-bindings/clock/mt8189-clk.h>
+
+#define MT_CCF_BRINGUP		1
+
+/* Regular Number Definition */
+#define INV_OFS			-1
+#define INV_BIT			-1
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
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate mfg_clks[] = {
+	GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d",
+			"mfg_sel_mfgpll"/* parent */, 0),
+};
+
+static const struct mtk_clk_desc mfg_mcd = {
+	.clks = mfg_clks,
+	.num_clks = CLK_MFG_NR_CLK,
+};
+
+static const struct of_device_id of_match_clk_mt8189_mfg[] = {
+	{
+		.compatible = "mediatek,mt8189-mfgsys",
+		.data = &mfg_mcd,
+	}, {
+		/* sentinel */
+	}
+};
+
+
+static int clk_mt8189_mfg_grp_probe(struct platform_device *pdev)
+{
+	int r;
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init begin\n", __func__, pdev->name);
+#endif
+
+	r = mtk_clk_simple_probe(pdev);
+	if (r)
+		dev_info(&pdev->dev,
+			"could not register clock provider: %s: %d\n",
+			pdev->name, r);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init end\n", __func__, pdev->name);
+#endif
+
+	return r;
+}
+
+static struct platform_driver clk_mt8189_mfg_drv = {
+	.probe = clk_mt8189_mfg_grp_probe,
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
index 000000000000..b0d666f68d9f
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-mmsys.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
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
+#include <dt-bindings/clock/mt8189-clk.h>
+
+#define MT_CCF_BRINGUP		1
+
+/* Regular Number Definition */
+#define INV_OFS			-1
+#define INV_BIT			-1
+
+static const struct mtk_gate_regs mm0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mm1_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
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
+	GATE_MM0(CLK_MM_DISP_OVL0_4L, "mm_disp_ovl0_4l",
+			"disp0_ck"/* parent */, 0),
+	GATE_MM0(CLK_MM_DISP_OVL1_4L, "mm_disp_ovl1_4l",
+			"disp0_ck"/* parent */, 1),
+	GATE_MM0(CLK_MM_VPP_RSZ0, "mm_vpp_rsz0",
+			"disp0_ck"/* parent */, 2),
+	GATE_MM0(CLK_MM_VPP_RSZ1, "mm_vpp_rsz1",
+			"disp0_ck"/* parent */, 3),
+	GATE_MM0(CLK_MM_DISP_RDMA0, "mm_disp_rdma0",
+			"disp0_ck"/* parent */, 4),
+	GATE_MM0(CLK_MM_DISP_RDMA1, "mm_disp_rdma1",
+			"disp0_ck"/* parent */, 5),
+	GATE_MM0(CLK_MM_DISP_COLOR0, "mm_disp_color0",
+			"disp0_ck"/* parent */, 6),
+	GATE_MM0(CLK_MM_DISP_COLOR1, "mm_disp_color1",
+			"disp0_ck"/* parent */, 7),
+	GATE_MM0(CLK_MM_DISP_CCORR0, "mm_disp_ccorr0",
+			"disp0_ck"/* parent */, 8),
+	GATE_MM0(CLK_MM_DISP_CCORR1, "mm_disp_ccorr1",
+			"disp0_ck"/* parent */, 9),
+	GATE_MM0(CLK_MM_DISP_CCORR2, "mm_disp_ccorr2",
+			"disp0_ck"/* parent */, 10),
+	GATE_MM0(CLK_MM_DISP_CCORR3, "mm_disp_ccorr3",
+			"disp0_ck"/* parent */, 11),
+	GATE_MM0(CLK_MM_DISP_AAL0, "mm_disp_aal0",
+			"disp0_ck"/* parent */, 12),
+	GATE_MM0(CLK_MM_DISP_AAL1, "mm_disp_aal1",
+			"disp0_ck"/* parent */, 13),
+	GATE_MM0(CLK_MM_DISP_GAMMA0, "mm_disp_gamma0",
+			"disp0_ck"/* parent */, 14),
+	GATE_MM0(CLK_MM_DISP_GAMMA1, "mm_disp_gamma1",
+			"disp0_ck"/* parent */, 15),
+	GATE_MM0(CLK_MM_DISP_DITHER0, "mm_disp_dither0",
+			"disp0_ck"/* parent */, 16),
+	GATE_MM0(CLK_MM_DISP_DITHER1, "mm_disp_dither1",
+			"disp0_ck"/* parent */, 17),
+	GATE_MM0(CLK_MM_DISP_DSC_WRAP0, "mm_disp_dsc_wrap0",
+			"disp0_ck"/* parent */, 18),
+	GATE_MM0(CLK_MM_VPP_MERGE0, "mm_vpp_merge0",
+			"disp0_ck"/* parent */, 19),
+	GATE_MM0(CLK_MMSYS_0_DISP_DVO, "mmsys_0_disp_dvo",
+			"disp0_ck"/* parent */, 20),
+	GATE_MM0(CLK_MMSYS_0_DISP_DSI0, "mmsys_0_CLK0",
+			"disp0_ck"/* parent */, 21),
+	GATE_MM0(CLK_MM_DP_INTF0, "mm_dp_intf0",
+			"disp0_ck"/* parent */, 22),
+	GATE_MM0(CLK_MM_DPI0, "mm_dpi0",
+			"disp0_ck"/* parent */, 23),
+	GATE_MM0(CLK_MM_DISP_WDMA0, "mm_disp_wdma0",
+			"disp0_ck"/* parent */, 24),
+	GATE_MM0(CLK_MM_DISP_WDMA1, "mm_disp_wdma1",
+			"disp0_ck"/* parent */, 25),
+	GATE_MM0(CLK_MM_DISP_FAKE_ENG0, "mm_disp_fake_eng0",
+			"disp0_ck"/* parent */, 26),
+	GATE_MM0(CLK_MM_DISP_FAKE_ENG1, "mm_disp_fake_eng1",
+			"disp0_ck"/* parent */, 27),
+	GATE_MM0(CLK_MM_SMI_LARB, "mm_smi_larb",
+			"disp0_ck"/* parent */, 28),
+	GATE_MM0(CLK_MM_DISP_MUTEX0, "mm_disp_mutex0",
+			"disp0_ck"/* parent */, 29),
+	GATE_MM0(CLK_MM_DIPSYS_CONFIG, "mm_dipsys_config",
+			"disp0_ck"/* parent */, 30),
+	GATE_MM0(CLK_MM_DUMMY, "mm_dummy",
+			"disp0_ck"/* parent */, 31),
+	/* MM1 */
+	GATE_MM1(CLK_MMSYS_1_DISP_DSI0, "mmsys_1_CLK0",
+			"dsi_occ_ck"/* parent */, 0),
+	GATE_MM1(CLK_MMSYS_1_LVDS_ENCODER, "mmsys_1_lvds_encoder",
+			"pll_dpix_ck"/* parent */, 1),
+	GATE_MM1(CLK_MMSYS_1_DPI0, "mmsys_1_dpi0",
+			"pll_dpix_ck"/* parent */, 2),
+	GATE_MM1(CLK_MMSYS_1_DISP_DVO, "mmsys_1_disp_dvo",
+			"edp_ck"/* parent */, 3),
+	GATE_MM1(CLK_MM_DP_INTF, "mm_dp_intf",
+			"dp_ck"/* parent */, 4),
+	GATE_MM1(CLK_MMSYS_1_LVDS_ENCODER_CTS, "mmsys_1_lvds_encoder_cts",
+			"vdstx_dg_cts_ck"/* parent */, 5),
+	GATE_MM1(CLK_MMSYS_1_DISP_DVO_AVT, "mmsys_1_disp_dvo_avt",
+			"edp_favt_ck"/* parent */, 6),
+};
+
+static const struct mtk_clk_desc mm_mcd = {
+	.clks = mm_clks,
+	.num_clks = CLK_MM_NR_CLK,
+};
+
+static const struct mtk_gate_regs gce_d_cg_regs = {
+	.set_ofs = 0xF0,
+	.clr_ofs = 0xF0,
+	.sta_ofs = 0xF0,
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
+	GATE_GCE_D(CLK_GCE_D_TOP, "gce_d_top",
+			"mminfra_gce_d"/* parent */, 16),
+};
+
+static const struct mtk_clk_desc gce_d_mcd = {
+	.clks = gce_d_clks,
+	.num_clks = CLK_GCE_D_NR_CLK,
+};
+
+static const struct mtk_gate_regs gce_m_cg_regs = {
+	.set_ofs = 0xF0,
+	.clr_ofs = 0xF0,
+	.sta_ofs = 0xF0,
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
+	GATE_GCE_M(CLK_GCE_M_TOP, "gce_m_top",
+			"mminfra_gce_m"/* parent */, 16),
+};
+
+static const struct mtk_clk_desc gce_m_mcd = {
+	.clks = gce_m_clks,
+	.num_clks = CLK_GCE_M_NR_CLK,
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
+		.regs = &mminfra_config0_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+#define GATE_MMINFRA_CONFIG1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mminfra_config1_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate mminfra_config_clks[] = {
+	/* MMINFRA_CONFIG0 */
+	GATE_MMINFRA_CONFIG0(CLK_MMINFRA_GCE_D, "mminfra_gce_d",
+			"mminfra_ck"/* parent */, 0),
+	GATE_MMINFRA_CONFIG0(CLK_MMINFRA_GCE_M, "mminfra_gce_m",
+			"mminfra_ck"/* parent */, 1),
+	GATE_MMINFRA_CONFIG0(CLK_MMINFRA_SMI, "mminfra_smi",
+			"mminfra_ck"/* parent */, 2),
+	/* MMINFRA_CONFIG1 */
+	GATE_MMINFRA_CONFIG1(CLK_MMINFRA_GCE_26M, "mminfra_gce_26m",
+			"mminfra_ck"/* parent */, 17),
+};
+
+static const struct mtk_clk_desc mminfra_config_mcd = {
+	.clks = mminfra_config_clks,
+	.num_clks = CLK_MMINFRA_CONFIG_NR_CLK,
+};
+
+static const struct of_device_id of_match_clk_mt8189_mmsys[] = {
+	{
+		.compatible = "mediatek,mt8189-dispsys",
+		.data = &mm_mcd,
+	}, {
+		.compatible = "mediatek,mt8189-gce_d",
+		.data = &gce_d_mcd,
+	}, {
+		.compatible = "mediatek,mt8189-gce_m",
+		.data = &gce_m_mcd,
+	}, {
+		.compatible = "mediatek,mt8189-mm_infra",
+		.data = &mminfra_config_mcd,
+	}, {
+		/* sentinel */
+	}
+};
+
+
+static int clk_mt8189_mmsys_grp_probe(struct platform_device *pdev)
+{
+	int r;
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init begin\n", __func__, pdev->name);
+#endif
+
+	r = mtk_clk_simple_probe(pdev);
+	if (r)
+		dev_info(&pdev->dev,
+			"could not register clock provider: %s: %d\n",
+			pdev->name, r);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init end\n", __func__, pdev->name);
+#endif
+
+	return r;
+}
+
+static struct platform_driver clk_mt8189_mmsys_drv = {
+	.probe = clk_mt8189_mmsys_grp_probe,
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
index 000000000000..9ee8835c5583
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-scp.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
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
+#include <dt-bindings/clock/mt8189-clk.h>
+
+#define MT_CCF_BRINGUP		1
+
+/* Regular Number Definition */
+#define INV_OFS			-1
+#define INV_BIT			-1
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
+	GATE_SCP(CLK_SCP_SET_SPI0, "scp_set_spi0",
+			"f26m_ck"/* parent */, 0),
+	GATE_SCP(CLK_SCP_SET_SPI1, "scp_set_spi1",
+			"f26m_ck"/* parent */, 1),
+};
+
+static const struct mtk_clk_desc scp_mcd = {
+	.clks = scp_clks,
+	.num_clks = CLK_SCP_NR_CLK,
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
+		.regs = &scp_iic_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate scp_iic_clks[] = {
+	GATE_SCP_IIC(CLK_SCP_IIC_I2C0_W1S, "scp_iic_i2c0_w1s",
+			"vlp_scp_iic_ck"/* parent */, 0),
+	GATE_SCP_IIC(CLK_SCP_IIC_I2C1_W1S, "scp_iic_i2c1_w1s",
+			"vlp_scp_iic_ck"/* parent */, 1),
+};
+
+static const struct mtk_clk_desc scp_iic_mcd = {
+	.clks = scp_iic_clks,
+	.num_clks = CLK_SCP_IIC_NR_CLK,
+};
+
+static const struct of_device_id of_match_clk_mt8189_scp[] = {
+	{
+		.compatible = "mediatek,mt8189-scp",
+		.data = &scp_mcd,
+	}, {
+		.compatible = "mediatek,mt8189-scp_i2c",
+		.data = &scp_iic_mcd,
+	}, {
+		/* sentinel */
+	}
+};
+
+static int clk_mt8189_scp_grp_probe(struct platform_device *pdev)
+{
+	int r;
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init begin\n", __func__, pdev->name);
+#endif
+
+	r = mtk_clk_simple_probe(pdev);
+	if (r)
+		dev_info(&pdev->dev,
+			"could not register clock provider: %s: %d\n",
+			pdev->name, r);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init end\n", __func__, pdev->name);
+#endif
+
+	return r;
+}
+
+static struct platform_driver clk_mt8189_scp_drv = {
+	.probe = clk_mt8189_scp_grp_probe,
+	.driver = {
+		.name = "clk-mt8189-scp",
+		.of_match_table = of_match_clk_mt8189_scp,
+	},
+};
+
+module_platform_driver(clk_mt8189_scp_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189-ufs.c b/drivers/clk/mediatek/clk-mt8189-ufs.c
new file mode 100644
index 000000000000..2ab318e984ba
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-ufs.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
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
+#include <dt-bindings/clock/mt8189-clk.h>
+
+#define MT_CCF_BRINGUP		1
+
+/* Regular Number Definition */
+#define INV_OFS			-1
+#define INV_BIT			-1
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
+		.regs = &ufscfg_ao_reg_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,		\
+	}
+
+static const struct mtk_gate ufscfg_ao_reg_clks[] = {
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_TX_SYM, "ufscfg_ao_unipro_tx_sym",
+			"f26m_ck"/* parent */, 1),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM0, "ufscfg_ao_unipro_rx_sym0",
+			"f26m_ck"/* parent */, 2),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM1, "ufscfg_ao_unipro_rx_sym1",
+			"f26m_ck"/* parent */, 3),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_SYS, "ufscfg_ao_unipro_sys",
+			"ufs_ck"/* parent */, 4),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_U_SAP_CFG, "ufscfg_ao_u_sap_cfg",
+			"f26m_ck"/* parent */, 5),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_U_PHY_TOP_AHB_S_BUS, "ufscfg_ao_u_phy_ahb_s_bus",
+			"axi_u_ck"/* parent */, 6),
+};
+
+static const struct mtk_clk_desc ufscfg_ao_reg_mcd = {
+	.clks = ufscfg_ao_reg_clks,
+	.num_clks = CLK_UFSCFG_AO_REG_NR_CLK,
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
+		.regs = &ufscfg_pdn_reg_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,		\
+	}
+
+static const struct mtk_gate ufscfg_pdn_reg_clks[] = {
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_UFS, "ufscfg_ufshci_ufs",
+			"ufs_ck"/* parent */, 0),
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_AES, "ufscfg_ufshci_aes",
+			"aes_ufsfde_ck"/* parent */, 1),
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_U_AHB, "ufscfg_ufshci_u_ahb",
+			"axi_u_ck"/* parent */, 3),
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_U_AXI, "ufscfg_ufshci_u_axi",
+			"mem_sub_u_ck"/* parent */, 5),
+};
+
+static const struct mtk_clk_desc ufscfg_pdn_reg_mcd = {
+	.clks = ufscfg_pdn_reg_clks,
+	.num_clks = CLK_UFSCFG_PDN_REG_NR_CLK,
+};
+
+static const struct of_device_id of_match_clk_mt8189_ufs[] = {
+	{
+		.compatible = "mediatek,mt8189-ufscfg_ao",
+		.data = &ufscfg_ao_reg_mcd,
+	}, {
+		.compatible = "mediatek,mt8189-ufscfg_pdn",
+		.data = &ufscfg_pdn_reg_mcd,
+	}, {
+		/* sentinel */
+	}
+};
+
+
+static int clk_mt8189_ufs_grp_probe(struct platform_device *pdev)
+{
+	int r;
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init begin\n", __func__, pdev->name);
+#endif
+
+	r = mtk_clk_simple_probe(pdev);
+	if (r)
+		dev_info(&pdev->dev,
+			"could not register clock provider: %s: %d\n",
+			pdev->name, r);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init end\n", __func__, pdev->name);
+#endif
+
+	return r;
+}
+
+static struct platform_driver clk_mt8189_ufs_drv = {
+	.probe = clk_mt8189_ufs_grp_probe,
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
index 000000000000..483cc0a520c7
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-vcodec.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
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
+#include <dt-bindings/clock/mt8189-clk.h>
+
+#define MT_CCF_BRINGUP		1
+
+/* Regular Number Definition */
+#define INV_OFS			-1
+#define INV_BIT			-1
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
+		.regs = &vdec_core0_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+#define GATE_VDEC_CORE1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vdec_core1_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate vdec_core_clks[] = {
+	/* VDEC_CORE0 */
+	GATE_VDEC_CORE0(CLK_VDEC_CORE_VDEC_CKEN, "vdec_core_vdec_cken",
+			"vdec_ck"/* parent */, 0),
+	GATE_VDEC_CORE0(CLK_VDEC_CORE_VDEC_ACTIVE, "vdec_core_vdec_active",
+			"vdec_ck"/* parent */, 4),
+	/* VDEC_CORE1 */
+	GATE_VDEC_CORE1(CLK_VDEC_CORE_LARB_CKEN, "vdec_core_larb_cken",
+			"vdec_ck"/* parent */, 0),
+};
+
+static const struct mtk_clk_desc vdec_core_mcd = {
+	.clks = vdec_core_clks,
+	.num_clks = CLK_VDEC_CORE_NR_CLK,
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
+		.flags = CLK_OPS_PARENT_ENABLE,		\
+	}
+
+static const struct mtk_gate ven1_clks[] = {
+	GATE_VEN1(CLK_VEN1_CKE0_LARB, "ven1_larb",
+			"venc_ck"/* parent */, 0),
+	GATE_VEN1(CLK_VEN1_CKE1_VENC, "ven1_venc",
+			"venc_ck"/* parent */, 4),
+	GATE_VEN1(CLK_VEN1_CKE2_JPGENC, "ven1_jpgenc",
+			"venc_ck"/* parent */, 8),
+	GATE_VEN1(CLK_VEN1_CKE3_JPGDEC, "ven1_jpgdec",
+			"venc_ck"/* parent */, 12),
+	GATE_VEN1(CLK_VEN1_CKE4_JPGDEC_C1, "ven1_jpgdec_c1",
+			"venc_ck"/* parent */, 16),
+	GATE_VEN1(CLK_VEN1_CKE5_GALS, "ven1_gals",
+			"venc_ck"/* parent */, 28),
+	GATE_VEN1(CLK_VEN1_CKE6_GALS_SRAM, "ven1_gals_sram",
+			"venc_ck"/* parent */, 31),
+};
+
+static const struct mtk_clk_desc ven1_mcd = {
+	.clks = ven1_clks,
+	.num_clks = CLK_VEN1_NR_CLK,
+};
+
+static const struct of_device_id of_match_clk_mt8189_vcodec[] = {
+	{
+		.compatible = "mediatek,mt8189-vdec_core",
+		.data = &vdec_core_mcd,
+	}, {
+		.compatible = "mediatek,mt8189-venc",
+		.data = &ven1_mcd,
+	}, {
+		/* sentinel */
+	}
+};
+
+
+static int clk_mt8189_vcodec_grp_probe(struct platform_device *pdev)
+{
+	int r;
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init begin\n", __func__, pdev->name);
+#endif
+
+	r = mtk_clk_simple_probe(pdev);
+	if (r)
+		dev_info(&pdev->dev,
+			"could not register clock provider: %s: %d\n",
+			pdev->name, r);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s: %s init end\n", __func__, pdev->name);
+#endif
+
+	return r;
+}
+
+static struct platform_driver clk_mt8189_vcodec_drv = {
+	.probe = clk_mt8189_vcodec_grp_probe,
+	.driver = {
+		.name = "clk-mt8189-vcodec",
+		.of_match_table = of_match_clk_mt8189_vcodec,
+	},
+};
+
+module_platform_driver(clk_mt8189_vcodec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
new file mode 100644
index 000000000000..17d5bc3793d6
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -0,0 +1,3563 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
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
+#include "clk-pll.h"
+
+#include <dt-bindings/clock/mt8189-clk.h>
+
+/* bringup config */
+#define MT_CCF_BRINGUP		0
+#define MT_CCF_PLL_DISABLE	0
+#define MT_CCF_MUX_DISABLE	0
+
+/* Regular Number Definition */
+#define INV_OFS	-1
+#define INV_BIT	-1
+
+/* TOPCK MUX SEL REG */
+#define CLK_CFG_UPDATE				0x0004
+#define CLK_CFG_UPDATE1				0x0008
+#define CLK_CFG_UPDATE2				0x000c
+#define VLP_CLK_CFG_UPDATE			0x0004
+#define CLK_CFG_0				0x0010
+#define CLK_CFG_0_SET				0x0014
+#define CLK_CFG_0_CLR				0x0018
+#define CLK_CFG_1				0x0020
+#define CLK_CFG_1_SET				0x0024
+#define CLK_CFG_1_CLR				0x0028
+#define CLK_CFG_2				0x0030
+#define CLK_CFG_2_SET				0x0034
+#define CLK_CFG_2_CLR				0x0038
+#define CLK_CFG_3				0x0040
+#define CLK_CFG_3_SET				0x0044
+#define CLK_CFG_3_CLR				0x0048
+#define CLK_CFG_4				0x0050
+#define CLK_CFG_4_SET				0x0054
+#define CLK_CFG_4_CLR				0x0058
+#define CLK_CFG_5				0x0060
+#define CLK_CFG_5_SET				0x0064
+#define CLK_CFG_5_CLR				0x0068
+#define CLK_CFG_6				0x0070
+#define CLK_CFG_6_SET				0x0074
+#define CLK_CFG_6_CLR				0x0078
+#define CLK_CFG_7				0x0080
+#define CLK_CFG_7_SET				0x0084
+#define CLK_CFG_7_CLR				0x0088
+#define CLK_CFG_8				0x0090
+#define CLK_CFG_8_SET				0x0094
+#define CLK_CFG_8_CLR				0x0098
+#define CLK_CFG_9				0x00A0
+#define CLK_CFG_9_SET				0x00A4
+#define CLK_CFG_9_CLR				0x00A8
+#define CLK_CFG_10				0x00B0
+#define CLK_CFG_10_SET				0x00B4
+#define CLK_CFG_10_CLR				0x00B8
+#define CLK_CFG_11				0x00C0
+#define CLK_CFG_11_SET				0x00C4
+#define CLK_CFG_11_CLR				0x00C8
+#define CLK_CFG_12				0x00D0
+#define CLK_CFG_12_SET				0x00D4
+#define CLK_CFG_12_CLR				0x00D8
+#define CLK_CFG_13				0x00E0
+#define CLK_CFG_13_SET				0x00E4
+#define CLK_CFG_13_CLR				0x00E8
+#define CLK_CFG_14				0x00F0
+#define CLK_CFG_14_SET				0x00F4
+#define CLK_CFG_14_CLR				0x00F8
+#define CLK_CFG_15				0x0100
+#define CLK_CFG_15_SET				0x0104
+#define CLK_CFG_15_CLR				0x0108
+#define CLK_CFG_16				0x0110
+#define CLK_CFG_16_SET				0x0114
+#define CLK_CFG_16_CLR				0x0118
+#define CLK_CFG_17				0x0180
+#define CLK_CFG_17_SET				0x0184
+#define CLK_CFG_17_CLR				0x0188
+#define CLK_CFG_18				0x0190
+#define CLK_CFG_18_SET				0x0194
+#define CLK_CFG_18_CLR				0x0198
+#define CLK_CFG_19				0x0240
+#define CLK_CFG_19_SET				0x0244
+#define CLK_CFG_19_CLR				0x0248
+#define CLK_AUDDIV_0				0x0320
+#define CLK_MISC_CFG_3				0x0510
+#define CLK_MISC_CFG_3_SET				0x0514
+#define CLK_MISC_CFG_3_CLR				0x0518
+#define VLP_CLK_CFG_0				0x0008
+#define VLP_CLK_CFG_0_SET				0x000C
+#define VLP_CLK_CFG_0_CLR				0x0010
+#define VLP_CLK_CFG_1				0x0014
+#define VLP_CLK_CFG_1_SET				0x0018
+#define VLP_CLK_CFG_1_CLR				0x001C
+#define VLP_CLK_CFG_2				0x0020
+#define VLP_CLK_CFG_2_SET				0x0024
+#define VLP_CLK_CFG_2_CLR				0x0028
+#define VLP_CLK_CFG_3				0x002C
+#define VLP_CLK_CFG_3_SET				0x0030
+#define VLP_CLK_CFG_3_CLR				0x0034
+#define VLP_CLK_CFG_4				0x0038
+#define VLP_CLK_CFG_4_SET				0x003C
+#define VLP_CLK_CFG_4_CLR				0x0040
+#define VLP_CLK_CFG_5				0x0044
+#define VLP_CLK_CFG_5_SET				0x0048
+#define VLP_CLK_CFG_5_CLR				0x004C
+
+/* TOPCK MUX SHIFT */
+#define TOP_MUX_AXI_SHIFT			0
+#define TOP_MUX_AXI_PERI_SHIFT			1
+#define TOP_MUX_AXI_UFS_SHIFT			2
+#define TOP_MUX_BUS_AXIMEM_SHIFT		3
+#define TOP_MUX_DISP0_SHIFT			4
+#define TOP_MUX_MMINFRA_SHIFT			5
+#define TOP_MUX_UART_SHIFT			6
+#define TOP_MUX_SPI0_SHIFT			7
+#define TOP_MUX_SPI1_SHIFT			8
+#define TOP_MUX_SPI2_SHIFT			9
+#define TOP_MUX_SPI3_SHIFT			10
+#define TOP_MUX_SPI4_SHIFT			11
+#define TOP_MUX_SPI5_SHIFT			12
+#define TOP_MUX_MSDC_MACRO_0P_SHIFT		13
+#define TOP_MUX_MSDC50_0_HCLK_SHIFT		14
+#define TOP_MUX_MSDC50_0_SHIFT			15
+#define TOP_MUX_AES_MSDCFDE_SHIFT		16
+#define TOP_MUX_MSDC_MACRO_1P_SHIFT		17
+#define TOP_MUX_MSDC30_1_SHIFT			18
+#define TOP_MUX_MSDC30_1_HCLK_SHIFT		19
+#define TOP_MUX_MSDC_MACRO_2P_SHIFT		20
+#define TOP_MUX_MSDC30_2_SHIFT			21
+#define TOP_MUX_MSDC30_2_HCLK_SHIFT		22
+#define TOP_MUX_AUD_INTBUS_SHIFT		23
+#define TOP_MUX_ATB_SHIFT			24
+#define TOP_MUX_DISP_PWM_SHIFT			25
+#define TOP_MUX_USB_TOP_P0_SHIFT		26
+#define TOP_MUX_SSUSB_XHCI_P0_SHIFT		27
+#define TOP_MUX_USB_TOP_P1_SHIFT		28
+#define TOP_MUX_SSUSB_XHCI_P1_SHIFT		29
+#define TOP_MUX_USB_TOP_P2_SHIFT		30
+#define TOP_MUX_SSUSB_XHCI_P2_SHIFT		0
+#define TOP_MUX_USB_TOP_P3_SHIFT		1
+#define TOP_MUX_SSUSB_XHCI_P3_SHIFT		2
+#define TOP_MUX_USB_TOP_P4_SHIFT		3
+#define TOP_MUX_SSUSB_XHCI_P4_SHIFT		4
+#define TOP_MUX_I2C_SHIFT			5
+#define TOP_MUX_SENINF_SHIFT			6
+#define TOP_MUX_SENINF1_SHIFT			7
+#define TOP_MUX_AUD_ENGEN1_SHIFT		8
+#define TOP_MUX_AUD_ENGEN2_SHIFT		9
+#define TOP_MUX_AES_UFSFDE_SHIFT		10
+#define TOP_MUX_UFS_SHIFT			11
+#define TOP_MUX_UFS_MBIST_SHIFT			12
+#define TOP_MUX_AUD_1_SHIFT			13
+#define TOP_MUX_AUD_2_SHIFT			14
+#define TOP_MUX_VENC_SHIFT			15
+#define TOP_MUX_VDEC_SHIFT			16
+#define TOP_MUX_PWM_SHIFT			17
+#define TOP_MUX_AUDIO_H_SHIFT			18
+#define TOP_MUX_MCUPM_SHIFT			19
+#define TOP_MUX_MEM_SUB_SHIFT			20
+#define TOP_MUX_MEM_SUB_PERI_SHIFT		21
+#define TOP_MUX_MEM_SUB_UFS_SHIFT		22
+#define TOP_MUX_EMI_N_SHIFT			23
+#define TOP_MUX_DSI_OCC_SHIFT			24
+#define TOP_MUX_AP2CONN_HOST_SHIFT		25
+#define TOP_MUX_IMG1_SHIFT			26
+#define TOP_MUX_IPE_SHIFT			27
+#define TOP_MUX_CAM_SHIFT			28
+#define TOP_MUX_CAMTM_SHIFT			29
+#define TOP_MUX_DSP_SHIFT			30
+#define TOP_MUX_SR_PKA_SHIFT			0
+#define TOP_MUX_DXCC_SHIFT			1
+#define TOP_MUX_MFG_REF_SHIFT			2
+#define TOP_MUX_MDP0_SHIFT			3
+#define TOP_MUX_DP_SHIFT			4
+#define TOP_MUX_EDP_SHIFT			5
+#define TOP_MUX_EDP_FAVT_SHIFT			6
+#define TOP_MUX_SNPS_ETH_250M_SHIFT		7
+#define TOP_MUX_SNPS_ETH_62P4M_PTP_SHIFT	8
+#define TOP_MUX_SNPS_ETH_50M_RMII_SHIFT		9
+#define TOP_MUX_SFLASH_SHIFT			10
+#define TOP_MUX_GCPU_SHIFT			11
+#define TOP_MUX_PCIE_MAC_TL_SHIFT		12
+#define TOP_MUX_VDSTX_CLKDIG_CTS_SHIFT		13
+#define TOP_MUX_PLL_DPIX_SHIFT			14
+#define TOP_MUX_ECC_SHIFT			15
+#define TOP_MUX_SCP_SHIFT			0
+#define TOP_MUX_PWRAP_ULPOSC_SHIFT		1
+#define TOP_MUX_SPMI_P_MST_SHIFT		2
+#define TOP_MUX_DVFSRC_SHIFT			3
+#define TOP_MUX_PWM_VLP_SHIFT			4
+#define TOP_MUX_AXI_VLP_SHIFT			5
+#define TOP_MUX_SYSTIMER_26M_SHIFT		6
+#define TOP_MUX_SSPM_SHIFT			7
+#define TOP_MUX_SSPM_F26M_SHIFT			8
+#define TOP_MUX_SRCK_SHIFT			9
+#define TOP_MUX_SCP_SPI_SHIFT			10
+#define TOP_MUX_SCP_IIC_SHIFT			11
+#define TOP_MUX_SCP_SPI_HIGH_SPD_SHIFT		12
+#define TOP_MUX_SCP_IIC_HIGH_SPD_SHIFT		13
+#define TOP_MUX_SSPM_ULPOSC_SHIFT		14
+#define TOP_MUX_APXGPT_26M_SHIFT		15
+#define TOP_MUX_VADSP_SHIFT			16
+#define TOP_MUX_VADSP_VOWPLL_SHIFT		17
+#define TOP_MUX_VADSP_UARTHUB_BCLK_SHIFT	18
+#define TOP_MUX_CAMTG0_SHIFT			19
+#define TOP_MUX_CAMTG1_SHIFT			20
+#define TOP_MUX_CAMTG2_SHIFT			21
+#define TOP_MUX_AUD_ADC_SHIFT			22
+#define TOP_MUX_KP_IRQ_GEN_SHIFT		23
+
+/* TOPCK CKSTA REG */
+
+
+/* TOPCK DIVIDER REG */
+#define CLK_AUDDIV_2				0x0328
+#define CLK_AUDDIV_3				0x0334
+#define CLK_AUDDIV_5				0x033C
+
+/* APMIXED PLL REG */
+#define AP_PLL_CON3				0x00C
+#define APLL1_TUNER_CON0			0x040
+#define APLL2_TUNER_CON0			0x044
+#define ARMPLL_LL_CON0				0x204
+#define ARMPLL_LL_CON1				0x208
+#define ARMPLL_LL_CON2				0x20C
+#define ARMPLL_LL_CON3				0x210
+#define ARMPLL_BL_CON0				0x214
+#define ARMPLL_BL_CON1				0x218
+#define ARMPLL_BL_CON2				0x21C
+#define ARMPLL_BL_CON3				0x220
+#define CCIPLL_CON0				0x224
+#define CCIPLL_CON1				0x228
+#define CCIPLL_CON2				0x22C
+#define CCIPLL_CON3				0x230
+#define MAINPLL_CON0				0x304
+#define MAINPLL_CON1				0x308
+#define MAINPLL_CON2				0x30C
+#define MAINPLL_CON3				0x310
+#define UNIVPLL_CON0				0x314
+#define UNIVPLL_CON1				0x318
+#define UNIVPLL_CON2				0x31C
+#define UNIVPLL_CON3				0x320
+#define MMPLL_CON0				0x324
+#define MMPLL_CON1				0x328
+#define MMPLL_CON2				0x32C
+#define MMPLL_CON3				0x330
+#define MFGPLL_CON0				0x504
+#define MFGPLL_CON1				0x508
+#define MFGPLL_CON2				0x50C
+#define MFGPLL_CON3				0x510
+#define APLL1_CON0				0x404
+#define APLL1_CON1				0x408
+#define APLL1_CON2				0x40C
+#define APLL1_CON3				0x410
+#define APLL1_CON4				0x414
+#define APLL2_CON0				0x418
+#define APLL2_CON1				0x41C
+#define APLL2_CON2				0x420
+#define APLL2_CON3				0x424
+#define APLL2_CON4				0x428
+#define EMIPLL_CON0				0x334
+#define EMIPLL_CON1				0x338
+#define EMIPLL_CON2				0x33C
+#define EMIPLL_CON3				0x340
+#define APUPLL2_CON0				0x614
+#define APUPLL2_CON1				0x618
+#define APUPLL2_CON2				0x61C
+#define APUPLL2_CON3				0x620
+#define APUPLL_CON0				0x604
+#define APUPLL_CON1				0x608
+#define APUPLL_CON2				0x60C
+#define APUPLL_CON3				0x610
+#define TVDPLL1_CON0				0x42C
+#define TVDPLL1_CON1				0x430
+#define TVDPLL1_CON2				0x434
+#define TVDPLL1_CON3				0x438
+#define TVDPLL2_CON0				0x43C
+#define TVDPLL2_CON1				0x440
+#define TVDPLL2_CON2				0x444
+#define TVDPLL2_CON3				0x448
+#define ETHPLL_CON0				0x514
+#define ETHPLL_CON1				0x518
+#define ETHPLL_CON2				0x51C
+#define ETHPLL_CON3				0x520
+#define MSDCPLL_CON0				0x524
+#define MSDCPLL_CON1				0x528
+#define MSDCPLL_CON2				0x52C
+#define MSDCPLL_CON3				0x530
+#define UFSPLL_CON0				0x534
+#define UFSPLL_CON1				0x538
+#define UFSPLL_CON2				0x53C
+#define UFSPLL_CON3				0x540
+
+/* HW Voter REG */
+
+
+static DEFINE_SPINLOCK(mt8189_clk_lock);
+
+static const struct mtk_fixed_factor vlp_ck_divs[] = {
+	FACTOR(CLK_VLP_CK_SCP, "vlp_scp_ck",
+			"vlp_scp_sel", 1, 1),
+	FACTOR(CLK_VLP_CK_PWRAP_ULPOSC, "vlp_pwrap_ulposc_ck",
+			"vlp_pwrap_ulposc_sel", 1, 1),
+	FACTOR(CLK_VLP_CK_SPMI_P_MST, "vlp_spmi_p_ck",
+			"vlp_spmi_p_sel", 1, 1),
+	FACTOR(CLK_VLP_CK_DVFSRC, "vlp_dvfsrc_ck",
+			"vlp_dvfsrc_sel", 1, 1),
+	FACTOR(CLK_VLP_CK_PWM_VLP, "vlp_pwm_vlp_ck",
+			"vlp_pwm_vlp_sel", 1, 1),
+	FACTOR(CLK_VLP_CK_SSPM, "vlp_sspm_ck",
+			"vlp_sspm_sel", 1, 1),
+	FACTOR(CLK_VLP_CK_SSPM_F26M, "vlp_sspm_f26m_ck",
+			"vlp_sspm_f26m_sel", 1, 1),
+	FACTOR(CLK_VLP_CK_SRCK, "vlp_srck_ck",
+			"vlp_srck_sel", 1, 1),
+	FACTOR(CLK_VLP_CK_SCP_IIC, "vlp_scp_iic_ck",
+			"vlp_scp_iic_sel", 1, 1),
+	FACTOR(CLK_VLP_CK_VADSP, "vlp_vadsp_ck",
+			"vlp_vadsp_sel", 1, 1),
+	FACTOR(CLK_VLP_CK_VADSP_VOWPLL, "vlp_vadsp_vowpll_ck",
+			"vlp_vadsp_vowpll_sel", 1, 1),
+	FACTOR(CLK_VLP_CK_VADSP_VLP_26M, "vlp_vadsp_vlp_26m_ck",
+			"tck_26m_mx9_ck", 1, 1),
+	FACTOR(CLK_VLP_CK_SEJ_26M, "vlp_sej_26m_ck",
+			"tck_26m_mx9_ck", 1, 1),
+	FACTOR(CLK_VLP_CK_SPMI_P_MST_32K, "vlp_spmi_p_32k_ck",
+			"rtc32k_i", 1, 1),
+	FACTOR(CLK_VLP_CK_VLP_F32K_COM, "vlp_vlp_f32k_com_ck",
+			"rtc32k_i", 1, 1),
+	FACTOR(CLK_VLP_CK_VLP_F26M_COM, "vlp_vlp_f26m_com_ck",
+			"f26m_ck", 1, 1),
+	FACTOR(CLK_VLP_CK_SSPM_F32K, "vlp_sspm_f32k_ck",
+			"rtc32k_i", 1, 1),
+	FACTOR(CLK_VLP_CK_SSPM_ULPOSC, "vlp_sspm_ulposc_ck",
+			"vlp_sspm_ulposc_sel", 1, 1),
+	FACTOR(CLK_VLP_CK_DPMSRCK, "vlp_dpmsrck_ck",
+			"f26m_ck", 1, 1),
+	FACTOR(CLK_VLP_CK_DPMSRULP, "vlp_dpmsrulp_ck",
+			"osc_d10", 1, 1),
+	FACTOR(CLK_VLP_CK_DPMSRRTC, "vlp_dpmsrrtc_ck",
+			"rtc32k_i", 1, 1),
+};
+
+static const struct mtk_fixed_factor top_divs[] = {
+	FACTOR(CLK_TOP_CCIPLL, "ccipll_ck",
+			"ccipll", 1, 1),
+	FACTOR(CLK_TOP_MAINPLL, "mainpll_ck",
+			"mainpll", 1, 1),
+	FACTOR(CLK_TOP_MAINPLL_D3, "mainpll_d3",
+			"mainpll", 1, 3),
+	FACTOR(CLK_TOP_MAINPLL_D4, "mainpll_d4",
+			"mainpll", 1, 4),
+	FACTOR(CLK_TOP_MAINPLL_D4_D2, "mainpll_d4_d2",
+			"mainpll", 1, 8),
+	FACTOR(CLK_TOP_MAINPLL_D4_D4, "mainpll_d4_d4",
+			"mainpll", 1, 16),
+	FACTOR(CLK_TOP_MAINPLL_D4_D8, "mainpll_d4_d8",
+			"mainpll", 43, 1375),
+	FACTOR(CLK_TOP_MAINPLL_D5, "mainpll_d5",
+			"mainpll", 1, 5),
+	FACTOR(CLK_TOP_MAINPLL_D5_D2, "mainpll_d5_d2",
+			"mainpll", 1, 10),
+	FACTOR(CLK_TOP_MAINPLL_D5_D4, "mainpll_d5_d4",
+			"mainpll", 1, 20),
+	FACTOR(CLK_TOP_MAINPLL_D5_D8, "mainpll_d5_d8",
+			"mainpll", 1, 40),
+	FACTOR(CLK_TOP_MAINPLL_D6, "mainpll_d6",
+			"mainpll", 1, 6),
+	FACTOR(CLK_TOP_MAINPLL_D6_D2, "mainpll_d6_d2",
+			"mainpll", 1, 12),
+	FACTOR(CLK_TOP_MAINPLL_D6_D4, "mainpll_d6_d4",
+			"mainpll", 1, 24),
+	FACTOR(CLK_TOP_MAINPLL_D6_D8, "mainpll_d6_d8",
+			"mainpll", 1, 48),
+	FACTOR(CLK_TOP_MAINPLL_D7, "mainpll_d7",
+			"mainpll", 1, 7),
+	FACTOR(CLK_TOP_MAINPLL_D7_D2, "mainpll_d7_d2",
+			"mainpll", 1, 14),
+	FACTOR(CLK_TOP_MAINPLL_D7_D4, "mainpll_d7_d4",
+			"mainpll", 1, 28),
+	FACTOR(CLK_TOP_MAINPLL_D7_D8, "mainpll_d7_d8",
+			"mainpll", 1, 56),
+	FACTOR(CLK_TOP_MAINPLL_D9, "mainpll_d9",
+			"mainpll", 1, 9),
+	FACTOR(CLK_TOP_UNIVPLL, "univpll_ck",
+			"univpll", 1, 1),
+	FACTOR(CLK_TOP_UNIVPLL_D2, "univpll_d2",
+			"univpll", 1, 2),
+	FACTOR(CLK_TOP_UNIVPLL_D3, "univpll_d3",
+			"univpll", 1, 3),
+	FACTOR(CLK_TOP_UNIVPLL_D4, "univpll_d4",
+			"univpll", 1, 4),
+	FACTOR(CLK_TOP_UNIVPLL_D4_D2, "univpll_d4_d2",
+			"univpll", 1, 8),
+	FACTOR(CLK_TOP_UNIVPLL_D4_D4, "univpll_d4_d4",
+			"univpll", 1, 16),
+	FACTOR(CLK_TOP_UNIVPLL_D4_D8, "univpll_d4_d8",
+			"univpll", 1, 32),
+	FACTOR(CLK_TOP_UNIVPLL_D5, "univpll_d5",
+			"univpll", 1, 5),
+	FACTOR(CLK_TOP_UNIVPLL_D5_D2, "univpll_d5_d2",
+			"univpll", 1, 10),
+	FACTOR(CLK_TOP_UNIVPLL_D5_D4, "univpll_d5_d4",
+			"univpll", 1, 20),
+	FACTOR(CLK_TOP_UNIVPLL_D6, "univpll_d6",
+			"univpll", 1, 6),
+	FACTOR(CLK_TOP_UNIVPLL_D6_D2, "univpll_d6_d2",
+			"univpll", 1, 12),
+	FACTOR(CLK_TOP_UNIVPLL_D6_D4, "univpll_d6_d4",
+			"univpll", 1, 24),
+	FACTOR(CLK_TOP_UNIVPLL_D6_D8, "univpll_d6_d8",
+			"univpll", 1, 48),
+	FACTOR(CLK_TOP_UNIVPLL_D6_D16, "univpll_d6_d16",
+			"univpll", 1, 96),
+	FACTOR(CLK_TOP_UNIVPLL_D7, "univpll_d7",
+			"univpll", 1, 7),
+	FACTOR(CLK_TOP_UNIVPLL_D7_D2, "univpll_d7_d2",
+			"univpll", 1, 14),
+	FACTOR(CLK_TOP_UNIVPLL_D7_D3, "univpll_d7_d3",
+			"univpll", 1, 21),
+	FACTOR(CLK_TOP_LVDSTX_DG_CTS, "lvdstx_dg_cts_ck",
+			"univpll", 1, 21),
+	FACTOR(CLK_TOP_UNIVPLL_192M, "univpll_192m_ck",
+			"univpll", 1, 13),
+	FACTOR(CLK_TOP_UNIVPLL_192M_D2, "univpll_192m_d2",
+			"univpll", 1, 26),
+	FACTOR(CLK_TOP_UNIVPLL_192M_D4, "univpll_192m_d4",
+			"univpll", 1, 52),
+	FACTOR(CLK_TOP_UNIVPLL_192M_D8, "univpll_192m_d8",
+			"univpll", 1, 104),
+	FACTOR(CLK_TOP_UNIVPLL_192M_D10, "univpll_192m_d10",
+			"univpll", 1, 130),
+	FACTOR(CLK_TOP_UNIVPLL_192M_D16, "univpll_192m_d16",
+			"univpll", 1, 208),
+	FACTOR(CLK_TOP_UNIVPLL_192M_D32, "univpll_192m_d32",
+			"univpll", 1, 416),
+	FACTOR(CLK_TOP_APLL1, "apll1_ck",
+			"apll1", 1, 1),
+	FACTOR(CLK_TOP_APLL1_D2, "apll1_d2",
+			"apll1", 1, 2),
+	FACTOR(CLK_TOP_APLL1_D4, "apll1_d4",
+			"apll1", 1, 4),
+	FACTOR(CLK_TOP_APLL1_D8, "apll1_d8",
+			"apll1", 1, 8),
+	FACTOR(CLK_TOP_APLL1_D3, "apll1_d3",
+			"apll1", 1, 3),
+	FACTOR(CLK_TOP_APLL2, "apll2_ck",
+			"apll2", 1, 1),
+	FACTOR(CLK_TOP_APLL2_D2, "apll2_d2",
+			"apll2", 1, 2),
+	FACTOR(CLK_TOP_APLL2_D4, "apll2_d4",
+			"apll2", 1, 4),
+	FACTOR(CLK_TOP_APLL2_D8, "apll2_d8",
+			"apll2", 1, 8),
+	FACTOR(CLK_TOP_APLL2_D3, "apll2_d3",
+			"apll2", 1, 3),
+	FACTOR(CLK_TOP_MFGPLL, "mfgpll_ck",
+			"mfgpll", 1, 1),
+	FACTOR(CLK_TOP_MMPLL, "mmpll_ck",
+			"mmpll", 1, 1),
+	FACTOR(CLK_TOP_MMPLL_D4, "mmpll_d4",
+			"mmpll", 1, 4),
+	FACTOR(CLK_TOP_MMPLL_D4_D2, "mmpll_d4_d2",
+			"mmpll", 1, 8),
+	FACTOR(CLK_TOP_MMPLL_D4_D4, "mmpll_d4_d4",
+			"mmpll", 1, 16),
+	FACTOR(CLK_TOP_VPLL_DPIX, "vpll_dpix_ck",
+			"mmpll", 1, 16),
+	FACTOR(CLK_TOP_MMPLL_D5, "mmpll_d5",
+			"mmpll", 1, 5),
+	FACTOR(CLK_TOP_MMPLL_D5_D2, "mmpll_d5_d2",
+			"mmpll", 1, 10),
+	FACTOR(CLK_TOP_MMPLL_D5_D4, "mmpll_d5_d4",
+			"mmpll", 1, 20),
+	FACTOR(CLK_TOP_MMPLL_D6, "mmpll_d6",
+			"mmpll", 1, 6),
+	FACTOR(CLK_TOP_MMPLL_D6_D2, "mmpll_d6_d2",
+			"mmpll", 1, 12),
+	FACTOR(CLK_TOP_MMPLL_D7, "mmpll_d7",
+			"mmpll", 1, 7),
+	FACTOR(CLK_TOP_MMPLL_D9, "mmpll_d9",
+			"mmpll", 1, 9),
+	FACTOR(CLK_TOP_TVDPLL1, "tvdpll1_ck",
+			"tvdpll1", 1, 1),
+	FACTOR(CLK_TOP_TVDPLL1_D2, "tvdpll1_d2",
+			"tvdpll1", 1, 2),
+	FACTOR(CLK_TOP_TVDPLL1_D4, "tvdpll1_d4",
+			"tvdpll1", 1, 4),
+	FACTOR(CLK_TOP_TVDPLL1_D8, "tvdpll1_d8",
+			"tvdpll1", 1, 8),
+	FACTOR(CLK_TOP_TVDPLL1_D16, "tvdpll1_d16",
+			"tvdpll1", 92, 1473),
+	FACTOR(CLK_TOP_TVDPLL2, "tvdpll2_ck",
+			"tvdpll2", 1, 1),
+	FACTOR(CLK_TOP_TVDPLL2_D2, "tvdpll2_d2",
+			"tvdpll2", 1, 2),
+	FACTOR(CLK_TOP_TVDPLL2_D4, "tvdpll2_d4",
+			"tvdpll2", 1, 4),
+	FACTOR(CLK_TOP_TVDPLL2_D8, "tvdpll2_d8",
+			"tvdpll2", 1, 8),
+	FACTOR(CLK_TOP_TVDPLL2_D16, "tvdpll2_d16",
+			"tvdpll2", 92, 1473),
+	FACTOR(CLK_TOP_ETHPLL, "ethpll_ck",
+			"ethpll", 1, 1),
+	FACTOR(CLK_TOP_ETHPLL_D2, "ethpll_d2",
+			"ethpll", 1, 2),
+	FACTOR(CLK_TOP_ETHPLL_D8, "ethpll_d8",
+			"ethpll", 1, 8),
+	FACTOR(CLK_TOP_ETHPLL_D10, "ethpll_d10",
+			"ethpll", 1, 10),
+	FACTOR(CLK_TOP_EMIPLL, "emipll_ck",
+			"emipll", 1, 1),
+	FACTOR(CLK_TOP_MSDCPLL, "msdcpll_ck",
+			"msdcpll", 1, 1),
+	FACTOR(CLK_TOP_MSDCPLL_D2, "msdcpll_d2",
+			"msdcpll", 1, 2),
+	FACTOR(CLK_TOP_UFSPLL, "ufspll_ck",
+			"ufspll", 1, 1),
+	FACTOR(CLK_TOP_UFSPLL_D2, "ufspll_d2",
+			"ufspll", 1, 2),
+	FACTOR(CLK_TOP_APUPLL, "apupll_ck",
+			"apupll", 1, 1),
+	FACTOR(CLK_TOP_CLKRTC, "clkrtc",
+			"clk32k", 1, 1),
+	FACTOR(CLK_TOP_RTC32K_CK_I, "rtc32k_i",
+			"clk32k", 1, 1),
+	FACTOR(CLK_TOP_TCK_26M_MX9, "tck_26m_mx9_ck",
+			"clk26m", 1, 1),
+	FACTOR(CLK_TOP_VOWPLL, "vowpll_ck",
+			"clk26m", 1, 1),
+	FACTOR(CLK_TOP_F26M_CK_D2, "f26m_d2",
+			"clk26m", 1, 2),
+	FACTOR(CLK_TOP_OSC, "osc_ck",
+			"ulposc", 1, 1),
+	FACTOR(CLK_TOP_OSC_D2, "osc_d2",
+			"ulposc", 1, 2),
+	FACTOR(CLK_TOP_OSC_D4, "osc_d4",
+			"ulposc", 1, 4),
+	FACTOR(CLK_TOP_OSC_D8, "osc_d8",
+			"ulposc", 1, 8),
+	FACTOR(CLK_TOP_OSC_D16, "osc_d16",
+			"ulposc", 61, 973),
+	FACTOR(CLK_TOP_OSC_D3, "osc_d3",
+			"ulposc", 1, 3),
+	FACTOR(CLK_TOP_OSC_D7, "osc_d7",
+			"ulposc", 1, 7),
+	FACTOR(CLK_TOP_OSC_D10, "osc_d10",
+			"ulposc", 1, 10),
+	FACTOR(CLK_TOP_OSC_D20, "osc_d20",
+			"ulposc", 1, 20),
+	FACTOR(CLK_TOP_F26M, "f26m_ck",
+			"clk26m", 1, 1),
+	FACTOR(CLK_TOP_RTC, "rtc_ck",
+			"clk32k", 1, 1),
+	FACTOR(CLK_TOP_AXI, "axi_ck",
+			"axi_sel", 1, 1),
+	FACTOR(CLK_TOP_AXI_PERI, "axi_peri_ck",
+			"axi_peri_sel", 1, 1),
+	FACTOR(CLK_TOP_AXI_UFS, "axi_u_ck",
+			"axi_u_sel", 1, 1),
+	FACTOR(CLK_TOP_BUS_AXIMEM, "bus_aximem_ck",
+			"bus_aximem_sel", 1, 1),
+	FACTOR(CLK_TOP_DISP0, "disp0_ck",
+			"disp0_sel", 1, 1),
+	FACTOR(CLK_TOP_MMINFRA, "mminfra_ck",
+			"mminfra_sel", 1, 1),
+	FACTOR(CLK_TOP_UART, "uart_ck",
+			"uart_sel", 1, 1),
+	FACTOR(CLK_TOP_SPI0, "spi0_ck",
+			"spi0_sel", 1, 1),
+	FACTOR(CLK_TOP_SPI1, "spi1_ck",
+			"spi1_sel", 1, 1),
+	FACTOR(CLK_TOP_SPI2, "spi2_ck",
+			"spi2_sel", 1, 1),
+	FACTOR(CLK_TOP_SPI3, "spi3_ck",
+			"spi3_sel", 1, 1),
+	FACTOR(CLK_TOP_SPI4, "spi4_ck",
+			"spi4_sel", 1, 1),
+	FACTOR(CLK_TOP_SPI5, "spi5_ck",
+			"spi5_sel", 1, 1),
+	FACTOR(CLK_TOP_MSDC50_0_HCLK, "msdc5hclk_ck",
+			"msdc5hclk_sel", 1, 1),
+	FACTOR(CLK_TOP_MSDC50_0, "msdc50_0_ck",
+			"msdc50_0_sel", 1, 1),
+	FACTOR(CLK_TOP_AES_MSDCFDE, "aes_msdcfde_ck",
+			"aes_msdcfde_sel", 1, 1),
+	FACTOR(CLK_TOP_MSDC30_1, "msdc30_1_ck",
+			"msdc30_1_sel", 1, 1),
+	FACTOR(CLK_TOP_MSDC30_1_HCLK, "msdc30_1_h_ck",
+			"msdc30_1_h_sel", 1, 1),
+	FACTOR(CLK_TOP_MSDC30_2, "msdc30_2_ck",
+			"msdc30_2_sel", 1, 1),
+	FACTOR(CLK_TOP_MSDC30_2_HCLK, "msdc30_2_h_ck",
+			"msdc30_2_h_sel", 1, 1),
+	FACTOR(CLK_TOP_AUD_INTBUS, "aud_intbus_ck",
+			"aud_intbus_sel", 1, 1),
+	FACTOR(CLK_TOP_ATB, "atb_ck",
+			"atb_sel", 1, 1),
+	FACTOR(CLK_TOP_DISP_PWM, "disp_pwm_ck",
+			"disp_pwm_sel", 1, 1),
+	FACTOR(CLK_TOP_USB_TOP_P0, "usb_p0_ck",
+			"usb_p0_sel", 1, 1),
+	FACTOR(CLK_TOP_USB_XHCI_P0, "ssusb_xhci_p0_ck",
+			"ssusb_xhci_p0_sel", 1, 1),
+	FACTOR(CLK_TOP_USB_TOP_P1, "usb_p1_ck",
+			"usb_p1_sel", 1, 1),
+	FACTOR(CLK_TOP_USB_XHCI_P1, "ssusb_xhci_p1_ck",
+			"ssusb_xhci_p1_sel", 1, 1),
+	FACTOR(CLK_TOP_USB_TOP_P2, "usb_p2_ck",
+			"usb_p2_sel", 1, 1),
+	FACTOR(CLK_TOP_USB_XHCI_P2, "ssusb_xhci_p2_ck",
+			"ssusb_xhci_p2_sel", 1, 1),
+	FACTOR(CLK_TOP_USB_TOP_P3, "usb_p3_ck",
+			"usb_p3_sel", 1, 1),
+	FACTOR(CLK_TOP_USB_XHCI_P3, "ssusb_xhci_p3_ck",
+			"ssusb_xhci_p3_sel", 1, 1),
+	FACTOR(CLK_TOP_USB_TOP_P4, "usb_p4_ck",
+			"usb_p4_sel", 1, 1),
+	FACTOR(CLK_TOP_USB_XHCI_P4, "ssusb_xhci_p4_ck",
+			"ssusb_xhci_p4_sel", 1, 1),
+	FACTOR(CLK_TOP_I2C, "i2c_ck",
+			"i2c_sel", 1, 1),
+	FACTOR(CLK_TOP_AUD_ENGEN1, "aud_engen1_ck",
+			"aud_engen1_sel", 1, 1),
+	FACTOR(CLK_TOP_AUD_ENGEN2, "aud_engen2_ck",
+			"aud_engen2_sel", 1, 1),
+	FACTOR(CLK_TOP_AES_UFSFDE, "aes_ufsfde_ck",
+			"aes_ufsfde_sel", 1, 1),
+	FACTOR(CLK_TOP_UFS, "ufs_ck",
+			"ufs_sel", 1, 1),
+	FACTOR(CLK_TOP_AUD_1, "aud_1_ck",
+			"aud_1_sel", 1, 1),
+	FACTOR(CLK_TOP_AUD_2, "aud_2_ck",
+			"aud_2_sel", 1, 1),
+	FACTOR(CLK_TOP_VENC, "venc_ck",
+			"venc_sel", 1, 1),
+	FACTOR(CLK_TOP_VDEC, "vdec_ck",
+			"vdec_sel", 1, 1),
+	FACTOR(CLK_TOP_PWM, "pwm_ck",
+			"pwm_sel", 1, 1),
+	FACTOR(CLK_TOP_AUDIO_H, "audio_h_ck",
+			"audio_h_sel", 1, 1),
+	FACTOR(CLK_TOP_MEM_SUB, "mem_sub_ck",
+			"mem_sub_sel", 1, 1),
+	FACTOR(CLK_TOP_MEM_SUB_PERI, "mem_sub_peri_ck",
+			"mem_sub_peri_sel", 1, 1),
+	FACTOR(CLK_TOP_MEM_SUB_UFS, "mem_sub_u_ck",
+			"mem_sub_u_sel", 1, 1),
+	FACTOR(CLK_TOP_DSI_OCC, "dsi_occ_ck",
+			"dsi_occ_sel", 1, 1),
+	FACTOR(CLK_TOP_IMG1, "img1_ck",
+			"img1_sel", 1, 1),
+	FACTOR(CLK_TOP_IPE, "ipe_ck",
+			"ipe_sel", 1, 1),
+	FACTOR(CLK_TOP_CAM, "cam_ck",
+			"cam_sel", 1, 1),
+	FACTOR(CLK_TOP_DXCC, "dxcc_ck",
+			"dxcc_sel", 1, 1),
+	FACTOR(CLK_TOP_MDP0, "mdp0_ck",
+			"mdp0_sel", 1, 1),
+	FACTOR(CLK_TOP_DP, "dp_ck",
+			"dp_sel", 1, 1),
+	FACTOR(CLK_TOP_EDP, "edp_ck",
+			"edp_sel", 1, 1),
+	FACTOR(CLK_TOP_EDP_FAVT, "edp_favt_ck",
+			"edp_favt_sel", 1, 1),
+	FACTOR(CLK_TOP_SFLASH, "sflash_ck",
+			"sflash_sel", 1, 1),
+	FACTOR(CLK_TOP_MAC_TL, "pcie_mac_tl_ck",
+			"pcie_mac_tl_sel", 1, 1),
+	FACTOR(CLK_TOP_VDSTX_DG_CTS, "vdstx_dg_cts_ck",
+			"vdstx_dg_cts_sel", 1, 1),
+	FACTOR(CLK_TOP_PLL_DPIX, "pll_dpix_ck",
+			"pll_dpix_sel", 1, 1),
+	FACTOR(CLK_TOP_ECC, "ecc_ck",
+			"ecc_sel", 1, 1),
+	FACTOR(CLK_TOP_USB_FRMCNT_CK_P0, "ssusb_frmcnt_p0",
+			"univpll_192m_d4", 1, 1),
+	FACTOR(CLK_TOP_USB_FRMCNT_CK_P1, "ssusb_frmcnt_p1",
+			"univpll_192m_d4", 1, 1),
+	FACTOR(CLK_TOP_USB_FRMCNT_CK_P2, "ssusb_frmcnt_p2",
+			"univpll_192m_d4", 1, 1),
+	FACTOR(CLK_TOP_USB_FRMCNT_CK_P3, "ssusb_frmcnt_p3",
+			"univpll_192m_d4", 1, 1),
+	FACTOR(CLK_TOP_USB_FRMCNT_CK_P4, "ssusb_frmcnt_p4",
+			"univpll_192m_d4", 1, 1),
+};
+
+static const char * const vlp_scp_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d4",
+	"univpll_d3",
+	"mainpll_d3",
+	"univpll_d6",
+	"apll1_ck",
+	"mainpll_d4",
+	"mainpll_d6",
+	"mainpll_d7",
+	"osc_d10"
+};
+
+static const char * const vlp_pwrap_ulposc_parents[] = {
+	"tck_26m_mx9_ck",
+	"osc_d10",
+	"osc_d7",
+	"osc_d8",
+	"osc_d16",
+	"mainpll_d7_d8"
+};
+
+static const char * const vlp_spmi_p_parents[] = {
+	"tck_26m_mx9_ck",
+	"f26m_d2",
+	"osc_d8",
+	"osc_d10",
+	"osc_d16",
+	"osc_d7",
+	"clkrtc",
+	"mainpll_d7_d8",
+	"mainpll_d6_d8",
+	"mainpll_d5_d8"
+};
+
+static const char * const vlp_dvfsrc_parents[] = {
+	"tck_26m_mx9_ck",
+	"osc_d10"
+};
+
+static const char * const vlp_pwm_vlp_parents[] = {
+	"tck_26m_mx9_ck",
+	"osc_d4",
+	"clkrtc",
+	"osc_d10",
+	"mainpll_d4_d8"
+};
+
+static const char * const vlp_axi_vlp_parents[] = {
+	"tck_26m_mx9_ck",
+	"osc_d10",
+	"osc_d2",
+	"mainpll_d7_d4",
+	"mainpll_d7_d2"
+};
+
+static const char * const vlp_systimer_26m_parents[] = {
+	"tck_26m_mx9_ck",
+	"osc_d10"
+};
+
+static const char * const vlp_sspm_parents[] = {
+	"tck_26m_mx9_ck",
+	"osc_d10",
+	"mainpll_d5_d2",
+	"osc_ck",
+	"mainpll_d6"
+};
+
+static const char * const vlp_sspm_f26m_parents[] = {
+	"tck_26m_mx9_ck",
+	"osc_d10"
+};
+
+static const char * const vlp_srck_parents[] = {
+	"tck_26m_mx9_ck",
+	"osc_d10"
+};
+
+static const char * const vlp_scp_spi_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d5_d4",
+	"mainpll_d7_d2",
+	"osc_d10"
+};
+
+static const char * const vlp_scp_iic_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d5_d4",
+	"mainpll_d7_d2",
+	"osc_d10"
+};
+
+static const char * const vlp_scp_spi_hs_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d5_d4",
+	"mainpll_d7_d2",
+	"osc_d10"
+};
+
+static const char * const vlp_scp_iic_hs_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d5_d4",
+	"mainpll_d7_d2",
+	"osc_d10"
+};
+
+static const char * const vlp_sspm_ulposc_parents[] = {
+	"osc_ck",
+	"univpll_d5_d2",
+	"osc_d10"
+};
+
+static const char * const vlp_apxgpt_26m_parents[] = {
+	"tck_26m_mx9_ck",
+	"osc_d10"
+};
+
+static const char * const vlp_vadsp_parents[] = {
+	"tck_26m_mx9_ck",
+	"osc_d20",
+	"osc_d10",
+	"osc_d2",
+	"osc_ck",
+	"mainpll_d4_d2"
+};
+
+static const char * const vlp_vadsp_vowpll_parents[] = {
+	"tck_26m_mx9_ck",
+	"vowpll_ck"
+};
+
+static const char * const vlp_vadsp_uarthub_b_parents[] = {
+	"tck_26m_mx9_ck",
+	"osc_d10",
+	"univpll_d6_d4",
+	"univpll_d6_d2"
+};
+
+static const char * const vlp_camtg0_parents[] = {
+	"tck_26m_mx9_ck",
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
+static const char * const vlp_camtg1_parents[] = {
+	"tck_26m_mx9_ck",
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
+static const char * const vlp_camtg2_parents[] = {
+	"tck_26m_mx9_ck",
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
+static const char * const vlp_aud_adc_parents[] = {
+	"tck_26m_mx9_ck",
+	"vowpll_ck",
+	"aud_adc_ext_ck",
+	"osc_d10"
+};
+
+static const char * const vlp_kp_irq_gen_parents[] = {
+	"tck_26m_mx9_ck",
+	"osc_d10",
+	"osc_d2",
+	"mainpll_d7_d4",
+	"mainpll_d7_d2"
+};
+
+static const struct mtk_mux vlp_ck_muxes[] = {
+#if MT_CCF_MUX_DISABLE
+	/* VLP_CLK_CFG_0 */
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_SEL/* dts */, "vlp_scp_sel",
+		vlp_scp_parents/* parent */, VLP_CLK_CFG_0, VLP_CLK_CFG_0_SET,
+		VLP_CLK_CFG_0_CLR/* set parent */, 0/* lsb */, 4/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SCP_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_PWRAP_ULPOSC_SEL/* dts */, "vlp_pwrap_ulposc_sel",
+		vlp_pwrap_ulposc_parents/* parent */, VLP_CLK_CFG_0, VLP_CLK_CFG_0_SET,
+		VLP_CLK_CFG_0_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_PWRAP_ULPOSC_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SPMI_P_MST_SEL/* dts */, "vlp_spmi_p_sel",
+		vlp_spmi_p_parents/* parent */, VLP_CLK_CFG_0, VLP_CLK_CFG_0_SET,
+		VLP_CLK_CFG_0_CLR/* set parent */, 16/* lsb */, 4/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SPMI_P_MST_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_DVFSRC_SEL/* dts */, "vlp_dvfsrc_sel",
+		vlp_dvfsrc_parents/* parent */, VLP_CLK_CFG_0, VLP_CLK_CFG_0_SET,
+		VLP_CLK_CFG_0_CLR/* set parent */, 24/* lsb */, 1/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_DVFSRC_SHIFT/* upd shift */),
+	/* VLP_CLK_CFG_1 */
+	MUX_CLR_SET_UPD(CLK_VLP_CK_PWM_VLP_SEL/* dts */, "vlp_pwm_vlp_sel",
+		vlp_pwm_vlp_parents/* parent */, VLP_CLK_CFG_1, VLP_CLK_CFG_1_SET,
+		VLP_CLK_CFG_1_CLR/* set parent */, 0/* lsb */, 3/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_PWM_VLP_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_AXI_VLP_SEL/* dts */, "vlp_axi_vlp_sel",
+		vlp_axi_vlp_parents/* parent */, VLP_CLK_CFG_1, VLP_CLK_CFG_1_SET,
+		VLP_CLK_CFG_1_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_AXI_VLP_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SYSTIMER_26M_SEL/* dts */, "vlp_systimer_26m_sel",
+		vlp_systimer_26m_parents/* parent */, VLP_CLK_CFG_1, VLP_CLK_CFG_1_SET,
+		VLP_CLK_CFG_1_CLR/* set parent */, 16/* lsb */, 1/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SYSTIMER_26M_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SSPM_SEL/* dts */, "vlp_sspm_sel",
+		vlp_sspm_parents/* parent */, VLP_CLK_CFG_1, VLP_CLK_CFG_1_SET,
+		VLP_CLK_CFG_1_CLR/* set parent */, 24/* lsb */, 3/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SSPM_SHIFT/* upd shift */),
+	/* VLP_CLK_CFG_2 */
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SSPM_F26M_SEL/* dts */, "vlp_sspm_f26m_sel",
+		vlp_sspm_f26m_parents/* parent */, VLP_CLK_CFG_2, VLP_CLK_CFG_2_SET,
+		VLP_CLK_CFG_2_CLR/* set parent */, 0/* lsb */, 1/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SSPM_F26M_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SRCK_SEL/* dts */, "vlp_srck_sel",
+		vlp_srck_parents/* parent */, VLP_CLK_CFG_2, VLP_CLK_CFG_2_SET,
+		VLP_CLK_CFG_2_CLR/* set parent */, 8/* lsb */, 1/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SRCK_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_SPI_SEL/* dts */, "vlp_scp_spi_sel",
+		vlp_scp_spi_parents/* parent */, VLP_CLK_CFG_2, VLP_CLK_CFG_2_SET,
+		VLP_CLK_CFG_2_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SCP_SPI_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_IIC_SEL/* dts */, "vlp_scp_iic_sel",
+		vlp_scp_iic_parents/* parent */, VLP_CLK_CFG_2, VLP_CLK_CFG_2_SET,
+		VLP_CLK_CFG_2_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SCP_IIC_SHIFT/* upd shift */),
+	/* VLP_CLK_CFG_3 */
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_SPI_HIGH_SPD_SEL/* dts */, "vlp_scp_spi_hs_sel",
+		vlp_scp_spi_hs_parents/* parent */, VLP_CLK_CFG_3, VLP_CLK_CFG_3_SET,
+		VLP_CLK_CFG_3_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SCP_SPI_HIGH_SPD_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_IIC_HIGH_SPD_SEL/* dts */, "vlp_scp_iic_hs_sel",
+		vlp_scp_iic_hs_parents/* parent */, VLP_CLK_CFG_3, VLP_CLK_CFG_3_SET,
+		VLP_CLK_CFG_3_CLR/* set parent */, 8/* lsb */, 2/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SCP_IIC_HIGH_SPD_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SSPM_ULPOSC_SEL/* dts */, "vlp_sspm_ulposc_sel",
+		vlp_sspm_ulposc_parents/* parent */, VLP_CLK_CFG_3, VLP_CLK_CFG_3_SET,
+		VLP_CLK_CFG_3_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SSPM_ULPOSC_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_APXGPT_26M_SEL/* dts */, "vlp_apxgpt_26m_sel",
+		vlp_apxgpt_26m_parents/* parent */, VLP_CLK_CFG_3, VLP_CLK_CFG_3_SET,
+		VLP_CLK_CFG_3_CLR/* set parent */, 24/* lsb */, 1/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_APXGPT_26M_SHIFT/* upd shift */),
+	/* VLP_CLK_CFG_4 */
+	MUX_CLR_SET_UPD(CLK_VLP_CK_VADSP_SEL/* dts */, "vlp_vadsp_sel",
+		vlp_vadsp_parents/* parent */, VLP_CLK_CFG_4, VLP_CLK_CFG_4_SET,
+		VLP_CLK_CFG_4_CLR/* set parent */, 0/* lsb */, 3/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_VADSP_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_VADSP_VOWPLL_SEL/* dts */, "vlp_vadsp_vowpll_sel",
+		vlp_vadsp_vowpll_parents/* parent */, VLP_CLK_CFG_4, VLP_CLK_CFG_4_SET,
+		VLP_CLK_CFG_4_CLR/* set parent */, 8/* lsb */, 1/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_VADSP_VOWPLL_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_VADSP_UARTHUB_BCLK_SEL/* dts */, "vlp_vadsp_uarthub_b_sel",
+		vlp_vadsp_uarthub_b_parents/* parent */, VLP_CLK_CFG_4, VLP_CLK_CFG_4_SET,
+		VLP_CLK_CFG_4_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_VADSP_UARTHUB_BCLK_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_CAMTG0_SEL/* dts */, "vlp_camtg0_sel",
+		vlp_camtg0_parents/* parent */, VLP_CLK_CFG_4, VLP_CLK_CFG_4_SET,
+		VLP_CLK_CFG_4_CLR/* set parent */, 24/* lsb */, 4/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_CAMTG0_SHIFT/* upd shift */),
+	/* VLP_CLK_CFG_5 */
+	MUX_CLR_SET_UPD(CLK_VLP_CK_CAMTG1_SEL/* dts */, "vlp_camtg1_sel",
+		vlp_camtg1_parents/* parent */, VLP_CLK_CFG_5, VLP_CLK_CFG_5_SET,
+		VLP_CLK_CFG_5_CLR/* set parent */, 0/* lsb */, 4/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_CAMTG1_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_CAMTG2_SEL/* dts */, "vlp_camtg2_sel",
+		vlp_camtg2_parents/* parent */, VLP_CLK_CFG_5, VLP_CLK_CFG_5_SET,
+		VLP_CLK_CFG_5_CLR/* set parent */, 8/* lsb */, 4/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_CAMTG2_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_AUD_ADC_SEL/* dts */, "vlp_aud_adc_sel",
+		vlp_aud_adc_parents/* parent */, VLP_CLK_CFG_5, VLP_CLK_CFG_5_SET,
+		VLP_CLK_CFG_5_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_AUD_ADC_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_KP_IRQ_GEN_SEL/* dts */, "vlp_kp_irq_gen_sel",
+		vlp_kp_irq_gen_parents/* parent */, VLP_CLK_CFG_5, VLP_CLK_CFG_5_SET,
+		VLP_CLK_CFG_5_CLR/* set parent */, 24/* lsb */, 3/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_KP_IRQ_GEN_SHIFT/* upd shift */),
+#else
+	/* VLP_CLK_CFG_0 */
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_SCP_SEL/* dts */, "vlp_scp_sel",
+		vlp_scp_parents/* parent */, VLP_CLK_CFG_0, VLP_CLK_CFG_0_SET,
+		VLP_CLK_CFG_0_CLR/* set parent */, 0/* lsb */, 4/* width */,
+		7/* pdn */, VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SCP_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_PWRAP_ULPOSC_SEL/* dts */, "vlp_pwrap_ulposc_sel",
+		vlp_pwrap_ulposc_parents/* parent */, VLP_CLK_CFG_0, VLP_CLK_CFG_0_SET,
+		VLP_CLK_CFG_0_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_PWRAP_ULPOSC_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SPMI_P_MST_SEL/* dts */, "vlp_spmi_p_sel",
+		vlp_spmi_p_parents/* parent */, VLP_CLK_CFG_0, VLP_CLK_CFG_0_SET,
+		VLP_CLK_CFG_0_CLR/* set parent */, 16/* lsb */, 4/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SPMI_P_MST_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_DVFSRC_SEL/* dts */, "vlp_dvfsrc_sel",
+		vlp_dvfsrc_parents/* parent */, VLP_CLK_CFG_0, VLP_CLK_CFG_0_SET,
+		VLP_CLK_CFG_0_CLR/* set parent */, 24/* lsb */, 1/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_DVFSRC_SHIFT/* upd shift */),
+	/* VLP_CLK_CFG_1 */
+	MUX_CLR_SET_UPD(CLK_VLP_CK_PWM_VLP_SEL/* dts */, "vlp_pwm_vlp_sel",
+		vlp_pwm_vlp_parents/* parent */, VLP_CLK_CFG_1, VLP_CLK_CFG_1_SET,
+		VLP_CLK_CFG_1_CLR/* set parent */, 0/* lsb */, 3/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_PWM_VLP_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_AXI_VLP_SEL/* dts */, "vlp_axi_vlp_sel",
+		vlp_axi_vlp_parents/* parent */, VLP_CLK_CFG_1, VLP_CLK_CFG_1_SET,
+		VLP_CLK_CFG_1_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_AXI_VLP_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SYSTIMER_26M_SEL/* dts */, "vlp_systimer_26m_sel",
+		vlp_systimer_26m_parents/* parent */, VLP_CLK_CFG_1, VLP_CLK_CFG_1_SET,
+		VLP_CLK_CFG_1_CLR/* set parent */, 16/* lsb */, 1/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SYSTIMER_26M_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SSPM_SEL/* dts */, "vlp_sspm_sel",
+		vlp_sspm_parents/* parent */, VLP_CLK_CFG_1, VLP_CLK_CFG_1_SET,
+		VLP_CLK_CFG_1_CLR/* set parent */, 24/* lsb */, 3/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SSPM_SHIFT/* upd shift */),
+	/* VLP_CLK_CFG_2 */
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SSPM_F26M_SEL/* dts */, "vlp_sspm_f26m_sel",
+		vlp_sspm_f26m_parents/* parent */, VLP_CLK_CFG_2, VLP_CLK_CFG_2_SET,
+		VLP_CLK_CFG_2_CLR/* set parent */, 0/* lsb */, 1/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SSPM_F26M_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SRCK_SEL/* dts */, "vlp_srck_sel",
+		vlp_srck_parents/* parent */, VLP_CLK_CFG_2, VLP_CLK_CFG_2_SET,
+		VLP_CLK_CFG_2_CLR/* set parent */, 8/* lsb */, 1/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SRCK_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_SPI_SEL/* dts */, "vlp_scp_spi_sel",
+		vlp_scp_spi_parents/* parent */, VLP_CLK_CFG_2, VLP_CLK_CFG_2_SET,
+		VLP_CLK_CFG_2_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SCP_SPI_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_IIC_SEL/* dts */, "vlp_scp_iic_sel",
+		vlp_scp_iic_parents/* parent */, VLP_CLK_CFG_2, VLP_CLK_CFG_2_SET,
+		VLP_CLK_CFG_2_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SCP_IIC_SHIFT/* upd shift */),
+	/* VLP_CLK_CFG_3 */
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_SPI_HIGH_SPD_SEL/* dts */, "vlp_scp_spi_hs_sel",
+		vlp_scp_spi_hs_parents/* parent */, VLP_CLK_CFG_3, VLP_CLK_CFG_3_SET,
+		VLP_CLK_CFG_3_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SCP_SPI_HIGH_SPD_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_IIC_HIGH_SPD_SEL/* dts */, "vlp_scp_iic_hs_sel",
+		vlp_scp_iic_hs_parents/* parent */, VLP_CLK_CFG_3, VLP_CLK_CFG_3_SET,
+		VLP_CLK_CFG_3_CLR/* set parent */, 8/* lsb */, 2/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SCP_IIC_HIGH_SPD_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SSPM_ULPOSC_SEL/* dts */, "vlp_sspm_ulposc_sel",
+		vlp_sspm_ulposc_parents/* parent */, VLP_CLK_CFG_3, VLP_CLK_CFG_3_SET,
+		VLP_CLK_CFG_3_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SSPM_ULPOSC_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_APXGPT_26M_SEL/* dts */, "vlp_apxgpt_26m_sel",
+		vlp_apxgpt_26m_parents/* parent */, VLP_CLK_CFG_3, VLP_CLK_CFG_3_SET,
+		VLP_CLK_CFG_3_CLR/* set parent */, 24/* lsb */, 1/* width */,
+		VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_APXGPT_26M_SHIFT/* upd shift */),
+	/* VLP_CLK_CFG_4 */
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_VADSP_SEL/* dts */, "vlp_vadsp_sel",
+		vlp_vadsp_parents/* parent */, VLP_CLK_CFG_4, VLP_CLK_CFG_4_SET,
+		VLP_CLK_CFG_4_CLR/* set parent */, 0/* lsb */, 3/* width */,
+		7/* pdn */, VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_VADSP_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_VADSP_VOWPLL_SEL/* dts */, "vlp_vadsp_vowpll_sel",
+		vlp_vadsp_vowpll_parents/* parent */, VLP_CLK_CFG_4, VLP_CLK_CFG_4_SET,
+		VLP_CLK_CFG_4_CLR/* set parent */, 8/* lsb */, 1/* width */,
+		15/* pdn */, VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_VADSP_VOWPLL_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_VADSP_UARTHUB_BCLK_SEL/* dts */, "vlp_vadsp_uarthub_b_sel",
+		vlp_vadsp_uarthub_b_parents/* parent */, VLP_CLK_CFG_4, VLP_CLK_CFG_4_SET,
+		VLP_CLK_CFG_4_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		23/* pdn */, VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_VADSP_UARTHUB_BCLK_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_CAMTG0_SEL/* dts */, "vlp_camtg0_sel",
+		vlp_camtg0_parents/* parent */, VLP_CLK_CFG_4, VLP_CLK_CFG_4_SET,
+		VLP_CLK_CFG_4_CLR/* set parent */, 24/* lsb */, 4/* width */,
+		31/* pdn */, VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_CAMTG0_SHIFT/* upd shift */),
+	/* VLP_CLK_CFG_5 */
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_CAMTG1_SEL/* dts */, "vlp_camtg1_sel",
+		vlp_camtg1_parents/* parent */, VLP_CLK_CFG_5, VLP_CLK_CFG_5_SET,
+		VLP_CLK_CFG_5_CLR/* set parent */, 0/* lsb */, 4/* width */,
+		7/* pdn */, VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_CAMTG1_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_CAMTG2_SEL/* dts */, "vlp_camtg2_sel",
+		vlp_camtg2_parents/* parent */, VLP_CLK_CFG_5, VLP_CLK_CFG_5_SET,
+		VLP_CLK_CFG_5_CLR/* set parent */, 8/* lsb */, 4/* width */,
+		15/* pdn */, VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_CAMTG2_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_AUD_ADC_SEL/* dts */, "vlp_aud_adc_sel",
+		vlp_aud_adc_parents/* parent */, VLP_CLK_CFG_5, VLP_CLK_CFG_5_SET,
+		VLP_CLK_CFG_5_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		23/* pdn */, VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_AUD_ADC_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_KP_IRQ_GEN_SEL/* dts */, "vlp_kp_irq_gen_sel",
+		vlp_kp_irq_gen_parents/* parent */, VLP_CLK_CFG_5, VLP_CLK_CFG_5_SET,
+		VLP_CLK_CFG_5_CLR/* set parent */, 24/* lsb */, 3/* width */,
+		31/* pdn */, VLP_CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_KP_IRQ_GEN_SHIFT/* upd shift */),
+#endif
+};
+
+static const char * const axi_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d4_d4",
+	"mainpll_d7_d2",
+	"mainpll_d4_d2",
+	"mainpll_d5_d2",
+	"mainpll_d6_d2",
+	"osc_d4"
+};
+
+static const char * const axi_peri_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d4_d4",
+	"mainpll_d7_d2",
+	"osc_d4"
+};
+
+static const char * const axi_u_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d4_d8",
+	"mainpll_d7_d4",
+	"osc_d8"
+};
+
+static const char * const bus_aximem_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d7_d2",
+	"mainpll_d5_d2",
+	"mainpll_d4_d2",
+	"mainpll_d6"
+};
+
+static const char * const disp0_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d5_d2",
+	"univpll_d5_d2",
+	"mainpll_d4_d2",
+	"univpll_d4_d2",
+	"mainpll_d6",
+	"univpll_d6",
+	"mmpll_d6",
+	"tvdpll1_ck",
+	"tvdpll2_ck",
+	"univpll_d4",
+	"mmpll_d4"
+};
+
+static const char * const mminfra_parents[] = {
+	"tck_26m_mx9_ck",
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
+	"emipll_ck"
+};
+
+static const char * const uart_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d6_d8"
+};
+
+static const char * const spi0_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d6_d2",
+	"univpll_192m_ck",
+	"mainpll_d6_d2",
+	"univpll_d4_d4",
+	"mainpll_d4_d4",
+	"univpll_d5_d4",
+	"univpll_d6_d4"
+};
+
+static const char * const spi1_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d6_d2",
+	"univpll_192m_ck",
+	"mainpll_d6_d2",
+	"univpll_d4_d4",
+	"mainpll_d4_d4",
+	"univpll_d5_d4",
+	"univpll_d6_d4"
+};
+
+static const char * const spi2_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d6_d2",
+	"univpll_192m_ck",
+	"mainpll_d6_d2",
+	"univpll_d4_d4",
+	"mainpll_d4_d4",
+	"univpll_d5_d4",
+	"univpll_d6_d4"
+};
+
+static const char * const spi3_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d6_d2",
+	"univpll_192m_ck",
+	"mainpll_d6_d2",
+	"univpll_d4_d4",
+	"mainpll_d4_d4",
+	"univpll_d5_d4",
+	"univpll_d6_d4"
+};
+
+static const char * const spi4_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d6_d2",
+	"univpll_192m_ck",
+	"mainpll_d6_d2",
+	"univpll_d4_d4",
+	"mainpll_d4_d4",
+	"univpll_d5_d4",
+	"univpll_d6_d4"
+};
+
+static const char * const spi5_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d6_d2",
+	"univpll_192m_ck",
+	"mainpll_d6_d2",
+	"univpll_d4_d4",
+	"mainpll_d4_d4",
+	"univpll_d5_d4",
+	"univpll_d6_d4"
+};
+
+static const char * const msdc_macro_0p_parents[] = {
+	"tck_26m_mx9_ck",
+	"msdcpll_ck",
+	"mmpll_d5_d4",
+	"univpll_d4_d2"
+};
+
+static const char * const msdc5hclk_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d4_d2",
+	"mainpll_d6_d2"
+};
+
+static const char * const msdc50_0_parents[] = {
+	"tck_26m_mx9_ck",
+	"msdcpll_ck",
+	"msdcpll_d2",
+	"mainpll_d6_d2",
+	"mainpll_d4_d4",
+	"mainpll_d6",
+	"univpll_d4_d4"
+};
+
+static const char * const aes_msdcfde_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d4_d2",
+	"mainpll_d6",
+	"mainpll_d4_d4",
+	"msdcpll_ck"
+};
+
+static const char * const msdc_macro_1p_parents[] = {
+	"tck_26m_mx9_ck",
+	"msdcpll_ck",
+	"mmpll_d5_d4",
+	"univpll_d4_d2"
+};
+
+static const char * const msdc30_1_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d6_d2",
+	"mainpll_d6_d2",
+	"mainpll_d7_d2",
+	"msdcpll_d2"
+};
+
+static const char * const msdc30_1_h_parents[] = {
+	"tck_26m_mx9_ck",
+	"msdcpll_d2",
+	"mainpll_d4_d4",
+	"mainpll_d6_d4"
+};
+
+static const char * const msdc_macro_2p_parents[] = {
+	"tck_26m_mx9_ck",
+	"msdcpll_ck",
+	"mmpll_d5_d4",
+	"univpll_d4_d2"
+};
+
+static const char * const msdc30_2_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d6_d2",
+	"mainpll_d6_d2",
+	"mainpll_d7_d2",
+	"msdcpll_d2"
+};
+
+static const char * const msdc30_2_h_parents[] = {
+	"tck_26m_mx9_ck",
+	"msdcpll_d2",
+	"mainpll_d4_d4",
+	"mainpll_d6_d4"
+};
+
+static const char * const aud_intbus_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d4_d4",
+	"mainpll_d7_d4"
+};
+
+static const char * const atb_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d4_d2",
+	"mainpll_d5_d2"
+};
+
+static const char * const disp_pwm_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d6_d4",
+	"osc_d2",
+	"osc_d4",
+	"osc_d16",
+	"univpll_d5_d4",
+	"mainpll_d4_d4"
+};
+
+static const char * const usb_p0_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d5_d4",
+	"univpll_d6_d4"
+};
+
+static const char * const ssusb_xhci_p0_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d5_d4",
+	"univpll_d6_d4"
+};
+
+static const char * const usb_p1_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d5_d4",
+	"univpll_d6_d4"
+};
+
+static const char * const ssusb_xhci_p1_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d5_d4",
+	"univpll_d6_d4"
+};
+
+static const char * const usb_p2_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d5_d4",
+	"univpll_d6_d4"
+};
+
+static const char * const ssusb_xhci_p2_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d5_d4",
+	"univpll_d6_d4"
+};
+
+static const char * const usb_p3_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d5_d4",
+	"univpll_d6_d4"
+};
+
+static const char * const ssusb_xhci_p3_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d5_d4",
+	"univpll_d6_d4"
+};
+
+static const char * const usb_p4_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d5_d4",
+	"univpll_d6_d4"
+};
+
+static const char * const ssusb_xhci_p4_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d5_d4",
+	"univpll_d6_d4"
+};
+
+static const char * const i2c_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d4_d8",
+	"univpll_d5_d4",
+	"mainpll_d4_d4"
+};
+
+static const char * const seninf_parents[] = {
+	"tck_26m_mx9_ck",
+	"osc_d2",
+	"univpll_d6_d2",
+	"mainpll_d4_d2",
+	"univpll_d4_d2",
+	"mmpll_d7",
+	"univpll_d6",
+	"univpll_d5"
+};
+
+static const char * const seninf1_parents[] = {
+	"tck_26m_mx9_ck",
+	"osc_d2",
+	"univpll_d6_d2",
+	"mainpll_d4_d2",
+	"univpll_d4_d2",
+	"mmpll_d7",
+	"univpll_d6",
+	"univpll_d5"
+};
+
+static const char * const aud_engen1_parents[] = {
+	"tck_26m_mx9_ck",
+	"apll1_d2",
+	"apll1_d4",
+	"apll1_d8"
+};
+
+static const char * const aud_engen2_parents[] = {
+	"tck_26m_mx9_ck",
+	"apll2_d2",
+	"apll2_d4",
+	"apll2_d8"
+};
+
+static const char * const aes_ufsfde_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d4",
+	"mainpll_d4_d2",
+	"mainpll_d6",
+	"mainpll_d4_d4",
+	"univpll_d4_d2",
+	"univpll_d6"
+};
+
+static const char * const ufs_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d4_d8",
+	"mainpll_d4_d4",
+	"mainpll_d5_d2",
+	"mainpll_d6_d2",
+	"univpll_d6_d2",
+	"msdcpll_d2"
+};
+
+static const char * const ufs_mbist_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d4_d2",
+	"univpll_d4_d2",
+	"ufspll_d2"
+};
+
+static const char * const aud_1_parents[] = {
+	"tck_26m_mx9_ck",
+	"apll1_ck"
+};
+
+static const char * const aud_2_parents[] = {
+	"tck_26m_mx9_ck",
+	"apll2_ck"
+};
+
+static const char * const venc_parents[] = {
+	"tck_26m_mx9_ck",
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
+static const char * const vdec_parents[] = {
+	"tck_26m_mx9_ck",
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
+static const char * const pwm_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d4_d8"
+};
+
+static const char * const audio_h_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d7_d2",
+	"apll1_ck",
+	"apll2_ck"
+};
+
+static const char * const mcupm_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d6_d2",
+	"mainpll_d5_d2",
+	"mainpll_d6_d2"
+};
+
+static const char * const mem_sub_parents[] = {
+	"tck_26m_mx9_ck",
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
+static const char * const mem_sub_peri_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d4_d4",
+	"mainpll_d5_d2",
+	"mainpll_d4_d2",
+	"mainpll_d6",
+	"mainpll_d5",
+	"univpll_d5",
+	"mainpll_d4"
+};
+
+static const char * const mem_sub_u_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d4_d4",
+	"mainpll_d5_d2",
+	"mainpll_d4_d2",
+	"mainpll_d6",
+	"mainpll_d5",
+	"univpll_d5",
+	"mainpll_d4"
+};
+
+static const char * const emi_n_parents[] = {
+	"tck_26m_mx9_ck",
+	"osc_d2",
+	"mainpll_d9",
+	"mainpll_d6",
+	"mainpll_d5",
+	"emipll_ck"
+};
+
+static const char * const dsi_occ_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d6_d2",
+	"univpll_d5_d2",
+	"univpll_d4_d2"
+};
+
+static const char * const ap2conn_host_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d7_d4"
+};
+
+static const char * const img1_parents[] = {
+	"tck_26m_mx9_ck",
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
+	"tck_26m_mx9_ck",
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
+static const char * const cam_parents[] = {
+	"tck_26m_mx9_ck",
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
+static const char * const camtm_parents[] = {
+	"tck_26m_mx9_ck",
+	"osc_d2",
+	"univpll_d6_d2",
+	"univpll_d6_d4"
+};
+
+static const char * const dsp_parents[] = {
+	"tck_26m_mx9_ck",
+	"osc_d4",
+	"osc_d3",
+	"osc_d2",
+	"univpll_d7_d2",
+	"univpll_d6_d2",
+	"mainpll_d6",
+	"univpll_d5"
+};
+
+static const char * const sr_pka_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d4_d4",
+	"mainpll_d4_d2",
+	"mainpll_d7",
+	"mainpll_d6",
+	"mainpll_d5"
+};
+
+static const char * const dxcc_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d4_d8",
+	"mainpll_d4_d4",
+	"mainpll_d4_d2"
+};
+
+static const char * const mfg_ref_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d6_d2",
+	"mainpll_d6",
+	"mainpll_d5_d2"
+};
+
+static const char * const mdp0_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d5_d2",
+	"univpll_d5_d2",
+	"mainpll_d4_d2",
+	"univpll_d4_d2",
+	"mainpll_d6",
+	"univpll_d6",
+	"mmpll_d6",
+	"tvdpll1_ck",
+	"tvdpll2_ck",
+	"univpll_d4",
+	"mmpll_d4"
+};
+
+static const char * const dp_parents[] = {
+	"tck_26m_mx9_ck",
+	"tvdpll1_d16",
+	"tvdpll1_d8",
+	"tvdpll1_d4",
+	"tvdpll1_d2"
+};
+
+static const char * const edp_parents[] = {
+	"tck_26m_mx9_ck",
+	"tvdpll2_d16",
+	"tvdpll2_d8",
+	"tvdpll2_d4",
+	"tvdpll2_d2",
+	"apll1_d4",
+	"apll2_d4"
+};
+
+static const char * const edp_favt_parents[] = {
+	"tck_26m_mx9_ck",
+	"tvdpll2_d16",
+	"tvdpll2_d8",
+	"tvdpll2_d4",
+	"tvdpll2_d2",
+	"apll1_d4",
+	"apll2_d4"
+};
+
+static const char * const snps_eth_250m_parents[] = {
+	"tck_26m_mx9_ck",
+	"ethpll_d2"
+};
+
+static const char * const snps_eth_62p4m_ptp_parents[] = {
+	"tck_26m_mx9_ck",
+	"ethpll_d8",
+	"apll1_d3",
+	"apll2_d3"
+};
+
+static const char * const snps_eth_50m_rmii_parents[] = {
+	"tck_26m_mx9_ck",
+	"ethpll_d10"
+};
+
+static const char * const sflash_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d7_d8",
+	"univpll_d6_d8",
+	"mainpll_d7_d4",
+	"mainpll_d6_d4",
+	"univpll_d6_d4",
+	"univpll_d7_d3",
+	"univpll_d5_d4"
+};
+
+static const char * const gcpu_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d6",
+	"mainpll_d4_d2",
+	"univpll_d4_d2",
+	"univpll_d5_d2",
+	"univpll_d5_d4",
+	"univpll_d6"
+};
+
+static const char * const pcie_mac_tl_parents[] = {
+	"tck_26m_mx9_ck",
+	"mainpll_d4_d4",
+	"univpll_d5_d4"
+};
+
+static const char * const vdstx_dg_cts_parents[] = {
+	"tck_26m_mx9_ck",
+	"lvdstx_dg_cts_ck",
+	"univpll_d7_d3"
+};
+
+static const char * const pll_dpix_parents[] = {
+	"tck_26m_mx9_ck",
+	"vpll_dpix_ck",
+	"mmpll_d4_d4"
+};
+
+static const char * const ecc_parents[] = {
+	"tck_26m_mx9_ck",
+	"univpll_d6_d2",
+	"univpll_d4_d2",
+	"univpll_d6",
+	"mainpll_d4",
+	"univpll_d4"
+};
+
+static const char * const apll_i2sin0_m_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const apll_i2sin1_m_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const apll_i2sin2_m_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const apll_i2sin3_m_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const apll_i2sin4_m_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const apll_i2sin6_m_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const apll_i2sout0_m_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const apll_i2sout1_m_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const apll_i2sout2_m_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const apll_i2sout3_m_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const apll_i2sout4_m_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const apll_i2sout6_m_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const apll_fmi2s_m_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const apll_tdmout_m_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const mfg_sel_mfgpll_parents[] = {
+	"mfg_ref_sel",
+	"mfgpll_ck"
+};
+
+static const struct mtk_mux top_muxes[] = {
+#if MT_CCF_MUX_DISABLE
+	/* CLK_CFG_0 */
+	MUX_CLR_SET_UPD(CLK_TOP_AXI_SEL/* dts */, "axi_sel",
+		axi_parents/* parent */, CLK_CFG_0, CLK_CFG_0_SET,
+		CLK_CFG_0_CLR/* set parent */, 0/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_AXI_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_AXI_PERI_SEL/* dts */, "axi_peri_sel",
+		axi_peri_parents/* parent */, CLK_CFG_0, CLK_CFG_0_SET,
+		CLK_CFG_0_CLR/* set parent */, 8/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_AXI_PERI_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_AXI_U_SEL/* dts */, "axi_u_sel",
+		axi_u_parents/* parent */, CLK_CFG_0, CLK_CFG_0_SET,
+		CLK_CFG_0_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_AXI_UFS_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_BUS_AXIMEM_SEL/* dts */, "bus_aximem_sel",
+		bus_aximem_parents/* parent */, CLK_CFG_0, CLK_CFG_0_SET,
+		CLK_CFG_0_CLR/* set parent */, 24/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_BUS_AXIMEM_SHIFT/* upd shift */),
+	/* CLK_CFG_1 */
+	MUX_CLR_SET_UPD(CLK_TOP_DISP0_SEL/* dts */, "disp0_sel",
+		disp0_parents/* parent */, CLK_CFG_1, CLK_CFG_1_SET,
+		CLK_CFG_1_CLR/* set parent */, 0/* lsb */, 4/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_DISP0_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_MMINFRA_SEL/* dts */, "mminfra_sel",
+		mminfra_parents/* parent */, CLK_CFG_1, CLK_CFG_1_SET,
+		CLK_CFG_1_CLR/* set parent */, 8/* lsb */, 4/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_MMINFRA_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_UART_SEL/* dts */, "uart_sel",
+		uart_parents/* parent */, CLK_CFG_1, CLK_CFG_1_SET,
+		CLK_CFG_1_CLR/* set parent */, 16/* lsb */, 1/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_UART_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_SPI0_SEL/* dts */, "spi0_sel",
+		spi0_parents/* parent */, CLK_CFG_1, CLK_CFG_1_SET,
+		CLK_CFG_1_CLR/* set parent */, 24/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SPI0_SHIFT/* upd shift */),
+	/* CLK_CFG_2 */
+	MUX_CLR_SET_UPD(CLK_TOP_SPI1_SEL/* dts */, "spi1_sel",
+		spi1_parents/* parent */, CLK_CFG_2, CLK_CFG_2_SET,
+		CLK_CFG_2_CLR/* set parent */, 0/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SPI1_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_SPI2_SEL/* dts */, "spi2_sel",
+		spi2_parents/* parent */, CLK_CFG_2, CLK_CFG_2_SET,
+		CLK_CFG_2_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SPI2_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_SPI3_SEL/* dts */, "spi3_sel",
+		spi3_parents/* parent */, CLK_CFG_2, CLK_CFG_2_SET,
+		CLK_CFG_2_CLR/* set parent */, 16/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SPI3_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_SPI4_SEL/* dts */, "spi4_sel",
+		spi4_parents/* parent */, CLK_CFG_2, CLK_CFG_2_SET,
+		CLK_CFG_2_CLR/* set parent */, 24/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SPI4_SHIFT/* upd shift */),
+	/* CLK_CFG_3 */
+	MUX_CLR_SET_UPD(CLK_TOP_SPI5_SEL/* dts */, "spi5_sel",
+		spi5_parents/* parent */, CLK_CFG_3, CLK_CFG_3_SET,
+		CLK_CFG_3_CLR/* set parent */, 0/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SPI5_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_MSDC_MACRO_0P_SEL/* dts */, "msdc_macro_0p_sel",
+		msdc_macro_0p_parents/* parent */, CLK_CFG_3, CLK_CFG_3_SET,
+		CLK_CFG_3_CLR/* set parent */, 8/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_MSDC_MACRO_0P_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_MSDC50_0_HCLK_SEL/* dts */, "msdc5hclk_sel",
+		msdc5hclk_parents/* parent */, CLK_CFG_3, CLK_CFG_3_SET,
+		CLK_CFG_3_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_MSDC50_0_HCLK_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_MSDC50_0_SEL/* dts */, "msdc50_0_sel",
+		msdc50_0_parents/* parent */, CLK_CFG_3, CLK_CFG_3_SET,
+		CLK_CFG_3_CLR/* set parent */, 24/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_MSDC50_0_SHIFT/* upd shift */),
+	/* CLK_CFG_4 */
+	MUX_CLR_SET_UPD(CLK_TOP_AES_MSDCFDE_SEL/* dts */, "aes_msdcfde_sel",
+		aes_msdcfde_parents/* parent */, CLK_CFG_4, CLK_CFG_4_SET,
+		CLK_CFG_4_CLR/* set parent */, 0/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_AES_MSDCFDE_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_MSDC_MACRO_1P_SEL/* dts */, "msdc_macro_1p_sel",
+		msdc_macro_1p_parents/* parent */, CLK_CFG_4, CLK_CFG_4_SET,
+		CLK_CFG_4_CLR/* set parent */, 8/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_MSDC_MACRO_1P_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_MSDC30_1_SEL/* dts */, "msdc30_1_sel",
+		msdc30_1_parents/* parent */, CLK_CFG_4, CLK_CFG_4_SET,
+		CLK_CFG_4_CLR/* set parent */, 16/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_MSDC30_1_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_MSDC30_1_HCLK_SEL/* dts */, "msdc30_1_h_sel",
+		msdc30_1_h_parents/* parent */, CLK_CFG_4, CLK_CFG_4_SET,
+		CLK_CFG_4_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_MSDC30_1_HCLK_SHIFT/* upd shift */),
+	/* CLK_CFG_5 */
+	MUX_CLR_SET_UPD(CLK_TOP_MSDC_MACRO_2P_SEL/* dts */, "msdc_macro_2p_sel",
+		msdc_macro_2p_parents/* parent */, CLK_CFG_5, CLK_CFG_5_SET,
+		CLK_CFG_5_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_MSDC_MACRO_2P_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_MSDC30_2_SEL/* dts */, "msdc30_2_sel",
+		msdc30_2_parents/* parent */, CLK_CFG_5, CLK_CFG_5_SET,
+		CLK_CFG_5_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_MSDC30_2_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_MSDC30_2_HCLK_SEL/* dts */, "msdc30_2_h_sel",
+		msdc30_2_h_parents/* parent */, CLK_CFG_5, CLK_CFG_5_SET,
+		CLK_CFG_5_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_MSDC30_2_HCLK_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_AUD_INTBUS_SEL/* dts */, "aud_intbus_sel",
+		aud_intbus_parents/* parent */, CLK_CFG_5, CLK_CFG_5_SET,
+		CLK_CFG_5_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_AUD_INTBUS_SHIFT/* upd shift */),
+	/* CLK_CFG_6 */
+	MUX_CLR_SET_UPD(CLK_TOP_ATB_SEL/* dts */, "atb_sel",
+		atb_parents/* parent */, CLK_CFG_6, CLK_CFG_6_SET,
+		CLK_CFG_6_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_ATB_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_DISP_PWM_SEL/* dts */, "disp_pwm_sel",
+		disp_pwm_parents/* parent */, CLK_CFG_6, CLK_CFG_6_SET,
+		CLK_CFG_6_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_DISP_PWM_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_USB_TOP_P0_SEL/* dts */, "usb_p0_sel",
+		usb_p0_parents/* parent */, CLK_CFG_6, CLK_CFG_6_SET,
+		CLK_CFG_6_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_USB_TOP_P0_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_USB_XHCI_P0_SEL/* dts */, "ssusb_xhci_p0_sel",
+		ssusb_xhci_p0_parents/* parent */, CLK_CFG_6, CLK_CFG_6_SET,
+		CLK_CFG_6_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SSUSB_XHCI_P0_SHIFT/* upd shift */),
+	/* CLK_CFG_7 */
+	MUX_CLR_SET_UPD(CLK_TOP_USB_TOP_P1_SEL/* dts */, "usb_p1_sel",
+		usb_p1_parents/* parent */, CLK_CFG_7, CLK_CFG_7_SET,
+		CLK_CFG_7_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_USB_TOP_P1_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_USB_XHCI_P1_SEL/* dts */, "ssusb_xhci_p1_sel",
+		ssusb_xhci_p1_parents/* parent */, CLK_CFG_7, CLK_CFG_7_SET,
+		CLK_CFG_7_CLR/* set parent */, 8/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_SSUSB_XHCI_P1_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_USB_TOP_P2_SEL/* dts */, "usb_p2_sel",
+		usb_p2_parents/* parent */, CLK_CFG_7, CLK_CFG_7_SET,
+		CLK_CFG_7_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_USB_TOP_P2_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_USB_XHCI_P2_SEL/* dts */, "ssusb_xhci_p2_sel",
+		ssusb_xhci_p2_parents/* parent */, CLK_CFG_7, CLK_CFG_7_SET,
+		CLK_CFG_7_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_SSUSB_XHCI_P2_SHIFT/* upd shift */),
+	/* CLK_CFG_8 */
+	MUX_CLR_SET_UPD(CLK_TOP_USB_TOP_P3_SEL/* dts */, "usb_p3_sel",
+		usb_p3_parents/* parent */, CLK_CFG_8, CLK_CFG_8_SET,
+		CLK_CFG_8_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_USB_TOP_P3_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_USB_XHCI_P3_SEL/* dts */, "ssusb_xhci_p3_sel",
+		ssusb_xhci_p3_parents/* parent */, CLK_CFG_8, CLK_CFG_8_SET,
+		CLK_CFG_8_CLR/* set parent */, 8/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_SSUSB_XHCI_P3_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_USB_TOP_P4_SEL/* dts */, "usb_p4_sel",
+		usb_p4_parents/* parent */, CLK_CFG_8, CLK_CFG_8_SET,
+		CLK_CFG_8_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_USB_TOP_P4_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_USB_XHCI_P4_SEL/* dts */, "ssusb_xhci_p4_sel",
+		ssusb_xhci_p4_parents/* parent */, CLK_CFG_8, CLK_CFG_8_SET,
+		CLK_CFG_8_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_SSUSB_XHCI_P4_SHIFT/* upd shift */),
+	/* CLK_CFG_9 */
+	MUX_CLR_SET_UPD(CLK_TOP_I2C_SEL/* dts */, "i2c_sel",
+		i2c_parents/* parent */, CLK_CFG_9, CLK_CFG_9_SET,
+		CLK_CFG_9_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_I2C_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_SENINF_SEL/* dts */, "seninf_sel",
+		seninf_parents/* parent */, CLK_CFG_9, CLK_CFG_9_SET,
+		CLK_CFG_9_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_SENINF_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_SENINF1_SEL/* dts */, "seninf1_sel",
+		seninf1_parents/* parent */, CLK_CFG_9, CLK_CFG_9_SET,
+		CLK_CFG_9_CLR/* set parent */, 16/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_SENINF1_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_AUD_ENGEN1_SEL/* dts */, "aud_engen1_sel",
+		aud_engen1_parents/* parent */, CLK_CFG_9, CLK_CFG_9_SET,
+		CLK_CFG_9_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_AUD_ENGEN1_SHIFT/* upd shift */),
+	/* CLK_CFG_10 */
+	MUX_CLR_SET_UPD(CLK_TOP_AUD_ENGEN2_SEL/* dts */, "aud_engen2_sel",
+		aud_engen2_parents/* parent */, CLK_CFG_10, CLK_CFG_10_SET,
+		CLK_CFG_10_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_AUD_ENGEN2_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_AES_UFSFDE_SEL/* dts */, "aes_ufsfde_sel",
+		aes_ufsfde_parents/* parent */, CLK_CFG_10, CLK_CFG_10_SET,
+		CLK_CFG_10_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_AES_UFSFDE_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_U_SEL/* dts */, "ufs_sel",
+		ufs_parents/* parent */, CLK_CFG_10, CLK_CFG_10_SET,
+		CLK_CFG_10_CLR/* set parent */, 16/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_UFS_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_U_MBIST_SEL/* dts */, "ufs_mbist_sel",
+		ufs_mbist_parents/* parent */, CLK_CFG_10, CLK_CFG_10_SET,
+		CLK_CFG_10_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_UFS_MBIST_SHIFT/* upd shift */),
+	/* CLK_CFG_11 */
+	MUX_CLR_SET_UPD(CLK_TOP_AUD_1_SEL/* dts */, "aud_1_sel",
+		aud_1_parents/* parent */, CLK_CFG_11, CLK_CFG_11_SET,
+		CLK_CFG_11_CLR/* set parent */, 0/* lsb */, 1/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_AUD_1_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_AUD_2_SEL/* dts */, "aud_2_sel",
+		aud_2_parents/* parent */, CLK_CFG_11, CLK_CFG_11_SET,
+		CLK_CFG_11_CLR/* set parent */, 8/* lsb */, 1/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_AUD_2_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_VENC_SEL/* dts */, "venc_sel",
+		venc_parents/* parent */, CLK_CFG_11, CLK_CFG_11_SET,
+		CLK_CFG_11_CLR/* set parent */, 16/* lsb */, 4/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_VENC_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_VDEC_SEL/* dts */, "vdec_sel",
+		vdec_parents/* parent */, CLK_CFG_11, CLK_CFG_11_SET,
+		CLK_CFG_11_CLR/* set parent */, 24/* lsb */, 4/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_VDEC_SHIFT/* upd shift */),
+	/* CLK_CFG_12 */
+	MUX_CLR_SET_UPD(CLK_TOP_PWM_SEL/* dts */, "pwm_sel",
+		pwm_parents/* parent */, CLK_CFG_12, CLK_CFG_12_SET,
+		CLK_CFG_12_CLR/* set parent */, 0/* lsb */, 1/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_PWM_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_AUDIO_H_SEL/* dts */, "audio_h_sel",
+		audio_h_parents/* parent */, CLK_CFG_12, CLK_CFG_12_SET,
+		CLK_CFG_12_CLR/* set parent */, 8/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_AUDIO_H_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_MCUPM_SEL/* dts */, "mcupm_sel",
+		mcupm_parents/* parent */, CLK_CFG_12, CLK_CFG_12_SET,
+		CLK_CFG_12_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_MCUPM_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_MEM_SUB_SEL/* dts */, "mem_sub_sel",
+		mem_sub_parents/* parent */, CLK_CFG_12, CLK_CFG_12_SET,
+		CLK_CFG_12_CLR/* set parent */, 24/* lsb */, 4/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_MEM_SUB_SHIFT/* upd shift */),
+	/* CLK_CFG_13 */
+	MUX_CLR_SET_UPD(CLK_TOP_MEM_SUB_PERI_SEL/* dts */, "mem_sub_peri_sel",
+		mem_sub_peri_parents/* parent */, CLK_CFG_13, CLK_CFG_13_SET,
+		CLK_CFG_13_CLR/* set parent */, 0/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_MEM_SUB_PERI_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_MEM_SUB_U_SEL/* dts */, "mem_sub_u_sel",
+		mem_sub_u_parents/* parent */, CLK_CFG_13, CLK_CFG_13_SET,
+		CLK_CFG_13_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_MEM_SUB_UFS_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_EMI_N_SEL/* dts */, "emi_n_sel",
+		emi_n_parents/* parent */, CLK_CFG_13, CLK_CFG_13_SET,
+		CLK_CFG_13_CLR/* set parent */, 16/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_EMI_N_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_DSI_OCC_SEL/* dts */, "dsi_occ_sel",
+		dsi_occ_parents/* parent */, CLK_CFG_13, CLK_CFG_13_SET,
+		CLK_CFG_13_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_DSI_OCC_SHIFT/* upd shift */),
+	/* CLK_CFG_14 */
+	MUX_CLR_SET_UPD(CLK_TOP_AP2CONN_HOST_SEL/* dts */, "ap2conn_host_sel",
+		ap2conn_host_parents/* parent */, CLK_CFG_14, CLK_CFG_14_SET,
+		CLK_CFG_14_CLR/* set parent */, 0/* lsb */, 1/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_AP2CONN_HOST_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_IMG1_SEL/* dts */, "img1_sel",
+		img1_parents/* parent */, CLK_CFG_14, CLK_CFG_14_SET,
+		CLK_CFG_14_CLR/* set parent */, 8/* lsb */, 4/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_IMG1_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_IPE_SEL/* dts */, "ipe_sel",
+		ipe_parents/* parent */, CLK_CFG_14, CLK_CFG_14_SET,
+		CLK_CFG_14_CLR/* set parent */, 16/* lsb */, 4/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_IPE_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_CAM_SEL/* dts */, "cam_sel",
+		cam_parents/* parent */, CLK_CFG_14, CLK_CFG_14_SET,
+		CLK_CFG_14_CLR/* set parent */, 24/* lsb */, 4/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_CAM_SHIFT/* upd shift */),
+	/* CLK_CFG_15 */
+	MUX_CLR_SET_UPD(CLK_TOP_CAMTM_SEL/* dts */, "camtm_sel",
+		camtm_parents/* parent */, CLK_CFG_15, CLK_CFG_15_SET,
+		CLK_CFG_15_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_CAMTM_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_DSP_SEL/* dts */, "dsp_sel",
+		dsp_parents/* parent */, CLK_CFG_15, CLK_CFG_15_SET,
+		CLK_CFG_15_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_DSP_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_SR_PKA_SEL/* dts */, "sr_pka_sel",
+		sr_pka_parents/* parent */, CLK_CFG_15, CLK_CFG_15_SET,
+		CLK_CFG_15_CLR/* set parent */, 16/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE2/* upd ofs */, TOP_MUX_SR_PKA_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_DXCC_SEL/* dts */, "dxcc_sel",
+		dxcc_parents/* parent */, CLK_CFG_15, CLK_CFG_15_SET,
+		CLK_CFG_15_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE2/* upd ofs */, TOP_MUX_DXCC_SHIFT/* upd shift */),
+	/* CLK_CFG_16 */
+	MUX_CLR_SET_UPD(CLK_TOP_MFG_REF_SEL/* dts */, "mfg_ref_sel",
+		mfg_ref_parents/* parent */, CLK_CFG_16, CLK_CFG_16_SET,
+		CLK_CFG_16_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE2/* upd ofs */, TOP_MUX_MFG_REF_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_MDP0_SEL/* dts */, "mdp0_sel",
+		mdp0_parents/* parent */, CLK_CFG_16, CLK_CFG_16_SET,
+		CLK_CFG_16_CLR/* set parent */, 8/* lsb */, 4/* width */,
+		CLK_CFG_UPDATE2/* upd ofs */, TOP_MUX_MDP0_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_DP_SEL/* dts */, "dp_sel",
+		dp_parents/* parent */, CLK_CFG_16, CLK_CFG_16_SET,
+		CLK_CFG_16_CLR/* set parent */, 16/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE2/* upd ofs */, TOP_MUX_DP_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_EDP_SEL/* dts */, "edp_sel",
+		edp_parents/* parent */, CLK_CFG_16, CLK_CFG_16_SET,
+		CLK_CFG_16_CLR/* set parent */, 24/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE2/* upd ofs */, TOP_MUX_EDP_SHIFT/* upd shift */),
+	/* CLK_CFG_17 */
+	MUX_CLR_SET_UPD(CLK_TOP_EDP_FAVT_SEL/* dts */, "edp_favt_sel",
+		edp_favt_parents/* parent */, CLK_CFG_17, CLK_CFG_17_SET,
+		CLK_CFG_17_CLR/* set parent */, 0/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE2/* upd ofs */, TOP_MUX_EDP_FAVT_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_ETH_250M_SEL/* dts */, "snps_eth_250m_sel",
+		snps_eth_250m_parents/* parent */, CLK_CFG_17, CLK_CFG_17_SET,
+		CLK_CFG_17_CLR/* set parent */, 8/* lsb */, 1/* width */,
+		CLK_CFG_UPDATE2/* upd ofs */, TOP_MUX_SNPS_ETH_250M_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_ETH_62P4M_PTP_SEL/* dts */, "snps_eth_62p4m_ptp_sel",
+		snps_eth_62p4m_ptp_parents/* parent */, CLK_CFG_17, CLK_CFG_17_SET,
+		CLK_CFG_17_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE2/* upd ofs */, TOP_MUX_SNPS_ETH_62P4M_PTP_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_ETH_50M_RMII_SEL/* dts */, "snps_eth_50m_rmii_sel",
+		snps_eth_50m_rmii_parents/* parent */, CLK_CFG_17, CLK_CFG_17_SET,
+		CLK_CFG_17_CLR/* set parent */, 24/* lsb */, 1/* width */,
+		CLK_CFG_UPDATE2/* upd ofs */, TOP_MUX_SNPS_ETH_50M_RMII_SHIFT/* upd shift */),
+	/* CLK_CFG_18 */
+	MUX_CLR_SET_UPD(CLK_TOP_SFLASH_SEL/* dts */, "sflash_sel",
+		sflash_parents/* parent */, CLK_CFG_18, CLK_CFG_18_SET,
+		CLK_CFG_18_CLR/* set parent */, 0/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE2/* upd ofs */, TOP_MUX_SFLASH_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_GCPU_SEL/* dts */, "gcpu_sel",
+		gcpu_parents/* parent */, CLK_CFG_18, CLK_CFG_18_SET,
+		CLK_CFG_18_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE2/* upd ofs */, TOP_MUX_GCPU_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_MAC_TL_SEL/* dts */, "pcie_mac_tl_sel",
+		pcie_mac_tl_parents/* parent */, CLK_CFG_18, CLK_CFG_18_SET,
+		CLK_CFG_18_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE2/* upd ofs */, TOP_MUX_PCIE_MAC_TL_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_VDSTX_DG_CTS_SEL/* dts */, "vdstx_dg_cts_sel",
+		vdstx_dg_cts_parents/* parent */, CLK_CFG_18, CLK_CFG_18_SET,
+		CLK_CFG_18_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE2/* upd ofs */, TOP_MUX_VDSTX_CLKDIG_CTS_SHIFT/* upd shift */),
+	/* CLK_CFG_19 */
+	MUX_CLR_SET_UPD(CLK_TOP_PLL_DPIX_SEL/* dts */, "pll_dpix_sel",
+		pll_dpix_parents/* parent */, CLK_CFG_19, CLK_CFG_19_SET,
+		CLK_CFG_19_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE2/* upd ofs */, TOP_MUX_PLL_DPIX_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_ECC_SEL/* dts */, "ecc_sel",
+		ecc_parents/* parent */, CLK_CFG_19, CLK_CFG_19_SET,
+		CLK_CFG_19_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE2/* upd ofs */, TOP_MUX_ECC_SHIFT/* upd shift */),
+	/* CLK_MISC_CFG_3 */
+	MUX_CLR_SET_UPD(CLK_TOP_MFG_SEL_MFGPLL/* dts */, "mfg_sel_mfgpll",
+		mfg_sel_mfgpll_parents/* parent */, CLK_MISC_CFG_3, CLK_MISC_CFG_3_SET,
+		CLK_MISC_CFG_3_CLR/* set parent */, 16/* lsb */, 1/* width */,
+		-1/* upd ofs */, -1/* upd shift */),
+#else
+	/* CLK_CFG_0 */
+	MUX_CLR_SET_UPD(CLK_TOP_AXI_SEL/* dts */, "axi_sel",
+		axi_parents/* parent */, CLK_CFG_0, CLK_CFG_0_SET,
+		CLK_CFG_0_CLR/* set parent */, 0/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_AXI_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_AXI_PERI_SEL/* dts */, "axi_peri_sel",
+		axi_peri_parents/* parent */, CLK_CFG_0, CLK_CFG_0_SET,
+		CLK_CFG_0_CLR/* set parent */, 8/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_AXI_PERI_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_AXI_U_SEL/* dts */, "axi_u_sel",
+		axi_u_parents/* parent */, CLK_CFG_0, CLK_CFG_0_SET,
+		CLK_CFG_0_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_AXI_UFS_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_BUS_AXIMEM_SEL/* dts */, "bus_aximem_sel",
+		bus_aximem_parents/* parent */, CLK_CFG_0, CLK_CFG_0_SET,
+		CLK_CFG_0_CLR/* set parent */, 24/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE/* upd ofs */, TOP_MUX_BUS_AXIMEM_SHIFT/* upd shift */),
+	/* CLK_CFG_1 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DISP0_SEL/* dts */, "disp0_sel",
+		disp0_parents/* parent */, CLK_CFG_1, CLK_CFG_1_SET,
+		CLK_CFG_1_CLR/* set parent */, 0/* lsb */, 4/* width */,
+		7/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_DISP0_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MMINFRA_SEL/* dts */, "mminfra_sel",
+		mminfra_parents/* parent */, CLK_CFG_1, CLK_CFG_1_SET,
+		CLK_CFG_1_CLR/* set parent */, 8/* lsb */, 4/* width */,
+		15/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_MMINFRA_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_UART_SEL/* dts */, "uart_sel",
+		uart_parents/* parent */, CLK_CFG_1, CLK_CFG_1_SET,
+		CLK_CFG_1_CLR/* set parent */, 16/* lsb */, 1/* width */,
+		23/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_UART_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI0_SEL/* dts */, "spi0_sel",
+		spi0_parents/* parent */, CLK_CFG_1, CLK_CFG_1_SET,
+		CLK_CFG_1_CLR/* set parent */, 24/* lsb */, 3/* width */,
+		31/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SPI0_SHIFT/* upd shift */),
+	/* CLK_CFG_2 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI1_SEL/* dts */, "spi1_sel",
+		spi1_parents/* parent */, CLK_CFG_2, CLK_CFG_2_SET,
+		CLK_CFG_2_CLR/* set parent */, 0/* lsb */, 3/* width */,
+		7/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SPI1_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI2_SEL/* dts */, "spi2_sel",
+		spi2_parents/* parent */, CLK_CFG_2, CLK_CFG_2_SET,
+		CLK_CFG_2_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		15/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SPI2_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI3_SEL/* dts */, "spi3_sel",
+		spi3_parents/* parent */, CLK_CFG_2, CLK_CFG_2_SET,
+		CLK_CFG_2_CLR/* set parent */, 16/* lsb */, 3/* width */,
+		23/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SPI3_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI4_SEL/* dts */, "spi4_sel",
+		spi4_parents/* parent */, CLK_CFG_2, CLK_CFG_2_SET,
+		CLK_CFG_2_CLR/* set parent */, 24/* lsb */, 3/* width */,
+		31/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SPI4_SHIFT/* upd shift */),
+	/* CLK_CFG_3 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI5_SEL/* dts */, "spi5_sel",
+		spi5_parents/* parent */, CLK_CFG_3, CLK_CFG_3_SET,
+		CLK_CFG_3_CLR/* set parent */, 0/* lsb */, 3/* width */,
+		7/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SPI5_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC_MACRO_0P_SEL/* dts */, "msdc_macro_0p_sel",
+		msdc_macro_0p_parents/* parent */, CLK_CFG_3, CLK_CFG_3_SET,
+		CLK_CFG_3_CLR/* set parent */, 8/* lsb */, 2/* width */,
+		15/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_MSDC_MACRO_0P_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_HCLK_SEL/* dts */, "msdc5hclk_sel",
+		msdc5hclk_parents/* parent */, CLK_CFG_3, CLK_CFG_3_SET,
+		CLK_CFG_3_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		23/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_MSDC50_0_HCLK_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_SEL/* dts */, "msdc50_0_sel",
+		msdc50_0_parents/* parent */, CLK_CFG_3, CLK_CFG_3_SET,
+		CLK_CFG_3_CLR/* set parent */, 24/* lsb */, 3/* width */,
+		31/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_MSDC50_0_SHIFT/* upd shift */),
+	/* CLK_CFG_4 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AES_MSDCFDE_SEL/* dts */, "aes_msdcfde_sel",
+		aes_msdcfde_parents/* parent */, CLK_CFG_4, CLK_CFG_4_SET,
+		CLK_CFG_4_CLR/* set parent */, 0/* lsb */, 3/* width */,
+		7/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_AES_MSDCFDE_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC_MACRO_1P_SEL/* dts */, "msdc_macro_1p_sel",
+		msdc_macro_1p_parents/* parent */, CLK_CFG_4, CLK_CFG_4_SET,
+		CLK_CFG_4_CLR/* set parent */, 8/* lsb */, 2/* width */,
+		15/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_MSDC_MACRO_1P_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1_SEL/* dts */, "msdc30_1_sel",
+		msdc30_1_parents/* parent */, CLK_CFG_4, CLK_CFG_4_SET,
+		CLK_CFG_4_CLR/* set parent */, 16/* lsb */, 3/* width */,
+		23/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_MSDC30_1_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1_HCLK_SEL/* dts */, "msdc30_1_h_sel",
+		msdc30_1_h_parents/* parent */, CLK_CFG_4, CLK_CFG_4_SET,
+		CLK_CFG_4_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		31/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_MSDC30_1_HCLK_SHIFT/* upd shift */),
+	/* CLK_CFG_5 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC_MACRO_2P_SEL/* dts */, "msdc_macro_2p_sel",
+		msdc_macro_2p_parents/* parent */, CLK_CFG_5, CLK_CFG_5_SET,
+		CLK_CFG_5_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		7/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_MSDC_MACRO_2P_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_2_SEL/* dts */, "msdc30_2_sel",
+		msdc30_2_parents/* parent */, CLK_CFG_5, CLK_CFG_5_SET,
+		CLK_CFG_5_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		15/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_MSDC30_2_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_2_HCLK_SEL/* dts */, "msdc30_2_h_sel",
+		msdc30_2_h_parents/* parent */, CLK_CFG_5, CLK_CFG_5_SET,
+		CLK_CFG_5_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		23/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_MSDC30_2_HCLK_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_INTBUS_SEL/* dts */, "aud_intbus_sel",
+		aud_intbus_parents/* parent */, CLK_CFG_5, CLK_CFG_5_SET,
+		CLK_CFG_5_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		31/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_AUD_INTBUS_SHIFT/* upd shift */),
+	/* CLK_CFG_6 */
+	MUX_CLR_SET_UPD(CLK_TOP_ATB_SEL/* dts */, "atb_sel",
+		atb_parents/* parent */, CLK_CFG_6, CLK_CFG_6_SET,
+		CLK_CFG_6_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_ATB_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DISP_PWM_SEL/* dts */, "disp_pwm_sel",
+		disp_pwm_parents/* parent */, CLK_CFG_6, CLK_CFG_6_SET,
+		CLK_CFG_6_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		15/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_DISP_PWM_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_P0_SEL/* dts */, "usb_p0_sel",
+		usb_p0_parents/* parent */, CLK_CFG_6, CLK_CFG_6_SET,
+		CLK_CFG_6_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		23/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_USB_TOP_P0_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_XHCI_P0_SEL/* dts */, "ssusb_xhci_p0_sel",
+		ssusb_xhci_p0_parents/* parent */, CLK_CFG_6, CLK_CFG_6_SET,
+		CLK_CFG_6_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		31/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SSUSB_XHCI_P0_SHIFT/* upd shift */),
+	/* CLK_CFG_7 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_P1_SEL/* dts */, "usb_p1_sel",
+		usb_p1_parents/* parent */, CLK_CFG_7, CLK_CFG_7_SET,
+		CLK_CFG_7_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		7/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_USB_TOP_P1_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_XHCI_P1_SEL/* dts */, "ssusb_xhci_p1_sel",
+		ssusb_xhci_p1_parents/* parent */, CLK_CFG_7, CLK_CFG_7_SET,
+		CLK_CFG_7_CLR/* set parent */, 8/* lsb */, 2/* width */,
+		15/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_SSUSB_XHCI_P1_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_P2_SEL/* dts */, "usb_p2_sel",
+		usb_p2_parents/* parent */, CLK_CFG_7, CLK_CFG_7_SET,
+		CLK_CFG_7_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		23/* pdn */, CLK_CFG_UPDATE/* upd ofs */,
+		TOP_MUX_USB_TOP_P2_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_XHCI_P2_SEL/* dts */, "ssusb_xhci_p2_sel",
+		ssusb_xhci_p2_parents/* parent */, CLK_CFG_7, CLK_CFG_7_SET,
+		CLK_CFG_7_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		31/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_SSUSB_XHCI_P2_SHIFT/* upd shift */),
+	/* CLK_CFG_8 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_P3_SEL/* dts */, "usb_p3_sel",
+		usb_p3_parents/* parent */, CLK_CFG_8, CLK_CFG_8_SET,
+		CLK_CFG_8_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		7/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_USB_TOP_P3_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_XHCI_P3_SEL/* dts */, "ssusb_xhci_p3_sel",
+		ssusb_xhci_p3_parents/* parent */, CLK_CFG_8, CLK_CFG_8_SET,
+		CLK_CFG_8_CLR/* set parent */, 8/* lsb */, 2/* width */,
+		15/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_SSUSB_XHCI_P3_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_P4_SEL/* dts */, "usb_p4_sel",
+		usb_p4_parents/* parent */, CLK_CFG_8, CLK_CFG_8_SET,
+		CLK_CFG_8_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		23/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_USB_TOP_P4_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_XHCI_P4_SEL/* dts */, "ssusb_xhci_p4_sel",
+		ssusb_xhci_p4_parents/* parent */, CLK_CFG_8, CLK_CFG_8_SET,
+		CLK_CFG_8_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		31/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_SSUSB_XHCI_P4_SHIFT/* upd shift */),
+	/* CLK_CFG_9 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_I2C_SEL/* dts */, "i2c_sel",
+		i2c_parents/* parent */, CLK_CFG_9, CLK_CFG_9_SET,
+		CLK_CFG_9_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		7/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_I2C_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF_SEL/* dts */, "seninf_sel",
+		seninf_parents/* parent */, CLK_CFG_9, CLK_CFG_9_SET,
+		CLK_CFG_9_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		15/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_SENINF_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF1_SEL/* dts */, "seninf1_sel",
+		seninf1_parents/* parent */, CLK_CFG_9, CLK_CFG_9_SET,
+		CLK_CFG_9_CLR/* set parent */, 16/* lsb */, 3/* width */,
+		23/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_SENINF1_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_ENGEN1_SEL/* dts */, "aud_engen1_sel",
+		aud_engen1_parents/* parent */, CLK_CFG_9, CLK_CFG_9_SET,
+		CLK_CFG_9_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		31/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_AUD_ENGEN1_SHIFT/* upd shift */),
+	/* CLK_CFG_10 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_ENGEN2_SEL/* dts */, "aud_engen2_sel",
+		aud_engen2_parents/* parent */, CLK_CFG_10, CLK_CFG_10_SET,
+		CLK_CFG_10_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		7/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_AUD_ENGEN2_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AES_UFSFDE_SEL/* dts */, "aes_ufsfde_sel",
+		aes_ufsfde_parents/* parent */, CLK_CFG_10, CLK_CFG_10_SET,
+		CLK_CFG_10_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		15/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_AES_UFSFDE_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_U_SEL/* dts */, "ufs_sel",
+		ufs_parents/* parent */, CLK_CFG_10, CLK_CFG_10_SET,
+		CLK_CFG_10_CLR/* set parent */, 16/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */, TOP_MUX_UFS_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_U_MBIST_SEL/* dts */, "ufs_mbist_sel",
+		ufs_mbist_parents/* parent */, CLK_CFG_10, CLK_CFG_10_SET,
+		CLK_CFG_10_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		31/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_UFS_MBIST_SHIFT/* upd shift */),
+	/* CLK_CFG_11 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_1_SEL/* dts */, "aud_1_sel",
+		aud_1_parents/* parent */, CLK_CFG_11, CLK_CFG_11_SET,
+		CLK_CFG_11_CLR/* set parent */, 0/* lsb */, 1/* width */,
+		7/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_AUD_1_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_2_SEL/* dts */, "aud_2_sel",
+		aud_2_parents/* parent */, CLK_CFG_11, CLK_CFG_11_SET,
+		CLK_CFG_11_CLR/* set parent */, 8/* lsb */, 1/* width */,
+		15/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_AUD_2_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_VENC_SEL/* dts */, "venc_sel",
+		venc_parents/* parent */, CLK_CFG_11, CLK_CFG_11_SET,
+		CLK_CFG_11_CLR/* set parent */, 16/* lsb */, 4/* width */,
+		23/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_VENC_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_VDEC_SEL/* dts */, "vdec_sel",
+		vdec_parents/* parent */, CLK_CFG_11, CLK_CFG_11_SET,
+		CLK_CFG_11_CLR/* set parent */, 24/* lsb */, 4/* width */,
+		31/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_VDEC_SHIFT/* upd shift */),
+	/* CLK_CFG_12 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_PWM_SEL/* dts */, "pwm_sel",
+		pwm_parents/* parent */, CLK_CFG_12, CLK_CFG_12_SET,
+		CLK_CFG_12_CLR/* set parent */, 0/* lsb */, 1/* width */,
+		7/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_PWM_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUDIO_H_SEL/* dts */, "audio_h_sel",
+		audio_h_parents/* parent */, CLK_CFG_12, CLK_CFG_12_SET,
+		CLK_CFG_12_CLR/* set parent */, 8/* lsb */, 2/* width */,
+		15/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_AUDIO_H_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_MCUPM_SEL/* dts */, "mcupm_sel",
+		mcupm_parents/* parent */, CLK_CFG_12, CLK_CFG_12_SET,
+		CLK_CFG_12_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_MCUPM_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_MEM_SUB_SEL/* dts */, "mem_sub_sel",
+		mem_sub_parents/* parent */, CLK_CFG_12, CLK_CFG_12_SET,
+		CLK_CFG_12_CLR/* set parent */, 24/* lsb */, 4/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_MEM_SUB_SHIFT/* upd shift */),
+	/* CLK_CFG_13 */
+	MUX_CLR_SET_UPD(CLK_TOP_MEM_SUB_PERI_SEL/* dts */, "mem_sub_peri_sel",
+		mem_sub_peri_parents/* parent */, CLK_CFG_13, CLK_CFG_13_SET,
+		CLK_CFG_13_CLR/* set parent */, 0/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_MEM_SUB_PERI_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_MEM_SUB_U_SEL/* dts */, "mem_sub_u_sel",
+		mem_sub_u_parents/* parent */, CLK_CFG_13, CLK_CFG_13_SET,
+		CLK_CFG_13_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_MEM_SUB_UFS_SHIFT/* upd shift */),
+	MUX_CLR_SET_UPD(CLK_TOP_EMI_N_SEL/* dts */, "emi_n_sel",
+		emi_n_parents/* parent */, CLK_CFG_13, CLK_CFG_13_SET,
+		CLK_CFG_13_CLR/* set parent */, 16/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_EMI_N_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DSI_OCC_SEL/* dts */, "dsi_occ_sel",
+		dsi_occ_parents/* parent */, CLK_CFG_13, CLK_CFG_13_SET,
+		CLK_CFG_13_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		31/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_DSI_OCC_SHIFT/* upd shift */),
+	/* CLK_CFG_14 */
+	MUX_CLR_SET_UPD(CLK_TOP_AP2CONN_HOST_SEL/* dts */, "ap2conn_host_sel",
+		ap2conn_host_parents/* parent */, CLK_CFG_14, CLK_CFG_14_SET,
+		CLK_CFG_14_CLR/* set parent */, 0/* lsb */, 1/* width */,
+		CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_AP2CONN_HOST_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_IMG1_SEL/* dts */, "img1_sel",
+		img1_parents/* parent */, CLK_CFG_14, CLK_CFG_14_SET,
+		CLK_CFG_14_CLR/* set parent */, 8/* lsb */, 4/* width */,
+		15/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_IMG1_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_IPE_SEL/* dts */, "ipe_sel",
+		ipe_parents/* parent */, CLK_CFG_14, CLK_CFG_14_SET,
+		CLK_CFG_14_CLR/* set parent */, 16/* lsb */, 4/* width */,
+		23/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_IPE_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAM_SEL/* dts */, "cam_sel",
+		cam_parents/* parent */, CLK_CFG_14, CLK_CFG_14_SET,
+		CLK_CFG_14_CLR/* set parent */, 24/* lsb */, 4/* width */,
+		31/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_CAM_SHIFT/* upd shift */),
+	/* CLK_CFG_15 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTM_SEL/* dts */, "camtm_sel",
+		camtm_parents/* parent */, CLK_CFG_15, CLK_CFG_15_SET,
+		CLK_CFG_15_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		7/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_CAMTM_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DSP_SEL/* dts */, "dsp_sel",
+		dsp_parents/* parent */, CLK_CFG_15, CLK_CFG_15_SET,
+		CLK_CFG_15_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		15/* pdn */, CLK_CFG_UPDATE1/* upd ofs */,
+		TOP_MUX_DSP_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SR_PKA_SEL/* dts */, "sr_pka_sel",
+		sr_pka_parents/* parent */, CLK_CFG_15, CLK_CFG_15_SET,
+		CLK_CFG_15_CLR/* set parent */, 16/* lsb */, 3/* width */,
+		23/* pdn */, CLK_CFG_UPDATE2/* upd ofs */,
+		TOP_MUX_SR_PKA_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DXCC_SEL/* dts */, "dxcc_sel",
+		dxcc_parents/* parent */, CLK_CFG_15, CLK_CFG_15_SET,
+		CLK_CFG_15_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		31/* pdn */, CLK_CFG_UPDATE2/* upd ofs */,
+		TOP_MUX_DXCC_SHIFT/* upd shift */),
+	/* CLK_CFG_16 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MFG_REF_SEL/* dts */, "mfg_ref_sel",
+		mfg_ref_parents/* parent */, CLK_CFG_16, CLK_CFG_16_SET,
+		CLK_CFG_16_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		7/* pdn */, CLK_CFG_UPDATE2/* upd ofs */,
+		TOP_MUX_MFG_REF_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MDP0_SEL/* dts */, "mdp0_sel",
+		mdp0_parents/* parent */, CLK_CFG_16, CLK_CFG_16_SET,
+		CLK_CFG_16_CLR/* set parent */, 8/* lsb */, 4/* width */,
+		15/* pdn */, CLK_CFG_UPDATE2/* upd ofs */,
+		TOP_MUX_MDP0_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DP_SEL/* dts */, "dp_sel",
+		dp_parents/* parent */, CLK_CFG_16, CLK_CFG_16_SET,
+		CLK_CFG_16_CLR/* set parent */, 16/* lsb */, 3/* width */,
+		23/* pdn */, CLK_CFG_UPDATE2/* upd ofs */,
+		TOP_MUX_DP_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_EDP_SEL/* dts */, "edp_sel",
+		edp_parents/* parent */, CLK_CFG_16, CLK_CFG_16_SET,
+		CLK_CFG_16_CLR/* set parent */, 24/* lsb */, 3/* width */,
+		31/* pdn */, CLK_CFG_UPDATE2/* upd ofs */,
+		TOP_MUX_EDP_SHIFT/* upd shift */),
+	/* CLK_CFG_17 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_EDP_FAVT_SEL/* dts */, "edp_favt_sel",
+		edp_favt_parents/* parent */, CLK_CFG_17, CLK_CFG_17_SET,
+		CLK_CFG_17_CLR/* set parent */, 0/* lsb */, 3/* width */,
+		7/* pdn */, CLK_CFG_UPDATE2/* upd ofs */,
+		TOP_MUX_EDP_FAVT_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ETH_250M_SEL/* dts */, "snps_eth_250m_sel",
+		snps_eth_250m_parents/* parent */, CLK_CFG_17, CLK_CFG_17_SET,
+		CLK_CFG_17_CLR/* set parent */, 8/* lsb */, 1/* width */,
+		15/* pdn */, CLK_CFG_UPDATE2/* upd ofs */,
+		TOP_MUX_SNPS_ETH_250M_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ETH_62P4M_PTP_SEL/* dts */, "snps_eth_62p4m_ptp_sel",
+		snps_eth_62p4m_ptp_parents/* parent */, CLK_CFG_17, CLK_CFG_17_SET,
+		CLK_CFG_17_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		23/* pdn */, CLK_CFG_UPDATE2/* upd ofs */,
+		TOP_MUX_SNPS_ETH_62P4M_PTP_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ETH_50M_RMII_SEL/* dts */, "snps_eth_50m_rmii_sel",
+		snps_eth_50m_rmii_parents/* parent */, CLK_CFG_17, CLK_CFG_17_SET,
+		CLK_CFG_17_CLR/* set parent */, 24/* lsb */, 1/* width */,
+		31/* pdn */, CLK_CFG_UPDATE2/* upd ofs */,
+		TOP_MUX_SNPS_ETH_50M_RMII_SHIFT/* upd shift */),
+	/* CLK_CFG_18 */
+	MUX_CLR_SET_UPD(CLK_TOP_SFLASH_SEL/* dts */, "sflash_sel",
+		sflash_parents/* parent */, CLK_CFG_18, CLK_CFG_18_SET,
+		CLK_CFG_18_CLR/* set parent */, 0/* lsb */, 3/* width */,
+		CLK_CFG_UPDATE2/* upd ofs */, TOP_MUX_SFLASH_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_GCPU_SEL/* dts */, "gcpu_sel",
+		gcpu_parents/* parent */, CLK_CFG_18, CLK_CFG_18_SET,
+		CLK_CFG_18_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		15/* pdn */, CLK_CFG_UPDATE2/* upd ofs */,
+		TOP_MUX_GCPU_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MAC_TL_SEL/* dts */, "pcie_mac_tl_sel",
+		pcie_mac_tl_parents/* parent */, CLK_CFG_18, CLK_CFG_18_SET,
+		CLK_CFG_18_CLR/* set parent */, 16/* lsb */, 2/* width */,
+		23/* pdn */, CLK_CFG_UPDATE2/* upd ofs */,
+		TOP_MUX_PCIE_MAC_TL_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_VDSTX_DG_CTS_SEL/* dts */, "vdstx_dg_cts_sel",
+		vdstx_dg_cts_parents/* parent */, CLK_CFG_18, CLK_CFG_18_SET,
+		CLK_CFG_18_CLR/* set parent */, 24/* lsb */, 2/* width */,
+		31/* pdn */, CLK_CFG_UPDATE2/* upd ofs */,
+		TOP_MUX_VDSTX_CLKDIG_CTS_SHIFT/* upd shift */),
+	/* CLK_CFG_19 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_PLL_DPIX_SEL/* dts */, "pll_dpix_sel",
+		pll_dpix_parents/* parent */, CLK_CFG_19, CLK_CFG_19_SET,
+		CLK_CFG_19_CLR/* set parent */, 0/* lsb */, 2/* width */,
+		7/* pdn */, CLK_CFG_UPDATE2/* upd ofs */,
+		TOP_MUX_PLL_DPIX_SHIFT/* upd shift */),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ECC_SEL/* dts */, "ecc_sel",
+		ecc_parents/* parent */, CLK_CFG_19, CLK_CFG_19_SET,
+		CLK_CFG_19_CLR/* set parent */, 8/* lsb */, 3/* width */,
+		15/* pdn */, CLK_CFG_UPDATE2/* upd ofs */,
+		TOP_MUX_ECC_SHIFT/* upd shift */),
+	/* CLK_MISC_CFG_3 */
+	MUX_CLR_SET_UPD(CLK_TOP_MFG_SEL_MFGPLL/* dts */, "mfg_sel_mfgpll",
+		mfg_sel_mfgpll_parents/* parent */, CLK_MISC_CFG_3, CLK_MISC_CFG_3_SET,
+		CLK_MISC_CFG_3_CLR/* set parent */, 16/* lsb */, 1/* width */,
+		-1/* upd ofs */, -1/* upd shift */),
+#endif
+};
+
+static const struct mtk_composite top_composites[] = {
+	/* CLK_AUDDIV_0 */
+	MUX(CLK_TOP_APLL_I2SIN0_MCK_SEL/* dts */, "apll_i2sin0_m_sel",
+		apll_i2sin0_m_parents/* parent */, 0x0320/* ofs */,
+		16/* lsb */, 1/* width */),
+	MUX(CLK_TOP_APLL_I2SIN1_MCK_SEL/* dts */, "apll_i2sin1_m_sel",
+		apll_i2sin1_m_parents/* parent */, 0x0320/* ofs */,
+		17/* lsb */, 1/* width */),
+	MUX(CLK_TOP_APLL_I2SIN2_MCK_SEL/* dts */, "apll_i2sin2_m_sel",
+		apll_i2sin2_m_parents/* parent */, 0x0320/* ofs */,
+		18/* lsb */, 1/* width */),
+	MUX(CLK_TOP_APLL_I2SIN3_MCK_SEL/* dts */, "apll_i2sin3_m_sel",
+		apll_i2sin3_m_parents/* parent */, 0x0320/* ofs */,
+		19/* lsb */, 1/* width */),
+	MUX(CLK_TOP_APLL_I2SIN4_MCK_SEL/* dts */, "apll_i2sin4_m_sel",
+		apll_i2sin4_m_parents/* parent */, 0x0320/* ofs */,
+		20/* lsb */, 1/* width */),
+	MUX(CLK_TOP_APLL_I2SIN6_MCK_SEL/* dts */, "apll_i2sin6_m_sel",
+		apll_i2sin6_m_parents/* parent */, 0x0320/* ofs */,
+		21/* lsb */, 1/* width */),
+	MUX(CLK_TOP_APLL_I2SOUT0_MCK_SEL/* dts */, "apll_i2sout0_m_sel",
+		apll_i2sout0_m_parents/* parent */, 0x0320/* ofs */,
+		22/* lsb */, 1/* width */),
+	MUX(CLK_TOP_APLL_I2SOUT1_MCK_SEL/* dts */, "apll_i2sout1_m_sel",
+		apll_i2sout1_m_parents/* parent */, 0x0320/* ofs */,
+		23/* lsb */, 1/* width */),
+	MUX(CLK_TOP_APLL_I2SOUT2_MCK_SEL/* dts */, "apll_i2sout2_m_sel",
+		apll_i2sout2_m_parents/* parent */, 0x0320/* ofs */,
+		24/* lsb */, 1/* width */),
+	MUX(CLK_TOP_APLL_I2SOUT3_MCK_SEL/* dts */, "apll_i2sout3_m_sel",
+		apll_i2sout3_m_parents/* parent */, 0x0320/* ofs */,
+		25/* lsb */, 1/* width */),
+	MUX(CLK_TOP_APLL_I2SOUT4_MCK_SEL/* dts */, "apll_i2sout4_m_sel",
+		apll_i2sout4_m_parents/* parent */, 0x0320/* ofs */,
+		26/* lsb */, 1/* width */),
+	MUX(CLK_TOP_APLL_I2SOUT6_MCK_SEL/* dts */, "apll_i2sout6_m_sel",
+		apll_i2sout6_m_parents/* parent */, 0x0320/* ofs */,
+		27/* lsb */, 1/* width */),
+	MUX(CLK_TOP_APLL_FMI2S_MCK_SEL/* dts */, "apll_fmi2s_m_sel",
+		apll_fmi2s_m_parents/* parent */, 0x0320/* ofs */,
+		28/* lsb */, 1/* width */),
+	MUX(CLK_TOP_APLL_TDMOUT_MCK_SEL/* dts */, "apll_tdmout_m_sel",
+		apll_tdmout_m_parents/* parent */, 0x0320/* ofs */,
+		29/* lsb */, 1/* width */),
+	/* CLK_AUDDIV_2 */
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV_I2SIN0/* dts */, "apll12_div_i2sin0"/* ccf */,
+		"apll_i2sin0_m_sel"/* parent */, 0x0320/* pdn ofs */,
+		0/* pdn bit */, CLK_AUDDIV_2/* ofs */, 8/* width */,
+		0/* lsb */),
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV_I2SIN1/* dts */, "apll12_div_i2sin1"/* ccf */,
+		"apll_i2sin1_m_sel"/* parent */, 0x0320/* pdn ofs */,
+		1/* pdn bit */, CLK_AUDDIV_2/* ofs */, 8/* width */,
+		8/* lsb */),
+	/* CLK_AUDDIV_3 */
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV_I2SOUT0/* dts */, "apll12_div_i2sout0"/* ccf */,
+		"apll_i2sout0_m_sel"/* parent */, 0x0320/* pdn ofs */,
+		6/* pdn bit */, CLK_AUDDIV_3/* ofs */, 8/* width */,
+		16/* lsb */),
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV_I2SOUT1/* dts */, "apll12_div_i2sout1"/* ccf */,
+		"apll_i2sout1_m_sel"/* parent */, 0x0320/* pdn ofs */,
+		7/* pdn bit */, CLK_AUDDIV_3/* ofs */, 8/* width */,
+		24/* lsb */),
+	/* CLK_AUDDIV_5 */
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV_FMI2S/* dts */, "apll12_div_fmi2s"/* ccf */,
+		"apll_fmi2s_m_sel"/* parent */, 0x0320/* pdn ofs */,
+		12/* pdn bit */, CLK_AUDDIV_5/* ofs */, 8/* width */,
+		0/* lsb */),
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV_TDMOUT_M/* dts */, "apll12_div_tdmout_m"/* ccf */,
+		"apll_tdmout_m_sel"/* parent */, 0x0320/* pdn ofs */,
+		13/* pdn bit */, CLK_AUDDIV_5/* ofs */, 8/* width */,
+		8/* lsb */),
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV_TDMOUT_B/* dts */, "apll12_div_tdmout_b"/* ccf */,
+		"apll12_div_tdmout_m"/* parent */, 0x0320/* pdn ofs */,
+		14/* pdn bit */, CLK_AUDDIV_5/* ofs */, 8/* width */,
+		16/* lsb */),
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
+		.flags = _flag,			\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+	}
+
+#define GATE_TOP(_id, _name, _parent, _shift)		\
+	GATE_TOP_FLAGS(_id, _name, _parent, _shift, 0)
+
+#define GATE_TOP_V(_id, _name, _parent) {    \
+		.id = _id,              \
+		.name = _name,              \
+		.parent_name = _parent,         \
+	}
+
+static const struct mtk_gate top_clks[] = {
+	GATE_TOP_FLAGS(CLK_TOP_FMCNT_P0_EN, "fmcnt_p0_en",
+			"univpll_192m_d4"/* parent */, 0, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_FMCNT_P1_EN, "fmcnt_p1_en",
+			"univpll_192m_d4"/* parent */, 1, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_FMCNT_P2_EN, "fmcnt_p2_en",
+			"univpll_192m_d4"/* parent */, 2, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_FMCNT_P3_EN, "fmcnt_p3_en",
+			"univpll_192m_d4"/* parent */, 3, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_FMCNT_P4_EN, "fmcnt_p4_en",
+			"univpll_192m_d4"/* parent */, 4, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_USB_F26M_CK_EN, "ssusb_f26m",
+			"f26m_ck"/* parent */, 5, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_SSPXTP_F26M_CK_EN, "sspxtp_f26m",
+			"f26m_ck"/* parent */, 6, CLK_IS_CRITICAL),
+	GATE_TOP(CLK_TOP_USB2_PHY_RF_P0_EN, "usb2_phy_rf_p0_en",
+			"f26m_ck"/* parent */, 7),
+	GATE_TOP(CLK_TOP_USB2_PHY_RF_P1_EN, "usb2_phy_rf_p1_en",
+			"f26m_ck"/* parent */, 10),
+	GATE_TOP(CLK_TOP_USB2_PHY_RF_P2_EN, "usb2_phy_rf_p2_en",
+			"f26m_ck"/* parent */, 11),
+	GATE_TOP(CLK_TOP_USB2_PHY_RF_P3_EN, "usb2_phy_rf_p3_en",
+			"f26m_ck"/* parent */, 12),
+	GATE_TOP(CLK_TOP_USB2_PHY_RF_P4_EN, "usb2_phy_rf_p4_en",
+			"f26m_ck"/* parent */, 13),
+	GATE_TOP_FLAGS(CLK_TOP_USB2_26M_CK_P0_EN, "usb2_26m_p0_en",
+			"f26m_ck"/* parent */, 14, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_USB2_26M_CK_P1_EN, "usb2_26m_p1_en",
+			"f26m_ck"/* parent */, 15, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_USB2_26M_CK_P2_EN, "usb2_26m_p2_en",
+			"f26m_ck"/* parent */, 18, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_USB2_26M_CK_P3_EN, "usb2_26m_p3_en",
+			"f26m_ck"/* parent */, 19, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_USB2_26M_CK_P4_EN, "usb2_26m_p4_en",
+			"f26m_ck"/* parent */, 20, CLK_IS_CRITICAL),
+	GATE_TOP(CLK_TOP_F26M_CK_EN, "pcie_f26m",
+			"f26m_ck"/* parent */, 21),
+	GATE_TOP_FLAGS(CLK_TOP_AP2CON_EN, "ap2con",
+			"f26m_ck"/* parent */, 24, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_EINT_N_EN, "eint_n",
+			"f26m_ck"/* parent */, 25, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_TOPCKGEN_FMIPI_CSI_UP26M_CK_EN, "TOPCKGEN_fmipi_csi_up26m",
+			"osc_d10"/* parent */, 26, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_EINT_E_EN, "eint_e",
+			"f26m_ck"/* parent */, 28, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_EINT_W_EN, "eint_w",
+			"f26m_ck"/* parent */, 30, CLK_IS_CRITICAL),
+	GATE_TOP_FLAGS(CLK_TOP_EINT_S_EN, "eint_s",
+			"f26m_ck"/* parent */, 31, CLK_IS_CRITICAL),
+};
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
+		.regs = &vlpcfg_ao_reg_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+	}
+
+#define GATE_VLPCFG_AO_REG_V(_id, _name, _parent) {    \
+		.id = _id,              \
+		.name = _name,              \
+		.parent_name = _parent,         \
+	}
+
+static const struct mtk_gate vlpcfg_ao_reg_clks[] = {
+	GATE_VLPCFG_AO_REG(EN, "en",
+			"f26m_ck"/* parent */, 8),
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
+		.regs = &vlp_ck_cg_regs,			\
+		.shift = _shift,			\
+		.flags = _flag,				\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+	}
+
+#define GATE_VLP_CK_V(_id, _name, _parent) {    \
+		.id = _id,              \
+		.name = _name,              \
+		.parent_name = _parent,         \
+	}
+
+#define GATE_VLP_CK(_id, _name, _parent, _shift)	\
+	GATE_VLP_CK_FLAGS(_id, _name, _parent, _shift, 0)
+
+static const struct mtk_gate vlp_ck_clks[] = {
+	GATE_VLP_CK(CLK_VLP_CK_VADSYS_VLP_26M_EN, "vlp_vadsys_vlp_26m",
+			"f26m_ck"/* parent */, 1),
+	GATE_VLP_CK_FLAGS(CLK_VLP_CK_FMIPI_CSI_UP26M_CK_EN, "VLP_fmipi_csi_up26m",
+			"osc_d10"/* parent */, 11, CLK_IS_CRITICAL),
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
+		.regs = &vlpcfg_reg_cg_regs,			\
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
+			"vlp_scp_ck"/* parent */, 28, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_RG_R_APXGPT_26M, "vlpcfg_r_apxgpt_26m_ck",
+			"vlp_sej_26m_ck"/* parent */, 24, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_DPMSRCK_TEST, "vlpcfg_dpmsrck_test_ck",
+			"vlp_dpmsrck_ck"/* parent */, 23, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_RG_DPMSRRTC_TEST, "vlpcfg_dpmsrrtc_test_ck",
+			"vlp_dpmsrrtc_ck"/* parent */, 22, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_DPMSRULP_TEST, "vlpcfg_dpmsrulp_test_ck",
+			"vlp_dpmsrulp_ck"/* parent */, 21, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SPMI_P_MST, "vlpcfg_spmi_p_ck",
+			"vlp_spmi_p_ck"/* parent */, 20, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SPMI_P_MST_32K, "vlpcfg_spmi_p_32k_ck",
+			"vlp_spmi_p_32k_ck"/* parent */, 18, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_PMIF_SPMI_P_SYS, "vlpcfg_pmif_spmi_p_sys_ck",
+			"vlp_pwrap_ulposc_ck"/* parent */, 13, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_PMIF_SPMI_P_TMR, "vlpcfg_pmif_spmi_p_tmr_ck",
+			"vlp_pwrap_ulposc_ck"/* parent */, 12, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG(CLK_VLPCFG_REG_PMIF_SPMI_M_SYS, "vlpcfg_pmif_spmi_m_sys_ck",
+			"vlp_pwrap_ulposc_ck"/* parent */, 11),
+	GATE_VLPCFG_REG(CLK_VLPCFG_REG_PMIF_SPMI_M_TMR, "vlpcfg_pmif_spmi_m_tmr_ck",
+			"vlp_pwrap_ulposc_ck"/* parent */, 10),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_DVFSRC, "vlpcfg_dvfsrc_ck",
+			"vlp_dvfsrc_ck"/* parent */, 9, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_PWM_VLP, "vlpcfg_pwm_vlp_ck",
+			"vlp_pwm_vlp_ck"/* parent */, 8, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SRCK, "vlpcfg_srck_ck",
+			"vlp_srck_ck"/* parent */, 7, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SSPM_F26M, "vlpcfg_sspm_f26m_ck",
+			"vlp_sspm_f26m_ck"/* parent */, 4, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SSPM_F32K, "vlpcfg_sspm_f32k_ck",
+			"vlp_sspm_f32k_ck"/* parent */, 3, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SSPM_ULPOSC, "vlpcfg_sspm_ulposc_ck",
+			"vlp_sspm_ulposc_ck"/* parent */, 2, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_VLP_32K_COM, "vlpcfg_vlp_32k_com_ck",
+			"vlp_vlp_f32k_com_ck"/* parent */, 1, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_VLP_26M_COM, "vlpcfg_vlp_26m_com_ck",
+			"vlp_vlp_f26m_com_ck"/* parent */, 0, CLK_IS_CRITICAL),
+};
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
+#define GATE_DBGAO_V(_id, _name, _parent) {    \
+		.id = _id,              \
+		.name = _name,              \
+		.parent_name = _parent,         \
+	}
+
+static const struct mtk_gate dbgao_clks[] = {
+	GATE_DBGAO(CLK_DBGAO_ATB_EN, "dbgao_atb_en",
+			"atb_ck"/* parent */, 0),
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
+#define GATE_DEM0_V(_id, _name, _parent) {    \
+		.id = _id,              \
+		.name = _name,              \
+		.parent_name = _parent,         \
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
+#define GATE_DEM1_V(_id, _name, _parent) {    \
+		.id = _id,              \
+		.name = _name,              \
+		.parent_name = _parent,         \
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
+#define GATE_DEM2_V(_id, _name, _parent) {    \
+		.id = _id,              \
+		.name = _name,              \
+		.parent_name = _parent,         \
+	}
+
+static const struct mtk_gate dem_clks[] = {
+	/* DEM0 */
+	GATE_DEM0(CLK_DEM_BUSCLK_EN, "dem_busclk_en",
+			"axi_ck"/* parent */, 0),
+	/* DEM1 */
+	GATE_DEM1(CLK_DEM_SYSCLK_EN, "dem_sysclk_en",
+			"axi_ck"/* parent */, 0),
+	/* DEM2 */
+	GATE_DEM2(CLK_DEM_ATB_EN, "dem_atb_en",
+			"atb_ck"/* parent */, 0),
+};
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
+		.regs = &dvfsrc_top_cg_regs,			\
+		.shift = _shift,			\
+		.flags = _flags,			\
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
+	}
+
+#define GATE_DVFSRC_TOP_V(_id, _name, _parent) {    \
+		.id = _id,              \
+		.name = _name,              \
+		.parent_name = _parent,         \
+	}
+
+static const struct mtk_gate dvfsrc_top_clks[] = {
+	GATE_DVFSRC_TOP_FLAGS(CLK_DVFSRC_TOP_DVFSRC_EN, "dvfsrc_dvfsrc_en",
+			"f26m_ck"/* parent */, 0, CLK_IS_CRITICAL),
+};
+
+enum subsys_id {
+	APMIXEDSYS = 0,
+	PLL_SYS_NUM,
+};
+
+static const struct mtk_pll_data *plls_data[PLL_SYS_NUM];
+static void __iomem *plls_base[PLL_SYS_NUM];
+
+#define MT8189_PLL_FMAX		(3800UL * MHZ)
+#define MT8189_PLL_FMIN		(1500UL * MHZ)
+#define MT8189_INTEGER_BITS	8
+
+#if MT_CCF_PLL_DISABLE
+#define PLL_CFLAGS		PLL_AO
+#else
+#define PLL_CFLAGS		(0)
+#endif
+
+#define PLL_SETCLR(_id, _name, _reg, _pll_setclr, _en_setclr_bit,		\
+			_rstb_setclr_bit, _flags, _pd_reg,		\
+			_pd_shift, _tuner_reg, _tuner_en_reg,		\
+			_tuner_en_bit, _pcw_reg, _pcw_shift,		\
+			_pcwbits) {					\
+		.id = _id,						\
+		.name = _name,						\
+		.reg = _reg,						\
+		.pll_setclr = &(_pll_setclr),				\
+		.flags = (_flags | PLL_CFLAGS),				\
+		.fmax = MT8189_PLL_FMAX,				\
+		.fmin = MT8189_PLL_FMIN,				\
+		.pd_reg = _pd_reg,					\
+		.pd_shift = _pd_shift,					\
+		.tuner_reg = _tuner_reg,				\
+		.tuner_en_reg = _tuner_en_reg,			\
+		.tuner_en_bit = _tuner_en_bit,				\
+		.pcw_reg = _pcw_reg,					\
+		.pcw_shift = _pcw_shift,				\
+		.pcwbits = _pcwbits,					\
+		.pcwibits = MT8189_INTEGER_BITS,			\
+	}
+
+static struct mtk_pll_setclr_data setclr_data = {
+	.en_ofs = 0x0070,
+	.en_set_ofs = 0x0074,
+	.en_clr_ofs = 0x0078,
+	.rstb_ofs = 0x0080,
+	.rstb_set_ofs = 0x0084,
+	.rstb_clr_ofs = 0x0088,
+};
+
+static const struct mtk_pll_data apmixed_plls[] = {
+	PLL_SETCLR(CLK_APMIXED_ARMPLL_LL, "armpll-ll", ARMPLL_LL_CON0, setclr_data/*base*/,
+		18, 0, PLL_AO,
+		ARMPLL_LL_CON1, 24/*pd*/,
+		0, 0, 0/*tuner*/,
+		ARMPLL_LL_CON1, 0, 22/*pcw*/),
+	PLL_SETCLR(CLK_APMIXED_ARMPLL_BL, "armpll-bl", ARMPLL_BL_CON0, setclr_data/*base*/,
+		17, 0, PLL_AO,
+		ARMPLL_BL_CON1, 24/*pd*/,
+		0, 0, 0/*tuner*/,
+		ARMPLL_BL_CON1, 0, 22/*pcw*/),
+	PLL_SETCLR(CLK_APMIXED_CCIPLL, "ccipll", CCIPLL_CON0, setclr_data/*base*/,
+		16, 0, PLL_AO,
+		CCIPLL_CON1, 24/*pd*/,
+		0, 0, 0/*tuner*/,
+		CCIPLL_CON1, 0, 22/*pcw*/),
+	PLL_SETCLR(CLK_APMIXED_MAINPLL, "mainpll", MAINPLL_CON0, setclr_data/*base*/,
+		15, 2, HAVE_RST_BAR | PLL_AO,
+		MAINPLL_CON1, 24/*pd*/,
+		0, 0, 0/*tuner*/,
+		MAINPLL_CON1, 0, 22/*pcw*/),
+	PLL_SETCLR(CLK_APMIXED_UNIVPLL, "univpll", UNIVPLL_CON0, setclr_data/*base*/,
+		14, 1, HAVE_RST_BAR,
+		UNIVPLL_CON1, 24/*pd*/,
+		0, 0, 0/*tuner*/,
+		UNIVPLL_CON1, 0, 22/*pcw*/),
+	PLL_SETCLR(CLK_APMIXED_MMPLL, "mmpll", MMPLL_CON0, setclr_data/*base*/,
+		13, 0, HAVE_RST_BAR,
+		MMPLL_CON1, 24/*pd*/,
+		0, 0, 0/*tuner*/,
+		MMPLL_CON1, 0, 22/*pcw*/),
+	PLL_SETCLR(CLK_APMIXED_MFGPLL, "mfgpll", MFGPLL_CON0, setclr_data/*base*/,
+		7, 0, 0,
+		MFGPLL_CON1, 24/*pd*/,
+		0, 0, 0/*tuner*/,
+		MFGPLL_CON1, 0, 22/*pcw*/),
+	PLL_SETCLR(CLK_APMIXED_APLL1, "apll1", APLL1_CON0, setclr_data/*base*/,
+		11, 0, 0,
+		APLL1_CON1, 24/*pd*/,
+		APLL1_TUNER_CON0, AP_PLL_CON3, 0/*tuner*/,
+		APLL1_CON2, 0, 32/*pcw*/),
+	PLL_SETCLR(CLK_APMIXED_APLL2, "apll2", APLL2_CON0, setclr_data/*base*/,
+		10, 0, 0,
+		APLL2_CON1, 24/*pd*/,
+		APLL2_TUNER_CON0, AP_PLL_CON3, 1/*tuner*/,
+		APLL2_CON2, 0, 32/*pcw*/),
+	PLL_SETCLR(CLK_APMIXED_EMIPLL, "emipll", EMIPLL_CON0, setclr_data/*base*/,
+		12, 0, PLL_AO,
+		EMIPLL_CON1, 24/*pd*/,
+		0, 0, 0/*tuner*/,
+		EMIPLL_CON1, 0, 22/*pcw*/),
+	PLL_SETCLR(CLK_APMIXED_APUPLL2, "apupll2", APUPLL2_CON0, setclr_data/*base*/,
+		2, 0, 0,
+		APUPLL2_CON1, 24/*pd*/,
+		0, 0, 0/*tuner*/,
+		APUPLL2_CON1, 0, 22/*pcw*/),
+	PLL_SETCLR(CLK_APMIXED_APUPLL, "apupll", APUPLL_CON0, setclr_data/*base*/,
+		3, 0, 0,
+		APUPLL_CON1, 24/*pd*/,
+		0, 0, 0/*tuner*/,
+		APUPLL_CON1, 0, 22/*pcw*/),
+	PLL_SETCLR(CLK_APMIXED_TVDPLL1, "tvdpll1", TVDPLL1_CON0, setclr_data/*base*/,
+		9, 0, 0,
+		TVDPLL1_CON1, 24/*pd*/,
+		0, 0, 0/*tuner*/,
+		TVDPLL1_CON1, 0, 22/*pcw*/),
+	PLL_SETCLR(CLK_APMIXED_TVDPLL2, "tvdpll2", TVDPLL2_CON0, setclr_data/*base*/,
+		8, 0, 0,
+		TVDPLL2_CON1, 24/*pd*/,
+		0, 0, 0/*tuner*/,
+		TVDPLL2_CON1, 0, 22/*pcw*/),
+	PLL_SETCLR(CLK_APMIXED_ETHPLL, "ethpll", ETHPLL_CON0, setclr_data/*base*/,
+		6, 0, 0,
+		ETHPLL_CON1, 24/*pd*/,
+		0, 0, 0/*tuner*/,
+		ETHPLL_CON1, 0, 22/*pcw*/),
+	PLL_SETCLR(CLK_APMIXED_MSDCPLL, "msdcpll", MSDCPLL_CON0, setclr_data/*base*/,
+		5, 0, 0,
+		MSDCPLL_CON1, 24/*pd*/,
+		0, 0, 0/*tuner*/,
+		MSDCPLL_CON1, 0, 22/*pcw*/),
+	PLL_SETCLR(CLK_APMIXED_UFSPLL, "ufspll", UFSPLL_CON0, setclr_data/*base*/,
+		4, 0, 0,
+		UFSPLL_CON1, 24/*pd*/,
+		0, 0, 0/*tuner*/,
+		UFSPLL_CON1, 0, 22/*pcw*/),
+};
+
+static int clk_mt8189_pll_registration(enum subsys_id id,
+		const struct mtk_pll_data *plls,
+		struct platform_device *pdev,
+		int num_plls)
+{
+	struct clk_hw_onecell_data *clk_data;
+	int r;
+	struct device_node *node = pdev->dev.of_node;
+
+	void __iomem *base;
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s init begin\n", __func__);
+#endif
+
+	if (id >= PLL_SYS_NUM) {
+		pr_notice("%s init invalid id(%d)\n", __func__, id);
+		return 0;
+	}
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base)) {
+		pr_info("%s(): ioremap failed\n", __func__);
+		return PTR_ERR(base);
+	}
+
+	clk_data = mtk_alloc_clk_data(num_plls);
+
+	mtk_clk_register_plls(node, plls, num_plls,
+			clk_data);
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+
+	if (r)
+		pr_info("%s(): could not register clock provider: %d\n",
+			__func__, r);
+
+	plls_data[id] = plls;
+	plls_base[id] = base;
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s init end\n", __func__);
+#endif
+
+	return r;
+}
+
+static int clk_mt8189_apmixed_probe(struct platform_device *pdev)
+{
+	return clk_mt8189_pll_registration(APMIXEDSYS, apmixed_plls,
+			pdev, ARRAY_SIZE(apmixed_plls));
+}
+
+static int clk_mt8189_dbgao_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	int r;
+	struct device_node *node = pdev->dev.of_node;
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s init begin\n", __func__);
+#endif
+
+	clk_data = mtk_alloc_clk_data(CLK_DBGAO_NR_CLK);
+
+	mtk_clk_register_gates(&pdev->dev, node, dbgao_clks,
+			ARRAY_SIZE(dbgao_clks), clk_data);
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+
+	if (r)
+		pr_info("%s(): could not register clock provider: %d\n",
+			__func__, r);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s init end\n", __func__);
+#endif
+
+	return r;
+}
+
+static int clk_mt8189_dem_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	int r;
+	struct device_node *node = pdev->dev.of_node;
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s init begin\n", __func__);
+#endif
+
+	clk_data = mtk_alloc_clk_data(CLK_DEM_NR_CLK);
+
+	mtk_clk_register_gates(&pdev->dev, node, dem_clks,
+			ARRAY_SIZE(dem_clks), clk_data);
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+
+	if (r)
+		pr_info("%s(): could not register clock provider: %d\n",
+			__func__, r);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s init end\n", __func__);
+#endif
+
+	return r;
+}
+
+static int clk_mt8189_dvfsrc_top_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	int r;
+	struct device_node *node = pdev->dev.of_node;
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s init begin\n", __func__);
+#endif
+
+	clk_data = mtk_alloc_clk_data(CLK_DVFSRC_TOP_NR_CLK);
+
+	mtk_clk_register_gates(&pdev->dev, node, dvfsrc_top_clks,
+			ARRAY_SIZE(dvfsrc_top_clks), clk_data);
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+
+	if (r)
+		pr_info("%s(): could not register clock provider: %d\n",
+			__func__, r);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s init end\n", __func__);
+#endif
+
+	return r;
+}
+
+static int clk_mt8189_top_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	int r;
+	struct device_node *node = pdev->dev.of_node;
+
+	void __iomem *base;
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s init begin\n", __func__);
+#endif
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base)) {
+		pr_info("%s(): ioremap failed\n", __func__);
+		return PTR_ERR(base);
+	}
+
+	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+
+	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs),
+			clk_data);
+
+	mtk_clk_register_muxes(&pdev->dev, top_muxes, ARRAY_SIZE(top_muxes),
+			node, &mt8189_clk_lock, clk_data);
+
+	mtk_clk_register_gates(&pdev->dev, node, top_clks, ARRAY_SIZE(top_clks), clk_data);
+
+	mtk_clk_register_composites(&pdev->dev, top_composites, ARRAY_SIZE(top_composites),
+			base, &mt8189_clk_lock, clk_data);
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+
+	if (r)
+		pr_info("%s(): could not register clock provider: %d\n",
+			__func__, r);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s init end\n", __func__);
+#endif
+
+	return r;
+}
+
+static int clk_mt8189_vlpcfg_ao_reg_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	int r;
+	struct device_node *node = pdev->dev.of_node;
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s init begin\n", __func__);
+#endif
+
+	clk_data = mtk_alloc_clk_data(CLK_VLPCFG_AO_REG_NR_CLK);
+
+	mtk_clk_register_gates(&pdev->dev, node, vlpcfg_ao_reg_clks,
+			ARRAY_SIZE(vlpcfg_ao_reg_clks), clk_data);
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+
+	if (r)
+		pr_info("%s(): could not register clock provider: %d\n",
+			__func__, r);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s init end\n", __func__);
+#endif
+
+	return r;
+}
+
+static int clk_mt8189_vlp_ck_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	int r;
+	struct device_node *node = pdev->dev.of_node;
+
+	void __iomem *base;
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s init begin\n", __func__);
+#endif
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base)) {
+		pr_info("%s(): ioremap failed\n", __func__);
+		return PTR_ERR(base);
+	}
+
+	clk_data = mtk_alloc_clk_data(CLK_VLP_CK_NR_CLK);
+
+	mtk_clk_register_factors(vlp_ck_divs, ARRAY_SIZE(vlp_ck_divs),
+			clk_data);
+
+	mtk_clk_register_muxes(&pdev->dev, vlp_ck_muxes, ARRAY_SIZE(vlp_ck_muxes),
+			node, &mt8189_clk_lock, clk_data);
+
+	mtk_clk_register_gates(&pdev->dev, node, vlp_ck_clks,
+			ARRAY_SIZE(vlp_ck_clks), clk_data);
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+
+	if (r)
+		pr_info("%s(): could not register clock provider: %d\n",
+			__func__, r);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s init end\n", __func__);
+#endif
+
+	return r;
+}
+
+static int clk_mt8189_vlpcfg_reg_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	int r;
+	struct device_node *node = pdev->dev.of_node;
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s init begin\n", __func__);
+#endif
+
+	clk_data = mtk_alloc_clk_data(CLK_VLPCFG_REG_NR_CLK);
+
+	mtk_clk_register_gates(&pdev->dev, node, vlpcfg_reg_clks,
+			ARRAY_SIZE(vlpcfg_reg_clks), clk_data);
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+
+	if (r)
+		pr_info("%s(): could not register clock provider: %d\n",
+			__func__, r);
+
+#if MT_CCF_BRINGUP
+	pr_notice("%s init end\n", __func__);
+#endif
+
+	return r;
+}
+
+/* for suspend LDVT only */
+static void pll_force_off_internal(const struct mtk_pll_data *plls,
+		void __iomem *base)
+{
+	void __iomem *rst_reg, *en_reg, *pwr_reg;
+
+	for (; plls->name; plls++) {
+		/* do not pwrdn the AO PLLs */
+		if ((plls->flags & PLL_AO) == PLL_AO)
+			continue;
+
+		if ((plls->flags & HAVE_RST_BAR) == HAVE_RST_BAR) {
+			rst_reg = base + plls->en_reg;
+			writel(readl(rst_reg) & ~plls->rst_bar_mask,
+				rst_reg);
+		}
+
+		en_reg = base + plls->en_reg;
+
+		pwr_reg = base + plls->pwr_reg;
+
+		writel(readl(en_reg) & ~plls->en_mask,
+				en_reg);
+		writel(readl(pwr_reg) | (0x2),
+				pwr_reg);
+		writel(readl(pwr_reg) & ~(0x1),
+				pwr_reg);
+	}
+}
+
+void mt8189_pll_force_off(void)
+{
+	int i;
+
+	for (i = 0; i < PLL_SYS_NUM; i++)
+		pll_force_off_internal(plls_data[i], plls_base[i]);
+}
+EXPORT_SYMBOL_GPL(mt8189_pll_force_off);
+
+static const struct of_device_id of_match_clk_mt8189[] = {
+	{
+		.compatible = "mediatek,mt8189-apmixedsys",
+		.data = clk_mt8189_apmixed_probe,
+	}, {
+		.compatible = "mediatek,mt8189-dbg_ao",
+		.data = clk_mt8189_dbgao_probe,
+	}, {
+		.compatible = "mediatek,mt8189-dem",
+		.data = clk_mt8189_dem_probe,
+	}, {
+		.compatible = "mediatek,mt8189-dvfsrc_top",
+		.data = clk_mt8189_dvfsrc_top_probe,
+	}, {
+		.compatible = "mediatek,mt8189-topckgen",
+		.data = clk_mt8189_top_probe,
+	}, {
+		.compatible = "mediatek,mt8189-vlp_ao_ckgen",
+		.data = clk_mt8189_vlpcfg_ao_reg_probe,
+	}, {
+		.compatible = "mediatek,mt8189-vlpcfg_reg_bus",
+		.data = clk_mt8189_vlpcfg_reg_probe,
+	}, {
+		.compatible = "mediatek,mt8189-vlp_ckgen",
+		.data = clk_mt8189_vlp_ck_probe,
+	}, {
+		/* sentinel */
+	}
+};
+
+static int clk_mt8189_probe(struct platform_device *pdev)
+{
+	int (*clk_probe)(struct platform_device *pd);
+	int r;
+
+	clk_probe = of_device_get_match_data(&pdev->dev);
+	if (!clk_probe)
+		return -EINVAL;
+
+	r = clk_probe(pdev);
+	if (r)
+		dev_info(&pdev->dev,
+			"could not register clock provider: %s: %d\n",
+			pdev->name, r);
+
+	return r;
+}
+
+static struct platform_driver clk_mt8189_drv = {
+	.probe = clk_mt8189_probe,
+	.driver = {
+		.name = "clk-mt8189",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_clk_mt8189,
+	},
+};
+
+module_platform_driver(clk_mt8189_drv);
+MODULE_LICENSE("GPL");
+
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 14def9405abb..d254e5c10ff4 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -569,26 +575,12 @@ int mtk_clk_register_muxes(struct device *dev,
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register clk %s: %pe\n", mux->name,
 			       hw);
-			goto err;
+			continue;
 		}
-
 		clk_data->hws[mux->id] = hw;
 	}
 
 	return 0;
-
-err:
-	while (--i >= 0) {
-		const struct mtk_mux *mux = &muxes[i];
-
-		if (IS_ERR_OR_NULL(clk_data->hws[mux->id]))
-			continue;
-
-		mtk_clk_unregister_mux(clk_data->hws[mux->id]);
-		clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
-	}
-
-	return PTR_ERR(hw);
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_muxes);
 
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
index 1d1e1708cbcd..7889241ca28f 100644
--- a/drivers/clk/mediatek/clk-pll.h
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -23,9 +23,19 @@ struct mtk_pll_div_table {
 #define PLL_AO		BIT(1)
 #define POSTDIV_MASK	GENMASK(2, 0)
 
+struct mtk_pll_setclr_data {
+	uint16_t en_ofs;
+	uint16_t en_set_ofs;
+	uint16_t en_clr_ofs;
+	uint16_t rstb_ofs;
+	uint16_t rstb_set_ofs;
+	uint16_t rstb_clr_ofs;
+};
+
 struct mtk_pll_data {
 	int id;
 	const char *name;
+	struct mtk_pll_setclr_data *pll_setclr;
 	u32 reg;
 	u32 pwr_reg;
 	u32 en_mask;
diff --git a/drivers/clk/mediatek/clkchk-mt8189.c b/drivers/clk/mediatek/clkchk-mt8189.c
new file mode 100644
index 000000000000..b72cb3aa2c03
--- /dev/null
+++ b/drivers/clk/mediatek/clkchk-mt8189.c
@@ -0,0 +1,1550 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+#include <linux/spinlock.h>
+
+#include <dt-bindings/power/mt8189-power.h>
+
+#if IS_ENABLED(CONFIG_MTK_DVFSRC_HELPER)
+#include <mt-plat/dvfsrc-exp.h>
+#endif
+
+#include "clkchk.h"
+#include "clkchk-mt8189.h"
+#include "clk-fmeter.h"
+#include "clk-mt8189-fmeter.h"
+
+#define BUG_ON_CHK_ENABLE		0
+#define CHECK_VCORE_FREQ		0
+#define CG_CHK_PWRON_ENABLE		0
+
+#define EVT_LEN				40
+#define CLK_ID_SHIFT			0
+#define CLK_STA_SHIFT			8
+
+#define INV_MSK				0xFFFFFFFF
+
+static DEFINE_SPINLOCK(clk_trace_lock);
+static unsigned int clk_event[EVT_LEN];
+static unsigned int evt_cnt, suspend_cnt;
+
+/* trace all subsys cgs */
+enum {
+	CLK_AFE_DL0_DAC_TML_CG = 0,
+	CLK_AFE_DL0_DAC_HIRES_CG = 1,
+	CLK_AFE_DL0_DAC_CG = 2,
+	CLK_AFE_DL0_PREDIS_CG = 3,
+	CLK_AFE_DL0_NLE_CG = 4,
+	CLK_AFE_PCM0_CG = 5,
+	CLK_AFE_CM1_CG = 6,
+	CLK_AFE_CM0_CG = 7,
+	CLK_AFE_HW_GAIN23_CG = 8,
+	CLK_AFE_HW_GAIN01_CG = 9,
+	CLK_AFE_FM_I2S_CG = 10,
+	CLK_AFE_MTKAIFV4_CG = 11,
+	CLK_AFE_AUDIO_HOPPING_CG = 12,
+	CLK_AFE_AUDIO_F26M_CG = 13,
+	CLK_AFE_APLL1_CG = 14,
+	CLK_AFE_APLL2_CG = 15,
+	CLK_AFE_H208M_CG = 16,
+	CLK_AFE_APLL_TUNER2_CG = 17,
+	CLK_AFE_APLL_TUNER1_CG = 18,
+	CLK_AFE_DMIC1_ADC_HIRES_TML_CG = 19,
+	CLK_AFE_DMIC1_ADC_HIRES_CG = 20,
+	CLK_AFE_DMIC1_TML_CG = 21,
+	CLK_AFE_DMIC1_ADC_CG = 22,
+	CLK_AFE_DMIC0_ADC_HIRES_TML_CG = 23,
+	CLK_AFE_DMIC0_ADC_HIRES_CG = 24,
+	CLK_AFE_DMIC0_TML_CG = 25,
+	CLK_AFE_DMIC0_ADC_CG = 26,
+	CLK_AFE_UL0_ADC_HIRES_TML_CG = 27,
+	CLK_AFE_UL0_ADC_HIRES_CG = 28,
+	CLK_AFE_UL0_TML_CG = 29,
+	CLK_AFE_UL0_ADC_CG = 30,
+	CLK_AFE_ETDM_IN1_CG = 31,
+	CLK_AFE_ETDM_IN0_CG = 32,
+	CLK_AFE_ETDM_OUT4_CG = 33,
+	CLK_AFE_ETDM_OUT1_CG = 34,
+	CLK_AFE_ETDM_OUT0_CG = 35,
+	CLK_AFE_TDM_OUT_CG = 36,
+	CLK_AFE_GENERAL4_ASRC_CG = 37,
+	CLK_AFE_GENERAL3_ASRC_CG = 38,
+	CLK_AFE_GENERAL2_ASRC_CG = 39,
+	CLK_AFE_GENERAL1_ASRC_CG = 40,
+	CLK_AFE_GENERAL0_ASRC_CG = 41,
+	CLK_AFE_CONNSYS_I2S_ASRC_CG = 42,
+	CLK_VAD_CORE0_EN_CG = 43,
+	CLK_VAD_BUSEMI_EN_CG = 44,
+	CLK_VAD_TIMER_EN_CG = 45,
+	CLK_VAD_DMA0_EN_CG = 46,
+	CLK_VAD_UART_EN_CG = 47,
+	CLK_VAD_VOWPLL_EN_CG = 48,
+	CLK_VADSYS_26M_CG = 49,
+	CLK_VADSYS_BUS_CG = 50,
+	CLK_CAM_M_LARB13_CG = 51,
+	CLK_CAM_M_LARB14_CG = 52,
+	CLK_CAM_M_CAMSYS_MAIN_CAM_CG = 53,
+	CLK_CAM_M_CAMSYS_MAIN_CAMTG_CG = 54,
+	CLK_CAM_M_SENINF_CG = 55,
+	CLK_CAM_M_CAMSV1_CG = 56,
+	CLK_CAM_M_CAMSV2_CG = 57,
+	CLK_CAM_M_CAMSV3_CG = 58,
+	CLK_CAM_M_FAKE_ENG_CG = 59,
+	CLK_CAM_M_CAM2MM_GALS_CG = 60,
+	CLK_CAM_M_CAMSV4_CG = 61,
+	CLK_CAM_M_PDA_CG = 62,
+	CLK_CAM_RA_CAMSYS_RAWA_LARBX_CG = 63,
+	CLK_CAM_RA_CAMSYS_RAWA_CAM_CG = 64,
+	CLK_CAM_RA_CAMSYS_RAWA_CAMTG_CG = 65,
+	CLK_CAM_RB_CAMSYS_RAWB_LARBX_CG = 66,
+	CLK_CAM_RB_CAMSYS_RAWB_CAM_CG = 67,
+	CLK_CAM_RB_CAMSYS_RAWB_CAMTG_CG = 68,
+	CLK_MM_DISP_OVL0_4L_CG = 69,
+	CLK_MM_DISP_OVL1_4L_CG = 70,
+	CLK_MM_VPP_RSZ0_CG = 71,
+	CLK_MM_VPP_RSZ1_CG = 72,
+	CLK_MM_DISP_RDMA0_CG = 73,
+	CLK_MM_DISP_RDMA1_CG = 74,
+	CLK_MM_DISP_COLOR0_CG = 75,
+	CLK_MM_DISP_COLOR1_CG = 76,
+	CLK_MM_DISP_CCORR0_CG = 77,
+	CLK_MM_DISP_CCORR1_CG = 78,
+	CLK_MM_DISP_CCORR2_CG = 79,
+	CLK_MM_DISP_CCORR3_CG = 80,
+	CLK_MM_DISP_AAL0_CG = 81,
+	CLK_MM_DISP_AAL1_CG = 82,
+	CLK_MM_DISP_GAMMA0_CG = 83,
+	CLK_MM_DISP_GAMMA1_CG = 84,
+	CLK_MM_DISP_DITHER0_CG = 85,
+	CLK_MM_DISP_DITHER1_CG = 86,
+	CLK_MM_DISP_DSC_WRAP0_CG = 87,
+	CLK_MM_VPP_MERGE0_CG = 88,
+	CLK_MMSYS_0_DISP_DVO_CG = 89,
+	CLK_MMSYS_0_DISP_DSI0_CG = 90,
+	CLK_MM_DP_INTF0_CG = 91,
+	CLK_MM_DISP_WDMA0_CG = 92,
+	CLK_MM_DISP_WDMA1_CG = 93,
+	CLK_MM_DISP_FAKE_ENG0_CG = 94,
+	CLK_MM_DISP_FAKE_ENG1_CG = 95,
+	CLK_MM_SMI_LARB_CG = 96,
+	CLK_MM_DISP_MUTEX0_CG = 97,
+	CLK_MM_DIPSYS_CONFIG_CG = 98,
+	CLK_MM_DUMMY_CG = 99,
+	CLK_MMSYS_1_DISP_DSI0_CG = 100,
+	CLK_MMSYS_1_LVDS_ENCODER_CG = 101,
+	CLK_MMSYS_1_DISP_DVO_CG = 102,
+	CLK_MM_DP_INTF_CG = 103,
+	CLK_MMSYS_1_LVDS_ENCODER_CTS_CG = 104,
+	CLK_MMSYS_1_DISP_DVO_AVT_CG = 105,
+	CLK_GCE_D_TOP_CG = 106,
+	CLK_GCE_M_TOP_CG = 107,
+	CLK_MMINFRA_GCE_D_CG = 108,
+	CLK_MMINFRA_GCE_M_CG = 109,
+	CLK_MMINFRA_SMI_CG = 110,
+	CLK_MMINFRA_GCE_26M_CG = 111,
+	CLK_IMGSYS1_LARB9_CG = 112,
+	CLK_IMGSYS1_LARB11_CG = 113,
+	CLK_IMGSYS1_DIP_CG = 114,
+	CLK_IMGSYS1_GALS_CG = 115,
+	CLK_IMGSYS2_LARB9_CG = 116,
+	CLK_IMGSYS2_LARB11_CG = 117,
+	CLK_IMGSYS2_MFB_CG = 118,
+	CLK_IMGSYS2_WPE_CG = 119,
+	CLK_IMGSYS2_MSS_CG = 120,
+	CLK_IMGSYS2_GALS_CG = 121,
+	CLK_IPE_LARB19_CG = 122,
+	CLK_IPE_LARB20_CG = 123,
+	CLK_IPE_SMI_SUBCOM_CG = 124,
+	CLK_IPE_FD_CG = 125,
+	CLK_IPE_FE_CG = 126,
+	CLK_IPE_RSC_CG = 127,
+	CLK_IPESYS_GALS_CG = 128,
+	CLK_IMPE_I2C0_CG = 129,
+	CLK_IMPE_I2C1_CG = 130,
+	CLK_IMPEN_I2C7_CG = 131,
+	CLK_IMPEN_I2C8_CG = 132,
+	CLK_IMPS_I2C3_CG = 133,
+	CLK_IMPS_I2C4_CG = 134,
+	CLK_IMPS_I2C5_CG = 135,
+	CLK_IMPS_I2C6_CG = 136,
+	CLK_IMPWS_I2C2_CG = 137,
+	CLK_IFRAO_CQ_DMA_FPC_CG = 138,
+	CLK_IFRAO_DEBUGSYS_CG = 139,
+	CLK_IFRAO_DBG_TRACE_CG = 140,
+	CLK_IFRAO_CQ_DMA_CG = 141,
+	CLK_PERAO_UART0_CG = 142,
+	CLK_PERAO_UART1_CG = 143,
+	CLK_PERAO_UART2_CG = 144,
+	CLK_PERAO_UART3_CG = 145,
+	CLK_PERAO_PWM_H_CG = 146,
+	CLK_PERAO_PWM_B_CG = 147,
+	CLK_PERAO_PWM_FB1_CG = 148,
+	CLK_PERAO_PWM_FB2_CG = 149,
+	CLK_PERAO_PWM_FB3_CG = 150,
+	CLK_PERAO_PWM_FB4_CG = 151,
+	CLK_PERAO_DISP_PWM0_CG = 152,
+	CLK_PERAO_DISP_PWM1_CG = 153,
+	CLK_PERAO_SPI0_B_CG = 154,
+	CLK_PERAO_SPI1_B_CG = 155,
+	CLK_PERAO_SPI2_B_CG = 156,
+	CLK_PERAO_SPI3_B_CG = 157,
+	CLK_PERAO_SPI4_B_CG = 158,
+	CLK_PERAO_SPI5_B_CG = 159,
+	CLK_PERAO_SPI0_H_CG = 160,
+	CLK_PERAO_SPI1_H_CG = 161,
+	CLK_PERAO_SPI2_H_CG = 162,
+	CLK_PERAO_SPI3_H_CG = 163,
+	CLK_PERAO_SPI4_H_CG = 164,
+	CLK_PERAO_SPI5_H_CG = 165,
+	CLK_PERAO_AXI_CG = 166,
+	CLK_PERAO_AHB_APB_CG = 167,
+	CLK_PERAO_TL_CG = 168,
+	CLK_PERAO_REF_CG = 169,
+	CLK_PERAO_I2C_CG = 170,
+	CLK_PERAO_DMA_B_CG = 171,
+	CLK_PERAO_SSUSB0_REF_CG = 172,
+	CLK_PERAO_SSUSB0_FRMCNT_CG = 173,
+	CLK_PERAO_SSUSB0_SYS_CG = 174,
+	CLK_PERAO_SSUSB0_XHCI_CG = 175,
+	CLK_PERAO_SSUSB0_F_CG = 176,
+	CLK_PERAO_SSUSB0_H_CG = 177,
+	CLK_PERAO_SSUSB1_REF_CG = 178,
+	CLK_PERAO_SSUSB1_FRMCNT_CG = 179,
+	CLK_PERAO_SSUSB1_SYS_CG = 180,
+	CLK_PERAO_SSUSB1_XHCI_CG = 181,
+	CLK_PERAO_SSUSB1_F_CG = 182,
+	CLK_PERAO_SSUSB1_H_CG = 183,
+	CLK_PERAO_SSUSB2_REF_CG = 184,
+	CLK_PERAO_SSUSB2_FRMCNT_CG = 185,
+	CLK_PERAO_SSUSB2_SYS_CG = 186,
+	CLK_PERAO_SSUSB2_XHCI_CG = 187,
+	CLK_PERAO_SSUSB2_F_CG = 188,
+	CLK_PERAO_SSUSB2_H_CG = 189,
+	CLK_PERAO_SSUSB3_REF_CG = 190,
+	CLK_PERAO_SSUSB3_FRMCNT_CG = 191,
+	CLK_PERAO_SSUSB3_SYS_CG = 192,
+	CLK_PERAO_SSUSB3_XHCI_CG = 193,
+	CLK_PERAO_SSUSB3_F_CG = 194,
+	CLK_PERAO_SSUSB3_H_CG = 195,
+	CLK_PERAO_SSUSB4_REF_CG = 196,
+	CLK_PERAO_SSUSB4_FRMCNT_CG = 197,
+	CLK_PERAO_SSUSB4_SYS_CG = 198,
+	CLK_PERAO_SSUSB4_XHCI_CG = 199,
+	CLK_PERAO_SSUSB4_F_CG = 200,
+	CLK_PERAO_SSUSB4_H_CG = 201,
+	CLK_PERAO_MSDC0_CG = 202,
+	CLK_PERAO_MSDC0_H_CG = 203,
+	CLK_PERAO_MSDC0_FAES_CG = 204,
+	CLK_PERAO_MSDC0_MST_F_CG = 205,
+	CLK_PERAO_MSDC0_SLV_H_CG = 206,
+	CLK_PERAO_MSDC1_CG = 207,
+	CLK_PERAO_MSDC1_H_CG = 208,
+	CLK_PERAO_MSDC1_MST_F_CG = 209,
+	CLK_PERAO_MSDC1_SLV_H_CG = 210,
+	CLK_PERAO_MSDC2_CG = 211,
+	CLK_PERAO_MSDC2_H_CG = 212,
+	CLK_PERAO_MSDC2_MST_F_CG = 213,
+	CLK_PERAO_MSDC2_SLV_H_CG = 214,
+	CLK_PERAO_SFLASH_CG = 215,
+	CLK_PERAO_SFLASH_F_CG = 216,
+	CLK_PERAO_SFLASH_H_CG = 217,
+	CLK_PERAO_SFLASH_P_CG = 218,
+	CLK_PERAO_AUDIO0_CG = 219,
+	CLK_PERAO_AUDIO1_CG = 220,
+	CLK_PERAO_AUDIO2_CG = 221,
+	CLK_PERAO_AUXADC_26M_CG = 222,
+	CLK_MDP_MUTEX0_CG = 223,
+	CLK_MDP_APB_BUS_CG = 224,
+	CLK_MDP_SMI0_CG = 225,
+	CLK_MDP_RDMA0_CG = 226,
+	CLK_MDP_RDMA2_CG = 227,
+	CLK_MDP_HDR0_CG = 228,
+	CLK_MDP_AAL0_CG = 229,
+	CLK_MDP_RSZ0_CG = 230,
+	CLK_MDP_TDSHP0_CG = 231,
+	CLK_MDP_COLOR0_CG = 232,
+	CLK_MDP_WROT0_CG = 233,
+	CLK_MDP_FAKE_ENG0_CG = 234,
+	CLK_MDPSYS_CONFIG_CG = 235,
+	CLK_MDP_RDMA1_CG = 236,
+	CLK_MDP_RDMA3_CG = 237,
+	CLK_MDP_HDR1_CG = 238,
+	CLK_MDP_AAL1_CG = 239,
+	CLK_MDP_RSZ1_CG = 240,
+	CLK_MDP_TDSHP1_CG = 241,
+	CLK_MDP_COLOR1_CG = 242,
+	CLK_MDP_WROT1_CG = 243,
+	CLK_MDP_RSZ2_CG = 244,
+	CLK_MDP_WROT2_CG = 245,
+	CLK_MDP_RSZ3_CG = 246,
+	CLK_MDP_WROT3_CG = 247,
+	CLK_MDP_BIRSZ0_CG = 248,
+	CLK_MDP_BIRSZ1_CG = 249,
+	CLK_MFG_BG3D_CG = 250,
+	CLK_SCP_SET_SPI0_CG = 251,
+	CLK_SCP_SET_SPI1_CG = 252,
+	CLK_SCP_IIC_I2C0_W1S_CG = 253,
+	CLK_SCP_IIC_I2C1_W1S_CG = 254,
+	CLK_UFSCFG_AO_REG_UNIPRO_TX_SYM_CG = 255,
+	CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM0_CG = 256,
+	CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM1_CG = 257,
+	CLK_UFSCFG_AO_REG_UNIPRO_SYS_CG = 258,
+	CLK_UFSCFG_AO_REG_U_SAP_CFG_CG = 259,
+	CLK_UFSCFG_AO_REG_U_PHY_TOP_AHB_S_BUS_CG = 260,
+	CLK_UFSCFG_REG_UFSHCI_UFS_CG = 261,
+	CLK_UFSCFG_REG_UFSHCI_AES_CG = 262,
+	CLK_UFSCFG_REG_UFSHCI_U_AHB_CG = 263,
+	CLK_UFSCFG_REG_UFSHCI_U_AXI_CG = 264,
+	CLK_VDEC_CORE_VDEC_CKEN_CG = 265,
+	CLK_VDEC_CORE_VDEC_ACTIVE_CG = 266,
+	CLK_VDEC_CORE_LARB_CKEN_CG = 267,
+	CLK_VEN1_CKE0_LARB_CG = 268,
+	CLK_VEN1_CKE1_VENC_CG = 269,
+	CLK_VEN1_CKE2_JPGENC_CG = 270,
+	CLK_VEN1_CKE3_JPGDEC_CG = 271,
+	CLK_VEN1_CKE4_JPGDEC_C1_CG = 272,
+	CLK_VEN1_CKE5_GALS_CG = 273,
+	CLK_VEN1_CKE6_GALS_SRAM_CG = 274,
+	TRACE_CLK_NUM = 275,
+};
+
+const char *trace_subsys_cgs[] = {
+	[CLK_AFE_DL0_DAC_TML_CG] = "afe_dl0_dac_tml",
+	[CLK_AFE_DL0_DAC_HIRES_CG] = "afe_dl0_dac_hires",
+	[CLK_AFE_DL0_DAC_CG] = "afe_dl0_dac",
+	[CLK_AFE_DL0_PREDIS_CG] = "afe_dl0_predis",
+	[CLK_AFE_DL0_NLE_CG] = "afe_dl0_nle",
+	[CLK_AFE_PCM0_CG] = "afe_pcm0",
+	[CLK_AFE_CM1_CG] = "afe_cm1",
+	[CLK_AFE_CM0_CG] = "afe_cm0",
+	[CLK_AFE_HW_GAIN23_CG] = "afe_hw_gain23",
+	[CLK_AFE_HW_GAIN01_CG] = "afe_hw_gain01",
+	[CLK_AFE_FM_I2S_CG] = "afe_fm_i2s",
+	[CLK_AFE_MTKAIFV4_CG] = "afe_mtkaifv4",
+	[CLK_AFE_AUDIO_HOPPING_CG] = "afe_audio_hopping_ck",
+	[CLK_AFE_AUDIO_F26M_CG] = "afe_audio_f26m_ck",
+	[CLK_AFE_APLL1_CG] = "afe_apll1_ck",
+	[CLK_AFE_APLL2_CG] = "afe_apll2_ck",
+	[CLK_AFE_H208M_CG] = "afe_h208m_ck",
+	[CLK_AFE_APLL_TUNER2_CG] = "afe_apll_tuner2",
+	[CLK_AFE_APLL_TUNER1_CG] = "afe_apll_tuner1",
+	[CLK_AFE_DMIC1_ADC_HIRES_TML_CG] = "afe_dmic1_aht",
+	[CLK_AFE_DMIC1_ADC_HIRES_CG] = "afe_dmic1_adc_hires",
+	[CLK_AFE_DMIC1_TML_CG] = "afe_dmic1_tml",
+	[CLK_AFE_DMIC1_ADC_CG] = "afe_dmic1_adc",
+	[CLK_AFE_DMIC0_ADC_HIRES_TML_CG] = "afe_dmic0_aht",
+	[CLK_AFE_DMIC0_ADC_HIRES_CG] = "afe_dmic0_adc_hires",
+	[CLK_AFE_DMIC0_TML_CG] = "afe_dmic0_tml",
+	[CLK_AFE_DMIC0_ADC_CG] = "afe_dmic0_adc",
+	[CLK_AFE_UL0_ADC_HIRES_TML_CG] = "afe_ul0_aht",
+	[CLK_AFE_UL0_ADC_HIRES_CG] = "afe_ul0_adc_hires",
+	[CLK_AFE_UL0_TML_CG] = "afe_ul0_tml",
+	[CLK_AFE_UL0_ADC_CG] = "afe_ul0_adc",
+	[CLK_AFE_ETDM_IN1_CG] = "afe_etdm_in1",
+	[CLK_AFE_ETDM_IN0_CG] = "afe_etdm_in0",
+	[CLK_AFE_ETDM_OUT4_CG] = "afe_etdm_out4",
+	[CLK_AFE_ETDM_OUT1_CG] = "afe_etdm_out1",
+	[CLK_AFE_ETDM_OUT0_CG] = "afe_etdm_out0",
+	[CLK_AFE_TDM_OUT_CG] = "afe_tdm_out",
+	[CLK_AFE_GENERAL4_ASRC_CG] = "afe_general4_asrc",
+	[CLK_AFE_GENERAL3_ASRC_CG] = "afe_general3_asrc",
+	[CLK_AFE_GENERAL2_ASRC_CG] = "afe_general2_asrc",
+	[CLK_AFE_GENERAL1_ASRC_CG] = "afe_general1_asrc",
+	[CLK_AFE_GENERAL0_ASRC_CG] = "afe_general0_asrc",
+	[CLK_AFE_CONNSYS_I2S_ASRC_CG] = "afe_connsys_i2s_asrc",
+	[CLK_VAD_CORE0_EN_CG] = "vad_core0",
+	[CLK_VAD_BUSEMI_EN_CG] = "vad_busemi_en",
+	[CLK_VAD_TIMER_EN_CG] = "vad_timer_en",
+	[CLK_VAD_DMA0_EN_CG] = "vad_dma0_en",
+	[CLK_VAD_UART_EN_CG] = "vad_uart_en",
+	[CLK_VAD_VOWPLL_EN_CG] = "vad_vowpll_en",
+	[CLK_VADSYS_26M_CG] = "vadsys_26m",
+	[CLK_VADSYS_BUS_CG] = "vadsys_bus",
+	[CLK_CAM_M_LARB13_CG] = "cam_m_larb13",
+	[CLK_CAM_M_LARB14_CG] = "cam_m_larb14",
+	[CLK_CAM_M_CAMSYS_MAIN_CAM_CG] = "cam_m_camsys_main_cam",
+	[CLK_CAM_M_CAMSYS_MAIN_CAMTG_CG] = "cam_m_camsys_main_camtg",
+	[CLK_CAM_M_SENINF_CG] = "cam_m_seninf",
+	[CLK_CAM_M_CAMSV1_CG] = "cam_m_camsv1",
+	[CLK_CAM_M_CAMSV2_CG] = "cam_m_camsv2",
+	[CLK_CAM_M_CAMSV3_CG] = "cam_m_camsv3",
+	[CLK_CAM_M_FAKE_ENG_CG] = "cam_m_fake_eng",
+	[CLK_CAM_M_CAM2MM_GALS_CG] = "cam_m_cam2mm_gals",
+	[CLK_CAM_M_CAMSV4_CG] = "cam_m_camsv4",
+	[CLK_CAM_M_PDA_CG] = "cam_m_pda",
+	[CLK_CAM_RA_CAMSYS_RAWA_LARBX_CG] = "cam_ra_camsys_rawa_larbx",
+	[CLK_CAM_RA_CAMSYS_RAWA_CAM_CG] = "cam_ra_camsys_rawa_cam",
+	[CLK_CAM_RA_CAMSYS_RAWA_CAMTG_CG] = "cam_ra_camsys_rawa_camtg",
+	[CLK_CAM_RB_CAMSYS_RAWB_LARBX_CG] = "cam_rb_camsys_rawb_larbx",
+	[CLK_CAM_RB_CAMSYS_RAWB_CAM_CG] = "cam_rb_camsys_rawb_cam",
+	[CLK_CAM_RB_CAMSYS_RAWB_CAMTG_CG] = "cam_rb_camsys_rawb_camtg",
+	[CLK_MM_DISP_OVL0_4L_CG] = "mm_disp_ovl0_4l",
+	[CLK_MM_DISP_OVL1_4L_CG] = "mm_disp_ovl1_4l",
+	[CLK_MM_VPP_RSZ0_CG] = "mm_vpp_rsz0",
+	[CLK_MM_VPP_RSZ1_CG] = "mm_vpp_rsz1",
+	[CLK_MM_DISP_RDMA0_CG] = "mm_disp_rdma0",
+	[CLK_MM_DISP_RDMA1_CG] = "mm_disp_rdma1",
+	[CLK_MM_DISP_COLOR0_CG] = "mm_disp_color0",
+	[CLK_MM_DISP_COLOR1_CG] = "mm_disp_color1",
+	[CLK_MM_DISP_CCORR0_CG] = "mm_disp_ccorr0",
+	[CLK_MM_DISP_CCORR1_CG] = "mm_disp_ccorr1",
+	[CLK_MM_DISP_CCORR2_CG] = "mm_disp_ccorr2",
+	[CLK_MM_DISP_CCORR3_CG] = "mm_disp_ccorr3",
+	[CLK_MM_DISP_AAL0_CG] = "mm_disp_aal0",
+	[CLK_MM_DISP_AAL1_CG] = "mm_disp_aal1",
+	[CLK_MM_DISP_GAMMA0_CG] = "mm_disp_gamma0",
+	[CLK_MM_DISP_GAMMA1_CG] = "mm_disp_gamma1",
+	[CLK_MM_DISP_DITHER0_CG] = "mm_disp_dither0",
+	[CLK_MM_DISP_DITHER1_CG] = "mm_disp_dither1",
+	[CLK_MM_DISP_DSC_WRAP0_CG] = "mm_disp_dsc_wrap0",
+	[CLK_MM_VPP_MERGE0_CG] = "mm_vpp_merge0",
+	[CLK_MMSYS_0_DISP_DVO_CG] = "mmsys_0_disp_dvo",
+	[CLK_MMSYS_0_DISP_DSI0_CG] = "mmsys_0_CLK0",
+	[CLK_MM_DP_INTF0_CG] = "mm_dp_intf0",
+	[CLK_MM_DISP_WDMA0_CG] = "mm_disp_wdma0",
+	[CLK_MM_DISP_WDMA1_CG] = "mm_disp_wdma1",
+	[CLK_MM_DISP_FAKE_ENG0_CG] = "mm_disp_fake_eng0",
+	[CLK_MM_DISP_FAKE_ENG1_CG] = "mm_disp_fake_eng1",
+	[CLK_MM_SMI_LARB_CG] = "mm_smi_larb",
+	[CLK_MM_DISP_MUTEX0_CG] = "mm_disp_mutex0",
+	[CLK_MM_DIPSYS_CONFIG_CG] = "mm_dipsys_config",
+	[CLK_MM_DUMMY_CG] = "mm_dummy",
+	[CLK_MMSYS_1_DISP_DSI0_CG] = "mmsys_1_CLK0",
+	[CLK_MMSYS_1_LVDS_ENCODER_CG] = "mmsys_1_lvds_encoder",
+	[CLK_MMSYS_1_DISP_DVO_CG] = "mmsys_1_disp_dvo",
+	[CLK_MM_DP_INTF_CG] = "mm_dp_intf",
+	[CLK_MMSYS_1_LVDS_ENCODER_CTS_CG] = "mmsys_1_lvds_encoder_cts",
+	[CLK_MMSYS_1_DISP_DVO_AVT_CG] = "mmsys_1_disp_dvo_avt",
+	[CLK_GCE_D_TOP_CG] = "gce_d_top",
+	[CLK_GCE_M_TOP_CG] = "gce_m_top",
+	[CLK_MMINFRA_GCE_D_CG] = "mminfra_gce_d",
+	[CLK_MMINFRA_GCE_M_CG] = "mminfra_gce_m",
+	[CLK_MMINFRA_SMI_CG] = "mminfra_smi",
+	[CLK_MMINFRA_GCE_26M_CG] = "mminfra_gce_26m",
+	[CLK_IMGSYS1_LARB9_CG] = "imgsys1_larb9",
+	[CLK_IMGSYS1_LARB11_CG] = "imgsys1_larb11",
+	[CLK_IMGSYS1_DIP_CG] = "imgsys1_dip",
+	[CLK_IMGSYS1_GALS_CG] = "imgsys1_gals",
+	[CLK_IMGSYS2_LARB9_CG] = "imgsys2_larb9",
+	[CLK_IMGSYS2_LARB11_CG] = "imgsys2_larb11",
+	[CLK_IMGSYS2_MFB_CG] = "imgsys2_mfb",
+	[CLK_IMGSYS2_WPE_CG] = "imgsys2_wpe",
+	[CLK_IMGSYS2_MSS_CG] = "imgsys2_mss",
+	[CLK_IMGSYS2_GALS_CG] = "imgsys2_gals",
+	[CLK_IPE_LARB19_CG] = "ipe_larb19",
+	[CLK_IPE_LARB20_CG] = "ipe_larb20",
+	[CLK_IPE_SMI_SUBCOM_CG] = "ipe_smi_subcom",
+	[CLK_IPE_FD_CG] = "ipe_fd",
+	[CLK_IPE_FE_CG] = "ipe_fe",
+	[CLK_IPE_RSC_CG] = "ipe_rsc",
+	[CLK_IPESYS_GALS_CG] = "ipesys_gals",
+	[CLK_IMPE_I2C0_CG] = "impe_i2c0",
+	[CLK_IMPE_I2C1_CG] = "impe_i2c1",
+	[CLK_IMPEN_I2C7_CG] = "impen_i2c7",
+	[CLK_IMPEN_I2C8_CG] = "impen_i2c8",
+	[CLK_IMPS_I2C3_CG] = "imps_i2c3",
+	[CLK_IMPS_I2C4_CG] = "imps_i2c4",
+	[CLK_IMPS_I2C5_CG] = "imps_i2c5",
+	[CLK_IMPS_I2C6_CG] = "imps_i2c6",
+	[CLK_IMPWS_I2C2_CG] = "impws_i2c2",
+	[CLK_IFRAO_CQ_DMA_FPC_CG] = "ifrao_dma",
+	[CLK_IFRAO_DEBUGSYS_CG] = "ifrao_debugsys",
+	[CLK_IFRAO_DBG_TRACE_CG] = "ifrao_dbg_trace",
+	[CLK_IFRAO_CQ_DMA_CG] = "ifrao_cq_dma",
+	[CLK_PERAO_UART0_CG] = "perao_uart0",
+	[CLK_PERAO_UART1_CG] = "perao_uart1",
+	[CLK_PERAO_UART2_CG] = "perao_uart2",
+	[CLK_PERAO_UART3_CG] = "perao_uart3",
+	[CLK_PERAO_PWM_H_CG] = "perao_pwm_h",
+	[CLK_PERAO_PWM_B_CG] = "perao_pwm_b",
+	[CLK_PERAO_PWM_FB1_CG] = "perao_pwm_fb1",
+	[CLK_PERAO_PWM_FB2_CG] = "perao_pwm_fb2",
+	[CLK_PERAO_PWM_FB3_CG] = "perao_pwm_fb3",
+	[CLK_PERAO_PWM_FB4_CG] = "perao_pwm_fb4",
+	[CLK_PERAO_DISP_PWM0_CG] = "perao_disp_pwm0",
+	[CLK_PERAO_DISP_PWM1_CG] = "perao_disp_pwm1",
+	[CLK_PERAO_SPI0_B_CG] = "perao_spi0_b",
+	[CLK_PERAO_SPI1_B_CG] = "perao_spi1_b",
+	[CLK_PERAO_SPI2_B_CG] = "perao_spi2_b",
+	[CLK_PERAO_SPI3_B_CG] = "perao_spi3_b",
+	[CLK_PERAO_SPI4_B_CG] = "perao_spi4_b",
+	[CLK_PERAO_SPI5_B_CG] = "perao_spi5_b",
+	[CLK_PERAO_SPI0_H_CG] = "perao_spi0_h",
+	[CLK_PERAO_SPI1_H_CG] = "perao_spi1_h",
+	[CLK_PERAO_SPI2_H_CG] = "perao_spi2_h",
+	[CLK_PERAO_SPI3_H_CG] = "perao_spi3_h",
+	[CLK_PERAO_SPI4_H_CG] = "perao_spi4_h",
+	[CLK_PERAO_SPI5_H_CG] = "perao_spi5_h",
+	[CLK_PERAO_AXI_CG] = "perao_axi",
+	[CLK_PERAO_AHB_APB_CG] = "perao_ahb_apb",
+	[CLK_PERAO_TL_CG] = "perao_tl",
+	[CLK_PERAO_REF_CG] = "perao_ref",
+	[CLK_PERAO_I2C_CG] = "perao_i2c",
+	[CLK_PERAO_DMA_B_CG] = "perao_dma_b",
+	[CLK_PERAO_SSUSB0_REF_CG] = "perao_ssusb0_ref",
+	[CLK_PERAO_SSUSB0_FRMCNT_CG] = "perao_ssusb0_frmcnt",
+	[CLK_PERAO_SSUSB0_SYS_CG] = "perao_ssusb0_sys",
+	[CLK_PERAO_SSUSB0_XHCI_CG] = "perao_ssusb0_xhci",
+	[CLK_PERAO_SSUSB0_F_CG] = "perao_ssusb0_f",
+	[CLK_PERAO_SSUSB0_H_CG] = "perao_ssusb0_h",
+	[CLK_PERAO_SSUSB1_REF_CG] = "perao_ssusb1_ref",
+	[CLK_PERAO_SSUSB1_FRMCNT_CG] = "perao_ssusb1_frmcnt",
+	[CLK_PERAO_SSUSB1_SYS_CG] = "perao_ssusb1_sys",
+	[CLK_PERAO_SSUSB1_XHCI_CG] = "perao_ssusb1_xhci",
+	[CLK_PERAO_SSUSB1_F_CG] = "perao_ssusb1_f",
+	[CLK_PERAO_SSUSB1_H_CG] = "perao_ssusb1_h",
+	[CLK_PERAO_SSUSB2_REF_CG] = "perao_ssusb2_ref",
+	[CLK_PERAO_SSUSB2_FRMCNT_CG] = "perao_ssusb2_frmcnt",
+	[CLK_PERAO_SSUSB2_SYS_CG] = "perao_ssusb2_sys",
+	[CLK_PERAO_SSUSB2_XHCI_CG] = "perao_ssusb2_xhci",
+	[CLK_PERAO_SSUSB2_F_CG] = "perao_ssusb2_f",
+	[CLK_PERAO_SSUSB2_H_CG] = "perao_ssusb2_h",
+	[CLK_PERAO_SSUSB3_REF_CG] = "perao_ssusb3_ref",
+	[CLK_PERAO_SSUSB3_FRMCNT_CG] = "perao_ssusb3_frmcnt",
+	[CLK_PERAO_SSUSB3_SYS_CG] = "perao_ssusb3_sys",
+	[CLK_PERAO_SSUSB3_XHCI_CG] = "perao_ssusb3_xhci",
+	[CLK_PERAO_SSUSB3_F_CG] = "perao_ssusb3_f",
+	[CLK_PERAO_SSUSB3_H_CG] = "perao_ssusb3_h",
+	[CLK_PERAO_SSUSB4_REF_CG] = "perao_ssusb4_ref",
+	[CLK_PERAO_SSUSB4_FRMCNT_CG] = "perao_ssusb4_frmcnt",
+	[CLK_PERAO_SSUSB4_SYS_CG] = "perao_ssusb4_sys",
+	[CLK_PERAO_SSUSB4_XHCI_CG] = "perao_ssusb4_xhci",
+	[CLK_PERAO_SSUSB4_F_CG] = "perao_ssusb4_f",
+	[CLK_PERAO_SSUSB4_H_CG] = "perao_ssusb4_h",
+	[CLK_PERAO_MSDC0_CG] = "perao_msdc0",
+	[CLK_PERAO_MSDC0_H_CG] = "perao_msdc0_h",
+	[CLK_PERAO_MSDC0_FAES_CG] = "perao_msdc0_faes",
+	[CLK_PERAO_MSDC0_MST_F_CG] = "perao_msdc0_mst_f",
+	[CLK_PERAO_MSDC0_SLV_H_CG] = "perao_msdc0_slv_h",
+	[CLK_PERAO_MSDC1_CG] = "perao_msdc1",
+	[CLK_PERAO_MSDC1_H_CG] = "perao_msdc1_h",
+	[CLK_PERAO_MSDC1_MST_F_CG] = "perao_msdc1_mst_f",
+	[CLK_PERAO_MSDC1_SLV_H_CG] = "perao_msdc1_slv_h",
+	[CLK_PERAO_MSDC2_CG] = "perao_msdc2",
+	[CLK_PERAO_MSDC2_H_CG] = "perao_msdc2_h",
+	[CLK_PERAO_MSDC2_MST_F_CG] = "perao_msdc2_mst_f",
+	[CLK_PERAO_MSDC2_SLV_H_CG] = "perao_msdc2_slv_h",
+	[CLK_PERAO_SFLASH_CG] = "perao_sflash",
+	[CLK_PERAO_SFLASH_F_CG] = "perao_sflash_f",
+	[CLK_PERAO_SFLASH_H_CG] = "perao_sflash_h",
+	[CLK_PERAO_SFLASH_P_CG] = "perao_sflash_p",
+	[CLK_PERAO_AUDIO0_CG] = "perao_audio0",
+	[CLK_PERAO_AUDIO1_CG] = "perao_audio1",
+	[CLK_PERAO_AUDIO2_CG] = "perao_audio2",
+	[CLK_PERAO_AUXADC_26M_CG] = "perao_auxadc_26m",
+	[CLK_MDP_MUTEX0_CG] = "mdp_mutex0",
+	[CLK_MDP_APB_BUS_CG] = "mdp_apb_bus",
+	[CLK_MDP_SMI0_CG] = "mdp_smi0",
+	[CLK_MDP_RDMA0_CG] = "mdp_rdma0",
+	[CLK_MDP_RDMA2_CG] = "mdp_rdma2",
+	[CLK_MDP_HDR0_CG] = "mdp_hdr0",
+	[CLK_MDP_AAL0_CG] = "mdp_aal0",
+	[CLK_MDP_RSZ0_CG] = "mdp_rsz0",
+	[CLK_MDP_TDSHP0_CG] = "mdp_tdshp0",
+	[CLK_MDP_COLOR0_CG] = "mdp_color0",
+	[CLK_MDP_WROT0_CG] = "mdp_wrot0",
+	[CLK_MDP_FAKE_ENG0_CG] = "mdp_fake_eng0",
+	[CLK_MDPSYS_CONFIG_CG] = "mdpsys_config",
+	[CLK_MDP_RDMA1_CG] = "mdp_rdma1",
+	[CLK_MDP_RDMA3_CG] = "mdp_rdma3",
+	[CLK_MDP_HDR1_CG] = "mdp_hdr1",
+	[CLK_MDP_AAL1_CG] = "mdp_aal1",
+	[CLK_MDP_RSZ1_CG] = "mdp_rsz1",
+	[CLK_MDP_TDSHP1_CG] = "mdp_tdshp1",
+	[CLK_MDP_COLOR1_CG] = "mdp_color1",
+	[CLK_MDP_WROT1_CG] = "mdp_wrot1",
+	[CLK_MDP_RSZ2_CG] = "mdp_rsz2",
+	[CLK_MDP_WROT2_CG] = "mdp_wrot2",
+	[CLK_MDP_RSZ3_CG] = "mdp_rsz3",
+	[CLK_MDP_WROT3_CG] = "mdp_wrot3",
+	[CLK_MDP_BIRSZ0_CG] = "mdp_birsz0",
+	[CLK_MDP_BIRSZ1_CG] = "mdp_birsz1",
+	[CLK_MFG_BG3D_CG] = "mfg_bg3d",
+	[CLK_SCP_SET_SPI0_CG] = "scp_set_spi0",
+	[CLK_SCP_SET_SPI1_CG] = "scp_set_spi1",
+	[CLK_SCP_IIC_I2C0_W1S_CG] = "scp_iic_i2c0_w1s",
+	[CLK_SCP_IIC_I2C1_W1S_CG] = "scp_iic_i2c1_w1s",
+	[CLK_UFSCFG_AO_REG_UNIPRO_TX_SYM_CG] = "ufscfg_ao_unipro_tx_sym",
+	[CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM0_CG] = "ufscfg_ao_unipro_rx_sym0",
+	[CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM1_CG] = "ufscfg_ao_unipro_rx_sym1",
+	[CLK_UFSCFG_AO_REG_UNIPRO_SYS_CG] = "ufscfg_ao_unipro_sys",
+	[CLK_UFSCFG_AO_REG_U_SAP_CFG_CG] = "ufscfg_ao_u_sap_cfg",
+	[CLK_UFSCFG_AO_REG_U_PHY_TOP_AHB_S_BUS_CG] = "ufscfg_ao_u_phy_ahb_s_bus",
+	[CLK_UFSCFG_REG_UFSHCI_UFS_CG] = "ufscfg_ufshci_ufs",
+	[CLK_UFSCFG_REG_UFSHCI_AES_CG] = "ufscfg_ufshci_aes",
+	[CLK_UFSCFG_REG_UFSHCI_U_AHB_CG] = "ufscfg_ufshci_u_ahb",
+	[CLK_UFSCFG_REG_UFSHCI_U_AXI_CG] = "ufscfg_ufshci_u_axi",
+	[CLK_VDEC_CORE_VDEC_CKEN_CG] = "vdec_core_vdec_cken",
+	[CLK_VDEC_CORE_VDEC_ACTIVE_CG] = "vdec_core_vdec_active",
+	[CLK_VDEC_CORE_LARB_CKEN_CG] = "vdec_core_larb_cken",
+	[CLK_VEN1_CKE0_LARB_CG] = "ven1_larb",
+	[CLK_VEN1_CKE1_VENC_CG] = "ven1_venc",
+	[CLK_VEN1_CKE2_JPGENC_CG] = "ven1_jpgenc",
+	[CLK_VEN1_CKE3_JPGDEC_CG] = "ven1_jpgdec",
+	[CLK_VEN1_CKE4_JPGDEC_C1_CG] = "ven1_jpgdec_c1",
+	[CLK_VEN1_CKE5_GALS_CG] = "ven1_gals",
+	[CLK_VEN1_CKE6_GALS_SRAM_CG] = "ven1_gals_sram",
+	[TRACE_CLK_NUM] = "NULL",
+};
+
+struct clkchk_fm {
+	const char *fm_name;
+	unsigned int fm_id;
+	unsigned int fm_type;
+};
+
+/* check which fmeter clk you want to get freq */
+enum {
+	CHK_FM_MMPLL2 = 0,
+	CHK_FM_NUM,
+};
+
+/* fill in the fmeter clk you want to get freq */
+struct  clkchk_fm chk_fm_list[] = {
+	{},
+};
+
+static void trace_clk_event(const char *name, unsigned int clk_sta)
+{
+	unsigned long flags = 0;
+	int i;
+
+	spin_lock_irqsave(&clk_trace_lock, flags);
+
+	if (!name)
+		goto OUT;
+
+	for (i = 0; i < TRACE_CLK_NUM; i++) {
+		if (!strcmp(trace_subsys_cgs[i], name))
+			break;
+	}
+
+	if (i == TRACE_CLK_NUM)
+		goto OUT;
+
+	clk_event[evt_cnt] = (i << CLK_ID_SHIFT) | (clk_sta << CLK_STA_SHIFT);
+	evt_cnt++;
+	if (evt_cnt >= EVT_LEN)
+		evt_cnt = 0;
+
+OUT:
+	spin_unlock_irqrestore(&clk_trace_lock, flags);
+}
+
+/*
+ * clkchk dump_regs
+ */
+
+#define REGBASE_V(_phys, _id_name, _pg, _pn) { .phys = _phys, .id = _id_name,	\
+		.name = #_id_name, .pg = _pg, .pn = _pn}
+
+static struct regbase rb[] = {
+	[top] = REGBASE_V(0x10000000, top, PD_NULL, CLK_NULL),
+	[ifrao] = REGBASE_V(0x10001000, ifrao, PD_NULL, CLK_NULL),
+	[infracfg_ao_reg_bus] = REGBASE_V(0x10001000, infracfg_ao_reg_bus, PD_NULL, CLK_NULL),
+	[apmixed] = REGBASE_V(0x1000C000, apmixed, PD_NULL, CLK_NULL),
+	[emicfg_ao_mem] = REGBASE_V(0x10270000, emicfg_ao_mem, PD_NULL, CLK_NULL),
+	[perao] = REGBASE_V(0x11036000, perao, PD_NULL, CLK_NULL),
+	[afe] = REGBASE_V(0x11050000, afe, MT8189_CHK_PD_AUDIO, CLK_NULL),
+	[ufscfg_ao_reg] = REGBASE_V(0x112b8000, ufscfg_ao_reg, PD_NULL, CLK_NULL),
+	[ufscfg_pdn_reg] = REGBASE_V(0x112bb000, ufscfg_pdn_reg, MT8189_CHK_PD_UFS0, CLK_NULL),
+	[impws] = REGBASE_V(0x11B21000, impws, PD_NULL, CLK_NULL),
+	[impe] = REGBASE_V(0x11C22000, impe, PD_NULL, CLK_NULL),
+	[imps] = REGBASE_V(0x11D74000, imps, PD_NULL, CLK_NULL),
+	[impen] = REGBASE_V(0x11F32000, impen, PD_NULL, CLK_NULL),
+	[mfg] = REGBASE_V(0x13FBF000, mfg, MT8189_CHK_PD_MFG0, CLK_NULL),
+	[mm] = REGBASE_V(0x14000000, mm, MT8189_CHK_PD_DIS0, CLK_NULL),
+	[imgsys1] = REGBASE_V(0x15020000, imgsys1, MT8189_CHK_PD_ISP_IMG1, CLK_NULL),
+	[imgsys2] = REGBASE_V(0x15820000, imgsys2, MT8189_CHK_PD_ISP_IMG2, CLK_NULL),
+	[vdec_core] = REGBASE_V(0x1602f000, vdec_core, MT8189_CHK_PD_VDE0, CLK_NULL),
+	[ven1] = REGBASE_V(0x17000000, ven1, MT8189_CHK_PD_VEN0, CLK_NULL),
+	[spm] = REGBASE_V(0x1C001000, spm, PD_NULL, CLK_NULL),
+	[vlpcfg_reg_bus] = REGBASE_V(0x1C00C000, vlpcfg_reg_bus, PD_NULL, CLK_NULL),
+	[vlp_ck] = REGBASE_V(0x1C012000, vlp_ck, PD_NULL, CLK_NULL),
+	[scp_iic] = REGBASE_V(0x1C80A000, scp_iic, PD_NULL, CLK_NULL),
+	[scp] = REGBASE_V(0x1CB21000, scp, PD_NULL, CLK_NULL),
+	[vad] = REGBASE_V(0x1E010000, vad, MT8189_CHK_PD_ADSP_AO, CLK_NULL),
+	[cam_m] = REGBASE_V(0x1a000000, cam_m, MT8189_CHK_PD_CAM_MAIN, CLK_NULL),
+	[cam_ra] = REGBASE_V(0x1a04f000, cam_ra, MT8189_CHK_PD_CAM_SUBA, CLK_NULL),
+	[cam_rb] = REGBASE_V(0x1a06f000, cam_rb, MT8189_CHK_PD_CAM_SUBB, CLK_NULL),
+	[ipe] = REGBASE_V(0x1b000000, ipe, MT8189_CHK_PD_ISP_IPE, CLK_NULL),
+	[vlpcfg_ao_reg] = REGBASE_V(0x1c000000, vlpcfg_ao_reg, PD_NULL, CLK_NULL),
+	[dvfsrc_top] = REGBASE_V(0x1c00f000, dvfsrc_top, PD_NULL, CLK_NULL),
+	[mminfra_config] = REGBASE_V(0x1e800000, mminfra_config, MT8189_CHK_PD_MM_INFRA, CLK_NULL),
+	[gce_d] = REGBASE_V(0x1e980000, gce_d, MT8189_CHK_PD_MDP0, "mminfra_gce_d"),
+	[gce_m] = REGBASE_V(0x1e990000, gce_m, MT8189_CHK_PD_MDP0, "mminfra_gce_m"),
+	[mdp] = REGBASE_V(0x1f000000, mdp, MT8189_CHK_PD_MDP0, CLK_NULL),
+	[dbgao] = REGBASE_V(0xD01A000, dbgao, PD_NULL, CLK_NULL),
+	[dem] = REGBASE_V(0xd0a0000, dem, PD_NULL, CLK_NULL),
+	{},
+};
+
+#define REGNAME(_base, _ofs, _name)	\
+	{ .base = &rb[_base], .id = _base, .ofs = _ofs, .name = #_name }
+
+static struct regname rn[] = {
+	/* TOPCKGEN register */
+	REGNAME(top, 0x0010, CLK_CFG_0),
+	REGNAME(top, 0x0020, CLK_CFG_1),
+	REGNAME(top, 0x0030, CLK_CFG_2),
+	REGNAME(top, 0x0040, CLK_CFG_3),
+	REGNAME(top, 0x0050, CLK_CFG_4),
+	REGNAME(top, 0x0060, CLK_CFG_5),
+	REGNAME(top, 0x0070, CLK_CFG_6),
+	REGNAME(top, 0x0080, CLK_CFG_7),
+	REGNAME(top, 0x0090, CLK_CFG_8),
+	REGNAME(top, 0x00A0, CLK_CFG_9),
+	REGNAME(top, 0x00B0, CLK_CFG_10),
+	REGNAME(top, 0x00C0, CLK_CFG_11),
+	REGNAME(top, 0x00D0, CLK_CFG_12),
+	REGNAME(top, 0x00E0, CLK_CFG_13),
+	REGNAME(top, 0x00F0, CLK_CFG_14),
+	REGNAME(top, 0x0100, CLK_CFG_15),
+	REGNAME(top, 0x0110, CLK_CFG_16),
+	REGNAME(top, 0x0180, CLK_CFG_17),
+	REGNAME(top, 0x0190, CLK_CFG_18),
+	REGNAME(top, 0x0240, CLK_CFG_19),
+	REGNAME(top, 0x0320, CLK_AUDDIV_0),
+	REGNAME(top, 0x0510, CLK_MISC_CFG_3),
+	REGNAME(top, 0x0328, CLK_AUDDIV_2),
+	REGNAME(top, 0x0334, CLK_AUDDIV_3),
+	REGNAME(top, 0x033C, CLK_AUDDIV_5),
+	REGNAME(top, 0x510, CLK_MISC_CFG_3),
+	/* INFRACFG_AO register */
+	REGNAME(ifrao, 0x90, MODULE_CG_0),
+	REGNAME(ifrao, 0x94, MODULE_CG_1),
+	REGNAME(ifrao, 0xAC, MODULE_CG_2),
+	REGNAME(ifrao, 0xC8, MODULE_CG_3),
+	/* INFRA_INFRACFG_AO_REG_BUS register */
+	REGNAME(infracfg_ao_reg_bus, 0x0C90, MCU_CONNSYS_PROTECT_EN_STA_0),
+	REGNAME(infracfg_ao_reg_bus, 0x0C9C, MCU_CONNSYS_PROTECT_RDY_STA_0),
+	REGNAME(infracfg_ao_reg_bus, 0x0C50, INFRASYS_PROTECT_EN_STA_1),
+	REGNAME(infracfg_ao_reg_bus, 0x0C5C, INFRASYS_PROTECT_RDY_STA_1),
+	REGNAME(infracfg_ao_reg_bus, 0x0C40, INFRASYS_PROTECT_EN_STA_0),
+	REGNAME(infracfg_ao_reg_bus, 0x0C4C, INFRASYS_PROTECT_RDY_STA_0),
+	REGNAME(infracfg_ao_reg_bus, 0x0C80, PERISYS_PROTECT_EN_STA_0),
+	REGNAME(infracfg_ao_reg_bus, 0x0C8C, PERISYS_PROTECT_RDY_STA_0),
+	REGNAME(infracfg_ao_reg_bus, 0x0C10, MMSYS_PROTECT_EN_STA_0),
+	REGNAME(infracfg_ao_reg_bus, 0x0C1C, MMSYS_PROTECT_RDY_STA_0),
+	REGNAME(infracfg_ao_reg_bus, 0x0C20, MMSYS_PROTECT_EN_STA_1),
+	REGNAME(infracfg_ao_reg_bus, 0x0C2C, MMSYS_PROTECT_RDY_STA_1),
+	REGNAME(infracfg_ao_reg_bus, 0x0C60, EMISYS_PROTECT_EN_STA_0),
+	REGNAME(infracfg_ao_reg_bus, 0x0C6C, EMISYS_PROTECT_RDY_STA_0),
+	REGNAME(infracfg_ao_reg_bus, 0x0CA0, MD_MFGSYS_PROTECT_EN_STA_0),
+	REGNAME(infracfg_ao_reg_bus, 0x0CAC, MD_MFGSYS_PROTECT_RDY_STA_0),
+	/* APMIXEDSYS register */
+	REGNAME(apmixed, 0x204, ARMPLL_LL_CON0),
+	REGNAME(apmixed, 0x208, ARMPLL_LL_CON1),
+	REGNAME(apmixed, 0x20c, ARMPLL_LL_CON2),
+	REGNAME(apmixed, 0x210, ARMPLL_LL_CON3),
+	REGNAME(apmixed, 0x214, ARMPLL_BL_CON0),
+	REGNAME(apmixed, 0x218, ARMPLL_BL_CON1),
+	REGNAME(apmixed, 0x21c, ARMPLL_BL_CON2),
+	REGNAME(apmixed, 0x220, ARMPLL_BL_CON3),
+	REGNAME(apmixed, 0x224, CCIPLL_CON0),
+	REGNAME(apmixed, 0x228, CCIPLL_CON1),
+	REGNAME(apmixed, 0x22c, CCIPLL_CON2),
+	REGNAME(apmixed, 0x230, CCIPLL_CON3),
+	REGNAME(apmixed, 0x304, MAINPLL_CON0),
+	REGNAME(apmixed, 0x308, MAINPLL_CON1),
+	REGNAME(apmixed, 0x30c, MAINPLL_CON2),
+	REGNAME(apmixed, 0x310, MAINPLL_CON3),
+	REGNAME(apmixed, 0x314, UNIVPLL_CON0),
+	REGNAME(apmixed, 0x318, UNIVPLL_CON1),
+	REGNAME(apmixed, 0x31c, UNIVPLL_CON2),
+	REGNAME(apmixed, 0x320, UNIVPLL_CON3),
+	REGNAME(apmixed, 0x324, MMPLL_CON0),
+	REGNAME(apmixed, 0x328, MMPLL_CON1),
+	REGNAME(apmixed, 0x32c, MMPLL_CON2),
+	REGNAME(apmixed, 0x330, MMPLL_CON3),
+	REGNAME(apmixed, 0x504, MFGPLL_CON0),
+	REGNAME(apmixed, 0x508, MFGPLL_CON1),
+	REGNAME(apmixed, 0x50c, MFGPLL_CON2),
+	REGNAME(apmixed, 0x510, MFGPLL_CON3),
+	REGNAME(apmixed, 0x404, APLL1_CON0),
+	REGNAME(apmixed, 0x408, APLL1_CON1),
+	REGNAME(apmixed, 0x40c, APLL1_CON2),
+	REGNAME(apmixed, 0x410, APLL1_CON3),
+	REGNAME(apmixed, 0x414, APLL1_CON4),
+	REGNAME(apmixed, 0x0040, APLL1_TUNER_CON0),
+	REGNAME(apmixed, 0x000C, AP_PLL_CON3),
+	REGNAME(apmixed, 0x418, APLL2_CON0),
+	REGNAME(apmixed, 0x41c, APLL2_CON1),
+	REGNAME(apmixed, 0x420, APLL2_CON2),
+	REGNAME(apmixed, 0x424, APLL2_CON3),
+	REGNAME(apmixed, 0x428, APLL2_CON4),
+	REGNAME(apmixed, 0x0044, APLL2_TUNER_CON0),
+	REGNAME(apmixed, 0x000C, AP_PLL_CON3),
+	REGNAME(apmixed, 0x334, EMIPLL_CON0),
+	REGNAME(apmixed, 0x338, EMIPLL_CON1),
+	REGNAME(apmixed, 0x33c, EMIPLL_CON2),
+	REGNAME(apmixed, 0x340, EMIPLL_CON3),
+	REGNAME(apmixed, 0x614, APUPLL2_CON0),
+	REGNAME(apmixed, 0x618, APUPLL2_CON1),
+	REGNAME(apmixed, 0x61c, APUPLL2_CON2),
+	REGNAME(apmixed, 0x620, APUPLL2_CON3),
+	REGNAME(apmixed, 0x604, APUPLL_CON0),
+	REGNAME(apmixed, 0x608, APUPLL_CON1),
+	REGNAME(apmixed, 0x60c, APUPLL_CON2),
+	REGNAME(apmixed, 0x610, APUPLL_CON3),
+	REGNAME(apmixed, 0x42c, TVDPLL1_CON0),
+	REGNAME(apmixed, 0x430, TVDPLL1_CON1),
+	REGNAME(apmixed, 0x434, TVDPLL1_CON2),
+	REGNAME(apmixed, 0x438, TVDPLL1_CON3),
+	REGNAME(apmixed, 0x43c, TVDPLL2_CON0),
+	REGNAME(apmixed, 0x440, TVDPLL2_CON1),
+	REGNAME(apmixed, 0x444, TVDPLL2_CON2),
+	REGNAME(apmixed, 0x448, TVDPLL2_CON3),
+	REGNAME(apmixed, 0x514, ETHPLL_CON0),
+	REGNAME(apmixed, 0x518, ETHPLL_CON1),
+	REGNAME(apmixed, 0x51c, ETHPLL_CON2),
+	REGNAME(apmixed, 0x520, ETHPLL_CON3),
+	REGNAME(apmixed, 0x524, MSDCPLL_CON0),
+	REGNAME(apmixed, 0x528, MSDCPLL_CON1),
+	REGNAME(apmixed, 0x52c, MSDCPLL_CON2),
+	REGNAME(apmixed, 0x530, MSDCPLL_CON3),
+	REGNAME(apmixed, 0x534, UFSPLL_CON0),
+	REGNAME(apmixed, 0x538, UFSPLL_CON1),
+	REGNAME(apmixed, 0x53c, UFSPLL_CON2),
+	REGNAME(apmixed, 0x540, UFSPLL_CON3),
+	/* EMICFG_AO_MEM register */
+	REGNAME(emicfg_ao_mem, 0x0080, GALS_SLP_PROT_EN),
+	REGNAME(emicfg_ao_mem, 0x008C, GALS_SLP_PROT_RDY),
+	/* PERICFG_AO register */
+	REGNAME(perao, 0x10, PERI_CG_0),
+	REGNAME(perao, 0x14, PERI_CG_1),
+	REGNAME(perao, 0x18, PERI_CG_2),
+	/* AFE register */
+	REGNAME(afe, 0x0, AUDIO_TOP_0),
+	REGNAME(afe, 0x4, AUDIO_TOP_1),
+	REGNAME(afe, 0x8, AUDIO_TOP_2),
+	REGNAME(afe, 0xC, AUDIO_TOP_3),
+	REGNAME(afe, 0x10, AUDIO_TOP_4),
+	/* UFSCFG_AO_REG register */
+	REGNAME(ufscfg_ao_reg, 0x4, UFS_AO_CG_0),
+	/* UFSCFG_PDN_REG register */
+	REGNAME(ufscfg_pdn_reg, 0x4, UFS_PDN_CG_0),
+	/* IMP_IIC_WRAP_WS register */
+	REGNAME(impws, 0xE00, AP_CLOCK_CG),
+	/* IMP_IIC_WRAP_E register */
+	REGNAME(impe, 0xE00, AP_CLOCK_CG),
+	/* IMP_IIC_WRAP_S register */
+	REGNAME(imps, 0xE00, AP_CLOCK_CG),
+	/* IMP_IIC_WRAP_EN register */
+	REGNAME(impen, 0xE00, AP_CLOCK_CG),
+	/* MFG register */
+	REGNAME(mfg, 0x0, MFG_CG_CON),
+	/* DISPSYS_CONFIG register */
+	REGNAME(mm, 0x100, MMSYS_CG_0),
+	REGNAME(mm, 0x110, MMSYS_CG_1),
+	/* IMGSYS1 register */
+	REGNAME(imgsys1, 0x0, IMG_CG),
+	/* IMGSYS2 register */
+	REGNAME(imgsys2, 0x0, IMG_CG),
+	/* VDEC_CORE register */
+	REGNAME(vdec_core, 0x8, LARB_CKEN_CON),
+	REGNAME(vdec_core, 0x0, VDEC_CKEN),
+	/* VENC_GCON register */
+	REGNAME(ven1, 0x0, VENCSYS_CG),
+	/* SPM register */
+	REGNAME(spm, 0xE04, CONN_PWR_CON),
+	REGNAME(spm, 0xF40, PWR_STATUS),
+	REGNAME(spm, 0xF44, PWR_STATUS_2ND),
+	REGNAME(spm, 0xE10, UFS0_PWR_CON),
+	REGNAME(spm, 0xE14, UFS0_PHY_PWR_CON),
+	REGNAME(spm, 0xE18, AUDIO_PWR_CON),
+	REGNAME(spm, 0xE1C, ADSP_TOP_PWR_CON),
+	REGNAME(spm, 0xE20, ADSP_INFRA_PWR_CON),
+	REGNAME(spm, 0xE24, ADSP_AO_PWR_CON),
+	REGNAME(spm, 0xE28, ISP_IMG1_PWR_CON),
+	REGNAME(spm, 0xE2C, ISP_IMG2_PWR_CON),
+	REGNAME(spm, 0xE30, ISP_IPE_PWR_CON),
+	REGNAME(spm, 0xE38, VDE0_PWR_CON),
+	REGNAME(spm, 0xE40, VEN0_PWR_CON),
+	REGNAME(spm, 0xE48, CAM_MAIN_PWR_CON),
+	REGNAME(spm, 0xE50, CAM_SUBA_PWR_CON),
+	REGNAME(spm, 0xE54, CAM_SUBB_PWR_CON),
+	REGNAME(spm, 0xE68, MDP0_PWR_CON),
+	REGNAME(spm, 0xE70, DIS0_PWR_CON),
+	REGNAME(spm, 0xE78, MM_INFRA_PWR_CON),
+	REGNAME(spm, 0xE80, DP_TX_PWR_CON),
+	REGNAME(spm, 0xE84, SCP_CORE_PWR_CON),
+	REGNAME(spm, 0xE88, SCP_PERI_PWR_CON),
+	REGNAME(spm, 0xE9C, CSI_RX_PWR_CON),
+	REGNAME(spm, 0xEA8, SSUSB_PWR_CON),
+	REGNAME(spm, 0xEB4, MFG0_PWR_CON),
+	REGNAME(spm, 0xEB8, MFG1_PWR_CON),
+	REGNAME(spm, 0xEBC, MFG2_PWR_CON),
+	REGNAME(spm, 0xEC0, MFG3_PWR_CON),
+	REGNAME(spm, 0xF70, EDP_TX_PWR_CON),
+	REGNAME(spm, 0xF74, PCIE_PWR_CON),
+	REGNAME(spm, 0xF78, PCIE_PHY_PWR_CON),
+	/* VLPCFG_REG_BUS register */
+	REGNAME(vlpcfg_reg_bus, 0x0210, VLP_TOPAXI_PROTECTEN),
+	REGNAME(vlpcfg_reg_bus, 0x0220, VLP_TOPAXI_PROTECTEN_STA1),
+	REGNAME(vlpcfg_reg_bus, 0x091C, VLPCFG_RSVD7_ADDR),
+	REGNAME(vlpcfg_reg_bus, 0x091C, VLPCFG_RSVD7_ADDR),
+	/* VLP_CKSYS register */
+	REGNAME(vlp_ck, 0x0008, VLP_CLK_CFG_0),
+	REGNAME(vlp_ck, 0x0014, VLP_CLK_CFG_1),
+	REGNAME(vlp_ck, 0x0020, VLP_CLK_CFG_2),
+	REGNAME(vlp_ck, 0x002C, VLP_CLK_CFG_3),
+	REGNAME(vlp_ck, 0x0038, VLP_CLK_CFG_4),
+	REGNAME(vlp_ck, 0x0044, VLP_CLK_CFG_5),
+	REGNAME(vlp_ck, 0x1F0, VLP_CLK_CFG_30),
+	/* SCP_IIC register */
+	REGNAME(scp_iic, 0xE10, CCU_CLOCK_CG),
+	/* SCP register */
+	REGNAME(scp, 0x154, AP_SPI_CG),
+	/* VADSYS register */
+	REGNAME(vad, 0x0, VADSYS_CK_EN),
+	REGNAME(vad, 0x180, VOW_AUDIODSP_SW_CG),
+	/* CAMSYS_MAIN register */
+	REGNAME(cam_m, 0x0, CAMSYS_CG),
+	/* CAMSYS_RAWA register */
+	REGNAME(cam_ra, 0x0, CAMSYS_CG),
+	/* CAMSYS_RAWB register */
+	REGNAME(cam_rb, 0x0, CAMSYS_CG),
+	/* IPESYS register */
+	REGNAME(ipe, 0x0, IMG_CG),
+	/* VLPCFG_AO_REG register */
+	REGNAME(vlpcfg_ao_reg, 0x800, DEBUGTOP_VLPAO_CTRL),
+	/* DVFSRC_TOP register */
+	REGNAME(dvfsrc_top, 0x0, DVFSRC_BASIC_CONTROL),
+	/* MMINFRA_CONFIG register */
+	REGNAME(mminfra_config, 0x100, MMINFRA_CG_0),
+	REGNAME(mminfra_config, 0x110, MMINFRA_CG_1),
+	/* GCE_D register */
+	REGNAME(gce_d, 0xF0, GCE_CTL_INT0),
+	/* GCE_M register */
+	REGNAME(gce_m, 0xF0, GCE_CTL_INT0),
+	/* MDPSYS_CONFIG register */
+	REGNAME(mdp, 0x100, MDPSYS_CG_0),
+	REGNAME(mdp, 0x110, MDPSYS_CG_1),
+	/* DBGAO register */
+	REGNAME(dbgao, 0x70, ATB),
+	/* DEM register */
+	REGNAME(dem, 0x70, ATB),
+	REGNAME(dem, 0x2C, DBGBUSCLK_EN),
+	REGNAME(dem, 0x30, DBGSYSCLK_EN),
+	{},
+};
+
+static const struct regname *get_all_mt8189_regnames(void)
+{
+	return rn;
+}
+
+static void init_regbase(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rb) - 1; i++) {
+		if (!rb[i].phys)
+			continue;
+
+		rb[i].virt = ioremap(rb[i].phys, 0x1000);
+	}
+}
+
+u32 get_mt8189_reg_value(u32 id, u32 ofs)
+{
+	if (id >= chk_sys_num)
+		return 0;
+
+	return clk_readl(rb[id].virt + ofs);
+}
+EXPORT_SYMBOL_GPL(get_mt8189_reg_value);
+
+/*
+ * clkchk pwr_data
+ */
+struct pwr_data {
+	const char *pvdname;
+	enum chk_sys_id id;
+	u32 base;
+	u32 ofs;
+};
+
+/*
+ * clkchk pwr_data
+ */
+static struct pwr_data pvd_pwr_data[] = {
+	{"audiosys", afe, spm, 0x0E18},
+	{"camsys_main", cam_m, spm, 0x0E48},
+	{"camsys_rawa", cam_ra, spm, 0x0E50},
+	{"camsys_rawb", cam_rb, spm, 0x0E54},
+	{"dispsys", mm, spm, 0x0E70},
+	{"imgsys1", imgsys1, spm, 0x0E28},
+	{"imgsys2", imgsys2, spm, 0x0E2C},
+	{"ipesys", ipe, spm, 0x0E30},
+	{"mfgsys", mfg, spm, 0x0EB4},
+	{"mm_infra", mminfra_config, spm, 0x0E78},
+	{"ufs_pdn", ufscfg_pdn_reg, spm, 0x0E10},
+	{"vdec_core", vdec_core, spm, 0x0E38},
+	{"venc", ven1, spm, 0x0E40},
+};
+
+static int get_pvd_pwr_data_idx(const char *pvdname)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pvd_pwr_data); i++) {
+		if (pvd_pwr_data[i].pvdname == NULL)
+			continue;
+		if (!strcmp(pvdname, pvd_pwr_data[i].pvdname))
+			return i;
+	}
+
+	return -1;
+}
+
+static u32 pwr_ofs[STA_NUM] = {
+	[PWR_STA] = 0xF40,
+	[PWR_STA2] = 0xF44,
+	[XPU_PWR_STA] = 0xF50,
+	[XPU_PWR_STA2] = 0xF54,
+};
+
+u32 *get_spm_pwr_status_array(void)
+{
+	static void __iomem *scpsys_base, *pwr_addr[STA_NUM];
+	static u32 pwr_sta[STA_NUM];
+	int i;
+
+	for (i = 0; i < STA_NUM; i++) {
+		if (!scpsys_base)
+			scpsys_base = ioremap(0x1c001000, PAGE_SIZE);
+
+		if (pwr_ofs[i]) {
+			pwr_addr[i] = scpsys_base + pwr_ofs[i];
+			pwr_sta[i] = clk_readl(pwr_addr[i]);
+		}
+	}
+
+	return pwr_sta;
+}
+
+static struct pvd_msk pvd_pwr_mask[] = {
+	{"mfgsys", XPU_PWR_STA, 0x00000004},		// BIT(2), MFG1
+	{"ufscfg_pdn", PWR_STA, 0x00000010},		// BIT(4), UFS0
+	{"audiosys", PWR_STA, 0x00000040},		// BIT(6), AUDIO
+	{"vadsys", PWR_STA, 0x00000080},		// BIT(7), ADSP_TOP
+	{"imgsys1", PWR_STA, 0x00000400},		// BIT(10), ISP_IMG1
+	{"imgsys2", PWR_STA, 0x00000800},		// BIT(11), ISP_IMG2
+	{"ipesys", PWR_STA, 0x00001000},		// BIT(12), IPE
+	{"vdec_core", PWR_STA, 0x00004000},		// BIT(14), VDE0
+	{"venc", PWR_STA, 0x00010000},		// BIT(16), VEN0
+	{"camsys_main", PWR_STA, 0x00040000},		// BIT(18), CAM_MAIN
+	{"camsys_rawa", PWR_STA, 0x00100000},		// BIT(20), CAM_SUBA
+	{"camsys_rawb", PWR_STA, 0x00200000},		// BIT(21), CAM_SUBB
+	{"mdpsys", PWR_STA, 0x04000000},		// BIT(26), MDP0
+	{"dispsys", PWR_STA, 0x10000000},		// BIT(28), DIS0
+	{"mm_infra", PWR_STA, 0x40000000},		// BIT(30), MMINFRA
+	{},
+};
+
+static struct pvd_msk *get_pvd_pwr_mask(void)
+{
+	return pvd_pwr_mask;
+}
+
+/*
+ * clkchk pwr_status
+ */
+static u32 get_pwr_status(s32 idx)
+{
+	if (idx < 0 || idx >= ARRAY_SIZE(pvd_pwr_data))
+		return 0;
+
+	if (pvd_pwr_data[idx].id >= chk_sys_num)
+		return 0;
+
+	return  clk_readl(rb[pvd_pwr_data[idx].base].virt + pvd_pwr_data[idx].ofs);
+}
+
+static bool is_cg_chk_pwr_on(void)
+{
+#if CG_CHK_PWRON_ENABLE
+	return true;
+#endif
+	return false;
+}
+
+#if CHECK_VCORE_FREQ
+/*
+ * clkchk vf table
+ */
+
+struct mtk_vf {
+	const char *name;
+	int freq_table[5];
+};
+
+#define MTK_VF_TABLE(_n, _freq0, _freq1, _freq2, _freq3, _freq4) {		\
+		.name = _n,		\
+		.freq_table = {_freq0, _freq1, _freq2, _freq3, _freq4},	\
+	}
+
+/*
+ * Opp0 : 0p8v
+ * Opp1 : 0p725v
+ * Opp2 : 0p65v
+ * Opp3 : 0p60v
+ * Opp4 : 0p55v
+ */
+static struct mtk_vf vf_table[] = {
+	/* Opp0, Opp1, Opp2, Opp3, Opp4 */
+	MTK_VF_TABLE("axi_sel", 156000, 156000, 156000, 156000),
+	MTK_VF_TABLE("axi_peri_sel", 156000, 156000, 156000, 156000),
+	MTK_VF_TABLE("axi_u_sel", 78000, 78000, 78000, 78000),
+	MTK_VF_TABLE("bus_aximem_sel", 364000, 273000, 273000, 218400),
+	MTK_VF_TABLE("disp0_sel", 624000, 416000, 312000, 218400),
+	MTK_VF_TABLE("mminfra_sel", 624000, 458333, 364000, 273000),
+	MTK_VF_TABLE("uart_sel", 52000, 52000, 52000, 52000),
+	MTK_VF_TABLE("spi0_sel", 208000, 208000, 208000, 208000),
+	MTK_VF_TABLE("spi1_sel", 208000, 208000, 208000, 208000),
+	MTK_VF_TABLE("spi2_sel", 208000, 208000, 208000, 208000),
+	MTK_VF_TABLE("spi3_sel", 208000, 208000, 208000, 208000),
+	MTK_VF_TABLE("spi4_sel", 208000, 208000, 208000, 208000),
+	MTK_VF_TABLE("spi5_sel", 208000, 208000, 208000, 208000),
+	MTK_VF_TABLE("msdc_macro_0p_sel", 416000, 416000, 416000, 416000),
+	MTK_VF_TABLE("msdc5hclk_sel", 273000, 273000, 273000, 273000),
+	MTK_VF_TABLE("msdc50_0_sel", 416000, 416000, 416000, 416000),
+	MTK_VF_TABLE("aes_msdcfde_sel", 416000, 416000, 416000, 416000),
+	MTK_VF_TABLE("msdc_macro_1p_sel", 416000, 416000, 416000, 416000),
+	MTK_VF_TABLE("msdc30_1_sel", 208000, 208000, 208000, 208000),
+	MTK_VF_TABLE("msdc30_1_h_sel", 208000, 208000, 208000, 208000),
+	MTK_VF_TABLE("msdc_macro_2p_sel", 416000, 416000, 416000, 416000),
+	MTK_VF_TABLE("msdc30_2_sel", 208000, 208000, 208000, 208000),
+	MTK_VF_TABLE("msdc30_2_h_sel", 208000, 208000, 208000, 208000),
+	MTK_VF_TABLE("aud_intbus_sel", 136500, 136500, 136500, 136500),
+	MTK_VF_TABLE("atb_sel", 273000, 273000, 273000, 273000),
+	MTK_VF_TABLE("disp_pwm_sel", 136500, 136500, 136500, 136500),
+	MTK_VF_TABLE("usb_p0_sel", 124800, 124800, 124800, 124800),
+	MTK_VF_TABLE("ssusb_xhci_p0_sel", 124800, 124800, 124800, 124800),
+	MTK_VF_TABLE("usb_p1_sel", 124800, 124800, 124800, 124800),
+	MTK_VF_TABLE("ssusb_xhci_p1_sel", 124800, 124800, 124800, 124800),
+	MTK_VF_TABLE("usb_p2_sel", 124800, 124800, 124800, 124800),
+	MTK_VF_TABLE("ssusb_xhci_p2_sel", 124800, 124800, 124800, 124800),
+	MTK_VF_TABLE("usb_p3_sel", 124800, 124800, 124800, 124800),
+	MTK_VF_TABLE("ssusb_xhci_p3_sel", 124800, 124800, 124800, 124800),
+	MTK_VF_TABLE("usb_p4_sel", 124800, 124800, 124800, 124800),
+	MTK_VF_TABLE("ssusb_xhci_p4_sel", 124800, 124800, 124800, 124800),
+	MTK_VF_TABLE("i2c_sel", 136500, 136500, 136500, 136500),
+	MTK_VF_TABLE("seninf_sel", 499200, 499200, 392857, 273000),
+	MTK_VF_TABLE("seninf1_sel", 499200, 499200, 392857, 273000),
+	MTK_VF_TABLE("aud_engen1_sel", 45158, 45158, 45158, 45158),
+	MTK_VF_TABLE("aud_engen2_sel", 49152, 49152, 49152, 49152),
+	MTK_VF_TABLE("aes_ufsfde_sel", 546000, 546000, 546000, 546000),
+	MTK_VF_TABLE("ufs_sel", 208000, 208000, 208000, 208000),
+	MTK_VF_TABLE("ufs_mbist_sel", 297000, 297000, 297000, 297000),
+	MTK_VF_TABLE("aud_1_sel", 180634, 180634, 180634, 180634),
+	MTK_VF_TABLE("aud_2_sel", 196608, 196608, 196608, 196608),
+	MTK_VF_TABLE("venc_sel", 624000, 458333, 343750, 249600),
+	MTK_VF_TABLE("vdec_sel", 546000, 416000, 312000, 218400),
+	MTK_VF_TABLE("pwm_sel", 78000, 78000, 78000, 78000),
+	MTK_VF_TABLE("audio_h_sel", 196608, 196608, 196608, 196608),
+	MTK_VF_TABLE("mcupm_sel", 218400, 218400, 218400, 218400),
+	MTK_VF_TABLE("mem_sub_sel", 546000, 436800, 273000, 218400),
+	MTK_VF_TABLE("mem_sub_peri_sel", 546000, 436800, 273000, 218400),
+	MTK_VF_TABLE("mem_sub_u_sel", 546000, 436800, 273000, 218400),
+	MTK_VF_TABLE("emi_n_sel", 688000, 688000, 688000, 688000),
+	MTK_VF_TABLE("dsi_occ_sel", 312000, 312000, 249600, 208000),
+	MTK_VF_TABLE("ap2conn_host_sel", 78000, 78000, 78000, 78000),
+	MTK_VF_TABLE("img1_sel", 624000, 458333, 343750, 229167),
+	MTK_VF_TABLE("ipe_sel", 546000, 416000, 312000, 229167),
+	MTK_VF_TABLE("cam_sel", 624000, 546000, 392857, 273000),
+	MTK_VF_TABLE("camtm_sel", 208000, 208000, 208000, 208000),
+	MTK_VF_TABLE("dsp_sel", 208000, 208000, 208000, 208000),
+	MTK_VF_TABLE("sr_pka_sel", 436800, 312000, 273000, 136500),
+	MTK_VF_TABLE("dxcc_sel", 273000, 273000, 273000, 273000),
+	MTK_VF_TABLE("mfg_ref_sel", 364000, 364000, 364000, 364000),
+	MTK_VF_TABLE("mdp0_sel", 624000, 416000, 312000, 218400),
+	MTK_VF_TABLE("dp_sel", 297000, 148500, 148500, 148500),
+	MTK_VF_TABLE("edp_sel", 297000, 148500, 148500, 148500),
+	MTK_VF_TABLE("edp_favt_sel", 297000, 148500, 148500, 148500),
+	MTK_VF_TABLE("snps_eth_250m_sel", 250000, 250000, 250000, 250000),
+	MTK_VF_TABLE("snps_eth_62p4m_ptp_sel", 62500, 62500, 62500, 62500),
+	MTK_VF_TABLE("snps_eth_50m_rmii_sel", 50000, 50000, 50000, 50000),
+	MTK_VF_TABLE("sflash_sel", 124800, 124800, 124800, 124800),
+	MTK_VF_TABLE("gcpu_sel", 416000, 364000, 364000, 273000),
+	MTK_VF_TABLE("pcie_mac_tl_sel", 136500, 136500, 136500, 136500),
+	MTK_VF_TABLE("vdstx_dg_cts_sel", 118900, 118900, 118900, 118900),
+	MTK_VF_TABLE("pll_dpix_sel", 171900, 171900, 171900, 171900),
+	MTK_VF_TABLE("ecc_sel", 546000, 416000, 416000, 312000),
+	{},
+};
+#endif
+
+static const char *get_vf_name(int id)
+{
+#if CHECK_VCORE_FREQ
+	if (id < 0) {
+		pr_info("[%s]Negative index detected\n", __func__);
+		return NULL;
+	}
+
+	return vf_table[id].name;
+
+#else
+	return NULL;
+#endif
+}
+
+static int get_vf_opp(int id, int opp)
+{
+#if CHECK_VCORE_FREQ
+	if (id < 0 || opp < 0) {
+		pr_info("[%s]Negative index detected\n", __func__);
+		return 0;
+	}
+
+	return vf_table[id].freq_table[opp];
+#else
+	return 0;
+#endif
+}
+
+static u32 get_vf_num(void)
+{
+#if CHECK_VCORE_FREQ
+	return ARRAY_SIZE(vf_table) - 1;
+#else
+	return 0;
+#endif
+}
+
+static int get_vcore_opp(void)
+{
+#if IS_ENABLED(CONFIG_MTK_DVFSRC_HELPER) && CHECK_VCORE_FREQ
+	return mtk_dvfsrc_query_opp_info(MTK_DVFSRC_SW_REQ_VCORE_OPP);
+#else
+	return VCORE_NULL;
+#endif
+}
+
+static unsigned int reg_dump_addr[ARRAY_SIZE(rn) - 1];
+static unsigned int reg_dump_val[ARRAY_SIZE(rn) - 1];
+static bool reg_dump_valid[ARRAY_SIZE(rn) - 1];
+
+void set_subsys_reg_dump_mt8189(enum chk_sys_id id[])
+{
+	const struct regname *rns = &rn[0];
+	int i, j, k;
+
+	for (i = 0; i < ARRAY_SIZE(rn) - 1; i++, rns++) {
+		int pwr_idx = PD_NULL;
+
+		if (!is_valid_reg(ADDR(rns)))
+			continue;
+
+		for (j = 0; id[j] != chk_sys_num; j++) {
+			/* filter out the subsys that we don't want */
+			if (rns->id == id[j])
+				break;
+		}
+
+		if (id[j] == chk_sys_num)
+			continue;
+
+		for (k = 0; k < ARRAY_SIZE(pvd_pwr_data); k++) {
+			if (pvd_pwr_data[k].id == id[j]) {
+				pwr_idx = k;
+				break;
+			}
+		}
+
+		if (pwr_idx != PD_NULL)
+			if (!pwr_hw_is_on(PWR_CON_STA, pwr_idx))
+				continue;
+
+		reg_dump_addr[i] = PHYSADDR(rns);
+		reg_dump_val[i] = clk_readl(ADDR(rns));
+		/* record each register dump index validation */
+		reg_dump_valid[i] = false;
+	}
+}
+EXPORT_SYMBOL_GPL(set_subsys_reg_dump_mt8189);
+
+void get_subsys_reg_dump_mt8189(void)
+{
+	const struct regname *rns = &rn[0];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rn) - 1; i++, rns++) {
+		if (reg_dump_valid[i])
+			pr_info("%-18s: [0x%08x] = 0x%08x\n",
+					rns->name, reg_dump_addr[i], reg_dump_val[i]);
+	}
+}
+EXPORT_SYMBOL_GPL(get_subsys_reg_dump_mt8189);
+
+void print_subsys_reg_mt8189(enum chk_sys_id id)
+{
+	struct regbase *rb_dump;
+	const struct regname *rns = &rn[0];
+	int pwr_idx = PD_NULL;
+	int i;
+
+	if (id >= chk_sys_num) {
+		pr_info("wrong id:%d\n", id);
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pvd_pwr_data); i++) {
+		if (pvd_pwr_data[i].id == id) {
+			pwr_idx = i;
+			break;
+		}
+	}
+
+	rb_dump = &rb[id];
+
+	for (i = 0; i < ARRAY_SIZE(rn) - 1; i++, rns++) {
+		if (!is_valid_reg(ADDR(rns)))
+			return;
+
+		/* filter out the subsys that we don't want */
+		if (rns->base != rb_dump)
+			continue;
+
+		if (pwr_idx != PD_NULL) {
+			if (!pwr_hw_is_on(PWR_CON_STA, pwr_idx))
+				return;
+		}
+
+		pr_info("%-18s: [0x%08x] = 0x%08x\n",
+			rns->name, PHYSADDR(rns), clk_readl(ADDR(rns)));
+	}
+}
+EXPORT_SYMBOL_GPL(print_subsys_reg_mt8189);
+
+static const char * const off_pll_names[] = {
+	"mmpll",
+	"mfgpll",
+	"apll1",
+	"apll2",
+	"apupll2",
+	"apupll",
+	"tvdpll1",
+	"tvdpll2",
+	"ethpll",
+	"msdcpll",
+	"ufspll",
+	NULL
+};
+
+static const char * const notice_pll_names[] = {
+	NULL
+};
+
+static const char * const bypass_pll_name[] = {
+	"mainpll",
+	"univpll",
+	"emipll",
+	NULL
+};
+
+static const char * const *get_off_pll_names(void)
+{
+	return off_pll_names;
+}
+
+static const char * const *get_notice_pll_names(void)
+{
+	return notice_pll_names;
+}
+
+static const char * const *get_bypass_pll_name(void)
+{
+	return bypass_pll_name;
+}
+
+static bool is_pll_chk_bug_on(void)
+{
+#if (BUG_ON_CHK_ENABLE) || (IS_ENABLED(CONFIG_MTK_CLKMGR_DEBUG))
+	return true;
+#endif
+	return false;
+}
+
+static bool is_suspend_retry_stop(bool reset_cnt)
+{
+	if (reset_cnt == true) {
+		suspend_cnt = 0;
+		return true;
+	}
+
+	suspend_cnt++;
+	pr_notice("%s: suspend cnt: %d\n", __func__, suspend_cnt);
+
+	if (suspend_cnt < 2)
+		return false;
+
+	return true;
+}
+
+static enum chk_sys_id bus_dump_id[] = {
+	top,
+	apmixed,
+	chk_sys_num,
+};
+
+static void get_bus_reg(void)
+{
+	set_subsys_reg_dump_mt8189(bus_dump_id);
+}
+
+static void dump_bus_reg(struct regmap *regmap, u32 ofs)
+{
+	set_subsys_reg_dump_mt8189(bus_dump_id);
+	get_subsys_reg_dump_mt8189();
+	/* sspm need some time to run isr */
+	mdelay(1000);
+}
+
+static enum chk_sys_id pll_dump_id[] = {
+	apmixed,
+	top,
+	chk_sys_num,
+};
+
+static void dump_pll_reg(bool bug_on)
+{
+	set_subsys_reg_dump_mt8189(pll_dump_id);
+	get_subsys_reg_dump_mt8189();
+
+	if (bug_on) {
+		mdelay(100);
+		//BUG_ON(1);
+	}
+}
+
+static bool clk_hw_is_on(struct clk_hw *hw)
+{
+	struct clk_hw *p_hw = clk_hw_get_parent(hw);
+
+	if (p_hw && !clk_hw_is_enabled(p_hw))
+		return false;
+
+	return clk_hw_is_enabled(hw) || clk_hw_is_prepared(hw);
+}
+
+static bool pvdck_is_on(struct provider_clk *pvdck)
+{
+	struct clk *c = NULL;
+	struct clk_hw *c_hw = NULL;
+
+	if (!pvdck)
+		return false;
+
+	c = pvdck->ck;
+	c_hw = __clk_get_hw(c);
+
+	if (!c_hw)
+		return false;
+
+	/* this clock depends on infra mtcmos */
+	if (pvdck->pwr_mask == INV_MSK || !pvdck->pwr_mask)
+		/* check the clk hardware status directly */
+		return clk_hw_is_on(c_hw);
+	/* this clock depends on non-infra mtcmos */
+	else {
+		/* if mtcmos is on, then check the clk hardware status */
+		if (pwr_hw_is_on(pvdck->sta_type, pvdck->pwr_mask) > 0)
+			return clk_hw_is_on(c_hw);
+		/* if mtcmos is off, then return 0 directly */
+		else
+			return false;
+	}
+}
+
+/*
+ * init functions
+ */
+
+static struct clkchk_ops clkchk_mt8189_ops = {
+	.get_all_regnames = get_all_mt8189_regnames,
+	.get_pvd_pwr_data_idx = get_pvd_pwr_data_idx,
+	.get_pwr_status = get_pwr_status,
+	.is_cg_chk_pwr_on = is_cg_chk_pwr_on,
+	.get_off_pll_names = get_off_pll_names,
+	.get_notice_pll_names = get_notice_pll_names,
+	.get_bypass_pll_name = get_bypass_pll_name,
+	.is_pll_chk_bug_on = is_pll_chk_bug_on,
+	.get_vf_name = get_vf_name,
+	.get_vf_opp = get_vf_opp,
+	.get_vf_num = get_vf_num,
+	.get_vcore_opp = get_vcore_opp,
+	.get_bus_reg = get_bus_reg,
+	.dump_bus_reg = dump_bus_reg,
+	.dump_pll_reg = dump_pll_reg,
+	.trace_clk_event = trace_clk_event,
+	.is_suspend_retry_stop = is_suspend_retry_stop,
+	.get_spm_pwr_status_array = get_spm_pwr_status_array,
+	.is_pwr_on = pvdck_is_on,
+	.get_pvd_pwr_mask = get_pvd_pwr_mask,
+};
+
+static int clk_chk_mt8189_probe(struct platform_device *pdev)
+{
+	suspend_cnt = 0;
+
+	init_regbase();
+
+	set_clkchk_notify();
+
+	set_clkchk_ops(&clkchk_mt8189_ops);
+
+#if CHECK_VCORE_FREQ
+	mtk_clk_check_muxes();
+#endif
+
+	return 0;
+}
+
+static const struct of_device_id of_match_clkchk_mt8189[] = {
+	{
+		.compatible = "mediatek,mt8189-clkchk",
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_chk_mt8189_drv = {
+	.probe = clk_chk_mt8189_probe,
+	.driver = {
+		.name = "clk-chk-mt8189",
+		.owner = THIS_MODULE,
+		.pm = &clk_chk_dev_pm_ops,
+		.of_match_table = of_match_clkchk_mt8189,
+	},
+};
+
+/*
+ * init functions
+ */
+
+static int __init clkchk_mt8189_init(void)
+{
+	return platform_driver_register(&clk_chk_mt8189_drv);
+}
+
+static void __exit clkchk_mt8189_exit(void)
+{
+	platform_driver_unregister(&clk_chk_mt8189_drv);
+}
+
+subsys_initcall(clkchk_mt8189_init);
+module_exit(clkchk_mt8189_exit);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clkchk-mt8189.h b/drivers/clk/mediatek/clkchk-mt8189.h
new file mode 100644
index 000000000000..a84fd6c6e9d4
--- /dev/null
+++ b/drivers/clk/mediatek/clkchk-mt8189.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#ifndef __DRV_CLKCHK_MT8189_H
+#define __DRV_CLKCHK_MT8189_H
+
+enum chk_sys_id {
+	top = 0,
+	ifrao = 1,
+	infracfg_ao_reg_bus = 2,
+	apmixed = 3,
+	emicfg_ao_mem = 4,
+	perao = 5,
+	afe = 6,
+	ufscfg_ao_reg = 7,
+	ufscfg_pdn_reg = 8,
+	impws = 9,
+	impe = 10,
+	imps = 11,
+	impen = 12,
+	mfg = 13,
+	mm = 14,
+	imgsys1 = 15,
+	imgsys2 = 16,
+	vdec_core = 17,
+	ven1 = 18,
+	spm = 19,
+	vlpcfg_reg_bus = 20,
+	vlp_ck = 21,
+	scp_iic = 22,
+	scp = 23,
+	vad = 24,
+	cam_m = 25,
+	cam_ra = 26,
+	cam_rb = 27,
+	ipe = 28,
+	vlpcfg_ao_reg = 29,
+	dvfsrc_top = 30,
+	mminfra_config = 31,
+	gce_d = 32,
+	gce_m = 33,
+	mdp = 34,
+	dbgao = 35,
+	dem = 36,
+	hwv = 37,
+	hwv_ext = 38,
+	hwv_wrt = 39,
+	chk_sys_num = 40,
+};
+
+enum chk_pd_id {
+	MT8189_CHK_PD_CONN = 0,
+	MT8189_CHK_PD_UFS0 = 1,
+	MT8189_CHK_PD_UFS0_PHY = 2,
+	MT8189_CHK_PD_AUDIO = 3,
+	MT8189_CHK_PD_ADSP_TOP_DORMANT = 4,
+	MT8189_CHK_PD_ADSP_INFRA = 5,
+	MT8189_CHK_PD_ADSP_AO = 6,
+	MT8189_CHK_PD_MM_INFRA = 7,
+	MT8189_CHK_PD_ISP_IMG1 = 8,
+	MT8189_CHK_PD_ISP_IMG2 = 9,
+	MT8189_CHK_PD_ISP_IPE = 10,
+	MT8189_CHK_PD_VDE0 = 11,
+	MT8189_CHK_PD_VEN0 = 12,
+	MT8189_CHK_PD_CAM_MAIN = 13,
+	MT8189_CHK_PD_CAM_SUBA = 14,
+	MT8189_CHK_PD_CAM_SUBB = 15,
+	MT8189_CHK_PD_MDP0 = 16,
+	MT8189_CHK_PD_DIS0 = 17,
+	MT8189_CHK_PD_DP_TX = 18,
+	MT8189_CHK_PD_CSI_RX = 19,
+	MT8189_CHK_PD_SSUSB = 20,
+	MT8189_CHK_PD_MFG0 = 21,
+	MT8189_CHK_PD_MFG1 = 22,
+	MT8189_CHK_PD_MFG2 = 23,
+	MT8189_CHK_PD_MFG3 = 24,
+	MT8189_CHK_PD_EDP_TX_DORMANT = 25,
+	MT8189_CHK_PD_PCIE = 26,
+	MT8189_CHK_PD_PCIE_PHY = 27,
+	MT8189_CHK_PD_APU = 28,
+	MT8189_CHK_PD_NUM,
+};
+
+#ifdef CONFIG_MTK_DVFSRC_HELPER
+extern int get_sw_req_vcore_opp(void);
+#endif
+
+extern void print_subsys_reg_mt8189(enum chk_sys_id id);
+extern void set_subsys_reg_dump_mt8189(enum chk_sys_id id[]);
+extern void get_subsys_reg_dump_mt8189(void);
+extern u32 get_mt8189_reg_value(u32 id, u32 ofs);
+#endif	/* __DRV_CLKCHK_MT8189_H */
diff --git a/drivers/clk/mediatek/clkdbg-mt8189.c b/drivers/clk/mediatek/clkdbg-mt8189.c
new file mode 100644
index 000000000000..20649c3e2155
--- /dev/null
+++ b/drivers/clk/mediatek/clkdbg-mt8189.c
@@ -0,0 +1,772 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/seq_file.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <clk-mux.h>
+#include "clkdbg.h"
+#include "clkchk.h"
+#include "clk-fmeter.h"
+
+#define PWR_STA_GROUP_MT8189_NR 3
+
+static void __iomem *scpsys_base;
+
+const char * const *get_mt8189_all_clk_names(void)
+{
+	static const char * const clks[] = {
+		/* topckgen */
+		"axi_sel",
+		"axi_peri_sel",
+		"axi_u_sel",
+		"bus_aximem_sel",
+		"disp0_sel",
+		"mminfra_sel",
+		"uart_sel",
+		"spi0_sel",
+		"spi1_sel",
+		"spi2_sel",
+		"spi3_sel",
+		"spi4_sel",
+		"spi5_sel",
+		"msdc_macro_0p_sel",
+		"msdc5hclk_sel",
+		"msdc50_0_sel",
+		"aes_msdcfde_sel",
+		"msdc_macro_1p_sel",
+		"msdc30_1_sel",
+		"msdc30_1_h_sel",
+		"msdc_macro_2p_sel",
+		"msdc30_2_sel",
+		"msdc30_2_h_sel",
+		"aud_intbus_sel",
+		"atb_sel",
+		"disp_pwm_sel",
+		"usb_p0_sel",
+		"ssusb_xhci_p0_sel",
+		"usb_p1_sel",
+		"ssusb_xhci_p1_sel",
+		"usb_p2_sel",
+		"ssusb_xhci_p2_sel",
+		"usb_p3_sel",
+		"ssusb_xhci_p3_sel",
+		"usb_p4_sel",
+		"ssusb_xhci_p4_sel",
+		"i2c_sel",
+		"seninf_sel",
+		"seninf1_sel",
+		"aud_engen1_sel",
+		"aud_engen2_sel",
+		"aes_ufsfde_sel",
+		"ufs_sel",
+		"ufs_mbist_sel",
+		"aud_1_sel",
+		"aud_2_sel",
+		"venc_sel",
+		"vdec_sel",
+		"pwm_sel",
+		"audio_h_sel",
+		"mcupm_sel",
+		"mem_sub_sel",
+		"mem_sub_peri_sel",
+		"mem_sub_u_sel",
+		"emi_n_sel",
+		"dsi_occ_sel",
+		"ap2conn_host_sel",
+		"img1_sel",
+		"ipe_sel",
+		"cam_sel",
+		"camtm_sel",
+		"dsp_sel",
+		"sr_pka_sel",
+		"dxcc_sel",
+		"mfg_ref_sel",
+		"mdp0_sel",
+		"dp_sel",
+		"edp_sel",
+		"edp_favt_sel",
+		"snps_eth_250m_sel",
+		"snps_eth_62p4m_ptp_sel",
+		"snps_eth_50m_rmii_sel",
+		"sflash_sel",
+		"gcpu_sel",
+		"pcie_mac_tl_sel",
+		"vdstx_dg_cts_sel",
+		"pll_dpix_sel",
+		"ecc_sel",
+		"apll_i2sin0_m_sel",
+		"apll_i2sin1_m_sel",
+		"apll_i2sin2_m_sel",
+		"apll_i2sin3_m_sel",
+		"apll_i2sin4_m_sel",
+		"apll_i2sin6_m_sel",
+		"apll_i2sout0_m_sel",
+		"apll_i2sout1_m_sel",
+		"apll_i2sout2_m_sel",
+		"apll_i2sout3_m_sel",
+		"apll_i2sout4_m_sel",
+		"apll_i2sout6_m_sel",
+		"apll_fmi2s_m_sel",
+		"apll_tdmout_m_sel",
+		"mfg_sel_mfgpll",
+
+		/* topckgen */
+		"apll12_div_i2sin0",
+		"apll12_div_i2sin1",
+		"apll12_div_i2sout0",
+		"apll12_div_i2sout1",
+		"apll12_div_fmi2s",
+		"apll12_div_tdmout_m",
+
+		/* topckgen */
+		"fmcnt_p0_en",
+		"fmcnt_p1_en",
+		"fmcnt_p2_en",
+		"fmcnt_p3_en",
+		"fmcnt_p4_en",
+		"ssusb_f26m",
+		"sspxtp_f26m",
+		"usb2_phy_rf_p0_en",
+		"usb2_phy_rf_p1_en",
+		"usb2_phy_rf_p2_en",
+		"usb2_phy_rf_p3_en",
+		"usb2_phy_rf_p4_en",
+		"usb2_26m_p0_en",
+		"usb2_26m_p1_en",
+		"usb2_26m_p2_en",
+		"usb2_26m_p3_en",
+		"usb2_26m_p4_en",
+		"pcie_f26m",
+		"ap2con",
+		"eint_n",
+		"TOPCKGEN_fmipi_csi_up26m",
+		"eint_e",
+		"eint_w",
+		"eint_s",
+
+		/* infracfg_ao */
+		"ifrao_dma",
+		"ifrao_debugsys",
+		"ifrao_dbg_trace",
+		"ifrao_cq_dma",
+
+		/* apmixedsys */
+		"armpll-ll",
+		"armpll-bl",
+		"ccipll",
+		"mainpll",
+		"univpll",
+		"mmpll",
+		"mfgpll",
+		"apll1",
+		"apll2",
+		"emipll",
+		"apupll2",
+		"apupll",
+		"tvdpll1",
+		"tvdpll2",
+		"ethpll",
+		"msdcpll",
+		"ufspll",
+
+		/* pericfg_ao */
+		"perao_uart0",
+		"perao_uart1",
+		"perao_uart2",
+		"perao_uart3",
+		"perao_pwm_h",
+		"perao_pwm_b",
+		"perao_pwm_fb1",
+		"perao_pwm_fb2",
+		"perao_pwm_fb3",
+		"perao_pwm_fb4",
+		"perao_disp_pwm0",
+		"perao_disp_pwm1",
+		"perao_spi0_b",
+		"perao_spi1_b",
+		"perao_spi2_b",
+		"perao_spi3_b",
+		"perao_spi4_b",
+		"perao_spi5_b",
+		"perao_spi0_h",
+		"perao_spi1_h",
+		"perao_spi2_h",
+		"perao_spi3_h",
+		"perao_spi4_h",
+		"perao_spi5_h",
+		"perao_axi",
+		"perao_ahb_apb",
+		"perao_tl",
+		"perao_ref",
+		"perao_i2c",
+		"perao_dma_b",
+		"perao_ssusb0_ref",
+		"perao_ssusb0_frmcnt",
+		"perao_ssusb0_sys",
+		"perao_ssusb0_xhci",
+		"perao_ssusb0_f",
+		"perao_ssusb0_h",
+		"perao_ssusb1_ref",
+		"perao_ssusb1_frmcnt",
+		"perao_ssusb1_sys",
+		"perao_ssusb1_xhci",
+		"perao_ssusb1_f",
+		"perao_ssusb1_h",
+		"perao_ssusb2_ref",
+		"perao_ssusb2_frmcnt",
+		"perao_ssusb2_sys",
+		"perao_ssusb2_xhci",
+		"perao_ssusb2_f",
+		"perao_ssusb2_h",
+		"perao_ssusb3_ref",
+		"perao_ssusb3_frmcnt",
+		"perao_ssusb3_sys",
+		"perao_ssusb3_xhci",
+		"perao_ssusb3_f",
+		"perao_ssusb3_h",
+		"perao_ssusb4_ref",
+		"perao_ssusb4_frmcnt",
+		"perao_ssusb4_sys",
+		"perao_ssusb4_xhci",
+		"perao_ssusb4_f",
+		"perao_ssusb4_h",
+		"perao_msdc0",
+		"perao_msdc0_h",
+		"perao_msdc0_faes",
+		"perao_msdc0_mst_f",
+		"perao_msdc0_slv_h",
+		"perao_msdc1",
+		"perao_msdc1_h",
+		"perao_msdc1_mst_f",
+		"perao_msdc1_slv_h",
+		"perao_msdc2",
+		"perao_msdc2_h",
+		"perao_msdc2_mst_f",
+		"perao_msdc2_slv_h",
+		"perao_sflash",
+		"perao_sflash_f",
+		"perao_sflash_h",
+		"perao_sflash_p",
+		"perao_audio0",
+		"perao_audio1",
+		"perao_audio2",
+		"perao_auxadc_26m",
+
+		/* afe */
+		"afe_dl0_dac_tml",
+		"afe_dl0_dac_hires",
+		"afe_dl0_dac",
+		"afe_dl0_predis",
+		"afe_dl0_nle",
+		"afe_pcm0",
+		"afe_cm1",
+		"afe_cm0",
+		"afe_hw_gain23",
+		"afe_hw_gain01",
+		"afe_fm_i2s",
+		"afe_mtkaifv4",
+		"afe_dmic1_aht",
+		"afe_dmic1_adc_hires",
+		"afe_dmic1_tml",
+		"afe_dmic1_adc",
+		"afe_dmic0_aht",
+		"afe_dmic0_adc_hires",
+		"afe_dmic0_tml",
+		"afe_dmic0_adc",
+		"afe_ul0_aht",
+		"afe_ul0_adc_hires",
+		"afe_ul0_tml",
+		"afe_ul0_adc",
+		"afe_etdm_in1",
+		"afe_etdm_in0",
+		"afe_etdm_out4",
+		"afe_etdm_out1",
+		"afe_etdm_out0",
+		"afe_tdm_out",
+		"afe_general4_asrc",
+		"afe_general3_asrc",
+		"afe_general2_asrc",
+		"afe_general1_asrc",
+		"afe_general0_asrc",
+		"afe_connsys_i2s_asrc",
+		"afe_audio_hopping_ck",
+		"afe_audio_f26m_ck",
+		"afe_apll1_ck",
+		"afe_apll2_ck",
+		"afe_h208m_ck",
+		"afe_apll_tuner2",
+		"afe_apll_tuner1",
+
+		/* ufscfg_ao_reg */
+		"ufscfg_ao_unipro_tx_sym",
+		"ufscfg_ao_unipro_rx_sym0",
+		"ufscfg_ao_unipro_rx_sym1",
+		"ufscfg_ao_unipro_sys",
+		"ufscfg_ao_u_sap_cfg",
+		"ufscfg_ao_u_phy_ahb_s_bus",
+
+		/* ufscfg_pdn_reg */
+		"ufscfg_ufshci_ufs",
+		"ufscfg_ufshci_aes",
+		"ufscfg_ufshci_u_ahb",
+		"ufscfg_ufshci_u_axi",
+
+		/* imp_iic_wrap_ws */
+		"impws_i2c2",
+
+		/* imp_iic_wrap_e */
+		"impe_i2c0",
+		"impe_i2c1",
+
+		/* imp_iic_wrap_s */
+		"imps_i2c3",
+		"imps_i2c4",
+		"imps_i2c5",
+		"imps_i2c6",
+
+		/* imp_iic_wrap_en */
+		"impen_i2c7",
+		"impen_i2c8",
+
+		/* mfg */
+		"mfg_bg3d",
+
+		/* dispsys_config */
+		"mm_disp_ovl0_4l",
+		"mm_disp_ovl1_4l",
+		"mm_vpp_rsz0",
+		"mm_vpp_rsz1",
+		"mm_disp_rdma0",
+		"mm_disp_rdma1",
+		"mm_disp_color0",
+		"mm_disp_color1",
+		"mm_disp_ccorr0",
+		"mm_disp_ccorr1",
+		"mm_disp_ccorr2",
+		"mm_disp_ccorr3",
+		"mm_disp_aal0",
+		"mm_disp_aal1",
+		"mm_disp_gamma0",
+		"mm_disp_gamma1",
+		"mm_disp_dither0",
+		"mm_disp_dither1",
+		"mm_disp_dsc_wrap0",
+		"mm_vpp_merge0",
+		"mmsys_0_disp_dvo",
+		"mmsys_0_CLK0",
+		"mm_dp_intf0",
+		"mm_dpi0",
+		"mm_disp_wdma0",
+		"mm_disp_wdma1",
+		"mm_disp_fake_eng0",
+		"mm_disp_fake_eng1",
+		"mm_smi_larb",
+		"mm_disp_mutex0",
+		"mm_dipsys_config",
+		"mm_dummy",
+		"mmsys_1_CLK0",
+		"mmsys_1_lvds_encoder",
+		"mmsys_1_dpi0",
+		"mmsys_1_disp_dvo",
+		"mm_dp_intf",
+		"mmsys_1_lvds_encoder_cts",
+		"mmsys_1_disp_dvo_avt",
+
+		/* imgsys1 */
+		"imgsys1_larb9",
+		"imgsys1_larb11",
+		"imgsys1_dip",
+		"imgsys1_gals",
+
+		/* imgsys2 */
+		"imgsys2_larb9",
+		"imgsys2_larb11",
+		"imgsys2_mfb",
+		"imgsys2_wpe",
+		"imgsys2_mss",
+		"imgsys2_gals",
+
+		/* vdec_core */
+		"vdec_core_larb_cken",
+		"vdec_core_vdec_cken",
+		"vdec_core_vdec_active",
+
+		/* venc_gcon */
+		"ven1_larb",
+		"ven1_venc",
+		"ven1_jpgenc",
+		"ven1_jpgdec",
+		"ven1_jpgdec_c1",
+		"ven1_gals",
+		"ven1_gals_sram",
+
+		/* vlpcfg_reg */
+		"vlpcfg_scp_ck",
+		"vlpcfg_r_apxgpt_26m_ck",
+		"vlpcfg_dpmsrck_test_ck",
+		"vlpcfg_dpmsrrtc_test_ck",
+		"vlpcfg_dpmsrulp_test_ck",
+		"vlpcfg_spmi_p_ck",
+		"vlpcfg_spmi_p_32k_ck",
+		"vlpcfg_pmif_spmi_p_sys_ck",
+		"vlpcfg_pmif_spmi_p_tmr_ck",
+		"vlpcfg_pmif_spmi_m_sys_ck",
+		"vlpcfg_pmif_spmi_m_tmr_ck",
+		"vlpcfg_dvfsrc_ck",
+		"vlpcfg_pwm_vlp_ck",
+		"vlpcfg_srck_ck",
+		"vlpcfg_sspm_f26m_ck",
+		"vlpcfg_sspm_f32k_ck",
+		"vlpcfg_sspm_ulposc_ck",
+		"vlpcfg_vlp_32k_com_ck",
+		"vlpcfg_vlp_26m_com_ck",
+		/* vlp_cksys */
+		"vlp_scp_sel",
+		"vlp_pwrap_ulposc_sel",
+		"vlp_spmi_p_sel",
+		"vlp_dvfsrc_sel",
+		"vlp_pwm_vlp_sel",
+		"vlp_axi_vlp_sel",
+		"vlp_systimer_26m_sel",
+		"vlp_sspm_sel",
+		"vlp_sspm_f26m_sel",
+		"vlp_srck_sel",
+		"vlp_scp_spi_sel",
+		"vlp_scp_iic_sel",
+		"vlp_scp_spi_hs_sel",
+		"vlp_scp_iic_hs_sel",
+		"vlp_sspm_ulposc_sel",
+		"vlp_apxgpt_26m_sel",
+		"vlp_vadsp_sel",
+		"vlp_vadsp_vowpll_sel",
+		"vlp_vadsp_uarthub_b_sel",
+		"vlp_camtg0_sel",
+		"vlp_camtg1_sel",
+		"vlp_camtg2_sel",
+		"vlp_aud_adc_sel",
+		"vlp_kp_irq_gen_sel",
+
+		/* vlp_cksys */
+		"vlp_vadsys_vlp_26m",
+		"VLP_fmipi_csi_up26m",
+
+		/* scp_iic */
+		"scp_iic_i2c0_w1s",
+		"scp_iic_i2c1_w1s",
+
+		/* scp */
+		"scp_set_spi0",
+		"scp_set_spi1",
+
+		/* vadsys */
+		"vad_core0",
+		"vad_busemi_en",
+		"vad_timer_en",
+		"vad_dma0_en",
+		"vad_uart_en",
+		"vad_vowpll_en",
+		"vadsys_26m",
+		"vadsys_bus",
+
+		/* camsys_main */
+		"cam_m_larb13",
+		"cam_m_larb14",
+		"cam_m_camsys_main_cam",
+		"cam_m_camsys_main_camtg",
+		"cam_m_seninf",
+		"cam_m_camsv1",
+		"cam_m_camsv2",
+		"cam_m_camsv3",
+		"cam_m_fake_eng",
+		"cam_m_cam2mm_gals",
+		"cam_m_camsv4",
+		"cam_m_pda",
+
+		/* camsys_rawa */
+		"cam_ra_camsys_rawa_larbx",
+		"cam_ra_camsys_rawa_cam",
+		"cam_ra_camsys_rawa_camtg",
+
+		/* camsys_rawb */
+		"cam_rb_camsys_rawb_larbx",
+		"cam_rb_camsys_rawb_cam",
+		"cam_rb_camsys_rawb_camtg",
+
+		/* ipesys */
+		"ipe_larb19",
+		"ipe_larb20",
+		"ipe_smi_subcom",
+		"ipe_fd",
+		"ipe_fe",
+		"ipe_rsc",
+		"ipesys_gals",
+
+		/* vlpcfg_ao_reg */
+		"en",
+
+		/* dvfsrc_top */
+		"dvfsrc_dvfsrc_en",
+
+		/* mminfra_config */
+		"mminfra_gce_d",
+		"mminfra_gce_m",
+		"mminfra_smi",
+		"mminfra_gce_26m",
+
+		/* gce_d */
+		"gce_d_top",
+
+		/* gce_m */
+		"gce_m_top",
+
+		/* mdpsys_config */
+		"mdp_mutex0",
+		"mdp_apb_bus",
+		"mdp_smi0",
+		"mdp_rdma0",
+		"mdp_rdma2",
+		"mdp_hdr0",
+		"mdp_aal0",
+		"mdp_rsz0",
+		"mdp_tdshp0",
+		"mdp_color0",
+		"mdp_wrot0",
+		"mdp_fake_eng0",
+		"mdpsys_config",
+		"mdp_rdma1",
+		"mdp_rdma3",
+		"mdp_hdr1",
+		"mdp_aal1",
+		"mdp_rsz1",
+		"mdp_tdshp1",
+		"mdp_color1",
+		"mdp_wrot1",
+		"mdp_rsz2",
+		"mdp_wrot2",
+		"mdp_rsz3",
+		"mdp_wrot3",
+		"mdp_birsz0",
+		"mdp_birsz1",
+
+		/* dbgao */
+		"dbgao_atb_en",
+
+		/* dem */
+		"dem_atb_en",
+		"dem_busclk_en",
+		"dem_sysclk_en",
+	};
+
+	return clks;
+}
+
+
+/*
+ * clkdbg dump all fmeter clks
+ */
+static const struct fmeter_clk *get_all_fmeter_clks(void)
+{
+	return mt_get_fmeter_clks();
+}
+
+static u32 fmeter_freq_op(const struct fmeter_clk *fclk)
+{
+	return mt_get_fmeter_freq(fclk->id, fclk->type);
+}
+
+static const char * const *get_pwr_names(void)
+{
+	static const char * const pwr_names[] = {
+		/* PWR_STATUS & PWR_STATUS_2ND */
+		[0] = "",
+		[1] = "CONN",
+		[2] = "IFR",
+		[3] = "PERI",
+		[4] = "UFS0",
+		[5] = "",
+		[6] = "AUDIO",
+		[7] = "ADSP_TOP",
+		[8] = "ADSP_INFRA",
+		[9] = "ADSP_AO",
+		[10] = "ISP_IMG1",
+		[11] = "ISP_IMG2",
+		[12] = "ISP_IPE",
+		[13] = "",
+		[14] = "VDE0",
+		[15] = "",
+		[16] = "VEN0",
+		[17] = "",
+		[18] = "CAM_MAIN",
+		[19] = "",
+		[20] = "CAM_SUBA",
+		[21] = "CAM_SUBB",
+		[22] = "",
+		[23] = "",
+		[24] = "",
+		[25] = "",
+		[26] = "MDP0",
+		[27] = "",
+		[28] = "DIS0",
+		[29] = "",
+		[30] = "MM_INFRA",
+		[31] = "",
+		/* PWR_MSB_STATUS & PWR_MSB_STATUS_2ND */
+		[32] = "DP_TX",
+		[33] = "SCP_CORE",
+		[34] = "SCP_PERI",
+		[35] = "DPM0",
+		[36] = "DPM1",
+		[37] = "EMI0",
+		[38] = "EMI1",
+		[39] = "CSI_RX",
+		[40] = "",
+		[41] = "SSPM",
+		[42] = "SSUSB",
+		[43] = "SSUSB_PHY",
+		[44] = "EDP_TX",
+		[45] = "PCIE",
+		[46] = "PCIE_PHY",
+		[47] = "",
+		[48] = "",
+		[49] = "",
+		[50] = "",
+		[51] = "",
+		[52] = "",
+		[53] = "",
+		[54] = "",
+		[55] = "",
+		[56] = "",
+		[57] = "",
+		[58] = "",
+		[59] = "",
+		[60] = "",
+		[61] = "",
+		[62] = "",
+		[63] = "",
+		/* CPU_PWR_STATUS & CPU_PWR_STATUS_2ND */
+		[64] = "C_EB",
+		[65] = "MFG0",
+		[66] = "MFG1",
+		[67] = "MFG2",
+		[68] = "MFG3",
+		[69] = "",
+		[70] = "",
+		[71] = "",
+		[72] = "",
+		[73] = "",
+		[74] = "",
+		[75] = "",
+		[76] = "",
+		[77] = "",
+		[78] = "",
+		[79] = "",
+		[80] = "",
+		[81] = "",
+		[82] = "",
+		[83] = "",
+		[84] = "",
+		[85] = "",
+		[86] = "",
+		[87] = "",
+		[88] = "",
+		[89] = "",
+		[90] = "",
+		[91] = "",
+		[92] = "",
+		[93] = "",
+		[94] = "",
+		[95] = "",
+		/* END */
+		[96] = NULL,
+	};
+
+	return pwr_names;
+}
+
+static u32 _get_pwr_status(u32 pwr_sta_ofs, u32 pwr_sta_2nd_ofs)
+{
+	static void __iomem *pwr_sta, *pwr_sta_2nd;
+
+	pwr_sta = scpsys_base + pwr_sta_ofs;
+	pwr_sta_2nd = scpsys_base + pwr_sta_2nd_ofs;
+
+	return readl(pwr_sta) & readl(pwr_sta_2nd);
+}
+
+static u32 *get_all_pwr_status(void)
+{
+	static struct regs {
+		u32 pwr_sta_ofs;
+		u32 pwr_sta_2nd_ofs;
+	} g[] = {
+		{0xF40, 0xF44},
+		{0xF48, 0xF4C},
+		{0xF50, 0xF54},
+	};
+
+	static u32 pwr_sta[PWR_STA_GROUP_MT8189_NR];
+	int i;
+
+	for (i = 0; i < PWR_STA_GROUP_MT8189_NR; i++)
+		pwr_sta[i] = _get_pwr_status(g[i].pwr_sta_ofs, g[i].pwr_sta_2nd_ofs);
+
+	return pwr_sta;
+}
+
+/*
+ * init functions
+ */
+
+static struct clkdbg_ops clkdbg_mt8189_ops = {
+	.get_all_fmeter_clks = get_all_fmeter_clks,
+	.prepare_fmeter = NULL,
+	.unprepare_fmeter = NULL,
+	.fmeter_freq = fmeter_freq_op,
+	.get_all_clk_names = get_mt8189_all_clk_names,
+	.get_pwr_names = get_pwr_names,
+	.get_all_pwr_status = get_all_pwr_status,
+};
+
+static int clk_dbg_mt8189_probe(struct platform_device *pdev)
+{
+	set_clkdbg_ops(&clkdbg_mt8189_ops);
+
+	return 0;
+}
+
+static struct platform_driver clk_dbg_mt8189_drv = {
+	.probe = clk_dbg_mt8189_probe,
+	.driver = {
+		.name = "clk-dbg-mt8189",
+		.owner = THIS_MODULE,
+	},
+};
+
+/*
+ * init functions
+ */
+
+static int __init clkdbg_mt8189_init(void)
+{
+	scpsys_base = ioremap(0x1C001000, PAGE_SIZE);
+
+	return clk_dbg_driver_register(&clk_dbg_mt8189_drv, "clk-dbg-mt8189");
+}
+
+static void __exit clkdbg_mt8189_exit(void)
+{
+	platform_driver_unregister(&clk_dbg_mt8189_drv);
+}
+
+subsys_initcall(clkdbg_mt8189_init);
+module_exit(clkdbg_mt8189_exit);
+MODULE_LICENSE("GPL");
-- 
2.45.2


