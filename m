Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEA3182759
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 04:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbgCLDPS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 23:15:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:57898 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387453AbgCLDPS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 23:15:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 03BE8200C9D;
        Thu, 12 Mar 2020 04:15:16 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E81B6200C96;
        Thu, 12 Mar 2020 04:15:15 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5E1DE203C1;
        Thu, 12 Mar 2020 04:15:15 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PM / devfreq: Fix handling dev_pm_qos_remove_request result
Date:   Thu, 12 Mar 2020 05:15:11 +0200
Message-Id: <ea4c8b53f2a045116a5f70e24374ce62c85f0b81.1583982882.git.leonard.crestez@nxp.com>
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
---
 drivers/devfreq/devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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

