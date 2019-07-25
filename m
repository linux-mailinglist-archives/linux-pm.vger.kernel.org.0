Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF83744B2
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 07:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390407AbfGYFGJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 01:06:09 -0400
Received: from icp-osb-irony-out1.external.iinet.net.au ([203.59.1.210]:42198
        "EHLO icp-osb-irony-out1.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390362AbfGYFGI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 01:06:08 -0400
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jul 2019 01:06:07 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CxDAAmNTld/1/rO8tlhW4hEhcTjRi?=
 =?us-ascii?q?IFwGCQwGDWYVTkRcJAQEBAQEBAQEBGxwBAYQ6BIMAOBMBAwEBAQQBAQEBBQF?=
 =?us-ascii?q?thGVFhXgvcnASgyKBdxOtZDOIeYFIgTSHCYRugUA/g3VshAMKG4V/BJU3lTQ?=
 =?us-ascii?q?JgSV2lBIZmAqLX4FYmWMhgVhNHxmDJ4J5jho1MIskglIBAQ?=
X-IPAS-Result: =?us-ascii?q?A2CxDAAmNTld/1/rO8tlhW4hEhcTjRiIFwGCQwGDWYVTk?=
 =?us-ascii?q?RcJAQEBAQEBAQEBGxwBAYQ6BIMAOBMBAwEBAQQBAQEBBQFthGVFhXgvcnASg?=
 =?us-ascii?q?yKBdxOtZDOIeYFIgTSHCYRugUA/g3VshAMKG4V/BJU3lTQJgSV2lBIZmAqLX?=
 =?us-ascii?q?4FYmWMhgVhNHxmDJ4J5jho1MIskglIBAQ?=
X-IronPort-AV: E=Sophos;i="5.64,305,1559491200"; 
   d="scan'208";a="228497770"
Received: from 203-59-235-95.perm.iinet.net.au (HELO rtcentos7.electromag.com.au) ([203.59.235.95])
  by icp-osb-irony-out1.iinet.net.au with ESMTP; 25 Jul 2019 12:56:43 +0800
From:   Richard Tresidder <rtresidd@electromag.com.au>
To:     sre@kernel.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        rfontana@redhat.com, allison@lohutok.net,
        rtresidd@electromag.com.au, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] power: supply: sbs-battery: Add ability to force load a battery via the devicetree
Date:   Thu, 25 Jul 2019 12:56:41 +0800
Message-Id: <1564030601-14639-1-git-send-email-rtresidd@electromag.com.au>
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
    Add the ability to force load a hot pluggable battery during boot where
    there is no gpio detect method available and the module is statically
    built. Normal polling will then occur on that battery when it is inserted.

 drivers/power/supply/sbs-battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 048d205..ea8ba3e 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -161,6 +161,7 @@ struct sbs_info {
 	int				poll_time;
 	u32				i2c_retry_count;
 	u32				poll_retry_count;
+	bool				force_load;
 	struct delayed_work		work;
 	struct mutex			mode_lock;
 	u32				flags;
@@ -852,6 +853,9 @@ static int sbs_probe(struct i2c_client *client,
 	if (rc)
 		chip->poll_retry_count = 0;
 
+	chip->force_load = of_property_read_bool(client->dev.of_node,
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
+	if (!(force_load || chip->gpio_detect || chip->force_load)) {
 		rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
 
 		if (rc < 0) {
-- 
1.8.3.1

