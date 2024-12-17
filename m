Return-Path: <linux-pm+bounces-19379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5019F53E5
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 18:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3263A1886B96
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 17:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250031F8919;
	Tue, 17 Dec 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2QWcNIZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406401448DC;
	Tue, 17 Dec 2024 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456639; cv=none; b=josSxOt7/Z1Vb7zJByJ+CTNp87ZfsUkCDGgp5eFmIvOTTNNF1+caJYTevnWIcYYrdTHwnfbkkuRcJnmZKsLqJsmtnGTiMjno7svpaDcy1l6yUIqMD7NMevBTXfhgAttisCvhMsjRbvwzIeckS4mi4JGDDRhNji3VGTGIXmtGllg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456639; c=relaxed/simple;
	bh=bo2DbfNN/XV8PtjOQRgHUQdty7u8Klx2lq7gG+DGLCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPHkkKmaWYHNxBsd4FDmLsVAWSpQcAVUn0s41jAdfymYwMIJ3ZRsKoW3FKJ8M2WYyFfajaT/blegsAuf8elClnTyvF2/JSW684hSoUsuw42LlFMZTuT5u3WanVhID67AywWb84In48iSdyt2lkaO50znSKAvRyrWTobTwkLgcSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2QWcNIZ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa66e4d1d5aso898568166b.2;
        Tue, 17 Dec 2024 09:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456635; x=1735061435; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZy+ohxzeE+ar21picC9h4eYdaG+4qliNlci3KD4Vgw=;
        b=J2QWcNIZto7yvpBQrh6mKvrblVxLtmlC3JUhf5Y/Zt/KUbeQwJm2tujQOIvgusdpeH
         OxQtg6/ukf/qG0i0qAZDAbt8Kty4R5sgHtx5KI/RjBs7r2m8URM0HPZv/0EsUYauOBt8
         SQlWvdZEx8cjc5Bl24O0YGoVqC5nN/N/wedkjlsO7JKYQFawBAfQUG/eqxRjc0Da7m8w
         G8kYqB8fURb99e+wh7ROZF9pgzB/BXqu79hpSje6BKD5fRJ4Lcw6CapYSg6HedEEybXP
         Tx3LE1WQqRwQ+WmtOYYXKYoSTX1SpRlCGF9W973gHZhIATRBNlIi5HWaLmLgyVwUzaLB
         16ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456635; x=1735061435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZy+ohxzeE+ar21picC9h4eYdaG+4qliNlci3KD4Vgw=;
        b=oEgmersRMyTI7lzDsPzlqPgd4hqE6xOvXJsNqkABI3cOavWKGxTbN8HjLf8ciWGV/v
         CvqEoMSnLObzhN+/9kHVNgWHaDUGu5VFF8aUUnBWZhTZIZkabctHqyvc8zxxnbL5dFi/
         JItvN+Ripv5hfeuvIloiVq4XxcyYG42nCoyyeWmgoz6Oe1ecpd8T/r92XmiiCykoPzop
         OjNxXJHaG4MkRRtDnt09BoCXCns+tBIauwRtsAcQ1aZPaGwyq3LmEFZ48q8XoL4bT8xs
         9UWyrP2bPpj/TsaIGecym1LV11Aqc2XWarcvIm18gder2ahzn5hM4RDaVb4VfT2QsjHL
         oMgg==
X-Forwarded-Encrypted: i=1; AJvYcCUHRfvTNJZFtvesd6p8zUj0q091P/W/1Ep/qdTNPQ3Aa08ib/r+mnHRfH9H4J9ROVfECV2pBPn83k4yv4Nu@vger.kernel.org, AJvYcCVZXm1jCRjxudfOKcpOCcELsnDbzi62icREKgkqj/e6ZDLvNxDUZhpQNoEJfeaVV0WO7rLIIycfCGrI@vger.kernel.org, AJvYcCVijTEppTC6POJ6pYtwgo++Q8TdSbse5+rrHHxaIS+8cAOLhSIaYLyzMRjLDD1El0iaY69v1BQVBOKsjQ==@vger.kernel.org, AJvYcCWTwtRJ8ZKgRGB3iUn3Re5s7aEin992Co+RRIEAcCEzlsUOhZ8LnCrM8PJV7kjI1eCsdam2EMerqQeUVWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzkqHBbMblzGhLMU9konJ/WEYDQlPlxHoxNqyrVOhcgAOQHgV5
	dpMqmGRXsrKy/XmyngvDutFwPM0ae3KVhccHAWwkK93Kcwnw81hU
X-Gm-Gg: ASbGncvOFtCvPkxczOHObaVMtHgt1qp6TnUVCnj253x8WgQGvJTJSKAh6WJtqTxLy8w
	jrxM93zZpgb4FrSHne1Ji2sqQJVIfa+1DWYjC2V63oF8OLpXF/GPCtu4z2AC9mtgkEObeJOSPkb
	zXUPzH/Yeyzo/Hnm3D97t+lyHZrn8Tce551zOzlVLL0M/yhzvH81o4OcpAYMy3Btfa/fANaqFgn
	lNqVOnQ/ekL+UWlXfNiTgPOPBrquovtCVT2FTnwdYxEcametDNy0IM=
X-Google-Smtp-Source: AGHT+IGMkuBncT8lElD9P3YrJ70TME9c3m4qa9hU2ssUTgbon80nWBjZySY6aCea1aCoalXp5XwBJw==
X-Received: by 2002:a17:907:94c9:b0:aa6:8186:5cab with SMTP id a640c23a62f3a-aab77eb0050mr1580211466b.54.1734456635427;
        Tue, 17 Dec 2024 09:30:35 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab95d813afsm470444166b.0.2024.12.17.09.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:30:35 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 17 Dec 2024 20:29:59 +0300
Subject: [PATCH v12 01/11] power: supply: add undervoltage health status
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-starqltechn_integration_upstream-v12-1-ed840944f948@gmail.com>
References: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
In-Reply-To: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734456632; l=2343;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=bo2DbfNN/XV8PtjOQRgHUQdty7u8Klx2lq7gG+DGLCE=;
 b=QJ+YAFJnHGGHjUI5m+u3aYVTvUx4EpohYZTIjiT5zMWnkzwvXD0fDJzHx/ldz47xhTeNyPZfk
 TY3hM+3jZSTCFFmJ2msPA3ID1wY3oRYO2Si8WozV8+v27RjZ9HdyWpU
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
index 74050dfb5fc0..546e36802ff7 100644
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
index e18f1ee53f21..f440c8a54aaf 100644
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
index 0d96657d1a2b..bb3c33de45c8 100644
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


