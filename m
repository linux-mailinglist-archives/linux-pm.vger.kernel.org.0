Return-Path: <linux-pm+bounces-23875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56918A5CB5A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 17:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13E13B8D86
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE842620DB;
	Tue, 11 Mar 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="eqwiAHBu"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7416261382;
	Tue, 11 Mar 2025 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712074; cv=none; b=EiV1/qr9zyKdi/pffQN62BhmEsHprp8McrIRXEkEIBnSCdMItNbOPGJrGACsvmJ7kLB0TX5pnfE8uqGLyfLWB1UiX/5p33oGha8KmmetXnAWI1MYWLW0m0WDTUdUjqIL8JbZUTBJ59wpZcee+ou4zADJZDJR64MiFuN77w7twGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712074; c=relaxed/simple;
	bh=3uDPeJnQqqJ9HXbAXZ01/ixO7b/9xhEVcyIzmMOb97k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUziJnj0WCfmHvzFd+W5BmGUc7FA2z2WkYp4vGKJJ47AKN3N28Xj7Bmf87vN026rJAEK/BwHPKYG6UcKi19wdKhNfLeIjfy5IythOVfH5gPIEK548S3iaqD7qSmnDjZXdatBoSqARyRaMRcjvz1hLWhdfsJr0YHxZLsd4+xppGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=eqwiAHBu; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 57F782E0922F;
	Tue, 11 Mar 2025 18:54:29 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741712070;
	bh=fz+QEXDgijsnzqKqvNoT4AdRG/0cAXDvNN6kXuH9sIs=; h=From:To:Subject;
	b=eqwiAHBugGi9O8LJrtteTaswt6N29CjvBJ2wd3w7ALsRigUBD5V5gXsypu0FaMWaO
	 gQFv935yK2ec7jf4xeBQxEgXABGsj9CxN0eKdMdyWSnRD6n5VJJb5S67+0oetwRLHo
	 HSld3C6BrZlwTQ7VRGzRci+8ZsHlIejilL0C5Qr8=
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
Subject: [PATCH v4 11/13] platform/x86: oxpec: Move fan speed read to separate
 function
Date: Tue, 11 Mar 2025 17:54:03 +0100
Message-ID: <20250311165406.331046-12-lkml@antheas.dev>
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
 <174171207063.20090.10686112370112123463@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

While not necessary for fixing the ABI hwmon issue, fan speed will be
the only remaining value without a function. Therefore, finish the
refactor by moving it to a separate function.

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 53 ++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index f0e70205ad19..97dc7b7c70c7 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -806,6 +806,34 @@ static umode_t oxp_ec_hwmon_is_visible(const void *drvdata,
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
@@ -900,30 +928,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
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
2.48.1


