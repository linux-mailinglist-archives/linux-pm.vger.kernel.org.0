Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0592C7066
	for <lists+linux-pm@lfdr.de>; Sat, 28 Nov 2020 19:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgK1R5z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Nov 2020 12:57:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50352 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733041AbgK1Rzz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Nov 2020 12:55:55 -0500
Received: from 220-133-187-190.hinet-ip.hinet.net ([220.133.187.190] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kj4RB-0006Sy-2o; Sat, 28 Nov 2020 17:55:10 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] thermal: intel: intel_pch_thermal: Indicate userspace usage
Date:   Sun, 29 Nov 2020 01:54:50 +0800
Message-Id: <20201128175450.12456-3-kai.heng.feng@canonical.com>
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

