Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E702C7079
	for <lists+linux-pm@lfdr.de>; Sat, 28 Nov 2020 19:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgK1R7i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Nov 2020 12:59:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50349 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732978AbgK1Rzy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Nov 2020 12:55:54 -0500
Received: from 220-133-187-190.hinet-ip.hinet.net ([220.133.187.190] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kj4R5-0006Sg-Rv; Sat, 28 Nov 2020 17:55:04 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Peter Kaestle <peter@piie.net>,
        Matthew Garrett <mjg59@google.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] thermal: int340x: Indicate userspace usage
Date:   Sun, 29 Nov 2020 01:54:49 +0800
Message-Id: <20201128175450.12456-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201128175450.12456-1-kai.heng.feng@canonical.com>
References: <20201128175450.12456-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The device isn't present under ACPI ThermalZone, and there's a dedicated
userspace daemon for this thermal device.

Let thermal core know it shouldn't handle trips to avoid surprising
thermal shutdown.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c     | 1 +
 .../thermal/intel/int340x_thermal/int340x_thermal_zone.c    | 6 +-----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 0966551cbaaa..2002bc96eb3c 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -439,6 +439,7 @@ static struct thermal_zone_device_ops int3400_thermal_ops = {
 static struct thermal_zone_params int3400_thermal_params = {
 	.governor_name = "user_space",
 	.no_hwmon = true,
+	.userspace = true,
 };
 
 static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 6e479deff76b..a103eb42ef2d 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -208,6 +208,7 @@ EXPORT_SYMBOL_GPL(int340x_thermal_read_trips);
 static struct thermal_zone_params int340x_thermal_params = {
 	.governor_name = "user_space",
 	.no_hwmon = true,
+	.userspace = true,
 };
 
 struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
@@ -259,14 +260,9 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 		ret = PTR_ERR(int34x_thermal_zone->zone);
 		goto err_thermal_zone;
 	}
-	ret = thermal_zone_device_enable(int34x_thermal_zone->zone);
-	if (ret)
-		goto err_enable;
 
 	return int34x_thermal_zone;
 
-err_enable:
-	thermal_zone_device_unregister(int34x_thermal_zone->zone);
 err_thermal_zone:
 	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
 	kfree(int34x_thermal_zone->aux_trips);
-- 
2.29.2

