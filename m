Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917204499AD
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 17:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbhKHQaD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 11:30:03 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:41780 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238803AbhKHQaD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 11:30:03 -0500
Received: from [77.244.183.192] (port=65054 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mk7UL-00DHLM-0b; Mon, 08 Nov 2021 17:27:17 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-pm@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 2/3] power: supply: core: add POWER_SUPPLY_HEALTH_NO_BATTERY
Date:   Mon,  8 Nov 2021 17:27:05 +0100
Message-Id: <20211108162706.2816454-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211108162706.2816454-1-luca@lucaceresoli.net>
References: <20211108162706.2816454-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some chargers can keep the system powered from the mains even when no
battery is present. It this case none of the currently defined health
statuses applies. Add a new status to report that no battery is present.

Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

This patch is new in v2.
---
 Documentation/ABI/testing/sysfs-class-power | 2 +-
 drivers/power/supply/power_supply_sysfs.c   | 1 +
 include/linux/power_supply.h                | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index f7904efc4cfa..a0b2a4280e38 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -413,7 +413,7 @@ Description:
 			      "Over voltage", "Unspecified failure", "Cold",
 			      "Watchdog timer expire", "Safety timer expire",
 			      "Over current", "Calibration required", "Warm",
-			      "Cool", "Hot"
+			      "Cool", "Hot", "No battery"
 
 What:		/sys/class/power_supply/<supply_name>/precharge_current
 Date:		June 2017
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c3d7cbcd4fad..6ac88fbee3cb 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -106,6 +106,7 @@ static const char * const POWER_SUPPLY_HEALTH_TEXT[] = {
 	[POWER_SUPPLY_HEALTH_WARM]		    = "Warm",
 	[POWER_SUPPLY_HEALTH_COOL]		    = "Cool",
 	[POWER_SUPPLY_HEALTH_HOT]		    = "Hot",
+	[POWER_SUPPLY_HEALTH_NO_BATTERY]	    = "No battery",
 };
 
 static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 9ca1f120a211..2d1318fe2455 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -66,6 +66,7 @@ enum {
 	POWER_SUPPLY_HEALTH_WARM,
 	POWER_SUPPLY_HEALTH_COOL,
 	POWER_SUPPLY_HEALTH_HOT,
+	POWER_SUPPLY_HEALTH_NO_BATTERY,
 };
 
 enum {
-- 
2.25.1

