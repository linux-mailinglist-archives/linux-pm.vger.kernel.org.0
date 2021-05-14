Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6913803C2
	for <lists+linux-pm@lfdr.de>; Fri, 14 May 2021 08:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhENGu3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 May 2021 02:50:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2596 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhENGu1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 May 2021 02:50:27 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FhJw90lR6zkWMk;
        Fri, 14 May 2021 14:46:33 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 14 May 2021 14:49:14 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 14
 May 2021 14:49:14 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
        <cw00.choi@samsung.com>, <b.zolnierkie@samsung.com>,
        <lukasz.luba@arm.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] PM / devfreq: Add missing error code in devfreq_add_device()
Date:   Fri, 14 May 2021 14:48:43 +0800
Message-ID: <20210514064843.11908-1-yuehaibing@huawei.com>
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

Set err code in the error path before jumping to the end of the function.

Fixes: 4dc3bab8687f ("PM / devfreq: Add support delayed timer for polling mode")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/devfreq/devfreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index fe08c46642f7..28f3e0ba6cdd 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -823,6 +823,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	if (devfreq->profile->timer < 0
 		|| devfreq->profile->timer >= DEVFREQ_TIMER_NUM) {
 		mutex_unlock(&devfreq->lock);
+		err = -EINVAL;
 		goto err_dev;
 	}
 
-- 
2.17.1

