Return-Path: <linux-pm+bounces-19763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BEF9FCAA0
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 12:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97D62163163
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 11:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1202D1D5CC9;
	Thu, 26 Dec 2024 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="MEdFQv5q"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2251D5176;
	Thu, 26 Dec 2024 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735212481; cv=none; b=RZ0dwlSGbnYP0acSTbPZAtkDnqYhQq0G97d6JG1F1ghb//7TawLpzQaCMR+5n3HxYZKH3TJAykV7zh8wdODwlzHUgzramvf6lZRIKIkqNPADblVrJZg07y9++2T9raYu0RccXFXXhNStjwDf/7PcqEPOI5+oQXvJG8LpxLlTA1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735212481; c=relaxed/simple;
	bh=OSd5G3egulkOWYS5LKv4tE0XPSfC2kNk9XOn36l3KbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4StOscdEFjRfw3npFryFSO+xjqOG9RX3EpRsAcYMZBuOPTW1nMMqJuPDL9vtnlTirpc9t+BvXoEEUFGdtoiUNfknheq8hLyJ15p72AedYHC+HWxqHaE7Ry9Ad7mD3O1YSKtN+BDeG7LhdLUmySzBKOVZCvn2F+yvJW2T9CtRy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=MEdFQv5q; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a02:2149:8b14:7c00:7f68:a54:8871:387f])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id DDF342E0111A;
	Thu, 26 Dec 2024 13:27:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1735212475;
	bh=dpfI8uIaxipgugPd6BO7woAKGR2nXTlTRTIZe0QvJLI=; h=From:To:Subject;
	b=MEdFQv5qutTPGIUHA6ugeByhs+OYYhIkUKNmsR9TcQeVhxcVCoOQfANZv988ydLqY
	 7S1jk1Hg2XbFrwKwiE1Qv7k/kbinYL9nDl4rqjm8iBu/8IuJR2wQYAl2K6sYNwMttc
	 lkSFaNfCpWgZeze1iXY3mfD5PLmYlNsueo69GBTc=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a02:2149:8b14:7c00:7f68:a54:8871:387f) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-hwmon@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
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
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH 10/10] hwmon: (oxp-sensors) Adhere to sysfs-class-hwmon and
 enable pwm on 2
Date: Thu, 26 Dec 2024 12:27:40 +0100
Message-ID: <20241226112740.340804-11-lkml@antheas.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241226112740.340804-1-lkml@antheas.dev>
References: <20241226112740.340804-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <173521247561.11447.13156273388358948546@linux1587.grserver.gr>
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

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/hwmon/oxp-sensors.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index 97bf51eba741..2ea9029ac287 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -927,7 +927,27 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
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
@@ -941,15 +961,24 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
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
@@ -1014,7 +1043,7 @@ static int oxp_platform_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device *hwdev;
 
-	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
+	hwdev = devm_hwmon_device_register_with_info(dev, "oxp_ec", NULL,
 						     &oxp_ec_chip_info, NULL);
 
 	return PTR_ERR_OR_ZERO(hwdev);
-- 
2.47.1


