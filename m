Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E08EDC9244
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 21:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfJBTZV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 15:25:21 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51662 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfJBTZV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Oct 2019 15:25:21 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 422FE1A06BF;
        Wed,  2 Oct 2019 21:25:19 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3499E1A0698;
        Wed,  2 Oct 2019 21:25:19 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 82C3620629;
        Wed,  2 Oct 2019 21:25:18 +0200 (CEST)
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
Subject: [PATCH v9 1/8] PM / devfreq: Don't fail devfreq_dev_release if not in list
Date:   Wed,  2 Oct 2019 22:25:04 +0300
Message-Id: <13d816e94e66130ed7d286755b2aefd242638499.1570044052.git.leonard.crestez@nxp.com>
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

Right now devfreq_dev_release will print a warning and abort the rest of
the cleanup if the devfreq instance is not part of the global
devfreq_list. But this is a valid scenario, for example it can happen if
the governor can't be found or on any other init error that happens
after device_register.

Initialize devfreq->node to an empty list head in devfreq_add_device so
that list_del becomes a safe noop inside devfreq_dev_release and we can
continue the rest of the cleanup.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index b905963cea7d..7dc899da1172 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -581,15 +581,10 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
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
@@ -640,10 +635,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
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

