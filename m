Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8477140DBC
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 16:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAQPXK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 10:23:10 -0500
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:10076 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728884AbgAQPXK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 10:23:10 -0500
X-Halon-ID: 44108ffb-393d-11ea-a00b-005056917a89
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p54ac5d7b.dip0.t-ipconnect.de [84.172.93.123])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id 44108ffb-393d-11ea-a00b-005056917a89;
        Fri, 17 Jan 2020 16:23:08 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-pm@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 1/2] thermal: rcar_thermal: Remove temperature bound
Date:   Fri, 17 Jan 2020 16:22:41 +0100
Message-Id: <20200117152242.3804288-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117152242.3804288-1-niklas.soderlund+renesas@ragnatech.se>
References: <20200117152242.3804288-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The hardware manual states that the operation of the sensor is not
guaranteed outside the range of -45°C to 125°C, not that the readings
are invalid. Remove the bound check and try to deliver temperature
readings even if we are outside the guaranteed operation range.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
* Changes since v2
- Preserver the guaranteed operating range in a comment.
---
 drivers/thermal/rcar_thermal.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index d0873de718da9218..f9c1fa10e6a2b3fd 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -275,12 +275,7 @@ static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
 		tmp = MCELSIUS((priv->ctemp * 5) - 60);
 	mutex_unlock(&priv->lock);
 
-	if ((tmp < MCELSIUS(-45)) || (tmp > MCELSIUS(125))) {
-		struct device *dev = rcar_priv_to_dev(priv);
-
-		dev_err(dev, "it couldn't measure temperature correctly\n");
-		return -EIO;
-	}
+	/* Guaranteed operating ragne is -45C to 125C. */
 
 	*temp = tmp;
 
-- 
2.24.1

