Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBA9424D0F
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 08:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhJGGGp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 02:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240265AbhJGGG3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 02:06:29 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642EEC061768;
        Wed,  6 Oct 2021 23:04:30 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id q125so4933769qkd.12;
        Wed, 06 Oct 2021 23:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AjmE6VeuEyL2QsLaDyUixanuKQ8JeVYXpqh+lIstwTs=;
        b=lhqw1eS6JVCxVYVw/4ep9L56P6tHseCPftpc5iQrus8h1JoH1nCjutvVTSp26TudPr
         vx0BsB0O7PX9DYaI0jRv/raDi3xwn1w5zq1RRxMUorG7q8BQ/TXyu9z3FgQ71JCRcwT/
         Aigoht9RSFpF9fRfSsm6gu3aFUVsP5Dunha8mwnZUuc1TrGD0OxDMddAJR322HZGh8fb
         q0zBx5PO8ZdLNb4Z+4xzkeP+L+kKFnvY2PRQ7isFgU8AgKLEmhgAbb62zCKFxPz2JKJ4
         6wxJ/4m78S1j0oayHuhboGUUKZVnbMQcF7lMkwdF/ZIZ85l49uEdWCuOIsnhMO/1xBU3
         o4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AjmE6VeuEyL2QsLaDyUixanuKQ8JeVYXpqh+lIstwTs=;
        b=xcmVUlEaDho2xElebVzQKyOMocVH24Qeo1YraQEbHu4F5c07xKjWhiHzdIze4z+B5c
         ex5Y4C1eQNAatUp1WBYAQz+KByxalmwjsiU014bQKmRHw9GM+9+fH/WiAZAuTCI95OIk
         r5TjK0fMtJ/5o3Q7f1zQnjQFAp+Qix1mwFJdlUCHXla4rdcuGmL2lhywR24pD/jL1uEn
         lp4Klpo6k7/d1JlVfWxw54g+7nv+wPBJ1My4Pax2B+44E33GvKhcGM2d8dE13axL7R4V
         PRLy5GWLL74vzJKT8WuQVQDXBdSlTLCvQU+F8+LDT6JDjinaOZOnLfwtSYca58Tz6Y1S
         G24g==
X-Gm-Message-State: AOAM531lqEzGKtpHpWI9+3oI9sGRGs1ZFB5o9bzTkA+JMr4+XQRq+Usl
        UR6SEiwwLg1fBOPnwb5/5UlluZxnNws=
X-Google-Smtp-Source: ABdhPJzUdkKDXGeOcDoog5HzF5lLmrBd3P1A2PZmqp7t4Y7eyd9UmIsTEg3eLvsBH/zb2/mlkrnbCg==
X-Received: by 2002:a37:9fc1:: with SMTP id i184mr1842222qke.247.1633586669653;
        Wed, 06 Oct 2021 23:04:29 -0700 (PDT)
Received: from localhost.localdomain (79-139-163-57.dynamic.spd-mgts.ru. [79.139.163.57])
        by smtp.gmail.com with ESMTPSA id x79sm13235042qkb.65.2021.10.06.23.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 23:04:29 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v1 6/6] soc/tegra: pmc: Add power off handler
Date:   Thu,  7 Oct 2021 09:02:53 +0300
Message-Id: <20211007060253.17049-7-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211007060253.17049-1-digetx@gmail.com>
References: <20211007060253.17049-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Nexus 7 Android tablet can be turned off using a special bootloader
command which is conveyed to bootloader by putting magic value into
specific scratch register and then rebooting normally. This power off
method should be invoked if USB cable is connected. Bootloader then will
display battery status and power off the device. This behaviour is
borrowed from downstream kernel and matches user expectations, otherwise
it looks like device got hung during power off.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 42 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index dc9ad075ee4a..44de043c2012 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -39,6 +39,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
+#include <linux/power_supply.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
@@ -107,6 +108,7 @@
 #define PMC_USB_DEBOUNCE_DEL		0xec
 #define PMC_USB_AO			0xf0
 
+#define PMC_SCRATCH37			0x130
 #define PMC_SCRATCH41			0x140
 
 #define PMC_WAKE2_MASK			0x160
@@ -1063,10 +1065,8 @@ int tegra_pmc_cpu_remove_clamping(unsigned int cpuid)
 	return tegra_powergate_remove_clamping(id);
 }
 
-static int tegra_pmc_restart_notify(struct notifier_block *this,
-				    unsigned long action, void *data)
+static void tegra_pmc_restart(const char *cmd)
 {
-	const char *cmd = data;
 	u32 value;
 
 	value = tegra_pmc_scratch_readl(pmc, pmc->soc->regs->scratch0);
@@ -1089,6 +1089,12 @@ static int tegra_pmc_restart_notify(struct notifier_block *this,
 	value = tegra_pmc_readl(pmc, PMC_CNTRL);
 	value |= PMC_CNTRL_MAIN_RST;
 	tegra_pmc_writel(pmc, value, PMC_CNTRL);
+}
+
+static int tegra_pmc_restart_notify(struct notifier_block *this,
+				    unsigned long action, void *data)
+{
+	tegra_pmc_restart(data);
 
 	return NOTIFY_DONE;
 }
@@ -1098,6 +1104,29 @@ static struct notifier_block tegra_pmc_restart_handler = {
 	.priority = 128,
 };
 
+static int tegra_pmc_poweroff_notify(struct notifier_block *this,
+				     unsigned long action, void *data)
+{
+	/*
+	 * Reboot Nexus 7 into special bootloader mode if USB cable is
+	 * connected in order to display battery status and power off.
+	 */
+	if (of_machine_is_compatible("asus,grouper") &&
+	    power_supply_is_system_supplied()) {
+		const u32 go_to_charger_mode = 0xa5a55a5a;
+
+		tegra_pmc_writel(pmc, go_to_charger_mode, PMC_SCRATCH37);
+		tegra_pmc_restart(NULL);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block tegra_pmc_poweroff_handler = {
+	.notifier_call = tegra_pmc_poweroff_notify,
+	.priority = 200,
+};
+
 static int powergate_show(struct seq_file *s, void *data)
 {
 	unsigned int i;
@@ -2866,6 +2895,13 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	err = devm_register_poweroff_handler(&pdev->dev, &tegra_pmc_poweroff_handler);
+	if (err) {
+		dev_err(&pdev->dev, "unable to register poweroff handler, %d\n",
+			err);
+		return err;
+	}
+
 	/*
 	 * PCLK clock rate can't be retrieved using CLK API because it
 	 * causes lockup if CPU enters LP2 idle state from some other
-- 
2.32.0

