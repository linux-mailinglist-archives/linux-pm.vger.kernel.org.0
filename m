Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97193BDE3A
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 21:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhGFT63 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 15:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230061AbhGFT63 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jul 2021 15:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625601350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K4iYqWImM1l/eHMp4+ECi30Nkvth8XA31wOblPl7aIY=;
        b=NFMdjVohNXHl0cjh9eSn4v34aKYEAozib7KcVcusw6c/B3SgTlFJEAexrYO9VT8Fka/9qY
        UFUsGUWeEjZMv/CjZN9feWIZPHXyWgLTBYwtZDs4Tz6MfrDotERZWssn3+ddqpSoYhWzi5
        wIT9/knzgaA3uHpFCse0UkwMBY/T7Ys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-pZM1Ede2MvajXIyrHkrRRg-1; Tue, 06 Jul 2021 15:55:48 -0400
X-MC-Unique: pZM1Ede2MvajXIyrHkrRRg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A02E71084F57;
        Tue,  6 Jul 2021 19:55:47 +0000 (UTC)
Received: from localhost (ovpn-113-53.rdu2.redhat.com [10.10.113.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34E545C1D5;
        Tue,  6 Jul 2021 19:55:40 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 1/2] power: supply: bq24735: reorganize ChargeOption command macros
Date:   Tue,  6 Jul 2021 16:55:26 -0300
Message-Id: <20210706195527.371108-2-bmeneg@redhat.com>
In-Reply-To: <20210706195527.371108-1-bmeneg@redhat.com>
References: <20210706195527.371108-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rename ChargeOption macros to match the others for ChargeCurrent and
ChargeVoltage and also separate the command & masks macros from the bits of
interest macros for each command.  This macro doesn't introduce any
functional change, only code re-org.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 drivers/power/supply/bq24735-charger.c | 27 ++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index b5d619db79f6..3ce36d09c017 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -31,9 +31,8 @@
 
 #include <linux/power/bq24735-charger.h>
 
-#define BQ24735_CHG_OPT			0x12
-#define BQ24735_CHG_OPT_CHARGE_DISABLE	(1 << 0)
-#define BQ24735_CHG_OPT_AC_PRESENT	(1 << 4)
+/* BQ24735 available commands and their respective masks */
+#define BQ24735_CHARGE_OPT		0x12
 #define BQ24735_CHARGE_CURRENT		0x14
 #define BQ24735_CHARGE_CURRENT_MASK	0x1fc0
 #define BQ24735_CHARGE_VOLTAGE		0x15
@@ -43,6 +42,10 @@
 #define BQ24735_MANUFACTURER_ID		0xfe
 #define BQ24735_DEVICE_ID		0xff
 
+/* ChargeOptions bits of interest */
+#define BQ24735_CHARGE_OPT_CHG_DISABLE	(1 << 0)
+#define BQ24735_CHARGE_OPT_AC_PRESENT	(1 << 4)
+
 struct bq24735 {
 	struct power_supply		*charger;
 	struct power_supply_desc	charger_desc;
@@ -167,8 +170,8 @@ static inline int bq24735_enable_charging(struct bq24735 *charger)
 	if (ret)
 		return ret;
 
-	return bq24735_update_word(charger->client, BQ24735_CHG_OPT,
-				   BQ24735_CHG_OPT_CHARGE_DISABLE, 0);
+	return bq24735_update_word(charger->client, BQ24735_CHARGE_OPT,
+				   BQ24735_CHARGE_OPT_CHG_DISABLE, 0);
 }
 
 static inline int bq24735_disable_charging(struct bq24735 *charger)
@@ -176,9 +179,9 @@ static inline int bq24735_disable_charging(struct bq24735 *charger)
 	if (charger->pdata->ext_control)
 		return 0;
 
-	return bq24735_update_word(charger->client, BQ24735_CHG_OPT,
-				   BQ24735_CHG_OPT_CHARGE_DISABLE,
-				   BQ24735_CHG_OPT_CHARGE_DISABLE);
+	return bq24735_update_word(charger->client, BQ24735_CHARGE_OPT,
+				   BQ24735_CHARGE_OPT_CHG_DISABLE,
+				   BQ24735_CHARGE_OPT_CHG_DISABLE);
 }
 
 static bool bq24735_charger_is_present(struct bq24735 *charger)
@@ -188,14 +191,14 @@ static bool bq24735_charger_is_present(struct bq24735 *charger)
 	} else {
 		int ac = 0;
 
-		ac = bq24735_read_word(charger->client, BQ24735_CHG_OPT);
+		ac = bq24735_read_word(charger->client, BQ24735_CHARGE_OPT);
 		if (ac < 0) {
 			dev_dbg(&charger->client->dev,
 				"Failed to read charger options : %d\n",
 				ac);
 			return false;
 		}
-		return (ac & BQ24735_CHG_OPT_AC_PRESENT) ? true : false;
+		return (ac & BQ24735_CHARGE_OPT_AC_PRESENT) ? true : false;
 	}
 
 	return false;
@@ -208,11 +211,11 @@ static int bq24735_charger_is_charging(struct bq24735 *charger)
 	if (!bq24735_charger_is_present(charger))
 		return 0;
 
-	ret  = bq24735_read_word(charger->client, BQ24735_CHG_OPT);
+	ret  = bq24735_read_word(charger->client, BQ24735_CHARGE_OPT);
 	if (ret < 0)
 		return ret;
 
-	return !(ret & BQ24735_CHG_OPT_CHARGE_DISABLE);
+	return !(ret & BQ24735_CHARGE_OPT_CHG_DISABLE);
 }
 
 static void bq24735_update(struct bq24735 *charger)
-- 
2.31.1

