Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209421AFC56
	for <lists+linux-pm@lfdr.de>; Sun, 19 Apr 2020 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgDSRIV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 13:08:21 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36534 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgDSRIV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 13:08:21 -0400
Received: by mail-oi1-f194.google.com with SMTP id s202so6772111oih.3;
        Sun, 19 Apr 2020 10:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rkm1yVQrueouMlMynX/IUSbPHuMCnuzEP4ZMzc2uSk4=;
        b=uLKWkiKig45Yrm6j5rcm4kw8g8GkGBO9vaVp/IB2s9DaGJxzWBlo75Rn7Tb0syveQA
         /47m//9XRJeqow79FXWI9mPpvK1TnDcwRlhWX71c3i9bAAuz+Cm8n0Mb7sfVXNntv9Gv
         7vKWvKQIksstshLQmo1J7yVQ8/Y4tjtuYBSLMgVwsDFsOMuyA3EckOeIJGEO+EMNmWtk
         bf1deNuGIfRvG9xRy/liMHW2yoHmdKYGFhJLrzwfIJMHAJsu/TLNQbCBV600xC3EgaM9
         PGazcj86bmjT9uI6zGMfdgkn37glAFQiAxgWYQJyDx7U2xX8oF9AxJ4zUiaY6lDs/nxj
         WrcA==
X-Gm-Message-State: AGi0PuaKiBgzMKOu/dAbmzn76+bv/97I4S9bOiT2JIAjYQM1pT+NJfhz
        q58aNTql9sIWcTh8P50ezA==
X-Google-Smtp-Source: APiQypLVQEjKhtfaW8eTl7YjGxsB7Qz3p8JXmiFRCoXKab90R013s1nz5LZs7Fjm2ta59f95TNmGeQ==
X-Received: by 2002:aca:f254:: with SMTP id q81mr8228410oih.12.1587316098741;
        Sun, 19 Apr 2020 10:08:18 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u205sm9661938oia.37.2020.04.19.10.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 10:08:18 -0700 (PDT)
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
Subject: [PATCH 04/17] power/reset: vexpress: Support building as a module
Date:   Sun, 19 Apr 2020 12:07:57 -0500
Message-Id: <20200419170810.5738-5-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419170810.5738-1-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable building the VExpress power-off/reset driver as a module.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/power/reset/Kconfig             |  2 +-
 drivers/power/reset/vexpress-poweroff.c | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 890380302080..0ba18221ba40 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -182,7 +182,7 @@ config POWER_RESET_VERSATILE
 	  reference boards.
 
 config POWER_RESET_VEXPRESS
-	bool "ARM Versatile Express power-off and reset driver"
+	tristate "ARM Versatile Express power-off and reset driver"
 	depends on ARM || ARM64
 	depends on VEXPRESS_CONFIG
 	help
diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
index 90cbaa8341e3..8a6d3add894c 100644
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/module.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -87,6 +88,7 @@ static const struct of_device_id vexpress_reset_of_match[] = {
 	},
 	{}
 };
+MODULE_DEVICE_TABLE(of, vexpress_reset_of_match);
 
 static int _vexpress_register_restart_handler(struct device *dev)
 {
@@ -145,9 +147,5 @@ static struct platform_driver vexpress_reset_driver = {
 		.of_match_table = vexpress_reset_of_match,
 	},
 };
-
-static int __init vexpress_reset_init(void)
-{
-	return platform_driver_register(&vexpress_reset_driver);
-}
-device_initcall(vexpress_reset_init);
+module_platform_driver(vexpress_reset_driver);
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

