Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC8E22CD88
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 20:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGXSYb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 14:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:32972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgGXSY3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 14:24:29 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F33B42070B;
        Fri, 24 Jul 2020 18:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595615069;
        bh=PuO42SWKqXGKsVy8DEJzaXe0S+VggBkOX28YgE6UznU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jw5r2T983VW2fPKtKoBaS8/S3bzyT22UZtHK2TUYkx4Lo7NyafZ6j/hIBZ9MQXPU4
         ID348NpyVVLUhddFt1nZWIbMJm2UqUnO7TLeE592zNa4Qd2C/lsl7IZPEyqr1YfUiS
         Jqn9VeiUfnZSfepXVsMath4uayXEJoH1rvgxpaO0=
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
Subject: [PATCH 04/16] memory: omap-gpmc: Correct kerneldoc
Date:   Fri, 24 Jul 2020 20:23:16 +0200
Message-Id: <20200724182328.3348-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724182328.3348-1-krzk@kernel.org>
References: <20200724182328.3348-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use proper kerneldoc to fix GCC warnings like:

    drivers/memory/omap-gpmc.c:299: warning: Function parameter or member 'cs' not described in 'gpmc_get_clk_period'
    drivers/memory/omap-gpmc.c:432: warning: Excess function parameter 'ma' description in 'get_gpmc_timing_reg'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/omap-gpmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 2675ea4e37fe..c91a021ac421 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -289,8 +289,8 @@ static unsigned long gpmc_get_fclk_period(void)
 
 /**
  * gpmc_get_clk_period - get period of selected clock domain in ps
- * @cs Chip Select Region.
- * @cd Clock Domain.
+ * @cs: Chip Select Region.
+ * @cd: Clock Domain.
  *
  * GPMC_CS_CONFIG1 GPMCFCLKDIVIDER for cs has to be setup
  * prior to calling this function with GPMC_CD_CLK.
@@ -409,7 +409,7 @@ static void gpmc_cs_bool_timings(int cs, const struct gpmc_bool_timings *p)
  * @reg:     GPMC_CS_CONFIGn register offset.
  * @st_bit:  Start Bit
  * @end_bit: End Bit. Must be >= @st_bit.
- * @ma:x     Maximum parameter value (before optional @shift).
+ * @max:     Maximum parameter value (before optional @shift).
  *           If 0, maximum is as high as @st_bit and @end_bit allow.
  * @name:    DTS node name, w/o "gpmc,"
  * @cd:      Clock Domain of timing parameter.
@@ -1134,7 +1134,7 @@ static struct gpmc_nand_ops nand_ops = {
 
 /**
  * gpmc_omap_get_nand_ops - Get the GPMC NAND interface
- * @regs: the GPMC NAND register map exclusive for NAND use.
+ * @reg: the GPMC NAND register map exclusive for NAND use.
  * @cs: GPMC chip select number on which the NAND sits. The
  *      register map returned will be specific to this chip select.
  *
-- 
2.17.1

