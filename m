Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59597284F71
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 18:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgJFQFi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 12:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgJFQFe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 12:05:34 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CEAC0613D2
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 09:05:34 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i2so383913ljg.4
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 09:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UmR0SlEWURAW2elKIdEQMMvc/1QuzUmp8HMEYH38pRg=;
        b=XTuI/IvrPTmTwnj0muDXHYNo+Knzu3pD/1v+EPUlOhh8MomeTzxfWg9rRWDAC1wq65
         Bofwwo8Kgj+Hk8HfSeZzbpJ+x7QwK2pe5tRbIbSScidtLDaUberFDDPilHpn96Qrwc8L
         ziHnESuMxpDuWb0JudgWCK/8+/OlICRZsvJxcyJQNn1NkNdUNv4UHeVVzm5fP3jWzejO
         +FU3HB866iJKKCzL3Hj7hP1uiQk53lIWWKaOLOj+y1yNcQANV1F0HPk7acpOOjFAqjAY
         SzED3epUcCQcaZIgKJBFpfaOpjoX8RmNSRDsb/BEwCs1tw2bhnpv3m79AIEdaQoNroiJ
         nvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UmR0SlEWURAW2elKIdEQMMvc/1QuzUmp8HMEYH38pRg=;
        b=CbWREk8JVjYeOXr1WziBKrF4ANFU/ZW8fElxUGg4okEIUn3K3mTOnLgb0hloFqSzcH
         tUR3wQvzDeth73axsdLQ3Ny455HgEZPPGi9xctWflETUYtzTf2jPE58lE1ZrTqWBxfgy
         mrzPUQZin99PhEw0XpCkJ28xecCwlIQ4aDmpWIf8Da60aI8F98a4LI58ag6bRUwyOsCM
         nQUJ/1m+67X3JAxagCgot3ZiZz2C1Q+5u0r8X8sRsHdQMoqd28MUNp/b2ZKwiJXtn2so
         8Mf8esPVi6HwxLsoBThykT7DwN0t5bpiMnBA8l6K/LIG0LFn5lIZgOVKZJuKGAnlq4bw
         NKUQ==
X-Gm-Message-State: AOAM531ilJpG1hEjeaR5/PuQuIk7BJ2FKGznkdLrNfo2CIBSAanNBmhY
        YXcoJCjtfa/VNDH8eLTHzh6ygw==
X-Google-Smtp-Source: ABdhPJyi6RdtOBXKlyt4bbuOXMx88hSWlD9kRRFs5wMLr4ncUfI/9TRNKYoh8EIsD5SFS161i+uVkQ==
X-Received: by 2002:a2e:7404:: with SMTP id p4mr2203467ljc.360.1602000332417;
        Tue, 06 Oct 2020 09:05:32 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-91.NA.cust.bahnhof.se. [98.128.180.91])
        by smtp.gmail.com with ESMTPSA id c16sm640925lfc.304.2020.10.06.09.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:05:31 -0700 (PDT)
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
        linux-omap@vger.kernel.org
Subject: [PATCH 3/4] power: avs: smartreflex Move driver to soc specific drivers
Date:   Tue,  6 Oct 2020 18:05:15 +0200
Message-Id: <20201006160516.319830-4-ulf.hansson@linaro.org>
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

Therefore, let's move the smartreflex driver for OMAP to the ti directory.

Cc: Nishanth Menon <nm@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                                 |  4 ++--
 arch/arm/plat-omap/Kconfig                  |  2 +-
 drivers/power/avs/Kconfig                   | 12 ------------
 drivers/power/avs/Makefile                  |  1 -
 drivers/soc/ti/Makefile                     |  1 +
 drivers/{power/avs => soc/ti}/smartreflex.c |  0
 6 files changed, 4 insertions(+), 16 deletions(-)
 rename drivers/{power/avs => soc/ti}/smartreflex.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f51dd1944fe6..040f0506d1c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5379,11 +5379,11 @@ F:	include/linux/debugfs.h
 F:	include/linux/kobj*
 F:	lib/kobj*
 
-DRIVERS FOR ADAPTIVE VOLTAGE SCALING (AVS)
+DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
 M:	Nishanth Menon <nm@ti.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
-F:	drivers/power/avs/
+F:	drivers/soc/ti/smartreflex.c
 F:	include/linux/power/smartreflex.h
 
 DRM DRIVER FOR ALLWINNER DE2 AND DE3 ENGINE
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 93fd7fc537cf..272670ef1e92 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -23,7 +23,7 @@ config OMAP_DEBUG_LEDS
 
 config POWER_AVS_OMAP
 	bool "AVS(Adaptive Voltage Scaling) support for OMAP IP versions 1&2"
-	depends on POWER_AVS && (ARCH_OMAP3 || ARCH_OMAP4) && PM
+	depends on (ARCH_OMAP3 || ARCH_OMAP4) && PM
 	select POWER_SUPPLY
 	help
 	  Say Y to enable AVS(Adaptive Voltage Scaling)
diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
index 9dde5a7e75c9..a4e40e534e6a 100644
--- a/drivers/power/avs/Kconfig
+++ b/drivers/power/avs/Kconfig
@@ -1,13 +1 @@
 # SPDX-License-Identifier: GPL-2.0-only
-menuconfig POWER_AVS
-	bool "Adaptive Voltage Scaling class support"
-	help
-	  AVS is a power management technique which finely controls the
-	  operating voltage of a device in order to optimize (i.e. reduce)
-	  its power consumption.
-	  At a given operating point the voltage is adapted depending on
-	  static factors (chip manufacturing process) and dynamic factors
-	  (temperature depending performance).
-	  AVS is also called SmartReflex on OMAP devices.
-
-	  Say Y here to enable Adaptive Voltage Scaling class support.
diff --git a/drivers/power/avs/Makefile b/drivers/power/avs/Makefile
index d541d436f01d..a4e40e534e6a 100644
--- a/drivers/power/avs/Makefile
+++ b/drivers/power/avs/Makefile
@@ -1,2 +1 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_POWER_AVS_OMAP)		+= smartreflex.o
diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
index 1110e5c98685..5463431ec96c 100644
--- a/drivers/soc/ti/Makefile
+++ b/drivers/soc/ti/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
 obj-$(CONFIG_TI_SCI_INTA_MSI_DOMAIN)	+= ti_sci_inta_msi.o
 obj-$(CONFIG_TI_K3_RINGACC)		+= k3-ringacc.o
 obj-$(CONFIG_TI_K3_SOCINFO)		+= k3-socinfo.o
+obj-$(CONFIG_POWER_AVS_OMAP)		+= smartreflex.o
diff --git a/drivers/power/avs/smartreflex.c b/drivers/soc/ti/smartreflex.c
similarity index 100%
rename from drivers/power/avs/smartreflex.c
rename to drivers/soc/ti/smartreflex.c
-- 
2.25.1

