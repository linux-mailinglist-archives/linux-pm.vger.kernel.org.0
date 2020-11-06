Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC732A906A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 08:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgKFHeR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 02:34:17 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:56252 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726248AbgKFHeP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 02:34:15 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A67WAXP024861;
        Fri, 6 Nov 2020 08:34:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=HuL+1QubX11jEfHh0jLX+sDvnHzjyso9r7m7MxCcH9Q=;
 b=JEIfQOvbW17tK6kYUxOYDhO2xQK9TubGaeBokFcjPSSX9cOiAXXPQ2fBAmsgAZ5S8E3u
 INmJhNxLgHuJLWEfcMI8R8ZeQeaBJ/LLWDRXB47ieZaRhY5SbOG5860DYx/SmkD2Q+f5
 D4OJYoTXftFrOHVjapYX77Spvo8wwm/acA5tPfIfeDW/oHJrkocuRXxS2rG2EckhYhMq
 UOICxTBVBnsFIiakX/qfnQoGnWAVLiA8hOqPoj/XEpGLHxQSPtQ+QK1bniCwVnTZ/VHq
 z8vWXGaIKoMwLO/Gf9n89EN3EAbgu/m0tS8qRV2R75kVzKEIrejSLxpCEQpzT82FBnD0 cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34h00etmn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 08:34:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 97C84100034;
        Fri,  6 Nov 2020 08:34:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8E123226678;
        Fri,  6 Nov 2020 08:34:09 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov 2020 08:34:08
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
Subject: [PATCH v1 3/4] PM: core: Make usage of device_wakeup_path() helper
Date:   Fri, 6 Nov 2020 08:33:57 +0100
Message-ID: <20201106073358.8379-4-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106073358.8379-1-patrice.chotard@st.com>
References: <20201106073358.8379-1-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_02:2020-11-05,2020-11-06 signatures=0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Make usage of dev_wakeup_path() helper.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/base/power/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.17.1

