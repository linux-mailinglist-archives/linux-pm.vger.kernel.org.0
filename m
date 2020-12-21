Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EEC2DFEF8
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 18:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgLURYs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 12:24:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:32918 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgLURYs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 12:24:48 -0500
Received: from 36-229-229-222.dynamic-ip.hinet.net ([36.229.229.222] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1krOub-0003Tq-14; Mon, 21 Dec 2020 17:23:57 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     andrzej.p@collabora.com, mjg59@google.com,
        srinivas.pandruvada@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andres Freund <andres@anarazel.de>,
        Chuhong Yuan <hslester96@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] thermal: intel: pch: Fix unexpected shutdown at critical temperature
Date:   Tue, 22 Dec 2020 01:23:44 +0800
Message-Id: <20201221172345.36976-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221172345.36976-1-kai.heng.feng@canonical.com>
References: <20201221172345.36976-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Like previous patch, the intel_pch_thermal device is not in ACPI
ThermalZone namespace, so a critical trip doesn't mean shutdown.

Override the default .critical callback to prevent surprising thermal
shutdoown.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Amend subject.

 drivers/thermal/intel/intel_pch_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 41723c6c6c0c..527c91f5960b 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -326,10 +326,16 @@ static int pch_get_trip_temp(struct thermal_zone_device *tzd, int trip, int *tem
 	return 0;
 }
 
+static void pch_critical(struct thermal_zone_device *tzd)
+{
+	dev_dbg(&tzd->device, "%s: critical temperature reached\n", tzd->type);
+}
+
 static struct thermal_zone_device_ops tzd_ops = {
 	.get_temp = pch_thermal_get_temp,
 	.get_trip_type = pch_get_trip_type,
 	.get_trip_temp = pch_get_trip_temp,
+	.critical = pch_critical,
 };
 
 enum board_ids {
-- 
2.29.2

