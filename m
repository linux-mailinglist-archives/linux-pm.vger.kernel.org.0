Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE1C1BE953
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 22:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgD2U6m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 16:58:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33633 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgD2U6m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 16:58:42 -0400
Received: by mail-ot1-f65.google.com with SMTP id j26so3009644ots.0;
        Wed, 29 Apr 2020 13:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xStMKk0H1Os/f4XhAPdtzwoAZgabWI5+EIoJOxpP6QU=;
        b=Zlb9kiqGbTv4xdp589LXEgGgDSaD6xJyxvuHFcHcOlt9GPE61O5r3Jsufn//1ziSpz
         uQgBR53LFNT4lX740j28fciWg5Aoy+jDrCIUmpWLyFovE6zuzTbtvvAqRZLZquUzQwX0
         Up44E7VBxKtWWQt8K6nl0NwhWhdUKoxRkXemUwrkMAc6NEx3B6NiXdfJ1fDRcYB/WdY+
         RqWARye9QdNAyVEJ77LUQCvyhjQfO8VY2J6hprkQCUejaDobBK6A32WEvUHBa1cwtBBr
         snAeQ2rBBUmHF4OYxLoySsrbm8QPbV0T/pJU0v232otg8kg/o0ZQhEaTe7YH9nHucTEz
         0I6A==
X-Gm-Message-State: AGi0PubJft2Efx5B6upfYTwoDhZh6zGMzZtPanuK5ccfi6/GWdY2iXlP
        Yepm79R+N558RbH84SR+/A==
X-Google-Smtp-Source: APiQypK3kk60mycPcQlbrx8lkRNiDbkLmjHejw1+fZgz13WaNX4EQAK5LW9ZdLCUGNgRh1SQc9dLUg==
X-Received: by 2002:a9d:37c9:: with SMTP id x67mr27294346otb.207.1588193921255;
        Wed, 29 Apr 2020 13:58:41 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z13sm653162oth.10.2020.04.29.13.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:58:40 -0700 (PDT)
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
Subject: [PATCH v2 09/16] mfd: vexpress-sysreg: Drop unused syscon child devices
Date:   Wed, 29 Apr 2020 15:58:18 -0500
Message-Id: <20200429205825.10604-10-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429205825.10604-1-robh@kernel.org>
References: <20200429205825.10604-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The "sys_id", "sys_misc" and "sys_procid" devices don't have a user
anywhere in the tree and do nothing more than create a syscon regmap for
a single register or 2. That's an overkill for creating child devices.
Let's just remove them.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Note that the other GPIO child devices could probably be removed and
added to the bgpio driver. Unfortunately, the model dts files were
never updated 6 years ago. Not sure if the models really need LEDs...

v2:
 - Add missing commmit message
---
 drivers/mfd/vexpress-sysreg.c | 36 -----------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index 0b9cc67706c7..90a4eda2ba2b 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -43,10 +43,6 @@
 
 /* The sysreg block is just a random collection of various functions... */
 
-static struct syscon_platform_data vexpress_sysreg_sys_id_pdata = {
-	.label = "sys_id",
-};
-
 static struct bgpio_pdata vexpress_sysreg_sys_led_pdata = {
 	.label = "sys_led",
 	.base = -1,
@@ -65,24 +61,8 @@ static struct bgpio_pdata vexpress_sysreg_sys_flash_pdata = {
 	.ngpio = 1,
 };
 
-static struct syscon_platform_data vexpress_sysreg_sys_misc_pdata = {
-	.label = "sys_misc",
-};
-
-static struct syscon_platform_data vexpress_sysreg_sys_procid_pdata = {
-	.label = "sys_procid",
-};
-
 static struct mfd_cell vexpress_sysreg_cells[] = {
 	{
-		.name = "syscon",
-		.num_resources = 1,
-		.resources = (struct resource []) {
-			DEFINE_RES_MEM(SYS_ID, 0x4),
-		},
-		.platform_data = &vexpress_sysreg_sys_id_pdata,
-		.pdata_size = sizeof(vexpress_sysreg_sys_id_pdata),
-	}, {
 		.name = "basic-mmio-gpio",
 		.of_compatible = "arm,vexpress-sysreg,sys_led",
 		.num_resources = 1,
@@ -109,22 +89,6 @@ static struct mfd_cell vexpress_sysreg_cells[] = {
 		},
 		.platform_data = &vexpress_sysreg_sys_flash_pdata,
 		.pdata_size = sizeof(vexpress_sysreg_sys_flash_pdata),
-	}, {
-		.name = "syscon",
-		.num_resources = 1,
-		.resources = (struct resource []) {
-			DEFINE_RES_MEM(SYS_MISC, 0x4),
-		},
-		.platform_data = &vexpress_sysreg_sys_misc_pdata,
-		.pdata_size = sizeof(vexpress_sysreg_sys_misc_pdata),
-	}, {
-		.name = "syscon",
-		.num_resources = 1,
-		.resources = (struct resource []) {
-			DEFINE_RES_MEM(SYS_PROCID0, 0x8),
-		},
-		.platform_data = &vexpress_sysreg_sys_procid_pdata,
-		.pdata_size = sizeof(vexpress_sysreg_sys_procid_pdata),
 	}, {
 		.name = "vexpress-syscfg",
 		.num_resources = 1,
-- 
2.20.1

