Return-Path: <linux-pm+bounces-18325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4A49DFD97
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 10:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8AD2835E6
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 09:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069811FC0E3;
	Mon,  2 Dec 2024 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQPt6Asa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1721FBE91;
	Mon,  2 Dec 2024 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132890; cv=none; b=OCxL/BHKsx3rgqUdZDODxi9WiNpbQSmYXx1+oR0id9h3Mj3DLFEDJq4aeDtzh9XKlcqlfWrqVjMYD34nbg1JUGimNRD8/R7MqApCy5ULrauU7Hzx4zrP/DTI/KSzfpJACOgpq0WTloNYCTGtggmRkOcGKTyIfY2672K4FBtqzx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132890; c=relaxed/simple;
	bh=tdGTuOCygyKLTzrZkn4w+l/pmKktzi0hDq2Y4cLiQJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aGfm4QhBxpO29FC3sPLIme6o9QkWq0RGLc/TfmhEDG4LlmSENQZziZdxCdUihMytQzvIk53Z0H/tQvE4vzOXtgKCZC7UYddbyX/n7v1pvc6LzXBq/45oYpxKD6w7Z15ixT+lX0uL8xxv6hsmtu7Uk0qRXHMMTAvGhlM71qMdWrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQPt6Asa; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa530a94c0eso660814866b.2;
        Mon, 02 Dec 2024 01:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733132887; x=1733737687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKMQu9Put2whTLlJmXR7bTTxcNbkqOf+6o99Kc/4Euo=;
        b=JQPt6AsaOfPmvZ+N+L6FgragsTyriJGhbg8y/5OwiWQZBWP0h7aK6YT3oG7MSSW7tw
         5TYwYCcreShaUcc3d6sXBEnE5gOrRDiWW2UU1z/gkiC1XuedZRi5t/qt3HmNbX61Hm1o
         r2ZXD8l7rXkXi2SIsLjSQ3+uXbZBcwd1/G1cQAD7iMo7C8fs8u9B1A+AhK42/huriVzB
         qowQ4vmuZlsTxPobnVwBPbscVP/kFF/HCV5sJ/AAnx/AOswq8TPbpTGkO4XBaeKq4/FS
         /753fAQpU4lXuMKViutYdktm4xmtE/kdmDqqohmxH3wgVlu1/gwbitUgHjQnMC8esqzn
         RZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733132887; x=1733737687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKMQu9Put2whTLlJmXR7bTTxcNbkqOf+6o99Kc/4Euo=;
        b=kHlGhuoZUZvMfyoQHAdEGGpQVJqzVEBx9AcremVVpLKzM5a4D5tmaOzmvc7YRMfhHp
         OT8brkKXGtf2544DJceJLr8ecnezP7215JgEks+7ldeZz3AwIyQzZXntPpxIDv1mink2
         l6E7Lxb51blSSqxCkASh44zyFM/Vg2QXcuATbLncWW6WMczuhg0c8a/pNuGG9bEgpyWN
         HiH3X0MTs2U8mhjd8VIyt5hvG4u+n1Y38cAD0bqbALkYh0haPC/sYDlSEo5/uf+AoMmA
         jbNfEO0RzKz8x2ALn25fbMYNRLrjmMtnCizjJeb5fqngESpKKHxhCbV5vbFttsCl44ig
         1Pzg==
X-Forwarded-Encrypted: i=1; AJvYcCVvvKCNvt589nz2cjpon5HFiDcpVBgIqxtxDfDYHhp3w/eCAPq7CLyjZLsYQaQqIBxp8awQeagl2y3t@vger.kernel.org, AJvYcCX6agzsN2eWypjfJ1xs9OlqkIqBK+v/IVslY1fpI3Rib6Vkv5p4EIm6vLJYuFHVpO0IsXQGKUbNxeLjR4U=@vger.kernel.org, AJvYcCX8rmw4h5/J8NsSnplcvOHOAFetkPwsX9lKuNnZdN5aykM502hobcyIGwOzrEUtNAhNZaLI7O3vKeI0gg==@vger.kernel.org, AJvYcCXNm96/+Ph6R0rNF3LEnt72evjdAM+rAhSCGCcInRQteqIMWuZvsyEyeLF/Hv77tpwu7my9iCAdtlFpi61P@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr+MVpBdgJ7dLA36GcwItLuaV3dXBfOJuFVcoBimltANM/Ri8S
	mD3HzeN47ncR23hvcfXz/zj+oyG+29QN9Ovvbr8TTZVKmZmp/URa
X-Gm-Gg: ASbGncuGp/PeLPwZWB+S5ccZjLbNGTRu6VmD2EvPcqzv69HH43IvqH26FaFEkr9kzks
	RfPt/AIsIPcIuEmjJbl+UplVLmKkPmP9S5IJO9jy7XRSAbBl6mEPywcpEgOwejAo3AKJxF4XVl9
	uTs9uKzcNhjmsnE9LbtqbT/34nsw/ZXSnETmQzrLh8isTqp6ZCpFigi4TKaTnsJPLh/NEWYX5y9
	EMt1mq3hJZWj121EnKG54GXO0YmuyXuIbB5Dh/jTIlQHQdZ
X-Google-Smtp-Source: AGHT+IGJh660APdyPaRenyDkc/Sr6gQpwtz0yPFS9TqaLYSUTvYP7MviS1z06zKjqFW8zY4aBMR2JQ==
X-Received: by 2002:a17:906:3085:b0:aa5:35fc:cc21 with SMTP id a640c23a62f3a-aa580f2be0cmr2006372366b.19.1733132885771;
        Mon, 02 Dec 2024 01:48:05 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa599957594sm487059766b.197.2024.12.02.01.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:48:05 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 02 Dec 2024 12:47:54 +0300
Subject: [PATCH v9 1/9] power: supply: add undervoltage health status
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-starqltechn_integration_upstream-v9-1-a1adc3bae2b8@gmail.com>
References: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
In-Reply-To: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733132883; l=2343;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=tdGTuOCygyKLTzrZkn4w+l/pmKktzi0hDq2Y4cLiQJI=;
 b=xgO7pUxB26f/cMg2PFnh0BWsWGEwTE43hhHhmBylkVzSIk0phGl5iDzv9a2RN9E29v/RE2Sfo
 SkWeE3g0OqFCD8L2zzkOcmnADJQxwSpXCbyH/WR2A7tjgeK34zuwKIc
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


