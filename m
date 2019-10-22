Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B1EE02A1
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 13:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbfJVLSL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 07:18:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37573 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfJVLSL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 07:18:11 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iMsAw-0005V1-VM; Tue, 22 Oct 2019 11:18:07 +0000
From:   Colin King <colin.king@canonical.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] thermal: qcom: tsens-v1: fix kfree of a non-pointer value
Date:   Tue, 22 Oct 2019 12:18:06 +0100
Message-Id: <20191022111806.23143-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the kfree of pointer qfprom_cdata is kfreeing an
error value that has been cast to a pointer rather than a
valid address.  Fix this by removing the kfree.

Fixes: 95ededc17e4e ("thermal: qcom: tsens-v1: Add support for MSM8956 and MSM8976")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/thermal/qcom/tsens-v1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 2d1077b64887..bd2ddb684a45 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -240,10 +240,8 @@ static int calibrate_8976(struct tsens_priv *priv)
 	u32 *qfprom_cdata;
 
 	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
-	if (IS_ERR(qfprom_cdata)) {
-		kfree(qfprom_cdata);
+	if (IS_ERR(qfprom_cdata))
 		return PTR_ERR(qfprom_cdata);
-	}
 
 	mode = (qfprom_cdata[4] & MSM8976_CAL_SEL_MASK);
 	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
-- 
2.20.1

