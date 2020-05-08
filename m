Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990BB1CA6E6
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 11:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgEHJR3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 05:17:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4298 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725710AbgEHJR3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 May 2020 05:17:29 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B24ECF3F380C0B35799A;
        Fri,  8 May 2020 17:17:26 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 17:17:18 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <Souvik.Chakravarty@arm.com>, <Thanu.Rangarajan@arm.com>
CC:     <Sudeep.Holla@arm.com>, <guohanjun@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH 1/3] cpufreq: fix the return value in 'cpufreq_boost_set_sw()'
Date:   Fri, 8 May 2020 17:11:02 +0800
Message-ID: <1588929064-30270-2-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1588929064-30270-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1588929064-30270-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When I try to add SW BOOST support for CPPC, I got the following error:
cpufreq: cpufreq_boost_trigger_state: Cannot enable BOOST
cpufreq: store_boost: Cannot enable BOOST!

It is because return value 1 of 'freq_qos_update_request()' means the
effective constraint value has changed, not a error code on failures.
But for 'cpufreq_driver.set_boost()', a nonzero return value means
failure. So change 'ret' to zero when 'freq_qos_update_request()'
returns a positive value.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4adac3a..475fb1b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2522,6 +2522,8 @@ static int cpufreq_boost_set_sw(int state)
 		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
 		if (ret < 0)
 			break;
+		else
+			ret = 0;
 	}
 
 	return ret;
-- 
1.7.12.4

