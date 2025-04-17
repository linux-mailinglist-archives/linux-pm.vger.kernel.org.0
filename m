Return-Path: <linux-pm+bounces-25666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E96A9249B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 19:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988E4462EFA
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 17:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2329925F99A;
	Thu, 17 Apr 2025 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="FVp/JD+Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAEC25F976;
	Thu, 17 Apr 2025 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912426; cv=none; b=EL4iNBJNIrZOiKcDoPAIh8lJA4us5reIJZVXxI/vxWOmwgbMibAr/DXMr2Q+e3OuxY5aABuXSPk4CR6MtCEnCsAc/9RcoB1wnYf3iIl6NCXfiMr4WOJZi1ug2QvUctzypPtzvJekhE6E7gkV7aHZiItKFM+HWV5YTXT6zcmivmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912426; c=relaxed/simple;
	bh=W1x5pJjA9EdH/lFvdzSyanXB2Y+JhoFnDL8qI9tULMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bl2CrkiGK+0206gipPjTnLIzZDhhLSNrX/lncifch3in+Ud3JOX1GfCE5RUZG7GoBeuvMS+BZKy9A8SqBmgAvXBdqlYoaCNve04OI6sf9c7a61tPKGDTp9AFPNQJ6HRP17CBl0qpdvOjz5ezefEqwNlIwlvImdO12mgTC2wmvLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=FVp/JD+Q; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 85EFC2E08A45;
	Thu, 17 Apr 2025 20:53:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1744912422;
	bh=XhHSSS3yH/u0IeInccMOpfgv+K5OyWpd/7A7EUyh9l8=; h=From:To:Subject;
	b=FVp/JD+QyvEqbGgBtoqQHLTng0zlqYEcvxnVBRhtegrQy1o2bx7jLIiIkV5pEwJKz
	 6C4DlQme93t8eGzR6V6WsLoq2bRFx67la3QVkyFlF8b77EgS3WYVvOF/tMFS5ttsvB
	 GnlOWY4XiYfcHFJhGgnEd0aOk/W4H5aK6odiJ2HA=
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
Subject: [PATCH v9 11/15] platform/x86: oxpec: Adhere to sysfs-class-hwmon and
 enable pwm on 2
Date: Thu, 17 Apr 2025 19:53:06 +0200
Message-ID: <20250417175310.3552671-12-lkml@antheas.dev>
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
 <174491242209.25384.9562712213909073386@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Currently, the driver does not adhere to the sysfs-class-hwmon
specification: 0 is used for auto fan control and 1 is used for manual
control. However, it is expected that 0 sets the fan to full speed,
1 sets the fan to manual, and then 2 is used for automatic control.

Therefore, change the sysfs API to reflect this and enable pwm on 2.

As we are breaking the ABI for this driver, rename oxpec to oxp_ec,
reflecting the naming convention used by other drivers, to allow for
a smooth migration in current userspace programs.

Closes: https://lore.kernel.org/linux-hwmon/20241027174836.8588-1-derekjohn.clark@gmail.com/
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 37 ++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index 34d03525302bb..52da8eae1f6ab 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -732,7 +732,27 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 		case hwmon_pwm_input:
 			return oxp_pwm_input_read(val);
 		case hwmon_pwm_enable:
-			return oxp_pwm_read(val);
+			ret = oxp_pwm_read(val);
+			if (ret)
+				return ret;
+
+			/* Check for auto and return 2 */
+			if (!*val) {
+				*val = 2;
+				return 0;
+			}
+
+			/* Return 0 if at full fan speed, 1 otherwise */
+			ret = oxp_pwm_fan_speed(val);
+			if (ret)
+				return ret;
+
+			if (*val == 255)
+				*val = 0;
+			else
+				*val = 1;
+
+			return 0;
 		default:
 			break;
 		}
@@ -746,15 +766,24 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
 			      u32 attr, int channel, long val)
 {
+	int ret;
+
 	switch (type) {
 	case hwmon_pwm:
 		switch (attr) {
 		case hwmon_pwm_enable:
 			if (val == 1)
 				return oxp_pwm_enable();
-			else if (val == 0)
+			else if (val == 2)
 				return oxp_pwm_disable();
-			return -EINVAL;
+			else if (val != 0)
+				return -EINVAL;
+
+			/* Enable PWM and set to max speed */
+			ret = oxp_pwm_enable();
+			if (ret)
+				return ret;
+			return oxp_pwm_input_write(255);
 		case hwmon_pwm_input:
 			return oxp_pwm_input_write(val);
 		default:
@@ -819,7 +848,7 @@ static int oxp_platform_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device *hwdev;
 
-	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
+	hwdev = devm_hwmon_device_register_with_info(dev, "oxp_ec", NULL,
 						     &oxp_ec_chip_info, NULL);
 
 	return PTR_ERR_OR_ZERO(hwdev);
-- 
2.49.0


