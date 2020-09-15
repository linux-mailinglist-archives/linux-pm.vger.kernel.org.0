Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAFB26B1EB
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 00:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgIOWhl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 18:37:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:55540 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbgIOWhM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Sep 2020 18:37:12 -0400
IronPort-SDR: SPwCRArGs7XJQAzoVTMmRlAT2hb2TompAmWulAuBt5HlybzBi11HujMIqXY6DiqUpAzUpcAwe+
 XzP40cKRg9Kw==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="147112836"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="147112836"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 15:37:07 -0700
IronPort-SDR: /TEsiT9aFADS/n2briVPbmXWdAqEWJfMs7jlqGM0vDhtRz/B9RySBfrd83Hgt15Y2ao7R60x0I
 H1gSX6Ru62EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="306813336"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga006.jf.intel.com with ESMTP; 15 Sep 2020 15:37:07 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] thermal: int340x: Provide notification for OEM variable change
Date:   Tue, 15 Sep 2020 15:36:48 -0700
Message-Id: <20200915223650.406046-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200915223650.406046-1-srinivas.pandruvada@linux.intel.com>
References: <20200915223650.406046-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When we receive ACPI notification for OEM variable change pass the
notification to user space handler. This will avoid polling for
OEM variable change from user space.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/int3400_thermal.c   | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 4f5859d4c780..2ca295e6e64d 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -349,30 +349,30 @@ static void int3400_notify(acpi_handle handle,
 {
 	struct int3400_thermal_priv *priv = data;
 	char *thermal_prop[5];
+	int therm_event;
 
 	if (!priv)
 		return;
 
 	switch (event) {
 	case INT3400_THERMAL_TABLE_CHANGED:
-		thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s",
-				priv->thermal->type);
-		thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d",
-				priv->thermal->temperature);
-		thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=");
-		thermal_prop[3] = kasprintf(GFP_KERNEL, "EVENT=%d",
-				THERMAL_TABLE_CHANGED);
-		thermal_prop[4] = NULL;
-		kobject_uevent_env(&priv->thermal->device.kobj, KOBJ_CHANGE,
-				thermal_prop);
+		therm_event = THERMAL_TABLE_CHANGED;
 		break;
 	case INT3400_ODVP_CHANGED:
 		evaluate_odvp(priv);
+		therm_event = THERMAL_DEVICE_POWER_CAPABILITY_CHANGED;
 		break;
 	default:
 		/* Ignore unknown notification codes sent to INT3400 device */
-		break;
+		return;
 	}
+
+	thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s", priv->thermal->type);
+	thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d", priv->thermal->temperature);
+	thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=");
+	thermal_prop[3] = kasprintf(GFP_KERNEL, "EVENT=%d", therm_event);
+	thermal_prop[4] = NULL;
+	kobject_uevent_env(&priv->thermal->device.kobj, KOBJ_CHANGE, thermal_prop);
 }
 
 static int int3400_thermal_get_temp(struct thermal_zone_device *thermal,
-- 
2.25.4

