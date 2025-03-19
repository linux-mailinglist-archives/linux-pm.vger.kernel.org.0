Return-Path: <linux-pm+bounces-24311-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39283A6979C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 19:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C8B46378B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 18:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E746521420E;
	Wed, 19 Mar 2025 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="mGUg/N/1"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F9D2135AD;
	Wed, 19 Mar 2025 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407894; cv=none; b=sie16ktJNs63cd84aSfpidXBqw6Jh5aHPSWv6o8bHuw+98nb24DAnxM0T6cyEyUsk0+ITlvp/+YjJZ2YehI1Wy+xHrg/JfJk6r3wHst6cF+X18YnK64DwzQyiFTl/nCZGPyBG6BME4CZcUT4MjP2Bzv05p9qby9lYyXS4Fd6qv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407894; c=relaxed/simple;
	bh=R2tsTvFHU28NYUTGbrvpyfcsC2ZaMbVploeaNWvqSmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnYQYw+EXeliu8sYdfZDXbj5qxbFNzrMft1pRHBJX0ls50yN5UIDw6hKnhJqaBlDwhFAJ96oiZOgr9rFhdAdr6ET8+w5XpkuKVhbANSec1kKy93mxnWC3sFevlNXsFBZVbTOU2j0Vyw0pVnbJ7TP/mWcgUHjGC8KGVFzrBjjEiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=mGUg/N/1; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 207362E09405;
	Wed, 19 Mar 2025 20:11:29 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742407891;
	bh=mJgmIe8lOvPxjf+wLyD8RBgL5ygfb/bNCRktNzVRiR4=; h=From:To:Subject;
	b=mGUg/N/1wJjZVHA0Y2gjSCZG3jf4Xrlh2dpjsp72ql/tgowqpnYbaqlziTXgYwe9U
	 ti2HOCGX8dNxItqKShKmAoS+6rYObUd4ete1ePwjBj2xr1gEChyJ7C0oNwhoteQ7pg
	 9cR7zdKwfC87ICNZSvGCITWqhhpgcNgFLWjRu3RQ=
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
Subject: [PATCH v7 05/14] ABI: testing: sysfs-class-oxp: add tt_led attribute
 documentation
Date: Wed, 19 Mar 2025 19:10:32 +0100
Message-ID: <20250319181044.392235-6-lkml@antheas.dev>
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
 <174240789074.2919.13042457260374211175@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Adds documentation about the tt_led attribute of OneXPlayer devices
to the sysfs-class-oxp ABI documentation.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 Documentation/ABI/testing/sysfs-platform-oxp | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-oxp b/Documentation/ABI/testing/sysfs-platform-oxp
index 091269ab2c8c4..ccf8e5902cf86 100644
--- a/Documentation/ABI/testing/sysfs-platform-oxp
+++ b/Documentation/ABI/testing/sysfs-platform-oxp
@@ -11,3 +11,15 @@ Description:
 		shortcut over the AT keyboard of the device. In addition,
 		using this setting is a prerequisite for PWM control for most
 		newer models (otherwise it NOOPs).
+
+What:		/sys/devices/platform/<platform>/tt_led
+Date:		Feb 2025
+KernelVersion:	6.15
+Contact:	"Antheas Kapenekakis" <lkml@antheas.dev>
+Description:
+		Some OneXPlayer devices (e.g., X1 series) feature a little LED
+		nested in the Turbo button. This LED is illuminated when the
+		device is in the higher TDP mode (e.g., 25W). Once tt_toggle
+		is engaged, this LED is left dangling to its last state. This
+		attribute allows userspace to control the LED state manually
+		(either with 1 or 0). Only a subset of devices contain this LED.
-- 
2.48.1


