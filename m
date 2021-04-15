Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1E03608CD
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 14:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhDOMEZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 08:04:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59494 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhDOMEY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 08:04:24 -0400
Date:   Thu, 15 Apr 2021 12:03:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618488239;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcLVW6qmIhchgvNZ5onfWSNMky292Olnyy7KCXssmnY=;
        b=nhSesb2C8Pom3CNPW4EcrU+0h+nzjMrAFynk15+F6tHpAen8bwoez3J77b7fgDoICetMVI
        edeiqa02q7Jdd+0I9MFGp6PldUYZEz0M7FVOxh2OvlgCQEKR6LchrVqVw2y21ZFcqhAiK9
        pjTFQxntyGauz6Qf0mZRsSErxOedtjSrLiBnf4kNJC14+LsjgBd3zmPMCVrjRohoZI4wa5
        c9D7imqggnsuBghBx1t2pVVX87EAm66WJRhkrwl9zHkm6cCP6reo1OPD1Zwdns3cZjnNr5
        edwbzqs4p0ETnqKGd7nB3pk5f59inWHonnlm2qbBbNWZWJxVXFGpmf3TmnZ8YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618488239;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcLVW6qmIhchgvNZ5onfWSNMky292Olnyy7KCXssmnY=;
        b=HxfYaVT+OvihdH+nr6XF19hKvaEMFA5SKQ6Tq1c4G6JMWbVEBBjayaRz8/EfL2oSqGvllY
        JtFgurz0GMLJRSDA==
From:   "thermal-bot for Ansuel Smith" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tsens: Don't hardcode sensor slope
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210404144823.31867-3-ansuelsmth@gmail.com>
References: <20210404144823.31867-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Message-ID: <161848823911.29796.11209123240672207975.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     e801d870ffafd03f0e85058cea7a949cb15628f1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//e801d870ffafd03f0e85058cea7a949cb15628f1
Author:        Ansuel Smith <ansuelsmth@gmail.com>
AuthorDate:    Sun, 04 Apr 2021 16:48:16 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 15 Apr 2021 13:21:42 +02:00

thermal/drivers/tsens: Don't hardcode sensor slope

Function compute_intercept_slope hardcode the sensor slope to
SLOPE_DEFAULT. Change this and use the default value only if a slope is
not defined. This is needed for tsens VER_0 that has a hardcoded slope
table.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210404144823.31867-3-ansuelsmth@gmail.com
---
 drivers/thermal/qcom/tsens.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 124384c..54382c6 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -86,7 +86,8 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
 			__func__, i, p1[i], p2[i]);
 
-		priv->sensor[i].slope = SLOPE_DEFAULT;
+		if (!priv->sensor[i].slope)
+			priv->sensor[i].slope = SLOPE_DEFAULT;
 		if (mode == TWO_PT_CALIB) {
 			/*
 			 * slope (m) = adc_code2 - adc_code1 (y2 - y1)/
