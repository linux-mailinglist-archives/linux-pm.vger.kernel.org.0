Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC1841A51A
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 04:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbhI1CIX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Sep 2021 22:08:23 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:8442 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbhI1CIW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Sep 2021 22:08:22 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5615278a6c89-e6cf5; Tue, 28 Sep 2021 10:06:30 +0800 (CST)
X-RM-TRANSID: 2ee5615278a6c89-e6cf5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee7615278a20fc-25757;
        Tue, 28 Sep 2021 10:06:30 +0800 (CST)
X-RM-TRANSID: 2ee7615278a20fc-25757
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH v2] power: supply: cpcap-battery: use device_get_match_data() to simplify code
Date:   Tue, 28 Sep 2021 10:06:23 +0800
Message-Id: <20210928020623.21192-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the function cpcap_battery_probe(), the driver only needs the
data object, so use device_get_match_data() instead, to make the
code cleaner.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
Changes from v1
 - change the title and commit message.
 - change the code to use other api to make code simple.
---
 drivers/power/supply/cpcap-battery.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 8d62d4241..18e3ff0e1 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -1026,20 +1026,13 @@ static const struct power_supply_desc cpcap_charger_battery_desc = {
 static int cpcap_battery_probe(struct platform_device *pdev)
 {
 	struct cpcap_battery_ddata *ddata;
-	const struct of_device_id *match;
 	struct power_supply_config psy_cfg = {};
 	int error;
+	const struct cpcap_battery_config *cfg;
 
-	match = of_match_device(of_match_ptr(cpcap_battery_id_table),
-				&pdev->dev);
-	if (!match)
-		return -EINVAL;
-
-	if (!match->data) {
-		dev_err(&pdev->dev, "no configuration data found\n");
-
+	cfg = device_get_match_data(&pdev->dev);
+	if (!cfg)
 		return -ENODEV;
-	}
 
 	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
@@ -1047,7 +1040,7 @@ static int cpcap_battery_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&ddata->irq_list);
 	ddata->dev = &pdev->dev;
-	memcpy(&ddata->config, match->data, sizeof(ddata->config));
+	memcpy(&ddata->config, cfg, sizeof(ddata->config));
 
 	ddata->reg = dev_get_regmap(ddata->dev->parent, NULL);
 	if (!ddata->reg)
-- 
2.20.1.windows.1



