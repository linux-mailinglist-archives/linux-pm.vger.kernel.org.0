Return-Path: <linux-pm+bounces-24204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C7FA6571E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 17:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EDEB17DE4C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A831BEF9B;
	Mon, 17 Mar 2025 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="J8/rvSIt"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AD91B4F1F;
	Mon, 17 Mar 2025 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226856; cv=none; b=ecaXclsFnR7sc3qGNwCQujjoa08VrwbDls2kyGTMIjqzkY6M03Nubl0QvcrzrrOz2xq9300BzK9+SSYI+S4a0iiQJFmln8KnBsmfO2qmmDIXniUHLD/fleZsfXYo/mDCMOhN3KBUJE1DWCQpbwKRy9TrjWmuoCVsGdPnIC/718g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226856; c=relaxed/simple;
	bh=NOBglK2Qm0Q1On+BVinoSr1EVnEvw2Jp6/SN/q0rUnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqvd9k//X6ntZbyEVmTamf8PFJWdP3U8e2RqQZrOTsBTsmHN0wJDP9ySOzSLrQH3wDrH2sgZPmBD5YQN+QR7yU+bbfN8SINhLos4QHsqesYEuKPVLjm5pqn5IiXPpcavSBF9w5GtXGuyBJswxTSMoJidjD4msZsBwII8TaDU+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=J8/rvSIt; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 048182E0946F;
	Mon, 17 Mar 2025 17:54:10 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742226853;
	bh=ZKF6gDzYQyX19MF8K7/dBz3k5vZBjUkN2pdUColclfE=; h=From:To:Subject;
	b=J8/rvSItUtMGPryOVRAy00uwTMd5P9zTFYMGZ62NpxsGmvq3BmYLMEtj3h4+gDAUi
	 YF+KKTcLLdJ3ySeqXdF4n5WgSxPfd11zqET18OImBZzh6ibXsOVsu9uIJf/KV/ExSk
	 FDpu2x/PZASjmBJmK68LBUttWShWaEKIS3MkzryA=
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
Subject: [PATCH v5 07/13] platform/x86: oxpec: Move pwm_enable read to its own
 function
Date: Mon, 17 Mar 2025 16:53:43 +0100
Message-ID: <20250317155349.1236188-8-lkml@antheas.dev>
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
 <174222685242.25318.1845623697253863095@linux1587.grserver.gr>
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
index d13704218d264..0ca965e224438 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -559,6 +559,32 @@ static int oxp_pwm_disable(void)
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
@@ -656,29 +682,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
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


