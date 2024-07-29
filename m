Return-Path: <linux-pm+bounces-11578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0AE93FCB8
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 19:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0AF1C2187E
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F363B189F50;
	Mon, 29 Jul 2024 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjDZrpmP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3632E1891C3;
	Mon, 29 Jul 2024 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275283; cv=none; b=DsER/MozBO5dftl3raDYNrJmUDu+/nGxvmaKOR0FMtJ49k/kyEba7NpLAC3UEjEvZxIBBJ0fd9mtImwqK/TpDMzBJ4rGKd1VvdwtCeGOj2rZ5KscJgoWlS0xP/8FzO9v0T0gb8OrCB/AG/msTruN2Ra9AftY2T4RNzzih1/yERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275283; c=relaxed/simple;
	bh=tNiZCBQ9vI1N19lL0qdAjIhq26icJW5eSTf6NBMnkgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uk3JrWs2mECQwFIVkUg55Ykjr+jqueAC4Zi1ACDgoALSRm0/dgPBbQyY+xkFo9vgX34xX4A8MAdrwGGGWOKXndr5KBsl4Rc6Sv4tC0RmY/e2JPoMaV9AdePW8n+zUKNrEsdHoCiodzQT/cnGJnaemJOBIzo8IDaT0NnsDtQRquo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjDZrpmP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-368f92df172so1606802f8f.2;
        Mon, 29 Jul 2024 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722275280; x=1722880080; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpdY2w7Ol8tWjnklayT84Hbch6eCd/qeKmcHW5pT54o=;
        b=SjDZrpmPRqZU4F1Avg2qNj1hhZuR5QO3ZCgEOfZGU6XJXUZ6nTJKo30b029rTP9D4A
         wJUD5Ask+ks3i0AyDqBdp+5DFWgqBSENVqh7FHYf3NYnc4RAguAwYg4jGg9ZYaisEvaK
         WdoW9+Wu9P2E3y1ojidU/PnzC02Jm0Tq8MCLeF+TEdkMvHZEFha+q5ia+NGbO6Jxr6zT
         oix3iY8lxP70Q4XBrhrBRFcWZslztaP1h/Mxr+dSBJyisxvSmAk4nY545ZfGB894gTvN
         CchkDzqLdGvEjwLKXXQAxX7JI+Z9t406By81zsNF+wkZSp03ohOz+60JB+tobf8Xue1T
         KQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275280; x=1722880080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpdY2w7Ol8tWjnklayT84Hbch6eCd/qeKmcHW5pT54o=;
        b=NLd1jsiuR2tE61db8m96VO5qNaPBKN5C9wPzEXr2RVbemHIyMNm6Ix/SBJpjl53+ZO
         4Trg4ZgYEWMC1Hp4GeOkNppcLgmLyO/4eV4WQIHyfqGeaa1JWxYR34L1hcDzWMWDw4Jh
         n18gr75pvJpv8WBSPQ+ZUtUCHOAu+pkrCUrLsqRymp+3sFxypZwm7VNmpiD0MFngVFUt
         tgOmeDkaLBTE99A7i8Zz+sJT4Gj3ym5UeojkvP4WiaNVxwMxAvTzep5CPYeBsN5H/Att
         xTPzLwqRSevsgFt9WWn07kJEbs0UZ5ssvZYaS2ZM59gsjujfvfz6RBncUFOtF42USU6+
         gQJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZBjWhNEveNZNPna4+kiD06gSrKMzfQyhSthaugK1HMArQuvH7eSJJmC/hOEBrEMyJgTxkMDZgE+vGkAF0rbOtXtk0rny6wBRcvT+42FGS5Cm9GLqrExIJHJlsyTFoEPLUXyx+4KSJ0lX7L9g0iKMImISRu0i45cASzD7O3tL4G926YwQB9xxLDL+KihO/AfPD4h+eEl8BdavfwX+m/w83TzliG5c=
X-Gm-Message-State: AOJu0YyfaY2ndGUm9xo8tjSvFXqw0Szp6iT0lrRZatpiPVvcmD7uUybR
	1cBqZ24sI+5pfzNBkq43zKSiE2QAgYJRh31zfdUImM/vABVHrPp4
X-Google-Smtp-Source: AGHT+IG/etUYMRG6EQg3R1Ca5UxAVuYa4JhLhQk6wFKPKMSpy23CLMxyZ6mlKsFnXrd8dFDFYq+WEA==
X-Received: by 2002:a05:6000:bc8:b0:368:7883:d14a with SMTP id ffacd0b85a97d-36b5d0444c5mr5780214f8f.33.1722275280385;
        Mon, 29 Jul 2024 10:48:00 -0700 (PDT)
Received: from tablet.my.domain ([37.30.0.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc8a7sm12716550f8f.59.2024.07.29.10.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 10:48:00 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 29 Jul 2024 19:47:41 +0200
Subject: [PATCH v3 07/10] power: supply: max77693: Set up charge/input
 current according to cable type
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-max77693-charger-extcon-v3-7-02315a6869d4@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2747;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=tNiZCBQ9vI1N19lL0qdAjIhq26icJW5eSTf6NBMnkgo=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmp9W/eTAFqhVcvrxPcQ+i1t+kITIAHn3E7QU9A
 CeM1wmLctSJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZqfVvwAKCRCzu/ihE6BR
 aDvyD/wNx5ko3xSL7orlI3cGVCD7U32mrcClUQ68x7NQswffpG0Xf42NfKJ8oRTLad7pBGhNMBS
 VeljVGA0BFvNoydBZEcxuoQok5SaS0V/dQCQfCYNmy7HskdQ98iyLl2GJnjKsumqHGpvmUnLgoA
 GoDSfu9hYvLNIfySqjyTdA7l7+FGS9o90jhszRGoyA/z66fhIvaz45oNM1nzWTBiIsTRjh2KPS7
 7+0HIiFDBwO5z88Xc4dMYZNDg/T4lWImqom440DIcBexUlI7QYYHywaY/sb48GmZaYfj6To/o+T
 V/MwFb/7YCAVhfGJ9Ks/tS92cKe6MNanINbFKJpRPIdA4dByoe9PDg5KHauA5yONue1JWIKPHuk
 uD36E1hP38Vqgpg3JexTR0ftothf6Skw2U7EVNM1rpQuIMHg5rtKly0pQb1Y+xmcpJmxfxxZ4E+
 y33Gcwt6y6Y36cnKrCAKTYvDL8Q/TfNlKncnbhWpy4s1eAXwRdonGlfUWvANnYmVApYkflTBo6E
 R8r0JOQ8PwZYUvg7iIWtQMU9cSX823LV2P5JIzH7A3KoqxBdRg66NXl9+HTEwNcpp/tJIzSutdd
 BZ835HurQGvaCglBdfyT0eOQOQw9DBHqKC1ezht/u50LgujCzsMox/GoaqUVN5jv2/QqdeM8C3t
 luoi1jeXZvpb48w==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

This behavior was observed on a downstream kernel - for chargers, the
current would be set to a fast charge current value, and it would be
bumped down for all other cable types.

If we leave only the fast charge current value applied, peripheral mode
stops working. If we stick to 500mA, charging becomes too slow. So, set
the charge input current limit accordingly to the cable type.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v3:
- Re-introduced this commit from v1. It seems to have been accidentally
  rolled into the previous commit in v2.
---
 drivers/power/supply/max77693_charger.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index 4ff402941d72..a3aeaba77309 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -716,6 +716,7 @@ static void max77693_charger_extcon_work(struct work_struct *work)
 						  cable.work);
 	struct extcon_dev *edev = chg->cable.edev;
 	bool set_charging, set_otg;
+	unsigned int input_current;
 	int connector, state;
 	int ret;
 
@@ -728,19 +729,28 @@ static void max77693_charger_extcon_work(struct work_struct *work)
 
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
 
@@ -748,6 +758,7 @@ static void max77693_charger_extcon_work(struct work_struct *work)
 			 connector);
 		break;
 	default:
+		input_current = 500000; /* 500 mA */
 		set_charging = false;
 		set_otg = false;
 
@@ -756,6 +767,12 @@ static void max77693_charger_extcon_work(struct work_struct *work)
 		break;
 	}
 
+	ret = max77693_set_input_current_limit(chg, input_current);
+	if (ret) {
+		dev_err(chg->dev, "failed to set input current (%d)\n", ret);
+		goto out;
+	}
+
 	ret = max77693_set_charging(chg, set_charging);
 	if (ret) {
 		dev_err(chg->dev, "failed to set charging (%d)\n", ret);

-- 
2.45.2


