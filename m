Return-Path: <linux-pm+bounces-22401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5762A3B9C4
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 10:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C919F1888AAC
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 09:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C74E1E5B76;
	Wed, 19 Feb 2025 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bW8yoFMS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB121E4928;
	Wed, 19 Feb 2025 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957226; cv=none; b=RXbVJxPeGClWzI53Tkw8wWgmEYwuEdRP6KWGxu+/PbrGaYwWsFMG5iaEIlYtYSqbGqvMiNP+0GaCQaSfSotfDWHOkypMJ7Gj2IPwzmat5J5yPz7EOG9KOJRhMTpza9VWsuoJ8hydmvxl5CVxWEc3mOJ8x2sQtXcZSjA7HgqSUcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957226; c=relaxed/simple;
	bh=qk9IZco66UBn8C3Vba9yyk9yqB7+Kiosc0nwXq6BBxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hkZ6m2Y37cB5Bl1sQoGhtVgJ47oj/vxgiSc8CDKMStN1b6iEbNyfxirngRDVIoQHwQpjHmOhgNOT1G2qspcKSgc8DK3YgeAldTyoCfW3BH8fOhwWNjOG9SolDBbyq6tA84pUhVkQH0KEVGLMGfnp2uEbDNUF8paF+eESm6MH/Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bW8yoFMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5BC8C4CEEF;
	Wed, 19 Feb 2025 09:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739957225;
	bh=qk9IZco66UBn8C3Vba9yyk9yqB7+Kiosc0nwXq6BBxM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bW8yoFMS83evLGvnhNoYee11OVAQ5y6uoenaJoSfSch7Uulo9S/6JiUx+LLS5j0k+
	 iGMhM0oiUUrZVC+xFVsL5Qca8Dw07kwOn1D18CKNyxwi3saUF3KIBSfblRsewCDDZW
	 JS1QGWRWbGNAbdZJ05/Jrr+wbbDW0XAEnPA1o4hB1nzdBk115wJyXGmuavDHemL4eP
	 wwG1BupxYys8xmwdByU8fBM+WTMYB/Ky0iR2fN1POH+gxKecU06arbmQhYn2Rwq5Wp
	 UsonkW14oZERZtNYAKmsyZdF31m7w15zkeSGlJXJ6CQyGvpFfp3HI+ezIvajuMeNG+
	 6+8B5nuJc6wDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2C8C021AA;
	Wed, 19 Feb 2025 09:27:05 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Wed, 19 Feb 2025 10:27:01 +0100
Subject: [PATCH 5/5] arm64: dts: apple: Add ISP nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-isp-v1-5-6d3e89b67c31@gmail.com>
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
 Janne Grunau <j@jannau.net>, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739957223; l=32393;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=M1l/C577EU61p9d/ygfOHQRhflKDcFrX9DiHp6hGnQY=;
 b=Dg0nSQ/h4VzFouS01v9scgfQH1KwJUwIe7GHoR0l1qvTMO5PGnFNcdgZcSmVEYrTK8Lb/KnnF
 IWcNCOTLvSTCZU2lM4CyQxmA6aTwhg4QSZM1vp9dwEpRWrGbtiZaGZU
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Eileen Yoon <eyn@gmx.com>

Adds device tree entries for the ISP and camera sensors

Signed-off-by: Eileen Yoon <eyn@gmx.com>
Co-developed-by: Janne Grunau <j@jannau.net>
Signed-off-by: Janne Grunau <j@jannau.net>
Co-developed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Hector Martin <marcan@marcan.st>
Co-developed-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 arch/arm64/boot/dts/apple/isp-common.dtsi      |  45 ++++++++++
 arch/arm64/boot/dts/apple/isp-imx248.dtsi      |  62 +++++++++++++
 arch/arm64/boot/dts/apple/isp-imx364.dtsi      |  78 ++++++++++++++++
 arch/arm64/boot/dts/apple/isp-imx558-cfg0.dtsi | 101 +++++++++++++++++++++
 arch/arm64/boot/dts/apple/isp-imx558.dtsi      | 102 +++++++++++++++++++++
 arch/arm64/boot/dts/apple/t600x-die0.dtsi      |  48 ++++++++++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi |   6 ++
 arch/arm64/boot/dts/apple/t600x-pmgr.dtsi      |  81 +++++++++++++++++
 arch/arm64/boot/dts/apple/t8103-j293.dts       |   6 ++
 arch/arm64/boot/dts/apple/t8103-j313.dts       |   6 ++
 arch/arm64/boot/dts/apple/t8103-j456.dts       |   6 ++
 arch/arm64/boot/dts/apple/t8103-j457.dts       |   6 ++
 arch/arm64/boot/dts/apple/t8103-pmgr.dtsi      | 118 +++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8103.dtsi           |  50 +++++++++++
 arch/arm64/boot/dts/apple/t8112-j413.dts       |   7 ++
 arch/arm64/boot/dts/apple/t8112-j493.dts       |   6 ++
 arch/arm64/boot/dts/apple/t8112-pmgr.dtsi      | 118 +++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112.dtsi           |  50 +++++++++++
 18 files changed, 896 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/isp-common.dtsi b/arch/arm64/boot/dts/apple/isp-common.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..beaaab950bef70d7521666ba093f10a57cf1b910
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/isp-common.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Common ISP configuration for Apple silicon platforms.
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/ {
+	aliases {
+		isp = &isp;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		isp_heap: isp-heap {
+			/* Filled in by bootloder */
+			reg = <0 0 0 0>;
+			no-map;
+		};
+	};
+};
+
+&isp {
+	memory-region = <&isp_heap>;
+	status = "okay";
+};
+
+&isp_dart0 {
+	status = "okay";
+};
+
+&isp_dart1 {
+	status = "okay";
+};
+
+&isp_dart2 {
+	status = "okay";
+};
+
+&ps_isp_sys {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/isp-imx248.dtsi b/arch/arm64/boot/dts/apple/isp-imx248.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..1d8a87b8058cfc8d63ccef5874aa7c2c318f9654
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/isp-imx248.dtsi
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * ISP configuration for platforms with IMX248 sensor.
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include "isp-common.dtsi"
+
+&isp {
+	apple,temporal-filter = <0>;
+
+	sensor-presets {
+		/* 1280x720 */
+		preset0 {
+			apple,config-index = <0>;
+			apple,input-size = <1296 736>;
+			apple,output-size = <1280 720>;
+			apple,crop = <8 8 1280 720>;
+		};
+
+		/* 960x720 (4:3) */
+		preset1 {
+			apple,config-index = <0>;
+			apple,input-size = <1296 736>;
+			apple,output-size = <960 720>;
+			apple,crop = <168 8 960 720>;
+		};
+
+		/* 960x540 (16:9) */
+		preset2 {
+			apple,config-index = <0>;
+			apple,input-size = <1296 736>;
+			apple,output-size = <960 540>;
+			apple,crop = <8 8 1280 720>;
+		};
+
+		/* 640x480 (4:3) */
+		preset3 {
+			apple,config-index = <0>;
+			apple,input-size = <1296 736>;
+			apple,output-size = <640 480>;
+			apple,crop = <168 8 960 720>;
+		};
+
+		/* 640x360 (16:9) */
+		preset4 {
+			apple,config-index = <0>;
+			apple,input-size = <1296 736>;
+			apple,output-size = <640 360>;
+			apple,crop = <8 8 1280 720>;
+		};
+
+		/* 320x180 (16:9) */
+		preset5 {
+			apple,config-index = <0>;
+			apple,input-size = <1296 736>;
+			apple,output-size = <320 180>;
+			apple,crop = <8 8 1280 720>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/isp-imx364.dtsi b/arch/arm64/boot/dts/apple/isp-imx364.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..dc52fb22126ffb7370fb4bb9e9a9e04ee3c1b9ae
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/isp-imx364.dtsi
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * ISP configuration for platforms with IMX364 sensor.
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include "isp-common.dtsi"
+
+&isp {
+	apple,temporal-filter = <0>;
+
+	sensor-presets {
+		/* 1920x1080 */
+		preset0 {
+			apple,config-index = <0>;
+			apple,input-size = <1920 1080>;
+			apple,output-size = <1920 1080>;
+			apple,crop = <0 0 1920 1080>;
+		};
+
+		/* 1440x720 (4:3) */
+		preset1 {
+			apple,config-index = <0>;
+			apple,input-size = <1920 1080>;
+			apple,output-size = <1440 1080>;
+			apple,crop = <240 0 1440 1080>;
+		};
+
+		/* 1280x720 (16:9) */
+		preset2 {
+			apple,config-index = <0>;
+			apple,input-size = <1920 1080>;
+			apple,output-size = <1280 720>;
+			apple,crop = <0 0 1920 1080>;
+		};
+
+		/* 960x720 (4:3) */
+		preset3{
+			apple,config-index = <0>;
+			apple,input-size = <1920 1080>;
+			apple,output-size = <960 720>;
+			apple,crop = <240 0 1440 1080>;
+		};
+
+		/* 960x540 (16:9) */
+		preset4 {
+			apple,config-index = <0>;
+			apple,input-size = <1920 1080>;
+			apple,output-size = <960 540>;
+			apple,crop = <0 0 1920 1080>;
+		};
+
+		/* 640x480 (4:3) */
+		preset5 {
+			apple,config-index = <0>;
+			apple,input-size = <1920 1080>;
+			apple,output-size = <640 480>;
+			apple,crop = <240 0 1440 1080>;
+		};
+
+		/* 640x360 (16:9) */
+		preset6 {
+			apple,config-index = <0>;
+			apple,input-size = <1920 1080>;
+			apple,output-size = <640 360>;
+			apple,crop = <0 0 1920 1080>;
+		};
+
+		/* 320x180 (16:9) */
+		preset7 {
+			apple,config-index = <0>;
+			apple,input-size = <1920 1080>;
+			apple,output-size = <320 180>;
+			apple,crop = <0 0 1920 1080>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/isp-imx558-cfg0.dtsi b/arch/arm64/boot/dts/apple/isp-imx558-cfg0.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..83a86a937f41a4589419b051d33f3fae728ffe6e
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/isp-imx558-cfg0.dtsi
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * ISP configuration for platforms with IMX558 sensor in
+ * config #0 mode.
+ *
+ * These platforms enable MLVNR for all configs except
+ * #0, which we don't support. Config #0 is an uncropped
+ * square 1920x1920 sensor, with dark corners.
+ * Therefore, we synthesize common resolutions by using
+ * crop/scale while always choosing config #0.
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include "isp-common.dtsi"
+
+&isp {
+	apple,temporal-filter = <0>;
+
+	sensor-presets {
+		/* 1920x1080 */
+		preset0 {
+			apple,config-index = <0>;
+			apple,input-size = <1920 1920>;
+			apple,output-size = <1920 1080>;
+			apple,crop = <0 420 1920 1080>;
+		};
+
+		/* 1080x1920 */
+		preset1 {
+			apple,config-index = <0>;
+			apple,input-size = <1920 1920>;
+			apple,output-size = <1080 1920>;
+			apple,crop = <420 0 1080 1920>;
+		};
+
+		/* 1920x1440 */
+		preset2 {
+			apple,config-index = <0>;
+			apple,input-size = <1920 1920>;
+			apple,output-size = <1920 1440>;
+			apple,crop = <0 240 1920 1440>;
+		};
+
+		/* 1440x1920 */
+		preset3 {
+			apple,config-index = <0>;
+			apple,input-size = <1920 1920>;
+			apple,output-size = <1440 1920>;
+			apple,crop = <240 0 1440 1920>;
+		};
+
+		/* 1280x720 */
+		preset4 {
+			apple,config-index = <0>;
+			apple,input-size = <1920 1920>;
+			apple,output-size = <1280 720>;
+			apple,crop = <0 420 1920 1080>;
+		};
+
+		/* 720x1280 */
+		preset5 {
+			apple,config-index = <0>;
+			apple,input-size = <1920 1920>;
+			apple,output-size = <720 1280>;
+			apple,crop = <420 0 1080 1920>;
+		};
+
+		/* 1280x960 */
+		preset6 {
+			apple,config-index = <0>;
+			apple,input-size = <1920 1920>;
+			apple,output-size = <1280 960>;
+			apple,crop = <0 240 1920 1440>;
+		};
+
+		/* 960x1280 */
+		preset7 {
+			apple,config-index = <0>;
+			apple,input-size = <1920 1920>;
+			apple,output-size = <960 1280>;
+			apple,crop = <240 0 1440 1920>;
+		};
+
+		/* 640x480 */
+		preset8 {
+			apple,config-index = <0>;
+			apple,input-size = <1920 1920>;
+			apple,output-size = <640 480>;
+			apple,crop = <0 240 1920 1440>;
+		};
+
+		/* 480x640 */
+		preset9 {
+			apple,config-index = <0>;
+			apple,input-size = <1920 1920>;
+			apple,output-size = <480 640>;
+			apple,crop = <240 0 1440 1920>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/isp-imx558.dtsi b/arch/arm64/boot/dts/apple/isp-imx558.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..6eae34a3c2ee4a5dc02c7871462c4cebfc0a9be2
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/isp-imx558.dtsi
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * ISP configuration for platforms with IMX558 sensor.
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include "isp-common.dtsi"
+
+&isp {
+	apple,temporal-filter = <0>;
+
+	sensor-presets {
+		/* 1920x1080 */
+		preset0 {
+			apple,config-index = <1>;
+			apple,input-size = <1920 1080>;
+			apple,output-size = <1920 1080>;
+			apple,crop = <0 0 1920 1080>;
+		};
+
+		/* 1080x1920 */
+		preset1 {
+			apple,config-index = <2>;
+			apple,input-size = <1080 1920>;
+			apple,output-size = <1080 1920>;
+			apple,crop = <0 0 1080 1920>;
+		};
+
+		/* 1760x1328 */
+		preset2 {
+			apple,config-index = <3>;
+			apple,input-size = <1760 1328>;
+			apple,output-size = <1760 1328>;
+			apple,crop = <0 0 1760 1328>;
+		};
+
+		/* 1328x1760 */
+		preset3 {
+			apple,config-index = <4>;
+			apple,input-size = <1328 1760>;
+			apple,output-size = < 1328 1760>;
+			apple,crop = <0 0 1328 1760>;
+		};
+
+		/* 1152x1152 */
+		preset4 {
+			apple,config-index = <5>;
+			apple,input-size = <1152 1152>;
+			apple,output-size = <1152 1152>;
+			apple,crop = <0 0 1152 1152>;
+		};
+
+		/* 1280x720 */
+		preset5 {
+			apple,config-index = <1>;
+			apple,input-size = <1920 1080>;
+			apple,output-size = <1280 720>;
+			apple,crop = <0 0 1920 1080>;
+		};
+
+		/* 720x1280 */
+		preset6 {
+			apple,config-index = <2>;
+			apple,input-size = <1080 1920>;
+			apple,output-size = <720 1280>;
+			apple,crop = <0 0 1080 1920>;
+		};
+
+		/* 1280x960 */
+		preset7 {
+			apple,config-index = <3>;
+			apple,input-size = <1760 1328>;
+			apple,output-size = <1280 960>;
+			apple,crop = <0 4 1760 1320>;
+		};
+
+		/* 960x1280 */
+		preset8 {
+			apple,config-index = <4>;
+			apple,input-size = <1328 1760>;
+			apple,output-size = <960 1280>;
+			apple,crop = <4 0 1320 1760>;
+		};
+
+		/* 640x480 */
+		preset9 {
+			apple,config-index = <3>;
+			apple,input-size = <1760 1328>;
+			apple,output-size = <640 480>;
+			apple,crop = <0 4 1760 1320>;
+		};
+
+		/* 480x640 */
+		preset10 {
+			apple,config-index = <4>;
+			apple,input-size = <1328 1760>;
+			apple,output-size = <480 640>;
+			apple,crop = <4 0 1320 1760>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
index b1c875e692c8fb9c0af46a23568a7b0cd720141b..019484360804ecdd0313638a0694a61693a5729a 100644
--- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
@@ -53,6 +53,54 @@ wdt: watchdog@2922b0000 {
 		interrupts = <AIC_IRQ 0 631 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	isp: isp@384000000 {
+		compatible = "apple,t6000-isp", "apple,isp";
+		reg = <0x3 0x84000000 0x0 0x2000000>,
+			<0x3 0x86104000 0x0 0x100>,
+			<0x3 0x86104170 0x0 0x100>,
+			<0x3 0x861043f0 0x0 0x100>;
+		reg-names = "coproc", "mbox", "gpio", "mbox2";
+		iommus = <&isp_dart0 0>, <&isp_dart1 0>, <&isp_dart2 0>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 538 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&ps_isp_sys>, <&ps_isp_set0>,
+			<&ps_isp_set1>, <&ps_isp_fe>, <&ps_isp_set3>,
+			<&ps_isp_set4>, <&ps_isp_set5>, <&ps_isp_set6>,
+			<&ps_isp_set7>, <&ps_isp_set8>;
+		apple,dart-vm-size = <0x0 0xa0000000>;
+		status = "disabled";
+	};
+
+	isp_dart0: iommu@3860e8000 {
+		compatible = "apple,t6000-dart";
+		reg = <0x3 0x860e8000 0x0 0x4000>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 543 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		power-domains = <&ps_isp_sys>;
+		status = "disabled";
+	};
+
+	isp_dart1: iommu@3860f4000 {
+		compatible = "apple,t6000-dart";
+		reg = <0x3 0x860f4000 0x0 0x4000>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 543 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		power-domains = <&ps_isp_sys>;
+		status = "disabled";
+	};
+
+	isp_dart2: iommu@3860fc000 {
+		compatible = "apple,t6000-dart";
+		reg = <0x3 0x860fc000 0x0 0x4000>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 543 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		power-domains = <&ps_isp_sys>;
+		status = "disabled";
+	};
+
 	sio_dart_0: iommu@39b004000 {
 		compatible = "apple,t6000-dart";
 		reg = <0x3 0x9b004000 0x0 0x4000>;
diff --git a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
index 2e471dfe43cf885c1234d36bf0e0acfdc4904621..416e6ec213c8238f0d3c15298d5e44cb13abaabf 100644
--- a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
@@ -119,3 +119,9 @@ sdhci0: mmc@0,0 {
 &fpwm0 {
 	status = "okay";
 };
+
+#include "isp-imx558.dtsi"
+
+&isp {
+	apple,platform-id = <3>;
+};
diff --git a/arch/arm64/boot/dts/apple/t600x-pmgr.dtsi b/arch/arm64/boot/dts/apple/t600x-pmgr.dtsi
index 0bd44753b76a0c111dc12e6e900bf2f3c07a07ff..1a24e0d20c040fc6225326cd665cf1d1902b7813 100644
--- a/arch/arm64/boot/dts/apple/t600x-pmgr.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-pmgr.dtsi
@@ -1368,6 +1368,7 @@ DIE_NODE(ps_isp_sys): power-controller@3a8 {
 		#reset-cells = <0>;
 		label = DIE_LABEL(isp_sys);
 		power-domains = <&DIE_NODE(ps_afnc2_lw1)>;
+		status = "disabled";
 	};
 
 	DIE_NODE(ps_venc_sys): power-controller@3b0 {
@@ -1456,6 +1457,86 @@ DIE_NODE(ps_venc_me1): power-controller@8020 {
 		label = DIE_LABEL(venc_me1);
 		power-domains = <&DIE_NODE(ps_venc_me0)>;
 	};
+
+	/* There is a dependency tree involved with these PDs,
+	 * but we do not express it here since the ISP driver
+	 * is supposed to sequence them in the right order anyway
+	 * (and we do not know the exact tree structure).
+	 *
+	 * This also works around spurious parent PD activation
+	 * on machines with ISP disabled (desktops).
+	 */
+	DIE_NODE(ps_isp_set0): power-controller@4000 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set0";
+	};
+
+	DIE_NODE(ps_isp_set1): power-controller@4010 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set1";
+	};
+
+	DIE_NODE(ps_isp_fe): power-controller@4008 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set2";
+	};
+
+	DIE_NODE(ps_isp_set3): power-controller@4028 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4028 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set3";
+	};
+
+	DIE_NODE(ps_isp_set4): power-controller@4020 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set4";
+	};
+
+	DIE_NODE(ps_isp_set5): power-controller@4030 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4030 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set5";
+	};
+
+	DIE_NODE(ps_isp_set6): power-controller@4018 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set6";
+	};
+
+	DIE_NODE(ps_isp_set7): power-controller@4038 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4038 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set7";
+	};
+
+	DIE_NODE(ps_isp_set8): power-controller@4040 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4040 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set8";
+	};
 };
 
 &DIE_NODE(pmgr_south) {
diff --git a/arch/arm64/boot/dts/apple/t8103-j293.dts b/arch/arm64/boot/dts/apple/t8103-j293.dts
index 56b0c67bfcda321b60c621de092643017693ff91..cef284f347363d416d375a68dacc7221739f2d75 100644
--- a/arch/arm64/boot/dts/apple/t8103-j293.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j293.dts
@@ -49,3 +49,9 @@ &i2c4 {
 &fpwm1 {
 	status = "okay";
 };
+
+#include "isp-imx248.dtsi"
+
+&isp {
+	apple,platform-id = <1>;
+};
diff --git a/arch/arm64/boot/dts/apple/t8103-j313.dts b/arch/arm64/boot/dts/apple/t8103-j313.dts
index 97a4344d8dca685708aff136af92a1b316f3c3dd..b6899af595f47eaae3e5ff24ba18490dc81377c8 100644
--- a/arch/arm64/boot/dts/apple/t8103-j313.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j313.dts
@@ -41,3 +41,9 @@ &wifi0 {
 &fpwm1 {
 	status = "okay";
 };
+
+#include "isp-imx248.dtsi"
+
+&isp {
+	apple,platform-id = <1>;
+};
diff --git a/arch/arm64/boot/dts/apple/t8103-j456.dts b/arch/arm64/boot/dts/apple/t8103-j456.dts
index 58c8e43789b4861544e20c717124ede3327be010..e54393b4e83c12a233067683c03e9ada2d1fba70 100644
--- a/arch/arm64/boot/dts/apple/t8103-j456.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j456.dts
@@ -75,3 +75,9 @@ &pcie0_dart_1 {
 &pcie0_dart_2 {
 	status = "okay";
 };
+
+#include "isp-imx364.dtsi"
+
+&isp {
+	apple,platform-id = <2>;
+};
diff --git a/arch/arm64/boot/dts/apple/t8103-j457.dts b/arch/arm64/boot/dts/apple/t8103-j457.dts
index 152f95fd49a2118093396838fbd8b6bd1b518f81..7a825eee01f5600fe5eb9a11d59e64d3939edac6 100644
--- a/arch/arm64/boot/dts/apple/t8103-j457.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j457.dts
@@ -48,3 +48,9 @@ ethernet0: ethernet@0,0 {
 &pcie0_dart_2 {
 	status = "okay";
 };
+
+#include "isp-imx364.dtsi"
+
+&isp {
+	apple,platform-id = <2>;
+};
diff --git a/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
index 9645861a858c1a7c46c25a614c2cc4b03083bf46..5761cb260b7f1c1a0657aa99137e451892610ec3 100644
--- a/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
@@ -805,6 +805,7 @@ ps_isp_sys: power-controller@400 {
 		#reset-cells = <0>;
 		label = "isp_sys";
 		power-domains = <&ps_rmx>;
+		status = "disabled";
 	};
 
 	ps_venc_sys: power-controller@408 {
@@ -1003,6 +1004,123 @@ ps_disp0_cpu0: power-controller@10018 {
 		apple,always-on; /* TODO: figure out if we can enable PM here */
 		apple,min-state = <4>;
 	};
+
+	/* There is a dependency tree involved with these PDs,
+	 * but we do not express it here since the ISP driver
+	 * is supposed to sequence them in the right order anyway
+	 * (and we do not know the exact tree structure).
+	 *
+	 * This also works around spurious parent PD activation
+	 * on machines with ISP disabled (desktops).
+	 */
+	ps_isp_set0: power-controller@4000 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set0";
+		apple,force-disable;
+	};
+
+	ps_isp_set1: power-controller@4008 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set1";
+		apple,force-disable;
+		apple,force-reset;
+	};
+
+	ps_isp_set2: power-controller@4010 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set2";
+		apple,force-disable;
+		apple,force-reset;
+	};
+
+	ps_isp_fe: power-controller@4018 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_fe";
+	};
+
+	ps_isp_set4: power-controller@4020 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set4";
+	};
+
+	ps_isp_set5: power-controller@4028 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4028 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set5";
+	};
+
+	ps_isp_set6: power-controller@4030 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4030 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set6";
+	};
+
+	ps_isp_set7: power-controller@4038 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4038 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set7";
+	};
+
+	ps_isp_set8: power-controller@4040 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4040 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set8";
+	};
+
+	ps_isp_set9: power-controller@4048 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4048 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set9";
+	};
+
+	ps_isp_set10: power-controller@4050 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4050 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set10";
+	};
+
+	ps_isp_set11: power-controller@4058 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4058 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set11";
+	};
+
+	ps_isp_set12: power-controller@4060 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4060 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set12";
+	};
 };
 
 &pmgr_mini {
diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 9b0dad6b618444ac6b1c9735c50cccfc3965f947..420fda4a8dba70992c7a55c9ef56142ed39ad68f 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -356,6 +356,56 @@ cpufreq_p: performance-controller@211e20000 {
 			#performance-domain-cells = <0>;
 		};
 
+		isp: isp@22a000000 {
+			compatible = "apple,t8103-isp", "apple,isp";
+			reg = <0x2 0x2a000000 0x0 0x2000000>,
+				<0x2 0x2c104000 0x0 0x100>,
+				<0x2 0x2c104170 0x0 0x100>,
+				<0x2 0x2c1043f0 0x0 0x100>;
+			reg-names = "coproc", "mbox", "gpio", "mbox2";
+			iommus = <&isp_dart0 0>, <&isp_dart1 0>, <&isp_dart2 0>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 246 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&ps_isp_sys>, <&ps_isp_set0>,
+				<&ps_isp_set1>, <&ps_isp_set2>, <&ps_isp_fe>,
+				<&ps_isp_set4>, <&ps_isp_set5>, <&ps_isp_set6>,
+				<&ps_isp_set7>, <&ps_isp_set8>, <&ps_isp_set9>,
+				<&ps_isp_set10>, <&ps_isp_set11>,
+				<&ps_isp_set12>;
+			apple,dart-vm-size = <0x0 0xa0000000>;
+			status = "disabled";
+		};
+
+		isp_dart0: iommu@22c0e8000 {
+			compatible = "apple,t8103-dart";
+			reg = <0x2 0x2c0e8000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 251 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&ps_isp_sys>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		isp_dart1: iommu@22c0f4000 {
+			compatible = "apple,t8103-dart";
+			reg = <0x2 0x2c0f4000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 251 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			power-domains = <&ps_isp_sys>;
+			status = "disabled";
+		};
+
+		isp_dart2: iommu@22c0fc000 {
+			compatible = "apple,t8103-dart";
+			reg = <0x2 0x2c0fc000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 251 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			power-domains = <&ps_isp_sys>;
+			status = "disabled";
+		};
+
 		sio_dart: iommu@235004000 {
 			compatible = "apple,t8103-dart";
 			reg = <0x2 0x35004000 0x0 0x4000>;
diff --git a/arch/arm64/boot/dts/apple/t8112-j413.dts b/arch/arm64/boot/dts/apple/t8112-j413.dts
index 6f69658623bf89ce73e3486bce504f1f5f8003f3..94bf097ff2a343cd6446b97e3391f9faee2fc5f4 100644
--- a/arch/arm64/boot/dts/apple/t8112-j413.dts
+++ b/arch/arm64/boot/dts/apple/t8112-j413.dts
@@ -78,3 +78,10 @@ &i2c4 {
 &fpwm1 {
 	status = "okay";
 };
+
+#include "isp-imx558-cfg0.dtsi"
+
+&isp {
+	apple,platform-id = <14>;
+	apple,temporal-filter = <1>;
+};
diff --git a/arch/arm64/boot/dts/apple/t8112-j493.dts b/arch/arm64/boot/dts/apple/t8112-j493.dts
index 0ad908349f55406783942735a2e9dad54cda00ec..5632bfb939ef8ff4f746c8e61ae0a87b82c646cb 100644
--- a/arch/arm64/boot/dts/apple/t8112-j493.dts
+++ b/arch/arm64/boot/dts/apple/t8112-j493.dts
@@ -67,3 +67,9 @@ &i2c4 {
 &fpwm1 {
 	status = "okay";
 };
+
+#include "isp-imx248.dtsi"
+
+&isp {
+	apple,platform-id = <6>;
+};
diff --git a/arch/arm64/boot/dts/apple/t8112-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8112-pmgr.dtsi
index 7c050c6f2707a1d8128c09b4f58076a1c035adac..7154615b757215a2294f8f1559657ade951aab6c 100644
--- a/arch/arm64/boot/dts/apple/t8112-pmgr.dtsi
+++ b/arch/arm64/boot/dts/apple/t8112-pmgr.dtsi
@@ -818,6 +818,7 @@ ps_isp_sys: power-controller@438 {
 		#reset-cells = <0>;
 		label = "isp_sys";
 		power-domains = <&ps_rmx1>;
+		status = "disabled";
 	};
 
 	ps_venc_sys: power-controller@440 {
@@ -964,6 +965,123 @@ ps_sep: power-controller@c00 {
 		apple,always-on;
 	};
 
+	/* There is a dependency tree involved with these PDs,
+	 * but we do not express it here since the ISP driver
+	 * is supposed to sequence them in the right order anyway
+	 * (and we do not know the exact tree structure).
+	 *
+	 * This also works around spurious parent PD activation
+	 * on machines with ISP disabled (desktops).
+	 */
+	ps_isp_set0: power-controller@4000 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set0";
+		apple,force-disable;
+	};
+
+	ps_isp_set1: power-controller@4008 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set1";
+		apple,force-disable;
+		apple,force-reset;
+	};
+
+	ps_isp_set2: power-controller@4010 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set2";
+		apple,force-disable;
+		apple,force-reset;
+	};
+
+	ps_isp_fe: power-controller@4018 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_fe";
+	};
+
+	ps_isp_set4: power-controller@4020 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set4";
+	};
+
+	ps_isp_set5: power-controller@4028 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4028 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set5";
+	};
+
+	ps_isp_set6: power-controller@4030 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4030 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set6";
+	};
+
+	ps_isp_set7: power-controller@4038 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4038 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set7";
+	};
+
+	ps_isp_set8: power-controller@4040 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4040 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set8";
+	};
+
+	ps_isp_set9: power-controller@4048 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4048 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set9";
+	};
+
+	ps_isp_set12: power-controller@4050 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4050 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set10";
+	};
+
+	ps_isp_set10: power-controller@4058 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4058 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set11";
+	};
+
+	ps_isp_set11: power-controller@4060 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4060 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_set12";
+	};
+
 	ps_venc_dma: power-controller@8000 {
 		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
 		reg = <0x8000 4>;
diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
index 1666e6ab250bc0be9b8318e3c8fc903ccd3f3760..ed1852ac346b0f74d84619147feb7e624e355630 100644
--- a/arch/arm64/boot/dts/apple/t8112.dtsi
+++ b/arch/arm64/boot/dts/apple/t8112.dtsi
@@ -379,6 +379,56 @@ cpufreq_p: cpufreq@211e20000 {
 			#performance-domain-cells = <0>;
 		};
 
+		isp: isp@22a000000 {
+			compatible = "apple,t8112-isp", "apple,isp";
+			reg = <0x2 0x2a000000 0x0 0x2000000>,
+				<0x2 0x2c4c4000 0x0 0x100>,
+				<0x2 0x2c4c41b0 0x0 0x100>,
+				<0x2 0x2c4c4430 0x0 0x100>;
+			reg-names = "coproc", "mbox", "gpio", "mbox2";
+			iommus = <&isp_dart0 0>, <&isp_dart1 0>, <&isp_dart2 0>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 269 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&ps_isp_sys>, <&ps_isp_set0>,
+				<&ps_isp_set1>, <&ps_isp_set2>, <&ps_isp_fe>,
+				<&ps_isp_set4>, <&ps_isp_set5>, <&ps_isp_set6>,
+				<&ps_isp_set7>, <&ps_isp_set8>, <&ps_isp_set9>,
+				<&ps_isp_set10>, <&ps_isp_set11>,
+				<&ps_isp_set12>;
+			apple,dart-vm-size = <0x0 0xa0000000>;
+			status = "disabled";
+		};
+
+		isp_dart0: iommu@22c4a8000 {
+			compatible = "apple,t8110-dart";
+			reg = <0x2 0x2c4a8000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 274 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&ps_isp_sys>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		isp_dart1: iommu@22c4b4000 {
+			compatible = "apple,t8110-dart";
+			reg = <0x2 0x2c4b4000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 274 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&ps_isp_sys>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		isp_dart2: iommu@22c4bc000 {
+			compatible = "apple,t8110-dart";
+			reg = <0x2 0x2c4bc000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 274 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&ps_isp_sys>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
 		sio_dart: iommu@235004000 {
 			compatible = "apple,t8110-dart";
 			reg = <0x2 0x35004000 0x0 0x4000>;

-- 
2.48.1



