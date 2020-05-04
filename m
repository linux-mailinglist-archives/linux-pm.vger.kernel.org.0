Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7137B1C4753
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 21:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgEDTsG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 15:48:06 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:2691 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbgEDTrt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 15:47:49 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49GD0f3WsZzLn;
        Mon,  4 May 2020 21:47:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588621666; bh=cQuVrUR3wgTd8lZabcNbfWQeqVxfRyNFlVyOZvgXwJk=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=XZvSQYHN9LeJpr3cfWfmFvU1OLPJHpuQVUUKBiQZGCpGExaESjaBqGLsRiiZKF7YR
         LmLUoTX3yjb3cBHu+GIkAzjSL9CxlYwJxYxbUi6mfKNeuHPlGj5UN0UC1aanJAVXgn
         ks5GaQ2vtvABsuQMRtP83X8vrrOu875OupshO9WHR8ko+RIowC8SjpcGprhb/7K1DW
         WHHGwf8zNECtxWsyzoa6gn34k+nE3tLZR0htnY/DNdWIY+4d/OPzvNowzk+qZ5MNi/
         96T1fbyVjyLsmnkBadI16bmwWvArpficzy9334M3t8bqPIrUUWo5rH0/iy9FZkdbPs
         vt/OVUGdX68ew==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 04 May 2020 21:47:46 +0200
Message-Id: <7c42c59a5f27a8f88dad6501d9032189d1878614.1588621247.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588621247.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588621247.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 4/8] power: bq25890: implement CHARGE_TYPE property
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

Report charging type based on recently read state.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 322d48d28fe5..02e62ac76e15 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -427,6 +427,18 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 
 		break;
 
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		if (!state.online || state.chrg_status == STATUS_NOT_CHARGING ||
+		    state.chrg_status == STATUS_TERMINATION_DONE)
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		else if (state.chrg_status == STATUS_PRE_CHARGING)
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
+		else if (state.chrg_status == STATUS_FAST_CHARGING)
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		else /* unreachable */
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+		break;
+
 	case POWER_SUPPLY_PROP_MANUFACTURER:
 		val->strval = BQ25890_MANUFACTURER;
 		break;
@@ -668,6 +680,7 @@ static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
-- 
2.20.1

