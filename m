Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA1A1AFC6F
	for <lists+linux-pm@lfdr.de>; Sun, 19 Apr 2020 19:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgDSRIf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 13:08:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42523 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgDSRIf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 13:08:35 -0400
Received: by mail-ot1-f68.google.com with SMTP id m18so5958707otq.9;
        Sun, 19 Apr 2020 10:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EBjrivoY+dBlZy5hXEimly9aG7ilu27sG29Xt5twimM=;
        b=YWwG/3ym07tUIH/z9FL+gDEvIwVUSedBOkjKsex1dtTnJw4eD7v+JwgXTUVuZB5nIT
         7N2zF1mCzrbO03EeGil5tbgRU4cURlJyJ4wcpDSfCO5BW4nSY6zhsWOsQAPEh0F9QDVP
         rLk4o/xNEPau/WLSuHjr1hu7zOzJdbQRVZrLM8hdnxijXrrS1QHdxWj4F37FEdi26Wng
         HryAQdd6LHPZFLO8MNhM+TcRHwgmiRFgOOYBWBfu4cnVv6svU9Ia39LS57WP2AXG9cZw
         s+KQpWe4wOZ5zcBS//x+yJQRwTFzqI+fMF3gSmRjg+Shr5Ge7mkEG7kyMIyFSflDLfvN
         8qng==
X-Gm-Message-State: AGi0PuacoFrM6dh25uiU+ogn0MsU6RFO1QXH+O32R+WwK7vo/24WU5Ce
        GBL539bp7ks3VkeIBbkovOhudh8=
X-Google-Smtp-Source: APiQypL94dbwiZMtLp3Y9iPspqjTiyd4nMHmIxz5FPIZ7BgIvaacRyIdkubSgHJoGyF7liSeKobz+Q==
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr6519994otr.335.1587316114376;
        Sun, 19 Apr 2020 10:08:34 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u205sm9661938oia.37.2020.04.19.10.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 10:08:33 -0700 (PDT)
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
Subject: [PATCH 16/17] bus: vexpress-config: Support building as module
Date:   Sun, 19 Apr 2020 12:08:09 -0500
Message-Id: <20200419170810.5738-17-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419170810.5738-1-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable building vexpress-config driver as a module.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

