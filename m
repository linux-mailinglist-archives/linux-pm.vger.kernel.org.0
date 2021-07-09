Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D3F3C2657
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 16:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhGIO5D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 10:57:03 -0400
Received: from server34.i7host.com.br ([186.227.200.26]:40712 "EHLO
        server34.i7host.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhGIO5C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 10:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smartgreen.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mieQJeji+kRVhr5p2jiTn0geBt9uhhRa6NZ8eq2C/y0=; b=JgpBFHRfchC6OTJCPbuJPtfDxa
        +WxABLUNlccgG5SqDNJlXzyyqlpNgsitsMOs0Zoic6AhuRy3GaOZum0AfbHWUmX2iSZ9ZlptDqu4V
        HoumfVd1X+pIGwVi0tdm9+d+Xp1/MOMrUYecYac35JT9ohpE0lL7QoblH0/GQgZFnvCTUfbah4J9z
        hQCjygNbJqYs1biONGfpw5okwqL3ZelRAQFkyg/ettSfxTbbCNasQJHjuEURjDEGFSqC8BAm5Jwr2
        FxhnzCxKKvhu6F2hlNLEAL2YtcCdvvoMtk5GvoYtoDC1vCLYTE2Or+dXwPn8rqXvknHrd6S1+c24w
        lmPbo9wQ==;
Received: from [177.220.172.135] (port=48408 helo=localhost)
        by server34.i7host.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <bruno.meneguele@smartgreen.net>)
        id 1m1rTx-004uZt-QU; Fri, 09 Jul 2021 11:27:59 -0300
From:   Bruno Meneguele <bruno.meneguele@smartgreen.net>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bruno Meneguele <bruno.meneguele@smartgreen.net>
Subject: [PATCH v3 1/2] power: supply: bq24735: reorganize ChargeOption command macros
Date:   Fri,  9 Jul 2021 11:27:30 -0300
Message-Id: <20210709142731.23418-2-bruno.meneguele@smartgreen.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210709142731.23418-1-bruno.meneguele@smartgreen.net>
References: <20210709142731.23418-1-bruno.meneguele@smartgreen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server34.i7host.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - smartgreen.net
X-Get-Message-Sender-Via: server34.i7host.com.br: authenticated_id: bruno.meneguele@smartgreen.net
X-Authenticated-Sender: server34.i7host.com.br: bruno.meneguele@smartgreen.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rename ChargeOption macros to match the others for ChargeCurrent and
ChargeVoltage and also separate the command & masks macros from the bits of
interest macros for each command.  This macro doesn't introduce any
functional change, only code re-org.

Signed-off-by: Bruno Meneguele <bruno.meneguele@smartgreen.net>
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

