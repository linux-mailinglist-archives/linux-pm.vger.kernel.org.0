Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE7A9D0DB
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 15:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbfHZNom (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 09:44:42 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55584 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731816AbfHZNoj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Aug 2019 09:44:39 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CE81D200241;
        Mon, 26 Aug 2019 15:44:37 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BFAFE20000C;
        Mon, 26 Aug 2019 15:44:37 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 3597420605;
        Mon, 26 Aug 2019 15:44:37 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/6] PM / devfreq: Add to devfreq_list immediately after registration
Date:   Mon, 26 Aug 2019 16:44:29 +0300
Message-Id: <29f4c0442344f0d1f333c5fbbcb9e60a4ffe3200.1566826075.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566826075.git.leonard.crestez@nxp.com>
References: <cover.1566826075.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1566826075.git.leonard.crestez@nxp.com>
References: <cover.1566826075.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

After the devfreq->dev is registered all error cleanup paths call
devfreq_dev_release which fails if the devfreq instance is not in the
global devfreq_list.

Fix by adding to the list immediately after registration.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/devfreq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Alternatively we could make devfreq_dev_release accept devfreq instance
not in the list.

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 15270293bea9..9b3bf64dc37d 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -677,10 +677,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	if (err) {
 		put_device(&devfreq->dev);
 		goto err_out;
 	}
 
+	/* Add to global list of devfreq instances */
+	mutex_lock(&devfreq_list_lock);
+	list_add(&devfreq->node, &devfreq_list);
+	mutex_unlock(&devfreq_list_lock);
+
 	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
 			array3_size(sizeof(unsigned int),
 				    devfreq->profile->max_state,
 				    devfreq->profile->max_state),
 			GFP_KERNEL);
@@ -719,12 +724,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		dev_err(dev, "%s: Unable to start governor for the device\n",
 			__func__);
 		goto err_init;
 	}
 
-	list_add(&devfreq->node, &devfreq_list);
-
 	mutex_unlock(&devfreq_list_lock);
 
 	return devfreq;
 
 err_init:
-- 
2.17.1

