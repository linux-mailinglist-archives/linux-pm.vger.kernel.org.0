Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6022130CF3
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 12:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfEaK5O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 06:57:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44782 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaK5O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2019 06:57:14 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hWfDg-0004Th-GR; Fri, 31 May 2019 10:57:08 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drivers: thermal: tsens: remove redundant u32 comparison with less than zero
Date:   Fri, 31 May 2019 11:57:08 +0100
Message-Id: <20190531105708.15312-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The u32 variable hw_id is unsigned and cannot be less than zero so
the comparison with less than zero is always false and hence is redundant
and can be removed.

Addresses-Coverity: ("Unsigned compared against 0")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/thermal/qcom/tsens-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 928e8e81ba69..f4419f45025d 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -69,7 +69,7 @@ bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id)
 	u32 val;
 	int ret;
 
-	if ((hw_id > (priv->num_sensors - 1)) || (hw_id < 0))
+	if (hw_id > (priv->num_sensors - 1))
 		return -EINVAL;
 	ret = regmap_field_read(priv->rf[SENSOR_EN], &val);
 	if (ret)
-- 
2.20.1

