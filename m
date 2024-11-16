Return-Path: <linux-pm+bounces-17674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A6B9D00D2
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 21:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125D01F22080
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 20:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17489198A11;
	Sat, 16 Nov 2024 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZ2IUeY6"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A55194C7A
	for <linux-pm@vger.kernel.org>; Sat, 16 Nov 2024 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731789434; cv=none; b=TWoQFYIXACJgG9QgmV30zzJX9aISTc3SnnJWiunTufNwspi4cRgBNhktICrGr5/jveueTa2JHtILZQenBSM4kSurF8Z+30KgYm+1NPLSymt1G1xGzOjYqRi/uKGOyaJejm6etBpOSH5Opa6dq3fioPXQylAu9M9rrcuhNWHXBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731789434; c=relaxed/simple;
	bh=u1/AtEoQwSJwGsbKD0GLeGX10uHIv29qtpAUQFKf95o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSr6x2Cj9IrlToTJjRW6MBfkde3it93UQyP+jwGTCQgZ7L9oYvVQKGEAwQ3y2qU2EQc7Yg96Jq6yC2u60cHJE2lcW8JlyjEboyTPQFYdPsQsyfLt/L6ji3RMIT6uGYO8Hm44uVTaq0C9WJkIhdFFQB9iXi+ZaOpWfH3Na4HL78I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MZ2IUeY6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731789431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4+hwsuXUh6txVo7lD5/sCKQ9GduGoC9trsMg2Xh+ZEM=;
	b=MZ2IUeY60Ct4fq329Ax3u/7I6H67azVIKDidXnFLsrvgNvmLuOw2Alomb9FalmYdQ+V8Sn
	5xbVQXwOJIJvR9Qk8Yn9w6FtpokntpoD81rIr/lpbkus1Pj3V0ceUs/ImoUPaznWKlcK3O
	sshTO1WT8tK2CI63Kv+XPM/6J/6GMdc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-EFyKibtaPLy1b7pJ8MXweg-1; Sat,
 16 Nov 2024 15:37:04 -0500
X-MC-Unique: EFyKibtaPLy1b7pJ8MXweg-1
X-Mimecast-MFC-AGG-ID: EFyKibtaPLy1b7pJ8MXweg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCFD319560B1;
	Sat, 16 Nov 2024 20:37:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95E3A1956056;
	Sat, 16 Nov 2024 20:37:00 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Hermes Zhang <chenhuiz@axis.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 3/3] power: supply: bq24190: Add BQ24297 support
Date: Sat, 16 Nov 2024 21:36:48 +0100
Message-ID: <20241116203648.169100-3-hdegoede@redhat.com>
In-Reply-To: <20241116203648.169100-1-hdegoede@redhat.com>
References: <20241116203648.169100-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The BQ24297 is identical to the BQ24296 except that it uses USB D+ / D-
data-lines for charger-type (max. input-current) detection instead of
a PSEL input pin.

This is the same difference as between the already supported BQ24190
(D+ / D-) and the BQ24192 (PSEL).

Note just like with the BQ24190 vs BQ24192 there is no difference how
the charger-IC works at the register-level. The only difference is in
the external hardware interface.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 4881cbd0e672..a6a9f3ede34a 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -152,6 +152,7 @@
 #define BQ24296_REG_VPRS_PN_MASK		(BIT(7) | BIT(6) | BIT(5))
 #define BQ24296_REG_VPRS_PN_SHIFT		5
 #define BQ24296_REG_VPRS_PN_24296		0x1
+#define BQ24296_REG_VPRS_PN_24297		0x3
 #define BQ24190_REG_VPRS_TS_PROFILE_MASK	BIT(2)
 #define BQ24190_REG_VPRS_TS_PROFILE_SHIFT	2
 #define BQ24190_REG_VPRS_DEV_REG_MASK		(BIT(1) | BIT(0))
@@ -208,6 +209,7 @@ enum bq24190_chip {
 	BQ24192i,
 	BQ24196,
 	BQ24296,
+	BQ24297,
 };
 
 /*
@@ -1904,6 +1906,7 @@ static int bq24296_check_chip(struct bq24190_dev_info *bdi)
 
 	switch (v) {
 	case BQ24296_REG_VPRS_PN_24296:
+	case BQ24296_REG_VPRS_PN_24297:
 		break;
 	default:
 		dev_err(bdi->dev, "Error unknown model: 0x%02x\n", v);
@@ -2033,6 +2036,17 @@ static const struct bq24190_chip_info bq24190_chip_info_tbl[] = {
 		.ichg_array_size = BQ24296_CCC_ICHG_VALUES_LEN,
 #ifdef CONFIG_REGULATOR
 		.vbus_desc = &bq24296_vbus_desc,
+#endif
+		.check_chip = bq24296_check_chip,
+		.set_chg_config = bq24296_battery_set_chg_config,
+		.ntc_fault_mask = BQ24296_REG_F_NTC_FAULT_MASK,
+		.get_ntc_status = bq24296_charger_get_ntc_status,
+		.set_otg_vbus = bq24296_set_otg_vbus,
+	},
+	[BQ24297] = {
+		.ichg_array_size = BQ24296_CCC_ICHG_VALUES_LEN,
+#ifdef CONFIG_REGULATOR
+		.vbus_desc = &bq24296_vbus_desc,
 #endif
 		.check_chip = bq24296_check_chip,
 		.set_chg_config = bq24296_battery_set_chg_config,
@@ -2296,6 +2310,7 @@ static const struct i2c_device_id bq24190_i2c_ids[] = {
 	{ "bq24192i", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24192i] },
 	{ "bq24196", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24196] },
 	{ "bq24296", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24296] },
+	{ "bq24297", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24297] },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
@@ -2306,6 +2321,7 @@ static const struct of_device_id bq24190_of_match[] = {
 	{ .compatible = "ti,bq24192i", .data = &bq24190_chip_info_tbl[BQ24192i] },
 	{ .compatible = "ti,bq24196", .data = &bq24190_chip_info_tbl[BQ24196] },
 	{ .compatible = "ti,bq24296", .data = &bq24190_chip_info_tbl[BQ24296] },
+	{ .compatible = "ti,bq24297", .data = &bq24190_chip_info_tbl[BQ24297] },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bq24190_of_match);
-- 
2.47.0


