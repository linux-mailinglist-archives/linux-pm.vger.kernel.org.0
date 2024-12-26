Return-Path: <linux-pm+bounces-19761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 600809FCA9B
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 12:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0B11882EF1
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 11:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A9D1D5AB2;
	Thu, 26 Dec 2024 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="l1OVM5JI"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6E31D515B;
	Thu, 26 Dec 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735212481; cv=none; b=DXAKG7ELSPstarRY4GPTNDBEI6eUNSSFAzaeMxK1AHihkd+ddC8nTGCaC7v3FrFClO1nsj5YC1o9Y0LlPQZOJ6+UYufCzhcCr9/yrN8XYP8rGh6LxIMn+jVkt9BbXpPUE5yjudkdbXKL9ec1m9VsDiK3bk5g+wkMVha0SaTA5VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735212481; c=relaxed/simple;
	bh=DEhIpwVMB2y2dnsRLLCdHZEz/4d/XHJ/aAM36Z3jcBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUtGgWpfniLFRmNSDVBOm6mOdNhK9qtWQpY6He7ZK3HY5BKVacZNAsuWDJT/NoIRpPydkzhjvjScSv9bP+FiEFTB/ErZsIUT48P+2CSGs0ODLdVmNSff6AfPl/qR4ki3z3UBM4VLpyNO7RPbNVpG7gejWwhuwf1AuXv/UtAte7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=l1OVM5JI; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a02:2149:8b14:7c00:7f68:a54:8871:387f])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id AD0AD2E00B97;
	Thu, 26 Dec 2024 13:27:52 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1735212473;
	bh=WS3l86rmtRCJTGJsKGoVNfTPktxQeypg5IPEzwJU+ZE=; h=From:To:Subject;
	b=l1OVM5JIN00wS6e9aGaqnKIhMyQIQETSBHeElPvVAqNVmTvbcap1MKEAOTArJKcTO
	 oFEmOl3ZAiqb26UfmD6nubBJHSvtA4Tz8g4vaLpZR33Bmkzf2MNYkokGO+C4C2O5x2
	 02SwXxQGcB79cVw2ecSxk/fq1zVuNS25juL0FaBI=
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
Subject: [PATCH 08/10] hwmon: (oxp-sensors) Move pwm value read/write to
 separate functions
Date: Thu, 26 Dec 2024 12:27:38 +0100
Message-ID: <20241226112740.340804-9-lkml@antheas.dev>
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
 <173521247339.11315.1855661158214180250@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Currently, this driver breaks sysfs by using auto as 0 and manual as 1.
However, for pwm_enable, 0 is full speed, 1 is manual, and 2 is auto.
For the correction to be possible, this means that the pwm_enable
endpoint will need access to both pwm enable and value (as for
the 0th value, the fan needs to be set to full power).

Therefore, move the pwm value read/write to separate functions.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/hwmon/oxp-sensors.c | 162 +++++++++++++++++++-----------------
 1 file changed, 87 insertions(+), 75 deletions(-)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index ff21a94bb80b..56873b879dee 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -795,6 +795,91 @@ static umode_t oxp_ec_hwmon_is_visible(const void *drvdata,
 	}
 }
 
+/* PWM input read/write functions */
+static int oxp_pwm_input_write(long val)
+{
+	if (val < 0 || val > 255)
+		return -EINVAL;
+	switch (board) {
+	case orange_pi_neo:
+		/* scale to range [1-244] */
+		val = ((val - 1) * 243 / 254) + 1;
+		return write_to_ec(ORANGEPI_SENSOR_PWM_REG, val);
+	case oxp_2:
+	case oxp_x1:
+		/* scale to range [0-184] */
+		val = (val * 184) / 255;
+		return write_to_ec(OXP_SENSOR_PWM_REG, val);
+	case aya_neo_2:
+	case aya_neo_air:
+	case aya_neo_air_1s:
+	case aya_neo_air_plus_mendo:
+	case aya_neo_air_pro:
+	case aya_neo_flip:
+	case aya_neo_geek:
+	case aya_neo_kun:
+	case oxp_mini_amd:
+	case oxp_mini_amd_a07:
+		/* scale to range [0-100] */
+		val = (val * 100) / 255;
+		return write_to_ec(OXP_SENSOR_PWM_REG, val);
+	case aok_zoe_a1:
+	case oxp_fly:
+	case oxp_mini_amd_pro:
+		return write_to_ec(OXP_SENSOR_PWM_REG, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int oxp_pwm_input_read(long *val)
+{
+	int ret;
+
+	switch (board) {
+	case orange_pi_neo:
+		ret = read_from_ec(ORANGEPI_SENSOR_PWM_REG, 1, val);
+		if (ret)
+			return ret;
+		/* scale from range [1-244] */
+		*val = ((*val - 1) * 254 / 243) + 1;
+		break;
+	case oxp_2:
+	case oxp_x1:
+		ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
+		if (ret)
+			return ret;
+		/* scale from range [0-184] */
+		*val = (*val * 255) / 184;
+		break;
+	case aya_neo_2:
+	case aya_neo_air:
+	case aya_neo_air_1s:
+	case aya_neo_air_plus_mendo:
+	case aya_neo_air_pro:
+	case aya_neo_flip:
+	case aya_neo_geek:
+	case aya_neo_kun:
+	case oxp_mini_amd:
+	case oxp_mini_amd_a07:
+		ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
+		if (ret)
+			return ret;
+		/* scale from range [0-100] */
+		*val = (*val * 255) / 100;
+		break;
+	case aok_zoe_a1:
+	case oxp_fly:
+	case oxp_mini_amd_pro:
+	default:
+		ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
+		if (ret)
+			return ret;
+		break;
+	}
+	return 0;
+}
+
 static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 			     u32 attr, int channel, long *val)
 {
@@ -835,48 +920,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_pwm:
 		switch (attr) {
 		case hwmon_pwm_input:
-			switch (board) {
-			case orange_pi_neo:
-				ret = read_from_ec(ORANGEPI_SENSOR_PWM_REG, 1, val);
-				if (ret)
-					return ret;
-				/* scale from range [1-244] */
-				*val = ((*val - 1) * 254 / 243) + 1;
-				break;
-			case oxp_2:
-			case oxp_x1:
-				ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
-				if (ret)
-					return ret;
-				/* scale from range [0-184] */
-				*val = (*val * 255) / 184;
-				break;
-			case aya_neo_2:
-			case aya_neo_air:
-			case aya_neo_air_1s:
-			case aya_neo_air_plus_mendo:
-			case aya_neo_air_pro:
-			case aya_neo_flip:
-			case aya_neo_geek:
-			case aya_neo_kun:
-			case oxp_mini_amd:
-			case oxp_mini_amd_a07:
-				ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
-				if (ret)
-					return ret;
-				/* scale from range [0-100] */
-				*val = (*val * 255) / 100;
-				break;
-			case aok_zoe_a1:
-			case oxp_fly:
-			case oxp_mini_amd_pro:
-			default:
-				ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
-				if (ret)
-					return ret;
-				break;
-			}
-			return 0;
+			return oxp_pwm_input_read(val);
 		case hwmon_pwm_enable:
 			return oxp_pwm_read(val);
 		default:
@@ -902,39 +946,7 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
 				return oxp_pwm_disable();
 			return -EINVAL;
 		case hwmon_pwm_input:
-			if (val < 0 || val > 255)
-				return -EINVAL;
-			switch (board) {
-			case orange_pi_neo:
-				/* scale to range [1-244] */
-				val = ((val - 1) * 243 / 254) + 1;
-				return write_to_ec(ORANGEPI_SENSOR_PWM_REG, val);
-			case oxp_2:
-			case oxp_x1:
-				/* scale to range [0-184] */
-				val = (val * 184) / 255;
-				return write_to_ec(OXP_SENSOR_PWM_REG, val);
-			case aya_neo_2:
-			case aya_neo_air:
-			case aya_neo_air_1s:
-			case aya_neo_air_plus_mendo:
-			case aya_neo_air_pro:
-			case aya_neo_flip:
-			case aya_neo_geek:
-			case aya_neo_kun:
-			case oxp_mini_amd:
-			case oxp_mini_amd_a07:
-				/* scale to range [0-100] */
-				val = (val * 100) / 255;
-				return write_to_ec(OXP_SENSOR_PWM_REG, val);
-			case aok_zoe_a1:
-			case oxp_fly:
-			case oxp_mini_amd_pro:
-				return write_to_ec(OXP_SENSOR_PWM_REG, val);
-			default:
-				break;
-			}
-			break;
+			return oxp_pwm_input_write(val);
 		default:
 			break;
 		}
-- 
2.47.1


