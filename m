Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75BE1BE95F
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 22:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgD2U6w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 16:58:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34694 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgD2U6v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 16:58:51 -0400
Received: by mail-ot1-f66.google.com with SMTP id 72so3005173otu.1;
        Wed, 29 Apr 2020 13:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pWYvadUHhNmHMbwqybGHGQMT9Gw6sFtWQjTu42eM8C0=;
        b=V38S/ukS8nn50Fh2GExci2Ft5xN/E2Etp/jzIUdEB3ek3Bvgdj3FxcjpO5LCGLeILC
         n6reMY4JWy0TMM6yzTW89ELFzP5c5nQZoE71sntSbTfNQpLQd5LdWr5ltoiYMSVbXjaH
         EjnapdE1TtSNSiJxZtzBqAGtp9tsouNg+WOH25Rf7cv7vmUuSHC1eLcdqGDc/aXKHQzl
         b/ElU/U/617bnd48PsXMQtyoYVzOvoHgIH+JjT/FnE8yKKCBl11+WFZGxeVpUyyPLJGf
         jaVSGPUv14cGvG3LEBVFz1VAd17OwKA3EozJ53ONm5Pcu1wvhtghyrzy1Eo77pi5DEmz
         6Kjw==
X-Gm-Message-State: AGi0PuaCKix6w/fqDZCQjN2u3SUWJxVkuufuOMA6RasvK7ba0AKE2RLz
        l9dbzhCIh7H0rcABgxpHnipkU6U=
X-Google-Smtp-Source: APiQypIEjHDyKVTXOVc+6IBJv/YMhCsxT0ApwM+suaKheeb6cM9wNc0N3d5PdgsvPksLVNF11I2D6A==
X-Received: by 2002:a9d:1ee7:: with SMTP id n94mr27119542otn.26.1588193929527;
        Wed, 29 Apr 2020 13:58:49 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z13sm653162oth.10.2020.04.29.13.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:58:48 -0700 (PDT)
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
Subject: [PATCH v2 15/16] bus: vexpress-config: Support building as module
Date:   Wed, 29 Apr 2020 15:58:24 -0500
Message-Id: <20200429205825.10604-16-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429205825.10604-1-robh@kernel.org>
References: <20200429205825.10604-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable building vexpress-config driver as a module.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/bus/Kconfig           |  2 +-
 drivers/bus/vexpress-config.c | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 6d4e4497b59b..c16268c53831 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -183,7 +183,7 @@ config UNIPHIER_SYSTEM_BUS
 	  needed to use on-board devices connected to UniPhier SoCs.
 
 config VEXPRESS_CONFIG
-	bool "Versatile Express configuration bus"
+	tristate "Versatile Express configuration bus"
 	default y if ARCH_VEXPRESS
 	depends on ARM || ARM64
 	depends on OF
diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
index caa35a4cb34d..a58ac0c8e282 100644
--- a/drivers/bus/vexpress-config.c
+++ b/drivers/bus/vexpress-config.c
@@ -7,6 +7,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
@@ -407,15 +408,12 @@ static const struct platform_device_id vexpress_syscfg_id_table[] = {
 	{ "vexpress-syscfg", },
 	{},
 };
+MODULE_DEVICE_TABLE(platform, vexpress_syscfg_id_table);
 
 static struct platform_driver vexpress_syscfg_driver = {
 	.driver.name = "vexpress-syscfg",
 	.id_table = vexpress_syscfg_id_table,
 	.probe = vexpress_syscfg_probe,
 };
-
-static int __init vexpress_syscfg_init(void)
-{
-	return platform_driver_register(&vexpress_syscfg_driver);
-}
-core_initcall(vexpress_syscfg_init);
+module_platform_driver(vexpress_syscfg_driver);
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

