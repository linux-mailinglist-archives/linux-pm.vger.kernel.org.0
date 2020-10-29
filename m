Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2555D29E832
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 11:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgJ2KDZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 06:03:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40886 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgJ2KDZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 06:03:25 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09TA32wW123130;
        Thu, 29 Oct 2020 05:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603965782;
        bh=k7KeTw+EPvwPumccHtCxA1SYp/jRuceL5dhcjH6gfkg=;
        h=From:To:CC:Subject:Date;
        b=vxXP+sYNSe0O7y+sCRHhOCADDgKYVw7d+eV3qCPM7z6Q+BL7tsUj3cDtTvMArX5is
         AHdkKLtCkWKGbU+ggOaBGPE/br0ETir3tVBiqXZ6RgU6XJ1gBsYTdDBxHt+tu5Ssg+
         fbz9OltPKP7So4YILIcGh6xkvxSI/MFf219x9AHE=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09TA32f9070566
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 05:03:02 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 29
 Oct 2020 05:03:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 29 Oct 2020 05:03:01 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09TA2wNj093779;
        Thu, 29 Oct 2020 05:02:59 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <edubezval@gmail.com>, <j-keerthy@ti.com>, <aford173@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <andreas@kemnade.info>,
        <tony@atomide.com>, <daniel.lezcano@linaro.org>
Subject: [PATCH] thermal: ti-soc-thermal: Disable the CPU PM notifier for OMAP4430
Date:   Thu, 29 Oct 2020 12:03:35 +0200
Message-ID: <20201029100335.27665-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It has been observed that on OMAP4430 (ES2.0, ES2.1 and ES2.3) the enabled
notifier causes errors on the DTEMP readout values:

ti-soc-thermal 4a002260.bandgap: in range ADC val: 52
ti-soc-thermal 4a002260.bandgap: in range ADC val: 64
ti-soc-thermal 4a002260.bandgap: in range ADC val: 64
ti-soc-thermal 4a002260.bandgap: out of range ADC val: 0
thermal thermal_zone0: failed to read out thermal zone (-5)
ti-soc-thermal 4a002260.bandgap: out of range ADC val: 0
thermal thermal_zone0: failed to read out thermal zone (-5)
ti-soc-thermal 4a002260.bandgap: out of range ADC val: 4
thermal thermal_zone0: failed to read out thermal zone (-5)
ti-soc-thermal 4a002260.bandgap: in range ADC val: 100

raw 100 translates to 133 Celsius on omap4-sdp, triggering shutdown due to
critical temperature.

When the notifier is disable for OMAP4430 the DTEMP values are stable:
ti-soc-thermal 4a002260.bandgap: in range ADC val: 56
ti-soc-thermal 4a002260.bandgap: in range ADC val: 56
ti-soc-thermal 4a002260.bandgap: in range ADC val: 57
ti-soc-thermal 4a002260.bandgap: in range ADC val: 57
ti-soc-thermal 4a002260.bandgap: in range ADC val: 56

Fixes: 5093402e5b44 ("thermal: ti-soc-thermal: Enable addition power management")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

my omap4-sdp (Blaze) was shutting down randomly due to critical temperature with
5.10-rc1 and I have bisected it back to 5093402e5b44.

Disabling the notifier fixes the random shutdowns on OMAP4430 (ES2.0 and ES2.1)
but it does not cause any issues on OMAP4460 (PandaES) or OMAP3630 (BeagleXM).
Tony's duovero with OMAP4430 ES2.3 did not ninja-shutdown, but he also have
constant and steady stream of:
thermal thermal_zone0: failed to read out thermal zone (-5)

pointing to similar issue.

Regards,
Peter

 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 5e596168ba73..dcac99f327b0 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/types.h>
 #include <linux/spinlock.h>
+#include <linux/sys_soc.h>
 #include <linux/reboot.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
@@ -864,6 +865,17 @@ static struct ti_bandgap *ti_bandgap_build(struct platform_device *pdev)
 	return bgp;
 }
 
+/*
+ * List of SoCs on which the CPU PM notifier can cause erros on the DTEMP
+ * readout.
+ * Enabled notifier on these machines results in erroneous, random values which
+ * could trigger unexpected thermal shutdown.
+ */
+static const struct soc_device_attribute soc_no_cpu_notifier[] = {
+	{ .machine = "OMAP4430" },
+	{ /* sentinel */ },
+};
+
 /***   Device driver call backs   ***/
 
 static
@@ -1020,7 +1032,8 @@ int ti_bandgap_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_PM_SLEEP
 	bgp->nb.notifier_call = bandgap_omap_cpu_notifier;
-	cpu_pm_register_notifier(&bgp->nb);
+	if (!soc_device_match(soc_no_cpu_notifier))
+		cpu_pm_register_notifier(&bgp->nb);
 #endif
 
 	return 0;
@@ -1056,7 +1069,8 @@ int ti_bandgap_remove(struct platform_device *pdev)
 	struct ti_bandgap *bgp = platform_get_drvdata(pdev);
 	int i;
 
-	cpu_pm_unregister_notifier(&bgp->nb);
+	if (!soc_device_match(soc_no_cpu_notifier))
+		cpu_pm_unregister_notifier(&bgp->nb);
 
 	/* Remove sensor interfaces */
 	for (i = 0; i < bgp->conf->sensor_count; i++) {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

