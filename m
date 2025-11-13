Return-Path: <linux-pm+bounces-37894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA8CC54E36
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 01:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7A7D4E1902
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 00:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D085676026;
	Thu, 13 Nov 2025 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyRRBzY5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPrwbDPU"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3784E13AA2D
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 00:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992923; cv=none; b=B4HHgO4v22fR28p7ezb1vDZ9BnZrIM5byyj3RM16imUJb05dQkV1ukShnvYkAweeyjiIesUL0Zg6hUM4cWvRrsPFvd9FGkN/ULGW3hhdEGJjUPE1PWco6x130+N2Jqr4v/x4qguiTAfrXD/e3CAReaWAcDtWIoGOD9Q2BQdITto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992923; c=relaxed/simple;
	bh=rkZwVrkOadyDRR22lYKiSlNshpLUvze0UwNBJO2yDCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcqqrcjcqmAPP/la3a/435Q03qwOqDX1IByzuO4uxnai0wbXYHucs6rqqQDseOvW1fHlFYEdzhbm0ahjMKWspPQWEtRIZDSMFcSeIX/qHJaEGI78InrFRLdAuUCxDffVn2y0vDHwdWhPIGlYx9dJ6iMucfchCYyGoS4//MZZgAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QyRRBzY5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPrwbDPU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762992920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1WcE71YI025D4IauzKZF0rnIgAKdLJAwYCr9A+FMYc=;
	b=QyRRBzY50+ZYtTIR8ZNS+gz3msSc0gwySrRFyXKr8xJPgcxSl13MZqPNHCif2gSSY2oZRx
	U4TyFZtMaQP+db8JK10FKNFEj6+qQkrQ142kd7fMY7WVKldpjeYLMqrnyYyftwHjvpHqaP
	GSvcr5Ze2kZ7VQ6R7fYLo/CPSxQ2SPY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-FHzH5t0kNw-54g_MiZpLKA-1; Wed, 12 Nov 2025 19:15:18 -0500
X-MC-Unique: FHzH5t0kNw-54g_MiZpLKA-1
X-Mimecast-MFC-AGG-ID: FHzH5t0kNw-54g_MiZpLKA_1762992917
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4710d174c31so1898005e9.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 16:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762992917; x=1763597717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1WcE71YI025D4IauzKZF0rnIgAKdLJAwYCr9A+FMYc=;
        b=LPrwbDPURBroc32TcXP5i9B6kur4desTXNf1VtUtz6Sd9ihm5gSopv9C3x9XMW2UBS
         BEgY2k8Gg5xWkAmPfE2mAr6/2XYTZXyT/ZNL2+A8pJaeI4egiqXz6H+yijDycLJ+8jFF
         BFzCjQhLYAgwPqn8WCgD4irKWAmC0Tz3tkqQv6sh58d0pS+EKbsN+PyAu89SdIydq9Gh
         DRyxC12xE5ojceOnuZ96VBldcryNSDPS0Rz3fBlKl1n3OoVV9NUvdECpUsCWoDTiDqhg
         liBjj15CEpt6PO39M4Vq1YnEKqzr35C3VNmwMZa7YXys5BQKSCbVDooUq/tY6Cfwu2Mo
         tOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762992917; x=1763597717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K1WcE71YI025D4IauzKZF0rnIgAKdLJAwYCr9A+FMYc=;
        b=jjHJAbIZTHW0/bilORERI2a3wqeosdpYqrB7/b4JMPcIFlrYo/WSn2HRfMV/HRwCH7
         OTo6eT53/VKz0SxoeeSS4d+M1PIsAQLVlD4fN3foXsNMKgH2sTxgTKSKeFMmRpd4eufA
         E98KAfnoy8rGzawF4f5mXndM2hjATph06Cnnz1tXdXxPbD1gQw1nin8Rnf1sgIQ26y9c
         tfBKzxC2SScmzYWW+k47lUtsQyvV/TgsqxAedVly8adbs5F9WMfovuw20ErwoDR9YxMQ
         n9GjchDSYYSMtk4nU35P1zzi/7nk+c2OS2LM2Ayj/NnI2nwGJgbUIvcDEOvh/cOrufGa
         oLpA==
X-Forwarded-Encrypted: i=1; AJvYcCUH+IlVWtGU8y77/3VsGdAo37lWx76/a1DuwcDpntsc2VWhHMup+bostC4M7h8cbFNFcwc604ra+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc5oD69j8Q6Acd8Fw8wiWR+wvtsN355n3ooal+8gilhwalVpup
	Tlu3K+lNZ7z6Avv6eBLmzFzO6bv5oDXSSnbGpMil9lAVne7d6hfVs2jC0IIH+LvahGKO6qtqzRi
	zT1O1HLkI8HuQsJQCCDhv2m+a8NjAn72G0cyK2HPPiFUE+726Gbu/xccGKWew
X-Gm-Gg: ASbGncsNF2onA3FZP+RBtvQApueecU2YVuzEan53n2aPhkurbOIopgewq6vBPYK7say
	GBdbmH0/K8gXDkV4kKiklnFrG789gzrX2T6gD+5d4xBxa1IXevY3nk1wf/CrWWH4YAS/ONAdcUH
	W37l7/m7ak30alNszVAwokWsSwnL0BZaYNfgNb4rd1jDnN5fsHvgbgY0YBGnvUZdBxjiSf1oCNl
	577UmI4TW1W/1IsFT2EFiz9aidMXHzwPUysmV84TVezSXFlZUUznxPPNIgHPWi82wLwtw7FzT3w
	CEncrECm5Z1mkm1YLQMwFBCstJ4PO6BgY/roszXd99+LmFPvBDNjTV2GQeCZexdFqQ3i5PH+O7s
	sJ+b6h2Fm2YmSkA==
X-Received: by 2002:a05:600c:3145:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-477870718cdmr46780905e9.2.1762992917433;
        Wed, 12 Nov 2025 16:15:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPbmxVbliqZZE2ij3N4XrtnplcTCMheZR9g48joM0Qg+CQVasHu64phvjG2+WlyX9GjLZJWA==
X-Received: by 2002:a05:600c:3145:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-477870718cdmr46780715e9.2.1762992917037;
        Wed, 12 Nov 2025 16:15:17 -0800 (PST)
Received: from sissix.lzampier.com ([2a06:5900:814a:ab00:3725:2991:6cf3:b3aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b589sm432983f8f.23.2025.11.12.16.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 16:15:16 -0800 (PST)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-input@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH v2 3/3] HID: input: Add support for multiple batteries per device
Date: Thu, 13 Nov 2025 00:15:05 +0000
Message-ID: <20251113001508.713574-4-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113001508.713574-1-lzampier@redhat.com>
References: <20251113001508.713574-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable HID devices to register and manage multiple batteries by
maintaining a list of hid_battery structures, each identified by
its report ID.

The legacy dev->battery field and related fields are maintained for
backward compatibility, pointing to the first battery in the list.
This allows existing code to continue working unchanged while
enabling new functionality for multi-battery devices.

Example hardware that can benefit from this:
- Gaming headsets with charging docks (e.g., SteelSeries Arctis Nova Pro
  Wireless)
- Graphics tablets with stylus batteries (Wacom)
- Wireless earbuds with per-earbud batteries plus charging case
- Split keyboards with independent battery per side

Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 drivers/hid/hid-core.c  |  4 ++
 drivers/hid/hid-input.c | 99 +++++++++++++++++++++++++++--------------
 include/linux/hid.h     | 12 ++++-
 3 files changed, 80 insertions(+), 35 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a5b3a8ca2fcb..76d628547e9a 100644
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
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 0e71efea9da3..9d0be3d4ce04 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -520,14 +520,20 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	unsigned quirks;
 	s32 min, max;
 	int error;
+	int battery_num = 0;

-	if (dev->battery)
-		return 0;	/* already initialized? */
+	/* Check if battery with this report_id already exists */
+	list_for_each_entry(bat, &dev->batteries, list) {
+		if (bat->report_id == field->report->id)
+			return 0;	/* already initialized */
+		battery_num++;
+	}

 	quirks = find_battery_quirk(dev);

-	hid_dbg(dev, "device %x:%x:%x %d quirks %d\n",
-		dev->bus, dev->vendor, dev->product, dev->version, quirks);
+	hid_dbg(dev, "device %x:%x:%x %d quirks %d report_id %d\n",
+		dev->bus, dev->vendor, dev->product, dev->version, quirks,
+		field->report->id);

 	if (quirks & HID_BATTERY_QUIRK_IGNORE)
 		return 0;
@@ -542,9 +548,17 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 		goto err_free_bat;
 	}

-	psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery",
-				   strlen(dev->uniq) ?
-					dev->uniq : dev_name(&dev->dev));
+	/* Create unique name for each battery based on report ID */
+	if (battery_num == 0) {
+		psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery",
+					   strlen(dev->uniq) ?
+						dev->uniq : dev_name(&dev->dev));
+	} else {
+		psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery-%d",
+					   strlen(dev->uniq) ?
+						dev->uniq : dev_name(&dev->dev),
+					   battery_num);
+	}
 	if (!psy_desc->name) {
 		error = -ENOMEM;
 		goto err_free_desc;
@@ -597,15 +611,23 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,

 	power_supply_powers(bat->ps, &dev->dev);

-	/* Maintain legacy single battery fields for backward compatibility */
-	dev->battery = bat->ps;
-	dev->battery_min = bat->min;
-	dev->battery_max = bat->max;
-	dev->battery_report_type = bat->report_type;
-	dev->battery_report_id = bat->report_id;
-	dev->battery_charge_status = bat->charge_status;
-	dev->battery_status = bat->status;
-	dev->battery_avoid_query = bat->avoid_query;
+	list_add_tail(&bat->list, &dev->batteries);
+
+	/*
+	 * The legacy single battery API is preserved by exposing the first
+	 * discovered battery. Systems relying on a single battery view maintain
+	 * unchanged behavior.
+	 */
+	if (battery_num == 0) {
+		dev->battery = bat->ps;
+		dev->battery_min = bat->min;
+		dev->battery_max = bat->max;
+		dev->battery_report_type = bat->report_type;
+		dev->battery_report_id = bat->report_id;
+		dev->battery_charge_status = bat->charge_status;
+		dev->battery_status = bat->status;
+		dev->battery_avoid_query = bat->avoid_query;
+	}

 	return 0;

@@ -620,21 +642,33 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,

 static void hidinput_cleanup_battery(struct hid_device *dev)
 {
-	struct hid_battery *bat;
+	struct hid_battery *bat, *next;
 	const struct power_supply_desc *psy_desc;

-	if (!dev->battery)
-		return;
+	list_for_each_entry_safe(bat, next, &dev->batteries, list) {
+		psy_desc = bat->ps->desc;
+		power_supply_unregister(bat->ps);
+		kfree(psy_desc->name);
+		kfree(psy_desc);
+		list_del(&bat->list);
+		kfree(bat);
+	}

-	bat = power_supply_get_drvdata(dev->battery);
-	psy_desc = dev->battery->desc;
-	power_supply_unregister(dev->battery);
-	kfree(psy_desc->name);
-	kfree(psy_desc);
-	kfree(bat);
 	dev->battery = NULL;
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
 static bool hidinput_update_battery_charge_status(struct hid_battery *bat,
 						  unsigned int usage, int value)
 {
@@ -652,17 +686,16 @@ static bool hidinput_update_battery_charge_status(struct hid_battery *bat,
 	return false;
 }

-static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
-				    int value)
+static void hidinput_update_battery(struct hid_device *dev, int report_id,
+				    unsigned int usage, int value)
 {
 	struct hid_battery *bat;
 	int capacity;

-	if (!dev->battery)
+	bat = hidinput_find_battery(dev, report_id);
+	if (!bat)
 		return;

-	bat = power_supply_get_drvdata(dev->battery);
-
 	if (hidinput_update_battery_charge_status(bat, usage, value)) {
 		power_supply_changed(bat->ps);
 		return;
@@ -705,8 +738,8 @@ static void hidinput_cleanup_battery(struct hid_device *dev)
 {
 }

-static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
-				    int value)
+static void hidinput_update_battery(struct hid_device *dev, int report_id,
+				    unsigned int usage, int value)
 {
 }
 #endif	/* CONFIG_HID_BATTERY_STRENGTH */
@@ -1574,7 +1607,7 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		return;

 	if (usage->type == EV_PWR) {
-		hidinput_update_battery(hid, usage->hid, value);
+		hidinput_update_battery(hid, report->id, usage->hid, value);
 		return;
 	}

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 63422130de20..a6e36835fb3c 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -700,8 +700,16 @@ struct hid_device {
 #ifdef CONFIG_HID_BATTERY_STRENGTH
 	/*
 	 * Power supply information for HID devices which report
-	 * battery strength. power_supply was successfully registered if
-	 * battery is non-NULL.
+	 * battery strength. Each battery is tracked separately in the
+	 * batteries list.
+	 */
+	struct list_head batteries;		/* List of hid_battery structures */
+
+	/*
+	 * Legacy single battery support - kept for backwards compatibility.
+	 * Points to the first battery in the list if any exists.
+	 * power_supply was successfully registered if battery is non-NULL.
+	 * DEPRECATED: New code should iterate through batteries list instead.
 	 */
 	struct power_supply *battery;
 	__s32 battery_capacity;
--
2.51.1


