Return-Path: <linux-pm+bounces-23693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B60F6A583A4
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 12:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D034116DED9
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 11:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11651CC8B0;
	Sun,  9 Mar 2025 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="uZ+LkaHA"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98C51A9B29;
	Sun,  9 Mar 2025 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741519294; cv=none; b=cbkiHsd7zsGms5O4pn5ai/WnFigAJLd0beIIoqGJqhUk+B/penjE6dLdu2b5JGroZjpVdBIV0umlkeSsqW8gU+XD/Oy2i3zsbUwx20v/YSZEQXMVzckzJSYkFMh4BlwyWppJxznLe3WIXS/cvnEtkZVw62ceyDlnY8Jbbw4OXBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741519294; c=relaxed/simple;
	bh=olnngvSWzuTw7+jwCrrVTLpt5jpDlljE7E7BTT8hoJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adCYl0xPGLCdrICb2kemY/tqKOzSrPBVleFMwlqM3V/LDCQymPSI6hvABAH6QsZ2rV/wWqLTHlCQfILclkiNtnGNjCtXHnEZwWKrikd7ppPmRUzB14aYI7QgRpY3PLUPVRKtL3Dabj2m2vFS7EKH7FO4E7UIkKEZgbrdhQcquXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=uZ+LkaHA; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id D07DD2E0735E;
	Sun,  9 Mar 2025 13:21:26 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741519288;
	bh=sNuKsdasOWIkDosj3z6QbzM+DrhvrIIui0OTrZw4L6c=; h=From:To:Subject;
	b=uZ+LkaHAcnDWH7cWMkzga8oWBhzJ9aQIzowhUW+/ZJgJ9X8jIsEMONZK2JOYt4WZf
	 4fgZzEk/OCPQWE7vnJKQ64gvb8hLmFVKaA0QHOL31TSkFQMGZo9yq7sLsSLqjr8Spn
	 pgqZViF3UM2mespYaaF2hS7uq/jArckyM2aCm92I=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
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
Subject: [PATCH v3 05/12] power: supply: add inhibit-charge-s0 to
 charge_behaviour
Date: Sun,  9 Mar 2025 12:21:06 +0100
Message-ID: <20250309112114.1177361-6-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309112114.1177361-1-lkml@antheas.dev>
References: <20250309112114.1177361-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174151928809.28899.2267117621414514029@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

OneXPlayer devices have a charge bypass feature
that allows the user to select between it being
active always or only when the device is on.

Therefore, add attribute inhibit-charge-s0 to
charge_behaviour to allow the user to select
that bypass should only be on when the device is
in the s0 state.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 Documentation/ABI/testing/sysfs-class-power | 11 ++++++-----
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 drivers/power/supply/test_power.c           |  1 +
 include/linux/power_supply.h                |  1 +
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 2a5c1a09a28f..b5daf757a559 100644
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
+			================== =====================================
+			auto:              Charge normally, respect thresholds
+			inhibit-charge:    Do not charge while AC is attached
+			inhibit-charge-s0: same as inhibit-charge but only in s0
+			force-discharge:   Force discharge while AC is attached
+			================== =====================================
 
 What:		/sys/class/power_supply/<supply_name>/technology
 Date:		May 2007
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index edb058c19c9c..1a98fc26ce96 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -140,6 +140,7 @@ static const char * const POWER_SUPPLY_SCOPE_TEXT[] = {
 static const char * const POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[] = {
 	[POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO]		= "auto",
 	[POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE]	= "inhibit-charge",
+	[POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0]	= "inhibit-charge-s0",
 	[POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE]	= "force-discharge",
 };
 
diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
index 2a975a110f48..4bc5ab84a9d6 100644
--- a/drivers/power/supply/test_power.c
+++ b/drivers/power/supply/test_power.c
@@ -214,6 +214,7 @@ static const struct power_supply_desc test_power_desc[] = {
 		.property_is_writeable = test_power_battery_property_is_writeable,
 		.charge_behaviours = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
 				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)
+				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0)
 				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE),
 	},
 	[TEST_USB] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 6ed53b292162..b1ca5e148759 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -212,6 +212,7 @@ enum power_supply_usb_type {
 enum power_supply_charge_behaviour {
 	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO = 0,
 	POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE,
+	POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0,
 	POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE,
 };
 
-- 
2.48.1


