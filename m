Return-Path: <linux-pm+bounces-25665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0EEA92496
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 19:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9CF1B60D57
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 17:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC7A25F968;
	Thu, 17 Apr 2025 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="v1K18Og6"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F47B25F7A1;
	Thu, 17 Apr 2025 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912424; cv=none; b=kQJwhTvekCEUJd6Iww5S/Pw39Bb/5LQUjYpYE2UfNxL4o3njLwsvnviaE/L1YisA+gdOBQ82qip9socgPOVTtOzSQ/kgEhfGuEp/50pPhiXLcobu4bdE/tQTK52kfhurzgOviDfKdoU4dQCrieT/5MrrhaIPRhoG132GoK7E8hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912424; c=relaxed/simple;
	bh=38ShhrSrNGKh7k7/IHHz53bSwsS8kRtrwr1hDJdaPOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvak4GdloQvmnd9MXa2sns606fwBJl9TgE+dN6J/M3xVWBrdYZCu8HaOb1NqqwMBnwGFn+pEdpk3vD8/jme2UuO8RaTMe4HCZ7Q4K4T46f+O+D0pg5V4a+fs9OtM17NmEGUhAPnTgoBHYsogQphn5IDPb1g+9IhEYcgSoEDd3UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=v1K18Og6; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 645C52E08886;
	Thu, 17 Apr 2025 20:53:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1744912420;
	bh=8W/U9wN57KtC9m5oXOAzSL0bGHr6zkPOnN65SFdPg8M=; h=From:To:Subject;
	b=v1K18Og69plvtuR5ZApS/9LKVQ95q5bUIdj6j8EAj8XECw1K2BSuBxm36uvvBjRRg
	 gc9OPCgxy6CijLGVA3NnATGUbjR631jcmjprK69R9vZDYdylALoDiShMkJU/mDAz+8
	 4bfOG6OEC7AUtdzq8yYAwLxDz8R49wLieajf6RYo=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:cbc0:999f:73ad:33bd) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
	Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>,
	linux-kernel@vger.kernel.org,
	sre@kernel.org,
	linux@weissschuh.net,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	mario.limonciello@amd.com,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v9 10/15] platform/x86: oxpec: Move fan speed read to separate
 function
Date: Thu, 17 Apr 2025 19:53:05 +0200
Message-ID: <20250417175310.3552671-11-lkml@antheas.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175310.3552671-1-lkml@antheas.dev>
References: <20250417175310.3552671-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174491242000.25306.3703614940855849095@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

While not necessary for fixing the ABI hwmon issue, fan speed will be
the only remaining value without a function. Therefore, finish the
refactor by moving it to a separate function.

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 53 ++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index e670f7d6682a3..34d03525302bb 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -599,6 +599,34 @@ static umode_t oxp_ec_hwmon_is_visible(const void *drvdata,
 	}
 }
 
+/* Fan speed read function */
+static int oxp_pwm_fan_speed(long *val)
+{
+	switch (board) {
+	case orange_pi_neo:
+		return read_from_ec(ORANGEPI_SENSOR_FAN_REG, 2, val);
+	case oxp_2:
+	case oxp_x1:
+		return read_from_ec(OXP_2_SENSOR_FAN_REG, 2, val);
+	case aok_zoe_a1:
+	case aya_neo_2:
+	case aya_neo_air:
+	case aya_neo_air_1s:
+	case aya_neo_air_plus_mendo:
+	case aya_neo_air_pro:
+	case aya_neo_flip:
+	case aya_neo_geek:
+	case aya_neo_kun:
+	case oxp_fly:
+	case oxp_mini_amd:
+	case oxp_mini_amd_a07:
+	case oxp_mini_amd_pro:
+		return read_from_ec(OXP_SENSOR_FAN_REG, 2, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 /* PWM input read/write functions */
 static int oxp_pwm_input_write(long val)
 {
@@ -694,30 +722,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_fan:
 		switch (attr) {
 		case hwmon_fan_input:
-			switch (board) {
-			case orange_pi_neo:
-				return read_from_ec(ORANGEPI_SENSOR_FAN_REG, 2, val);
-			case oxp_2:
-			case oxp_x1:
-				return read_from_ec(OXP_2_SENSOR_FAN_REG, 2, val);
-			case aok_zoe_a1:
-			case aya_neo_2:
-			case aya_neo_air:
-			case aya_neo_air_1s:
-			case aya_neo_air_plus_mendo:
-			case aya_neo_air_pro:
-			case aya_neo_flip:
-			case aya_neo_geek:
-			case aya_neo_kun:
-			case oxp_fly:
-			case oxp_mini_amd:
-			case oxp_mini_amd_a07:
-			case oxp_mini_amd_pro:
-				return read_from_ec(OXP_SENSOR_FAN_REG, 2, val);
-			default:
-				break;
-			}
-			break;
+			return oxp_pwm_fan_speed(val);
 		default:
 			break;
 		}
-- 
2.49.0


