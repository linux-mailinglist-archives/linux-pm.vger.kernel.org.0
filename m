Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0EA596B12
	for <lists+linux-pm@lfdr.de>; Wed, 17 Aug 2022 10:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiHQIIq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Aug 2022 04:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiHQIIo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Aug 2022 04:08:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822204D4D4
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 01:08:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n4so15266030wrp.10
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 01:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Ak72FGFbfXpSRonkz3yL70wABVme2CnwT8ZwOZfKHbk=;
        b=Ajvpgr8bma/+PrVmx7XaOtQ49NzWRN9qEw5X0ud3GIXmt/6SU8O1FfBlqYK+5MRnvl
         k082reGCUiZFOn8mjysSGp3UlnXUNOSBNXyufVFKQDaVG3Ap0kvEXvnO0fKcgBPLN+FS
         YDusNfm2UUWgu/4mq1QDMvDX/u5XxLrEDI9mAFpWEm/ebPWm+AYBE+PbteKStS0ykrn0
         EBlDms3VVM4Av1CZt71PudPptXrrh0T50oBnj1FPl50XGS8C+hgE6uqX1Cou96qrtMaG
         jeDIwjp2RErYd786ARvI2UXD7V3a73oU8C2VkpZa8il/RHYsXoIWjrmIi+Q0zMBAgGvK
         rxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Ak72FGFbfXpSRonkz3yL70wABVme2CnwT8ZwOZfKHbk=;
        b=zD4Y2MzbrN0uMHoVuaKKpQE6Bml6M4VosB9V6eY5d7gnrGezB810Q2a9LQF+3J3kII
         vwzHx6P+kS4bZ03o3canJUoxwQSCyo1WsC2xTGxRfrAhHXLTEcPrP3lXDf6pC7uPs2ph
         2Eb78wqKfd0IdnTPcmmyzIFJ4W3zNLB8s9JCJzONmxUoeyldTTHrpne0c6FRn907rxqw
         fFeow30KmutxLzZpTgC81dzlf/dxIxw61cklfaSC+nX9HWkdwmHUOt4fSkuBnQE3WqE0
         RzwU5m9bCvawwr/nVOABK4WXo1/GPTz5KHJiHQB2gq1wpNEWaSN67zkygOlDEFNszTT6
         9iAQ==
X-Gm-Message-State: ACgBeo2BEWEpuCQyxP0vqnp2anGuqRREjG7MJkz39BzS2UWhdknfBUI6
        2JYkGTVmxyhqj8fHZhEPL3gQ3Q==
X-Google-Smtp-Source: AA6agR6s+hpMiCmi6f0fKUxsw27bi9vrOcIGbIViJi2IROSVBsDAsYU1ZIvyV4w1sWcfqauxhtc27Q==
X-Received: by 2002:a05:6000:1d82:b0:220:5f9b:9a77 with SMTP id bk2-20020a0560001d8200b002205f9b9a77mr13360040wrb.622.1660723715881;
        Wed, 17 Aug 2022 01:08:35 -0700 (PDT)
Received: from Balsam-ThinkPad-T480.civfrance.com (58.188.158.77.rev.sfr.net. [77.158.188.58])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003a54d610e5fsm1391992wmq.26.2022.08.17.01.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 01:08:35 -0700 (PDT)
From:   bchihi@baylibre.com
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: [PATCH v9,1/7] thermal: mediatek: Relocate driver to mediatek folder
Date:   Wed, 17 Aug 2022 10:07:51 +0200
Message-Id: <20220817080757.352021-2-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817080757.352021-1-bchihi@baylibre.com>
References: <20220817080757.352021-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Michael Kao <michael.kao@mediatek.com>

Add MediaTek proprietary folder to upstream more thermal zone and cooler
drivers, relocate the original thermal controller driver to it, and rename it
as "auxadc_thermal.c" to show its purpose more clearly.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Co-developed-by: Ben Tseng <ben.tseng@mediatek.com>
Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
Co-developed-by: Balsam CHIHI <bchihi@baylibre.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 drivers/thermal/Kconfig                       | 14 ++++--------
 drivers/thermal/Makefile                      |  2 +-
 drivers/thermal/mediatek/Kconfig              | 22 +++++++++++++++++++
 drivers/thermal/mediatek/Makefile             |  1 +
 .../auxadc_thermal.c}                         |  2 +-
 5 files changed, 29 insertions(+), 12 deletions(-)
 create mode 100644 drivers/thermal/mediatek/Kconfig
 create mode 100644 drivers/thermal/mediatek/Makefile
 rename drivers/thermal/{mtk_thermal.c => mediatek/auxadc_thermal.c} (99%)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e052dae614eb..d35f63daca3b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -412,16 +412,10 @@ config DA9062_THERMAL
 	  zone.
 	  Compatible with the DA9062 and DA9061 PMICs.
 
-config MTK_THERMAL
-	tristate "Temperature sensor driver for mediatek SoCs"
-	depends on ARCH_MEDIATEK || COMPILE_TEST
-	depends on HAS_IOMEM
-	depends on NVMEM || NVMEM=n
-	depends on RESET_CONTROLLER
-	default y
-	help
-	  Enable this option if you want to have support for thermal management
-	  controller present in Mediatek SoCs
+menu "Mediatek thermal drivers"
+depends on ARCH_MEDIATEK || COMPILE_TEST
+source "drivers/thermal/mediatek/Kconfig"
+endmenu
 
 config AMLOGIC_THERMAL
 	tristate "Amlogic Thermal Support"
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index def8e1a0399c..f7daeb8056c4 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -55,7 +55,7 @@ obj-y				+= st/
 obj-$(CONFIG_QCOM_TSENS)	+= qcom/
 obj-y				+= tegra/
 obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
-obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
+obj-y				+= mediatek/
 obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
 obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
diff --git a/drivers/thermal/mediatek/Kconfig b/drivers/thermal/mediatek/Kconfig
new file mode 100644
index 000000000000..8ff32370b591
--- /dev/null
+++ b/drivers/thermal/mediatek/Kconfig
@@ -0,0 +1,22 @@
+config MTK_THERMAL
+	tristate "MediaTek thermal drivers"
+	depends on THERMAL_OF
+	help
+	  This is the option for MediaTek thermal software solutions.
+	  Please enable corresponding options to get temperature
+	  information from thermal sensors or turn on throttle
+	  mechaisms for thermal mitigation.
+
+if MTK_THERMAL
+
+config MTK_SOC_THERMAL
+	tristate "AUXADC temperature sensor driver for MediaTek SoCs"
+	depends on HAS_IOMEM
+	depends on NVMEM
+	depends on RESET_CONTROLLER
+	help
+	  Enable this option if you want to get SoC temperature
+	  information for MediaTek platforms. This driver configures
+	  thermal controllers to collect temperature via AUXADC interface.
+
+endif
diff --git a/drivers/thermal/mediatek/Makefile b/drivers/thermal/mediatek/Makefile
new file mode 100644
index 000000000000..bec325f06a46
--- /dev/null
+++ b/drivers/thermal/mediatek/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MTK_SOC_THERMAL)		+= auxadc_thermal.o
diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
similarity index 99%
rename from drivers/thermal/mtk_thermal.c
rename to drivers/thermal/mediatek/auxadc_thermal.c
index ede94eadddda..60924f8f98e9 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -23,7 +23,7 @@
 #include <linux/reset.h>
 #include <linux/types.h>
 
-#include "thermal_hwmon.h"
+#include "../thermal_hwmon.h"
 
 /* AUXADC Registers */
 #define AUXADC_CON1_SET_V	0x008
-- 
2.34.1

