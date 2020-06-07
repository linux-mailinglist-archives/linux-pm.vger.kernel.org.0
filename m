Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AB21F0EC1
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 21:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgFGTAF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 15:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbgFGS5Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:24 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037CCC061A0E;
        Sun,  7 Jun 2020 11:57:23 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d7so8855383lfi.12;
        Sun, 07 Jun 2020 11:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z07PPt/u97dYBnTZgvhRJ5rLo7+ZbziTOZ6KMaLiXtU=;
        b=Ctrheq2+Lk6agPf9hiEOvCmdXzM5uqqaftrWAGWVrhVKMKGMDwZHxP40MhdNi98r79
         jRnM/h+E9d6TV0BLQJypxKwufygJ1ZMzDYUntJlF3gpaBlbmAXXz0ZRG6gskT3AiKqls
         FQgLziaiSgFbIij7fr5PgZWH0ZN0VOFLqrvggSQhuHCh9GqlnZgfgJ4WJYhBplI+e92p
         tWIxsqbF3q63thO9NQ3ZAlJm9DD4SYtSu7ULH0FvzWFshROa5+GDnjIFQuQBy8Dyhuvj
         vcdcgPs8fBGgE03XAlczSbYn3oFxeszqKeJUp/Fczhm6nYh/0v2Kmy8TOKQyEVASmXLx
         FrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z07PPt/u97dYBnTZgvhRJ5rLo7+ZbziTOZ6KMaLiXtU=;
        b=Kegn8m2ZEYUQKIZC3g7luvjRylKLFUvVuLsnpvrfZEAsSO4OyvAd7FCmJtUzl+6fsO
         4HtCidzRDDBnqzxzoJEAvhzMizfCCvjEe33DzoUJH1z55XDQ72ZwXZRKomuQeTtOC2Jp
         WWXRuSVAzbu1sIUmKzbeGW7pZ1KKTi4UeidxZvbm5PJZgkTz1zAbVSEX+Nx+V07Bv31v
         mylZSHjcVO25cPpN1vy3RhqLwdsqoXZJbgDzW2oL0+RP7KmlRGAMaEFuw4sfrEruznNC
         m5U7WrZ6KUIzzcNeFsZQaL10D8++FnaqMf7EMBF22uYE/ikwXLPA36j3XbQg4/xLpxan
         06mw==
X-Gm-Message-State: AOAM530suGD/Ct8txcbIQ2OCS+p3OISvGu9xCJThetP/GNms7h1GEse/
        mklAaAORt+xVElwpfVw0I2K/UIx1
X-Google-Smtp-Source: ABdhPJxaKvBwRyTdyvk01wbXZBDYI3yeNk6swFO3Ell52B0Lg1W78KUXB4yGariWUIU0YR3GP/Pujg==
X-Received: by 2002:a19:8b06:: with SMTP id n6mr10632727lfd.66.1591556241530;
        Sun, 07 Jun 2020 11:57:21 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:21 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 09/39] memory: tegra20-emc: Initialize MC timings
Date:   Sun,  7 Jun 2020 21:55:00 +0300
Message-Id: <20200607185530.18113-10-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We're going to add interconnect support to the EMC driver. Once this
support will be added, the Tegra20 devfreq driver will no longer be
able to use clk_round_rate(emc) for building up OPP table. It's quite
handy that struct tegra_mc contains memory timings which could be used
by the devfreq drivers instead of the clk rate-rounding. The tegra_mc
timings are populated by the MC driver only for Tegra30+ SoCs, hence
the Tegra20 EMC could populate timings by itself.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 47 ++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 035d9251e28a..a95522020a25 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -15,12 +15,15 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/sort.h>
 #include <linux/types.h>
 
 #include <soc/tegra/fuse.h>
 
+#include "mc.h"
+
 #define EMC_INTSTATUS				0x000
 #define EMC_INTMASK				0x004
 #define EMC_DBG					0x008
@@ -650,6 +653,38 @@ static void tegra_emc_debugfs_init(struct tegra_emc *emc)
 			    emc, &tegra_emc_debug_max_rate_fops);
 }
 
+static int tegra_emc_init_mc_timings(struct tegra_emc *emc)
+{
+	struct tegra_mc_timing *timing;
+	struct platform_device *pdev;
+	struct device_node *np;
+	struct tegra_mc *mc;
+	unsigned int i;
+
+	np = of_find_compatible_node(NULL, NULL, "nvidia,tegra20-mc-gart");
+	if (!np)
+		return -ENOENT;
+
+	pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (!pdev)
+		return -ENOENT;
+
+	mc = platform_get_drvdata(pdev);
+	if (!mc)
+		return -EPROBE_DEFER;
+
+	mc->timings = devm_kcalloc(mc->dev, emc->num_timings, sizeof(*timing),
+				   GFP_KERNEL);
+	if (!mc->timings)
+		return -ENOMEM;
+
+	for (i = 0; i < emc->num_timings; i++)
+		mc->timings[mc->num_timings++].rate = emc->timings[i].rate;
+
+	return 0;
+}
+
 static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
@@ -705,6 +740,18 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	/*
+	 * Only Tegra30+ SoCs are having Memory Controller timings initialized
+	 * by the MC driver. For Tegra20 we need to populate the MC timings
+	 * from here. The MC timings will be used by the Tegra20 devfreq driver.
+	 */
+	err = tegra_emc_init_mc_timings(emc);
+	if (err) {
+		dev_err(&pdev->dev, "failed to initialize mc timings: %d\n",
+			err);
+		return err;
+	}
+
 	tegra20_clk_set_emc_round_callback(emc_round_rate, emc);
 
 	emc->clk = devm_clk_get(&pdev->dev, "emc");
-- 
2.26.0

