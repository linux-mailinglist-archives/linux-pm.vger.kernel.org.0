Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D515B40E
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 23:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgBLWrn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 17:47:43 -0500
Received: from vsp-unauthed02.binero.net ([195.74.38.227]:29866 "EHLO
        vsp-unauthed02.binero.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLWrn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 17:47:43 -0500
X-Halon-ID: a77b4be1-4de9-11ea-aa6d-005056917f90
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p4fca2392.dip0.t-ipconnect.de [79.202.35.146])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id a77b4be1-4de9-11ea-aa6d-005056917f90;
        Wed, 12 Feb 2020 23:47:39 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] thermal: rcar_gen3_thermal: Remove unneeded curly brackets
Date:   Wed, 12 Feb 2020 23:47:32 +0100
Message-Id: <20200212224732.736785-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When devm_add_action() was turned into devm_add_action_or_reset() the
curly brackets for the error case where kept but are not needed, remove
them to match the style of the driver.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 55d1736f532cdb33..a2bf9d8074cc4fcf 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -444,9 +444,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 
 		ret = devm_add_action_or_reset(dev, rcar_gen3_hwmon_action, zone);
-		if (ret) {
+		if (ret)
 			goto error_unregister;
-		}
 
 		ret = of_thermal_get_ntrips(tsc->zone);
 		if (ret < 0)
-- 
2.25.0

