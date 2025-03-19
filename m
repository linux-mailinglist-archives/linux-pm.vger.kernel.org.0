Return-Path: <linux-pm+bounces-24319-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F20A697C7
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 19:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3131899ACF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 18:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC1021B9C5;
	Wed, 19 Mar 2025 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="PuTyQOS2"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA78B21ABB9;
	Wed, 19 Mar 2025 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407914; cv=none; b=MKg8bD6XZS+4DgtkwvJnFa6nCYWjH/UAjF/UbO+X+of/fF22vEdz85jffxvM+FHG6ov0JAmZc4TzioGkCOZ2QmtXhNtbOdjgNdNZBY6He7EPzRbeLBfhCymrwadsRviLcdOm4xQzX7JjuKKzODc7I1PedkmsLKxOYADkcdvbn5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407914; c=relaxed/simple;
	bh=AhOqABeQ0vXvahxs8PbCfQtxgyUiwwogm6zkHDbfI30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWE3WlL+sTGCPFHrN6uU7m8AbT3Ml0dcIu6/Bt/rJRxSDCOVH5IyRBnRU0JA4vD0Zj1FM0iq8evVxVR0lUnU1K8ukc9hnJHCGirsRND2ID3lKvQ9KQYu+8zAYNlsyEn8VJW50Tu+v3lB0/D/7wFd8ZZow8AB9A1Mq06CYpwByKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=PuTyQOS2; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 1DEEC2E09256;
	Wed, 19 Mar 2025 20:11:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742407908;
	bh=ci2LqqQkQAv7AZa5q9BXHmil16TfRnfqqGR5OrMycsA=; h=From:To:Subject;
	b=PuTyQOS2FS5/sXG4En+LtV5gSCjddXDuE/4/imSc/LfavoCkXdY8vN/nIH9TqHkTJ
	 dzNIuPGk6WV3v+7RSO0t8KcpfnygTkAqzCJ30BRrJEKPFofvGuhfKCbgo1HpD3gsb3
	 sXNkFWJphlyaw8xUcuE636Y1ifVIyp9VfD/bV2TE=
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
Subject: [PATCH v7 13/14] power: supply: add inhibit-charge-awake to
 charge_behaviour
Date: Wed, 19 Mar 2025 19:10:40 +0100
Message-ID: <20250319181044.392235-14-lkml@antheas.dev>
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
X-PPP-Message-ID: 
 <174240790769.3519.12290875463764537349@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

OneXPlayer devices have a charge inhibit feature
that allows the user to select between it being
active always or only when the device is on.

Therefore, add attribute inhibit-charge-awake to
charge_behaviour to allow the user to select
that charge should be paused only when the device
is awake.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 Documentation/ABI/testing/sysfs-class-power | 11 ++++++-----
 drivers/power/supply/power_supply_sysfs.c   |  7 ++++---
 drivers/power/supply/test_power.c           |  1 +
 include/linux/power_supply.h                |  1 +
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 2a5c1a09a28f9..78afb2422fc5a 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -508,11 +508,12 @@ Description:
 		Access: Read, Write
 
 		Valid values:
-			================ ====================================
-			auto:            Charge normally, respect thresholds
-			inhibit-charge:  Do not charge while AC is attached
-			force-discharge: Force discharge while AC is attached
-			================ ====================================
+			===================== ========================================
+			auto:                 Charge normally, respect thresholds
+			inhibit-charge:       Do not charge while AC is attached
+			inhibit-charge-awake: inhibit-charge only when device is awake
+			force-discharge:      Force discharge while AC is attached
+			===================== ========================================
 
 What:		/sys/class/power_supply/<supply_name>/technology
 Date:		May 2007
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index edb058c19c9c4..f769d5941d0d3 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -138,9 +138,10 @@ static const char * const POWER_SUPPLY_SCOPE_TEXT[] = {
 };
 
 static const char * const POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[] = {
-	[POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO]		= "auto",
-	[POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE]	= "inhibit-charge",
-	[POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE]	= "force-discharge",
+	[POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO]			= "auto",
+	[POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE]		= "inhibit-charge",
+	[POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE]	= "inhibit-charge-awake",
+	[POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE]		= "force-discharge",
 };
 
 static struct power_supply_attr power_supply_attrs[] __ro_after_init = {
diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
index 2a975a110f485..958e0c0cf2876 100644
--- a/drivers/power/supply/test_power.c
+++ b/drivers/power/supply/test_power.c
@@ -214,6 +214,7 @@ static const struct power_supply_desc test_power_desc[] = {
 		.property_is_writeable = test_power_battery_property_is_writeable,
 		.charge_behaviours = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
 				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)
+				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE)
 				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE),
 	},
 	[TEST_USB] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 6ed53b2921624..bb8e9e62ce834 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -212,6 +212,7 @@ enum power_supply_usb_type {
 enum power_supply_charge_behaviour {
 	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO = 0,
 	POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE,
+	POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE,
 	POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE,
 };
 
-- 
2.48.1


