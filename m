Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D212C7DE1
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 06:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgK3Fhn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 00:37:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58787 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgK3Fhn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 00:37:43 -0500
Received: from 220-133-187-190.hinet-ip.hinet.net ([220.133.187.190] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kjbrs-0002yW-GG; Mon, 30 Nov 2020 05:36:57 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     andrzej.p@collabora.com, mjg59@google.com,
        srinivas.pandruvada@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] thermal: intel: intel_pch_thermal: Indicate userspace usage
Date:   Mon, 30 Nov 2020 13:36:40 +0800
Message-Id: <20201130053640.54608-3-kai.heng.feng@canonical.com>
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
 drivers/thermal/intel/intel_pch_thermal.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 3b813ebb6ca1..e55e6318d733 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -270,6 +270,10 @@ static struct thermal_zone_device_ops tzd_ops = {
 	.get_trip_temp = pch_get_trip_temp,
 };
 
+static struct thermal_zone_params tzd_params = {
+	.userspace = true,
+};
+
 enum board_ids {
 	board_hsw,
 	board_wpt,
@@ -346,21 +350,16 @@ static int intel_pch_thermal_probe(struct pci_dev *pdev,
 		goto error_cleanup;
 
 	ptd->tzd = thermal_zone_device_register(bi->name, nr_trips, 0, ptd,
-						&tzd_ops, NULL, 0, 0);
+						&tzd_ops, &tzd_params, 0, 0);
 	if (IS_ERR(ptd->tzd)) {
 		dev_err(&pdev->dev, "Failed to register thermal zone %s\n",
 			bi->name);
 		err = PTR_ERR(ptd->tzd);
 		goto error_cleanup;
 	}
-	err = thermal_zone_device_enable(ptd->tzd);
-	if (err)
-		goto err_unregister;
 
 	return 0;
 
-err_unregister:
-	thermal_zone_device_unregister(ptd->tzd);
 error_cleanup:
 	iounmap(ptd->hw_base);
 error_release:
-- 
2.29.2

