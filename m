Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C673F332DC5
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 19:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhCISEo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 13:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhCISES (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 13:04:18 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BA2C06174A;
        Tue,  9 Mar 2021 10:04:18 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id F22311F4580B
Received: by jupiter.universe (Postfix, from userid 1000)
        id BAF764800DE; Tue,  9 Mar 2021 19:04:12 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 7/7] power: supply: core: reduce loglevel for probe defer info
Date:   Tue,  9 Mar 2021 19:04:07 +0100
Message-Id: <20210309180407.650943-8-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309180407.650943-1-sebastian.reichel@collabora.com>
References: <20210309180407.650943-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Avoid logging probe defer information for default loglevel
configurations. This is only required for debugging probe
defer issues, which requires enabling debug messages for
other subsystems.

This dev_info() message predates having deferred devices
information available in /sys/kernel/debug/devices_deferred,
which is generally more useful.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/power_supply_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 38e3aa642131..d99e2f11c183 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -169,7 +169,7 @@ static int __power_supply_populate_supplied_from(struct device *dev,
 			break;
 
 		if (np == epsy->of_node) {
-			dev_info(&psy->dev, "%s: Found supply : %s\n",
+			dev_dbg(&psy->dev, "%s: Found supply : %s\n",
 				psy->desc->name, epsy->desc->name);
 			psy->supplied_from[i-1] = (char *)epsy->desc->name;
 			psy->num_supplies++;
@@ -1143,7 +1143,7 @@ __power_supply_register(struct device *parent,
 
 	rc = power_supply_check_supplies(psy);
 	if (rc) {
-		dev_info(dev, "Not all required supplies found, defer probe\n");
+		dev_dbg(dev, "Not all required supplies found, defer probe\n");
 		goto check_supplies_failed;
 	}
 
-- 
2.30.1

