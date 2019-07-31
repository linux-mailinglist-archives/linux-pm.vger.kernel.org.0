Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F384A7C227
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 14:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfGaMu6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 08:50:58 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:38516 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfGaMu5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 08:50:57 -0400
Received: from ramsan ([84.194.98.4])
        by michel.telenet-ops.be with bizsmtp
        id jQqv2000C05gfCL06Qqv77; Wed, 31 Jul 2019 14:50:55 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hso4F-0000cX-Fr; Wed, 31 Jul 2019 14:50:55 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hso4F-0003qe-Dl; Wed, 31 Jul 2019 14:50:55 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] thermal: rcar_gen3_thermal: Use devm_add_action_or_reset() helper
Date:   Wed, 31 Jul 2019 14:50:53 +0200
Message-Id: <20190731125053.14750-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the devm_add_action_or_reset() helper instead of open-coding the
same operations.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/thermal/rcar_gen3_thermal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index a56463308694e937..2db7e7f8baf939fd 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -443,11 +443,10 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		if (ret)
 			goto error_unregister;
 
-		ret = devm_add_action(dev, rcar_gen3_hwmon_action, zone);
-		if (ret) {
-			rcar_gen3_hwmon_action(zone);
+		ret = devm_add_action_or_reset(dev, rcar_gen3_hwmon_action,
+					       zone);
+		if (ret)
 			goto error_unregister;
-		}
 
 		ret = of_thermal_get_ntrips(tsc->zone);
 		if (ret < 0)
-- 
2.17.1

