Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F17A128F1B
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2019 18:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfLVRlg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 12:41:36 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40695 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfLVRlg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2019 12:41:36 -0500
Received: by mail-pl1-f195.google.com with SMTP id s21so3543752plr.7;
        Sun, 22 Dec 2019 09:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GjIArb4hl7a0UGSCX9uBkL4nmbYXvZobEZoJkTTSRZE=;
        b=mPCxLyETPkbxQhjDoSLsPUtXBpNUwEKEmKVzgnHkA4JnaBUw9M+lvbXtEb0YReHJzT
         l9J15qZXXxVM2VC27XXsahsfGBCRDuqDDpjHhreb5qzctHmIQULVnWBhI+RiAetpgSrC
         XSxwVxo1l7JEL0zM9SBC+n2cJSl4PakbOrBBpkdZt7zOzjPgKoSa0A4BlkPJX3lYH/zT
         LoD2mwynQpO0XKOlsRQKLwlCpiqsJuanDg4131Td4qRhCD9CWw3dQyz+7xYoa9XyN7U4
         3nrW7xwYI4zARl/3xWOI71nMSMLqScXF3MAuF7LNA6VGBJWEFZ6BAa6MEgugUlu8tYcZ
         acSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GjIArb4hl7a0UGSCX9uBkL4nmbYXvZobEZoJkTTSRZE=;
        b=MrcsqpY2WFGT+YYRRwD2K0LBUKVeEPBqY5p2+f9+DDQ+ArXJExrzTQ1nnONPECUbBi
         gPEJtHiE71SX2zcyAiKWOLT2DtlzRllEyTw5GwTGH3MPxTvG8PkwwSyVfjYEteafBzHj
         qm3yi+fsSAzxuTxvPJBwsOAHTgGj/t5bzK2wx5rfXX/GXqmE5g8wfvF6ivxJ9W9FnLm1
         +BWhT5IAWof8SRQ4/er/7/TdMNrjoxKGtZ4kOsJ/fKnMH+gXpdoykRJLjvui3S1CqNFh
         1opeZM6by/CrmNTBCnPFc1sAkfKAVXXe7yUYsBP6qMvyGRiF5v/SUSlud8qHar/KHb3y
         6K3g==
X-Gm-Message-State: APjAAAUsAXjYO8Cyj9z+wSMg3exAwvJA1+rxc+f2z1QtkU401GqpLePy
        7g9CXVhwBTKz9x6TwgjwdUQ=
X-Google-Smtp-Source: APXvYqxWJxGk8wNhQDGsDwCsSuiO1+raKJZgeeqvjiRwYP/0gDQg6gDnZJGz3gr4oLv5qmI2Aww9Rw==
X-Received: by 2002:a17:902:9f88:: with SMTP id g8mr27115715plq.100.1577036495552;
        Sun, 22 Dec 2019 09:41:35 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id i3sm19663100pfo.72.2019.12.22.09.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Dec 2019 09:41:34 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 1/2] PM / devfreq: rk3399_dmc: Disable devfreq-event device when fails
Date:   Sun, 22 Dec 2019 17:41:31 +0000
Message-Id: <20191222174132.3701-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The probe process may fail, but the devfreq event device remains
enabled. Call devfreq_event_disable_edev on the error return path.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
v2:
-change subject
-rename lable to err_edev
-fix error path handler
---
 drivers/devfreq/rk3399_dmc.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)


diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 2f1027c5b647..4288745304c7 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -364,7 +364,8 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 			if (res.a0) {
 				dev_err(dev, "Failed to set dram param: %ld\n",
 					res.a0);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_edev;
 			}
 		}
 	}
@@ -373,8 +374,10 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	if (node) {
 		data->regmap_pmu = syscon_node_to_regmap(node);
 		of_node_put(node);
-		if (IS_ERR(data->regmap_pmu))
-			return PTR_ERR(data->regmap_pmu);
+		if (IS_ERR(data->regmap_pmu)) {
+			ret = PTR_ERR(data->regmap_pmu);
+			goto err_edev;
+		}
 	}
 
 	regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
@@ -392,7 +395,8 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 		data->odt_dis_freq = data->timing.lpddr4_odt_dis_freq;
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_edev;
 	};
 
 	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
@@ -426,7 +430,8 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	 */
 	if (dev_pm_opp_of_add_table(dev)) {
 		dev_err(dev, "Invalid operating-points in device tree.\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_edev;
 	}
 
 	of_property_read_u32(np, "upthreshold",
@@ -466,6 +471,8 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 
 err_free_opp:
 	dev_pm_opp_of_remove_table(&pdev->dev);
+err_edev:
+	devfreq_event_disable_edev(data->edev);
 	return ret;
 }
 
-- 
2.17.1

