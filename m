Return-Path: <linux-pm+bounces-39892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C7BCDA38C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 19:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D506305EB4A
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF993491CF;
	Tue, 23 Dec 2025 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="npbzClcl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F142C0F8E;
	Tue, 23 Dec 2025 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766512653; cv=none; b=F0Y3nGhAdTyIRyObjABgos7l4lzHr1FtBWDA6PG93OJGVeHE+G+G/8LMP6flcEA9wA7bs1L8At3pLYT0SaaoJThh6S2+XApR/RsyPDkqcMF1wHm4xU+Dd3vqy920rc8shL16rMA+R2+wOLlTX3jc/ijqyoTfxgbFv9ZRDA/XgcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766512653; c=relaxed/simple;
	bh=fS/y7V1DWGJJ6yTGiMBH2J6unJqICyr0FDu2qnKiWWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bsp3mttTqEs3h43MMTuvJGorYkaoUCHS3kQduLBF8UAzLmqWbL2ESEtVynZcwSdzhlgVu4ZicPq6DrnNBQ40jYEX74YpCrTvC3CRVOAznl58cbOxEHTBWKzPKbcJBIL/5DePEoILXOhm33DWJ9gW5yZjgo7O0/0dhFsVszO57vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=npbzClcl; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id 069CA604A6;
	Tue, 23 Dec 2025 17:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1766512642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5e65IGpIhGqP5Bp1BDEsHKNZKGjWq/+tq7PdLVmUW0=;
	b=npbzClcl8kaXyFa96B1ZIk+8Eh2mJGPe27Q671JQPbl+AAIxn+Rpy7RDsJIODnsVZsco6a
	j2IozCx7S6Or2BIVhhfAkVQGwuruWNvnvUatm3E0zk9TONgPNjk1cscXtgbFiMW5sVoBeK
	cEst+8sVsPBhsE6EIj8oGqO5xpgsw7Q=
Received: from frank-u24.. (fttx-pool-217.61.156.193.bambit.de [217.61.156.193])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id BBCE2122700;
	Tue, 23 Dec 2025 17:57:21 +0000 (UTC)
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
	Balsam CHIHI <bchihi@baylibre.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/2] thermal/drivers/mediatek/lvts_thermal: Add mt7987 support
Date: Tue, 23 Dec 2025 18:56:27 +0100
Message-ID: <20251223175710.25850-3-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223175710.25850-1-linux@fw-web.de>
References: <20251223175710.25850-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Add support for MT7987.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v2:
- drop irq-enable member
- move mt7987 above mt7988
---
 drivers/thermal/mediatek/lvts_thermal.c | 36 +++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index ab55b20cda47..c345a6191715 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -85,6 +85,8 @@
 #define LVTS_GOLDEN_TEMP_DEFAULT	50
 #define LVTS_COEFF_A_MT8195			-250460
 #define LVTS_COEFF_B_MT8195			250460
+#define LVTS_COEFF_A_MT7987			-204650
+#define LVTS_COEFF_B_MT7987			204650
 #define LVTS_COEFF_A_MT7988			-204650
 #define LVTS_COEFF_B_MT7988			204650
 
@@ -1373,6 +1375,20 @@ static void lvts_remove(struct platform_device *pdev)
 		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], false);
 }
 
+static const struct lvts_ctrl_data mt7987_lvts_ap_data_ctrl[] = {
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT7987_CPU,
+			  .cal_offsets = { 0x04, 0x05, 0x06 } },
+			{ .dt_id = MT7987_ETH2P5G,
+			  .cal_offsets = { 0x08, 0x09, 0x0a } },
+		},
+		VALID_SENSOR_MAP(1, 1, 0, 0),
+		.offset = 0x0,
+		.mode = LVTS_MSR_FILTERED_MODE,
+	},
+};
+
 static const struct lvts_ctrl_data mt7988_lvts_ap_data_ctrl[] = {
 	{
 		.lvts_sensor = {
@@ -1455,6 +1471,12 @@ static const u32 default_init_cmds[] = {
 	0xC10300FC, 0xC103009D, 0xC10300F1, 0xC10300E1
 };
 
+static const u32 mt7987_init_cmds[] = {
+	0xC1030300, 0xC1030420, 0xC1030500, 0xC10307A6, 0xC10308C7,
+	0xC103098D, 0xC1030C7C, 0xC1030AA8, 0xC10308CE, 0xC10308C7,
+	0xC1030B04, 0xC1030E01, 0xC10306B8
+};
+
 static const u32 mt7988_init_cmds[] = {
 	0xC1030300, 0xC1030420, 0xC1030500, 0xC10307A6, 0xC1030CFC,
 	0xC1030A8C, 0xC103098D, 0xC10308F1, 0xC1030B04, 0xC1030E01,
@@ -1753,6 +1775,19 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 	}
 };
 
+static const struct lvts_data mt7987_lvts_ap_data = {
+	.lvts_ctrl	= mt7987_lvts_ap_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt7987_lvts_ap_data_ctrl),
+	.conn_cmd	= mt7988_conn_cmds,
+	.init_cmd	= mt7987_init_cmds,
+	.num_conn_cmd	= ARRAY_SIZE(mt7988_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(mt7987_init_cmds),
+	.temp_factor	= LVTS_COEFF_A_MT7987,
+	.temp_offset	= LVTS_COEFF_B_MT7987,
+	.gt_calib_bit_offset = 32,
+	.def_calibration = 19380,
+};
+
 static const struct lvts_data mt7988_lvts_ap_data = {
 	.lvts_ctrl	= mt7988_lvts_ap_data_ctrl,
 	.conn_cmd	= mt7988_conn_cmds,
@@ -1857,6 +1892,7 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 };
 
 static const struct of_device_id lvts_of_match[] = {
+	{ .compatible = "mediatek,mt7987-lvts-ap", .data = &mt7987_lvts_ap_data },
 	{ .compatible = "mediatek,mt7988-lvts-ap", .data = &mt7988_lvts_ap_data },
 	{ .compatible = "mediatek,mt8186-lvts", .data = &mt8186_lvts_data },
 	{ .compatible = "mediatek,mt8188-lvts-mcu", .data = &mt8188_lvts_mcu_data },
-- 
2.43.0


