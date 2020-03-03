Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B27001770D9
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 09:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgCCIKw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 03:10:52 -0500
Received: from inva020.nxp.com ([92.121.34.13]:56736 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbgCCIKw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Mar 2020 03:10:52 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7FECE1A153A;
        Tue,  3 Mar 2020 09:10:50 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 18D701A14C0;
        Tue,  3 Mar 2020 09:10:47 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0B7E44029E;
        Tue,  3 Mar 2020 16:10:42 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] thermal: Fix build warning of !defined(CONFIG_THERMAL_OF)
Date:   Tue,  3 Mar 2020 16:04:43 +0800
Message-Id: <1583222684-10229-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add "inline" to thermal_zone_of_get_sensor_id() function to avoid below
build warning of !defined(CONFIG_THERMAL_OF).

In file included from drivers/hwmon/hwmon.c:22:
include/linux/thermal.h:382:12: warning: 'thermal_zone_of_get_sensor_id'
defined but not used [-Wunused-function]
382 | static int thermal_zone_of_get_sensor_id(struct device_node *tz_np,

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 include/linux/thermal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 53e6f67..c91b1e3 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -379,7 +379,7 @@ void devm_thermal_zone_of_sensor_unregister(struct device *dev,
 					    struct thermal_zone_device *tz);
 #else
 
-static int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
+static inline int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
 					 struct device_node *sensor_np,
 					 u32 *id)
 {
-- 
2.7.4

