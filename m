Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069DA2C742F
	for <lists+linux-pm@lfdr.de>; Sat, 28 Nov 2020 23:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgK1Vts (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Nov 2020 16:49:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50331 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732712AbgK1Rzo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Nov 2020 12:55:44 -0500
Received: from 220-133-187-190.hinet-ip.hinet.net ([220.133.187.190] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kj4R0-0006RD-4E; Sat, 28 Nov 2020 17:54:58 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] thermal: core: Add indication for userspace usage
Date:   Sun, 29 Nov 2020 01:54:48 +0800
Message-Id: <20201128175450.12456-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We are seeing thermal shutdown on Intel based mobile workstations, the
shutdown happens during the first trip handle in
thermal_zone_device_register():
kernel: thermal thermal_zone15: critical temperature reached (101 C), shutting down

However, we shouldn't do a thermal shutdown here, since
1) We may want to use a dedicated daemon, Intel's thermald in this case,
to handle thermal shutdown.

2) For ACPI based system, _CRT doesn't mean shutdown unless it's inside
ThermalZone. ACPI Spec, 11.4.4 _CRT (Critical Temperature):
"... If this object it present under a device, the device’s driver
evaluates this object to determine the device’s critical cooling
temperature trip point. This value may then be used by the device’s
driver to program an internal device temperature sensor trip point."

So a "critical trip" here merely means we should take a more aggressive
cooling method.

So add an indication to let thermal core know it should leave thermal
device to userspace to handle.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/thermal/thermal_core.c | 3 +++
 include/linux/thermal.h        | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c6d74bc1c90b..6561e3767529 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1477,6 +1477,9 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 			goto unregister;
 	}
 
+	if (tz->tzp && tz->tzp->userspace)
+		thermal_zone_device_disable(tz);
+
 	mutex_lock(&thermal_list_lock);
 	list_add_tail(&tz->node, &thermal_tz_list);
 	mutex_unlock(&thermal_list_lock);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index d07ea27e72a9..e8e8fac78fc8 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -247,6 +247,8 @@ struct thermal_zone_params {
 	 */
 	bool no_hwmon;
 
+	bool userspace;
+
 	int num_tbps;	/* Number of tbp entries */
 	struct thermal_bind_params *tbp;
 
-- 
2.29.2

