Return-Path: <linux-pm+bounces-6970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2638B028F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 08:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2BBC1C22587
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 06:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A383158204;
	Wed, 24 Apr 2024 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQIm8xVd"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80BB1581E4
	for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 06:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941631; cv=none; b=hQObQY65O2KUtRmTnuWfqd/LglODqEys5Nc3NCRMFvLY9S05P99RolAMNC7RaYDPkSGV2YDE+tAW3rt6cnNkgJZM/UBTHN6Bzsl7oiLaj4CcbrG6N1zWIQelUADeT1DY+VCrSAHlMjqitLppjEhH0ssXxLbLDuXgBgJUVSF18xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941631; c=relaxed/simple;
	bh=0KjAMqbHUw3uxZJXlReNduNBiZpdhGndBxByERbdMHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkqjPK8k6feUB5NYKL2ZqrtAChQJj+VQxLCBw5h2zdELBTPt/+ITW75Oohum7m6h1yFoom0K6etwmHrUlMKKtUbdny1LSK5bkscjOaGZtmklspDhu7m+Q92V9s+bHns3/w4GqoPoIqIEgTKBQnTOS1Rw3mBmTYePimZ0c7NB4T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cQIm8xVd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713941628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxmSPRqzwsemR1gX6SjRw8z2Adjkeh77GwpibeqFcKI=;
	b=cQIm8xVdAGvSmhhaDni2/GC6jizwAdmvuQiE6vFf9xF/NCQidLC2SvUbkeBGjUzlkPlT8Z
	WFXwfkqGIE3Jlmyxx+rWnvwqsqHVofJgOhzhT9OkHr3zLDpa+ZjTZabIgYduUAoWOpVnb7
	4EN94J+UH4WpOHfkE+PqIx8m6a9m0ns=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-tVwTTAE9PmeI3K7B11oEMg-1; Wed, 24 Apr 2024 02:53:45 -0400
X-MC-Unique: tVwTTAE9PmeI3K7B11oEMg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA44B18065B2;
	Wed, 24 Apr 2024 06:53:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.73])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3E433C01595;
	Wed, 24 Apr 2024 06:53:38 +0000 (UTC)
From: Kate Hsuan <hpa@redhat.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: [PATCH v7 4/6] leds: trigger: Add led_mc_trigger_event() function
Date: Wed, 24 Apr 2024 14:52:10 +0800
Message-ID: <20240424065212.263784-5-hpa@redhat.com>
In-Reply-To: <20240424065212.263784-1-hpa@redhat.com>
References: <20240424065212.263784-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

From: Hans de Goede <hdegoede@redhat.com>

Add a new led_mc_trigger_event() function for triggers which want to
change the color of a multi-color LED based on their trigger conditions.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
---
 drivers/leds/led-triggers.c | 20 ++++++++++++++++++++
 include/linux/leds.h        |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index bd59a14a4a90..fcc4e7a7b12b 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -380,6 +380,26 @@ void led_trigger_event(struct led_trigger *trig,
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
index fed88eb9e170..5378e4cd03ff 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -526,6 +526,9 @@ void led_trigger_register_simple(const char *name,
 				struct led_trigger **trigger);
 void led_trigger_unregister_simple(struct led_trigger *trigger);
 void led_trigger_event(struct led_trigger *trigger,  enum led_brightness event);
+void led_mc_trigger_event(struct led_trigger *trig,
+			  unsigned int *intensity_value, unsigned int num_colors,
+			  enum led_brightness brightness);
 void led_trigger_blink(struct led_trigger *trigger, unsigned long delay_on,
 		       unsigned long delay_off);
 void led_trigger_blink_oneshot(struct led_trigger *trigger,
@@ -562,6 +565,9 @@ static inline void led_trigger_register_simple(const char *name,
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


