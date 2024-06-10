Return-Path: <linux-pm+bounces-8883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE840902412
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 16:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19626B23A63
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 14:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C50132137;
	Mon, 10 Jun 2024 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OG9f6wG/"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C373A84E1F;
	Mon, 10 Jun 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029730; cv=none; b=TuoFVhnOtuF9kyyoZAvIfLwKz5YGl8OlzNMNdqrEOSAb7sKcVMDwVJ0Gx1G3goer9kEP8qKNEk+pUh/t7tSyOBCG9qool/dn7NWyhxC8aVNMAuRh40wMUC3ZgC7eO7gzkmYLWVAvJknfUEZrHlvIPP+NpdHkwxJJKeXNuD4aE4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029730; c=relaxed/simple;
	bh=3tcqVVhQqCaT+3z4fZrihxke4dkAgNATE9zTQ//OqSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4PF6GxNa4bi+WUewrF6hZ0Jo2KroezrzSgkQ/gGSjjSQ1q/TX91FCwWyjMlwZ0uwKf2wT1/O6Ne1+fRXk4VYyeFT9/w3y44N7TY4LkcH+Vd9XelMs643uoMGIsHKsuoppPnmxHd0gBx1SpykFMSjlWewHrF1W33tPeQ7taVtLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OG9f6wG/; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45AESdIA130773;
	Mon, 10 Jun 2024 09:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718029719;
	bh=cnlL8pgxHm/TUemaZzLk0mqFTbNkBrsmza0zEXs5fmc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=OG9f6wG/d86lVrmeEx5zZX0uO1uKF0VcdpaRzDzmygygaHcb3lu4CEUYH0qA4ZSEI
	 lIyJiN45QqunSrj+Jwrzrl1AMi7Sitt0RnvfvnVIF5Zw+9+3cQCoPHJgLispOPeMQe
	 llVr2DbGXU9w7itrSQE1/vrz7pSySzGubZUYyZH4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45AESdnR005797
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 09:28:39 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 09:28:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 09:28:39 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45AESbiL095574;
	Mon, 10 Jun 2024 09:28:38 -0500
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>
CC: Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 4/5] power: reset: brcmstb: Use devm_register_sys_off_handler()
Date: Mon, 10 Jun 2024 09:28:35 -0500
Message-ID: <20240610142836.168603-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610142836.168603-1-afd@ti.com>
References: <20240610142836.168603-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Function register_restart_handler() is deprecated. Using this new API
removes our need to keep and manage a struct notifier_block.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/reset/brcmstb-reboot.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/power/reset/brcmstb-reboot.c b/drivers/power/reset/brcmstb-reboot.c
index 94ea317f61ef4..59ed1513cfb30 100644
--- a/drivers/power/reset/brcmstb-reboot.c
+++ b/drivers/power/reset/brcmstb-reboot.c
@@ -29,8 +29,7 @@ struct reset_reg_mask {
 
 static const struct reset_reg_mask *reset_masks;
 
-static int brcmstb_restart_handler(struct notifier_block *this,
-				   unsigned long mode, void *cmd)
+static int brcmstb_restart_handler(struct sys_off_data *data)
 {
 	int rc;
 	u32 tmp;
@@ -65,11 +64,6 @@ static int brcmstb_restart_handler(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block brcmstb_restart_nb = {
-	.notifier_call = brcmstb_restart_handler,
-	.priority = 128,
-};
-
 static const struct reset_reg_mask reset_bits_40nm = {
 	.rst_src_en_mask = BIT(0),
 	.sw_mstr_rst_mask = BIT(0),
@@ -100,7 +94,8 @@ static int brcmstb_reboot_probe(struct platform_device *pdev)
 	rst_src_en = args[0];
 	sw_mstr_rst = args[1];
 
-	rc = register_restart_handler(&brcmstb_restart_nb);
+	rc = devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART,
+					   128, brcmstb_restart_handler, NULL);
 	if (rc)
 		dev_err(&pdev->dev,
 			"cannot register restart handler (err=%d)\n", rc);
-- 
2.39.2


