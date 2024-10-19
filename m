Return-Path: <linux-pm+bounces-16041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1940A9A4FDE
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 18:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725681F25EC6
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 16:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA7E18455B;
	Sat, 19 Oct 2024 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Sm26cgir"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4E6256F
	for <linux-pm@vger.kernel.org>; Sat, 19 Oct 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729355666; cv=none; b=LmGTZW0ab+JW3DC9WET0XN5RZ1rMB5zoH1YDacIZ2da0h80Xupx538ElPThelkz8YvqgEmrO+lpEAc1FpX3Hs705fRucMVUA4oW1G3IwO0ve26iGpU8V2JWkeyiiwaQsoP1TN9phVnjbwIo4dVPS+PcfyOVefilJSJnnMr4FCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729355666; c=relaxed/simple;
	bh=aRRn7FOMR1wqi0jWKcBBbLTNqyFCac2Z0qIc/Xra310=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SyTu5FxeBq2155D/9Hq9rSOhiTwzT0BRfxiRCz4n6Vv21pMH4Ju4WZuSHtDqovA1xBLNPqtZ44EFky986uNmY0DTvRoeEe8eaqpJUZmCCraJYMermYlmdFXXHsK714C2wzgjI/+wdVW1PbbyddYfWt2uPqXNusAuaw7RdBt6nzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Sm26cgir; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a991fedbd04so207537066b.3
        for <linux-pm@vger.kernel.org>; Sat, 19 Oct 2024 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729355661; x=1729960461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hg9iFzNh4P99a8tg4t9/uhZ4l+VvPZHWO5Yn+n21E8w=;
        b=Sm26cgirH/IkQ774VL2eBFgHYcQvq8wCvW6xK2DIamCivRkzkeoqQrAnX5YdY87JiW
         vl2nK20ovXFQjKRMtOSUbdQ+4snucRRiAnrZrswe8CD570m2SGGlcLYS8iGNAJe3vaoV
         giHn9dGPPoHkhP9rY1lu+rI/W4ttsZY2WHw+OYDTR4rNelYkGOep+CKTSI8bV7NtHnR5
         RzO/OXVO9roNl6sh/wg/+1HCBa0p+sOySPfVldVgsC73Apxldq9ACe3FjVIPRQQDCpMI
         1IExeYb4PLY2wt49vjdHzxZuzJ8hdG87Tp2NqAIJ+8IJ6DgqF7wKkmKAJ4OFzolje6b5
         bk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729355661; x=1729960461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hg9iFzNh4P99a8tg4t9/uhZ4l+VvPZHWO5Yn+n21E8w=;
        b=N7yudbil+lcOmjXchYJCHGkDxppt0msMV09eJkdYZoXa4UrYm6Kex921chHjkEcELB
         H6Avv+H4Aler8aaoOB/adeHk9KR82CCJwDSHuymBsYV+P7/KRHBJ7hXn2Bi7QyOl0LJJ
         MkhSeWtWBZPF0NZb6Y7Ibuki2sCL5mJgfo+bxYpNJ25nOG8ud9HByyX0VI0K4vud39wR
         1xP3W7fD5sYzWFiQlHFoXQa3CeVw6svA0QbwrVG7h2M5RJZdtea8qQFxfccDmuXERdn9
         Z6FZE6WHb6CIEJcMbbZHbBWZ2plnD3L70DxweSV1jgwYyeV+FMP7nyW3yn5EIDuD3K4g
         /Hmw==
X-Forwarded-Encrypted: i=1; AJvYcCU1ICJsI9GgCGPPqWt7SoTCUsGdQEmZvu7Du3dYyrHe/YAyWnO57wWNo3T15xmUrM70GKaBHL+dJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvHALPWRYeJOipfipjKrgChj6nPrnp/BTvzw93TLOpg56Q8xjY
	5tczbkNku81AoTb6aQYJU4eZcJRZ5pMaKeiu5KD7KZ5J0gLk2yFm8TbwxUBSCwA=
X-Google-Smtp-Source: AGHT+IFVnHFrtbgeVMnY2xoNIP2JyFdVPf8LyAd2gWYoQSjniYG+Dx+/TWuBPPEwlMn4i5Xc2LOXrg==
X-Received: by 2002:a05:6402:2747:b0:5c9:4b8c:b92e with SMTP id 4fb4d7f45d1cf-5ca0ae814bbmr6651756a12.26.1729355660668;
        Sat, 19 Oct 2024 09:34:20 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ca0b0ff773sm1974195a12.92.2024.10.19.09.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 09:34:20 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH] thermal: Switch back to struct platform_driver::remove()
Date: Sat, 19 Oct 2024 18:34:11 +0200
Message-ID: <20241019163412.304422-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=20834; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=aRRn7FOMR1wqi0jWKcBBbLTNqyFCac2Z0qIc/Xra310=; b=kA0DAAoBj4D7WH0S/k4ByyZiAGcT34TIzQ7I9CVTWtYuyJGT2d/LGviiRBCXYiYflzG98T5N8 IkBMwQAAQoAHRYhBD+BrGk6eh5Zia3+04+A+1h9Ev5OBQJnE9+EAAoJEI+A+1h9Ev5O2EIIAK3x TERUTK4p5SriC6CvLTy21c7J+hc3iNYkeR0UldpVyCxZ9zGldbNiq10U/eNrmqkI+2bsBoUrxox 15xY7Z2snDyyq9uRZqq3gS/4ZKpwAqb3lJK3/3zzj3hDW6/EqseIet/RYd6yT9exxeBmIA53v6q E2yKidy9NOS98LPRz+TwWfCN0vFNPe6cNk/TAM8/mf/7REe6ROepLzhwhaliZ28AKbY7acX+sKO coUfv0ajYjClsxECeyqR3vWtBQlH2j7iLvreHwqd4aKidD7znwssVBqy9snt31Q0u+ceWL05qKa K92o7k/0gEd9qfUT/tc+dIx3Ffj5IBaa3Jh8UXg=
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/thermalto use .remove(), with
the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

On the way make a few whitespace changes to make indention consistent.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

given the simplicity of the individual changes I do this all in a single
patch. I you don't agree, please tell and I will happily split it.

It's based on Friday's next, feel free to drop changes that result in a
conflict when you come around to apply this. I'll care for the fallout
at a later time then. (Having said that, if you use b4 am -3 and git am
-3, there should be hardly any conflict.)

Note I didn't Cc: all the individual driver maintainers to not trigger
sending limits and spam filters.

Best regards
Uwe

 drivers/thermal/amlogic_thermal.c                       | 2 +-
 drivers/thermal/armada_thermal.c                        | 2 +-
 drivers/thermal/broadcom/bcm2835_thermal.c              | 2 +-
 drivers/thermal/broadcom/ns-thermal.c                   | 2 +-
 drivers/thermal/da9062-thermal.c                        | 6 +++---
 drivers/thermal/dove_thermal.c                          | 2 +-
 drivers/thermal/hisi_thermal.c                          | 4 ++--
 drivers/thermal/imx8mm_thermal.c                        | 2 +-
 drivers/thermal/imx_thermal.c                           | 2 +-
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 2 +-
 drivers/thermal/intel/int340x_thermal/int3401_thermal.c | 2 +-
 drivers/thermal/intel/int340x_thermal/int3402_thermal.c | 2 +-
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 2 +-
 drivers/thermal/intel/int340x_thermal/int3406_thermal.c | 2 +-
 drivers/thermal/k3_bandgap.c                            | 2 +-
 drivers/thermal/k3_j72xx_bandgap.c                      | 2 +-
 drivers/thermal/kirkwood_thermal.c                      | 2 +-
 drivers/thermal/mediatek/lvts_thermal.c                 | 2 +-
 drivers/thermal/qcom/tsens.c                            | 2 +-
 drivers/thermal/renesas/rcar_gen3_thermal.c             | 2 +-
 drivers/thermal/renesas/rcar_thermal.c                  | 2 +-
 drivers/thermal/renesas/rzg2l_thermal.c                 | 2 +-
 drivers/thermal/rockchip_thermal.c                      | 2 +-
 drivers/thermal/samsung/exynos_tmu.c                    | 2 +-
 drivers/thermal/spear_thermal.c                         | 2 +-
 drivers/thermal/sprd_thermal.c                          | 2 +-
 drivers/thermal/st/st_thermal_memmap.c                  | 2 +-
 drivers/thermal/st/stm_thermal.c                        | 2 +-
 drivers/thermal/tegra/soctherm.c                        | 2 +-
 drivers/thermal/tegra/tegra-bpmp-thermal.c              | 2 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c             | 2 +-
 drivers/thermal/uniphier_thermal.c                      | 2 +-
 32 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index cd4776aa805e..3c5f7dbddf2c 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -333,7 +333,7 @@ static struct platform_driver amlogic_thermal_driver = {
 		.of_match_table = of_amlogic_thermal_match,
 	},
 	.probe = amlogic_thermal_probe,
-	.remove_new = amlogic_thermal_remove,
+	.remove = amlogic_thermal_remove,
 };
 
 module_platform_driver(amlogic_thermal_driver);
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index fdcb077cfd54..9bff21068721 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -970,7 +970,7 @@ static void armada_thermal_exit(struct platform_device *pdev)
 
 static struct platform_driver armada_thermal_driver = {
 	.probe = armada_thermal_probe,
-	.remove_new = armada_thermal_exit,
+	.remove = armada_thermal_exit,
 	.driver = {
 		.name = "armada_thermal",
 		.of_match_table = armada_thermal_id_table,
diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 7d61493082b5..7fbba2233c4c 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -268,7 +268,7 @@ static void bcm2835_thermal_remove(struct platform_device *pdev)
 
 static struct platform_driver bcm2835_thermal_driver = {
 	.probe = bcm2835_thermal_probe,
-	.remove_new = bcm2835_thermal_remove,
+	.remove = bcm2835_thermal_remove,
 	.driver = {
 		.name = "bcm2835_thermal",
 		.of_match_table = bcm2835_thermal_of_match_table,
diff --git a/drivers/thermal/broadcom/ns-thermal.c b/drivers/thermal/broadcom/ns-thermal.c
index 5eaf79c490f0..8b5b32f749ee 100644
--- a/drivers/thermal/broadcom/ns-thermal.c
+++ b/drivers/thermal/broadcom/ns-thermal.c
@@ -80,7 +80,7 @@ MODULE_DEVICE_TABLE(of, ns_thermal_of_match);
 
 static struct platform_driver ns_thermal_driver = {
 	.probe		= ns_thermal_probe,
-	.remove_new	= ns_thermal_remove,
+	.remove		= ns_thermal_remove,
 	.driver = {
 		.name = "ns-thermal",
 		.of_match_table = ns_thermal_of_match,
diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index a27aff88cd96..2077e85ef5ca 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -250,10 +250,10 @@ static void da9062_thermal_remove(struct platform_device *pdev)
 
 static struct platform_driver da9062_thermal_driver = {
 	.probe	= da9062_thermal_probe,
-	.remove_new = da9062_thermal_remove,
+	.remove	= da9062_thermal_remove,
 	.driver	= {
-		.name	= "da9062-thermal",
-		.of_match_table = da9062_compatible_reg_id_table,
+		.name		= "da9062-thermal",
+		.of_match_table	= da9062_compatible_reg_id_table,
 	},
 };
 
diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index ac30de3c0a5f..f9157a47156b 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -170,7 +170,7 @@ MODULE_DEVICE_TABLE(of, dove_thermal_id_table);
 
 static struct platform_driver dove_thermal_driver = {
 	.probe = dove_thermal_probe,
-	.remove_new = dove_thermal_exit,
+	.remove = dove_thermal_exit,
 	.driver = {
 		.name = "dove_thermal",
 		.of_match_table = dove_thermal_id_table,
diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index f1fe0f8ab04f..7e918bd3f100 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -637,10 +637,10 @@ static struct platform_driver hisi_thermal_driver = {
 	.driver = {
 		.name		= "hisi_thermal",
 		.pm		= pm_sleep_ptr(&hisi_thermal_pm_ops),
-		.of_match_table = of_hisi_thermal_match,
+		.of_match_table	= of_hisi_thermal_match,
 	},
 	.probe	= hisi_thermal_probe,
-	.remove_new = hisi_thermal_remove,
+	.remove	= hisi_thermal_remove,
 };
 
 module_platform_driver(hisi_thermal_driver);
diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index d74ed6ce2974..719d71f5b235 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -399,7 +399,7 @@ static struct platform_driver imx8mm_tmu = {
 		.of_match_table = imx8mm_tmu_table,
 	},
 	.probe = imx8mm_tmu_probe,
-	.remove_new = imx8mm_tmu_remove,
+	.remove = imx8mm_tmu_remove,
 };
 module_platform_driver(imx8mm_tmu);
 
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index b8e85a405351..bab52e6b3b15 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -861,7 +861,7 @@ static struct platform_driver imx_thermal = {
 		.of_match_table = of_imx_thermal_match,
 	},
 	.probe		= imx_thermal_probe,
-	.remove_new	= imx_thermal_remove,
+	.remove		= imx_thermal_remove,
 };
 module_platform_driver(imx_thermal);
 
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index b0c0f0ffdcb0..b2fc02c3a767 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -707,7 +707,7 @@ MODULE_DEVICE_TABLE(acpi, int3400_thermal_match);
 
 static struct platform_driver int3400_thermal_driver = {
 	.probe = int3400_thermal_probe,
-	.remove_new = int3400_thermal_remove,
+	.remove = int3400_thermal_remove,
 	.driver = {
 		   .name = "int3400 thermal",
 		   .acpi_match_table = ACPI_PTR(int3400_thermal_match),
diff --git a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
index 193645a73861..96d6277a5a8c 100644
--- a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
@@ -60,7 +60,7 @@ static SIMPLE_DEV_PM_OPS(int3401_proc_thermal_pm, int3401_thermal_suspend,
 
 static struct platform_driver int3401_driver = {
 	.probe = int3401_add,
-	.remove_new = int3401_remove,
+	.remove = int3401_remove,
 	.driver = {
 		.name = "int3401 thermal",
 		.acpi_match_table = int3401_device_ids,
diff --git a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
index ab8bfb5a3946..543b03960e99 100644
--- a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
@@ -89,7 +89,7 @@ MODULE_DEVICE_TABLE(acpi, int3402_thermal_match);
 
 static struct platform_driver int3402_thermal_driver = {
 	.probe = int3402_thermal_probe,
-	.remove_new = int3402_thermal_remove,
+	.remove = int3402_thermal_remove,
 	.driver = {
 		   .name = "int3402 thermal",
 		   .acpi_match_table = int3402_thermal_match,
diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index c094a422ded3..04aa0afb3b1d 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -281,7 +281,7 @@ MODULE_DEVICE_TABLE(acpi, int3403_device_ids);
 
 static struct platform_driver int3403_driver = {
 	.probe = int3403_add,
-	.remove_new = int3403_remove,
+	.remove = int3403_remove,
 	.driver = {
 		.name = "int3403 thermal",
 		.acpi_match_table = int3403_device_ids,
diff --git a/drivers/thermal/intel/int340x_thermal/int3406_thermal.c b/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
index 1c266493c1aa..e21fcbccf4ba 100644
--- a/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
@@ -195,7 +195,7 @@ MODULE_DEVICE_TABLE(acpi, int3406_thermal_match);
 
 static struct platform_driver int3406_thermal_driver = {
 	.probe = int3406_thermal_probe,
-	.remove_new = int3406_thermal_remove,
+	.remove = int3406_thermal_remove,
 	.driver = {
 		   .name = "int3406 thermal",
 		   .acpi_match_table = int3406_thermal_match,
diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 2a703770fc91..678d6ed711b5 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -250,7 +250,7 @@ MODULE_DEVICE_TABLE(of, of_k3_bandgap_match);
 
 static struct platform_driver k3_bandgap_sensor_driver = {
 	.probe = k3_bandgap_probe,
-	.remove_new = k3_bandgap_remove,
+	.remove = k3_bandgap_remove,
 	.driver = {
 		.name = "k3-soc-thermal",
 		.of_match_table	= of_k3_bandgap_match,
diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 9bc279ac131a..ccd42db97177 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -594,7 +594,7 @@ MODULE_DEVICE_TABLE(of, of_k3_j72xx_bandgap_match);
 
 static struct platform_driver k3_j72xx_bandgap_sensor_driver = {
 	.probe = k3_j72xx_bandgap_probe,
-	.remove_new = k3_j72xx_bandgap_remove,
+	.remove = k3_j72xx_bandgap_remove,
 	.driver = {
 		.name = "k3-j72xx-soc-thermal",
 		.of_match_table	= of_k3_j72xx_bandgap_match,
diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
index a18158ebe65f..7c2265231668 100644
--- a/drivers/thermal/kirkwood_thermal.c
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -102,7 +102,7 @@ MODULE_DEVICE_TABLE(of, kirkwood_thermal_id_table);
 
 static struct platform_driver kirkwood_thermal_driver = {
 	.probe = kirkwood_thermal_probe,
-	.remove_new = kirkwood_thermal_exit,
+	.remove = kirkwood_thermal_exit,
 	.driver = {
 		.name = "kirkwood_thermal",
 		.of_match_table = kirkwood_thermal_id_table,
diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 1997e91bb3be..292ea2e0a617 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1788,7 +1788,7 @@ static const struct dev_pm_ops lvts_pm_ops = {
 
 static struct platform_driver lvts_driver = {
 	.probe = lvts_probe,
-	.remove_new = lvts_remove,
+	.remove = lvts_remove,
 	.driver = {
 		.name = "mtk-lvts-thermal",
 		.of_match_table = lvts_of_match,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 0b4421bf4785..3fbb0834af6c 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1360,7 +1360,7 @@ static void tsens_remove(struct platform_device *pdev)
 
 static struct platform_driver tsens_driver = {
 	.probe = tsens_probe,
-	.remove_new = tsens_remove,
+	.remove = tsens_remove,
 	.driver = {
 		.name = "qcom-tsens",
 		.pm	= &tsens_pm_ops,
diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 810f86677461..1ec169aeacfc 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -603,7 +603,7 @@ static struct platform_driver rcar_gen3_thermal_driver = {
 		.of_match_table = rcar_gen3_thermal_dt_ids,
 	},
 	.probe		= rcar_gen3_thermal_probe,
-	.remove_new	= rcar_gen3_thermal_remove,
+	.remove		= rcar_gen3_thermal_remove,
 };
 module_platform_driver(rcar_gen3_thermal_driver);
 
diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
index ddc8341e5c3f..00a66ee0a5b0 100644
--- a/drivers/thermal/renesas/rcar_thermal.c
+++ b/drivers/thermal/renesas/rcar_thermal.c
@@ -579,7 +579,7 @@ static struct platform_driver rcar_thermal_driver = {
 		.of_match_table = rcar_thermal_dt_ids,
 	},
 	.probe		= rcar_thermal_probe,
-	.remove_new	= rcar_thermal_remove,
+	.remove		= rcar_thermal_remove,
 };
 module_platform_driver(rcar_thermal_driver);
 
diff --git a/drivers/thermal/renesas/rzg2l_thermal.c b/drivers/thermal/renesas/rzg2l_thermal.c
index 0e1cb9045ee6..b588be628640 100644
--- a/drivers/thermal/renesas/rzg2l_thermal.c
+++ b/drivers/thermal/renesas/rzg2l_thermal.c
@@ -240,7 +240,7 @@ static struct platform_driver rzg2l_thermal_driver = {
 		.of_match_table = rzg2l_thermal_dt_ids,
 	},
 	.probe = rzg2l_thermal_probe,
-	.remove_new = rzg2l_thermal_remove,
+	.remove = rzg2l_thermal_remove,
 };
 module_platform_driver(rzg2l_thermal_driver);
 
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 086ed42dd16c..f551df48eef9 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1689,7 +1689,7 @@ static struct platform_driver rockchip_thermal_driver = {
 		.of_match_table = of_rockchip_thermal_match,
 	},
 	.probe = rockchip_thermal_probe,
-	.remove_new = rockchip_thermal_remove,
+	.remove = rockchip_thermal_remove,
 };
 
 module_platform_driver(rockchip_thermal_driver);
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 96cffb2c44ba..47a99b3c5395 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1164,7 +1164,7 @@ static struct platform_driver exynos_tmu_driver = {
 		.of_match_table = exynos_tmu_match,
 	},
 	.probe = exynos_tmu_probe,
-	.remove_new = exynos_tmu_remove,
+	.remove = exynos_tmu_remove,
 };
 
 module_platform_driver(exynos_tmu_driver);
diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 60a871998b07..bb96be947521 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -173,7 +173,7 @@ MODULE_DEVICE_TABLE(of, spear_thermal_id_table);
 
 static struct platform_driver spear_thermal_driver = {
 	.probe = spear_thermal_probe,
-	.remove_new = spear_thermal_exit,
+	.remove = spear_thermal_exit,
 	.driver = {
 		.name = "spear_thermal",
 		.pm = &spear_thermal_pm_ops,
diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index dfd1d529c410..e546067c9621 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -534,7 +534,7 @@ static const struct dev_pm_ops sprd_thermal_pm_ops = {
 
 static struct platform_driver sprd_thermal_driver = {
 	.probe = sprd_thm_probe,
-	.remove_new = sprd_thm_remove,
+	.remove = sprd_thm_remove,
 	.driver = {
 		.name = "sprd-thermal",
 		.pm = &sprd_thermal_pm_ops,
diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index 97493d2b2f49..8f76e50ea567 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -174,7 +174,7 @@ static struct platform_driver st_mmap_thermal_driver = {
 		.of_match_table = st_mmap_thermal_of_match,
 	},
 	.probe		= st_mmap_probe,
-	.remove_new	= st_mmap_remove,
+	.remove		= st_mmap_remove,
 };
 
 module_platform_driver(st_mmap_thermal_driver);
diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index ffd988600ed6..6e90eb9f414d 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -582,7 +582,7 @@ static struct platform_driver stm_thermal_driver = {
 		.of_match_table = stm_thermal_of_match,
 	},
 	.probe		= stm_thermal_probe,
-	.remove_new	= stm_thermal_remove,
+	.remove		= stm_thermal_remove,
 };
 module_platform_driver(stm_thermal_driver);
 
diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index a023c948afbd..6f1501e3fcc4 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -2269,7 +2269,7 @@ static SIMPLE_DEV_PM_OPS(tegra_soctherm_pm, soctherm_suspend, soctherm_resume);
 
 static struct platform_driver tegra_soctherm_driver = {
 	.probe = tegra_soctherm_probe,
-	.remove_new = tegra_soctherm_remove,
+	.remove = tegra_soctherm_remove,
 	.driver = {
 		.name = "tegra_soctherm",
 		.pm = &tegra_soctherm_pm,
diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c b/drivers/thermal/tegra/tegra-bpmp-thermal.c
index 72ce14c980cd..997d77ce30d9 100644
--- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
+++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
@@ -315,7 +315,7 @@ MODULE_DEVICE_TABLE(of, tegra_bpmp_thermal_of_match);
 
 static struct platform_driver tegra_bpmp_thermal_driver = {
 	.probe = tegra_bpmp_thermal_probe,
-	.remove_new = tegra_bpmp_thermal_remove,
+	.remove = tegra_bpmp_thermal_remove,
 	.driver = {
 		.name = "tegra-bpmp-thermal",
 		.of_match_table = tegra_bpmp_thermal_of_match,
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index caadfc61be93..ba43399d0b38 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1281,7 +1281,7 @@ MODULE_DEVICE_TABLE(of, of_ti_bandgap_match);
 
 static struct platform_driver ti_bandgap_sensor_driver = {
 	.probe = ti_bandgap_probe,
-	.remove_new = ti_bandgap_remove,
+	.remove = ti_bandgap_remove,
 	.driver = {
 			.name = "ti-soc-thermal",
 			.pm = DEV_PM_OPS,
diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 0325b7195136..1a04294effea 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -371,7 +371,7 @@ MODULE_DEVICE_TABLE(of, uniphier_tm_dt_ids);
 
 static struct platform_driver uniphier_tm_driver = {
 	.probe = uniphier_tm_probe,
-	.remove_new = uniphier_tm_remove,
+	.remove = uniphier_tm_remove,
 	.driver = {
 		.name = "uniphier-thermal",
 		.of_match_table = uniphier_tm_dt_ids,

base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
-- 
2.45.2

