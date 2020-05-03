Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE911C2D4F
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 17:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgECPVT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 11:21:19 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:44073 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbgECPVR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 3 May 2020 11:21:17 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49FV7Y5Y3YzGj;
        Sun,  3 May 2020 17:21:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588519273; bh=gRqyNiKmpXtCcJah85qRJb4ZmdxMMi1xeLY32RUkzmw=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=XdOrHPWZRiIUVwKr8xqvyDxjKdLqwZ+yKi0xARn1bSUANXrFnGLH5Csiov+g3DrhB
         mqlqKgdQltrnzTA4OmGXpVB8iUdMMoyoEDvykwEObBmVmdiC2J+qZVtg4La4NFpMNu
         VLgXt7D2+x8NMdzNHVjSFICQULOmeoHesXIeOtxlIKMCxDrQJ/0+RhvacfkL7qctsU
         +9eEmFoRZNSPCnU4q/kR7mg5yph3cQClBotymVBl1QDYzx0j124ncNvpX+Mb+nae2P
         ZZIEptvTnKe33SoYloW7t/fa6B2ymTIHTvtAVbIkg1Y3HdVnsz949//5PNj41sXDl8
         CAajXGp1bvnrw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 03 May 2020 17:21:13 +0200
Message-Id: <48d71a9b286e688ce8155449f62dc8fe0da39f17.1588517058.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 09/11] power: bq25890: implement INPUT_CURRENT_LIMIT
 property
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

Report REG00.IINLIM value as INPUT_CURRENT_LIMIT property.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index b48685009048..87c5832e23d3 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -254,6 +254,7 @@ enum bq25890_table_ids {
 	/* range tables */
 	TBL_ICHG,
 	TBL_ITERM,
+	TBL_IILIM,
 	TBL_VREG,
 	TBL_BOOSTV,
 	TBL_SYSVMIN,
@@ -294,6 +295,7 @@ static const union {
 	/* TODO: BQ25896 has max ICHG 3008 mA */
 	[TBL_ICHG] =	{ .rt = {0,	  5056000, 64000} },	 /* uA */
 	[TBL_ITERM] =	{ .rt = {64000,   1024000, 64000} },	 /* uA */
+	[TBL_IILIM] =   { .rt = {50000,   3200000, 50000} },	 /* uA */
 	[TBL_VREG] =	{ .rt = {3840000, 4608000, 16000} },	 /* uV */
 	[TBL_BOOSTV] =	{ .rt = {4550000, 5510000, 64000} },	 /* uV */
 	[TBL_SYSVMIN] = { .rt = {3000000, 3700000, 100000} },	 /* uV */
@@ -505,6 +507,14 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->intval = bq25890_find_val(bq->init_data.iterm, TBL_ITERM);
 		break;
 
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = bq25890_field_read(bq, F_IILIM);
+		if (ret < 0)
+			return ret;
+
+		val->intval = bq25890_find_val(ret, TBL_IILIM);
+		break;
+
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		ret = bq25890_field_read(bq, F_SYSV); /* read measured value */
 		if (ret < 0)
@@ -695,6 +705,7 @@ static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 };
 
-- 
2.20.1

