Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129071C474E
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 21:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgEDTsF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 15:48:05 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:35878 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgEDTrt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 15:47:49 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49GD0g55STzGl;
        Mon,  4 May 2020 21:47:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588621667; bh=PlaAuIlDy3wYhoSP1lLGpuqY1fWmmJ/2uPxVj7hhzBo=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=bM0G5Ssafpcd4gQ6AmyrZCFs48qjeAEpBBHuN9KJaRivjld8/zmlpv3l+30I3mcAY
         28QVdbNIAgA5JW/g4Yw+Bw0kGLXIkmlACNjLqLDsTTDVmMEhHRBDFURm4owlhJVy1u
         oCiAYLw8veflUtYcnWJhoeZn+IY6MvpwnvP7nBbD5lx7kOEL/+ipeponlPzzM1pxuv
         IhDx6V5PFPOj/7EXfj1L/7+mWdhL1ebd1K2B70QQXMby05PNVg6AA7HcJlIsZ2351y
         5Ing8xufXREMRi/l7d++W2WOn0QGiX6qWxEPBpWxR70UYDf29Lj7onodsq0g/DeQm2
         tHi9G5Z1T8N3g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 04 May 2020 21:47:47 +0200
Message-Id: <f9bee8d1f65bf1f880752dc17cc390e5d566a93d.1588621247.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588621247.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588621247.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 6/8] power: bq25890: implement INPUT_CURRENT_LIMIT property
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Angus Ainslie <angus@akkea.ca>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
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
index dfd7bf9a3a55..cb57125ea988 100644
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
@@ -494,6 +496,14 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
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
@@ -692,6 +702,7 @@ static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
-- 
2.20.1

