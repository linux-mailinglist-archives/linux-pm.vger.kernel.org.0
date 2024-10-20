Return-Path: <linux-pm+bounces-16052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3470B9A54C9
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2024 17:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543351C20955
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2024 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E65719307F;
	Sun, 20 Oct 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zOpVFwKU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F71DA21
	for <linux-pm@vger.kernel.org>; Sun, 20 Oct 2024 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729438767; cv=none; b=JprS+Egz5slSKcfuRqDcCzsDpU6/5/tNFYfiuh2D2SWJv6b30GcO/uRox/8dNbmELlAmbTZWC49Efaige28B2gbbzfD98ZsmhQXJfxJ2pc6aXFbCDJqzkPm28lD3Us9KW9nY+RJXo1Cxz5aWDDFbP9E4Xwz0ahzykJzTnhzR4kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729438767; c=relaxed/simple;
	bh=AsKy/L1PudWhG9mNpiuUsiQuT1OOmzitYU+eHLiCEQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LvKXl64L4wQ9xz7PikcwQCsYRil1f3Ogp9Zi5b1apfeasWTMCpDjwOtHTNsXOCQjRuYQ78BtBZKC7bj2+bXEfv0KMLNvTuGGJ+CSY9+C+/KMn77hkXwCwDgJETjpqkZq0F2YKRtRQj90cJhnPpnTCjWDAfsQqb/cmVfSo9ZDBsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zOpVFwKU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso418216766b.3
        for <linux-pm@vger.kernel.org>; Sun, 20 Oct 2024 08:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729438762; x=1730043562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lANbPfK22UcoybL/7HwHZKKPo3UwXjPpMJefJFL0vpA=;
        b=zOpVFwKUcq+dSHjOPxeBtqbAxrF3cagjHLnWl8pPO0YsddgoNWjmiMJC9gZJY4fXA+
         SegLDZNkPVs3mKG9GgNxpm2UQG1gJONg4owceBT+jpqLv2b04QzjoRltP3eBkN20foGo
         OCGqh2pYvN7BPRS43TaNEUBTGXPELfuIH4d0Aoia0TQwxPWDlFkjoegh0c3oYMMomvNB
         C9FTK0E4iB9254MXrapAoYkTzdkDEq3e5O09G6EHJw36OFi69GhOiYG8+bHo8aiClQ+z
         Xj2tpGjgfAClTezzbdLskgd6Jo3qwvOtMCEFj2fwX9WsTeOeUVtxHKAc4OqEKYpQ2CU5
         u2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729438762; x=1730043562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lANbPfK22UcoybL/7HwHZKKPo3UwXjPpMJefJFL0vpA=;
        b=etr/T9JjQcSUCF77XRDGCpF5Ky4n70rqCECpZ3rZYL3Y6xXQ3XOYbb0HI88s+9wsAv
         lNhzTHfDCdapFmi1lV8lLI9hGZKMZy1pF4YblPsvlxXX+v49FEsIpDU4oznOFWWX86y9
         IBDSMymo+Ov9dmBrBiHLS0YEdDsrvsnwdw9cIV72uTL5Va0rWIT0qRwGR+6BbFryY0I1
         Qb4DTSu4j+54MwiJXrdHSAA0zBmhQfCiB4YIj297KLj8g+aXI1vPG8GSBoF3TOlxEGWY
         c2AztHCx0eI1ft4hUBtquGYVZzlIVjpXc7/2ZX2tgQYzuWAGHRkEyiEZYE/qHrBWXC3r
         TNlQ==
X-Gm-Message-State: AOJu0YzccRbChwYVpQDo0T2oIg6El3KnBbzEIyGkJPMCwsoChoeVbqk5
	U44YOOPec71rcfIM9I3tYAetPXy5eH/GkAv88Kevf+l4mZNQsdK098+1ExCDtZGZHMWodArIdkI
	P
X-Google-Smtp-Source: AGHT+IFdotcw85+UPzp3e5yRxItILakpa3teHHM2EMvkQ2v1bM3lIcft1JIUM40lND7U9LSpDGO9LA==
X-Received: by 2002:a17:907:2cc6:b0:a9a:1565:1051 with SMTP id a640c23a62f3a-a9a69969fbfmr927295466b.10.1729438761654;
        Sun, 20 Oct 2024 08:39:21 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:2fbe:bcb5:676d:98da])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d68f7sm101353866b.1.2024.10.20.08.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 08:39:21 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: Switch back to struct platform_driver::remove()
Date: Sun, 20 Oct 2024 17:39:10 +0200
Message-ID: <20241020153910.324096-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=12383; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=AsKy/L1PudWhG9mNpiuUsiQuT1OOmzitYU+eHLiCEQI=; b=owGbwMvMwMXY3/A7olbonx/jabUkhnRRFblEiTeyrz2VOG+/Tzk9S03xzH1Lxr7mn7OP8n6fU /aq/uf1TkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmUneb/X/Slx9yUY1+SZP3 GZ56pzBfzij1x7MC31pT/rnSS3sCG4XfZR7gCTwbqXhuQcfOipVZDDaxMmf//RQ2dIo/xM63VlR fnXfe8jkKbim8apXWgXo+evoKPR1SrsXiB6dNN5D00kqR0ZmQzLZE+Jh64jpha/NtFR4Fwc/Xp+ gZKi87FxPvVvgoUObmHG+/ilntyer77+7j/XZp7YSete+fnN2zlJGxrSY28uZm087MpeVTda+za 26YK2c7fYt4V85Ei8Izp4+wvGkTMWJ+c3jDXmbekq5F3VM3nFuv2TYzVMaQfXPXc0PVg7eO979t KZIx6o69khq+YW5yjnjaTQ6hVNYtXFcb57eLiBh2ztwKAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/cpufreq to use .remove(),
with the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

given the simplicity of the individual changes I do this all in a single
patch. I you don't agree, please tell and I will happily split it.

It's based on Friday's next. Feel free to drop changes that result in
a conflict when you come around to apply this. I'll care for the fallout
at a later time then. (Having said that, if you use b4 am -3 and git am
-3, there should be hardly any conflict.)

Note I didn't Cc: all the individual driver maintainers to not trigger
sending limits and spam filters.

Best regards
Uwe

 drivers/cpufreq/acpi-cpufreq.c         | 2 +-
 drivers/cpufreq/brcmstb-avs-cpufreq.c  | 2 +-
 drivers/cpufreq/cpufreq-dt.c           | 2 +-
 drivers/cpufreq/davinci-cpufreq.c      | 2 +-
 drivers/cpufreq/imx-cpufreq-dt.c       | 2 +-
 drivers/cpufreq/imx6q-cpufreq.c        | 2 +-
 drivers/cpufreq/kirkwood-cpufreq.c     | 2 +-
 drivers/cpufreq/loongson3_cpufreq.c    | 2 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c  | 2 +-
 drivers/cpufreq/omap-cpufreq.c         | 2 +-
 drivers/cpufreq/pcc-cpufreq.c          | 2 +-
 drivers/cpufreq/qcom-cpufreq-hw.c      | 2 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c   | 2 +-
 drivers/cpufreq/qoriq-cpufreq.c        | 2 +-
 drivers/cpufreq/raspberrypi-cpufreq.c  | 2 +-
 drivers/cpufreq/scpi-cpufreq.c         | 2 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 2 +-
 drivers/cpufreq/tegra186-cpufreq.c     | 2 +-
 drivers/cpufreq/tegra194-cpufreq.c     | 2 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c | 2 +-
 20 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 0f04feb6cafa..433eb597c2b8 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -1028,7 +1028,7 @@ static struct platform_driver acpi_cpufreq_platdrv = {
 	.driver = {
 		.name	= "acpi-cpufreq",
 	},
-	.remove_new	= acpi_cpufreq_remove,
+	.remove = acpi_cpufreq_remove,
 };
 
 static int __init acpi_cpufreq_init(void)
diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index ea8438550b49..5d03a295a085 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -777,7 +777,7 @@ static struct platform_driver brcm_avs_cpufreq_platdrv = {
 		.of_match_table = brcm_avs_cpufreq_match,
 	},
 	.probe		= brcm_avs_cpufreq_probe,
-	.remove_new	= brcm_avs_cpufreq_remove,
+	.remove		= brcm_avs_cpufreq_remove,
 };
 module_platform_driver(brcm_avs_cpufreq_platdrv);
 
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 983443396f8f..3a7c3372bda7 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -345,7 +345,7 @@ static struct platform_driver dt_cpufreq_platdrv = {
 		.name	= "cpufreq-dt",
 	},
 	.probe		= dt_cpufreq_probe,
-	.remove_new	= dt_cpufreq_remove,
+	.remove		= dt_cpufreq_remove,
 };
 module_platform_driver(dt_cpufreq_platdrv);
 
diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index 7d2754411d8c..8736be3a06ce 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -145,7 +145,7 @@ static struct platform_driver davinci_cpufreq_driver = {
 	.driver = {
 		.name	 = "cpufreq-davinci",
 	},
-	.remove_new = __exit_p(davinci_cpufreq_remove),
+	.remove = __exit_p(davinci_cpufreq_remove),
 };
 
 int __init davinci_cpufreq_init(void)
diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
index 577bb9e2f112..1492c92ffc1a 100644
--- a/drivers/cpufreq/imx-cpufreq-dt.c
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -183,7 +183,7 @@ static void imx_cpufreq_dt_remove(struct platform_device *pdev)
 
 static struct platform_driver imx_cpufreq_dt_driver = {
 	.probe = imx_cpufreq_dt_probe,
-	.remove_new = imx_cpufreq_dt_remove,
+	.remove = imx_cpufreq_dt_remove,
 	.driver = {
 		.name = "imx-cpufreq-dt",
 	},
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index c20d3ecc5a81..f3c99f378ad6 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -522,7 +522,7 @@ static struct platform_driver imx6q_cpufreq_platdrv = {
 		.name	= "imx6q-cpufreq",
 	},
 	.probe		= imx6q_cpufreq_probe,
-	.remove_new	= imx6q_cpufreq_remove,
+	.remove		= imx6q_cpufreq_remove,
 };
 module_platform_driver(imx6q_cpufreq_platdrv);
 
diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index fd20b986d1f2..312f2654d1d5 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -189,7 +189,7 @@ static void kirkwood_cpufreq_remove(struct platform_device *pdev)
 
 static struct platform_driver kirkwood_cpufreq_platform_driver = {
 	.probe = kirkwood_cpufreq_probe,
-	.remove_new = kirkwood_cpufreq_remove,
+	.remove = kirkwood_cpufreq_remove,
 	.driver = {
 		.name = "kirkwood-cpufreq",
 	},
diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
index 6b5e6798d9a2..61ebebf69455 100644
--- a/drivers/cpufreq/loongson3_cpufreq.c
+++ b/drivers/cpufreq/loongson3_cpufreq.c
@@ -386,7 +386,7 @@ static struct platform_driver loongson3_platform_driver = {
 	},
 	.id_table = cpufreq_id_table,
 	.probe = loongson3_cpufreq_probe,
-	.remove_new = loongson3_cpufreq_remove,
+	.remove = loongson3_cpufreq_remove,
 };
 module_platform_driver(loongson3_platform_driver);
 
diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 8925e096d5b9..f7db5f4ad306 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -344,7 +344,7 @@ MODULE_DEVICE_TABLE(of, mtk_cpufreq_hw_match);
 
 static struct platform_driver mtk_cpufreq_hw_driver = {
 	.probe = mtk_cpufreq_hw_driver_probe,
-	.remove_new = mtk_cpufreq_hw_driver_remove,
+	.remove = mtk_cpufreq_hw_driver_remove,
 	.driver = {
 		.name = "mtk-cpufreq-hw",
 		.of_match_table = mtk_cpufreq_hw_match,
diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index de8be0a8932d..106220c0fd11 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -188,7 +188,7 @@ static struct platform_driver omap_cpufreq_platdrv = {
 		.name	= "omap-cpufreq",
 	},
 	.probe		= omap_cpufreq_probe,
-	.remove_new	= omap_cpufreq_remove,
+	.remove		= omap_cpufreq_remove,
 };
 module_platform_driver(omap_cpufreq_platdrv);
 
diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 771efbf51a48..ac2e90a65f0c 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -615,7 +615,7 @@ static struct platform_driver pcc_cpufreq_platdrv = {
 	.driver = {
 		.name	= "pcc-cpufreq",
 	},
-	.remove_new	= pcc_cpufreq_remove,
+	.remove		= pcc_cpufreq_remove,
 };
 
 static int __init pcc_cpufreq_init(void)
diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 900d6844c43d..98129565acb8 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -736,7 +736,7 @@ static void qcom_cpufreq_hw_driver_remove(struct platform_device *pdev)
 
 static struct platform_driver qcom_cpufreq_hw_driver = {
 	.probe = qcom_cpufreq_hw_driver_probe,
-	.remove_new = qcom_cpufreq_hw_driver_remove,
+	.remove = qcom_cpufreq_hw_driver_remove,
 	.driver = {
 		.name = "qcom-cpufreq-hw",
 		.of_match_table = qcom_cpufreq_hw_match,
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index ae556d5ba231..3a8ed723a23e 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -578,7 +578,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(qcom_cpufreq_pm_ops, qcom_cpufreq_suspend, NULL)
 
 static struct platform_driver qcom_cpufreq_driver = {
 	.probe = qcom_cpufreq_probe,
-	.remove_new = qcom_cpufreq_remove,
+	.remove = qcom_cpufreq_remove,
 	.driver = {
 		.name = "qcom-cpufreq-nvmem",
 		.pm = pm_sleep_ptr(&qcom_cpufreq_pm_ops),
diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 3519bf34d397..a37ce051236c 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -296,7 +296,7 @@ static struct platform_driver qoriq_cpufreq_platform_driver = {
 		.name = "qoriq-cpufreq",
 	},
 	.probe = qoriq_cpufreq_probe,
-	.remove_new = qoriq_cpufreq_remove,
+	.remove = qoriq_cpufreq_remove,
 };
 module_platform_driver(qoriq_cpufreq_platform_driver);
 
diff --git a/drivers/cpufreq/raspberrypi-cpufreq.c b/drivers/cpufreq/raspberrypi-cpufreq.c
index e0705cc9a57d..5050932954e3 100644
--- a/drivers/cpufreq/raspberrypi-cpufreq.c
+++ b/drivers/cpufreq/raspberrypi-cpufreq.c
@@ -85,7 +85,7 @@ static struct platform_driver raspberrypi_cpufreq_driver = {
 		.name = "raspberrypi-cpufreq",
 	},
 	.probe          = raspberrypi_cpufreq_probe,
-	.remove_new	= raspberrypi_cpufreq_remove,
+	.remove		= raspberrypi_cpufreq_remove,
 };
 module_platform_driver(raspberrypi_cpufreq_driver);
 
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 8d73e6e8be2a..cd89c1b9832c 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -217,7 +217,7 @@ static struct platform_driver scpi_cpufreq_platdrv = {
 		.name	= "scpi-cpufreq",
 	},
 	.probe		= scpi_cpufreq_probe,
-	.remove_new	= scpi_cpufreq_remove,
+	.remove		= scpi_cpufreq_remove,
 };
 module_platform_driver(scpi_cpufreq_platdrv);
 
diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 293921acec93..352e1a69a85e 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -283,7 +283,7 @@ static void sun50i_cpufreq_nvmem_remove(struct platform_device *pdev)
 
 static struct platform_driver sun50i_cpufreq_driver = {
 	.probe = sun50i_cpufreq_nvmem_probe,
-	.remove_new = sun50i_cpufreq_nvmem_remove,
+	.remove = sun50i_cpufreq_nvmem_remove,
 	.driver = {
 		.name = "sun50i-cpufreq-nvmem",
 	},
diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 7b8fcfa55038..c7761eb99f3c 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -276,7 +276,7 @@ static struct platform_driver tegra186_cpufreq_platform_driver = {
 		.of_match_table = tegra186_cpufreq_of_match,
 	},
 	.probe = tegra186_cpufreq_probe,
-	.remove_new = tegra186_cpufreq_remove,
+	.remove = tegra186_cpufreq_remove,
 };
 module_platform_driver(tegra186_cpufreq_platform_driver);
 
diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 07ea7ed61b68..9055dd398e7f 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -818,7 +818,7 @@ static struct platform_driver tegra194_ccplex_driver = {
 		.of_match_table = tegra194_cpufreq_of_match,
 	},
 	.probe = tegra194_cpufreq_probe,
-	.remove_new = tegra194_cpufreq_remove,
+	.remove = tegra194_cpufreq_remove,
 };
 module_platform_driver(tegra194_ccplex_driver);
 
diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 3fadf536c429..0f86cdb7ec8a 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -565,7 +565,7 @@ static struct platform_driver ve_spc_cpufreq_platdrv = {
 		.name	= "vexpress-spc-cpufreq",
 	},
 	.probe		= ve_spc_cpufreq_probe,
-	.remove_new	= ve_spc_cpufreq_remove,
+	.remove		= ve_spc_cpufreq_remove,
 };
 module_platform_driver(ve_spc_cpufreq_platdrv);
 

base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
-- 
2.45.2


