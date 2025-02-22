Return-Path: <linux-pm+bounces-22726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E90DA409E2
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 17:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0432D3B82DB
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 16:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7928C1FC0FD;
	Sat, 22 Feb 2025 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Jj1UxrBN"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA56A13A265;
	Sat, 22 Feb 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740241241; cv=none; b=g152rqPYPdUt2+oZvx4amI6eVScxBHbUykkQjOhMtKR8+tOgpzQyR6YBhLVCfBJc8HPZcTBu0eLaVNZl75ajizU+ckq69OV2rRJtmJk65YQh3q43R7vR+VStYMiKcd7hDrqA49rZWC5ZrLN9NR6GJDcPQHvyp6so+Yc09Kr2Q80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740241241; c=relaxed/simple;
	bh=CBpPCiWn2z4z/Jikegt6a6HHwcjSp4acCbqB94ecohs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBL4ZqP4CVWQl3jKaksHfV/qUzdu/EGMhYsDd8hePCZxih2uc2IZrCrbQCQzYeTa9TjtSauG5jhE2h8tCcuCyYZspsRDPuxkwyLpomqxOLYjTLyXS+HysMHBmWI4rFIJ3MmP6bweQAKIdwu0VU9r/0D16eg0vTQMdt+JQ+euYlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Jj1UxrBN; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id DBB142E08C3E;
	Sat, 22 Feb 2025 18:20:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740241236;
	bh=LKUznuBJTNZaKsBu09bq4CWrMhUVhn38RMi0tzwcObs=; h=From:To:Subject;
	b=Jj1UxrBNaRREJluOijBcgnm1TeWQy86HCW+6fU4VpUHmDzLU1kZW3e3aw0Vt9SrOM
	 bMml+Ut2wJUvuVmJT1LRrzZ0qSbnsk01OvQF/Kw7aj+7/U2VsdxbFJgnKg0+LA2l0N
	 3KGhri7ctlZH/14QJZzLScKuMZ0mWNS2H5Hd4owg=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:cbc0:999f:73ad:33bd) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-hwmon@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
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
Subject: [PATCH v2 07/12] hwmon: (oxp-sensors) Move pwm_enable read to its own
 function
Date: Sat, 22 Feb 2025 17:18:18 +0100
Message-ID: <20250222161824.172511-8-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250222161824.172511-1-lkml@antheas.dev>
References: <20250222161824.172511-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174024123619.13957.10446542481454210143@linux1587.grserver.gr>
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
index 9c43ec0fc994..1da1e1655f96 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -762,6 +762,32 @@ static int oxp_pwm_disable(void)
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
@@ -859,29 +885,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
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


