Return-Path: <linux-pm+bounces-18814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 013B99E9237
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 12:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA06718866E0
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9923E21B906;
	Mon,  9 Dec 2024 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYzoqu5Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6E721B8EE;
	Mon,  9 Dec 2024 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743763; cv=none; b=EYQ3+lI1yDy+oL88rRxezS0nFXqjwZVb23VZR0lsLUu+0wpsK1HFU1N0oDDjzNM0M9qD05xLU15qiJnn4J2HSp5RLNLXn4xi9yXiQG3vWifs8XxelHDJohXEnFHIRvWOnx3Y9TW9Bk8TlKysnBWhZV34cT+UHKqgMW9gapuhnQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743763; c=relaxed/simple;
	bh=w0q8rLNlEn36s1ZZTa5PlSCwUgC3hcO3Cuy8zeZ1xD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dikQa6uyQAZWEwzezkWajxajMDnfEmuxwvjdyHJUc6c+uAf7RfXCEmQW+bmzuiIRNK2x3Sj9zgCZxUFoCmuMERiOpTZvVCA8b1r1UW19pKFE436Yj++08O4qyU+5jF1ADB9YP42Bz9Z5JVN1mB5NSfXmQWZNGUlyagw2bZRX/go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYzoqu5Y; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a68480164so569665166b.3;
        Mon, 09 Dec 2024 03:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733743760; x=1734348560; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKaMSh7JgpkFzTixh+i3hm1CFn8OPlofH+VQYbnd7Xg=;
        b=EYzoqu5Yt1zaagvg7HKVmquKbQw5lWl7L+BtLMHeCfGL+igXRiGTSeGXLquyae6VDz
         809rFfQ+LtgFzcW1rSjxoRMzVO5ZME/EPLnJeCsaaf5L0E6GS17WZYGY6/uL75ybImZ1
         WE/pDBcVHeYdeF9g39W19Dh1EHjhp5NXxxtt3rCiaooUghyixF15Q18h4ZQlNYosQXzO
         ulL9Et85uchKL4Uvvsz69v8nLSf+2QjbvH+Kt7HCJLVw04J5RBGQcjg9myPI13hd7yw1
         2T5tZjL5YN3peDOGMyY1zQxMZENpwc0n8NepyHjKNU9CQVH019vI7MvS0+4K5pxYBS+s
         055w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743760; x=1734348560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKaMSh7JgpkFzTixh+i3hm1CFn8OPlofH+VQYbnd7Xg=;
        b=m/dDkcNW4E2eF/GncPoxbkhp59NaiY+ghV0dxEQlSlI33EgO1pUcQNnkX6UfEY9VbV
         B3wd1GmdC3R5sfCZ8SpP1rWDCNcbDWJCMLCtm1MjRRUWHwQBafC+6+P7LxvO6f21co6G
         DcfWwYgZRF/GXluzt9gseVLqjgAXmMA5akIBUcvwIIuYibMyNe3qrjPnH5Mf4f+LFpjw
         AHEuIrqVJU5pRH+TBFhigo94GnyGnoHBCiajPscdPs4dQocdAFpgyf9FFcxAkkDmYgg1
         gPRKRNGECCpqLZjBmjRZzp+GAwzsClyyj9ffSL1J5oYXhRouba0FaL81tfw4V4shBlHh
         F8Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUuEnkexRQtFA7dh2jsBbhB3u9Q8HHgYi0mJctcwVXj9iHA0mJuoQlr4dKTDNrxnTL/rtYcSZeyWRYYTw==@vger.kernel.org, AJvYcCVYdrm7YBQqlppG0fY73EUjLrddBuy8nWTSoF1mO3IKIv6szFRag5Z1/3KuoYSHvaynSt8x8ABA1zpq4Wc=@vger.kernel.org, AJvYcCX+YOs/5E524+xKL174aU1XneyPG/pJVnG2cDe4orLy+xDzDeeTxLYFfOTQa2WF7A6g/ijBjPsx93NS@vger.kernel.org, AJvYcCXCGxFOQBSkzcSiE1YbsXzHd+7BKds2HSPnarr3uG7l5fbe88UU7zxUksew8XAbljdcgUZfr3mSQitOUQZV@vger.kernel.org
X-Gm-Message-State: AOJu0YxuX4X7OE/JgD/p7Xt+IHI57mv/+7OPYpGNu+Yiws04M2hWBwyj
	t4Eiy72JUGkjSxAtuR1Ko0Iaf6P+CIsHkrnKA7/sUNA9rCD4W5ZYZ96hSkHb
X-Gm-Gg: ASbGncssEgHSmWD3NZyj2HhURVa6vdDyLYTQ1CuBfQ+8zwFoEYYyyog4UUfE/EtG79S
	cbe2jBszUdHYhqBM/JnXxTLd78/QoVbuFF9q8Ek+VsTJMKbNo60BgIyr8dKDbwYGcGj1s8FZPOn
	MyrJCdOF3qK1S2m3SXYG+JIzHj48sFb9/HTS5rCuz+PYqUdcGfT1zy2NOmClrmFbKeblTEURn8a
	ZBljAQcddcLRDsRvjqlbgYqVd7Lgy2KCdEN4SC8LffUdYqo
X-Google-Smtp-Source: AGHT+IG71JrYd26BSFxXv+0U0QAIuW9ZnzerLPbx/c3JNhA5JevN+OJI89AsRi4jXhVm80DPvvqDdw==
X-Received: by 2002:a17:906:4c2:b0:aa5:308c:3489 with SMTP id a640c23a62f3a-aa63a2519b0mr971929666b.58.1733743759766;
        Mon, 09 Dec 2024 03:29:19 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b608faesm5980350a12.44.2024.12.09.03.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:29:19 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 09 Dec 2024 14:26:25 +0300
Subject: [PATCH v11 1/9] power: supply: add undervoltage health status
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-starqltechn_integration_upstream-v11-1-dc0598828e01@gmail.com>
References: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
In-Reply-To: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733743755; l=2343;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=w0q8rLNlEn36s1ZZTa5PlSCwUgC3hcO3Cuy8zeZ1xD8=;
 b=qyb9HK1XZB6acVNb7GFFm4/lqnt/97CSWSRh4qKrbW/5CSwEu5LDoZFanaNoMs2h8TDk6Zjxt
 EkPGXwWVK+sDR21lL+b7ZBlV5HSPw392zQJh8Ujbdojrzl+nQMZDUwq
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
index 99bfe1f03eb8..09e3f544aad6 100644
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
2.39.5


