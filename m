Return-Path: <linux-pm+bounces-17121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3529E9C096F
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 15:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90EE284F01
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 14:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428702139A2;
	Thu,  7 Nov 2024 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="md29J8U7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D2F21315B
	for <linux-pm@vger.kernel.org>; Thu,  7 Nov 2024 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991463; cv=none; b=H0P2hUcxq3soiHVSmIDpK5uYXqhEb4a3bKqWy3Dz/MjWxQleXwajqH22OtTHj6G+8rOS6VTKte1e27ThyWBfSt6EeRPZ7sbSl1RzGrNr3QN6bJhrk3xqogN6Dg5bk+eiBGk/rg4B+MR4fL+b2NiJtKVmDMNv3cZAOLVqYhQRsyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991463; c=relaxed/simple;
	bh=BLY94gMzJV8bl1rs8ITlqHgcrX3WJaZb1Ugt48De6Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nYKke4E9EoubrxIXsVirxPqc9UrW87oflDbaMRHjiTdvyUaeVi7WqjCDfVDau9iaYJ8ftstsOv7mTf8tolLBGDddiwoDQ/n4k6qzDgAO3VRVBwmU7dJCRJ/P4KDmx33/rNkqrlQEbPucSxtuI33BTSxUdoNYhUDyDqvkqipjPoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=md29J8U7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so9203155e9.3
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2024 06:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730991458; x=1731596258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lqk0qjxtF+D8UlnS4c7pFGqetkwdoGFt8LgY3js1r6w=;
        b=md29J8U7/VHYYyn33wxR9udL2DoXIsYHTWs+uzv6i93xcwWP6pwa8L3qDFYa/chAyK
         0BlcLGpcFDjYqz+OyX9iv7dVeajesA9oePaPntYSRh1FXM01yWkgeNLG/A72YNJyu1HN
         ehMAgVj6Vmhgwv74vVmo/E8lNlsk5SPbSHHiIGyLDLcfYsP4gvEUGjkZ1+qD88ZRHe+8
         2fWXwtl5hI8PX8AS3Us3tvx+scbgVhYENouumy3gRya4m3zOiC9t52AkcseDguGd5FSY
         swUOon8XtuU4+SiN45YcuiCX+pN8xqRGIrtPMzMl4kJMsuSD4B6PdKkq1GkStSfo5hvb
         SPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730991458; x=1731596258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lqk0qjxtF+D8UlnS4c7pFGqetkwdoGFt8LgY3js1r6w=;
        b=rojk1LWpjBo988XQTy5govObWQYV+Hj6Ta5htfUYPCOUOGJY9hkYKNfEp6irJ1ZI+F
         NDTPIUIunUwOlFjMwpM8meZ4TX6TBSOY95tPYsG4VZPskJsb6nlDt6x8LLkPtIQ60+9A
         lasVYjy1bA9rFzfo6D8Ilt3RAeCJmUwIQOwFPnHjgYTvaLLd9w3fyMP46xBNHeB09Y6k
         fjbhXj1it7kCkGczKtkWRFvOC96SmiZUoZDoXCJWk88sY+i/ojCm6f8JCGwTe6GCMJUZ
         Hzw++gz7sMFDqNon6D8zIyNfQDHE8QXzUuxJW1i4aefI2MtoFjAhPkA+ipnHLojpSBHS
         tYWA==
X-Forwarded-Encrypted: i=1; AJvYcCUfe3hckyhL7SEDBFTu3qC18Js1cuA2bEIiHnCDuIJfTEOSrLRmbYNmPHkgbkmJARhzV8pDN/nl6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy49GwIPTjGRtji7yPM7u72B8iAjKjciuuUddVBc5lnERN+Fc5c
	q4xe4ms62CdmNM3qaflGZ01oAMMdzxIW+mjVCcMc9TYJi09+mHSIESyRh5q4B0U=
X-Google-Smtp-Source: AGHT+IFutcR0bwD8WGqeYpA0PxXHK8DXeXLoWqc0ukDAw+4BGJ+GPCxRmhBmc2u0+oKs2PA+/pN2iw==
X-Received: by 2002:a05:600c:3c9d:b0:42f:823d:dddd with SMTP id 5b1f17b1804b1-4328327e6ddmr198325885e9.27.1730991458265;
        Thu, 07 Nov 2024 06:57:38 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5e56sm66186115e9.2.2024.11.07.06.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 06:57:37 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org
Subject: [PATCH] memory: Switch back to struct platform_driver::remove()
Date: Thu,  7 Nov 2024 15:57:16 +0100
Message-ID:  <1a44c5fc95616d64157d2f4a55f460476d382554.1730987047.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9746; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=BLY94gMzJV8bl1rs8ITlqHgcrX3WJaZb1Ugt48De6Y8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnLNVM5QHSsQ7HgmkC6FzXKigeL1KUUWrXvsJ6O VJasoc4Mn+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZyzVTAAKCRCPgPtYfRL+ TigRB/0bxEq95zaC2k3YuORkpdyWmyAoPbkwl6e0yDuizDWC8tUPgkPxjP6tjGCeLnO0fqtTk3M y5yD+Jo9qpEaO8Q4tCyiWZ/2EMw2eXve2+L6l/hFHq1HwUcDe3uru2yXBaXpbrOgNAuMKRlpApR 4KoXUXbQETaAPe5MhVphrGW+dxWzf5I0XHMXefWcg2fHXsoz2EI5hKEk0c25S3dI4tM4RZFqnfK 08Pp2+RlDKgDMTRbstCJeYXCYZxKahvwrIhg6AK9FP6yPsTpc8rlMvQsdBx6zilVYUex/dBgxeO pXTfPBqNmRn6mTjrN6Qu5lwEUnReoNrvyOCiooTUjAvWL240
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/memory to use .remove(), with
the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

A few white space changes are included to make indention consistent.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I did a single patch for all of drivers/memory. While I usually prefer
to do one logical change per patch, this seems to be overengineering
here as the individual changes are really trivial and shouldn't be much
in the way for stable backports. But I'll happily split the patch if you
prefer it split. Also if you object the indentation stuff, I can rework
that.

This is based on yesterday's next, if conflicts arise when you apply it
at some later time and don't want to resolve them, feel free to just
drop the changes to the conflicting files. I'll notice and followup at a
later time then. Or ask me for a fixed resend. (Having said that, I
recommend b4 am -3 + git am -3 which should resolve most conflicts just
fine.)

Best regards
Uwe

 drivers/memory/brcmstb_dpfe.c            | 2 +-
 drivers/memory/brcmstb_memc.c            | 2 +-
 drivers/memory/emif.c                    | 2 +-
 drivers/memory/fsl-corenet-cf.c          | 2 +-
 drivers/memory/fsl_ifc.c                 | 2 +-
 drivers/memory/jz4780-nemc.c             | 2 +-
 drivers/memory/mtk-smi.c                 | 4 ++--
 drivers/memory/omap-gpmc.c               | 2 +-
 drivers/memory/renesas-rpc-if.c          | 6 +++---
 drivers/memory/samsung/exynos5422-dmc.c  | 6 +++---
 drivers/memory/stm32-fmc2-ebi.c          | 6 +++---
 drivers/memory/tegra/tegra186-emc.c      | 2 +-
 drivers/memory/tegra/tegra210-emc-core.c | 2 +-
 drivers/memory/ti-emif-pm.c              | 2 +-
 14 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 5028467b2dc9..08d9e05b1b33 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -934,7 +934,7 @@ static struct platform_driver brcmstb_dpfe_driver = {
 		.of_match_table = brcmstb_dpfe_of_match,
 	},
 	.probe = brcmstb_dpfe_probe,
-	.remove_new = brcmstb_dpfe_remove,
+	.remove = brcmstb_dpfe_remove,
 	.resume = brcmstb_dpfe_resume,
 };
 
diff --git a/drivers/memory/brcmstb_memc.c b/drivers/memory/brcmstb_memc.c
index 4f17a93aa028..c87b37e2c1f0 100644
--- a/drivers/memory/brcmstb_memc.c
+++ b/drivers/memory/brcmstb_memc.c
@@ -283,7 +283,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(brcmstb_memc_pm_ops, brcmstb_memc_suspend,
 
 static struct platform_driver brcmstb_memc_driver = {
 	.probe = brcmstb_memc_probe,
-	.remove_new = brcmstb_memc_remove,
+	.remove = brcmstb_memc_remove,
 	.driver = {
 		.name		= "brcmstb_memc",
 		.of_match_table	= brcmstb_memc_of_match,
diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 99eb7d1baa5f..2e1ecae9e959 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1159,7 +1159,7 @@ MODULE_DEVICE_TABLE(of, emif_of_match);
 
 static struct platform_driver emif_driver = {
 	.probe		= emif_probe,
-	.remove_new	= emif_remove,
+	.remove		= emif_remove,
 	.shutdown	= emif_shutdown,
 	.driver = {
 		.name = "emif",
diff --git a/drivers/memory/fsl-corenet-cf.c b/drivers/memory/fsl-corenet-cf.c
index f47d05f7c5c5..ecd6c1955153 100644
--- a/drivers/memory/fsl-corenet-cf.c
+++ b/drivers/memory/fsl-corenet-cf.c
@@ -249,7 +249,7 @@ static struct platform_driver ccf_driver = {
 		.of_match_table = ccf_matches,
 	},
 	.probe = ccf_probe,
-	.remove_new = ccf_remove,
+	.remove = ccf_remove,
 };
 
 module_platform_driver(ccf_driver);
diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index 15e919c24f81..27e041178c09 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -316,7 +316,7 @@ static struct platform_driver fsl_ifc_ctrl_driver = {
 		.of_match_table = fsl_ifc_match,
 	},
 	.probe       = fsl_ifc_ctrl_probe,
-	.remove_new  = fsl_ifc_ctrl_remove,
+	.remove      = fsl_ifc_ctrl_remove,
 };
 
 static int __init fsl_ifc_init(void)
diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
index fb6db2ffe71b..1a8161514d03 100644
--- a/drivers/memory/jz4780-nemc.c
+++ b/drivers/memory/jz4780-nemc.c
@@ -407,7 +407,7 @@ static const struct of_device_id jz4780_nemc_dt_match[] = {
 
 static struct platform_driver jz4780_nemc_driver = {
 	.probe		= jz4780_nemc_probe,
-	.remove_new	= jz4780_nemc_remove,
+	.remove		= jz4780_nemc_remove,
 	.driver	= {
 		.name	= "jz4780-nemc",
 		.of_match_table = of_match_ptr(jz4780_nemc_dt_match),
diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 2bc034dff691..5710348f72f6 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -616,7 +616,7 @@ static const struct dev_pm_ops smi_larb_pm_ops = {
 
 static struct platform_driver mtk_smi_larb_driver = {
 	.probe	= mtk_smi_larb_probe,
-	.remove_new = mtk_smi_larb_remove,
+	.remove = mtk_smi_larb_remove,
 	.driver	= {
 		.name = "mtk-smi-larb",
 		.of_match_table = mtk_smi_larb_of_ids,
@@ -838,7 +838,7 @@ static const struct dev_pm_ops smi_common_pm_ops = {
 
 static struct platform_driver mtk_smi_common_driver = {
 	.probe	= mtk_smi_common_probe,
-	.remove_new = mtk_smi_common_remove,
+	.remove = mtk_smi_common_remove,
 	.driver	= {
 		.name = "mtk-smi-common",
 		.of_match_table = mtk_smi_common_of_ids,
diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index c8a0d82f9c27..50eb9f49512b 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2743,7 +2743,7 @@ MODULE_DEVICE_TABLE(of, gpmc_dt_ids);
 
 static struct platform_driver gpmc_driver = {
 	.probe		= gpmc_probe,
-	.remove_new	= gpmc_remove,
+	.remove		= gpmc_remove,
 	.driver		= {
 		.name	= DEVICE_NAME,
 		.of_match_table = of_match_ptr(gpmc_dt_ids),
diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 7fbd36fa1a1b..55209ca43a96 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -794,10 +794,10 @@ static const struct of_device_id rpcif_of_match[] = {
 MODULE_DEVICE_TABLE(of, rpcif_of_match);
 
 static struct platform_driver rpcif_driver = {
-	.probe	= rpcif_probe,
-	.remove_new = rpcif_remove,
+	.probe = rpcif_probe,
+	.remove = rpcif_remove,
 	.driver = {
-		.name =	"rpc-if",
+		.name = "rpc-if",
 		.of_match_table = rpcif_of_match,
 	},
 };
diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 7d80322754fa..dfc5ee54a9b7 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1570,10 +1570,10 @@ static const struct of_device_id exynos5_dmc_of_match[] = {
 MODULE_DEVICE_TABLE(of, exynos5_dmc_of_match);
 
 static struct platform_driver exynos5_dmc_platdrv = {
-	.probe	= exynos5_dmc_probe,
-	.remove_new = exynos5_dmc_remove,
+	.probe = exynos5_dmc_probe,
+	.remove = exynos5_dmc_remove,
 	.driver = {
-		.name	= "exynos5-dmc",
+		.name = "exynos5-dmc",
 		.of_match_table = exynos5_dmc_of_match,
 	},
 };
diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
index 566c225f71c0..2f1e2d7d54b5 100644
--- a/drivers/memory/stm32-fmc2-ebi.c
+++ b/drivers/memory/stm32-fmc2-ebi.c
@@ -1814,9 +1814,9 @@ static const struct of_device_id stm32_fmc2_ebi_match[] = {
 MODULE_DEVICE_TABLE(of, stm32_fmc2_ebi_match);
 
 static struct platform_driver stm32_fmc2_ebi_driver = {
-	.probe	= stm32_fmc2_ebi_probe,
-	.remove_new = stm32_fmc2_ebi_remove,
-	.driver	= {
+	.probe = stm32_fmc2_ebi_probe,
+	.remove = stm32_fmc2_ebi_remove,
+	.driver = {
 		.name = "stm32_fmc2_ebi",
 		.of_match_table = stm32_fmc2_ebi_match,
 		.pm = &stm32_fmc2_ebi_pm_ops,
diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 33d67d251719..bc807d7fcd4e 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -406,7 +406,7 @@ static struct platform_driver tegra186_emc_driver = {
 		.sync_state = icc_sync_state,
 	},
 	.probe = tegra186_emc_probe,
-	.remove_new = tegra186_emc_remove,
+	.remove = tegra186_emc_remove,
 };
 module_platform_driver(tegra186_emc_driver);
 
diff --git a/drivers/memory/tegra/tegra210-emc-core.c b/drivers/memory/tegra/tegra210-emc-core.c
index 78ca1d6c0977..2d5d8245a1d3 100644
--- a/drivers/memory/tegra/tegra210-emc-core.c
+++ b/drivers/memory/tegra/tegra210-emc-core.c
@@ -2051,7 +2051,7 @@ static struct platform_driver tegra210_emc_driver = {
 		.pm = &tegra210_emc_pm_ops,
 	},
 	.probe = tegra210_emc_probe,
-	.remove_new = tegra210_emc_remove,
+	.remove = tegra210_emc_remove,
 };
 
 module_platform_driver(tegra210_emc_driver);
diff --git a/drivers/memory/ti-emif-pm.c b/drivers/memory/ti-emif-pm.c
index 592f70e9c8e5..df362ecc59e9 100644
--- a/drivers/memory/ti-emif-pm.c
+++ b/drivers/memory/ti-emif-pm.c
@@ -330,7 +330,7 @@ static const struct dev_pm_ops ti_emif_pm_ops = {
 
 static struct platform_driver ti_emif_driver = {
 	.probe = ti_emif_probe,
-	.remove_new = ti_emif_remove,
+	.remove = ti_emif_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = ti_emif_of_match,

base-commit: 5b913f5d7d7fe0f567dea8605f21da6eaa1735fb
-- 
2.45.2


