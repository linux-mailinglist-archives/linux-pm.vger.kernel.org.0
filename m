Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4CD24994D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 11:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgHSJ1Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Aug 2020 05:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHSJ1Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2020 05:27:24 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29A5C061757
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 02:27:23 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id HMTK230054C55Sk01MTKZ4; Wed, 19 Aug 2020 11:27:19 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8KNL-0007ty-54; Wed, 19 Aug 2020 11:27:19 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8KNL-0000qQ-2m; Wed, 19 Aug 2020 11:27:19 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] thermal: rcar_thermal: Add missing braces to conditional statement
Date:   Wed, 19 Aug 2020 11:27:16 +0200
Message-Id: <20200819092716.3191-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to Documentation/process/coding-style.rst, if one branch of a
conditional statement needs braces, both branches should use braces.

Fixes: bbcf90c0646ac797 ("thermal: Explicitly enable non-changing thermal zone devices")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/thermal/rcar_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 787710bb88fee890..5c2a13bf249ccb87 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -546,11 +546,11 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto error_unregister;
 
-		if (chip->use_of_thermal)
+		if (chip->use_of_thermal) {
 			priv->zone = devm_thermal_zone_of_sensor_register(
 						dev, i, priv,
 						&rcar_thermal_zone_of_ops);
-		else {
+		} else {
 			priv->zone = thermal_zone_device_register(
 						"rcar_thermal",
 						1, 0, priv,
-- 
2.17.1

