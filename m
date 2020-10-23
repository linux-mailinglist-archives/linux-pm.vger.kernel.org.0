Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8BE296C53
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 11:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461703AbgJWJr7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 05:47:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40116 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S461606AbgJWJr7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Oct 2020 05:47:59 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E51D9FF76A67F7A51BAF;
        Fri, 23 Oct 2020 17:47:56 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 23 Oct 2020
 17:47:54 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>
Subject: [PATCH -next] cpufreq: remove unnecessary break
Date:   Fri, 23 Oct 2020 17:58:39 +0800
Message-ID: <20201023095839.32218-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A 'break' is not needed because of previous 'return'

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/cpufreq/e_powersaver.c | 1 -
 drivers/cpufreq/longhaul.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index 776a58bab0ff..ab93bce8ae77 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -223,7 +223,6 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 	case EPS_BRAND_C3:
 		pr_cont("C3\n");
 		return -ENODEV;
-		break;
 	}
 	/* Enable Enhanced PowerSaver */
 	rdmsrl(MSR_IA32_MISC_ENABLE, val);
diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index 123fb006810d..182a4dbca095 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -593,7 +593,6 @@ static void longhaul_setup_voltagescaling(void)
 		break;
 	default:
 		return;
-		break;
 	}
 	if (min_vid_speed >= highest_speed)
 		return;
-- 
2.17.1

