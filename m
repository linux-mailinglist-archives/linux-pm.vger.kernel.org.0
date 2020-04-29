Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357611BE957
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 22:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgD2U6p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 16:58:45 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46100 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgD2U6p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 16:58:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id z25so2955198otq.13;
        Wed, 29 Apr 2020 13:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YVdgjOMdrp4pITT+OD/ByR8/aSUy3Z4Z+ze2J/iYQ6k=;
        b=RCQ+404kGhlLjSb8pSvs+ZrYR78kxPX6Rk6sSwLrmuMDNMFb72hEQoFHp2GXvBFHvf
         4ipRkaeT26fJYzL4exp4Dbi471cLjYVmJcNm05fqh0/DAMc2QfXGcU3To7X+MFjUKkqJ
         SGz98QPu3BSGUGkUpSMUhMjpGZFi9BJWI9+CvcZSNU0W7o+Gw/tIIar9wuwYEfsB2NIk
         h5nKPdVgShmQJaXJHm9EQqI3GtYTIIhDpNcyhZJqmtzcoSBiPwhpo513dwHc1PH8A0UW
         6Dzz81pU5qPmccbzi0kekMDBXKCxM8TNG4d6PT2iPBlqEAc9ikwtBI+UP6B4K3Vp8aH8
         YHOA==
X-Gm-Message-State: AGi0PuZ+EfV238gjtVSYWE+mqKCBdhc8JiuuysGoTp/UwAlXFGHrpWbn
        nf0TpzhZNjBG+VWK696InA==
X-Google-Smtp-Source: APiQypJwtGJh3hZqXXGgF3NfdVWqG/d1UqHW5SEEQkLSKsrIcN0E2g7mLyFVcD1pVGk3VyH6QwPlvg==
X-Received: by 2002:a9d:5548:: with SMTP id h8mr7161940oti.193.1588193924208;
        Wed, 29 Apr 2020 13:58:44 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z13sm653162oth.10.2020.04.29.13.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:58:43 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 11/16] mfd: vexpress-sysreg: Support building as a module
Date:   Wed, 29 Apr 2020 15:58:20 -0500
Message-Id: <20200429205825.10604-12-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429205825.10604-1-robh@kernel.org>
References: <20200429205825.10604-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable building the vexpress-sysreg driver as a module.

As deferred probe between the vexpress components works now, we don't
need to create struct devices early with of_platform_device_create().

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mfd/Kconfig           |  2 +-
 drivers/mfd/vexpress-sysreg.c | 15 ++++-----------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b1311dea2da1..792766558328 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2028,7 +2028,7 @@ config MCP_UCB1200_TS
 endmenu
 
 config MFD_VEXPRESS_SYSREG
-	bool "Versatile Express System Registers"
+	tristate "Versatile Express System Registers"
 	depends on VEXPRESS_CONFIG && GPIOLIB
 	default y
 	select GPIO_GENERIC_PLATFORM
diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index 9fb37fa689e0..eeeeb1d26d5d 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/mfd/core.h>
+#include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/syscon.h>
 #include <linux/platform_device.h>
@@ -151,6 +152,7 @@ static const struct of_device_id vexpress_sysreg_match[] = {
 	{ .compatible = "arm,vexpress-sysreg", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, vexpress_sysreg_match);
 
 static struct platform_driver vexpress_sysreg_driver = {
 	.driver = {
@@ -160,14 +162,5 @@ static struct platform_driver vexpress_sysreg_driver = {
 	.probe = vexpress_sysreg_probe,
 };
 
-static int __init vexpress_sysreg_init(void)
-{
-	struct device_node *node;
-
-	/* Need the sysreg early, before any other device... */
-	for_each_matching_node(node, vexpress_sysreg_match)
-		of_platform_device_create(node, NULL, NULL);
-
-	return platform_driver_register(&vexpress_sysreg_driver);
-}
-core_initcall(vexpress_sysreg_init);
+module_platform_driver(vexpress_sysreg_driver);
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

