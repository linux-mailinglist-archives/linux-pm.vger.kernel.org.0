Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F65D22CDA5
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 20:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgGXSZC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 14:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgGXSZB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 14:25:01 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28D7C20737;
        Fri, 24 Jul 2020 18:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595615101;
        bh=PG6DFq6DFhp0c0tCQjZwNqORmsdKI/6YANJJI3rKHkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BTpG2kxB2ql+0y+QbmJdItyS5XIiGXiPGTDT7ZSIMLEQgU4tY/6XfasLm7bIoFBAD
         XVgXe53chcTcl3PlPI4qUlKBGyea8J4iWoEbAVu5WXkj8Vefcva6i5kNgLPG7T7Cuf
         PmcUAAqUIUVKUqr1dCr+uXSbb4UhPFkyErwdRF60=
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
Subject: [PATCH 11/16] memory: brcmstb_dpfe: Fix language typo
Date:   Fri, 24 Jul 2020 20:23:23 +0200
Message-Id: <20200724182328.3348-12-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724182328.3348-1-krzk@kernel.org>
References: <20200724182328.3348-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix firwmare -> firmware.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/brcmstb_dpfe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 604f0e3fb112..60e8633b1175 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -23,7 +23,7 @@
  *     - BE kernel + LE firmware image
  *     - BE kernel + BE firmware image
  *
- * The DPCU always runs in big endian mode. The firwmare image, however, can
+ * The DPCU always runs in big endian mode. The firmware image, however, can
  * be in either format. Also, communication between host CPU and DCPU is
  * always in little endian.
  */
-- 
2.17.1

