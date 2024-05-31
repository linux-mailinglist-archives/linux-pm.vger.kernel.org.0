Return-Path: <linux-pm+bounces-8456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E328F8D60DF
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 13:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE831C23CB6
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 11:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5827157A5B;
	Fri, 31 May 2024 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDLJHWF2"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1DA157499
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155700; cv=none; b=SVPFhBdu0otPRj1exEkTCn/gDy4vZBe6ouhReVzX8Ua9th2TCwPrnMSNASfjXuGyChmiZJPWMSkw0O0P+CVHgf7FIrl+aEMYB66io1OJEKxHnP4r663R+ed3/NVSwheTeILZO/s+hK3KdxR1qJTuh0XO6rrSVKzp400Vx7FA8Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155700; c=relaxed/simple;
	bh=Sp2fk/LWKEXy8T7aNKWh8TAuPw3EfqS0eI2YVI2d8m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LosO84GkSigafN+pZCkChrWX7ekD9sF4RV2ZaPVH3VMnfBzZbseixN8Knclx1rSffnNO0huxRqzr8qYWB+jbVpuC1wfZ0Wy9Joo2qzRIOtITNJBFilQq8alsnNKKDa0G+wxGincL39ZilGGVGOGNH+mBG6WS3X6sKkku+/aZ6xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IDLJHWF2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717155698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6v8hUtIyOm2WJgq154hZETop1FlsLE+UFbP2MSs3ok4=;
	b=IDLJHWF2QmnDWemOv/K3YunfgU8JrTulD9vgVQ63MK9j/SPFGVYv/QVxiWlDd4vgzzpH5j
	0wyUnatvM8Xib2MGr4SMx6yBBXZdpFjy6RcnZBDZuuPMMb0yME2dNfECrMxgdojwMZ6yCg
	+Q3aCKGR8PMAeYNT3yNvz/c05c8ZJXg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-Tu1JxxD2Myqd1x3eYoW-Cg-1; Fri,
 31 May 2024 07:41:36 -0400
X-MC-Unique: Tu1JxxD2Myqd1x3eYoW-Cg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53E8529AA385;
	Fri, 31 May 2024 11:41:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 04F47740F;
	Fri, 31 May 2024 11:41:34 +0000 (UTC)
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
Subject: [PATCH v10 3/6] leds: rgb: leds-ktd202x: Initialize mutex earlier
Date: Fri, 31 May 2024 13:41:21 +0200
Message-ID: <20240531114124.45346-4-hdegoede@redhat.com>
In-Reply-To: <20240531114124.45346-1-hdegoede@redhat.com>
References: <20240531114124.45346-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

The mutex must be initialized before the LED class device is registered
otherwise there is a race where it may get used before it is initialized:

 DEBUG_LOCKS_WARN_ON(lock->magic != lock)
 WARNING: CPU: 2 PID: 2045 at kernel/locking/mutex.c:587 __mutex_lock
 ...
 RIP: 0010:__mutex_lock+0x7db/0xc10
 ...
 set_brightness_delayed_set_brightness.part.0+0x17/0x60
 set_brightness_delayed+0xf1/0x100
 process_one_work+0x222/0x5a0

Move the mutex_init() call earlier to avoid this race condition and
switch to devm_mutex_init() to avoid the need to add error-exit
cleanup to probe() if probe() fails later on.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v9:
- Use devm_mutex_init() instead of plain mutex_init()

Changes in v8:
- New patch in v8 of this series
---
 drivers/leds/rgb/leds-ktd202x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
index 60ca6ec34336..d5c442163c46 100644
--- a/drivers/leds/rgb/leds-ktd202x.c
+++ b/drivers/leds/rgb/leds-ktd202x.c
@@ -556,6 +556,10 @@ static int ktd202x_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	ret = devm_mutex_init(dev, &chip->mutex);
+	if (ret)
+		return ret;
+
 	chip->num_leds = (unsigned long)i2c_get_match_data(client);
 
 	chip->regulators[0].supply = "vin";
@@ -584,8 +588,6 @@ static int ktd202x_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	mutex_init(&chip->mutex);
-
 	return 0;
 }
 
@@ -594,8 +596,6 @@ static void ktd202x_remove(struct i2c_client *client)
 	struct ktd202x *chip = i2c_get_clientdata(client);
 
 	ktd202x_chip_disable(chip);
-
-	mutex_destroy(&chip->mutex);
 }
 
 static void ktd202x_shutdown(struct i2c_client *client)
-- 
2.45.1


