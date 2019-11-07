Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B95F7F26C2
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 06:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfKGFIl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 00:08:41 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38932 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbfKGFIl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 Nov 2019 00:08:41 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7099453EC5D9C231290F;
        Thu,  7 Nov 2019 13:08:36 +0800 (CST)
Received: from HGHY2S004841851.china.huawei.com (10.184.217.114) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Thu, 7 Nov 2019 13:08:27 +0800
From:   Shen Kai <shenkai8@huawei.com>
To:     <viresh.kumar@linaro.org>
CC:     <hushiyuan@huawei.com>, <linfeilong@huawei.com>,
        <rafael.j.wysocki@intel.com>, <linux-pm@vger.kernel.org>,
        <rjw@rjwysocki.net>
Subject: [PATCH v3]cpufreq: add NULL check to the store method of cpufreq
Date:   Thu, 7 Nov 2019 05:08:17 +0000
Message-ID: <1573103297-7252-1-git-send-email-shenkai8@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
In-Reply-To: <20191107030601.xqe2tpcprkg7epul@vireshk-i7>
References: <20191107030601.xqe2tpcprkg7epul@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.217.114]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Kai Shen <shenkai8@huawei.com>

Add NULL check in the store function here to avoid NULL callback invoking.
Though some interfaces of cpufreq are set as read-only, user can still get 
write permission using chmod which can lead to a kernel crash.

The following operations can lead to a kernel crash.

chmod +w /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
echo 1 >  /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq

This bug was found on linux 4.19

Signed-off-by: Kai Shen <shenkai8@huawei.com>
Reported-by: Feilong Lin <linfeilong@huawei.com>
Reviewed-by: Feilong Lin <linfeilong@huawei.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2->V3
- use return value -EIO instead.
- do NULL check in show method too.

 drivers/cpufreq/cpufreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 48a224a..bc19d6c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -933,6 +933,9 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 	struct freq_attr *fattr = to_attr(attr);
 	ssize_t ret;
 
+	if (!fattr->show)
+		return -EIO;
+
 	down_read(&policy->rwsem);
 	ret = fattr->show(policy, buf);
 	up_read(&policy->rwsem);
@@ -947,6 +950,9 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 	struct freq_attr *fattr = to_attr(attr);
 	ssize_t ret = -EINVAL;
 
+	if (!fattr->store)
+		return -EIO;
+
 	/*
 	 * cpus_read_trylock() is used here to work around a circular lock
 	 * dependency problem with respect to the cpufreq_register_driver().
-- 
2.6.4.windows.1


