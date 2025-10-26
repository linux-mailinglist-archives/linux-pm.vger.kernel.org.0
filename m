Return-Path: <linux-pm+bounces-36841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 053C9C0A71E
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 13:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 801EF4E43E0
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 12:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE62EACE;
	Sun, 26 Oct 2025 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="slZAivgU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AA41DA23;
	Sun, 26 Oct 2025 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761481877; cv=none; b=Msgw5xRjHvij0B+F6w08zXOp4HvhxHfmQCvsgmGAIDDu4qUlM+o8cmpss3rXlYWLdRUvupMJaZEYZj/vAmwob04xt8nlG8bdxTS8/0KFb5rlhAxY6dCBj7kqNtGWtp61MUHjIsKR9hHNkRmwSlyFZ2qo4FvWHU/uojyD/D/uQIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761481877; c=relaxed/simple;
	bh=WKw7dDEx74rUPEVO41nKsVffxoxsW+xqBWzteYJXNFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCiiSsQzs4Mhjrxg5Ke+aDJsO0XvAHcmf8YU5aMpjsRTAanRyArAsvns/8rtEQZ9apEJTDrRS0b4TBc41/6sGIEErMP6KM1e358TE5j4El/56EqCEFs5aDsq9AhrJPSkTlIG0++prvV7AHsgyESGtwutRomcm808seBiBJ3xbHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=slZAivgU; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout1.routing.net (Postfix) with ESMTP id AE13F40027;
	Sun, 26 Oct 2025 12:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1761481325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2xhSctYjH9Rr38j6lYic7dZqTUlNx7v9z2EjOasSd8c=;
	b=slZAivgUGmXS6MXAwMunhdNmLh1re0Cepb/YihkUrtunpWcf2mfGvV+82+C2zd+Ww2gCTB
	IPe+N1tyT8sEskbkt4ADY/8PktYZNDOPKJe/XmNOUkHMyY9Eda9b0tFDME457o084HlT8C
	YVMNgfrcE3XNgvR2sgyWCG9qhGuOfbc=
Received: from frank-u24.. (fttx-pool-217.61.154.70.bambit.de [217.61.154.70])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 70EA71226F7;
	Sun, 26 Oct 2025 12:22:05 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Mason Chang <mason-cw.chang@mediatek.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Balsam CHIHI <bchihi@baylibre.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v1 4/5] thermal/drivers/mediatek/lvts_thermal: Add SoC based golden Temp
Date: Sun, 26 Oct 2025 13:21:33 +0100
Message-ID: <20251026122143.71100-5-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026122143.71100-1-linux@fw-web.de>
References: <20251026122143.71100-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Add SoC based golden temp for invalid efuse data.

This is a preliminary patch for mt7987 support where goldentemp is
slightly higher than other SOCs.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/thermal/mediatek/lvts_thermal.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 9413b30f7b69..544941e8219a 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -134,6 +134,7 @@ struct lvts_data {
 	int num_init_cmd;
 	int temp_factor;
 	int temp_offset;
+	int golden_temp;
 	int gt_calib_bit_offset;
 	unsigned int def_calibration;
 	bool irq_enable;
@@ -811,8 +812,10 @@ static int lvts_golden_temp_init(struct device *dev, u8 *calib,
 	gt = (((u32 *)calib)[0] >> lvts_data->gt_calib_bit_offset) & 0xff;
 
 	/* A zero value for gt means that device has invalid efuse data */
-	if (gt && gt < LVTS_GOLDEN_TEMP_MAX)
+	if (gt && gt <= LVTS_GOLDEN_TEMP_MAX)
 		golden_temp = gt;
+	else
+		golden_temp = lvts_data->golden_temp;
 
 	golden_temp_offset = golden_temp * 500 + lvts_data->temp_offset;
 
@@ -1786,6 +1789,7 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 	.num_init_cmd	= ARRAY_SIZE(mt7988_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT7988,
 	.temp_offset	= LVTS_COEFF_B_MT7988,
+	.golden_temp	= LVTS_GOLDEN_TEMP_DEFAULT,
 	.gt_calib_bit_offset = 24,
 	.irq_enable = true, //SDK false
 };
@@ -1799,6 +1803,7 @@ static const struct lvts_data mt8186_lvts_data = {
 	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT7988,
 	.temp_offset	= LVTS_COEFF_B_MT7988,
+	.golden_temp	= LVTS_GOLDEN_TEMP_DEFAULT,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 19000,
 	.irq_enable = true,
@@ -1813,6 +1818,7 @@ static const struct lvts_data mt8188_lvts_mcu_data = {
 	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
+	.golden_temp	= LVTS_GOLDEN_TEMP_DEFAULT,
 	.gt_calib_bit_offset = 20,
 	.def_calibration = 35000,
 	.irq_enable = true,
@@ -1827,6 +1833,7 @@ static const struct lvts_data mt8188_lvts_ap_data = {
 	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
+	.golden_temp	= LVTS_GOLDEN_TEMP_DEFAULT,
 	.gt_calib_bit_offset = 20,
 	.def_calibration = 35000,
 	.irq_enable = true,
@@ -1841,6 +1848,7 @@ static const struct lvts_data mt8192_lvts_mcu_data = {
 	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
+	.golden_temp	= LVTS_GOLDEN_TEMP_DEFAULT,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.irq_enable = true,
@@ -1855,6 +1863,7 @@ static const struct lvts_data mt8192_lvts_ap_data = {
 	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
+	.golden_temp	= LVTS_GOLDEN_TEMP_DEFAULT,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.irq_enable = true,
@@ -1869,6 +1878,7 @@ static const struct lvts_data mt8195_lvts_mcu_data = {
 	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
+	.golden_temp	= LVTS_GOLDEN_TEMP_DEFAULT,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.irq_enable = true,
@@ -1883,6 +1893,7 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
+	.golden_temp	= LVTS_GOLDEN_TEMP_DEFAULT,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 };
-- 
2.43.0


