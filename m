Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3610A2B71C
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2019 15:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfE0N75 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 May 2019 09:59:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50108 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfE0N75 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 May 2019 09:59:57 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BCDD59305DE19F6E293A;
        Mon, 27 May 2019 21:44:03 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 27 May 2019
 21:43:55 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <amit.kucheria@linaro.org>, <agross@kernel.org>,
        <david.brown@linaro.org>, <rui.zhang@intel.com>,
        <edubezval@gmail.com>, <daniel.lezcano@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drivers: thermal: tsens: Change hw_id type to int in is_sensor_enabled
Date:   Mon, 27 May 2019 21:41:24 +0800
Message-ID: <20190527134124.14784-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sensor hw_id is int type other u32, is_sensor_enabled
should use int to compare, this fix smatch warning:

drivers/thermal/qcom/tsens-common.c:72
 is_sensor_enabled() warn: unsigned 'hw_id' is never less than zero.

Fixes: 3e6a8fb33084 ("drivers: thermal: tsens: Add new operation to check if a sensor is enabled")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/thermal/qcom/tsens-common.c | 2 +-
 drivers/thermal/qcom/tsens.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 928e8e81ba69..5df4eed84535 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -64,7 +64,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 	}
 }
 
-bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id)
+bool is_sensor_enabled(struct tsens_priv *priv, int hw_id)
 {
 	u32 val;
 	int ret;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index eefe3844fb4e..15264806f6a8 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -315,7 +315,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mo
 int init_common(struct tsens_priv *priv);
 int get_temp_tsens_valid(struct tsens_priv *priv, int i, int *temp);
 int get_temp_common(struct tsens_priv *priv, int i, int *temp);
-bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id);
+bool is_sensor_enabled(struct tsens_priv *priv, int hw_id);
 
 /* TSENS target */
 extern const struct tsens_plat_data data_8960;
-- 
2.17.1


