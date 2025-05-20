Return-Path: <linux-pm+bounces-27414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DA0ABDDCF
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 16:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9484E5B74
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 14:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413C5248884;
	Tue, 20 May 2025 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrCF5EIl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F7424676B;
	Tue, 20 May 2025 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751835; cv=none; b=n64QVXYWx8Q3Y1FZq/GvteajCHkDY98i0WYck1B7PR8B5BVi8FhImklI7p88L+IZV5/Bpr/qxpLfQV38BmzFRi3q1I6bxFT4jhdbDa66s9WLALL05OoBn8+EZAEpyCxSNltxxX4WYaaFuDwslNnBmxPIKWWBJXbWpPxqvptQhtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751835; c=relaxed/simple;
	bh=NpHOvoz30jTvWxkTtOJChQtptjJCsdLKabk/jgfpkbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4l4nIiMAk7xsM7XXeWIqDP/q+SVdA0Jw2RUO2+PyuQd4j8T/aviXQS/ZVrigD+oCNqrKtJCr8xm2HKfIHl3oZfBqvyufsOFVgY3iV2/NJYsm0+fb23ChIOvLnHkH1LugWrd2CmDkF14nAnt/wMeyZiQ7bYGiRHqD5oSr/JLmrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrCF5EIl; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73972a54919so5354933b3a.3;
        Tue, 20 May 2025 07:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747751833; x=1748356633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dlhONOe8kjzHEf4GnqQkT/Of42VPEcZLuCZO1PPJVQo=;
        b=lrCF5EIl03bb/2PHIkrvQPih2dMBTOh7gWABvB6ijwgIi4JptE8Bw2/ovMXrQq6NS7
         OXsLFLBu+3uiAksh85acPSLJR8k3eevVn1F9DNYHhVTlnAvc0U8IjDj2uYKVP33CK7lt
         0MiC+KJNXZR0ujRTCRffSrdwt1qxb3/j6MKOkgFf+/mtqD/RRHg9JSenoaTW5tZfN7dL
         ObkWQbNeKKd/wm6kfv4/77hAKjgyqd0KvNRiV7fDOGxQaC3RYc1kBLADQzyWavI/FUtm
         I0sc/xA+dOQdbOohca5BGwL2MPebuQ55g2we2Fd86L3CqEpHkgT5X37oGJ2VgOOooIVD
         dqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747751833; x=1748356633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlhONOe8kjzHEf4GnqQkT/Of42VPEcZLuCZO1PPJVQo=;
        b=lAuxvYmPu3QY1XLJ1JaL0dTXMPWETp0/6kD1kSW1kMp6oEAzN+c2pWcxA9+X0qGAHr
         1gixDNRGZWQ+wHsSZghYyWyk820BEOSnPMs8Jtg5xjf4CPEBmhNykT7XedKH/btNeEkm
         xehpMiMYZqNC1R3RB8CON8ZL336lrawltgaYxFZLgNRWxlwdaqFUVoRnQvf8gxCku24C
         kcCDwJMqRLO349Aivly1vUrCdU2sRH3FUN35mEM2EuMQH773swNncglW5Ofrkgs0N7Md
         /wBcQSLspXzEh5HsaJqLN64QOkmOIaSiv+F4iw+aM6uHfyUNU+Kw25zU+u8ddqUqaTJu
         dRBw==
X-Forwarded-Encrypted: i=1; AJvYcCUNZk2v9cpHcCRLSqKApqif4U75PqSUaU/O2+CnHMRc0FLDY554uxhDMBs6fseMyXRYg3sIat/8Auo=@vger.kernel.org, AJvYcCUVzk2oYzYpuX9vDjTtD8ejNo/cyFbvVfKFTuxJUpaMakUOOSFrTsO7JAgJq4F7dHUggLcNuJzESfe/1OXj@vger.kernel.org, AJvYcCXMJUw1Vsg3tN2nqScL7R5pvCodlMfWAr6WwqiIO+9qYsPVK3hKrpsMZ3BAlkczDSXlYYFInfnKySrvLeL/@vger.kernel.org
X-Gm-Message-State: AOJu0YyX5WCzOsZSWz+g5xg0KxCYcng+42G9AdXmxXtXe2wZ14t51hbX
	bCkA0hQ/iR0cnVpc03x3QQol4DIMHIIgDF/SPDe18tV5G71hqEFU1DNJFoip3KIulRg=
X-Gm-Gg: ASbGnctRMwheAQr0gkEYuxw3m7IzieBiRnpeYCVh8dWbWBLxll2gyZ54wSPW/SADjam
	IwEnPMWtbN4MzjUNVp+0CaknZIpu3hq2fbILGXSQ9xkq9fJmo+yfFbWl9Q5nBvidQn7SXbFw+iG
	JnIF6952tC6lKbLKKP3Cf8ngowrX3qTK3f8EeUGaGci0WQvb/FE3/pZShWpZudvWsCnj1iWdiTw
	GARWp5ANt45AAmsTPhI44mpDehccc9jIu+rgFkgvYdSq/dtmU2WEQxhb0izFkAHHvfhG6wiNuJN
	nbIXyrB7yvI2k/T+W2J3QS39rC11ooKOkv89sNo5Yj72R08PHXxnwKY70HloIT0U7+2uGL+YPV0
	+oXpL9A==
X-Google-Smtp-Source: AGHT+IHngVBRNUsCcZBqTb3BZacBhWqB3R/WdnqBcxzYa5uxGHUQCKHrv0wnQqRH1cITiyhcuChqrA==
X-Received: by 2002:a05:6a21:1088:b0:215:e818:9fe5 with SMTP id adf61e73a8af0-216218e73fdmr26930787637.18.1747751832677;
        Tue, 20 May 2025 07:37:12 -0700 (PDT)
Received: from localhost.localdomain ([61.77.55.112])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-742a98a3347sm8251439b3a.172.2025.05.20.07.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:37:12 -0700 (PDT)
From: Taeyoung Kwon <xoduddk12345@gmail.com>
X-Google-Original-From: Taeyoung Kwon <Taeyoung.Kwon@telit.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Taeyoung Kwon <Taeyoung.Kwon@telit.com>
Subject: [PATCH] power: reset: qcom-pon: Rename variables to use generic naming
Date: Tue, 20 May 2025 14:35:50 +0000
Message-ID: <20250520143612.109567-1-Taeyoung.Kwon@telit.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As my company email adds a signature automatically,
I am sending this from my personal Gmail account

---
The qcom-pon driver was originally implemented for the PM8916 PMIC, and
as a result, several internal variable names still refer to 'pm8916'.
However, the driver has since been extended to support other PMICs as
well.

This patch renames those variables to use more generic and consistent
names, improving clarity and reducing confusion for non-PM8916 devices.

Signed-off-by: Taeyoung Kwon <Taeyoung.Kwon@telit.com>
---
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


