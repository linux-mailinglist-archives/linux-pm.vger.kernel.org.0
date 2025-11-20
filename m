Return-Path: <linux-pm+bounces-38293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE6CC7393A
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 11:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4ADA32FFF0
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 10:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3541732E722;
	Thu, 20 Nov 2025 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xf6Xe37v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1/IUTsO"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEA3309F1A
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636096; cv=none; b=fGAtTQuoH7tiWMFPKp8le/uAhp/V4kDNEvcOaJrgAqBWz8yqMMWPyRxji/cNUSnIOp66RPg5iFHAz7Gt6a8FKa94OOPfkk7wfBfXWFbhzpqUQ/pQFKrzHhPMH+c4LRwOcNommlMOt8WZQP6ZIQbkdhGJi4cLRTo+Tw6bL8zP85U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636096; c=relaxed/simple;
	bh=PPkJxw15+q7s7gLBQ6b8YTcBqwsFxxHaABelotsniF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYLjWvFWyUGSc6aXTEUYwcdOFe46z7W3J6727Yt0R888EI0SXuDh0GFw8ovMiBLc3w9nxOuajuhv2mn610dIEWmK6p1Ecd12bJwDZOPtX+gLKUm3NoRFhGwoEqFR/4gXGzSXLPtyBklF1NtwD60CpYAjG2zoygNYVIbkppiu1ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xf6Xe37v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1/IUTsO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763636091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e6kPwKFMU3muCTMc5BnD5BG1LleSTxWQrCXWXTRMkzw=;
	b=Xf6Xe37v+aXkkNY4lWy3OWbQQn0XgUTHIQE/fI7H1hnkiN6Eqef76k8GhibhTjK1woOaFw
	wo+iqAqKMzhkXxcr0mEBnwuSigHNkU+XLrSfX7VN31tIB8JJe0zoFdUGHcvpUiwoGEI6YI
	Jovgrr2jyTUTy1bwv49xiR1OPPmmhWg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-avhFcenEPc2Pq3RoZoWaFA-1; Thu, 20 Nov 2025 05:54:50 -0500
X-MC-Unique: avhFcenEPc2Pq3RoZoWaFA-1
X-Mimecast-MFC-AGG-ID: avhFcenEPc2Pq3RoZoWaFA_1763636089
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-37bb16b6181so3908291fa.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 02:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763636088; x=1764240888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6kPwKFMU3muCTMc5BnD5BG1LleSTxWQrCXWXTRMkzw=;
        b=D1/IUTsOaTq1YHG8Fx5GpLW5AcTKup8NXEEVdiRa1yT6YFCc2dhglUE6MS7+eoAk+Q
         pt1aAlQWIJaXpT99/GZaqVfXMHdDrB8bhqZbi6yHvJv2jnSwuTAbXL7B/h/zJZb4CrrG
         g/suoO3B2nU9rGqmlPCft1vFzPaRSav42fXXoC5Nueo199+EaVuaY6ESG6i2cLI8tw1T
         g/2EUGWWwkDmjyFsgSjDrka+BCTjQBTYdRI/L030y3iNXLELS0rBoxXjORb2XADF59Fw
         F+vCaIIs3smuP+6rwgY4ETYREBLgSZgJBgFsdfKTrHeoCP/wbFui7Gbeh9Mo2IeCma2S
         ODZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763636088; x=1764240888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e6kPwKFMU3muCTMc5BnD5BG1LleSTxWQrCXWXTRMkzw=;
        b=NTHoog2LLo9l6HSY/BkILKtASyBDfwgZBOASsYNtDT1IvRKirhUMvO0iHZlxX22AGA
         xnqu+kK5gmYyeVfL18YeV4kn8NbAt7OgZ/zT//+87uSEbwsb3za44MtdpGlrtdn2B6WZ
         FDFDnJc7PXQj0LfNeJRG+gF3+OoTJF+8KzL5kVQQAVL38nFDMIIyE4qzK1lPgrAeu0++
         4dMKpgSFLLLJS/lZlv75gKiLGcF3Yl2591tWagbuD4SbJgywSXEUYnj/6LLLmNCjDYLb
         RhZ1M3CK/Ce9sUm0UC6L0ao7J5iJ9t68HNeTZf/S5nxZBiG7ppk2CZK2Dapy1lIDFT2+
         UobA==
X-Forwarded-Encrypted: i=1; AJvYcCU6KM+ReVYmYqGrWAnYO4xyiQSUu4irKFCYj/XnWwxCVSZYvxbfdCaBFJJuTYgNP4mEYC5+WdPG8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0t1E3220yQnuVOuu7kbEcPHCbdvhiYfHYKp1fzDxnQrkCyQUm
	34jcAzaAkMDlwvYjxto8iE6IXtOa9n9sLIxfzMS2+x+JVaTnc0+OP/YgS3JBxIGUpcaFzr4DUbZ
	sjVstz5gGzGdOraw3zbYMoVIavNN3jBQ38u+6Yje3uWtSTJrfzoMpIAzc67c/
X-Gm-Gg: ASbGncu3iJtFK4z7SwX0mDH7crbek+ffRB9vDH5Ol7CGRLSEGbtMSVzgmZMsF3tEcZp
	zI7B5yKxALlBEnc865xHiUtoSY0htPaDyDsUVzFQxN1MIxdWxnTem8ZLJIbRpI6os/Tc3CdMHga
	KMXg2Hf1r55t4OIFRlGGgnR3bz7mN5dRdtuxb0WLumFhqhI04IqU6D7y86KLQ2jm/rJnjg/m5Kz
	vUri8R+lnOHasih1Dfu3AkhyYHgmJv6tqsRp3WdWI4hBDazO+szOP69Jkdrq9eI4JPWy8PeLiyK
	jTtbaOT60KjiJ1GENR72uN5slcfQ9aoKTqMUtQTJMRDw3Q7U9ZatTUP2O8MvwBfHYG6OsDI9sT9
	RtycCecf2AKjwmeP3V8FXZHkY/nHypOIzBftiuja+m5ufcb3Rxr8RSo+b7NkbXXxJeRk/0q9xj/
	B/wljC/zE=
X-Received: by 2002:a05:6512:1293:b0:594:5695:b403 with SMTP id 2adb3069b0e04-5969f4d29camr600505e87.34.1763636088192;
        Thu, 20 Nov 2025 02:54:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFAd/eh+KDgL2GfBzILWIcFYjQFmEmoU7hjdZMfKd54i8WZLRfd/gqHHmwBU9cmlRJhZ9nKw==
X-Received: by 2002:a05:6512:1293:b0:594:5695:b403 with SMTP id 2adb3069b0e04-5969f4d29camr600490e87.34.1763636087657;
        Thu, 20 Nov 2025 02:54:47 -0800 (PST)
Received: from sissix.redhat.com ([2a06:5900:814a:ab00:3725:2991:6cf3:b3aa])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbbefb8sm578218e87.46.2025.11.20.02.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 02:54:47 -0800 (PST)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-input@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 1/1] HID: input: Add support for multiple batteries per device
Date: Thu, 20 Nov 2025 10:54:39 +0000
Message-ID: <20251120105442.150508-2-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120105442.150508-1-lzampier@redhat.com>
References: <20251120105442.150508-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce struct hid_battery to encapsulate individual battery state and
enable HID devices to register multiple batteries, each identified by
its report ID.

This change adds struct hid_battery with all battery-related fields and
replaces the legacy dev->battery_* fields with a batteries list. All
memory management is converted to use devm_* for simpler cleanup.
Batteries are named using their report ID with the pattern
hid-{uniq}-battery-{report_id}. External drivers hid-apple and
hid-magicmouse are updated to use the new battery API via the
hid_get_first_battery() helper, and hid-input-test is updated for the
new battery structure.

This enables proper battery reporting for devices with multiple
batteries such as split keyboards, gaming headsets with charging docks,
and wireless earbuds with per-earbud batteries.

Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 drivers/hid/hid-apple.c      |  10 +-
 drivers/hid/hid-core.c       |   4 +
 drivers/hid/hid-input-test.c |  39 ++++---
 drivers/hid/hid-input.c      | 196 +++++++++++++++++++----------------
 drivers/hid/hid-magicmouse.c |  10 +-
 include/linux/hid.h          |  54 +++++++---
 6 files changed, 187 insertions(+), 126 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 57da4f86a..42ff0be7c 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -619,17 +619,19 @@ static int apple_fetch_battery(struct hid_device *hdev)
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 	struct hid_report_enum *report_enum;
 	struct hid_report *report;
+	struct hid_battery *bat;

-	if (!(asc->quirks & APPLE_RDESC_BATTERY) || !hdev->battery)
+	bat = hid_get_first_battery(hdev);
+	if (!(asc->quirks & APPLE_RDESC_BATTERY) || !bat)
 		return -1;

-	report_enum = &hdev->report_enum[hdev->battery_report_type];
-	report = report_enum->report_id_hash[hdev->battery_report_id];
+	report_enum = &hdev->report_enum[bat->report_type];
+	report = report_enum->report_id_hash[bat->report_id];

 	if (!report || report->maxfield < 1)
 		return -1;

-	if (hdev->battery_capacity == hdev->battery_max)
+	if (bat->capacity == bat->max)
 		return -1;

 	hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a5b3a8ca2..76d628547 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2990,6 +2990,10 @@ struct hid_device *hid_allocate_device(void)
 	mutex_init(&hdev->ll_open_lock);
 	kref_init(&hdev->ref);

+#ifdef CONFIG_HID_BATTERY_STRENGTH
+	INIT_LIST_HEAD(&hdev->batteries);
+#endif
+
 	ret = hid_bpf_device_init(hdev);
 	if (ret)
 		goto out_err;
diff --git a/drivers/hid/hid-input-test.c b/drivers/hid/hid-input-test.c
index 6f5c71660..c92008daf 100644
--- a/drivers/hid/hid-input-test.c
+++ b/drivers/hid/hid-input-test.c
@@ -9,54 +9,59 @@

 static void hid_test_input_update_battery_charge_status(struct kunit *test)
 {
-	struct hid_device *dev;
+	struct hid_battery *bat;
 	bool handled;

-	dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	bat = kunit_kzalloc(test, sizeof(*bat), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bat);

-	handled = hidinput_update_battery_charge_status(dev, HID_DG_HEIGHT, 0);
+	handled = hidinput_update_battery_charge_status(bat, HID_DG_HEIGHT, 0);
 	KUNIT_EXPECT_FALSE(test, handled);
-	KUNIT_EXPECT_EQ(test, dev->battery_charge_status, POWER_SUPPLY_STATUS_UNKNOWN);
+	KUNIT_EXPECT_EQ(test, bat->charge_status, POWER_SUPPLY_STATUS_UNKNOWN);

-	handled = hidinput_update_battery_charge_status(dev, HID_BAT_CHARGING, 0);
+	handled = hidinput_update_battery_charge_status(bat, HID_BAT_CHARGING, 0);
 	KUNIT_EXPECT_TRUE(test, handled);
-	KUNIT_EXPECT_EQ(test, dev->battery_charge_status, POWER_SUPPLY_STATUS_DISCHARGING);
+	KUNIT_EXPECT_EQ(test, bat->charge_status, POWER_SUPPLY_STATUS_DISCHARGING);

-	handled = hidinput_update_battery_charge_status(dev, HID_BAT_CHARGING, 1);
+	handled = hidinput_update_battery_charge_status(bat, HID_BAT_CHARGING, 1);
 	KUNIT_EXPECT_TRUE(test, handled);
-	KUNIT_EXPECT_EQ(test, dev->battery_charge_status, POWER_SUPPLY_STATUS_CHARGING);
+	KUNIT_EXPECT_EQ(test, bat->charge_status, POWER_SUPPLY_STATUS_CHARGING);
 }

 static void hid_test_input_get_battery_property(struct kunit *test)
 {
 	struct power_supply *psy;
+	struct hid_battery *bat;
 	struct hid_device *dev;
 	union power_supply_propval val;
 	int ret;

 	dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
-	dev->battery_avoid_query = true;
+
+	bat = kunit_kzalloc(test, sizeof(*bat), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bat);
+	bat->dev = dev;
+	bat->avoid_query = true;

 	psy = kunit_kzalloc(test, sizeof(*psy), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, psy);
-	psy->drv_data = dev;
+	psy->drv_data = bat;

-	dev->battery_status = HID_BATTERY_UNKNOWN;
-	dev->battery_charge_status = POWER_SUPPLY_STATUS_CHARGING;
+	bat->status = HID_BATTERY_UNKNOWN;
+	bat->charge_status = POWER_SUPPLY_STATUS_CHARGING;
 	ret = hidinput_get_battery_property(psy, POWER_SUPPLY_PROP_STATUS, &val);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 	KUNIT_EXPECT_EQ(test, val.intval, POWER_SUPPLY_STATUS_UNKNOWN);

-	dev->battery_status = HID_BATTERY_REPORTED;
-	dev->battery_charge_status = POWER_SUPPLY_STATUS_CHARGING;
+	bat->status = HID_BATTERY_REPORTED;
+	bat->charge_status = POWER_SUPPLY_STATUS_CHARGING;
 	ret = hidinput_get_battery_property(psy, POWER_SUPPLY_PROP_STATUS, &val);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 	KUNIT_EXPECT_EQ(test, val.intval, POWER_SUPPLY_STATUS_CHARGING);

-	dev->battery_status = HID_BATTERY_REPORTED;
-	dev->battery_charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
+	bat->status = HID_BATTERY_REPORTED;
+	bat->charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
 	ret = hidinput_get_battery_property(psy, POWER_SUPPLY_PROP_STATUS, &val);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 	KUNIT_EXPECT_EQ(test, val.intval, POWER_SUPPLY_STATUS_DISCHARGING);
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 2bbb645c2..9c1afe88f 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -419,18 +419,18 @@ static unsigned find_battery_quirk(struct hid_device *hdev)
 	return quirks;
 }

-static int hidinput_scale_battery_capacity(struct hid_device *dev,
+static int hidinput_scale_battery_capacity(struct hid_battery *bat,
 					   int value)
 {
-	if (dev->battery_min < dev->battery_max &&
-	    value >= dev->battery_min && value <= dev->battery_max)
-		value = ((value - dev->battery_min) * 100) /
-			(dev->battery_max - dev->battery_min);
+	if (bat->min < bat->max &&
+	    value >= bat->min && value <= bat->max)
+		value = ((value - bat->min) * 100) /
+			(bat->max - bat->min);

 	return value;
 }

-static int hidinput_query_battery_capacity(struct hid_device *dev)
+static int hidinput_query_battery_capacity(struct hid_battery *bat)
 {
 	u8 *buf;
 	int ret;
@@ -439,14 +439,14 @@ static int hidinput_query_battery_capacity(struct hid_device *dev)
 	if (!buf)
 		return -ENOMEM;

-	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, 4,
-				 dev->battery_report_type, HID_REQ_GET_REPORT);
+	ret = hid_hw_raw_request(bat->dev, bat->report_id, buf, 4,
+				 bat->report_type, HID_REQ_GET_REPORT);
 	if (ret < 2) {
 		kfree(buf);
 		return -ENODATA;
 	}

-	ret = hidinput_scale_battery_capacity(dev, buf[1]);
+	ret = hidinput_scale_battery_capacity(bat, buf[1]);
 	kfree(buf);
 	return ret;
 }
@@ -455,7 +455,8 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 					 enum power_supply_property prop,
 					 union power_supply_propval *val)
 {
-	struct hid_device *dev = power_supply_get_drvdata(psy);
+	struct hid_battery *bat = power_supply_get_drvdata(psy);
+	struct hid_device *dev = bat->dev;
 	int value;
 	int ret = 0;

@@ -466,13 +467,13 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 		break;

 	case POWER_SUPPLY_PROP_CAPACITY:
-		if (dev->battery_status != HID_BATTERY_REPORTED &&
-		    !dev->battery_avoid_query) {
-			value = hidinput_query_battery_capacity(dev);
+		if (bat->status != HID_BATTERY_REPORTED &&
+		    !bat->avoid_query) {
+			value = hidinput_query_battery_capacity(bat);
 			if (value < 0)
 				return value;
 		} else  {
-			value = dev->battery_capacity;
+			value = bat->capacity;
 		}

 		val->intval = value;
@@ -483,20 +484,20 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 		break;

 	case POWER_SUPPLY_PROP_STATUS:
-		if (dev->battery_status != HID_BATTERY_REPORTED &&
-		    !dev->battery_avoid_query) {
-			value = hidinput_query_battery_capacity(dev);
+		if (bat->status != HID_BATTERY_REPORTED &&
+		    !bat->avoid_query) {
+			value = hidinput_query_battery_capacity(bat);
 			if (value < 0)
 				return value;

-			dev->battery_capacity = value;
-			dev->battery_status = HID_BATTERY_QUERIED;
+			bat->capacity = value;
+			bat->status = HID_BATTERY_QUERIED;
 		}

-		if (dev->battery_status == HID_BATTERY_UNKNOWN)
+		if (bat->status == HID_BATTERY_UNKNOWN)
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
 		else
-			val->intval = dev->battery_charge_status;
+			val->intval = bat->charge_status;
 		break;

 	case POWER_SUPPLY_PROP_SCOPE:
@@ -511,37 +512,54 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 	return ret;
 }

+static struct hid_battery *hidinput_find_battery(struct hid_device *dev,
+						 int report_id)
+{
+	struct hid_battery *bat;
+
+	list_for_each_entry(bat, &dev->batteries, list) {
+		if (bat->report_id == report_id)
+			return bat;
+	}
+	return NULL;
+}
+
 static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 				  struct hid_field *field, bool is_percentage)
 {
+	struct hid_battery *bat;
 	struct power_supply_desc *psy_desc;
-	struct power_supply_config psy_cfg = { .drv_data = dev, };
+	struct power_supply_config psy_cfg = { 0 };
 	unsigned quirks;
 	s32 min, max;
-	int error;

-	if (dev->battery)
-		return 0;	/* already initialized? */
+	if (hidinput_find_battery(dev, field->report->id))
+		return 0;	/* already initialized */

 	quirks = find_battery_quirk(dev);

-	hid_dbg(dev, "device %x:%x:%x %d quirks %d\n",
-		dev->bus, dev->vendor, dev->product, dev->version, quirks);
+	hid_dbg(dev, "device %x:%x:%x %d quirks %d report_id %d\n",
+		dev->bus, dev->vendor, dev->product, dev->version, quirks,
+		field->report->id);

 	if (quirks & HID_BATTERY_QUIRK_IGNORE)
 		return 0;

-	psy_desc = kzalloc(sizeof(*psy_desc), GFP_KERNEL);
+	bat = devm_kzalloc(&dev->dev, sizeof(*bat), GFP_KERNEL);
+	if (!bat)
+		return -ENOMEM;
+
+	psy_desc = devm_kzalloc(&dev->dev, sizeof(*psy_desc), GFP_KERNEL);
 	if (!psy_desc)
 		return -ENOMEM;

-	psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery",
-				   strlen(dev->uniq) ?
-					dev->uniq : dev_name(&dev->dev));
-	if (!psy_desc->name) {
-		error = -ENOMEM;
-		goto err_free_mem;
-	}
+	psy_desc->name = devm_kasprintf(&dev->dev, GFP_KERNEL,
+					"hid-%s-battery-%d",
+					strlen(dev->uniq) ?
+						dev->uniq : dev_name(&dev->dev),
+					field->report->id);
+	if (!psy_desc->name)
+		return -ENOMEM;

 	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
 	psy_desc->properties = hidinput_battery_props;
@@ -560,98 +578,89 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	if (quirks & HID_BATTERY_QUIRK_FEATURE)
 		report_type = HID_FEATURE_REPORT;

-	dev->battery_min = min;
-	dev->battery_max = max;
-	dev->battery_report_type = report_type;
-	dev->battery_report_id = field->report->id;
-	dev->battery_charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
+	bat->dev = dev;
+	bat->min = min;
+	bat->max = max;
+	bat->report_type = report_type;
+	bat->report_id = field->report->id;
+	bat->charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
+	bat->status = HID_BATTERY_UNKNOWN;

 	/*
 	 * Stylus is normally not connected to the device and thus we
 	 * can't query the device and get meaningful battery strength.
 	 * We have to wait for the device to report it on its own.
 	 */
-	dev->battery_avoid_query = report_type == HID_INPUT_REPORT &&
-				   field->physical == HID_DG_STYLUS;
+	bat->avoid_query = report_type == HID_INPUT_REPORT &&
+			   field->physical == HID_DG_STYLUS;

 	if (quirks & HID_BATTERY_QUIRK_AVOID_QUERY)
-		dev->battery_avoid_query = true;
-
-	dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
-	if (IS_ERR(dev->battery)) {
-		error = PTR_ERR(dev->battery);
-		hid_warn(dev, "can't register power supply: %d\n", error);
-		goto err_free_name;
+		bat->avoid_query = true;
+
+	psy_cfg.drv_data = bat;
+	bat->ps = devm_power_supply_register(&dev->dev, psy_desc, &psy_cfg);
+	if (IS_ERR(bat->ps)) {
+		hid_warn(dev, "can't register power supply: %ld\n",
+			 PTR_ERR(bat->ps));
+		return PTR_ERR(bat->ps);
 	}

-	power_supply_powers(dev->battery, &dev->dev);
-	return 0;
+	power_supply_powers(bat->ps, &dev->dev);

-err_free_name:
-	kfree(psy_desc->name);
-err_free_mem:
-	kfree(psy_desc);
-	dev->battery = NULL;
-	return error;
+	list_add_tail(&bat->list, &dev->batteries);
+
+	return 0;
 }

 static void hidinput_cleanup_battery(struct hid_device *dev)
 {
-	const struct power_supply_desc *psy_desc;
-
-	if (!dev->battery)
-		return;
+	struct hid_battery *bat, *next;

-	psy_desc = dev->battery->desc;
-	power_supply_unregister(dev->battery);
-	kfree(psy_desc->name);
-	kfree(psy_desc);
-	dev->battery = NULL;
+	list_for_each_entry_safe(bat, next, &dev->batteries, list) {
+		list_del(&bat->list);
+	}
 }

-static bool hidinput_update_battery_charge_status(struct hid_device *dev,
+static bool hidinput_update_battery_charge_status(struct hid_battery *bat,
 						  unsigned int usage, int value)
 {
 	switch (usage) {
 	case HID_BAT_CHARGING:
-		dev->battery_charge_status = value ?
-					     POWER_SUPPLY_STATUS_CHARGING :
-					     POWER_SUPPLY_STATUS_DISCHARGING;
+		bat->charge_status = value ?
+				     POWER_SUPPLY_STATUS_CHARGING :
+				     POWER_SUPPLY_STATUS_DISCHARGING;
 		return true;
 	}

 	return false;
 }

-static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
-				    int value)
+static void hidinput_update_battery(struct hid_battery *bat,
+				    unsigned int usage, int value)
 {
 	int capacity;

-	if (!dev->battery)
-		return;
-
-	if (hidinput_update_battery_charge_status(dev, usage, value)) {
-		power_supply_changed(dev->battery);
+	if (hidinput_update_battery_charge_status(bat, usage, value)) {
+		power_supply_changed(bat->ps);
 		return;
 	}

 	if ((usage & HID_USAGE_PAGE) == HID_UP_DIGITIZER && value == 0)
 		return;

-	if (value < dev->battery_min || value > dev->battery_max)
+	if (value < bat->min || value > bat->max)
 		return;

-	capacity = hidinput_scale_battery_capacity(dev, value);
+	capacity = hidinput_scale_battery_capacity(bat, value);

-	if (dev->battery_status != HID_BATTERY_REPORTED ||
-	    capacity != dev->battery_capacity ||
-	    ktime_after(ktime_get_coarse(), dev->battery_ratelimit_time)) {
-		dev->battery_capacity = capacity;
-		dev->battery_status = HID_BATTERY_REPORTED;
-		dev->battery_ratelimit_time =
+	if (bat->status != HID_BATTERY_REPORTED ||
+	    capacity != bat->capacity ||
+	    ktime_after(ktime_get_coarse(), bat->ratelimit_time)) {
+		bat->capacity = capacity;
+		bat->status = HID_BATTERY_REPORTED;
+		bat->ratelimit_time =
 			ktime_add_ms(ktime_get_coarse(), 30 * 1000);
-		power_supply_changed(dev->battery);
+		power_supply_changed(bat->ps);
 	}
 }
 #else  /* !CONFIG_HID_BATTERY_STRENGTH */
@@ -665,8 +674,14 @@ static void hidinput_cleanup_battery(struct hid_device *dev)
 {
 }

-static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
-				    int value)
+static struct hid_battery *hidinput_find_battery(struct hid_device *dev,
+						 int report_id)
+{
+	return NULL;
+}
+
+static void hidinput_update_battery(struct hid_battery *bat,
+				    unsigned int usage, int value)
 {
 }
 #endif	/* CONFIG_HID_BATTERY_STRENGTH */
@@ -1534,7 +1549,10 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		return;

 	if (usage->type == EV_PWR) {
-		hidinput_update_battery(hid, usage->hid, value);
+		struct hid_battery *bat = hidinput_find_battery(hid, report->id);
+
+		if (bat)
+			hidinput_update_battery(bat, usage->hid, value);
 		return;
 	}

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 7d4a25c6d..b495f7a4b 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -812,19 +812,21 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
 #ifdef CONFIG_HID_BATTERY_STRENGTH
 	struct hid_report_enum *report_enum;
 	struct hid_report *report;
+	struct hid_battery *bat;

-	if (!hdev->battery ||
+	bat = hid_get_first_battery(hdev);
+	if (!bat ||
 	    (!is_usb_magicmouse2(hdev->vendor, hdev->product) &&
 	     !is_usb_magictrackpad2(hdev->vendor, hdev->product)))
 		return -1;

-	report_enum = &hdev->report_enum[hdev->battery_report_type];
-	report = report_enum->report_id_hash[hdev->battery_report_id];
+	report_enum = &hdev->report_enum[bat->report_type];
+	report = report_enum->report_id_hash[bat->report_id];

 	if (!report || report->maxfield < 1)
 		return -1;

-	if (hdev->battery_capacity == hdev->battery_max)
+	if (bat->capacity == bat->max)
 		return -1;

 	hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index a4ddb94e3..3e33ef74c 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -634,6 +634,36 @@ enum hid_battery_status {
 	HID_BATTERY_REPORTED,		/* Device sent unsolicited battery strength report */
 };

+/**
+ * struct hid_battery - represents a single battery power supply
+ * @dev: pointer to the parent hid_device
+ * @ps: the power supply instance
+ * @min: minimum battery value from HID descriptor
+ * @max: maximum battery value from HID descriptor
+ * @report_type: HID report type (input/feature)
+ * @report_id: HID report ID for this battery
+ * @charge_status: current charging status
+ * @status: battery reporting status
+ * @capacity: current battery capacity (0-100)
+ * @avoid_query: if true, avoid querying battery (e.g., for stylus)
+ * @ratelimit_time: rate limiting for battery reports
+ * @list: list node for linking into hid_device's battery list
+ */
+struct hid_battery {
+	struct hid_device *dev;
+	struct power_supply *ps;
+	__s32 min;
+	__s32 max;
+	__s32 report_type;
+	__s32 report_id;
+	__s32 charge_status;
+	enum hid_battery_status status;
+	__s32 capacity;
+	bool avoid_query;
+	ktime_t ratelimit_time;
+	struct list_head list;
+};
+
 struct hid_driver;
 struct hid_ll_driver;

@@ -670,19 +700,10 @@ struct hid_device {
 #ifdef CONFIG_HID_BATTERY_STRENGTH
 	/*
 	 * Power supply information for HID devices which report
-	 * battery strength. power_supply was successfully registered if
-	 * battery is non-NULL.
+	 * battery strength. Each battery is tracked separately in the
+	 * batteries list.
 	 */
-	struct power_supply *battery;
-	__s32 battery_capacity;
-	__s32 battery_min;
-	__s32 battery_max;
-	__s32 battery_report_type;
-	__s32 battery_report_id;
-	__s32 battery_charge_status;
-	enum hid_battery_status battery_status;
-	bool battery_avoid_query;
-	ktime_t battery_ratelimit_time;
+	struct list_head batteries;
 #endif

 	unsigned long status;						/* see STAT flags above */
@@ -743,6 +764,15 @@ static inline void hid_set_drvdata(struct hid_device *hdev, void *data)
 	dev_set_drvdata(&hdev->dev, data);
 }

+#ifdef CONFIG_HID_BATTERY_STRENGTH
+static inline struct hid_battery *hid_get_first_battery(struct hid_device *hdev)
+{
+	if (list_empty(&hdev->batteries))
+		return NULL;
+	return list_first_entry(&hdev->batteries, struct hid_battery, list);
+}
+#endif
+
 #define HID_GLOBAL_STACK_SIZE 4
 #define HID_COLLECTION_STACK_SIZE 4

--
2.51.0


