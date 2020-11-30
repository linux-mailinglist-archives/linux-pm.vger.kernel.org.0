Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE2F2C7DDE
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 06:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgK3Fhn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 00:37:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58786 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgK3Fhn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 00:37:43 -0500
Received: from 220-133-187-190.hinet-ip.hinet.net ([220.133.187.190] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kjbrn-0002y4-5l; Mon, 30 Nov 2020 05:36:52 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     andrzej.p@collabora.com, mjg59@google.com,
        srinivas.pandruvada@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Peter Kaestle <peter@piie.net>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] thermal: int340x: Indicate userspace usage
Date:   Mon, 30 Nov 2020 13:36:39 +0800
Message-Id: <20201130053640.54608-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130053640.54608-1-kai.heng.feng@canonical.com>
References: <20201130053640.54608-1-kai.heng.feng@canonical.com>
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

