Return-Path: <linux-pm+bounces-27683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBD0AC4E93
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 14:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEFA189ED1F
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 12:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485F52620C1;
	Tue, 27 May 2025 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xX7yzLVz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A6D2586FE
	for <linux-pm@vger.kernel.org>; Tue, 27 May 2025 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748348338; cv=none; b=moqx/PI/Hn3ND5Bz7B9DtaOjU/BBS9adS2Yass/ZdvDvSVRNwxed82fq2vse3RpCNomBPdtROVNQZuTLl+aoft2WCfmd1BtfLP0gFvIzX9AyAEQbWa3ZFg1UWIby+hcavPT1fHBpHyYs/nsjDpOZPreQvxqtjG9GPr0i6e5bVv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748348338; c=relaxed/simple;
	bh=86zn2u46JYtNwZO5g1DsbWK8w+q5RR5pXL4APJoYNtE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GCox3mOO35jeV0+if3y5dmGDgS7/5dHi6N2SePKC5szJYXDz2FmntXymoMquP02kh57/3kH4IC15YwF6cfhdoQ1yusIN9L2g57N+RWk0/CcVJay0OoM77EOtjuoNhuUeYJ2Yjfoo0RirUYxFrJOsinyt5wMg6QjfiaV8Ya7DHpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--korneld.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xX7yzLVz; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--korneld.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a3696a0d3aso1336862f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 27 May 2025 05:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748348335; x=1748953135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kVklkqDwNsJQ+fgi/kO5TdjSnCkSRE14ziGkMJqjasc=;
        b=xX7yzLVzVtRJlK98hk6EN/EfSFIqWaGw2Z+VFBopCaC0DD/T4xcsn9dBIirfKAaL2S
         Px21qQ34+hscOXUdGkS6L0nphE6CPgEcxwnh0Cd6azgblAJTBaVrorEBdKC91DFpl0iF
         yMo81rRCbS7NmsEjj/9NwDtcvEDaRB8W/Q7oRf0VOwzpAle5dvB4VBsNWwu84884cWmZ
         rmS2eeKgKHTbuyga4eoNHN5fLcxehcrG0vlRnvgbHh4MVntRtgC1AyOnSq5XT1Ffm8BS
         e0Iek1X3Jf0YL8JpNLHa6dmWnx5/n1GzfYG+5LvmUz/DDiLCnJMUR8EplDKrL2ez78kx
         70Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748348335; x=1748953135;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVklkqDwNsJQ+fgi/kO5TdjSnCkSRE14ziGkMJqjasc=;
        b=Zob3Mmu9RZUglxvO8fMuIqeVJHo9lXCkaYJjikyqLK6Z9BYVM8xItwZDYPFaNJCxkR
         ykjq+gVLELwuq7N+eUoeSbSgM/81iwiknMbJJOXMyA4iDEE9Nw2cEAtdF01Nj5Ab5Oj0
         yrA/DUzg5v3f2ZpxbXeYf+ZBJ2u75wnEPa+C3p6QLQvoy0xPSqdknC3uIbPvegHCH5JM
         u3nwwKeK9Oz8ww5Uc4Xvw0T5r4PothVgoHc0S9mQPpUX0vNybKkoKvkzQnP1WIhj8Fcb
         ld+OHDz5o3P0jc7ddtTIB17bwR/4AdOet8BSV6SfavEuVJy2whaKJaCcb6fv/KD9hFqi
         DIKw==
X-Forwarded-Encrypted: i=1; AJvYcCX27LMrmmAKiZnzAfT8jRIJczUk5q5ERx0D8ZRltDySBgXAjNCQVIp1TncnBtaQCLpzuED1/aLRjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJw7VOQI8o6HQ1iwUsQpa65yVGSt1oKpyjk2snmoTASHPhH7U3
	IqR5xH5Bbl0/ulOghHlCVa/aDWbz764w5L2skWL9VLYsCdYFIbv3sV3c82iNyZ775EejonUdseB
	rSK9PszXLSw==
X-Google-Smtp-Source: AGHT+IF+4dI2W1Tz8PmaqeJX0XTKtsVBTKm0orDfRvn6Ll06nNvBREgJXKng13K8rbJ9Xc7pKINOeCL2o2e+
X-Received: from wmbev15.prod.google.com ([2002:a05:600c:800f:b0:442:faba:ccec])
 (user=korneld job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1885:b0:3a4:e5bc:9892
 with SMTP id ffacd0b85a97d-3a4e5bc992fmr426611f8f.21.1748348334751; Tue, 27
 May 2025 05:18:54 -0700 (PDT)
Date: Tue, 27 May 2025 12:18:07 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250527121807.3597061-1-korneld@google.com>
Subject: [PATCH] power: supply: qcom_battmgr: Report battery capacity
From: "=?UTF-8?q?Kornel=20Dul=C4=99ba?=" <korneld@google.com>
To: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chromeos-krk-upstreaming@google.com, 
	"=?UTF-8?q?Kornel=20Dul=C4=99ba?=" <korneld@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Battery charge can be reported in several different ways. One of them is
is charge percentage referred to as POWER_SUPPLY_PROP_CAPACITY in the
power supply API. Currently the driver reports the capacity in this way
on SM8350, but not on the newer variants referred to as SC8280XP in the
driver. Although this is not a bug in itself, not reporting the
percentage can confuse some userspace consumers.
Mimic what is done in the ACPI driver (drivers/acpi/battery.c) and
calculate the percentage capacity by dividing the current charge value
by the full charge. Both values are expressed in either uWh, or
in uAh.

Signed-off-by: Kornel Dul=C4=99ba <korneld@google.com>
---
 drivers/power/supply/qcom_battmgr.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qco=
m_battmgr.c
index fe27676fbc7c..5ed5452ab51c 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -577,6 +577,8 @@ static int qcom_battmgr_bat_get_property(struct power_s=
upply *psy,
 		val->intval =3D battmgr->status.capacity;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
+		if (battmgr->status.percent =3D=3D (unsigned int)-1)
+			return -ENODATA;
 		val->intval =3D battmgr->status.percent;
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
@@ -617,6 +619,7 @@ static const enum power_supply_property sc8280xp_bat_pr=
ops[] =3D {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -1063,6 +1066,21 @@ static void qcom_battmgr_sc8280xp_callback(struct qc=
om_battmgr *battmgr,
 		battmgr->ac.online =3D source =3D=3D BATTMGR_CHARGING_SOURCE_AC;
 		battmgr->usb.online =3D source =3D=3D BATTMGR_CHARGING_SOURCE_USB;
 		battmgr->wireless.online =3D source =3D=3D BATTMGR_CHARGING_SOURCE_WIREL=
ESS;
+		if (battmgr->info.last_full_capacity !=3D 0) {
+			/*
+			 * 100 * battmgr->status.capacity can overflow a 32bit
+			 * unsigned integer. Do a temporary cast to avoid that.
+			 */
+			battmgr->status.percent =3D
+				(uint64_t)100 * battmgr->status.capacity /
+				battmgr->info.last_full_capacity;
+		} else {
+			/*
+			 * Let the sysfs handler know no data is available at
+			 * this time.
+			 */
+			battmgr->status.percent =3D (unsigned int)-1;
+		}
 		break;
 	case BATTMGR_BAT_DISCHARGE_TIME:
 		battmgr->status.discharge_time =3D le32_to_cpu(resp->time);
--=20
2.49.0.1151.ga128411c76-goog


