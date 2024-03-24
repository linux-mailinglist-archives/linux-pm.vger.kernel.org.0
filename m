Return-Path: <linux-pm+bounces-5262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E48B887D58
	for <lists+linux-pm@lfdr.de>; Sun, 24 Mar 2024 16:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FF11C20C38
	for <lists+linux-pm@lfdr.de>; Sun, 24 Mar 2024 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307901B809;
	Sun, 24 Mar 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1LaRGzm"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958C81A28C
	for <linux-pm@vger.kernel.org>; Sun, 24 Mar 2024 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711292556; cv=none; b=tuoaaJI4FFHE1YbUiURenR2MY7Hf0EEdmWtvHJ3MqR36o0WXGc0aSoMcMpx2h5LtJxc+HOigJsXiGNDg9VH/GTYHeF4hRbgMhpBj7vQ1+D5M6pFw3PWpkTgYg8wDg1xO9AjoMWlDtLvpSepyBbq5On6B9TELKFJ2r6viU2DpvV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711292556; c=relaxed/simple;
	bh=f5/bJ67Sv0EFeJIOjhY7goPpZbgR8OLgYaO4aKMajrg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMjVxlPz5o7NBO07GMDoq/nYtQXq3nV1KinwIMM4U4jbo8Nf7SMA3pKCQetf6aqjw0yAAxdMV1HkgJ0rSiuP/L0HoisoZ+TkUxdSDgcfLYzR+doaiD9pmSICpnHcQthtWO54FtUITO2kGEp7d8QvDGNoXMTBxsyYHQJGKRTYUvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1LaRGzm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711292553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aaThFgoqCnVkRdxTondZNkroyy7Kv7fQbcUMkGLhXZA=;
	b=I1LaRGzmbUrdn6z33itmp0U8iH6Gtcj9LjTaFCR+pFHNVXHeMuDWFaagn+DzxFmJO8XoLM
	D1xcr4x9WWoGviwQg64k+eb6KkfEJ360XRPptlPsR9rAx+k4c/+xWGZFZY5vNuwBFDYcBp
	YoIgfqFbtx7vd72KJ4C5KL12ukzN84A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-8dT4ycs1P9-VDhyW7_Runw-1; Sun,
 24 Mar 2024 11:02:29 -0400
X-MC-Unique: 8dT4ycs1P9-VDhyW7_Runw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50FB9380008B;
	Sun, 24 Mar 2024 15:02:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.75])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3EF9C40C6DAE;
	Sun, 24 Mar 2024 15:02:21 +0000 (UTC)
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
Subject: [PATCH v5 RESEND 4/6] leds: trigger: Add led_mc_trigger_event() function
Date: Sun, 24 Mar 2024 23:01:05 +0800
Message-ID: <20240324150107.976025-5-hpa@redhat.com>
In-Reply-To: <20240324150107.976025-1-hpa@redhat.com>
References: <20240324150107.976025-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

From: Hans de Goede <hdegoede@redhat.com>

Add a new led_mc_trigger_event() function for triggers which want to
change the color of a multi-color LED based on their trigger conditions.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
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


