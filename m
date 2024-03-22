Return-Path: <linux-pm+bounces-5209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F357188658F
	for <lists+linux-pm@lfdr.de>; Fri, 22 Mar 2024 04:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E251F23078
	for <lists+linux-pm@lfdr.de>; Fri, 22 Mar 2024 03:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFADB667;
	Fri, 22 Mar 2024 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDDDu1L0"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB3910A24
	for <linux-pm@vger.kernel.org>; Fri, 22 Mar 2024 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711078736; cv=none; b=fPH7IsaFQ3QtHAaNJ5sc3NR0KYVZ+Vf4CdHzK7Sourn0n1goyQERSN/G39KPymXdYfZ3tB027OkPR3u6GJJmKpeZgsqFd6wu8jqgEcRacQ92da//J9La1dQ/c4DHo7I+2c+vBm/y/jAz3UGx6qyKCA1nqgHLppxs3LZR8Cbe9IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711078736; c=relaxed/simple;
	bh=f5/bJ67Sv0EFeJIOjhY7goPpZbgR8OLgYaO4aKMajrg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnbOjEtCiN6HSWagUx3VvriXjI+9w/HFvlMByhAsmOhTb+em8aYGll5EnQpkcyv5CSydZzRZxrv/hsUePuqrPJfCdhO9IjN1X4YhtMmIDPJ7vt9HESiuk2oLOuG2xi6zvlj0AF3FiU5oY1JCMgdkKCBGU7Fbv25Gkxf7rI3Ghbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jDDDu1L0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711078733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aaThFgoqCnVkRdxTondZNkroyy7Kv7fQbcUMkGLhXZA=;
	b=jDDDu1L0S6n+XNvnLfXHdaYBTuJ8hw0l4AZKomCZ+rN+KcvsdSo7SY4yqFQ2pPpOV5gWcd
	ID7liIqZ+evVgAz4f/yHAZo4wOMV10/PdBzLPujtWc6nD4xXQ4NcCSLTYuhvCeFfPx3TAw
	QoM697xHuY4aatt/fTslZE/9NOe7ffo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-1cFmZtnjPRiM48klTFqeBw-1; Thu,
 21 Mar 2024 23:38:49 -0400
X-MC-Unique: 1cFmZtnjPRiM48klTFqeBw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C8A03C0275F;
	Fri, 22 Mar 2024 03:38:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7CBBC2022C23;
	Fri, 22 Mar 2024 03:38:44 +0000 (UTC)
From: Kate Hsuan <hpa@redhat.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 4/6] leds: trigger: Add led_mc_trigger_event() function
Date: Fri, 22 Mar 2024 11:37:34 +0800
Message-ID: <20240322033736.9344-5-hpa@redhat.com>
In-Reply-To: <20240322033736.9344-1-hpa@redhat.com>
References: <20240322033736.9344-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

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


