Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F65731CCC2
	for <lists+linux-pm@lfdr.de>; Tue, 16 Feb 2021 16:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhBPPRL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Feb 2021 10:17:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53329 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhBPPRL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2021 10:17:11 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lC25S-0005ar-ML; Tue, 16 Feb 2021 15:16:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] thermal: qcom: Fix comparison with uninitialized variable channels_available
Date:   Tue, 16 Feb 2021 15:16:26 +0000
Message-Id: <20210216151626.162996-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the check of chip->channels[i].channel is against an the
uninitialized variable channels_available.  I believe the variable
channels_available needs to be fetched first by the call to adc_tm5_read
before the channels check. Fix the issue swapping the order of the
channels check loop with the call to adc_tm5_read.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: ca66dca5eda6 ("thermal: qcom: add support for adc-tm5 PMIC thermal monitor")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index a2014375587d..b460b56e981c 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -375,13 +375,6 @@ static int adc_tm5_init(struct adc_tm5_chip *chip)
 	int ret;
 	unsigned int i;
 
-	for (i = 0; i < chip->nchannels; i++) {
-		if (chip->channels[i].channel >= channels_available) {
-			dev_err(chip->dev, "Invalid channel %d\n", chip->channels[i].channel);
-			return -EINVAL;
-		}
-	}
-
 	ret = adc_tm5_read(chip, ADC_TM5_NUM_BTM,
 			   &channels_available, sizeof(channels_available));
 	if (ret) {
@@ -389,6 +382,13 @@ static int adc_tm5_init(struct adc_tm5_chip *chip)
 		return ret;
 	}
 
+	for (i = 0; i < chip->nchannels; i++) {
+		if (chip->channels[i].channel >= channels_available) {
+			dev_err(chip->dev, "Invalid channel %d\n", chip->channels[i].channel);
+			return -EINVAL;
+		}
+	}
+
 	buf[0] = chip->decimation;
 	buf[1] = chip->avg_samples | ADC_TM5_FAST_AVG_EN;
 	buf[2] = ADC_TM5_TIMER1;
-- 
2.30.0

