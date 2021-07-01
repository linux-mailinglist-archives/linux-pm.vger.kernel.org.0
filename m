Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712F13B9913
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbhGAXbU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbhGAXbL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:11 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E19AC0613DB;
        Thu,  1 Jul 2021 16:28:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n14so14801409lfu.8;
        Thu, 01 Jul 2021 16:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HzpHVd/wXJ30oh466IC2EVzooXzefGiYFjcn2n08ruo=;
        b=QzQ5pplO2hhsbw4yrYD9N9EAUWtcjbEFGLQlsHe9NA9KplC5LuAmxFr/VdBx7bMNOf
         QB7TRZeR7R/KI4EfpynT6XoWcHWfAYjJa79Cb+2r8X1IdcS+NpTRZe1H8qgwhS5JLu0M
         IAn6mv4rTdgIcaDbKpKo+1rsyEoW1kqrzKsm3QQ6o+F4wZeKFSOTeYUaG0jDRtoo16lO
         yKwjInhJ2v7Wqxwkz9r/QG28vovm0TsXrnXWL1j3E7R1AF9gfEWuNyKN4uH/Q9gZacxO
         Ar8aE68laHh1v2wlCYzyD5y9Sm21I+y7UMOYhLElHhKvB6Yeut1gLfV6aOge3lLRz5rS
         UhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HzpHVd/wXJ30oh466IC2EVzooXzefGiYFjcn2n08ruo=;
        b=fXpDsSITch+r0Mwia0WWPRLWc3K17e/L5VJwKSvpFSCxqJXsjDwXAxmxsj/x/IfMRL
         TfaDDYMlvc2xk2tUXv7oFbgMMFNyQBt2qa7rifzU4dbfwMBnfbyiBIGtJFo1Q3xp+bLs
         y3z+ifqKugnVqFOU7PXNzvgUjckGnAHMbVp5XlKXwZDFhCWttZqeVcnJ9kJSdj9cAfNR
         MD0tRzyZVwJXCneJypGEeWMHCb2fyWipXQcs6GAhO+820s6tsBbvdR1quH9yenKbXZfF
         rhRDXdRR9pEnXVAzSitqOYrBASPGfvi7j/E01p+SEEJmtv5WXZBrf75zGwz0BMiyQr21
         vybQ==
X-Gm-Message-State: AOAM532WrKwIwW1ikkm4YITIbsDbYiUFRgdAaV7YmSiN4lw0WaVSZTvz
        TpKJIivCX7k62sDjXl9Zkmk=
X-Google-Smtp-Source: ABdhPJzfqFSUj+VP5Nw9ZJTEEruIvxosX04YbKueXxIvsSGSB7k6tIGdggcUDopLk6lGDR/1cFu6BQ==
X-Received: by 2002:a05:6512:3b27:: with SMTP id f39mr1479891lfv.360.1625182117689;
        Thu, 01 Jul 2021 16:28:37 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 13/37] drm/tegra: hdmi: Add OPP support
Date:   Fri,  2 Jul 2021 02:27:04 +0300
Message-Id: <20210701232728.23591-14-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The HDMI on Tegra belongs to the core power domain and we're going to
enable GENPD support for the core domain. Now HDMI driver must use
OPP API for driving the controller's clock rate because OPP API takes
care of reconfiguring the domain's performance state in accordance to
the clock rate. Add OPP support to the HDMI driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/hdmi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index e5d2a4026028..5b5d174c5a2b 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -11,10 +11,13 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
+#include <soc/tegra/common.h>
+
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_debugfs.h>
@@ -1195,7 +1198,7 @@ static void tegra_hdmi_encoder_enable(struct drm_encoder *encoder)
 	h_back_porch = mode->htotal - mode->hsync_end;
 	h_front_porch = mode->hsync_start - mode->hdisplay;
 
-	err = clk_set_rate(hdmi->clk, hdmi->pixel_clock);
+	err = dev_pm_opp_set_rate(hdmi->dev, hdmi->pixel_clock);
 	if (err < 0) {
 		dev_err(hdmi->dev, "failed to set HDMI clock frequency: %d\n",
 			err);
@@ -1708,6 +1711,10 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 
 	hdmi->output.dev = &pdev->dev;
 
+	err = devm_tegra_core_dev_init_opp_table_simple(&pdev->dev);
+	if (err)
+		return err;
+
 	err = tegra_output_probe(&hdmi->output);
 	if (err < 0)
 		return err;
-- 
2.30.2

