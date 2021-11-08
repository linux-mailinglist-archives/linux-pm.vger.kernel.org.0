Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B13E447D75
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 11:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbhKHKQX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 05:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238648AbhKHKPj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 05:15:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5329BC061228;
        Mon,  8 Nov 2021 02:12:42 -0800 (PST)
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF6231EC05B0;
        Mon,  8 Nov 2021 11:12:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0bmUspGRI3vuCuIzEtla9uRDSSAXdxTYEy3IVd3MVFs=;
        b=BUCqB0bDjyvsSVFWoldZl8G9z6l/yU+oZd+AQAP9vsPEIgEqbFJl5K8CcnZI9x+iBhOB7V
        aSIJUJUIvfFl56W+sSbyZ685y4Q64T3nmFnFcG/7sOPjkJyzC9A33IMB0Iy+8H1PfQhimc
        rLYVuWJ4mNyKLgZ9s1JN5HSOX4T/dwE=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v0 41/42] power: supply: ab8500: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:56 +0100
Message-Id: <20211108101157.15189-42-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211108101157.15189-1-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Avoid homegrown notifier registration checks.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-pm@vger.kernel.org
---
 drivers/power/supply/ab8500_charger.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 15eadaf46f14..de99f070cbc2 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3644,10 +3644,10 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	}
 
 	/* Notifier for external charger enabling */
-	if (!di->ac_chg.enabled)
-		blocking_notifier_chain_register(
-			&charger_notifier_list, &charger_nb);
-
+	if (!di->ac_chg.enabled) {
+		if (blocking_notifier_chain_register(&charger_notifier_list, &charger_nb))
+			pr_warn("Charger notifier already registered\n");
+	}
 
 	di->usb_phy = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (IS_ERR_OR_NULL(di->usb_phy)) {
-- 
2.29.2

