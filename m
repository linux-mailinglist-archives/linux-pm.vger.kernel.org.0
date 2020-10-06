Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70216284F6F
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 18:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgJFQFf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 12:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgJFQFb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 12:05:31 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276A4C061755
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 09:05:30 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id p15so7181981ljj.8
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 09:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OwoCSmfxLGjvt1o0N+0EiCnK4lbyycGM//QYdUZDGlU=;
        b=oTF8UsYmfg+TFpK0V8akH8qv2XJgpNyqWeUQHdVUXkNtf132IjWE4EF5DiVDrzjuKC
         ha5LTVMufN2CjeKbR816/JtDpe6AQ6z66HjBxvLrQxYONwiJypn2wlIG6dTxI50APNk5
         0rqmDQEcmwTWZyYDrJRFNKSFX9dZHt5xXxwNEN+QmJH7GgdzGStfeGMIpEuanZNwINGb
         e+3GMnQoyLbFn70Wg3zpnIOVPbrcxJr1NjzjqJVFakMNwRJGRhTruq6R/VSqg+FAViJ1
         opKd4lFS63d6n5FrmRvd9a6GDlwAeyvdxbXZb/8QrHLa/4nqRBVnNL7urnUg0h/Gc0DD
         nLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OwoCSmfxLGjvt1o0N+0EiCnK4lbyycGM//QYdUZDGlU=;
        b=edQwErP7Rw6JXcdp/NnvSLdc2ed2kiu2Fz9ThefPMsRRoIK5GlLjOzweHED6gLhfE4
         HtYdHb9g/2ZgZYDr3Zes2+XVhDCw7zFgM64cYkosoo2qqSPGKQ6FJKipBPa6OvawLa8g
         UlIDpKe3ttRHdBdS3amFS0f8TG2ucsM8JHTTlWck2jBj2NnVe3hbHj0Umkbetxq0YlYm
         dcfYGKSkQ1kWujopyaj+RqP2Nr9u+Qcpl7roAV/Ai7e+N8QSkr+mACwpNE0M6aEWPKm1
         4rGfGNc+R75VrFa1vkLk7CUMH/GtuJWmVAW3XWDbnH02ua3yHJ15Z028UW0af/fdbRn/
         Hqxw==
X-Gm-Message-State: AOAM532iYty7z9NmWeWJLTlUQ3uaz8sEcKPWZHKsttAvHowErMLCcJzv
        XejkUUB3iB46/iw5lRmL06IrOw==
X-Google-Smtp-Source: ABdhPJyK6GFnxxaPzlRZzyqp1dUcsyX1BZVo9YC5jkTtBCuubAbjnNvASa8/UOvQO+5ydWM8eAcE4A==
X-Received: by 2002:a05:651c:10cc:: with SMTP id l12mr1934994ljn.351.1602000328219;
        Tue, 06 Oct 2020 09:05:28 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-91.NA.cust.bahnhof.se. [98.128.180.91])
        by smtp.gmail.com with ESMTPSA id c16sm640925lfc.304.2020.10.06.09.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:05:27 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <nks@flawful.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/4] power: avs: qcom-cpr: Move the driver to the qcom specific drivers
Date:   Tue,  6 Oct 2020 18:05:13 +0200
Message-Id: <20201006160516.319830-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201006160516.319830-1-ulf.hansson@linaro.org>
References: <20201006160516.319830-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The avs drivers are all SoC specific drivers that doesn't share any code.
Instead they are located in a directory, mostly to keep similar
functionality together. From a maintenance point of view, it makes better
sense to collect SoC specific drivers like these, into the SoC specific
directories.

Therefore, let's move the qcom-cpr driver to the qcom directory.

Cc: Niklas Cassel <nks@flawful.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                                      |  2 +-
 drivers/power/avs/Kconfig                        | 16 ----------------
 drivers/power/avs/Makefile                       |  1 -
 drivers/soc/qcom/Kconfig                         | 16 ++++++++++++++++
 drivers/soc/qcom/Makefile                        |  1 +
 drivers/{power/avs/qcom-cpr.c => soc/qcom/cpr.c} |  0
 6 files changed, 18 insertions(+), 18 deletions(-)
 rename drivers/{power/avs/qcom-cpr.c => soc/qcom/cpr.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f1a56f6efaa..f51dd1944fe6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14337,7 +14337,7 @@ L:	linux-pm@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
-F:	drivers/power/avs/qcom-cpr.c
+F:	drivers/soc/qcom/cpr.c
 
 QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
 M:	Ilia Lin <ilia.lin@kernel.org>
diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
index cdb4237bfd02..089b6244b716 100644
--- a/drivers/power/avs/Kconfig
+++ b/drivers/power/avs/Kconfig
@@ -12,22 +12,6 @@ menuconfig POWER_AVS
 
 	  Say Y here to enable Adaptive Voltage Scaling class support.
 
-config QCOM_CPR
-	tristate "QCOM Core Power Reduction (CPR) support"
-	depends on POWER_AVS && HAS_IOMEM
-	select PM_OPP
-	select REGMAP
-	help
-	  Say Y here to enable support for the CPR hardware found on Qualcomm
-	  SoCs like QCS404.
-
-	  This driver populates CPU OPPs tables and makes adjustments to the
-	  tables based on feedback from the CPR hardware. If you want to do
-	  CPUfrequency scaling say Y here.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called qcom-cpr
-
 config ROCKCHIP_IODOMAIN
 	tristate "Rockchip IO domain support"
 	depends on POWER_AVS && ARCH_ROCKCHIP && OF
diff --git a/drivers/power/avs/Makefile b/drivers/power/avs/Makefile
index 9007d05853e2..a1b8cd453f19 100644
--- a/drivers/power/avs/Makefile
+++ b/drivers/power/avs/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_POWER_AVS_OMAP)		+= smartreflex.o
-obj-$(CONFIG_QCOM_CPR)			+= qcom-cpr.o
 obj-$(CONFIG_ROCKCHIP_IODOMAIN)		+= rockchip-io-domain.o
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 3dc3e3d61ea3..6a3b69b43ad5 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -26,6 +26,22 @@ config QCOM_COMMAND_DB
 	  resource on a RPM-hardened platform must use this database to get
 	  SoC specific identifier and information for the shared resources.
 
+config QCOM_CPR
+	tristate "QCOM Core Power Reduction (CPR) support"
+	depends on ARCH_QCOM && HAS_IOMEM
+	select PM_OPP
+	select REGMAP
+	help
+	  Say Y here to enable support for the CPR hardware found on Qualcomm
+	  SoCs like QCS404.
+
+	  This driver populates CPU OPPs tables and makes adjustments to the
+	  tables based on feedback from the CPR hardware. If you want to do
+	  CPUfrequency scaling say Y here.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called qcom-cpr
+
 config QCOM_GENI_SE
 	tristate "QCOM GENI Serial Engine Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 93392d9dc7f7..ad675a6593d0 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -3,6 +3,7 @@ CFLAGS_rpmh-rsc.o := -I$(src)
 obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
 obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
+obj-$(CONFIG_QCOM_CPR)		+= cpr.o
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
 obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/soc/qcom/cpr.c
similarity index 100%
rename from drivers/power/avs/qcom-cpr.c
rename to drivers/soc/qcom/cpr.c
-- 
2.25.1

