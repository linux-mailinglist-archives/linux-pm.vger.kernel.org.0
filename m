Return-Path: <linux-pm+bounces-11105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3231931508
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 14:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A24228259F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 12:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4255818E776;
	Mon, 15 Jul 2024 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRC/969B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780D318E755;
	Mon, 15 Jul 2024 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048120; cv=none; b=sfdCIISPOvU6Q4RKpGjGoTW8YRiur3LiPWMAXFkADern6dnGn+8sEKhi3fXSAuDmvCqla9xRfN8lyV7F8CIKOLudqUNfGo7bznOY9wEGHFe5WFgrtOofYMrr7sD5+v1o9aedOIjEjZHcgSBoBoP4VM6to7xeS8QGZEtx45C8hNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048120; c=relaxed/simple;
	bh=sa109WgAcykCnYFwcY2iDwvvtR/mCqo5hBu3QTu8IW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oF9wfv275id31D4koT6/Eyym7OF+FbQJ94nocXgyFbIFKnlkQL1K9XAAaIn9mIRPsU+0cOGksfTmUox4qBXwqvCrYmIhsONdZl+Ss7c50netYORbE4rf6mKQF8UOMm3TJAZP26oh0LFEeeDGPkk4bwCHUV9QI0iJhb/ObdWNGkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRC/969B; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-595712c49ebso5133699a12.0;
        Mon, 15 Jul 2024 05:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721048117; x=1721652917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hy8uXIYsKBTu0N7Z2wuBwfh2n1x8LDG4iwV5RA5Sikk=;
        b=LRC/969BXBpy9ruF9OiSIyFQxq9qRX7NrQC+1JeliGPvxPX62R1ypiJpfOvGTJkV5c
         bSz6sW9kxZ+N5e/B42fjrunWhoJCV/AAPA8RJhTRA6fe94SyZ9lV7WOvjwppZpJj03Ij
         L/y6YqHufyrTXvWMReYyuF/P5E0XdFM4WpR9K9lj9sX5qoW9gheCEP4ZpM+EHICuQsz9
         IIfa7zICKJftKifBguBkuafPn7eHI03ptepeh1IlPnbxFFSGloR59c9YrQSksE3AjS4b
         qWZl8f8SLvB5E9dvmjFqSGkmbqP7ZyynzXZ/2Nzyb6MD1LX6v5goEowNTo08FZzKXtLo
         U7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721048117; x=1721652917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hy8uXIYsKBTu0N7Z2wuBwfh2n1x8LDG4iwV5RA5Sikk=;
        b=b/NZYSeImL3q6VUG6ByWeRTintAUd0WYGAIGatsdjPKG7wLs/vWBQt88eDXZJwjrKG
         GksNEcjBwiv/9fFvEqSdABl9qGIDp1xk8Fzqa5LnD12gR+3DAnGDxY7eCP1//zQEXn5K
         eKSJGBK93R658anG9IEammoat+Omy1JTMg6BFRVq2jAc5PoOcx2fnXpv/hZFIWSUGXE/
         Q3LWGtOwP9L/kZe8zZAXMXWCAknM+MXQN9As0wuSeK1Q2uEB2ZHl+ZtyIh2FxEdwPZcc
         b+mbe/A9nhYFj25EzZ75/iqs2Oi0GDcLl/tUqivrvhAlz+gel6pW06YhHBv3kHaw76ML
         aVNA==
X-Forwarded-Encrypted: i=1; AJvYcCUhC1XDkU5iCj37AbiK1iyc77ag2lubs1rlSfVlr7SpBlaCgCL964q+O4/Nx/87+gAfpPv3Uxhcn11yspZf4ZIfriJPRMzt9r9eSjpbAQkN/gCtZ7ScQq/Z+8q2QqEiEsOCFQi2TSkRPN70XojoQhr3ZpsMXw0j7HGzbNm8zW2Jr4wwTTipwfjcwsWiIGi01JEusMpOuByw4NtbYXF5Epw3BOaXAdY=
X-Gm-Message-State: AOJu0YwvPkekLSXDDHDyRa+DfQy3lC0ZoXf16W/CWORro/i4jYQTrxqh
	3AlLJb9tUTRI3bAEEPtQOdNy9Ohr4hPQChiCL2c6wft/q//3l1N9GV7U4SiR
X-Google-Smtp-Source: AGHT+IFSeOUQ4GQ0JktHokv589tUfaMihwOmd9W2rP3yeBHjQVzPLMNMNZgec2Vx5yIRh3tyCsIOBA==
X-Received: by 2002:a05:6402:5bc6:b0:587:2dd0:93ec with SMTP id 4fb4d7f45d1cf-594bc7c7e36mr12494193a12.30.1721048116556;
        Mon, 15 Jul 2024 05:55:16 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-157-210.multi.internet.cyfrowypolsat.pl. [37.248.157.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26f62165sm3333307a12.87.2024.07.15.05.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:55:16 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 15 Jul 2024 14:55:05 +0200
Subject: [PATCH v2 3/9] regulator: max77693: Set fast charge current in
 MAX77693 CHARGER regulator
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-max77693-charger-extcon-v2-3-0838ffbb18c3@gmail.com>
References: <20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com>
In-Reply-To: <20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3543;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=sa109WgAcykCnYFwcY2iDwvvtR/mCqo5hBu3QTu8IW4=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmlRwpIpRGh8YMXJ3XQOkQ2hUgOoJw/29UT+Po2
 VR5KAyFJ3yJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZpUcKQAKCRCzu/ihE6BR
 aLY6EACF7ffTvprcNEbjAy1hgs2bevgEwN4A3e2ItBicKITTLCZFfKxd2+k4A4oXyjZ3N15Ewg3
 VKas0dQ03e4EoTGGlT/HTcwhVR8tIkGM3367YU8ZdNXJsOK8O0X5AbQ5m6YEHag6w5hVnICJEGA
 VUUXnOYofTqM5FkphC/9RrYfSRTmAwDV43Ha71LP+up6hhgZPDZz/MJWhTkfiI29P31gOBQGvhz
 C9maOTwMswG7NlAmTFofooE/R8jZRQ+tHrPj81cNjI75K5x8rb8vkYOTQphbU5GNnKBOp3llefC
 C5SjiHEgMfqAj9wV5wKYEee7W4rDkwygXa0deHUjG+ng2+hNJlwmkKSlgYSrmbcR5pA8XWPna3i
 qqgU7bDA7PxzgCLSzs9SfBu7gzx7dbhfUKA8Z5HG2lCuOu8kkz9QMrDjG6KwGoZ36gxcyAU+t2s
 PyFm4pBN+P3+OcRG8DKyi5ix9NGO/p0qdyhr9vo1HW/dTPhygvgt8HGBsZxQFYoOb4oAaA5UbKT
 7JbQhROiYfHM5L8kjqAc5yldv3OtB9rnKJNUA9DimrwQeAkbMuXK0i2nHfrlLTy0TbtJMFFmuR3
 O++w5f3y5GPOMfSDo6/iNb2iWs0SWVBKVJD0F7YAHdjlh8uhEuyHpOnRkXiUrD6B5xh5tmFe8s2
 tfe4E4tD1MEgblQ==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

The MAX77693 CHARGER regulator only controlled the "charge input
current", with fast charge current being listed as a TODO.

Fix this by also setting the fast charge current when the CHARGER
regulator limits are changed.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Added this commit
---
 drivers/regulator/max77693-regulator.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/max77693-regulator.c b/drivers/regulator/max77693-regulator.c
index 72a67d0c5f1e..3fee2e255fd0 100644
--- a/drivers/regulator/max77693-regulator.c
+++ b/drivers/regulator/max77693-regulator.c
@@ -36,6 +36,7 @@ enum max77843_regulator_type {
 
 /* Register differences between chargers: MAX77693 and MAX77843 */
 struct chg_reg_data {
+	enum max77693_types type;
 	unsigned int linear_reg;
 	unsigned int linear_mask;
 	unsigned int uA_step;
@@ -46,11 +47,12 @@ struct chg_reg_data {
  * MAX77693 CHARGER regulator - Min : 20mA, Max : 2580mA, step : 20mA
  * 0x00, 0x01, 0x2, 0x03	= 60 mA
  * 0x04 ~ 0x7E			= (60 + (X - 3) * 20) mA
- * Actually for MAX77693 the driver manipulates the maximum input current,
- * not the fast charge current (output). This should be fixed.
  *
  * On MAX77843 the calculation formula is the same (except values).
  * Fortunately it properly manipulates the fast charge current.
+ *
+ * On MAX77693 there is an additional "fast charge current" register:
+ * min: 0 mA, max: 2100mA, step: 0.1A / 3.
  */
 static int max77693_chg_get_current_limit(struct regulator_dev *rdev)
 {
@@ -86,6 +88,7 @@ static int max77693_chg_set_current_limit(struct regulator_dev *rdev,
 	const struct chg_reg_data *reg_data = rdev_get_drvdata(rdev);
 	unsigned int chg_min_uA = rdev->constraints->min_uA;
 	int sel = 0;
+	int ret;
 
 	while (chg_min_uA + reg_data->uA_step * sel < min_uA)
 		sel++;
@@ -96,7 +99,30 @@ static int max77693_chg_set_current_limit(struct regulator_dev *rdev,
 	/* the first four codes for charger current are all 60mA */
 	sel += reg_data->min_sel;
 
-	return regmap_write(rdev->regmap, reg_data->linear_reg, sel);
+	ret = regmap_write(rdev->regmap, reg_data->linear_reg, sel);
+	if (ret)
+		return ret;
+
+	if (reg_data->type == TYPE_MAX77693) {
+		/*
+		 * For MAX77693 we also have to set the fast charge current
+		 * value. This value has a lower upper limit (2.1A), so we cap
+		 * it at the highest possible value if it goes above the limit.
+		 */
+
+		sel = (min_uA / 1000) * 10 / 333; /* 0.1A/3 steps */
+
+		if (sel > CHG_CNFG_02_CC_MASK)
+			sel = CHG_CNFG_02_CC_MASK;
+
+		sel <<= CHG_CNFG_02_CC_SHIFT;
+
+		return regmap_update_bits(rdev->regmap,
+				MAX77693_CHG_REG_CHG_CNFG_02,
+				CHG_CNFG_02_CC_MASK, sel);
+	}
+
+	return 0;
 }
 /* end of CHARGER regulator ops */
 
@@ -179,6 +205,7 @@ static const struct regulator_desc max77693_supported_regulators[] = {
 };
 
 static const struct chg_reg_data max77693_chg_reg_data = {
+	.type		= TYPE_MAX77693,
 	.linear_reg	= MAX77693_CHG_REG_CHG_CNFG_09,
 	.linear_mask	= CHG_CNFG_09_CHGIN_ILIM_MASK,
 	.uA_step	= 20000,
@@ -219,6 +246,7 @@ static const struct regulator_desc max77843_supported_regulators[] = {
 };
 
 static const struct chg_reg_data max77843_chg_reg_data = {
+	.type		= TYPE_MAX77843,
 	.linear_reg	= MAX77843_CHG_REG_CHG_CNFG_02,
 	.linear_mask	= MAX77843_CHG_FAST_CHG_CURRENT_MASK,
 	.uA_step	= MAX77843_CHG_FAST_CHG_CURRENT_STEP,

-- 
2.45.2


