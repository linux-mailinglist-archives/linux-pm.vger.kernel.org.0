Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E001552D2C2
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbiESMoQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbiESMoO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0CDBA57A
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:11 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964250;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2PNr3Pv5DC0UrKTktI1u6RxfjWWhjyTiBwmP+VekTc=;
        b=HzHcPQGUKtVCJ5Eu9W5nA9zUx4sLg3HL6J1xOR6oC7AGTLFC/NAHMYTj9m4ApNO2u8kNBl
        +WPrQiSwCHOhPmIULe6CL3yq5jgkMQTGhNfyQedxe8eBegBEA39V4dcCKHWBZ96aMBk13f
        WLEwLRU8xZTdOT7jWC1YKLXAWWGiZDmvlwu+stcSIwXKnXoKuFrmvyBGsPncbmWBh9R/o9
        eGI/GEHa8ejJ8itpWmksKhLfpKAaPS9ohSqhXZYuP/Lfyo3n9HFho0K6j400cJEmvLicsu
        Lw6Lxxll00I3KVCt6+AU/UPnbfE0pw/NJPW90sSEy4+wQjMXlfkaYK0QH/Sdpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964250;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2PNr3Pv5DC0UrKTktI1u6RxfjWWhjyTiBwmP+VekTc=;
        b=EW8trRYLsPEppu67I15j1BWMBZU86btI/icvLjV6e/fL9CFZFuq1s6c+qRzyTlgq/DBxKf
        pNXVdQGNgQXRn+BA==
From:   "thermal-bot for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/rz2gl: Fix OTP Calibration
 Register values
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220428093346.7552-1-biju.das.jz@bp.renesas.com>
References: <20220428093346.7552-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <165296424932.4207.992501972227598497.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     2d37f5c90bdc659b329dac7cf6d165a4bbf34cb6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//2d37f5c90bdc659b329dac7cf6d165a4bbf34cb6
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Thu, 28 Apr 2022 10:33:46 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:52 +02:00

thermal/drivers/rz2gl: Fix OTP Calibration Register values

As per the latest RZ/G2L Hardware User's Manual (Rev.1.10 Apr, 2022),
the bit 31 of TSU OTP Calibration Register(OTPTSUTRIM) indicates
whether bit [11:0] of OTPTSUTRIM is valid or invalid.

This patch updates the code to reflect this change.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20220428093346.7552-1-biju.das.jz@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/rzg2l_thermal.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index 7a9cdc1..be07e04 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -32,6 +32,8 @@
 #define TSU_SS		0x10
 
 #define OTPTSUTRIM_REG(n)	(0x18 + ((n) * 0x4))
+#define OTPTSUTRIM_EN_MASK	BIT(31)
+#define OTPTSUTRIM_MASK		GENMASK(11, 0)
 
 /* Sensor Mode Register(TSU_SM) */
 #define TSU_SM_EN_TS		BIT(0)
@@ -183,11 +185,15 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(dev);
 
 	priv->calib0 = rzg2l_thermal_read(priv, OTPTSUTRIM_REG(0));
-	if (!priv->calib0)
+	if (priv->calib0 & OTPTSUTRIM_EN_MASK)
+		priv->calib0 &= OTPTSUTRIM_MASK;
+	else
 		priv->calib0 = SW_CALIB0_VAL;
 
 	priv->calib1 = rzg2l_thermal_read(priv, OTPTSUTRIM_REG(1));
-	if (!priv->calib1)
+	if (priv->calib1 & OTPTSUTRIM_EN_MASK)
+		priv->calib1 &= OTPTSUTRIM_MASK;
+	else
 		priv->calib1 = SW_CALIB1_VAL;
 
 	platform_set_drvdata(pdev, priv);
