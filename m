Return-Path: <linux-pm+bounces-33468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A85B3CC72
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 17:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA513A8FC3
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2100627F19B;
	Sat, 30 Aug 2025 15:57:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D7D27E1AC;
	Sat, 30 Aug 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756569448; cv=none; b=u3qtH70XCbzANZRKpr/aYHSPWxogDFmeU2bOGyDwaT0uwL3dHSt4sUpa5KJRn6hM0xl4U2AADVD/4yuwkp8SpwvG4g7+4a4SrSvg3T0BcmY12Y311cJEzkuUnmwNSFY/vBgtATCSS0bhiNWhS14Q1Fa5J2Q+hJiGikD4/76L0S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756569448; c=relaxed/simple;
	bh=wESNMmETSujCZDADuk72y+hfY7Tabce4sDTR2e+7eYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPilXwLUgBZsQ6RVa/HW1bRw56O01w6mHn/r4YTI1EmAOvHFGjscUdkTKzzchBYKGsfxbWpp907XD+kvvjYxqz7OdCOD2N97SbsNr+p0kl81/RZFigIc2LMuJrOkHsu6MKhW3VpmuQNV1d/Q7lwLhb6R9UmXIuuHqk6wyEWI6jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1usNxA-000000007rf-2P6a;
	Sat, 30 Aug 2025 15:57:20 +0000
Date: Sat, 30 Aug 2025 16:57:17 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mason Chang <mason-cw.chang@mediatek.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Frank Wunderlich <frank-w@public-files.de>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Chad Monroe <chad.monroe@adtran.com>
Subject: [PATCH linux-stable 6.12 3/3] thermal/drivers/mediatek/lvts_thermal:
 Add mt7988 lvts commands
Message-ID: <253c49132453481a74fa3ef59f0b85a51bc9d4c6.1756568900.git.daniel@makrotopia.org>
References: <cover.1756568900.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756568900.git.daniel@makrotopia.org>

From: Mason Chang <mason-cw.chang@mediatek.com>

[ Upstream commit 685a755089f95b7e205c0202567d9a647f9de096 ]

These commands are necessary to avoid severely abnormal and inaccurate
temperature readings that are caused by using the default commands.

Fixes: 585e92e6a79f ("thermal/drivers/mediatek/lvts_thermal: Add mt7988 support")
Signed-off-by: Mason Chang <mason-cw.chang@mediatek.com>
Link: https://lore.kernel.org/r/20250526102659.30225-4-mason-cw.chang@mediatek.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 239476152bab..017191b9f864 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1421,6 +1421,8 @@ static int lvts_resume(struct device *dev)
 }
 
 static const u32 default_conn_cmds[] = { 0xC103FFFF, 0xC502FF55 };
+static const u32 mt7988_conn_cmds[] = { 0xC103FFFF, 0xC502FC55 };
+
 /*
  * Write device mask: 0xC1030000
  */
@@ -1431,6 +1433,12 @@ static const u32 default_init_cmds[] = {
 	0xC10300FC, 0xC103009D, 0xC10300F1, 0xC10300E1
 };
 
+static const u32 mt7988_init_cmds[] = {
+	0xC1030300, 0xC1030420, 0xC1030500, 0xC10307A6, 0xC1030CFC,
+	0xC1030A8C, 0xC103098D, 0xC10308F1, 0xC1030B04, 0xC1030E01,
+	0xC10306B8
+};
+
 /*
  * The MT8186 calibration data is stored as packed 3-byte little-endian
  * values using a weird layout that makes sense only when viewed as a 32-bit
@@ -1725,11 +1733,11 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 
 static const struct lvts_data mt7988_lvts_ap_data = {
 	.lvts_ctrl	= mt7988_lvts_ap_data_ctrl,
-	.conn_cmd	= default_conn_cmds,
-	.init_cmd	= default_init_cmds,
+	.conn_cmd	= mt7988_conn_cmds,
+	.init_cmd	= mt7988_init_cmds,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt7988_lvts_ap_data_ctrl),
-	.num_conn_cmd	= ARRAY_SIZE(default_conn_cmds),
-	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
+	.num_conn_cmd	= ARRAY_SIZE(mt7988_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(mt7988_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT7988,
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 	.gt_calib_bit_offset = 24,
-- 
2.51.0

