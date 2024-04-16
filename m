Return-Path: <linux-pm+bounces-6457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A70978A632A
	for <lists+linux-pm@lfdr.de>; Tue, 16 Apr 2024 07:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C19283C9E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Apr 2024 05:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF38453363;
	Tue, 16 Apr 2024 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZBOy22q"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00CE42070
	for <linux-pm@vger.kernel.org>; Tue, 16 Apr 2024 05:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246025; cv=none; b=oCKJXCnZ5u1beTe+i1vm8pjdM6sxGgCammbCwUAVONNL//I5XdTfjyVsXAKSIgdhDGrX6FIAIcPGeP/6CJeWQ/vNlKGcM8iH6yLfsxTfamJ8DrEB/7WbQ/PkrRJTRK6hAXSTpLcap4J9QISKVe9nhBTMfbcn7o6VKzOsg37JnAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246025; c=relaxed/simple;
	bh=p7Qf/Wv2gRIQXdGwm+8FyGDK8jF8gAk1WduxuCaLuAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/phnSPICKTIGXSUFEC0BfFtG8NzsRwxMGHrqvc+TAGhfxhErtCfv7PKyjf7MZxeNMstDz9vUNY0eseOWWOch7U0jtBrM+fOANfv1YtTpNs5OcRug1LocPkYeSjKGV9NIaqD8BQMmRfHhlHz50sbtFikUas2btVYBt5hSq6ZOxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZBOy22q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713246023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCFCbOFCL4zzLvTeJtHwSPF85SA+R3VeJ49a5BsSC8o=;
	b=GZBOy22q3QXUtN5OKocwSieHYsY9CEQd4kmi9NWOV1cBz78CGt63SoiNFYMUyONKdNCK7I
	DoSqQUEME9Yn6+vEeVmvr6nAOGcZalDHqoxsD+qqyY4pWg6h5FD7ikp1c2ZiP7xBpR1JYD
	WPTG2GOhT5jrQ/GPW/h3IbhFYPGzfSo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-GYCt1oTgPSinxF7vLj3KzQ-1; Tue, 16 Apr 2024 01:40:18 -0400
X-MC-Unique: GYCt1oTgPSinxF7vLj3KzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7F418007BA;
	Tue, 16 Apr 2024 05:40:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2AA0E51EF;
	Tue, 16 Apr 2024 05:40:11 +0000 (UTC)
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
Cc: Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v6 5/5] platform: x86-android-tablets: others: Set the LED trigger to charging_orange_full_green for Xiaomi pad2
Date: Tue, 16 Apr 2024 13:39:09 +0800
Message-ID: <20240416053909.256319-6-hpa@redhat.com>
In-Reply-To: <20240416053909.256319-1-hpa@redhat.com>
References: <20240416053909.256319-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Set the default trigger to bq27520-0-charging-orange-full-green. The LED
will show orange when the battery is charging. The LED will show green
when the battery status is full.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/x86-android-tablets/other.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
index c77d56454f2d..52032a874b7f 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -610,7 +610,7 @@ static const struct property_entry ktd2026_rgb_led_props[] = {
 	PROPERTY_ENTRY_U32("reg", 0),
 	PROPERTY_ENTRY_U32("color", LED_COLOR_ID_RGB),
 	PROPERTY_ENTRY_STRING("function", "indicator"),
-	PROPERTY_ENTRY_STRING("linux,default-trigger", "bq27520-0-charging"),
+	PROPERTY_ENTRY_STRING("linux,default-trigger", "bq27520-0-charging-orange-full-green"),
 	{ }
 };
 
-- 
2.44.0


