Return-Path: <linux-pm+bounces-19760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB889FCA99
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 12:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10F21882F5B
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 11:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A116B1D5AA8;
	Thu, 26 Dec 2024 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="IqfloShH"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E231D5173;
	Thu, 26 Dec 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735212481; cv=none; b=qxGuA7e0VVloG6WUUQgLHEY8gqpbVM8RyZL2jnbFIfBpLa6dMkOrOSBI660wt2hrGSN4RV9LtXThD77sQoziUAkq3laElkv2ktPce+HbT2VWUudamtH/02Gsoo5u3p7ixZ3yYOFG1dZH6ezKVmSGDWhSH/upmO1Y1guL6zyyhv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735212481; c=relaxed/simple;
	bh=YZcjuddjVgKAPlLHMmpUlG4maLOUSx9z9HERhUa1ICI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcoYL6VXVSS89vWG3adC4UjtHigxPfgWrKT4YG4Fv4Zy49rPHIfTUz5TO94oUfmG/M/55QAvpgs12hcHZd8jlGfTT8V8CcDSbiqaFFzSMGijN41vRQaETBxrv5bNWFC0Q28i1+/jPMU0xGRsJY6fag9ZGKVQzotT8L75RgL/vQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=IqfloShH; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a02:2149:8b14:7c00:7f68:a54:8871:387f])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 8D2D72E008C8;
	Thu, 26 Dec 2024 13:27:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1735212472;
	bh=bBJXHzoxw0zz+h75ayHF8LKD0Y1CZ2bQuWhAXCVJPtE=; h=From:To:Subject;
	b=IqfloShHa/sMkg/K88o/awRKbTYtBvAtfZCL5xxAww1iZjuP95qFJLGq8IfXoqU2H
	 5rhcrMMiQl/ZiLzIqQ/Z15VyvNUY9CPVJVfUPDSEnwU1pzzZpEDSzDaELdwuCLwa79
	 9U8jsiK2lYYg1cWgf5P4A9n9XzpdnV1ldKYlNqd0=
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
Subject: [PATCH 07/10] hwmon: (oxp-sensors) Move pwm_enable read to its own
 function
Date: Thu, 26 Dec 2024 12:27:37 +0100
Message-ID: <20241226112740.340804-8-lkml@antheas.dev>
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
 <173521247225.11229.2342718855724452207@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Currently, this driver breaks sysfs by using auto as 0 and manual as 1.
However, for pwm_enable, 0 is full speed, 1 is manual, and 2 is auto.
For the correction to be possible, this means that the pwm_enable
endpoint will need access to both pwm enable and value (as for
the 0th value, the fan needs to be set to full power).

Therefore, begin by moving the current pwm_enable read to its own
function, oxp_pwm_enable.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/hwmon/oxp-sensors.c | 50 ++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index 850e8d72be1f..ff21a94bb80b 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -755,6 +755,32 @@ static int oxp_pwm_disable(void)
 	}
 }
 
+static int oxp_pwm_read(long *val)
+{
+	switch (board) {
+	case orange_pi_neo:
+		return read_from_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, 1, val);
+	case aok_zoe_a1:
+	case aya_neo_2:
+	case aya_neo_air:
+	case aya_neo_air_1s:
+	case aya_neo_air_plus_mendo:
+	case aya_neo_air_pro:
+	case aya_neo_flip:
+	case aya_neo_geek:
+	case aya_neo_kun:
+	case oxp_2:
+	case oxp_fly:
+	case oxp_mini_amd:
+	case oxp_mini_amd_a07:
+	case oxp_mini_amd_pro:
+	case oxp_x1:
+		return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 /* Callbacks for hwmon interface */
 static umode_t oxp_ec_hwmon_is_visible(const void *drvdata,
 				       enum hwmon_sensor_types type, u32 attr, int channel)
@@ -852,29 +878,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 			}
 			return 0;
 		case hwmon_pwm_enable:
-			switch (board) {
-			case orange_pi_neo:
-				return read_from_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, 1, val);
-			case aok_zoe_a1:
-			case aya_neo_2:
-			case aya_neo_air:
-			case aya_neo_air_1s:
-			case aya_neo_air_plus_mendo:
-			case aya_neo_air_pro:
-			case aya_neo_flip:
-			case aya_neo_geek:
-			case aya_neo_kun:
-			case oxp_2:
-			case oxp_fly:
-			case oxp_mini_amd:
-			case oxp_mini_amd_a07:
-			case oxp_mini_amd_pro:
-			case oxp_x1:
-				return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
-			default:
-				break;
-			}
-			break;
+			return oxp_pwm_read(val);
 		default:
 			break;
 		}
-- 
2.47.1


