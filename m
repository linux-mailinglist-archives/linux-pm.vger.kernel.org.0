Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34E19142C22
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 14:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgATNeE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 08:34:04 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8726 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726642AbgATNeE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 08:34:04 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KDXClf017210;
        Mon, 20 Jan 2020 14:34:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Xwp4k5WiF9SCPSpeAaAwJeBrzvHbrC++BBeoTvKLGWk=;
 b=ghFY7PsILGscFTUDKg4+h3STmLk/eTemV+K+eE+Mw96+1rzV2MfKzsk7E8S8Gz1h+lmi
 lQcpME2GlN/H2q+Nt9xKKvZS4oMbhBPfNJtp33uL2wdBgpJjk+/EmW5yMDdXqnp1ho+6
 165ETf4taD5oUDOBKKWrvsKijmqFTBLRdqlaAwr7uOjDQN/4EcS5m3hEXoEh9LyuNFWq
 rm2tv1Hg+049H4eS94Az+mRT36QzUAenVBOHAe9YisBvz6m/pAAkxESPYTt5qkSuqXaV
 +11TZXBiXxwAsSgkStUYnNjm6zrC5gaKRK4DOxqx7cS2Sfnv7zEp0Yow0jqpX6VYQTV3 FA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkr1dsrjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 14:34:01 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1BB05100038;
        Mon, 20 Jan 2020 14:34:01 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0E70E2B187F;
        Mon, 20 Jan 2020 14:34:01 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 20 Jan 2020 14:34:00
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <rjw@rjwysocki.net>, <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] cpuidle: sysfs: fix warning when compiling with W=1
Date:   Mon, 20 Jan 2020 14:33:59 +0100
Message-ID: <20200120133359.1672-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix kernel documentation comments to remove the warnings when
compiling with W=1.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/cpuidle/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 38ef770be90d..1909584e1e50 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -142,6 +142,7 @@ static struct attribute_group cpuidle_attr_group = {
 
 /**
  * cpuidle_add_interface - add CPU global sysfs attributes
+ * @dev: the target device
  */
 int cpuidle_add_interface(struct device *dev)
 {
@@ -153,6 +154,7 @@ int cpuidle_add_interface(struct device *dev)
 
 /**
  * cpuidle_remove_interface - remove CPU global sysfs attributes
+ * @dev: the target device
  */
 void cpuidle_remove_interface(struct device *dev)
 {
@@ -615,7 +617,7 @@ static struct kobj_type ktype_driver_cpuidle = {
 
 /**
  * cpuidle_add_driver_sysfs - adds the driver name sysfs attribute
- * @device: the target device
+ * @dev: the target device
  */
 static int cpuidle_add_driver_sysfs(struct cpuidle_device *dev)
 {
@@ -646,7 +648,7 @@ static int cpuidle_add_driver_sysfs(struct cpuidle_device *dev)
 
 /**
  * cpuidle_remove_driver_sysfs - removes the driver name sysfs attribute
- * @device: the target device
+ * @dev: the target device
  */
 static void cpuidle_remove_driver_sysfs(struct cpuidle_device *dev)
 {
-- 
2.15.0

