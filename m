Return-Path: <linux-pm+bounces-23873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47202A5CB55
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 17:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884F317BF11
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D222620CE;
	Tue, 11 Mar 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="v+6k7CJl"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3FD260A45;
	Tue, 11 Mar 2025 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712070; cv=none; b=H2EjbSTN1C0c28ifL8hO/+hBXL65USWzijATMi914iRPgW35uvSOERTzi/euqPWKxXTiqAjKIvhPpHqwwPxLZOx7pxUCvDp6/itGBs/fri+hAyg9L9bfOK1QD3QqpdIHxpMnB41KO5dTYpN6Q+san4bNWGVy/aAvRJuSQJCeJGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712070; c=relaxed/simple;
	bh=nRT6LA48v69J6tvLRneftqa1ArXK92XsnxLhaEYh6w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOKDS4C6HqY66Z5Exxpopjw6/L7RUPdo1MtI7msikGOC0y6KGojoO6NStZDusP5RWPQFBmA3halMk8m/3bkKCm3IozA7Q1YVQIp8vhNnfL806XARNbjiZlkKMb/Gu6kBpaCYg6w0fdHmiTr1ivC0rjU5AGlaXUr8etoDAEUaZ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=v+6k7CJl; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 4E17D2E09238;
	Tue, 11 Mar 2025 18:54:25 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741712066;
	bh=JVXzCrqbCnINLvVCrt28a4xe/Qg2XgidWiEOkLh/3nk=; h=From:To:Subject;
	b=v+6k7CJlDe8g76qV/J8n8sIdrNjJO6mhtOmwPuGTZvS3uy7gvwAoxtC2NAir7jmAi
	 hETAbVaZdQel/a6TMISseLAR6S+bOOISkXQczZHwwxIG/uKNAsN9p1gjilBcC96Etw
	 czSieNgI6eGl4VA652YsYqiceZ2wx1BejqUmazWw=
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
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v4 09/13] platform/x86: oxpec: Move pwm_enable read to its own
 function
Date: Tue, 11 Mar 2025 17:54:01 +0100
Message-ID: <20250311165406.331046-10-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311165406.331046-1-lkml@antheas.dev>
References: <20250311165406.331046-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174171206656.19866.6107637543377574654@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Currently, this driver breaks ABI by using auto as 0 and manual as 1.
However, for pwm_enable, 0 is full speed, 1 is manual, and 2 is auto.
For the correction to be possible, this means that the pwm_enable
endpoint will need access to both pwm enable and value (as for
the 0th value, the fan needs to be set to full power).

Therefore, begin by moving the current pwm_enable read to its own
function, oxp_pwm_enable.

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 50 +++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index 58a1919aec15..31c7d0041492 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -766,6 +766,32 @@ static int oxp_pwm_disable(void)
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
@@ -863,29 +889,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
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
2.48.1


