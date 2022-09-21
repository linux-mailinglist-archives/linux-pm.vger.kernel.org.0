Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A7E5BF2ED
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 03:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiIUB2L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Sep 2022 21:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiIUB1W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Sep 2022 21:27:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5018165A2
        for <linux-pm@vger.kernel.org>; Tue, 20 Sep 2022 18:27:05 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MXLKp48FwzpStB;
        Wed, 21 Sep 2022 09:24:14 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 09:27:02 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>,
        <linux-pm@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH] thermal/drivers/hisilicon: Use dev_err_probe() helper
Date:   Wed, 21 Sep 2022 01:24:37 +0000
Message-ID: <20220921012437.20695-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_err() can be replace with dev_err_probe() which will check if error
code is -EPROBE_DEFER.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/thermal/hisi_thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index d6974db7aaf7..e44f4d9ae7b8 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -394,9 +394,8 @@ static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 	data->clk = devm_clk_get(dev, "thermal_clk");
 	if (IS_ERR(data->clk)) {
 		ret = PTR_ERR(data->clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get thermal clk: %d\n", ret);
-		return ret;
+		return dev_err_probe(dev, ret,
+				     "failed to get thermal clk: %d\n", ret);
 	}
 
 	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor), GFP_KERNEL);
-- 
2.17.1

