Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E0D1C2D5D
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgECPVk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 11:21:40 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:59391 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbgECPVP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 3 May 2020 11:21:15 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49FV7Y2NWdzBc;
        Sun,  3 May 2020 17:21:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588519273; bh=j/RXM+fNBpI5abZHjWXnC0UL+wj8lzgTO3a3XRS4VRU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=RopMzqEdt2k3EhVrpoxZUHP+e7++yDN2QM8vDrySiLubm8gTIHh8LmmjY5PeAV+Jh
         X4gOFPG/P9M8/qaaomk0YcuR+AKXLvi2610zUsvV+JPl26cOAiU5RPoLTSAH3V4vii
         kXu3nSgEam2KBZ5MqCxMtNzDE9vihUpRgK4NL3Xxhgl9BIXh+b0o8Vb1MYajl8bH2O
         FqVYpZZJyxIIGmCDXqVQ7wPej5ctZFHv4YulbkgijbBYLN/SN+Bh19jTRe4UOAqxUF
         CtgcixercNi0WIKqtM7fuYjs17bA40NS1sSYFuZwh/FsSBYdZCP/ybA2U8GV4ZLHUn
         iT7MRDOuC6v3Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 03 May 2020 17:21:13 +0200
Message-Id: <f6827f3c9a9666ac15e227220ef9efabf67e0caa.1588517058.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 08/11] power: bq25890: implement PRECHARGE_CURRENT property
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

Report configured precharge current.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index ad0901fdceb6..b48685009048 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -497,6 +497,10 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->intval = bq25890_find_val(bq->init_data.vreg, TBL_VREG);
 		break;
 
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+		val->intval = bq25890_find_val(bq->init_data.iprechg, TBL_ITERM);
+		break;
+
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 		val->intval = bq25890_find_val(bq->init_data.iterm, TBL_ITERM);
 		break;
@@ -689,6 +693,7 @@ static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 };
-- 
2.20.1

