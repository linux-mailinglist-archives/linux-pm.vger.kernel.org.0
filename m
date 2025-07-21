Return-Path: <linux-pm+bounces-31179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C225DB0BE91
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 10:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5689189E57A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 08:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01702289835;
	Mon, 21 Jul 2025 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HbStGUkW"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E995288CBA;
	Mon, 21 Jul 2025 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753085787; cv=none; b=ubDex4b3aKFFuig/M9Ch8l426w2Wm/vf2NmMwmRlDBaIx8fto+ZJTz1cFL6HFTnsvgkfh8Jfh+QWvT5WXIHbADlXzrBwW38/Uowb7mOR3pj9omRDd/CT1gkWutv50ItzFxSUQSO1AAbG6XmWMl94VHnji5feUBJjO27poSo5PC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753085787; c=relaxed/simple;
	bh=IAyNqFidV1l98mln2YG/RNOQg5D8Q79goQT6eiPEBXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rJQzVydwFWlLKo6zZKNGpdPLwGH6RYaxwWGlL9e1DhYSSPyTpVm+jGVrUt6M0keCHWUemHXyejGX/ZvEfQj7GE0crLTX+o2kbI8xX40CP2NSg19CadriAHIQk2qS03LWuWMcM8/Vyw20OPaTUHt47qwv/QAuK1RkCxQAvbarCHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HbStGUkW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753085784;
	bh=IAyNqFidV1l98mln2YG/RNOQg5D8Q79goQT6eiPEBXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HbStGUkW8gycIdY24kr33mL01U1IUkkhYzbo87s2T68Su0pINtoi10Bx2GViJATLq
	 v7Qt/OQ8ZFOV2DIOUEBKWwwUNsNhKC30nOWNPXCJQ6Sc4oWo+j7DPxYWM0cw47KvGo
	 D3iglTmvqQyPC7dGF5h6Avwkz4vHv9ohRMAaZBsSPxTTnP3IBio6A0hGXqPTn5oUdf
	 qPyrxv9lZsHvLOwudBsDKgkkkO3kIUw8TrNkn7arUkd/fIhIDO54M/4p/Os5B1ZWi+
	 zuAs+UVJbMDriQ+JcfEf/zDeu2Fqt5mIhKee/GD8Q082f0CSJlR+7XRWDJ/I/94R1N
	 hmhF5EahQ772g==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:4487:69c6:40a:81be])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1716817E1541;
	Mon, 21 Jul 2025 10:16:23 +0200 (CEST)
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
Cc: nfraprado@collabora.com,
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
Subject: [PATCH 6/9] thermal/drivers/mediatek/lvts: Add support for ATP mode
Date: Mon, 21 Jul 2025 10:14:56 +0200
Message-Id: <20250721081459.16278-7-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721081459.16278-1-laura.nao@collabora.com>
References: <20250721081459.16278-1-laura.nao@collabora.com>
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

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 34 ++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 3c34956e37c1..8f9da0d5b886 100644
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
@@ -90,6 +94,7 @@
 
 #define LVTS_MSR_IMMEDIATE_MODE		0
 #define LVTS_MSR_FILTERED_MODE		1
+#define LVTS_MSR_ATP_MODE		2
 
 #define LVTS_MSR_READ_TIMEOUT_US	400
 #define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
@@ -207,6 +212,10 @@ static const struct debugfs_reg32 lvts_regs[] = {
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
@@ -621,6 +630,13 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
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
@@ -656,8 +672,20 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
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
@@ -907,7 +935,7 @@ static void lvts_ctrl_monitor_enable(struct device *dev, struct lvts_ctrl *lvts_
 	u32 sensor_map = 0;
 	int i;
 
-	if (lvts_ctrl->mode != LVTS_MSR_FILTERED_MODE)
+	if (lvts_ctrl->mode == LVTS_MSR_IMMEDIATE_MODE)
 		return;
 
 	if (enable) {
-- 
2.39.5


