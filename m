Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B64B12081F
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 15:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfLPOGs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 09:06:48 -0500
Received: from foss.arm.com ([217.140.110.172]:56568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbfLPOGr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Dec 2019 09:06:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA8001045;
        Mon, 16 Dec 2019 06:06:46 -0800 (PST)
Received: from e123648.arm.com (unknown [10.37.12.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 894E93F718;
        Mon, 16 Dec 2019 06:06:44 -0800 (PST)
From:   lukasz.luba@arm.com
To:     linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     amit.kucheria@verdurent.com, corbet@lwn.net, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: [PATCH  1/3] docs: thermal: Add bind, unbind information together with trip point
Date:   Mon, 16 Dec 2019 14:06:20 +0000
Message-Id: <20191216140622.25467-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216140622.25467-1-lukasz.luba@arm.com>
References: <20191216140622.25467-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lukasz Luba <lukasz.luba@arm.com>

Update sysfs interface documentation about new attributes in the cooling
device folder: bind and unbind. It also updates the changed cooling device
associated trip point interface extending it by information about writable
values.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 .../driver-api/thermal/sysfs-api.rst          | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index b40b1f839148..605f0d9ffe71 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -407,6 +407,8 @@ Thermal cooling device sys I/F, created once it's registered::
     |---stats/time_in_state_ms:	Time (msec) spent in various cooling states
     |---stats/total_trans:	Total number of times cooling state is changed
     |---stats/trans_table:	Cooing state transition table
+    |---bind_tz:	Interface for binding cooling device to thermal zone
+    |---unbind_tz:	Interface for unbinding cooling device from thermal zone
 
 
 Then next two dynamic attributes are created/removed in pairs. They represent
@@ -507,9 +509,12 @@ available_policies
 `cdev[0-*]_trip_point`
 	The trip point in this thermal zone which `cdev[0-*]` is associated
 	with; -1 means the cooling device is not associated with any trip
-	point.
+	point. Writing a value (a proper integer) will set new trip point
+	to this cooling device. The value -1 will cause the cooling device
+	is not associated to any trip point and can be unbind from the
+	thermal zone.
 
-	RO, Optional
+	RW, Optional
 
 `cdev[0-*]_weight`
 	The influence of `cdev[0-*]` in this thermal zone. This value
@@ -637,6 +642,27 @@ max_state
 
 	RO, Required
 
+bind_tz
+	Writing the thermal zone name binds this cooling device with the
+	specified thermal zone. A new dynamic attributes 'cdev*' will be
+	created inside the thermal zone directory.
+	The proper thermal zone name can be from read the attribute:
+	/sys/class/thermal/thermal_zone*/type
+	The default (-1) trip point will be set into the cooling instance,
+	which should be updated later using 'cdev*_trip_point' interface.
+
+	WO, Required
+
+unbind_tz
+	Writing the thermal zone name unbinds this cooling device from
+	the specified thermal zone. The cooling instance needs to set -1
+	into the associated cooling device instance 'cdev*_trip_point'
+	first.
+	The proper thermal zone name can be read from the attribute:
+	/sys/class/thermal/thermal_zone*/type
+
+	WO, Required
+
 cur_state
 	The current cooling state of this cooling device.
 	The value can any integer numbers between 0 and max_state:
-- 
2.17.1

