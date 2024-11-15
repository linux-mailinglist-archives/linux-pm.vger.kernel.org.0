Return-Path: <linux-pm+bounces-17638-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FDE9CF1E9
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 17:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB7A1F22D04
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 16:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906851D9359;
	Fri, 15 Nov 2024 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="slEGHZr3"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B37C1D63ED;
	Fri, 15 Nov 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688838; cv=none; b=aDKQZouT2wCJHfLgE4Bn3SfAicc7u/66Y38NpZeoKHcbzN3sSTdz4+7JwQUKi6I34XpVbBBKAKVMwztdW4gnoQJYGwC+mBLNXu5z06+UTIDsD4nbIYBtGESY9J5xmxPKeJDj7oSVP832WKtyJj0IPG0R1fvM9Zjqd6TEwKgO2Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688838; c=relaxed/simple;
	bh=ReJ9dLJkmJ51yM3qtvDgNGGTzsQWCETDqLee/2ZGECU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QfviTu993UlkGHM8jX5lJH8JhYZLvYP844NqLE0lXfI8OXzney75WUJ15xue8uCaUNrwBnotj4+zAfUW1yQFIlPVQBZKM+9J7G/QbhUTGCsgcOuF+muX76u5vd9rodvDZilG7jFAt9WwB/TUagi0IN0D4n7llstYn9MoZAnltnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=slEGHZr3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731688833;
	bh=ReJ9dLJkmJ51yM3qtvDgNGGTzsQWCETDqLee/2ZGECU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=slEGHZr3q5L3EQXl9KA6zoJ0gygaovxX3gl9AQ9v7dhqZNuBRGodaiFT0QReAqa81
	 fkdsNyC6mDKjTt7UepodSw1tmiDFqmmmd+ybxPwM6mLYf+UG1woSp5YzcLOwreI+YA
	 o7oFigGABVMwEqAabgXKblItwGs7jTVJ9TgUFPz0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 15 Nov 2024 17:40:21 +0100
Subject: [PATCH v2 1/2] thermal: core: Add stub for
 thermal_zone_device_update()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241115-hwmon-thermal-v2-1-c96f0c0984b2@weissschuh.net>
References: <20241115-hwmon-thermal-v2-0-c96f0c0984b2@weissschuh.net>
In-Reply-To: <20241115-hwmon-thermal-v2-0-c96f0c0984b2@weissschuh.net>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731688832; l=979;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ReJ9dLJkmJ51yM3qtvDgNGGTzsQWCETDqLee/2ZGECU=;
 b=2cRIq3RMhZMNSp+W/2tI2ZAdtQSuWltRIMZ43F5qnGgb3jPt6HKBTKeqgAat97HQ4pU5ne5bv
 xQJN6T4RnQkB4rlhuIogobSfYvQlpFXu0KjV9JpieFyARKvBCsw6DqF
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

To simplify the !CONFIG_THERMAL case in the hwmon core,
add a !CONFIG_THERMAL stub for thermal_zone_device_update().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/thermal.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 25ea8fe2313e6d0a53192974a80d92f50f0ff03e..93880b7bd7d92df5a631f297664b9ba37146fd6a 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -289,6 +289,10 @@ static inline struct thermal_zone_device *thermal_tripless_zone_device_register(
 static inline void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 { }
 
+static inline void thermal_zone_device_update(struct thermal_zone_device *,
+					      enum thermal_notify_event)
+{ }
+
 static inline struct thermal_cooling_device *
 thermal_cooling_device_register(const char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)

-- 
2.47.0


