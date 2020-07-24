Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818FE22CD98
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 20:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgGXSYs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 14:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbgGXSYr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 14:24:47 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C59D2070E;
        Fri, 24 Jul 2020 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595615087;
        bh=x7xMPArX2Q8l2DRbmFscnClk9ELgBMvWmqASsxDhbfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j31dWumhoDOzSWirJxjWIezRfGLMLhjbROt5uNI8OIOlYwx76qTFnhOAKg0DKEsmi
         67JXGcHTpUlZS+i63RgYBLAeKpFN5z0+wIT9YBUWzHmPtKEsLMHP5JkNNtGf8KpEJx
         pLaaUXFbqLOGCcqs9k64pNZTjlD786U8B6GUuPlE=
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
Subject: [RFT 08/16] memory: omap-gpmc: Use WARN() instead of BUG() on wrong free
Date:   Fri, 24 Jul 2020 20:23:20 +0200
Message-Id: <20200724182328.3348-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724182328.3348-1-krzk@kernel.org>
References: <20200724182328.3348-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since driver tracks reserved memory, freeing a non-reserved GPMC should
not be fatal and crash the system.  Printing a warning is friendlier.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on HW.
---
 drivers/memory/omap-gpmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 9339a7c75fdd..414bfb481266 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -1072,8 +1072,7 @@ void gpmc_cs_free(int cs)
 
 	spin_lock(&gpmc_mem_lock);
 	if (cs >= gpmc_cs_num || cs < 0 || !gpmc_cs_reserved(cs)) {
-		printk(KERN_ERR "Trying to free non-reserved GPMC CS%d\n", cs);
-		BUG();
+		WARN(1, "Trying to free non-reserved GPMC CS%d\n", cs);
 		spin_unlock(&gpmc_mem_lock);
 		return;
 	}
-- 
2.17.1

