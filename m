Return-Path: <linux-pm+bounces-26202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BC0A9C733
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 13:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00A84C8143
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 11:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C462522B5;
	Fri, 25 Apr 2025 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ydtrIwEz"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428AB243374;
	Fri, 25 Apr 2025 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579920; cv=none; b=HcZY+I6cPH1PwqtC3wPgPNqu1XhzRLHzEjmWZs9kqloIdUYZ8N8ScYE/JLVbYbSzPxBjmk4r/oNJQYATNYwzR+GI6NQPQiJyc5PzS/LaUo1tBW4QC2ndvCS2BzpHO63X/Ph4QyoZRF9WrjomaL3db8Y8i+lV9/TePgz3+lBQljE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579920; c=relaxed/simple;
	bh=AfcL0Nwf6KBck4GsxAmBQhQ4ZKqHYKxhM/JpLsdTG1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LU805OzpIcZy/a4x/wr8ESSyh/LYemlTRqZc4GcrLChkyvRxdCgViSbbdcyPkDxVik4jaeZkpbtffZEbisdv2uvMVp5DvfdQ9yUvUdcwHduxzWWQdWsaSHni697cGk3pOIGQ6kT60Q2eQaSvprrzafe/9Y0RIaoxkJLxphf65yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ydtrIwEz; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a02:2149:8a3b:5a00:3490:6581:3910:8337])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id DAEB12E08E36;
	Fri, 25 Apr 2025 14:18:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1745579917;
	bh=z/313biShVTazLrvUB2ckbPzjcB11lIzCuKyGQptDbI=; h=From:To:Subject;
	b=ydtrIwEzMvT7F69OQQEG4Zk9D0l7IiGvag+heD5BRhaXMdLIEZTeozcDxPLsYxIRX
	 4U6iWur2+nLqSCR9Tha4tnVakRuWTy3wNWdZ5c846r0MTQ0egkQFRYzvUVVEd0QvTp
	 Xc61CmrqTbrVEfGSJxbzgwbfQCRPCEo3ufK5ASew=
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
Subject: [PATCH v10 08/16] platform/x86: oxpec: Move pwm_enable read to its
 own function
Date: Fri, 25 Apr 2025 13:18:13 +0200
Message-ID: <20250425111821.88746-9-lkml@antheas.dev>
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
 <174557991681.22747.8157243158238482210@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Currently, this driver breaks ABI by using auto as 0 and manual as 1.
However, for pwm_enable, 0 is full speed, 1 is manual, and 2 is auto.
For the correction to be possible, this means that the pwm_enable
endpoint will need access to both pwm enable and value (as for the 0th
value, the fan needs to be set to full power).

Therefore, begin by moving the current pwm_enable read to its own
function, oxp_pwm_enable.

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 50 +++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index 97594fe614896..f5f3fbbca5552 100644
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
2.49.0


