Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15DD713030B
	for <lists+linux-pm@lfdr.de>; Sat,  4 Jan 2020 16:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgADPWI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Jan 2020 10:22:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgADPWI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 4 Jan 2020 10:22:08 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA90A2464E;
        Sat,  4 Jan 2020 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578151326;
        bh=Bq3wSGweNgUnUR2ScgkLGNaGTFe493jXCOPTmwaWkAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KKhmPrZfrU1Y+AD2SvVoDbIiTf6U9ofMcOVSslLGy1lXv0B9aCVzy1xAjiKqlULG+
         YsGpS+ZEyATCAaJ0gu3tQf/8JOFwg9qobOf+MlCfVzpdVQYqnt/qpN/PlhCcWKjYgY
         Ea8jENCBIb79do/+/2IwniWPS4VUHhZ2GK8brqdI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kukjin Kim <kgene@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 06/20] thermal: exynos: Rename Samsung and Exynos to lowercase
Date:   Sat,  4 Jan 2020 16:20:53 +0100
Message-Id: <20200104152107.11407-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200104152107.11407-1-krzk@kernel.org>
References: <20200104152107.11407-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix up inconsistent usage of upper and lowercase letters in "Samsung"
and "Exynos" names.

"SAMSUNG" and "EXYNOS" are not abbreviations but regular trademarked
names.  Therefore they should be written with lowercase letters starting
with capital letter.

The lowercase "Exynos" name is promoted by its manufacturer Samsung
Electronics Co., Ltd., in advertisement materials and on website.

Although advertisement materials usually use uppercase "SAMSUNG", the
lowercase version is used in all legal aspects (e.g. on Wikipedia and in
privacy/legal statements on
https://www.samsung.com/semiconductor/privacy-global/).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/driver-api/thermal/exynos_thermal.rst | 6 +++---
 drivers/thermal/samsung/Kconfig                     | 2 +-
 drivers/thermal/samsung/exynos_tmu.c                | 4 ++--
 include/dt-bindings/thermal/thermal_exynos.h        | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/driver-api/thermal/exynos_thermal.rst b/Documentation/driver-api/thermal/exynos_thermal.rst
index d4e4a5b75805..764df4ab584d 100644
--- a/Documentation/driver-api/thermal/exynos_thermal.rst
+++ b/Documentation/driver-api/thermal/exynos_thermal.rst
@@ -4,7 +4,7 @@ Kernel driver exynos_tmu
 
 Supported chips:
 
-* ARM SAMSUNG EXYNOS4, EXYNOS5 series of SoC
+* ARM Samsung Exynos4, Exynos5 series of SoC
 
   Datasheet: Not publicly available
 
@@ -14,7 +14,7 @@ Authors: Amit Daniel <amit.daniel@samsung.com>
 TMU controller Description:
 ---------------------------
 
-This driver allows to read temperature inside SAMSUNG EXYNOS4/5 series of SoC.
+This driver allows to read temperature inside Samsung Exynos4/5 series of SoC.
 
 The chip only exposes the measured 8-bit temperature code value
 through a register.
@@ -43,7 +43,7 @@ The three equations are:
        Trimming info for 85 degree Celsius (stored at TRIMINFO register)
        Temperature code measured at 85 degree Celsius which is unchanged
 
-TMU(Thermal Management Unit) in EXYNOS4/5 generates interrupt
+TMU(Thermal Management Unit) in Exynos4/5 generates interrupt
 when temperature exceeds pre-defined levels.
 The maximum number of configurable threshold is five.
 The threshold levels are defined as follows::
diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index fe0d2ba51392..f4eff5a41a84 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -5,7 +5,7 @@ config EXYNOS_THERMAL
 	depends on HAS_IOMEM
 	help
 	  If you say yes here you get support for the TMU (Thermal Management
-	  Unit) driver for SAMSUNG EXYNOS series of SoCs. This driver initialises
+	  Unit) driver for Samsung Exynos series of SoCs. This driver initialises
 	  the TMU, reports temperature and handles cooling action if defined.
 	  This driver uses the Exynos core thermal APIs and TMU configuration
 	  data from the supported SoCs.
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 8193b66a3f83..fd4a17812f33 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * exynos_tmu.c - Samsung EXYNOS TMU (Thermal Management Unit)
+ * exynos_tmu.c - Samsung Exynos TMU (Thermal Management Unit)
  *
  *  Copyright (C) 2014 Samsung Electronics
  *  Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
@@ -1186,7 +1186,7 @@ static struct platform_driver exynos_tmu_driver = {
 
 module_platform_driver(exynos_tmu_driver);
 
-MODULE_DESCRIPTION("EXYNOS TMU Driver");
+MODULE_DESCRIPTION("Exynos TMU Driver");
 MODULE_AUTHOR("Donggeun Kim <dg77.kim@samsung.com>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:exynos-tmu");
diff --git a/include/dt-bindings/thermal/thermal_exynos.h b/include/dt-bindings/thermal/thermal_exynos.h
index 642e4e7f4084..52fcb51dda3c 100644
--- a/include/dt-bindings/thermal/thermal_exynos.h
+++ b/include/dt-bindings/thermal/thermal_exynos.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * thermal_exynos.h - Samsung EXYNOS TMU device tree definitions
+ * thermal_exynos.h - Samsung Exynos TMU device tree definitions
  *
  *  Copyright (C) 2014 Samsung Electronics
  *  Lukasz Majewski <l.majewski@samsung.com>
-- 
2.17.1

