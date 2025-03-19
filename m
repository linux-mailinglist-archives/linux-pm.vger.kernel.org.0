Return-Path: <linux-pm+bounces-24317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C33A697B7
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 19:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52BA188261F
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 18:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ABC21A43C;
	Wed, 19 Mar 2025 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ILPjBzVI"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C40218E97;
	Wed, 19 Mar 2025 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407907; cv=none; b=XymeJRM6+UIiPHLn7W61q2Ww3zKq3W1WgzhS9OwyCS1gzetPjcqnz9yJdkkmOFbOYW4EMWw3C8XTJr8qzrVENoW3gAxDXoetqY3bZvz2LhUFcw5a31yul/x9fnJ6KvexYqq1tu0jaZDTfG4nnWLzVSmuodEDOLh01pW488gVEiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407907; c=relaxed/simple;
	bh=oJp+AcDHyF//++icEOks2WYjf0+rIVQorzDheMIQUQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rE6ZRHpaMSSjGhBeqLCgnFWoxoxaqigVLlo+y0MjKfl46cHNcaY+c1VXuGSNkJ0c+bjPz1HqwUA061GXxQZH58y5lqgZyvvx+MHHo4u65TDTckm/57m7l+OfLFeKShbIbVDzoI52fN5kB2Dg0E10TSe729YmBACE7p39mSuFEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ILPjBzVI; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id D6D402E095D4;
	Wed, 19 Mar 2025 20:11:41 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742407903;
	bh=vA3CGMQHbSQtTTweauRQx0SuUKgGgjHHt+95VrP2xiY=; h=From:To:Subject;
	b=ILPjBzVI+fNbuskLdYm0kclgVc/00rvxI4Yo5i5SZDwlCPqymdpNiFI2kH9RGxsZZ
	 M8BTulf6Puulw7T+czytj3wpzrWLwp1BA8LqVtNq7hb0syDTj8By+yrR7Jkh64bLFC
	 dPUEDDQ4eJQIGNL1YIB5JSNU4WnLCh9Naw4Ei8Tc=
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
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	mario.limonciello@amd.com,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v7 11/14] platform/x86: oxpec: Adhere to sysfs-class-hwmon and
 enable pwm on 2
Date: Wed, 19 Mar 2025 19:10:38 +0100
Message-ID: <20250319181044.392235-12-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319181044.392235-1-lkml@antheas.dev>
References: <20250319181044.392235-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <174240790348.3388.643265854959137827@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Currently, the driver does not adhere to the sysfs-class-hwmon
specification: 0 is used for auto fan control and 1 is used for manual
control. However, it is expected that 0 sets the fan to full speed,
1 sets the fan to manual, and then 2 is used for automatic control.

Therefore, change the sysfs API to reflect this and enable pwm on 2.

As we are breaking the ABI for this driver, rename oxpec to oxp_ec,
reflecting the naming convention used by other drivers, to allow for
a smooth migration in current userspace programs.

Closes: https://lore.kernel.org/linux-hwmon/20241027174836.8588-1-derekjohn.clark@gmail.com/
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index 5b84647569931..97085ea9e8d77 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -731,7 +731,27 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 		case hwmon_pwm_input:
 			return oxp_pwm_input_read(val);
 		case hwmon_pwm_enable:
-			return oxp_pwm_read(val);
+			ret = oxp_pwm_read(val);
+			if (ret)
+				return ret;
+
+			/* Check for auto and return 2 */
+			if (!*val) {
+				*val = 2;
+				return 0;
+			}
+
+			/* Return 0 if at full fan speed, 1 otherwise */
+			ret = oxp_pwm_fan_speed(val);
+			if (ret)
+				return ret;
+
+			if (*val == 255)
+				*val = 0;
+			else
+				*val = 1;
+
+			return 0;
 		default:
 			break;
 		}
@@ -745,15 +765,24 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
 			      u32 attr, int channel, long val)
 {
+	int ret;
+
 	switch (type) {
 	case hwmon_pwm:
 		switch (attr) {
 		case hwmon_pwm_enable:
 			if (val == 1)
 				return oxp_pwm_enable();
-			else if (val == 0)
+			else if (val == 2)
 				return oxp_pwm_disable();
-			return -EINVAL;
+			else if (val != 0)
+				return -EINVAL;
+
+			/* Enable PWM and set to max speed */
+			ret = oxp_pwm_enable();
+			if (ret)
+				return ret;
+			return oxp_pwm_input_write(255);
 		case hwmon_pwm_input:
 			return oxp_pwm_input_write(val);
 		default:
-- 
2.48.1


