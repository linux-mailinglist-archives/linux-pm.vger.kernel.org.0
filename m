Return-Path: <linux-pm+bounces-8416-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7B18D47BB
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 10:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CC23B218B1
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 08:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F5E17FAA0;
	Thu, 30 May 2024 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0ScUcrA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A8517E454;
	Thu, 30 May 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059401; cv=none; b=sNWrrz52KTpPiWwcTYuo5e6kksfKqy6aaLEgUmK9UreOHU7qRdkTA2zsd6CQGQ855NrZITrG40Xc6q++Y3hVea7iXq5HAxgpOrYlr1lN6fLR4OG1g9KeJ9XtHjC8h4iq+xwez7CE80ahykcEJKskiKNhtnxanhQKDWkow7zIRec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059401; c=relaxed/simple;
	bh=bu/D7bMK1QFCZGMzfQmpKpoYUdwQ8o3XZkg5O1eFV1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ii8zb4EHbZaCAYt/6LRK5XqVpnAWk0F8oRrdE0WsdQqwQStQroHCR9/w6WAudtSQYk+eZy2EkD1aX6zKrCqWaVovZjsTQNyAEz8rtVpegdLLxdYg2vCvo0sewC8UyXOoSsq+CXWnLrYGyqo98C6HUEWdSnTSqIOuSjRh7TkKvhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0ScUcrA; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52962423ed8so763961e87.2;
        Thu, 30 May 2024 01:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717059398; x=1717664198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DVL7HMaLdGimcENmoBF+IUgjRnKXHAyyw7ouZ5rrWU=;
        b=T0ScUcrAdjLsAcffDNfuktlVOyW+sa88C8/SBnu8KbKIHVMyDXhEhU3NGYFSgfHHQ1
         mrJeFK21MOk6bcbPvMdxZ1HP/hGt/7iEQkiHv27knzvfGhq/akaOYJ7xWczM2YI5PYhv
         pHdIX6E02cr/NdsYZOc6bcV0jL+3YACTrmHLjRc0qaxr7xbcA2LvvsIHAG1sGC8TCnZH
         MIM2ZjUZQffazR8nJPJ9GHeAf/l7duJzYeXP4wQ1Bg+nTVMuBZDQjWxarTRM/kZvme4M
         RjheyaLwiwuOK5GWawGHgwQcNkhpW6CxUD19L2bjwi5bgSfAMdMpyhKGj43NVdi8rUfR
         7oZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717059398; x=1717664198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DVL7HMaLdGimcENmoBF+IUgjRnKXHAyyw7ouZ5rrWU=;
        b=RvKQfsaVAQj/Rw7e/YQf0xco24CpZufd6XDqQZsI1MKyJifq5XcpFXBKKbfo6xL+nn
         afkzjQZY6UqNTDBM/kiF6OFoIw07AnqTo6VSUqINJmF/+aaTo8BeOAZbG6FkNSlBD7RM
         VGhIi4/v38M4W4Anjsrim6578cpUFGg1+oBfpq8MsGK5XSCA/ZBZdaqLXtXrH0x2tLok
         p5sBe69qZlDiYRviYEvFUNL6Uplq9XIrzNPhHzKii4gP66fPvs6+iIXHCipst5iawW2b
         Ppb7TDKCksfV4C34/1vDw5iWwkZztolmSVC8RkfA4ZYLVhC4/BcuwVigUQ9Q8VUd0Pl6
         VXCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkpetSVvMEPTgP9lPFMx12VhqkGdvUqtuie5H6mVVIJlW0OlpBXb1KJv3g4RKq3mmSrkCTuQpBQgyWj6dpY2wPyJj2hSIxUkQZhrfrocJroOk5hXN8jBKXiWQE33ySCFu7FKxk6H3mrNw31wgrdksZDythmsEqw+fEft+JxPXEBzhDYHizBW9iWq+eYIUyj9AdVhH51ObWe+lcHcA3ZKbvLdCrpYw=
X-Gm-Message-State: AOJu0Yyc4esmDrhXazrW/sBmOxplc66XlHHQ0p2/KCcuId3oYx6K6iYS
	RErDY8a2fGKkIS0jnkiHXH/vHxs2FIzrBZKob7G4Qv5fVyDRl6XJ
X-Google-Smtp-Source: AGHT+IFTjYlQv7nU3izoblFm7KSETkxELCqItOAh1GiFE325pUNk9/sXgkbtI+fA8666ss/SUq+7Mg==
X-Received: by 2002:ac2:48b3:0:b0:52a:9db1:9d7a with SMTP id 2adb3069b0e04-52b7d48e0f0mr947365e87.58.1717059397940;
        Thu, 30 May 2024 01:56:37 -0700 (PDT)
Received: from hex.my.domain (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc500a1sm798430166b.125.2024.05.30.01.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:56:37 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Thu, 30 May 2024 10:55:59 +0200
Subject: [PATCH RFC 09/11] power: supply: max77693: Set up charge/input
 current according to cable type
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-max77693-charger-extcon-v1-9-dc2a9e5bdf30@gmail.com>
References: <20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com>
In-Reply-To: <20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>, 
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, 
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717059384; l=3617;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=bu/D7bMK1QFCZGMzfQmpKpoYUdwQ8o3XZkg5O1eFV1U=;
 b=dN1Vyib5+v40zVBQAXRIRNpvfeNVaScau4zaQVfODXVKPuwbfQ2kYHfUVagNu2vj924k+RYYV
 0064bxnp3XVDKfVveClxYOyfb363quWai75IRNCdcxJ614xDPFpSopX
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

This behavior was observed on a downstream kernel - for chargers, the
current would be set to a fast charge current value, and it would be
bumped down for all other cable types.

If we leave only the fast charge current value applied, peripheral mode
stops working. If we stick to 500mA, charging becomes too slow. So, set
the charge input current limit accordingly to the cable type.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/power/supply/max77693_charger.c | 35 ++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index e548fd420e78..76e08775f796 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -711,6 +711,10 @@ static int max77693_reg_init(struct max77693_charger *chg)
 	if (ret)
 		return ret;
 
+	/*
+	 * Set it to a lower value by default; the DT fast charge current
+	 * property is applied later, in the charger detection mechanism.
+	 */
 	ret = max77693_set_input_current_limit(chg,
 				DEFAULT_FAST_CHARGE_CURRENT);
 	if (ret)
@@ -772,6 +776,7 @@ static void max77693_charger_extcon_work(struct work_struct *work)
 						  cable.work);
 	struct extcon_dev *edev = chg->cable.edev;
 	bool set_charging, set_otg;
+	unsigned int input_current;
 	int connector, state;
 	int ret;
 
@@ -784,19 +789,28 @@ static void max77693_charger_extcon_work(struct work_struct *work)
 
 	switch (connector) {
 	case EXTCON_CHG_USB_SDP:
-	case EXTCON_CHG_USB_DCP:
 	case EXTCON_CHG_USB_CDP:
+	case EXTCON_CHG_USB_SLOW:
+		input_current = 500000; /* 500 mA */
+		set_charging = true;
+		set_otg = false;
+
+		dev_info(chg->dev, "slow charging. connector type: %d\n",
+			 connector);
+		break;
+	case EXTCON_CHG_USB_DCP:
 	case EXTCON_CHG_USB_ACA:
 	case EXTCON_CHG_USB_FAST:
-	case EXTCON_CHG_USB_SLOW:
 	case EXTCON_CHG_USB_PD:
+		input_current = chg->fast_charge_current;
 		set_charging = true;
 		set_otg = false;
 
-		dev_info(chg->dev, "charging. connector type: %d\n",
+		dev_info(chg->dev, "fast charging. connector type: %d\n",
 			 connector);
 		break;
 	case EXTCON_USB_HOST:
+		input_current = 500000; /* 500 mA */
 		set_charging = false;
 		set_otg = true;
 
@@ -804,6 +818,7 @@ static void max77693_charger_extcon_work(struct work_struct *work)
 			 connector);
 		break;
 	default:
+		input_current = 500000; /* 500 mA */
 		set_charging = false;
 		set_otg = false;
 
@@ -812,10 +827,12 @@ static void max77693_charger_extcon_work(struct work_struct *work)
 		break;
 	}
 
-	/*
-	 * The functions below already check if the change is necessary,
-	 * so we don't need to do so here.
-	 */
+	ret = max77693_set_input_current_limit(chg, input_current);
+	if (ret) {
+		dev_err(chg->dev, "failed to set input current (%d)\n", ret);
+		goto out;
+	}
+
 	ret = max77693_set_charging(chg, set_charging);
 	if (ret) {
 		dev_err(chg->dev, "failed to set charging (%d)\n", ret);
@@ -887,6 +904,10 @@ static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
 			&chg->batttery_overcurrent))
 		chg->batttery_overcurrent = DEFAULT_BATTERY_OVERCURRENT;
 
+	if (of_property_read_u32(np, "maxim,fast-charge-current-microamp",
+			&chg->fast_charge_current))
+		chg->fast_charge_current = DEFAULT_FAST_CHARGE_CURRENT;
+
 	if (of_property_read_u32(np, "maxim,charge-input-threshold-microvolt",
 			&chg->charge_input_threshold_volt))
 		chg->charge_input_threshold_volt =

-- 
2.45.1


