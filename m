Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FABB2702B2
	for <lists+linux-pm@lfdr.de>; Fri, 18 Sep 2020 18:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgIRQzk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Sep 2020 12:55:40 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50760 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIRQzj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Sep 2020 12:55:39 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08IGtSFe031511;
        Fri, 18 Sep 2020 11:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600448128;
        bh=dnBBdBAJkrSU9mR6n8dkW+xkv8/EHY+JavGeJ3J8HS0=;
        h=From:To:CC:Subject:Date;
        b=Zj2XpPaWnkRn/SrR8zK+9qULZOzS/nbS0pLie9aCUY+TvM8Xc4RvCXJUBIRQa1bL9
         ipZ2deeSmyK8V5gyycqcIj8+TfGpOiORTOe2KdsvRqXIbSAEmkn8meDGuwfSTe718q
         rd8+v2bTjqG+4JW0FtkeTtM9fmaF5WPDIp9ARq/U=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IGtSl2039017;
        Fri, 18 Sep 2020 11:55:28 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 11:55:27 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 11:55:27 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IGtQDc106420;
        Fri, 18 Sep 2020 11:55:27 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] pm: runtime: fix timer_expires on 32bits arch
Date:   Fri, 18 Sep 2020 19:55:18 +0300
Message-ID: <20200918165518.23246-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The commit 8234f6734c5d ("PM-runtime: Switch autosuspend over to using
hrtimers") switched PM runtime autosuspend to use hrtimers and all related
time accounting in ns, but missed update the struct
dev_pm_info->timer_expires to u64. This causes timer_expires value to be
truncated on 32bits architectures when assignment is done from u64 values:

rpm_suspend()
|- dev->power.timer_expires = expires;

Hence, fix it by changing timer_expires type to u64.

Cc: Vincent Guittot <vincent.guittot@linaro.org>
Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 include/linux/pm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index a30a4b54df52..47aca6bac1d6 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -590,7 +590,7 @@ struct dev_pm_info {
 #endif
 #ifdef CONFIG_PM
 	struct hrtimer		suspend_timer;
-	unsigned long		timer_expires;
+	u64			timer_expires;
 	struct work_struct	work;
 	wait_queue_head_t	wait_queue;
 	struct wake_irq		*wakeirq;
-- 
2.17.1

