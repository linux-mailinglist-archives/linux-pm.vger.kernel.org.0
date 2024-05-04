Return-Path: <linux-pm+bounces-7507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C14948BBD33
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 18:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF8828249F
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 16:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8606A58AC3;
	Sat,  4 May 2024 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VirZen3a"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163515C614
	for <linux-pm@vger.kernel.org>; Sat,  4 May 2024 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714840895; cv=none; b=Dm/c2M25EPDGXbhs/Ac13sXZTEDn2QBhqNf5oKBBQpa+kSzp+VgzzeBQo9uRzDcK5VUAq9p9AsNrtq5FuclMXgrPzNCIH/EHs4vK3xdzP+Zvs5VYQbsVh2P92mZm5xAHYCzmmvJPdH0/5f6/vEplwRdFnOhY5/2YVXhzCi3MOtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714840895; c=relaxed/simple;
	bh=/0fToQ2iJiRqdx6PBUa7OtDSZMO9BIMoXNb+0GT7xks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jASLJZrkLNYdp/GKx9aPIN+NIIU+fgJKW39wWnpZfLfP9fxNirxtsTBVffgNEIvQuAt9y8fkL1ZbDQIUU8IHrUXdrbW1SP0EEYhBiTryWgy0OPj4cslCt3ZIGGiaWGAD3nW3E/gSuok6VKdjJyHOVhu279kzVGC+sDFxhKHJuJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VirZen3a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714840893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPRLXDItnp0uhz0pZwCmAgzkhjsF5FhD82XowiKJz/A=;
	b=VirZen3aTJCMGnmR5auLiiv3N27p96wdbs+hfIKPSdT5fc1ipA9Mu/h2irvTAI760p+53t
	jv3IwqPLRRSacFeH77PuOicbn51LRFzNyj1/qoOZpfU/4FCTm1TNKmxJbDAbSZwqQesmOr
	5mMTeY8si9Vnonpbh53qosxqlvYMYX8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-jHIhJba-PJaCYY2vsDU65Q-1; Sat, 04 May 2024 12:41:29 -0400
X-MC-Unique: jHIhJba-PJaCYY2vsDU65Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7122E101042D;
	Sat,  4 May 2024 16:41:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.41])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1EBA6EC688;
	Sat,  4 May 2024 16:41:27 +0000 (UTC)
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
	linux-pm@vger.kernel.org
Subject: [PATCH v9 7/7] platform: x86-android-tablets: Xiaomi pad2 RGB LED fwnode updates
Date: Sat,  4 May 2024 18:41:05 +0200
Message-ID: <20240504164105.114017-8-hdegoede@redhat.com>
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

From: Kate Hsuan <hpa@redhat.com>

Xiaomi pad2 RGB LED fwnode updates:

1. Set "label" instead "function" to change the LED classdev name from
   "rgb:indicator" to "i2c-ktd2026:rgb:indicator" to match the usual
   triplet name format for LED classdevs.

2. Set the trigger to the new "bq27520-0-charging-orange-full-green"
   powersupply trigger type for multi-color LEDs.

3. Put the fwnode link for red before green in ktd2026_node_group[] so that
   multi_index becomes "red green blue".

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Co-developed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/x86-android-tablets/other.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
index ce487b3c972c..198ea894d071 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -609,8 +609,8 @@ static const struct software_node ktd2026_node = {
 static const struct property_entry ktd2026_rgb_led_props[] = {
 	PROPERTY_ENTRY_U32("reg", 0),
 	PROPERTY_ENTRY_U32("color", LED_COLOR_ID_RGB),
-	PROPERTY_ENTRY_STRING("function", "indicator"),
-	PROPERTY_ENTRY_STRING("linux,default-trigger", "bq27520-0-charging"),
+	PROPERTY_ENTRY_STRING("label", "i2c-ktd2026:rgb:indicator"),
+	PROPERTY_ENTRY_STRING("linux,default-trigger", "bq27520-0-charging-orange-full-green"),
 	{ }
 };
 
@@ -656,9 +656,9 @@ static const struct software_node ktd2026_red_led_node = {
 static const struct software_node *ktd2026_node_group[] = {
 	&ktd2026_node,
 	&ktd2026_rgb_led_node,
+	&ktd2026_red_led_node,
 	&ktd2026_green_led_node,
 	&ktd2026_blue_led_node,
-	&ktd2026_red_led_node,
 	NULL
 };
 
-- 
2.44.0


