Return-Path: <linux-pm+bounces-20624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1002A14FEA
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 14:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2994A18885C0
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 13:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2FB200BAE;
	Fri, 17 Jan 2025 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQu1mkSl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D811200100;
	Fri, 17 Jan 2025 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118904; cv=none; b=PxdbiA0PrfDb1ciHkgIIbkWrDDvdzu5y9rKwoZzJasxjWWoegbAHPneh5OKlmR+vx9TPQRLY2uYsipAvEJJW12BsPij+GPfCgcLg6ye5Ba+nxvz12CDHoZ6k4hUGALrwS2v2dg9QPodHtLysnKZbLGN8b8M+2lsf3K2Q3cWbFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118904; c=relaxed/simple;
	bh=I7mtjfCVJ1O2Vg6443qyW0B5WFDFjRpanCU/ThHHH0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=keU2JGtdZBofTQHgkvRa4dtJUwLGP51j8m1AekzBsESkQHdpn7XZISxZqYxOvmPeqTCZnxUkuQnQhDWLVYWNqDicxvqRKEEJHWIPDihzeV1awNAPS/ADFndam5LmsvSaTUdyVqt3yBFN1c2SUyWWqMhz420Awn2nkhwGwwQYoAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQu1mkSl; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d9f0a6adb4so4292764a12.1;
        Fri, 17 Jan 2025 05:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737118901; x=1737723701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAsrsTp1vVx4HKavdMezqlK1BcLoKSQ4OHEn1+GzS2A=;
        b=PQu1mkSllt/Db5gr4TtXGzBHUIJr1ITm4xSmxDpv+l73qVMCUOWHnB1TZsFM1uQdsQ
         aRnbRWWjiDDevNoKRohZTMJQcxIzEtlhP3XGsD0jDvG+Lqww4/J87XpwN5FkeP/4gEm0
         Wft1+aZCZFXu20R7gPxXZOzNWdlx2325SEq+etWxs2XEK40wR1wQlvDNHtpPb8bYXGMP
         ToBlljrJeYOVFdQOmnnlYAht1fH8kq8J0A8pS8TwbDMHsOfDGcKZPcBN9Mp0Ka9NJnaa
         NDrFrOZDjA3pKNGE4OvAizsY0EwGpcoL5HH2zuvNyONHyPQ79GY9HmZ5IsMee6WnKUTs
         Vvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737118901; x=1737723701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAsrsTp1vVx4HKavdMezqlK1BcLoKSQ4OHEn1+GzS2A=;
        b=w8wfu4MFUUKWUUBAmCtBVg3A+wA2DO1rP8j23yYh3kb5y7aTBgaPLUYegQRhi0XIQw
         mOeDyn5KIY7LwHoNYlGjhQUlzrdLPCnXP+ZN+hhVmu75PmsrkYU8UL0u2vQu2ERsoqq2
         eMU2IpH7koAcXZpSkHW+9GR3NRS8f622LGhtUOKFIZiqU+wjdCr4RCfLk8rvP3BrRwAq
         fxXgkOWq6p6RLYjnMx5WOR77k4TWTHvy1uYcszDQBxTBfp+NpauwmX6m5Tne8EWmqbuV
         TdvD2tH4cuu+JSxs9kvibQbT30Y0CJlBcDSezsPGWJrBAY4BxDHmoigLI7ZuYdGsP2RI
         5Mqg==
X-Forwarded-Encrypted: i=1; AJvYcCULPHW3hqFyaUuW3lJMCvkAyEjP1TD8MSMqW4OCc4F5Z48+gVYLCV4FYmQY9XyjcYq3BS9yLIwAgrErbg==@vger.kernel.org, AJvYcCVZtz7WaGhgHoeyIe68Ho6MEJQa19LVwGJx8SO0FZC2EZCdxJE4g8ttT9sdnJAWk3NMFl0cY9DSsHFOXxu6@vger.kernel.org, AJvYcCVl2oR+AtIwzcsNCSGesU7j009ywPv/nNkEQrM4lPtxAPqjqWtCkQ03ztT/1k6AIAxc7qnVn00COlgg@vger.kernel.org, AJvYcCWxDb6Cd62hNwLiTbM3y2Jo0Y7aYAJpyW/uR+ackARYZl66dOIF1Ikjbg1ysBDRqjiFKnlXCb9NuniQpP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwnInyLfu2XsQ6eJUJQS2nZ03Jpmq1lEHBNJwy4rG6mNrVZCJU
	C7TDIlvbH3Kuu6MAv6qCWt8QAenCiFX+jtpoNVI05OH1OlewJ1R1
X-Gm-Gg: ASbGncvER7i5CcYZzcH36kzLDKYkxC+mR9POyZu2Gzul6RYvElLjDakVgmbTDOxFZpf
	mZQQFTcQwtCJI7x0UbHzI49zaQUGue5KvhdWlTVBTUHgbBtbGrIMOonEhkAB5B2ylrE4AwAecuq
	zJsmFdGT+KP9PBD9I2SAE3/0Hx9nO6Jo3vwjLZWbZ0JJ8uh+UQKRGe5iDAaZomGGF1V0B04XTBv
	CPMI/XdzWXStHM+xobkAfLhKND39Z0Uz1KdDvBrnne/jaSkoO/q5J7SnQTp3wXN4vQyavJ3RSKY
	JGsibcff2saOCPWJql67/09xmQ==
X-Google-Smtp-Source: AGHT+IEAckyTOMgZk9zMie+3QTGmiDbVRuLtrBUtSt/jKNocNun+q1jiUIFg+LbTHAX6/1Zvcfcw7w==
X-Received: by 2002:a17:907:9691:b0:aa6:519c:ef9a with SMTP id a640c23a62f3a-ab38b3d5ebdmr252695466b.53.1737118899940;
        Fri, 17 Jan 2025 05:01:39 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384d2d69fsm166289166b.79.2025.01.17.05.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 05:01:39 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 17 Jan 2025 16:01:31 +0300
Subject: [PATCH v16 4/7] mfd: simple-mfd-i2c: Add MAX77705 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-starqltechn_integration_upstream-v16-4-11afa877276c@gmail.com>
References: <20250117-starqltechn_integration_upstream-v16-0-11afa877276c@gmail.com>
In-Reply-To: <20250117-starqltechn_integration_upstream-v16-0-11afa877276c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737118892; l=1436;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=I7mtjfCVJ1O2Vg6443qyW0B5WFDFjRpanCU/ThHHH0E=;
 b=E8YhlKkeFkWOcv3MPCSRxBmfpFOHhiKYyrEZ3Q6GRWyZ5+GjdJ6/qVckO/dZbTOOC3OqakKvQ
 BJeaDrmFcOLA4Ki/DK3ZAn28NNVGrRJYXMxPv1A9Eh+4hpMG3QeAl6c
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


