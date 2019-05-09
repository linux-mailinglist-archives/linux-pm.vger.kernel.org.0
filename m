Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89C9318777
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 11:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfEIJJU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 05:09:20 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:46048 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfEIJJU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 05:09:20 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hOf3G-0000lU-Cj from Jiada_Wang@mentor.com ; Thu, 09 May 2019 02:09:18 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Thu, 9 May 2019 02:09:15 -0700
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiada_wang@mentor.com>
Subject: [PATCH 1/1] thermal: rcar_gen3_thermal: Fix to show correct trip points number
Date:   Thu, 9 May 2019 18:09:17 +0900
Message-ID: <20190509090917.26982-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently after store trip points number in 'ret', it is overwritten
afterwards, this cause incorrect trip point number always be shown in
the debug information after register of each thermal zone.

This patch fix this issue by moving get of trip number to
end of thermal zone registration.

Fixes: 6269e9f790e8d ("thermal: rcar_gen3_thermal: Register hwmon sysfs interface")
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 88fa41cf16e8..5083e602935c 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -433,10 +433,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		}
 		tsc->zone = zone;
 
-		ret = of_thermal_get_ntrips(tsc->zone);
-		if (ret < 0)
-			goto error_unregister;
-
 		tsc->zone->tzp->no_hwmon = false;
 		ret = thermal_add_hwmon_sysfs(tsc->zone);
 		if (ret)
@@ -448,6 +444,10 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 		}
 
+		ret = of_thermal_get_ntrips(tsc->zone);
+		if (ret < 0)
+			goto error_unregister;
+
 		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
 	}
 
-- 
2.19.2

