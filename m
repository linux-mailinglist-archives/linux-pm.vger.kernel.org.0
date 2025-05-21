Return-Path: <linux-pm+bounces-27457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC48ABF5AB
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 15:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6273E178EA1
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 13:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1948A2676C4;
	Wed, 21 May 2025 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBM60d25"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A11263F4E;
	Wed, 21 May 2025 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833118; cv=none; b=CsYHlJUYcL2on/2/hraSHEiOoTIX8lg6enzBun9FUSHiq2C7bgQDKfYNmHPEWUOOjzNYNDC6aFBzM9goZpsolECPHP/gLLrD0u6zKjN80YGH88lK3C230fCQRWyLiRyq0nTHKD646+wgr8kxckpPXU6Sihcyj9bPZ9H8fso+Ywo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833118; c=relaxed/simple;
	bh=za+MdSYK+CoBXvIWPz3YA6uAitLEqcQq9VREikg77H8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NdaOMaDvgIIOppusa/TL422m76RvwEYxVIYfVvvVssDR+0Kt83RBeKslpuIcHHYkalt6SEdGYThxT9HxSCgoB4+XJyjTYTZvAZaMwYT6Lg6KGEpSA2Fn66YYvwKvY6onQX9DkMNV3AuL+nKR2wJzuI+qNkY/IpRbxai/zDzAwHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBM60d25; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so5653368b3a.0;
        Wed, 21 May 2025 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747833115; x=1748437915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O2qQPefvvV4ihaAAFaNPu9WwGYNsphvozJRkAhoefLE=;
        b=TBM60d25l5nm9YZS0Qkz5QoPWZJigtO7w+rqKjcdfRnpz95kXbfdvqq8VAVPQCt0u2
         AQ7bgE0/ErcuQUz23nCgofSzeVvJkrkgn5UU/f0GHib2abFWqGnUy6k9j0HzSJlLb4Xt
         J7oCUjPSEhSd+IhrK1hKXy5fDfj5P2/Y9g6sYQHOmWbmvsR897R5WVVWC8XzzdenpO1o
         SUiJSe8L2LX60g4y86Qy41/an0iwdNEWBlwOWy0R5tzu+201Qsi6Okvr50wM2g3sNb17
         cU21ywb5BgV8tX5B8h6W89kunu94Dl6qHp7463mYfZJ28LtIjpzoOHGc31/uHXqQ1LA8
         6ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747833115; x=1748437915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2qQPefvvV4ihaAAFaNPu9WwGYNsphvozJRkAhoefLE=;
        b=muHDa5nCgijV+jHlWZaU+ar1gHhcDyRdTkqT92emT2bMb3KDe35F4Oqez6H1KKJS4G
         PcHoH442B9OhiQjFm7u+InJ71B0qU2V9Ltq9mXuCYQBuo8gbuGl88XtFf/hzri4SPcCI
         NhjLgIxkpf+L44+y84Ymnvl5nISc3JG9HsDPnQ2hCV38nTY4Vt07pv8jnyxBk63QGHQb
         YPdpqd6truoF8zQm265bUFMRp5S3sfj4cNAWl2nR50NkOgDO6IUU2sf1IYMscneWGQou
         5G+qIKnMut1OAd89JGw3Z8QCF6uxZUTG7+nVo5iFZF0xU5BVigkXhbwvJi2gHZvLMPn+
         8Ulg==
X-Forwarded-Encrypted: i=1; AJvYcCVjDAfD/+mBQ2I7gRdXdqbGGORcuTLnTcoCJ+g64Ruf80xC4g8MoxcAtwEMyiioKGQ3ovZKGLIlVlnURrFu@vger.kernel.org, AJvYcCVwsYjTz/4fcTtrLvKtGYqCs3WuDElJyYsZPXpXOkwHTkCcxNwEQ0sl6xiAYo1Khc4lBxEDr7bSLjWREcbx@vger.kernel.org, AJvYcCXl7qXY5EZKS4RYG916VgCX4pXbMNvOUF087IGk30+a11ADiO0XgFd72Gn8/9aztS4txICv6Kc04zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw03ej7fTEsKgPGoSD4CJlwUZ6Agf3gXK7vDz0kzaov0kO05yX
	+7TJ07Fxp0KPlAEps2JKJyuLzwC2ZQN+QQH1GeS1T6/H1KSSTTaONQQ13pnzUydfjyDn1Q==
X-Gm-Gg: ASbGncucCJ9YpHS67I7EJt7A6GgBxKg/V01UVK6QiZeME/KSV79IoOqGmkYIkU+NFHT
	PX90/oybemP7t89PLVWGVSHsXSV42ymhdD7IhWq0j1AUYBR7WJA2UXMBC5x940Nrdy9518SwBk6
	lDzIXepWvWfGIIhYsD0hjUSNZWMB3WmNLHWGDuKSNyCRuZjOt4t9g/rxPMBUuybJgcAxcQtYZKj
	csGWJnBpc4JvMXpLv7PzisySAB5rpT3O3FhL492PdBSwUVkm27vKNX6rTmiXyBVailqDwaqXlOg
	ty9/W7QAIeSKeEWP6CPQCNJWAjzI1Ze6SZ4nbvwJTyQejDau670NVH/GfN151RhIkWqtKgxqGrs
	gsHnOwg==
X-Google-Smtp-Source: AGHT+IFlGplauBEgvKTRiQTI4a4oPx0iajBKn0509TDL6mEGaAIkVylvguO2Fv9F3FG+EprGcIHh4Q==
X-Received: by 2002:a05:6a20:7353:b0:1f5:8c05:e8f8 with SMTP id adf61e73a8af0-216218f916cmr33749172637.25.1747833114470;
        Wed, 21 May 2025 06:11:54 -0700 (PDT)
Received: from localhost.localdomain ([61.77.55.112])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b26eaf5c6b0sm9679038a12.7.2025.05.21.06.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 06:11:53 -0700 (PDT)
From: Taeyoung Kwon <xoduddk12345@gmail.com>
X-Google-Original-From: Taeyoung Kwon <Taeyoung.Kwon@telit.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Taeyoung Kwon <Taeyoung.Kwon@telit.com>
Subject: [PATCH v2] power: reset: qcom-pon: Rename variables to use generic naming
Date: Wed, 21 May 2025 13:09:52 +0000
Message-ID: <20250521131116.2664-1-Taeyoung.Kwon@telit.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Taeyoung Kwon <Taeyoung.Kwon@telit.com>

The qcom-pon driver was originally implemented for the PM8916 PMIC, and
as a result, several internal variable names still refer to 'pm8916'.
However, the driver has since been extended to support other PMICs as
well.

This patch renames those variables to use more generic and consistent
names, improving clarity and reducing confusion for non-PM8916 devices.

Signed-off-by: Taeyoung Kwon <Taeyoung.Kwon@telit.com>
---

Changes in v1:
- Moved explanation under the '---' line

Changes in v2:
- Moved "From:" line

Since my company email automatically adds a footer signature,
I’m sending this patch from my personal Gmail account.

Apologies for the repeated mistakes.

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


