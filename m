Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D41F713B55D
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 23:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgANWhy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 17:37:54 -0500
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:11318 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727072AbgANWhy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 17:37:54 -0500
X-Halon-ID: 87a82090-371d-11ea-b6d8-005056917f90
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p54ac5d7b.dip0.t-ipconnect.de [84.172.93.123])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id 87a82090-371d-11ea-b6d8-005056917f90;
        Tue, 14 Jan 2020 23:30:56 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-pm@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 1/2] thermal: rcar_thermal: Remove temperature bound
Date:   Tue, 14 Jan 2020 23:29:44 +0100
Message-Id: <20200114222945.3128250-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114222945.3128250-1-niklas.soderlund+renesas@ragnatech.se>
References: <20200114222945.3128250-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The hardware manual states that the operation of the sensor is not
guaranteed outside the range of -40°C to 125°C, not that the readings
are invalid. Remove the bound check and try to deliver temperature
readings even if we are outside the guaranteed operation range.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_thermal.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index d0873de718da9218..2ae60b27a0183db1 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -275,13 +275,6 @@ static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
 		tmp = MCELSIUS((priv->ctemp * 5) - 60);
 	mutex_unlock(&priv->lock);
 
-	if ((tmp < MCELSIUS(-45)) || (tmp > MCELSIUS(125))) {
-		struct device *dev = rcar_priv_to_dev(priv);
-
-		dev_err(dev, "it couldn't measure temperature correctly\n");
-		return -EIO;
-	}
-
 	*temp = tmp;
 
 	return 0;
-- 
2.24.1

