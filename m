Return-Path: <linux-pm+bounces-22402-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0884A3B9C9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 10:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA58E1884799
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 09:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE35C1E7C25;
	Wed, 19 Feb 2025 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp6r4ahz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA861E47DD;
	Wed, 19 Feb 2025 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957226; cv=none; b=o+P1yhEi3ieLoD/CgWCCPsAALxVEIpYaa1XdPCM0BOlbsRu68yoyUg0uZiWKzcQ9uukoN8O+5MirnlI6k3gxMmnDb4innZ9nUwbiO3aCTlHhKdYK14w16+KXeqnrhsQwCzlGEk7C+/L7ansB5f6kvWAk09/V3WbJnt2IGfSCnXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957226; c=relaxed/simple;
	bh=yMw9vmIgrg1JvIZujJL9/Tz3Vh/+SQDcKSGdU3NPUII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BWM/uiFRbrtjjBVkmtPAGo0hgp7fFcQgDmRMlP+x1BEjqdNZV8K12/QyIp+NDKDfFqTinGMaS16WMVcwBybvd99OG4VDL1oxwEFkqqNgUppvYeRPFhdNScv7gwysDUSEyYCrzA44sUFMQ5klVUl5Qaa+8PkN1+ymaBybPSIKmXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp6r4ahz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D499EC4CEF3;
	Wed, 19 Feb 2025 09:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739957225;
	bh=yMw9vmIgrg1JvIZujJL9/Tz3Vh/+SQDcKSGdU3NPUII=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gp6r4ahzo0zBOrq7fpgZRfbkyVKhs5mMu1DvgpvJUAgEBFhVFYyp9lwpDJMYthFBe
	 Cu+G7hYcxZYzSefKcQ9BBeNq0+IeJFq2Gdfhm1o3iOAUB9ZyDD5DVbAZgvHsCgUtqF
	 ki5GlYxv0JQwl/9+p+lzQO6ph2PzMpiWyoLZh9jDFxWm2Ob18MLleJVpks7ucdZrY5
	 5SYqAKY4nC2+eqGFx4XuNScxyF7QA5hI+HHv/kQGAIjbDxtSLsfvYubnkVDGYtSnTL
	 UEs1QlnxRacvO3ZtudoN7XV/0mhNyVqM7C+YxVbTND4sOnmLJ/J+TP41HvPMRmoDRC
	 2zVOcl2exFORw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AF3C021B0;
	Wed, 19 Feb 2025 09:27:05 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Wed, 19 Feb 2025 10:27:00 +0100
Subject: [PATCH 4/5] media: apple: Add Apple ISP driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-isp-v1-4-6d3e89b67c31@gmail.com>
References: <20250219-isp-v1-0-6d3e89b67c31@gmail.com>
In-Reply-To: <20250219-isp-v1-0-6d3e89b67c31@gmail.com>
To: Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-media@vger.kernel.org, imx@lists.linux.dev, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Eileen Yoon <eyn@gmx.com>, 
 Asahi Lina <lina@asahilina.net>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739957223; l=146595;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=Y5AdVy05ng5aR3cJJSTmEv1iGAwuTX7g27+sGVZy9us=;
 b=zrAFAjh9v/UfMGrnaQQd4GTGZbT+FMhZXaUiCiYsvqB2U5ZIlURXJCzWquhaK0SMKT8ljOblz
 OGs8JgZD5DmCsWPEg1tTZVoL04n1fLAym0Yq2asVNU+suKvMAw3QBQH
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Eileen Yoon <eyn@gmx.com>

This is the ISP and camera module present on certain Apple laptops

Signed-off-by: Eileen Yoon <eyn@gmx.com>
Co-developed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Hector Martin <marcan@marcan.st>
Co-developed-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Asahi Lina <lina@asahilina.net>
Co-developed-by: Janne Grunau <j@jannau.net>
Signed-off-by: Janne Grunau <j@jannau.net>
Co-developed-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 MAINTAINERS                                  |   1 +
 drivers/media/platform/Kconfig               |   1 +
 drivers/media/platform/Makefile              |   1 +
 drivers/media/platform/apple/Kconfig         |   5 +
 drivers/media/platform/apple/Makefile        |   3 +
 drivers/media/platform/apple/isp/Kconfig     |  16 +
 drivers/media/platform/apple/isp/Makefile    |   3 +
 drivers/media/platform/apple/isp/isp-cam.c   | 414 ++++++++++++
 drivers/media/platform/apple/isp/isp-cam.h   |  21 +
 drivers/media/platform/apple/isp/isp-cmd.c   | 635 +++++++++++++++++++
 drivers/media/platform/apple/isp/isp-cmd.h   | 692 ++++++++++++++++++++
 drivers/media/platform/apple/isp/isp-drv.c   | 586 +++++++++++++++++
 drivers/media/platform/apple/isp/isp-drv.h   | 284 +++++++++
 drivers/media/platform/apple/isp/isp-fw.c    | 770 +++++++++++++++++++++++
 drivers/media/platform/apple/isp/isp-fw.h    |  24 +
 drivers/media/platform/apple/isp/isp-iommu.c | 251 ++++++++
 drivers/media/platform/apple/isp/isp-iommu.h |  20 +
 drivers/media/platform/apple/isp/isp-ipc.c   | 258 ++++++++
 drivers/media/platform/apple/isp/isp-ipc.h   |  25 +
 drivers/media/platform/apple/isp/isp-regs.h  |  56 ++
 drivers/media/platform/apple/isp/isp-v4l2.c  | 900 +++++++++++++++++++++++++++
 drivers/media/platform/apple/isp/isp-v4l2.h  |  16 +
 22 files changed, 4982 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dea7239ee0f5464b31efed5a2e0e5e602bcb6439..60517f7dcee14fc942dd3f77ed5d58eae394f7fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2248,6 +2248,7 @@ F:	drivers/i2c/busses/i2c-pasemi-platform.c
 F:	drivers/iommu/apple-dart.c
 F:	drivers/iommu/io-pgtable-dart.c
 F:	drivers/irqchip/irq-apple-aic.c
+F:	drivers/media/platform/apple/*
 F:	drivers/nvme/host/apple.c
 F:	drivers/nvmem/apple-efuses.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 85d2627776b6a424fbd392187669535c4159ec97..ba75cfdb57f710cca086136e4524d3e1bc1910ac 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -65,6 +65,7 @@ config VIDEO_MUX
 source "drivers/media/platform/allegro-dvt/Kconfig"
 source "drivers/media/platform/amlogic/Kconfig"
 source "drivers/media/platform/amphion/Kconfig"
+source "drivers/media/platform/apple/Kconfig"
 source "drivers/media/platform/aspeed/Kconfig"
 source "drivers/media/platform/atmel/Kconfig"
 source "drivers/media/platform/broadcom/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index ace4e34483ddce6c3361479989086145dd495f29..e59e4259064bf04b718ea8d128031af859a13d2e 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -8,6 +8,7 @@
 obj-y += allegro-dvt/
 obj-y += amlogic/
 obj-y += amphion/
+obj-y += apple/
 obj-y += aspeed/
 obj-y += atmel/
 obj-y += broadcom/
diff --git a/drivers/media/platform/apple/Kconfig b/drivers/media/platform/apple/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..f16508bff5242a0bc433bf8a1d8e3f29737d20d1
--- /dev/null
+++ b/drivers/media/platform/apple/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+comment "Apple media platform drivers"
+
+source "drivers/media/platform/apple/isp/Kconfig"
diff --git a/drivers/media/platform/apple/Makefile b/drivers/media/platform/apple/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..d8fe985b0e6c377de6c77d30a3a796c40f3da116
--- /dev/null
+++ b/drivers/media/platform/apple/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-y += isp/
diff --git a/drivers/media/platform/apple/isp/Kconfig b/drivers/media/platform/apple/isp/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..8e94962990031304d51cdd7cd6190b05b05b40bb
--- /dev/null
+++ b/drivers/media/platform/apple/isp/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config VIDEO_APPLE_ISP
+	tristate "Apple Silicon Image Signal Processor driver"
+	select VIDEOBUF2_CORE
+	select VIDEOBUF2_V4L2
+	select VIDEOBUF2_DMA_SG
+	depends on ARCH_APPLE || COMPILE_TEST
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_DEV
+	help
+	  Say Y here to enable support for the ISP and cameras persent
+	  in Apple ARM laptops.
+
+	  To compile this driver as a module, choose M here. The module will be
+	  called apple_isp
diff --git a/drivers/media/platform/apple/isp/Makefile b/drivers/media/platform/apple/isp/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..4649f32987f025a639945a37d774d4ecdc83b02a
--- /dev/null
+++ b/drivers/media/platform/apple/isp/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+apple-isp-y := isp-cam.o isp-cmd.o isp-drv.o isp-fw.o isp-iommu.o isp-ipc.o isp-v4l2.o
+obj-$(CONFIG_VIDEO_APPLE_ISP) += apple-isp.o
diff --git a/drivers/media/platform/apple/isp/isp-cam.c b/drivers/media/platform/apple/isp/isp-cam.c
new file mode 100644
index 0000000000000000000000000000000000000000..bdf46666987ec61a432d384ae0bd4173230aa82c
--- /dev/null
+++ b/drivers/media/platform/apple/isp/isp-cam.c
@@ -0,0 +1,414 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright 2023 Eileen Yoon <eyn@gmx.com> */
+
+#include <linux/firmware.h>
+
+#include "isp-cam.h"
+#include "isp-cmd.h"
+#include "isp-fw.h"
+#include "isp-iommu.h"
+
+#define ISP_MAX_PRESETS 32
+
+struct isp_setfile {
+	u32 version;
+	u32 magic;
+	const char *path;
+	size_t size;
+};
+
+static const struct isp_setfile isp_setfiles[] = {
+	[ISP_IMX248_1820_01] = {0x248, 0x18200103, "apple/isp_1820_01XX.dat", 0x442c},
+	[ISP_IMX248_1822_02] = {0x248, 0x18220201, "apple/isp_1822_02XX.dat", 0x442c},
+	[ISP_IMX343_5221_02] = {0x343, 0x52210211, "apple/isp_5221_02XX.dat", 0x4870},
+	[ISP_IMX354_9251_02] = {0x354, 0x92510208, "apple/isp_9251_02XX.dat", 0xa5ec},
+	[ISP_IMX356_4820_01] = {0x356, 0x48200107, "apple/isp_4820_01XX.dat", 0x9324},
+	[ISP_IMX356_4820_02] = {0x356, 0x48200206, "apple/isp_4820_02XX.dat", 0x9324},
+	[ISP_IMX364_8720_01] = {0x364, 0x87200103, "apple/isp_8720_01XX.dat", 0x36ac},
+	[ISP_IMX364_8723_01] = {0x364, 0x87230101, "apple/isp_8723_01XX.dat", 0x361c},
+	[ISP_IMX372_3820_01] = {0x372, 0x38200108, "apple/isp_3820_01XX.dat", 0xfdb0},
+	[ISP_IMX372_3820_02] = {0x372, 0x38200205, "apple/isp_3820_02XX.dat", 0xfdb0},
+	[ISP_IMX372_3820_11] = {0x372, 0x38201104, "apple/isp_3820_11XX.dat", 0xfdb0},
+	[ISP_IMX372_3820_12] = {0x372, 0x38201204, "apple/isp_3820_12XX.dat", 0xfdb0},
+	[ISP_IMX405_9720_01] = {0x405, 0x97200102, "apple/isp_9720_01XX.dat", 0x92c8},
+	[ISP_IMX405_9721_01] = {0x405, 0x97210102, "apple/isp_9721_01XX.dat", 0x9818},
+	[ISP_IMX405_9723_01] = {0x405, 0x97230101, "apple/isp_9723_01XX.dat", 0x92c8},
+	[ISP_IMX414_2520_01] = {0x414, 0x25200102, "apple/isp_2520_01XX.dat", 0xa444},
+	[ISP_IMX503_7820_01] = {0x503, 0x78200109, "apple/isp_7820_01XX.dat", 0xb268},
+	[ISP_IMX503_7820_02] = {0x503, 0x78200206, "apple/isp_7820_02XX.dat", 0xb268},
+	[ISP_IMX505_3921_01] = {0x505, 0x39210102, "apple/isp_3921_01XX.dat", 0x89b0},
+	[ISP_IMX514_2820_01] = {0x514, 0x28200108, "apple/isp_2820_01XX.dat", 0xa198},
+	[ISP_IMX514_2820_02] = {0x514, 0x28200205, "apple/isp_2820_02XX.dat", 0xa198},
+	[ISP_IMX514_2820_03] = {0x514, 0x28200305, "apple/isp_2820_03XX.dat", 0xa198},
+	[ISP_IMX514_2820_04] = {0x514, 0x28200405, "apple/isp_2820_04XX.dat", 0xa198},
+	[ISP_IMX558_1921_01] = {0x558, 0x19210106, "apple/isp_1921_01XX.dat", 0xad40},
+	[ISP_IMX558_1922_02] = {0x558, 0x19220201, "apple/isp_1922_02XX.dat", 0xad40},
+	[ISP_IMX603_7920_01] = {0x603, 0x79200109, "apple/isp_7920_01XX.dat", 0xad2c},
+	[ISP_IMX603_7920_02] = {0x603, 0x79200205, "apple/isp_7920_02XX.dat", 0xad2c},
+	[ISP_IMX603_7921_01] = {0x603, 0x79210104, "apple/isp_7921_01XX.dat", 0xad90},
+	[ISP_IMX613_4920_01] = {0x613, 0x49200108, "apple/isp_4920_01XX.dat", 0x9324},
+	[ISP_IMX613_4920_02] = {0x613, 0x49200204, "apple/isp_4920_02XX.dat", 0x9324},
+	[ISP_IMX614_2921_01] = {0x614, 0x29210107, "apple/isp_2921_01XX.dat", 0xed6c},
+	[ISP_IMX614_2921_02] = {0x614, 0x29210202, "apple/isp_2921_02XX.dat", 0xed6c},
+	[ISP_IMX614_2922_02] = {0x614, 0x29220201, "apple/isp_2922_02XX.dat", 0xed6c},
+	[ISP_IMX633_3622_01] = {0x633, 0x36220111, "apple/isp_3622_01XX.dat", 0x100d4},
+	[ISP_IMX703_7721_01] = {0x703, 0x77210106, "apple/isp_7721_01XX.dat", 0x936c},
+	[ISP_IMX703_7722_01] = {0x703, 0x77220106, "apple/isp_7722_01XX.dat", 0xac20},
+	[ISP_IMX713_4721_01] = {0x713, 0x47210107, "apple/isp_4721_01XX.dat", 0x936c},
+	[ISP_IMX713_4722_01] = {0x713, 0x47220109, "apple/isp_4722_01XX.dat", 0x9218},
+	[ISP_IMX714_2022_01] = {0x714, 0x20220107, "apple/isp_2022_01XX.dat", 0xa198},
+	[ISP_IMX772_3721_01] = {0x772, 0x37210106, "apple/isp_3721_01XX.dat", 0xfdf8},
+	[ISP_IMX772_3721_11] = {0x772, 0x37211106, "apple/isp_3721_11XX.dat", 0xfe14},
+	[ISP_IMX772_3722_01] = {0x772, 0x37220104, "apple/isp_3722_01XX.dat", 0xfca4},
+	[ISP_IMX772_3723_01] = {0x772, 0x37230106, "apple/isp_3723_01XX.dat", 0xfca4},
+	[ISP_IMX814_2123_01] = {0x814, 0x21230101, "apple/isp_2123_01XX.dat", 0xed54},
+	[ISP_IMX853_7622_01] = {0x853, 0x76220112, "apple/isp_7622_01XX.dat", 0x247f8},
+	[ISP_IMX913_7523_01] = {0x913, 0x75230107, "apple/isp_7523_01XX.dat", 0x247f8},
+	[ISP_VD56G0_6221_01] = {0xd56, 0x62210102, "apple/isp_6221_01XX.dat", 0x1b80},
+	[ISP_VD56G0_6222_01] = {0xd56, 0x62220102, "apple/isp_6222_01XX.dat", 0x1b80},
+};
+
+struct isp_version {
+	u32 version;
+	enum isp_sensor_id id;
+};
+
+static const struct isp_version isp_versions[] = {
+	{0x248, ISP_IMX248_1820_01},
+	{0x343, ISP_IMX343_5221_02},
+	{0x354, ISP_IMX354_9251_02},
+	{0x356, ISP_IMX356_4820_01},
+	{0x364, ISP_IMX364_8720_01},
+	{0x372, ISP_IMX372_3820_01},
+	{0x405, ISP_IMX405_9720_01},
+	{0x414, ISP_IMX414_2520_01},
+	{0x503, ISP_IMX503_7820_01},
+	{0x505, ISP_IMX505_3921_01},
+	{0x514, ISP_IMX514_2820_01},
+	{0x558, ISP_IMX558_1921_01},
+	{0x603, ISP_IMX603_7920_01},
+	{0x613, ISP_IMX613_4920_01},
+	{0x614, ISP_IMX614_2921_01},
+	{0x633, ISP_IMX633_3622_01},
+	{0x703, ISP_IMX703_7721_01},
+	{0x713, ISP_IMX713_4721_01},
+	{0x714, ISP_IMX714_2022_01},
+	{0x772, ISP_IMX772_3721_01},
+	{0x814, ISP_IMX814_2123_01},
+	{0x853, ISP_IMX853_7622_01},
+	{0x913, ISP_IMX913_7523_01},
+	{0xd56, ISP_VD56G0_6221_01},
+};
+
+static int isp_ch_get_sensor_id(struct apple_isp *isp, u32 ch)
+{
+	struct isp_format *fmt = isp_get_format(isp, ch);
+	int i;
+
+	/* TODO need more datapoints to figure out the sub-versions
+	 * Defaulting to 1st release for now, the calib files aren't too different.
+	 */
+	for (i = 0; i < ARRAY_SIZE(isp_versions); i++) {
+		if (isp_versions[i].version == fmt->version) {
+			fmt->id = isp_versions[i].id;
+			return 0;
+		}
+	}
+
+	dev_err(isp->dev, "invalid sensor version: 0x%x\n",
+		fmt->version);
+
+	return -EINVAL;
+}
+
+static int isp_ch_cache_sensor_info(struct apple_isp *isp, u32 ch)
+{
+	struct isp_format *fmt = isp_get_format(isp, ch);
+	struct cmd_ch_info *args; /* Too big to allocate on stack */
+	int err = 0;
+
+	args = kzalloc(sizeof(*args), GFP_KERNEL);
+	if (!args)
+		return -ENOMEM;
+
+	err = apple_isp_cmd_ch_info_get(isp, ch, args);
+	if (err)
+		goto exit;
+
+	dev_info(isp->dev, "found sensor %x %s on ch %d\n", args->version,
+		 args->module_sn, ch);
+
+	fmt->version = args->version;
+
+	err = isp_ch_get_sensor_id(isp, ch);
+	if (err ||
+	    (fmt->id != ISP_IMX248_1820_01 && fmt->id != ISP_IMX558_1921_01 &&
+	     fmt->id != ISP_IMX364_8720_01)) {
+		dev_err(isp->dev,
+			"ch %d: unsupported sensor. Please file a bug report with hardware info & dmesg trace.\n",
+			ch);
+		return -ENODEV;
+	}
+
+exit:
+	kfree(args);
+
+	return err;
+}
+
+static int isp_detect_camera(struct apple_isp *isp)
+{
+	int err;
+	struct cmd_config_get args;
+
+	memset(&args, 0, sizeof(args));
+
+	err = apple_isp_cmd_config_get(isp, &args);
+	if (err)
+		return err;
+
+	if (!args.num_channels) {
+		dev_err(isp->dev, "did not detect any channels\n");
+		return -ENODEV;
+	}
+
+	if (args.num_channels > ISP_MAX_CHANNELS) {
+		dev_warn(isp->dev, "found %d channels when maximum is %d\n",
+			 args.num_channels, ISP_MAX_CHANNELS);
+		args.num_channels = ISP_MAX_CHANNELS;
+	}
+
+	if (args.num_channels > 1) {
+		dev_warn(
+			isp->dev,
+			"warning: driver doesn't support multiple channels. Please file a bug report with hardware info & dmesg trace.\n");
+	}
+
+	isp->num_channels = args.num_channels;
+	isp->current_ch = 0;
+
+	err = isp_ch_cache_sensor_info(isp, isp->current_ch);
+	if (err) {
+		dev_err(isp->dev, "failed to cache sensor info\n");
+		return err;
+	}
+
+	return 0;
+}
+
+int apple_isp_detect_camera(struct apple_isp *isp)
+{
+	int err;
+
+	/* RPM must be enabled prior to calling this */
+	err = apple_isp_firmware_boot(isp);
+	if (err) {
+		dev_err(isp->dev,
+			"failed to boot firmware for initial sensor detection: %d\n",
+			err);
+		return -EPROBE_DEFER;
+	}
+
+	err = isp_detect_camera(isp);
+
+	apple_isp_cmd_flicker_sensor_set(isp, 0);
+
+	apple_isp_cmd_ch_stop(isp, 0);
+	apple_isp_cmd_ch_buffer_return(isp, isp->current_ch);
+
+	apple_isp_firmware_shutdown(isp);
+
+	return err;
+}
+
+static int isp_ch_load_setfile(struct apple_isp *isp, u32 ch)
+{
+	struct isp_format *fmt = isp_get_format(isp, ch);
+	const struct isp_setfile *setfile = &isp_setfiles[fmt->id];
+	const struct firmware *fw;
+	u32 magic;
+	int err;
+
+	err = request_firmware(&fw, setfile->path, isp->dev);
+	if (err) {
+		dev_err(isp->dev, "failed to request setfile '%s': %d\n",
+			setfile->path, err);
+		return err;
+	}
+
+	if (fw->size < setfile->size) {
+		dev_err(isp->dev, "setfile too small (0x%lx/0x%zx)\n", fw->size,
+			setfile->size);
+		release_firmware(fw);
+		return -EINVAL;
+	}
+
+	magic = be32_to_cpup((__be32 *)fw->data);
+	if (magic != setfile->magic) {
+		dev_err(isp->dev, "setfile '%s' corrupted?\n", setfile->path);
+		release_firmware(fw);
+		return -EINVAL;
+	}
+
+	memcpy(isp->data_surf->virt, (void *)fw->data, setfile->size);
+	release_firmware(fw);
+
+	return apple_isp_cmd_ch_set_file_load(isp, ch, isp->data_surf->iova,
+					      setfile->size);
+}
+
+static int isp_ch_configure_capture(struct apple_isp *isp, u32 ch)
+{
+	struct isp_format *fmt = isp_get_format(isp, ch);
+	int err;
+
+	apple_isp_cmd_flicker_sensor_set(isp, 0);
+
+	err = isp_ch_load_setfile(isp, ch);
+	if (err) {
+		dev_err(isp->dev, "calibration data not loaded: %d\n",
+			err);
+		return err;
+	}
+
+	if (isp->hw->lpdp) {
+		err = apple_isp_cmd_ch_lpdp_hs_receiver_tuning_set(isp, ch, 1, 15);
+		if (err)
+			return err;
+	}
+
+	err = apple_isp_cmd_ch_sbs_enable(isp, ch, 1);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_ch_camera_config_select(isp, ch, fmt->preset->index);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_ch_buffer_recycle_mode_set(
+		isp, ch, CISP_BUFFER_RECYCLE_MODE_EMPTY_ONLY);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_ch_buffer_recycle_start(isp, ch);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_ch_crop_set(isp, ch, fmt->preset->crop_offset.x,
+					fmt->preset->crop_offset.y,
+					fmt->preset->crop_size.x,
+					fmt->preset->crop_size.y);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_ch_output_config_set(isp, ch, fmt->preset->output_dim.x,
+						 fmt->preset->output_dim.y,
+						 fmt->strides, CISP_COLORSPACE_REC709,
+						 CISP_OUTPUT_FORMAT_YUV_2PLANE);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_ch_preview_stream_set(isp, ch, 1);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_ch_cnr_start(isp, ch);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_ch_mbnr_enable(isp, ch, 0, ISP_MBNR_MODE_ENABLE, 1);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_apple_ch_ae_fd_scene_metering_config_set(isp, ch);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_apple_ch_ae_metering_mode_set(isp, ch, 3);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_ch_ae_stability_set(isp, ch, 32);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_ch_ae_stability_to_stable_set(isp, ch, 20);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_ch_sif_pixel_format_set(isp, ch);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_ch_ae_frame_rate_max_set(isp, ch, ISP_FRAME_RATE_DEN);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_ch_ae_frame_rate_min_set(isp, ch, ISP_FRAME_RATE_DEN2);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_apple_ch_temporal_filter_start(isp, ch, isp->temporal_filter);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_apple_ch_motion_history_start(isp, ch);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_apple_ch_temporal_filter_enable(isp, ch);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_ch_buffer_pool_config_set(isp, ch, CISP_POOL_TYPE_META);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_ch_buffer_pool_config_set(isp, ch,
+						      CISP_POOL_TYPE_META_CAPTURE);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int isp_configure_capture(struct apple_isp *isp)
+{
+	return isp_ch_configure_capture(isp, isp->current_ch);
+}
+
+int apple_isp_start_camera(struct apple_isp *isp)
+{
+	int err;
+
+	err = apple_isp_firmware_boot(isp);
+	if (err) {
+		dev_err(isp->dev, "failed to boot firmware: %d\n", err);
+		return err;
+	}
+
+	err = isp_configure_capture(isp);
+	if (err) {
+		dev_err(isp->dev, "failed to configure capture: %d\n", err);
+		apple_isp_firmware_shutdown(isp);
+		return err;
+	}
+
+	return 0;
+}
+
+void apple_isp_stop_camera(struct apple_isp *isp)
+{
+	apple_isp_firmware_shutdown(isp);
+}
+
+int apple_isp_start_capture(struct apple_isp *isp)
+{
+	return apple_isp_cmd_ch_start(isp, 0);
+}
+
+void apple_isp_stop_capture(struct apple_isp *isp)
+{
+	apple_isp_cmd_ch_stop(isp, 0);
+	apple_isp_cmd_ch_buffer_return(isp, isp->current_ch);
+}
diff --git a/drivers/media/platform/apple/isp/isp-cam.h b/drivers/media/platform/apple/isp/isp-cam.h
new file mode 100644
index 0000000000000000000000000000000000000000..2372cf2e012bebd775f7d4d45836bb6d06c54b5c
--- /dev/null
+++ b/drivers/media/platform/apple/isp/isp-cam.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2023 Eileen Yoon <eyn@gmx.com> */
+
+#ifndef __ISP_CAM_H__
+#define __ISP_CAM_H__
+
+#include "isp-drv.h"
+
+#define ISP_FRAME_RATE_NUM 256
+#define ISP_FRAME_RATE_DEN 7680
+#define ISP_FRAME_RATE_DEN2 3840
+
+int apple_isp_detect_camera(struct apple_isp *isp);
+
+int apple_isp_start_camera(struct apple_isp *isp);
+void apple_isp_stop_camera(struct apple_isp *isp);
+
+int apple_isp_start_capture(struct apple_isp *isp);
+void apple_isp_stop_capture(struct apple_isp *isp);
+
+#endif /* __ISP_CAM_H__ */
diff --git a/drivers/media/platform/apple/isp/isp-cmd.c b/drivers/media/platform/apple/isp/isp-cmd.c
new file mode 100644
index 0000000000000000000000000000000000000000..5b678023b9b9c9497606c1cbb406bc99121785d6
--- /dev/null
+++ b/drivers/media/platform/apple/isp/isp-cmd.c
@@ -0,0 +1,635 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright 2023 Eileen Yoon <eyn@gmx.com> */
+
+#include "isp-cmd.h"
+#include "isp-drv.h"
+#include "isp-iommu.h"
+#include "isp-ipc.h"
+
+#define CISP_OPCODE_SHIFT     32UL
+#define CISP_OPCODE(x)	      (((u64)(x)) << CISP_OPCODE_SHIFT)
+#define CISP_OPCODE_GET(x)    (((u64)(x)) >> CISP_OPCODE_SHIFT)
+
+#define CISP_TIMEOUT	      msecs_to_jiffies(3000)
+#define CISP_SEND_IN(x, a)    (cisp_send((x), &(a), sizeof(a), 0, CISP_TIMEOUT))
+#define CISP_SEND_INOUT(x, a) (cisp_send((x), &(a), sizeof(a), sizeof(a), CISP_TIMEOUT))
+#define CISP_SEND_OUT(x, a)   (cisp_send_read((x), (a), sizeof(*a), sizeof(*a)))
+#define CISP_POST_IN(x, a)    (cisp_send((x), &(a), sizeof(a), 0, 0))
+#define CISP_POST_INOUT(x, a)    (cisp_send((x), &(a), sizeof(a), sizeof(a), 0))
+
+static int cisp_send(struct apple_isp *isp, void *args, u32 insize, u32 outsize, int timeout)
+{
+	struct isp_channel *chan = isp->chan_io;
+	struct isp_message *req = &chan->req;
+	u64 opcode;
+	int err;
+
+	req->arg0 = isp->cmd_iova;
+	req->arg1 = insize;
+	req->arg2 = outsize;
+
+	memcpy(isp->cmd_virt, args, insize);
+	err = apple_isp_ipc_chan_send(isp, chan, timeout);
+	if (err) {
+		memcpy(&opcode, args, sizeof(opcode));
+		dev_err(isp->dev,
+			"%s: failed to send OPCODE 0x%04llx: [0x%llx, 0x%llx, 0x%llx]\n",
+			chan->name, CISP_OPCODE_GET(opcode), req->arg0,
+			req->arg1, req->arg2);
+	}
+
+	return err;
+}
+
+static int cisp_send_read(struct apple_isp *isp, void *args, u32 insize,
+			  u32 outsize)
+{
+	int err;
+
+	err = cisp_send(isp, args, insize, outsize, CISP_TIMEOUT);
+	if (err)
+		return err;
+
+	memcpy(args, isp->cmd_virt, outsize);
+	return 0;
+}
+
+int apple_isp_cmd_start(struct apple_isp *isp, u32 mode)
+{
+	struct cmd_start args = {
+		.opcode = CISP_OPCODE(CISP_CMD_START),
+		.mode = mode,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_stop(struct apple_isp *isp, u32 mode)
+{
+	struct cmd_stop args = {
+		.opcode = CISP_OPCODE(CISP_CMD_STOP),
+		.mode = mode,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_power_down(struct apple_isp *isp)
+{
+	struct cmd_power_down args = {
+		.opcode = CISP_OPCODE(CISP_CMD_POWER_DOWN),
+	};
+	return CISP_POST_INOUT(isp, args);
+}
+
+int apple_isp_cmd_suspend(struct apple_isp *isp)
+{
+	struct cmd_suspend args = {
+		.opcode = CISP_OPCODE(CISP_CMD_SUSPEND),
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_print_enable(struct apple_isp *isp, u32 enable)
+{
+	struct cmd_print_enable args = {
+		.opcode = CISP_OPCODE(CISP_CMD_PRINT_ENABLE),
+		.enable = enable,
+	};
+	return CISP_SEND_INOUT(isp, args);
+}
+
+int apple_isp_cmd_trace_enable(struct apple_isp *isp, u32 enable)
+{
+	struct cmd_trace_enable args = {
+		.opcode = CISP_OPCODE(CISP_CMD_TRACE_ENABLE),
+		.enable = enable,
+	};
+	return CISP_SEND_INOUT(isp, args);
+}
+
+int apple_isp_cmd_config_get(struct apple_isp *isp, struct cmd_config_get *args)
+{
+	args->opcode = CISP_OPCODE(CISP_CMD_CONFIG_GET);
+	return CISP_SEND_OUT(isp, args);
+}
+
+int apple_isp_cmd_set_isp_pmu_base(struct apple_isp *isp, u64 pmu_base)
+{
+	struct cmd_set_isp_pmu_base args = {
+		.opcode = CISP_OPCODE(CISP_CMD_SET_ISP_PMU_BASE),
+		.pmu_base = pmu_base,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_set_dsid_clr_req_base2(struct apple_isp *isp, u64 dsid_clr_base0,
+					 u64 dsid_clr_base1, u64 dsid_clr_base2,
+					 u64 dsid_clr_base3, u32 dsid_clr_range0,
+					 u32 dsid_clr_range1, u32 dsid_clr_range2,
+					 u32 dsid_clr_range3)
+{
+	struct cmd_set_dsid_clr_req_base2 args = {
+		.opcode = CISP_OPCODE(CISP_CMD_SET_DSID_CLR_REG_BASE2),
+		.dsid_clr_base0 = dsid_clr_base0,
+		.dsid_clr_base1 = dsid_clr_base1,
+		.dsid_clr_base2 = dsid_clr_base2,
+		.dsid_clr_base3 = dsid_clr_base3,
+		.dsid_clr_range0 = dsid_clr_range0,
+		.dsid_clr_range1 = dsid_clr_range1,
+		.dsid_clr_range2 = dsid_clr_range2,
+		.dsid_clr_range3 = dsid_clr_range3,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_set_dsid_clr_req_base(struct apple_isp *isp, u64 dsid_clr_base,
+					u32 dsid_clr_range)
+{
+	struct cmd_set_dsid_clr_req_base args = {
+		.opcode = CISP_OPCODE(CISP_CMD_SET_DSID_CLR_REG_BASE),
+		.dsid_clr_base = dsid_clr_base,
+		.dsid_clr_range = dsid_clr_range,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_pmp_ctrl_set(struct apple_isp *isp, u64 clock_scratch,
+			       u64 clock_base, u8 clock_bit, u8 clock_size,
+			       u64 bandwidth_scratch, u64 bandwidth_base,
+			       u8 bandwidth_bit, u8 bandwidth_size)
+{
+	struct cmd_pmp_ctrl_set args = {
+		.opcode = CISP_OPCODE(CISP_CMD_PMP_CTRL_SET),
+		.clock_scratch = clock_scratch,
+		.clock_base = clock_base,
+		.clock_bit = clock_bit,
+		.clock_size = clock_size,
+		.clock_pad = 0,
+		.bandwidth_scratch = bandwidth_scratch,
+		.bandwidth_base = bandwidth_base,
+		.bandwidth_bit = bandwidth_bit,
+		.bandwidth_size = bandwidth_size,
+		.bandwidth_pad = 0,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_fid_enter(struct apple_isp *isp)
+{
+	struct cmd_fid_enter args = {
+		.opcode = CISP_OPCODE(CISP_CMD_FID_ENTER),
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_fid_exit(struct apple_isp *isp)
+{
+	struct cmd_fid_exit args = {
+		.opcode = CISP_OPCODE(CISP_CMD_FID_EXIT),
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_start(struct apple_isp *isp, u32 chan)
+{
+	struct cmd_ch_start args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_START),
+		.chan = chan,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_stop(struct apple_isp *isp, u32 chan)
+{
+	struct cmd_ch_stop args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_STOP),
+		.chan = chan,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_flicker_sensor_set(struct apple_isp *isp, u32 mode)
+{
+	struct cmd_flicker_sensor_set args = {
+		.opcode = CISP_OPCODE(CISP_CMD_FLICKER_SENSOR_SET),
+		.mode = mode,
+	};
+	return CISP_SEND_INOUT(isp, args);
+}
+
+int apple_isp_cmd_ch_info_get(struct apple_isp *isp, u32 chan,
+			      struct cmd_ch_info *args)
+{
+	args->opcode = CISP_OPCODE(CISP_CMD_CH_INFO_GET);
+	args->chan = chan;
+	return CISP_SEND_OUT(isp, args);
+}
+
+int apple_isp_cmd_ch_camera_config_get(struct apple_isp *isp, u32 chan, u32 preset,
+				       struct cmd_ch_camera_config *args)
+{
+	args->opcode = CISP_OPCODE(CISP_CMD_CH_CAMERA_CONFIG_GET);
+	args->preset = preset;
+	args->chan = chan;
+	return CISP_SEND_OUT(isp, args);
+}
+
+int apple_isp_cmd_ch_camera_config_current_get(struct apple_isp *isp, u32 chan,
+					       struct cmd_ch_camera_config *args)
+{
+	args->opcode = CISP_OPCODE(CISP_CMD_CH_CAMERA_CONFIG_CURRENT_GET);
+	args->chan = chan;
+	return CISP_SEND_OUT(isp, args);
+}
+
+int apple_isp_cmd_ch_camera_config_select(struct apple_isp *isp, u32 chan, u32 preset)
+{
+	struct cmd_ch_camera_config_select args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_CAMERA_CONFIG_SELECT),
+		.chan = chan,
+		.preset = preset,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_buffer_return(struct apple_isp *isp, u32 chan)
+{
+	struct cmd_ch_buffer_return args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_BUFFER_RETURN),
+		.chan = chan,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_set_file_load(struct apple_isp *isp, u32 chan, u64 addr,
+				   u32 size)
+{
+	if (isp->fw_compat >= ISP_FIRMWARE_V_13_5) {
+		struct cmd_ch_set_file_load64 args = {
+			.opcode = CISP_OPCODE(CISP_CMD_CH_SET_FILE_LOAD),
+			.chan = chan,
+			.addr = addr,
+			.size = size,
+		};
+		return CISP_SEND_IN(isp, args);
+	}
+	struct cmd_ch_set_file_load args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_SET_FILE_LOAD),
+		.chan = chan,
+		.addr = addr,
+		.size = size,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_sbs_enable(struct apple_isp *isp, u32 chan, u32 enable)
+{
+	struct cmd_ch_sbs_enable args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_SBS_ENABLE),
+		.chan = chan,
+		.enable = enable,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_crop_set(struct apple_isp *isp, u32 chan, u32 x1, u32 y1, u32 x2,
+			      u32 y2)
+{
+	struct cmd_ch_crop_set args = {
+		.opcode = CISP_OPCODE(isp->hw->scl1 ? CISP_CMD_CH_CROP_SCL1_SET
+				      : CISP_CMD_CH_CROP_SET),
+		.chan = chan,
+		.x1 = x1,
+		.y1 = y1,
+		.x2 = x2,
+		.y2 = y2,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_output_config_set(struct apple_isp *isp, u32 chan, u32 width,
+				 u32 height, u32 strides[3], u32 colorspace, u32 format)
+{
+	struct cmd_ch_output_config_set args = {
+		.opcode = CISP_OPCODE(isp->hw->scl1 ? CISP_CMD_CH_OUTPUT_CONFIG_SCL1_SET
+				      : CISP_CMD_CH_OUTPUT_CONFIG_SET),
+		.chan = chan,
+		.width = width,
+		.height = height,
+		.colorspace = colorspace,
+		.format = format,
+		.padding_rows = 0,
+		.unk_h0 = height,
+		.compress = 0,
+		.unk_w2 = width,
+	};
+	memcpy(args.strides, strides, sizeof(args.strides));
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_preview_stream_set(struct apple_isp *isp, u32 chan, u32 stream)
+{
+	struct cmd_ch_preview_stream_set args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_PREVIEW_STREAM_SET),
+		.chan = chan,
+		.stream = stream,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_als_disable(struct apple_isp *isp, u32 chan)
+{
+	struct cmd_ch_als_disable args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_ALS_DISABLE),
+		.chan = chan,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_cnr_start(struct apple_isp *isp, u32 chan)
+{
+	struct cmd_ch_cnr_start args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_CNR_START),
+		.chan = chan,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_mbnr_enable(struct apple_isp *isp, u32 chan, u32 use_case,
+				 u32 mode, u32 enable_chroma)
+{
+	struct cmd_ch_mbnr_enable args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_MBNR_ENABLE),
+		.chan = chan,
+		.use_case = use_case,
+		.mode = mode,
+		.enable_chroma = enable_chroma,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_sif_pixel_format_set(struct apple_isp *isp, u32 chan)
+{
+	struct cmd_ch_sif_pixel_format_set args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_SIF_PIXEL_FORMAT_SET),
+		.chan = chan,
+		.format = 3,
+		.type = 1,
+		.compress = 0,
+		.unk_10 = 0,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_buffer_recycle_mode_set(struct apple_isp *isp, u32 chan,
+					     u32 mode)
+{
+	struct cmd_ch_buffer_recycle_mode_set args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_BUFFER_RECYCLE_MODE_SET),
+		.chan = chan,
+		.mode = mode,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_buffer_recycle_start(struct apple_isp *isp, u32 chan)
+{
+	struct cmd_ch_buffer_recycle_start args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_BUFFER_RECYCLE_START),
+		.chan = chan,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_buffer_pool_config_set(struct apple_isp *isp, u32 chan, u16 type)
+{
+	struct cmd_ch_buffer_pool_config_set args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_BUFFER_POOL_CONFIG_SET),
+		.chan = chan,
+		.type = type,
+		.count = ISP_MAX_BUFFERS,
+		.meta_size0 = isp->hw->meta_size,
+		.meta_size1 = isp->hw->meta_size,
+		.unk0 = 0,
+		.unk1 = 0,
+		.unk2 = 0,
+		.data_blocks = 1,
+		.compress = 0,
+	};
+	return CISP_SEND_INOUT(isp, args);
+}
+
+int apple_isp_cmd_ch_buffer_pool_return(struct apple_isp *isp, u32 chan)
+{
+	struct cmd_ch_buffer_pool_return args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_BUFFER_POOL_RETURN),
+		.chan = chan,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_apple_ch_temporal_filter_start(struct apple_isp *isp, u32 chan, u32 arg)
+{
+	struct cmd_apple_ch_temporal_filter_start args = {
+		.opcode = CISP_OPCODE(CISP_CMD_APPLE_CH_TEMPORAL_FILTER_START),
+		.chan = chan,
+		.unk_c = 1,
+		.unk_10 = arg,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_apple_ch_temporal_filter_stop(struct apple_isp *isp, u32 chan)
+{
+	struct cmd_apple_ch_temporal_filter_stop args = {
+		.opcode = CISP_OPCODE(CISP_CMD_APPLE_CH_TEMPORAL_FILTER_STOP),
+		.chan = chan,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_apple_ch_motion_history_start(struct apple_isp *isp, u32 chan)
+{
+	struct cmd_apple_ch_motion_history_start args = {
+		.opcode = CISP_OPCODE(CISP_CMD_APPLE_CH_MOTION_HISTORY_START),
+		.chan = chan,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_apple_ch_motion_history_stop(struct apple_isp *isp, u32 chan)
+{
+	struct cmd_apple_ch_motion_history_stop args = {
+		.opcode = CISP_OPCODE(CISP_CMD_APPLE_CH_MOTION_HISTORY_STOP),
+		.chan = chan,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_apple_ch_temporal_filter_enable(struct apple_isp *isp, u32 chan)
+{
+	struct cmd_apple_ch_temporal_filter_enable args = {
+		.opcode = CISP_OPCODE(CISP_CMD_APPLE_CH_TEMPORAL_FILTER_ENABLE),
+		.chan = chan,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_apple_ch_temporal_filter_disable(struct apple_isp *isp, u32 chan)
+{
+	struct cmd_apple_ch_temporal_filter_disable args = {
+		.opcode =
+			CISP_OPCODE(CISP_CMD_APPLE_CH_TEMPORAL_FILTER_DISABLE),
+		.chan = chan,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_ae_stability_set(struct apple_isp *isp, u32 chan, u32 stability)
+{
+	struct cmd_ch_ae_stability_set args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_AE_STABILITY_SET),
+		.chan = chan,
+		.stability = stability,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_ae_stability_to_stable_set(struct apple_isp *isp, u32 chan,
+					  u32 stability)
+{
+	struct cmd_ch_ae_stability_to_stable_set args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_AE_STABILITY_TO_STABLE_SET),
+		.chan = chan,
+		.stability = stability,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_ae_frame_rate_max_get(struct apple_isp *isp, u32 chan,
+					   struct cmd_ch_ae_frame_rate_max_get *args)
+{
+	args->opcode = CISP_OPCODE(CISP_CMD_CH_AE_FRAME_RATE_MAX_GET);
+	args->chan = chan;
+	return CISP_SEND_OUT(isp, args);
+}
+
+int apple_isp_cmd_ch_ae_frame_rate_max_set(struct apple_isp *isp, u32 chan,
+					   u32 framerate)
+{
+	struct cmd_ch_ae_frame_rate_max_set args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_AE_FRAME_RATE_MAX_SET),
+		.chan = chan,
+		.framerate = framerate,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_ae_frame_rate_min_set(struct apple_isp *isp, u32 chan,
+					   u32 framerate)
+{
+	struct cmd_ch_ae_frame_rate_min_set args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_AE_FRAME_RATE_MIN_SET),
+		.chan = chan,
+		.framerate = framerate,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_apple_ch_ae_fd_scene_metering_config_set(struct apple_isp *isp,
+							   u32 chan)
+{
+	struct cmd_apple_ch_ae_fd_scene_metering_config_set args = {
+		.opcode = CISP_OPCODE(
+			CISP_CMD_APPLE_CH_AE_FD_SCENE_METERING_CONFIG_SET),
+		.chan = chan,
+		.unk_c = 0xb8,
+		.unk_10 = 0x2000200,
+		.unk_14 = 0x280800,
+		.unk_18 = 0xe10028,
+		.unk_1c = 0xa0399,
+		.unk_20 = 0x3cc02cc,
+	};
+	return CISP_SEND_INOUT(isp, args);
+}
+
+int apple_isp_cmd_apple_ch_ae_metering_mode_set(struct apple_isp *isp, u32 chan,
+						u32 mode)
+{
+	struct cmd_apple_ch_ae_metering_mode_set args = {
+		.opcode = CISP_OPCODE(CISP_CMD_APPLE_CH_AE_METERING_MODE_SET),
+		.chan = chan,
+		.mode = mode,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_apple_ch_ae_flicker_freq_update_current_set(struct apple_isp *isp,
+							      u32 chan, u32 freq)
+{
+	struct cmd_apple_ch_ae_flicker_freq_update_current_set args = {
+		.opcode = CISP_OPCODE(
+			CISP_CMD_APPLE_CH_AE_FLICKER_FREQ_UPDATE_CURRENT_SET),
+		.chan = chan,
+		.freq = freq,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_semantic_video_enable(struct apple_isp *isp, u32 chan,
+					   u32 enable)
+{
+	struct cmd_ch_semantic_video_enable args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_SEMANTIC_VIDEO_ENABLE),
+		.chan = chan,
+		.enable = enable,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_semantic_awb_enable(struct apple_isp *isp, u32 chan, u32 enable)
+{
+	struct cmd_ch_semantic_awb_enable args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_SEMANTIC_AWB_ENABLE),
+		.chan = chan,
+		.enable = enable,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_lpdp_hs_receiver_tuning_set(struct apple_isp *isp, u32 chan,
+						 u32 unk1, u32 unk2)
+{
+	struct cmd_ch_lpdp_hs_receiver_tuning_set args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_LPDP_HS_RECEIVER_TUNING_SET),
+		.chan = chan,
+		.unk1 = unk1,
+		.unk2 = unk2,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_property_write(struct apple_isp *isp, u32 chan, u32 prop, u32 val)
+{
+	struct cmd_ch_property_write args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_PROPERTY_WRITE),
+		.chan = chan,
+		.prop = prop,
+		.val = val,
+	};
+	return CISP_SEND_IN(isp, args);
+}
+
+int apple_isp_cmd_ch_property_read(struct apple_isp *isp, u32 chan, u32 prop, u32 *val)
+{
+	struct cmd_ch_property_write args = {
+		.opcode = CISP_OPCODE(CISP_CMD_CH_PROPERTY_READ),
+		.chan = chan,
+		.prop = prop,
+		.val = 0xdeadbeef,
+	};
+	int ret = CISP_SEND_OUT(isp, &args);
+
+	*val = args.val;
+
+	return ret;
+}
diff --git a/drivers/media/platform/apple/isp/isp-cmd.h b/drivers/media/platform/apple/isp/isp-cmd.h
new file mode 100644
index 0000000000000000000000000000000000000000..75e7295f783c998dbc7775216cff94beba440b36
--- /dev/null
+++ b/drivers/media/platform/apple/isp/isp-cmd.h
@@ -0,0 +1,692 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2023 Eileen Yoon <eyn@gmx.com> */
+
+#ifndef __ISP_CMD_H__
+#define __ISP_CMD_H__
+
+#include "isp-drv.h"
+
+#define CISP_CMD_START					     0x0000
+#define CISP_CMD_STOP					     0x0001
+#define CISP_CMD_CONFIG_GET				     0x0003
+#define CISP_CMD_PRINT_ENABLE				     0x0004
+#define CISP_CMD_BUILDINFO				     0x0006
+#define CISP_CMD_GET_BES_PARAM				     0x000f
+#define CISP_CMD_POWER_DOWN				     0x0010
+#define CISP_CMD_SET_ISP_PMU_BASE			     0x0011
+#define CISP_CMD_PMP_CTRL_SET				     0x001c
+#define CISP_CMD_TRACE_ENABLE				     0x001d
+#define CISP_CMD_SUSPEND				     0x0021
+#define CISP_CMD_FID_ENTER				     0x0022
+#define CISP_CMD_FID_EXIT				     0x0023
+#define CISP_CMD_FLICKER_SENSOR_SET			     0x0024
+#define CISP_CMD_CH_START				     0x0100
+#define CISP_CMD_CH_STOP				     0x0101
+#define CISP_CMD_CH_BUFFER_RETURN			     0x0104
+#define CISP_CMD_CH_CAMERA_CONFIG_CURRENT_GET		     0x0105
+#define CISP_CMD_CH_CAMERA_CONFIG_GET			     0x0106
+#define CISP_CMD_CH_CAMERA_CONFIG_SELECT		     0x0107
+#define CISP_CMD_CH_INFO_GET				     0x010d
+#define CISP_CMD_CH_BUFFER_RECYCLE_MODE_SET		     0x010e
+#define CISP_CMD_CH_BUFFER_RECYCLE_START		     0x010f
+#define CISP_CMD_CH_BUFFER_RECYCLE_STOP			     0x0110
+#define CISP_CMD_CH_SET_FILE_LOAD			     0x0111
+#define CISP_CMD_CH_SIF_PIXEL_FORMAT_SET		     0x0115
+#define CISP_CMD_CH_BUFFER_POOL_CONFIG_GET		     0x0116
+#define CISP_CMD_CH_BUFFER_POOL_CONFIG_SET		     0x0117
+#define CISP_CMD_CH_CAMERA_MIPI_FREQUENCY_GET		     0x011a
+#define CISP_CMD_CH_CAMERA_PIX_FREQUENCY_GET		     0x011f
+#define CISP_CMD_CH_PROPERTY_WRITE			     0x0122
+#define CISP_CMD_CH_PROPERTY_READ			     0x0123
+#define CISP_CMD_CH_LOCAL_RAW_BUFFER_ENABLE		     0x0125
+#define CISP_CMD_CH_META_DATA_ENABLE			     0x0126
+#define CISP_CMD_CH_CAMERA_MIPI_FREQUENCY_TOTAL_GET	     0x0133
+#define CISP_CMD_CH_SBS_ENABLE				     0x013b
+#define CISP_CMD_CH_LSC_POLYNOMIAL_COEFF_GET		     0x0142
+#define CISP_CMD_CH_SET_META_DATA_REQUIRED		     0x014f
+#define CISP_CMD_CH_BUFFER_POOL_RETURN			     0x015b
+#define CISP_CMD_CH_CAMERA_AGILE_FREQ_ARRAY_CURRENT_GET	     0x015e
+#define CISP_CMD_CH_AE_START				     0x0200
+#define CISP_CMD_CH_AE_STOP				     0x0201
+#define CISP_CMD_CH_AE_FRAME_RATE_MAX_GET		     0x0207
+#define CISP_CMD_CH_AE_FRAME_RATE_MAX_SET		     0x0208
+#define CISP_CMD_CH_AE_FRAME_RATE_MIN_GET		     0x0209
+#define CISP_CMD_CH_AE_FRAME_RATE_MIN_SET		     0x020a
+#define CISP_CMD_CH_AE_STABILITY_SET			     0x021a
+#define CISP_CMD_CH_AE_STABILITY_TO_STABLE_SET		     0x0229
+#define CISP_CMD_CH_SENSOR_NVM_GET			     0x0501
+#define CISP_CMD_CH_SENSOR_PERMODULE_LSC_INFO_GET	     0x0507
+#define CISP_CMD_CH_SENSOR_PERMODULE_LSC_GRID_GET	     0x0511
+#define CISP_CMD_CH_LPDP_HS_RECEIVER_TUNING_SET		     0x051b
+#define CISP_CMD_CH_FOCUS_LIMITS_GET			     0x0701
+#define CISP_CMD_CH_CROP_GET				     0x0800
+#define CISP_CMD_CH_CROP_SET				     0x0801
+#define CISP_CMD_CH_SCALER_CROP_SET			     0x080a
+#define CISP_CMD_CH_CROP_SCL1_GET			     0x080b
+#define CISP_CMD_CH_CROP_SCL1_SET			     0x080c
+#define CISP_CMD_CH_SCALER_CROP_SCL1_SET		     0x080d
+#define CISP_CMD_CH_ALS_ENABLE				     0x0a1c
+#define CISP_CMD_CH_ALS_DISABLE				     0x0a1d
+#define CISP_CMD_CH_CNR_START				     0x0a2f
+#define CISP_CMD_CH_MBNR_ENABLE				     0x0a3a
+#define CISP_CMD_CH_OUTPUT_CONFIG_SET			     0x0b01
+#define CISP_CMD_CH_OUTPUT_CONFIG_SCL1_SET		     0x0b09
+#define CISP_CMD_CH_PREVIEW_STREAM_SET			     0x0b0d
+#define CISP_CMD_CH_SEMANTIC_VIDEO_ENABLE		     0x0b17
+#define CISP_CMD_CH_SEMANTIC_AWB_ENABLE			     0x0b18
+#define CISP_CMD_CH_FACE_DETECTION_START		     0x0d00
+#define CISP_CMD_CH_FACE_DETECTION_STOP			     0x0d01
+#define CISP_CMD_CH_FACE_DETECTION_CONFIG_GET		     0x0d02
+#define CISP_CMD_CH_FACE_DETECTION_CONFIG_SET		     0x0d03
+#define CISP_CMD_CH_FACE_DETECTION_DISABLE		     0x0d04
+#define CISP_CMD_CH_FACE_DETECTION_ENABLE		     0x0d05
+#define CISP_CMD_CH_FID_START				     0x3000
+#define CISP_CMD_CH_FID_STOP				     0x3001
+#define CISP_CMD_IPC_ENDPOINT_SET2			     0x300c
+#define CISP_CMD_IPC_ENDPOINT_UNSET2			     0x300d
+#define CISP_CMD_SET_DSID_CLR_REG_BASE2			     0x3204
+#define CISP_CMD_SET_DSID_CLR_REG_BASE			     0x3205
+#define CISP_CMD_APPLE_CH_AE_METERING_MODE_SET		     0x8206
+#define CISP_CMD_APPLE_CH_AE_FD_SCENE_METERING_CONFIG_SET    0x820e
+#define CISP_CMD_APPLE_CH_AE_FLICKER_FREQ_UPDATE_CURRENT_SET 0x8212
+#define CISP_CMD_APPLE_CH_TEMPORAL_FILTER_START		     0xc100
+#define CISP_CMD_APPLE_CH_TEMPORAL_FILTER_STOP		     0xc101
+#define CISP_CMD_APPLE_CH_MOTION_HISTORY_START		     0xc102
+#define CISP_CMD_APPLE_CH_MOTION_HISTORY_STOP		     0xc103
+#define CISP_CMD_APPLE_CH_TEMPORAL_FILTER_ENABLE	     0xc113
+#define CISP_CMD_APPLE_CH_TEMPORAL_FILTER_DISABLE	     0xc114
+
+#define CISP_POOL_TYPE_META				     0x0
+#define CISP_POOL_TYPE_RENDERED				     0x1
+#define CISP_POOL_TYPE_FD				     0x2
+#define CISP_POOL_TYPE_RAW				     0x3
+#define CISP_POOL_TYPE_STAT				     0x4
+#define CISP_POOL_TYPE_RAW_AUX				     0x5
+#define CISP_POOL_TYPE_YCC				     0x6
+#define CISP_POOL_TYPE_CAPTURE_FULL_RES			     0x7
+#define CISP_POOL_TYPE_META_CAPTURE			     0x8
+#define CISP_POOL_TYPE_RENDERED_SCL1			     0x9
+#define CISP_POOL_TYPE_STAT_PIXELOUTPUT			     0x11
+#define CISP_POOL_TYPE_FSCL				     0x12
+#define CISP_POOL_TYPE_CAPTURE_FULL_RES_YCC		     0x13
+#define CISP_POOL_TYPE_RENDERED_RAW			     0x14
+#define CISP_POOL_TYPE_CAPTURE_PDC_RAW			     0x16
+#define CISP_POOL_TYPE_FPC_DATA				     0x17
+#define CISP_POOL_TYPE_AICAM_SEG			     0x19
+#define CISP_POOL_TYPE_SPD				     0x1a
+#define CISP_POOL_TYPE_META_DEPTH			     0x1c
+#define CISP_POOL_TYPE_JASPER_DEPTH			     0x1d
+#define CISP_POOL_TYPE_RAW_SIFR				     0x1f
+#define CISP_POOL_TYPE_FEP_THUMBNAIL_DYNAMIC_POOL_RAW	     0x21
+
+#define CISP_COLORSPACE_REC709				     0x1
+#define CISP_OUTPUT_FORMAT_YUV_2PLANE			     0x0
+#define CISP_OUTPUT_FORMAT_YUV_1PLANE			     0x1
+#define CISP_OUTPUT_FORMAT_RGB				     0x2
+#define CISP_BUFFER_RECYCLE_MODE_EMPTY_ONLY		     0x1
+
+struct cmd_start {
+	u64 opcode;
+	u32 mode;
+} __packed;
+static_assert(sizeof(struct cmd_start) == 0xc);
+
+struct cmd_stop {
+	u64 opcode;
+	u32 mode;
+} __packed;
+static_assert(sizeof(struct cmd_stop) == 0xc);
+
+struct cmd_power_down {
+	u64 opcode;
+} __packed;
+static_assert(sizeof(struct cmd_power_down) == 0x8);
+
+struct cmd_suspend {
+	u64 opcode;
+} __packed;
+static_assert(sizeof(struct cmd_suspend) == 0x8);
+
+struct cmd_print_enable {
+	u64 opcode;
+	u32 enable;
+} __packed;
+static_assert(sizeof(struct cmd_print_enable) == 0xc);
+
+struct cmd_trace_enable {
+	u64 opcode;
+	u32 enable;
+} __packed;
+static_assert(sizeof(struct cmd_trace_enable) == 0xc);
+
+struct cmd_config_get {
+	u64 opcode;
+	u32 timestamp_freq;
+	u32 num_channels;
+	u32 unk_10;
+	u32 unk_14;
+	u32 unk_18;
+} __packed;
+static_assert(sizeof(struct cmd_config_get) == 0x1c);
+
+struct cmd_set_isp_pmu_base {
+	u64 opcode;
+	u64 pmu_base;
+} __packed;
+static_assert(sizeof(struct cmd_set_isp_pmu_base) == 0x10);
+
+struct cmd_set_dsid_clr_req_base2 {
+	u64 opcode;
+	u64 dsid_clr_base0;
+	u64 dsid_clr_base1;
+	u64 dsid_clr_base2;
+	u64 dsid_clr_base3;
+	u32 dsid_clr_range0;
+	u32 dsid_clr_range1;
+	u32 dsid_clr_range2;
+	u32 dsid_clr_range3;
+} __packed;
+static_assert(sizeof(struct cmd_set_dsid_clr_req_base2) == 0x38);
+
+struct cmd_set_dsid_clr_req_base {
+	u64 opcode;
+	u64 dsid_clr_base;
+	u32 dsid_clr_range;
+} __packed;
+static_assert(sizeof(struct cmd_set_dsid_clr_req_base) == 0x14);
+
+struct cmd_pmp_ctrl_set {
+	u64 opcode;
+	u64 clock_scratch;
+	u64 clock_base;
+	u8 clock_bit;
+	u8 clock_size;
+	u16 clock_pad;
+	u64 bandwidth_scratch;
+	u64 bandwidth_base;
+	u8 bandwidth_bit;
+	u8 bandwidth_size;
+	u16 bandwidth_pad;
+} __packed;
+static_assert(sizeof(struct cmd_pmp_ctrl_set) == 0x30);
+
+struct cmd_fid_enter {
+	u64 opcode;
+} __packed;
+static_assert(sizeof(struct cmd_fid_enter) == 0x8);
+
+struct cmd_fid_exit {
+	u64 opcode;
+} __packed;
+static_assert(sizeof(struct cmd_fid_exit) == 0x8);
+
+struct cmd_ipc_endpoint_set2 {
+	u64 opcode;
+	u32 unk;
+	u64 addr1;
+	u32 size1;
+	u64 addr2;
+	u32 size2;
+	u64 regs;
+	u32 unk2;
+} __packed;
+static_assert(sizeof(struct cmd_ipc_endpoint_set2) == 0x30);
+
+struct cmd_flicker_sensor_set {
+	u64 opcode;
+	u32 mode;
+} __packed;
+static_assert(sizeof(struct cmd_flicker_sensor_set) == 0xc);
+
+int apple_isp_cmd_start(struct apple_isp *isp, u32 mode);
+int apple_isp_cmd_stop(struct apple_isp *isp, u32 mode);
+int apple_isp_cmd_power_down(struct apple_isp *isp);
+int apple_isp_cmd_suspend(struct apple_isp *isp);
+int apple_isp_cmd_print_enable(struct apple_isp *isp, u32 enable);
+int apple_isp_cmd_trace_enable(struct apple_isp *isp, u32 enable);
+int apple_isp_cmd_config_get(struct apple_isp *isp, struct cmd_config_get *args);
+int apple_isp_cmd_set_isp_pmu_base(struct apple_isp *isp, u64 pmu_base);
+int apple_isp_cmd_set_dsid_clr_req_base(struct apple_isp *isp, u64 dsid_clr_base,
+					u32 dsid_clr_range);
+int apple_isp_cmd_set_dsid_clr_req_base2(struct apple_isp *isp, u64 dsid_clr_base0,
+					 u64 dsid_clr_base1, u64 dsid_clr_base2,
+					 u64 dsid_clr_base3, u32 dsid_clr_range0,
+					 u32 dsid_clr_range1, u32 dsid_clr_range2,
+					 u32 dsid_clr_range3);
+int apple_isp_cmd_pmp_ctrl_set(struct apple_isp *isp, u64 clock_scratch,
+			       u64 clock_base, u8 clock_bit, u8 clock_size,
+			       u64 bandwidth_scratch, u64 bandwidth_base,
+			       u8 bandwidth_bit, u8 bandwidth_size);
+int apple_isp_cmd_fid_enter(struct apple_isp *isp);
+int apple_isp_cmd_fid_exit(struct apple_isp *isp);
+int apple_isp_cmd_flicker_sensor_set(struct apple_isp *isp, u32 mode);
+
+struct cmd_ch_start {
+	u64 opcode;
+	u32 chan;
+} __packed;
+static_assert(sizeof(struct cmd_ch_start) == 0xc);
+
+struct cmd_ch_stop {
+	u64 opcode;
+	u32 chan;
+} __packed;
+static_assert(sizeof(struct cmd_ch_stop) == 0xc);
+
+struct cmd_ch_info {
+	u64 opcode;
+	u32 chan;
+	u32 unk_c;  /* 0x7da0001, 0x7db0001 */
+	u32 unk_10; /* 0x300ac, 0x5006d */
+	u32 unk_14; /* 0x40007, 0x10007 */
+	u32 unk_18; /* 0x5, 0x2 */
+	u32 unk_1c; /* 0x1, 0x1 */
+	u32 version;
+	u32 unk_24; /* 0x7, 0x9 */
+	u32 unk_28; /* 0x1, 0x1410 */
+	u32 unk_2c; /* 0x7, 0x2 */
+	u32 pad_30[7];
+	u32 unk_4c; /* 0x10000, 0x50000 */
+	u32 unk_50; /* 0x1, 0x1 */
+	u32 unk_54; /* 0x0, 0x0 */
+	u32 unk_58; /* 0x4, 0x4 */
+	u32 unk_5c; /* 0x10, 0x20 */
+	u32 num_presets;
+	u32 unk_64; /* 0x0, 0x0 */
+	u32 unk_68; /* 0x44c0, 0x4680 */
+	u32 unk_6c; /* 0x40, 0x40 */
+	u32 unk_70; /* 0x1, 0x1 */
+	u32 unk_74; /* 0x2, 0x2 */
+	u32 unk_78; /* 0x4000, 0x4000 */
+	u32 unk_7c; /* 0x40, 0x40 */
+	u32 unk_80; /* 0x1, 0x1 */
+	u32 pad_84[2];
+	u32 unk_8c; /* 0x36, 0x36 */
+	u32 pad_90[2];
+	u32 timestamp_freq;
+	u16 pad_9c;
+	char module_sn[20];
+	u16 pad_b0;
+	u32 unk_b4; /* 0x8, 0x8 */
+	u32 pad_b8[2];
+	u32 unk_c0; /* 0x4, 0x1 */
+	u32 unk_c4; /* 0x0, 0x0 */
+	u32 unk_c8; /* 0x0, 0x100 */
+	u32 pad_cc[4];
+	u32 unk_dc; /* 0xff0000, 0xff0000 */
+	u32 unk_e0; /* 0xc00, 0xc00 */
+	u32 unk_e4; /* 0x0, 0x0 */
+	u32 unk_e8; /* 0x1c, 0x1c */
+	u32 unk_ec; /* 0x640, 0x680 */
+	u32 unk_f0; /* 0x4, 0x4 */
+	u32 unk_f4; /* 0x4, 0x4 */
+	u32 pad_f8[6];
+	u32 unk_110; /* 0x0, 0x7800000 */
+	u32 unk_114; /* 0x0, 0x780 */
+} __packed;
+static_assert(sizeof(struct cmd_ch_info) == 0x118);
+
+struct cmd_ch_camera_config {
+	u64 opcode;
+	u32 chan;
+	u32 preset;
+	u16 in_width;
+	u16 in_height;
+	u16 out_width;
+	u16 out_height;
+	u32 unk_28;
+	u32 unk_2c;
+	u32 unk_30[16];
+	u32 sensor_clk;
+	u32 unk_64[4];
+	u32 timestamp_freq;
+	u32 unk_78[2];
+	u32 unk_80[16];
+	u32 in_width2; /* repeated in u32?? */
+	u32 in_height2;
+	u32 unk_c8[3];
+	u32 out_width2;
+	u32 out_height2;
+} __packed;
+static_assert(sizeof(struct cmd_ch_camera_config) == 0xdc);
+
+struct cmd_ch_camera_config_select {
+	u64 opcode;
+	u32 chan;
+	u32 preset;
+} __packed;
+static_assert(sizeof(struct cmd_ch_camera_config_select) == 0x10);
+
+struct cmd_ch_set_file_load {
+	u64 opcode;
+	u32 chan;
+	u32 addr;
+	u32 size;
+} __packed;
+static_assert(sizeof(struct cmd_ch_set_file_load) == 0x14);
+
+struct cmd_ch_set_file_load64 {
+	u64 opcode;
+	u32 chan;
+	u64 addr;
+	u32 size;
+} __packed;
+static_assert(sizeof(struct cmd_ch_set_file_load64) == 0x18);
+
+struct cmd_ch_buffer_return {
+	u64 opcode;
+	u32 chan;
+} __packed;
+static_assert(sizeof(struct cmd_ch_buffer_return) == 0xc);
+
+struct cmd_ch_sbs_enable {
+	u64 opcode;
+	u32 chan;
+	u32 enable;
+} __packed;
+static_assert(sizeof(struct cmd_ch_sbs_enable) == 0x10);
+
+struct cmd_ch_crop_set {
+	u64 opcode;
+	u32 chan;
+	u32 x1;
+	u32 y1;
+	u32 x2;
+	u32 y2;
+} __packed;
+static_assert(sizeof(struct cmd_ch_crop_set) == 0x1c);
+
+struct cmd_ch_output_config_set {
+	u64 opcode;
+	u32 chan;
+	u32 width;
+	u32 height;
+	u32 colorspace;
+	u32 format;
+	u32 strides[3];
+	u32 padding_rows;
+	u32 unk_h0;
+	u32 compress;
+	u32 unk_w2;
+} __packed;
+static_assert(sizeof(struct cmd_ch_output_config_set) == 0x38);
+
+struct cmd_ch_preview_stream_set {
+	u64 opcode;
+	u32 chan;
+	u32 stream;
+} __packed;
+static_assert(sizeof(struct cmd_ch_preview_stream_set) == 0x10);
+
+struct cmd_ch_als_disable {
+	u64 opcode;
+	u32 chan;
+} __packed;
+static_assert(sizeof(struct cmd_ch_als_disable) == 0xc);
+
+struct cmd_ch_cnr_start {
+	u64 opcode;
+	u32 chan;
+} __packed;
+static_assert(sizeof(struct cmd_ch_cnr_start) == 0xc);
+
+struct cmd_ch_mbnr_enable {
+	u64 opcode;
+	u32 chan;
+	u32 use_case;
+	u32 mode;
+	u32 enable_chroma;
+} __packed;
+static_assert(sizeof(struct cmd_ch_mbnr_enable) == 0x18);
+
+struct cmd_ch_sif_pixel_format_set {
+	u64 opcode;
+	u32 chan;
+	u8 format;
+	u8 type;
+	u16 compress;
+	u32 unk_10;
+} __packed;
+static_assert(sizeof(struct cmd_ch_sif_pixel_format_set) == 0x14);
+
+struct cmd_ch_lpdp_hs_receiver_tuning_set {
+	u64 opcode;
+	u32 chan;
+	u32 unk1;
+	u32 unk2;
+} __packed;
+static_assert(sizeof(struct cmd_ch_lpdp_hs_receiver_tuning_set) == 0x14);
+
+struct cmd_ch_property_write {
+	u64 opcode;
+	u32 chan;
+	u32 prop;
+	u32 val;
+	u32 unk1;
+	u32 unk2;
+} __packed;
+static_assert(sizeof(struct cmd_ch_property_write) == 0x1c);
+
+int apple_isp_cmd_ch_start(struct apple_isp *isp, u32 chan);
+int apple_isp_cmd_ch_stop(struct apple_isp *isp, u32 chan);
+int apple_isp_cmd_ch_info_get(struct apple_isp *isp, u32 chan,
+			      struct cmd_ch_info *args);
+int apple_isp_cmd_ch_camera_config_get(struct apple_isp *isp, u32 chan, u32 preset,
+				       struct cmd_ch_camera_config *args);
+int apple_isp_cmd_ch_camera_config_current_get(struct apple_isp *isp, u32 chan,
+					       struct cmd_ch_camera_config *args);
+int apple_isp_cmd_ch_camera_config_select(struct apple_isp *isp, u32 chan,
+					  u32 preset);
+int apple_isp_cmd_ch_set_file_load(struct apple_isp *isp, u32 chan, u64 addr,
+				   u32 size);
+int apple_isp_cmd_ch_buffer_return(struct apple_isp *isp, u32 chan);
+int apple_isp_cmd_ch_sbs_enable(struct apple_isp *isp, u32 chan, u32 enable);
+int apple_isp_cmd_ch_crop_set(struct apple_isp *isp, u32 chan, u32 x1, u32 y1, u32 x2,
+			      u32 y2);
+int apple_isp_cmd_ch_output_config_set(struct apple_isp *isp, u32 chan, u32 width,
+				       u32 height, u32 strides[3], u32 colorspace, u32 format);
+int apple_isp_cmd_ch_preview_stream_set(struct apple_isp *isp, u32 chan, u32 stream);
+int apple_isp_cmd_ch_als_disable(struct apple_isp *isp, u32 chan);
+int apple_isp_cmd_ch_cnr_start(struct apple_isp *isp, u32 chan);
+int apple_isp_cmd_ch_mbnr_enable(struct apple_isp *isp, u32 chan, u32 use_case,
+				 u32 mode, u32 enable_chroma);
+int apple_isp_cmd_ch_sif_pixel_format_set(struct apple_isp *isp, u32 chan);
+int apple_isp_cmd_ch_lpdp_hs_receiver_tuning_set(struct apple_isp *isp, u32 chan,
+						 u32 unk1, u32 unk2);
+
+int apple_isp_cmd_ch_property_read(struct apple_isp *isp, u32 chan, u32 prop, u32 *val);
+int apple_isp_cmd_ch_property_write(struct apple_isp *isp, u32 chan, u32 prop, u32 val);
+
+enum isp_mbnr_mode {
+	ISP_MBNR_MODE_DISABLE = 0,
+	ISP_MBNR_MODE_ENABLE = 1,
+	ISP_MBNR_MODE_BYPASS = 2,
+};
+
+struct cmd_ch_buffer_recycle_mode_set {
+	u64 opcode;
+	u32 chan;
+	u32 mode;
+} __packed;
+static_assert(sizeof(struct cmd_ch_buffer_recycle_mode_set) == 0x10);
+
+struct cmd_ch_buffer_recycle_start {
+	u64 opcode;
+	u32 chan;
+} __packed;
+static_assert(sizeof(struct cmd_ch_buffer_recycle_start) == 0xc);
+
+struct cmd_ch_buffer_pool_config_set {
+	u64 opcode;
+	u32 chan;
+	u16 type;
+	u16 count;
+	u32 meta_size0;
+	u32 meta_size1;
+	u64 unk0;
+	u64 unk1;
+	u64 unk2;
+	u32 zero[0x19];
+	u32 data_blocks;
+	u32 compress;
+} __packed;
+static_assert(sizeof(struct cmd_ch_buffer_pool_config_set) == 0x9c);
+
+struct cmd_ch_buffer_pool_return {
+	u64 opcode;
+	u32 chan;
+} __packed;
+static_assert(sizeof(struct cmd_ch_buffer_pool_return) == 0xc);
+
+int apple_isp_cmd_ch_buffer_recycle_mode_set(struct apple_isp *isp, u32 chan,
+					     u32 mode);
+int apple_isp_cmd_ch_buffer_recycle_start(struct apple_isp *isp, u32 chan);
+int apple_isp_cmd_ch_buffer_pool_config_set(struct apple_isp *isp, u32 chan,
+					    u16 type);
+int apple_isp_cmd_ch_buffer_pool_config_get(struct apple_isp *isp, u32 chan,
+					    u16 type);
+int apple_isp_cmd_ch_buffer_pool_return(struct apple_isp *isp, u32 chan);
+
+struct cmd_apple_ch_temporal_filter_start {
+	u64 opcode;
+	u32 chan;
+	u32 unk_c;
+	u32 unk_10;
+} __packed;
+static_assert(sizeof(struct cmd_apple_ch_temporal_filter_start) == 0x14);
+
+struct cmd_apple_ch_temporal_filter_stop {
+	u64 opcode;
+	u32 chan;
+} __packed;
+static_assert(sizeof(struct cmd_apple_ch_temporal_filter_stop) == 0xc);
+
+struct cmd_apple_ch_motion_history_start {
+	u64 opcode;
+	u32 chan;
+} __packed;
+static_assert(sizeof(struct cmd_apple_ch_motion_history_start) == 0xc);
+
+struct cmd_apple_ch_motion_history_stop {
+	u64 opcode;
+	u32 chan;
+} __packed;
+static_assert(sizeof(struct cmd_apple_ch_motion_history_stop) == 0xc);
+
+struct cmd_apple_ch_temporal_filter_enable {
+	u64 opcode;
+	u32 chan;
+} __packed;
+static_assert(sizeof(struct cmd_apple_ch_temporal_filter_enable) == 0xc);
+
+struct cmd_apple_ch_temporal_filter_disable {
+	u64 opcode;
+	u32 chan;
+} __packed;
+static_assert(sizeof(struct cmd_apple_ch_temporal_filter_disable) == 0xc);
+
+int apple_isp_cmd_apple_ch_temporal_filter_start(struct apple_isp *isp, u32 chan, u32 arg);
+int apple_isp_cmd_apple_ch_temporal_filter_stop(struct apple_isp *isp, u32 chan);
+int apple_isp_cmd_apple_ch_motion_history_start(struct apple_isp *isp, u32 chan);
+int apple_isp_cmd_apple_ch_motion_history_stop(struct apple_isp *isp, u32 chan);
+int apple_isp_cmd_apple_ch_temporal_filter_enable(struct apple_isp *isp, u32 chan);
+int apple_isp_cmd_apple_ch_temporal_filter_disable(struct apple_isp *isp, u32 chan);
+
+struct cmd_ch_ae_stability_set {
+	u64 opcode;
+	u32 chan;
+	u32 stability;
+} __packed;
+static_assert(sizeof(struct cmd_ch_ae_stability_set) == 0x10);
+
+struct cmd_ch_ae_stability_to_stable_set {
+	u64 opcode;
+	u32 chan;
+	u32 stability;
+} __packed;
+static_assert(sizeof(struct cmd_ch_ae_stability_to_stable_set) == 0x10);
+
+struct cmd_ch_ae_frame_rate_max_get {
+	u64 opcode;
+	u32 chan;
+	u32 framerate;
+} __packed;
+static_assert(sizeof(struct cmd_ch_ae_frame_rate_max_get) == 0x10);
+
+struct cmd_ch_ae_frame_rate_max_set {
+	u64 opcode;
+	u32 chan;
+	u32 framerate;
+} __packed;
+static_assert(sizeof(struct cmd_ch_ae_frame_rate_max_set) == 0x10);
+
+struct cmd_ch_ae_frame_rate_min_set {
+	u64 opcode;
+	u32 chan;
+	u32 framerate;
+} __packed;
+static_assert(sizeof(struct cmd_ch_ae_frame_rate_min_set) == 0x10);
+
+struct cmd_apple_ch_ae_fd_scene_metering_config_set {
+	u64 opcode;
+	u32 chan;
+	u32 unk_c;
+	u32 unk_10;
+	u32 unk_14;
+	u32 unk_18;
+	u32 unk_1c;
+	u32 unk_20;
+} __packed;
+static_assert(sizeof(struct cmd_apple_ch_ae_fd_scene_metering_config_set) ==
+	      0x24);
+
+struct cmd_apple_ch_ae_metering_mode_set {
+	u64 opcode;
+	u32 chan;
+	u32 mode;
+} __packed;
+static_assert(sizeof(struct cmd_apple_ch_ae_metering_mode_set) == 0x10);
+
+struct cmd_apple_ch_ae_flicker_freq_update_current_set {
+	u64 opcode;
+	u32 chan;
+	u32 freq;
+} __packed;
+static_assert(sizeof(struct cmd_apple_ch_ae_flicker_freq_update_current_set) ==
+	      0x10);
+
+int apple_isp_cmd_ch_ae_stability_set(struct apple_isp *isp, u32 chan, u32 stability);
+int apple_isp_cmd_ch_ae_stability_to_stable_set(struct apple_isp *isp, u32 chan,
+						u32 stability);
+int apple_isp_cmd_ch_ae_frame_rate_max_get(struct apple_isp *isp, u32 chan,
+					   struct cmd_ch_ae_frame_rate_max_get *args);
+int apple_isp_cmd_ch_ae_frame_rate_max_set(struct apple_isp *isp, u32 chan,
+					   u32 framerate);
+int apple_isp_cmd_ch_ae_frame_rate_min_set(struct apple_isp *isp, u32 chan,
+					   u32 framerate);
+int apple_isp_cmd_apple_ch_ae_fd_scene_metering_config_set(struct apple_isp *isp,
+							   u32 chan);
+int apple_isp_cmd_apple_ch_ae_metering_mode_set(struct apple_isp *isp, u32 chan,
+						u32 mode);
+int apple_isp_cmd_apple_ch_ae_flicker_freq_update_current_set(struct apple_isp *isp,
+							      u32 chan, u32 freq);
+
+struct cmd_ch_semantic_video_enable {
+	u64 opcode;
+	u32 chan;
+	u32 enable;
+} __packed;
+static_assert(sizeof(struct cmd_ch_semantic_video_enable) == 0x10);
+
+struct cmd_ch_semantic_awb_enable {
+	u64 opcode;
+	u32 chan;
+	u32 enable;
+} __packed;
+static_assert(sizeof(struct cmd_ch_semantic_awb_enable) == 0x10);
+
+int apple_isp_cmd_ch_semantic_video_enable(struct apple_isp *isp, u32 chan,
+				     u32 enable);
+int apple_isp_cmd_ch_semantic_awb_enable(struct apple_isp *isp, u32 chan, u32 enable);
+
+#endif /* __ISP_CMD_H__ */
diff --git a/drivers/media/platform/apple/isp/isp-drv.c b/drivers/media/platform/apple/isp/isp-drv.c
new file mode 100644
index 0000000000000000000000000000000000000000..b0c73b4f43d73f4ee29093fe62ed1d39ccfa33dd
--- /dev/null
+++ b/drivers/media/platform/apple/isp/isp-drv.c
@@ -0,0 +1,586 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Apple Image Signal Processor driver
+ *
+ * Copyright (C) 2023 The Asahi Linux Contributors
+ */
+
+#include <linux/iommu.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/workqueue.h>
+
+#include "isp-cam.h"
+#include "isp-fw.h"
+#include "isp-iommu.h"
+#include "isp-v4l2.h"
+
+static void apple_isp_detach_genpd(struct apple_isp *isp)
+{
+	if (isp->pd_count <= 1)
+		return;
+
+	for (int i = isp->pd_count - 1; i >= 0; i--) {
+		if (isp->pd_link[i])
+			device_link_del(isp->pd_link[i]);
+		if (!IS_ERR_OR_NULL(isp->pd_dev[i]))
+			dev_pm_domain_detach(isp->pd_dev[i], true);
+	}
+}
+
+static int apple_isp_attach_genpd(struct apple_isp *isp)
+{
+	struct device *dev = isp->dev;
+
+	isp->pd_count = of_count_phandle_with_args(
+		dev->of_node, "power-domains", "#power-domain-cells");
+	if (isp->pd_count <= 1)
+		return 0;
+
+	isp->pd_dev = devm_kcalloc(dev, isp->pd_count, sizeof(*isp->pd_dev),
+				   GFP_KERNEL);
+	if (!isp->pd_dev)
+		return -ENOMEM;
+
+	isp->pd_link = devm_kcalloc(dev, isp->pd_count, sizeof(*isp->pd_link),
+				    GFP_KERNEL);
+	if (!isp->pd_link)
+		return -ENOMEM;
+
+	for (int i = 0; i < isp->pd_count; i++) {
+		int flags = DL_FLAG_STATELESS;
+
+		/* Primary power domain uses RPM integration */
+		if (i == 0)
+			flags |= DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE;
+
+		isp->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
+		if (IS_ERR(isp->pd_dev[i])) {
+			apple_isp_detach_genpd(isp);
+			return PTR_ERR(isp->pd_dev[i]);
+		}
+
+		isp->pd_link[i] =
+			device_link_add(dev, isp->pd_dev[i], flags);
+
+		if (!isp->pd_link[i]) {
+			apple_isp_detach_genpd(isp);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int apple_isp_init_iommu(struct apple_isp *isp)
+{
+	struct device *dev = isp->dev;
+	phys_addr_t heap_base;
+	size_t heap_size;
+	u64 vm_size;
+	int err;
+	int size;
+	struct device_node *mem_node;
+	const __be32 *maps, *end;
+
+	isp->domain = iommu_get_domain_for_dev(isp->dev);
+	if (!isp->domain)
+		return -ENODEV;
+	isp->shift = __ffs(isp->domain->pgsize_bitmap);
+
+	mem_node = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (!mem_node) {
+		dev_err(dev, "No memory-region found for heap\n");
+		return -ENODEV;
+	}
+
+	maps = of_get_property(mem_node, "iommu-addresses", &size);
+	if (!maps || !size) {
+		dev_err(dev, "No valid iommu-addresses found for heap\n");
+		return -ENODEV;
+	}
+
+	end = maps + size / sizeof(__be32);
+
+	while (maps < end) {
+		maps++;
+		maps = of_translate_dma_region(dev->of_node, maps, &heap_base,
+					       &heap_size);
+	}
+
+	isp->fw.heap_top = heap_base + heap_size;
+
+	err = of_property_read_u64(dev->of_node, "apple,dart-vm-size",
+				   &vm_size);
+	if (err) {
+		dev_err(dev, "failed to read 'apple,dart-vm-size': %d\n", err);
+		return err;
+	}
+
+	drm_mm_init(&isp->iovad, isp->fw.heap_top,
+		    vm_size - (heap_base & 0xffffffff));
+
+	return 0;
+}
+
+static void apple_isp_free_iommu(struct apple_isp *isp)
+{
+	drm_mm_takedown(&isp->iovad);
+}
+
+static int isp_of_read_coord(struct device *dev, struct device_node *np,
+			     const char *prop, struct coord *val)
+{
+	u32 xy[2];
+	int ret;
+
+	ret = of_property_read_u32_array(np, prop, xy, 2);
+	if (ret) {
+		dev_err(dev, "failed to read '%s' property\n", prop);
+		return ret;
+	}
+
+	val->x = xy[0];
+	val->y = xy[1];
+	return 0;
+}
+
+static int apple_isp_init_presets(struct apple_isp *isp)
+{
+	struct device *dev = isp->dev;
+	struct isp_preset *preset;
+	int err = 0;
+
+	struct device_node *np __free(device_node) =
+		of_get_child_by_name(dev->of_node, "sensor-presets");
+	if (!np) {
+		dev_err(dev, "failed to get DT node 'presets'\n");
+		return -EINVAL;
+	}
+
+	isp->num_presets = of_get_child_count(np);
+	if (!isp->num_presets) {
+		dev_err(dev, "no sensor presets found\n");
+		return -EINVAL;
+	}
+
+	isp->presets = devm_kzalloc(
+		dev, sizeof(*isp->presets) * isp->num_presets, GFP_KERNEL);
+	if (!isp->presets)
+		return -ENOMEM;
+
+	preset = isp->presets;
+	for_each_child_of_node_scoped(np, child) {
+		u32 xywh[4];
+
+		err = of_property_read_u32(child, "apple,config-index",
+					   &preset->index);
+		if (err) {
+			dev_err(dev, "no apple,config-index property\n");
+			return err;
+		}
+
+		err = isp_of_read_coord(dev, child, "apple,input-size",
+					&preset->input_dim);
+		if (err)
+			return err;
+		err = isp_of_read_coord(dev, child, "apple,output-size",
+					&preset->output_dim);
+		if (err)
+			return err;
+
+		err = of_property_read_u32_array(child, "apple,crop", xywh, 4);
+		if (err) {
+			dev_err(dev, "failed to read 'apple,crop' property\n");
+			return err;
+		}
+		preset->crop_offset.x = xywh[0];
+		preset->crop_offset.y = xywh[1];
+		preset->crop_size.x = xywh[2];
+		preset->crop_size.y = xywh[3];
+
+		preset++;
+	}
+
+	return 0;
+}
+
+static const char *isp_fw2str(enum isp_firmware_version version)
+{
+	switch (version) {
+	case ISP_FIRMWARE_V_12_3:
+		return "12.3";
+	case ISP_FIRMWARE_V_12_4:
+		return "12.4";
+	case ISP_FIRMWARE_V_13_5:
+		return "13.5";
+	default:
+		return "unknown";
+	}
+}
+
+#define ISP_FW_VERSION_MIN_LEN	3
+#define ISP_FW_VERSION_MAX_LEN	5
+
+static enum isp_firmware_version isp_read_fw_version(struct device *dev,
+						     const char *name)
+{
+	u32 ver[ISP_FW_VERSION_MAX_LEN];
+	int len = of_property_read_variable_u32_array(dev->of_node, name, ver,
+						      ISP_FW_VERSION_MIN_LEN,
+						      ISP_FW_VERSION_MAX_LEN);
+
+	switch (len) {
+	case 3:
+		if (ver[0] == 12 && ver[1] == 3 && ver[2] <= 1)
+			return ISP_FIRMWARE_V_12_3;
+		else if (ver[0] == 12 && ver[1] == 4 && ver[2] == 0)
+			return ISP_FIRMWARE_V_12_4;
+		else if (ver[0] == 13 && ver[1] == 5 && ver[2] == 0)
+			return ISP_FIRMWARE_V_13_5;
+
+		dev_warn(dev, "unknown %s: %d.%d.%d\n", name, ver[0], ver[1], ver[2]);
+		break;
+	case 4:
+		dev_warn(dev, "unknown %s: %d.%d.%d.%d\n", name, ver[0], ver[1],
+			 ver[2], ver[3]);
+		break;
+	case 5:
+		dev_warn(dev, "unknown %s: %d.%d.%d.%d.%d\n", name, ver[0],
+			 ver[1], ver[2], ver[3], ver[4]);
+		break;
+	default:
+		dev_warn(dev, "could not parse %s: %d\n", name, len);
+		break;
+	}
+
+	return ISP_FIRMWARE_V_UNKNOWN;
+}
+
+static enum isp_firmware_version isp_check_firmware_version(struct device *dev)
+{
+	enum isp_firmware_version version, compat;
+
+	/* firmware version is just informative */
+	version = isp_read_fw_version(dev, "apple,firmware-version");
+	compat = isp_read_fw_version(dev, "apple,firmware-compat");
+
+	dev_info(dev, "ISP firmware-compat: %s (FW: %s)\n", isp_fw2str(compat),
+		 isp_fw2str(version));
+
+	return compat;
+}
+
+static int apple_isp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct apple_isp *isp;
+	int err;
+
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(42));
+	if (err)
+		return err;
+
+	isp = devm_kzalloc(dev, sizeof(*isp), GFP_KERNEL);
+	if (!isp)
+		return -ENOMEM;
+
+	isp->dev = dev;
+	isp->hw = of_device_get_match_data(dev);
+	platform_set_drvdata(pdev, isp);
+	dev_set_drvdata(dev, isp);
+
+	/* Differences between firmware versions are rather minor so try to work
+	 * with unknown firmware.
+	 */
+	isp->fw_compat = isp_check_firmware_version(dev);
+
+	err = of_property_read_u32(dev->of_node, "apple,platform-id",
+				   &isp->platform_id);
+	if (err) {
+		dev_err(dev, "failed to get 'apple,platform-id' property: %d\n",
+			err);
+		return err;
+	}
+
+	err = of_property_read_u32(dev->of_node, "apple,temporal-filter",
+				   &isp->temporal_filter);
+	if (err)
+		isp->temporal_filter = 0;
+
+	err = apple_isp_init_presets(isp);
+	if (err) {
+		dev_err(dev, "failed to initialize presets\n");
+		return err;
+	}
+
+	err = apple_isp_attach_genpd(isp);
+	if (err) {
+		dev_err(dev, "failed to attach power domains\n");
+		return err;
+	}
+
+	isp->coproc = devm_platform_ioremap_resource_byname(pdev, "coproc");
+	if (IS_ERR(isp->coproc)) {
+		err = PTR_ERR(isp->coproc);
+		goto detach_genpd;
+	}
+
+	isp->mbox = devm_platform_ioremap_resource_byname(pdev, "mbox");
+	if (IS_ERR(isp->mbox)) {
+		err = PTR_ERR(isp->mbox);
+		goto detach_genpd;
+	}
+
+	isp->gpio = devm_platform_ioremap_resource_byname(pdev, "gpio");
+	if (IS_ERR(isp->gpio)) {
+		err = PTR_ERR(isp->gpio);
+		goto detach_genpd;
+	}
+
+	isp->mbox2 = devm_platform_ioremap_resource_byname(pdev, "mbox2");
+	if (IS_ERR(isp->mbox2)) {
+		err = PTR_ERR(isp->mbox2);
+		goto detach_genpd;
+	}
+
+	isp->irq = platform_get_irq(pdev, 0);
+	if (isp->irq < 0) {
+		err = isp->irq;
+		goto detach_genpd;
+	}
+	if (!isp->irq) {
+		err = -ENODEV;
+		goto detach_genpd;
+	}
+
+	mutex_init(&isp->iovad_lock);
+	mutex_init(&isp->video_lock);
+	spin_lock_init(&isp->buf_lock);
+	init_waitqueue_head(&isp->wait);
+	INIT_LIST_HEAD(&isp->gc);
+	INIT_LIST_HEAD(&isp->bufs_pending);
+	INIT_LIST_HEAD(&isp->bufs_submitted);
+	isp->wq = alloc_workqueue("apple-isp-wq", WQ_UNBOUND, 0);
+	if (!isp->wq) {
+		dev_err(dev, "failed to create workqueue\n");
+		err = -ENOMEM;
+		goto detach_genpd;
+	}
+
+	err = apple_isp_init_iommu(isp);
+	if (err) {
+		dev_err(dev, "failed to init iommu: %d\n", err);
+		goto destroy_wq;
+	}
+
+	err = apple_isp_alloc_firmware_surface(isp);
+	if (err) {
+		dev_err(dev, "failed to alloc firmware surface: %d\n", err);
+		goto free_iommu;
+	}
+
+	pm_runtime_enable(dev);
+
+	err = apple_isp_detect_camera(isp);
+	if (err) {
+		dev_err(dev, "failed to detect camera: %d\n", err);
+		goto free_surface;
+	}
+
+	err = apple_isp_setup_video(isp);
+	if (err) {
+		dev_err(dev, "failed to register video device: %d\n", err);
+		goto free_surface;
+	}
+
+	return 0;
+
+free_surface:
+	pm_runtime_disable(dev);
+	apple_isp_free_firmware_surface(isp);
+free_iommu:
+	apple_isp_free_iommu(isp);
+destroy_wq:
+	destroy_workqueue(isp->wq);
+detach_genpd:
+	apple_isp_detach_genpd(isp);
+	return err;
+}
+
+static void apple_isp_remove(struct platform_device *pdev)
+{
+	struct apple_isp *isp = platform_get_drvdata(pdev);
+
+	apple_isp_remove_video(isp);
+	pm_runtime_disable(isp->dev);
+	apple_isp_free_firmware_surface(isp);
+	apple_isp_free_iommu(isp);
+	destroy_workqueue(isp->wq);
+	apple_isp_detach_genpd(isp);
+}
+
+static const struct apple_isp_hw apple_isp_hw_t8103 = {
+	.gen = ISP_GEN_T8103,
+	.pmu_base = 0x23b704000,
+
+	.dsid_count = 4,
+	.dsid_clr_base0 = 0x200014000,
+	.dsid_clr_base1 = 0x200054000,
+	.dsid_clr_base2 = 0x200094000,
+	.dsid_clr_base3 = 0x2000d4000,
+	.dsid_clr_range0 = 0x1000,
+	.dsid_clr_range1 = 0x1000,
+	.dsid_clr_range2 = 0x1000,
+	.dsid_clr_range3 = 0x1000,
+
+	.clock_scratch = 0x23b738010,
+	.clock_base = 0x23bc3c000,
+	.clock_bit = 0x1,
+	.clock_size = 0x4,
+	.bandwidth_scratch = 0x23b73800c,
+	.bandwidth_base = 0x23bc3c000,
+	.bandwidth_bit = 0x0,
+	.bandwidth_size = 0x4,
+
+	.scl1 = false,
+	.lpdp = false,
+	.meta_size = ISP_META_SIZE_T8103,
+};
+
+static const struct apple_isp_hw apple_isp_hw_t6000 = {
+	.gen = ISP_GEN_T8103,
+	.pmu_base = 0x28e584000,
+
+	.dsid_count = 1,
+	.dsid_clr_base0 = 0x200014000,
+	.dsid_clr_base1 = 0x200054000,
+	.dsid_clr_base2 = 0x200094000,
+	.dsid_clr_base3 = 0x2000d4000,
+	.dsid_clr_range0 = 0x1000,
+	.dsid_clr_range1 = 0x1000,
+	.dsid_clr_range2 = 0x1000,
+	.dsid_clr_range3 = 0x1000,
+
+	.clock_scratch = 0x28e3d0868,
+	.clock_base = 0x0,
+	.clock_bit = 0x0,
+	.clock_size = 0x8,
+	.bandwidth_scratch = 0x28e3d0980,
+	.bandwidth_base = 0x0,
+	.bandwidth_bit = 0x0,
+	.bandwidth_size = 0x8,
+
+	.scl1 = false,
+	.lpdp = false,
+	.meta_size = ISP_META_SIZE_T8103,
+};
+
+static const struct apple_isp_hw apple_isp_hw_t8112 = {
+	.gen = ISP_GEN_T8112,
+	.pmu_base = 0x23b704000,
+
+	.dsid_count = 1,
+	.dsid_clr_base0 = 0x200f14000,
+	.dsid_clr_range0 = 0x1000,
+
+	.clock_scratch = 0x23b3d0560,
+	.clock_base = 0x0,
+	.clock_bit = 0x0,
+	.clock_size = 0x8,
+	.bandwidth_scratch = 0x23b3d05d0,
+	.bandwidth_base = 0x0,
+	.bandwidth_bit = 0x0,
+	.bandwidth_size = 0x8,
+
+	.scl1 = false,
+	.lpdp = false,
+	.meta_size = ISP_META_SIZE_T8112,
+};
+
+static const struct apple_isp_hw apple_isp_hw_t6020 = {
+	.gen = ISP_GEN_T8112,
+	.pmu_base = 0x290284000,
+
+	.dsid_count = 1,
+	.dsid_clr_base0 = 0x200f14000,
+	.dsid_clr_range0 = 0x1000,
+
+	.clock_scratch = 0x28e3d10a8,
+	.clock_base = 0x0,
+	.clock_bit = 0x0,
+	.clock_size = 0x8,
+	.bandwidth_scratch = 0x28e3d1200,
+	.bandwidth_base = 0x0,
+	.bandwidth_bit = 0x0,
+	.bandwidth_size = 0x8,
+
+	.scl1 = true,
+	.lpdp = true,
+	.meta_size = ISP_META_SIZE_T8112,
+};
+
+static const struct of_device_id apple_isp_of_match[] = {
+	{ .compatible = "apple,t8103-isp", .data = &apple_isp_hw_t8103 },
+	{ .compatible = "apple,t8112-isp", .data = &apple_isp_hw_t8112 },
+	{ .compatible = "apple,t6000-isp", .data = &apple_isp_hw_t6000 },
+	{ .compatible = "apple,t6020-isp", .data = &apple_isp_hw_t6020 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, apple_isp_of_match);
+
+static __maybe_unused int apple_isp_runtime_suspend(struct device *dev)
+{
+	/* RPM sleep is called when the V4L2 file handle is closed */
+	return 0;
+}
+
+static __maybe_unused int apple_isp_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+
+static __maybe_unused int apple_isp_suspend(struct device *dev)
+{
+	struct apple_isp *isp = dev_get_drvdata(dev);
+
+	/* We must restore V4L2 context on system resume. If we were streaming
+	 * before, we (essentially) stop streaming and start streaming again.
+	 */
+	apple_isp_video_suspend(isp);
+
+	return 0;
+}
+
+static __maybe_unused int apple_isp_resume(struct device *dev)
+{
+	struct apple_isp *isp = dev_get_drvdata(dev);
+
+	apple_isp_video_resume(isp);
+
+	return 0;
+}
+
+static const struct dev_pm_ops apple_isp_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(apple_isp_suspend, apple_isp_resume)
+	RUNTIME_PM_OPS(apple_isp_runtime_suspend, apple_isp_runtime_resume, NULL)
+};
+
+static struct platform_driver apple_isp_driver = {
+	.driver	= {
+		.name		= "apple-isp",
+		.of_match_table	= apple_isp_of_match,
+		.pm		= pm_ptr(&apple_isp_pm_ops),
+	},
+	.probe	= apple_isp_probe,
+	.remove	= apple_isp_remove,
+};
+module_platform_driver(apple_isp_driver);
+
+MODULE_AUTHOR("Eileen Yoon <eyn@gmx.com>");
+MODULE_DESCRIPTION("Apple ISP driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/media/platform/apple/isp/isp-drv.h b/drivers/media/platform/apple/isp/isp-drv.h
new file mode 100644
index 0000000000000000000000000000000000000000..b76ad4f56328c0454ad8fa249c82471fbae02d3a
--- /dev/null
+++ b/drivers/media/platform/apple/isp/isp-drv.h
@@ -0,0 +1,284 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2023 Eileen Yoon <eyn@gmx.com> */
+
+#ifndef __ISP_DRV_H__
+#define __ISP_DRV_H__
+
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/spinlock.h>
+
+#include <drm/drm_mm.h>
+#include <media/v4l2-device.h>
+#include <media/videobuf2-core.h>
+#include <media/videobuf2-v4l2.h>
+
+#define APPLE_ISP_DEVICE_NAME "apple-isp"
+#define APPLE_ISP_CARD_NAME "FaceTime HD Camera"
+
+#define ISP_MAX_CHANNELS      6
+#define ISP_IPC_MESSAGE_SIZE  64
+#define ISP_IPC_FLAG_ACK      0x1
+#define ISP_META_SIZE_T8103      0x4640
+#define ISP_META_SIZE_T8112      0x4840
+
+/* used to limit the user space buffers to the buffer_pool_config */
+#define ISP_MAX_BUFFERS 16
+
+enum isp_generation {
+	ISP_GEN_T8103,
+	ISP_GEN_T8112,
+};
+
+enum isp_firmware_version {
+	ISP_FIRMWARE_V_UNKNOWN,
+	ISP_FIRMWARE_V_12_3,
+	ISP_FIRMWARE_V_12_4,
+	ISP_FIRMWARE_V_13_5,
+};
+
+struct isp_surf {
+	struct drm_mm_node *mm;
+	struct list_head head;
+	u64 size;
+	u64 type;
+	u32 num_pages;
+	struct page **pages;
+	struct sg_table sgt;
+	dma_addr_t iova;
+	void *virt;
+	refcount_t refcount;
+	bool gc;
+	bool submitted;
+};
+
+struct isp_message {
+	u64 arg0;
+	u64 arg1;
+	u64 arg2;
+	u64 arg3;
+	u64 arg4;
+	u64 arg5;
+	u64 arg6;
+	u64 arg7;
+} __packed;
+static_assert(sizeof(struct isp_message) == ISP_IPC_MESSAGE_SIZE);
+
+struct isp_channel {
+	char *name;
+	u32 type;
+	u32 src;
+	u32 num;
+	u64 size;
+	dma_addr_t iova;
+	void *virt;
+	u32 doorbell;
+	u32 cursor;
+	struct mutex lock;
+	struct isp_message req;
+	struct isp_message rsp;
+	const struct isp_chan_ops *ops;
+};
+
+struct coord {
+	u32 x;
+	u32 y;
+};
+
+struct isp_preset {
+	u32 index;
+	struct coord input_dim;
+	struct coord output_dim;
+	struct coord crop_offset;
+	struct coord crop_size;
+};
+
+struct apple_isp_hw {
+	enum isp_generation gen;
+	u64 pmu_base;
+
+	int dsid_count;
+	u64 dsid_clr_base0;
+	u64 dsid_clr_base1;
+	u64 dsid_clr_base2;
+	u64 dsid_clr_base3;
+	u32 dsid_clr_range0;
+	u32 dsid_clr_range1;
+	u32 dsid_clr_range2;
+	u32 dsid_clr_range3;
+
+	u64 clock_scratch;
+	u64 clock_base;
+	u8 clock_bit;
+	u8 clock_size;
+	u64 bandwidth_scratch;
+	u64 bandwidth_base;
+	u8 bandwidth_bit;
+	u8 bandwidth_size;
+
+	u32 meta_size;
+	bool scl1;
+	bool lpdp;
+};
+
+enum isp_sensor_id {
+	ISP_IMX248_1820_01,
+	ISP_IMX248_1822_02,
+	ISP_IMX343_5221_02,
+	ISP_IMX354_9251_02,
+	ISP_IMX356_4820_01,
+	ISP_IMX356_4820_02,
+	ISP_IMX364_8720_01,
+	ISP_IMX364_8723_01,
+	ISP_IMX372_3820_01,
+	ISP_IMX372_3820_02,
+	ISP_IMX372_3820_11,
+	ISP_IMX372_3820_12,
+	ISP_IMX405_9720_01,
+	ISP_IMX405_9721_01,
+	ISP_IMX405_9723_01,
+	ISP_IMX414_2520_01,
+	ISP_IMX503_7820_01,
+	ISP_IMX503_7820_02,
+	ISP_IMX505_3921_01,
+	ISP_IMX514_2820_01,
+	ISP_IMX514_2820_02,
+	ISP_IMX514_2820_03,
+	ISP_IMX514_2820_04,
+	ISP_IMX558_1921_01,
+	ISP_IMX558_1922_02,
+	ISP_IMX603_7920_01,
+	ISP_IMX603_7920_02,
+	ISP_IMX603_7921_01,
+	ISP_IMX613_4920_01,
+	ISP_IMX613_4920_02,
+	ISP_IMX614_2921_01,
+	ISP_IMX614_2921_02,
+	ISP_IMX614_2922_02,
+	ISP_IMX633_3622_01,
+	ISP_IMX703_7721_01,
+	ISP_IMX703_7722_01,
+	ISP_IMX713_4721_01,
+	ISP_IMX713_4722_01,
+	ISP_IMX714_2022_01,
+	ISP_IMX772_3721_01,
+	ISP_IMX772_3721_11,
+	ISP_IMX772_3722_01,
+	ISP_IMX772_3723_01,
+	ISP_IMX814_2123_01,
+	ISP_IMX853_7622_01,
+	ISP_IMX913_7523_01,
+	ISP_VD56G0_6221_01,
+	ISP_VD56G0_6222_01,
+};
+
+struct isp_format {
+	enum isp_sensor_id id;
+	u32 version;
+	struct isp_preset *preset;
+	unsigned int num_planes;
+	u32 strides[VB2_MAX_PLANES];
+	size_t plane_size[VB2_MAX_PLANES];
+	size_t total_size;
+};
+
+struct apple_isp {
+	struct device *dev;
+	const struct apple_isp_hw *hw;
+	enum isp_firmware_version fw_compat;
+	u32 platform_id;
+	u32 temporal_filter;
+	struct isp_preset *presets;
+	int num_presets;
+
+	int num_channels;
+	struct isp_format fmts[ISP_MAX_CHANNELS];
+	unsigned int current_ch;
+
+	struct video_device vdev;
+	struct media_device mdev;
+	struct v4l2_device v4l2_dev;
+	struct vb2_queue vbq;
+	struct mutex video_lock;
+	unsigned int sequence;
+	bool multiplanar;
+
+	int pd_count;
+	struct device **pd_dev;
+	struct device_link **pd_link;
+	bool pds_active;
+
+	int irq;
+
+	void __iomem *coproc;
+	void __iomem *mbox;
+	void __iomem *gpio;
+	void __iomem *mbox2;
+
+	struct iommu_domain *domain;
+	unsigned long shift;
+	struct drm_mm iovad;
+	struct mutex iovad_lock;
+
+	struct isp_firmware {
+		u64 heap_top;
+	} fw;
+
+	struct isp_surf *ipc_surf;
+	struct isp_surf *extra_surf;
+	struct isp_surf *data_surf;
+	struct isp_surf *log_surf;
+	struct isp_surf *bt_surf;
+	struct isp_surf *meta_surfs[ISP_MAX_BUFFERS];
+	struct list_head gc;
+	struct workqueue_struct *wq;
+
+	int num_ipc_chans;
+	struct isp_channel **ipc_chans;
+	struct isp_channel *chan_tm; /* TERMINAL */
+	struct isp_channel *chan_io; /* IO */
+	struct isp_channel *chan_dg; /* DEBUG */
+	struct isp_channel *chan_bh; /* BUF_H2T */
+	struct isp_channel *chan_bt; /* BUF_T2H */
+	struct isp_channel *chan_sm; /* SHAREDMALLOC */
+	struct isp_channel *chan_it; /* IO_T2H */
+
+	wait_queue_head_t wait;
+	dma_addr_t cmd_iova;
+	void *cmd_virt;
+
+	unsigned long state;
+	spinlock_t buf_lock;
+	struct list_head bufs_pending;
+	struct list_head bufs_submitted;
+};
+
+struct isp_chan_ops {
+	int (*handle)(struct apple_isp *isp, struct isp_channel *chan);
+};
+
+struct isp_buffer {
+	struct vb2_v4l2_buffer vb;
+	struct list_head link;
+	struct isp_surf surfs[VB2_MAX_PLANES];
+};
+
+#define to_isp_buffer(x) container_of((x), struct isp_buffer, vb)
+
+enum {
+	ISP_STATE_STREAMING,
+	ISP_STATE_LOGGING,
+	ISP_STATE_SLEEPING,
+};
+
+#define isp_dbg(isp, fmt, ...) \
+	dev_dbg((isp)->dev, "[%s] " fmt, __func__, ##__VA_ARGS__)
+
+#define isp_err(isp, fmt, ...) \
+	dev_err((isp)->dev, "[%s] " fmt, __func__, ##__VA_ARGS__)
+
+#define isp_get_format(isp, ch)	    (&(isp)->fmts[(ch)])
+#define isp_get_current_format(isp) (isp_get_format(isp, isp->current_ch))
+
+#endif /* __ISP_DRV_H__ */
diff --git a/drivers/media/platform/apple/isp/isp-fw.c b/drivers/media/platform/apple/isp/isp-fw.c
new file mode 100644
index 0000000000000000000000000000000000000000..ffdfcf460fedcf2bcf94118a7b27d9e49010274f
--- /dev/null
+++ b/drivers/media/platform/apple/isp/isp-fw.c
@@ -0,0 +1,770 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright 2023 Eileen Yoon <eyn@gmx.com> */
+
+#include "isp-fw.h"
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/types.h>
+
+#include "isp-cmd.h"
+#include "isp-iommu.h"
+#include "isp-ipc.h"
+#include "isp-regs.h"
+#include "isp-v4l2.h"
+
+#define ISP_FIRMWARE_MDELAY    1
+#define ISP_FIRMWARE_MAX_TRIES 1000
+
+#define ISP_FIRMWARE_IPC_SIZE  0x1c000
+#define ISP_FIRMWARE_DATA_SIZE 0x28000
+
+#define ISP_COPROC_IN_WFI      0x3
+
+static inline u32 isp_coproc_read32(struct apple_isp *isp, u32 reg)
+{
+	return readl(isp->coproc + reg);
+}
+
+static inline void isp_coproc_write32(struct apple_isp *isp, u32 reg, u32 val)
+{
+	writel(val, isp->coproc + reg);
+}
+
+static inline u32 isp_gpio_read32(struct apple_isp *isp, u32 reg)
+{
+	return readl(isp->gpio + reg);
+}
+
+static inline void isp_gpio_write32(struct apple_isp *isp, u32 reg, u32 val)
+{
+	writel(val, isp->gpio + reg);
+}
+
+static int apple_isp_power_up_domains(struct apple_isp *isp)
+{
+	int ret;
+
+	if (isp->pds_active)
+		return 0;
+
+	for (int i = 1; i < isp->pd_count; i++) {
+		ret = pm_runtime_resume_and_get(isp->pd_dev[i]);
+		if (ret) {
+			dev_err(isp->dev,
+				"Failed to power up power domain %d: %d\n", i, ret);
+			while (--i != 1)
+				pm_runtime_put_sync(isp->pd_dev[i]);
+			return ret;
+		}
+	}
+
+	isp->pds_active = true;
+
+	return 0;
+}
+
+static void apple_isp_power_down_domains(struct apple_isp *isp)
+{
+	int ret;
+
+	if (!isp->pds_active)
+		return;
+
+	for (int i = isp->pd_count - 1; i >= 1; i--) {
+		ret = pm_runtime_put_sync(isp->pd_dev[i]);
+		if (ret < 0)
+			dev_err(isp->dev,
+				"Failed to power up power domain %d: %d\n", i, ret);
+	}
+
+	isp->pds_active = false;
+}
+
+void *apple_isp_translate(struct apple_isp *isp, struct isp_surf *surf,
+			  dma_addr_t iova, size_t size)
+{
+	dma_addr_t end = iova + size;
+
+	if (!surf) {
+		dev_err(isp->dev,
+			"Failed to translate IPC iova 0x%llx (0x%zx): No surface\n",
+			(long long)iova, size);
+		return NULL;
+	}
+
+	if (end < iova || iova < surf->iova ||
+	    end > (surf->iova + surf->size)) {
+		dev_err(isp->dev,
+			"Failed to translate IPC iova 0x%llx (0x%zx): Out of bounds\n",
+			(long long)iova, size);
+		return NULL;
+	}
+
+	if (!surf->virt) {
+		dev_err(isp->dev,
+			"Failed to translate IPC iova 0x%llx (0x%zx): No VMap\n",
+			(long long)iova, size);
+		return NULL;
+	}
+
+	return surf->virt + (iova - surf->iova);
+}
+
+struct isp_firmware_bootargs {
+	u32 pad_0[2];
+	u64 ipc_iova;
+	u64 shared_base;
+	u64 shared_size;
+	u64 extra_iova;
+	u64 extra_size;
+	u32 platform_id;
+	u32 pad_40;
+	u64 logbuf_addr;
+	u64 logbuf_size;
+	u64 logbuf_entsize;
+	u32 ipc_size;
+	u32 pad_60[5];
+	u32 unk5;
+	u32 pad_7c[13];
+	u32 pad_b0;
+	u32 unk7;
+	u32 pad_b8[5];
+	u32 unk_iova1;
+	u32 pad_c0[47];
+	u32 unk9;
+} __packed;
+static_assert(sizeof(struct isp_firmware_bootargs) == 0x180);
+
+struct isp_chan_desc {
+	char name[64];
+	u32 type;
+	u32 src;
+	u32 num;
+	u32 pad;
+	u64 iova;
+	u32 padding[0x2a];
+} __packed;
+static_assert(sizeof(struct isp_chan_desc) == 0x100);
+
+static const struct isp_chan_ops tm_ops = {
+	.handle = apple_isp_ipc_tm_handle,
+};
+
+static const struct isp_chan_ops sm_ops = {
+	.handle = apple_isp_ipc_sm_handle,
+};
+
+static const struct isp_chan_ops bt_ops = {
+	.handle = apple_isp_ipc_bt_handle,
+};
+
+static irqreturn_t apple_isp_isr(int irq, void *dev)
+{
+	struct apple_isp *isp = dev;
+
+	isp_mbox2_write32(isp, ISP_MBOX2_IRQ_ACK,
+			 isp_mbox_read32(isp, ISP_MBOX_IRQ_INTERRUPT));
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t apple_isp_isr_thread(int irq, void *dev)
+{
+	struct apple_isp *isp = dev;
+
+	wake_up_all(&isp->wait);
+
+	apple_isp_ipc_chan_handle(isp, isp->chan_sm);
+	wake_up_all(&isp->wait); /* Some commands depend on sm */
+
+	apple_isp_ipc_chan_handle(isp, isp->chan_tm);
+
+	apple_isp_ipc_chan_handle(isp, isp->chan_bt);
+	wake_up_all(&isp->wait);
+
+	return IRQ_HANDLED;
+}
+
+static void isp_disable_irq(struct apple_isp *isp)
+{
+	isp_mbox_write32(isp, ISP_MBOX_IRQ_ENABLE, 0x0);
+	free_irq(isp->irq, isp);
+	isp_gpio_write32(isp, ISP_GPIO_1, 0xfeedbabe);
+}
+
+static int isp_enable_irq(struct apple_isp *isp)
+{
+	int err;
+
+	err = request_threaded_irq(isp->irq, apple_isp_isr,
+				   apple_isp_isr_thread, 0, "apple-isp", isp);
+	if (err) {
+		isp_err(isp, "failed to request IRQ#%u (%d)\n", isp->irq, err);
+		return err;
+	}
+
+	isp_mbox_write32(isp, ISP_MBOX_IRQ_ENABLE, 0xf);
+
+	return 0;
+}
+
+static int isp_reset_coproc(struct apple_isp *isp)
+{
+	int retries;
+	u32 status;
+	u32 val;
+
+	isp_coproc_write32(isp, ISP_COPROC_EDPRCR, 0x2);
+
+	isp_coproc_write32(isp, ISP_COPROC_FABRIC_0, 0xff00ff);
+	isp_coproc_write32(isp, ISP_COPROC_FABRIC_1, 0xff00ff);
+	isp_coproc_write32(isp, ISP_COPROC_FABRIC_2, 0xff00ff);
+	isp_coproc_write32(isp, ISP_COPROC_FABRIC_3, 0xff00ff);
+
+	isp_coproc_write32(isp, ISP_COPROC_IRQ_MASK_0, 0xffffffff);
+	isp_coproc_write32(isp, ISP_COPROC_IRQ_MASK_1, 0xffffffff);
+	isp_coproc_write32(isp, ISP_COPROC_IRQ_MASK_2, 0xffffffff);
+	isp_coproc_write32(isp, ISP_COPROC_IRQ_MASK_3, 0xffffffff);
+	isp_coproc_write32(isp, ISP_COPROC_IRQ_MASK_4, 0xffffffff);
+	isp_coproc_write32(isp, ISP_COPROC_IRQ_MASK_5, 0xffffffff);
+
+	for (retries = 0; retries < 128; retries++) {
+		val = isp_coproc_read32(isp, 0x818);
+		if (val == 0)
+			break;
+	}
+
+	for (retries = 0; retries < 128; retries++) {
+		val = isp_coproc_read32(isp, 0x81c);
+		if (val == 0)
+			break;
+	}
+
+	for (retries = 0; retries < ISP_FIRMWARE_MAX_TRIES; retries++) {
+		status = isp_coproc_read32(isp, ISP_COPROC_STATUS);
+		if (status & ISP_COPROC_IN_WFI) {
+			isp_dbg(isp, "%d: coproc in WFI (status: 0x%x)\n",
+				retries, status);
+			break;
+		}
+		mdelay(ISP_FIRMWARE_MDELAY);
+	}
+	if (retries >= ISP_FIRMWARE_MAX_TRIES) {
+		isp_err(isp, "coproc NOT in WFI (status: 0x%x)\n", status);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void isp_firmware_shutdown_stage1(struct apple_isp *isp)
+{
+	isp_coproc_write32(isp, ISP_COPROC_CONTROL, 0x0);
+
+	apple_isp_power_down_domains(isp);
+}
+
+static int isp_firmware_boot_stage1(struct apple_isp *isp)
+{
+	int err, retries;
+	u32 val;
+
+	err = apple_isp_power_up_domains(isp);
+	if (err)
+		return err;
+
+
+	isp_gpio_write32(isp, ISP_GPIO_CLOCK_EN, 0x1);
+
+	err = isp_reset_coproc(isp);
+	if (err)
+		return err;
+
+	isp_gpio_write32(isp, ISP_GPIO_0, 0x0);
+	isp_gpio_write32(isp, ISP_GPIO_1, 0x0);
+	isp_gpio_write32(isp, ISP_GPIO_2, 0x0);
+	isp_gpio_write32(isp, ISP_GPIO_3, 0x0);
+	isp_gpio_write32(isp, ISP_GPIO_4, 0x0);
+	isp_gpio_write32(isp, ISP_GPIO_5, 0x0);
+	isp_gpio_write32(isp, ISP_GPIO_6, 0x0);
+	isp_gpio_write32(isp, ISP_GPIO_7, 0x0);
+
+	isp_mbox_write32(isp, ISP_MBOX_IRQ_ENABLE, 0x0);
+
+	isp_coproc_write32(isp, ISP_COPROC_CONTROL, 0x0);
+	isp_coproc_write32(isp, ISP_COPROC_CONTROL, 0x10);
+
+	/* Wait for ISP_GPIO_7 to 0x0 -> 0x8042006 */
+	for (retries = 0; retries < ISP_FIRMWARE_MAX_TRIES; retries++) {
+		val = isp_gpio_read32(isp, ISP_GPIO_7);
+		if (val == 0x8042006) {
+			isp_dbg(isp,
+				"got first magic number (0x%x) from firmware\n",
+				val);
+			break;
+		}
+		mdelay(ISP_FIRMWARE_MDELAY);
+	}
+	if (retries >= ISP_FIRMWARE_MAX_TRIES) {
+		isp_err(isp,
+			"never received first magic number from firmware\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+int apple_isp_alloc_firmware_surface(struct apple_isp *isp)
+{
+	/* These are static, so let's do it once and for all */
+	isp->ipc_surf = apple_isp_alloc_surface_vmap(isp, ISP_FIRMWARE_IPC_SIZE);
+	if (!isp->ipc_surf) {
+		isp_err(isp, "failed to alloc shared surface for ipc\n");
+		return -ENOMEM;
+	}
+
+	isp->data_surf = apple_isp_alloc_surface_vmap(isp, ISP_FIRMWARE_DATA_SIZE);
+	if (!isp->data_surf) {
+		isp_err(isp, "failed to alloc shared surface for data files\n");
+		apple_isp_free_surface(isp, isp->ipc_surf);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void apple_isp_free_firmware_surface(struct apple_isp *isp)
+{
+	apple_isp_free_surface(isp, isp->data_surf);
+	apple_isp_free_surface(isp, isp->ipc_surf);
+}
+
+static void isp_firmware_shutdown_stage2(struct apple_isp *isp)
+{
+	apple_isp_free_surface(isp, isp->extra_surf);
+}
+
+static int isp_firmware_boot_stage2(struct apple_isp *isp)
+{
+	struct isp_firmware_bootargs args;
+	dma_addr_t args_iova;
+	void *args_virt;
+	int err, retries;
+	u32 val, num_ipc_chans, args_offset, extra_size;
+
+	num_ipc_chans = isp_gpio_read32(isp, ISP_GPIO_0);
+	args_offset = isp_gpio_read32(isp, ISP_GPIO_1);
+	extra_size = isp_gpio_read32(isp, ISP_GPIO_3);
+	isp->num_ipc_chans = num_ipc_chans;
+
+	if (!isp->num_ipc_chans) {
+		dev_err(isp->dev, "No IPC channels found\n");
+		return -ENODEV;
+	}
+
+	if (isp->num_ipc_chans != 7)
+		dev_warn(isp->dev, "unexpected channel count (%d)\n",
+			 num_ipc_chans);
+
+	isp->extra_surf = apple_isp_alloc_surface_vmap(isp, extra_size);
+	if (!isp->extra_surf) {
+		isp_err(isp, "failed to alloc surface for extra heap\n");
+		return -ENOMEM;
+	}
+
+	args_iova = isp->ipc_surf->iova + args_offset + 0x40;
+	args_virt = isp->ipc_surf->virt + args_offset + 0x40;
+	isp->cmd_iova = args_iova + sizeof(args) + 0x40;
+	isp->cmd_virt = args_virt + sizeof(args) + 0x40;
+
+	memset(&args, 0, sizeof(args));
+	args.ipc_iova = isp->ipc_surf->iova;
+	args.ipc_size = isp->ipc_surf->size;
+	args.shared_base = isp->fw.heap_top & 0xffffffff;
+	args.shared_size = 0x10000000UL - args.shared_base;
+	args.extra_iova = isp->extra_surf->iova;
+	args.extra_size = isp->extra_surf->size;
+	args.platform_id = isp->platform_id;
+	args.unk5 = 0x40;
+	args.unk7 = 0x1;
+	args.unk_iova1 = args_iova + sizeof(args) - 0xc;
+	args.unk9 = 0x3;
+	memcpy(args_virt, &args, sizeof(args));
+
+	isp_gpio_write32(isp, ISP_GPIO_0, args_iova);
+	isp_gpio_write32(isp, ISP_GPIO_1, args_iova >> 32);
+	dma_wmb();
+
+	/* Wait for ISP_GPIO_7 to 0xf7fbdff9 -> 0x8042006 */
+	isp_gpio_write32(isp, ISP_GPIO_7, 0xf7fbdff9);
+
+	for (retries = 0; retries < ISP_FIRMWARE_MAX_TRIES; retries++) {
+		val = isp_gpio_read32(isp, ISP_GPIO_7);
+		if (val == 0x8042006) {
+			isp_dbg(isp,
+				"got second magic number (0x%x) from firmware\n",
+				val);
+			break;
+		}
+		mdelay(ISP_FIRMWARE_MDELAY);
+	}
+	if (retries >= ISP_FIRMWARE_MAX_TRIES) {
+		isp_err(isp,
+			"never received second magic number from firmware\n");
+		err = -ENODEV;
+		goto free_extra;
+	}
+
+	return 0;
+
+free_extra:
+	apple_isp_free_surface(isp, isp->extra_surf);
+	return err;
+}
+
+static inline struct isp_channel *isp_get_chan_index(struct apple_isp *isp,
+						     const char *name)
+{
+	for (int i = 0; i < isp->num_ipc_chans; i++) {
+		if (!strcasecmp(isp->ipc_chans[i]->name, name))
+			return isp->ipc_chans[i];
+	}
+	return NULL;
+}
+
+static void isp_free_channel_info(struct apple_isp *isp)
+{
+	struct isp_channel *chan;
+	int i;
+
+	for (i = 0; i < isp->num_ipc_chans; i++) {
+		chan = isp->ipc_chans[i];
+		if (!chan)
+			continue;
+
+		kfree(chan->name);
+		kfree(chan);
+		isp->ipc_chans[i] = NULL;
+	}
+	kfree(isp->ipc_chans);
+	isp->ipc_chans = NULL;
+}
+
+static int isp_fill_channel_info(struct apple_isp *isp)
+{
+	u64 table_iova = isp_gpio_read32(isp, ISP_GPIO_0) |
+			 ((u64)isp_gpio_read32(isp, ISP_GPIO_1)) << 32;
+	void *table_virt = apple_isp_ipc_translate(
+		isp, table_iova,
+		sizeof(struct isp_chan_desc) * isp->num_ipc_chans);
+
+	if (!table_virt) {
+		dev_err(isp->dev, "Failed to find channel table\n");
+		return -EIO;
+	}
+
+	isp->ipc_chans = kcalloc(isp->num_ipc_chans,
+				 sizeof(struct isp_channel *), GFP_KERNEL);
+	if (!isp->ipc_chans)
+		goto out;
+
+	for (int i = 0; i < isp->num_ipc_chans; i++) {
+		struct isp_chan_desc desc;
+		void *desc_virt = table_virt + (i * sizeof(desc));
+		struct isp_channel *chan =
+			kzalloc(sizeof(struct isp_channel), GFP_KERNEL);
+		if (!chan)
+			goto out;
+		isp->ipc_chans[i] = chan;
+
+		memcpy(&desc, desc_virt, sizeof(desc));
+		chan->name = kstrdup(desc.name, GFP_KERNEL);
+		chan->type = desc.type;
+		chan->src = desc.src;
+		chan->doorbell = 1 << chan->src;
+		chan->num = desc.num;
+		chan->size = desc.num * ISP_IPC_MESSAGE_SIZE;
+		chan->iova = desc.iova;
+		chan->virt =
+			apple_isp_ipc_translate(isp, desc.iova, chan->size);
+		chan->cursor = 0;
+		mutex_init(&chan->lock);
+
+		if (!chan->virt) {
+			dev_err(isp->dev, "Failed to find channel buffer\n");
+			goto out;
+		}
+
+		if ((chan->type != ISP_IPC_CHAN_TYPE_COMMAND) &&
+		    (chan->type != ISP_IPC_CHAN_TYPE_REPLY) &&
+		    (chan->type != ISP_IPC_CHAN_TYPE_REPORT)) {
+			isp_err(isp, "invalid ipc chan type (%d)\n",
+				chan->type);
+			goto out;
+		}
+
+		isp_dbg(isp, "chan: %s type: %d src: %d num: %d iova: 0x%llx\n",
+			chan->name, chan->type, chan->src, chan->num,
+			chan->iova);
+	}
+
+	isp->chan_tm = isp_get_chan_index(isp, "TERMINAL");
+	isp->chan_io = isp_get_chan_index(isp, "IO");
+	isp->chan_dg = isp_get_chan_index(isp, "DEBUG");
+	isp->chan_bh = isp_get_chan_index(isp, "BUF_H2T");
+	isp->chan_bt = isp_get_chan_index(isp, "BUF_T2H");
+	isp->chan_sm = isp_get_chan_index(isp, "SHAREDMALLOC");
+	isp->chan_it = isp_get_chan_index(isp, "IO_T2H");
+
+	if (!isp->chan_tm || !isp->chan_io || !isp->chan_dg || !isp->chan_bh ||
+	    !isp->chan_bt || !isp->chan_sm || !isp->chan_it) {
+		isp_err(isp, "did not find all of the required ipc chans\n");
+		goto out;
+	}
+
+	isp->chan_tm->ops = &tm_ops;
+	isp->chan_sm->ops = &sm_ops;
+	isp->chan_bt->ops = &bt_ops;
+
+	return 0;
+out:
+	isp_free_channel_info(isp);
+	return -ENOMEM;
+}
+
+static void isp_firmware_shutdown_stage3(struct apple_isp *isp)
+{
+	isp_free_channel_info(isp);
+}
+
+static int isp_firmware_boot_stage3(struct apple_isp *isp)
+{
+	struct isp_channel *chan;
+	struct isp_message msg;
+	void *msg_virt;
+	int err, retries, i, j;
+	u32 val;
+
+	err = isp_fill_channel_info(isp);
+	if (err)
+		return err;
+
+	/* Mask the command channels to prepare for submission */
+	for (i = 0; i < isp->num_ipc_chans; i++) {
+		chan = isp->ipc_chans[i];
+		if (chan->type != ISP_IPC_CHAN_TYPE_COMMAND)
+			continue;
+		for (j = 0; j < chan->num; j++) {
+			msg_virt = chan->virt + (j * sizeof(msg));
+
+			memset(&msg, 0, sizeof(msg));
+			msg.arg0 = ISP_IPC_FLAG_ACK;
+			memcpy(msg_virt, &msg, sizeof(msg));
+		}
+	}
+	dma_wmb();
+
+	/* Wait for ISP_GPIO_3 to 0x8042006 -> 0x0 */
+	isp_gpio_write32(isp, ISP_GPIO_3, 0x8042006);
+
+	for (retries = 0; retries < ISP_FIRMWARE_MAX_TRIES; retries++) {
+		val = isp_gpio_read32(isp, ISP_GPIO_3);
+		if (val == 0x0) {
+			isp_dbg(isp,
+				"got third magic number (0x%x) from firmware\n",
+				val);
+			break;
+		}
+		mdelay(ISP_FIRMWARE_MDELAY);
+	}
+	if (retries >= ISP_FIRMWARE_MAX_TRIES) {
+		isp_err(isp,
+			"never received third magic number from firmware\n");
+		isp_free_channel_info(isp);
+		return -ENODEV;
+	}
+
+	isp_dbg(isp, "firmware booted!\n");
+
+	return 0;
+}
+
+static int isp_stop_command_processor(struct apple_isp *isp)
+{
+	int retries;
+	int res;
+	u32 val;
+
+	isp_gpio_write32(isp, ISP_GPIO_0, 0xf7fbdff9);
+
+	res = apple_isp_cmd_suspend(isp);
+	if (res) {
+		isp_err(isp, "isp_cmd_suspend() failed\n");
+		return res;
+	}
+
+	for (retries = 0; retries < ISP_FIRMWARE_MAX_TRIES; retries++) {
+		val = isp_gpio_read32(isp, ISP_GPIO_0);
+		if (val == 0x8042006) {
+			isp_dbg(isp, "got magic number (0x%x) from firmware\n",
+				val);
+			break;
+		}
+		mdelay(ISP_FIRMWARE_MDELAY);
+	}
+	if (retries >= ISP_FIRMWARE_MAX_TRIES) {
+		isp_err(isp, "never received magic number from firmware\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int isp_start_command_processor(struct apple_isp *isp)
+{
+	int err;
+
+	err = apple_isp_cmd_print_enable(isp, 1);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_set_isp_pmu_base(isp, isp->hw->pmu_base);
+	if (err)
+		return err;
+
+	if (isp->hw->dsid_count == 1) {
+		err = apple_isp_cmd_set_dsid_clr_req_base(
+			isp, isp->hw->dsid_clr_base0, isp->hw->dsid_clr_range0);
+		if (err)
+			return err;
+	} else {
+		err = apple_isp_cmd_set_dsid_clr_req_base2(
+			isp, isp->hw->dsid_clr_base0, isp->hw->dsid_clr_base1,
+			isp->hw->dsid_clr_base2, isp->hw->dsid_clr_base3,
+			isp->hw->dsid_clr_range0, isp->hw->dsid_clr_range1,
+			isp->hw->dsid_clr_range2, isp->hw->dsid_clr_range3);
+		if (err)
+			return err;
+	}
+
+	err = apple_isp_cmd_pmp_ctrl_set(
+		isp, isp->hw->clock_scratch, isp->hw->clock_base,
+		isp->hw->clock_bit, isp->hw->clock_size,
+		isp->hw->bandwidth_scratch, isp->hw->bandwidth_base,
+		isp->hw->bandwidth_bit, isp->hw->bandwidth_size);
+	if (err)
+		return err;
+
+	err = apple_isp_cmd_start(isp, 0);
+	if (err)
+		return err;
+
+	/* Now we can access CISP_CMD_CH_* commands */
+
+	return 0;
+}
+
+static void isp_collect_gc_surface(struct apple_isp *isp)
+{
+	struct isp_surf *tmp, *surf;
+
+	isp->log_surf = NULL;
+	isp->bt_surf = NULL;
+
+	list_for_each_entry_safe_reverse(surf, tmp, &isp->gc, head) {
+		isp_dbg(isp, "freeing iova: 0x%llx size: 0x%llx virt: %pS\n",
+			surf->iova, surf->size, (void *)surf->virt);
+		apple_isp_free_surface(isp, surf);
+	}
+}
+
+static int isp_firmware_boot(struct apple_isp *isp)
+{
+	int err;
+
+	err = isp_firmware_boot_stage1(isp);
+	if (err) {
+		isp_err(isp, "failed firmware boot stage 1: %d\n", err);
+		goto garbage_collect;
+	}
+
+	err = isp_firmware_boot_stage2(isp);
+	if (err) {
+		isp_err(isp, "failed firmware boot stage 2: %d\n", err);
+		goto shutdown_stage1;
+	}
+
+	err = isp_firmware_boot_stage3(isp);
+	if (err) {
+		isp_err(isp, "failed firmware boot stage 3: %d\n", err);
+		goto shutdown_stage2;
+	}
+
+	err = isp_enable_irq(isp);
+	if (err) {
+		isp_err(isp, "failed to enable interrupts: %d\n", err);
+		goto shutdown_stage3;
+	}
+
+	err = isp_start_command_processor(isp);
+	if (err) {
+		isp_err(isp, "failed to start command processor: %d\n", err);
+		goto disable_irqs;
+	}
+
+	flush_workqueue(isp->wq);
+
+	return 0;
+
+disable_irqs:
+	isp_disable_irq(isp);
+shutdown_stage3:
+	isp_firmware_shutdown_stage3(isp);
+shutdown_stage2:
+	isp_firmware_shutdown_stage2(isp);
+shutdown_stage1:
+	isp_firmware_shutdown_stage1(isp);
+garbage_collect:
+	isp_collect_gc_surface(isp);
+	return err;
+}
+
+static void isp_firmware_shutdown(struct apple_isp *isp)
+{
+	flush_workqueue(isp->wq);
+	isp_stop_command_processor(isp);
+	isp_disable_irq(isp);
+	isp_firmware_shutdown_stage3(isp);
+	isp_firmware_shutdown_stage2(isp);
+	isp_firmware_shutdown_stage1(isp);
+	isp_collect_gc_surface(isp);
+}
+
+int apple_isp_firmware_boot(struct apple_isp *isp)
+{
+	int err;
+
+	/* Needs to be power cycled for IOMMU to behave correctly */
+	err = pm_runtime_resume_and_get(isp->dev);
+	if (err) {
+		dev_err(isp->dev, "failed to enable power: %d\n", err);
+		return err;
+	}
+
+	err = isp_firmware_boot(isp);
+	if (err) {
+		dev_err(isp->dev, "failed to boot firmware: %d\n", err);
+		pm_runtime_put_sync(isp->dev);
+		return err;
+	}
+
+	return 0;
+}
+
+void apple_isp_firmware_shutdown(struct apple_isp *isp)
+{
+	isp_firmware_shutdown(isp);
+	pm_runtime_put_sync(isp->dev);
+}
diff --git a/drivers/media/platform/apple/isp/isp-fw.h b/drivers/media/platform/apple/isp/isp-fw.h
new file mode 100644
index 0000000000000000000000000000000000000000..b986141cf2a9a474b9e5ef0abada0d51dbfcdd91
--- /dev/null
+++ b/drivers/media/platform/apple/isp/isp-fw.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2023 Eileen Yoon <eyn@gmx.com> */
+
+#ifndef __ISP_FW_H__
+#define __ISP_FW_H__
+
+#include "isp-drv.h"
+
+int apple_isp_alloc_firmware_surface(struct apple_isp *isp);
+void apple_isp_free_firmware_surface(struct apple_isp *isp);
+
+int apple_isp_firmware_boot(struct apple_isp *isp);
+void apple_isp_firmware_shutdown(struct apple_isp *isp);
+
+void *apple_isp_translate(struct apple_isp *isp, struct isp_surf *surf,
+			  dma_addr_t iova, size_t size);
+
+static inline void *apple_isp_ipc_translate(struct apple_isp *isp,
+					    dma_addr_t iova, size_t size)
+{
+	return apple_isp_translate(isp, isp->ipc_surf, iova, size);
+}
+
+#endif /* __ISP_FW_H__ */
diff --git a/drivers/media/platform/apple/isp/isp-iommu.c b/drivers/media/platform/apple/isp/isp-iommu.c
new file mode 100644
index 0000000000000000000000000000000000000000..79d3a9691542b0301e3e02ea5313d64a4e68be7d
--- /dev/null
+++ b/drivers/media/platform/apple/isp/isp-iommu.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright 2023 Eileen Yoon <eyn@gmx.com> */
+
+#include <linux/iommu.h>
+#include <linux/vmalloc.h>
+
+#include "isp-iommu.h"
+
+static void isp_surf_free_pages(struct isp_surf *surf)
+{
+	for (u32 i = 0; i < surf->num_pages && surf->pages[i] != NULL; i++)
+		__free_page(surf->pages[i]);
+
+	kvfree(surf->pages);
+}
+
+static int isp_surf_alloc_pages(struct isp_surf *surf)
+{
+	surf->pages = kvmalloc_array(surf->num_pages, sizeof(*surf->pages),
+				     GFP_KERNEL);
+	if (!surf->pages)
+		return -ENOMEM;
+
+	for (u32 i = 0; i < surf->num_pages; i++) {
+		surf->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (surf->pages[i] == NULL)
+			goto free_pages;
+	}
+
+	return 0;
+
+free_pages:
+	isp_surf_free_pages(surf);
+	return -ENOMEM;
+}
+
+int apple_isp_surf_vmap(struct apple_isp *isp, struct isp_surf *surf)
+{
+	surf->virt = vmap(surf->pages, surf->num_pages, VM_MAP,
+			  pgprot_writecombine(PAGE_KERNEL));
+	if (surf->virt == NULL) {
+		dev_err(isp->dev, "failed to vmap size 0x%llx\n", surf->size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void isp_surf_vunmap(struct apple_isp *isp, struct isp_surf *surf)
+{
+	if (surf->virt)
+		vunmap(surf->virt);
+	surf->virt = NULL;
+}
+
+static void isp_surf_unreserve_iova(struct apple_isp *isp,
+				    struct isp_surf *surf)
+{
+	if (surf->mm) {
+		mutex_lock(&isp->iovad_lock);
+		drm_mm_remove_node(surf->mm);
+		mutex_unlock(&isp->iovad_lock);
+		kfree(surf->mm);
+	}
+	surf->mm = NULL;
+}
+
+static int isp_surf_reserve_iova(struct apple_isp *isp, struct isp_surf *surf)
+{
+	int err;
+
+	surf->mm = kzalloc(sizeof(*surf->mm), GFP_KERNEL);
+	if (!surf->mm)
+		return -ENOMEM;
+
+	mutex_lock(&isp->iovad_lock);
+	err = drm_mm_insert_node_generic(&isp->iovad, surf->mm,
+					 ALIGN(surf->size, 1UL << isp->shift),
+					 1UL << isp->shift, 0, 0);
+	mutex_unlock(&isp->iovad_lock);
+	if (err) {
+		dev_err(isp->dev, "failed to reserve 0x%llx of iova space\n",
+			surf->size);
+		goto mm_free;
+	}
+
+	surf->iova = surf->mm->start;
+
+	return 0;
+mm_free:
+	kfree(surf->mm);
+	surf->mm = NULL;
+	return err;
+}
+
+static void isp_surf_iommu_unmap(struct apple_isp *isp, struct isp_surf *surf)
+{
+	iommu_unmap(isp->domain, surf->iova, surf->size);
+	sg_free_table(&surf->sgt);
+}
+
+static int isp_surf_iommu_map(struct apple_isp *isp, struct isp_surf *surf)
+{
+	unsigned long size;
+	int err;
+
+	err = sg_alloc_table_from_pages(&surf->sgt, surf->pages,
+					surf->num_pages, 0, surf->size,
+					GFP_KERNEL);
+	if (err) {
+		dev_err(isp->dev, "failed to alloc sgt from pages\n");
+		return err;
+	}
+
+	size = iommu_map_sgtable(isp->domain, surf->iova, &surf->sgt,
+				 IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
+	if (size < surf->size) {
+		dev_err(isp->dev, "failed to iommu_map sgt to iova 0x%llx\n",
+			surf->iova);
+		sg_free_table(&surf->sgt);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static void __isp_surf_init(struct apple_isp *isp, struct isp_surf *surf,
+			    u64 size, bool gc)
+{
+	surf->mm = NULL;
+	surf->virt = NULL;
+	surf->size = ALIGN(size, 1UL << isp->shift);
+	surf->num_pages = surf->size >> isp->shift;
+	surf->gc = gc;
+}
+
+struct isp_surf *__apple_isp_alloc_surface(struct apple_isp *isp, u64 size, bool gc)
+{
+	struct isp_surf *surf;
+	int err;
+
+	surf = kzalloc(sizeof(struct isp_surf), GFP_KERNEL);
+	if (!surf)
+		return NULL;
+
+	__isp_surf_init(isp, surf, size, gc);
+
+	err = isp_surf_alloc_pages(surf);
+	if (err) {
+		dev_err(isp->dev, "failed to allocate %d pages\n",
+			surf->num_pages);
+		goto free_surf;
+	}
+
+	err = isp_surf_reserve_iova(isp, surf);
+	if (err) {
+		dev_err(isp->dev, "failed to reserve 0x%llx of iova space\n",
+			surf->size);
+		goto free_pages;
+	}
+
+	err = isp_surf_iommu_map(isp, surf);
+	if (err) {
+		dev_err(isp->dev,
+			"failed to iommu_map size 0x%llx to iova 0x%llx\n",
+			surf->size, surf->iova);
+		goto unreserve_iova;
+	}
+
+	refcount_set(&surf->refcount, 1);
+	if (surf->gc)
+		list_add_tail(&surf->head, &isp->gc);
+
+	return surf;
+
+unreserve_iova:
+	isp_surf_unreserve_iova(isp, surf);
+free_pages:
+	isp_surf_free_pages(surf);
+free_surf:
+	kfree(surf);
+	return NULL;
+}
+
+struct isp_surf *apple_isp_alloc_surface_vmap(struct apple_isp *isp, u64 size)
+{
+	struct isp_surf *surf;
+	int err;
+
+	surf = __apple_isp_alloc_surface(isp, size, false);
+	if (!surf)
+		return NULL;
+
+	err = apple_isp_surf_vmap(isp, surf);
+	if (err) {
+		dev_err(isp->dev, "failed to vmap iova 0x%llx - 0x%llx\n",
+			surf->iova, surf->iova + surf->size);
+		apple_isp_free_surface(isp, surf);
+		return NULL;
+	}
+
+	return surf;
+}
+
+void apple_isp_free_surface(struct apple_isp *isp, struct isp_surf *surf)
+{
+	if (refcount_dec_and_test(&surf->refcount)) {
+		isp_surf_vunmap(isp, surf);
+		isp_surf_iommu_unmap(isp, surf);
+		isp_surf_unreserve_iova(isp, surf);
+		isp_surf_free_pages(surf);
+		if (surf->gc)
+			list_del(&surf->head);
+		kfree(surf);
+	}
+}
+
+int apple_isp_iommu_map_sgt(struct apple_isp *isp, struct isp_surf *surf,
+			    struct sg_table *sgt, u64 size)
+{
+	int err;
+	ssize_t mapped;
+
+	surf->mm = NULL;
+	surf->size = size;
+
+	err = isp_surf_reserve_iova(isp, surf);
+	if (err) {
+		dev_err(isp->dev, "failed to reserve 0x%llx of iova space\n",
+			surf->size);
+		return err;
+	}
+
+	mapped = iommu_map_sgtable(isp->domain, surf->iova, sgt,
+				   IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
+	if (mapped < surf->size) {
+		dev_err(isp->dev, "failed to iommu_map sgt to iova 0x%llx\n",
+			surf->iova);
+		isp_surf_unreserve_iova(isp, surf);
+		return -ENXIO;
+	}
+	surf->size = mapped;
+
+	return 0;
+}
+
+void apple_isp_iommu_unmap_sgt(struct apple_isp *isp, struct isp_surf *surf)
+{
+	iommu_unmap(isp->domain, surf->iova, surf->size);
+	isp_surf_unreserve_iova(isp, surf);
+}
diff --git a/drivers/media/platform/apple/isp/isp-iommu.h b/drivers/media/platform/apple/isp/isp-iommu.h
new file mode 100644
index 0000000000000000000000000000000000000000..4a4afe7ccd0c8c61fb614fdcb8871335e71f3b2c
--- /dev/null
+++ b/drivers/media/platform/apple/isp/isp-iommu.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2023 Eileen Yoon <eyn@gmx.com> */
+
+#ifndef __ISP_IOMMU_H__
+#define __ISP_IOMMU_H__
+
+#include "isp-drv.h"
+
+struct isp_surf *__apple_isp_alloc_surface(struct apple_isp *isp, u64 size, bool gc);
+#define isp_alloc_surface(isp, size)	(__apple_isp_alloc_surface(isp, size, false))
+#define isp_alloc_surface_gc(isp, size) (__apple_isp_alloc_surface(isp, size, true))
+struct isp_surf *apple_isp_alloc_surface_vmap(struct apple_isp *isp, u64 size);
+int apple_isp_surf_vmap(struct apple_isp *isp, struct isp_surf *surf);
+void apple_isp_free_surface(struct apple_isp *isp, struct isp_surf *surf);
+
+int apple_isp_iommu_map_sgt(struct apple_isp *isp, struct isp_surf *surf,
+			    struct sg_table *sgt, u64 size);
+void apple_isp_iommu_unmap_sgt(struct apple_isp *isp, struct isp_surf *surf);
+
+#endif /* __ISP_IOMMU_H__ */
diff --git a/drivers/media/platform/apple/isp/isp-ipc.c b/drivers/media/platform/apple/isp/isp-ipc.c
new file mode 100644
index 0000000000000000000000000000000000000000..e32c16d97556be4aab4571d531ed16b12636db78
--- /dev/null
+++ b/drivers/media/platform/apple/isp/isp-ipc.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright 2023 Eileen Yoon <eyn@gmx.com> */
+
+#include "isp-iommu.h"
+#include "isp-ipc.h"
+#include "isp-regs.h"
+#include "isp-fw.h"
+
+#define ISP_IPC_FLAG_TERMINAL_ACK	0x3
+#define ISP_IPC_BUFEXC_STAT_META_OFFSET 0x10
+
+struct isp_sm_deferred_work {
+	struct work_struct work;
+	struct apple_isp *isp;
+	struct isp_surf *surf;
+};
+
+struct isp_bufexc_stat {
+	u64 unk_0; /* 2 */
+	u64 unk_8; /* 2 */
+
+	u64 meta_iova;
+	u64 pad_20[3];
+	u64 meta_size; /* 0x4640 */
+	u64 unk_38;
+
+	u32 unk_40; /* 1 */
+	u32 unk_44;
+	u64 unk_48;
+
+	u64 iova0;
+	u64 iova1;
+	u64 iova2;
+	u64 iova3;
+	u32 pad_70[4];
+
+	u32 unk_80; /* 2 */
+	u32 unk_84; /* 1 */
+	u32 unk_88; /* 0x10 || 0x13 */
+	u32 unk_8c;
+	u32 pad_90[96];
+
+	u32 unk_210; /* 0x28 */
+	u32 unk_214;
+	u32 index;
+	u16 bes_width; /* 1296, 0x510 */
+	u16 bes_height; /* 736, 0x2e0 */
+
+	u32 unk_220; /* 0x0 || 0x1 */
+	u32 pad_224[3];
+	u32 unk_230; /* 0xf7ed38 */
+	u32 unk_234; /* 3 */
+	u32 pad_238[2];
+	u32 pad_240[16];
+} __packed;
+static_assert(sizeof(struct isp_bufexc_stat) == ISP_IPC_BUFEXC_STAT_SIZE);
+
+static inline void *chan_msg_virt(struct isp_channel *chan, u32 index)
+{
+	return chan->virt + (index * ISP_IPC_MESSAGE_SIZE);
+}
+
+static inline void chan_read_msg_index(struct apple_isp *isp,
+				       struct isp_channel *chan,
+				       struct isp_message *msg, u32 index)
+{
+	memcpy(msg, chan_msg_virt(chan, index), sizeof(*msg));
+}
+
+static inline void chan_read_msg(struct apple_isp *isp,
+				 struct isp_channel *chan,
+				 struct isp_message *msg)
+{
+	chan_read_msg_index(isp, chan, msg, chan->cursor);
+}
+
+static inline void chan_write_msg_index(struct apple_isp *isp,
+					struct isp_channel *chan,
+					struct isp_message *msg, u32 index)
+{
+	u64 *p0;
+
+	p0 = chan_msg_virt(chan, index);
+	memcpy(p0 + 1, &msg->arg1, sizeof(*msg) - 8);
+
+	/* Make sure we write arg0 last, since that indicates message validity. */
+	dma_wmb();
+	*p0 = msg->arg0;
+	dma_wmb();
+}
+
+static inline void chan_write_msg(struct apple_isp *isp,
+				  struct isp_channel *chan,
+				  struct isp_message *msg)
+{
+	chan_write_msg_index(isp, chan, msg, chan->cursor);
+}
+
+static inline void chan_update_cursor(struct isp_channel *chan)
+{
+	if (chan->cursor >= (chan->num - 1))
+		chan->cursor = 0;
+	else
+		chan->cursor += 1;
+}
+
+static int chan_handle_once(struct apple_isp *isp, struct isp_channel *chan)
+{
+	int err;
+
+	lockdep_assert_held(&chan->lock);
+
+	err = chan->ops->handle(isp, chan);
+	if (err) {
+		dev_err(isp->dev, "%s: handler failed: %d)\n", chan->name, err);
+		return err;
+	}
+
+	chan_write_msg(isp, chan, &chan->rsp);
+
+	isp_mbox2_write32(isp, ISP_MBOX2_IRQ_DOORBELL, chan->doorbell);
+
+	chan_update_cursor(chan);
+
+	return 0;
+}
+
+static inline bool chan_rx_done(struct apple_isp *isp, struct isp_channel *chan)
+{
+	if (((chan->req.arg0 & 0xf) == ISP_IPC_FLAG_ACK) ||
+	    ((chan->req.arg0 & 0xf) == ISP_IPC_FLAG_TERMINAL_ACK)) {
+		return true;
+	}
+	return false;
+}
+
+int apple_isp_ipc_chan_handle(struct apple_isp *isp, struct isp_channel *chan)
+{
+	int err = 0;
+
+	mutex_lock(&chan->lock);
+	while (1) {
+		chan_read_msg(isp, chan, &chan->req);
+		if (chan_rx_done(isp, chan)) {
+			err = 0;
+			break;
+		}
+		err = chan_handle_once(isp, chan);
+		if (err)
+			break;
+	}
+	mutex_unlock(&chan->lock);
+
+	return err;
+}
+
+static inline bool chan_tx_done(struct apple_isp *isp, struct isp_channel *chan)
+{
+	dma_rmb();
+
+	chan_read_msg(isp, chan, &chan->rsp);
+	if ((chan->rsp.arg0) == (chan->req.arg0 | ISP_IPC_FLAG_ACK)) {
+		chan_update_cursor(chan);
+		return true;
+	}
+	return false;
+}
+
+int apple_isp_ipc_chan_send(struct apple_isp *isp, struct isp_channel *chan,
+			    unsigned long timeout)
+{
+	long t;
+
+	chan_write_msg(isp, chan, &chan->req);
+	dma_wmb();
+
+	isp_mbox2_write32(isp, ISP_MBOX2_IRQ_DOORBELL, chan->doorbell);
+
+	if (!timeout)
+		return 0;
+
+	t = wait_event_timeout(isp->wait, chan_tx_done(isp, chan), timeout);
+	if (t == 0) {
+		dev_err(isp->dev,
+			"%s: timed out on request [0x%llx, 0x%llx, 0x%llx]\n",
+			chan->name, chan->req.arg0, chan->req.arg1,
+			chan->req.arg2);
+		return -ETIME;
+	}
+
+	isp_dbg(isp, "%s: request success (%ld)\n", chan->name, t);
+
+	return 0;
+}
+
+int apple_isp_ipc_tm_handle(struct apple_isp *isp, struct isp_channel *chan)
+{
+	struct isp_message *rsp = &chan->rsp;
+
+	rsp->arg0 = ISP_IPC_FLAG_ACK;
+	rsp->arg1 = 0x0;
+	rsp->arg2 = 0x0;
+
+	return 0;
+}
+
+int apple_isp_ipc_sm_handle(struct apple_isp *isp, struct isp_channel *chan)
+{
+	struct isp_message *req = &chan->req, *rsp = &chan->rsp;
+	int err;
+
+	if (req->arg0 == 0x0) {
+		struct isp_sm_deferred_work *dwork;
+		struct isp_surf *surf;
+
+		surf = isp_alloc_surface_gc(isp, req->arg1);
+		if (!surf) {
+			isp_err(isp, "failed to alloc requested size 0x%llx\n",
+				req->arg1);
+			kfree(dwork);
+			return -ENOMEM;
+		}
+		surf->type = req->arg2;
+
+		rsp->arg0 = surf->iova | ISP_IPC_FLAG_ACK;
+		rsp->arg1 = 0x0;
+		rsp->arg2 = 0x0; /* macOS uses this to index surfaces */
+
+		switch (surf->type) {
+		case 0x4c4f47: /* "LOG" */
+			isp->log_surf = surf;
+			break;
+		case 0x4d495343: /* "MISC" */
+			if (surf->size == 0xc000)
+				isp->bt_surf = surf;
+			break;
+		default:
+			/* skip vmap */
+			return 0;
+		}
+
+		err = apple_isp_surf_vmap(isp, surf);
+		if (err)
+			isp_err(isp, "failed to vmap iova=0x%llx size=0x%llx\n",
+				surf->iova, surf->size);
+	} else {
+		/* This should be the shared surface free request, but
+		 * 1) The fw doesn't request to free all of what it requested
+		 * 2) The fw continues to access the surface after
+		 * So we link it to the gc, which runs after fw shutdown
+		 */
+		rsp->arg0 = req->arg0 | ISP_IPC_FLAG_ACK;
+		rsp->arg1 = 0x0;
+		rsp->arg2 = 0x0;
+	}
+
+	return 0;
+}
diff --git a/drivers/media/platform/apple/isp/isp-ipc.h b/drivers/media/platform/apple/isp/isp-ipc.h
new file mode 100644
index 0000000000000000000000000000000000000000..e3418a4eb6f73764642ec97aa65bc725a4247568
--- /dev/null
+++ b/drivers/media/platform/apple/isp/isp-ipc.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2023 Eileen Yoon <eyn@gmx.com> */
+
+#ifndef __ISP_IPC_H__
+#define __ISP_IPC_H__
+
+#include "isp-drv.h"
+
+#define ISP_IPC_CHAN_TYPE_COMMAND   0
+#define ISP_IPC_CHAN_TYPE_REPLY	    1
+#define ISP_IPC_CHAN_TYPE_REPORT    2
+
+#define ISP_IPC_BUFEXC_STAT_SIZE    0x280
+#define ISP_IPC_BUFEXC_FLAG_RENDER  0x10000000
+#define ISP_IPC_BUFEXC_FLAG_COMMAND 0x30000000
+#define ISP_IPC_BUFEXC_FLAG_ACK	    0x80000000
+
+int apple_isp_ipc_chan_handle(struct apple_isp *isp, struct isp_channel *chan);
+int apple_isp_ipc_chan_send(struct apple_isp *isp, struct isp_channel *chan,
+			    unsigned long timeout);
+
+int apple_isp_ipc_tm_handle(struct apple_isp *isp, struct isp_channel *chan);
+int apple_isp_ipc_sm_handle(struct apple_isp *isp, struct isp_channel *chan);
+
+#endif /* __ISP_IPC_H__ */
diff --git a/drivers/media/platform/apple/isp/isp-regs.h b/drivers/media/platform/apple/isp/isp-regs.h
new file mode 100644
index 0000000000000000000000000000000000000000..c040dc19954382caf66912189c9e132209461858
--- /dev/null
+++ b/drivers/media/platform/apple/isp/isp-regs.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2023 Eileen Yoon <eyn@gmx.com> */
+
+#ifndef __ISP_REGS_H__
+#define __ISP_REGS_H__
+
+#include "isp-drv.h"
+
+#define ISP_COPROC_FABRIC_0    0x738
+#define ISP_COPROC_FABRIC_1    0x798
+#define ISP_COPROC_FABRIC_2    0x7f8
+#define ISP_COPROC_FABRIC_3    0x858
+
+#define ISP_COPROC_RVBAR       0x1050000
+#define ISP_COPROC_EDPRCR      0x1010310
+#define ISP_COPROC_CONTROL     0x1400044
+#define ISP_COPROC_STATUS      0x1400048
+
+#define ISP_COPROC_IRQ_MASK_0  0x1400a00
+#define ISP_COPROC_IRQ_MASK_1  0x1400a04
+#define ISP_COPROC_IRQ_MASK_2  0x1400a08
+#define ISP_COPROC_IRQ_MASK_3  0x1400a0c
+#define ISP_COPROC_IRQ_MASK_4  0x1400a10
+#define ISP_COPROC_IRQ_MASK_5  0x1400a14
+
+#define ISP_MBOX_IRQ_INTERRUPT 0x00
+#define ISP_MBOX_IRQ_ENABLE    0x04
+#define ISP_MBOX2_IRQ_DOORBELL 0x00
+#define ISP_MBOX2_IRQ_ACK      0x0c
+
+#define ISP_GPIO_0	       0x00
+#define ISP_GPIO_1	       0x04
+#define ISP_GPIO_2	       0x08
+#define ISP_GPIO_3	       0x0c
+#define ISP_GPIO_4	       0x10
+#define ISP_GPIO_5	       0x14
+#define ISP_GPIO_6	       0x18
+#define ISP_GPIO_7	       0x1c
+#define ISP_GPIO_CLOCK_EN      0x20
+
+static inline u32 isp_mbox_read32(struct apple_isp *isp, u32 reg)
+{
+	return readl(isp->mbox + reg);
+}
+
+static inline void isp_mbox_write32(struct apple_isp *isp, u32 reg, u32 val)
+{
+	writel(val, isp->mbox + reg);
+}
+
+static inline void isp_mbox2_write32(struct apple_isp *isp, u32 reg, u32 val)
+{
+	writel(val, isp->mbox2 + reg);
+}
+
+#endif /* __ISP_REGS_H__ */
diff --git a/drivers/media/platform/apple/isp/isp-v4l2.c b/drivers/media/platform/apple/isp/isp-v4l2.c
new file mode 100644
index 0000000000000000000000000000000000000000..5e82e8b9cb480bb2a61ca620a563e7d25a1b0324
--- /dev/null
+++ b/drivers/media/platform/apple/isp/isp-v4l2.c
@@ -0,0 +1,900 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright 2023 Eileen Yoon <eyn@gmx.com> */
+
+#include <linux/module.h>
+
+#include <media/media-device.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-mc.h>
+#include <media/videobuf2-dma-sg.h>
+
+#include "isp-cam.h"
+#include "isp-cmd.h"
+#include "isp-iommu.h"
+#include "isp-ipc.h"
+#include "isp-fw.h"
+#include "isp-v4l2.h"
+
+#define ISP_MIN_FRAMES 2
+#define ISP_MAX_PLANES 4
+#define ISP_MAX_PIX_FORMATS 2
+#define ISP_BUFFER_TIMEOUT msecs_to_jiffies(1500)
+#define ISP_STRIDE_ALIGNMENT 64
+
+static bool multiplanar;
+module_param(multiplanar, bool, 0644);
+MODULE_PARM_DESC(multiplanar, "Enable multiplanar API");
+
+struct isp_buflist_buffer {
+	u64 iovas[ISP_MAX_PLANES];
+	u32 flags[ISP_MAX_PLANES];
+	u32 num_planes;
+	u32 pool_type;
+	u32 tag;
+	u32 pad;
+} __packed;
+static_assert(sizeof(struct isp_buflist_buffer) == 0x40);
+
+struct isp_buflist {
+	u64 type;
+	u64 num_buffers;
+	struct isp_buflist_buffer buffers[];
+};
+
+int apple_isp_ipc_bt_handle(struct apple_isp *isp, struct isp_channel *chan)
+{
+	struct isp_message *req = &chan->req, *rsp = &chan->rsp;
+	struct isp_buffer *tmp, *buf;
+	struct isp_buflist *bl;
+	struct isp_surf *meta;
+	struct isp_buflist_buffer *bufd;
+	enum vb2_buffer_state state;
+	u32 count;
+	int err = 0;
+
+	if (req->arg1 < sizeof(struct isp_buflist)) {
+		dev_err(isp->dev, "%s: Bad length 0x%llx\n", chan->name,
+			req->arg1);
+		return -EIO;
+	}
+
+	bl = apple_isp_translate(isp, isp->bt_surf, req->arg0, req->arg1);
+
+	count = bl->num_buffers;
+	if (count > (req->arg1 - sizeof(struct isp_buffer)) /
+			    sizeof(struct isp_buflist_buffer)) {
+		dev_err(isp->dev, "%s: Bad length 0x%llx\n", chan->name,
+			req->arg1);
+		return -EIO;
+	}
+
+	spin_lock(&isp->buf_lock);
+	for (int i = 0; i < count; i++) {
+		bufd = &bl->buffers[i];
+
+		if (bufd->pool_type == 0) {
+			for (int j = 0; j < ARRAY_SIZE(isp->meta_surfs); j++) {
+				meta = isp->meta_surfs[j];
+				if ((u32)bufd->iovas[0] == (u32)meta->iova) {
+					WARN_ON(!meta->submitted);
+					meta->submitted = false;
+				}
+			}
+		} else {
+			list_for_each_entry_safe_reverse(
+				buf, tmp, &isp->bufs_submitted, link) {
+				if ((u32)buf->surfs[0].iova ==
+				    (u32)bufd->iovas[0]) {
+					state = VB2_BUF_STATE_ERROR;
+
+					buf->vb.vb2_buf.timestamp =
+						ktime_get_ns();
+					buf->vb.sequence = isp->sequence++;
+					buf->vb.field = V4L2_FIELD_NONE;
+					if (req->arg2 ==
+					    ISP_IPC_BUFEXC_FLAG_RENDER)
+						state = VB2_BUF_STATE_DONE;
+					vb2_buffer_done(&buf->vb.vb2_buf,
+							state);
+					list_del(&buf->link);
+				}
+			}
+		}
+	}
+	spin_unlock(&isp->buf_lock);
+
+	rsp->arg0 = req->arg0 | ISP_IPC_FLAG_ACK;
+	rsp->arg1 = 0x0;
+	rsp->arg2 = ISP_IPC_BUFEXC_FLAG_ACK;
+
+	return err;
+}
+
+static int isp_submit_buffers(struct apple_isp *isp)
+{
+	struct isp_format *fmt = isp_get_current_format(isp);
+	struct isp_channel *chan = isp->chan_bh;
+	struct isp_message *req = &chan->req;
+	struct isp_buffer *buf, *tmp;
+	struct isp_surf *meta;
+	unsigned long flags;
+	size_t offset;
+	int err;
+
+	struct isp_buflist *bl = isp->cmd_virt;
+	struct isp_buflist_buffer *bufd = &bl->buffers[0];
+
+	bl->type = 1;
+	bl->num_buffers = 0;
+
+	spin_lock_irqsave(&isp->buf_lock, flags);
+	for (int i = 0; i < ARRAY_SIZE(isp->meta_surfs); i++) {
+		meta = isp->meta_surfs[i];
+
+		if (meta->submitted)
+			continue;
+
+		bufd->num_planes = 1;
+		bufd->pool_type = 0;
+		bufd->iovas[0] = meta->iova;
+		bufd->flags[0] = 0x40000000;
+		bufd++;
+		bl->num_buffers++;
+
+		meta->submitted = true;
+	}
+
+	while ((buf = list_first_entry_or_null(&isp->bufs_pending,
+					       struct isp_buffer, link))) {
+		memset(bufd, 0, sizeof(*bufd));
+
+		bufd->num_planes = fmt->num_planes;
+		bufd->pool_type = isp->hw->scl1 ? CISP_POOL_TYPE_RENDERED_SCL1 :
+						  CISP_POOL_TYPE_RENDERED;
+		offset = 0;
+		for (int j = 0; j < fmt->num_planes; j++) {
+			bufd->iovas[j] = buf->surfs[0].iova + offset;
+			bufd->flags[j] = 0x40000000;
+			offset += fmt->plane_size[j];
+		}
+
+		bufd++;
+		bl->num_buffers++;
+
+		/*
+		 * Queue the buffer as submitted and release the lock for now.
+		 * We need to do this before actually submitting to avoid a
+		 * race with the buffer return codepath.
+		 */
+		list_move_tail(&buf->link, &isp->bufs_submitted);
+	}
+
+	spin_unlock_irqrestore(&isp->buf_lock, flags);
+
+	req->arg0 = isp->cmd_iova;
+	req->arg1 = max_t(u64, ISP_IPC_BUFEXC_STAT_SIZE,
+			  ((uintptr_t)bufd - (uintptr_t)bl));
+	req->arg2 = ISP_IPC_BUFEXC_FLAG_COMMAND;
+
+	err = apple_isp_ipc_chan_send(isp, chan, ISP_BUFFER_TIMEOUT);
+	if (err) {
+		/* If we fail, consider the buffer not submitted. */
+		dev_err(isp->dev,
+			"%s: failed to send bufs: [0x%llx, 0x%llx, 0x%llx]\n",
+			chan->name, req->arg0, req->arg1, req->arg2);
+
+		/*
+		 * Try to find the buffer in the list, and if it's
+		 * still there, move it back to the pending list.
+		 */
+		spin_lock_irqsave(&isp->buf_lock, flags);
+
+		bufd = &bl->buffers[0];
+		for (int i = 0; i < bl->num_buffers; i++, bufd++) {
+			list_for_each_entry_safe_reverse(
+				buf, tmp, &isp->bufs_submitted, link) {
+				if (bufd->iovas[0] == buf->surfs[0].iova) {
+					list_move_tail(&buf->link,
+						       &isp->bufs_pending);
+				}
+			}
+			for (int j = 0; j < ARRAY_SIZE(isp->meta_surfs); j++) {
+				meta = isp->meta_surfs[j];
+				if (bufd->iovas[0] == meta->iova)
+					meta->submitted = false;
+			}
+		}
+
+		spin_unlock_irqrestore(&isp->buf_lock, flags);
+	}
+
+	return err;
+}
+
+/*
+ * Videobuf2 section
+ */
+static int isp_vb2_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
+			       unsigned int *num_planes, unsigned int sizes[],
+			       struct device *alloc_devs[])
+{
+	struct apple_isp *isp = vb2_get_drv_priv(vq);
+	struct isp_format *fmt = isp_get_current_format(isp);
+
+	/* This is not strictly necessary but makes it easy to enforce that
+	 * at most 16 buffers are submitted at once. ISP on t6001 (FW 12.3)
+	 * times out if more buffers are submitted than set in the buffer pool
+	 * config before streaming is started.
+	 */
+	*nbuffers = min_t(unsigned int, *nbuffers, ISP_MAX_BUFFERS);
+
+	if (*num_planes) {
+		if (sizes[0] < fmt->total_size)
+			return -EINVAL;
+
+		return 0;
+	}
+
+	*num_planes = 1;
+	sizes[0] = fmt->total_size;
+
+	return 0;
+}
+
+static void __isp_vb2_buf_cleanup(struct vb2_buffer *vb, unsigned int i)
+{
+	struct apple_isp *isp = vb2_get_drv_priv(vb->vb2_queue);
+	struct isp_buffer *buf =
+		container_of(vb, struct isp_buffer, vb.vb2_buf);
+
+	while (i--)
+		apple_isp_iommu_unmap_sgt(isp, &buf->surfs[i]);
+}
+
+static void isp_vb2_buf_cleanup(struct vb2_buffer *vb)
+{
+	__isp_vb2_buf_cleanup(vb, vb->num_planes);
+}
+
+static int isp_vb2_buf_init(struct vb2_buffer *vb)
+{
+	struct apple_isp *isp = vb2_get_drv_priv(vb->vb2_queue);
+	struct isp_buffer *buf =
+		container_of(vb, struct isp_buffer, vb.vb2_buf);
+	struct sg_table *sgt;
+	unsigned int i;
+	int err;
+
+	for (i = 0; i < vb->num_planes; i++) {
+		sgt = vb2_dma_sg_plane_desc(vb, i);
+		err = apple_isp_iommu_map_sgt(isp, &buf->surfs[i], sgt,
+					      vb2_plane_size(vb, i));
+		if (err)
+			goto cleanup;
+	}
+
+	return 0;
+
+cleanup:
+	__isp_vb2_buf_cleanup(vb, i);
+	return err;
+}
+
+static int isp_vb2_buf_prepare(struct vb2_buffer *vb)
+{
+	struct apple_isp *isp = vb2_get_drv_priv(vb->vb2_queue);
+	struct isp_format *fmt = isp_get_current_format(isp);
+
+	if (vb2_plane_size(vb, 0) < fmt->total_size)
+		return -EINVAL;
+
+	vb2_set_plane_payload(vb, 0, fmt->total_size);
+
+	return 0;
+}
+
+static void isp_vb2_release_buffers(struct apple_isp *isp,
+				    enum vb2_buffer_state state)
+{
+	struct isp_buffer *buf;
+	unsigned long flags;
+
+	spin_lock_irqsave(&isp->buf_lock, flags);
+	list_for_each_entry(buf, &isp->bufs_submitted, link)
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
+	INIT_LIST_HEAD(&isp->bufs_submitted);
+	list_for_each_entry(buf, &isp->bufs_pending, link)
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
+	INIT_LIST_HEAD(&isp->bufs_pending);
+	spin_unlock_irqrestore(&isp->buf_lock, flags);
+}
+
+static void isp_vb2_buf_queue(struct vb2_buffer *vb)
+{
+	struct apple_isp *isp = vb2_get_drv_priv(vb->vb2_queue);
+	struct isp_buffer *buf =
+		container_of(vb, struct isp_buffer, vb.vb2_buf);
+	unsigned long flags;
+	bool empty;
+
+	spin_lock_irqsave(&isp->buf_lock, flags);
+	empty = list_empty(&isp->bufs_pending) &&
+		list_empty(&isp->bufs_submitted);
+	list_add_tail(&buf->link, &isp->bufs_pending);
+	spin_unlock_irqrestore(&isp->buf_lock, flags);
+
+	if (test_bit(ISP_STATE_STREAMING, &isp->state) && !empty)
+		isp_submit_buffers(isp);
+}
+
+static int apple_isp_start_streaming(struct apple_isp *isp)
+{
+	int err;
+
+	err = apple_isp_start_camera(isp);
+	if (err) {
+		dev_err(isp->dev, "failed to start camera: %d\n", err);
+		goto release_buffers;
+	}
+
+	err = isp_submit_buffers(isp);
+	if (err) {
+		dev_err(isp->dev, "failed to send initial batch: %d\n", err);
+		goto stop_camera;
+	}
+
+	err = apple_isp_start_capture(isp);
+	if (err) {
+		dev_err(isp->dev, "failed to start capture: %d\n", err);
+		goto stop_camera;
+	}
+
+	set_bit(ISP_STATE_STREAMING, &isp->state);
+
+	return 0;
+
+stop_camera:
+	apple_isp_stop_camera(isp);
+release_buffers:
+	isp_vb2_release_buffers(isp, VB2_BUF_STATE_QUEUED);
+	return err;
+}
+
+static void apple_isp_stop_streaming(struct apple_isp *isp)
+{
+	clear_bit(ISP_STATE_STREAMING, &isp->state);
+	apple_isp_stop_capture(isp);
+	apple_isp_stop_camera(isp);
+}
+
+static int isp_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
+{
+	struct apple_isp *isp = vb2_get_drv_priv(q);
+
+	isp->sequence = 0;
+
+	return apple_isp_start_streaming(isp);
+}
+
+static void isp_vb2_stop_streaming(struct vb2_queue *q)
+{
+	struct apple_isp *isp = vb2_get_drv_priv(q);
+
+	apple_isp_stop_streaming(isp);
+	isp_vb2_release_buffers(isp, VB2_BUF_STATE_ERROR);
+}
+
+int apple_isp_video_suspend(struct apple_isp *isp)
+{
+	/* Swap into STATE_SLEEPING as isp_vb2_buf_queue() submits on
+	 * STATE_STREAMING.
+	 */
+	if (test_bit(ISP_STATE_STREAMING, &isp->state)) {
+		/* Signal buffers to be recycled for clean shutdown */
+		isp_vb2_release_buffers(isp, VB2_BUF_STATE_QUEUED);
+		apple_isp_stop_streaming(isp);
+		set_bit(ISP_STATE_SLEEPING, &isp->state);
+	}
+
+	return 0;
+}
+
+int apple_isp_video_resume(struct apple_isp *isp)
+{
+	if (test_bit(ISP_STATE_SLEEPING, &isp->state)) {
+		clear_bit(ISP_STATE_SLEEPING, &isp->state);
+		apple_isp_start_streaming(isp);
+	}
+
+	return 0;
+}
+
+static const struct vb2_ops isp_vb2_ops = {
+	.queue_setup = isp_vb2_queue_setup,
+	.buf_init = isp_vb2_buf_init,
+	.buf_cleanup = isp_vb2_buf_cleanup,
+	.buf_prepare = isp_vb2_buf_prepare,
+	.buf_queue = isp_vb2_buf_queue,
+	.start_streaming = isp_vb2_start_streaming,
+	.stop_streaming = isp_vb2_stop_streaming,
+	.wait_prepare = vb2_ops_wait_prepare,
+	.wait_finish = vb2_ops_wait_finish,
+};
+
+static int isp_set_preset(struct apple_isp *isp, struct isp_format *fmt,
+			  struct isp_preset *preset)
+{
+	int i;
+	size_t total_size;
+
+	fmt->preset = preset;
+
+	fmt->num_planes = 2;
+	fmt->strides[0] = ALIGN(preset->output_dim.x, ISP_STRIDE_ALIGNMENT);
+	/* UV subsampled interleaved */
+	fmt->strides[1] = ALIGN(preset->output_dim.x, ISP_STRIDE_ALIGNMENT);
+	fmt->plane_size[0] = fmt->strides[0] * preset->output_dim.y;
+	fmt->plane_size[1] = fmt->strides[1] * preset->output_dim.y / 2;
+
+	total_size = 0;
+	for (i = 0; i < fmt->num_planes; i++)
+		total_size += fmt->plane_size[i];
+	fmt->total_size = total_size;
+
+	return 0;
+}
+
+static struct isp_preset *isp_select_preset(struct apple_isp *isp, u32 width,
+				     u32 height)
+{
+	struct isp_preset *preset, *best = &isp->presets[0];
+	int i, score, best_score = INT_MAX;
+
+	/* Default if no dimensions */
+	if (width == 0 || height == 0)
+		return &isp->presets[0];
+
+	for (i = 0; i < isp->num_presets; i++) {
+		preset = &isp->presets[i];
+		score = abs((int)preset->output_dim.x - (int)width) +
+		abs((int)preset->output_dim.y - (int)height);
+		if (score < best_score) {
+			best = preset;
+			best_score = score;
+		}
+	}
+
+	return best;
+}
+
+/*
+ * V4L2 ioctl section
+ */
+static int isp_vidioc_querycap(struct file *file, void *priv,
+			       struct v4l2_capability *cap)
+{
+	strscpy(cap->card, APPLE_ISP_CARD_NAME, sizeof(cap->card));
+	strscpy(cap->driver, APPLE_ISP_DEVICE_NAME, sizeof(cap->driver));
+
+	return 0;
+}
+
+static int isp_vidioc_enum_format(struct file *file, void *fh,
+				  struct v4l2_fmtdesc *f)
+{
+	struct apple_isp *isp = video_drvdata(file);
+
+	if (f->index >= ISP_MAX_PIX_FORMATS)
+		return -EINVAL;
+
+	switch (f->index) {
+	case 0:
+		f->pixelformat = V4L2_PIX_FMT_NV12;
+		break;
+	case 1:
+		if (!isp->multiplanar)
+			return -EINVAL;
+		f->pixelformat = V4L2_PIX_FMT_NV12M;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int isp_vidioc_enum_framesizes(struct file *file, void *fh,
+				      struct v4l2_frmsizeenum *f)
+{
+	struct apple_isp *isp = video_drvdata(file);
+
+	if (f->index >= isp->num_presets)
+		return -EINVAL;
+
+	if ((f->pixel_format != V4L2_PIX_FMT_NV12) &&
+	    (f->pixel_format != V4L2_PIX_FMT_NV12M))
+		return -EINVAL;
+
+	f->discrete.width = isp->presets[f->index].output_dim.x;
+	f->discrete.height = isp->presets[f->index].output_dim.y;
+	f->type = V4L2_FRMSIZE_TYPE_DISCRETE;
+
+	return 0;
+}
+
+static int isp_vidioc_enum_frameintervals(struct file *filp, void *priv,
+					  struct v4l2_frmivalenum *interval)
+{
+	if (interval->index != 0)
+		return -EINVAL;
+
+	interval->type = V4L2_FRMIVAL_TYPE_DISCRETE;
+	interval->discrete.numerator = 1;
+	interval->discrete.denominator = 30;
+	return 0;
+}
+
+static inline void isp_get_sp_pix_format(struct apple_isp *isp,
+					 struct v4l2_format *f,
+					 struct isp_format *fmt)
+{
+	f->fmt.pix.width = fmt->preset->output_dim.x;
+	f->fmt.pix.height = fmt->preset->output_dim.y;
+	f->fmt.pix.bytesperline = fmt->strides[0];
+	f->fmt.pix.sizeimage = fmt->total_size;
+
+	f->fmt.pix.field = V4L2_FIELD_NONE;
+	f->fmt.pix.pixelformat = V4L2_PIX_FMT_NV12;
+	f->fmt.pix.colorspace = V4L2_COLORSPACE_REC709;
+	f->fmt.pix.ycbcr_enc = V4L2_YCBCR_ENC_709;
+	f->fmt.pix.xfer_func = V4L2_XFER_FUNC_709;
+}
+
+static inline void isp_get_mp_pix_format(struct apple_isp *isp,
+					 struct v4l2_format *f,
+					 struct isp_format *fmt)
+{
+	f->fmt.pix_mp.width = fmt->preset->output_dim.x;
+	f->fmt.pix_mp.height = fmt->preset->output_dim.y;
+	f->fmt.pix_mp.num_planes = fmt->num_planes;
+	for (int i = 0; i < fmt->num_planes; i++) {
+		f->fmt.pix_mp.plane_fmt[i].sizeimage = fmt->plane_size[i];
+		f->fmt.pix_mp.plane_fmt[i].bytesperline = fmt->strides[i];
+	}
+
+	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
+	f->fmt.pix_mp.pixelformat = V4L2_PIX_FMT_NV12M;
+	f->fmt.pix_mp.colorspace = V4L2_COLORSPACE_REC709;
+	f->fmt.pix_mp.ycbcr_enc = V4L2_YCBCR_ENC_709;
+	f->fmt.pix_mp.xfer_func = V4L2_XFER_FUNC_709;
+}
+
+static int isp_vidioc_get_format(struct file *file, void *fh,
+				 struct v4l2_format *f)
+{
+	struct apple_isp *isp = video_drvdata(file);
+	struct isp_format *fmt = isp_get_current_format(isp);
+
+	isp_get_sp_pix_format(isp, f, fmt);
+
+	return 0;
+}
+
+static int isp_vidioc_set_format(struct file *file, void *fh,
+				 struct v4l2_format *f)
+{
+	struct apple_isp *isp = video_drvdata(file);
+	struct isp_format *fmt = isp_get_current_format(isp);
+	struct isp_preset *preset;
+	int err;
+
+	preset = isp_select_preset(isp, f->fmt.pix.width, f->fmt.pix.height);
+	err = isp_set_preset(isp, fmt, preset);
+	if (err)
+		return err;
+
+	isp_get_sp_pix_format(isp, f, fmt);
+
+	isp->vbq.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+
+	return 0;
+}
+
+static int isp_vidioc_try_format(struct file *file, void *fh,
+				 struct v4l2_format *f)
+{
+	struct apple_isp *isp = video_drvdata(file);
+	struct isp_format fmt = *isp_get_current_format(isp);
+	struct isp_preset *preset;
+	int err;
+
+	preset = isp_select_preset(isp, f->fmt.pix.width, f->fmt.pix.height);
+	err = isp_set_preset(isp, &fmt, preset);
+	if (err)
+		return err;
+
+	isp_get_sp_pix_format(isp, f, &fmt);
+
+	return 0;
+}
+
+static int isp_vidioc_get_format_mplane(struct file *file, void *fh,
+					struct v4l2_format *f)
+{
+	struct apple_isp *isp = video_drvdata(file);
+	struct isp_format *fmt = isp_get_current_format(isp);
+
+	if (!isp->multiplanar)
+		return -ENOTTY;
+
+	isp_get_mp_pix_format(isp, f, fmt);
+
+	return 0;
+}
+
+static int isp_vidioc_set_format_mplane(struct file *file, void *fh,
+					struct v4l2_format *f)
+{
+	struct apple_isp *isp = video_drvdata(file);
+	struct isp_format *fmt = isp_get_current_format(isp);
+	struct isp_preset *preset;
+	int err;
+
+	if (!isp->multiplanar)
+		return -ENOTTY;
+
+	preset = isp_select_preset(isp, f->fmt.pix_mp.width,
+				   f->fmt.pix_mp.height);
+	err = isp_set_preset(isp, fmt, preset);
+	if (err)
+		return err;
+
+	isp_get_mp_pix_format(isp, f, fmt);
+
+	isp->vbq.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+
+	return 0;
+}
+
+static int isp_vidioc_try_format_mplane(struct file *file, void *fh,
+					struct v4l2_format *f)
+{
+	struct apple_isp *isp = video_drvdata(file);
+	struct isp_format fmt = *isp_get_current_format(isp);
+	struct isp_preset *preset;
+	int err;
+
+	if (!isp->multiplanar)
+		return -ENOTTY;
+
+	preset = isp_select_preset(isp, f->fmt.pix_mp.width,
+				   f->fmt.pix_mp.height);
+	err = isp_set_preset(isp, &fmt, preset);
+	if (err)
+		return err;
+
+	isp_get_mp_pix_format(isp, f, &fmt);
+
+	return 0;
+}
+
+static int isp_vidioc_enum_input(struct file *file, void *fh,
+				 struct v4l2_input *inp)
+{
+	if (inp->index)
+		return -EINVAL;
+
+	strscpy(inp->name, APPLE_ISP_DEVICE_NAME, sizeof(inp->name));
+	inp->type = V4L2_INPUT_TYPE_CAMERA;
+
+	return 0;
+}
+
+static int isp_vidioc_get_input(struct file *file, void *fh, unsigned int *i)
+{
+	*i = 0;
+
+	return 0;
+}
+
+static int isp_vidioc_set_input(struct file *file, void *fh, unsigned int i)
+{
+	if (i)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int isp_vidioc_get_param(struct file *file, void *fh,
+				struct v4l2_streamparm *a)
+{
+	struct apple_isp *isp = video_drvdata(file);
+
+	if (a->type != V4L2_BUF_TYPE_VIDEO_CAPTURE &&
+	    (!isp->multiplanar ||
+	     a->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE))
+		return -EINVAL;
+
+	a->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
+	a->parm.capture.readbuffers = ISP_MIN_FRAMES;
+	a->parm.capture.timeperframe.numerator = ISP_FRAME_RATE_NUM;
+	a->parm.capture.timeperframe.denominator = ISP_FRAME_RATE_DEN;
+
+	return 0;
+}
+
+static int isp_vidioc_set_param(struct file *file, void *fh,
+				struct v4l2_streamparm *a)
+{
+	struct apple_isp *isp = video_drvdata(file);
+
+	if (a->type != V4L2_BUF_TYPE_VIDEO_CAPTURE &&
+	    (!isp->multiplanar ||
+	     a->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE))
+		return -EINVAL;
+
+	/* Not supporting frame rate sets. No use. Plus floats. */
+	a->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
+	a->parm.capture.readbuffers = ISP_MIN_FRAMES;
+	a->parm.capture.timeperframe.numerator = ISP_FRAME_RATE_NUM;
+	a->parm.capture.timeperframe.denominator = ISP_FRAME_RATE_DEN;
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops isp_v4l2_ioctl_ops = {
+	.vidioc_querycap = isp_vidioc_querycap,
+
+	.vidioc_enum_fmt_vid_cap = isp_vidioc_enum_format,
+	.vidioc_g_fmt_vid_cap = isp_vidioc_get_format,
+	.vidioc_s_fmt_vid_cap = isp_vidioc_set_format,
+	.vidioc_try_fmt_vid_cap = isp_vidioc_try_format,
+	.vidioc_g_fmt_vid_cap_mplane = isp_vidioc_get_format_mplane,
+	.vidioc_s_fmt_vid_cap_mplane = isp_vidioc_set_format_mplane,
+	.vidioc_try_fmt_vid_cap_mplane = isp_vidioc_try_format_mplane,
+
+	.vidioc_enum_framesizes = isp_vidioc_enum_framesizes,
+	.vidioc_enum_frameintervals = isp_vidioc_enum_frameintervals,
+	.vidioc_enum_input = isp_vidioc_enum_input,
+	.vidioc_g_input = isp_vidioc_get_input,
+	.vidioc_s_input = isp_vidioc_set_input,
+	.vidioc_g_parm = isp_vidioc_get_param,
+	.vidioc_s_parm = isp_vidioc_set_param,
+
+	.vidioc_reqbufs = vb2_ioctl_reqbufs,
+	.vidioc_querybuf = vb2_ioctl_querybuf,
+	.vidioc_create_bufs = vb2_ioctl_create_bufs,
+	.vidioc_qbuf = vb2_ioctl_qbuf,
+	.vidioc_expbuf = vb2_ioctl_expbuf,
+	.vidioc_dqbuf = vb2_ioctl_dqbuf,
+	.vidioc_prepare_buf = vb2_ioctl_prepare_buf,
+	.vidioc_streamon = vb2_ioctl_streamon,
+	.vidioc_streamoff = vb2_ioctl_streamoff,
+};
+
+static const struct v4l2_file_operations isp_v4l2_fops = {
+	.owner = THIS_MODULE,
+	.open = v4l2_fh_open,
+	.release = vb2_fop_release,
+	.read = vb2_fop_read,
+	.poll = vb2_fop_poll,
+	.mmap = vb2_fop_mmap,
+	.unlocked_ioctl = video_ioctl2,
+};
+
+static const struct media_device_ops isp_media_device_ops = {
+	.link_notify = v4l2_pipeline_link_notify,
+};
+
+int apple_isp_setup_video(struct apple_isp *isp)
+{
+	struct video_device *vdev = &isp->vdev;
+	struct vb2_queue *vbq = &isp->vbq;
+	struct isp_format *fmt = isp_get_current_format(isp);
+	int err;
+
+	err = isp_set_preset(isp, fmt, &isp->presets[0]);
+	if (err) {
+		dev_err(isp->dev, "failed to set default preset: %d\n", err);
+		return err;
+	}
+
+	for (int i = 0; i < ARRAY_SIZE(isp->meta_surfs); i++) {
+		isp->meta_surfs[i] =
+			apple_isp_alloc_surface_vmap(isp, isp->hw->meta_size);
+		if (!isp->meta_surfs[i]) {
+			isp_err(isp, "failed to alloc meta surface\n");
+			err = -ENOMEM;
+			goto surf_cleanup;
+		}
+	}
+
+	media_device_init(&isp->mdev);
+	isp->v4l2_dev.mdev = &isp->mdev;
+	isp->mdev.ops = &isp_media_device_ops;
+	isp->mdev.dev = isp->dev;
+	strscpy(isp->mdev.model, APPLE_ISP_DEVICE_NAME,
+		sizeof(isp->mdev.model));
+
+	err = media_device_register(&isp->mdev);
+	if (err) {
+		dev_err(isp->dev, "failed to register media device: %d\n", err);
+		goto media_cleanup;
+	}
+
+	isp->multiplanar = multiplanar;
+
+	err = v4l2_device_register(isp->dev, &isp->v4l2_dev);
+	if (err) {
+		dev_err(isp->dev, "failed to register v4l2 device: %d\n", err);
+		goto media_unregister;
+	}
+
+	vbq->drv_priv = isp;
+	vbq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+	vbq->io_modes = VB2_MMAP;
+	vbq->dev = isp->dev;
+	vbq->ops = &isp_vb2_ops;
+	vbq->mem_ops = &vb2_dma_sg_memops;
+	vbq->buf_struct_size = sizeof(struct isp_buffer);
+	vbq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	vbq->min_queued_buffers = ISP_MIN_FRAMES;
+	vbq->lock = &isp->video_lock;
+
+	err = vb2_queue_init(vbq);
+	if (err) {
+		dev_err(isp->dev, "failed to init vb2 queue: %d\n", err);
+		goto v4l2_unregister;
+	}
+
+	vdev->queue = vbq;
+	vdev->fops = &isp_v4l2_fops;
+	vdev->ioctl_ops = &isp_v4l2_ioctl_ops;
+	vdev->device_caps = V4L2_BUF_TYPE_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
+	if (isp->multiplanar)
+		vdev->device_caps |= V4L2_CAP_VIDEO_CAPTURE_MPLANE;
+	vdev->v4l2_dev = &isp->v4l2_dev;
+	vdev->vfl_type = VFL_TYPE_VIDEO;
+	vdev->vfl_dir = VFL_DIR_RX;
+	vdev->release = video_device_release_empty;
+	vdev->lock = &isp->video_lock;
+	strscpy(vdev->name, APPLE_ISP_DEVICE_NAME, sizeof(vdev->name));
+	video_set_drvdata(vdev, isp);
+
+	err = video_register_device(vdev, VFL_TYPE_VIDEO, 0);
+	if (err) {
+		dev_err(isp->dev, "failed to register video device: %d\n", err);
+		goto v4l2_unregister;
+	}
+
+	return 0;
+
+v4l2_unregister:
+	v4l2_device_unregister(&isp->v4l2_dev);
+media_unregister:
+	media_device_unregister(&isp->mdev);
+media_cleanup:
+	media_device_cleanup(&isp->mdev);
+surf_cleanup:
+	for (int i = 0; i < ARRAY_SIZE(isp->meta_surfs); i++) {
+		if (isp->meta_surfs[i])
+			apple_isp_free_surface(isp, isp->meta_surfs[i]);
+		isp->meta_surfs[i] = NULL;
+	}
+
+	return err;
+}
+
+void apple_isp_remove_video(struct apple_isp *isp)
+{
+	vb2_video_unregister_device(&isp->vdev);
+	v4l2_device_unregister(&isp->v4l2_dev);
+	media_device_unregister(&isp->mdev);
+	media_device_cleanup(&isp->mdev);
+	for (int i = 0; i < ARRAY_SIZE(isp->meta_surfs); i++) {
+		if (isp->meta_surfs[i])
+			apple_isp_free_surface(isp, isp->meta_surfs[i]);
+		isp->meta_surfs[i] = NULL;
+	}
+}
diff --git a/drivers/media/platform/apple/isp/isp-v4l2.h b/drivers/media/platform/apple/isp/isp-v4l2.h
new file mode 100644
index 0000000000000000000000000000000000000000..e41533cd54f79fbb8b991920750a8bb04a09ac1a
--- /dev/null
+++ b/drivers/media/platform/apple/isp/isp-v4l2.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2023 Eileen Yoon <eyn@gmx.com> */
+
+#ifndef __ISP_V4L2_H__
+#define __ISP_V4L2_H__
+
+#include "isp-drv.h"
+
+int apple_isp_setup_video(struct apple_isp *isp);
+void apple_isp_remove_video(struct apple_isp *isp);
+int apple_isp_ipc_bt_handle(struct apple_isp *isp, struct isp_channel *chan);
+
+int apple_isp_video_suspend(struct apple_isp *isp);
+int apple_isp_video_resume(struct apple_isp *isp);
+
+#endif /* __ISP_V4L2_H__ */

-- 
2.48.1



