Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCFF128ABF
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2019 19:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfLUSS7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Dec 2019 13:18:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35598 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfLUSS7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Dec 2019 13:18:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so6660059pgk.2;
        Sat, 21 Dec 2019 10:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bwbzx/0lyuLyDgYjlpKZwdoDwlYToxmSNQqN2Jns3/U=;
        b=iafzJSRx/Oh+GsjR2eJ4ZkqzB5Pw0i+xDji0iUrPwKNsBXCMR/h7rRSPzD0vZlMela
         6/GMUqYS/4BARhHl0hNwVUAuXSKviN70XHxuqnmaSokLKcW9GMr20YleqNvxBuI05GMI
         5zefIMIKTzIXxMx1KYw33LQnboH+Qj+LodgB1d/l5GsN91jedf/bt1b0T37ydml6moDG
         6Rz/1uEp+h1r+qtjE2LEIwjE4ZCpMCGJmpVplFWbTp7QPtfj4vWS5X60x1xEP3Dcl4iG
         iRzdyYLvTo1d6oXwKTshMXs/0+TZySPVTUTiCF5Weqvp/egm7AyJIzQplp8tvj1gIA9+
         D+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bwbzx/0lyuLyDgYjlpKZwdoDwlYToxmSNQqN2Jns3/U=;
        b=kU714BccProNuH96ZlAgh9hMCBERV0W1FX5CRBIK26KuMoRJ36wxAjj8hXTqyOpU7x
         UFmc8fxiNNaHDy1zrAze05U76YNgCqAVAc7EaS9np/iMd3nEAmTxSsd096WdW5H/aY0d
         nHUr9HfhNLV13V0pP39tIBpV11vtV0GK1e4KTnsFRZNjTKQo4qdBtfW2Ym4cdJ3JAFzw
         Y3jQ/HMMLj12MTirGVgGcEeW4fcu4hhRY9xQpxON0AZXO6OnN34ewzdHdag5TB39YJQv
         ZuSJ+Fo8eG53hWbmuTuR5YpXJ2Lzqq4AAwCO6kOAmxjpXJjE7WNYalDLvgZAjOVg51cF
         lZAg==
X-Gm-Message-State: APjAAAUr9kxH6QxWG0amaf6lhNu/zWUQ2TmSD6rQ8NNWUkZozKyN7tx5
        zHzV/ygucP1dwf23AgkOl6U=
X-Google-Smtp-Source: APXvYqwCQ2pikuGus5t9NRDx8dicrxR/iMjGdpMtjiAyPYt4OsDp/uwZ/85qHhf7prm6ugOwlBoVNA==
X-Received: by 2002:a65:488f:: with SMTP id n15mr23158105pgs.61.1576952338290;
        Sat, 21 Dec 2019 10:18:58 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id m71sm17264906pje.0.2019.12.21.10.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Dec 2019 10:18:57 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/2] PM / devfreq: rk3399_dmc: Add missing devfreq_event_disable_edev
Date:   Sat, 21 Dec 2019 18:18:54 +0000
Message-Id: <20191221181855.31380-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The probe process may fail, but the devfreq event device remains
enabled. Call devfreq_event_disable_edev on the error return path.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/rk3399_dmc.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 2f1027c5b647..4f4e7c041888 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -364,7 +364,8 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 			if (res.a0) {
 				dev_err(dev, "Failed to set dram param: %ld\n",
 					res.a0);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_disable_edev;
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
+			goto err_disable_edev;
+		}
 	}
 
 	regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
@@ -392,7 +395,8 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 		data->odt_dis_freq = data->timing.lpddr4_odt_dis_freq;
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_disable_edev;
 	};
 
 	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
@@ -426,7 +430,8 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	 */
 	if (dev_pm_opp_of_add_table(dev)) {
 		dev_err(dev, "Invalid operating-points in device tree.\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_disable_edev;
 	}
 
 	of_property_read_u32(np, "upthreshold",
@@ -464,6 +469,8 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_disable_edev:
+	devfreq_event_disable_edev(data->edev);
 err_free_opp:
 	dev_pm_opp_of_remove_table(&pdev->dev);
 	return ret;
-- 
2.17.1

