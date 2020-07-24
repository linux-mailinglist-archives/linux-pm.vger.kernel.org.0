Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E194A22CD9B
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 20:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgGXSYw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 14:24:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbgGXSYw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 14:24:52 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D11B720771;
        Fri, 24 Jul 2020 18:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595615092;
        bh=Vl/dugxAyzjWbfR0Cyd+BAILFtMv+EqLyvmIFi2Uc4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zMf6q4K/a55Nf4iNIM966rSC9Xi3o8hA6YX2Xs50eYlq/F+w2qj/EACT9fsCo9OMG
         ja96IRCrULjLUbfYtRZvfaSPsU+wpzsBeuF/8BJ61VYnkJJAJU8HAi3KpNNzc1vLUD
         It+Y/GUs9l+OBdQchlBgYDo5ZoXT1aTREYE64PlE=
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
Subject: [PATCH 09/16] memory: omap-gpmc: Fix language typo
Date:   Fri, 24 Jul 2020 20:23:21 +0200
Message-Id: <20200724182328.3348-10-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724182328.3348-1-krzk@kernel.org>
References: <20200724182328.3348-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix arbitary -> arbitrary.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/omap-gpmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 414bfb481266..76a9c700cbd5 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2126,7 +2126,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	gpmc_cs_disable_mem(cs);
 
 	/*
-	 * FIXME: gpmc_cs_request() will map the CS to an arbitary
+	 * FIXME: gpmc_cs_request() will map the CS to an arbitrary
 	 * location in the gpmc address space. When booting with
 	 * device-tree we want the NOR flash to be mapped to the
 	 * location specified in the device-tree blob. So remap the
-- 
2.17.1

