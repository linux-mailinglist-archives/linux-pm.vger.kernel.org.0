Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD76455295
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 03:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242537AbhKRCXX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 21:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242530AbhKRCXS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 21:23:18 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9463DC061570
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:18 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id t26so17987961lfk.9
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OxNCjc7MAwItE0Quq7/jM51++0N9X+9SGKjcFevR0vs=;
        b=NtJ3GsxjG6ca6VT0dZBFLYg2rZ/TLg3SgtIp/ZiA6DZNKQVkwNEA2C/7T6n9aGPYhX
         s4yzZUAhbbd6XwuSuMyLP8AgGfeezuXcOMaQGXnRNI0/g4FRtctjPFcn+yn7pGo1gdFq
         VCE7KC4JzPonJC2vf7LAPYrg+gyKa76YevK0ZSou/wGUfdXx75DQ+Knyc5sLbeEDGjb+
         mjggsnbhzWr1xccr6FaifHau4DHDFIHTVtYlr9lfB4jBWW/TrS/ikrREvEB0brUzmrrX
         uRvysnzpt01AOV93SudkJbBx5lZPMBThDO4ENsSZ2XK8h6NGPl8fuihwIyER3qxiGIYN
         3a/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OxNCjc7MAwItE0Quq7/jM51++0N9X+9SGKjcFevR0vs=;
        b=LluLuoF2DljmYaU/1NoDd4AuDhIOvTUfb+pw0v30LDZ51FJ6Oo1lVx68Wz3DpQHLZ7
         4wzz4qLDqDsoXrJL6G2P5AhTQAqrbXFzq5rFAH32W600tc0v4z8DMr2Z4CJ3cDe4Y63v
         mQvjK530jThfYktod4ITvrt5GDo9u7tu5AUjx4GKB8pmJq9v96BynMrWAIGlkg/FscOE
         wy+zvc4RQ684lALT/1o94OJrxmpyGk0hkUpBI9N171TFhYGRnVHqeLzlB5x1LHeEXRXT
         CChtMDpTj4m9En19zugNc20KzwbXkpC36UwGeu+dnei5FA5LGlmL2BQuSeXr1NisfQer
         PPqA==
X-Gm-Message-State: AOAM531G7HihoH/Duwm5CF74G2njThwah1PV3Cw9OxtOGOYFoh1olM50
        qPucnv/QYXRU7vzd36lWXW5XZg==
X-Google-Smtp-Source: ABdhPJzxEs2+20rCekhCR2yvTq85HsNgYBf3/3jiosawMSQ1RkrWh7mo4rIjX3izYtk1Ua7vzT0Nzw==
X-Received: by 2002:a05:6512:2304:: with SMTP id o4mr20392488lfu.543.1637202016994;
        Wed, 17 Nov 2021 18:20:16 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j19sm165321lfe.120.2021.11.17.18.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 18:20:15 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 09/16] power: supply: ab8500_fg: Init battery data in bind()
Date:   Thu, 18 Nov 2021 03:17:45 +0100
Message-Id: <20211118021752.2262818-10-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118021752.2262818-1-linus.walleij@linaro.org>
References: <20211118021752.2262818-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We were assigning some battery data state in probe() but
this is insecure as it depends on the proper probe order
between the components: the charger must probe first so
that the battery data is populated. Move the init to
the bind() call which is certain to happen after the
probe of the master and all components has happened.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_fg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index ab6141faa798..daa008138b05 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3023,6 +3023,10 @@ static int ab8500_fg_bind(struct device *dev, struct device *master,
 		return -ENOMEM;
 	}
 
+	di->bat_cap.max_mah_design = di->bm->bi.charge_full_design_uah;
+	di->bat_cap.max_mah = di->bat_cap.max_mah_design;
+	di->vbat_nom_uv = di->bm->bi.voltage_max_design_uv;
+
 	/* Start the coulomb counter */
 	ab8500_fg_coulomb_counter(di, true);
 	/* Run the FG algorithm */
@@ -3082,10 +3086,6 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
 	psy_cfg.drv_data = di;
 
-	di->bat_cap.max_mah_design = di->bm->bi.charge_full_design_uah;
-	di->bat_cap.max_mah = di->bat_cap.max_mah_design;
-	di->vbat_nom_uv = di->bm->bi.voltage_max_design_uv;
-
 	di->init_capacity = true;
 
 	ab8500_fg_charge_state_to(di, AB8500_FG_CHARGE_INIT);
-- 
2.31.1

