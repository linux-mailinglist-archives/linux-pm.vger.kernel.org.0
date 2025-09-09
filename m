Return-Path: <linux-pm+bounces-34300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4936B50549
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 20:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8AF161120
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 18:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EF136999A;
	Tue,  9 Sep 2025 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8lpjht4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FA8369320;
	Tue,  9 Sep 2025 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442585; cv=none; b=i9/1ET1WorA7QN/2cQLLP2mmnjFHlzAdfaVQzxyvC/2ImF7YDhCSsPSmh5HBZSbdRfw2rVTKEcgiZgX5Hlhtw9nyAXdYAp45hFZLBb70+m9qt+2w55PIJ0q9BkxQID5XcfMF5m+AYTMsI67fqVtstYtR8mBAIuQdACUZ2HMeiFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442585; c=relaxed/simple;
	bh=Art95FP4CDMp3B3wO95DSHb+3nyZc8ObS8pqSfOsfws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V7yzV/zPOTRkz8rJlxXc029++OnS5JDg81hipmApQik4MkeuRr5HXA+T1nRXOUe9zl/tDbwTgvIyciiwTJPTw00ZALqv9i6B3BFDTW4eF09b/ifh55DFJNlcGENIO1/9CFs/5rYZzw6JOmon9Nc81cUXVxQnG2z8LstyEoYLLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8lpjht4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b0418f6fc27so992669266b.3;
        Tue, 09 Sep 2025 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757442582; x=1758047382; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeAm2av/mnmRbyLHfv410Kah1AmetvGnLw+tWu4KGQ0=;
        b=i8lpjht4WvGNnkqDCN4D3WBWjWzpoksXDPIs5ZqdW2mCgcJxCFNbdFofBWoa3H8Mrr
         0B23V8nL8+43Mk6YuCVwpbX92KipLqyBAEqemp8WgfSBXMcIPD9s2273wXHI2H/HZym6
         /PDE2GWVtXtYbM8pyJHk0pKL8uIHe6jdZSRriCQtVH2y54dR55hlYFMnXto6NukS3yJW
         7PGc9X5mELrioYO4ey/DwVEM3ceRrpzKmRXOOnuy+jZDdxHnClr+6nyo8ZWnFyvCVUx1
         FvRMagRCf5cDGDAebgSQqITTn9PZRBJrFM4a3DzMbbedJXeQIUnbYVOldm1ThIKOKwqf
         xVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757442582; x=1758047382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeAm2av/mnmRbyLHfv410Kah1AmetvGnLw+tWu4KGQ0=;
        b=kUbF9sFZES177+uM0QvCBLUlNxqD5dbeI9SnVWu4gxvW3DK5zy6/882voQsVv3lJ3J
         oRDRw38DrrYq3q/wgtCgwGw6f7M6VaLSelJuEBLpDqPzt63a1hiZ0tqie3xNz7njFXVY
         CLuepl2RL8T0fTcDwnuKdbhCjRtEU9wy+9qw+kpVc64SpN2hR4S0TtTmpyfqs0MKo/bd
         iW7rbikHK9ZDi/ca8fFX7dgJJqFJhnAj1prXi4mXLYSnM54oykIBkct4I4BZFLJZbRWZ
         s9E0W82SP/1JMWiCTz7Ce4laxxbi8Ylo9dTpR7ETWTm2fbHL0KQM3I0rPiRY50BohRFZ
         My8g==
X-Forwarded-Encrypted: i=1; AJvYcCVyRxMC97W6lxecZNmq5NpAQHejM/fBgRpwQHlJbJ+qlUsa/CQLq6IEkb3VPCYFNq8QNcXALnRt6Rp+wvY=@vger.kernel.org, AJvYcCXS2M/psJgIbk160BQ59GdsPoQa5QjIydVi2RxSXaZZoZPIpLVxUZH29e+777GjcWH3uDUZZcOrhWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDlH4xF+YWBFRWOV+igWedj0FSp7vG9g2Ll5gt1BWzhSX/Q7UV
	KeKOa2W55F+5kI+j0Wws43bT/hROPHeRF17smYgvK4dKjHHWmYJE+BPSF5TSDQ==
X-Gm-Gg: ASbGncutoVoBu+ptY0ioifkFsU7tdS34TXeg7uJQFulU/PR4oEY5O2qtBtusQDP+h31
	lWQWRqpPdhCSjHvNLkEOv9J3WX8C0ZYeWDCxYdHcwr14aTscZSg3APVq0sDjKL0dpBNYiEug3l1
	uaRQiQR1K/yVTer2qUcBYQGuYEKzsa+0NeXnn/bHy2AzqstoSizfTMZTpiqMaJrZLWUzKJwQ6AJ
	HtYyLciPXCP7dZ72poMEa0YyRKBZws7Q7MKilQIwqkeC7hrEEdyccAkGfUYRvMnHFa/IuiJ1zvV
	vc3P+Agt5xMxCQQKVY8ntmiPa9QbWKfO6syubsRTRtrmdDoZXgRTl2WDdGpWHlTHejUFVUv7D0F
	4sLZK7SJx+YWKKybpqXke
X-Google-Smtp-Source: AGHT+IHXX8PH2cH+81HpRkdTN3HkHUucvuvPnMpmdfKLlhJcbRuQWFRrO/cIx51qu2p6Jy/A+lh25A==
X-Received: by 2002:a17:907:944d:b0:afe:7ba0:df58 with SMTP id a640c23a62f3a-b04b170d61fmr1304472966b.46.1757442582125;
        Tue, 09 Sep 2025 11:29:42 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07833ebe61sm30520666b.89.2025.09.09.11.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:29:41 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 09 Sep 2025 21:29:19 +0300
Subject: [PATCH v2 9/9] power: supply: max77976_charger: fix constant
 current reporting
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-max77705_77976_charger_improvement-v2-9-a8d2fba47159@gmail.com>
References: <20250909-max77705_77976_charger_improvement-v2-0-a8d2fba47159@gmail.com>
In-Reply-To: <20250909-max77705_77976_charger_improvement-v2-0-a8d2fba47159@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757442571; l=2453;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=Art95FP4CDMp3B3wO95DSHb+3nyZc8ObS8pqSfOsfws=;
 b=f4Q0SknzXp2mOAUVjz7fxc50lg6/oOucw4N/X2CKmOaV9DBnfOjzAW1/s7rCmoLNks8xMlhrr
 Pk6J/aYjGCbDVS/2O1WPafHaO9exk/1MssdUdRmwo+Mk3wI2sP3GVPK
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


