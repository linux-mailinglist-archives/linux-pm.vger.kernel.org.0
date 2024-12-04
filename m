Return-Path: <linux-pm+bounces-18569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8275D9E4687
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 22:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA0CB3E38F
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 20:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821BE1F542D;
	Wed,  4 Dec 2024 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoSPspbL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3841F03F6;
	Wed,  4 Dec 2024 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343012; cv=none; b=SGAFKJcdsUEd4qx4ytgACSqhBoXNHUsNxH4pHa6Tl4ZdwXfVboC+6C/yn8kDjBo/8oR17YOgsBY+YY682lyRRaM2eHJsZ8YtAUELHLGPd+B07nNRbX+uomsuxLevQxAbQQOI4ZjbtK3dGCVxHZ9OhZx3P1kcMj2f9GFXnB+swHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343012; c=relaxed/simple;
	bh=tdGTuOCygyKLTzrZkn4w+l/pmKktzi0hDq2Y4cLiQJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=apKgSRpjZJpZAsOLBvMIWPFwS+ey01hfqgXUB6Tp5r7G8r7n+y7fc1q4kiX9IA1GddYLy04T4nab61/jmrqU7HY5oeOzqT6JNWEp0XXv7IGOPB1C7WbhPijLfxoqLbvuzMFOH9EL0ijUOAnHImv9YAD4dWrVOWA6PWLyXSrqGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoSPspbL; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso136273a12.0;
        Wed, 04 Dec 2024 12:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733343009; x=1733947809; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKMQu9Put2whTLlJmXR7bTTxcNbkqOf+6o99Kc/4Euo=;
        b=FoSPspbLnBX8YxvBMeorznCQ9wr7rZQkWRcktqNg+0PBO0yUmYI76PiV6YCIGEkn8w
         Wn+mm7slg504TY2Zylk94JryKh4TApqvECaeKnrUUKVawRn0OF/gm2GQgkcpoHOiyuou
         PROZbRARZQdEwtY10pGkETy8Q0n3uv5kNU30B7vmWm5cf6rxWS53toK7mitjglm+8w9h
         3E0s53b2nVSEWQAJPQQ/ucvvZ4Grh7c0F+f8O9hcR0v/3C3TYCdGMfeTttBG4OWQrgn9
         mz80rFRV+DjnlBVTUXPOyjbiy3QTtyJhd248XOQ7sCfXXCXB+2zIEO/DgeDlgtAHL754
         9XrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343009; x=1733947809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKMQu9Put2whTLlJmXR7bTTxcNbkqOf+6o99Kc/4Euo=;
        b=pEJDmbdGQuYaQpv8/IdWNiZGkAfne/gI1H8pxOpEsyiuYbUhcex5dWzSwZFp01gDPS
         cqzsDoQ7cWpvAaoZKbKI7AFNLr/FJ9nSZ/0D7s/6I5TeiQzs/4T8oPHCnd+wEbnwDaMq
         emyH01JdSHfea3433SM0sb4Il/sCTouycP2SK0LBJtla8112cUANOnZsIrAMoSYNlgfx
         KqGhAv7Dy0M1TQU4x8+MSKStbp4RfP9Idex7v61R6427GK4tvEl3JBPnwwsAurNE2xjI
         YY9225Zhxs1zVboqm1yen7CIcjnMkLv986rroKinEEcw/UcEYCSoN+HcY3XWFfZLOIy6
         VY0w==
X-Forwarded-Encrypted: i=1; AJvYcCUkHihGgrAawZjKDaCPEuoq3gc8z8TWT1hqSI6HUBqQforl57iMkcKPy87fX9XdPmKF8sw7gPII8kaQ@vger.kernel.org, AJvYcCXhTUS3pJXWTomCnUdA09Ym2jleZIxQkIqsCNIeSf0eBatK5TDKVWeuHl2IGH3+0u+EPjGHRMFaJtF8Hb0=@vger.kernel.org, AJvYcCXkD2zN90lUmGu+uErTfzcB2N7KUVZNvbbeirDOHbAGMwB/paq2/OvmrTIQoIG+d8Cve81J84+i1HG+KQ==@vger.kernel.org, AJvYcCXkO7rSikKY3wHgQ5n/3HFyncSfkJ1rj1ihm4/OfhH52bwwWubbJD8Hjne6oDr7eLz1jA/NveHvUfaaAeNr@vger.kernel.org
X-Gm-Message-State: AOJu0YyjI3G9tf1uyISE9tFcAg+92/wH0Kif38e6dEFYD7bUthmZyje1
	ad6cEfpXYSz7G2sNu5tvIrxShQ6XufxDGiZc3FTCwaEquLjF/z06GtVftQ==
X-Gm-Gg: ASbGncvOHHb4o/Dx0/2aSk/Q06pyyUmG6RlllBsJj0U2CLd3XblFSN/ahjRL0PhrWkM
	sqNx+faQFjjBmVkAqLT3ozH1hRboF8l1JyKK/LaRmuVE1VqxuD+NZIcMt1HVe0eftSUY7tUVqr5
	Gm9WxTuQzcQTeFPJb2s4rYwW+OmlRrO/dCRLuympRDthlVGPvnFPn1y0bpLuZa3pN/O/SkakJUh
	AOqkCW8HRbhF4u9twmnl4fKO2H2BOmTP+oTa3N/ckk0mC/l
X-Google-Smtp-Source: AGHT+IGwXKLjeKxVeZz0jTdMNawaoorRsxT+cnf6ab+DEplm6GK1dKbSi6GDgZ91AhjzC7g7TyuIhQ==
X-Received: by 2002:aa7:d455:0:b0:5d0:fb56:3f with SMTP id 4fb4d7f45d1cf-5d10cb5649emr9607975a12.12.1733343008574;
        Wed, 04 Dec 2024 12:10:08 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d0b7ce5584sm6266526a12.54.2024.12.04.12.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 12:10:07 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 04 Dec 2024 23:09:51 +0300
Subject: [PATCH v10 1/8] power: supply: add undervoltage health status
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-starqltechn_integration_upstream-v10-1-7de85e48e562@gmail.com>
References: <20241204-starqltechn_integration_upstream-v10-0-7de85e48e562@gmail.com>
In-Reply-To: <20241204-starqltechn_integration_upstream-v10-0-7de85e48e562@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733343003; l=2343;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=tdGTuOCygyKLTzrZkn4w+l/pmKktzi0hDq2Y4cLiQJI=;
 b=ZOJIa6ovLTepPQBmB/i8cyTPdsHGMAV1RHRQ/+DQ4XvoXvYhQk074sqiIQxkDM5aRFdqgKgAw
 Gz8+g4EFYbyDys7qeFUA8O/zmm22i4jkTrySrb8CNhxBqBtNZ7bOZUK
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
2.39.5


