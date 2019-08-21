Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A54E97900
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 14:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfHUMPz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 08:15:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726894AbfHUMPz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Aug 2019 08:15:55 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9B3DE709F13984C0D1AA;
        Wed, 21 Aug 2019 20:15:51 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 21 Aug 2019
 20:15:45 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <agross@kernel.org>, <rjw@rjwysocki.net>,
        <viresh.kumar@linaro.org>, <sibis@codeaurora.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] cpufreq: qcom-hw: remove set but not used variable 'prev_cc'
Date:   Wed, 21 Aug 2019 20:14:45 +0800
Message-ID: <20190821121445.72588-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

drivers/cpufreq/qcom-cpufreq-hw.c: In function qcom_cpufreq_hw_read_lut:
drivers/cpufreq/qcom-cpufreq-hw.c:89:38: warning:
 variable prev_cc set but not used [-Wunused-but-set-variable]

It is not used since commit 3003e75a5045 ("cpufreq:
qcom-hw: Update logic to detect turbo frequency")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 3eea197..a9ae2f8 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -86,7 +86,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 				    struct cpufreq_policy *policy,
 				    void __iomem *base)
 {
-	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
+	u32 data, src, lval, i, core_count, prev_freq = 0, freq;
 	u32 volt;
 	struct cpufreq_frequency_table	*table;
 
@@ -139,7 +139,6 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 			break;
 		}
 
-		prev_cc = core_count;
 		prev_freq = freq;
 	}
 
-- 
2.7.4


