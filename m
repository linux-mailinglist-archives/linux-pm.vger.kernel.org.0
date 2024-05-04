Return-Path: <linux-pm+bounces-7504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A496C8BBD29
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 18:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BDE1C20D6A
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 16:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E7D5A11D;
	Sat,  4 May 2024 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkKCU88M"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF318535A5
	for <linux-pm@vger.kernel.org>; Sat,  4 May 2024 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714840890; cv=none; b=ey88+W63q8IhAdWbLsaOmMsGDne0+mfOa1lM3c4CJ+sUN6ndwk5x1t0P9NsslI8FWwTzAbPDimqDMRrqGiBU9LJxlweoVGAU8uvtY1twV0EFXJfImJsKti9JUKNGO+aYvhZrjbz7HLo1m7NtR2hwBQXxp1xAjWYah2Z9LuLmP9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714840890; c=relaxed/simple;
	bh=kR3rIKjeK22V3jdldAeKhBfXLNJis6BieB8qH4tygoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jd2DE0/I9QVb6D5HCWSIjFZFxcjFbEcddQ2sQUopPK+c2APo0AQqubuU/mYUzBavOecuxU8YNznQDqeObGD3MA2oq6w0mWQpOUy2mU04rkpzLaUerWNEOBmWljRxePr4ckpUh1N162ppPYypH5sbMtVzpfAc3QlBcD27S+SEu5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QkKCU88M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714840887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyHi4ZtAm4mEigEGa6Bg+/SYTMDTUgikGTMOzAVrwT8=;
	b=QkKCU88MZK5LgbVm9APOi55rBP8ugrvpsFQoIglZeoDe+n/wlAoDT2mWh/UDOTR4B7EFmT
	NpoiSXpHxj0lYeKn6IM3UEUfaX6CdQY8Ig3+U/7+eBT2ybj/y72xhqe0zDp3sB0eJznVOI
	H9MoI4bsDg1pGqw6ug5YHQ47AIm2B3A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183--Px3eHryN02Bm1TR6qVJqA-1; Sat, 04 May 2024 12:41:22 -0400
X-MC-Unique: -Px3eHryN02Bm1TR6qVJqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 033F1802E4D;
	Sat,  4 May 2024 16:41:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.41])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A0F36EC682;
	Sat,  4 May 2024 16:41:19 +0000 (UTC)
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
Subject: [PATCH v9 3/7] leds: rgb: leds-ktd202x: Initialize mutex earlier
Date: Sat,  4 May 2024 18:41:01 +0200
Message-ID: <20240504164105.114017-4-hdegoede@redhat.com>
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
2.44.0


