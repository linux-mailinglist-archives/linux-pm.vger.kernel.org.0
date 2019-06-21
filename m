Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4BF4E76B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 13:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfFUL4N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 07:56:13 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33926 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFUL4M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2019 07:56:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id y198so4909413lfa.1;
        Fri, 21 Jun 2019 04:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6CY0RheL+tKXKaf6H+vxXAMTeNTiZ763D8RhuvLAtc=;
        b=mog0CL2U0G1P8NJgVE/dtGaUCKtnqsbnRVgfihGI+R1N1xTZON4z3Vc/zEDa6RWwju
         ca+WqipdrsAuErOjZkSRMn6zMb2uLt/OajY8Q6CHcnAr2Jchn+iAEySCuH4olXqzUsIC
         M/oIIKLFtMcNxdYCriD1OG3R2wn5xIUU3L8y23a4VAaVZHsSKVrIaZBcMaVEQOKKBvof
         RO6PQ5TJNjxezCIxwxbOGt/zqJ3UTxOS5HHizU/AB4JHrjn8zjDTKRdVFtTkz5Xf+2V4
         34T4/MOrzdhftqo4MlzFaXzkE0W6b77Y4esu+/WDee/ITqkbZuuY1ackyagPAi0kmyVm
         lHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6CY0RheL+tKXKaf6H+vxXAMTeNTiZ763D8RhuvLAtc=;
        b=XxMZDhknaoRCSmE8846DGsOet8F0tC4Htxz8hlLz/v0haWrviuzQDydCNiO6EcGN9r
         VCo0Cse1TfoaHpLeb3e1GZyz+qRyPg++C3tMzkw8oi/euW86WTNfZqC7ybQLvB0y324f
         Ox+k7SzsxS7nhWcji2deCTand0bJTYaOnr04hVBdoUX/H+ZH7maGMexjRjNA2FTVb/QA
         Q5bjGPr+2dOUXpjyihs2jF2HuNOMPpH6Uf5Rm12IlA3uodzMgzoPVaZoYSarqeuoNQyX
         hU/4IRpbaDhySjWqoKM9Wj68bV2o0ZC2jVrUJk3e+uoKMCwxnUj3j+cd9znw8n2h1w0H
         7SmA==
X-Gm-Message-State: APjAAAU5tswl7YZ9/sI8Sg7qwNxO43APdOErBJ/1a1R1j5CPm2Lm1gIb
        Y138wmY1lIFW3T3k4/BhUV2o/OPt
X-Google-Smtp-Source: APXvYqwqTasJcDIxaN0kCPAmlskTL45Kf7oqTESP7/BzjMEakfzchsEzCi4jMYZLcDVSLh2seJSBGw==
X-Received: by 2002:a19:9e4b:: with SMTP id h72mr42918875lfe.21.1561118170186;
        Fri, 21 Jun 2019 04:56:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a315:5445:5300:a5e4:32fe:c6e4:d5eb])
        by smtp.googlemail.com with ESMTPSA id s14sm356791ljd.88.2019.06.21.04.56.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 04:56:09 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     sre@kernel.org
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v4 1/2] power: supply: max8998-charger: Parse device tree for required data.
Date:   Fri, 21 Jun 2019 13:56:01 +0200
Message-Id: <20190621115602.17559-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621115602.17559-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190621115602.17559-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds missing code for reading charger configuration
from devicetree.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v3:
  - Property prefix should be maxim, not max8998
  - Changed property name to more meaning full

Changes from v2:
  - Make restart level and charge timeout properties optional.
    If they're not present in devicetree, assume they're disabled.

Changes from v1:
  - Removed unneeded Fixes tag
  - Use new property names
---
 drivers/power/supply/max8998_charger.c | 60 ++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/power/supply/max8998_charger.c b/drivers/power/supply/max8998_charger.c
index 9a926c7c0f22..dfd473ed4c5b 100644
--- a/drivers/power/supply/max8998_charger.c
+++ b/drivers/power/supply/max8998_charger.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
@@ -69,6 +70,59 @@ static const struct power_supply_desc max8998_battery_desc = {
 	.num_properties	= ARRAY_SIZE(max8998_battery_props),
 };
 
+static int max8998_pmic_dt_parse_pdata(struct max8998_dev *iodev,
+					struct max8998_platform_data *pdata)
+{
+	struct device_node *pmic_np = iodev->dev->of_node;
+	struct device_node *charger_np;
+	int ret;
+
+	charger_np = of_get_child_by_name(pmic_np, "charger");
+	if (!charger_np) {
+		dev_err(iodev->dev, "could not find charger sub-node\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(charger_np,
+					"maxim,end-of-charge-percentage",
+					&pdata->eoc);
+	if (ret < 0) {
+		dev_err(iodev->dev,
+			"Could not find maxim,end-of-charge-percentage in devicetree\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(charger_np,
+					"maxim,charge-restart-threshold",
+					&pdata->restart);
+	if (ret < 0) {
+		if (ret != -EINVAL) {
+			dev_err(iodev->dev,
+				"Failed to read maxim,charge-restart-threshold\n");
+			return ret;
+		}
+
+		pdata->restart = -1;
+		dev_dbg(iodev->dev, "Charge Restart Threshold disabled\n");
+	}
+
+	ret = of_property_read_u32(charger_np,
+					"maxim,charge-timeout",
+					&pdata->timeout);
+	if (ret < 0) {
+		if (ret != -EINVAL) {
+			dev_err(iodev->dev,
+				"Failed to read maxim,charge-timeout\n");
+			return ret;
+		}
+
+		pdata->timeout = -1;
+		dev_dbg(iodev->dev, "Charge Full Timeout disabled\n");
+	}
+
+	return 0;
+}
+
 static int max8998_battery_probe(struct platform_device *pdev)
 {
 	struct max8998_dev *iodev = dev_get_drvdata(pdev->dev.parent);
@@ -83,6 +137,12 @@ static int max8998_battery_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (IS_ENABLED(CONFIG_OF) && iodev->dev->of_node) {
+		ret = max8998_pmic_dt_parse_pdata(iodev, pdata);
+		if (ret)
+			return ret;
+	}
+
 	max8998 = devm_kzalloc(&pdev->dev, sizeof(struct max8998_battery_data),
 				GFP_KERNEL);
 	if (!max8998)
-- 
2.17.1

