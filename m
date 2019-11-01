Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C07EC0F0
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 11:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfKAKAp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 06:00:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53147 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbfKAKAo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 06:00:44 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iQTjP-0003cs-VH; Fri, 01 Nov 2019 10:00:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] drivers: thermal: tsens: fix potential integer overflow on multiply
Date:   Fri,  1 Nov 2019 10:00:35 +0000
Message-Id: <20191101100035.25502-1-colin.king@canonical.com>
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

Also use div_u64 for the divide as suggested by Daniel Lezcano.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: fbfe1a042cfd ("drivers: thermal: tsens: Add interrupt support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: use div_u64 for the divide as suggested by Daniel Lezcano.

---
 drivers/thermal/qcom/tsens-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 03bf1b8133ea..c6b551ec7323 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -92,7 +92,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 
 static inline u32 degc_to_code(int degc, const struct tsens_sensor *s)
 {
-	u64 code = (degc * s->slope + s->offset) / SLOPE_FACTOR;
+	u64 code = div_u64(((u64)degc * s->slope + s->offset), SLOPE_FACTOR);
 
 	pr_debug("%s: raw_code: 0x%llx, degc:%d\n", __func__, code, degc);
 	return clamp_val(code, THRESHOLD_MIN_ADC_CODE, THRESHOLD_MAX_ADC_CODE);
-- 
2.20.1

