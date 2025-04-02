Return-Path: <linux-pm+bounces-24720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E72A78A27
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 10:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A503E18888CA
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 08:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32A9234973;
	Wed,  2 Apr 2025 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KmhvrdUC"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0044A19F40F;
	Wed,  2 Apr 2025 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743583160; cv=none; b=hggBnJwgKQDKHANVg6Hrdy0n+lQHE0GZ/9P0SaQsJvDvSbnRDvIEpKVrye4d6JOweWC1SGiiZ5GVpQiE0GBIUe65StqatADR5dn5SnPNGbnKlBkYVyHi4gnXA4esrm9LIc5HjDE24bK2bSXH1XvcE0WdS53Fl0NViWCTBGND9Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743583160; c=relaxed/simple;
	bh=cQTnye/bMR3a4CIhuNYW2H7HVeU4bIvhzbyjX6kKvvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JpduhQoqpVS+/HgzYuEu7YPlt0aLjqLzJ5hFszal4GSLfFAiKP+vAym3ifoIgrBveaAPF6SAAv4g8+gtI9AHf3ic+gl3KFMK3S5tT8BwQ4uGAbuWlTyjq9fkLg0b+NlXl9QRyhei0dRL11qIqTehcuL0hp5uB/L4gZwXk3wTGJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KmhvrdUC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1743583155;
	bh=cQTnye/bMR3a4CIhuNYW2H7HVeU4bIvhzbyjX6kKvvA=;
	h=From:To:Cc:Subject:Date:From;
	b=KmhvrdUCWCt5GLrm0X0nDnXCINis0c3PO83VB3eTPmQOPZWd3Amw0zkdr97Coo3pi
	 tmsDGwV1FOlfZFQSbDW8Y+KuUvcH4HFBqhSl3FtA0saib8j6f5EQDopBNjxzxKkyHM
	 QkuuXW7nm87Itz8z/KjEJ4tJ5TkSJru8IcrhK0ESpa9mrIV78pHNKWSzVL6oplw+vV
	 Rguxt+IErwfc2b0UpvWoAJUxam/Baoy6l53GfqVYbUpuPn1sapymsts8a0y0Ruti8Z
	 2+nADxb4FjWoBku1Y4fQJKM3MWUkiz95h4ulbmiGA44tv4/ufZrQAlWbyMYJYZ2GXy
	 S5n3tqwAyYN7w==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3FBE617E0B0B;
	Wed,  2 Apr 2025 10:39:14 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: rafael@kernel.org
Cc: daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	npitre@baylibre.com,
	jpanis@baylibre.com,
	nfraprado@collabora.com,
	wenst@chromium.org,
	bchihi@baylibre.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] thermal/drivers/mediatek/lvts: Fix debugfs unregister on failure
Date: Wed,  2 Apr 2025 10:38:52 +0200
Message-ID: <20250402083852.20624-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running the probe function for this driver, the function
lvts_debugfs_init() gets called in lvts_domain_init() which, in
turn, gets called in lvts_probe() before registering threaded
interrupt handlers.

Even though it's unlikely, the last call may fail and, if it does,
there's nothing removing the already created debugfs folder and
files.

In order to fix that, instead of calling the lvts debugfs cleanup
function upon failure, register a devm action that will take care
of calling that upon failure or driver removal.

Since devm was used, also delete the call to lvts_debugfs_exit()
in the lvts_remove() callback, as now that's done automatically.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 088481d91e6e..c0be4ca55c7b 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -213,6 +213,13 @@ static const struct debugfs_reg32 lvts_regs[] = {
 	LVTS_DEBUG_FS_REGS(LVTS_CLKEN),
 };
 
+static void lvts_debugfs_exit(void *data)
+{
+	struct lvts_domain *lvts_td = data;
+
+	debugfs_remove_recursive(lvts_td->dom_dentry);
+}
+
 static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
 {
 	struct debugfs_regset32 *regset;
@@ -245,12 +252,7 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
 		debugfs_create_regset32("registers", 0400, dentry, regset);
 	}
 
-	return 0;
-}
-
-static void lvts_debugfs_exit(struct lvts_domain *lvts_td)
-{
-	debugfs_remove_recursive(lvts_td->dom_dentry);
+	return devm_add_action_or_reset(dev, lvts_debugfs_exit, lvts_td);
 }
 
 #else
@@ -1374,8 +1376,6 @@ static void lvts_remove(struct platform_device *pdev)
 
 	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
 		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], false);
-
-	lvts_debugfs_exit(lvts_td);
 }
 
 static const struct lvts_ctrl_data mt7988_lvts_ap_data_ctrl[] = {
-- 
2.48.1


