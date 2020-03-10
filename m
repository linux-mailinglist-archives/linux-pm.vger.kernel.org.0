Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C89180436
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 18:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgCJRBX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 13:01:23 -0400
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:28504 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727138AbgCJRBX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 13:01:23 -0400
X-Halon-ID: bf03e7c3-62f0-11ea-aa6d-005056917f90
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p4fca2392.dip0.t-ipconnect.de [79.202.35.146])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id bf03e7c3-62f0-11ea-aa6d-005056917f90;
        Tue, 10 Mar 2020 18:01:12 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 3/3] thermal: rcar_thermal: Remove lock in rcar_thermal_get_current_temp()
Date:   Tue, 10 Mar 2020 18:00:29 +0100
Message-Id: <20200310170029.1648996-4-niklas.soderlund+renesas@ragnatech.se>
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

With the ctemp value returned instead of cached in the private data
structure their is no need to take the lock when translating ctemp into
a temperature.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_thermal.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 953dc28d1dd1d499..8bdcb449bd280a18 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -254,24 +254,20 @@ static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
 static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
 					 int *temp)
 {
-	int ctemp, tmp;
+	int ctemp;
 
 	ctemp = rcar_thermal_update_temp(priv);
 	if (ctemp < 0)
 		return ctemp;
 
-	mutex_lock(&priv->lock);
+	/* Guaranteed operating range is -45C to 125C. */
+
 	if (priv->chip->ctemp_bands == 1)
-		tmp = MCELSIUS((ctemp * 5) - 65);
+		*temp = MCELSIUS((ctemp * 5) - 65);
 	else if (ctemp < 24)
-		tmp = MCELSIUS(((ctemp * 55) - 720) / 10);
+		*temp = MCELSIUS(((ctemp * 55) - 720) / 10);
 	else
-		tmp = MCELSIUS((ctemp * 5) - 60);
-	mutex_unlock(&priv->lock);
-
-	/* Guaranteed operating range is -45C to 125C. */
-
-	*temp = tmp;
+		*temp = MCELSIUS((ctemp * 5) - 60);
 
 	return 0;
 }
-- 
2.25.1

