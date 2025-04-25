Return-Path: <linux-pm+bounces-26199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12870A9C722
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 13:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2399C66EB
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 11:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0696524BC00;
	Fri, 25 Apr 2025 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="IGuT9+fv"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F7C2475C2;
	Fri, 25 Apr 2025 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579916; cv=none; b=gILDkRmUJuTxIa76LfoubpF05esFJfRJ99Pb82bxgeIQf94ITLHuCigYiDHSULxvwV/aPt6ax8CqMWcUY0em7Mt4CrSWvNQMhuyAczMaRj1HuebdRY+Nz91hfgyjAMn3piHO647X5kirGVgpHNDQhlIf2gIVMpIoejq5wGFk91g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579916; c=relaxed/simple;
	bh=KgeLBLUqyMCAfp8HeyHw/KMMrJ/KP4MlFBSWaFW5MHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FYRI/JwQOegjlCseWZOd8ZTZPeig7Aqnv4ZggqvABFQuUK+IE5Oha4MOrP8z+xFcdVmwxL1fyuyklmWJXq0RxW+sCi144o9zZsVm+mc4WpRS19AwxU7doitDqYfYKc7wJDc66CFROlJugeNTl60VUoV7PvDIEQ0DgO7kC4qR/lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=IGuT9+fv; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a02:2149:8a3b:5a00:3490:6581:3910:8337])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id DA2042E08E42;
	Fri, 25 Apr 2025 14:18:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1745579913;
	bh=UF9WFNgRR76C7UnzKQASAEECGiGNsHozip/3FZayxBc=; h=From:To:Subject;
	b=IGuT9+fvohgj7yOiD4HXzvKPjg6Zxif0InX1uG4iPR69123TlCrIs761L82CswGUM
	 ipDG3kN5L/bR++SkYmJ3EGwQ+HycOlqsl9j5BvVD+8YEi6vAoDS7TYlCFNJ00G2ANw
	 J1j1IwGGJ2hCHiBYmHmMMhD+JY1sXq48BLAa+nBE=
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
Subject: [PATCH v10 05/16] ABI: testing: sysfs-class-oxp: add tt_led attribute
 documentation
Date: Fri, 25 Apr 2025 13:18:10 +0200
Message-ID: <20250425111821.88746-6-lkml@antheas.dev>
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
 <174557991273.22511.14304133268253133356@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Adds documentation about the tt_led attribute of OneXPlayer devices to
the sysfs-class-oxp ABI documentation.

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 Documentation/ABI/testing/sysfs-platform-oxp | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-oxp b/Documentation/ABI/testing/sysfs-platform-oxp
index 091269ab2c8c4..b3f39fc21dfa8 100644
--- a/Documentation/ABI/testing/sysfs-platform-oxp
+++ b/Documentation/ABI/testing/sysfs-platform-oxp
@@ -11,3 +11,15 @@ Description:
 		shortcut over the AT keyboard of the device. In addition,
 		using this setting is a prerequisite for PWM control for most
 		newer models (otherwise it NOOPs).
+
+What:		/sys/devices/platform/<platform>/tt_led
+Date:		April 2025
+KernelVersion:	6.16
+Contact:	"Antheas Kapenekakis" <lkml@antheas.dev>
+Description:
+		Some OneXPlayer devices (e.g., X1 series) feature a little LED
+		nested in the Turbo button. This LED is illuminated when the
+		device is in the higher TDP mode (e.g., 25W). Once tt_toggle
+		is engaged, this LED is left dangling to its last state. This
+		attribute allows userspace to control the LED state manually
+		(either with 1 or 0). Only a subset of devices contain this LED.
-- 
2.49.0


