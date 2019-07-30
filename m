Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5377A570
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 12:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfG3KEn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 06:04:43 -0400
Received: from icp-osb-irony-out1.external.iinet.net.au ([203.59.1.210]:44024
        "EHLO icp-osb-irony-out1.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725947AbfG3KEn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 06:04:43 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AEBgC6FUBd/1/rO8tmghmDVSESFxO?=
 =?us-ascii?q?NGogdAYJDAYkskRsJAQEBAQEBAQEBGxwBAYQ6BIJoNwYOAQMBAQEEAQEBAQU?=
 =?us-ascii?q?BbYRlRYV4L3JwEoMigXcTrVwziHmBSIE0hwmEboFAP4N1bIQDChuFfwSVOpV?=
 =?us-ascii?q?DCYEld5QYGZgRi2SBWZloIoFYTR8ZgyeCeY4aNTCLdIJSAQE?=
X-IPAS-Result: =?us-ascii?q?A2AEBgC6FUBd/1/rO8tmghmDVSESFxONGogdAYJDAYksk?=
 =?us-ascii?q?RsJAQEBAQEBAQEBGxwBAYQ6BIJoNwYOAQMBAQEEAQEBAQUBbYRlRYV4L3JwE?=
 =?us-ascii?q?oMigXcTrVwziHmBSIE0hwmEboFAP4N1bIQDChuFfwSVOpVDCYEld5QYGZgRi?=
 =?us-ascii?q?2SBWZloIoFYTR8ZgyeCeY4aNTCLdIJSAQE?=
X-IronPort-AV: E=Sophos;i="5.64,326,1559491200"; 
   d="scan'208";a="229597879"
Received: from 203-59-235-95.perm.iinet.net.au (HELO rtcentos7.electromag.com.au) ([203.59.235.95])
  by icp-osb-irony-out1.iinet.net.au with ESMTP; 30 Jul 2019 18:04:40 +0800
From:   Richard Tresidder <rtresidd@electromag.com.au>
To:     sre@kernel.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        rfontana@redhat.com, allison@lohutok.net,
        rtresidd@electromag.com.au, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] power/supply/sbs-battery: Add ability to force load a battery via the devicetree
Date:   Tue, 30 Jul 2019 18:04:39 +0800
Message-Id: <1564481079-39238-1-git-send-email-rtresidd@electromag.com.au>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the ability to force load a hot pluggable battery during boot where
there is no gpio detect method available and the module is statically
built. Normal polling will then occur on that battery when it is inserted.

Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
---

Notes:
    sbs_battery: Add ability to force load from devicetree
    
    Add the ability to force load a hot pluggable battery during boot where
    there is no gpio detect method available and the module is statically
    built. Normal polling will then occur on that battery when it is inserted.
    
    v2: move forceload variable to a local in probe.
        merge device tree documentation into this patch

 drivers/power/supply/sbs-battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 048d205..b55721d 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -816,6 +816,7 @@ static int sbs_probe(struct i2c_client *client,
 	struct power_supply_config psy_cfg = {};
 	int rc;
 	int irq;
+	bool dt_force_load;
 
 	sbs_desc = devm_kmemdup(&client->dev, &sbs_default_desc,
 			sizeof(*sbs_desc), GFP_KERNEL);
@@ -852,6 +853,9 @@ static int sbs_probe(struct i2c_client *client,
 	if (rc)
 		chip->poll_retry_count = 0;
 
+	dt_force_load = of_property_read_bool(client->dev.of_node,
+						"sbs,force-load");
+
 	if (pdata) {
 		chip->poll_retry_count = pdata->poll_retry_count;
 		chip->i2c_retry_count  = pdata->i2c_retry_count;
@@ -890,7 +894,7 @@ static int sbs_probe(struct i2c_client *client,
 	 * Before we register, we might need to make sure we can actually talk
 	 * to the battery.
 	 */
-	if (!(force_load || chip->gpio_detect)) {
+	if (!(force_load || chip->gpio_detect || dt_force_load)) {
 		rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
 
 		if (rc < 0) {
-- 
1.8.3.1

