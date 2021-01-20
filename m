Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008F02FC776
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 03:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbhATCGc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 21:06:32 -0500
Received: from m12-12.163.com ([220.181.12.12]:59552 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728939AbhATCF5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 Jan 2021 21:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=XVfX1
        7Zs72gwj0Y+DXdHxGS7GyATCKP2lfOSz9IDsYg=; b=XXaiBy+YzdYoUQWeuV5QI
        v6S1tzcziUts644V9qBSsXYUecFKVYoGFFBNLkRvVAusd+S7r1cwBuW16TWA+c4c
        JZnpH2+cudWrBNRrzOuJOXyg4LgYJygs19LV4tl7E2BH74li2fAudOHCIr5qFoJW
        hkLEMZfjZb7hNtGa1LBfKM=
Received: from DONGJIAN-NJ.ccdomain.com (unknown [218.94.48.178])
        by smtp8 (Coremail) with SMTP id DMCowAD3_8+3iwdg9iWYMw--.22870S2;
        Wed, 20 Jan 2021 09:47:40 +0800 (CST)
From:   Jian Dong <dj0227@163.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, dongjian@yulong.com, huyue2@yulong.com,
        zhangwen@yulong.com
Subject: [PATCH] power-supply: use kobj_to_dev()
Date:   Wed, 20 Jan 2021 09:47:12 +0800
Message-Id: <20210120014713.17668-1-dj0227@163.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAD3_8+3iwdg9iWYMw--.22870S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyrur4DXF1rCFW8XF43Wrg_yoW3uFbE9a
        yDurZ7WrW3W3Wj934Ykw1fZFy0kw1kZFyIqa1ktFZ3JFyUZw4DZ34DZ34IkF1DX3y7CFZ8
        ua4vqF1Y9Fy8GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU11CJtUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: dgmqjjqx6rljoofrz/1tbiFhwg3V44O4rfRQAAs6
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: dongjian <dongjian@yulong.com>

Use kobj_to_dev() instead of open-coding it

Signed-off-by: dongjian <dongjian@yulong.com>
---
 drivers/power/supply/ds2760_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply/ds2760_battery.c
index 695bb67..5f50da5 100644
--- a/drivers/power/supply/ds2760_battery.c
+++ b/drivers/power/supply/ds2760_battery.c
@@ -198,7 +198,7 @@ static ssize_t w1_slave_read(struct file *filp, struct kobject *kobj,
 			     struct bin_attribute *bin_attr, char *buf,
 			     loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	return w1_ds2760_read(dev, buf, off, count);
 }
 
-- 
1.9.1


