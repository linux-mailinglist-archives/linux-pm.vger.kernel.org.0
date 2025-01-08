Return-Path: <linux-pm+bounces-20094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C99A05E3C
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 15:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE682188610A
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 14:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3473F1FE454;
	Wed,  8 Jan 2025 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxQFBD72"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DA21FCFE5;
	Wed,  8 Jan 2025 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736345655; cv=none; b=r87/ME+hmd5gpUkTDyDKvmI70AVBWRubFkuY4SgCPHVDJY+uCOo2f64hzeQLy3pT6DEjuQP73qadsXj0sIbDaB3cii87Tcy7h0kYs29ae9HURQk18iSZHROpUiSNr5elBFVJt2/+fUqf17zNwg7ZSZkgYPvBFzM3UGNqbpK4z7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736345655; c=relaxed/simple;
	bh=rXMMoUEBWsz761qBBGBqdbWKIdj1EFYCUeoxnRId9F4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BNEjnmG9yhxgFk8hCaXKJcIRKid5NXCwVXrolw70L6KFdhSChxg0e3A7m12Jbqsqv2w2lbGhLdQscBDwduYiOs8uYWvIDa1wJ77vAj+6oir6OIHVllaxRiTt4fK26v0PbH62KoMCfWY3ES6ei/JjPolv6YraqWj7Yst6Y5SYJt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxQFBD72; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so29173127a12.1;
        Wed, 08 Jan 2025 06:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736345645; x=1736950445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EemsH4Zp9goG/DvipUIIJ+D3oeBJrKh5E5A6/JLDo5M=;
        b=PxQFBD72e8NItd+MGfy3dSFK+Ex6z7DFe/A1RRTlvVOe3VaHOd+x2grJQIo0nIGTGQ
         FL7woUePR8T8pPkpL6u7mf1PlFRdFA+xEaXZGznr3urFkF+cyMeu2uRI40t71TnP+047
         Yd3LUSVKaJGhazh+KTQZvm35z8aiuKE6MYSzyBk4jqKDcExg3YnFF8azyPIlP5ip4r2z
         5y+f8zBMqS8+VE0rhs65/aPFR3w9tcDqj16GNAj+dZYXcUDZHPFsGf2IRoo9gE9Dc14o
         u8I7ZmlbSBHSLn9uMmXugRuP+XNBnpc8rIFbSr4lPUaYJZqPAReqJvwayN7kj/FANDFl
         4aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736345645; x=1736950445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EemsH4Zp9goG/DvipUIIJ+D3oeBJrKh5E5A6/JLDo5M=;
        b=r9L72RiJ35q5f0m7QJnsGXCTeZHNcL3qcfKab1hqIYRpisuF+NZzgefWUsI7xJ47Es
         /zca/GKlxkuHDvoqaPfpqMt4Vvra5rHke3gp9MVX7yMIl9ZdM7qWt8FyxLczDWK/l2ae
         Tug98hCjVc3w2xmtApxSR3d3ww3gcUbuS0GS16ie7bfs07SW0OPBL/Fbb+35+bRLNLPM
         1BXrxlD8HqApk+rU7HtKtSMRe9X4TfsbbxJfc0IqgMrNlP3XE+wbjjYgwmi/6zN1DDul
         tsLzGTQwVZMOKAnMp68t5ZeGevrefMkPkGmf/UUzjEZwYSK5B9b+ipUiopRpb1HkLyTy
         18rA==
X-Forwarded-Encrypted: i=1; AJvYcCVqUfSDOheXHp/SMSB0y6s+bBOtrhDt7Pn4GrpLwDO0g6izacotPffb/CjPZluBIe44aBkOQR4BD8E5zA==@vger.kernel.org, AJvYcCWQv3kBBKcOmZqmbZyIilBWEH8aI0QaalLMjG6GQKIh7Owm6jn0zK4V/jpQV/pvIdourWsgrFCLrX38ZP0=@vger.kernel.org, AJvYcCWgsFSQEZiu23vfQ6Z/93jlU9Q80A4ClcivPWu5Qw/4mE/ZLF+ja+9ZjJXuxgLvbn4ZxzDx8Jlu5Gmfh7T9@vger.kernel.org, AJvYcCXxdz9J48VHm5rtlAbgedpIikdrDmap6j1DDSeOD+1MeCmMe/T5WzSk6PROjlRhEqsssx3p5Lm4li9x@vger.kernel.org
X-Gm-Message-State: AOJu0YxHCvknQR6abRArdtqAyer3aw4RHoiAp+0dRIeihSIGwEr3uUNn
	gx+CqPNwa9iQDnvlgj0Z0toy/d48+Z61XGGzbiMLGetpsvghtzdv
X-Gm-Gg: ASbGncvd8GiXXg0RcZg0zHvj6ZhTtYvVqlvJUQAO680Duc6oDBxaeEcwfGKAHuvjQua
	dlc2W0aQnCDaVQ514VZLllRFl7176k1/pLrWftBZxPfLFmCdZFoCZOQX0nXil3bh9qSlNAT4hwd
	EzaMXJlpJEle7DvtDwTrwEPXih6N2QhZ6Avs82GPZqat5hmBb4e05AWXLvCNVVjwYfatYotJbJb
	6HHDFz4VECE+94wcE8GrjVIH+HqWQtNah8OZweohZZwgKS7hZ+bqBocQfNcT+SslOMkkPQmE8a5
	0H1TIA/KENpbHs9Thvr/4aAnKA==
X-Google-Smtp-Source: AGHT+IHNZ3x4Qg1guN0mFGBLUwQ0UfGE4wfr8PtLRJoeoCMH8PVgsbHcC3T2WJvOzUPGUn5sR26MAg==
X-Received: by 2002:a05:6402:400e:b0:5d2:729f:995b with SMTP id 4fb4d7f45d1cf-5d972e479cdmr2637523a12.24.1736345644702;
        Wed, 08 Jan 2025 06:14:04 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0efe4941sm2500562666b.95.2025.01.08.06.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:14:04 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 08 Jan 2025 17:13:45 +0300
Subject: [PATCH v14 01/10] power: supply: add undervoltage health status
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-starqltechn_integration_upstream-v14-1-f6e84ec20d96@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736345640; l=2343;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=rXMMoUEBWsz761qBBGBqdbWKIdj1EFYCUeoxnRId9F4=;
 b=u0iBcG7nsI6h8j9uqJCQ8PuqHdAoS53jQuDQrv45uvjmKffYLhZl6hC6GXVKkI6iBVY9i7DwU
 wLlW3PgxpP8DNXQtXQW2FXNq4BiIPOONby7a65fkNGW8knf80779HCV
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add POWER_SUPPLY_HEALTH_UNDERVOLTAGE status for power supply
to report under voltage lockout failures.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes for v5:
- update Documentation/ABI/testing/sysfs-class-power and
  drivers/power/supply/power_supply_sysfs.c
---
 Documentation/ABI/testing/sysfs-class-power | 2 +-
 drivers/power/supply/power_supply_sysfs.c   | 1 +
 include/linux/power_supply.h                | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index cb53dde20a80..2a5c1a09a28f 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -453,7 +453,7 @@ Description:
 
 		Valid values:
 			      "Unknown", "Good", "Overheat", "Dead",
-			      "Over voltage", "Unspecified failure", "Cold",
+			      "Over voltage", "Under voltage", "Unspecified failure", "Cold",
 			      "Watchdog timer expire", "Safety timer expire",
 			      "Over current", "Calibration required", "Warm",
 			      "Cool", "Hot", "No battery"
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 9ce5eda24093..edb058c19c9c 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -99,6 +99,7 @@ static const char * const POWER_SUPPLY_HEALTH_TEXT[] = {
 	[POWER_SUPPLY_HEALTH_OVERHEAT]		    = "Overheat",
 	[POWER_SUPPLY_HEALTH_DEAD]		    = "Dead",
 	[POWER_SUPPLY_HEALTH_OVERVOLTAGE]	    = "Over voltage",
+	[POWER_SUPPLY_HEALTH_UNDERVOLTAGE]	    = "Under voltage",
 	[POWER_SUPPLY_HEALTH_UNSPEC_FAILURE]	    = "Unspecified failure",
 	[POWER_SUPPLY_HEALTH_COLD]		    = "Cold",
 	[POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE] = "Watchdog timer expire",
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index c3ce9f2b17d4..6ed53b292162 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -60,6 +60,7 @@ enum {
 	POWER_SUPPLY_HEALTH_OVERHEAT,
 	POWER_SUPPLY_HEALTH_DEAD,
 	POWER_SUPPLY_HEALTH_OVERVOLTAGE,
+	POWER_SUPPLY_HEALTH_UNDERVOLTAGE,
 	POWER_SUPPLY_HEALTH_UNSPEC_FAILURE,
 	POWER_SUPPLY_HEALTH_COLD,
 	POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE,

-- 
2.39.5


