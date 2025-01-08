Return-Path: <linux-pm+bounces-20096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3B6A05E47
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 15:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483A47A28A6
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 14:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19A41FECC1;
	Wed,  8 Jan 2025 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjqLBZpI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C51FCFE4;
	Wed,  8 Jan 2025 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736345658; cv=none; b=J8SmJ7tefuCmSAzA2joXJVHU42Bqf8/QC46EiR4xEErzPB+y7hiaqoX/qvpw24b+tk9BJlBbNOG3zJlocwrTlgyCLseXtw72v3Kpw677DY78DqnVFLGMh0E7TPvublhMKU4ZlJZUCvE6/SIDr0xewsXwQtmh4k4l3vPzpVwnp2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736345658; c=relaxed/simple;
	bh=iiRnf4Wt6mhhESchgHXjPJDU1ILplxAAXBKmr7mHB+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YxqQPBqO3HpWO4BtgNTgeBZrAeMYy4QEQuhX7h4z396lWl1EnuCq0NwGlyLuQHU596wuGWaEsk+M+j0vmYsCsP7nuIaBAyU+4pU91WPqi+3wneV4lVn08F4FiDO0A6wr2XndlJOHszjpUpSGtePJmJBIyR9etKzxlh5iVyGDH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjqLBZpI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so2430176166b.0;
        Wed, 08 Jan 2025 06:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736345651; x=1736950451; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ny34XKwUX+MJKcT29KzUxMJWJuevNw9zT0IEL+SXaPw=;
        b=ZjqLBZpIzTOasYhyIQmAh1j1wagtq7WJzft6sJEu6e9X2EInf6m54G/G132/k2tRBf
         Pllnuy+EgHptzwLJySmh4szrPsZ6NF8opbBrZ5NyvZOCtpGoD/EgulOwCHjUzm3YZULz
         6CTTjWxQVBYygA7K+0Zu75Q32cgrVG/D46S21vazJK3nMAUuVQhLn5wM3vS0armge3mw
         CfXd04h1OEES2YahluNtmlw8V0ZqqzcdRVHG3vjeW4VGPF/iWhbGYvQDu/iIUzhMy9iv
         RpV4g5Znx8/szghwawgV2LueF0by61f4gWGnkXrMPLk6EXKY4cyh5e1xBbnBVCDqB/0N
         D40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736345651; x=1736950451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ny34XKwUX+MJKcT29KzUxMJWJuevNw9zT0IEL+SXaPw=;
        b=XpjgDDryPjrWXCi/CeTKARHwcT+wGf/1gRBvfNBO8VzvyDv4soIBsaCHr411keFKsc
         HD0JezocDGvH//47K49jdku3aMrHR/AiHIpj/qauVcFBPlBjosiEmaZ3nHbnXSDQ52eV
         RQvCopKu7jT8G0y4btsmmL2HoUdRJH0k0Hg9TEWHkVYt4gE+ifPDFlms6v/Z7mYT5k+t
         VHqiBsFEiG1+ozQeFTt6IWb5AmSjMTQ5z1+J2sRPx2mVEDZ1nDykBFoWIBQHE2MwU86v
         GZi9mSyJ2+Eb3Ur+elcxOL8xGfUFVDZu6z4J0/WpQ95GdsOMSOheOXo8izKAZHLiQUtf
         wLJA==
X-Forwarded-Encrypted: i=1; AJvYcCU27oGM9s+qoiDWMXFFKDSbrO4LhyTMpxCtl1R2g/CmMtkln909ciNnX326a4qO0uMjBSIGRZ3MT2CXEQkx@vger.kernel.org, AJvYcCUWWwimxxVgjUk5lAhdn/zwb3wy01Aj3QpJQRGhWEj2IjtXiSxv3OMf4eeeXRb1Mv6AWKShy8neFHt6eg==@vger.kernel.org, AJvYcCVTIINUIzkMgWyIMFdsW7nW9hv8oApwdXG2bvk2xmxgvnvy0iU8FCqmRzb15AYmpmT+42aWy44jTRnUPIo=@vger.kernel.org, AJvYcCXGrlomKoK6XgizNxuGMEv1Z2/woQWo5B17LohtyMEFmrjVX0JW8oXDqtTdlmHCXposr2hgMj2b5NFi@vger.kernel.org
X-Gm-Message-State: AOJu0YzLNlGVTzwAJlCovs10gk0EtZGIj6UyEMpU7eOXAqdJflYQwUI6
	bGJ78OWdoLk6tQvVU5Mtqa74K7VhBwyMIZat4aFgoxTPQ9BrZhla
X-Gm-Gg: ASbGncu5LMo0mrjRWriPtn3lqpGF4E6ezvG9DOlaOvpzfc0vbQ3gPYXddmxAdpl1IqF
	X01MFIWerXT61n+Ny/WpV0G1JaWnmg1FEeytJhL4Rv33Tnir/mzTzBIFmCItXecYY/YqboSWS87
	KnZx7D7JSnkPD+OJymNLlqWfOTS0TA/BrwyyW+5OGDOGgkFx7OLL6vzXF1u/glXo1DF3u3GJJfZ
	C3IyIclqcTyUYFRGlZWbKtCUkl7tCRPKupV/zC0bOE04bWEre4lr9DnZW3EJOmJVnIV1PaHBGlD
	osDBMOoGLhCidaxLhshkwupqHA==
X-Google-Smtp-Source: AGHT+IHHnmhZ3qi0gyf3t368dwgvmTxBOD3hjh+LjlYRMGD9VRgDw+Egk9Cr6rifjtSwMfxE6RqAnQ==
X-Received: by 2002:a05:6402:530f:b0:5d1:2377:5af3 with SMTP id 4fb4d7f45d1cf-5d972e00027mr5942480a12.5.1736345650625;
        Wed, 08 Jan 2025 06:14:10 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0efe4941sm2500562666b.95.2025.01.08.06.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:14:10 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 08 Jan 2025 17:13:49 +0300
Subject: [PATCH v14 05/10] power: supply: max17042: add max77705 fuel gauge
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-starqltechn_integration_upstream-v14-5-f6e84ec20d96@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736345640; l=1366;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=iiRnf4Wt6mhhESchgHXjPJDU1ILplxAAXBKmr7mHB+o=;
 b=e3n/SJmIQ+m+1tqyYlTow66FpXac6IJetEnkckrhjejE7c3qZF7uIuJpA2bMBGh64zmAjiFPZ
 df67MVQELdoCTchlq/srtuCPIuK1Ly3UCRGCae4fQ/F1hXpoDkKEsbw
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add max77705 fuel gauge support.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes in v12:
- add only to platform version IDs

Changes in v11:
- add device type to compatible

Changes in v10:
- keep alphabetical order
---
 drivers/power/supply/max17042_battery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 4037843e25bb..655b3f25dbd7 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1234,6 +1234,8 @@ static const struct of_device_id max17042_dt_match[] __used = {
 		.data = (void *) MAXIM_DEVICE_TYPE_MAX17050 },
 	{ .compatible = "maxim,max17055",
 		.data = (void *) MAXIM_DEVICE_TYPE_MAX17055 },
+	{ .compatible = "maxim,max77705-battery",
+		.data = (void *) MAXIM_DEVICE_TYPE_MAX17047 },
 	{ .compatible = "maxim,max77849-battery",
 		.data = (void *) MAXIM_DEVICE_TYPE_MAX17047 },
 	{ },
@@ -1256,6 +1258,7 @@ static const struct platform_device_id max17042_platform_id[] = {
 	{ "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
 	{ "max17055", MAXIM_DEVICE_TYPE_MAX17055 },
+	{ "max77705-battery", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ "max77849-battery", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ }
 };

-- 
2.39.5


