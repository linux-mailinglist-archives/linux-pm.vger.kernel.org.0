Return-Path: <linux-pm+bounces-39947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A218CDEA08
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 12:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 997523009FA0
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A15631A7FE;
	Fri, 26 Dec 2025 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMcDEObg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzL2/ULo"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E369631985B
	for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766747434; cv=none; b=jnd+kI0Xr+ORNGQgP9Ibs6PipPmg9SS2IyDanvzuwUiBXIfck8FEA+t8s2QErcDjIEpGh5wViLW8gNuE7wBgT69/STV2h1AzClIPA9Y+gEcfwR6/e6oeU2kqmDsHjgjXANRHJew+m5Tz8UCS+CH2AS1witGD4i7g0yg2GJ1+XCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766747434; c=relaxed/simple;
	bh=OPqAPXSNfScp/WjOLLIGKwDhHxQ0u7LBqf+H7bfoa0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxVyigMGaRiReMBUrogpC7gW7/cqsbCk3n+e9sXIr3Gh6y+gzFVbnJhBynnsT7/Sj9l8M5oRZh/KXe+au6svzk3AzSs5n+PO1Z6rVRhuWcitACq0dINb0w9n/IbGGnglavPQ9WMNctUKbsUxEgrLhbDTiM3YhqEDj4it9ZRQY/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMcDEObg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzL2/ULo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766747430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5lzUQU6gKnw7KrSrIVAgtcMoXzj3A3pQeBpgfzCf+yc=;
	b=XMcDEObgBrZR7C6uPPEGqdOW0HTMs1VLY4uuY2MDATqQOIfUYfGc8Ffqil8phgAdMbw8Iy
	6yT0lrVzk916l3NF7pIkdwggAF4yJaQLTcsxlkpbQrJjGpmMvi6/GPA55CaRfJelSUnISV
	yaqWa63AGYnDPtU//lkQjzCTqK2AlJQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-Y4omGf7rPUOA4Yn41GYphQ-1; Fri, 26 Dec 2025 06:10:28 -0500
X-MC-Unique: Y4omGf7rPUOA4Yn41GYphQ-1
X-Mimecast-MFC-AGG-ID: Y4omGf7rPUOA4Yn41GYphQ_1766747427
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d17fff653so24774865e9.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 03:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766747427; x=1767352227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lzUQU6gKnw7KrSrIVAgtcMoXzj3A3pQeBpgfzCf+yc=;
        b=LzL2/ULozcJbW5/i+QD8TPMAnn/haWMoDwI1vISb/Y1gEai0gtFoizgwkm46OMgBVi
         RUgyDxwj53ZO1u/RPkbougaS39wa1hpizXYxVYVXz0ytkkTvT4X0Ejb+it1pSn7r6XHV
         IIvxQHR2Y0HlTktydUp1SemvxY4VLMMNlbxGRHXUWGG1qbQf2TmPY3n5vSQ2iQo8aA9e
         ObFlOQgRJN6NxHcd12qnr1eE6mDFYp2pteXx9O3CfVosCvop9iNKwEAb2vmRLiFCYCUK
         Sx7z14NXeW4NLmhEZ8yZCp9/cwaKZBRYtgWJ5RpaE/Eqby8uLnMaHim2uPxQc4xG/U1M
         RU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766747427; x=1767352227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5lzUQU6gKnw7KrSrIVAgtcMoXzj3A3pQeBpgfzCf+yc=;
        b=WJ8kn/r6BavFEBdPR2heUDdGaS7djkSg481PcbUGBmiYw9h8JPHV9HLVCyqAOgw4m1
         9dwxosZnG3SG97ZiaAfl7ZhDEQER/Bz7u3dSEQso1Ry+mcvEwgBoWzGlRi+KDn/zLX2S
         WjzVe0czbTwMkr3ZK2WuNBnuChvCcpLMh657N07WPVdJ3+lK0PMwJ6bhrRAFvad7XNID
         Q+DEkXZp0RSXy/bgy9XKFMeMpkGyhF5UTK/7ZAyH2DOjbns1uhxl9HpKKFUhC6y3N3gq
         LjT/Hhfa18g00FEjTPZaj0+dQPC0owAUsqtquDJN2dEZWKUZUFWZ7m1f2hVmjAFe6pcU
         RH3w==
X-Forwarded-Encrypted: i=1; AJvYcCULNfd7HdWFgA1OXlz0WTZAR+Ao//G75JMs6lC6HpHvBUHPc149c3eDPESHdv2zzXbjJqhl5qaLWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCJM6jzGwJ7k/WopuLSJH/T3PVyQJOCnY/ecdmJ0QmS7pjiDAU
	VBfEjCLUKJ2likrCGnhN2e5PAEV81Yeo2ajrXc7aJOdpIj+OC0AqtgUrZf1HssdgnaWb18/OuCG
	JyRDWEoFmlPqAA/CKd3nRacgqcqWUekqcb6F/tcuw8qQrEjtkIFEAH6vAw47y
X-Gm-Gg: AY/fxX7bUb2Z3Bciv2feijxDSjuOmxiNdoizgr7+OyIc5F3GJUZqGWpmgCLMwJrmjM9
	+mUvTM87q76E9AJdyHSlE4XCyMwui0a36QG3nBc6bGdDucuFBV2AOjGzg4UyjD28vnoJTriEMk/
	QIaQ1cAOhpEapd1zXxoKM0Zdi4hNJcgV0YinqlP+rTyiDATLpjOxLtfokHIrjr62CDXIEcNM7fR
	27RDVav6wPCxKBxUHJJSzmPcdSSFcTuKamyjY2j7Qx7NxOGLqJrZGXZtkhWHX3LAaOxiAs+6C1G
	WUYiLQIBxh6lGqKjdXaGCpdPNY2DFjp7oJvF2ojj2HhDbDXufSVuawAzt12xjFafyswk7IZBmcQ
	UIzKlkhouv1lRsdj+94acuREILosRHNvVyr+Ikx5d0fKQCDoIFjbWvQ2JuJsx9YqG9c6L3ywhZW
	PwukpJ+KBPAg==
X-Received: by 2002:a05:600c:45cf:b0:477:582e:7a81 with SMTP id 5b1f17b1804b1-47d1954986fmr222389755e9.4.1766747426996;
        Fri, 26 Dec 2025 03:10:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyHY3l79eahMPdTGyMoL8hWD3V6bSrWPn5iCpySXOAIfLf8X++0alz/pvmfAWdglqioPYYPw==
X-Received: by 2002:a05:600c:45cf:b0:477:582e:7a81 with SMTP id 5b1f17b1804b1-47d1954986fmr222389445e9.4.1766747426560;
        Fri, 26 Dec 2025 03:10:26 -0800 (PST)
Received: from sissix.lzampier.com ([2a06:5900:814a:ab00:3725:2991:6cf3:b3aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193d4e91sm375653855e9.13.2025.12.26.03.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 03:10:26 -0800 (PST)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-input@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	linux-pm@vger.kernel.org,
	lcasmz54@gmail.com
Subject: [PATCH v6 2/3] HID: input: Introduce struct hid_battery and refactor battery code
Date: Fri, 26 Dec 2025 11:10:15 +0000
Message-ID: <20251226111019.31243-3-lzampier@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251226111019.31243-1-lzampier@redhat.com>
References: <20251226111019.31243-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce struct hid_battery to encapsulate individual battery state,
preparing for future multi-battery support.

The new structure contains all battery-related fields previously stored
directly in hid_device (capacity, min, max, report_type, report_id,
charge_status, etc.). The hid_device->battery pointer type changes from
struct power_supply* to struct hid_battery*, and all battery functions
are refactored accordingly.

A hid_get_battery() helper is added for external drivers, with
hid-apple.c and hid-magicmouse.c updated to use the new API. The
hid-input-test.c KUnit tests are also updated for the new structure.

No functional changes for single-battery devices.

Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 drivers/hid/hid-apple.c      |  10 +--
 drivers/hid/hid-input-test.c |  39 ++++++-----
 drivers/hid/hid-input.c      | 123 ++++++++++++++++++++---------------
 drivers/hid/hid-magicmouse.c |  10 +--
 include/linux/hid.h          |  49 ++++++++++----
 5 files changed, 140 insertions(+), 91 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 61404d7a43ee..4889160beefe 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -618,17 +618,19 @@ static int apple_fetch_battery(struct hid_device *hdev)
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 	struct hid_report_enum *report_enum;
 	struct hid_report *report;
+	struct hid_battery *bat;
 
-	if (!(asc->quirks & APPLE_RDESC_BATTERY) || !hdev->battery)
+	bat = hid_get_battery(hdev);
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
diff --git a/drivers/hid/hid-input-test.c b/drivers/hid/hid-input-test.c
index 6f5c71660d82..c92008dafddf 100644
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
index 71862beede9e..c2d16236c638 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -418,18 +418,18 @@ static unsigned find_battery_quirk(struct hid_device *hdev)
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
@@ -438,14 +438,14 @@ static int hidinput_query_battery_capacity(struct hid_device *dev)
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
@@ -454,7 +454,8 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 					 enum power_supply_property prop,
 					 union power_supply_propval *val)
 {
-	struct hid_device *dev = power_supply_get_drvdata(psy);
+	struct hid_battery *bat = power_supply_get_drvdata(psy);
+	struct hid_device *dev = bat->dev;
 	int value;
 	int ret = 0;
 
@@ -465,13 +466,13 @@ static int hidinput_get_battery_property(struct power_supply *psy,
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
@@ -482,20 +483,20 @@ static int hidinput_get_battery_property(struct power_supply *psy,
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
@@ -513,8 +514,9 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 				  struct hid_field *field, bool is_percentage)
 {
+	struct hid_battery *bat;
 	struct power_supply_desc *psy_desc;
-	struct power_supply_config psy_cfg = { .drv_data = dev, };
+	struct power_supply_config psy_cfg = { 0 };
 	unsigned quirks;
 	s32 min, max;
 	int error;
@@ -530,16 +532,22 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	if (quirks & HID_BATTERY_QUIRK_IGNORE)
 		return 0;
 
-	psy_desc = devm_kzalloc(&dev->dev, sizeof(*psy_desc), GFP_KERNEL);
-	if (!psy_desc)
+	bat = devm_kzalloc(&dev->dev, sizeof(*bat), GFP_KERNEL);
+	if (!bat)
 		return -ENOMEM;
 
+	psy_desc = devm_kzalloc(&dev->dev, sizeof(*psy_desc), GFP_KERNEL);
+	if (!psy_desc) {
+		error = -ENOMEM;
+		goto err_free_bat;
+	}
+
 	psy_desc->name = devm_kasprintf(&dev->dev, GFP_KERNEL, "hid-%s-battery",
 					strlen(dev->uniq) ?
 						dev->uniq : dev_name(&dev->dev));
 	if (!psy_desc->name) {
 		error = -ENOMEM;
-		goto err_free_mem;
+		goto err_free_desc;
 	}
 
 	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
@@ -559,49 +567,55 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
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
+		bat->avoid_query = true;
 
-	dev->battery = devm_power_supply_register(&dev->dev, psy_desc, &psy_cfg);
-	if (IS_ERR(dev->battery)) {
-		error = PTR_ERR(dev->battery);
+	psy_cfg.drv_data = bat;
+	bat->ps = devm_power_supply_register(&dev->dev, psy_desc, &psy_cfg);
+	if (IS_ERR(bat->ps)) {
+		error = PTR_ERR(bat->ps);
 		hid_warn(dev, "can't register power supply: %d\n", error);
 		goto err_free_name;
 	}
 
-	power_supply_powers(dev->battery, &dev->dev);
+	power_supply_powers(bat->ps, &dev->dev);
+	dev->battery = bat;
 	return 0;
 
 err_free_name:
 	devm_kfree(&dev->dev, psy_desc->name);
-err_free_mem:
+err_free_desc:
 	devm_kfree(&dev->dev, psy_desc);
+err_free_bat:
+	devm_kfree(&dev->dev, bat);
 	dev->battery = NULL;
 	return error;
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
 
@@ -611,32 +625,33 @@ static bool hidinput_update_battery_charge_status(struct hid_device *dev,
 static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
 				    int value)
 {
+	struct hid_battery *bat = dev->battery;
 	int capacity;
 
-	if (!dev->battery)
+	if (!bat)
 		return;
 
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
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 7d4a25c6de0e..b3c20af0c010 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -812,19 +812,21 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
 #ifdef CONFIG_HID_BATTERY_STRENGTH
 	struct hid_report_enum *report_enum;
 	struct hid_report *report;
+	struct hid_battery *bat;
 
-	if (!hdev->battery ||
+	bat = hid_get_battery(hdev);
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
index a4ddb94e3ee5..d14b867299c8 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -634,6 +634,34 @@ enum hid_battery_status {
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
+};
+
 struct hid_driver;
 struct hid_ll_driver;
 
@@ -670,19 +698,9 @@ struct hid_device {
 #ifdef CONFIG_HID_BATTERY_STRENGTH
 	/*
 	 * Power supply information for HID devices which report
-	 * battery strength. power_supply was successfully registered if
-	 * battery is non-NULL.
+	 * battery strength. battery is non-NULL if successfully registered.
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
+	struct hid_battery *battery;
 #endif
 
 	unsigned long status;						/* see STAT flags above */
@@ -743,6 +761,13 @@ static inline void hid_set_drvdata(struct hid_device *hdev, void *data)
 	dev_set_drvdata(&hdev->dev, data);
 }
 
+#ifdef CONFIG_HID_BATTERY_STRENGTH
+static inline struct hid_battery *hid_get_battery(struct hid_device *hdev)
+{
+	return hdev->battery;
+}
+#endif
+
 #define HID_GLOBAL_STACK_SIZE 4
 #define HID_COLLECTION_STACK_SIZE 4
 
-- 
2.52.0


