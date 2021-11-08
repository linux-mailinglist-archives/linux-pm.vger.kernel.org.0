Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81A3447D5C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 11:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbhKHKPE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 05:15:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38262 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237820AbhKHKPD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:03 -0500
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 882681EC04F9;
        Mon,  8 Nov 2021 11:12:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pC+lbIlcGv1j3XkDfTSs0sRGhsbjTty6nFQwrtKjf0s=;
        b=Z9gIVV1V5rkYabJG5os2pf2e3fqyNnmC8KQbPSgnSrNG03TKVFMiJQZbqs6mLQsMCwwtPv
        T2k/IrVub07C1zRLDSMF5PcVyP83dk29HeYQcgvUDHSTpT5WVdohPsz7lQiFRuOjq7cN+y
        su2vysrZbwd/yJvnCwHzEAgs6lfkKZ0=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v0 13/42] power: reset: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:28 +0100
Message-Id: <20211108101157.15189-14-bp@alien8.de>
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
 drivers/power/reset/ltc2952-poweroff.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index fbb344353fe4..6ca251e4b1be 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -279,8 +279,10 @@ static int ltc2952_poweroff_probe(struct platform_device *pdev)
 	pm_power_off = ltc2952_poweroff_kill;
 
 	data->panic_notifier.notifier_call = ltc2952_poweroff_notify_panic;
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &data->panic_notifier);
+
+	if (atomic_notifier_chain_register(&panic_notifier_list, &data->panic_notifier))
+		pr_warn("LTC2952 panic notifier already registered\n");
+
 	dev_info(&pdev->dev, "probe successful\n");
 
 	return 0;
-- 
2.29.2

