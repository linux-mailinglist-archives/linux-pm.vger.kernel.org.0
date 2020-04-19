Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4931AFC67
	for <lists+linux-pm@lfdr.de>; Sun, 19 Apr 2020 19:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDSRIc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 13:08:32 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34125 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgDSRIb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 13:08:31 -0400
Received: by mail-ot1-f65.google.com with SMTP id h11so519073ots.1;
        Sun, 19 Apr 2020 10:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3HyKpPbcRN4znVuAjhoeE+CSQVXiKwEz8DNz5m29rBI=;
        b=qGZTGEj3UeNP9RW/FkyurKNQVZVIYIuy22YhPxl3qB/Q9db1nWOrFRHZumH0NPLayv
         ecyJ9eXCBD0obdic1HX4Bdw7ruQRM30KHhvdmDBIjR+3Yk8AuWYfEzM9SREA9CDEFmny
         LkNzmcmYeEqcDcBvgq9KsKZoVTcR/JE0C9Eng9koHTojiNPx3EVEv4+CTu2Ve6H7pHtb
         PyKtmVd4QsD/TQ2MBnju4ewktDf0o4dMLl1aniUUwgWB/ap/4WgOvCAYwnR/ophN1dgR
         uLEYik+pJSFrwBmabfB7xB+YfUU26YtpyXda0sKKCF9OmdcDoj3Lg45qTlCUK3Sx6bk0
         dBMw==
X-Gm-Message-State: AGi0PuYSuSReSAjZ8YwqBu0EKtps2AqOs1bV4wP5kccKzJUlSwuj6CGH
        3dGK09hPp8vJEy/o9nrbew==
X-Google-Smtp-Source: APiQypJ3TUDwE5W0Lbu6MaWW9hEAAI/eMa1e4x7PzilWJJUeR5E6pht0rkfYrYUnpXdKfjZXW9G54Q==
X-Received: by 2002:a9d:6c55:: with SMTP id g21mr6432746otq.211.1587316109509;
        Sun, 19 Apr 2020 10:08:29 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u205sm9661938oia.37.2020.04.19.10.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 10:08:28 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 12/17] mfd: vexpress-sysreg: Support building as a module
Date:   Sun, 19 Apr 2020 12:08:05 -0500
Message-Id: <20200419170810.5738-13-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419170810.5738-1-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable building the vexpress-sysreg driver as a module.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
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

