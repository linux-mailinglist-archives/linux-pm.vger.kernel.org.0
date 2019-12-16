Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDCAA120871
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 15:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfLPOT0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 09:19:26 -0500
Received: from foss.arm.com ([217.140.110.172]:56976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbfLPOT0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Dec 2019 09:19:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E33131FB;
        Mon, 16 Dec 2019 06:19:25 -0800 (PST)
Received: from e123648.arm.com (unknown [10.37.12.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11A353F718;
        Mon, 16 Dec 2019 06:19:23 -0800 (PST)
From:   lukasz.luba@arm.com
To:     linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc:     amit.kucheria@verdurent.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: [PATCH  2/2] thermal: devfreq_cooling: Add device node reclaiming in devfreq_cooling_register()
Date:   Mon, 16 Dec 2019 14:19:09 +0000
Message-Id: <20191216141909.30063-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216141909.30063-1-lukasz.luba@arm.com>
References: <20191216141909.30063-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lukasz Luba <lukasz.luba@arm.com>

Since the devfreq device parent might have the proper device node, devfreq
cooling registration can re-use it. This will allow thermal bind function
to pin thermal zone with cooling device based on definition in the device
tree automatically. It will simplify registration of cooling device in
drivers code.
Fix also 'unregister path' and add IS_ERR_OR_NULL() check.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 1861241c7ef5..c29056cb4a71 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -574,7 +574,24 @@ EXPORT_SYMBOL_GPL(of_devfreq_cooling_register);
  */
 struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df)
 {
-	return of_devfreq_cooling_register(NULL, df);
+	struct thermal_cooling_device *dfc;
+	struct device_node *np = NULL;
+	struct device *dev;
+
+	if (IS_ERR_OR_NULL(df))
+		return ERR_PTR(-EINVAL);
+
+	dev = df->dev.parent;
+
+	if (dev && dev->of_node)
+		np = of_node_get(dev->of_node);
+
+	dfc = of_devfreq_cooling_register(np, df);
+
+	if (np)
+		of_node_put(np);
+
+	return dfc;
 }
 EXPORT_SYMBOL_GPL(devfreq_cooling_register);
 
@@ -586,7 +603,7 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
 	struct devfreq_cooling_device *dfc;
 
-	if (!cdev)
+	if (IS_ERR_OR_NULL(cdev))
 		return;
 
 	dfc = cdev->devdata;
-- 
2.17.1

