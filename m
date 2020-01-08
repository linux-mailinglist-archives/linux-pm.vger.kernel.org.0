Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D63E134D30
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 21:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgAHU0W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 15:26:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53570 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgAHU0J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 15:26:09 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 008KQ6xV005535;
        Wed, 8 Jan 2020 14:26:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578515166;
        bh=AtQN2XJEmrYkV3ctwtTT7i/s5/8bXhlXRSLZa3niB7U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rjygro5RJ5eBI7Q5bT1v8FCTMP/DrtkfTbFJsv2g3lI93MTk85nynpVJe5z99/DPf
         7wva+O6xZUsiKg1Rucyistx+0l9G6rIfkV37l9C9Sib2tpjI5N7K6KzInVS0lMQSfG
         1gpvUNA+Ehomhz5wWXMH7lDp9B8u3adLYzmzFMPQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 008KQ5SM036028
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jan 2020 14:26:05 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 14:26:04 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 14:26:05 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008KQ55N074448;
        Wed, 8 Jan 2020 14:26:05 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <sebastian.reichel@collabora.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 2/4] power_supply: Add additional health properties to the header
Date:   Wed, 8 Jan 2020 14:23:12 -0600
Message-ID: <20200108202314.11791-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200108202314.11791-1-dmurphy@ti.com>
References: <20200108202314.11791-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v3 - updated the ABI documentation and the power supply health text array.

 Documentation/ABI/testing/sysfs-class-power | 2 +-
 drivers/power/supply/power_supply_sysfs.c   | 2 +-
 include/linux/power_supply.h                | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index bf3b48f022dc..9f3fd01a9373 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -190,7 +190,7 @@ Description:
 		Valid values: "Unknown", "Good", "Overheat", "Dead",
 			      "Over voltage", "Unspecified failure", "Cold",
 			      "Watchdog timer expire", "Safety timer expire",
-			      "Over current"
+			      "Over current", "Warm", "Cool", "Hot"
 
 What:		/sys/class/power_supply/<supply_name>/precharge_current
 Date:		June 2017
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index f37ad4eae60b..d0d549611794 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -61,7 +61,7 @@ static const char * const power_supply_charge_type_text[] = {
 static const char * const power_supply_health_text[] = {
 	"Unknown", "Good", "Overheat", "Dead", "Over voltage",
 	"Unspecified failure", "Cold", "Watchdog timer expire",
-	"Safety timer expire", "Over current"
+	"Safety timer expire", "Over current", "Warm", "Cool", "Hot"
 };
 
 static const char * const power_supply_technology_text[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 28413f737e7d..bd0d3225f245 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -61,6 +61,9 @@ enum {
 	POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE,
 	POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE,
 	POWER_SUPPLY_HEALTH_OVERCURRENT,
+	POWER_SUPPLY_HEALTH_WARM,
+	POWER_SUPPLY_HEALTH_COOL,
+	POWER_SUPPLY_HEALTH_HOT,
 };
 
 enum {
-- 
2.23.0

