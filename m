Return-Path: <linux-pm+bounces-24422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89C6A6C9A8
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 11:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A975883713
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 10:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D03B233D64;
	Sat, 22 Mar 2025 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="nDpKefdm"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DD91FBE8B;
	Sat, 22 Mar 2025 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742639804; cv=none; b=fI4JImv5IlHKe025tupydctSDy/Equ0Qco1y7uX1kdqL/RxBudR0XcasT7Ggw37GrvlvUEVa6erV92I5JUg3K2G4v8aibP7VD87oQhx17cQOqxq536muynxwNj0A9oASyv1urxaIMoimNcUS6H9pB5kwbq1tMDIA3yqkeSwmB3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742639804; c=relaxed/simple;
	bh=BDLDuEvbsk25r7z6QYqNqHi6PcFPOgzMWYfNsA5otrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Crue9SXA7nN6bD9HieMbMllJeUvym3KENCNR5nyn8LiQFVXKShUXvOpzHbq96jITfWt1rRUWrxYmy12qDlLpw+iV3PFHY3ipQVrOO9z3ccQsG/5VfD4Ad2H/OpQ7Zv6ErrBAWT2ypZEHcKKly336LE8o1y1YGCvIysPVRDguMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=nDpKefdm; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 2B43E2E08CF3;
	Sat, 22 Mar 2025 12:36:38 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742639800;
	bh=JVVt0Bc7RNFjQXq9FiS7Soy48tzLmI3yzRkNTFulO3A=; h=From:To:Subject;
	b=nDpKefdmeCEkOc7ZQuXgcV5v2Y4VE7w0M+L3CQQnwDFvP9EE9o/klINhlzYMV892y
	 2Ez92MAi70k37vdEHTdN90WSM3l05drWuhlTK+6iPpV7AVniBUpBb5qwGS1eY0LZqU
	 WI+r7X9gnfc0Mhc1Wtn8Syvs17+vm/wtV1zMkQtw=
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
Subject: [PATCH v8 13/14] power: supply: add inhibit-charge-awake to
 charge_behaviour
Date: Sat, 22 Mar 2025 11:36:05 +0100
Message-ID: <20250322103606.680401-14-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250322103606.680401-1-lkml@antheas.dev>
References: <20250322103606.680401-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174263979977.11921.17801320383587416341@linux1587.grserver.gr>
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
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
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


