Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B025352D2D2
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbiESMo1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238013AbiESMoZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58838BA98C
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:24 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3xn818POQ3JBi8GGgkqN6EY9klfTUz1haeuQPD1Uems=;
        b=lga6CkD2Pz65JtfcnOGRJTtNMEQwqiDVxSJ7O2hZCzkhvEqdZIBBEyk5Ga2g2mIZbCJ5uw
        3zdKYb5Tk1mRju+KorYxB8NBqQJFLKLQDrbi7MeYBKojIooovGlOaJ/kCkEPS0aJYi24Fh
        9FBE+RpkZ00kNPwIy2GLd0235Xp+ks0w13V0a+wtpv6lxZMPxx+9f12tadJAbIlsHoXIMQ
        JdpCq4Py5wblxwCIHO/95QIuitrjq83YYY7e6jCXs09B43QWSD1CXjocintLoJNgGx/Ri/
        IpGpQS2yUf2Rk2kGUlnS+aKDov93i4c3jMPPJ0WB1vLhIBDAJlTM3ZiIoF3UQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3xn818POQ3JBi8GGgkqN6EY9klfTUz1haeuQPD1Uems=;
        b=49SKxLc1i1mCST/VUSj7iafo370KEqpA/iA6WvnMQia2icNclv2hJExwrZoKIKY0/1fMNY
        PokHnrK+lGahMjCA==
From:   "thermal-bot for Massimiliano Minella" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/k3: Add hwmon support
Cc:     Massimiliano Minella <massimiliano.minella@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220401151656.913166-1-massimiliano.minella@se.com>
References: <20220401151656.913166-1-massimiliano.minella@se.com>
MIME-Version: 1.0
Message-ID: <165296426176.4207.15051030762623208961.tip-bot2@tip-bot2>
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

Commit-ID:     9e5f5f15fef5efd6847b8802e509b67fce72e2fb
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//9e5f5f15fef5efd6847b8802e509b67fce72e2fb
Author:        Massimiliano Minella <massimiliano.minella@gmail.com>
AuthorDate:    Fri, 01 Apr 2022 17:13:51 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:51 +02:00

thermal/drivers/k3: Add hwmon support

Expose the thermal sensors on K3 AM654 as hwmon devices, so that
temperatures could be read using lm-sensors.

Signed-off-by: Massimiliano Minella <massimiliano.minella@gmail.com>
Link: https://lore.kernel.org/r/20220401151656.913166-1-massimiliano.minella@se.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/k3_bandgap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 35f41e8..5d0b3ff 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -16,6 +16,8 @@
 #include <linux/thermal.h>
 #include <linux/types.h>
 
+#include "thermal_hwmon.h"
+
 #define K3_VTM_DEVINFO_PWR0_OFFSET		0x4
 #define K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK	0xf0
 #define K3_VTM_TMPSENS0_CTRL_OFFSET	0x80
@@ -219,6 +221,9 @@ static int k3_bandgap_probe(struct platform_device *pdev)
 			ret = PTR_ERR(data[id].tzd);
 			goto err_alloc;
 		}
+
+		if (devm_thermal_add_hwmon_sysfs(data[id].tzd))
+			dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
 	}
 
 	platform_set_drvdata(pdev, bgp);
