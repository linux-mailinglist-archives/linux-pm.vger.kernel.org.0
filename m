Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3AD1AFC5D
	for <lists+linux-pm@lfdr.de>; Sun, 19 Apr 2020 19:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgDSRIZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 13:08:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36701 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgDSRIY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 13:08:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id b13so5968472oti.3;
        Sun, 19 Apr 2020 10:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqpSGKoXLi3sKkfdberr101LzIYIKH6zzFoEGRY23rQ=;
        b=IVJ6TVu1bor1TsCV4EipYSKgqBOmcvwhXU6MxGcesmNSixT8o8VndHrEoEL0QYChqv
         4z/xVvGBKPJiD9iDJhiQ2VmAgTjrzZq/G3GX4vFrbRob/4XWulNMQnghmGXYmTNlBlnc
         uKwY5MPtJ1euG4Y61IoB2QhAjR7OlVFTvGx3KS5HCu8WKJghyR3IMQMeqgrfjVdPsl3/
         L8M6k0i5dd6FnMrAMSkwH1hC2ibpD58dISJwfXC4DQUKhhA0j2d20N8B08MzqbwRBP1Y
         Skb+E2U4HF3XVjn7d5CXRDrDjZnz+3ZC5T0+rYMUZCyLwPZ2AzqDy6k7TQsvAPw8WFvI
         vXbQ==
X-Gm-Message-State: AGi0PuaK66D7MfhQo3SVyIccdyHYNNpmpXmQWlMa9OnYa4131tMhoxX0
        cIARMSSpQUEnrk35rDGjAg==
X-Google-Smtp-Source: APiQypIFr2mQFKNOYpHIWrxwJ0w/H0567uuPX+ub6eDgSKHRgh3fJS5CSFDmpVpY8TCgeusy5wORrQ==
X-Received: by 2002:a9d:4e11:: with SMTP id p17mr797808otf.35.1587316103723;
        Sun, 19 Apr 2020 10:08:23 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u205sm9661938oia.37.2020.04.19.10.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 10:08:23 -0700 (PDT)
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
        linux-pm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 08/17] clk: vexpress-osc: Support building as a module
Date:   Sun, 19 Apr 2020 12:08:01 -0500
Message-Id: <20200419170810.5738-9-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419170810.5738-1-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable building the vexpress-osc clock driver as a module.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/clk/versatile/Kconfig            |  4 ++--
 drivers/clk/versatile/clk-vexpress-osc.c | 10 ++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
index 5bdd5c98990b..9de2396dcf9b 100644
--- a/drivers/clk/versatile/Kconfig
+++ b/drivers/clk/versatile/Kconfig
@@ -15,8 +15,8 @@ config CLK_SP810
 	  of the ARM SP810 System Controller cell.
 
 config CLK_VEXPRESS_OSC
-	bool "Clock driver for Versatile Express OSC clock generators"
-	depends on VEXPRESS_CONFIG || COMPILE_TEST
+	tristate "Clock driver for Versatile Express OSC clock generators"
+	depends on VEXPRESS_CONFIG
 	default y if ARCH_VEXPRESS
 	---help---
 	  Simple regmap-based driver driving clock generators on Versatile
diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/versatile/clk-vexpress-osc.c
index 5bb1d5a714d0..b2b32fa2d7c3 100644
--- a/drivers/clk/versatile/clk-vexpress-osc.c
+++ b/drivers/clk/versatile/clk-vexpress-osc.c
@@ -7,6 +7,7 @@
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -108,6 +109,7 @@ static const struct of_device_id vexpress_osc_of_match[] = {
 	{ .compatible = "arm,vexpress-osc", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, vexpress_osc_of_match);
 
 static struct platform_driver vexpress_osc_driver = {
 	.driver	= {
@@ -116,9 +118,5 @@ static struct platform_driver vexpress_osc_driver = {
 	},
 	.probe = vexpress_osc_probe,
 };
-
-static int __init vexpress_osc_init(void)
-{
-	return platform_driver_register(&vexpress_osc_driver);
-}
-core_initcall(vexpress_osc_init);
+module_platform_driver(vexpress_osc_driver);
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

