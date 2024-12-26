Return-Path: <linux-pm+bounces-19762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CD69FCA9D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 12:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9812616172E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 11:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04CF1D5AD3;
	Thu, 26 Dec 2024 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="rkfbbafc"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F18D1D45FB;
	Thu, 26 Dec 2024 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735212481; cv=none; b=kbqocvtf8DHz6keaAJw1ho2OTywxdtirI2VJS1zzStLaErYcuFqOeuvEq6g5TlLZN0Lbh+FeUgiYvyjSgMzMGAxnwTttWJkwtbuS0fPR5Bj26uNlFMPQAW+YTYwbYrqPl788Pyvc5XZ4aMjXm/1a6T7NmHmVJXlYl3fm+WaTd/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735212481; c=relaxed/simple;
	bh=x0fnV7Yv0PqWxPcYKxTj5QOhnYcL+pa22jneTc5qxIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vaf3Bpq1RzOat1G6sGofk3NqjibnjjPTjpj9pB2vCUB+0yzRW5Xnn48KD4MKXfenUZNhtHD1B7R0JkkxJvurs9Zsl/TMhIzdFEmF72QnEGM6CNw0sqZfqLGn6d7Ca7FybgB0lWxpz5wsFL2D+IPLbGDUFL06tgCnRPz+p+7WHwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=rkfbbafc; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a02:2149:8b14:7c00:7f68:a54:8871:387f])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id C8FF02E00E2A;
	Thu, 26 Dec 2024 13:27:53 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1735212474;
	bh=2oZ5tWtUyFxQVNs6y6jjq9yxUgNmtY3kPTHz3nqztA8=; h=From:To:Subject;
	b=rkfbbafcYRiwMOmXqVOhRUz9prFnLtNtlVxgSUNGFeFJipAW17MK8p8v0zD9GhiAt
	 jBjdQDEhTJMATVYDJWtzPExNx2Nr0TayJFpZfKB3mCZvQ5eRgo2i7QIKtatxfjvYKB
	 9a8T863Km9yopSMrEKsaXhqjaoTCYhl1owOSI7L0=
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
Subject: [PATCH 09/10] hwmon: (oxp-sensors) Move fan speed read to separate
 function
Date: Thu, 26 Dec 2024 12:27:39 +0100
Message-ID: <20241226112740.340804-10-lkml@antheas.dev>
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
 <173521247450.11369.1518889444393454533@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

While not necessary for fixing the sysfs issue, fan speed will be the
only remaining value without a function. Therefore, finish the refactor
by moving it to a separate function.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/hwmon/oxp-sensors.c | 53 ++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index 56873b879dee..97bf51eba741 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -795,6 +795,34 @@ static umode_t oxp_ec_hwmon_is_visible(const void *drvdata,
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
@@ -889,30 +917,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
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
2.47.1


