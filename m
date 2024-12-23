Return-Path: <linux-pm+bounces-19693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E764B9FAF3A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 15:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F0B167496
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 14:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9D31BCA19;
	Mon, 23 Dec 2024 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRBLigh3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8651BD000;
	Mon, 23 Dec 2024 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734962412; cv=none; b=G54DejTeiQfiDUcxoU93sEcOf9NCbF/YDSBUbgHhEZ+MQ5vC5lL5guGqY9bwjqRHucyKW5avLpgu3Kbt6WtxXu4V93zL97uwxkIaMZhJpfZPEGezIo4rU60+vFOCqUi13tCnoIomQmpar8ktu7oWFI/mxQwgn/nLCW1+h1pyRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734962412; c=relaxed/simple;
	bh=I7mtjfCVJ1O2Vg6443qyW0B5WFDFjRpanCU/ThHHH0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X+1QZICxcPmH/yIC0SR/9RrdIbcVCMWz+7/GS13lPIeBqBgC3dhRM9fk4BHd1slKMYGGbzsD/6ldBF9lBc+NiTa6h9rvSt3j033am5yzpBT6hInBEC/2hAa7n/nFrsYDGedpn2McixQhCorMvK2vNAGvcqWePGNicEvWck2l5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRBLigh3; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so887388a12.3;
        Mon, 23 Dec 2024 06:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734962408; x=1735567208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAsrsTp1vVx4HKavdMezqlK1BcLoKSQ4OHEn1+GzS2A=;
        b=CRBLigh3Yg7vdvpXNvr7+E0tG3EmZ3Uc6V4uhsyUPsQpDDzT0OEnEh604rQYygMCz4
         GUr1o9G6AIDJZUE9kCBr+mUtCUOCHK3qDuYwuj4pM4CYRGlQ3rKpW/dpXSopEnrUNTTC
         ADdpBj0iTE+Vsqb8Q41y3xhvkLoouXj5y7+4A0DTJG+1KRkZZjdoCvbibf7Lynctn+tV
         fUWQ928j9npAG2G0oViMfRg9yqqVbhkl1cW+s+n62nH5RTGEzbl4f5IrOoLP1dajVQiK
         Lp0YYJOCw054HGRWQ8fJ+fEZOgg233ObqIcEIc3lD0XxHeeoQ3twsHzo+mWvSiGmKS1W
         nIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734962408; x=1735567208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAsrsTp1vVx4HKavdMezqlK1BcLoKSQ4OHEn1+GzS2A=;
        b=gWcLwos07uq4xnugpzI/xsqx247SfwSHIFfF1pDpSfrKCPlU6t7G35kAo1RqBxNl+J
         aCJnlVmwfoRQChPiPJrlGzLF8yDx5odFM1/bDcowfQT41AEllGxHSAc8rZJo2zlJmwS3
         6aAqSiAKt3apcFoYL+VCnXaZaxZP0ToQqrqTDynFfRFiUpmR7RU7TluAO1NPqvNiZOEc
         8yvsVquCFD/K80WySF3anRZqLG0pI3D424ihwkK6ZVe4xZbS/zqfdmmlr+onTN6AMz9G
         DxobYqWyEVb4jP6KUGk+py5egVY+Ap/tVVZmFMubiqpuB3D0lzVwa/gagCOQHi7G+HwR
         TCfg==
X-Forwarded-Encrypted: i=1; AJvYcCV57rqFjaxr5Sb5oO6zEg8eiXZ97OwZqDiAnc9p5gSBanYo+3d4DCo5bZv0imD8tbimVUrmb+RoGiSRxw==@vger.kernel.org, AJvYcCVK6Bqvtc3Vx3y2Hu1aP85hDi10Vn3OSL8nYAaYjpdV/HKnNwWo9brC94Q0gvHC/IJQmH3Lvks3J5iX@vger.kernel.org, AJvYcCVzlvI2YgyanvF73dq5UFLiwWDe7hx7Q0qgyFIjGu/rucX9/S0zXtdvLvpzm8fhop4HUwNyQNHvzUtc22Q6@vger.kernel.org, AJvYcCXCsTvjUCjAu/TXbENMkcnDzn9Ybexa2u4WdoHB68bwKcsNMBJa5OgzCfRlYpVAtV2+6qBCa3LXdajwcBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9lsA2pgxSrlJX34uUcA5U66yqfXMqH5hAF+Nf7ELMJHZ0N5Fd
	af7MjFvB7sEh+kkhCAge9X4sZnM+6r9mhxdQVvi6tK4UzPVG9aNR1Jg4mg==
X-Gm-Gg: ASbGnctRn7y7h+ZLQBBEqaUb7KvAiOpEz78S4iSNI4AFDuZVTknhpGbCySFxRAb/QEz
	0vsEJNAckgpJb3EICk5igf1x7R9/sDeuvNhG/BCRPsUjXf7FRsTlSICg+ffsBx1xreyORVPM9H7
	8iiMbFfEIZsvF+kXrrJcEnIssWUgdioUKnG6JJ/TwyE7EpgI3ZYNFOvTVIFABTkDBrzPswbJYxJ
	QDXRPnNUN3QdQ9rcPQhJIYSWu7yM/WOG0r+F6EAzuRXItf+Nt6PqKn6Lfpc5UP8iiWaloTqg6tk
	b7WF+57Szc7rR3Tvh7qWt24r+g==
X-Google-Smtp-Source: AGHT+IGkX2twjYykPfvrcevPR5SmL9ufGNABslDrIHQ3V0lMHPJD3pH/auJVtXptIdL4bIYPQe+pOg==
X-Received: by 2002:a05:6402:270d:b0:5d1:2652:42ba with SMTP id 4fb4d7f45d1cf-5d81dd9a22amr11538622a12.16.1734962408175;
        Mon, 23 Dec 2024 06:00:08 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ca31sm4911485a12.88.2024.12.23.06.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 06:00:07 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 23 Dec 2024 16:59:44 +0300
Subject: [PATCH v13 07/10] mfd: simple-mfd-i2c: Add MAX77705 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241223-starqltechn_integration_upstream-v13-7-fbc610c70832@gmail.com>
References: <20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com>
In-Reply-To: <20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734962389; l=1436;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=I7mtjfCVJ1O2Vg6443qyW0B5WFDFjRpanCU/ThHHH0E=;
 b=F62UIeWI7IWnW8geVb+Negvf0pgv3ZePjOicrYlLicIi/pJdoe2BXXt77hd90QPoRrzRo+O3M
 ogs5lq+ur8WCZ+kNUTS3KU4kY+je6r6gv93jatMMFVCy2AWSLNZ7EPM
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add MAX77705 support - fuel gauge and hwmon devices.
Hwmon provides charger input and system bus measurements.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v13:
- remove compatible from cells
- change mfd compatible to match max77705 fuel gauge node
---
 drivers/mfd/simple-mfd-i2c.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 6eda79533208..22159913bea0 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -83,11 +83,22 @@ static const struct simple_mfd_data maxim_max5970 = {
 	.mfd_cell_size = ARRAY_SIZE(max5970_cells),
 };
 
+static const struct mfd_cell max77705_sensor_cells[] = {
+	{ .name = "max77705-battery" },
+	{ .name = "max77705-hwmon", },
+};
+
+static const struct simple_mfd_data maxim_mon_max77705 = {
+	.mfd_cell = max77705_sensor_cells,
+	.mfd_cell_size = ARRAY_SIZE(max77705_sensor_cells),
+};
+
 static const struct of_device_id simple_mfd_i2c_of_match[] = {
 	{ .compatible = "kontron,sl28cpld" },
 	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
 	{ .compatible = "maxim,max5970", .data = &maxim_max5970},
 	{ .compatible = "maxim,max5978", .data = &maxim_max5970},
+	{ .compatible = "maxim,max77705-battery", .data = &maxim_mon_max77705},
 	{}
 };
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);

-- 
2.39.5


