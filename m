Return-Path: <linux-pm+bounces-8880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7516D90240D
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 16:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AED11F2300E
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137A612F38B;
	Mon, 10 Jun 2024 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kDtyKVVr"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D4B824BC;
	Mon, 10 Jun 2024 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029729; cv=none; b=I2tc0v2tOkohu0iagRPqCBd75aepVLZcx68Nd/f9a5aS0uCSRqZdpUtzfYQQH2sl876guBIlEL/oELttHOC3HvVd0dG89JafrDBCJWJdFOvfV+oL15aBl6D4S6XkN/IlfJOUL6sqvCYKisAujzQORBeAGcxJ4sloo2nS9gtEcI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029729; c=relaxed/simple;
	bh=NTVKsVayEu2e/ta57w2zMpupCFS2KPBDy/ecgoDlBzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kxnuo7pAqKUUkpv0W0KOqAjsO2BypcJtqZF+Obh5kMo4IclYWMx8Z3uHaT8oGgwK9+5ppH6K7vgyXf08BR3QAMQOCUgSG5UHfeyf+FUMAMcqCho6+IwCJEggdsyCEb493H7STn1i/uk0xBOfXcHy/yRRujdxyHs0bGotpm8LtBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kDtyKVVr; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45AESc6O125310;
	Mon, 10 Jun 2024 09:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718029718;
	bh=pvtv1w8mptVyobEHSvk6AkP2PCKKbZqvPVKxMdTdMJs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kDtyKVVrbj54kAINAYDqnXhVizPBqg+OqsnzJs4CCIaKYHyoSzdKi9V/IFxbzQB9h
	 T6ixiZ3ZP1truT1tlqkidn5L3zBJmsovZVR7Zca58ZYEFra0J02HehDFgW32ICpFJ8
	 sSR31JfwoiECVcJObrW4qZzI/B81/v6BItE7Bj3Q=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45AESciR005779
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 09:28:38 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 09:28:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 09:28:38 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45AESbiJ095574;
	Mon, 10 Jun 2024 09:28:38 -0500
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>
CC: Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 2/5] power: reset: brcmstb: Use device_get_match_data() for matching
Date: Mon, 10 Jun 2024 09:28:33 -0500
Message-ID: <20240610142836.168603-2-afd@ti.com>
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

Use device_get_match_data() for finding the matching node and fetching
the match data all in one.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/reset/brcmstb-reboot.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/power/reset/brcmstb-reboot.c b/drivers/power/reset/brcmstb-reboot.c
index 797f0079bb590..db5b7120eadd0 100644
--- a/drivers/power/reset/brcmstb-reboot.c
+++ b/drivers/power/reset/brcmstb-reboot.c
@@ -83,24 +83,16 @@ static const struct reset_reg_mask reset_bits_65nm = {
 	.sw_mstr_rst_mask = BIT(31),
 };
 
-static const struct of_device_id of_match[] = {
-	{ .compatible = "brcm,brcmstb-reboot", .data = &reset_bits_40nm },
-	{ .compatible = "brcm,bcm7038-reboot", .data = &reset_bits_65nm },
-	{},
-};
-
 static int brcmstb_reboot_probe(struct platform_device *pdev)
 {
 	int rc;
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *of_id;
 
-	of_id = of_match_node(of_match, np);
-	if (!of_id) {
-		pr_err("failed to look up compatible string\n");
+	reset_masks = device_get_match_data(&pdev->dev);
+	if (!reset_masks) {
+		pr_err("failed to get match data\n");
 		return -EINVAL;
 	}
-	reset_masks = of_id->data;
 
 	regmap = syscon_regmap_lookup_by_phandle(np, "syscon");
 	if (IS_ERR(regmap)) {
@@ -130,6 +122,12 @@ static int brcmstb_reboot_probe(struct platform_device *pdev)
 	return rc;
 }
 
+static const struct of_device_id of_match[] = {
+	{ .compatible = "brcm,brcmstb-reboot", .data = &reset_bits_40nm },
+	{ .compatible = "brcm,bcm7038-reboot", .data = &reset_bits_65nm },
+	{},
+};
+
 static struct platform_driver brcmstb_reboot_driver = {
 	.probe = brcmstb_reboot_probe,
 	.driver = {
-- 
2.39.2


