Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6317BB58E2
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2019 02:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbfIRASd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 20:18:33 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45788 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfIRASd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Sep 2019 20:18:33 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6AEB61A06EA;
        Wed, 18 Sep 2019 02:18:31 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5E63B1A0700;
        Wed, 18 Sep 2019 02:18:31 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C88CB20601;
        Wed, 18 Sep 2019 02:18:30 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/8] PM / devfreq: Don't fail devfreq_dev_release if not in list
Date:   Wed, 18 Sep 2019 03:18:21 +0300
Message-Id: <60f8aa909fe209632734b6c637dffbc7554f996c.1568764439.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568764439.git.leonard.crestez@nxp.com>
References: <cover.1568764439.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1568764439.git.leonard.crestez@nxp.com>
References: <cover.1568764439.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Right now devfreq_dev_release will print a warning and abort the rest of
the cleanup if the devfreq instance is not part of the global
devfreq_list. But this is a valid scenario, for example it can happen if
the governor can't be found or on any other init error that happens
after device_register.

Initialize devfreq->node to an empty list head in devfreq_add_device so
that list_del becomes a safe noop inside devfreq_dev_release and we can
continue the rest of the cleanup.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/devfreq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 665575228c4f..a715f27f35fd 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -582,15 +582,10 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
 static void devfreq_dev_release(struct device *dev)
 {
 	struct devfreq *devfreq = to_devfreq(dev);
 
 	mutex_lock(&devfreq_list_lock);
-	if (IS_ERR(find_device_devfreq(devfreq->dev.parent))) {
-		mutex_unlock(&devfreq_list_lock);
-		dev_warn(&devfreq->dev, "releasing devfreq which doesn't exist\n");
-		return;
-	}
 	list_del(&devfreq->node);
 	mutex_unlock(&devfreq_list_lock);
 
 	if (devfreq->profile->exit)
 		devfreq->profile->exit(devfreq->dev.parent);
@@ -641,10 +636,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	mutex_init(&devfreq->lock);
 	mutex_lock(&devfreq->lock);
 	devfreq->dev.parent = dev;
 	devfreq->dev.class = devfreq_class;
 	devfreq->dev.release = devfreq_dev_release;
+	INIT_LIST_HEAD(&devfreq->node);
 	devfreq->profile = profile;
 	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
 	devfreq->previous_freq = profile->initial_freq;
 	devfreq->last_status.current_frequency = profile->initial_freq;
 	devfreq->data = data;
-- 
2.17.1

