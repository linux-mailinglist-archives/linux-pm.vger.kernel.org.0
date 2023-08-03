Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92BD76E076
	for <lists+linux-pm@lfdr.de>; Thu,  3 Aug 2023 08:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjHCGnv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Aug 2023 02:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjHCGno (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Aug 2023 02:43:44 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA9D3594;
        Wed,  2 Aug 2023 23:43:32 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3736hQQL092032;
        Thu, 3 Aug 2023 01:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691045006;
        bh=aMJt1BSQ70+nAqZv3DfY2aWRMBDxpF2RibSYxbtwTKA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qOqh6TAkfM6gYmvB99+yKIcp2eQdY3Na/uJ3F3InUuq+z3xExALC1sFefdq7xQCG4
         wu07RWI34uY5EaFn8+FWSs72jr4JdoEn8zHw4b+mytcB7Fwb/wnbDoJh4ev74dJZC2
         a5rlKD6mz2sYgeDWQUWJ3Io+yoC30l+7xJadrzdY=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3736hQcP024916
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 01:43:26 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 01:43:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 01:43:25 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3736hPf8018756;
        Thu, 3 Aug 2023 01:43:25 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        "Santosh Shilimkar" <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Praneeth Bajjuri" <praneeth@ti.com>,
        Tony Lindgren <tony@atomide.com>, Dhruva Gole <d-gole@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>, Georgi Vlaev <g-vlaev@ti.com>
Subject: [PATCH V6 4/4] firmware: ti_sci: Introduce system suspend resume support
Date:   Thu, 3 Aug 2023 12:12:47 +0530
Message-ID: <20230803064247.503036-5-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803064247.503036-1-d-gole@ti.com>
References: <20230803064247.503036-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce system suspend resume calls that will allow the ti_sci
driver to support deep sleep low power mode when the user space issues a
suspend to mem.

Also, write a ti_sci_prepare_system_suspend call to be used in the driver
suspend handler to allow the system to identify the low power mode being
entered and if necessary, send TISCI_MSG_PREPARE_SLEEP with information
about the mode is being entered and the address for allocated memory for
storing the context during Deep Sleep.

We're using "pm_suspend_target_state" to map the kernel's target suspend
state to SysFW low power mode. Make sure this is available only when
CONFIG_SUSPEND is enabled.

Co-developed-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/firmware/ti_sci.c | 63 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 0334ade19868..172b726e00a6 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/soc/ti/ti-msgmgr.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/suspend.h>
 #include <linux/reboot.h>
 
 #include "ti_sci.h"
@@ -3521,6 +3522,67 @@ static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
 	return NOTIFY_BAD;
 }
 
+static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
+{
+#if IS_ENABLED(CONFIG_SUSPEND)
+	u8 mode;
+
+	/* Map and validate the target Linux suspend state to TISCI LPM. */
+	switch (pm_suspend_target_state) {
+	case PM_SUSPEND_MEM:
+		/* S2MEM is not supported by the firmware. */
+		if (!(info->fw_caps & MSG_FLAG_CAPS_LPM_DEEP_SLEEP))
+			return 0;
+		mode = TISCI_MSG_VALUE_SLEEP_MODE_DEEP_SLEEP;
+		break;
+	default:
+		/*
+		 * Do not fail if we don't have action to take for a
+		 * specific suspend mode.
+		 */
+		return 0;
+	}
+
+	return ti_sci_cmd_prepare_sleep(&info->handle, mode,
+					(u32)(info->ctx_mem_addr & 0xffffffff),
+					(u32)((u64)info->ctx_mem_addr >> 32), 0);
+#else
+	return 0;
+#endif
+}
+
+static int ti_sci_suspend(struct device *dev)
+{
+	struct ti_sci_info *info = dev_get_drvdata(dev);
+	int ret;
+
+	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_ENABLE);
+	if (ret)
+		return ret;
+	dev_dbg(dev, "%s: set I/O isolation: %d\n", __func__, ret);
+
+	ret = ti_sci_prepare_system_suspend(info);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ti_sci_resume(struct device *dev)
+{
+	struct ti_sci_info *info = dev_get_drvdata(dev);
+	int ret;
+
+	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_DISABLE);
+	if (ret)
+		return ret;
+	dev_dbg(dev, "%s: disable I/O isolation: %d\n", __func__, ret);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ti_sci_pm_ops, ti_sci_suspend, ti_sci_resume);
+
 static int ti_sci_init_suspend(struct platform_device *pdev,
 			       struct ti_sci_info *info)
 {
@@ -3759,6 +3821,7 @@ static struct platform_driver ti_sci_driver = {
 	.driver = {
 		   .name = "ti-sci",
 		   .of_match_table = of_match_ptr(ti_sci_of_match),
+		   .pm = &ti_sci_pm_ops,
 	},
 };
 module_platform_driver(ti_sci_driver);
-- 
2.34.1

