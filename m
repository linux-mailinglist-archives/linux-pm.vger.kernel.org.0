Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EEE2C218F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 10:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbgKXJgh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 04:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731329AbgKXJgh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 04:36:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318D0C0613D6
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2020 01:36:37 -0800 (PST)
Date:   Tue, 24 Nov 2020 09:36:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606210595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpK3ZOcc9IN3mbPVIFozPu3q/CF/W1GZ9Jktq79y/8M=;
        b=UsmyA/WFhOseeKjKxWM6LzMuTEbDfgOtHXPQExs9cD9v6kDj5mPyVYwqA8XATz6y6scpfh
        BqwBU/te3uViw8VP/2lcDksLVCxGCGHqF0n5viNrAHMs9/P0CTtGkRlOSM4zts6PSeeVLp
        3OO7ROEPUBIhL3JEoSVTSPSblUOSHu5Dl6mzxYIAP+y/MQed+lupVhi5Zt4z7b5IAIHrfa
        wHRNATEO3u8Y/8+/neL7pmhl7siLbYK4Oh4Fxiw0euUVW4I1P/wB+zs5b3aPJAM8HVTIqc
        1Rd26ahZOowAA2vFjB438eCTAwDP65MfOZpGB4hBvl4o7wAJTl8/3QLw9+wqqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606210595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpK3ZOcc9IN3mbPVIFozPu3q/CF/W1GZ9Jktq79y/8M=;
        b=KMSlBG2rMTSKlN7sTyn9HC+uuXqn3jjCRAGq059b1SWyrAymNAORgrQvgoJ56MnTF8frlN
        ILOeLbKI+5lWCeBg==
From:   "thermal-bot for Martin Blumenstingl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: amlogic: Add hwmon support
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201115190658.631578-1-martin.blumenstingl@googlemail.com>
References: <20201115190658.631578-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Message-ID: <160621059356.11115.5710672427369092678.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     cb68a8580e2086fad38597af4c60d39de8df0cde
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//cb68a8580e2086fad38597af4c60d39de8df0cde
Author:        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
AuthorDate:    Sun, 15 Nov 2020 20:06:58 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 16 Nov 2020 10:30:53 +01:00

thermal: amlogic: Add hwmon support

Many monitoring tools read the CPU temperature using the hwmon
interface. Expose the thermal sensors on Amlogic boards as hwmon
devices.

Without this lm_sensors' "sensors" tool does not find any temperature
sensors. Now it prints:
  cpu_thermal-virtual-0
  Adapter: Virtual device
  temp1:        +44.7 C  (crit = +110.0 C)

  ddr_thermal-virtual-0
  Adapter: Virtual device
  temp1:        +45.9 C  (crit = +110.0 C)

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201115190658.631578-1-martin.blumenstingl@googlemail.com
---
 drivers/thermal/amlogic_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index ccb1fe1..dffe3ba 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -29,6 +29,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
+#include "thermal_hwmon.h"
 
 #define TSENSOR_CFG_REG1			0x4
 	#define TSENSOR_CFG_REG1_RSET_VBG	BIT(12)
@@ -287,6 +288,9 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (devm_thermal_add_hwmon_sysfs(pdata->tzd))
+		dev_warn(&pdev->dev, "Failed to add hwmon sysfs attributes\n");
+
 	ret = amlogic_thermal_initialize(pdata);
 	if (ret)
 		return ret;
