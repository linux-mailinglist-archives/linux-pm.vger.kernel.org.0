Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6930818350E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 16:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCLPgL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 11:36:11 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34268 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgCLPgL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Mar 2020 11:36:11 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0EF14200F9E;
        Thu, 12 Mar 2020 16:36:09 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0298C2001B8;
        Thu, 12 Mar 2020 16:36:09 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D605203C1;
        Thu, 12 Mar 2020 16:36:08 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        dAN cARPENTER <DAN.CARPENTER@ORACLE.COM>
Cc:     mYUNGjOO hAM <MYUNGJOO.HAM@SAMSUNG.COM>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Adam Ford <aford173@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] PM / devfreq: Fix handling dev_pm_qos_remove_request result
Date:   Thu, 12 Mar 2020 17:36:06 +0200
Message-Id: <06fc3c3d0a8bca1bce104ca9d6a7d5ff94bdf9ab.1584027085.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The dev_pm_qos_remove_request function can return 1 if
"aggregated constraint value has changed" so only negative values should
be reported as errors.

Fixes: 27dbc542f651 ("PM / devfreq: Use PM QoS for sysfs min/max_freq")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Cc: stable@vger.kernel.org
---
 drivers/devfreq/devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Changes since v1:
* Add fixes and cc: stable, drop empty line in message.
Link to v1: https://patchwork.kernel.org/patch/11433131/

I'm not sure this meet that stable kernel standard of "real bug that
bothers people" because all this fixes is a spurious dev_warn on device
removal. But Sasha Levin's script seem to collect a lot of low-priority
fixes anyway.

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 5c481ad1cfc7..6fecd11dafdd 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -703,17 +703,17 @@ static void devfreq_dev_release(struct device *dev)
 		dev_warn(dev->parent,
 			"Failed to remove min_freq notifier: %d\n", err);
 
 	if (dev_pm_qos_request_active(&devfreq->user_max_freq_req)) {
 		err = dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
-		if (err)
+		if (err < 0)
 			dev_warn(dev->parent,
 				"Failed to remove max_freq request: %d\n", err);
 	}
 	if (dev_pm_qos_request_active(&devfreq->user_min_freq_req)) {
 		err = dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
-		if (err)
+		if (err < 0)
 			dev_warn(dev->parent,
 				"Failed to remove min_freq request: %d\n", err);
 	}
 
 	if (devfreq->profile->exit)
-- 
2.17.1

