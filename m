Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8583C18CD0D
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 12:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgCTLc7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 07:32:59 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:25034 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726814AbgCTLc7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 07:32:59 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02KBS9l7024109;
        Fri, 20 Mar 2020 12:32:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=9JFlGiU/3onpGHyyQ9mKFWQ3/a8dPy+vRefEgTYZXMI=;
 b=qCJNcH7JzjVbvCjknOM7z3yXzxEv3VCT7Opan2ZUd/PmdWGnaaYeOZ6jZ4EVWpDjRptI
 mZ/n+xIOBsbPmYhAB0PFvZQ78NdKAiGIjyjVCi5z3X/faXnG1S8vj65tazqmYaefr7h7
 3xGOZ157dDRAYD7M8mxny1pge28bRcJo3i2YbfsvbSgp7NPLBWTcUHBetn/7of8v2KTF
 6Dags31i+CC22YpVevyzDhkIahyyCSr3KlhcAl+RvinmuuEBoC1lnvpT51EXj04nNAcb
 AbuOvvkijTIRVg6TqInQBr/DJ3YFYs8cfgketZ0+LiYR4/KRB66irU2OmmX0NlRX8Y3E Cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yu8etqf38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Mar 2020 12:32:56 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2AF76100038;
        Fri, 20 Mar 2020 12:32:51 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1FB172A9700;
        Fri, 20 Mar 2020 12:32:51 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Mar 2020 12:32:50
 +0100
From:   <patrice.chotard@st.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <patrice.chotard@st.com>, Erwan Le Ray <erwan.leray@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: PM / wakeup: Add dev_wakeup_path() helper
Date:   Fri, 20 Mar 2020 12:32:33 +0100
Message-ID: <20200320113233.10219-1-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-20_03:2020-03-20,2020-03-20 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Add dev_wakeup_path() helper to avoid to spread
dev->power.wakeup_path test in drivers.

In case CONFIG_PM_SLEEP is not set, wakeup_path is not defined,
dev_wakeup_path() is returning false.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

Currently, in mainline kernel, no drivers are testing dev->power.wakeup_path
for PM purpose. A stm32 serial driver patch will be submitted soon and will 
make usage of this helper.

 include/linux/pm_wakeup.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index aa3da6611533..d0bd13c19253 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -84,6 +84,11 @@ static inline bool device_may_wakeup(struct device *dev)
 	return dev->power.can_wakeup && !!dev->power.wakeup;
 }
 
+static inline bool device_wakeup_path(struct device *dev)
+{
+	return !!dev->power.wakeup_path;
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

