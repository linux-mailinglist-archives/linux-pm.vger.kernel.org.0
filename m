Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16CD457F25
	for <lists+linux-pm@lfdr.de>; Sat, 20 Nov 2021 16:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbhKTP7D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Nov 2021 10:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhKTP7C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Nov 2021 10:59:02 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECC4C061574
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:55:59 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id y26so57995904lfa.11
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fun4TWsSc9G9zLaUwD2vvAGUYfe4r5yJaE/87fDhtJg=;
        b=WoHNzsL5dP/OK5lIXEWBNcSlkEwA0lS8FY2rCfTIB+jrm2Szd3aftZrXdZYSkgpTln
         e4T92wwynTf2rcKGaDdLWobj1ZGItM4mHJZ/Wbym/Oi7DAxBmXbIF39bEcI6foc16CPZ
         Iid6wS5a9aSivNFJjWMIYeq6mr8lKp5Omdjgosv7dl6g3AWxoJ08qH8M0vULW6EXHaTd
         P02CkePde+KkcQNWMG+sQemMH41MTNj7EqI2++uI6C0tEfmbla2oHllsahR5N4FIHDCK
         tEnP4CDrBQAIloDBsXBkEhHMDNLCOGdPUDnrrOqRr9oFC9Q3dGYNEh3Qw14VXRvIdo4H
         8DrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fun4TWsSc9G9zLaUwD2vvAGUYfe4r5yJaE/87fDhtJg=;
        b=wKJgkCdQ0lU9YlWa5vk9piLLHXxkLVZXgC5Fn2bnKgpKZT1aZtK0MLOPzXOST+mK0o
         BJ7uEOFyHjjBgQgRkgHnLC0tLfVzDJt6BpB1J0EhnxEG6Fco6Rre1s2NB27rPZ14ml7K
         UV2moipx8H8w2uCV/ZPS4WJ93AcFDK5G0KsjEA7vC+Disf0ESmYsyzMnw0YP9EGX3nqJ
         NRxunI7rKGlL9KdgLajiV0IjyX7bjzscUEek11nuc03fyF4oqpYP5mMRWEo9fBWawIWH
         QbwLblsWfcZVo8HeR3pEx5MhWPv34IGFpgoSI+djkH8vjticWkGJy4GalquiuUHFR3Jw
         JAXQ==
X-Gm-Message-State: AOAM533nOxrA/Pmmb2mbcu+9rluAMimUmOGeHS+EqyUwbH6Dn3jmZ6Z+
        n50S/kM5FC2DSVkfP4nnOWmtsQ==
X-Google-Smtp-Source: ABdhPJw2GjcBWjYeIEo41ftfi7E+UIDhziF8xKNHpG5kzWqJVH8EzUCvBwtR6hdMaq4F5I+BB4hoCw==
X-Received: by 2002:a05:6512:32c6:: with SMTP id f6mr41589404lfg.40.1637423757609;
        Sat, 20 Nov 2021 07:55:57 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t12sm280922ljg.63.2021.11.20.07.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 07:55:56 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 09/16] power: supply: ab8500_fg: Init battery data in bind()
Date:   Sat, 20 Nov 2021 16:53:19 +0100
Message-Id: <20211120155326.2891664-10-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211120155326.2891664-1-linus.walleij@linaro.org>
References: <20211120155326.2891664-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Rebase on the other patches
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

