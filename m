Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE8A38D3C8
	for <lists+linux-pm@lfdr.de>; Sat, 22 May 2021 07:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhEVFLw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 May 2021 01:11:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3625 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhEVFLv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 May 2021 01:11:51 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FnBKS2fllzQnWY;
        Sat, 22 May 2021 13:06:52 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 13:10:25 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 22 May
 2021 13:10:24 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <daniel.lezcano@linaro.org>, <colin.king@canonical.com>
Subject: [PATCH -next] thermal: qcom: return error code on error path in adc_tm5_get_dt_channel_data()
Date:   Sat, 22 May 2021 13:15:12 +0800
Message-ID: <20210522051512.158228-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Return -EINVAL when args is invalid.

Fixes: ca66dca5eda6 ("thermal: qcom: add support for adc-tm5 PMIC thermal monitor")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index b460b56e981c..8ccd5d22c13b 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -441,7 +441,7 @@ static int adc_tm5_get_dt_channel_data(struct adc_tm5_chip *adc_tm,
 
 	if (args.args_count != 1 || args.args[0] >= ADC5_MAX_CHANNEL) {
 		dev_err(dev, "%s: invalid ADC channel number %d\n", name, chan);
-		return ret;
+		return -EINVAL;;
 	}
 	channel->adc_channel = args.args[0];
 
-- 
2.25.1

