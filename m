Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883B14D22AA
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 21:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350249AbiCHUet (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 15:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350243AbiCHUer (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 15:34:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816103CA67
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 12:33:50 -0800 (PST)
Date:   Tue, 08 Mar 2022 20:33:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646771629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gwzhspYvd93cpuYWPtAREUDrprowvdT/6XzU/jlWg7I=;
        b=y0y0oWL+j72u5pfIcD9U4MrCFVUGvvwxX1NBxRRDzYoPWIRsqrvxtP/MboijcDY1ZIsejZ
        n0VRtFAjmKqnvbgY5Qo2B13HL3zCuJMGtNkaARoO/lRUVU6Cbu+O/DP6dGtHrznE4vK2/3
        o4Beue9sUWyWK3bVuTuYaDHJpgKBRu5vrCNgM8FMm7L3TG0roU2Crs36UFavjZE9HyO/ED
        VG3bmvyn5SXM/gg7zQV4PYGFZzGTsbsHixKqAjJLbeXA/AokesKIO9yiMjJmLqHCKneqAi
        01zf+fUHebZMCzm+jJ27vvS2IdRMayRWCemjW9YIoGMa/cUyvAt86oULxSb++w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646771629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gwzhspYvd93cpuYWPtAREUDrprowvdT/6XzU/jlWg7I=;
        b=wCs3hJhKSc/Mqcv2Dg5LdVBxN91al/wwLw0bK8EyGb0gyx6jJmjAaiqMBFywZIb/izw6Y7
        x3q61eEgpLp45sAw==
From:   "thermal-bot for Romain Naour" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] drivers/thermal/ti-soc-thermal: Add hwmon support
Cc:     Romain Naour <romain.naour@smile.fr>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220218104725.2718904-1-romain.naour@smile.fr>
References: <20220218104725.2718904-1-romain.naour@smile.fr>
MIME-Version: 1.0
Message-ID: <164677162686.16921.5314559926092195125.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     3a9abd6cece8321be821bf84406a94e3c483f31e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//3a9abd6cece8321be821bf84406a94e3c483f31e
Author:        Romain Naour <romain.naour@smile.fr>
AuthorDate:    Fri, 18 Feb 2022 11:47:25 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 08 Mar 2022 21:26:09 +01:00

drivers/thermal/ti-soc-thermal: Add hwmon support

Expose ti-soc-thermal thermal sensors as HWMON devices.

  # sensors
  cpu_thermal-virtual-0
  Adapter: Virtual device
  temp1:        +54.2 C  (crit = +105.0 C)

  dspeve_thermal-virtual-0
  Adapter: Virtual device
  temp1:        +51.4 C  (crit = +105.0 C)

  gpu_thermal-virtual-0
  Adapter: Virtual device
  temp1:        +54.2 C  (crit = +105.0 C)

  iva_thermal-virtual-0
  Adapter: Virtual device
  temp1:        +54.6 C  (crit = +105.0 C)

  core_thermal-virtual-0
  Adapter: Virtual device
  temp1:        +52.6 C  (crit = +105.0 C)

Similar to imx_sc_thermal d2bc4dd91da6095a769fdc9bc519d3be7ad5f97a.

No need to take care of thermal_remove_hwmon_sysfs() since
devm_thermal_add_hwmon_sysfs() (a wrapper around devres) is
used. See c7fc403e40b0ea18976a59e968c23439a80809e8.

Signed-off-by: Romain Naour <romain.naour@smile.fr>
Link: https://lore.kernel.org/r/20220218104725.2718904-1-romain.naour@smile.fr
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index f843758..0959632 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -21,6 +21,7 @@
 
 #include "ti-thermal.h"
 #include "ti-bandgap.h"
+#include "../thermal_hwmon.h"
 
 /* common data structures */
 struct ti_thermal_data {
@@ -189,6 +190,9 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 	ti_bandgap_set_sensor_data(bgp, id, data);
 	ti_bandgap_write_update_interval(bgp, data->sensor_id, interval);
 
+	if (devm_thermal_add_hwmon_sysfs(data->ti_thermal))
+		dev_warn(bgp->dev, "failed to add hwmon sysfs attributes\n");
+
 	return 0;
 }
 
