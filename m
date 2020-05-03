Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584891C2D68
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 17:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgECPVw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 11:21:52 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:51302 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbgECPVN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 3 May 2020 11:21:13 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49FV7V4cPmzJf;
        Sun,  3 May 2020 17:21:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588519270; bh=mKRZQCnghprUjuua4YgNrBV4tEAzgIfaruToSEdSL8Q=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=iPkQ/FLZt0ykL0C0STfJW+MwNu2UkDUGr4OQ6JlSyUelkoC4xqpzSnNFV9/O2rSuL
         VpVMo3SAaD9wZHXIHicqatX/+9KlUNiAqV61sgnRyuonVnDUZcJd0mPcruQ+XN2ym3
         /4x+QfaU89Of/NgvDIZ1DQvRvLoKwciO+vTFPe/5Nxe/HO0OjShhFdk2UKlHl1adkS
         3t0HVeYcmo5n7krhUhsq+iLmUYGxM+kQyWHSYGbJHB4rZBHSoLgx5QDrWANi3VJ2bF
         /PFK/8jh1IirzAtd3Q9f9Junk6m8OH/FHP+igF7ru3dlPPkRveQ7JoYam7VDBozhIS
         XubhkFsOchIlg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 03 May 2020 17:21:10 +0200
Message-Id: <e623178ff9592e041089a40a7593b5a5770df4f3.1588517058.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 02/11] power: bq25890: simplify chip name property getter
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Driver rejects unknown chips early in the probe(), so when
bq25890_power_supply_get_property() is made reachable, bq->chip_version
will already be set to correct value - there is no need to check
it again.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index c642519ef7b2..f9f29edadddc 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -32,6 +32,13 @@ enum bq25890_chip_version {
 	BQ25896,
 };
 
+static const char *const bq25890_chip_name[] = {
+	"BQ25890",
+	"BQ25892",
+	"BQ25895",
+	"BQ25896",
+};
+
 enum bq25890_fields {
 	F_EN_HIZ, F_EN_ILIM, F_IILIM,				     /* Reg00 */
 	F_BHOT, F_BCOLD, F_VINDPM_OFS,				     /* Reg01 */
@@ -400,17 +407,7 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_MODEL_NAME:
-		if (bq->chip_version == BQ25890)
-			val->strval = "BQ25890";
-		else if (bq->chip_version == BQ25892)
-			val->strval = "BQ25892";
-		else if (bq->chip_version == BQ25895)
-			val->strval = "BQ25895";
-		else if (bq->chip_version == BQ25896)
-			val->strval = "BQ25896";
-		else
-			val->strval = "UNKNOWN";
-
+		val->strval = bq25890_chip_name[bq->chip_version];
 		break;
 
 	case POWER_SUPPLY_PROP_ONLINE:
-- 
2.20.1

