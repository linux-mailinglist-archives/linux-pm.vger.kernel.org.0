Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07F2019C533
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389114AbgDBO64 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:58:56 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:45187 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389047AbgDBO6g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:58:36 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR5k2S3Rz1vh;
        Thu,  2 Apr 2020 16:58:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839514; bh=gRqyNiKmpXtCcJah85qRJb4ZmdxMMi1xeLY32RUkzmw=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=py4C8dEl3mEDGP6diNl5IGaONluJgCjEUrAgpOdCMlmzzGB+kSQ8UsqPbkOmzyB/6
         ClF+RNRKliZzAMgD302oZzOfqzGBH91lP/LL0REBDLF9uktKub9S/AcvzjwuT7be/B
         09VS8Z68vdLkgpsbzDuCP/xI22ZvTc57YzfZsU4HBWXswZOgj9Ouj7AsuLVusj5gzd
         idMtkYtb7qbKhj7zbvaZbJrQniLkQs3Ny85rtAdjBsZeKYvMI5jFcV7YAGgS42bP5t
         K7fz5257DiYFWmRpbG4sZ8zhz84k7fLyTLf+Q9Ot+zfPGh4+vvrNLiqjMDfScm6tVz
         m3+K+7kTpS06Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:58:33 +0200
Message-Id: <e60a23192ff336dd5b7307bc059ebf3e876183b1.1585838679.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 09/14] power: supply: bq25890: implement INPUT_CURRENT_LIMIT
 property
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
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

