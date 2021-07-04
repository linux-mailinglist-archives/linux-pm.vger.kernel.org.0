Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD593BAE2D
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jul 2021 20:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhGDSFF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 14:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhGDSFF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 14:05:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B13C061764
        for <linux-pm@vger.kernel.org>; Sun,  4 Jul 2021 11:02:29 -0700 (PDT)
Date:   Sun, 04 Jul 2021 18:02:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625421746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xkW/tkeaEcVRjBzdSJMs4a0SqsgiwqQuS1TIFNcq2I=;
        b=tRdlr4q4xZO4YefsfDZi+teBVHjl19sTCthF38+uIhPWFl3bSA7xOpjTQvBS9elvCLYy5z
        WBoUj2k8zfzOYjtiOVz69w4mzXBFOdndMFLYdwVk53HlQrIM85sQk3ijPP09VVegJcwdmZ
        Zc8SHlG2nkw965erKds+3LzEoqyPei53/oGpU3QXs68B+QEmH9jXk1vkUuYcwst2ZplEyh
        Qpv9mTnFmS98hoqxiDGXFpdg9XlNHY5Ag5uxMehRdZrM9jThUL5GmK5RZmCf+L8C24Jem2
        THAgHumkxiUD1CHD649b7h3dA9oma37wg1Sw0TLtR99/LmSNRJBo8P89mc5ctA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625421746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xkW/tkeaEcVRjBzdSJMs4a0SqsgiwqQuS1TIFNcq2I=;
        b=3qb0G0KmWQd12JRhcg1e5ygfE6CPQGHMW+PrzILW6bMzkCBwMTwSk/lZNNITH/uT84hUTe
        RGcFmqoSYQqkSPCQ==
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
Message-ID: <162542174606.395.14663046188155761547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     24e21d9f40ec3fb4228e3427454b733316a2a6c6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//24e21d9f40ec3fb4228e3427454b733316a2a6c6
Author:        Frank Wunderlich <frank-w@public-files.de>
AuthorDate:    Tue, 08 Jun 2021 17:45:30 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 04 Jul 2021 18:28:04 +02:00

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
