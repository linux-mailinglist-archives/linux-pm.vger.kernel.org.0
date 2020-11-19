Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B7E2B8C44
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 08:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgKSH0S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 02:26:18 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:9388 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgKSH0S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2020 02:26:18 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ7NNB0013879;
        Thu, 19 Nov 2020 08:26:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=2BXn53haZ5gJaPW1+VypT9nSjpu7NF73w6MtSEilcxU=;
 b=wBW4oUNE8ayiTG1J6cV/rFV2Lc5PQ3ItO+l2nrZT2vB2apiSafiV2mfo1CioxUe8TIXn
 PdrOBheRnmMlCwGD/ySYU/Wmg26MNL+f4Y5S2Z5jyx6Ib2LC72lX6/OUrljWB+hZoB0V
 zokUiJlQcj1PRuxIN4vKattYcydDq7tubEctgHz+4vXCsKnohoJMoP1ZymIDqJoGSDTL
 i7MTdji+ZWv8+mttl7L2vLR08+G2X+QVZN6Sf/ZuLkGL2YTGA5C61jI/nDWJBmNXOcvK
 f+cYmxmhRjacHnPCtTs68v25crcJydhTh75LGgjY20j4sMupvjalWbCcw39ZwnFkhUAv Hw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t58cxdjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 08:26:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5726D10002A;
        Thu, 19 Nov 2020 08:26:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 43F1722AD88;
        Thu, 19 Nov 2020 08:26:09 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Nov 2020 08:26:08
 +0100
From:   <patrice.chotard@st.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>
CC:     <patrice.chotard@st.com>, <erwan.leray@st.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <pierre-yves.mordret@st.com>, <amelie.delaunay@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH v2] PM: Add dev_wakeup_path() helper
Date:   Thu, 19 Nov 2020 08:25:39 +0100
Message-ID: <20201119072539.5673-1-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_05:2020-11-17,2020-11-19 signatures=0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Add dev_wakeup_path() helper to avoid to spread
dev->power.wakeup_path test in drivers.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes from v1:
  - Fold the 4 v1 patches into one
  - Add Ulf's Reviewed-by

 drivers/base/power/domain.c      |  4 ++--
 drivers/base/power/main.c        |  4 ++--
 drivers/i2c/busses/i2c-stm32f7.c |  4 ++--
 include/linux/pm_wakeup.h        | 10 ++++++++++
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 743268996336..e0894ef8457c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1142,7 +1142,7 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
 	if (ret)
 		return ret;
 
-	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
+	if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
 		return 0;
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
@@ -1196,7 +1196,7 @@ static int genpd_resume_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
+	if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
 		return pm_generic_resume_noirq(dev);
 
 	genpd_lock(genpd);
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index c7ac49042cee..921c5b2ec30a 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1359,7 +1359,7 @@ static void dpm_propagate_wakeup_to_parent(struct device *dev)
 
 	spin_lock_irq(&parent->power.lock);
 
-	if (dev->power.wakeup_path && !parent->power.ignore_children)
+	if (device_wakeup_path(dev) && !parent->power.ignore_children)
 		parent->power.wakeup_path = true;
 
 	spin_unlock_irq(&parent->power.lock);
@@ -1627,7 +1627,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 		goto Complete;
 
 	/* Avoid direct_complete to let wakeup_path propagate. */
-	if (device_may_wakeup(dev) || dev->power.wakeup_path)
+	if (device_may_wakeup(dev) || device_wakeup_path(dev))
 		dev->power.direct_complete = false;
 
 	if (dev->power.direct_complete) {
diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index f41f51a176a1..9aa8e65b511e 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -2322,7 +2322,7 @@ static int stm32f7_i2c_suspend(struct device *dev)
 
 	i2c_mark_adapter_suspended(&i2c_dev->adap);
 
-	if (!device_may_wakeup(dev) && !dev->power.wakeup_path) {
+	if (!device_may_wakeup(dev) && !device_wakeup_path(dev)) {
 		ret = stm32f7_i2c_regs_backup(i2c_dev);
 		if (ret < 0) {
 			i2c_mark_adapter_resumed(&i2c_dev->adap);
@@ -2341,7 +2341,7 @@ static int stm32f7_i2c_resume(struct device *dev)
 	struct stm32f7_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 	int ret;
 
-	if (!device_may_wakeup(dev) && !dev->power.wakeup_path) {
+	if (!device_may_wakeup(dev) && !device_wakeup_path(dev)) {
 		ret = pm_runtime_force_resume(dev);
 		if (ret < 0)
 			return ret;
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index aa3da6611533..196a157456aa 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -84,6 +84,11 @@ static inline bool device_may_wakeup(struct device *dev)
 	return dev->power.can_wakeup && !!dev->power.wakeup;
 }
 
+static inline bool device_wakeup_path(struct device *dev)
+{
+	return dev->power.wakeup_path;
+}
+
 static inline void device_set_wakeup_path(struct device *dev)
 {
 	dev->power.wakeup_path = true;
@@ -174,6 +179,11 @@ static inline bool device_may_wakeup(struct device *dev)
 	return dev->power.can_wakeup && dev->power.should_wakeup;
 }
 
+static inline bool device_wakeup_path(struct device *dev)
+{
+	return false;
+}
+
 static inline void device_set_wakeup_path(struct device *dev) {}
 
 static inline void __pm_stay_awake(struct wakeup_source *ws) {}
-- 
2.17.1

