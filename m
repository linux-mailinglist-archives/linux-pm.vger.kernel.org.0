Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21F9A8B699
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 13:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfHML1W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 07:27:22 -0400
Received: from inva020.nxp.com ([92.121.34.13]:46104 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfHML1W (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Aug 2019 07:27:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A509A1A077E;
        Tue, 13 Aug 2019 13:27:19 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8DDD01A0240;
        Tue, 13 Aug 2019 13:27:19 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 040AA2060E;
        Tue, 13 Aug 2019 13:27:18 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] PM / devfreq: passive: Use non-devm notifiers
Date:   Tue, 13 Aug 2019 14:27:14 +0300
Message-Id: <c61515ebec930dd5afe4ae224bfcda118ea8fe55.1565695568.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devfreq passive governor registers and unregisters devfreq
transition notifiers on DEVFREQ_GOV_START/GOV_STOP using devm wrappers.

If devfreq itself is registered with devm then a warning is triggered on
rmmod from devm_devfreq_unregister_notifier. Call stack looks like this:

	devm_devfreq_unregister_notifier+0x30/0x40
	devfreq_passive_event_handler+0x4c/0x88
	devfreq_remove_device.part.8+0x6c/0x9c
	devm_devfreq_dev_release+0x18/0x20
	release_nodes+0x1b0/0x220
	devres_release_all+0x78/0x84
	device_release_driver_internal+0x100/0x1c0
	driver_detach+0x4c/0x90
	bus_remove_driver+0x7c/0xd0
	driver_unregister+0x2c/0x58
	platform_driver_unregister+0x10/0x18
	imx_devfreq_platdrv_exit+0x14/0xd40 [imx_devfreq]

This happens because devres_release_all will first remove all the nodes
into a separate todo list so the nested devres_release from
devm_devfreq_unregister_notifier won't find anything.

Fix the warning by calling the non-devm APIS for frequency notification.
Using devm wrappers is not actually useful for a governor anyway: it
relies on the devfreq core to correctly match the GOV_START/GOV_STOP
notifications.

Fixes: 996133119f57 ("PM / devfreq: Add new passive governor")
Cc: stable@vger.kernel.org
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

---
Changes since v2:
* Add fixes: tag and reorder to be similar with other patches
* No code changes
Link to v2: https://patchwork.kernel.org/patch/11091119/

Sorry

Changes since v1:
* Remove unused variable
Link to v1: https://patchwork.kernel.org/patch/11084541/

 drivers/devfreq/governor_passive.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 58308948b863..be6eeab9c814 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -147,11 +147,10 @@ static int devfreq_passive_notifier_call(struct notifier_block *nb,
 }
 
 static int devfreq_passive_event_handler(struct devfreq *devfreq,
 				unsigned int event, void *data)
 {
-	struct device *dev = devfreq->dev.parent;
 	struct devfreq_passive_data *p_data
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq *parent = (struct devfreq *)p_data->parent;
 	struct notifier_block *nb = &p_data->nb;
 	int ret = 0;
@@ -163,16 +162,16 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 	case DEVFREQ_GOV_START:
 		if (!p_data->this)
 			p_data->this = devfreq;
 
 		nb->notifier_call = devfreq_passive_notifier_call;
-		ret = devm_devfreq_register_notifier(dev, parent, nb,
+		ret = devfreq_register_notifier(parent, nb,
 					DEVFREQ_TRANSITION_NOTIFIER);
 		break;
 	case DEVFREQ_GOV_STOP:
-		devm_devfreq_unregister_notifier(dev, parent, nb,
-					DEVFREQ_TRANSITION_NOTIFIER);
+		WARN_ON(devfreq_unregister_notifier(parent, nb,
+					DEVFREQ_TRANSITION_NOTIFIER));
 		break;
 	default:
 		break;
 	}
 
-- 
2.17.1

