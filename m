Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AC531F12E
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 21:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBRUlt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 15:41:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54036 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhBRUkX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 15:40:23 -0500
Date:   Thu, 18 Feb 2021 20:39:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613680781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c86wtqKF4oox9qFUF+SbZ8fPIwPQ80tIMeF8xHocerY=;
        b=WFGJkNhz8jauPJxCSmAVG9fmvITb/u8u0Ri2UpJOm/oSUaWzf9ZbaBZM4lCp1Qs6mTv2pA
        vR/cheRDmq+b822QyshJNGshRZA8iROgqC28HgmzwTiiQUiR4omGXDcHS6p9ctrmSkLvFT
        OblaCfUqIryIiPRbDa3feRGZieMWwYqT/L0toKGHve5cOg2vmnhtp4wXiPqkqpUXUzynID
        ZU7BwiwqKUB3KML2dKtSoiz5vFjre6hDrjpJixElmIP4RKzBGpWAGXOwL6uus8klIRA07F
        jGLKLaO8cj97/yWZYnEumJx2peDm3WnAa19r9CKpAoKm9k4e7Y68Cst4RiloNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613680781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c86wtqKF4oox9qFUF+SbZ8fPIwPQ80tIMeF8xHocerY=;
        b=m1rjWwZXsO/zq8MfaPPL1y4XC7UPODSYsXnhMxOy4Da1Hr1T3mVtqwVbpJCg22KybzRys8
        j4WGYsfRLfshPLDQ==
From:   "thermal-bot for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: qcom: Fix comparison with
 uninitialized variable channels_available
Cc:     Colin Ian King <colin.king@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210216151626.162996-1-colin.king@canonical.com>
References: <20210216151626.162996-1-colin.king@canonical.com>
MIME-Version: 1.0
Message-ID: <161368078062.20312.12939458122513115365.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     74369d041a0a3e9e57de50efd4bd4bc10564e254
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//74369d041a0a3e9e57de50efd4bd4bc10564e254
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Tue, 16 Feb 2021 15:16:26 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 16 Feb 2021 19:05:23 +01:00

thermal: qcom: Fix comparison with uninitialized variable channels_available

Currently the check of chip->channels[i].channel is against an the
uninitialized variable channels_available.  I believe the variable
channels_available needs to be fetched first by the call to adc_tm5_read
before the channels check. Fix the issue swapping the order of the
channels check loop with the call to adc_tm5_read.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: ca66dca5eda6 ("thermal: qcom: add support for adc-tm5 PMIC thermal monitor")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210216151626.162996-1-colin.king@canonical.com
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index a201437..b460b56 100644
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
