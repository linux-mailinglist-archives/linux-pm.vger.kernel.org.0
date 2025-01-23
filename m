Return-Path: <linux-pm+bounces-20881-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3313FA1A695
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 16:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19630188C355
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 15:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE602135D7;
	Thu, 23 Jan 2025 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHgt1aqK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9706C2135A6;
	Thu, 23 Jan 2025 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737644691; cv=none; b=fCOpDR/BLcuiUjf5A8Adi74/mEBItMxFNpXTEWxRYvQJPGgKxttyN4r3dNB+AP8CaAjKLOsTV3Oo9SPHvWMpltJvOwZkO3VhO9c5ng8KwGJZtN3gxsD5KEyoNFTCi2w+wE4d1KNMqkdy8z2ptIHBDHDrUgZIi5qFIYN3lm+boZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737644691; c=relaxed/simple;
	bh=CtprffnpEbYxDe8u/UoA05nd8I1ef5XjWeIMbb57lBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jb1xfj+e1qC7J0dSiX6w292QtOr5SvaS9rgiNxJop29Y1sU+UNC0ybzECeqUFp1lzAyLcHDhARKQ+QW/Z0XkDtw/NYg0E1K0+Y93TN3vgpKcvbUe1+wxdxzBgN5O9vfPUbeQ/yEdTkA8UEwgmGdppH9GBSnE1PDUPVM6zlu4iig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHgt1aqK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab34a170526so172933966b.0;
        Thu, 23 Jan 2025 07:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737644688; x=1738249488; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4emZSPD2XPCtkBBxeLGmo0DeDiE7Bmi6DIbjpCH4uE=;
        b=PHgt1aqKMKxAVDTpu7BQ/a/FSNGraiLk8fejnLxRRqJs3FFSGln1n8FieWsEKAhQK4
         igGbUvyiCiiFLkY9D+WgrJDMNIx/UrbvUvTxMHw2t/9qQ7ashHliHA4hfNIiGgPvvfer
         ceJc4yGqVElJCnQp7sGvvfnouXieAIbVMMoz01THPRvtJarTHbAgdL721qBi2OBsOSd3
         NmzBUOu9SNH/A7vcls/cqh0gM9KURafNuQxU1T7HJLSwvHhKEJY2WUGR5A9+DmJJXALG
         z1FS9rwo0dstpqRKPS4ijFhfkPZ8dBqGkagQiDhZHc9Ns3OouRz8/qNOFsrqdh7wqUun
         cnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737644688; x=1738249488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4emZSPD2XPCtkBBxeLGmo0DeDiE7Bmi6DIbjpCH4uE=;
        b=WCGsUDE3uKn1sGztLkhw04uFbqXnW5E1/2WWLL65UMndA5c8L+B2P9DVTfzI3kdQWo
         t3umBPoCHnIPcb9IHoqDG+TO1adh61EMnn9+Fw3q+CNvNkVSwgLpvh6WW/i6jjOsFbR4
         KPNMUNsT3qPoJlehNdjKHh0N/a+xI9fjvXI2FeoDenK1ku85Jz9L6ncB5ks6l3PJ1Loz
         C0CxMd/9R3FXtMkd1m1isb+dETQSev1gDaEk/sUhqc4LEpDm5TbrlfW2R7/UgsczZ42u
         TUVPG/w4j8Tma3b2qdjeunKHefm7Der+hg4qVdlNbJbo/dYFNk12Am3vtraphk2kSmsI
         Z9gw==
X-Forwarded-Encrypted: i=1; AJvYcCUwUe1N/AZ5WE2lz9WCd+HMiT+MEHBTIEq/e62bWXZquVoyhcehLxSXGnu1fM0R1ZV1B9ToDHgBqj4Kvxw=@vger.kernel.org, AJvYcCWACve4VVlu9rvZ580NZziSY1UIHhKpTrmpV6sToXw4QZklrWpD1wINC7R7XuumF9UT45fvsEZZ++DrbQ==@vger.kernel.org, AJvYcCXAQ1cbAEoMRoTSnkc0ffqrLUFBdM53H/YmQPTxgs8OniAij7DicWdR79NCguxXs+FaQi16wRio4Un00GJ9@vger.kernel.org, AJvYcCXq0bcyN114Owgrc8sIQceWkIq5zI2be8GA9Ngv3PmfEtemHqXxYvSIQXB/aXJX2iE8ydSX4se7KY++@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5/Xkj93AW1jb8osOv78S80GDzzWaD+5Yt/RonPvKZLM5cEko/
	fQRMQT173X3HkxwHa4Td4kz3Ym5TVlXR5+ZeelJ9wssH7Nks4nqh3gFugg==
X-Gm-Gg: ASbGncvDRKYRZ1egJjEGpbfy20KW0HTi13tEMS/FHtzhUYLFsFSAOkqe0C/70iV1DVn
	3NjEx1HFOo55y9pT6AOuZMgU7UGX5BLKHlzoraxShf4/+pP63aRfli+UOmw/zIXSxNi2lI5XUsy
	rTXOQobCFXqmzphdQkzq8B+VqsBiO4f9JVYKRvm2ur5y9nGPU8BhKjroqYedMsiIt50ewMBn0jG
	PJg0tggRnZLqL3KjE5JnAVbE/h8ru26tyLSR9tTkdoXt3lh56XAegyvnqTPdFPsnG7vUGGkx/hK
	2dQ=
X-Google-Smtp-Source: AGHT+IEM4Fg0VsE5KVPEdN1qfbLQdJIzb3rKFXsb0RSQrtlAJJEIEvn83zfbx7it7LLrKSyE8zNARQ==
X-Received: by 2002:a17:907:96a5:b0:ab3:6734:99da with SMTP id a640c23a62f3a-ab38b3841d7mr2181061666b.37.1737644687564;
        Thu, 23 Jan 2025 07:04:47 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.22])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384f2903esm1084727266b.109.2025.01.23.07.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 07:04:47 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 23 Jan 2025 18:04:29 +0300
Subject: [PATCH v17 4/7] mfd: simple-mfd-i2c: Add MAX77705 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-starqltechn_integration_upstream-v17-4-8b06685b6612@gmail.com>
References: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
In-Reply-To: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
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
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737644676; l=1595;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=CtprffnpEbYxDe8u/UoA05nd8I1ef5XjWeIMbb57lBc=;
 b=7SQY0EYQNV7oTKiK36ZI3nKPt9wvydqu506YdprAOjB2lh0KrOWf6+7FZxXXVQ9koHf3myyXl
 cJaRD432+IVBWUJEB5WEmS/Hg4xk2AsuRG8IXy5FtgDHbfqq7iTj8DK
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add MAX77705 support - fuel gauge and hwmon devices.
Hwmon provides charger input and system bus measurements.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v17:
- add Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

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


