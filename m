Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 264F9769BD
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 15:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfGZNyG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 09:54:06 -0400
Received: from olimex.com ([184.105.72.32]:34079 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387630AbfGZNnD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Jul 2019 09:43:03 -0400
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jul 2019 09:43:03 EDT
Received: from localhost.localdomain ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2019 06:32:59 -0700
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Cc:     Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH 1/1] thermal_hwmon: Sanitize thermal_zone type
Date:   Fri, 26 Jul 2019 16:32:36 +0300
Message-Id: <20190726133236.22872-1-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When calling thermal_add_hwmon_sysfs(), the device type is sanitized by
replacing '-' with '_'. However tz->type remains unsanitized. Thus
calling thermal_hwmon_lookup_by_type() returns no device. And if there is
no device, thermal_remove_hwmon_sysfs() fails with "hwmon device lookup failed!".

The result is unregisted hwmon devices in the sysfs.

Fixes: 409ef0bacacf ("thermal_hwmon: Sanitize attribute name passed to hwmon")

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 drivers/thermal/thermal_hwmon.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 40c69a533b24..dd5d8ee37928 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -87,13 +87,17 @@ static struct thermal_hwmon_device *
 thermal_hwmon_lookup_by_type(const struct thermal_zone_device *tz)
 {
 	struct thermal_hwmon_device *hwmon;
+	char type[THERMAL_NAME_LENGTH];
 
 	mutex_lock(&thermal_hwmon_list_lock);
-	list_for_each_entry(hwmon, &thermal_hwmon_list, node)
-		if (!strcmp(hwmon->type, tz->type)) {
+	list_for_each_entry(hwmon, &thermal_hwmon_list, node) {
+		strcpy(type, tz->type);
+		strreplace(type, '-', '_');
+		if (!strcmp(hwmon->type, type)) {
 			mutex_unlock(&thermal_hwmon_list_lock);
 			return hwmon;
 		}
+	}
 	mutex_unlock(&thermal_hwmon_list_lock);
 
 	return NULL;
-- 
2.17.1

