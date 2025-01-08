Return-Path: <linux-pm+bounces-20097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 850ACA05E4C
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 15:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0421881BDD
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891E81FF1A9;
	Wed,  8 Jan 2025 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/go+vW3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573071FE461;
	Wed,  8 Jan 2025 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736345660; cv=none; b=L95MiDrBDV2f4ZtQR+8L2NuzUKs15YafvOVpuz3dorqSvw5O4yMjLiam12FnmFFIw/2FwmoPQGXX6SpL6PE+nt7uDPBHwkLfwHw2iy47G0lGIY/sYL2gsD01On9rz9AavAMV6iKnUSzOyZsgrmNKQ8eB5fEs7Zvi3CmQZOcd21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736345660; c=relaxed/simple;
	bh=I7mtjfCVJ1O2Vg6443qyW0B5WFDFjRpanCU/ThHHH0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JrwwOIyCxyktee/NVMleAwA9Z2tGjspjDgOvI1rX0SmwHkrd0dyIPAgsZWxmDQ2B0FCtqqIqbJDKmLrvkeIPwwkBn3CxkMrVCQWQS7lDbxM5EGaHlmKhA6SHS9Z7k8bCGs6FzLeKNIDdl0NQX7NNgWlbY39iKYDHr+3NKVW3r6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/go+vW3; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa69107179cso2799526066b.0;
        Wed, 08 Jan 2025 06:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736345653; x=1736950453; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAsrsTp1vVx4HKavdMezqlK1BcLoKSQ4OHEn1+GzS2A=;
        b=F/go+vW3tRiweffasKTeRCub3UTRfcRVEvw4LkqZrsvT1QkYl56ouWjA0NyeNSndJu
         dHfxbqw1IkbYtMDaMer8I16mNDpHagvuSBqhZMfkdZVp3uD7WvRWfBPlHhxpulUds9FS
         JsHs9L5f6hG8KD9AIbfmS2esC+UJJpsTFmNvdCg21Vam+IZ2XK/gw+rGJZOE869EsmtQ
         7UnPGkGg3+EAVVBIvsdhmrXeIlNKrzKIy5Xf3xzznvxk+gRhqPKicq8/uVGd5kgEkvMC
         nyfd3uP8cwhtByYTcVsifPjro0DNZKzo+eBfZtUZNATjhdACB+y/hwnze7i2xp0dlaxl
         JqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736345653; x=1736950453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAsrsTp1vVx4HKavdMezqlK1BcLoKSQ4OHEn1+GzS2A=;
        b=e0m8Uw3WmPs8QN8PF1Z8qq/mvGAb6+nw2+RtrPdL0See09q/U0uIvBybWeqPM/22Va
         sNjkd+se2o5KfuUxFldP3KlL0lmlBx7pbXfCJOE0/fHp8TBNiWHuLXse/g2qzzuguJrs
         hUQAsH+L4DceqeAEnqRAUZPi+/KMzOuBDhkrnwaWIC0svTcdTZ0lgRZkxSHPSnBbk63T
         cdLnyEDkr+r2yq3vuSV8lZmr1AX9J59nSUo9ei63U9F0ZeHOyRxAEYcq78Q/0NEY7OYc
         ZqPRTMsWMxdePeZ1IMvHRI2C7sIu5Nu+Qxo/BHnQO7O3J0ED/YTb0OTzgULZqiOkZAml
         uYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe/6AXgP0M978ec+VphATWc5taFiuuAKDEYkhtdZaNhNhhoFHMdt0yV+KWmIBBTneW12Xr1zaXgnlW@vger.kernel.org, AJvYcCW3zx6qGMQh/7k4ncU1rM92rCXGJkxUNNGMWIWtd6Waa98xa7BfVgf93JO7GX66p0c/Zfs6lijNm6k0jg==@vger.kernel.org, AJvYcCXIjMQXUawOi/pU8uACj7Z4oxY1u+A1zjsfV5qTNG7HXA1jOgrhfoo3n/sNUsVXzevfDsYPRCqfezls1sg=@vger.kernel.org, AJvYcCXqb7lxK3bUXqVo/4mQBVHOEsEgn4V77PxGUsmPpnIFH+F1jSzaKuJ3c+l12h5c/ywe113uciOx14aDzxcz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4itEsMFwcCQwddxjASpqU8hr0nfgqMXP3uh9elLBYtkaLKD8D
	f9aSZU/X+8N0Sfy74KGrno0Qr8/XEKxBZayBfiRE0PlgpvBYfeq4
X-Gm-Gg: ASbGncvOJoCeWXKpvEhO4RLoOW3Rn73eN4hw6eNiv2v7vEmSQEKF+wbzyWX9M0DNpDQ
	fASVY1ToyEg66D0JX3FGoxx2za7+um7Ppun4mgcRsACjlIcX+lAxHLwR0+iCFU2tR0dkQSB/36a
	T3/90uANpnGnJ+E1lyvifjlCMz1jLnBs3sS3uHjOif8wrZeKGuDxCfjnstN3mjpzaGF+eWWWfvB
	7Xiyai0B/DpxhMQ22wWtJR2cQBI/EDDHUGUh0DSkATz0jRR0ysaSBbqFmFs+z4yCd4na1pqDw+I
	pQaJfnD+LHsDH6MiGxhQ7nwppw==
X-Google-Smtp-Source: AGHT+IGEh+LVPv/D0Mg3OQICJF+cwxS9rog2MJCMJ4L3QLCPHPYJH6o6Fpoe2HikJOse/wolK+fTRA==
X-Received: by 2002:a17:907:72cf:b0:aaf:c19b:6ca0 with SMTP id a640c23a62f3a-ab2ab66ce98mr241981466b.5.1736345653293;
        Wed, 08 Jan 2025 06:14:13 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0efe4941sm2500562666b.95.2025.01.08.06.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:14:13 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 08 Jan 2025 17:13:51 +0300
Subject: [PATCH v14 07/10] mfd: simple-mfd-i2c: Add MAX77705 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-starqltechn_integration_upstream-v14-7-f6e84ec20d96@gmail.com>
References: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
In-Reply-To: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736345640; l=1436;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=I7mtjfCVJ1O2Vg6443qyW0B5WFDFjRpanCU/ThHHH0E=;
 b=pQqkRhG7P6Z9S4s6K74BVMR+tI2s4Dz0WPDeeEKk00l3/T6eRhGO5wyLt/xv6O5FwFvsebaOG
 1fn0qsDGJKtDmjq6VkTFx4WecO7zXYn1Bb1L+X/C3SUKBRw2sDIYm1l
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


