Return-Path: <linux-pm+bounces-31629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D79A5B1639F
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 17:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51501AA411E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DF02E0400;
	Wed, 30 Jul 2025 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jpJdEhXG"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7C62DAFB7;
	Wed, 30 Jul 2025 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888959; cv=none; b=nijWCLAnSGm9TGoq6A8EO74gJVdwPC8zwj3vQA3epcxQ7jz1IHZIO2h4WQyJmqY96+0ybhKFB7dkFQmFpI4PYFA5wmfxy3HI8a2KeiwNQmZl0qD7wP/85v3tXIiojooLMWMNQ9fZBUqTLejrybnRz6tfo/RiV99+jyNj8Iy+DAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888959; c=relaxed/simple;
	bh=6oSrWE7nDKS9ds+QujMt4KJb/Qw7JldrgF69gNyz5KY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DFfxzbQPg9kixPxXHSKI5MBoGeeG8Py9KAI66/CKQOksboqNizUypzBPw4mhaBHnQx/APw6xUkM1Mu34rlKOA0n5NmMycfnt6ocWtXgAamV5GgFXExVRsbzuWJZsyjpGFJE7o2r0K49+XqKLVsFbBltS4ktK3RchIj1WxxJoR3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jpJdEhXG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753888955;
	bh=6oSrWE7nDKS9ds+QujMt4KJb/Qw7JldrgF69gNyz5KY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jpJdEhXGRuIrL69fTsc4htLZucyBZ93eqmUBlok459owKo7F7FhIV7R0SGi45/knG
	 0wS/7jB1GSqjk4baQleowf+h/bW4CrEuVQVcM6f1C+GjiqAP8zduJ8pL/WjrxU+Ie0
	 4HBUC0lUBopVVN7sHvyyMP9sJqAvcnDJ4fIQdxeBkZL4DxVZb2YDh1VqrGRZQa1f52
	 5nNyojdIy/VHkGFkDrKSXWKHrYsIJrh6v7iw9vxtVYs0sNiT2oENAP1GOM/ATYSf8Y
	 XAb2ZAb3yfwX/di0hrv9o9kq6b8pT9QVliAExxNEIuhWsspDjqUPLaCmvEkrb5VAEu
	 3APHRpGEoUmNw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:41d5:bfd6:7c6f:85ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 886F917E1321;
	Wed, 30 Jul 2025 17:22:34 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: srini@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: wenst@chromium.org,
	nfraprado@collabora.com,
	arnd@arndb.de,
	colin.i.king@gmail.com,
	u.kleine-koenig@baylibre.com,
	andrew-ct.chen@mediatek.com,
	lala.lin@mediatek.com,
	bchihi@baylibre.com,
	frank-w@public-files.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v2 6/9] thermal/drivers/mediatek/lvts: Add support for ATP mode
Date: Wed, 30 Jul 2025 17:21:25 +0200
Message-Id: <20250730152128.311109-7-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730152128.311109-1-laura.nao@collabora.com>
References: <20250730152128.311109-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MT8196/MT6991 uses ATP (Abnormal Temperature Prevention) mode to detect
abnormal temperature conditions, which involves reading temperature data
from a dedicated set of registers separate from the ones used for
immediate and filtered modes.

Add support for ATP mode and its relative registers to ensure accurate
temperature readings and proper thermal management on MT8196/MT6991
devices.

While at it, convert mode defines to enum.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 44 +++++++++++++++++++++----
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 750345465f00..fbe735e4fd77 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -44,6 +44,10 @@
 #define LVTS_EDATA01(__base)	(__base + 0x0058)
 #define LVTS_EDATA02(__base)	(__base + 0x005C)
 #define LVTS_EDATA03(__base)	(__base + 0x0060)
+#define LVTS_ATP0(__base)		(__base + 0x0070)
+#define LVTS_ATP1(__base)		(__base + 0x0074)
+#define LVTS_ATP2(__base)		(__base + 0x0078)
+#define LVTS_ATP3(__base)		(__base + 0x007C)
 #define LVTS_MSR0(__base)		(__base + 0x0090)
 #define LVTS_MSR1(__base)		(__base + 0x0094)
 #define LVTS_MSR2(__base)		(__base + 0x0098)
@@ -88,9 +92,6 @@
 #define LVTS_COEFF_A_MT7988			-204650
 #define LVTS_COEFF_B_MT7988			204650
 
-#define LVTS_MSR_IMMEDIATE_MODE		0
-#define LVTS_MSR_FILTERED_MODE		1
-
 #define LVTS_MSR_READ_TIMEOUT_US	400
 #define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
 
@@ -101,6 +102,12 @@
 static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
 static int golden_temp_offset;
 
+enum lvts_msr_mode {
+	LVTS_MSR_IMMEDIATE_MODE,
+	LVTS_MSR_FILTERED_MODE,
+	LVTS_MSR_ATP_MODE,
+};
+
 struct lvts_sensor_data {
 	int dt_id;
 	u8 cal_offsets[LVTS_MAX_CAL_OFFSETS];
@@ -110,7 +117,7 @@ struct lvts_ctrl_data {
 	struct lvts_sensor_data lvts_sensor[LVTS_SENSOR_MAX];
 	u8 valid_sensor_mask;
 	int offset;
-	int mode;
+	enum lvts_msr_mode mode;
 };
 
 #define VALID_SENSOR_MAP(s0, s1, s2, s3) \
@@ -211,6 +218,10 @@ static const struct debugfs_reg32 lvts_regs[] = {
 	LVTS_DEBUG_FS_REGS(LVTS_EDATA01),
 	LVTS_DEBUG_FS_REGS(LVTS_EDATA02),
 	LVTS_DEBUG_FS_REGS(LVTS_EDATA03),
+	LVTS_DEBUG_FS_REGS(LVTS_ATP0),
+	LVTS_DEBUG_FS_REGS(LVTS_ATP1),
+	LVTS_DEBUG_FS_REGS(LVTS_ATP2),
+	LVTS_DEBUG_FS_REGS(LVTS_ATP3),
 	LVTS_DEBUG_FS_REGS(LVTS_MSR0),
 	LVTS_DEBUG_FS_REGS(LVTS_MSR1),
 	LVTS_DEBUG_FS_REGS(LVTS_MSR2),
@@ -625,6 +636,13 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
 		LVTS_IMMD3(lvts_ctrl->base)
 	};
 
+	void __iomem *atp_regs[] = {
+		LVTS_ATP0(lvts_ctrl->base),
+		LVTS_ATP1(lvts_ctrl->base),
+		LVTS_ATP2(lvts_ctrl->base),
+		LVTS_ATP3(lvts_ctrl->base)
+	};
+
 	int i;
 
 	lvts_for_each_valid_sensor(i, lvts_ctrl_data) {
@@ -660,8 +678,20 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
 		/*
 		 * Each sensor has its own register address to read from.
 		 */
-		lvts_sensor[i].msr = lvts_ctrl_data->mode == LVTS_MSR_IMMEDIATE_MODE ?
-			imm_regs[i] : msr_regs[i];
+		switch (lvts_ctrl_data->mode) {
+		case LVTS_MSR_IMMEDIATE_MODE:
+			lvts_sensor[i].msr = imm_regs[i];
+			break;
+		case LVTS_MSR_FILTERED_MODE:
+			lvts_sensor[i].msr = msr_regs[i];
+			break;
+		case LVTS_MSR_ATP_MODE:
+			lvts_sensor[i].msr = atp_regs[i];
+			break;
+		default:
+			lvts_sensor[i].msr = imm_regs[i];
+			break;
+		}
 
 		lvts_sensor[i].low_thresh = INT_MIN;
 		lvts_sensor[i].high_thresh = INT_MIN;
@@ -911,7 +941,7 @@ static void lvts_ctrl_monitor_enable(struct device *dev, struct lvts_ctrl *lvts_
 	u32 sensor_map = 0;
 	int i;
 
-	if (lvts_ctrl->mode != LVTS_MSR_FILTERED_MODE)
+	if (lvts_ctrl->mode == LVTS_MSR_IMMEDIATE_MODE)
 		return;
 
 	if (enable) {
-- 
2.39.5


