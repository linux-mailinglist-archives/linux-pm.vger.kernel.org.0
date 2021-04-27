Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A222136CBE7
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbhD0TpO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43146 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238946AbhD0TpN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:13 -0400
Date:   Tue, 27 Apr 2021 19:44:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552669;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJQg3BQGvTWloJznAMp3lJLg0kq/iRV5aJwdYIlVIKg=;
        b=V1jSp+1y0vrwkPCl5S5e7ZKyuTWp1AujBPM9Y2ng4bOKJTz+mT67dNEp5TCOoUnyVdRP69
        EnUc/2uw8G4RFARPJAP3eqPLxnFm+iGuuirl5ykw+o89txEBLD2oBeGZ4dyPLhkzXUmHyf
        +HooRmmRffFcNOQjc81T70YFiPZjKI84bjmSFeF2Prs7qY+OqQ+uv7LxunirqrD3Zn475Z
        SJoF6eQQ5wxudFBdGAp3T6EA9ZKBFnnaFSwjkJRm8gdY/XlcZFqs8GRa35ly0w40abQfh4
        3f+kxtG4LUYg6tVRgJWE8Yn13N4HdBwnG7VXui78hI4bF03y8gs83yE5z5VKgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552669;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJQg3BQGvTWloJznAMp3lJLg0kq/iRV5aJwdYIlVIKg=;
        b=SWrMluy/u7+MwBFC2ZQgUsZAE3FXbFAcpzPjqqJ4tbXtEoCRZtG/O/qsag5s58D3FqVuxP
        veE4tNfy4OGj+8BQ==
From:   "thermal-bot for Ansuel Smith" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tsens: Don't hardcode sensor slope
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210420183343.2272-2-ansuelsmth@gmail.com>
References: <20210420183343.2272-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Message-ID: <161955266909.29796.7242975907607602175.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     9d51769b2e75bb33c56c8f9ee933eca2d92b375b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//9d51769b2e75bb33c56c8f9ee933eca2d92b375b
Author:        Ansuel Smith <ansuelsmth@gmail.com>
AuthorDate:    Tue, 20 Apr 2021 20:33:35 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 22 Apr 2021 14:08:50 +02:00

thermal/drivers/tsens: Don't hardcode sensor slope

Function compute_intercept_slope hardcode the sensor slope to
SLOPE_DEFAULT. Change this and use the default value only if a slope is
not defined. This is needed for tsens VER_0 that has a hardcoded slope
table.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210420183343.2272-2-ansuelsmth@gmail.com
---
 drivers/thermal/qcom/tsens.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index a5da6a7..d6f8021 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -85,7 +85,8 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
 			__func__, i, p1[i], p2[i]);
 
-		priv->sensor[i].slope = SLOPE_DEFAULT;
+		if (!priv->sensor[i].slope)
+			priv->sensor[i].slope = SLOPE_DEFAULT;
 		if (mode == TWO_PT_CALIB) {
 			/*
 			 * slope (m) = adc_code2 - adc_code1 (y2 - y1)/
