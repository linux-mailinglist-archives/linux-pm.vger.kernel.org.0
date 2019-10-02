Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD0BCC9245
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 21:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfJBTZW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 15:25:22 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60054 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728612AbfJBTZW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Oct 2019 15:25:22 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0AC47200809;
        Wed,  2 Oct 2019 21:25:20 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F01F82006C7;
        Wed,  2 Oct 2019 21:25:19 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 453862060C;
        Wed,  2 Oct 2019 21:25:19 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 2/8] PM / devfreq: Fix devfreq_notifier_call returning errno
Date:   Wed,  2 Oct 2019 22:25:05 +0300
Message-Id: <10b1e5f93e7594852aa5cbfe1309bf486f70ecbb.1570044052.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1570044052.git.leonard.crestez@nxp.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1570044052.git.leonard.crestez@nxp.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Notifier callbacks shouldn't return negative errno but one of the
NOTIFY_OK/DONE/BAD values.

The OPP core will ignore return values from notifiers but returning a
value that matches NOTIFY_STOP_MASK will stop the notification chain.

Fix by always returning NOTIFY_OK.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/devfreq.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 7dc899da1172..32bbf6e80380 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -548,30 +548,32 @@ EXPORT_SYMBOL(devfreq_interval_update);
  */
 static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
 				 void *devp)
 {
 	struct devfreq *devfreq = container_of(nb, struct devfreq, nb);
-	int ret;
+	int err = -EINVAL;
 
 	mutex_lock(&devfreq->lock);
 
 	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
-	if (!devfreq->scaling_min_freq) {
-		mutex_unlock(&devfreq->lock);
-		return -EINVAL;
-	}
+	if (!devfreq->scaling_min_freq)
+		goto out;
 
 	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
-	if (!devfreq->scaling_max_freq) {
-		mutex_unlock(&devfreq->lock);
-		return -EINVAL;
-	}
+	if (!devfreq->scaling_max_freq)
+		goto out;
+
+	err = update_devfreq(devfreq);
 
-	ret = update_devfreq(devfreq);
+out:
 	mutex_unlock(&devfreq->lock);
+	if (err)
+		dev_err(devfreq->dev.parent,
+			"failed to update frequency from OPP notifier (%d)\n",
+			err);
 
-	return ret;
+	return NOTIFY_OK;
 }
 
 /**
  * devfreq_dev_release() - Callback for struct device to release the device.
  * @dev:	the devfreq device
-- 
2.17.1

