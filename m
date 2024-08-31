Return-Path: <linux-pm+bounces-13288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA46096721F
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 16:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E99A1F22880
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 14:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA03814D449;
	Sat, 31 Aug 2024 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5esY2H6"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0E21DFD1
	for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725114084; cv=none; b=C+6MqXETJq1RUEBafE8rx0J6S2J/oYU3+kUA5fDNQmpS3rwJHdcu/T1tamou4EZwr24BqVtLxyWbVT7vYvyTjlXKk1T/LVjyje2DvZqHdlZOvvCd1mPDTsinjldGE5owASFFogJRSSffDKqXXQiJZHicK8Mxn9OesZ1F3PIKP6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725114084; c=relaxed/simple;
	bh=kvlpVhOfdVYqzYjygZ62VId+u5GFqaC2KnLUoFZwwg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZvaKzQIIhthTVMbDbyFyo+Rdk5YNDk12bmzszLoyHwGSRxbVeBcFv3As90wecxqxTXkLT2ji5Mm+gIcSncG7/C7aQZdq7R94ccEwJNtOIXXXnPbSMtbxl1uZo8eCE1oJHQaEngRXmP427VD7Axfe24VT9KknpBmlNBgnChH4XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5esY2H6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725114082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0QIaDwiuzjwwdhdGYGN9s12CC0QR4D1zMEIQpGYdueU=;
	b=L5esY2H665rBKs/SqfpmGA9Hb3jgQh2ZK8l12DuUtepArS0f235nSCc50C6oY0m8kmXHrC
	2lSEr7lhV/Fh8dLD0lL9UgnWjiu9Hkgb6ZJ2AHDvzzVrRWrcPL0flKhtPhP+SYxkLTp6IX
	SbPk2FWIbS8C1GIWA++czt0DErHbH90=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-fgYXGaqhNH24_hgJ54PJEg-1; Sat,
 31 Aug 2024 10:21:16 -0400
X-MC-Unique: fgYXGaqhNH24_hgJ54PJEg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6A611955F40;
	Sat, 31 Aug 2024 14:21:13 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF4913001FEF;
	Sat, 31 Aug 2024 14:21:09 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Enric Balletbo Serra <enric.balletbo@collabora.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: [PATCH 5/6] power: supply: sysfs: Move power_supply_show_enum_with_available() up
Date: Sat, 31 Aug 2024 16:20:38 +0200
Message-ID: <20240831142039.28830-6-hdegoede@redhat.com>
In-Reply-To: <20240831142039.28830-1-hdegoede@redhat.com>
References: <20240831142039.28830-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Move power_supply_show_enum_with_available() higher up in
the power_supply_sysfs.c file.

This is a preparation patch to avoid needing a forward declaration
when replacing power_supply_show_usb_type() with it later on.

This commit only moves the function, there are no changes to it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/power_supply_sysfs.c | 62 +++++++++++------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 9f21b0b54caf..c98a6de59d3b 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -237,6 +237,37 @@ static enum power_supply_property dev_attr_psp(struct device_attribute *attr)
 	return  to_ps_attr(attr) - power_supply_attrs;
 }
 
+static ssize_t power_supply_show_enum_with_available(
+			struct device *dev, const char * const labels[], int label_count,
+			unsigned int available_values, int value, char *buf)
+{
+	bool match = false, available, active;
+	ssize_t count = 0;
+	int i;
+
+	for (i = 0; i < label_count; i++) {
+		available = available_values & BIT(i);
+		active = i == value;
+
+		if (available && active) {
+			count += sysfs_emit_at(buf, count, "[%s] ", labels[i]);
+			match = true;
+		} else if (available) {
+			count += sysfs_emit_at(buf, count, "%s ", labels[i]);
+		}
+	}
+
+	if (!match) {
+		dev_warn(dev, "driver reporting unavailable enum value %d\n", value);
+		return -EINVAL;
+	}
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+
 static ssize_t power_supply_show_usb_type(struct device *dev,
 					  const struct power_supply_desc *desc,
 					  union power_supply_propval *value,
@@ -518,37 +549,6 @@ int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return ret;
 }
 
-static ssize_t power_supply_show_enum_with_available(
-			struct device *dev, const char * const labels[], int label_count,
-			unsigned int available_values, int value, char *buf)
-{
-	bool match = false, available, active;
-	ssize_t count = 0;
-	int i;
-
-	for (i = 0; i < label_count; i++) {
-		available = available_values & BIT(i);
-		active = i == value;
-
-		if (available && active) {
-			count += sysfs_emit_at(buf, count, "[%s] ", labels[i]);
-			match = true;
-		} else if (available) {
-			count += sysfs_emit_at(buf, count, "%s ", labels[i]);
-		}
-	}
-
-	if (!match) {
-		dev_warn(dev, "driver reporting unavailable enum value %d\n", value);
-		return -EINVAL;
-	}
-
-	if (count)
-		buf[count - 1] = '\n';
-
-	return count;
-}
-
 ssize_t power_supply_charge_behaviour_show(struct device *dev,
 					   unsigned int available_behaviours,
 					   enum power_supply_charge_behaviour current_behaviour,
-- 
2.46.0


