Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64BE3CCE79
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jul 2021 09:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhGSHap (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Jul 2021 03:30:45 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:58579 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233759AbhGSHap (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Jul 2021 03:30:45 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jul 2021 03:30:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1626679666; x=1658215666;
  h=from:to:cc:subject:date:message-id;
  bh=uNWl9es6Whwq/2IPyi9HkWJ5Uoe1DW7pH0BDC8R6XAk=;
  b=mvEbZA/8Z6df1xJ33Oz2hRFelKxI09iGaFyOUVid07NMrVCaqKaN97Ow
   2vf+5PNJBwBblpNJncNWBM3ati/i5+SgNGI3GqQuLfIm3pRBUQx4zUVSR
   RGMqEz5OzmqJoeAZ/Utaf57P2eFUaycj167e18+Wiujfd5rFpz/V0S+pT
   i9wkchwKQodIIOCSL7FmSI4d34e5rqJ61nVrTxTvoDu3SoyKyfL9RuCzG
   /4qOpAcHhOsKTOh36b686EuNikzRT/gJAFqK/+77pO42PcqfpxE6RyPco
   Trso2YkHnnxd8pxAz1fOyOPrMQxmY6p6tl30dO7aTQ6WZMF2MnvcbHYFX
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,251,1620684000"; 
   d="scan'208";a="18512869"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 19 Jul 2021 09:20:36 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 19 Jul 2021 09:20:36 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 19 Jul 2021 09:20:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1626679236; x=1658215236;
  h=from:to:cc:subject:date:message-id;
  bh=uNWl9es6Whwq/2IPyi9HkWJ5Uoe1DW7pH0BDC8R6XAk=;
  b=nqxNjwqHR2dUzGzj/H7+Oe0EIhJ5LNbjPo5BZElk9Cw/QZZvty/uwtnq
   KGS+IlsVxBWitHkso4Fdn35HsjUsK9kIDsGUq2WboxQcyImhBZmwOdVZY
   etm8bY5Wq0qj7cQkosc1sBClI6TmMVvI5Pgyuhn+C1Q+aSJFZG4fmU6iy
   c3RlBtKWZxjPjMBp+g8pR/OLuoTgfVlBzwIXmLsXUwAYsvi2YgJugC9rl
   b+NlV7mayIqkVrep3nMHSSXGanUlkaR9M3B0+Etmiou2OVjvgValMlRnc
   sYyAearsH19zbK6OYvH+ZfIWXBNFN5i1jbFdqJOIeGTHth7+cRDzT6kCF
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,251,1620684000"; 
   d="scan'208";a="18512865"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 19 Jul 2021 09:20:36 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 0F6A0280075;
        Mon, 19 Jul 2021 09:20:36 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/2] power: supply: sbs-battery: add support for time_to_empty_now attribute
Date:   Mon, 19 Jul 2021 09:20:19 +0200
Message-Id: <7238b56cca93c8101288b069fd044024da81db1f.1626678985.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cd466515301fcb19e9b858b2287d8bcc10cc3de1.1626678985.git.matthias.schiffer@ew.tq-group.com>
References: <cd466515301fcb19e9b858b2287d8bcc10cc3de1.1626678985.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <cd466515301fcb19e9b858b2287d8bcc10cc3de1.1626678985.git.matthias.schiffer@ew.tq-group.com>
References: <cd466515301fcb19e9b858b2287d8bcc10cc3de1.1626678985.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As defined by the Smart Battery Data Specification.

An _AVG suffix is added to the enum values REG_TIME_TO_EMPTY and
REG_TIME_TO_FULL to make the distinction clear.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/power/supply/sbs-battery.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 3d6b8247d450..c4a95b01463a 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -31,8 +31,9 @@ enum {
 	REG_CURRENT_AVG,
 	REG_MAX_ERR,
 	REG_CAPACITY,
-	REG_TIME_TO_EMPTY,
-	REG_TIME_TO_FULL,
+	REG_TIME_TO_EMPTY_NOW,
+	REG_TIME_TO_EMPTY_AVG,
+	REG_TIME_TO_FULL_AVG,
 	REG_STATUS,
 	REG_CAPACITY_LEVEL,
 	REG_CYCLE_COUNT,
@@ -119,9 +120,11 @@ static const struct chip_data {
 		SBS_DATA(POWER_SUPPLY_PROP_ENERGY_FULL, 0x10, 0, 65535),
 	[REG_FULL_CHARGE_CAPACITY_CHARGE] =
 		SBS_DATA(POWER_SUPPLY_PROP_CHARGE_FULL, 0x10, 0, 65535),
-	[REG_TIME_TO_EMPTY] =
+	[REG_TIME_TO_EMPTY_NOW] =
+		SBS_DATA(POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW, 0x11, 0, 65535),
+	[REG_TIME_TO_EMPTY_AVG] =
 		SBS_DATA(POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG, 0x12, 0, 65535),
-	[REG_TIME_TO_FULL] =
+	[REG_TIME_TO_FULL_AVG] =
 		SBS_DATA(POWER_SUPPLY_PROP_TIME_TO_FULL_AVG, 0x13, 0, 65535),
 	[REG_CHARGE_CURRENT] =
 		SBS_DATA(POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX, 0x14, 0, 65535),
@@ -165,6 +168,7 @@ static const enum power_supply_property sbs_properties[] = {
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CAPACITY_ERROR_MARGIN,
 	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
 	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
 	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
@@ -748,6 +752,7 @@ static void  sbs_unit_adjustment(struct i2c_client *client,
 		val->intval -= TEMP_KELVIN_TO_CELSIUS;
 		break;
 
+	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
 	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
 		/* sbs provides time to empty and time to full in minutes.
@@ -966,6 +971,7 @@ static int sbs_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
 	case POWER_SUPPLY_PROP_TEMP:
+	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
 	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
-- 
2.17.1

