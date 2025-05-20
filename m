Return-Path: <linux-pm+bounces-27436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3E2ABE609
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 23:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8A94C827E
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 21:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298EB25C712;
	Tue, 20 May 2025 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQCqaKba"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908222528FD;
	Tue, 20 May 2025 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747776484; cv=none; b=C0UlApwgTZndAoHvY3Cp/pF3n+oTf0MHIQVnk68pQAzmFilAGSOqUzHM0zea4DUEVjlGEbD4gwXzZqQPmHxzRHuzElr3dtGMGmEDwb3Kcfhs9sUt1V8ZRBExgKjGP8hT3cB5cQWyodfL2F69ykTB45FotQxE4VfY8V4uRJ7Jz3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747776484; c=relaxed/simple;
	bh=hMECzyE2xMkzkh1rfutM7c9DeLea6c7ftfsOEzSyz1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OPZlGgtZYB0CtHW/bMXg/zRfLqP/TU/ZjmrASw3fRhe8DPILTlFPdB6uC28+zCeclzuP1lzwwTZp0nz1j6g4Tz+Wkwr6DtkPZBxhXSJfozu5Wu3tU8iFSYr6GgI1496H979jLesSZYQvmofUHSeevMqwcxoV6X69CcYzQNdX5z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQCqaKba; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c46611b6so4183261b3a.1;
        Tue, 20 May 2025 14:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747776482; x=1748381282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lXLFRnZ8EdNmlVUpXbUp5NFz+FyLzBFlDfsPfisaiLE=;
        b=WQCqaKbaVXeA8HJw8rTY61nA0UeDKJcGp9LNYMTRO6ZFM2H2moRf018MSfkmnCn63i
         Obpu/paaFm7kT3XlbFETvOUxawEfByMD7wgSSOw/sA6y4rxvnRii8Xr/s/spPN4B1DXe
         gIML6mKO7v6/edoeOiNs0uKxFn1cn3Gwi6zwr6ESHr7slnZi/LmwF6G8+9/sqwLz/L2d
         6TAcMuqG9YrlXA6bB1mliatIpki/klRw9o+JvqPvYRwBSx/jB66rH38Nh5KICAfV2QZ0
         YYSqgN1Q8Jp5CwuCv+e22MC2oWOi5RiEcI+n7nfEPcoo8A3pmYoQzxluG2zLx8+9TtMK
         yDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747776482; x=1748381282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXLFRnZ8EdNmlVUpXbUp5NFz+FyLzBFlDfsPfisaiLE=;
        b=ZPOmUUKbZjU95Tf63NqBuE+K1yhDzwJevFrAlHXZUVGslhNg+3u0hdE2AguH9DvGeH
         43Utn0MJwfKNsSUmeT0QXmLFndZmEiV5FIWqnmj1sLCQJ82/6/PWMuu4jRsv6WDiHfdl
         /Uo10CsdBnJ0mQFxT9CveuYf+w4fux5/oMGYkmCQhjVfrb+EAq5e0mjBishLc2IbiLiI
         MVDrV6vgeo1CAzOTFR+UrERW+8VaMM6ZqTWUenpaI9EzsnLD2gFbnD+5jD5NnRrCRUxI
         ycAxgapZsnJYbsHgWyzE32znhHn/6O2aCusTf3dKNuaBBN5Ar8dRCrvRyZP+VD3MhaBn
         Pb9A==
X-Forwarded-Encrypted: i=1; AJvYcCUHEJy8PE6Pzc4VWk410iJ6OJPXWf7QUFZP16psEPeiLzdJI+OxzQQdVEUmM+pBDCg5jCppcbkJDu0=@vger.kernel.org, AJvYcCWrnTIR5Y+UPzxRqQN6BLNHUKdIW7UwPcwroO3eXUsSaCx4IuR0DV/UtfJQ2DFUFpeJ9b8ibd4MZXAme7HL@vger.kernel.org, AJvYcCXZul4q7APTiUp0B15DTycgSDroe8T15tIJRy3fCx4ovwyRgfWeWjaE+lHh/czd+v3edfpyZo3MLzWrgFe7@vger.kernel.org
X-Gm-Message-State: AOJu0YxKEAPL8K6VurbUgpUa1CisZvYYE82OE9eLsEmxkCMRojse81wE
	YBIwmnrYidwdJy3QqrmokPmEFCbcGmn3IApicd+vvCgHeWVHBZrN0POaKBvXz6WlIQc=
X-Gm-Gg: ASbGnctvZ4hKMb3kMJM1ZmCJpqmsrg80geAPc69aBhzm7aCF/gFIaJOWlk46v1YZi15
	blGPNLE3x5Xj8PG+JzxO0MZypHJwaO7la3xWZw2iia0p8CDUKLXdGodWdQGC1VjvTJIxn9IvEZ4
	ioK1lwbvpOMNrC9PHQdlIgICBGnlmzGQgUkyVhHjQmcOGrNisjqnsqtvWhobeAYvdjddTHBF5CJ
	JaHPA1RWKAIVsxDAittqw8TdpDVmobWyCo2dhy6vas+fRJksZvDZUYPB9+2rdfgD49YRSdgkkRx
	5XxycGMWZcYyv6k6ukyvKxORGoXXEatDV3VzfC6N3F2gP9Yy5DPaNG/WjiGlqcAWIuSZwXomexO
	4GaZEJA==
X-Google-Smtp-Source: AGHT+IHwaRH9Cq1paBmaGV59yIT8QGOA1/WD1PNfV7WGQAbaupIks8dC+RhoWq1GByHre7/jtTkFVw==
X-Received: by 2002:a05:6a00:94a7:b0:740:91eb:c66 with SMTP id d2e1a72fcca58-742acc906b0mr25727847b3a.3.1747776481713;
        Tue, 20 May 2025 14:28:01 -0700 (PDT)
Received: from localhost.localdomain ([61.77.55.112])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-742a9829cddsm8702051b3a.97.2025.05.20.14.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 14:28:01 -0700 (PDT)
From: Taeyoung Kwon <xoduddk12345@gmail.com>
X-Google-Original-From: Taeyoung Kwon <Taeyoung.Kwon@telit.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Taeyoung Kwon <Taeyoung.Kwon@telit.com>
Subject: [PATCH v1] power: reset: qcom-pon: Rename variables to use generic naming
Date: Tue, 20 May 2025 21:27:20 +0000
Message-ID: <20250520212740.2729-1-Taeyoung.Kwon@telit.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The qcom-pon driver was originally implemented for the PM8916 PMIC, and
as a result, several internal variable names still refer to 'pm8916'.
However, the driver has since been extended to support other PMICs as
well.

This patch renames those variables to use more generic and consistent
names, improving clarity and reducing confusion for non-PM8916 devices.

Signed-off-by: Taeyoung Kwon <Taeyoung.Kwon@telit.com>
---
From: Taeyoung Kwon <Taeyoung.Kwon@telit.com>

Changes in v1:
- Moved explanation under the '---' line

Since my company email automatically adds a footer signature,
I’m sending this patch from my personal Gmail account.
Is this acceptable, or should I resend the patch using
an email that matches the Signed-off-by line?

 drivers/power/reset/qcom-pon.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 1344b361a475..7e108982a582 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -19,7 +19,7 @@
 
 #define NO_REASON_SHIFT			0
 
-struct pm8916_pon {
+struct qcom_pon {
 	struct device *dev;
 	struct regmap *regmap;
 	u32 baseaddr;
@@ -27,11 +27,11 @@ struct pm8916_pon {
 	long reason_shift;
 };
 
-static int pm8916_reboot_mode_write(struct reboot_mode_driver *reboot,
+static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
 				    unsigned int magic)
 {
-	struct pm8916_pon *pon = container_of
-			(reboot, struct pm8916_pon, reboot_mode);
+	struct qcom_pon *pon = container_of
+			(reboot, struct qcom_pon, reboot_mode);
 	int ret;
 
 	ret = regmap_update_bits(pon->regmap,
@@ -44,9 +44,9 @@ static int pm8916_reboot_mode_write(struct reboot_mode_driver *reboot,
 	return ret;
 }
 
-static int pm8916_pon_probe(struct platform_device *pdev)
+static int qcom_pon_probe(struct platform_device *pdev)
 {
-	struct pm8916_pon *pon;
+	struct qcom_pon *pon;
 	long reason_shift;
 	int error;
 
@@ -72,7 +72,7 @@ static int pm8916_pon_probe(struct platform_device *pdev)
 	if (reason_shift != NO_REASON_SHIFT) {
 		pon->reboot_mode.dev = &pdev->dev;
 		pon->reason_shift = reason_shift;
-		pon->reboot_mode.write = pm8916_reboot_mode_write;
+		pon->reboot_mode.write = qcom_pon_reboot_mode_write;
 		error = devm_reboot_mode_register(&pdev->dev, &pon->reboot_mode);
 		if (error) {
 			dev_err(&pdev->dev, "can't register reboot mode\n");
@@ -85,7 +85,7 @@ static int pm8916_pon_probe(struct platform_device *pdev)
 	return devm_of_platform_populate(&pdev->dev);
 }
 
-static const struct of_device_id pm8916_pon_id_table[] = {
+static const struct of_device_id qcom_pon_id_table[] = {
 	{ .compatible = "qcom,pm8916-pon", .data = (void *)GEN1_REASON_SHIFT },
 	{ .compatible = "qcom,pm8941-pon", .data = (void *)NO_REASON_SHIFT },
 	{ .compatible = "qcom,pms405-pon", .data = (void *)GEN1_REASON_SHIFT },
@@ -93,16 +93,16 @@ static const struct of_device_id pm8916_pon_id_table[] = {
 	{ .compatible = "qcom,pmk8350-pon", .data = (void *)GEN2_REASON_SHIFT },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, pm8916_pon_id_table);
+MODULE_DEVICE_TABLE(of, qcom_pon_id_table);
 
-static struct platform_driver pm8916_pon_driver = {
-	.probe = pm8916_pon_probe,
+static struct platform_driver qcom_pon_driver = {
+	.probe = qcom_pon_probe,
 	.driver = {
-		.name = "pm8916-pon",
-		.of_match_table = pm8916_pon_id_table,
+		.name = "qcom-pon",
+		.of_match_table = qcom_pon_id_table,
 	},
 };
-module_platform_driver(pm8916_pon_driver);
+module_platform_driver(qcom_pon_driver);
 
-MODULE_DESCRIPTION("pm8916 Power On driver");
+MODULE_DESCRIPTION("Qualcomm Power On driver");
 MODULE_LICENSE("GPL v2");
-- 
2.49.0


