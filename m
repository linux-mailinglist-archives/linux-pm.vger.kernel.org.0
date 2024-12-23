Return-Path: <linux-pm+bounces-19687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB0B9FAF14
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 15:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A20518852DF
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A751AF0C4;
	Mon, 23 Dec 2024 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keKU8rvK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D28C1F16B;
	Mon, 23 Dec 2024 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734962398; cv=none; b=lr7mQwEaGqKEJmMEp9QdZZ8wsMIQ825pOKK2IiQamXK4QaPA3AYiPEtg7uWbA2fIglJtZQVVOAOiZU8hAZtItkrxd8dNIMtqIyBEFu87Zjd8nk7IFsQbGIbUR0PnkIUWSeQCzyFMLn2t6wvj30x/qODYK/S421VBZBlTzDW6Avc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734962398; c=relaxed/simple;
	bh=rXMMoUEBWsz761qBBGBqdbWKIdj1EFYCUeoxnRId9F4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u4GuaGLmGkrrX78FRwz9R7Zfz2dFeKNkU0+DnAt9r3k3LXknLLvW0GuppQhLJRsUaryF7cWvQ3dduBlMKscdtLvJxh953VUIG0aA4yjuxHWMsX9ATQPO6Z2aK4qPRMkQMdlocB9Hvpvet2QLT7M4vcMk1t+cHhZoUgSMqNNLKIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keKU8rvK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa543c4db92so510281066b.0;
        Mon, 23 Dec 2024 05:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734962394; x=1735567194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EemsH4Zp9goG/DvipUIIJ+D3oeBJrKh5E5A6/JLDo5M=;
        b=keKU8rvKGx6nZBMxPFkhjAw9PRYqXl4kVGZ4ldcQfv/dYOqlYZBXrCotSeUmrWoeO7
         ndOAGMnyqZ1Sn1OM8gv016M8iBqPTO7La40FX8bFxrKs2ixWoQdKTDZ+BKdBuauxGuMt
         CASuGGzOVw6sBLYj638jYX/mh+rNo2Ho/OAkpEapsrvMLG4gw9scd7ZAMvck6RQ0+12p
         3NgJY8mcDz/uoPHyOtXG9khRoQOgNlvjW8bzHLQtyDhpi0pndKKa9sD08yFsoJoRHZyy
         7PGsTjYITXV4Y0+r3T//5dNjaT3NmCNwgh6iQO8hoF75SzNUYm23nB/nGRlJD6BLgAMs
         aSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734962394; x=1735567194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EemsH4Zp9goG/DvipUIIJ+D3oeBJrKh5E5A6/JLDo5M=;
        b=Cqw4iSRh/GjReote8xBvHLl7TO2x7i2VJEVLZLwoYtAv78e/Lcj75ThTFcTaltqiiY
         jcVPcViWNDu4AXWzSCXDp9su5hDfsGsu/mS16ZuRZWfDLsIsqqQxUU3rZsJzoZ291mU1
         4M4i3M/inD7qdrw5NyBfBUDzlMzUhU19aCgViPs5/yDAFVD1gRowkaMIbr3oC7L9h2sU
         sMbvM2LW35lM2o3t4YJbqNxNiKk+gC5TGhTlA3JLGZyO5lFyNa22bOT/VXC2aAOUa8do
         VO/re6Iv7FrPBTF4+CMIuAH+QTtvGwU6m3zk/KDQGtnO6dl+OpLUvsRW1IeQe5dEsLe2
         +QQw==
X-Forwarded-Encrypted: i=1; AJvYcCUymDn6R0SzVsvqNfgqOeZykFNfF9sb3+kcZyble206AhCX9FSsjkCx5hkNpf+k85Z0tW6pEzWcLt7kT4mr@vger.kernel.org, AJvYcCVK6PXqyqCuXv6uoQlmd4qhZn4mi1ADe8t6NKTmq4oyMakooDKAKdDG5lNI0pEusM9EORJIU35YozEC@vger.kernel.org, AJvYcCX9I59kIWr+qFFI+3+F2l4O2igmo27ht/nnRD19KvOMzOnZYNGV2wnCxt6dpfWks9B+qYSlRlutPostGQ==@vger.kernel.org, AJvYcCXYI/R2atIHZ80/jTZ9y3GwN4Tyw9/jE4m7FNIlCqL31Lv8aGjuQA3rqECc/+1UyviC4RSwOTJeA/zsCQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwi45TO+qXgM/9ZgcqT/kTybcJQaL/oeFSXgvveeaGfmkGbzA
	DnuOEQQjY5DU6K9CxFEIpeSckkMLAewYhLS/2beOTDEJWE4leG9nhI5rHA==
X-Gm-Gg: ASbGncun7r16QhAmZhbqu4V2eXS6wxbXFoFya/+d5oYbcwGguUtwUMn+cBkT4PYeCWn
	oS2anbKqO9qyw/VEtwQKDBliG3DQuPeYhasYQrDcRQ7QhmTjFhBcW3fBpDX+yO5QQ5m+xbaOVN9
	SrxVcc79cyrWQ71hz540Gi6N8Jtn1tMXjkZYaDR9/EF0M3P4sUUq+HHEyK/Ohg4ZfL1+VEOD1QY
	Lozgk6AG34rtAtgkTwHoYeQpftI4edICUR4XWCtUGfrWM4wzbA+1r8v1U3v6Bym61MySK3N4POT
	pMsVjz6p8BH9eCkLWveraG2vpg==
X-Google-Smtp-Source: AGHT+IF0EbdUr/tJzpVwdi1m5M2HcJk6VLrzISyRN02kI778SSneOk1QaXf9+pybPSYjkL5mVa8DWQ==
X-Received: by 2002:a17:907:2d29:b0:aa6:9503:aa73 with SMTP id a640c23a62f3a-aac3378bb24mr1110351566b.51.1734962394159;
        Mon, 23 Dec 2024 05:59:54 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ca31sm4911485a12.88.2024.12.23.05.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 05:59:53 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 23 Dec 2024 16:59:38 +0300
Subject: [PATCH v13 01/10] power: supply: add undervoltage health status
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241223-starqltechn_integration_upstream-v13-1-fbc610c70832@gmail.com>
References: <20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com>
In-Reply-To: <20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734962389; l=2343;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=rXMMoUEBWsz761qBBGBqdbWKIdj1EFYCUeoxnRId9F4=;
 b=R0CTiByOwCpn2ajKwfow2P3ccBfioOfzIcXuNCmHH7ekm6fLRXch7MHrPG65WHKorMHjnXN5D
 bYo54tmz09fA7ln5bT2IGXBbXhiWpiqcadnK2jD5eHoXKm9OMdydZn0
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


