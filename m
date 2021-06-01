Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE8A396B43
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 04:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhFACfT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 22:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbhFACfO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 22:35:14 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE53C06175F;
        Mon, 31 May 2021 19:33:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j10so19319777lfb.12;
        Mon, 31 May 2021 19:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRjE9GrdNwqNM0RZjj5ET9YAbdAVTqOUbODt0FYhk9w=;
        b=RDuxGt7zGvitQUegDBkv5bqe15b3kcSK9FnS0xIHms2ZUjchJLnAgfYcWrFfpK/4GP
         YpI8nWwSMcWKen+8/tn3Zf1koccJdoQhQxJi3YKcTz4p03BpCj+ykIcEQjWUIVFyHAzt
         rNwMYz1x2CHlHJvMyuk4ODsAb2iMyr8Luzei9ItSNsS5SxSBIsarCkPD+ZmtornP5ZeR
         +QewZmtucl0FB+CJFKnBXi8sY3CBbhsw/JH6louTcIglG49pPRKLrBajbRhOo8+u2bXR
         r8iPWVI6tOYoo6Q706w1MngRIQGWoItH4pvCoGlISt2SbpIaVEXQhUwIVX9wHxmfgWOk
         CF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRjE9GrdNwqNM0RZjj5ET9YAbdAVTqOUbODt0FYhk9w=;
        b=k09Ztaam4g7E2xhRCevKP5qgwyQ5irIChIAB4/7qbZ9Snp1uBSiyb3pB4j94HxQKid
         GzEG1gBGNhYeipOwC34+hEhaM6p0gFhyx4skaWVI2ZWcXNGqPhok0RtukpMx8TYL0n6v
         b9aSe7cWAjTL7p4P0xEh0bWJ6by7L1VjJjwTJCpogQyO4loACjnW7fIVlxMfOQEXwR+2
         XCiIxv5WfsEyecyCqoBYmK/78i2X9uzK+UcgSqjgwVIv1yDiFjDlgNYq4Pz+8JbfvrYy
         lhJxamVV50CZ/Vqzbmj0XP53rtHykEu1LChkkXaLj2rTMMk9MLXw/dzlNWFCEBn0LzVa
         3F0A==
X-Gm-Message-State: AOAM533qGhjTWw1OCYwRcWGuU4W6cJ5TCemFZewYX6fshgrIqKTeesPW
        FLni7dunFaJRJNJ21Pgn86Y=
X-Google-Smtp-Source: ABdhPJyl3zPqVtpQsvKxOF4gVKWPopyXM2iViqCyeWIYuYvChCLGpq8PPbVd1z+phH1jPy/6XnLxeA==
X-Received: by 2002:ac2:530c:: with SMTP id c12mr2385934lfh.514.1622514811446;
        Mon, 31 May 2021 19:33:31 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id l21sm107848lfc.28.2021.05.31.19.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:33:31 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?q?Nikola=20Milosavljevi=C4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v6 08/14] memory: tegra: Enable compile testing for all drivers
Date:   Tue,  1 Jun 2021 05:31:13 +0300
Message-Id: <20210601023119.22044-9-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210601023119.22044-1-digetx@gmail.com>
References: <20210601023119.22044-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable compile testing for all Tegra memory drivers.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/Kconfig | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
index a70967a56e52..71bba2345bce 100644
--- a/drivers/memory/tegra/Kconfig
+++ b/drivers/memory/tegra/Kconfig
@@ -2,16 +2,18 @@
 config TEGRA_MC
 	bool "NVIDIA Tegra Memory Controller support"
 	default y
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || (COMPILE_TEST && COMMON_CLK)
 	select INTERCONNECT
 	help
 	  This driver supports the Memory Controller (MC) hardware found on
 	  NVIDIA Tegra SoCs.
 
+if TEGRA_MC
+
 config TEGRA20_EMC
 	tristate "NVIDIA Tegra20 External Memory Controller driver"
 	default y
-	depends on TEGRA_MC && ARCH_TEGRA_2x_SOC
+	depends on ARCH_TEGRA_2x_SOC || COMPILE_TEST
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select PM_DEVFREQ
 	help
@@ -23,7 +25,7 @@ config TEGRA20_EMC
 config TEGRA30_EMC
 	tristate "NVIDIA Tegra30 External Memory Controller driver"
 	default y
-	depends on TEGRA_MC && ARCH_TEGRA_3x_SOC
+	depends on ARCH_TEGRA_3x_SOC || COMPILE_TEST
 	select PM_OPP
 	help
 	  This driver is for the External Memory Controller (EMC) found on
@@ -34,8 +36,8 @@ config TEGRA30_EMC
 config TEGRA124_EMC
 	tristate "NVIDIA Tegra124 External Memory Controller driver"
 	default y
-	depends on TEGRA_MC && ARCH_TEGRA_124_SOC
-	select TEGRA124_CLK_EMC
+	depends on ARCH_TEGRA_124_SOC || COMPILE_TEST
+	select TEGRA124_CLK_EMC if ARCH_TEGRA
 	select PM_OPP
 	help
 	  This driver is for the External Memory Controller (EMC) found on
@@ -49,10 +51,12 @@ config TEGRA210_EMC_TABLE
 
 config TEGRA210_EMC
 	tristate "NVIDIA Tegra210 External Memory Controller driver"
-	depends on TEGRA_MC && ARCH_TEGRA_210_SOC
+	depends on ARCH_TEGRA_210_SOC || COMPILE_TEST
 	select TEGRA210_EMC_TABLE
 	help
 	  This driver is for the External Memory Controller (EMC) found on
 	  Tegra210 chips. The EMC controls the external DRAM on the board.
 	  This driver is required to change memory timings / clock rate for
 	  external memory.
+
+endif
-- 
2.30.2

