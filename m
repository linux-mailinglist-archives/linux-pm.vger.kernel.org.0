Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0074354376E
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jun 2022 17:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243215AbiFHPbk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jun 2022 11:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243815AbiFHPbj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2022 11:31:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9B93CA7E
        for <linux-pm@vger.kernel.org>; Wed,  8 Jun 2022 08:31:26 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a15so33777708lfb.9
        for <linux-pm@vger.kernel.org>; Wed, 08 Jun 2022 08:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PszhJWgHAI6pVsyU6iHd0WPiwfriVIOotwYAT+LX6GU=;
        b=CJ9bUUwJ5I/2DRNLCwUbHItekG3dQdL6+dLnCT2zVgL6qMZvEEUR9eCHnpXyDYeVM0
         dHfBKU7+U7dn9sO5zja+12uiXSJNCU1BzI7Ay6FoFGiczeGbMo8JcM5s0Swu6eCOtkZC
         Q+AK6UE4hVeKkKwh8MtJbSqpCOMeJZaZbLqpVVMjRNypYaxgB4wW94kwpPirlmsO/Iab
         DMgJ3LT0anyUrRiN30L60/8iJERFGNyJB/KrOMmJhtQbJZ5awHODafZlDF9otpqrBbMq
         k4Ei9DQ6XDDZKioxSUzM1Pgt9K7gWnHt+lU0YdjTnlU8eTqSsEFB6VbxCz2yTZJJV5XL
         AtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PszhJWgHAI6pVsyU6iHd0WPiwfriVIOotwYAT+LX6GU=;
        b=dpBurOUacW9A076/PeZMUpYAIM88HoS9+jgjorPgZeZ5WrrQKvj3BKfQy+Oe6c8lge
         ZePo3dJOprsOEPJ0sMdOAeq3vS4QXUwTQSMHZz2Q77+chAw0MkTxc82LOyBtBUX9hlhW
         4akaYo+MPO9FT7fxWvYVaHvdtOxiP3bIj4/g9tw43SkVfwcTJxvk5mKGX0/boxmPeVZG
         nXSEsDSLvxmmFL322F9JRFE8X2vy7KTft1+vGzTGPVC1zweB1D92vmE0X3XOac0qG6mn
         akCgqtXrkuXdRgwDjkL5C11pP2zi7gONGJF/1GyD02vsBfmlbESVuHur+qrvMHMsoa5u
         j75g==
X-Gm-Message-State: AOAM530Y3l5jj2ZxZpAKora7cH/wVHe0d1Kj5FM7ByhuXFlKzVsA179P
        h4KT3/i+oJ905SOfexZ/ipHEDA==
X-Google-Smtp-Source: ABdhPJw0DT7ia5MoypxM38XOxKE1ZGLksy/tIyqFVdh0t9mXVXB4daSntt2cx1ZWggrI94fa5IiEvg==
X-Received: by 2002:ac2:5463:0:b0:479:15cc:5cfe with SMTP id e3-20020ac25463000000b0047915cc5cfemr18622178lfn.656.1654702284777;
        Wed, 08 Jun 2022 08:31:24 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-137.NA.cust.bahnhof.se. [155.4.133.137])
        by smtp.gmail.com with ESMTPSA id k6-20020a2e92c6000000b002556a17e193sm3348345ljh.38.2022.06.08.08.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 08:31:23 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Tony Lindgren <tony@atomide.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Axe Yang <axe.yang@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM: runtime: Extend support for wakeirq for force_suspend|resume
Date:   Wed,  8 Jun 2022 17:31:20 +0200
Message-Id: <20220608153120.303070-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A driver that makes use of pm_runtime_force_suspend|resume() to support
system suspend/resume, currently needs to manage the wakeirq support
itself. To avoid the boilerplate code in the driver's system suspend/resume
callbacks in particular, let's extend pm_runtime_force_suspend|resume() to
deal with the wakeirq.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Note that, the reason behind this patch came up while discussing an MMC patch
for a Mediatek MMC host driver [1].

Kind regards
Ulf Hansson

[1]
https://lkml.org/lkml/2022/6/8/813

---
 drivers/base/power/runtime.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 676dc72d912d..445a724cbded 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1876,10 +1876,13 @@ int pm_runtime_force_suspend(struct device *dev)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
 
+	dev_pm_enable_wake_irq_check(dev, true);
 	ret = callback ? callback(dev) : 0;
 	if (ret)
 		goto err;
 
+	dev_pm_enable_wake_irq_complete(dev);
+
 	/*
 	 * If the device can stay in suspend after the system-wide transition
 	 * to the working state that will follow, drop the children counter of
@@ -1896,6 +1899,7 @@ int pm_runtime_force_suspend(struct device *dev)
 	return 0;
 
 err:
+	dev_pm_disable_wake_irq_check(dev, true);
 	pm_runtime_enable(dev);
 	return ret;
 }
@@ -1929,9 +1933,11 @@ int pm_runtime_force_resume(struct device *dev)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
+	dev_pm_disable_wake_irq_check(dev, false);
 	ret = callback ? callback(dev) : 0;
 	if (ret) {
 		pm_runtime_set_suspended(dev);
+		dev_pm_enable_wake_irq_check(dev, false);
 		goto out;
 	}
 
-- 
2.25.1

