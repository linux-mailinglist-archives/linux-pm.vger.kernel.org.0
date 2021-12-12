Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4334719C2
	for <lists+linux-pm@lfdr.de>; Sun, 12 Dec 2021 12:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhLLLUi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Dec 2021 06:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhLLLUh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Dec 2021 06:20:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C98CC061751
        for <linux-pm@vger.kernel.org>; Sun, 12 Dec 2021 03:20:37 -0800 (PST)
Date:   Sun, 12 Dec 2021 11:20:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639308034;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JXzSIBUlF3urteQxxQUErhvImJCJhwB07mVfs0lRCck=;
        b=RAxDOZ4R0GB59kasLd3h9DyUL9N8Skd/wlhK+9rmoKfx+pJtYp7v1eDoFyK83p302imGKN
        i1Ix2hZUvxz2cIVequxarlXIqcvZu7RiKUV1M1J+arBl0iy4Kb+Q39fSh45IaLAqUKSTo7
        8VQL5GB+0IW0Fl+CWslJfcLStyVEhY8y3FKKQcCsLNBlojBSCDJjkGv3tIHDqazYO6ZeYH
        M/VDof+cUh92EPSPApdMSGahRyT+AxBldYCVXqgsy4nOFj4vPqnz8TgcM3/jQdy1QJuhoP
        4ym8okfWueOJ505j0TqbwbnBmo2ns98DeoBtiu+piZqvAB9MQ9IcxRk0Du343Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639308034;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JXzSIBUlF3urteQxxQUErhvImJCJhwB07mVfs0lRCck=;
        b=lQ7YjR14fDKNRcNURw/JzRp+csZeyfgdQ2q12QfXctKY+d5E0+XOR/t+tOea0rXG1FNtND
        9cbazndvT2qNWTCg==
From:   "thermal-bot for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/rz2gl: Add error check for
 reset_control_deassert()
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20211208164010.4130-1-biju.das.jz@bp.renesas.com>
References: <20211208164010.4130-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <163930803312.23020.13150282411504030063.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     8ee1c0f6526ce942b7595951c7bb0165010051c2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//8ee1c0f6526ce942b7595951c7bb0165010051c2
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Wed, 08 Dec 2021 16:40:09 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 09 Dec 2021 15:58:09 +01:00

thermal/drivers/rz2gl: Add error check for reset_control_deassert()

If reset_control_deassert() fails, then we won't be able to access
the device registers. Therefore check the return code of
reset_control_deassert() and bail out in case of error.

While at it replace the parameter "&pdev->dev" -> "dev" in
devm_reset_control_get_exclusive().

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Link: https://lore.kernel.org/r/20211208164010.4130-1-biju.das.jz@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/rzg2l_thermal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index d47d4a3..7a9cdc1 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -170,12 +170,14 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	priv->dev = dev;
-	priv->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	priv->rstc = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(priv->rstc))
 		return dev_err_probe(dev, PTR_ERR(priv->rstc),
 				     "failed to get cpg reset");
 
-	reset_control_deassert(priv->rstc);
+	ret = reset_control_deassert(priv->rstc);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to deassert");
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
