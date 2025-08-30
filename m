Return-Path: <linux-pm+bounces-33480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15647B3CF5D
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 22:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463161B244D6
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 20:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1392E9754;
	Sat, 30 Aug 2025 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnKAvOXH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D842E92BA;
	Sat, 30 Aug 2025 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756586739; cv=none; b=KObKbj2nFHGRk0SA/AXm+BebCaxb1jry1iz8iZxC73/skoPJlOkjwe7pULWGsKw+h+o1FeBsChbfpba264ceOrmz75v8chFQedrS0RqvFVuPxNgoctHWKofL+711lhtJtR5N5Y9v/TPKv+YS7z4sxRigYE97CDZEmor1LNDb69g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756586739; c=relaxed/simple;
	bh=Art95FP4CDMp3B3wO95DSHb+3nyZc8ObS8pqSfOsfws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pjEAL/3IuXhr28WG7fJxtC4CuN1vSKtt2CEYDzj7LET7xtP0p3CYc2AIdDJc5ZQZEZXRTHgKHx1FPrEf6s3f6yJjFI0WXqo8uAPcAibNZUgpGfxRXrfWgw6dDe0l7GNxKxo80vqWi6K5sqyhGJ8H4NkfoxeJq6cIfJiyv09gO5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnKAvOXH; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61d143aa4acso1813837a12.2;
        Sat, 30 Aug 2025 13:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756586736; x=1757191536; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeAm2av/mnmRbyLHfv410Kah1AmetvGnLw+tWu4KGQ0=;
        b=QnKAvOXHCdybYdgxmB0Teh7+HJwkWKcFeye8zyazyX+Jb92/4bu0LOpzBJr+W30mbd
         6TJe8W/SxhdAoGGfmtaugXUz1aFUlSjb70L/2Ig/W37jOap9a+n4E22stDTcfe3NfVqV
         tYQVb5U1Pvlv86rjSaUGWe5Eb28iP+6l8rAScB13dyZNAJ+TdLh0XS9AGcp23xWi9vwV
         iQyhsWR71EePRXq5GLz+FngPjsOsXToOWfJFTKK6/hOAC48VPbxQUSW9XXsigUOt7uTC
         pJptg7d+2EKFmZBzJqtnUB4OBWT3V8ja4uZUkn0ESUJwPttgyMNqVFLvbe0KGSp/q0jm
         yHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756586736; x=1757191536;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeAm2av/mnmRbyLHfv410Kah1AmetvGnLw+tWu4KGQ0=;
        b=BNJWCoNULRXwaUrnM4jg2fmRuz8jTleOj/oyjtl+1QKQ3CraEJ7+sInSgfQOuden8S
         6DwpbCNsBCQvwm0FvMOLdVqo2sPhwPuem3CSVHiQdw9XdZYozxW+pd8dH7EiBjiZE160
         9YMn526Dizl8BjsVv2n8/YSdauDEo49oNfDquN4C6Ivyvpqgnhvjy10BvjwsT2LAZ/oB
         NHv3ybq+bu543E67x1pxAZ17wCbuhD2ASQKTXh9KLt20D+HGR9TY1TFzd6yIk/yBecKD
         WJb8SvWrMsLtrHZZog+gSedxN5rt+p4gl/vZn/ii71awtPEQ+2FDBspB6Ti/O91UmCEX
         zRaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY1HbRM+fAUYQSE7DRBhi7T8bUXKb84ts1z3g/gxgLl9sAItq5DWgZN35aEjG86o8oKZcecz5D0wgYoVo=@vger.kernel.org, AJvYcCXRFbn4PG/W9Jz4Rqbr63iXt9wDIfGERNh26YKZHnjUp6B4DbVeAzB+WbIZB6K+aWSuwZpgSU4EdfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFzdOXz7q4lRg+vFYs+v1nLIBHWGDLDAAT679NvZw620wFhGG+
	bh58uY2ifYq0PJ3zp30nVTQfPqkETlqvzOL7vk39sMTyM2EAqYhe1+q1
X-Gm-Gg: ASbGncuudHQqOWr0MrP6QJnn3fkL3fNYfsmfW0IU0YCH1CKIoBC5BwoaKi33yIL0P/u
	uKi/AGms2QeTDz8s3DyWcKaoU+F3iQIjVROuguITPlZyAAlhnGaTfvmdVKwFrY95WMS4DM7zZ2v
	qFkNwzcH94mbumTkAlknHdDEMcvPstEtE1BL/LiOQZzLNoNstlxNSW9MpLVWKjSHDUyiKqsClwn
	EK0k+/SR0OmEOTWZpTLroFYDsQ5cW8sXLHh8RPnPoLP5sa93F5w8sK1Ix9hoc6Yjy6G3zkDuSlr
	0a2QUcVBSF6gjxmkX6AWmpliYwi/vd1F0JN242HWEwD7/CgJYbuVDCi1GJCZ/lKfyf4I/6Fm4TT
	uIw6k1fEhmH0KZ/4dfDTyMQs1hX07kfY=
X-Google-Smtp-Source: AGHT+IE/wlt3X7TmzHIskQQpXtDBkPNymzOhbMnbsts4PLvb1yJxrkVR+VxXEF1qQCKREuRPDsHB8g==
X-Received: by 2002:a05:6402:4491:b0:61b:fca1:b80f with SMTP id 4fb4d7f45d1cf-61d26c32daamr2242690a12.11.1756586736415;
        Sat, 30 Aug 2025 13:45:36 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ade4sm4066630a12.45.2025.08.30.13.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 13:45:36 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sat, 30 Aug 2025 23:45:22 +0300
Subject: [PATCH 9/9] power: supply: max77976_charger: fix constant current
 reporting
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-max77705_77976_charger_improvement-v1-9-e976db3fd432@gmail.com>
References: <20250830-max77705_77976_charger_improvement-v1-0-e976db3fd432@gmail.com>
In-Reply-To: <20250830-max77705_77976_charger_improvement-v1-0-e976db3fd432@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756586721; l=2453;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=Art95FP4CDMp3B3wO95DSHb+3nyZc8ObS8pqSfOsfws=;
 b=I9Z5rYD5MnLmwXT+loEFJSGx+ZPaRiTgjvdcu5BXLWVxcR0k3IZCUwp5aGgVf5BBzdwUlrsq1
 zlFofN322PTBDSeZVhcQQEZfgY8liUkl422sJy5VAQtn3oTA1gxF41P
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


