Return-Path: <linux-pm+bounces-7541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AB38BD1A8
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 17:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4EE1F23D41
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5D41553A0;
	Mon,  6 May 2024 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="DeLUNc1+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQ9tOp9Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5E315383A;
	Mon,  6 May 2024 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010073; cv=none; b=XeXtElaBAnWOP70oyJR7zkpMU8y/15zjn3o5DyKKw3Om+G700UDeTRXu/EFQxiGSSbkwRWapzGdO8t3Gk9DNLB5z8xB3u1sOCq2nL27g3BIqnP8icfu29/K/wdGb/ySg8eFNBoHSRyxBN308cLsdekoiBHqLU7Xnwk6U/dfNtGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010073; c=relaxed/simple;
	bh=vomKwqZt0R+lkLKOn5x8hJ88w/SPYcaCpnMAws6w6+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcT0NrOYsF8+kb5AJ62O7dPOkzVkpitjeHCc3+wvthtWwZ3mdxoAX/Pxtt1uSResvWz3TbcvCZtkK+Iyuh+mE8+umnI07mO0+FQVly6pKxxdh4nWahIZpmekXoRIIq30hWnG0a9HYOQ+Ell7o5GgOFSqmaYnl/idYWVzTTOXvP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=DeLUNc1+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQ9tOp9Z; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 35C851C0017C;
	Mon,  6 May 2024 11:41:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 06 May 2024 11:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1715010068;
	 x=1715096468; bh=dP0j44dHhI8VsGTOZHFKNW4xZbIJYFFQYbnPMYwl69Q=; b=
	DeLUNc1+T/LYzhuY45qG46dz/HklDnGD0paiLE3YpXhxF4QeewuAshgVKMb5qNm5
	tEAHHxtSd9qri5YwP3iA1T4e0uZdvmAztv1BRQy7pDD8Xtu5ZjYrF8mzaZq+x0GV
	2NmZmh7Ylyvn/0qu2o8u4iCNNQk/zq83KPw0ZRIq/P2vTchRTknPv5pxMTnZoe5X
	HQbtGC1qYy+ObB1hJuz51R1ApoacgSgS24dnWilnKgWA7KUF1VI6sYqD+x4xzxD0
	sAjdkgDb2+wcKWfyBcQZ+3AgFR9VzSo5edCxLLeOfwO5et1oaRnIR5ebBDsn9Fog
	8/f5Eo/srBM1t00Ldi7n/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715010068; x=
	1715096468; bh=dP0j44dHhI8VsGTOZHFKNW4xZbIJYFFQYbnPMYwl69Q=; b=a
	Q9tOp9ZWvjSji3AVsoTzqA4CIrGwshnV5uVJNl+MR0OGu8C151ndc0afqA7667x4
	A50LrFQy1pLTQH+d4k2LtzT5f5uMknIoYdVXM03r4+Af96zwc7xHdJMi9169fo3B
	JeT2fxdFg7JoDn9yBoyQ14ar1LqClDhYk9Av2MJgVTKqPgwWOrJzxczbcNVhu2R7
	68ODdVj8KfdBab4raRn+feQ3YvXCC5W7854e6//jfLBQHQDUAoHgr98WlPQh3xiK
	J7TIfNaPzQgwvkbURtnrq4fp06iEc0RqIRUb8C/JZn7ZxYvjXABf18TdgvVXw6Z0
	mf0EoWCrtRsKbmyRms+4g==
X-ME-Sender: <xms:FPo4ZoZ2EN3EZw79id9Mb1Uv9a6cwzS8bUD-c6wPUBk5S-4iTIsKPg>
    <xme:FPo4Zjb3_KlqxajFtcCkGhaADQWl6MajXvaHRQubP_Zzk8YDbE1rhqqNTQdgy_iqe
    WEXgfAV6vVtm0pRN2o>
X-ME-Received: <xmr:FPo4Zi8e-FfzzC47uwsf8K1WcMtLKj83NIoUvQ-t0qzzxhhPF6ZBO5TZz8KlD4mO-E-ZTWQtdC-oPy2TCj0he94Dd33p36XnEZlV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnh
    gvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeehiefgueev
    uedtfefhheegkeevtdelueeukeevfeduhefhhfejfffggeffleefgeenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggv
    rhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:FPo4ZiqA-jlo143G8Yg7b3uJw98qQi7mGByrpu0ZgB7wZFx8jj7GZQ>
    <xmx:FPo4ZjoSyo0hsR5vAlTozEr0EKSdSFgn8RSZl5GvS4yv78tmTdwt1A>
    <xmx:FPo4ZgR7yIUMBW5EcMTaejzyHXfSPdrzqkfq5n3EqTEAZ-r9-ry09Q>
    <xmx:FPo4ZjqKL2cp7odL8_sRyH6yIsAgpwiR6XKEMPwZw9fdxwGjPhTxDw>
    <xmx:FPo4ZnfwNsuDiq3Z8UITr0ks6KQv8Jcc4EL_IGotdjwivXbDXgihptiU>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 11:41:07 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pm@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 1/2] thermal: renesas: Group all renesas thermal drivers together
Date: Mon,  6 May 2024 17:40:10 +0200
Message-ID: <20240506154011.344324-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506154011.344324-1-niklas.soderlund+renesas@ragnatech.se>
References: <20240506154011.344324-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move all Renesas thermal drivers to a vendor specific directory.

All drivers are moved verbatim apart from the updated include path for
thermal_hwmon.h.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 MAINTAINERS                                   |  4 +--
 drivers/thermal/Kconfig                       | 28 ++-----------------
 drivers/thermal/Makefile                      |  4 +--
 drivers/thermal/renesas/Kconfig               | 27 ++++++++++++++++++
 drivers/thermal/renesas/Makefile              |  5 ++++
 .../thermal/{ => renesas}/rcar_gen3_thermal.c |  2 +-
 drivers/thermal/{ => renesas}/rcar_thermal.c  |  2 +-
 drivers/thermal/{ => renesas}/rzg2l_thermal.c |  2 +-
 8 files changed, 40 insertions(+), 34 deletions(-)
 create mode 100644 drivers/thermal/renesas/Kconfig
 create mode 100644 drivers/thermal/renesas/Makefile
 rename drivers/thermal/{ => renesas}/rcar_gen3_thermal.c (99%)
 rename drivers/thermal/{ => renesas}/rcar_thermal.c (99%)
 rename drivers/thermal/{ => renesas}/rzg2l_thermal.c (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec0284125e8f..ae2f9c7d6c4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18790,8 +18790,8 @@ L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
 F:	Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
-F:	drivers/thermal/rcar_gen3_thermal.c
-F:	drivers/thermal/rcar_thermal.c
+F:	drivers/thermal/renesas/rcar_gen3_thermal.c
+F:	drivers/thermal/renesas/rcar_thermal.c
 
 RENESAS RIIC DRIVER
 M:	Chris Brandt <chris.brandt@renesas.com>
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 204ed89a3ec9..ed16897584b4 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -343,32 +343,6 @@ config ROCKCHIP_THERMAL
 	  trip point. Cpufreq is used as the cooling device and will throttle
 	  CPUs when the Temperature crosses the passive trip point.
 
-config RCAR_THERMAL
-	tristate "Renesas R-Car thermal driver"
-	depends on ARCH_RENESAS || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  Enable this to plug the R-Car thermal sensor driver into the Linux
-	  thermal framework.
-
-config RCAR_GEN3_THERMAL
-	tristate "Renesas R-Car Gen3 and RZ/G2 thermal driver"
-	depends on ARCH_RENESAS || COMPILE_TEST
-	depends on HAS_IOMEM
-	depends on OF
-	help
-	  Enable this to plug the R-Car Gen3 or RZ/G2 thermal sensor driver into
-	  the Linux thermal framework.
-
-config RZG2L_THERMAL
-	tristate "Renesas RZ/G2L thermal driver"
-	depends on ARCH_RENESAS || COMPILE_TEST
-	depends on HAS_IOMEM
-	depends on OF
-	help
-	  Enable this to plug the RZ/G2L thermal sensor driver into the Linux
-	  thermal framework.
-
 config KIRKWOOD_THERMAL
 	tristate "Temperature sensor on Marvell Kirkwood SoCs"
 	depends on MACH_KIRKWOOD || COMPILE_TEST
@@ -459,6 +433,8 @@ depends on (ARCH_STI || ARCH_STM32) && OF
 source "drivers/thermal/st/Kconfig"
 endmenu
 
+source "drivers/thermal/renesas/Kconfig"
+
 source "drivers/thermal/tegra/Kconfig"
 
 config GENERIC_ADC_THERMAL
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 5cdf7d68687f..ce7a4752ef52 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -38,9 +38,7 @@ obj-$(CONFIG_THERMAL_MMIO)		+= thermal_mmio.o
 obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
 obj-$(CONFIG_SUN8I_THERMAL)     += sun8i_thermal.o
 obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
-obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
-obj-$(CONFIG_RCAR_GEN3_THERMAL)	+= rcar_gen3_thermal.o
-obj-$(CONFIG_RZG2L_THERMAL)	+= rzg2l_thermal.o
+obj-y				+= renesas/
 obj-$(CONFIG_KIRKWOOD_THERMAL)  += kirkwood_thermal.o
 obj-y				+= samsung/
 obj-$(CONFIG_DOVE_THERMAL)	+= dove_thermal.o
diff --git a/drivers/thermal/renesas/Kconfig b/drivers/thermal/renesas/Kconfig
new file mode 100644
index 000000000000..1be65a03d290
--- /dev/null
+++ b/drivers/thermal/renesas/Kconfig
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config RCAR_THERMAL
+	tristate "Renesas R-Car thermal driver"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Enable this to plug the R-Car thermal sensor driver into the Linux
+	  thermal framework.
+
+config RCAR_GEN3_THERMAL
+	tristate "Renesas R-Car Gen3 and RZ/G2 thermal driver"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on HAS_IOMEM
+	depends on OF
+	help
+	  Enable this to plug the R-Car Gen3 or RZ/G2 thermal sensor driver into
+	  the Linux thermal framework.
+
+config RZG2L_THERMAL
+	tristate "Renesas RZ/G2L thermal driver"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on HAS_IOMEM
+	depends on OF
+	help
+	  Enable this to plug the RZ/G2L thermal sensor driver into the Linux
+	  thermal framework.
diff --git a/drivers/thermal/renesas/Makefile b/drivers/thermal/renesas/Makefile
new file mode 100644
index 000000000000..bf9cb3cb94d6
--- /dev/null
+++ b/drivers/thermal/renesas/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_RCAR_GEN3_THERMAL)	+= rcar_gen3_thermal.o
+obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
+obj-$(CONFIG_RZG2L_THERMAL)	+= rzg2l_thermal.o
diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
similarity index 99%
rename from drivers/thermal/rcar_gen3_thermal.c
rename to drivers/thermal/renesas/rcar_gen3_thermal.c
index a764cb1115a5..c5a3895bb405 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -16,7 +16,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/thermal.h>
 
-#include "thermal_hwmon.h"
+#include "../thermal_hwmon.h"
 
 /* Register offsets */
 #define REG_GEN3_IRQSTR		0x04
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
similarity index 99%
rename from drivers/thermal/rcar_thermal.c
rename to drivers/thermal/renesas/rcar_thermal.c
index 925183753fcb..1e93f60b6d74 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/renesas/rcar_thermal.c
@@ -19,7 +19,7 @@
 #include <linux/spinlock.h>
 #include <linux/thermal.h>
 
-#include "thermal_hwmon.h"
+#include "../thermal_hwmon.h"
 
 #define IDLE_INTERVAL	5000
 
diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/renesas/rzg2l_thermal.c
similarity index 99%
rename from drivers/thermal/rzg2l_thermal.c
rename to drivers/thermal/renesas/rzg2l_thermal.c
index 04efd824ac4c..0e1cb9045ee6 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/renesas/rzg2l_thermal.c
@@ -17,7 +17,7 @@
 #include <linux/thermal.h>
 #include <linux/units.h>
 
-#include "thermal_hwmon.h"
+#include "../thermal_hwmon.h"
 
 #define CTEMP_MASK	0xFFF
 
-- 
2.45.0


