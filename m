Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A291D7197
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 09:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgERHQs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 03:16:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4808 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726676AbgERHQr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 May 2020 03:16:47 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EC212A17FD7449AE7F76;
        Mon, 18 May 2020 15:16:43 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 18 May 2020 15:16:34 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <Souvik.Chakravarty@arm.com>, <Thanu.Rangarajan@arm.com>
CC:     <Sudeep.Holla@arm.com>, <guohanjun@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH v2 1/3] cpufreq: handle the return value of '.set_boost()' properly
Date:   Mon, 18 May 2020 15:10:06 +0800
Message-ID: <1589785808-12138-2-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1589785808-12138-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1589785808-12138-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

'freq_qos_update_request()' called by 'cpufreq_boost_set_sw()' reutrns 1
when the effective constraint value of frequency QoS has changed. It's
not an error code. So handle the return value 1 of '.set_boost()' in
'cpufreq_boost_trigger_state()' properly.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4adac3a..bb6746e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2540,7 +2540,10 @@ int cpufreq_boost_trigger_state(int state)
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	ret = cpufreq_driver->set_boost(state);
-	if (ret) {
+	if (ret == 1) {
+		pr_debug("The effective constraint value of frequency QoS has changed.\n");
+		return 0;
+	} else if (ret) {
 		write_lock_irqsave(&cpufreq_driver_lock, flags);
 		cpufreq_driver->boost_enabled = !state;
 		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-- 
1.7.12.4

