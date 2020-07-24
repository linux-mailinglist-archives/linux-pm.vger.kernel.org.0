Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B01722CD8D
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 20:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgGXSYf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 14:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbgGXSYe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 14:24:34 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87B7F2073E;
        Fri, 24 Jul 2020 18:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595615073;
        bh=j4OZBd61HSNkr1Rlja2ZzFgA907VpAkAmZpKbAqpmVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k8QAns7qKb8Dc2oZQ/yfh5QXJZiffCMebqBOUuQS/n3u0dNw1MP9UNKdN9CfXyxUv
         42wvVlq4zIQ3R+8VW9b2MVS0KBJ88HgJvxQcJXOQDbggs/neMOTEwHwcFwdGxD8hKW
         ddpcK2x6tzwTXJ4ERLJkOutwIka1XgMsxGymt67Y=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 05/16] memory: omap-gpmc: Enclose macro argument usage in parenthesis
Date:   Fri, 24 Jul 2020 20:23:17 +0200
Message-Id: <20200724182328.3348-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724182328.3348-1-krzk@kernel.org>
References: <20200724182328.3348-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Macros arguments should be enclosed by parenthesis for safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/omap-gpmc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index c91a021ac421..62577255ba0f 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -107,8 +107,8 @@
 #define ENABLE_PREFETCH		(0x1 << 7)
 #define DMA_MPU_MODE		2
 
-#define	GPMC_REVISION_MAJOR(l)		((l >> 4) & 0xf)
-#define	GPMC_REVISION_MINOR(l)		(l & 0xf)
+#define	GPMC_REVISION_MAJOR(l)		(((l) >> 4) & 0xf)
+#define	GPMC_REVISION_MINOR(l)		((l) & 0xf)
 
 #define	GPMC_HAS_WR_ACCESS		0x1
 #define	GPMC_HAS_WR_DATA_MUX_BUS	0x2
@@ -139,27 +139,27 @@
 #define GPMC_CONFIG1_WRITEMULTIPLE_SUPP (1 << 28)
 #define GPMC_CONFIG1_WRITETYPE_ASYNC    (0 << 27)
 #define GPMC_CONFIG1_WRITETYPE_SYNC     (1 << 27)
-#define GPMC_CONFIG1_CLKACTIVATIONTIME(val) ((val & 3) << 25)
+#define GPMC_CONFIG1_CLKACTIVATIONTIME(val) (((val) & 3) << 25)
 /** CLKACTIVATIONTIME Max Ticks */
 #define GPMC_CONFIG1_CLKACTIVATIONTIME_MAX 2
-#define GPMC_CONFIG1_PAGE_LEN(val)      ((val & 3) << 23)
+#define GPMC_CONFIG1_PAGE_LEN(val)      (((val) & 3) << 23)
 /** ATTACHEDDEVICEPAGELENGTH Max Value */
 #define GPMC_CONFIG1_ATTACHEDDEVICEPAGELENGTH_MAX 2
 #define GPMC_CONFIG1_WAIT_READ_MON      (1 << 22)
 #define GPMC_CONFIG1_WAIT_WRITE_MON     (1 << 21)
-#define GPMC_CONFIG1_WAIT_MON_TIME(val) ((val & 3) << 18)
+#define GPMC_CONFIG1_WAIT_MON_TIME(val) (((val) & 3) << 18)
 /** WAITMONITORINGTIME Max Ticks */
 #define GPMC_CONFIG1_WAITMONITORINGTIME_MAX  2
-#define GPMC_CONFIG1_WAIT_PIN_SEL(val)  ((val & 3) << 16)
-#define GPMC_CONFIG1_DEVICESIZE(val)    ((val & 3) << 12)
+#define GPMC_CONFIG1_WAIT_PIN_SEL(val)  (((val) & 3) << 16)
+#define GPMC_CONFIG1_DEVICESIZE(val)    (((val) & 3) << 12)
 #define GPMC_CONFIG1_DEVICESIZE_16      GPMC_CONFIG1_DEVICESIZE(1)
 /** DEVICESIZE Max Value */
 #define GPMC_CONFIG1_DEVICESIZE_MAX     1
-#define GPMC_CONFIG1_DEVICETYPE(val)    ((val & 3) << 10)
+#define GPMC_CONFIG1_DEVICETYPE(val)    (((val) & 3) << 10)
 #define GPMC_CONFIG1_DEVICETYPE_NOR     GPMC_CONFIG1_DEVICETYPE(0)
-#define GPMC_CONFIG1_MUXTYPE(val)       ((val & 3) << 8)
+#define GPMC_CONFIG1_MUXTYPE(val)       (((val) & 3) << 8)
 #define GPMC_CONFIG1_TIME_PARA_GRAN     (1 << 4)
-#define GPMC_CONFIG1_FCLK_DIV(val)      (val & 3)
+#define GPMC_CONFIG1_FCLK_DIV(val)      ((val) & 3)
 #define GPMC_CONFIG1_FCLK_DIV2          (GPMC_CONFIG1_FCLK_DIV(1))
 #define GPMC_CONFIG1_FCLK_DIV3          (GPMC_CONFIG1_FCLK_DIV(2))
 #define GPMC_CONFIG1_FCLK_DIV4          (GPMC_CONFIG1_FCLK_DIV(3))
-- 
2.17.1

