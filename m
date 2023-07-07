Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D0674B2A1
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 16:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjGGOGB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 10:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjGGOFi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 10:05:38 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791822738
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 07:05:11 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b5c231c23aso31015271fa.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2023 07:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738709; x=1691330709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8/R65mfXAHzbxX/Yt/oiagP1RewF0H/jSZoqHRKyvw=;
        b=tunTCtuJSMkrNfKB7zXRqYFc3dBg13wFN2619YM1UDWrcOwMNMMdemELKhSYM1ulK0
         BLiUHkr/mQebq+CTZqrW33MHDNPalSMa2wmE+IxEX1wIzViVba2hqUA35D0qDtAboKk/
         1tCUcEnOgxhjruhHhF284mKTZzLUh7FNzFH9CFLl5SgVWJuEWn6DpaUPVkq2PIkOkIUM
         NUEa5FG7BYycAF0tolipgMQEph6v5kUBmy47MXRV3KkIBs/vfJd5XJiz2NKj1rEWwNe4
         TUcaskBDiN0U4vhPwa8kZ4Ac0gNdgFsZO+kLgJlmqV6QEIp/+0PLibvM42dnJwqtdsU8
         GI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738709; x=1691330709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8/R65mfXAHzbxX/Yt/oiagP1RewF0H/jSZoqHRKyvw=;
        b=VYnKNESI6MxCXWf8VCe1JfuE5JTETiN/rXWSimh4rzYb/Rx4ffqgtmEUVQGe+5Ru3E
         2iwEStalfO7HYaMNulWw4Wfr1iR4NNKPhd0qzbAeYaHkwQtPVzQFNUoW+Tk2BT2OwNOl
         i94NJ/v2OdvM+XmYVrQ4kAvgtRoKN5o5JEmMXZDQIzDXMUdc7Y1ckQtJZ0jBNnHYpR06
         0SdAX/eMw1PsTRKnvd7Jl1GXDZs0JohvVKIS2kskcpZb6ewyCHSAAW/jQG5CKuOnRKoO
         cX07WisGH/cz6BDKXutR6Q/cUVcp+EdQhTS9+K5mLsP78SQaTMfL++uCia9YZc5KudyL
         Ce8Q==
X-Gm-Message-State: ABy/qLbpYnE7WEsug3IT/EaE+xo4WjouIPSxmpPBAvSavApV4YmBp5zx
        Ue/WdW29se6aBfU+0RZKE+R6HQ==
X-Google-Smtp-Source: APBJJlHpl8BDqdizNvRgFYh8xGJqPB5RsiI6fTOozpyN+ToBWQzqKLiwu+M08DljZ9h1vz5AHVd/pw==
X-Received: by 2002:a2e:3e1a:0:b0:2b6:df15:f6ad with SMTP id l26-20020a2e3e1a000000b002b6df15f6admr4230300lja.18.1688738709123;
        Fri, 07 Jul 2023 07:05:09 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:05:08 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 17/18] ARM: ux500: Convert power-domain code into a regular platform driver
Date:   Fri,  7 Jul 2023 16:04:33 +0200
Message-Id: <20230707140434.723349-18-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707140434.723349-1-ulf.hansson@linaro.org>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To make the code more standalone and moveable, let's convert it into a
platform driver.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |  5 -----
 arch/arm/mach-ux500/pm_domains.c | 25 ++++++++++++++++++++-----
 arch/arm/mach-ux500/pm_domains.h | 17 -----------------
 3 files changed, 20 insertions(+), 27 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/pm_domains.h

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 7cc0dd8ed991..b1a70f203372 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -26,8 +26,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 
-#include "pm_domains.h"
-
 static int __init ux500_l2x0_unlock(void)
 {
 	int i;
@@ -115,9 +113,6 @@ static const struct of_device_id u8500_local_bus_nodes[] = {
 
 static void __init u8500_init_machine(void)
 {
-	/* Initialize ux500 power domains */
-	ux500_pm_domains_init();
-
 	of_platform_populate(NULL, u8500_local_bus_nodes,
 			     NULL, NULL);
 }
diff --git a/arch/arm/mach-ux500/pm_domains.c b/arch/arm/mach-ux500/pm_domains.c
index 427b9ac4af6c..3d4f111ed156 100644
--- a/arch/arm/mach-ux500/pm_domains.c
+++ b/arch/arm/mach-ux500/pm_domains.c
@@ -6,6 +6,9 @@
  *
  * Implements PM domains using the generic PM domain for ux500.
  */
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/err.h>
@@ -13,7 +16,6 @@
 #include <linux/pm_domain.h>
 
 #include <dt-bindings/arm/ux500_pm_domains.h>
-#include "pm_domains.h"
 
 static int pd_power_off(struct generic_pm_domain *domain)
 {
@@ -49,18 +51,17 @@ static struct generic_pm_domain *ux500_pm_domains[NR_DOMAINS] = {
 	[DOMAIN_VAPE] = &ux500_pm_domain_vape,
 };
 
-static const struct of_device_id ux500_pm_domain_matches[] __initconst = {
+static const struct of_device_id ux500_pm_domain_matches[] = {
 	{ .compatible = "stericsson,ux500-pm-domains", },
 	{ },
 };
 
-int __init ux500_pm_domains_init(void)
+static int ux500_pm_domains_probe(struct platform_device *pdev)
 {
-	struct device_node *np;
+	struct device_node *np = pdev->dev.of_node;
 	struct genpd_onecell_data *genpd_data;
 	int i;
 
-	np = of_find_matching_node(NULL, ux500_pm_domain_matches);
 	if (!np)
 		return -ENODEV;
 
@@ -77,3 +78,17 @@ int __init ux500_pm_domains_init(void)
 	of_genpd_add_provider_onecell(np, genpd_data);
 	return 0;
 }
+
+static struct platform_driver ux500_pm_domains_driver = {
+	.probe  = ux500_pm_domains_probe,
+	.driver = {
+		.name = "ux500_pm_domains",
+		.of_match_table = ux500_pm_domain_matches,
+	},
+};
+
+static int __init ux500_pm_domains_init(void)
+{
+	return platform_driver_register(&ux500_pm_domains_driver);
+}
+arch_initcall(ux500_pm_domains_init);
diff --git a/arch/arm/mach-ux500/pm_domains.h b/arch/arm/mach-ux500/pm_domains.h
deleted file mode 100644
index 33c55f2c6b3c..000000000000
--- a/arch/arm/mach-ux500/pm_domains.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2014 Linaro Ltd.
- *
- * Author: Ulf Hansson <ulf.hansson@linaro.org>
- */
-
-#ifndef __MACH_UX500_PM_DOMAINS_H
-#define __MACH_UX500_PM_DOMAINS_H
-
-#ifdef CONFIG_PM_GENERIC_DOMAINS
-extern int __init ux500_pm_domains_init(void);
-#else
-static inline int ux500_pm_domains_init(void) { return 0; }
-#endif
-
-#endif
-- 
2.34.1

