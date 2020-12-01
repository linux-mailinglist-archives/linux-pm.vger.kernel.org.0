Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4102CA2FC
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 13:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgLAMni (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 07:43:38 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:47935 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbgLAMni (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Dec 2020 07:43:38 -0500
Received: from tnuva.tkos.co.il (unknown [10.0.4.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPSA id 14B3C4400C5;
        Tue,  1 Dec 2020 14:42:56 +0200 (IST)
From:   Jonathan Ben-Avraham <yba@tkos.co.il>
To:     linux-pm@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Jonathan Ben-Avraham <yba@tkos.co.il>
Subject: [PATCH] thermal: armada: hwmon support for new DT binding.
Date:   Tue,  1 Dec 2020 14:42:46 +0200
Message-Id: <20201201124246.16381-1-yba@tkos.co.il>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For legacy DT binding the armada driver calls
thermal_zone_device_register(), which registers the hwmon device.
For new DT bindings, devm_thermal_add_hwmon_sysfs() must be called
explicitly.

Fixes: c9899c183921f (thermal: armada: use the resource managed
registration helper alternative)

Signed-off-by: Jonathan Ben-Avraham <yba@tkos.co.il>
---
 drivers/thermal/armada_thermal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c2ebfb5be4b3..57f8d0df126f 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 
 #include "thermal_core.h"
+#include "thermal_hwmon.h"
 
 /* Thermal Manager Control and Status Register */
 #define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
@@ -945,6 +946,10 @@ static int armada_thermal_probe(struct platform_device *pdev)
 		 */
 		if (irq > 0 && !priv->overheat_sensor)
 			armada_configure_overheat_int(priv, tz, sensor->id);
+
+		if (devm_thermal_add_hwmon_sysfs(tz))
+			dev_warn(&pdev->dev,
+				"Failed to add hwmon sysfs attributes\n");
 	}
 
 	/* Just complain if no overheat interrupt was set up */
-- 
2.11.0

