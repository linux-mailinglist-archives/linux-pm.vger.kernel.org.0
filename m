Return-Path: <linux-pm+bounces-33466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F87B3CC6E
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 17:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B4A1BA29A7
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FA0265296;
	Sat, 30 Aug 2025 15:57:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAE524EA90;
	Sat, 30 Aug 2025 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756569428; cv=none; b=UFSm3+PgGDQomC0t0hOPjFugQRjTy7rqDB5maIfDy7EQ7bKu1fJvRNiA+QXIb4lcyz6dZdNQ0fsuJyT+OcjOONTcBNBuA1+uTs1FNBgxoKlgT+1VBjALALJS0A4yPz0nOJhH+LdXYtGosm5xFu5C6dZHs2nEeVEez3faXq2fDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756569428; c=relaxed/simple;
	bh=TR3dYiXJaEpl0M5QPz3NRcBIUcRMr2+x6i8Z5eZSKvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2FsMLtH7LthueBLxD3vM/kqgcA6/yRVh+9BrWy/CPTu3jntFwocr0vlk5mBibl2WhvMLYxtNuvVRpM04JJyxvjuQJebtBPSVsMK7O9215XkU0BJB+SwUUhuwQWEFpVAp7MrzB7qYKzo9B22rfU/yOsGeIyXIXK3HayBYEoqFqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1usNwq-000000007q1-1HU3;
	Sat, 30 Aug 2025 15:57:00 +0000
Date: Sat, 30 Aug 2025 16:56:56 +0100
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
Subject: [PATCH linux-stable 6.12 1/3] thermal/drivers/mediatek/lvts_thermal:
 Change lvts commands array to static const
Message-ID: <aa993c1f03ad73680879c04ab7fbe72aa04ce9db.1756568900.git.daniel@makrotopia.org>
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

[ Upstream commit c5d5a72c01f7faabe7cc0fd63942c18372101daf ]

Change the LVTS commands array to static const in preparation for
adding different commands.

Fixes: 585e92e6a79f ("thermal/drivers/mediatek/lvts_thermal: Add mt7988 support")
Signed-off-by: Mason Chang <mason-cw.chang@mediatek.com>
Link: https://lore.kernel.org/r/20250526102659.30225-2-mason-cw.chang@mediatek.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 29 +++++++++++++------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index ae063d1bc95f..c24b76bcd18a 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -92,6 +92,17 @@
 
 #define LVTS_MINIMUM_THRESHOLD		20000
 
+static const u32 default_conn_cmds[] = { 0xC103FFFF, 0xC502FF55 };
+/*
+ * Write device mask: 0xC1030000
+ */
+static const u32 default_init_cmds[] = {
+	0xC1030E01, 0xC1030CFC, 0xC1030A8C, 0xC103098D, 0xC10308F1,
+	0xC10307A6, 0xC10306B8, 0xC1030500, 0xC1030420, 0xC1030300,
+	0xC1030030, 0xC10300F6, 0xC1030050, 0xC1030060, 0xC10300AC,
+	0xC10300FC, 0xC103009D, 0xC10300F1, 0xC10300E1
+};
+
 static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
 static int golden_temp_offset;
 
@@ -880,7 +891,7 @@ static void lvts_ctrl_monitor_enable(struct device *dev, struct lvts_ctrl *lvts_
  * each write in the configuration register must be separated by a
  * delay of 2 us.
  */
-static void lvts_write_config(struct lvts_ctrl *lvts_ctrl, u32 *cmds, int nr_cmds)
+static void lvts_write_config(struct lvts_ctrl *lvts_ctrl, const u32 *cmds, int nr_cmds)
 {
 	int i;
 
@@ -963,9 +974,9 @@ static int lvts_ctrl_set_enable(struct lvts_ctrl *lvts_ctrl, int enable)
 
 static int lvts_ctrl_connect(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 {
-	u32 id, cmds[] = { 0xC103FFFF, 0xC502FF55 };
+	u32 id;
 
-	lvts_write_config(lvts_ctrl, cmds, ARRAY_SIZE(cmds));
+	lvts_write_config(lvts_ctrl, default_conn_cmds, ARRAY_SIZE(default_conn_cmds));
 
 	/*
 	 * LVTS_ID : Get ID and status of the thermal controller
@@ -984,17 +995,7 @@ static int lvts_ctrl_connect(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 
 static int lvts_ctrl_initialize(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 {
-	/*
-	 * Write device mask: 0xC1030000
-	 */
-	u32 cmds[] = {
-		0xC1030E01, 0xC1030CFC, 0xC1030A8C, 0xC103098D, 0xC10308F1,
-		0xC10307A6, 0xC10306B8, 0xC1030500, 0xC1030420, 0xC1030300,
-		0xC1030030, 0xC10300F6, 0xC1030050, 0xC1030060, 0xC10300AC,
-		0xC10300FC, 0xC103009D, 0xC10300F1, 0xC10300E1
-	};
-
-	lvts_write_config(lvts_ctrl, cmds, ARRAY_SIZE(cmds));
+	lvts_write_config(lvts_ctrl, default_init_cmds, ARRAY_SIZE(default_init_cmds));
 
 	return 0;
 }
-- 
2.51.0

