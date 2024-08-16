Return-Path: <linux-pm+bounces-12326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E412F9543E9
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6C6282D3C
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E48143C6F;
	Fri, 16 Aug 2024 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ES6lcZfS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732C313B5B3;
	Fri, 16 Aug 2024 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796369; cv=none; b=H4rkETnOZNxTfnszFVnj8Nb8mNKY/IKLePA9ePlZmwgsuQhxoIBAkMCtvnWTdcw0wPRRVhKJ+go4liuG2ldUhlSDnZYxWD/v4wEE9aIRWJMeZbVzJdr9L0pyeIf37Y2xonKUx24ihMn1O/mvSj+wu4YlPJ5xZjOzkQQtRJmJIwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796369; c=relaxed/simple;
	bh=9tKk8IBY8YUSIH0ECZT8vZVS+bk8IwZ/nsbmqbh0O0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xe1GMUFSqedeqoEojNPv4UexnevlL9HBYE/EIGCKne1MCHI9pp5zFY55M+iY6rwNPrxFPaLsZYaWqqVfZlIAh8TQN4VzZyIXuHKqy+TvWex33J+dmPIWLynxsvwwe4qr6MGgqFuuWuw3DJZA0QDNzyA6kQPM/2VlDkuIpbQuitc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ES6lcZfS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42803bbf842so17290545e9.1;
        Fri, 16 Aug 2024 01:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723796366; x=1724401166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qaOD3rKusxi0zQqgiaHpgdf4b2i/F2QB75S2grdzC44=;
        b=ES6lcZfSZKWaK+GthUFsArt2775eisvMTjvmAe6oY6Dkjy7c2DCxHY+T1einoayKui
         7/8O8/P21tggZi2A7HMRfktCY40HPMmcMhdg2pUcoA3k0s12MmaDDWAOB0CNDyXXGLZl
         +wDU1ZaG1acY/kwQ7tSITnlL6bER3a4L6bCG7HdklhT8MxSknBjEOHUUR9PvNuvl/znm
         5gKjmbP8FsQCCXfh6zwy0GopaeN1rZ4Sx12bvvj0ujhgBhm0W2FDeOih+fzvDG/FEtL5
         RsH4s/aEsvlmDA49ngF6GJuZXmYRWzBHoBkrmGS0CfBnsyqHWcrxAYobAQ32NrNj4YMU
         ieNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796366; x=1724401166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaOD3rKusxi0zQqgiaHpgdf4b2i/F2QB75S2grdzC44=;
        b=JAnNQhH1etqNtRUxbUP8YAq4m7vaz0wlH6Dp0dZuJo88+fie+/66xXohB2hod51fZB
         AkRPVhPAhnj4aabPAyrVlUqTvYYSXFVnleeqgJRw+E15V1Fs2e0+HggTHQEZLP1EAhAr
         t2UmzRYUKk1FYKkBOOi744Pi4W4X7t4r0BUGpvDFTY9gr+cq1OPrLOgPThtl1o4C6FFu
         ZzAT71Qmo7qyzcqdaZntk1rcWo4iS5a6kJg26R1byTueSrA48kQH0Mkfy+gzwy8UvT0k
         32roaCrmXPBbkz6vDRFSB1aefu7ETqo1cfWDyHTXkVw+ufw8WlpcJbItdTJarrlrX8z3
         6ylA==
X-Forwarded-Encrypted: i=1; AJvYcCV6TdXbOcEJpBB7Ri0CR2guXxcXfBSYpDEHUGVe+jT23HU5H9t3XM4UcwCkD1y09gZ5qtBS7IwkBVlu1Ra8W3g8yvZQId7X4slZ87Qi6EIfcw7WSgy/71lRuwegQHN7UQoaWgLMahX45dSLahO1b77b8kbOMjGTT38au6NbozRR2ZygxPRDRYhITh8+weNfv0Xq7jb5hF4DOfS127Ec0dZoeS4wQmM=
X-Gm-Message-State: AOJu0YwMqZPuglkq5sb0DCBUWWRPW2iblzKwkyYA+7Q0hVTOdeA6ZiaI
	iyztUvAABd6b4UT1cbVCwqXH++9FTEz+wH8WBoNZz3dvTR8BSwDN
X-Google-Smtp-Source: AGHT+IGqwtVcXQKNh8O0fbem1eWcZ1w8RFD4cuHCIdxMrfHUkdXEj31Hz43gXqKgPdNZM9R7oJ2C5Q==
X-Received: by 2002:a05:600c:1394:b0:426:5f09:cf53 with SMTP id 5b1f17b1804b1-429ed794da8mr14540675e9.15.1723796365560;
        Fri, 16 Aug 2024 01:19:25 -0700 (PDT)
Received: from tablet.my.domain ([37.30.8.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded35991sm69732645e9.21.2024.08.16.01.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:19:25 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 16 Aug 2024 10:19:12 +0200
Subject: [PATCH v4 06/10] power: supply: max77693: Add support for
 detecting and enabling OTG
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-max77693-charger-extcon-v4-6-050a0a9bfea0@gmail.com>
References: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
In-Reply-To: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
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
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4023;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=9tKk8IBY8YUSIH0ECZT8vZVS+bk8IwZ/nsbmqbh0O0A=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmvwt+vqva+BUdawrIWvIhu5Ymj2S8KArA+aJpi
 ZgwlobFry6JAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZr8LfgAKCRCzu/ihE6BR
 aI83D/9G8dZ+ucjhexcdplvfoufCG6KhhAaDCFIUp726bzqD5GVi+fZs4B79aN/Mb64+uQ3kLOi
 4AGNaVVUYQUQSlbbpSdBVApMt87xdZ0z97SPD2EVICrpnF9fQvPT5eRRC+sMvDyFjt+8zaGFNOr
 Mry4BHCr/Gg/hWOo0BQf8mNt+Gwx9JJ5vbMUcXu7fZczfJ9Yp8XzuCZXvbR+LFLlql+5mhoFWx3
 vajC6Vqelc0EyTG6oDn9tVv2EdDd4MSH0sSQykAl/Ga5xRq+uRERJIp5ghHdIi71AkHBYDN6AeT
 apQh4kWhFQSKGV4iYBzqwRN1PdTo3gIsfDuZDl4XpWa5ywFUUh2C2LY8RBDsHtc7Fh9a4BpHWfR
 cE7lFyIovOIkVsPncshvXV66P1yeZ7SVqhVtnIgPonGSLpeunYdngSu5XcWtAcvZoqq5eBuGlpY
 yikxUEH1zSGpociurXOnBHI0xVv/nXfrlSLu7nhCQJ9ubxpyND3sAsB7Vgt/0qsqcbz6svA8/51
 e6kXpVr3VP75rl7dfgu5vffEXRfk7drftWvk1/ukI8b6AZ2cOvLBnG7Gssq3PzEKaKlwV19qu/P
 M9kfJPQzDHKDFZF+K8ijapLYsahc48JGkO9zbG7TP7dD5u2WypM4GxD9PVF/3c6wOCTQ+PX/ije
 hy3lLpIabe/i8QQ==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Building upon the newly added extcon detection support, add detection
for USB OTG cables (EXTCON_USB_HOST type), and enable/disable the OTG
bits as needed.

Acked-by: Lee Jones <lee@kernel.org>
Tested-by: Henrik Grimler <henrik@grimler.se>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v3:
- Dropped CHARGER regulator in favor of enabling charging directly

Changes in v2:
- Added CHGIN OTG current limit value
- Squashed MFD header register changes into this commit
---
 drivers/power/supply/max77693_charger.c | 53 ++++++++++++++++++++++++++-------
 include/linux/mfd/max77693-private.h    |  5 ++++
 2 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index d67857d2aa0b..bf156544fe1b 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -692,11 +692,30 @@ static int max77693_set_charging(struct max77693_charger *chg, bool enable)
 			data);
 }
 
+static int max77693_set_otg(struct max77693_charger *chg, bool enable)
+{
+	unsigned int data;
+
+	if (enable)
+		data = CHG_CNFG_00_OTG_MASK | CHG_CNFG_00_BOOST_MASK |
+				CHG_CNFG_00_DIS_MUIC_CTRL_MASK;
+	else
+		data = ~(CHG_CNFG_00_OTG_MASK | CHG_CNFG_00_BOOST_MASK |
+				CHG_CNFG_00_DIS_MUIC_CTRL_MASK);
+
+	return regmap_update_bits(chg->max77693->regmap,
+			MAX77693_CHG_REG_CHG_CNFG_00,
+			CHG_CNFG_00_OTG_MASK | CHG_CNFG_00_BOOST_MASK |
+			CHG_CNFG_00_DIS_MUIC_CTRL_MASK,
+			data);
+}
+
 static void max77693_charger_extcon_work(struct work_struct *work)
 {
 	struct max77693_charger *chg = container_of(work, struct max77693_charger,
 						  cable.work);
 	struct extcon_dev *edev = chg->cable.edev;
+	bool set_charging, set_otg;
 	int connector, state;
 	int ret;
 
@@ -715,25 +734,39 @@ static void max77693_charger_extcon_work(struct work_struct *work)
 	case EXTCON_CHG_USB_FAST:
 	case EXTCON_CHG_USB_SLOW:
 	case EXTCON_CHG_USB_PD:
-		ret = max77693_set_charging(chg, true);
-		if (ret) {
-			dev_err(chg->dev, "failed to enable charging\n");
-			break;
-		}
+		set_charging = true;
+		set_otg = false;
+
 		dev_info(chg->dev, "charging. connector type: %d\n",
 			 connector);
 		break;
+	case EXTCON_USB_HOST:
+		set_charging = false;
+		set_otg = true;
+
+		dev_info(chg->dev, "USB host. connector type: %d\n",
+			 connector);
+		break;
 	default:
-		ret = max77693_set_charging(chg, false);
-		if (ret) {
-			dev_err(chg->dev, "failed to disable charging\n");
-			break;
-		}
+		set_charging = false;
+		set_otg = false;
+
 		dev_info(chg->dev, "not charging. connector type: %d\n",
 			 connector);
 		break;
 	}
 
+	ret = max77693_set_charging(chg, set_charging);
+	if (ret) {
+		dev_err(chg->dev, "failed to set charging (%d)\n", ret);
+		goto out;
+	}
+
+	ret = max77693_set_otg(chg, set_otg);
+	if (ret)
+		dev_err(chg->dev, "failed to set OTG (%d)\n", ret);
+
+out:
 	power_supply_changed(chg->charger);
 }
 
diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
index 0819cf0a4f5f..1fd93bfbf3dc 100644
--- a/include/linux/mfd/max77693-private.h
+++ b/include/linux/mfd/max77693-private.h
@@ -209,7 +209,10 @@ enum max77693_charger_battery_state {
 
 /* MAX77693 CHG_CNFG_00 register */
 #define CHG_CNFG_00_CHG_MASK		0x1
+#define CHG_CNFG_00_OTG_MASK		0x2
 #define CHG_CNFG_00_BUCK_MASK		0x4
+#define CHG_CNFG_00_BOOST_MASK		0x8
+#define CHG_CNFG_00_DIS_MUIC_CTRL_MASK	0x20
 
 /* MAX77693_CHG_REG_CHG_CNFG_01 register */
 #define CHG_CNFG_01_FCHGTIME_SHIFT	0
@@ -222,6 +225,8 @@ enum max77693_charger_battery_state {
 /* MAX77693_CHG_REG_CHG_CNFG_02 register */
 #define CHG_CNFG_02_CC_SHIFT		0
 #define CHG_CNFG_02_CC_MASK		0x3F
+#define CHG_CNFG_02_OTG_ILIM_SHIFT	7
+#define CHG_CNFG_02_OTG_ILIM_MASK	0x80
 
 /* MAX77693_CHG_REG_CHG_CNFG_03 register */
 #define CHG_CNFG_03_TOITH_SHIFT		0

-- 
2.46.0


