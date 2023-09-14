Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22007A026B
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 13:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbjINLTv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 07:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237725AbjINLTp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 07:19:45 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BFB1FE2
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 04:19:40 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so13035571fa.2
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690379; x=1695295179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4AQYXVW3A30PqnsD+M8aOCxVdHOXHi6IQ/sQ09Z4ts=;
        b=SqYtQeHzlacr2wpiqn440sVP1PVzzsY4bkjJHouszGG/BR5JhH4zngeUCZq56VjSU4
         TjvK2KloOmpvNhfx1w02TBpE+8/5XJC2P+/2/v1QPHqfyRbZetz5KY07R81oECuqqZqP
         fNP5yZM1Kwj+U0F8x+TwFC8L3kq5/502DPtvo247+mBHRf3r4mI9EnKwUAzJLS3QG8X3
         fyAYkoCS//w/TaQSSPD4Z+b0t/vFFRTz2Lb4FhkPjU1SsWEFy5bVhOhzV25tIt0J8By4
         uMtvSRisJH/6DJHt7G5bMPGumVGkrhNvJsfCcGMrZt2Tzsi3PoOBwpm0ECxsu0eicED+
         6XKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690379; x=1695295179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4AQYXVW3A30PqnsD+M8aOCxVdHOXHi6IQ/sQ09Z4ts=;
        b=LXrKDggnRvCxn/tDGKIOb/T+Uu+xt/P66yjrex69DFPZCDQDpEALU9HwkCbras7k3p
         roE1WAza7Kuj1IQP4FbiVMDLLkYjf8h61cQp51obBZMiIaBhj+IytxjH0CCZA9VuSRR3
         TqTLJHj0012BrcIE4Tk5kButdkCxM8JPUmsrEWllecmaG8D9j3kaiKdrfMadCO9peGEx
         1XEBT5eN4gJcWOUVbARR8WMOAdU+8ueU6JCWSYjJYqIN/JtK6QZOtnCDAJRvbaic4Z/M
         2Gg704LNmuOS1/M+JJBIUeOWphcf/ZnPc9BuB5/zl1fFK1P887HLx78LL3DBMGtvExB8
         Z7KQ==
X-Gm-Message-State: AOJu0YwqJCw+jQgrBz/1YBwa/vZ1qIUWSm55YcH9s9ROhMwTsjs6PRa1
        ew9U9um5OXWT0EMvqRmUHy6gsQ==
X-Google-Smtp-Source: AGHT+IE3SErW6Lewr5rbpUuacMhs7ikzrG/xi+QG4UxR8L4l4rUK7dvv+mXMyalbYMVAoJaNPiKf7Q==
X-Received: by 2002:a2e:9154:0:b0:2bc:efa4:2c32 with SMTP id q20-20020a2e9154000000b002bcefa42c32mr4690301ljg.37.1694690378945;
        Thu, 14 Sep 2023 04:19:38 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id y15-20020a2e978f000000b002bce38190a3sm237679lji.34.2023.09.14.04.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:19:38 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@amd.com>
Subject: [PATCH 17/17] pmdomain: xilinx: Move Kconfig option to the pmdomain subsystem
Date:   Thu, 14 Sep 2023 13:19:36 +0200
Message-Id: <20230914111936.586824-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Kconfig option belongs closer to the corresponding implementation,
hence let's move it from the soc subsystem to the pmdomain subsystem.

Cc: Michal Simek <michal.simek@amd.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig        |  1 +
 drivers/pmdomain/xilinx/Kconfig | 10 ++++++++++
 drivers/soc/xilinx/Kconfig      |  9 ---------
 3 files changed, 11 insertions(+), 9 deletions(-)
 create mode 100644 drivers/pmdomain/xilinx/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 785d177b0ad7..dca0899cd210 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -16,5 +16,6 @@ source "drivers/pmdomain/starfive/Kconfig"
 source "drivers/pmdomain/sunxi/Kconfig"
 source "drivers/pmdomain/tegra/Kconfig"
 source "drivers/pmdomain/ti/Kconfig"
+source "drivers/pmdomain/xilinx/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/xilinx/Kconfig b/drivers/pmdomain/xilinx/Kconfig
new file mode 100644
index 000000000000..5242753d848a
--- /dev/null
+++ b/drivers/pmdomain/xilinx/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config ZYNQMP_PM_DOMAINS
+	bool "Enable Zynq MPSoC generic PM domains"
+	default y
+	depends on PM && ZYNQMP_FIRMWARE
+	select PM_GENERIC_DOMAINS
+	help
+	  Say yes to enable device power management through PM domains
+	  If in doubt, say N.
diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 8a755a5c8836..49d69d6e18fe 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -16,15 +16,6 @@ config ZYNQMP_POWER
 
 	  If in doubt, say N.
 
-config ZYNQMP_PM_DOMAINS
-	bool "Enable Zynq MPSoC generic PM domains"
-	default y
-	depends on PM && ZYNQMP_FIRMWARE
-	select PM_GENERIC_DOMAINS
-	help
-	  Say yes to enable device power management through PM domains
-	  If in doubt, say N.
-
 config XLNX_EVENT_MANAGER
 	bool "Enable Xilinx Event Management Driver"
 	depends on ZYNQMP_FIRMWARE
-- 
2.34.1

