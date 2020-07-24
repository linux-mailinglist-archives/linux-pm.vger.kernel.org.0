Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAB922CDB5
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 20:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgGXSZR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 14:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgGXSZQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 14:25:16 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01060208E4;
        Fri, 24 Jul 2020 18:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595615115;
        bh=ZHssgXFw9tdp7kd/8wRKNVCbGynFMRozJTxl7pkD+Og=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjhYGXA27XLYt9lyspm8gFo+X/D5qtiSf7WzpvxzFrV94+N5wXza9uH45nrCfIiDr
         hD7GrGNueoWRlGmxHVyJSwqUSJ+IWqojSDFuVggp6ARyZJgh0oUB8IvOl0xunJfYCP
         yWj39eImA4yZWVOA5EvMwGxKEMJL5eXwG1G4X+gw=
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
Subject: [PATCH 14/16] memory: pl172: Enclose macro argument usage in parenthesis
Date:   Fri, 24 Jul 2020 20:23:26 +0200
Message-Id: <20200724182328.3348-15-krzk@kernel.org>
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
 drivers/memory/pl172.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/pl172.c b/drivers/memory/pl172.c
index 084891eb29cc..575fadbffa30 100644
--- a/drivers/memory/pl172.c
+++ b/drivers/memory/pl172.c
@@ -21,7 +21,7 @@
 #include <linux/of_platform.h>
 #include <linux/time.h>
 
-#define MPMC_STATIC_CFG(n)		(0x200 + 0x20 * n)
+#define MPMC_STATIC_CFG(n)		(0x200 + 0x20 * (n))
 #define  MPMC_STATIC_CFG_MW_8BIT	0x0
 #define  MPMC_STATIC_CFG_MW_16BIT	0x1
 #define  MPMC_STATIC_CFG_MW_32BIT	0x2
@@ -31,17 +31,17 @@
 #define  MPMC_STATIC_CFG_EW		BIT(8)
 #define  MPMC_STATIC_CFG_B		BIT(19)
 #define  MPMC_STATIC_CFG_P		BIT(20)
-#define MPMC_STATIC_WAIT_WEN(n)		(0x204 + 0x20 * n)
+#define MPMC_STATIC_WAIT_WEN(n)		(0x204 + 0x20 * (n))
 #define  MPMC_STATIC_WAIT_WEN_MAX	0x0f
-#define MPMC_STATIC_WAIT_OEN(n)		(0x208 + 0x20 * n)
+#define MPMC_STATIC_WAIT_OEN(n)		(0x208 + 0x20 * (n))
 #define  MPMC_STATIC_WAIT_OEN_MAX	0x0f
-#define MPMC_STATIC_WAIT_RD(n)		(0x20c + 0x20 * n)
+#define MPMC_STATIC_WAIT_RD(n)		(0x20c + 0x20 * (n))
 #define  MPMC_STATIC_WAIT_RD_MAX	0x1f
-#define MPMC_STATIC_WAIT_PAGE(n)	(0x210 + 0x20 * n)
+#define MPMC_STATIC_WAIT_PAGE(n)	(0x210 + 0x20 * (n))
 #define  MPMC_STATIC_WAIT_PAGE_MAX	0x1f
-#define MPMC_STATIC_WAIT_WR(n)		(0x214 + 0x20 * n)
+#define MPMC_STATIC_WAIT_WR(n)		(0x214 + 0x20 * (n))
 #define  MPMC_STATIC_WAIT_WR_MAX	0x1f
-#define MPMC_STATIC_WAIT_TURN(n)	(0x218 + 0x20 * n)
+#define MPMC_STATIC_WAIT_TURN(n)	(0x218 + 0x20 * (n))
 #define  MPMC_STATIC_WAIT_TURN_MAX	0x0f
 
 /* Maximum number of static chip selects */
-- 
2.17.1

