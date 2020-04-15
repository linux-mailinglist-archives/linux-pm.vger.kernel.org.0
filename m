Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FE51AAF75
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 19:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410927AbgDORX5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Apr 2020 13:23:57 -0400
Received: from vsp-unauthed02.binero.net ([195.74.38.227]:17110 "EHLO
        vsp-unauthed02.binero.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410926AbgDORX4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2020 13:23:56 -0400
X-Halon-ID: dad1c5e3-7f3d-11ea-aeed-005056917f90
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p4fca2392.dip0.t-ipconnect.de [79.202.35.146])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id dad1c5e3-7f3d-11ea-aeed-005056917f90;
        Wed, 15 Apr 2020 19:23:45 +0200 (CEST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] thermal: rcar_thermal: Clean up rcar_thermal_update_temp()
Date:   Wed, 15 Apr 2020 19:23:49 +0200
Message-Id: <20200415172349.2185096-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Moving the ctemp variable out of the private data structure made it
possible to clean up rcar_thermal_update_temp(). Initialize the local
ctemp to the error code to return if the reading fails and just return
it at the end of the function.

It's OK to change the datatype of old, new and ctemp to int as all
values are AND with CTEMP (0x3f) before being stored. While at it
change the datatype of the loop variable 'i' to to unsigned int.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_thermal.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index e0c1f2409035e2bb..3c0c86b0664ec57f 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -198,8 +198,8 @@ static void _rcar_thermal_bset(struct rcar_thermal_priv *priv, u32 reg,
 static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
 {
 	struct device *dev = rcar_priv_to_dev(priv);
-	int i;
-	u32 ctemp, old, new;
+	int old, new, ctemp = -EINVAL;
+	unsigned int i;
 
 	mutex_lock(&priv->lock);
 
@@ -209,7 +209,6 @@ static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
 	 */
 	rcar_thermal_bset(priv, THSCR, CPCTL, CPCTL);
 
-	ctemp = 0;
 	old = ~0;
 	for (i = 0; i < 128; i++) {
 		/*
@@ -227,7 +226,7 @@ static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
 		old = new;
 	}
 
-	if (!ctemp) {
+	if (ctemp == -EINVAL) {
 		dev_err(dev, "thermal sensor was broken\n");
 		goto err_out_unlock;
 	}
@@ -248,7 +247,7 @@ static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
 err_out_unlock:
 	mutex_unlock(&priv->lock);
 
-	return ctemp ? ctemp : -EINVAL;
+	return ctemp;
 }
 
 static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
-- 
2.26.0

