Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574052114C4
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 23:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgGAVLV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 17:11:21 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59718 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgGAVLL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 17:11:11 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 061LB7kN032866;
        Wed, 1 Jul 2020 16:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593637867;
        bh=HbH/vZFBhcoNmQVTTDScKJZ6t2zedwS3QC05EmL/fVg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OTIA0Sy4ec6M3Brzv/JoduvhuM8U9uyLGIZtL5EruVxqCMtjwVn1zuhNMX1vFo4QV
         Hkl58DD6rZUN/O0D+m5G95PsY6Ak8zkusua1ksbSDDzVDrVQxWqcrkmonMG4ZETOui
         ZMsDwk/ciKlhZqTdiJIk8eR1CDCr0WAT2MrChI1s=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 061LB70d113004
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Jul 2020 16:11:07 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 16:11:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 1 Jul 2020 16:11:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061LB6BH050319;
        Wed, 1 Jul 2020 16:11:06 -0500
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <pali@kernel.org>, <robh@kernel.org>
CC:     <afd@ti.com>, <r-rivera-matos@ti.com>, <dmurphy@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <sspatil@android.com>,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v15 1/4] power_supply: Add additional health properties to the header
Date:   Wed, 1 Jul 2020 16:10:41 -0500
Message-ID: <20200701211044.18590-2-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701211044.18590-1-r-rivera-matos@ti.com>
References: <20200701211044.18590-1-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>

Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.

HEALTH_WARM, HEALTH_COOL, and HEALTH_HOT properties are taken
from JEITA specification JISC8712:2015

Acked-by: Andrew F. Davis <afd@ti.com>
Tested-by: Guru Das Srinagesh <gurus@codeaurora.org>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/ABI/testing/sysfs-class-power | 3 ++-
 drivers/power/supply/power_supply_sysfs.c   | 3 +++
 include/linux/power_supply.h                | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 216d61a22f1e..40213c73bc9c 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -205,7 +205,8 @@ Description:
 		Valid values: "Unknown", "Good", "Overheat", "Dead",
 			      "Over voltage", "Unspecified failure", "Cold",
 			      "Watchdog timer expire", "Safety timer expire",
-			      "Over current", "Calibration required"
+			      "Over current", "Calibration required", "Warm",
+			      "Cool", "Hot"
 
 What:		/sys/class/power_supply/<supply_name>/precharge_current
 Date:		June 2017
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index bc79560229b5..4d6e1d5015d6 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -101,6 +101,9 @@ static const char * const POWER_SUPPLY_HEALTH_TEXT[] = {
 	[POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE]   = "Safety timer expire",
 	[POWER_SUPPLY_HEALTH_OVERCURRENT]	    = "Over current",
 	[POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED]  = "Calibration required",
+	[POWER_SUPPLY_HEALTH_WARM]		    = "Warm",
+	[POWER_SUPPLY_HEALTH_COOL]		    = "Cool",
+	[POWER_SUPPLY_HEALTH_HOT]		    = "Hot",
 };
 
 static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index ac1345a48ad0..b5ee35d3c304 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -62,6 +62,9 @@ enum {
 	POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE,
 	POWER_SUPPLY_HEALTH_OVERCURRENT,
 	POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED,
+	POWER_SUPPLY_HEALTH_WARM,
+	POWER_SUPPLY_HEALTH_COOL,
+	POWER_SUPPLY_HEALTH_HOT,
 };
 
 enum {
-- 
2.27.0

