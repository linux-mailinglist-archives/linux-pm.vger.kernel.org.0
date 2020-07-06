Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609B0215846
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 15:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgGFN0g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 09:26:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729209AbgGFN0f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Jul 2020 09:26:35 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3769E3ED197AB1A85962;
        Mon,  6 Jul 2020 21:26:32 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 6 Jul 2020 21:26:23 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>, Zhang Rui <rui.zhang@intel.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-pm@vger.kernel.org>
Subject: [PATCH -next] thermal: core: Make thermal_cdev_set_cur_state() static
Date:   Mon, 6 Jul 2020 21:36:33 +0800
Message-ID: <20200706133633.79511-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

sparse report build warning as follows:

drivers/thermal/thermal_helpers.c:178:6: warning:
 symbol 'thermal_cdev_set_cur_state' was not declared. Should it be static?

Since function thermal_cdev_set_cur_state() is not used out of
thermal_helpers.c, so marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/thermal/thermal_helpers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 53dd92ccfd19..00a3df6a2d62 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -175,7 +175,8 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
-void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev, int target)
+static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
+				       int target)
 {
 	if (cdev->ops->set_cur_state(cdev, target))
 		return;

