Return-Path: <linux-pm+bounces-24205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C651A65721
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 17:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A8E179813
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671271CDFD5;
	Mon, 17 Mar 2025 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Jsu2tMPq"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6772F1C6FF6;
	Mon, 17 Mar 2025 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226859; cv=none; b=tbLCtX8GDMynoBfbkNm69FtXRmLRy1250Ajzzk1wQ4vtF1qPyEjvmGUTiexBZhd2T9uKsm6YtuVj1CKwlBI1bFligVlresrUmo1Sjf8uwHO0jKxKduX9PE9Ykb06YzpX9xS0pL0pLsw8eQmDdmVqTUO83nIFKCDIT6avJiG/uwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226859; c=relaxed/simple;
	bh=fOWQVgU2+W7s0Du4CSQjBqOhpL3GdLYu/Um6Se6n1h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fL2oC5OJPZgifouGogCxHeNnLhP3gEGFAHHafPxQP9h1biwU2eAi5XfK14sS56Fzc/NLKTZvGo8VA0U/a38NXew2NW+jtjaoQL0VEJbWLLNVZlwHZdG0PrIJewYvgTDbWfDjQjulmmqkH2VceFC953BPe4VmQmWVsX/qhKcosJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Jsu2tMPq; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 44EE82E09477;
	Mon, 17 Mar 2025 17:54:13 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742226855;
	bh=D6sDLIrDnjOeLutyw7TyQF+oRWXBDfhCyqTaBCb1E/E=; h=From:To:Subject;
	b=Jsu2tMPq3ioFoZkDFbTPRLmWYYf/OcmmTp//FpFLf4ZT9nPqq9fcMkQ+ENvXabDiE
	 tio0jwQiWyJUNvOToAnEhdbm4v4tm8ny9RxyeIlOH9tr6LJALga2v6hf6lFaChg78d
	 4Yi+mMc/JCpn8TbagfpfEe2Nydw5HZtpipzKCNa4=
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
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v5 08/13] platform/x86: oxpec: Move pwm value read/write to
 separate functions
Date: Mon, 17 Mar 2025 16:53:44 +0100
Message-ID: <20250317155349.1236188-9-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317155349.1236188-1-lkml@antheas.dev>
References: <20250317155349.1236188-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174222685487.25411.2620804120285440600@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Currently, this driver breaks hwmon ABI by using auto as 0 and manual
as 1. However, for pwm_enable, 0 is full speed, 1 is manual, and 2 is
auto. For the correction to be possible, this means that the pwm_enable
endpoint will need access to both pwm enable and value (as for
the 0th value, the fan needs to be set to full power).

Therefore, move the pwm value read/write to separate functions.

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 162 +++++++++++++++++++----------------
 1 file changed, 87 insertions(+), 75 deletions(-)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index 0ca965e224438..67bc871462466 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -599,6 +599,91 @@ static umode_t oxp_ec_hwmon_is_visible(const void *drvdata,
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
@@ -639,48 +724,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
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
@@ -706,39 +750,7 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
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
2.48.1


