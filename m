Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A68DF109C
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 08:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfKFHq6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 02:46:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728291AbfKFHq6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Nov 2019 02:46:58 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0A0BB7354256DFDA87CA;
        Wed,  6 Nov 2019 15:46:57 +0800 (CST)
Received: from HGHY2S004841851.china.huawei.com (10.184.217.114) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 6 Nov 2019 15:46:50 +0800
From:   Shen Kai <shenkai8@huawei.com>
To:     <viresh.kumar@linaro.org>, <rjw@rjwysocki.net>
CC:     <hushiyuan@huawei.com>, <linfeilong@huawei.com>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH]cpufreq: add NULL check to the store method of cpufreq
Date:   Wed, 6 Nov 2019 07:46:42 +0000
Message-ID: <1573026402-21032-1-git-send-email-shenkai8@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.217.114]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: shenkai <shenkai8@huawei.com>

Add NULL check in the store function here to avoid NULL callback invoking.
Though some interfaces of cpufreq are set as read-only, user can still get 
write permission using chmod which can lead to a kernel crash.

The following operations can lead to a kernel crash.

chmod +w /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
echo 1 >  /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq

This bug was found on linux 4.19

Signed-off-by: shenkai <shenkai8@huawei.com>
Reported-by: linfeilong <linfeilong@huawei.com>
Reviewed-by: linfeilong <linfeilong@huawei.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index bffc11b..4ccaa96 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -947,6 +947,9 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 	struct freq_attr *fattr = to_attr(attr);
 	ssize_t ret = -EINVAL;
 
+	if (!fattr->store)
+		return ret;
+
 	/*
 	 * cpus_read_trylock() is used here to work around a circular lock
 	 * dependency problem with respect to the cpufreq_register_driver().
-- 
2.6.4.windows.1


