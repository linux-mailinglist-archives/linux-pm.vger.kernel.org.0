Return-Path: <linux-pm+bounces-37782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A395EC4D4E3
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 12:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FA918C4F37
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 11:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D313355040;
	Tue, 11 Nov 2025 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXZMdTij";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dd/EiRUJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A89F34FF77
	for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858650; cv=none; b=tdooAZ1ZTgkzrfv7ANdQDXf9cLr/9dK8NYv3tJMS/Px+oeomDupMELK6hSWNJj/LjKfEx4pTANjCuZ8Xd5c2nv/YZw4IJRYFFtLTK1lJw0r8RBui1MYPLiEz2akiUjnCi7zDVSkV/YhQDMdTCR6nhFW0K3XmWZSI2QKDJU7dJxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858650; c=relaxed/simple;
	bh=GAhLUK7NokaOBdHhjdiuOOBNENQn4uOex32x8jh3pcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPU4aR9wsRSQoAsj9i6B3BfAiUnmTYPBqyvLgEzxt6dMADQ3uZqhDrG19AUnZnkeM2wRHqyxylQ4UGfbNDUn7eWKSRcPA0hz+uar8WfpaXMCbTZSt4un3UuEhoSz4oWWN5zW0pGobxFTqd59CEn1vnUgZoGk8PcUmR4+xtt7N0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXZMdTij; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dd/EiRUJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762858647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OA3MLt0HtCa+3bbTy+qorTBrGQRJe5gwgZCEi7pnzlA=;
	b=QXZMdTijDMbyCAfXhEpldnSS5lHi4d5Hp/r30hvCeTtpZQJyipFi6yn4dom81cILXjac+E
	QS9Il00ZTJ4F99Uys38oiZz+XNkcWD6ndC/Tg7o+VtkTxLEi6OAl3O4FgvNtkcLaM7+n6P
	gXt0R3o9bpUneUcKLsmykcog22ydho8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-Lc1c2C8ROUmqr4-RQGFRaQ-1; Tue, 11 Nov 2025 05:57:25 -0500
X-MC-Unique: Lc1c2C8ROUmqr4-RQGFRaQ-1
X-Mimecast-MFC-AGG-ID: Lc1c2C8ROUmqr4-RQGFRaQ_1762858644
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775f51ce36so37362915e9.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 02:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762858644; x=1763463444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OA3MLt0HtCa+3bbTy+qorTBrGQRJe5gwgZCEi7pnzlA=;
        b=dd/EiRUJpt8I/4Bm2uTWvtkCVuV/9ik3Y7B1+ttXoYSkgos25CiJjSKOIwViYc4VzO
         6CzIxuxd5DM5CZtfyMGc/hSXmX+pIwDazLPF4CUDoJ0LwXocWVeUts1v1S6XvzKe4Wpx
         oUMh7bH9lQHGa3Uy0I+KUuydGyqIzBl8h0XXBOvAno0FMKHB70CJ6FelZYZewOXG1wGY
         iJAFoJK2vXEl789+WpfYkmxbYJd6ayJImuFnuFdUpBZuDSOJGZGhK3XrYZJKx0bvr3gA
         VIBmJ7Ixk4Rd+DNrw3ugaWbThq9hNdP8IrXBGw/dB59RcUtdIbouZR2A40bo3tvfXIob
         CD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762858644; x=1763463444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OA3MLt0HtCa+3bbTy+qorTBrGQRJe5gwgZCEi7pnzlA=;
        b=RTWBAqP2rSt7emY/hv/Xe/WBYG4jd+Y0r2Rs7X/PxyEkxAjPXc7WGfxba4oaL2qd5y
         6xM3pa3dquN6dyYtZgEiT8o80XAsQJANnAUC9ll8PJQ5qe7kTKvhE/gumUe6WczbwKnU
         LTY2HH8C2rbm6ZLODC9Rj4p2qBSN6aAsd9IUwZW+oorUv3TYdpfdh93UHxLB75rym5l8
         gaEi8Yu7klM39GYwrkJcbkZfhK7w6RRJksCFPnnf3XY2UeSFrOGikktFKIXlBX4lNlxJ
         DcGpg68a/5xIFPK2lTZSWZkoeQo+NNeQZ+39SG2iLk876eNZwqM6/CmwOZtTvxkOnUWx
         8ZUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAvrDgE7syndN4f2yaMnBEhz2eZ69vX6/FmKQTF0RZhzRDgo70KFODhIlfLxgGY1qfqRYn7St8ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YycDNNxIPN0kL3buSn1ahEVQHBfnLK3tyHxh8CnWeckTGcdH9Ue
	mmWM2saGvLQJGFymZOd1Dk7LokGEknQgIWNXM/xizeCVD7F08kkzm9nOn9PTmyfDl31ytLg2r4N
	ddbRQ47SUAMXCxxzixYBqR5h+yHNDSt7xdRlBz2jV0aXNME0/o9w2uKVpd0jV
X-Gm-Gg: ASbGncvhGwEwvIERThTCnVdZRgzoMUKIByq+Sr0ryTHXMUCALMyMxVe9JYMjcE7+io4
	mzwxXuGXvyvP+M8jimDLfB55wqLZAAsfU/bF6F1PiZNWt1fOuqS+VVdKAnciTxEzOXFiTiCj5Xk
	C1itNCzaOyyzMrn0wg0RhsYtcUTewBQ4Bj+nLNciDpTwJ2b/h1AxIxCbaKV8OwM42gQfn4hmnDs
	8FtRmoODFA5qvr+fT4cNjSPs32tCrX9H3k5WbLNE16poGndXh5glXg0xCTsMu/vKb58y9CuNcly
	Uhdipb6PD/lE369Dhsh+RSKfKk7ZiSd1jWyBHxOvq1lcWpbjcczg2Jg3STooCOeSB4QIUUFHqZq
	8o23Un0AMNugdpw==
X-Received: by 2002:a05:600c:3b0a:b0:46e:46c7:b79a with SMTP id 5b1f17b1804b1-4777322870bmr105691035e9.2.1762858644200;
        Tue, 11 Nov 2025 02:57:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ90auCasoE9P8jn9uzsh4DtTgqPrjXay3Mk3u1ymZy23RmngSV+vew6hQGAhqIpqU5mnSgA==
X-Received: by 2002:a05:600c:3b0a:b0:46e:46c7:b79a with SMTP id 5b1f17b1804b1-4777322870bmr105690745e9.2.1762858643746;
        Tue, 11 Nov 2025 02:57:23 -0800 (PST)
Received: from sissix.lzampier.com ([2a06:5900:814a:ab00:3725:2991:6cf3:b3aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679607esm27069549f8f.43.2025.11.11.02.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:57:23 -0800 (PST)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-input@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH 1/1] HID: input: Add support for multiple batteries per device
Date: Tue, 11 Nov 2025 10:56:31 +0000
Message-ID: <20251111105634.1684751-2-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111105634.1684751-1-lzampier@redhat.com>
References: <20251111105634.1684751-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for multiple batteries per HID device by introducing
struct hid_battery to encapsulate individual battery state and using
a list to track multiple batteries identified by report ID. The legacy
dev->battery field is maintained for backwards compatibility.

Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 drivers/hid/hid-core.c  |   4 +
 drivers/hid/hid-input.c | 193 +++++++++++++++++++++++++++-------------
 include/linux/hid.h     |  42 ++++++++-
 3 files changed, 176 insertions(+), 63 deletions(-)

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
index e56e7de53279..071df319775b 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
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
+		if (bat->status != HID_BATTERY_REPORTED &&
+		    !bat->avoid_query) {
 			value = hidinput_query_battery_capacity(dev);
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
+		if (bat->status != HID_BATTERY_REPORTED &&
+		    !bat->avoid_query) {
 			value = hidinput_query_battery_capacity(dev);
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
@@ -513,33 +514,53 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 				  struct hid_field *field, bool is_percentage)
 {
+	struct hid_battery *bat;
 	struct power_supply_desc *psy_desc;
-	struct power_supply_config psy_cfg = { .drv_data = dev, };
+	struct power_supply_config psy_cfg;
 	unsigned quirks;
 	s32 min, max;
 	int error;
+	int battery_num = 0;
 
-	if (dev->battery)
-		return 0;	/* already initialized? */
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
 
-	psy_desc = kzalloc(sizeof(*psy_desc), GFP_KERNEL);
-	if (!psy_desc)
+	bat = kzalloc(sizeof(*bat), GFP_KERNEL);
+	if (!bat)
 		return -ENOMEM;
 
-	psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery",
-				   strlen(dev->uniq) ?
-					dev->uniq : dev_name(&dev->dev));
+	psy_desc = kzalloc(sizeof(*psy_desc), GFP_KERNEL);
+	if (!psy_desc) {
+		error = -ENOMEM;
+		goto err_free_bat;
+	}
+
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
-		goto err_free_mem;
+		goto err_free_desc;
 	}
 
 	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
@@ -559,98 +580,148 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	if (quirks & HID_BATTERY_QUIRK_FEATURE)
 		report_type = HID_FEATURE_REPORT;
 
-	dev->battery_min = min;
-	dev->battery_max = max;
-	dev->battery_report_type = report_type;
-	dev->battery_report_id = field->report->id;
-	dev->battery_charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
+	/* Initialize battery structure */
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
 
-	dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
-	if (IS_ERR(dev->battery)) {
-		error = PTR_ERR(dev->battery);
+	psy_cfg.drv_data = bat;
+	bat->ps = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
+	if (IS_ERR(bat->ps)) {
+		error = PTR_ERR(bat->ps);
 		hid_warn(dev, "can't register power supply: %d\n", error);
 		goto err_free_name;
 	}
 
-	power_supply_powers(dev->battery, &dev->dev);
+	power_supply_powers(bat->ps, &dev->dev);
+
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
+
 	return 0;
 
 err_free_name:
 	kfree(psy_desc->name);
-err_free_mem:
+err_free_desc:
 	kfree(psy_desc);
-	dev->battery = NULL;
+err_free_bat:
+	kfree(bat);
 	return error;
 }
 
 static void hidinput_cleanup_battery(struct hid_device *dev)
 {
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
 
-	psy_desc = dev->battery->desc;
-	power_supply_unregister(dev->battery);
-	kfree(psy_desc->name);
-	kfree(psy_desc);
 	dev->battery = NULL;
 }
 
-static bool hidinput_update_battery_charge_status(struct hid_device *dev,
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
+		if (bat->dev->battery == bat->ps)
+			bat->dev->battery_charge_status = bat->charge_status;
 		return true;
 	}
 
 	return false;
 }
 
-static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
-				    int value)
+static void hidinput_update_battery(struct hid_device *dev, int report_id,
+				    unsigned int usage, int value)
 {
+	struct hid_battery *bat;
 	int capacity;
 
-	if (!dev->battery)
+	bat = hidinput_find_battery(dev, report_id);
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
 
 	capacity = hidinput_scale_battery_capacity(dev, value);
 
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
+
+		if (dev->battery == bat->ps) {
+			dev->battery_capacity = bat->capacity;
+			dev->battery_status = bat->status;
+			dev->battery_ratelimit_time = bat->ratelimit_time;
+		}
+
+		power_supply_changed(bat->ps);
 	}
 }
 #else  /* !CONFIG_HID_BATTERY_STRENGTH */
@@ -664,8 +735,8 @@ static void hidinput_cleanup_battery(struct hid_device *dev)
 {
 }
 
-static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
-				    int value)
+static void hidinput_update_battery(struct hid_device *dev, int report_id,
+				    unsigned int usage, int value)
 {
 }
 #endif	/* CONFIG_HID_BATTERY_STRENGTH */
@@ -1533,7 +1604,7 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		return;
 
 	if (usage->type == EV_PWR) {
-		hidinput_update_battery(hid, usage->hid, value);
+		hidinput_update_battery(hid, report->id, usage->hid, value);
 		return;
 	}
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index a4ddb94e3ee5..a6e36835fb3c 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -634,6 +634,36 @@ enum hid_battery_status {
 	HID_BATTERY_REPORTED,		/* Device sent unsolicited battery strength report */
 };
 
+/**
+ * struct hid_battery - represents a single battery power supply
+ * @list: list node for linking into hid_device's battery list
+ * @dev: pointer to the parent hid_device
+ * @ps: the power supply device
+ * @capacity: current battery capacity
+ * @min: minimum battery value
+ * @max: maximum battery value
+ * @report_type: type of report (HID_INPUT_REPORT, HID_FEATURE_REPORT)
+ * @report_id: report ID for this battery
+ * @charge_status: current charge status
+ * @status: battery status (unknown, queried, reported)
+ * @avoid_query: if true, don't query battery (wait for device reports)
+ * @ratelimit_time: time for rate limiting battery updates
+ */
+struct hid_battery {
+	struct list_head list;
+	struct hid_device *dev;
+	struct power_supply *ps;
+	__s32 capacity;
+	__s32 min;
+	__s32 max;
+	__s32 report_type;
+	__s32 report_id;
+	__s32 charge_status;
+	enum hid_battery_status status;
+	bool avoid_query;
+	ktime_t ratelimit_time;
+};
+
 struct hid_driver;
 struct hid_ll_driver;
 
@@ -670,8 +700,16 @@ struct hid_device {
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


