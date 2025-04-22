Return-Path: <linux-pm+bounces-25828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1547A95CF4
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 06:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDFD3ACE32
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 04:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4691A5BA4;
	Tue, 22 Apr 2025 04:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCNYov93"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D7196;
	Tue, 22 Apr 2025 04:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745296055; cv=none; b=muEo2PBg6HIk1QP+HjAww7V3lclnMCcTWTn4it3YT2IDMCW4y+3Vt9OUXn6j4MLpllAUFHqkTnmgbR7jX6MTOK7l6YWHjw8z4d1/49YlZ7eqeF+802JQ2fRaib/gO7qOFqgZeevtMPorPo14ay94b1uQUrlFusRHVvC7T+EgYuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745296055; c=relaxed/simple;
	bh=cVee4LUILXsvDSQHmDz/+cDq84rklpyfDtZScWy3/9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DA+P9/StHPYawlR1DzJuhqaeNewgwDocKccuxZKG3kXjGE0rHO1BDGqT4QMIGW36icXigRK5+yv3EvQyDeWiDbD46mb6zTvX+2xz7YPePqA/khA2w5iqZTC2N3Iy0+TwQdMwQq2XQhB7z+ux/1nawpWP/pXnWovxTPH5b51UNdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCNYov93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3366BC4CEEA;
	Tue, 22 Apr 2025 04:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745296055;
	bh=cVee4LUILXsvDSQHmDz/+cDq84rklpyfDtZScWy3/9A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hCNYov93mbQwiwGq/v9EuebjO1gs3R4Argvzm2Eexn8mrLPpLJ9sTv0gxunegVUcn
	 RfYVImigt2nEHU3EWZ5TQkJ7cZTp62r7qlvlPavnyiW0SinkJ4I7vajs+nfP30UFVT
	 R5XYAXhjcKEweuWteBukTjmUf2wOQePXYgT4PBtInusq/7mTxnxgWIEnzq2YzDs/z3
	 /b4oX1xE3RN3s0Nmytpk2bE3zawfKMY6iVtDXf3BKuLSbmoF8888M9/BJPoFxZvmXb
	 EYSZxkBbHRSK81vAXmCx5I+vJcw/FuTPEe0NZG6svLSnrLzDO/39+shy8wBaAi3Sg+
	 9rZ9l+G1HZADg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23125C369DC;
	Tue, 22 Apr 2025 04:27:35 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 21 Apr 2025 23:27:34 -0500
Subject: [PATCH 2/2] power: bq24190: Add BQ24193 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250421-bq24193-v1-2-f125ef396d24@gmail.com>
References: <20250421-bq24193-v1-0-f125ef396d24@gmail.com>
In-Reply-To: <20250421-bq24193-v1-0-f125ef396d24@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745296054; l=2741;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=KH4KqT7liHBctKmamnaT1uEJSQP5ipoPIY0y4ceij+8=;
 b=Srn+RTLP3md8VYiBjljZ37a3S1R0CduOg6wqznLn1iltRbI1KzYPK0p9LlysICu9NcpAxThg0
 EIUWqWUVeY2C9w2VxyUlgHILOtW2HxlJ50EBusLHtAZ/DkBKPS1O+2B
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

The BQ24193 is most similar to the BQ24192. This is used in many Nvidia
Tegra devices such as the SHIELD Portable. This variant works as-is with
the existing BQ24192 code, but cannot be probed with a simple fallback
compatible to ti,bq24192. So add it same as how BQ24196 is handled.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/power/supply/bq24190_charger.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index f0d97ab45bd87f3baab20bb316eaebef77d99ae8..1867beadd7afff8273d6fc7770b470209e4845e2 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -207,6 +207,7 @@ enum bq24190_chip {
 	BQ24190,
 	BQ24192,
 	BQ24192i,
+	BQ24193,
 	BQ24196,
 	BQ24296,
 	BQ24297,
@@ -2014,6 +2015,17 @@ static const struct bq24190_chip_info bq24190_chip_info_tbl[] = {
 		.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
 #ifdef CONFIG_REGULATOR
 		.vbus_desc = &bq24190_vbus_desc,
+#endif
+		.check_chip = bq24190_check_chip,
+		.set_chg_config = bq24190_battery_set_chg_config,
+		.ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK,
+		.get_ntc_status = bq24190_charger_get_ntc_status,
+		.set_otg_vbus = bq24190_set_otg_vbus,
+	},
+	[BQ24193] = {
+		.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
+#ifdef CONFIG_REGULATOR
+		.vbus_desc = &bq24190_vbus_desc,
 #endif
 		.check_chip = bq24190_check_chip,
 		.set_chg_config = bq24190_battery_set_chg_config,
@@ -2308,6 +2320,7 @@ static const struct i2c_device_id bq24190_i2c_ids[] = {
 	{ "bq24190", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24190] },
 	{ "bq24192", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24192] },
 	{ "bq24192i", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24192i] },
+	{ "bq24193", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24193] },
 	{ "bq24196", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24196] },
 	{ "bq24296", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24296] },
 	{ "bq24297", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24297] },
@@ -2319,6 +2332,7 @@ static const struct of_device_id bq24190_of_match[] = {
 	{ .compatible = "ti,bq24190", .data = &bq24190_chip_info_tbl[BQ24190] },
 	{ .compatible = "ti,bq24192", .data = &bq24190_chip_info_tbl[BQ24192] },
 	{ .compatible = "ti,bq24192i", .data = &bq24190_chip_info_tbl[BQ24192i] },
+	{ .compatible = "ti,bq24193", .data = &bq24190_chip_info_tbl[BQ24193] },
 	{ .compatible = "ti,bq24196", .data = &bq24190_chip_info_tbl[BQ24196] },
 	{ .compatible = "ti,bq24296", .data = &bq24190_chip_info_tbl[BQ24296] },
 	{ .compatible = "ti,bq24297", .data = &bq24190_chip_info_tbl[BQ24297] },

-- 
2.48.1



