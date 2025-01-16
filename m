Return-Path: <linux-pm+bounces-20568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B069FA13F69
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 17:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9E63AB563
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DA522F847;
	Thu, 16 Jan 2025 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2kykzap"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6FD22DC2B;
	Thu, 16 Jan 2025 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044782; cv=none; b=bXghJR6/UIrTMviCeIarH/NzUKNKWcvkf6h3ASbdkDh82BW2jS2uWPNW4JUhHjLg2DdwlPxSvBB0ek9eArF5T1CFLNdf4iD+RSkdD543NfmbsHX1LzpOTYEfJC5yHb9vIl/eex0WP44/i3X+3WXVbQZaHbexMMbx+BhICnudCxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044782; c=relaxed/simple;
	bh=I7mtjfCVJ1O2Vg6443qyW0B5WFDFjRpanCU/ThHHH0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fri0dPn7TWa+TQgmdCzRkUCh3HVpy65kXtEDsTIwJOs2LOB7hvqPQsX/ZM6qc9hxwkafV5Rs/2ZidN5xzyHlpsGFAaSX2dAkmECzdbiZ7fVdnY8tBw8/kkkf5b7dRBm3vtx9eArT92dCkc3gnVlHRHB9UronFJF2/ONvWlYWDqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2kykzap; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab322ecd75dso210324866b.0;
        Thu, 16 Jan 2025 08:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737044778; x=1737649578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAsrsTp1vVx4HKavdMezqlK1BcLoKSQ4OHEn1+GzS2A=;
        b=e2kykzapkv2FuEKwVmx1IPVBFyKh+8BKM0xZBatgmL4Mplfc/Gpt58RbYdhkYQAMLB
         RxlaNlqCN59nwx8Kbwuip/scn8M2UlbjlAjvgDUeFOOcEYwi1q3J4e06l30JUM7fSGOV
         QnInhWKkqyZmekeRE4KRgAbdTk79doE/QjIrPmm5qJNmjx3Ax8JibdZjPfndHtUA3I+g
         7cFFXqDtddqxkzksBWUGxkEpZy04S1R5kS91D8Lk987OglHDN71DnXVo8olWHRiDdG2F
         aOFRL6VjjJhlC2bewfYYz8iw4rc/tTfblaElX5mXrOTv9UD67yFICVvkfTk07OoKlbBe
         NiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737044778; x=1737649578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAsrsTp1vVx4HKavdMezqlK1BcLoKSQ4OHEn1+GzS2A=;
        b=vwZvMp35s7b6ss9PY1iYSvvcBBK2JEIlsUYGPgWIKm30R1WprM3o7v3E0vxCTY++d2
         bou5MGOijjU6GNANbcz+8FbZ+9fcgkYFAbtoucx8Rwl9KnnW5tpMCLkyRXSDd2rJ6Ebb
         RvKW4es1YKaV48PWCcqQgBTc7ddsl+Y+Q4IIgPbLQTMkmOUBdO7M61uCsME2g/4s7J5a
         d6H4hCECSCJFCMA5G1geKAndXlUtMfRWEqgGPq2Un6pz1EqmQkmQm2+/CKc0YuFqR4FB
         jICNkjC1+KyxpL6Z5wJEf5PScu7NDeMmvDkYy3ZSx8SW9OEEXF1UKUyuPBcQjeynUveS
         77+A==
X-Forwarded-Encrypted: i=1; AJvYcCUbaLvn5i7EHKsHfkQjx5LApoE//3cvXbNRncyFJzOypTh7hvtBm5Dl2DrkaN0As7CgZmw3VPjOhWsX8Hw=@vger.kernel.org, AJvYcCVr5G3mcXTKcCyPYPly9gHukTGhuGVc4lqkwuHpFzkQsLS3GFkWW3+pMtTgCgi37tPiS21+756kUw9yDw==@vger.kernel.org, AJvYcCXASVt6DJx315/mIja/kwVoSkkpf7tqzavu8F8PoWcL/79nue8Y4nDqZN+tI5Hm4oSsTYHCWJx2ovVh@vger.kernel.org, AJvYcCXTT9N2LNYAw3z4amWRQzoaW4zdEGCOhGoZjdVl+BTNHbMznAIekB/JKmV4/jRrOg1jppx9tnF1g5j+PhBW@vger.kernel.org
X-Gm-Message-State: AOJu0YyiN9GmXY2Yv6cVc+2dT/YxGYcabNLGjvwlUzaFHjnnWFripah7
	5VqkyfXydXEVAHUvB4YX5VhKk7zeqpyZfzlj6dS0VFFptDYt4PYY
X-Gm-Gg: ASbGncuj/Zv4gCD9IbiVU5mjf/CFfzLRHRlbspwe9FEpyRI51PdpUq4rUaI65R2ZZmA
	A4j1W1+apYFY7TvNpW0EVbXrrAztg7FUEQPHAP2UtqtsD8sKWeJQKseU/X1UCOR8oUYSXMg/OPv
	t1bIgy8mysGvsPDXpMNWf01I6mO95EywMhH2MH8UYQWC45/AMqWrHYQjJL/AP3aCgcsTybW13eO
	CNFU93YY00XYv49Pe0e6TrGKnWYEOpcUxFcd+tso+w34fRNMYCWGqoDx/QUDaG+0yalSDhcJbmF
	vaFNAXI3vJNGHZRXF4yDj1B9cQ==
X-Google-Smtp-Source: AGHT+IHHtqh/oF5Inc4HgefrHxQm/G1WLLtEgKt4j75lZC1ZiGJhTLddK1IcFi6vYCWeO3ELhWGkPA==
X-Received: by 2002:a17:906:e203:b0:ab2:f255:59f5 with SMTP id a640c23a62f3a-ab36e39265cmr299420366b.16.1737044777655;
        Thu, 16 Jan 2025 08:26:17 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384f29260sm16411666b.94.2025.01.16.08.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 08:26:17 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 16 Jan 2025 19:26:06 +0300
Subject: [PATCH v15 4/7] mfd: simple-mfd-i2c: Add MAX77705 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-starqltechn_integration_upstream-v15-4-cf229de9f758@gmail.com>
References: <20250116-starqltechn_integration_upstream-v15-0-cf229de9f758@gmail.com>
In-Reply-To: <20250116-starqltechn_integration_upstream-v15-0-cf229de9f758@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737044771; l=1436;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=I7mtjfCVJ1O2Vg6443qyW0B5WFDFjRpanCU/ThHHH0E=;
 b=Mwfyv4xW3aWJqjWSRuVBGRCgkdw/OULD28lzl4EZAOFgPtxHBIqIpcb9cwELEVYi3W3qcuvyG
 zKlufwqoB1DAVzPB7IJiah+coYjXIpCyD77ltCDKjl1w48Y5UCl6LfI
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


