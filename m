Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0DF2E77BA
	for <lists+linux-pm@lfdr.de>; Wed, 30 Dec 2020 11:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgL3KT6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Dec 2020 05:19:58 -0500
Received: from muru.com ([72.249.23.125]:40576 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgL3KT5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Dec 2020 05:19:57 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 34A7580BA;
        Wed, 30 Dec 2020 10:19:30 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>
Subject: [PATCH] power: supply: cpcap: Add missing IRQF_ONESHOT to fix regression
Date:   Wed, 30 Dec 2020 12:19:11 +0200
Message-Id: <20201230101911.11747-1-tony@atomide.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 25d76fed7ffe ("phy: cpcap-usb: Use IRQF_ONESHOT") started causing
errors loading phy-cpcap-usb driver:

cpcap_battery cpcap_battery.0: failed to register power supply
genirq: Flags mismatch irq 211. 00002080 (se0conn) vs. 00000080 (se0conn)
cpcap-usb-phy cpcap-usb-phy.0: could not get irq se0conn: -16

Let's fix this by adding the missing IRQF_ONESHOT to also cpcap-battery
and cpcap-charger drivers.

Fixes: 25d76fed7ffe ("phy: cpcap-usb: Use IRQF_ONESHOT")
Reported-by: Merlijn Wajer <merlijn@wizzup.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 2 +-
 drivers/power/supply/cpcap-charger.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -666,7 +666,7 @@ static int cpcap_battery_init_irq(struct platform_device *pdev,
 
 	error = devm_request_threaded_irq(ddata->dev, irq, NULL,
 					  cpcap_battery_irq_thread,
-					  IRQF_SHARED,
+					  IRQF_SHARED | IRQF_ONESHOT,
 					  name, ddata);
 	if (error) {
 		dev_err(ddata->dev, "could not get irq %s: %i\n",
diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -708,7 +708,7 @@ static int cpcap_usb_init_irq(struct platform_device *pdev,
 
 	error = devm_request_threaded_irq(ddata->dev, irq, NULL,
 					  cpcap_charger_irq_thread,
-					  IRQF_SHARED,
+					  IRQF_SHARED | IRQF_ONESHOT,
 					  name, ddata);
 	if (error) {
 		dev_err(ddata->dev, "could not get irq %s: %i\n",
-- 
2.29.2
