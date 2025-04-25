Return-Path: <linux-pm+bounces-26210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCECA9C760
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 13:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7708A9C6775
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 11:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467AB259CBF;
	Fri, 25 Apr 2025 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="gN9XDfXO"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC3A2594B4;
	Fri, 25 Apr 2025 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579933; cv=none; b=iNHzg7KV9aIaKVD9ozzzkpw4EtXMDinaWgXJ1WgS4z/JQAzIEpe38De24XIninf2MXxjZif8jYpu4Tx1kfF/Q8GxjHtAKuLUhnZORDh+6OgJYVEwtYmXZd/CSNGaQXkv020wNAt4rE6t7ZaRZqGJrzrNKY9tnzbjqXA3GPpYmNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579933; c=relaxed/simple;
	bh=T7PKyVUt3crhS062wcPX6RuQLioSxyB4opN5XxKCgAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wx50jAkU5BEXkFCTBFqVUxM5LO0TqagfUgt/0XLmtW7xhEIn7Z9H84gIyy5BgFuh/n8t1AKqNtUKNyuG6S12r+IJAH+LRIBjNZXAAPkpegxqifMYYVD1TcUTg4msVhtavdAJ0r9XypIzwT8PxBUKTKT6akI5kp8xirgoT55q6/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=gN9XDfXO; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a02:2149:8a3b:5a00:3490:6581:3910:8337])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 4DF772E028F6;
	Fri, 25 Apr 2025 14:18:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1745579929;
	bh=EOM7xb1wc43oU0lf5rEDD2j76CA4sncrvzR8q1EepOk=; h=From:To:Subject;
	b=gN9XDfXO9bZuksSsw7C9sWYvNPOBsB77UZG1AoldwsHpf3RsJacLdDwCOxqYqiS+o
	 C9HcCfuMGURG2GWy8WDQEWwLryfHeISXzXqmvquLiiHfOiyENWtNc99prITGsoQsQe
	 Tvrg4ba7t6hVZrdU9D/N6b0yKzDVYr4tj4KkLo+o=
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
Subject: [PATCH v10 16/16] platform/x86: oxpec: Convert defines to using tabs
Date: Fri, 25 Apr 2025 13:18:21 +0200
Message-ID: <20250425111821.88746-17-lkml@antheas.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425111821.88746-1-lkml@antheas.dev>
References: <20250425111821.88746-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174557992913.23354.14997138938371653254@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

The defines used spaces previously. Convert all of them to use tabs.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index 692a6d6d08316..a07ba9c2fe4f5 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -64,36 +64,36 @@ static enum oxp_board board;
 static struct device *oxp_dev;
 
 /* Fan reading and PWM */
-#define OXP_SENSOR_FAN_REG             0x76 /* Fan reading is 2 registers long */
-#define OXP_2_SENSOR_FAN_REG           0x58 /* Fan reading is 2 registers long */
-#define OXP_SENSOR_PWM_ENABLE_REG      0x4A /* PWM enable is 1 register long */
-#define OXP_SENSOR_PWM_REG             0x4B /* PWM reading is 1 register long */
-#define PWM_MODE_AUTO                  0x00
-#define PWM_MODE_MANUAL                0x01
+#define OXP_SENSOR_FAN_REG		0x76 /* Fan reading is 2 registers long */
+#define OXP_2_SENSOR_FAN_REG		0x58 /* Fan reading is 2 registers long */
+#define OXP_SENSOR_PWM_ENABLE_REG	0x4A /* PWM enable is 1 register long */
+#define OXP_SENSOR_PWM_REG		0x4B /* PWM reading is 1 register long */
+#define PWM_MODE_AUTO			0x00
+#define PWM_MODE_MANUAL			0x01
 
 /* OrangePi fan reading and PWM */
-#define ORANGEPI_SENSOR_FAN_REG        0x78 /* Fan reading is 2 registers long */
-#define ORANGEPI_SENSOR_PWM_ENABLE_REG 0x40 /* PWM enable is 1 register long */
-#define ORANGEPI_SENSOR_PWM_REG        0x38 /* PWM reading is 1 register long */
+#define ORANGEPI_SENSOR_FAN_REG		0x78 /* Fan reading is 2 registers long */
+#define ORANGEPI_SENSOR_PWM_ENABLE_REG	0x40 /* PWM enable is 1 register long */
+#define ORANGEPI_SENSOR_PWM_REG		0x38 /* PWM reading is 1 register long */
 
 /* Turbo button takeover function
  * Different boards have different values and EC registers
  * for the same function
  */
-#define OXP_TURBO_SWITCH_REG           0xF1 /* Mini Pro, OneXFly, AOKZOE */
-#define OXP_2_TURBO_SWITCH_REG         0xEB /* OXP2 and X1 */
-#define OXP_MINI_TURBO_SWITCH_REG      0x1E /* Mini AO7 */
+#define OXP_TURBO_SWITCH_REG		0xF1 /* Mini Pro, OneXFly, AOKZOE */
+#define OXP_2_TURBO_SWITCH_REG		0xEB /* OXP2 and X1 */
+#define OXP_MINI_TURBO_SWITCH_REG	0x1E /* Mini AO7 */
 
-#define OXP_MINI_TURBO_TAKE_VAL        0x01 /* Mini AO7 */
-#define OXP_TURBO_TAKE_VAL             0x40 /* All other models */
+#define OXP_MINI_TURBO_TAKE_VAL		0x01 /* Mini AO7 */
+#define OXP_TURBO_TAKE_VAL		0x40 /* All other models */
 
-#define OXP_TURBO_RETURN_VAL           0x00 /* Common return val */
+#define OXP_TURBO_RETURN_VAL		0x00 /* Common return val */
 
 /* X1 Turbo LED */
-#define OXP_X1_TURBO_LED_REG           0x57
+#define OXP_X1_TURBO_LED_REG		0x57
 
-#define OXP_X1_TURBO_LED_OFF           0x01
-#define OXP_X1_TURBO_LED_ON            0x02
+#define OXP_X1_TURBO_LED_OFF		0x01
+#define OXP_X1_TURBO_LED_ON		0x02
 
 /* Battery extension settings */
 #define EC_CHARGE_CONTROL_BEHAVIOURS	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)             | \
-- 
2.49.0


