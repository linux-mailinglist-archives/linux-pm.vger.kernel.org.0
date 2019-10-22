Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B20D7E035A
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 13:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388205AbfJVLtP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 07:49:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38152 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388204AbfJVLtP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 07:49:15 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iMsf1-0007KS-67; Tue, 22 Oct 2019 11:49:11 +0000
From:   Colin King <colin.king@canonical.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drivers: thermal: tsens: fix potential integer overflow on multiply
Date:   Tue, 22 Oct 2019 12:49:10 +0100
Message-Id: <20191022114910.652-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently a multiply operation is being performed on two int values
and the result is being assigned to a u64, presumably because the
end result is expected to be probably larger than an int. However,
because the multiply is an int multiply one can get overflow. Avoid
the overflow by casting degc to a u64 to force a u64 multiply.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: fbfe1a042cfd ("drivers: thermal: tsens: Add interrupt support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/thermal/qcom/tsens-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 03bf1b8133ea..3d7855106ecd 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -92,7 +92,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 
 static inline u32 degc_to_code(int degc, const struct tsens_sensor *s)
 {
-	u64 code = (degc * s->slope + s->offset) / SLOPE_FACTOR;
+	u64 code = ((u64)degc * s->slope + s->offset) / SLOPE_FACTOR;
 
 	pr_debug("%s: raw_code: 0x%llx, degc:%d\n", __func__, code, degc);
 	return clamp_val(code, THRESHOLD_MIN_ADC_CODE, THRESHOLD_MAX_ADC_CODE);
-- 
2.20.1

