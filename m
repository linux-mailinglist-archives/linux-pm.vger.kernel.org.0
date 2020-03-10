Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E3C180435
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 18:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgCJRBY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 13:01:24 -0400
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:28488 "EHLO
        bin-mail-out-06.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727171AbgCJRBX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 13:01:23 -0400
X-Halon-ID: be57ab94-62f0-11ea-aa6d-005056917f90
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p4fca2392.dip0.t-ipconnect.de [79.202.35.146])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id be57ab94-62f0-11ea-aa6d-005056917f90;
        Tue, 10 Mar 2020 18:01:11 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 1/3] thermal: rcar_thermal: Always update thermal zone on interrupt
Date:   Tue, 10 Mar 2020 18:00:27 +0100
Message-Id: <20200310170029.1648996-2-niklas.soderlund+renesas@ragnatech.se>
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

Since commit a1ade5653804b8eb ("thermal: rcar: check every
rcar_thermal_update_temp() return value") the temperature is always read
in rcar_thermal_get_current_temp() so comparing it before and after
enabling interrupts have little effect. Remove the check and always
update the thermal zone when we get an interrupt that the temperature
have changed.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_thermal.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 8f1aafa2044e5ba7..f379eb5f8b9ecd14 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -387,28 +387,17 @@ static void _rcar_thermal_irq_ctrl(struct rcar_thermal_priv *priv, int enable)
 static void rcar_thermal_work(struct work_struct *work)
 {
 	struct rcar_thermal_priv *priv;
-	int cctemp, nctemp;
 	int ret;
 
 	priv = container_of(work, struct rcar_thermal_priv, work.work);
 
-	ret = rcar_thermal_get_current_temp(priv, &cctemp);
-	if (ret < 0)
-		return;
-
 	ret = rcar_thermal_update_temp(priv);
 	if (ret < 0)
 		return;
 
 	rcar_thermal_irq_enable(priv);
 
-	ret = rcar_thermal_get_current_temp(priv, &nctemp);
-	if (ret < 0)
-		return;
-
-	if (nctemp != cctemp)
-		thermal_zone_device_update(priv->zone,
-					   THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_update(priv->zone, THERMAL_EVENT_UNSPECIFIED);
 }
 
 static u32 rcar_thermal_had_changed(struct rcar_thermal_priv *priv, u32 status)
-- 
2.25.1

