Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7370284F72
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 18:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgJFQFi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 12:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJFQFd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 12:05:33 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175EBC0613D1
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 09:05:32 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h20so4566340lji.9
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 09:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NF7N2mRAW3S3z+E29H9n2GJWFQgwjLjZu6wXpmNrAjA=;
        b=QnuSjKv9RKJSS9usSHdc3csUNh37+SWBojV0KbiqRB/uUTyHw3PUCuPMbBoNLbSxch
         ctAIEo0CDVjKJevPf8p4VuE6HubydpRxVZc5eeZYpcPCPuuydsALWD1AsCayyx2NYnUO
         zyaCyTWKvoPYy/StmNcDNA20FouWPO/eLpEL/w6uUaDJl/xgZVobJnAY/bclDGlibLEB
         VhtT98t14R2Wn5t2aOyfegJrVQG58LgYY1pesyCRO2hrouJk5XVsSuFAKCVmAJa/CaGL
         P0BTqIS0stb/5p33JCdbJ1247LON+riDWu/XaHSTEniorXOPZ7QsRmYRWlyd2qbVXntJ
         5AMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NF7N2mRAW3S3z+E29H9n2GJWFQgwjLjZu6wXpmNrAjA=;
        b=CrkTRGMYGjne+uRaugyGGG0+Ud4Etgp95iJ6vbTvdNlwt8Vndj1d3OsbXlpe9j7oFa
         Dwrsicl4m5Hv8F0iLdO7jrFA07XGRnHWky3d/0O2UjyKNXyxOndsM+EQKQAuaXgjatce
         f7JvMRlaNvrpglAnhcNDkFuA5b+m1uIaUWvgUcsJ/QJ0rRtjxqytEDqGyXfqXnTv0xz0
         YuWjw5WxFe4qbwaLyvluLvh62JOOCzXhVWae4UAjC+8J4RjDNAm6VtCXCMTKHzr8gBOH
         2yvuuFXNp8gYMDnUuHyE40Hncf3xdtNpRYq9GWTGazx3o+PQrE8eQUa0H6nPjP4xN0s7
         g43g==
X-Gm-Message-State: AOAM533XKqKifnRDjmnAdgBxwYjfVQAohoqFcqu/OH7k7frmaoFzVkY6
        w3x8SSsma57hSjn4ERb79cKAWw==
X-Google-Smtp-Source: ABdhPJzFR1bW78+ImmzRtpoOmMSKfadbIQz9q34xFBp+SWTiAX3i+KDBgDh1vUYYVDcwMdNCwHBdFQ==
X-Received: by 2002:a2e:97c1:: with SMTP id m1mr2005098ljj.289.1602000330485;
        Tue, 06 Oct 2020 09:05:30 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-91.NA.cust.bahnhof.se. [98.128.180.91])
        by smtp.gmail.com with ESMTPSA id c16sm640925lfc.304.2020.10.06.09.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:05:29 -0700 (PDT)
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
        linux-rockchip@lists.infradead.org
Subject: [PATCH 2/4] power: avs: rockchip-io: Move the driver to the rockchip specific drivers
Date:   Tue,  6 Oct 2020 18:05:14 +0200
Message-Id: <20201006160516.319830-3-ulf.hansson@linaro.org>
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

Therefore, let's move the rockchip-io driver to the rockchip directory.

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/power/avs/Kconfig                                 | 8 --------
 drivers/power/avs/Makefile                                | 1 -
 drivers/soc/rockchip/Kconfig                              | 8 ++++++++
 drivers/soc/rockchip/Makefile                             | 1 +
 .../avs/rockchip-io-domain.c => soc/rockchip/io-domain.c} | 0
 5 files changed, 9 insertions(+), 9 deletions(-)
 rename drivers/{power/avs/rockchip-io-domain.c => soc/rockchip/io-domain.c} (100%)

diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
index 089b6244b716..9dde5a7e75c9 100644
--- a/drivers/power/avs/Kconfig
+++ b/drivers/power/avs/Kconfig
@@ -11,11 +11,3 @@ menuconfig POWER_AVS
 	  AVS is also called SmartReflex on OMAP devices.
 
 	  Say Y here to enable Adaptive Voltage Scaling class support.
-
-config ROCKCHIP_IODOMAIN
-	tristate "Rockchip IO domain support"
-	depends on POWER_AVS && ARCH_ROCKCHIP && OF
-	help
-	  Say y here to enable support io domains on Rockchip SoCs. It is
-	  necessary for the io domain setting of the SoC to match the
-	  voltage supplied by the regulators.
diff --git a/drivers/power/avs/Makefile b/drivers/power/avs/Makefile
index a1b8cd453f19..d541d436f01d 100644
--- a/drivers/power/avs/Makefile
+++ b/drivers/power/avs/Makefile
@@ -1,3 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_POWER_AVS_OMAP)		+= smartreflex.o
-obj-$(CONFIG_ROCKCHIP_IODOMAIN)		+= rockchip-io-domain.o
diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
index b71b73bf5fc5..2c13bf4dd5db 100644
--- a/drivers/soc/rockchip/Kconfig
+++ b/drivers/soc/rockchip/Kconfig
@@ -14,6 +14,14 @@ config ROCKCHIP_GRF
 	  In a lot of cases there also need to be default settings initialized
 	  to make some of them conform to expectations of the kernel.
 
+config ROCKCHIP_IODOMAIN
+	tristate "Rockchip IO domain support"
+	depends on OF
+	help
+	  Say y here to enable support io domains on Rockchip SoCs. It is
+	  necessary for the io domain setting of the SoC to match the
+	  voltage supplied by the regulators.
+
 config ROCKCHIP_PM_DOMAINS
         bool "Rockchip generic power domain"
         depends on PM
diff --git a/drivers/soc/rockchip/Makefile b/drivers/soc/rockchip/Makefile
index afca0a4c4b72..875032f7344e 100644
--- a/drivers/soc/rockchip/Makefile
+++ b/drivers/soc/rockchip/Makefile
@@ -3,4 +3,5 @@
 # Rockchip Soc drivers
 #
 obj-$(CONFIG_ROCKCHIP_GRF) += grf.o
+obj-$(CONFIG_ROCKCHIP_IODOMAIN) += io-domain.o
 obj-$(CONFIG_ROCKCHIP_PM_DOMAINS) += pm_domains.o
diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/soc/rockchip/io-domain.c
similarity index 100%
rename from drivers/power/avs/rockchip-io-domain.c
rename to drivers/soc/rockchip/io-domain.c
-- 
2.25.1

