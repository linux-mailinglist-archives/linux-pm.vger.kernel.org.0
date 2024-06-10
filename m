Return-Path: <linux-pm+bounces-8881-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C54902410
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 16:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0351C219F0
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 14:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002D6132115;
	Mon, 10 Jun 2024 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YZyc7xxi"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EED84D2A;
	Mon, 10 Jun 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029729; cv=none; b=gr4V3lyyTrow4j6VqVC1v8Cn2oL9LL9iejk5Mc/LmOQVK8D3/58DCRpUWGJOW/J39ZKIxuS03D2PRIKGMd4XEwl82U8LyHCJ1HxPUmznoVoM6rniA8TwQUxE/5jGsMwfeX4+hESyHQ8xU7TKRpJ8xhTNm1BACrjjw5zjFzFU3s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029729; c=relaxed/simple;
	bh=mG0r+hw0sL+I/LKoCAN0zFwQxC+2TqHY6277Z6VzDyk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bV+7bfUfm7xs7LpGVyynKmrITkBzFEM3PsAcMDGH0K9g0AKVyTRI9Obngn8SckCR4WzjiySaweJGHT9T4dk8o2IL0kBmOcu7zIpU5LF4P9G2AuolnyY+5Qz4JePEQPWwwn6T0atjjibWDUCSlmmjyU4tutcK5yvhXGsEQNA0xjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YZyc7xxi; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45AESdQ2077494;
	Mon, 10 Jun 2024 09:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718029719;
	bh=rY0GlNBEm2jymjnwKoounw4ILr8+9Jltj98FEVGjHCI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YZyc7xxiLT6ziao7dgiqOHzxwaLMxYTtRyDCgvhsjONJcXg8TehhN4vfH41UNXXau
	 k520PG/jkkYRDIPyO0SZSVdU5NBpq3RrU/bOEmKLzP6PHxiyBH/tBXalJHC6NVblHn
	 l0NpHgkB1fkfHPjY3xd6qtW3qpNi6iBU8xpFFDW8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45AESd4w005788
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 09:28:39 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 09:28:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 09:28:39 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45AESbiK095574;
	Mon, 10 Jun 2024 09:28:38 -0500
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>
CC: Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 3/5] power: reset: brcmstb: Use syscon_regmap_lookup_by_phandle_args() helper
Date: Mon, 10 Jun 2024 09:28:34 -0500
Message-ID: <20240610142836.168603-3-afd@ti.com>
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

Simplify probe by fetching the regmap and its arguments in one call.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/reset/brcmstb-reboot.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/power/reset/brcmstb-reboot.c b/drivers/power/reset/brcmstb-reboot.c
index db5b7120eadd0..94ea317f61ef4 100644
--- a/drivers/power/reset/brcmstb-reboot.c
+++ b/drivers/power/reset/brcmstb-reboot.c
@@ -18,9 +18,6 @@
 #include <linux/smp.h>
 #include <linux/mfd/syscon.h>
 
-#define RESET_SOURCE_ENABLE_REG 1
-#define SW_MASTER_RESET_REG 2
-
 static struct regmap *regmap;
 static u32 rst_src_en;
 static u32 sw_mstr_rst;
@@ -87,6 +84,7 @@ static int brcmstb_reboot_probe(struct platform_device *pdev)
 {
 	int rc;
 	struct device_node *np = pdev->dev.of_node;
+	unsigned int args[2];
 
 	reset_masks = device_get_match_data(&pdev->dev);
 	if (!reset_masks) {
@@ -94,25 +92,13 @@ static int brcmstb_reboot_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	regmap = syscon_regmap_lookup_by_phandle(np, "syscon");
+	regmap = syscon_regmap_lookup_by_phandle_args(np, "syscon", 2, args);
 	if (IS_ERR(regmap)) {
 		pr_err("failed to get syscon phandle\n");
 		return -EINVAL;
 	}
-
-	rc = of_property_read_u32_index(np, "syscon", RESET_SOURCE_ENABLE_REG,
-					&rst_src_en);
-	if (rc) {
-		pr_err("can't get rst_src_en offset (%d)\n", rc);
-		return -EINVAL;
-	}
-
-	rc = of_property_read_u32_index(np, "syscon", SW_MASTER_RESET_REG,
-					&sw_mstr_rst);
-	if (rc) {
-		pr_err("can't get sw_mstr_rst offset (%d)\n", rc);
-		return -EINVAL;
-	}
+	rst_src_en = args[0];
+	sw_mstr_rst = args[1];
 
 	rc = register_restart_handler(&brcmstb_restart_nb);
 	if (rc)
-- 
2.39.2


