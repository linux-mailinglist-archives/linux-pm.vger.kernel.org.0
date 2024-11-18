Return-Path: <linux-pm+bounces-17688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A909D0961
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 07:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1929281340
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 06:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC351465A5;
	Mon, 18 Nov 2024 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tRsR6ChK"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D577113C661;
	Mon, 18 Nov 2024 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731910567; cv=none; b=JRZQ55Vufy/eGNZo2BTh6h7xTPvQNMOry2K3JHe+hPX42tfdB8Csq6KVvrWn34lPxN7Er0bQzw9BAmmvu3QgYmNZ0F03DSdQ9e1IpS/XvbUTqmc9Qyx5+sSt+lOnH7o2hXob32pMqhERPbe/e/9czrTxwz0WWf7W5Kv4Uef0xrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731910567; c=relaxed/simple;
	bh=8l9BbI5wmQ7Yg0khc+4YV+pJmUQSE6mzpNDquJJs/Iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZyzKzsDI/X7e5jTnk1HTKZ5pAfkb9eEPnjrsUQQZn+Fa2BUHilaVG3bA1glT91EHXikl66Tss8hb4Z861m7wZD9i/Pf56Qpf305c4VRerVOJJ/nFELsjBX7Mwbfm3mgqcdGJ6L2HWVN99eslfLb/AEEx8zTInAWTKvxP8UKlMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tRsR6ChK; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731910561;
	bh=8l9BbI5wmQ7Yg0khc+4YV+pJmUQSE6mzpNDquJJs/Iw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tRsR6ChKaDQ5fmLTPv1Npm5C0+tIX36pWGXcALJxsSrn/HLK0ecLSCDteslIGXEdY
	 Kb8BFOGFa85PXlQMAB90/hR7U6VyZdbIk7o7UO4bLNf146orWPKpUIFiAUvJBaRV4+
	 3S+vcvwwWu9kYzufBf9femZulpoH4K7OzJ/qCLOw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 18 Nov 2024 07:15:58 +0100
Subject: [PATCH v3 1/2] thermal: core: Add stub for
 thermal_zone_device_update()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241118-hwmon-thermal-v3-1-9c17973e7342@weissschuh.net>
References: <20241118-hwmon-thermal-v3-0-9c17973e7342@weissschuh.net>
In-Reply-To: <20241118-hwmon-thermal-v3-0-9c17973e7342@weissschuh.net>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731910561; l=1036;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8l9BbI5wmQ7Yg0khc+4YV+pJmUQSE6mzpNDquJJs/Iw=;
 b=8sUbc9kO+kGIUbDCUM8i2ThbUYCshpKkJ6FQovZGVJXeM66tYi+q7DHbSLr7UDLhLcqW1BpiM
 y0s5vJq3nRTDcEl+KJcb/9GBjoM6z+1WR5wtCgaXOykk6XS+qPmz7yg
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

To simplify the !CONFIG_THERMAL case in the hwmon core,
add a !CONFIG_THERMAL stub for thermal_zone_device_update().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 include/linux/thermal.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 25ea8fe2313e6d0a53192974a80d92f50f0ff03e..455e0814b9165dbb96d698e670f160136a017cc4 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -289,6 +289,10 @@ static inline struct thermal_zone_device *thermal_tripless_zone_device_register(
 static inline void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 { }
 
+static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
+					      enum thermal_notify_event event)
+{ }
+
 static inline struct thermal_cooling_device *
 thermal_cooling_device_register(const char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)

-- 
2.47.0


