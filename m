Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA0332D03C
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 10:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhCDJ4r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 04:56:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13125 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhCDJ4R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 04:56:17 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DrmR44DrQz16GLg;
        Thu,  4 Mar 2021 17:53:52 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Mar 2021 17:55:25 +0800
From:   'Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] cpufreq: qcom-hw: Fix return value check in qcom_cpufreq_hw_cpu_init()
Date:   Thu, 4 Mar 2021 10:04:23 +0000
Message-ID: <20210304100423.3856265-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function ioremap() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Fixes: 67fc209b527d ("cpufreq: qcom-hw: drop devm_xxx() calls from init/exit hooks")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index d3c23447b892..6e59ec4fb564 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -317,9 +317,9 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	base = ioremap(res->start, resource_size(res));
-	if (IS_ERR(base)) {
+	if (!base) {
 		dev_err(dev, "failed to map resource %pR\n", res);
-		ret = PTR_ERR(base);
+		ret = -ENOMEM;
 		goto release_region;
 	}
 

