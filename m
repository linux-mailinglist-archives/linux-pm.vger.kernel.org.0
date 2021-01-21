Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A7A2FE89B
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 12:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbhAULUp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 06:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbhAULUn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 06:20:43 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6184CC061793
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:18:48 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y8so1097787plp.8
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t5BvkMjuaVY08gUJbMK2zLQ+31ycbwXJT/Kur/3Z95w=;
        b=F1sJbjeFjLx44rMNM9VXJT1VmL0MJFDwx3vGHr2mL8qHmnto11WjN8OD6D0Tyl/3vP
         yxjF81dLQrtt3ea+reaI7O2lR4kp3WgLQ2E6yT65oolB8vJLDeETZLwZ8AT+H4p8KKFM
         eVMKCCkc3lJqxoLslpyYIPktsJtfe5IAPrM3JkeG+gRiiPJgp7Ea+eeujptT99yVRHvE
         3w0lz9qDfeIR6CqQj7nyk17ZQYSS2gaCG++MImOdhNGYBOSZMr3IFxb3hxWFMP1rpLwi
         t0cbvWkGBBmFxH5Ts7PPu2urw4C14l638fkduz4HQve/esYKhJsb+KyPYqvVC6MIXtUr
         81tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t5BvkMjuaVY08gUJbMK2zLQ+31ycbwXJT/Kur/3Z95w=;
        b=gqbFlJtBRRVDsJ3Oy6LfxIlVwNOGIAzrmS1DnP9sd6iroI8F++tQhKlqh4Z9GaK+zT
         x3D750cZzfskAQo/YHSKuHAunQ7j78M7R3wiCLCB363myOhSYmRi9eKzjunTHbm1ZR2r
         9YpRa+t/WRT8nKubIJTTLW5N81TX0ubxAOF6UCHf9zK8EA8biVkZPD+ZM1+vZ3Ip9yPc
         2kTe40podliXwxCfOrJq8TNVoXeYhXfcudzWWRFjcpDJG/EJip3J5LDnurCFr44JkT4p
         +lunT/3IBl+l57znNk25u7DUUwWJDsso5VqbkBHlkVKdrBFK4kdktkGqGLLmVbEjx8Vn
         6Y6A==
X-Gm-Message-State: AOAM531YTxTFihx6HSDIm5W6WChbnpmqf8di1g9UvD6JcILPK+kdswEI
        VtvFHUDuL6yElUnkJieaJ3BUSA==
X-Google-Smtp-Source: ABdhPJz7q/I5ANoKOSZSRSNYadjp4zVir7HUG9/UL0WMu7ayW5Oc9Bj7FnQUI7AdPHyZwNvg7ZPdOg==
X-Received: by 2002:a17:90a:9eb:: with SMTP id 98mr4799013pjo.40.1611227927908;
        Thu, 21 Jan 2021 03:18:47 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id d22sm5661965pjv.11.2021.01.21.03.18.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:18:47 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/13] opp: No need to check clk for errors
Date:   Thu, 21 Jan 2021 16:47:42 +0530
Message-Id: <26fe0df01647061cee8278af64a86610d65711f6.1611227342.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611227342.git.viresh.kumar@linaro.org>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Clock is not optional for users who call into dev_pm_opp_set_rate().
Remove the unnecessary checks.

While at it also drop the local variable for clk and use opp_table->clk
instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9ec8e42981d0..cb5b67ccf5cf 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -987,7 +987,6 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	struct opp_table *opp_table;
 	unsigned long freq, old_freq, temp_freq;
 	struct dev_pm_opp *old_opp, *opp;
-	struct clk *clk;
 	int ret;
 
 	opp_table = _find_opp_table(dev);
@@ -1001,19 +1000,11 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		goto put_opp_table;
 	}
 
-	clk = opp_table->clk;
-	if (IS_ERR(clk)) {
-		dev_err(dev, "%s: No clock available for the device\n",
-			__func__);
-		ret = PTR_ERR(clk);
-		goto put_opp_table;
-	}
-
-	freq = clk_round_rate(clk, target_freq);
+	freq = clk_round_rate(opp_table->clk, target_freq);
 	if ((long)freq <= 0)
 		freq = target_freq;
 
-	old_freq = clk_get_rate(clk);
+	old_freq = clk_get_rate(opp_table->clk);
 
 	/* Return early if nothing to do */
 	if (opp_table->enabled && old_freq == freq) {
@@ -1031,7 +1022,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	 * equivalent to a clk_set_rate()
 	 */
 	if (!_get_opp_count(opp_table)) {
-		ret = _generic_set_opp_clk_only(dev, clk, freq);
+		ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
 		goto put_opp_table;
 	}
 
@@ -1071,7 +1062,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 						 opp->supplies);
 	} else {
 		/* Only frequency scaling */
-		ret = _generic_set_opp_clk_only(dev, clk, freq);
+		ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
 	}
 
 	/* Scaling down? Configure required OPPs after frequency */
-- 
2.25.0.rc1.19.g042ed3e048af

