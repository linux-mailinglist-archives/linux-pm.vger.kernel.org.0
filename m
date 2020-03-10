Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 462BE17F6A1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 12:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgCJLr1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 07:47:27 -0400
Received: from vsp-unauthed02.binero.net ([195.74.38.227]:26984 "EHLO
        vsp-unauthed02.binero.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgCJLr1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 07:47:27 -0400
X-Halon-ID: e5b57f30-62c4-11ea-9f85-005056917a89
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p4fca2392.dip0.t-ipconnect.de [79.202.35.146])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id e5b57f30-62c4-11ea-9f85-005056917a89;
        Tue, 10 Mar 2020 12:47:24 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] thermal: rcar_thermal: Handle probe error gracefully
Date:   Tue, 10 Mar 2020 12:47:09 +0100
Message-Id: <20200310114709.1483860-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If the common register memory resource is not available the driver needs
to fail gracefully to disable PM. Instead of returning the error
directly store it in ret and use the already existing error path.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_thermal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 8f1aafa2044e5ba7..4a48d1d2a31c9250 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -521,8 +521,10 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			res = platform_get_resource(pdev, IORESOURCE_MEM,
 						    mres++);
 			common->base = devm_ioremap_resource(dev, res);
-			if (IS_ERR(common->base))
-				return PTR_ERR(common->base);
+			if (IS_ERR(common->base)) {
+				ret = PTR_ERR(common->base);
+				goto error_unregister;
+			}
 
 			idle = 0; /* polling delay is not needed */
 		}
-- 
2.25.1

