Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E2F1DB30F
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 14:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgETMUl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 08:20:41 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44108 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETMUl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 08:20:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04KCKco0061153;
        Wed, 20 May 2020 07:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589977238;
        bh=hvXKcUkV7XpnUy1BQBCRXKA20QIPtE7iW2gyUhNIc9Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BwC/PZ9XyakTLt155LuTvUgqKlzhw6Z+UzM7EUks7SaNZA908r6yEaE5V/PhdgbJj
         IcemRfDu32u9uq/H4n5uSIe1f4eRVsRJOl+Y6mURteB4MuEI5kHqLM6WRHg7luJLIx
         Ac2JvdeQYRclkuUjmgXVHdKqEQ22a7Fp0+x0/8Ec=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04KCKcxZ010552;
        Wed, 20 May 2020 07:20:38 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 20
 May 2020 07:20:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 20 May 2020 07:20:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04KCKcBA062731;
        Wed, 20 May 2020 07:20:38 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>
CC:     <sspatil@android.com>, <dmurphy@ti.com>,
        <linux-pm@vger.kernel.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v8 1/3] power_supply: Add additional health properties to the header
Date:   Wed, 20 May 2020 07:20:25 -0500
Message-ID: <20200520122027.31320-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520122027.31320-1-dmurphy@ti.com>
References: <20200520122027.31320-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.

HEALTH_WARM, HEALTH_COOL, and HEALTH_HOT properties are taken from the JEITA spec.

Signed-off-by: Dan Murphy <dmurphy@ti.com>

Tested-by: Guru Das Srinagesh <gurus@codeaurora.org>
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
index dcd5a71e6c67..8670e90c1d51 100644
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
2.26.2

