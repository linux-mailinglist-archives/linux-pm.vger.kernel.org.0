Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99ED51D1E56
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390542AbgEMS5a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390389AbgEMS4f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:56:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7721EC061A0C;
        Wed, 13 May 2020 11:56:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4A0F92A251E
Received: by jupiter.universe (Postfix, from userid 1000)
        id 74B84480104; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 06/19] power: supply: sbs-battery: add POWER_SUPPLY_PROP_CAPACITY_ERROR_MARGIN support
Date:   Wed, 13 May 2020 20:56:02 +0200
Message-Id: <20200513185615.508236-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for reporting the MaxError register from
battery fuel gauges following the smart battery standard.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/sbs-battery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index a15783802ef8..4356fdf25d4a 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -26,6 +26,7 @@ enum {
 	REG_TEMPERATURE,
 	REG_VOLTAGE,
 	REG_CURRENT,
+	REG_MAX_ERR,
 	REG_CAPACITY,
 	REG_TIME_TO_EMPTY,
 	REG_TIME_TO_FULL,
@@ -85,6 +86,8 @@ static const struct chip_data {
 		SBS_DATA(POWER_SUPPLY_PROP_VOLTAGE_NOW, 0x09, 0, 20000),
 	[REG_CURRENT] =
 		SBS_DATA(POWER_SUPPLY_PROP_CURRENT_NOW, 0x0A, -32768, 32767),
+	[REG_MAX_ERR] =
+		SBS_DATA(POWER_SUPPLY_PROP_CAPACITY_ERROR_MARGIN, 0x0c, 0, 100),
 	[REG_CAPACITY] =
 		SBS_DATA(POWER_SUPPLY_PROP_CAPACITY, 0x0D, 0, 100),
 	[REG_REMAINING_CAPACITY] =
@@ -132,6 +135,7 @@ static enum power_supply_property sbs_properties[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CAPACITY_ERROR_MARGIN,
 	POWER_SUPPLY_PROP_TEMP,
 	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
 	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
@@ -676,6 +680,7 @@ static int sbs_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
 	case POWER_SUPPLY_PROP_CAPACITY:
+	case POWER_SUPPLY_PROP_CAPACITY_ERROR_MARGIN:
 		ret = sbs_get_property_index(client, psp);
 		if (ret < 0)
 			break;
-- 
2.26.2

