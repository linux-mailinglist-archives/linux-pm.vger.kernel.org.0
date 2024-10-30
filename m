Return-Path: <linux-pm+bounces-16772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBFE9B6EE2
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 22:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC671C21A9C
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 21:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3074821767F;
	Wed, 30 Oct 2024 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivIawcHw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBBC1E2007;
	Wed, 30 Oct 2024 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323850; cv=none; b=M9llOJ7hWGUCLl0EukVUltW/uBIB4pOA2Q+Ezq4zNQ84W1AhAnlU9FN4nkDPcD4rbjppprQZFug/03Vrf3hI4Pl15Wt9gh8I7B87lMTZbfIKKBtEbspAH/Qt3X+b46rLlBUO/Y/1UwMj/D4bWSsj6rFKiMGV+2ZXKOy5XvDqYQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323850; c=relaxed/simple;
	bh=y/7jYmf1JcJqTTDBz6fJcxDfIXqmBQfVP45wXhvGGlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QZIOBC56FIf+j7e+mmx2rt7Pv5L2ZmwRn9YmNmrLxqs6LBv02wC7Jq28eURb93lCObhkMw4IF5jPahLpYN7An4tjQ564yvNBJYvFmwoGHYEg56Fi7UmRyFGv1qk/44uUbuNCMjasQJ+9pzoXrf52rKzskQE6d52ICLQsoq6yQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivIawcHw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so2139485a12.1;
        Wed, 30 Oct 2024 14:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730323846; x=1730928646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNk0fOb9DIQVLHw9i7VYExiUbdtUJ37rSb7ICr8WfBE=;
        b=ivIawcHw4jSAA92xt1hV2jRd20SAC0jwiQqgdoB0HCCP6Mm1YxiU9tMhoW8fquPytt
         Chvf7SJEmM3CB45sibnd2woYWdfcBgky8Ajd5lfi3d1+9K2zE1yRW5dkD25Y8rAAEF7x
         +rJnDYnhnBNlwU+V/MZKTlQrpkIBC+D/dl9U+RWw6/kJ5E+Ie4ZFBZAXOlnQOL1wGi+Y
         ls/82GhVs+gbJ2FyuXSr2T7EIeqqV8+tcFeUK/EJxA4tnyBaJAmk859wewGQCKxY4lY8
         T7Swc4edeOmWE6cD4D9VLvBA96Z+8nVU2WVLBqf9bQ1OjZ45yW42x5lLHv5VJJwLc9ML
         1WKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323846; x=1730928646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNk0fOb9DIQVLHw9i7VYExiUbdtUJ37rSb7ICr8WfBE=;
        b=mFSDfPAOTsRzpJjL1kmf5ehstc0qkZgK8TViYPA+/9T12aG2s24dcNaYzBhunwxGPd
         YhaVVCc25XXke110J8cAJin0MlE59zwf/EzrXaqAjNS0tlKksJDvh1Lih6gVxBjhCnWi
         LJsGTw8Jd0j/vHgayPIGfQcWF7HxXtN8lHYd2OjyrGNWuUl/b2O6OMzwnJERfVVAGsxR
         wyMMnaAg+3d+hRCAwgs9IuXj8OKh0oUZYW+TlZCxKDeZtlspWzuGqWIJoL1pU4qRxpR9
         Tkdvgjzj9ohIXROdblUbn5zjllGaSBWrXZJi45N9oWmZ2xEraNTVXTqyeNJHFSxmuyst
         Tj+w==
X-Forwarded-Encrypted: i=1; AJvYcCUfmm4235LPIbXGG6JLWMoRwtytTrtdlT63w0XIFFbXezYzZTRCrn2tauyE8AHkFNXhO8EsxYvgskrW@vger.kernel.org, AJvYcCWD0R+oKpSUyjEsrrXz41yFVhBYEZ5zKIlsuVQNBdIX7UwjGaolyNYFdvlpB6A9BXvLvpxfHw1+kYF3w1qL@vger.kernel.org, AJvYcCWt90MUNkZRFUO67xZAl37sJnMVewa6R8EyinYzCsKwhCI0qDNyuvWSveCyZrl5UKnuRuQe3K+bsYlI2Q==@vger.kernel.org, AJvYcCXPwGUGHuSWFeC25R3eoNu2k9vHXSUPoPh0ETIbtIv1RZQdcWimRnDFZq/hhLdbkJF3h1UxMlQzm6gDOuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5ZQpfMiakOhzWfuxNthoYhtzF3kIixNgwGV9Ki6QOetBuZjC
	fuacUBC+49SAEjfGvAMP/b1Yy6nHPIM1fJ9Xm6xMK2thZ1xBXAbl
X-Google-Smtp-Source: AGHT+IHDe8EnUg6S/Xo91skwUa8BMKfGILxKvwzsg2o97eP/dMfXTYal1TLgSqSDMHQGKy7rJHP/AA==
X-Received: by 2002:a17:907:920a:b0:a99:f777:c6ef with SMTP id a640c23a62f3a-a9e559e17e2mr14344966b.3.1730323845866;
        Wed, 30 Oct 2024 14:30:45 -0700 (PDT)
Received: from [127.0.1.1] (leased-line-46-53-189-50.telecom.by. [46.53.189.50])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9e564c5410sm687266b.57.2024.10.30.14.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:30:44 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 31 Oct 2024 00:30:36 +0300
Subject: [PATCH v8 1/7] power: supply: add undervoltage health status
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-starqltechn_integration_upstream-v8-1-2fa666c2330e@gmail.com>
References: <20241031-starqltechn_integration_upstream-v8-0-2fa666c2330e@gmail.com>
In-Reply-To: <20241031-starqltechn_integration_upstream-v8-0-2fa666c2330e@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730323840; l=2343;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=y/7jYmf1JcJqTTDBz6fJcxDfIXqmBQfVP45wXhvGGlI=;
 b=tPM41zuqSg3jDLESeDd26sT90VH3+D70KrINRfzxhY0VXwQ/ZoiQdHhvxz+dLPz/cigTpbmUg
 TcrGRTWNDwBDqKcLV4QkG/1HnCE88Kkr8kihd/5/yYEPWQEtaa59TO+
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
index 45180b62d426..32c018c5d088 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -433,7 +433,7 @@ Description:
 
 		Valid values:
 			      "Unknown", "Good", "Overheat", "Dead",
-			      "Over voltage", "Unspecified failure", "Cold",
+			      "Over voltage", "Under voltage", "Unspecified failure", "Cold",
 			      "Watchdog timer expire", "Safety timer expire",
 			      "Over current", "Calibration required", "Warm",
 			      "Cool", "Hot", "No battery"
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 571de43fcca9..247c2910ba34 100644
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
index b98106e1a90f..e96d262f3c2b 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -58,6 +58,7 @@ enum {
 	POWER_SUPPLY_HEALTH_OVERHEAT,
 	POWER_SUPPLY_HEALTH_DEAD,
 	POWER_SUPPLY_HEALTH_OVERVOLTAGE,
+	POWER_SUPPLY_HEALTH_UNDERVOLTAGE,
 	POWER_SUPPLY_HEALTH_UNSPEC_FAILURE,
 	POWER_SUPPLY_HEALTH_COLD,
 	POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE,

-- 
2.39.2


