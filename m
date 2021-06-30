Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2472A3B7FFE
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 11:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhF3Jde (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 05:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbhF3Jdd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 05:33:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34821C061756
        for <linux-pm@vger.kernel.org>; Wed, 30 Jun 2021 02:31:05 -0700 (PDT)
Date:   Wed, 30 Jun 2021 09:31:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625045462;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JVMsBEgmL18iI+pUnk3rLGDKdrAI945RuC6Z0SPpv0A=;
        b=u/cwcjDMyBQHVF1v7lRCyCxLHW648BlLRQhTlHQmXpGo/2hNUmAiAhDd96IdXsNyJR7444
        WexGbWj0skvrKg8TdDrdv/CdYEh9aWy3VeoHm/jqoMkdSbA4QCRAaujZXpZS16pWSMXdk1
        IATnxThtz/IFfCNOmGGs+ztOL9aKxoNLzkF8CO+swju2Zpu0Ev5yGatRNrCtrRbeDYker3
        G4bWhiDGyVmbTgXP6vD+qLuBE/kiKik535sm+13OtgHrqQx7FVi6ef495lGZppKp4qRgKZ
        +HBj6aBRy+wRZ1Y0KGlUWFWOGOo/a07xc2fCA4FsO200mpFg/ccROeAELn2+yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625045462;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JVMsBEgmL18iI+pUnk3rLGDKdrAI945RuC6Z0SPpv0A=;
        b=dVAlJXFIdQeb9hTclgJBc726Crd22a4xnTmEZFbtE9p7uVTb71LdnKr7EoB521sZfLN3GC
        uo3eu58fFqOdc7Dw==
From:   "thermal-bot for Frank Wunderlich" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/mediatek: Add sensors-support
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210608154530.70074-1-linux@fw-web.de>
References: <20210608154530.70074-1-linux@fw-web.de>
MIME-Version: 1.0
Message-ID: <162504546151.395.8011120525144706324.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     77b6c4044d8f7062b2c1c2a99f4bb076acc7f04f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//77b6c4044d8f7062b2c1c2a99f4bb076acc7f04f
Author:        Frank Wunderlich <frank-w@public-files.de>
AuthorDate:    Tue, 08 Jun 2021 17:45:30 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 28 Jun 2021 20:57:36 +02:00

thermal/drivers/mediatek: Add sensors-support

Add HWMON-support to mediateks thermal driver to allow lm-sensors
userspace tools read soc temperature

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210608154530.70074-1-linux@fw-web.de
---
 drivers/thermal/mtk_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 97e8678..ede94ea 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -23,6 +23,8 @@
 #include <linux/reset.h>
 #include <linux/types.h>
 
+#include "thermal_hwmon.h"
+
 /* AUXADC Registers */
 #define AUXADC_CON1_SET_V	0x008
 #define AUXADC_CON1_CLR_V	0x00c
@@ -1087,6 +1089,10 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		goto err_disable_clk_peri_therm;
 	}
 
+	ret = devm_thermal_add_hwmon_sysfs(tzdev);
+	if (ret)
+		dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
+
 	return 0;
 
 err_disable_clk_peri_therm:
