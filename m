Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C160B13EBF6
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 18:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgAPRxo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 12:53:44 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42732 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394444AbgAPRxo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 12:53:44 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00GHrf2d029061;
        Thu, 16 Jan 2020 11:53:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579197221;
        bh=B/iCkwTr7cWaPkDN8XqqkjSjyISA6ScP9Jk96VoY74g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DJNZO/IILaMc7CT9XjjQenD1hOjC3mfo9gqFfGIZpZV9IxWrtbJECganZLL9Tr/az
         2GIp6QWtlzGPh81DJEuvTUTs8PXd7maUPFppZ0u9476Y1e6mMInj0GuMHgWJFDcLWo
         BLhEs28q+V70PPWERxmhxwHK/tnUaVAKBnc6mfLY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00GHrfg9039191;
        Thu, 16 Jan 2020 11:53:41 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 16
 Jan 2020 11:53:40 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 16 Jan 2020 11:53:41 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00GHreYm058133;
        Thu, 16 Jan 2020 11:53:40 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <sebastian.reichel@collabora.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v4 2/4] power_supply: Add additional health properties to the header
Date:   Thu, 16 Jan 2020 11:50:37 -0600
Message-ID: <20200116175039.1317-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116175039.1317-1-dmurphy@ti.com>
References: <20200116175039.1317-1-dmurphy@ti.com>
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
2.25.0

