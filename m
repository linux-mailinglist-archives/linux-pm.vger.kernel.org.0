Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF8022CDB3
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 20:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGXSZM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 14:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgGXSZL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 14:25:11 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48CE120748;
        Fri, 24 Jul 2020 18:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595615110;
        bh=muCyaGVz+SpXbnkfAtqPQlZm2UB0n+WNFxw7LeFuqDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MyAQphoHz6ZKWzm8WDqVhc0uJvYtNKtckbOXOCw1edLC4wC3kxU8ua3nKzM0N21fG
         CokWlmAbw0XmcN9V2uZ7EL5tfiB8UjFBz8bRjrLCsynP7kPzseOozm1iO9+Ghb3T21
         Oswyr6CTGpkNmw4bGTO41hKWHjGDofJJHrx8KJlw=
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
Subject: [PATCH 13/16] memory: of: Correct kerneldoc
Date:   Fri, 24 Jul 2020 20:23:25 +0200
Message-Id: <20200724182328.3348-14-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724182328.3348-1-krzk@kernel.org>
References: <20200724182328.3348-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use proper kerneldoc to fix GCC warnings like:

   drivers/memory/of_memory.c:30: warning: Function parameter or member 'dev' not described in 'of_get_min_tck'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/of_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
index 67b811cb2cb9..d9f5437d3bce 100644
--- a/drivers/memory/of_memory.c
+++ b/drivers/memory/of_memory.c
@@ -18,7 +18,7 @@
 /**
  * of_get_min_tck() - extract min timing values for ddr
  * @np: pointer to ddr device tree node
- * @device: device requesting for min timing values
+ * @dev: device requesting for min timing values
  *
  * Populates the lpddr2_min_tck structure by extracting data
  * from device tree node. Returns a pointer to the populated
@@ -155,7 +155,7 @@ EXPORT_SYMBOL(of_get_ddr_timings);
 /**
  * of_lpddr3_get_min_tck() - extract min timing values for lpddr3
  * @np: pointer to ddr device tree node
- * @device: device requesting for min timing values
+ * @dev: device requesting for min timing values
  *
  * Populates the lpddr3_min_tck structure by extracting data
  * from device tree node. Returns a pointer to the populated
-- 
2.17.1

