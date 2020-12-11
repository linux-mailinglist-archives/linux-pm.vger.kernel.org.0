Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DDF2D7646
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 14:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390550AbgLKNKO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 08:10:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34838 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391594AbgLKNJo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 08:09:44 -0500
Date:   Fri, 11 Dec 2020 13:09:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607692141;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PZMfD0R3wvU6tba0sO/oGHpE6HxkFy5X5RXhvGRBWqE=;
        b=Nw1cGJ8Rcis3+hRoZ5Vw9fp7T5j1Erf/Ys3dTmXGJpRDD0KxMU85exR4gZljn9dhq4e9Nj
        o4Sed+U1nL6uXTlvx37zwSptTAIjnuFxuxHlx7fe8WCVAxzi/5eGAFv9zKiYixnwwpUBc8
        MvvKMmwVyaYMFmamQZtcGYAHdiZPkaWmtMkLgY/LMLo9czEEbSekBk2nBN2dGEWtEwDSnZ
        0vRc8UZ4qa5oQ8sgebba4AfO0WeDQlnRej9BYeYfVj4K9GsPbAKCJhPL+8JTgU86oykFvT
        qz+9+P4aNUVMtNlsxgvmEOGJDmkhRtiAphHDXO+vqseCPe2Nz08lXFS80vMnmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607692141;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PZMfD0R3wvU6tba0sO/oGHpE6HxkFy5X5RXhvGRBWqE=;
        b=swGwVxvkW6P/BjF6Vf6SV6QzDbMe7hJL/geRQUz2wk6ui4+kLOZpHfkREtSqytvij/1bLn
        cX85XzaqX0OZtxBw==
From:   "thermal-bot for Zheng Yongjun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: broadcom: simplify the return
 expression of bcm2711_thermal_probe()
Cc:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201210135432.1249-1-zhengyongjun3@huawei.com>
References: <20201210135432.1249-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Message-ID: <160769214116.3364.11482668495795304341.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     ea21f589de9a7d787f50da480d01457d8dcdd64a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ea21f589de9a7d787f50da480d01457d8dcdd64a
Author:        Zheng Yongjun <zhengyongjun3@huawei.com>
AuthorDate:    Thu, 10 Dec 2020 21:54:32 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 10 Dec 2020 18:29:43 +01:00

thermal: broadcom: simplify the return expression of bcm2711_thermal_probe()

Simplify the return expression.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201210135432.1249-1-zhengyongjun3@huawei.com
---
 drivers/thermal/broadcom/bcm2711_thermal.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/broadcom/bcm2711_thermal.c
index 67c2a73..1ec57d9 100644
--- a/drivers/thermal/broadcom/bcm2711_thermal.c
+++ b/drivers/thermal/broadcom/bcm2711_thermal.c
@@ -102,11 +102,7 @@ static int bcm2711_thermal_probe(struct platform_device *pdev)
 	priv->thermal = thermal;
 
 	thermal->tzp->no_hwmon = false;
-	ret = thermal_add_hwmon_sysfs(thermal);
-	if (ret)
-		return ret;
-
-	return 0;
+	return thermal_add_hwmon_sysfs(thermal);
 }
 
 static struct platform_driver bcm2711_thermal_driver = {
