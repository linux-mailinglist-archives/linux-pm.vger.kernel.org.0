Return-Path: <linux-pm+bounces-34979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 246AFB86264
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 19:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54965608C7
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D735E3148CB;
	Thu, 18 Sep 2025 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf7rDI/1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089FC30B51D
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215213; cv=none; b=NDqFsZN2NmVmA5Tq0krvS49KekF+tF/5M1lgEiBEMv9/oVFKUF62wPIFqK39YhdAakBSXzGB/QrqC6u8FXqWB/vhLW3Q5QvRNJNAlHUsnKlBaRVtWrgHd+q0HmkGWxZPu3sobba6Lzeu/aAijG4NxhEtfjsiyT645sWUpqZ9pJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215213; c=relaxed/simple;
	bh=Art95FP4CDMp3B3wO95DSHb+3nyZc8ObS8pqSfOsfws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IEodK0UScuMEEwbsI2k8YYWbE+RZgrWKy3ZgpqHyMWUYmmF0ge9JJEUdhWSK8gB87w9rv4qf2lPvT0igsXqqajM+tEB0HTTHLd/Zi3WAIAPP71C0wn7y8n89zyBKM/cZntT6PoIW8qruerJ2uNoERDyIA6JaOuPDTxNf42oYFb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mf7rDI/1; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7a16441so185392766b.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 10:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758215210; x=1758820010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeAm2av/mnmRbyLHfv410Kah1AmetvGnLw+tWu4KGQ0=;
        b=mf7rDI/1JtRj3AHaE61zu3VP/d4DBGd5WJQd9G3IUaHWw8B6h0+L3CjqAXHwt3h/Fo
         GX4JUviX7iDDpOVwsv1Yyfg2CzGP0+taXkncR2ksBGMLcEVqYiY9aRfXWJqn1JgMKJMh
         BXjJOhacCy9KDu0xXX66bphujjzh4WL7tD1s/r0Mga3tMi9hxEAdVY8HSPJLbjIfROBC
         yOz53dWm38F0/Lepb0nlcjtNOYeWIR5u/c8bl5MqT2gr16VtHaTTsvJ7X1zu/K5IxDDx
         pk78D8UwQLHYWuh+l5cveGYa7DfMq6jeIFMJypfsW9CfDcLsZrA2J332HuMLCm80Gvsd
         Qy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758215210; x=1758820010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeAm2av/mnmRbyLHfv410Kah1AmetvGnLw+tWu4KGQ0=;
        b=L+r1K4HYQw+h/Z7jZ1Dy6orKqyAORSI9qHkYNhoQW0K28ugtLcXVa9kkeonUe0CkeU
         7JjGphO/qxaPb6UmEH06wMj9NZepp1efO1M2L/pFb61dFTbT8yE4Dqvvm3vXVF3hG73s
         UjCHAD05gstlfVP7ubmU7qydqNQuLb0Lm0QGDSB5DlvOXj7KKoY0qeagVivoWSpmsyfx
         dQJf//3odBnTJUWA3UQzRtLUqQr8XJaRkAvIAbYgXASkkfpKloMAZIVLwb/1TU7xNt44
         MrHGuxvortMwzie74Ug80MDr8XsqnGDHG0/b06wodcsroZ8aqv9GkhC6bnpk58rI+V6H
         p5tA==
X-Forwarded-Encrypted: i=1; AJvYcCU4slX625Rt43YVDTd2n5yDBa+6ZxQWLgMVaFuoUlSWgO/vwxe9tNa7tTiS+BhqQrbZy03VqB2WFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJHgpO2mQwwc51McmZVBlG8LqBu++tTiBuIrwAiFhBWH2PRB77
	LGZOceEhTYCEHXwBhGVVyzl8iAvqK3SeoSHEW9ckJvlT2LKYgtyi0JJ1
X-Gm-Gg: ASbGncvt6EPYs0RVWWqH8VVnbfSMHMmS9K/OpqRSuH4TdaVOnmod3P9npykbdds0YPq
	gRIEjegjZudYgqZV9o3QzYyNHsf/aztghpxKSe0VkYx+QyeikNMw9f8ZShT9KgDdQhKnUW+CMKt
	JtvGOl7RV8j1q7Vp6+qYm2X+LMR/xsWJPmd1TpSR02Jl2XQ7TykZhMDX17vZmWFirPtu/Xyhnu9
	UP0NRF1otbBqdxPSiMtCNDuU478BqsM+aPsmcMSB22zhHnXa1qcN7V0kNlGnxcAJKQsBO5Co0nE
	v5WpPF/UsOsOgTdb/tlng8+3K9YfQH/0+sdReNFHg0/B2EdAPTdnitup6wUF0FIhykPkofrmC3a
	OYDxU0cDNgqaUji6tv7fHxuOaoM3TgfJMZ7XnYvg=
X-Google-Smtp-Source: AGHT+IGAuKIadp13aCfB47IRZfgI20SNnptoUvrYGmJWsUJGXaJAMNWHhnQ8QfEc5ReZ/ElIYKU62A==
X-Received: by 2002:a17:907:7296:b0:b04:27a9:cfe1 with SMTP id a640c23a62f3a-b1bbd49d74amr671497566b.47.1758215210055;
        Thu, 18 Sep 2025 10:06:50 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b1fd271f895sm225845366b.97.2025.09.18.10.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:06:49 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 18 Sep 2025 20:06:45 +0300
Subject: [PATCH v4 1/9] power: supply: max77976_charger: fix constant
 current reporting
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-max77705_77976_charger_improvement-v4-1-11ec9188f489@gmail.com>
References: <20250918-max77705_77976_charger_improvement-v4-0-11ec9188f489@gmail.com>
In-Reply-To: <20250918-max77705_77976_charger_improvement-v4-0-11ec9188f489@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758215207; l=2453;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=Art95FP4CDMp3B3wO95DSHb+3nyZc8ObS8pqSfOsfws=;
 b=IJqzlXgKsHMAXEj3GQSQT8jwEsojD7g6pxkyxGxRxJWnETbMhiatOuO09zydhtuP0cHGtE2fn
 TzOfOlpwItHCS65iPOWBsDu0YqzUL4Vv82mnsWLX6ciLJfAWV5SiDnZ
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

CHARGE_CONTROL_LIMIT is a wrong property to report charge current limit,
because `CHARGE_*` attributes represents capacity, not current. The
correct attribute to report and set charge current limit is
CONSTANT_CHARGE_CURRENT.

Rename CHARGE_CONTROL_LIMIT to CONSTANT_CHARGE_CURRENT.

Fixes: 715ecbc10d6a ("power: supply: max77976: add Maxim MAX77976 charger driver")

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max77976_charger.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/max77976_charger.c b/drivers/power/supply/max77976_charger.c
index e6fe68cebc32..3d6ff4005533 100644
--- a/drivers/power/supply/max77976_charger.c
+++ b/drivers/power/supply/max77976_charger.c
@@ -292,10 +292,10 @@ static int max77976_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_ONLINE:
 		err = max77976_get_online(chg, &val->intval);
 		break;
-	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
 		val->intval = MAX77976_CHG_CC_MAX;
 		break;
-	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		err = max77976_get_integer(chg, CHG_CC,
 					   MAX77976_CHG_CC_MIN,
 					   MAX77976_CHG_CC_MAX,
@@ -330,7 +330,7 @@ static int max77976_set_property(struct power_supply *psy,
 	int err = 0;
 
 	switch (psp) {
-	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		err = max77976_set_integer(chg, CHG_CC,
 					   MAX77976_CHG_CC_MIN,
 					   MAX77976_CHG_CC_MAX,
@@ -355,7 +355,7 @@ static int max77976_property_is_writeable(struct power_supply *psy,
 					  enum power_supply_property psp)
 {
 	switch (psp) {
-	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		return true;
 	default:
@@ -368,8 +368,8 @@ static enum power_supply_property max77976_psy_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
-	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,

-- 
2.39.5


