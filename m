Return-Path: <linux-pm+bounces-26203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CE2A9C737
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 13:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784584E0058
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 11:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE6A253941;
	Fri, 25 Apr 2025 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Y2nlMVQj"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481D525228B;
	Fri, 25 Apr 2025 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579922; cv=none; b=jGgL7EKJJrGkakokub6ngVKgPX+2/LB4Bc5KJkmmkEqNJXOm9cNSNNdPlAbvizgG9md93V9fMa4UA5t5qMzIFcM3cHsjl0MlhLVLHKrd2JUhnEOtxFRG1PTM8GMiDFvopEretBRDD8qPeDT9GYEG2HhJ8Z6isPuy7PwMQ16ZRIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579922; c=relaxed/simple;
	bh=Uz/HxOdawB8yA+nM2b1LPMEDleVe+lhgVkBUbkapCqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbRwZaNdK6BMH02OCJtIBFI9XCdYPMCzYY7Sv4oYW/WCUZpuOvu/Ckc4QWzHI3lKvs5y4GQ1nTld8WYHIWOwCHbSkOEfQ0M8xYO40AgFZ89/J2LGf0mAgWvBVGXE+LqcY6JgBybBn8re6E1YMP63x5pjAp3CaTjMK/e5plcck54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Y2nlMVQj; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a02:2149:8a3b:5a00:3490:6581:3910:8337])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 4B4BC2E08E4E;
	Fri, 25 Apr 2025 14:18:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1745579918;
	bh=x1EfM4iPcxxLy10xcIZpSqDS78JelduiUC4Laf3pAmw=; h=From:To:Subject;
	b=Y2nlMVQjzcesy2g5IPNAhN9oxc2I68f2hc2+9ZGTrZ3fm6wAeR4KVs0jo+o7QzPAr
	 bfq0QW3or2V1EQYJaJQti03IelzUh0fJb+MnzJavJE3+F61ni5gMhKqGW88AzOnKgP
	 9saIr1KSHsqx5a57YR7EQfraxfJoM/kvEKBAyaL0=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a02:2149:8a3b:5a00:3490:6581:3910:8337) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
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
Subject: [PATCH v10 09/16] platform/x86: oxpec: Move pwm value read/write to
 separate functions
Date: Fri, 25 Apr 2025 13:18:14 +0200
Message-ID: <20250425111821.88746-10-lkml@antheas.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425111821.88746-1-lkml@antheas.dev>
References: <20250425111821.88746-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174557991817.22820.5117572294016848859@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Currently, this driver breaks hwmon ABI by using auto as 0 and manual
as 1. However, for pwm_enable, 0 is full speed, 1 is manual, and 2 is
auto. For the correction to be possible, this means that the pwm_enable
endpoint will need access to both pwm enable and value (as for the 0th
value, the fan needs to be set to full power).

Therefore, move the pwm value read/write to separate functions.

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 163 +++++++++++++++++++----------------
 1 file changed, 88 insertions(+), 75 deletions(-)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index f5f3fbbca5552..5da8e1d6073d5 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -599,6 +599,92 @@ static umode_t oxp_ec_hwmon_is_visible(const void *drvdata,
 	}
 }
 
+/* PWM input read/write functions */
+static int oxp_pwm_input_write(long val)
+{
+	if (val < 0 || val > 255)
+		return -EINVAL;
+
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
@@ -639,48 +725,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
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
@@ -706,39 +751,7 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
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
2.49.0


