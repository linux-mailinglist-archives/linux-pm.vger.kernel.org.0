Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662F42A9066
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 08:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgKFHeP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 02:34:15 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38258 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726242AbgKFHeP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 02:34:15 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A67WHJ5010174;
        Fri, 6 Nov 2020 08:34:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=DW4TL1hhopvy7rJvSn490/m5hIsP5bvfPFPkyjlW1jk=;
 b=LYkC9Vz7Vwziot4/+mylXc7dN2fG63JgmHOJHm6WOGCR9tYBR74Weejlu3Q5m7gD2jsP
 vSBwmemP0ViRLf/nvmdo6PvJPF6BSICu4P/KrB/Tax6Bxv0J1BDExsecu2G/vUDZEN2V
 eH1DQYQk6Melvym81D0Y5XfAuuMZYLM7UgmSEhznxtN+ndrnJTuTaeaUe5rAxwP9pPl0
 8pDJDKD29+jfO1q77+F1AhltsoMpyxiV2PdVDpfohyawWo4gNBe+oo+MCbW+2biTJO/R
 PWVmRg1FVimZlf0BxxPZbH1A+VSwIOk0OjeSB1g8UsEZSgspY8x2Xm9e8Z9rx+7Ybyf8 QA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34gywrckrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 08:34:09 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DC55C10002A;
        Fri,  6 Nov 2020 08:34:08 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CF995226678;
        Fri,  6 Nov 2020 08:34:08 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
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
Subject: [PATCH v1 2/4] PM: domains: Make usage of device_wakeup_path() helper
Date:   Fri, 6 Nov 2020 08:33:56 +0100
Message-ID: <20201106073358.8379-3-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106073358.8379-1-patrice.chotard@st.com>
References: <20201106073358.8379-1-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG2NODE3.st.com
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
 drivers/base/power/domain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.17.1

