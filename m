Return-Path: <linux-pm+bounces-31904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55F4B1A357
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 15:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D002517A78C
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 13:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EE7271451;
	Mon,  4 Aug 2025 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V6ddnnko"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84626B2A5;
	Mon,  4 Aug 2025 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314370; cv=none; b=uA+5gHTUkPcvZ/v44fz2F9FHW3WL9C2wrEc9vXn62d7QvPAZUykbS2212lFBut72WJgEAK0PzBa4ivKYhka2t1Fzn2N6OcPdjjH2qKbz4wlfFzJ3lGe1qiMVkdpY8zvoAhONcq7wKtvUCYqvBnlMOsDXpNnmwn1geVxKZrLKrxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314370; c=relaxed/simple;
	bh=3EUMyB1zHIKHzfZUJiqkP2t5ouVGGyM7JSAA86ydGYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QZNgdGXaPvsMMpKKYrResxNg0AT0I04ekbIgr1ZBq9KI0MSAzT+1c+fcqSUfupoNypO5W2yLcV3pwkhArf0qLGZi1YbXVSEYnStR//SIeAD0BIkI0jHqyt28u+uCV3d22+3x2wBdrK0O5AMbOEHSCzZoqqFK4762507gOdyXFBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V6ddnnko; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754314366;
	bh=3EUMyB1zHIKHzfZUJiqkP2t5ouVGGyM7JSAA86ydGYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V6ddnnkoOJopqolmpjTOlmMYmcmhq43y8AJcl/O/ZY4CcBhq0sIbwg7aUt1enFz80
	 qbcvSYZj9NfnyGZJSlDw+Pi14mRDw8RBhZhzmMqsGQoe/iVg86ZW2Xn15NRJlv3l1H
	 6FgUJ27JJhTWaOKoZeXB24rurjloKZB6KCe/hBsykz6K67+HN2/jLH0MZh30IzdFy8
	 ixFJXy18i8f2d7g0DEtP1xKXIrsXDu2e582HhVZunrBm1I87Y3ceV00pkXPjrizDC2
	 p/0lf03XvLxkK5BlcRHMTLT13vKTkRZ9Py8GDFhnln2Yy+d7b5o6bz2ERmPeXjNqWt
	 3B4f4L8liF+tQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:865e:547d:4830:837d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0FB8517E1298;
	Mon,  4 Aug 2025 15:32:45 +0200 (CEST)
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
	Laura Nao <laura.nao@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Fei Shao <fshao@chromium.org>
Subject: [PATCH v3 6/9] thermal/drivers/mediatek/lvts: Add support for ATP mode
Date: Mon,  4 Aug 2025 15:30:32 +0200
Message-Id: <20250804133035.309990-7-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804133035.309990-1-laura.nao@collabora.com>
References: <20250804133035.309990-1-laura.nao@collabora.com>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Fei Shao <fshao@chromium.org>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 44 +++++++++++++++++++++----
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index e29664f1316a..dcfcb1be5a09 100644
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


