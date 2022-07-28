Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDA158434D
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiG1Plt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiG1Pls (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F86368DF0
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:47 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D9Z0nBO4feTdDES5we4nSo79baCg7t2QErLjV3s8Y5A=;
        b=akpTeIpJuNHSKWeU5P3pRsNLPBhN6DnEhp3GHc74qJbut+GxpMzWeq2ADFoH/0o10HGSpP
        vDoTNijh3hyAyv1iIZVZpiTRu+IE153+nfopvddqBVdFjmOcbC7L4uF1dz8Hfjx79DSax8
        Ysax24Wxa1j2tFB4zot/3YYLOFMlI6v6iXFlmkd40RzLcdG/7gWN8EqqB2825te6EdFKOr
        LvJ6USRuuHEwTk2HvDBuzA2SA+J2AUdavReMkJPaUY5KVrC7aifzxugUk8ewNe9X596vPm
        c79lZsWrs5AmOxomcooeYsPzIs3ujilkEJvdpVQeLHZen12+0t0+8T1J6Vmr3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D9Z0nBO4feTdDES5we4nSo79baCg7t2QErLjV3s8Y5A=;
        b=1tZ7gY7vZyXtQiawwaTnDqgOePWouxHOwgb/0QrYRDBO4YtjDsm6Y6JtWtCh9g9HwdDbBs
        kVDAPadqx+vra7Cw==
From:   "thermal-bot for Dmitry Baryshkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/qcom/temp-alarm: Register
 thermal zones as hwmon sensors
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220719054940.755907-1-dmitry.baryshkov@linaro.org>
References: <20220719054940.755907-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Message-ID: <165902290488.15455.7645927052363659067.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     fb55b0129787ec98eace23ddccd429188d318574
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//fb55b0129787ec98eace23ddccd429188d318574
Author:        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
AuthorDate:    Tue, 19 Jul 2022 08:49:39 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:50 +02:00

thermal/drivers/qcom/temp-alarm: Register thermal zones as hwmon sensors

Register thermal zones as hwmon sensors to let userspace read
temperatures using standard hwmon interface.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Link: https://lore.kernel.org/r/20220719054940.755907-1-dmitry.baryshkov@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 7419e19..770f82c 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -16,6 +16,7 @@
 #include <linux/thermal.h>
 
 #include "../thermal_core.h"
+#include "../thermal_hwmon.h"
 
 #define QPNP_TM_REG_DIG_MAJOR		0x01
 #define QPNP_TM_REG_TYPE		0x04
@@ -458,6 +459,10 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (devm_thermal_add_hwmon_sysfs(chip->tz_dev))
+		dev_warn(&pdev->dev,
+			 "Failed to add hwmon sysfs attributes\n");
+
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, qpnp_tm_isr,
 					IRQF_ONESHOT, node->name, chip);
 	if (ret < 0)
