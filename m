Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D0B472AEF
	for <lists+linux-pm@lfdr.de>; Mon, 13 Dec 2021 12:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhLMLLK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Dec 2021 06:11:10 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:32425 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229836AbhLMLLK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Dec 2021 06:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639393870; x=1670929870;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=5YidXyIgQI0E20XN+ohYDbgdQ4PIMU4JJRYFHx89oE8=;
  b=KDTObcZgeUBgX5pdS6MRxVHXoOGUCif3vFLXR8NStYXXpk39M5ryOOBI
   bo0sAGQ8WXHVXvpbvXJk3ks3kpXsNIR5A+gS53tl7zowqPgvJ1+EjBYDq
   TqVXQfjjduRSn/IYSgdSS/QWldQs+d0qX4tRPL+hx6uRch67l/jzuT1kK
   o=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Dec 2021 03:11:09 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 03:11:01 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 13 Dec 2021 03:11:02 -0800
Received: from codeaurora.org (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 13 Dec
 2021 03:10:59 -0800
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        David Collins <quic_collinsd@quicinc.com>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Subject: [PATCH] power_supply: Register cooling device outside of probe
Date:   Mon, 13 Dec 2021 16:40:41 +0530
Message-ID: <1639393841-17444-1-git-send-email-quic_manafm@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Registering the cooling device from the probe can result in the
execution of get_property() function before it gets initialized.

To avoid this, register the cooling device from a workqueue
instead of registering in the probe.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
---
 drivers/power/supply/power_supply_core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 10a357a..c306b9d 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -132,6 +132,7 @@ void power_supply_changed(struct power_supply *psy)
 }
 EXPORT_SYMBOL_GPL(power_supply_changed);
 
+static int psy_register_cooler(struct device *dev, struct power_supply *psy);
 /*
  * Notify that power supply was registered after parent finished the probing.
  *
@@ -139,6 +140,8 @@ EXPORT_SYMBOL_GPL(power_supply_changed);
  * calling power_supply_changed() directly from power_supply_register()
  * would lead to execution of get_property() function provided by the driver
  * too early - before the probe ends.
+ * Also, registering cooling device from the probe will execute the
+ * get_property() function. So register the cooling device after the probe.
  *
  * Avoid that by waiting on parent's mutex.
  */
@@ -156,6 +159,7 @@ static void power_supply_deferred_register_work(struct work_struct *work)
 	}
 
 	power_supply_changed(psy);
+	psy_register_cooler(psy->dev.parent, psy);
 
 	if (psy->dev.parent)
 		mutex_unlock(&psy->dev.parent->mutex);
@@ -1257,10 +1261,6 @@ __power_supply_register(struct device *parent,
 	if (rc)
 		goto register_thermal_failed;
 
-	rc = psy_register_cooler(psy);
-	if (rc)
-		goto register_cooler_failed;
-
 	rc = power_supply_create_triggers(psy);
 	if (rc)
 		goto create_triggers_failed;
@@ -1290,8 +1290,6 @@ __power_supply_register(struct device *parent,
 add_hwmon_sysfs_failed:
 	power_supply_remove_triggers(psy);
 create_triggers_failed:
-	psy_unregister_cooler(psy);
-register_cooler_failed:
 	psy_unregister_thermal(psy);
 register_thermal_failed:
 	device_del(dev);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

