Return-Path: <linux-pm+bounces-14814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78529987137
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 12:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2044E2868AE
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 10:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EB11AD9EB;
	Thu, 26 Sep 2024 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2hQlHQk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4161AD9C8;
	Thu, 26 Sep 2024 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346055; cv=none; b=Q2XOxK/x4Y8EF5/3pDacFobrINEP0PJDYPKYNeGDM5OedAtfNFDJY294TkV9OBJZ7Ay6S5oMIW9sMOPn6uu8a/J28/1pq24woJiVhLPeBLWH4VOO6m7orNoxOe3Z91z0LfQHjWradlMO0hlueJ/BlvB5aG0ygx2iDXpPEfrmy98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346055; c=relaxed/simple;
	bh=HJ0A6QCUdODL8Ly5y32DEfhcMGJG5BnjTSkz0jr8Gvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RME7jFVA4n0THG4gMi5v2KBIWXR5GTVBZcjvGE78UfuZMipvmz8nlh9gn7LgB+luQ/bS3uEYajRcrSzmvCw2nGeh2nGvFQr4u5UPDVa6zWemW8o3Cx7uUuk+gRTec00RVySVOKkBzu5Zmbaw4bvDeReULobeefDLtuiUaT06L2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2hQlHQk; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-535694d67eeso869946e87.0;
        Thu, 26 Sep 2024 03:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727346052; x=1727950852; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZslR+ik1mCYyj1qO5cyJZQJ3YEIIi44NJsP0OMl+IU=;
        b=E2hQlHQk8Cmp2zWbnedx8ToJ2CsWeeMMBbgup4BHs9ceO3wHkQ/BqbSw2HtZjrfdKE
         Ui4HlNJLTWpCOOiJw1xwRtWi0cNp7U4rryHEQa+dpznn7oexddetWcm3fY9MA9pT5SCY
         piyJNKF8Rkc3SSctuu3McU7TSHU898/AIsAB+6rlPxU1SL7Ev8c29WiVZrPl7H+vrjV6
         fnIGjJ9rAhTlQcSirpTw1i2p6O4F4iPDN2Kfw/aGnEKFpnaf6706yiWQ5k5eaGqukghn
         V2vXAf9rkirtWgLqSjG74/L1VI8IevGCc5v/ToXADNk/D62+DfOvH69hrEe1sa1BBatc
         SnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727346052; x=1727950852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZslR+ik1mCYyj1qO5cyJZQJ3YEIIi44NJsP0OMl+IU=;
        b=KQdXHvzhaX4Rbwc4EJ1oSp7jS8y6l+dbB6FI40uUSCebi1fI73kinlJAnJd6lOvwFc
         YdUHf3s0LHHU19QWVRxlJv/jkPhegp8SlJXniJNcUp3EHatVPbvEyJ3eEQ/Or7EzaKsW
         q7O5Gxqwe7I7kF7GYYuAKJBMBw7QzW4USBp/oSfoK+GVDKtomtIFWsJFmSb34k7apWHV
         8IOkEa1WWAGBT0hTWdc77ojSLrHa02udZVgakcY0g9zEiihssEKhFfBaerCPYGyEn1op
         9ETieaHPdUbudeIsUYz3qySCAtTX1OmRHvkU38KILdStv0fJyLhJCoVvanWkIyqsyMoC
         Onpw==
X-Forwarded-Encrypted: i=1; AJvYcCVJxTX0Cd5agS4qOL7B2YtOHK/yenE7No5fHEkzSVp6IROP5UtEMoVasC2jzgFWRCDrAvgf/7R0fGym6Zk=@vger.kernel.org, AJvYcCWHKCKdnH/+P6+Sr33yQaB+TOKku3s8lkMDO4mpkRrgja2CJloHuiTIob6dy04SChMgNAdVl2etQ5Wb5g==@vger.kernel.org, AJvYcCWLsCwaSowU7Te7JmjYOEPqjwB4iDwblIVK/JdidIXqTDqTQI6Ro0mEgGltehUBaoxst8mtoX2RsjgWUNBn@vger.kernel.org, AJvYcCXt9OvUyi95oQZRainFKot4Gpnd6h61ftUFy+JW8TWTJkKzSxBR8TgDuucbWV8xyRIMPSqyv2yL2Deq@vger.kernel.org
X-Gm-Message-State: AOJu0YxelIYpsMN+JLUtL5GuU20oV/WdTBREW/gqxMnGKZz0m/TYWmMV
	LdP2wDDy96V9gcwVhQ1TjHhK4vcYI8kFxvvcMjdXjJz6wRE9g0yT
X-Google-Smtp-Source: AGHT+IH3Ylwe/kFzrXSbmzZR/5UQJwqKoRLCcmz8RbSfDAbTdwsnudyXoV35V9nqhTEZH2KRt8gRBQ==
X-Received: by 2002:a05:6512:3c8b:b0:52c:ad70:6feb with SMTP id 2adb3069b0e04-53896bf39efmr782010e87.20.1727346051454;
        Thu, 26 Sep 2024 03:20:51 -0700 (PDT)
Received: from [127.0.1.1] (mm-20-1-84-93.mgts.dynamic.pppoe.byfly.by. [93.84.1.20])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-537a85ee54esm759071e87.96.2024.09.26.03.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 03:20:50 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 26 Sep 2024 13:20:18 +0300
Subject: [PATCH v5 1/7] power: supply: add undervoltage health status
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-starqltechn_integration_upstream-v5-1-e0033f141d17@gmail.com>
References: <20240617-starqltechn_integration_upstream-v5-0-e0033f141d17@gmail.com>
In-Reply-To: <20240617-starqltechn_integration_upstream-v5-0-e0033f141d17@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727346045; l=2343;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=HJ0A6QCUdODL8Ly5y32DEfhcMGJG5BnjTSkz0jr8Gvw=;
 b=Zyi92JtQM5vD+tEI53WaReJHGeLrefiOfI9MNeTN+E1MopZhBG3GeTe7rsmq5ITOV14/2hpxp
 PuAE6itfR1TBmR76GclBJqklWVwZLqRfwl+TVsSO5uBeclG+vPUUBhn
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
index 16b3c5880cd8..82b2275de465 100644
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
index 910d407ebe63..8682e6466544 100644
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


