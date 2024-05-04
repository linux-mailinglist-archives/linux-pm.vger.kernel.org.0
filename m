Return-Path: <linux-pm+bounces-7503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC468BBD2B
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 18:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6332FB21462
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 16:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586F858AC3;
	Sat,  4 May 2024 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCK0Rvlz"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA753361
	for <linux-pm@vger.kernel.org>; Sat,  4 May 2024 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714840890; cv=none; b=QThWmsYepGFabD3qYrn3eDdUidw4GZde6F8fLHgdD9B36u5ySPu5je/1X2nYbUDfYbw2PRHBg2CrfnDkOAva26S+E8UWGyvKqqJjbrzPDSfQoUOOYuYvX1SksQRmDY8jMDp3F8CeRch4stSuQnrwgIjQn/i6qKlRlUwF2R0n4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714840890; c=relaxed/simple;
	bh=5rSI6KNjYGDtmtl+QEPb+3Xm6sOYaNSP5UQLYni0s1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHWMAyq4dGDoYVmP3W9wTIi4t/7s5ONsIuw3aJ1Opo1LCDdAw8N2Mo7738QXW61OC1EhFtLnFLmef+Xy3iaiNqGnejhrk5V1Zi7IuHPk4VzivnBr7okBUMiMolIplmXhPq6YfgkFSPNBJMLCFjS/UhDcxIOzHwEOXWDj4G6mLeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCK0Rvlz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714840887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=neQpUmMTVRy/ge3nnnYttmc7IrWyiPpmnFd2224kk0Y=;
	b=YCK0Rvlzy5cXEjWnx9wyZ7WuD1/cMRCUFJp5iBm3HdqZPUYIICCFEbOk6XPimUwiAJ7rgW
	NGssPJX7SHX2UtIZFqsyb5bcm6TpXhZU8OVxBpekcPbUPw/WzFV0gJdPUbHgzZZN9XXydL
	nfpGFBPPGu5lUcnV7L8Q7PWM/zKrehM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-qd2kxRX3PVKYT0_n1Q5h_Q-1; Sat, 04 May 2024 12:41:25 -0400
X-MC-Unique: qd2kxRX3PVKYT0_n1Q5h_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43D9C8032FA;
	Sat,  4 May 2024 16:41:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.41])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CA433EC680;
	Sat,  4 May 2024 16:41:23 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Kate Hsuan <hpa@redhat.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: [PATCH v9 5/7] leds: trigger: Add led_mc_trigger_event() function
Date: Sat,  4 May 2024 18:41:03 +0200
Message-ID: <20240504164105.114017-6-hdegoede@redhat.com>
In-Reply-To: <20240504164105.114017-1-hdegoede@redhat.com>
References: <20240504164105.114017-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Add a new led_mc_trigger_event() function for triggers which want to
change the color of a multi-color LED based on their trigger conditions.

Reviewed-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/leds/led-triggers.c | 20 ++++++++++++++++++++
 include/linux/leds.h        |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index f0f5c925b23f..6d535a7fd075 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -394,6 +394,26 @@ void led_trigger_event(struct led_trigger *trig,
 }
 EXPORT_SYMBOL_GPL(led_trigger_event);
 
+void led_mc_trigger_event(struct led_trigger *trig,
+			  unsigned int *intensity_value, unsigned int num_colors,
+			  enum led_brightness brightness)
+{
+	struct led_classdev *led_cdev;
+
+	if (!trig)
+		return;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(led_cdev, &trig->led_cdevs, trig_list) {
+		if (!(led_cdev->flags & LED_MULTI_COLOR))
+			continue;
+
+		led_mc_set_brightness(led_cdev, intensity_value, num_colors, brightness);
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(led_mc_trigger_event);
+
 static void led_trigger_blink_setup(struct led_trigger *trig,
 			     unsigned long delay_on,
 			     unsigned long delay_off,
diff --git a/include/linux/leds.h b/include/linux/leds.h
index e80a185e255a..acd0aafd603c 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -507,6 +507,9 @@ void led_trigger_register_simple(const char *name,
 				struct led_trigger **trigger);
 void led_trigger_unregister_simple(struct led_trigger *trigger);
 void led_trigger_event(struct led_trigger *trigger,  enum led_brightness event);
+void led_mc_trigger_event(struct led_trigger *trig,
+			  unsigned int *intensity_value, unsigned int num_colors,
+			  enum led_brightness brightness);
 void led_trigger_blink(struct led_trigger *trigger, unsigned long delay_on,
 		       unsigned long delay_off);
 void led_trigger_blink_oneshot(struct led_trigger *trigger,
@@ -543,6 +546,9 @@ static inline void led_trigger_register_simple(const char *name,
 static inline void led_trigger_unregister_simple(struct led_trigger *trigger) {}
 static inline void led_trigger_event(struct led_trigger *trigger,
 				enum led_brightness event) {}
+static inline void led_mc_trigger_event(struct led_trigger *trig,
+				unsigned int *intensity_value, unsigned int num_colors,
+				enum led_brightness brightness) {}
 static inline void led_trigger_blink(struct led_trigger *trigger,
 				      unsigned long delay_on,
 				      unsigned long delay_off) {}
-- 
2.44.0


