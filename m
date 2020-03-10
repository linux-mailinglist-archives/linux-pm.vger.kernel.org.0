Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 255DF180433
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 18:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCJRBX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 13:01:23 -0400
Received: from vsp-unauthed02.binero.net ([195.74.38.227]:28498 "EHLO
        vsp-unauthed02.binero.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgCJRBX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 13:01:23 -0400
X-Halon-ID: beaacbdb-62f0-11ea-aa6d-005056917f90
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p4fca2392.dip0.t-ipconnect.de [79.202.35.146])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id beaacbdb-62f0-11ea-aa6d-005056917f90;
        Tue, 10 Mar 2020 18:01:12 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 2/3] thermal: rcar_thermal: Do not store ctemp in rcar_thermal_priv
Date:   Tue, 10 Mar 2020 18:00:28 +0100
Message-Id: <20200310170029.1648996-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310170029.1648996-1-niklas.soderlund+renesas@ragnatech.se>
References: <20200310170029.1648996-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no need to cache the ctemp value in the private data structure
as it's always prefetched before it's used. Remove it from the structure
and have rcar_thermal_update_temp return the value instead of storing
it.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_thermal.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index f379eb5f8b9ecd14..953dc28d1dd1d499 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -95,7 +95,6 @@ struct rcar_thermal_priv {
 	struct mutex lock;
 	struct list_head list;
 	int id;
-	u32 ctemp;
 };
 
 #define rcar_thermal_for_each_priv(pos, common)	\
@@ -201,7 +200,6 @@ static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
 	struct device *dev = rcar_priv_to_dev(priv);
 	int i;
 	u32 ctemp, old, new;
-	int ret = -EINVAL;
 
 	mutex_lock(&priv->lock);
 
@@ -247,32 +245,28 @@ static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
 						   ((ctemp - 1) << 0)));
 	}
 
-	dev_dbg(dev, "thermal%d  %d -> %d\n", priv->id, priv->ctemp, ctemp);
-
-	priv->ctemp = ctemp;
-	ret = 0;
 err_out_unlock:
 	mutex_unlock(&priv->lock);
-	return ret;
+
+	return ctemp ? ctemp : -EINVAL;
 }
 
 static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
 					 int *temp)
 {
-	int tmp;
-	int ret;
+	int ctemp, tmp;
 
-	ret = rcar_thermal_update_temp(priv);
-	if (ret < 0)
-		return ret;
+	ctemp = rcar_thermal_update_temp(priv);
+	if (ctemp < 0)
+		return ctemp;
 
 	mutex_lock(&priv->lock);
 	if (priv->chip->ctemp_bands == 1)
-		tmp = MCELSIUS((priv->ctemp * 5) - 65);
-	else if (priv->ctemp < 24)
-		tmp = MCELSIUS(((priv->ctemp * 55) - 720) / 10);
+		tmp = MCELSIUS((ctemp * 5) - 65);
+	else if (ctemp < 24)
+		tmp = MCELSIUS(((ctemp * 55) - 720) / 10);
 	else
-		tmp = MCELSIUS((priv->ctemp * 5) - 60);
+		tmp = MCELSIUS((ctemp * 5) - 60);
 	mutex_unlock(&priv->lock);
 
 	/* Guaranteed operating range is -45C to 125C. */
-- 
2.25.1

