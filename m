Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 961BA19C338
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 15:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731970AbgDBNxF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 09:53:05 -0400
Received: from smtp1.axis.com ([195.60.68.17]:15751 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbgDBNxF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 09:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2696; q=dns/txt; s=axis-central1;
  t=1585835584; x=1617371584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CV98VA9FjGiVV8kHnbGGkcM5ZTwpBaBb+rPFa5htYbc=;
  b=DEWfDEb997ZftaOI7oxxpTvcXVKKOVTOzc4U4o9/7oYMV/QGBZmJq5cG
   y0VTiM5DtvKwqNdlS6SpLK77MUpBC45jwKtHYRhs0607Yaoyc7fki8ckG
   3VIBYWtY2D+80OrbK4wNKnokfuZousCNPKpEyzoOVUok+KCf9Kbx703aO
   Uqymr1OYaSdfA+6bzMn1Zs2V2xRqt1PthSnn/Quf58b89D7vDqSW0ARgS
   itZIj4PLKQxupfLHdROuZ3pCnwkov5W64evdhN/tXoa2/1ata3fGK83Md
   m2aK0kE9+QNYoqpgY2DWMkNVOfeDDS3/UQwBWHI6bkHu83enTO5E2okQI
   g==;
IronPort-SDR: fGATzLwdBAQHpGaI2GlFlmFFxyp0j6MD3Cr8UUVyPMRnMrI1fLmKoJnoLfmeglY7JrZfv34fim
 qdBsuLBZKnyy3ir7XrNRoIdiERCdRsfrm22uE8hrzTLBrN+kfwx6VJdfUHZCOsqWYc/3jhiN7I
 D8Wl+kKuhe6b0S9ZJJ7h2vEIlWvPD968/RXHw0Ufjfg1Qwus3rCQ4O4brCFC5KNvyXk7ghNBmm
 c+aIVOzthCfffaKtk/eXiLDKz0sOMukLsvCCqtnzSO0o4QlN8zGJ7zPzkFSIo0u7HJd4DKuBUi
 t7Q=
X-IronPort-AV: E=Sophos;i="5.72,335,1580770800"; 
   d="scan'208";a="7244825"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <rui.zhang@intel.com>, <daniel.lezcano@linaro.org>,
        <amit.kucheria@verdurent.com>
CC:     <kernel@axis.com>, <linux-pm@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH] thermal: Add ratelimited print for HOT trip point
Date:   Thu, 2 Apr 2020 15:52:42 +0200
Message-ID: <20200402135242.11117-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, HOT trips don't do much in the core except for emitting an
ftrace event.  Unlike for ACTIVE/PASSIVE, cooling/throttling is not
activated.

The ACPI driver sends a netlink notification to userspace, but the other
drivers either don't implement ->notify() (all but rcar_thermal), or
don't do anything for HOT in their ->notify() implementation
(rcar_thermal).  (tegra appears to use the HOT trip device tree data for
other purposes.)

To make this trip point a bit more useful, add a warning print in the
core when this temperature is reached, so that this information is
available in the kernel log for diagnostic purposes.  The warning is
ratelimited by default to once an hour and can be adjusted with module
parameters.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/thermal/thermal_core.c | 12 ++++++++++++
 include/linux/thermal.h        |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9a321dc548c8..06f1dfae0310 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -47,6 +47,12 @@ static bool power_off_triggered;
 
 static struct thermal_governor *def_governor;
 
+static unsigned int thermal_ratelimit_interval = 60 * 60 * HZ;
+static unsigned int thermal_ratelimit_burst = 1;
+
+module_param_named(ratelimit_interval, thermal_ratelimit_interval, uint, 0);
+module_param_named(ratelimit_burst, thermal_ratelimit_burst, uint, 0);
+
 /*
  * Governor section: set of functions to handle thermal governors
  *
@@ -404,6 +410,9 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 			power_off_triggered = true;
 		}
 		mutex_unlock(&poweroff_lock);
+	} else if (__ratelimit(&tz->ratelimit)) {
+		dev_warn(&tz->device, "hot temperature reached (%d C)\n",
+			  tz->temperature / 1000);
 	}
 }
 
@@ -1290,6 +1299,9 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	tz->passive_delay = passive_delay;
 	tz->polling_delay = polling_delay;
 
+	ratelimit_state_init(&tz->ratelimit, thermal_ratelimit_interval,
+			     thermal_ratelimit_burst);
+
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
 	result = thermal_zone_create_device_groups(tz, mask);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 126913c6a53b..d3d0d6c7c4a1 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -196,6 +196,7 @@ struct thermal_zone_device {
 	int passive;
 	int prev_low_trip;
 	int prev_high_trip;
+	struct ratelimit_state ratelimit;
 	unsigned int forced_passive;
 	atomic_t need_update;
 	struct thermal_zone_device_ops *ops;
-- 
2.25.1

