Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B3438DF19
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 04:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhEXCNn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 May 2021 22:13:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5670 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhEXCNn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 May 2021 22:13:43 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpLHm342dz1BQn6;
        Mon, 24 May 2021 10:09:24 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 10:12:11 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 24
 May 2021 10:12:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
        <cw00.choi@samsung.com>, <yuehaibing@huawei.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] PM / devfreq: governor: use DEVICE_ATTR_RW macro
Date:   Mon, 24 May 2021 10:11:58 +0800
Message-ID: <20210524021158.21236-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use DEVICE_ATTR_RW helper instead of plain DEVICE_ATTR,
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/devfreq/governor_userspace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 0fd6c4851071..ab9db7adb3ad 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -31,8 +31,8 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
 	return 0;
 }
 
-static ssize_t store_freq(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t count)
+static ssize_t set_freq_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
 {
 	struct devfreq *devfreq = to_devfreq(dev);
 	struct userspace_data *data;
@@ -52,8 +52,8 @@ static ssize_t store_freq(struct device *dev, struct device_attribute *attr,
 	return err;
 }
 
-static ssize_t show_freq(struct device *dev, struct device_attribute *attr,
-			 char *buf)
+static ssize_t set_freq_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct devfreq *devfreq = to_devfreq(dev);
 	struct userspace_data *data;
@@ -70,7 +70,7 @@ static ssize_t show_freq(struct device *dev, struct device_attribute *attr,
 	return err;
 }
 
-static DEVICE_ATTR(set_freq, 0644, show_freq, store_freq);
+static DEVICE_ATTR_RW(set_freq);
 static struct attribute *dev_entries[] = {
 	&dev_attr_set_freq.attr,
 	NULL,
-- 
2.17.1

