Return-Path: <linux-pm+bounces-11577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA0993FCB3
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 19:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B811C22441
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DE21891BB;
	Mon, 29 Jul 2024 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIKHaRFv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC4F188CB8;
	Mon, 29 Jul 2024 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275282; cv=none; b=KZVib97k846zqO7zc/7xgU+9M7ygX4GmoFarH5iF4q0/lHjgleJa5UfdFB1BVXOoYN0QUq+jX/3ZFXiWBDz0KX4ds/7wIrlPukmwUt0L3xti//EY2DrdWc30DXMhD+L3Z6yd7F1CJoTkWv3e+qk4rMVmLDckdqEFvVxEwptW/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275282; c=relaxed/simple;
	bh=024yPNon1poyVphR8keDLRzye+FGmZPcxiMYS+/Gw4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ai3CgEkTDtgUeUw45gchaT6iQ/PYVcas64bpYPjzFwAJ+UuR09glXm6cXTyBM7IvQvyNznPrcUpbmOj0CKkmBS8AtUnxswC75mf+jljtbZUEVz4oVoly1xKHJ+zkFdR56j++eN0HmlYBhhRGH59AKLa0GlWgYwfJN4XzM4bTZvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIKHaRFv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-368380828d6so2089440f8f.1;
        Mon, 29 Jul 2024 10:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722275278; x=1722880078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVY1jXrpCpuLnTI+cr7IUvSFt5/r6cGcoEVasJ6ji9A=;
        b=AIKHaRFvT0yFvdKCLaQeJ6ZL5y3si/8rgEfNmcP3plXTy/MPwZYUZpO/vO1pyr/7dd
         WPwoBQRi7m2biYgSd8OBviwYtt39ZOS53TxhuMoqDZ8E6Bu4gtkoVwMcws4aW3rJHpbM
         LBfvHc7aGQ5q7AeqND7/KSE89+B2YR5Vvl97bzrZYkJviMqhXd48HKuZdoUF0fwWtKEq
         AAAPHVwr3G4F5jYy4HTXGSLcrk/8o+4EdCNUnFBKts6bOCRT/np4WW+uUH4oB7ISjw8B
         8h7p6gr7qoryOcE6tOLol7m0CUa3BGX5R3x0zm33L7RnnQ7BvhkDnS8BFvFtmZuzsxcF
         lJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275278; x=1722880078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVY1jXrpCpuLnTI+cr7IUvSFt5/r6cGcoEVasJ6ji9A=;
        b=WCrPHaCrojVi0mZjs3k1dkXh3u7YpGK0yYnO5LjQ8KuBOn6ofMiWt5DnHQDeEjHjAv
         vZzRKP4thlBuOkJjUqKZJBSPevHMtLM73W2xvqfpixt6pMrnnEzCpNtTa18P4RctpzIx
         w68wbIzyoUKEhZ/88ZJWvzPCmWXxCQhJA8T588RmKMHLTW/4zhWo8q9NpwBdhCyZSkFl
         uP7PTsrFvacVkEHGzae2+pApL2/SqVWt0yKC3JkXtEJ5kDmj3+F11lY6g7QO+xPW0ZSt
         6FYNBAq504kumDARqQyLwX16VWDajCkz4UfsO2a6D6iwcVeTc6W9C0f7YvOoCs9kV0ZV
         30RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAORCCHiegz4ef1EgidXSBOwhr72nN0XWMIDC5EUrxmv3jI0WC4g7Fh2A/KCNuN9t4KYpXzNtHX8UKzHDYmqB/idodffuwQTvZaL4Q/ZKKDA7U1HHMKaLK/ZyKeu2ezAer2i6DqjdbVJlC6Koc4OzNaKdE6csaISp1AT7DF0/DzxhztPo6e4+dWDrNmYmzVtKZQVuJKI0mx1US+c7EyaVNljazYXc=
X-Gm-Message-State: AOJu0Yy8EuEnk30OzqhzQqkGCsfAjgqh1r2kC93kQQGvE6Y6N1O3KFA9
	x3fbpcS4n1c4aZa8eWHK1rXxLurIthAQbFCGjjbT2HCUPe2lEqG/
X-Google-Smtp-Source: AGHT+IESUKIOz9EOD4bMAEVsQ1c3gyu5wcJumGnQDHtsVxQCfe0b14lkjpjGizmWJSNEPwvpeg6yqw==
X-Received: by 2002:a5d:5f8f:0:b0:368:6b29:a551 with SMTP id ffacd0b85a97d-36b5cee9840mr6605792f8f.1.1722275278275;
        Mon, 29 Jul 2024 10:47:58 -0700 (PDT)
Received: from tablet.my.domain ([37.30.0.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc8a7sm12716550f8f.59.2024.07.29.10.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 10:47:57 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 29 Jul 2024 19:47:40 +0200
Subject: [PATCH v3 06/10] power: supply: max77693: Add support for
 detecting and enabling OTG
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-max77693-charger-extcon-v3-6-02315a6869d4@gmail.com>
References: <20240729-max77693-charger-extcon-v3-0-02315a6869d4@gmail.com>
In-Reply-To: <20240729-max77693-charger-extcon-v3-0-02315a6869d4@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3976;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=024yPNon1poyVphR8keDLRzye+FGmZPcxiMYS+/Gw4c=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmp9W/Lu3SRHqrCllRimkJgkfsCB052nicnaGby
 3fEjo5pLcCJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZqfVvwAKCRCzu/ihE6BR
 aFShD/9WBNp5/ufqDpQ7Ogg4q0KyeCU9xsAXW84ooiCrfS0a5SX8ZzT2jc5ScfhgU1ZyYuUl7+/
 jYUxJzlwD9BdjwSavVI9AH1nBq+wLgV/KNFDy0Iu5flOwydmikW42LdfamtU8VL0JW+sAaY67EH
 Rr0doikJvv8XipnqngyCW1SI0jgTUsssYFmy6a0ZpitqOH3Wf52+JbOLZPsaIR/FFfi87RY2ZVQ
 jcuaLioPgV5ATsg37+pDeEMIiwQ5JavFUm48eiaLgjy6naHJ4TdJqj54raQNTzITnhegr6pQOit
 JPE9XKf0DWqkdMUQTRUyjrrd5QP6QS5CILANFIQ5nOr5PpF/uQOKBnqoN0Mx76nqB8iXStg971k
 rPF7CxarpHy/95mn7TNEEOnddw5w1/UIN+o9thvdlLtNDekcj9Du0y3MOaDC0Zj0I+ivWwYPu2o
 2Q1dXNQpg4N+qQj4QpssFSZgqp5v4MUgnnIHZQUVa/KVlxjMcIDY1jyf3ihgH8LRytX0ev2fnZE
 Vw3U4H2NMqtUGQoaWzNQmejf+g3SZbZfGsyDNHkI0Jw5dp8dbbsd6TmAkmoIVM7sfss3ibUA2xl
 4QaVv2EC8fXZ078HA/xH2qQzt4qFudoKDxXHhYICp6xcXa6OUq17o5ZAKuZJot7UYUV3n1b4ygB
 9ZJPzKcSI4ZCXuA==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Building upon the newly added extcon detection support, add detection
for USB OTG cables (EXTCON_USB_HOST type), and enable/disable the OTG
bits as needed.

Acked-by: Lee Jones <lee@kernel.org>
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
index 2e05467c682e..4ff402941d72 100644
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
2.45.2


