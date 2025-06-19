Return-Path: <linux-pm+bounces-29084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEE4AE0970
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 16:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F526A03A6
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020FB28C2B1;
	Thu, 19 Jun 2025 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAiZ0vOx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4A28B511
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344926; cv=none; b=umXTpecerlbSu3fIfen5va03xbiFJxUHI0vXkPkBYi/WcmLfQGXV2nF6xm4eX0Ppxtbq8K9tUI/EMFPloCK6yIS8W/8LHnUgpOnHA2qmm0uQXxNTkW+CZzdojDXqQE4EapjXHI21RAAT7xlwa1ku7O60uB1ay22Jcs6d2VbzaS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344926; c=relaxed/simple;
	bh=OWLz8jy0aYNhz1ULgnx3Uoo5bzB1cKuLHiMXElp54PI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GQfMo7zKHUZ4GX3mCo3MJgmt6EDo6xGT3QWe97iSywCKQt1vXnVtSyVenO+W+v7TnaowlX7uk2yRpERVLDyklEDMDq9qCzHIy3H7Gskix3rthJfB1NWTWKtQNv4dPLmaCNp2bWZkp27jh8dF7eqVznj9rplMNq4nzSsNcn6svb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cAiZ0vOx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so6442585e9.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 07:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750344922; x=1750949722; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dnf+feM05FonyZlazVIOtB30dq6CHjOa2Ov1CmFsycc=;
        b=cAiZ0vOxo3eoBOjHhxbVtn+mmCd9v5n/dtseGM10BjPEzbC6+82oFk42xsCddDXfVA
         hGGUP16/wJ1ubIRZor//crD8vgg0XGIBs9/XMFKZbgVM8SsxuDyf2j3vtZ2ZdFCxJbYg
         JiSnoswoD4p43dhI+8OOMSR1oDQaCYfwP3PzzOBlPLLv04zr+GEmNBKCskgcNL6KTqSa
         wkJoTwuapbi6ZDQmlPsBZWosFnSr0/yfabq+tm8FIDdyx8Gm+SSQ+vjnW3YDtwR631ip
         e6swyLDqxUnkHnC2JEf0sbDTOT/sKuXR5WIj+QdZaQHfNWd1I4uh3rg3e34eJ5FzU8Gn
         galg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344922; x=1750949722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnf+feM05FonyZlazVIOtB30dq6CHjOa2Ov1CmFsycc=;
        b=aWjM3Z4sM2d6EQcNW6+olcsSE8vPiafx3/A3fiK+q8I+ZCIJWswkhiARC852Tnshv4
         gKDbMIEJ/jHChxfZumBAmptTJPpAzX8zjtPmbGQIX1l41FpcWlodJSDLlmpn4Ey6uEjO
         A3Wgc3CiXtHzQemrrXifwZfJzoz8ZSHQ8VsyD008F1XabBVMxoojUiKE2yQ6f7cc3tFz
         LHuSpH9qehswzjJ9QrJr3+3elUMI2vdtEJn8/UbNJE66jDbgayYFdfFcer0KouJToOpf
         BFATVsIDcAoqoPMbiYj64dq3wgzEptQuTa9wtSqNQzFbwqKmPdkuuwjAMCLzH/NNQ8tv
         E7bw==
X-Forwarded-Encrypted: i=1; AJvYcCXSgQZyoEO2pOi5Y3TfFQ+64unG40E6wpBmyQz1dllI2ODL641G/WwHJChwhKAWD0s1i3eMjsRTJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg+iW2VJNejnvkyzTGKbsPcd9lfhNehJHFN20UcVHg0yq4Pi3d
	N7uV6+3MWUT5mwAZ8dlhzWBGpDDc22Ez90EfJQlOpIGjlte3U4RSXKJ4KFvZYJLXhUU=
X-Gm-Gg: ASbGncu76KmPTGcX8eRGofd9jHEFCr13gqg55s3m7Rkka3LBVcPZ/zSP5o4HjsMxOhV
	JTQ5TEan3rAE7SHfGP9WhOpKEgjqDoNKGsPLqFNsbckDJjIVcSnL/mX72fC6Hgr+xFHXRBUY8k1
	aAFwHsN0eidjIZzk1r9NUiVOanYs/5QLszwNJpsJrDRnZRpq3bnmUe0S2f4v9d37IIHfjuP++AQ
	Bw7m2+ZK69C6hG0v8pL3GzzCWCfYnNJge3m5ARYeK6QOwNU1icZDHTQuob1fguzZ/mQa7tn7x54
	05tyXBszSTTZTGBHZoIwvNRutvFCh7bNtWQ0SkPivj1O6F6HPhT0NIDYYwnexZz3gpMyGRgEIie
	vw9YyBx8KQHk=
X-Google-Smtp-Source: AGHT+IH/e7xadtOoCFZYila+AAoZ9HnFHye/u22AteKbqkhelHkoFqJjVHtiDctthry8gjEGaxNFqw==
X-Received: by 2002:a05:600c:3153:b0:442:f4a3:9388 with SMTP id 5b1f17b1804b1-45350e7c275mr122080525e9.19.1750344921855;
        Thu, 19 Jun 2025 07:55:21 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([2a0e:c5c1:0:100:b058:b8f5:b561:423c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebced8asm31343715e9.40.2025.06.19.07.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:55:21 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Jun 2025 16:55:12 +0200
Subject: [PATCH 04/11] power: supply: pmi8998_charger: rename to qcom_smbx
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-smb2-smb5-support-v1-4-ac5dec51b6e1@linaro.org>
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
In-Reply-To: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-hardening@vger.kernel.org, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17352;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=OWLz8jy0aYNhz1ULgnx3Uoo5bzB1cKuLHiMXElp54PI=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoVCTR5QQWOfKw4wNukOAR+6QYsvQU/EnPxlc3j
 +oPY/FAIb6JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaFQk0QAKCRAFgzErGV9k
 ttpQEACf/dWD6EO6igozEPvUMvpjWhziJWfMyCYyN3Ce7wq8qfmaAWS5mGMu0NcrTzRTxuxP8H1
 eOttX5MznBrgpT0Rr+Y/8TILIX0+SwOmJuSjXq7PSnC7XxQMlzL0fBRsc6pgtI1hRvpQw+CES7N
 21ob+fiOrnzdkyV8MzVVzBhcB7nW3wHg7EuOLnHyU7rqbFso2Zj/vJOqNVhzfvv3lQ5xb8/KmvC
 hAfFabZaN7qtl5k6q0u8uRyVz3jQFQKIJiLe+YziDNSXVdvpH4tPslyl0tefnBwenARd7R/zWNc
 jja+1ON085/MuYNDFO+vlF+Fa0JodRP8/x6ODsg3JkWoGUr7OSQdSbaJK/juzMsiOql8dlQ2wcK
 BphQMVFvcV1FwniNstZo2kJrijEoXlfy20TMBBHhV0yDpR39v5LRxrEGD/OQPdkAJFMGsysf4aB
 Qwauj0q1a2xEF7qjhfyjOvHLjBU2JwBGcjiXWs0ba42Bn5btKHn1K03H7YFXCx/KY4PmFv1Q9T8
 pu0WW6ycnxPSukQ22oQCF2rMtHcfwBY9V9Q+AIokcuJYPh6m/PAbJtND0Ehy6uFKF5pNjv0ofRc
 TLYHYzy0yxRUybTNc1U+sAya7tjhW5udvsB9beAyoYwkvWP0EpuSqYs+PG2+mSbm9Qilj2dtwXt
 Md1+vvTFSV1Jvrw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47

Prepare to add smb5 support by making variables and the file name more
generic. Also take the opportunity to remove the "_charger" suffix since
smb2 always refers to a charger.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/power/supply/Makefile                      |   2 +-
 .../supply/{qcom_pmi8998_charger.c => qcom_smbx.c} | 148 ++++++++++-----------
 2 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 4f5f8e3507f80da02812f0d08c2d81ddff0a272f..f943c9150b326d41ff241f82610f70298635eb08 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -119,6 +119,6 @@ obj-$(CONFIG_RN5T618_POWER)	+= rn5t618_power.o
 obj-$(CONFIG_BATTERY_ACER_A500)	+= acer_a500_battery.o
 obj-$(CONFIG_BATTERY_SURFACE)	+= surface_battery.o
 obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
 obj-$(CONFIG_BATTERY_UG3105)	+= ug3105_battery.o
-obj-$(CONFIG_CHARGER_QCOM_SMB2)	+= qcom_pmi8998_charger.o
+obj-$(CONFIG_CHARGER_QCOM_SMB2)	+= qcom_smbx.o
 obj-$(CONFIG_FUEL_GAUGE_MM8013)	+= mm8013.o
diff --git a/drivers/power/supply/qcom_pmi8998_charger.c b/drivers/power/supply/qcom_smbx.c
similarity index 88%
rename from drivers/power/supply/qcom_pmi8998_charger.c
rename to drivers/power/supply/qcom_smbx.c
index cd3cb473c70dd1c289cc4094e74746e3c6dc16ee..b1cb925581ec6b8cfca3897be2de5b00a336c920 100644
--- a/drivers/power/supply/qcom_pmi8998_charger.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -361,19 +361,19 @@ enum charger_status {
 	INHIBIT_CHARGE,
 	DISABLE_CHARGE,
 };
 
-struct smb2_register {
+struct smb_init_register {
 	u16 addr;
 	u8 mask;
 	u8 val;
 };
 
 /**
- * struct smb2_chip - smb2 chip structure
+ * struct smb_chip - smb chip structure
  * @dev:		Device reference for power_supply
  * @name:		The platform device name
- * @base:		Base address for smb2 registers
+ * @base:		Base address for smb registers
  * @regmap:		Register map
  * @batt_info:		Battery data from DT
  * @status_change_work: Worker to handle plug/unplug events
  * @cable_irq:		USB plugin IRQ
@@ -381,9 +381,9 @@ struct smb2_register {
  * @usb_in_i_chan:	USB_IN current measurement channel
  * @usb_in_v_chan:	USB_IN voltage measurement channel
  * @chg_psy:		Charger power supply instance
  */
-struct smb2_chip {
+struct smb_chip {
 	struct device *dev;
 	const char *name;
 	unsigned int base;
 	struct regmap *regmap;
@@ -398,9 +398,9 @@ struct smb2_chip {
 
 	struct power_supply *chg_psy;
 };
 
-static enum power_supply_property smb2_properties[] = {
+static enum power_supply_property smb_properties[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
@@ -410,9 +410,9 @@ static enum power_supply_property smb2_properties[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_USB_TYPE,
 };
 
-static int smb2_get_prop_usb_online(struct smb2_chip *chip, int *val)
+static int smb_get_prop_usb_online(struct smb_chip *chip, int *val)
 {
 	unsigned int stat;
 	int rc;
 
@@ -430,15 +430,15 @@ static int smb2_get_prop_usb_online(struct smb2_chip *chip, int *val)
 /*
  * Qualcomm "automatic power source detection" aka APSD
  * tells us what type of charger we're connected to.
  */
-static int smb2_apsd_get_charger_type(struct smb2_chip *chip, int *val)
+static int smb_apsd_get_charger_type(struct smb_chip *chip, int *val)
 {
 	unsigned int apsd_stat, stat;
 	int usb_online = 0;
 	int rc;
 
-	rc = smb2_get_prop_usb_online(chip, &usb_online);
+	rc = smb_get_prop_usb_online(chip, &usb_online);
 	if (!usb_online) {
 		*val = POWER_SUPPLY_USB_TYPE_UNKNOWN;
 		return rc;
 	}
@@ -470,15 +470,15 @@ static int smb2_apsd_get_charger_type(struct smb2_chip *chip, int *val)
 
 	return 0;
 }
 
-static int smb2_get_prop_status(struct smb2_chip *chip, int *val)
+static int smb_get_prop_status(struct smb_chip *chip, int *val)
 {
 	unsigned char stat[2];
 	int usb_online = 0;
 	int rc;
 
-	rc = smb2_get_prop_usb_online(chip, &usb_online);
+	rc = smb_get_prop_usb_online(chip, &usb_online);
 	if (!usb_online) {
 		*val = POWER_SUPPLY_STATUS_DISCHARGING;
 		return rc;
 	}
@@ -518,9 +518,9 @@ static int smb2_get_prop_status(struct smb2_chip *chip, int *val)
 		return rc;
 	}
 }
 
-static inline int smb2_get_current_limit(struct smb2_chip *chip,
+static inline int smb_get_current_limit(struct smb_chip *chip,
 					 unsigned int *val)
 {
 	int rc = regmap_read(chip->regmap, chip->base + ICL_STATUS, val);
 
@@ -528,9 +528,9 @@ static inline int smb2_get_current_limit(struct smb2_chip *chip,
 		*val *= CURRENT_SCALE_FACTOR;
 	return rc;
 }
 
-static int smb2_set_current_limit(struct smb2_chip *chip, unsigned int val)
+static int smb_set_current_limit(struct smb_chip *chip, unsigned int val)
 {
 	unsigned char val_raw;
 
 	if (val > 4800000) {
@@ -543,24 +543,24 @@ static int smb2_set_current_limit(struct smb2_chip *chip, unsigned int val)
 	return regmap_write(chip->regmap, chip->base + USBIN_CURRENT_LIMIT_CFG,
 			    val_raw);
 }
 
-static void smb2_status_change_work(struct work_struct *work)
+static void smb_status_change_work(struct work_struct *work)
 {
 	unsigned int charger_type, current_ua;
 	int usb_online = 0;
 	int count, rc;
-	struct smb2_chip *chip;
+	struct smb_chip *chip;
 
-	chip = container_of(work, struct smb2_chip, status_change_work.work);
+	chip = container_of(work, struct smb_chip, status_change_work.work);
 
-	smb2_get_prop_usb_online(chip, &usb_online);
+	smb_get_prop_usb_online(chip, &usb_online);
 	if (!usb_online)
 		return;
 
 	for (count = 0; count < 3; count++) {
 		dev_dbg(chip->dev, "get charger type retry %d\n", count);
-		rc = smb2_apsd_get_charger_type(chip, &charger_type);
+		rc = smb_apsd_get_charger_type(chip, &charger_type);
 		if (rc != -EAGAIN)
 			break;
 		msleep(100);
 	}
@@ -591,13 +591,13 @@ static void smb2_status_change_work(struct work_struct *work)
 		current_ua = SDP_CURRENT_UA;
 		break;
 	}
 
-	smb2_set_current_limit(chip, current_ua);
+	smb_set_current_limit(chip, current_ua);
 	power_supply_changed(chip->chg_psy);
 }
 
-static int smb2_get_iio_chan(struct smb2_chip *chip, struct iio_channel *chan,
+static int smb_get_iio_chan(struct smb_chip *chip, struct iio_channel *chan,
 			     int *val)
 {
 	int rc;
 	union power_supply_propval status;
@@ -616,9 +616,9 @@ static int smb2_get_iio_chan(struct smb2_chip *chip, struct iio_channel *chan,
 
 	return iio_read_channel_processed(chan, val);
 }
 
-static int smb2_get_prop_health(struct smb2_chip *chip, int *val)
+static int smb_get_prop_health(struct smb_chip *chip, int *val)
 {
 	int rc;
 	unsigned int stat;
 
@@ -650,13 +650,13 @@ static int smb2_get_prop_health(struct smb2_chip *chip, int *val)
 		return 0;
 	}
 }
 
-static int smb2_get_property(struct power_supply *psy,
+static int smb_get_property(struct power_supply *psy,
 			     enum power_supply_property psp,
 			     union power_supply_propval *val)
 {
-	struct smb2_chip *chip = power_supply_get_drvdata(psy);
+	struct smb_chip *chip = power_supply_get_drvdata(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_MANUFACTURER:
 		val->strval = "Qualcomm";
@@ -664,45 +664,45 @@ static int smb2_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = chip->name;
 		return 0;
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
-		return smb2_get_current_limit(chip, &val->intval);
+		return smb_get_current_limit(chip, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		return smb2_get_iio_chan(chip, chip->usb_in_i_chan,
+		return smb_get_iio_chan(chip, chip->usb_in_i_chan,
 					 &val->intval);
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		return smb2_get_iio_chan(chip, chip->usb_in_v_chan,
+		return smb_get_iio_chan(chip, chip->usb_in_v_chan,
 					 &val->intval);
 	case POWER_SUPPLY_PROP_ONLINE:
-		return smb2_get_prop_usb_online(chip, &val->intval);
+		return smb_get_prop_usb_online(chip, &val->intval);
 	case POWER_SUPPLY_PROP_STATUS:
-		return smb2_get_prop_status(chip, &val->intval);
+		return smb_get_prop_status(chip, &val->intval);
 	case POWER_SUPPLY_PROP_HEALTH:
-		return smb2_get_prop_health(chip, &val->intval);
+		return smb_get_prop_health(chip, &val->intval);
 	case POWER_SUPPLY_PROP_USB_TYPE:
-		return smb2_apsd_get_charger_type(chip, &val->intval);
+		return smb_apsd_get_charger_type(chip, &val->intval);
 	default:
 		dev_err(chip->dev, "invalid property: %d\n", psp);
 		return -EINVAL;
 	}
 }
 
-static int smb2_set_property(struct power_supply *psy,
+static int smb_set_property(struct power_supply *psy,
 			     enum power_supply_property psp,
 			     const union power_supply_propval *val)
 {
-	struct smb2_chip *chip = power_supply_get_drvdata(psy);
+	struct smb_chip *chip = power_supply_get_drvdata(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
-		return smb2_set_current_limit(chip, val->intval);
+		return smb_set_current_limit(chip, val->intval);
 	default:
 		dev_err(chip->dev, "No setter for property: %d\n", psp);
 		return -EINVAL;
 	}
 }
 
-static int smb2_property_is_writable(struct power_supply *psy,
+static int smb_property_is_writable(struct power_supply *psy,
 				     enum power_supply_property psp)
 {
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
@@ -711,11 +711,11 @@ static int smb2_property_is_writable(struct power_supply *psy,
 		return 0;
 	}
 }
 
-static irqreturn_t smb2_handle_batt_overvoltage(int irq, void *data)
+static irqreturn_t smb_handle_batt_overvoltage(int irq, void *data)
 {
-	struct smb2_chip *chip = data;
+	struct smb_chip *chip = data;
 	unsigned int status;
 
 	regmap_read(chip->regmap, chip->base + BATTERY_CHARGER_STATUS_2,
 		    &status);
@@ -728,11 +728,11 @@ static irqreturn_t smb2_handle_batt_overvoltage(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t smb2_handle_usb_plugin(int irq, void *data)
+static irqreturn_t smb_handle_usb_plugin(int irq, void *data)
 {
-	struct smb2_chip *chip = data;
+	struct smb_chip *chip = data;
 
 	power_supply_changed(chip->chg_psy);
 
 	schedule_delayed_work(&chip->status_change_work,
@@ -740,20 +740,20 @@ static irqreturn_t smb2_handle_usb_plugin(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t smb2_handle_usb_icl_change(int irq, void *data)
+static irqreturn_t smb_handle_usb_icl_change(int irq, void *data)
 {
-	struct smb2_chip *chip = data;
+	struct smb_chip *chip = data;
 
 	power_supply_changed(chip->chg_psy);
 
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t smb2_handle_wdog_bark(int irq, void *data)
+static irqreturn_t smb_handle_wdog_bark(int irq, void *data)
 {
-	struct smb2_chip *chip = data;
+	struct smb_chip *chip = data;
 	int rc;
 
 	power_supply_changed(chip->chg_psy);
 
@@ -764,24 +764,24 @@ static irqreturn_t smb2_handle_wdog_bark(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
 
-static const struct power_supply_desc smb2_psy_desc = {
+static const struct power_supply_desc smb_psy_desc = {
 	.name = "pmi8998_charger",
 	.type = POWER_SUPPLY_TYPE_USB,
 	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_SDP) |
 		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
 		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
 		     BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
-	.properties = smb2_properties,
-	.num_properties = ARRAY_SIZE(smb2_properties),
-	.get_property = smb2_get_property,
-	.set_property = smb2_set_property,
-	.property_is_writeable = smb2_property_is_writable,
+	.properties = smb_properties,
+	.num_properties = ARRAY_SIZE(smb_properties),
+	.get_property = smb_get_property,
+	.set_property = smb_set_property,
+	.property_is_writeable = smb_property_is_writable,
 };
 
 /* Init sequence derived from vendor downstream driver */
-static const struct smb2_register smb2_init_seq[] = {
+static const struct smb_init_register smb_init_seq[] = {
 	{ .addr = AICL_RERUN_TIME_CFG, .mask = AICL_RERUN_TIME_MASK, .val = 0 },
 	/*
 	 * By default configure us as an upstream facing port
 	 * FIXME: This will be handled by the type-c driver
@@ -881,19 +881,19 @@ static const struct smb2_register smb2_init_seq[] = {
 	  .mask = FAST_CHARGE_CURRENT_SETTING_MASK,
 	  .val = 1000000 / CURRENT_SCALE_FACTOR },
 };
 
-static int smb2_init_hw(struct smb2_chip *chip)
+static int smb_init_hw(struct smb_chip *chip)
 {
 	int rc, i;
 
-	for (i = 0; i < ARRAY_SIZE(smb2_init_seq); i++) {
+	for (i = 0; i < ARRAY_SIZE(smb_init_seq); i++) {
 		dev_dbg(chip->dev, "%d: Writing 0x%02x to 0x%02x\n", i,
-			smb2_init_seq[i].val, smb2_init_seq[i].addr);
+			smb_init_seq[i].val, smb_init_seq[i].addr);
 		rc = regmap_update_bits(chip->regmap,
-					chip->base + smb2_init_seq[i].addr,
-					smb2_init_seq[i].mask,
-					smb2_init_seq[i].val);
+					chip->base + smb_init_seq[i].addr,
+					smb_init_seq[i].mask,
+					smb_init_seq[i].val);
 		if (rc < 0)
 			return dev_err_probe(chip->dev, rc,
 					     "%s: init command %d failed\n",
 					     __func__, i);
@@ -901,9 +901,9 @@ static int smb2_init_hw(struct smb2_chip *chip)
 
 	return 0;
 }
 
-static int smb2_init_irq(struct smb2_chip *chip, int *irq, const char *name,
+static int smb_init_irq(struct smb_chip *chip, int *irq, const char *name,
 			 irqreturn_t (*handler)(int irq, void *data))
 {
 	int irqnum;
 	int rc;
@@ -923,13 +923,13 @@ static int smb2_init_irq(struct smb2_chip *chip, int *irq, const char *name,
 
 	return 0;
 }
 
-static int smb2_probe(struct platform_device *pdev)
+static int smb_probe(struct platform_device *pdev)
 {
 	struct power_supply_config supply_config = {};
 	struct power_supply_desc *desc;
-	struct smb2_chip *chip;
+	struct smb_chip *chip;
 	int rc, irq;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -958,19 +958,19 @@ static int smb2_probe(struct platform_device *pdev)
 		return dev_err_probe(chip->dev, PTR_ERR(chip->usb_in_i_chan),
 				     "Couldn't get usbin_i IIO channel\n");
 	}
 
-	rc = smb2_init_hw(chip);
+	rc = smb_init_hw(chip);
 	if (rc < 0)
 		return rc;
 
 	supply_config.drv_data = chip;
 	supply_config.fwnode = dev_fwnode(&pdev->dev);
 
-	desc = devm_kzalloc(chip->dev, sizeof(smb2_psy_desc), GFP_KERNEL);
+	desc = devm_kzalloc(chip->dev, sizeof(smb_psy_desc), GFP_KERNEL);
 	if (!desc)
 		return -ENOMEM;
-	memcpy(desc, &smb2_psy_desc, sizeof(smb2_psy_desc));
+	memcpy(desc, &smb_psy_desc, sizeof(smb_psy_desc));
 	desc->name =
 		devm_kasprintf(chip->dev, GFP_KERNEL, "%s-charger",
 			       (const char *)device_get_match_data(chip->dev));
 	if (!desc->name)
@@ -987,9 +987,9 @@ static int smb2_probe(struct platform_device *pdev)
 		return dev_err_probe(chip->dev, rc,
 				     "Failed to get battery info\n");
 
 	rc = devm_delayed_work_autocancel(chip->dev, &chip->status_change_work,
-					  smb2_status_change_work);
+					  smb_status_change_work);
 	if (rc)
 		return dev_err_probe(chip->dev, rc,
 				     "Failed to init status change work\n");
 
@@ -998,22 +998,22 @@ static int smb2_probe(struct platform_device *pdev)
 				FLOAT_VOLTAGE_SETTING_MASK, rc);
 	if (rc < 0)
 		return dev_err_probe(chip->dev, rc, "Couldn't set vbat max\n");
 
-	rc = smb2_init_irq(chip, &irq, "bat-ov", smb2_handle_batt_overvoltage);
+	rc = smb_init_irq(chip, &irq, "bat-ov", smb_handle_batt_overvoltage);
 	if (rc < 0)
 		return rc;
 
-	rc = smb2_init_irq(chip, &chip->cable_irq, "usb-plugin",
-			   smb2_handle_usb_plugin);
+	rc = smb_init_irq(chip, &chip->cable_irq, "usb-plugin",
+			   smb_handle_usb_plugin);
 	if (rc < 0)
 		return rc;
 
-	rc = smb2_init_irq(chip, &irq, "usbin-icl-change",
-			   smb2_handle_usb_icl_change);
+	rc = smb_init_irq(chip, &irq, "usbin-icl-change",
+			   smb_handle_usb_icl_change);
 	if (rc < 0)
 		return rc;
-	rc = smb2_init_irq(chip, &irq, "wdog-bark", smb2_handle_wdog_bark);
+	rc = smb_init_irq(chip, &irq, "wdog-bark", smb_handle_wdog_bark);
 	if (rc < 0)
 		return rc;
 
 	devm_device_init_wakeup(chip->dev);
@@ -1029,24 +1029,24 @@ static int smb2_probe(struct platform_device *pdev)
 
 	return 0;
 }
 
-static const struct of_device_id smb2_match_id_table[] = {
+static const struct of_device_id smb_match_id_table[] = {
 	{ .compatible = "qcom,pmi8998-charger", .data = "pmi8998" },
 	{ .compatible = "qcom,pm660-charger", .data = "pm660" },
 	{ /* sentinal */ }
 };
-MODULE_DEVICE_TABLE(of, smb2_match_id_table);
+MODULE_DEVICE_TABLE(of, smb_match_id_table);
 
-static struct platform_driver qcom_spmi_smb2 = {
-	.probe = smb2_probe,
+static struct platform_driver qcom_spmi_smb = {
+	.probe = smb_probe,
 	.driver = {
-		.name = "qcom-pmi8998/pm660-charger",
-		.of_match_table = smb2_match_id_table,
+		.name = "qcom-smbx-charger",
+		.of_match_table = smb_match_id_table,
 		},
 };
 
-module_platform_driver(qcom_spmi_smb2);
+module_platform_driver(qcom_spmi_smb);
 
 MODULE_AUTHOR("Casey Connolly <casey.connolly@linaro.org>");
 MODULE_DESCRIPTION("Qualcomm SMB2 Charger Driver");
 MODULE_LICENSE("GPL");

-- 
2.49.0


