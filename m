Return-Path: <linux-pm+bounces-15280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D1A993221
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 17:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713901C236D4
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 15:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB481DAC85;
	Mon,  7 Oct 2024 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeujKDf0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011ED1DA612;
	Mon,  7 Oct 2024 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316567; cv=none; b=OmRSze79L/JH6vbXt9eFsfPJ1aIuH+SMxjRDXEjNK4ADRchkfq4QgnUa5rvjP5cnb79AEh1WH2bXAGVCb/Zjal6PdxsKLN3l9LTaQryluB3cnUFm/V+ui+LX1XCzcjFnnKF1QqDtVGydh935TrYytDVBHtsu5IORT+IwdBtuewo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316567; c=relaxed/simple;
	bh=HJ0A6QCUdODL8Ly5y32DEfhcMGJG5BnjTSkz0jr8Gvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BStea2U9AwmCB43zL1M+24CC3jSV7BeiFvG/RLtGUQpRZV4xhaGQzCJd9UOqdS59AyMyizxJhkGuii9gSPj58/VUDsu47RDU4IX2HmyPYl8ypP7t3+3i70Mfl77h5pNDGarYrMIWJE6cf2CQPpGMhYDaUujjUSGF+g341p8XfWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeujKDf0; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fadb636abaso44880351fa.3;
        Mon, 07 Oct 2024 08:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728316564; x=1728921364; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZslR+ik1mCYyj1qO5cyJZQJ3YEIIi44NJsP0OMl+IU=;
        b=eeujKDf0tiiP8pkFJWpLEBjEivyMWz1aQEcXDsNlwFCa/+VaieA4/BoVY8JZj0UkNN
         mpKPbZFAP02/9NpiS7pViz1VhMRftioKJqT6gypObEQEM1hW1N/Puubpi5RTr2vpTwL1
         Pn4V7kcE62W9M4M2FDxKmkIna4lVbc1UCaQKdfTkMWi0RaEEj+3RzIhppi47NQnKCqbr
         6B8h0PkKZH2ZFTIgECnjx7r4WetcCIsuNbT+vv+eE5EMDcY1ct0XIvKLUxXwKVa5w7t3
         E5JRhzCaKvCxkRQMhsEueUiF2M+Yfe94JYQ/3DV48VFhtQ5TtrJt/XlPvzC/gIGjQC+I
         Txng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728316564; x=1728921364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZslR+ik1mCYyj1qO5cyJZQJ3YEIIi44NJsP0OMl+IU=;
        b=KgQI1rDWpVG5oKro1hokD18zxRE74/65vn3oGqiF9p9A4Thgih3hLuU9Gyao7M3jei
         sY35SrAE9J9wCFSReKuTbrGKKofvpaxa81zA/IQS22lTtg9cMDXUCXcnmOZKCyu/K5aZ
         9DrJ2/hzdwHaTle/wWzco+13XZQVAGq0A4YXynYqwwuWUC9XF6K1eTikQ57cwI/3cNK/
         YV9lGB0yK1njmMgtkq8B39lWnjys5DZmO7C6jGpyXQGsTxsMgFU1MIuX09ZRgWAEBKmM
         KOIx/jPU2VJm1V5sXZGQxykCS3lVRd35Hh3xsmvJVHv5GSkYfnsbZ6wtNN7J/q5fM59Y
         d1TA==
X-Forwarded-Encrypted: i=1; AJvYcCULoWwUN+XEMPNMEkpg/q0jdTohu+ckET5tiMiu3Kq0H5augawCbfaOwvf+l8Q7Ly0XRfX+E/JHr8WVDQ==@vger.kernel.org, AJvYcCV0tKJM73eXchrzysuQnv1NYpWEiUfG8dSxWJakCJFBIeI76uhY5UWyZOtRxsuJvqL11Anyri/sv95V2aE=@vger.kernel.org, AJvYcCWEno3Dkq9wGDQ3+QoFvD0eKr49/k0q1KazKOJnWDeVtaXaxXdoimYU1aOGPs0kQU3JsWkFvcfNopzB@vger.kernel.org, AJvYcCXqnod7cuZRbMyRxCrktTtcYqm17L2e0Jp7LG5W6XiB9b4rNrJuqxYPGGMKuzvYOr/Pga5KSsMdxn78wrsu@vger.kernel.org
X-Gm-Message-State: AOJu0YwIU+8hjYFUHYtF1qlne5i4dMPyE20XZpBZUINk+nbDEyO9ojFQ
	EydaoMpFZSyeCCxqdkMCQckMKT/NNU7R4FVaW8KJaghp6/6jtv7EDHJd5g==
X-Google-Smtp-Source: AGHT+IFpfPPtViwn3a16pOFhkk35HDXD6wd84NB0lHbMvbwJpsbB0/rQ6oLNNXXUC31jVfqC/gijPg==
X-Received: by 2002:a2e:a9a4:0:b0:2fa:cc50:e6c3 with SMTP id 38308e7fff4ca-2faf3c1c874mr56687741fa.10.1728316563431;
        Mon, 07 Oct 2024 08:56:03 -0700 (PDT)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-75.telecom.by. [46.53.210.75])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2faf9b24a22sm8552461fa.93.2024.10.07.08.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:56:02 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 07 Oct 2024 18:55:49 +0300
Subject: [PATCH v6 1/7] power: supply: add undervoltage health status
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-starqltechn_integration_upstream-v6-1-0d38b5090c57@gmail.com>
References: <20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com>
In-Reply-To: <20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728316556; l=2343;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=HJ0A6QCUdODL8Ly5y32DEfhcMGJG5BnjTSkz0jr8Gvw=;
 b=x/qjUz5O/GErT1jiao8Q14tCeywgkdMG7JxyUhmuz6cvCIUxkpwFPvwTrr6ySWVZbH7JAdd5B
 GLeQjT0ZmfEBukiBUgc8MBMn3LXQKD1jWIRy3F6LE9hZ0mYKUBPzv53
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


