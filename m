Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B022A9067
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 08:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgKFHeO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 02:34:14 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:56230 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbgKFHeO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 02:34:14 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A67WF6s025144;
        Fri, 6 Nov 2020 08:34:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=qmmIKwYZ90BVKQOZUzUSLDoaeQqLehemAxhOjRrw3Ik=;
 b=ffSe7ENoXdV8XDBuIkygsPI7I9zlHv3zP1l2rV4mRzw2PHpcHk4X5iOK0JjzbtItO6ZB
 Yl3yF3OUKPgMxpkCe8gU9IyDVPKm3W9h9Fw32zZkvPz7npE67bxg0111k/Z9GA9Tj83g
 5FKEGOJ8aI70R10PpIA8Kug3Qw/EWSs3o+Egl+5izPAWUv2sHFCx2SP/fIVk5i4A+GzK
 da8ndJyCsd0b0yThI3dZi3/K9f0lGwLYISWOTWJh3QW9NrDcKe4bjJ/PTCnq03cppGAV
 CYKQP0QGJWfo4WEbg9wHQ6SJSxj1hEoKJuD3konduBiMPLG5fWGzrR8wwv4jPnRr06M6 uQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34h00etmn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 08:34:08 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3E38C100038;
        Fri,  6 Nov 2020 08:34:08 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 322F222667A;
        Fri,  6 Nov 2020 08:34:08 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov 2020 08:34:07
 +0100
From:   <patrice.chotard@st.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>
CC:     <patrice.chotard@st.com>, Erwan Le Ray <erwan.leray@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        <amelie.delaunay@st.com>, <erwan_leray@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH v1 1/4] PM / wakeup: Add dev_wakeup_path() helper
Date:   Fri, 6 Nov 2020 08:33:55 +0100
Message-ID: <20201106073358.8379-2-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106073358.8379-1-patrice.chotard@st.com>
References: <20201106073358.8379-1-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_02:2020-11-05,2020-11-06 signatures=0
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
 include/linux/pm_wakeup.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

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

