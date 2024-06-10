Return-Path: <linux-pm+bounces-8879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EFA90240C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 16:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8475B281C4E
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 14:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3D812BE91;
	Mon, 10 Jun 2024 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pUiKRdSl"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D9484A4A;
	Mon, 10 Jun 2024 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029728; cv=none; b=JtmwYBs0WuMdL3P71mz75/XvO4aClqzttPXEDeQohXPgH0ysaZGxPAARwdgvxsKdObRumaiOO9ADmKtW6NgPAihaWIl5Eb4LUDf9DAegN+Edd4VbbREhr4PjOegJYkJoN8n7S7EUvw7WOP0fVZLEBskrO4oTY5Wm7g9c+hPhJR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029728; c=relaxed/simple;
	bh=5bQM7hHF7PLhbjD/krJghRpcI2zapDtOoV2uqLTS5Ok=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SreG/TKGxd0U5HrFO+GFqrYQ8DNjgWr73YmLOiqwqMVH1GBco6H7o7KSfHs0Ms2+NPFSI8Dgqg2ZW5YQ3VxRnVDfGR6fuNSt4cNRZaDLCJYXHWOFeEU+Vsge8L68cA4l5+NfW7XVZaWVG/TxlszBr4tatixBmAkXbuhWqfVxjMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pUiKRdSl; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45AEScRf077485;
	Mon, 10 Jun 2024 09:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718029718;
	bh=33XS1jVgoWUHzWe+ClzEaiI5z3azMfp+cKYexpVd4jY=;
	h=From:To:CC:Subject:Date;
	b=pUiKRdSlFlaLFa/tdEdfU1bvVquPh73nHmiI1NTD4Yqce8JFaktOWNN/UUjMEkch1
	 viYM0wgYwP3KoCBNCzF414CUib5HaUkEqpU2K08qafiq5N43hlh+hrXRRI0UgSVnll
	 OlXHTN9qXvYncngWnf8KkrUPCkP4jdkrHH0VUyE0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45AEScRp123863
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 09:28:38 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 09:28:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 09:28:38 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45AESbiI095574;
	Mon, 10 Jun 2024 09:28:37 -0500
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>
CC: Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/5] power: reset: brcmstb: Use normal driver register function
Date: Mon, 10 Jun 2024 09:28:32 -0500
Message-ID: <20240610142836.168603-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The platform_driver_probe() helper is useful when the probe function
is in the _init section, that is not the case here. Use the normal
platform_driver_register() function.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/reset/brcmstb-reboot.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/reset/brcmstb-reboot.c b/drivers/power/reset/brcmstb-reboot.c
index 0f2944dc93551..797f0079bb590 100644
--- a/drivers/power/reset/brcmstb-reboot.c
+++ b/drivers/power/reset/brcmstb-reboot.c
@@ -140,7 +140,6 @@ static struct platform_driver brcmstb_reboot_driver = {
 
 static int __init brcmstb_reboot_init(void)
 {
-	return platform_driver_probe(&brcmstb_reboot_driver,
-					brcmstb_reboot_probe);
+	return platform_driver_register(&brcmstb_reboot_driver);
 }
 subsys_initcall(brcmstb_reboot_init);
-- 
2.39.2


