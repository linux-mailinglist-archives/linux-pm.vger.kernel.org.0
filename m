Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDB62F0974
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jan 2021 20:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbhAJTyy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 14:54:54 -0500
Received: from muru.com ([72.249.23.125]:42368 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbhAJTyy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 10 Jan 2021 14:54:54 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 510FF813C;
        Sun, 10 Jan 2021 19:54:13 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 03/15] power: supply: cpcap-charger: Fix flakey reboot with charger connected
Date:   Sun, 10 Jan 2021 21:53:51 +0200
Message-Id: <20210110195403.13758-4-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210110195403.13758-1-tony@atomide.com>
References: <20210110195403.13758-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If we have a USB charger connected, reboot is flakey and often fails to
reboot the device with the charger LED staying on.

Let's fix this by implementing .shutdown.

Cc: Arthur Demchenkov <spinal.by@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-charger.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -886,7 +886,7 @@ static int cpcap_charger_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int cpcap_charger_remove(struct platform_device *pdev)
+static void cpcap_charger_shutdown(struct platform_device *pdev)
 {
 	struct cpcap_charger_ddata *ddata = platform_get_drvdata(pdev);
 	int error;
@@ -903,6 +903,11 @@ static int cpcap_charger_remove(struct platform_device *pdev)
 			 error);
 	cancel_delayed_work_sync(&ddata->vbus_work);
 	cancel_delayed_work_sync(&ddata->detect_work);
+}
+
+static int cpcap_charger_remove(struct platform_device *pdev)
+{
+	cpcap_charger_shutdown(pdev);
 
 	return 0;
 }
@@ -913,6 +918,7 @@ static struct platform_driver cpcap_charger_driver = {
 		.name	= "cpcap-charger",
 		.of_match_table = of_match_ptr(cpcap_charger_id_table),
 	},
+	.shutdown = cpcap_charger_shutdown,
 	.remove	= cpcap_charger_remove,
 };
 module_platform_driver(cpcap_charger_driver);
-- 
2.30.0
