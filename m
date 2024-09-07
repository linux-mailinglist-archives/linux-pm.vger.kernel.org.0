Return-Path: <linux-pm+bounces-13834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E0C9701D0
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 13:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FED7B230D9
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067B115A864;
	Sat,  7 Sep 2024 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0BmB88D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52946158556;
	Sat,  7 Sep 2024 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725707271; cv=none; b=ZFT1H7EZDlvUgyCC2jpn42EZlHH0RVfYIRGrMKOedEFI3CD88PDJOPnq0Gign/28RMQTgByY5Vt77cvilsDGRJzWfJFrnifEoTRLJZlKGYKznmcxjAk9rZbyWOZNgrhlSaYPkhgIqaYT1TtdpDaGiVqRT4d8ldRlvw473ZIpw0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725707271; c=relaxed/simple;
	bh=udRTh01PFdNwrz5h6uyHU1yEO3a3lSXrCIR5rWz7vCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EQyVF7y7xG/JW5s3aTtNC0AjyVgTZr+eOblenAZ2ZlPUfcyma+r1TpE3VIc3Q6qVUHhn+0VmnYkQNX9zPDoBcD97kCgOck6AblbJAkYeCb7QywV4DUTohJYxYyauVGFhvDN1xeO7HKoIFbEHuQF7usDsGYpZ3xq12Pa+A31qDXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0BmB88D; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so21931895e9.2;
        Sat, 07 Sep 2024 04:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725707269; x=1726312069; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nn3W1kMigTVE8blchx+fEv/bpRlWtEY28Jz/T9i8iA4=;
        b=Y0BmB88D9089fael/icln5NNlttYC8zBgNoezWyLZAO6wMMvaZwBYvAOutc17Lt9/X
         gGKc51x0eBAHXokexw7poTbBhSidklpbaNNXGufU3fL8Y5c/EyLvoY11t8eJ2LfMojiD
         S7yKZT2kzweKoB1Cjwj3iO1b+8BH8MhuaCv4EwNXf82lab6AK7yrgmlmGD7P7o7GlWcP
         YQ1tuWV/U8J63G6TkUB9wRQThlFLgivpOAL7spk9fpKwn5Q99UNeBJ/qO/gaYkFGewnu
         hu7atLyQ6N2qx/qYRLyUV0lho3GX/nWECNV9oXxcfT+O2CZzfubJ1nbYRhwqXdcPIT1q
         6g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725707269; x=1726312069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nn3W1kMigTVE8blchx+fEv/bpRlWtEY28Jz/T9i8iA4=;
        b=eQvrr8BYf/E6M3rNGaAcS02QojhwoUdPAKp5wfUKufuNKPmn2vyTgdbBR415tMtusn
         hjIQSDKJjTNcwiT11KT/5Jz8utcXhnniG7YAw5gVja6fVGIEywCrkEzuAV93cs79Fjtm
         BP2Wp2KtE303Dg58f/IRU8itCQVpZlAXE1qvU2J2HpgcxrnviEjyC39tx4JSfVb/oEgo
         4F2/M/LxF+/u4kywsK73eJFAvrsTWeDPOUu1ToShY42HTe1N3a0l/tUHznQZdhxAuGha
         kF7Uu/hngjedqHC6J9aXocPhRRFn6WICEoh2zPaUP8eKAvnH4nunY562HvExUVW0OV9/
         +v+A==
X-Forwarded-Encrypted: i=1; AJvYcCUQKG5mFnuv45z7YzDW9IG40EX6x2InwGKVjbuj5IOmfhWYak8A7gqqBlH0ryDt60zOP6fQw6DwOCE6eP3D@vger.kernel.org, AJvYcCWpjVR/yx3kZFTJRAHP68AQAC9E84hKIxM4pEdyvIaUmYHHLjxfY2laJbFMI7oC43NWMddx3fT2DQZf@vger.kernel.org
X-Gm-Message-State: AOJu0YyLbU5Eaef5dxvZSeycM3wRL2bTQVnef5nysHcvd7E/GRqxus/F
	V2enZ3e/4LYxfTd6PVJOvHBTGfhy8gjaxOmp+bKJL4yKaDas++HW3lCLKc7N
X-Google-Smtp-Source: AGHT+IHSy+MLOjb96dv5ua1bHQAoaTx9nS32PPhKOkrFsquf1+TmcibLteRqakdjbU+c4tDt8zltaw==
X-Received: by 2002:a05:600c:4713:b0:426:689b:65b7 with SMTP id 5b1f17b1804b1-42c9f9d359dmr41212935e9.25.1725707268603;
        Sat, 07 Sep 2024 04:07:48 -0700 (PDT)
Received: from [192.168.1.130] (51B6DC2A.dsl.pool.telekom.hu. [81.182.220.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb444b0sm13719415e9.21.2024.09.07.04.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 04:07:48 -0700 (PDT)
From: "=?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=" <trabarni@gmail.com>
X-Google-Original-From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 07 Sep 2024 13:07:46 +0200
Subject: [PATCH 2/2] power: supply: bq256xx: Add ability to omit battery
 class
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240907-bq256xx-omit-battery-class-v1-2-45f6d8dbd1e5@mainlining.org>
References: <20240907-bq256xx-omit-battery-class-v1-0-45f6d8dbd1e5@mainlining.org>
In-Reply-To: <20240907-bq256xx-omit-battery-class-v1-0-45f6d8dbd1e5@mainlining.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725707265; l=1218;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=udRTh01PFdNwrz5h6uyHU1yEO3a3lSXrCIR5rWz7vCo=;
 b=pBEi+vQWV1Tf+hFCfwy10ZgliSgqQx629lgUiySLwHV5X2JAURNICMyNzYM8EhcSLD3ytbXN1
 ttQNSUOD81SBWegIe7kmTGomM5mJopKkmAU6g7iZ4/+HTY/Yo+Hgvdo
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add omit-battery-class property to avoid make a battery device
for charger when fg makes one.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 drivers/power/supply/bq256xx_charger.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 5514d1896bb8..62721d564b39 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -1547,12 +1547,14 @@ static int bq256xx_power_supply_init(struct bq256xx_device *bq,
 		return PTR_ERR(bq->charger);
 	}
 
-	bq->battery = devm_power_supply_register(bq->dev,
-						      &bq256xx_battery_desc,
-						      psy_cfg);
-	if (IS_ERR(bq->battery)) {
-		dev_err(dev, "power supply register battery failed\n");
-		return PTR_ERR(bq->battery);
+	if (!device_property_read_bool(dev, "omit-battery-class")) {
+		bq->battery = devm_power_supply_register(bq->dev,
+							 &bq256xx_battery_desc,
+							 psy_cfg);
+		if (IS_ERR(bq->battery)) {
+			dev_err(dev, "power supply register battery failed\n");
+			return PTR_ERR(bq->battery);
+		}
 	}
 	return 0;
 }

-- 
2.46.0


